require 'yaml/store'

class CourseStore
  def initialize(filename) @store = YAML::Store.new(filename)
  end
   def save(course)
      @store.transaction do
        unless course.id
          highest_id = @store.roots.max || 0
          course.id = highest_id + 1
        end
        @store[course.id] = course
      end
  end
    def all
      @store.transaction do
        @store.roots.map { |id| @store[id] }
      end
  end 
  def get(id)
    course = nil
    @store.transaction do
      course = @store[id]
    end
    return course
  end

  def delete(id)
    @store.transaction {@store.delete(id)}
  end
end