cdef class GraphicsInstruction
cdef class InstructionGroup
cdef class ContextInstruction
cdef class VertexInstruction

cdef class Canvas
cdef class RenderContext

from vbo cimport *
from context_instructions cimport *

cdef class GraphicsInstruction:
    cdef int flags
    cdef GraphicsInstruction parent
    cdef apply(self)
    cdef flag_update(self)
    cdef flag_update_done(self)

cdef class InstructionGroup(GraphicsInstruction):
    cdef list children
    cpdef add(self, GraphicsInstruction c)
    cpdef remove(self, GraphicsInstruction c)
    cpdef clear(self)

cdef class ContextInstruction(GraphicsInstruction):
    cdef dict context_state
    cdef list context_push
    cdef list context_pop

    cdef RenderContext get_context(self)
    cdef set_state(self, str name, value)
    cdef push_state(self, str name)
    cdef pop_state(self, str name)

cdef class VertexInstruction(GraphicsInstruction):
    cdef BindTexture texture_binding
    cdef VertexBatch batch
    cdef list vertices
    cdef list indices
    cdef list _tex_coords

    cdef update_batch(self)
    cdef build(self)




cdef Canvas getActiveCanvas()
cdef class Canvas(InstructionGroup):
    cpdef draw(self)



from shader cimport *
cdef class RenderContext(Canvas):
    cdef Shader shader
    cdef dict state_stacks
    #cdef TextureManager texture_manager
    cdef object default_texture

    cdef set_state(self, str name, value)
    cdef get_state(self, str name)
    cdef set_states(self, dict states)
    cdef push_state(self, str name)
    cdef push_states(self, list names)
    cdef pop_state(self, str name)
    cdef pop_states(self, list names)
    cdef enter(self)
    cdef apply(self)
    cpdef draw(self)

