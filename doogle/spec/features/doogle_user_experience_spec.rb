require 'rails_helper'

describe "doogle user experience", type: :feature, js: true do
  let(:invalid_search_term) { 'not-a-real-word' }
  let(:search_term) { 'test' }
  let(:search_term_definitions) {
    [
      'a critical examination, observation, or evaluation',
      'a basis for evaluation'
    ]
  }

  before do
    # stub dictionary API call
  end

  scenario "a user looks up definitions" do
    visit definition_path
    expect(page).to have_content('Doogle')
    expect(page).to have_content('Doogle Search')

    fill_in 'search-term', with: invalid_search_term
    find_button('Search').click
    expect(page).to have_content('No definition found')

    fill_in 'search-term', with: search_term
    find_button('Search').click
    search_term_definitions.each { |definition|
      expect(page).to have_content(definition)
    }
  end
end