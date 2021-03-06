require 'features_helper'

RSpec.describe 'Add a secret' do
  before(:each) do
    SecretRepository.new.clear
    CategoryRepository.new.create(title: 'TestCategory')
  end

  it 'can create a new secret encrypted in database' do
    visit '/secrets/new'

    fill_in 'Login',  with: 'New Secret'
    fill_in 'Secret', with: 'secret'
    select 'TestCategory', from: 'secret-category'
    click_button 'Add'

    expect(page).to have_current_path('/secrets')
    expect(SecretRepository.new.last.secret).to eq(Encryptor.encrypt('secret'))
  end

  it 'displays list of errors when params contains errors' do
    visit '/secrets/new'

    within 'form' do
      click_button 'Add'
    end

    expect(current_path).to eq('/secrets')

    expect(page).to have_content('There was a problem with your submission')
    expect(page).to have_content('Login must be filled')
    expect(page).to have_content('Secret must be filled')
  end
end
