class TasksController < ApplicationController

  def new
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new
  end

  def create
    if params[:task_list_id]
    session['id'] = params[:task_list_id]
  end

    task_params = params.require(:task).permit(:description, :due_date).merge(task_list_id: session['id'])
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: "Task was created successfully!"
    else
      render :new
    end
  end

end
