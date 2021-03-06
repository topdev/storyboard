require 'spec_helper'

describe Api::V1::TokensController do
  let(:user) { FactoryGirl.create :user }
  let(:auth_token) { user.authentication_token }
  context 'auth with valid params' do
    it "should auth with user" do
      post '/api/v1/tokens', { email: user.email, password: 'password' }
      expect(response.body).to eql({ id: user.id, token: user.authentication_token, name: user.name }.to_json)
    end

    it 'should destroy tokens' do
      delete '/api/v1/tokens', {}, { 'Authorization' => auth_token }
      expect(response.status).to eql 200
    end
  end
end