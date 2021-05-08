{% for view_model in view_models -%}
  <table class="pls-inflection-table pls-inflection-type-conjugation">
    <thead>
      <tr>
        <td><span class="pls-inflection-table-title">{{ view_model.name | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% if view_model.ar_values_exist.0 -%}
        <td colspan="2"><span class="pls-inflection-col-header">{{ "active" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% endif -%}
        {% if view_model.ar_values_exist.1 -%}
        <td colspan="2"><span class="pls-inflection-col-header">{{ "reflexive" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% endif -%}
      </tr>
      <tr>
        <td><span class="pls-inflection-row-header"></span></td>
        {% if view_model.ar_values_exist.0 -%}
        <td><span class="pls-inflection-col-header">{{ "singular" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        <td><span class="pls-inflection-col-header">{{ "plural" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% endif -%}
        {% if view_model.ar_values_exist.1 -%}
        <td><span class="pls-inflection-col-header">{{ "singular" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        <td><span class="pls-inflection-col-header">{{ "plural" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% endif -%}
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><span class="pls-inflection-row-header">{{ view_model.name | localise_abbrev(hmap = abbrev_map)  }} {{ "3rd" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% if view_model.ar_values_exist.0 -%}
        <td>
          {% for inflection in view_model.inflections_list.0 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        <td>
          {% for inflection in view_model.inflections_list.1 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        {% endif -%}
        {% if view_model.ar_values_exist.1 -%}
        <td>
          {% for inflection in view_model.inflections_list.2 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        <td>
          {% for inflection in view_model.inflections_list.3 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        {% endif -%}
      </tr>
      <tr>
        <td><span class="pls-inflection-row-header">{{ view_model.name | localise_abbrev(hmap = abbrev_map) }} {{ "2nd" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% if view_model.ar_values_exist.0 -%}
        <td>
          {% for inflection in view_model.inflections_list.4 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        <td>
          {% for inflection in view_model.inflections_list.5 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        {% endif -%}
        {% if view_model.ar_values_exist.1 -%}
        <td>
          {% for inflection in view_model.inflections_list.6 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        <td>
          {% for inflection in view_model.inflections_list.7 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        {% endif -%}
      </tr>
      <tr>
        <td><span class="pls-inflection-row-header">{{ view_model.name | localise_abbrev(hmap = abbrev_map) }} {{ "1st" | localise_abbrev(hmap = abbrev_map)  }}</span></td>
        {% if view_model.ar_values_exist.0 -%}
        <td>
          {% for inflection in view_model.inflections_list.8 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        <td>
          {% for inflection in view_model.inflections_list.9 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        {% endif -%}
        {% if view_model.ar_values_exist.1 -%}
        <td>
          {% for inflection in view_model.inflections_list.10 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        <td>
          {% for inflection in view_model.inflections_list.11 -%}
          {% if inflection -%}
          <div class="pls-inflection-inflected-word">{{ inflection }}</div>
          {% endif -%}
          {% endfor -%}
        </td>
        {% endif -%}
      </tr>
    </tbody>
  </table>

{% endfor -%}
