require 'test_helper_rails'

class RailsTest < ActionDispatch::IntegrationTest
  include ::DummyRailsIntegration

  def test_visit_root_render
    visit root_path

    page.has_content?('Success')

    screenshot!
  end

  def test_root_has_no_javascript_errors
    visit root_path

    browser_logs = page.driver.browser.manage.logs.get(:browser).to_a
    browser_logs.each do |error|
      refute error.level == 'SEVERE', error.message
    end
  end

  def test_autoprefixer
    get ActionController::Base.helpers.stylesheet_path('application.css')
    assert_match(/-webkit-(?:transition|transform)/, response.body)
  end

  def test_precompile
    Dummy::Application.load_tasks
    Rake::Task['assets:precompile'].invoke
  end
end
