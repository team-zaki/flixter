Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  # allows courses to be stored in database. Students need to view all the courses available on our web app
  resources :courses, only: [:index, :show]
  # Connect instructor controller in config/routes.rb to 'instructor namespace' course controller
  namespace :instructor do
    resources :courses, only: [:new, :create, :show]
  end
end
