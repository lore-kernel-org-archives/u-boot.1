Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EC8C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 17:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A258262F;
	Fri, 31 Jan 2025 18:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="fe+2P33I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E87248262F; Fri, 31 Jan 2025 17:11:40 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2604580F70
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 17:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1389425CBC;
 Fri, 31 Jan 2025 17:11:37 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNw2oWxcF0HQ; Fri, 31 Jan 2025 17:11:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1738339854; bh=mRYimqy0Dvyu75HQ6iFjiOwYrrFqK4f04hH87GOgrCY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fe+2P33I2N6nF22RUgRZdGTffzC7gSCd337DAjHIKaksV+LRQHTDH6bK8iXjhjXby
 S/pdUXwRRyCIjlMduv6P6mNxecxgc+zoVzomGM604mKnSJCZaKecaAHdfMF75qftMs
 GlcHPFVC2wArpQjByw8S4uBW/YWE7VTlPs/CUOw+ezw8uRNQyyaWkThEwZ1cWv+1Sb
 l+wZpInddNOtqFvgwankfcCehpis2j+GeXddWcri1eO5jNVSW7vM126k09ChtS6Ogm
 IbjCLRHT1u95bBsPwLDn6I/Wx86EaCdGLlSNsr+6KMB4OOyIHi8sgZmeKzBHF7RSZa
 QQU+a1iYGv1eA==
Date: Fri, 31 Jan 2025 16:10:34 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH v2 1/3] Introduce coroutines framework
Message-ID: <Z5z1-nHenTmnjukU@pie.lan>
References: <cover.1738059345.git.jerome.forissier@linaro.org>
 <912af13c205a31080cc61d40bec29d7402185d6e.1738059345.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912af13c205a31080cc61d40bec29d7402185d6e.1738059345.git.jerome.forissier@linaro.org>
