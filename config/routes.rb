Rails.application.routes.draw do
  devise_for :users
  # singleton route for dashboards controller
  resource :dashboard, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'privacy', to: 'static_pages#privacy'
  get 'team', to: 'static_pages#team'
  # allows courses to be stored in database. Students need to view all the courses available on our web app
  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create
  end
  resources :lessons, only: [:show]
  # Connect instructor controller in config/routes.rb to 'instructor namespace' course controller
  namespace :instructor do
    resources :lessons, only: [:update]
    resources :sections, only: [:update]
    resources :sections, only: [] do
      resources :lessons, only: [:create]      
    end
    resources :courses, only: [:new, :create, :show] do
      resources :sections, only: [:create]
    end
  end
end