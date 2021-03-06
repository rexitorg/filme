Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :user do

    resources :histories, :only => [:create,:index,:new]
    resources :cart_items, :only => [:show,:create,:destroy]
    resources :good_reviews, :only =>[:create]
    resources :products, :only => [:index,:show] do
      resource :favorites, :only => [:create,:index,:destroy]
    end
  end

  namespace :admin do
    resources :products,:except => [:show]
    resources :lp_images,:only => [:edit,:update]
    resources :movies do
      resource :movie_reviews,:only => [:create] 
    end
    resources :users, :except =>[:show,:create]
  end

  scope module: :admin do
    resources :admin,:except => [:show,:update]
  end

  scope module: :user do
    resources :users,:only => [:edit,:update,:show]
  end

  #命名パスは勝手に付けた
  get 'user/products/thanks', to: 'user/histories#finish', as: 'products_buy'
  get 'user/products/seach', to: 'user/products#search',as: 'search_products'
  get 'user/thanks', to:'user/user#finish'
  get 'user/check', to:'user/users#destroy_check'
  root to: 'root#top'
end
