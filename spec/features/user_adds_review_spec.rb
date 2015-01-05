require "rails_helper"

feature "user adds review", %{
  As a user, I want to be able to rate locations
  and optionally provide a review comment
  So others can see those details.

  Acceptance Criteria:
  -[ ] I must give a rating and optionally a review comment
  -[ ] I must see those on the site page
  -[ ] I must be signed in to add a review
  } do

    let (:test_site) do
      FactoryGirl.create(:site)
    end

    scenario "Visits a site" do

      visit site_path(test_site)

      expect(page).to have_content "Add a Review"
    end

    scenario "Add a review" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Sign in"

      expect(page).to have_content("Signed in successfully")
      expect(page).to have_content("Sign Out")

      visit site_path(test_site)

      click_on "Add a Review"
      save_and_open_page
      select "5", from: "Rating"

      click_on "Submit"

      expect(page).to have_content "Rating: 5"
      expect(page).to have_content "Review Saved Successfully"
    end

    scenario "User tries to add comment as a Guest" do

      visit site_path(test_site)
      click_on "Add a Review"

      expect(page).to have_content "You need to sign in
      or sign up before continuing."
    end
  end