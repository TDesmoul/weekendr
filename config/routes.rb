Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :weekends, only: [:index]

  resources :bookmarks, only: [:index, :create, :destroy]
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
