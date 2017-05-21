class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  def show
    @user = User.find(params[:id])
    @items = @user.items.uniq
    @count_want = @user.want_items.count
    @count_have = @user.have_items.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      # 特定の URL を新規にリクエストする（普通にブラウザで URL を入力するのと似ている）
      # ようするに http://xxx.xxx.com をリクエストする
      redirect_to @user
    else
      flash[:danger] = 'ユーザの登録に失敗しました。'
      # 1個前のページを表示する（違うけど、ブラウザバックみたいなイメージ？）
      # ここにくる場合は、フォームの入力にエラーがある場合で、もしここで、redirect_to を使ってしまうと、
      # せっかく入力したフォームの値が消えてしまう
      # だから、バリデーションエラーと共に、入力内容を戻すために、render を使う
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
