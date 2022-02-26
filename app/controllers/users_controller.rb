class UsersController < ApplicationController

  def index
    @book = Book.new
    @users = User.all
    @user= User.find(current_user.id)
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def create
    @create = Book.new(book_params)
    @create.user_id = current_user.id
    if @create.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@create.id)
    else
      @book = Book.new
      @books = Book.all
      @user = User.find(current_user.id)
      render "index"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
