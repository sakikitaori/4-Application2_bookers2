class BooksController < ApplicationController

  def new
    @book = Book.new
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

  def index
    @create = Book.new
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @bookn = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    # book.update(book_params)
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      # @book = Book.find(params[:id])
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
