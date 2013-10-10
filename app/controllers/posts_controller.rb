class PostsController < ApplicationController
  include ContextValidations::Controller

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.validations = validations

    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def base_validations
    validates :title, presence: true, uniqueness: true
    validates :content, presence: true
  end
end