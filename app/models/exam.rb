class Exam < ApplicationRecord
  belongs_to :patient

  belongs_to :point_po, class_name: "Point", :foreign_key => 'point_po_id', dependent: :destroy
  belongs_to :point_or, class_name: "Point", :foreign_key => 'point_or_id', dependent: :destroy
  belongs_to :point_a, class_name: "Point", :foreign_key => 'point_n_id', dependent: :destroy
  belongs_to :point_n, class_name: "Point", :foreign_key => 'point_a_id', dependent: :destroy

  accepts_nested_attributes_for :point_po
  accepts_nested_attributes_for :point_or
  accepts_nested_attributes_for :point_n
  accepts_nested_attributes_for :point_a

  def maxillary_depth_angle
    # A fórmula para determinar o ângulo entre dois planos é dada por: sejam n1 e n2 planos definidos no espaço.
    # teta será o angulo formado através da fórmula (n1*n2)/raiz(n1^2)*raiz(n2^2).
    # O cos teta define o angulo formado pelos planos.

    a1 = (self.point_po.x*self.point_or.x)+(self.point_po.y*self.point_or.y)
    a2 = (self.point_n.x*self.point_a.x)+(self.point_n.y*self.point_a.y)
    teta = (a1*a2)/(Math.sqrt(a1**2)*Math.sqrt(a2**2))
    if Math.cos(teta) > 0
       return 90+(Math.cos(teta))
     elsif Math.cos(teta) < 0
       return 90-(Math.cos(teta))
     else
       return 0
    end
  end
end
