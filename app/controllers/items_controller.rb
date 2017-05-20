class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @item = Item.find(params[:id])
    @wants_users = @item.want_users
  end
  
  def new
    @items = []
    
    @keyword = params[:keyword]
    if @keyword
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
        })
        
      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
      end
    end
  end
end