X-Mailman-Approved-At: Fri, 31 Jan 2025 18:08:50 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Jan 28, 2025 at 11:19:15AM +0100, Jerome Forissier wrote:
> Adds the COROUTINES Kconfig symbol which introduces a new internal API
> for coroutines support. As explained in the Kconfig file, this is meant
> to provide some kind of cooperative multi-tasking with the goal to
> improve performance by overlapping lengthy operations.
> 
> The API as well as the implementation is very much inspired from libaco
> [1]. The reference implementation is simplified to remove all things
> not needed in U-Boot, the coding style is updated, and the aco_ prefix
> is replaced by co_.
> 
> I believe the stack handling could be simplified: the stack of the main
> coroutine could probably probably be used by the secondary coroutines
> instead of allocating a new stack dynamically.
> 
> Only i386, x86_64 and aarch64 are supported at the moment. Other
> architectures need to provide a _co_switch() function in assembly.
> 
> Only aarch64 has been tested.
> 
> [1] https://github.com/hnes/libaco/
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/arm/cpu/armv8/Makefile    |   1 +
>  arch/arm/cpu/armv8/co_switch.S |  36 +++++++
>  include/coroutines.h           | 130 ++++++++++++++++++++++++++
>  lib/Kconfig                    |  10 ++
>  lib/Makefile                   |   2 +
>  lib/coroutines.c               | 165 +++++++++++++++++++++++++++++++++
>  6 files changed, 344 insertions(+)
>  create mode 100644 arch/arm/cpu/armv8/co_switch.S
>  create mode 100644 include/coroutines.h
>  create mode 100644 lib/coroutines.c
> 
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index 2e71ff2dc97..6d07b6aa9f9 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -46,3 +46,4 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
>  obj-$(CONFIG_XEN) += xen/
>  obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
>  obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
> +obj-$(CONFIG_COROUTINES) += co_switch.o
> diff --git a/arch/arm/cpu/armv8/co_switch.S b/arch/arm/cpu/armv8/co_switch.S
> new file mode 100644
> index 00000000000..4405e89ec56
> --- /dev/null
> +++ b/arch/arm/cpu/armv8/co_switch.S
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* void _co_switch(struct uco *from_co, struct uco *to_co); */
> +.text
> +.globl _co_switch
> +.type  _co_switch, @function
> +_co_switch:
> +    // x0: from_co
> +    // x1: to_co
> +    // from_co and to_co layout: { pc, sp, x19-x29 }
> +
> +    // Save context to from_co (x0)
> +    // AAPCS64 says "A subroutine invocation must preserve the contents of the
> +    // registers r19-r29 and SP"
> +    adr x2, 1f  // pc we should use to resume after this function
> +    mov x3, sp
> +    stp x2, x3, [x0, #0]  // pc, sp
> +    stp x19, x20, [x0, #16]
> +    stp x21, x22, [x0, #32]
> +    stp x23, x24, [x0, #48]
> +    stp x25, x26, [x0, #64]
> +    stp x27, x28, [x0, #80]
> +    stp x29, x30, [x0, #96]
> +
> +    // Load new context from to_co (x1)
> +    ldp x2, x3, [x1, #0]  // pc, sp
> +    ldp x19, x20, [x1, #16]
> +    ldp x21, x22, [x1, #32]
> +    ldp x23, x24, [x1, #48]
> +    ldp x25, x26, [x1, #64]
> +    ldp x27, x28, [x1, #80]
> +    ldp x29, x30, [x1, #96]
> +    mov sp, x3
> +    br x2
> +
> +1:  // Return to the caller
> +    ret

We've done similar context switching in setjmp/longjmp. Is it possible
to unify this part and get rid of the duplicated assembly for each
architecture?

The jmp_buf structure is actually non-opaque to the caller through
jmp_buf_data, thus I believe this logic could be rewritten in C with
setjmp/longjmp(),

	if (!setjmp(from_co))
		longjmp(to_co);
	else
		return;

and replace co.regs with jmp_buf_data.

btw, I guess the jmp_buf_data type is kept for historical usage in EFI
implementation, but looking through our EFI code it seems the details of
jmp_buf aren't used anymore now. So maybe it's the time to clean up and
make it a better context-switching API as well.

> diff --git a/include/coroutines.h b/include/coroutines.h
> new file mode 100644
> index 00000000000..b85b656127c
> --- /dev/null
> +++ b/include/coroutines.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later */
> +/*
> + * Copyright 2018 Sen Han <00hnes@gmail.com>
> + * Copyright 2025 Linaro Limited
> + */
> +
> +#ifndef _COROUTINES_H_
> +#define _COROUTINES_H_
> +
> +#ifndef CONFIG_COROUTINES
> +
> +static inline void co_yield(void) {}
> +static inline void co_exit(void) {}
> +
> +#else
> +
> +#ifdef __UBOOT__
> +#include <log.h>
> +#else
> +#include <assert.h>
> +#endif
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +
> +#ifdef __aarch64__
> +#define CO_REG_IDX_RETADDR 0
> +#define CO_REG_IDX_SP 1
> +#else
> +#error Architecture no supported
> +#endif
> +
> +struct co_save_stack {
> +    void*  ptr;
> +    size_t sz;
> +    size_t valid_sz;
> +    size_t max_cpsz; /* max copy size in bytes */
> +};
> +
> +struct co_stack {
> +    void *ptr;
> +    size_t sz;
> +    void *align_highptr;
> +    void *align_retptr;
> +    size_t align_validsz;
> +    size_t align_limit;
> +    struct co *owner;
> +    void *real_ptr;
> +    size_t real_sz;
> +};
> +
> +struct co {
> +	/* CPU state: callee-saved registers plus SP and PC */
> +	void *reg[14];  // pc, sp, x19-x29, x30 (lr)
> +
> +	struct co *main_co;
> +	void *arg;
> +	bool done;
> +
> +	void (*fp)(void);
> +
> +	struct co_save_stack save_stack;
> +	struct co_stack *stack;
> +};
> +
> +extern struct co *current_co;
> +
> +static inline struct co *co_get_co(void)
> +{
> +	return current_co;
> +}
> +
> +static inline void *co_get_arg(void)
> +{
> +	return co_get_co()->arg;
> +}
> +
> +struct co_stack *co_stack_new(size_t sz);
> +
> +void co_stack_destroy(struct co_stack *s);
> +
> +struct co *co_create(struct co *main_co,
> +		     struct co_stack *stack,
> +		     size_t save_stack_sz, void (*fp)(void),
> +		     void *arg);
> +
> +void co_resume(struct co *resume_co);
> +
> +void co_destroy(struct co *co);
> +
> +void *_co_switch(struct co *from_co, struct co *to_co);
> +
> +static inline void _co_yield_to_main_co(struct co *yield_co)
> +{
> +    assert(yield_co);
> +    assert(yield_co->main_co);
> +    _co_switch(yield_co, yield_co->main_co);
> +}
> +
> +static inline void co_yield(void)
> +{
> +	if (current_co)
> +		_co_yield_to_main_co(current_co);
> +}
> +
> +static inline bool co_is_main_co(struct co *co)
> +{
> +	return !co->main_co;
> +}
> +
> +static inline void co_exit(void)
> +{
> +	struct co *co = co_get_co();
> +
> +	if (!co)
> +		return;
> +	co->done = true;
> +	assert(co->stack->owner == co);
> +	co->stack->owner = NULL;
> +	co->stack->align_validsz = 0;
> +	_co_yield_to_main_co(co);
> +	assert(false);
> +}
> +
> +#endif /* CONFIG_COROUTINES */
> +#endif /* _COROUTINES_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 8f1a96d98c4..b6c1380b927 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1226,6 +1226,16 @@ config PHANDLE_CHECK_SEQ
>  	  enable this config option to distinguish them using
>  	  phandles in fdtdec_get_alias_seq() function.
>  
> +config COROUTINES
> +	bool "Enable coroutine support"
> +	help
> +	  Coroutines allow to implement a simple form of cooperative
> +	  multi-tasking. The main thread of execution registers one or
> +	  more functions as coroutine entry points, then it schedules one
> +	  of them. At any point the scheduled coroutine may yield, that is,
> +	  suspend its execution and return back to the main thread. At this
> +	  point another coroutine may be scheduled and so on until all the
> +	  registered coroutines are done.
>  endmenu
>  
>  source "lib/fwu_updates/Kconfig"
> diff --git a/lib/Makefile b/lib/Makefile
> index 5cb3278d2ef..7b809151f5a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -159,6 +159,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
>  
>  obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
>  
> +obj-$(CONFIG_COROUTINES) += coroutines.o
> +
>  #
>  # Build a fast OID lookup registry from include/linux/oid_registry.h
>  #
> diff --git a/lib/coroutines.c b/lib/coroutines.c
> new file mode 100644
> index 00000000000..20c5aba5510
> --- /dev/null
> +++ b/lib/coroutines.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later
> +
> +// Copyright 2018 Sen Han <00hnes@gmail.com>
> +// Copyright 2025 Linaro Limited
> +
> +#include <coroutines.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +
> +
> +/* Current co-routine */
> +struct co *current_co;
> +
> +struct co_stack *co_stack_new(size_t sz)
> +{
> +	struct co_stack *p = calloc(1, sizeof(*p));
> +	uintptr_t u_p;
> +
> +	if (!p)
> +		return NULL;
> +
> +	if (sz < 4096)
> +		sz = 4096;
> +
> +	p->sz = sz;
> +	p->ptr = malloc(sz);
> +	if (!p->ptr) {
> +		free(p);
> +		return NULL;
> +	}
> +
> +	p->owner = NULL;
> +	u_p = (uintptr_t)(p->sz - (sizeof(void*) << 1) + (uintptr_t)p->ptr);
> +	u_p = (u_p >> 4) << 4;
> +	p->align_highptr = (void*)u_p;
> +	p->align_retptr  = (void*)(u_p - sizeof(void*));
> +	assert(p->sz > (16 + (sizeof(void*) << 1) + sizeof(void*)));
> +	p->align_limit = p->sz - 16 - (sizeof(void*) << 1);
> +
> +	return p;
> +}
> +
> +void co_stack_destroy(struct co_stack *s){
> +	if (!s)
> +		return;
> +	free(s->ptr);
> +	free(s);
> +}
> +
> +struct co *co_create(struct co *main_co,
> +		     struct co_stack *stack,
> +		     size_t save_stack_sz,
> +		     void (*fp)(void), void *arg)
> +{
> +	struct co *p = malloc(sizeof(*p));
> +	assert(p);
> +	memset(p, 0, sizeof(*p));
> +
> +	if (main_co) {
> +		assert(stack);
> +		p->stack = stack;
> +		p->reg[CO_REG_IDX_RETADDR] = (void *)fp;
> +		// FIXME original code uses align_retptr; causes a crash
> +		p->reg[CO_REG_IDX_SP] = p->stack->align_highptr;
> +		p->main_co = main_co;
> +		p->arg = arg;
> +		p->fp = fp;
> +		if (!save_stack_sz)
> +			save_stack_sz = 64;
> +		p->save_stack.ptr = malloc(save_stack_sz);
> +		assert(p->save_stack.ptr);
> +		p->save_stack.sz = save_stack_sz;
> +		p->save_stack.valid_sz = 0;
> +	} else {
> +		p->main_co = NULL;
> +		p->arg = arg;
> +		p->fp = fp;
> +		p->stack = NULL;
> +		p->save_stack.ptr = NULL;
> +	}
> +	return p;
> +}
> +
> +static void grab_stack(struct co *resume_co)
> +{
> +	struct co *owner_co = resume_co->stack->owner;
> +
> +	if (owner_co) {
> +		assert(owner_co->stack == resume_co->stack);
> +		assert((uintptr_t)(owner_co->stack->align_retptr) >=
> +		       (uintptr_t)(owner_co->reg[CO_REG_IDX_SP]));
> +		assert((uintptr_t)owner_co->stack->align_highptr -
> +				(uintptr_t)owner_co->stack->align_limit
> +			<= (uintptr_t)owner_co->reg[CO_REG_IDX_SP]);
> +		owner_co->save_stack.valid_sz =
> +			(uintptr_t)owner_co->stack->align_retptr -
> +			(uintptr_t)owner_co->reg[CO_REG_IDX_SP];
> +		if (owner_co->save_stack.sz < owner_co->save_stack.valid_sz) {
> +			free(owner_co->save_stack.ptr);
> +			owner_co->save_stack.ptr = NULL;
> +			do {
> +				owner_co->save_stack.sz <<= 1;
> +				assert(owner_co->save_stack.sz > 0);
> +			} while (owner_co->save_stack.sz <
> +				 owner_co->save_stack.valid_sz);
> +			owner_co->save_stack.ptr =
> +				malloc(owner_co->save_stack.sz);
> +			assert(owner_co->save_stack.ptr);
> +		}
> +		if (owner_co->save_stack.valid_sz > 0)
> +			memcpy(owner_co->save_stack.ptr,
> +			       owner_co->reg[CO_REG_IDX_SP],
> +			       owner_co->save_stack.valid_sz);
> +		if (owner_co->save_stack.valid_sz >
> +		    owner_co->save_stack.max_cpsz)
> +			owner_co->save_stack.max_cpsz =
> +				owner_co->save_stack.valid_sz;
> +		owner_co->stack->owner = NULL;
> +		owner_co->stack->align_validsz = 0;
> +	}
> +	assert(!resume_co->stack->owner);
> +	assert(resume_co->save_stack.valid_sz <=
> +	       resume_co->stack->align_limit - sizeof(void *));
> +	if (resume_co->save_stack.valid_sz > 0)
> +		memcpy((void*)
> +		       (uintptr_t)(resume_co->stack->align_retptr) -
> +				resume_co->save_stack.valid_sz,
> +		       resume_co->save_stack.ptr,
> +		       resume_co->save_stack.valid_sz);
> +	if (resume_co->save_stack.valid_sz > resume_co->save_stack.max_cpsz)
> +		resume_co->save_stack.max_cpsz = resume_co->save_stack.valid_sz;
> +	resume_co->stack->align_validsz =
> +		resume_co->save_stack.valid_sz + sizeof(void *);
> +	resume_co->stack->owner = resume_co;
> +}
> +
> +void co_resume(struct co *resume_co)
> +{
> +	assert(resume_co && resume_co->main_co && !resume_co->done);
> +
> +	if (resume_co->stack->owner != resume_co)
> +		grab_stack(resume_co);
> +
> +	current_co = resume_co;
> +	_co_switch(resume_co->main_co, resume_co);
> +	current_co = resume_co->main_co;
> +}
> +
> +void co_destroy(struct co *co){
> +	if (!co)
> +		return;
> +
> +	if(co_is_main_co(co)){
> +		free(co);
> +		current_co = NULL;
> +	} else {
> +		if(co->stack->owner == co){
> +			co->stack->owner = NULL;
> +			co->stack->align_validsz = 0;
> +		}
> +		free(co->save_stack.ptr);
> +		co->save_stack.ptr = NULL;
> +		free(co);
> +	}
> +}
> -- 
> 2.43.0
> 
