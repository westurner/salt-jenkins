include:
  {%- if grains['os_family'] not in ('FreeBSD', 'Gentoo') %}
  - gcc
  {%- endif %}
  - python.pip
{%- if grains['os_family'] not in ('Arch', 'Solaris', 'FreeBSD', 'Gentoo') %}
{#- These distributions don't ship the develop headers separately #}
  - python.headers
{% endif %}

timelib:
  pip.installed:
    {%- if salt['config.get']('virtualenv_path', None)  %}
    - bin_env: {{ salt['config.get']('virtualenv_path') }}
    {%- endif %}
    - require:
      {%- if grains['os_family'] not in ('Arch', 'Solaris', 'FreeBSD', 'Gentoo') %}
      {#- These distributions don't ship the develop headers separately #}
      - pkg: python-dev
      {%- endif %}
      {%- if grains['os_family'] not in ('FreeBSD', 'Gentoo') %}
        {#- FreeBSD always ships with gcc #}
      - pkg: gcc
      {%- endif %}
      - cmd: python-pip
