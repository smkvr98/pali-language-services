/*
TODO
o Generate inflection table
  - exe display, generate given pali1, stem, pattern
    v verbs: eti pr
    v support multiple inflections
    - verbs: -
    - verbs: *
  - sql generation work
    v place constraints on verbs / pos
    - generalize lists and order
  - test case
  - front-end display
  - non-verbs
  - remove empty columns rows
  - host determines styling
  - publish js module with sql stuff
  x expand acronyms
- Generate all words for a given stem
    - Generate all words for irreg
 */

static HEADER_TEMPLATE: &str =
    r#"<p><strong>{{PĀLI1}} &ndash; "{{PATTERN}}" ({{EXAMPLE_INFO}})</strong></p><br />"#;
static FOOTER_TEMPLATE: &str = r#"<p><a href="https://docs.google.com/forms/d/e/1FAIpQLSdqnYM0_5VeWzkFBPzyxaLqUfKWgNjI8STCpdrx4vX3hetyxw/viewform"><strong>spot a mistake? something missing? fix it here!</strong></a></p><br />"#;
static VERB_TENSE_TEMPLATE: &str = include_str!("templates/verb_tense.html");

static VERB_SQL_TEMPLATE: &str = r#"SELECT inflections FROM '{{TABLE}}' where tense = '{{TENSE}}' and person = '{{PERSON}}' and actreflx = '{{ACTREFLX}}' and "number" = '{{NUMBER}}'"#;
const TENSE_VALUES: &[&str] = &["pr", "imp", "opt", "fut"];
const PERSON_VALUES: &[&str] = &["3rd", "2nd", "1st"];
const ACTREFLX_VALUES: &[&str] = &["act", "reflx"];
const NUMBER_VALUES: &[&str] = &["sg", "pl"];

fn get_inflections_from_table(
    table_name: &str,
    exec_sql: impl Fn(&str) -> Result<Vec<Vec<String>>, String>,
) -> Vec<String> {
    let mut inflections: Vec<String> = Vec::new();
    TENSE_VALUES.iter().for_each(|&t| {
        PERSON_VALUES.iter().for_each(|&p| {
            ACTREFLX_VALUES.iter().for_each(|&ar| {
                NUMBER_VALUES.iter().for_each(|&n| {
                    let sql = VERB_SQL_TEMPLATE
                        .replace("{{TABLE}}", table_name)
                        .replace("{{TENSE}}", t)
                        .replace("{{PERSON}}", p)
                        .replace("{{ACTREFLX}}", ar)
                        .replace("{{NUMBER}}", n);
                    let x = match exec_sql(&sql) {
                        Ok(mut x) => {
                            if x.len() == 1 && x[0].len() == 1 {
                                x.remove(0).remove(0)
                            } else {
                                "".to_string()
                            }
                        }
                        Err(e) => e,
                    };
                    inflections.push(x);
                })
            })
        })
    });

    inflections
}

fn create_inflected_stems_html_fragment(stem: &str, inflections: &str) -> String {
    let html: String = inflections.split(',').fold(String::new(), |acc, e| {
        acc + &format!("{}<strong>{}</strong><br />", stem, e)
    });
    html
}

fn create_html_body(stem: &str, inflections: &[String]) -> String {
    let template = VERB_TENSE_TEMPLATE.to_string();
    let body: String = inflections
        .iter()
        .enumerate()
        .fold(template, |acc, (ei, e)| {
            let name = format!("|{}|", ei);
            let value = create_inflected_stems_html_fragment(stem, e);
            acc.replace(&name, &value)
        });

    body
}

fn append_header_footer(body: &str, pali1: &str, pattern: &str, example_info: &str) -> String {
    let header = HEADER_TEMPLATE
        .replace("{{PĀLI1}}", pali1)
        .replace("{{PATTERN}}", pattern)
        .replace("{{EXAMPLE_INFO}}", example_info);

    format!("{}\n{}\n{}", &header, &body, FOOTER_TEMPLATE)
}

fn get_itable(isql: &str) -> Result<String, String> {
    match isql.len() {
        0 => Err("?".to_string()),
        _ => Ok("eti_pr".to_string()),
    }
}

fn get_pali1_metadata(pali1: &str) -> Result<String, String> {
    match pali1.len() {
        0 => Err("?".to_string()),
        _ => Ok("ābādh|eti pr|like bhāveti".to_string()),
    }
}

fn exec_sql_structured<F>(f: F) -> impl Fn(&str) -> Result<Vec<Vec<String>>, String>
where
    F: Fn(&str) -> Result<String, String>,
{
    move |sql| {
        let xxx = f(sql)?;
        let v: Vec<Vec<String>> = serde_json::from_str(&xxx).map_err(|e| e.to_string())?;
        Ok(v)
    }
}

pub fn generate_inflection_table(
    pali1: &str,
    _exec_sql_no_transliteration: fn(&str) -> Result<String, String>,
    exec_sql_with_transliteration: fn(&str) -> Result<String, String>,
) -> Result<String, String> {
    let metadata: Vec<String> = get_pali1_metadata(pali1)?
        .split('|')
        .map(|s| s.to_string())
        .collect();
    let table_name = get_itable(&pali1)?;
    let inflections = get_inflections_from_table(
        &table_name,
        exec_sql_structured(exec_sql_with_transliteration),
    );
    let body = create_html_body(&metadata[0], &inflections);
    let html = append_header_footer(&body, pali1, &metadata[1], &metadata[2]);

    Ok(html)
}