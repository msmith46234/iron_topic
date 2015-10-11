class InterestsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_interest, only: [:show, :edit, :update, :destroy]


    def new
      @topic = Topic.find(params[:topic_id])
      @interest = @topic.interests.build
    end

    def create
      @topic = Topic.find(params[:topic_id])
      @interest = @topic.interests.build(interest_params)
      @interest.user_id = current_user.id
      @interest.save
      @topic.interest_count += 1
      score = @interest.score
      @topic.interest_score += score
      @topic.rating = @topic.interest_score / @topic.interest_count
      @topic.save

      redirect_to @topic
    end

    def destroy
      @interest = Interest.new(params[:id])
      @interest.destroy
      @interest.save
      redirect_to interests_url
    end

    def update
      @interest.update(interest_params)
      redirect_to
    end

  private

  def set_interest
      @interest= Interest.find(params[:id])
    end

  def interest_params
    params.require(:interest).permit(:comment, :score)
  end

  end
