require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'active_support/core_ext/kernel/reporting'

Dir['test/support/**/*.rb'].each do |file|
  # strip ^test/ and .rb$
  file = file[5..-4]
  require_relative File.join('.', file)
end

GEM_PATH = File.expand_path('../', File.dirname(__FILE__))

Capybara.configure do |config|
  config.app_host              = 'http://localhost:7000'
  config.default_driver        = :selenium_chrome_headless
  config.server                = :webrick
  config.server_port           = 7000
  config.default_max_wait_time = 10
end
