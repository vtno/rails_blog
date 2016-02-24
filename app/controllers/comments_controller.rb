class CommentsController < ApplicationController
	http_basic_authenticate_with :name => "tino", :password=>"0"
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		respond_to do |format|
			if @comment.save
				format.html {redirect_to post_path(@post), notice: 'Comment added!'}
			else 
				format.html {redirect_to post_path(@post), notice: 'Empty comment cannot be added!'}
			end
		end
	end
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)

	end
	private
	def comment_params
		params.require(:comment).permit(:commenter, :body)
	end
end
