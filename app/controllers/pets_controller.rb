class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params["pet"])
    if !params["owner"]["name"].empty?
      owner = Owner.create(params["owner"])
      @pet.update(owner_id: owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params["id"])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    if params["pet"].keys.include?("owner_id")
      owner = Owner.find(params["pet"]["owner_id"])
    end
    @pet = Pet.find(params["id"])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.update(name: params["pet"]["name"], owner_id: owner.id)
    redirect to "pets/#{@pet.id}"
  end
end