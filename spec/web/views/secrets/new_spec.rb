RSpec.describe Web::Views::Secrets::New, type: :view do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/secrets/new.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end
end