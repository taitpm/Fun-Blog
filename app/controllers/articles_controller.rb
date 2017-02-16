class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy] 

	def index
	 	if logged_in?
 	 	 @articles = Article.paginate(page: params[:page], per_page: 5)
 		else
 		flash[:danger] = "You must be logged in to perform that action"
 		 redirect_to root_path
 		end
	end

	def new
		@article = Article.new
	end
	
	def edit
	end

	def create
		#render palain: params[:article].inspect
		@article = Article.new(article_params)
		@article.user = User.first
		if @article.save
			flash[:success] = "Article was successfully created."
			redirect_to article_path(@article)
		else
			render 'new'
		end	
	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article was successfully update."
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def show
	end

	def destroy
		@article.destroy
		flash[:danger] = "Article was successfully delete."
		redirect_to articles_path
	end

	private
	def set_article
		@article = Article.find(params[:id])
	end
	def article_params
		params.require(:article).permit(:title, :description)
	end
end
