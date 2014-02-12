class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    unless current_user
      @user = User.new(user_params)
      if @user.password == @user.password_confirmation
        @user.save
        redirect_to root_path
        flash[:notice] = "A confirmation e-mail has been sent to your account"
      else
        redirect_to new_user_path
        flash[:notice] = "Password and password confirmation did not match"
      end
    else
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username,:email,:password,:password_confirmation)
  end
end
