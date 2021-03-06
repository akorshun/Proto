#include "inlinehook_const.h"

func_post:
	sub sp, sp, #0xa0
	stp x29, x30, [sp]
	mov x29, sp
	stp x0, x1, [sp, #0x18]
	stp x2, x3, [sp, #0x28]
	stp x4, x5, [sp, #0x38]
	stp x6, x7, [sp, #0x48]
	adr x30, orig_lr
place_holder:
.word PLACE_HOLDER_MAGIC
	mov x0, x0
	mov x0, x0
	mov x0, x0
	ldr x16, orig_addr
	blr x16
orig_lr:
	stp x0, x1, [sp, #0x58]
	stp x2, x3, [sp, #0x68]
	stp x4, x5, [sp, #0x78]
	stp x6, x7, [sp, #0x88]
    str x0, [x29, #0x10]
    ldp x6, x7, [sp, #0x40]
    ldp x4, x5, [sp, #0x30]
    ldp x2, x3, [sp, #0x20]
    ldp x0, x1, [sp, #0x10]
    add x0, x29, #0x10
    ldr x16, filter_addr
    blr x16
    cbz x0, not_attack_log
    ldr x0, patch_info
    ldr x1, attack_logger
    blr x1
not_attack_log:
	ldp x6, x7, [sp, #0x88]
	ldp x4, x5, [sp, #0x78]
	ldp x2, x3, [sp, #0x68]
	ldp x0, x1, [sp, #0x58]
    ldr x0, [x29, #0x10]
    ldp x29, x30, [sp]
    add sp, sp, #0xa0
    ret

filter_addr:
.quad FILTER_ADDR_MAGIC
orig_addr:
.quad ORIGIN_ADDR_MAGIC
patch_info:
.quad PATCH_INFO_CTX_MAGIC
attack_logger:
.quad ATTACK_LOGGER_MAGIC
