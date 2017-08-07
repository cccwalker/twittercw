class EpicenterController < ApplicationController
  before_action :authenticate_user!
  
  def feed
    user_list = current_user.following << current_user.id
    @following_tweets = Tweet.where(user_id: user_list).order(created_at: :desc)
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])  	
  end
  
  def tag_tweets
    @tag = Tag.find(params[:id])
  end

end
