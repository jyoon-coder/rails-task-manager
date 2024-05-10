class TasksController < ApplicationController
   # '/tasks'
   def index
    @tasks = Task.all
    # render 'index.html.erb'
  end

  # '/tasks/1'
  def show
    @task = Task.find(params[:id])
  end

  # '/tasks/new'
  def new
    # this instance variable is JUST for the form
    @task = Task.new
  end

  # we cant access from a URL. The form is sending the data here (/restaurants)
  # THIS DOES NOT HAVE A VIEW
  def create
    # we need to create our instance with our STRONG params
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      # show the form with the restaurant that didnt save (not a brand new one)
      render 'new', status: :unprocessable_entity
    end
  end

  # '/restaurants/1/edit'
  def edit
    # this instance variable is JUST for the form
    @task = Task.find(params[:id])
  end

  def update
    # load the the instacne i want to update
    @task = Task.find(params[:id])
    # update the instance with the strong_params
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  # we cant access this one in the URL, but a link can with a delete method
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  def task_params
    # we are whitelisting the attributes a user can give us
    params.require(:task).permit(:title, :details, :completed)
  end
end
