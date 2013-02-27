default['passenger']['install_method'] = 'source'

default['passenger']['version']     = '3.0.19'
default['passenger']['apache_mpm']  = nil
default['passenger']['root_path']   = "#{languages['ruby']['gems_dir']}/gems/passenger-#{passenger['version']}"
default['passenger']['module_path'] = "#{passenger['root_path']}/ext/apache2/mod_passenger.so"
default['passenger']['max_pool_size'] = 6
default['passenger']['manage_module_conf'] = true
default['passenger']['ruby_bin'] = "#{languages['ruby']['ruby_bin']}"

default['passenger']['package']['name'] = nil
default['passenger']['package']['version'] = node['passenger']['version']

default['passenger']['rvm']['user'] = nil
default['passenger']['rvm']['user_home'] = nil
default['passenger']['rvm']['group'] = "#{passenger['rvm']['user']}"
default['passenger']['rvm']['ruby_string'] = node['rvm']['user_default_ruby']
default['passenger']['rvm']['root_path'] = "#{passenger['rvm']['user_home']}/.rvm/gems/ruby-#{passenger['rvm']['ruby_string']}/gems/passenger-#{passenger['version']}"
default['passenger']['rvm']['module_path'] = "#{passenger['rvm']['root_path']}/ext/apache2/mod_passenger.so"
default['passenger']['rvm']['installer_path'] = "#{passenger['rvm']['user_home']}/.rvm/gems/ruby-#{passenger['rvm']['ruby_string']}/bin/passenger-install-apache2-module"
default['passenger']['rvm']['ruby_bin'] = "#{passenger['rvm']['user_home']}/.rvm/rubies/ruby-#{passenger['rvm']['ruby_string']}/bin/ruby"
