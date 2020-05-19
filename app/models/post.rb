class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  
  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      unless category_attribute[:name].blank?
        category = Category.find_or_create_by(category_attribute)
        self.post_categories.build(category: category)
      end
    end
  end

  def comment_users
    users = []
    self.comments.each do |comment|
      users << comment.user
    end
    users.uniq
  end
end
