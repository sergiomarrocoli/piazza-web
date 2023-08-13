require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'requires name' do
    @user = User.new(name: "", email: 'johndoe@example.com', password: 'password')
    assert_not @user.valid?
  end

  test 'requires valid email' do
    @user = User.new(name: "John Doe", email: '', password: 'password')
    assert_not @user.valid?

    @user.email = 'johndoe'
    assert_not @user.valid?

    @user.email = 'johndoe@example.com'
    assert @user.valid?
  end

  test 'requires unique email' do
    @existing_user = User.create(name: "John Doe", email: 'johndoe@example.com', password: 'password')
    assert @existing_user.valid?

    @user = User.new(name: "John Doe", email: 'johndoe@example.com')
    assert_not @user.valid?
  end

  test "name and email is stripped of spaces before saving" do
    @user = User.create(
      name: " John ",
      email: " johndoe@example.com ",
      password: "password"
    )
    assert_equal "John", @user.name
    assert_equal "johndoe@example.com", @user.email
  end
end
