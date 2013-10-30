require 'test_helper'

class AddAFriendTest < ActionDispatch::IntegrationTest
  def sign_in_as(user, password)
    post login_path, user: { email: user.email, password: password }
  end

  test "that adding a friend works" do
    sign_in_as users(:jacob), "testing"
    
    get "/user_friendships/new?friend_id=#{users(:robert).profile_name}"
    assert_response :success

    assert_difference 'UserFriendship.count', 2 do
      post "/user_friendships", user_friendships: { friend_id: users(:robert).profile_name }
      assert_response :redirect
      assert_equal "Friend request sent.", flash[:success]
    end
  end
end
