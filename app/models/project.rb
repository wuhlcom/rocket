# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  user_id         :integer
#  image           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  fund_goal       :integer
#  is_hidden       :boolean          default(TRUE)
#  fund_progress   :integer          default(0)
#  backer_quantity :integer          default(0)
#

class Project < ApplicationRecord
  validates :name, presence: true
  validates :fund_goal, numericality: { greater_than: 0 }

  mount_uploader :image, ImageUploader
  has_many :plans

  scope :published, -> { where(is_hidden: false) }
  def publish!
    self.is_hidden = false
    save
  end

  def hide!
    self.is_hidden = true
    save
  end
end
