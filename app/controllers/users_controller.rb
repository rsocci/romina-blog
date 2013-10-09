class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user = AdminUser.new(user_params) if params[:user][:type] == 'admin'
    @user = ReaderUser.new(user_params) if params[:user][:type] == 'reader'

    if @user.save
      @user.reload
      session[:identity_id] = @user.password_identities.first.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
