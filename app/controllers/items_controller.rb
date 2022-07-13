class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        render json: user.items
      else
        render json: { error: "User not found" }, status: :not_found
      end
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    item = Item.find_by(id: params[:id])
    if item
      render json: item
    else 
      render json: { error: "Item not found" }, status: :not_found
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    if user
      item = user.items.create(item_params)
      render json: item, status: :created
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end
end
