require('rspec')
require('pg')
require('task')

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do

  describe('.all') do
    it('is empty at first') do
      expect(Task.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a task to a list of saved tasks') do
      test_task = Task.new({:description => "learn SQL"})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe('#description') do
    it('lets you add give a description of a task') do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.description()).to(eq('learn SQL', :list_id => 1))
    end
  end

  describe("#list_id") do
    it('lets you read out the list id') do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe('#==') do
    it('is the same task if it has the same description') do
      task1 = Task.new({:description => "learn SQL", :list_id => 1})
      task2 = Task.new({:description => "learn SQL", :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end


end
