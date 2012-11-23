class TestsController < ApplicationController
  def index
  end

  def step_one
  	@next_step = 'step_two'

  	render :template => 'tests/steps'
  end

  def step_two
  	@next_step = 'step_three'

	render :template => 'tests/steps'
  end

  def steps
  	session[:step] = session[:step] or 0
  	@step = session[:step].to_i + 1

  	session[:step] = @step

  	str = session[:answers] or ''

  	answer = "-1"

  	if params[:a] then
  		answer = "1"
  	end

	str = str.to_s + @step.to_s + ':' + answer.to_s + ' '

  	session[:answers] = str

  	@answ = str

  	render :template => 'tests/steps'
  end

  def finish
  	if not session[:answers] then
  		return redirect_to :action => "steps"
  	end

  	answ = session[:answers]

  	session[:step] = nil
  	session[:answers] = nil

  	i = [1, 3, 4, 5, 9]
  	n = [2, 6, 7, 8]

  	a = answ.split

  	ii = 0
  	nn = 0

  	i.each {|i|
  		ar =  a[i].split(':')
  		ii = ii +
  		ar[1].to_i
  	}

  	n.each {|i|
  		ar =  a[i].split(':')
  		nn = nn + ar[1].to_i
  	}

  	@i = ii
  	@n = nn

  	render :template => 'tests/finish'
  end
end
