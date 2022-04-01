require 'rails_helper'
RSpec.describe TreesController, type: :request do
  describe "controller" do
    it "creates a tree and redirects to the tree's page" do

      get "/trees/new"
      expect(response).to render_template(:new)
      expect(response).to_not render_template(:show)

      post "/trees", :params => { tree: FactoryBot.build(:tree).attributes  }
      expect(response).to redirect_to(assigns(:tree))
      follow_redirect!

      expect(response).to render_template(:show)
    end

    it "updates a tree and redirects to the good tree's page" do
      tree = FactoryBot.create(:tree)

      get "/trees/#{tree.id}/edit"
      expect(response).to render_template(:edit)
      expect(response).to_not render_template(:new)

      patch "/trees/#{tree.id}", :params => { tree: tree.attributes }
      expect(response).to redirect_to(assigns(:tree))
      follow_redirect!

      expect(response).to render_template(:show)
    end

    it "the index render the good template" do
      get "/trees"
      expect(response).not_to render_template(:show)
      expect(response).to render_template(:index)
    end

    it "the show render the good template" do
      get "/trees/#{Tree.last.id}"
      expect(response).not_to render_template(:index)
      expect(response).to render_template(:show)
    end
  end
end
