class Recipe < ActiveRecord::Base

  has_many :ingredients
  has_many :directions
  belongs_to :user

  accepts_nested_attributes_for :ingredients,
                                reject_if: proc { |attributes| attributes ['nazwa'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :directions,
                                reject_if: proc { |attributes| attributes ['krok'].blank? },
                                allow_destroy: true

  validates :nazwa, :opis, :image, presence: true

  has_attached_file :image, :styles => { :medium => "300x300#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 2.megabytes
end
