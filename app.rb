require 'sinatra'
require './course'
require './course_store'
store = CourseStore.new('courses.yml')

get('/courses') do
  @courses = store.all
  erb :index
end

get('/courses/new') do
  erb :new
end

post('/courses/create') do
  @course = Course.new
  @course.title = params['title']
  @course.instructor = params['instructor']
  @course.semester = params['semester']
  store.save(@course)
  # show a new, empty form
  redirect "/courses"
end

get('/courses/:id') do
  id = params['id'].to_i
  @course = store.get(id)
  erb :show
end

delete('/courses/:id') do
    id = params['id'].to_i
    store.delete(id)
    redirect('/courses')
end

post('/courses/edit') do
  id = params['id'].to_i
  @course = store.get(id)
  erb :edit
end

post('/courses/update') do
  id = params['id'].to_i
  @course = store.get(id)
  @course.title = params['title']
  @course.instructor = params['instructor']
  @course.semester = params['semester']
  store.save(@course)
  # show a new, empty form
  redirect "/courses"
end
