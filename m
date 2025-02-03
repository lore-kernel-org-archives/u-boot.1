Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B5CC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 11:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0083D80079;
	Mon,  3 Feb 2025 12:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E36280087; Mon,  3 Feb 2025 12:57:10 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD5A8004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 12:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1tev4a-0002p2-Qs; Mon, 03 Feb 2025 12:57:04 +0100
Message-ID: <04166eeb-5296-4564-a222-a6e02453c40c@pengutronix.de>
Date: Mon, 3 Feb 2025 12:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] Introduce coroutines framework
To: Yao Zi <ziyao@disroot.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <cover.1738059345.git.jerome.forissier@linaro.org>
 <912af13c205a31080cc61d40bec29d7402185d6e.1738059345.git.jerome.forissier@linaro.org>
 <Z5z1-nHenTmnjukU@pie.lan>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <Z5z1-nHenTmnjukU@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hi,

On 31.01.25 17:10, Yao Zi wrote:
> On Tue, Jan 28, 2025 at 11:19:15AM +0100, Jerome Forissier wrote:
>> +.globl _co_switch
>> +.type  _co_switch, @function
>> +_co_switch:
>> +    // x0: from_co
>> +    // x1: to_co
>> +    // from_co and to_co layout: { pc, sp, x19-x29 }
>> +
>> +    // Save context to from_co (x0)
>> +    // AAPCS64 says "A subroutine invocation must preserve the contents of the
>> +    // registers r19-r29 and SP"
>> +    adr x2, 1f  // pc we should use to resume after this function
>> +    mov x3, sp
>> +    stp x2, x3, [x0, #0]  // pc, sp
>> +    stp x19, x20, [x0, #16]
>> +    stp x21, x22, [x0, #32]
>> +    stp x23, x24, [x0, #48]
>> +    stp x25, x26, [x0, #64]
>> +    stp x27, x28, [x0, #80]
>> +    stp x29, x30, [x0, #96]
>> +
>> +    // Load new context from to_co (x1)
>> +    ldp x2, x3, [x1, #0]  // pc, sp
>> +    ldp x19, x20, [x1, #16]
>> +    ldp x21, x22, [x1, #32]
>> +    ldp x23, x24, [x1, #48]
>> +    ldp x25, x26, [x1, #64]
>> +    ldp x27, x28, [x1, #80]
>> +    ldp x29, x30, [x1, #96]
>> +    mov sp, x3
>> +    br x2
>> +
>> +1:  // Return to the caller
>> +    ret
> 
> We've done similar context switching in setjmp/longjmp. Is it possible
> to unify this part and get rid of the duplicated assembly for each
> architecture?
> 
> The jmp_buf structure is actually non-opaque to the caller through
> jmp_buf_data, thus I believe this logic could be rewritten in C with
> setjmp/longjmp(),
> 
> 	if (!setjmp(from_co))
> 		longjmp(to_co);
> 	else
> 		return;
> 
> and replace co.regs with jmp_buf_data.

That's what the equivalent feature in barebox (called bthreads) is doing
as well: https://github.com/barebox/barebox/blob/master/common/bthread.c#L116

In addition to longjmp/setjmp, a third initjmp was introduced for all
architectures that allows creating the new context from scratch.


Cheers,
Ahmad

> 
> btw, I guess the jmp_buf_data type is kept for historical usage in EFI
> implementation, but looking through our EFI code it seems the details of
> jmp_buf aren't used anymore now. So maybe it's the time to clean up and
> make it a better context-switching API as well.
> 
>> diff --git a/include/coroutines.h b/include/coroutines.h
>> new file mode 100644
>> index 00000000000..b85b656127c
>> --- /dev/null
>> +++ b/include/coroutines.h
>> @@ -0,0 +1,130 @@
>> +/* SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later */
>> +/*
>> + * Copyright 2018 Sen Han <00hnes@gmail.com>
>> + * Copyright 2025 Linaro Limited
>> + */
>> +
>> +#ifndef _COROUTINES_H_
>> +#define _COROUTINES_H_
>> +
>> +#ifndef CONFIG_COROUTINES
>> +
>> +static inline void co_yield(void) {}
>> +static inline void co_exit(void) {}
>> +
>> +#else
>> +
>> +#ifdef __UBOOT__
>> +#include <log.h>
>> +#else
>> +#include <assert.h>
>> +#endif
>> +#include <limits.h>
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <time.h>
>> +
>> +#ifdef __aarch64__
>> +#define CO_REG_IDX_RETADDR 0
>> +#define CO_REG_IDX_SP 1
>> +#else
>> +#error Architecture no supported
>> +#endif
>> +
>> +struct co_save_stack {
>> +    void*  ptr;
>> +    size_t sz;
>> +    size_t valid_sz;
>> +    size_t max_cpsz; /* max copy size in bytes */
>> +};
>> +
>> +struct co_stack {
>> +    void *ptr;
>> +    size_t sz;
>> +    void *align_highptr;
>> +    void *align_retptr;
>> +    size_t align_validsz;
>> +    size_t align_limit;
>> +    struct co *owner;
>> +    void *real_ptr;
>> +    size_t real_sz;
>> +};
>> +
>> +struct co {
>> +	/* CPU state: callee-saved registers plus SP and PC */
>> +	void *reg[14];  // pc, sp, x19-x29, x30 (lr)
>> +
>> +	struct co *main_co;
>> +	void *arg;
>> +	bool done;
>> +
>> +	void (*fp)(void);
>> +
>> +	struct co_save_stack save_stack;
>> +	struct co_stack *stack;
>> +};
>> +
>> +extern struct co *current_co;
>> +
>> +static inline struct co *co_get_co(void)
>> +{
>> +	return current_co;
>> +}
>> +
>> +static inline void *co_get_arg(void)
>> +{
>> +	return co_get_co()->arg;
>> +}
>> +
>> +struct co_stack *co_stack_new(size_t sz);
>> +
>> +void co_stack_destroy(struct co_stack *s);
>> +
>> +struct co *co_create(struct co *main_co,
>> +		     struct co_stack *stack,
>> +		     size_t save_stack_sz, void (*fp)(void),
>> +		     void *arg);
>> +
>> +void co_resume(struct co *resume_co);
>> +
>> +void co_destroy(struct co *co);
>> +
>> +void *_co_switch(struct co *from_co, struct co *to_co);
>> +
>> +static inline void _co_yield_to_main_co(struct co *yield_co)
>> +{
>> +    assert(yield_co);
>> +    assert(yield_co->main_co);
>> +    _co_switch(yield_co, yield_co->main_co);
>> +}
>> +
>> +static inline void co_yield(void)
>> +{
>> +	if (current_co)
>> +		_co_yield_to_main_co(current_co);
>> +}
>> +
>> +static inline bool co_is_main_co(struct co *co)
>> +{
>> +	return !co->main_co;
>> +}
>> +
>> +static inline void co_exit(void)
>> +{
>> +	struct co *co = co_get_co();
>> +
>> +	if (!co)
>> +		return;
>> +	co->done = true;
>> +	assert(co->stack->owner == co);
>> +	co->stack->owner = NULL;
>> +	co->stack->align_validsz = 0;
>> +	_co_yield_to_main_co(co);
>> +	assert(false);
>> +}
>> +
>> +#endif /* CONFIG_COROUTINES */
>> +#endif /* _COROUTINES_H_ */
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 8f1a96d98c4..b6c1380b927 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -1226,6 +1226,16 @@ config PHANDLE_CHECK_SEQ
>>  	  enable this config option to distinguish them using
>>  	  phandles in fdtdec_get_alias_seq() function.
>>  
>> +config COROUTINES
>> +	bool "Enable coroutine support"
>> +	help
>> +	  Coroutines allow to implement a simple form of cooperative
>> +	  multi-tasking. The main thread of execution registers one or
>> +	  more functions as coroutine entry points, then it schedules one
>> +	  of them. At any point the scheduled coroutine may yield, that is,
>> +	  suspend its execution and return back to the main thread. At this
>> +	  point another coroutine may be scheduled and so on until all the
>> +	  registered coroutines are done.
>>  endmenu
>>  
>>  source "lib/fwu_updates/Kconfig"
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 5cb3278d2ef..7b809151f5a 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -159,6 +159,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
>>  
>>  obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
>>  
>> +obj-$(CONFIG_COROUTINES) += coroutines.o
>> +
>>  #
>>  # Build a fast OID lookup registry from include/linux/oid_registry.h
>>  #
>> diff --git a/lib/coroutines.c b/lib/coroutines.c
>> new file mode 100644
>> index 00000000000..20c5aba5510
>> --- /dev/null
>> +++ b/lib/coroutines.c
>> @@ -0,0 +1,165 @@
>> +// SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later
>> +
>> +// Copyright 2018 Sen Han <00hnes@gmail.com>
>> +// Copyright 2025 Linaro Limited
>> +
>> +#include <coroutines.h>
>> +#include <stdio.h>
>> +#include <stdint.h>
>> +
>> +
>> +/* Current co-routine */
>> +struct co *current_co;
>> +
>> +struct co_stack *co_stack_new(size_t sz)
>> +{
>> +	struct co_stack *p = calloc(1, sizeof(*p));
>> +	uintptr_t u_p;
>> +
>> +	if (!p)
>> +		return NULL;
>> +
>> +	if (sz < 4096)
>> +		sz = 4096;
>> +
>> +	p->sz = sz;
>> +	p->ptr = malloc(sz);
>> +	if (!p->ptr) {
>> +		free(p);
>> +		return NULL;
>> +	}
>> +
>> +	p->owner = NULL;
>> +	u_p = (uintptr_t)(p->sz - (sizeof(void*) << 1) + (uintptr_t)p->ptr);
>> +	u_p = (u_p >> 4) << 4;
>> +	p->align_highptr = (void*)u_p;
>> +	p->align_retptr  = (void*)(u_p - sizeof(void*));
>> +	assert(p->sz > (16 + (sizeof(void*) << 1) + sizeof(void*)));
>> +	p->align_limit = p->sz - 16 - (sizeof(void*) << 1);
>> +
>> +	return p;
>> +}
>> +
>> +void co_stack_destroy(struct co_stack *s){
>> +	if (!s)
>> +		return;
>> +	free(s->ptr);
>> +	free(s);
>> +}
>> +
>> +struct co *co_create(struct co *main_co,
>> +		     struct co_stack *stack,
>> +		     size_t save_stack_sz,
>> +		     void (*fp)(void), void *arg)
>> +{
>> +	struct co *p = malloc(sizeof(*p));
>> +	assert(p);
>> +	memset(p, 0, sizeof(*p));
>> +
>> +	if (main_co) {
>> +		assert(stack);
>> +		p->stack = stack;
>> +		p->reg[CO_REG_IDX_RETADDR] = (void *)fp;
>> +		// FIXME original code uses align_retptr; causes a crash
>> +		p->reg[CO_REG_IDX_SP] = p->stack->align_highptr;
>> +		p->main_co = main_co;
>> +		p->arg = arg;
>> +		p->fp = fp;
>> +		if (!save_stack_sz)
>> +			save_stack_sz = 64;
>> +		p->save_stack.ptr = malloc(save_stack_sz);
>> +		assert(p->save_stack.ptr);
>> +		p->save_stack.sz = save_stack_sz;
>> +		p->save_stack.valid_sz = 0;
>> +	} else {
>> +		p->main_co = NULL;
>> +		p->arg = arg;
>> +		p->fp = fp;
>> +		p->stack = NULL;
>> +		p->save_stack.ptr = NULL;
>> +	}
>> +	return p;
>> +}
>> +
>> +static void grab_stack(struct co *resume_co)
>> +{
>> +	struct co *owner_co = resume_co->stack->owner;
>> +
>> +	if (owner_co) {
>> +		assert(owner_co->stack == resume_co->stack);
>> +		assert((uintptr_t)(owner_co->stack->align_retptr) >=
>> +		       (uintptr_t)(owner_co->reg[CO_REG_IDX_SP]));
>> +		assert((uintptr_t)owner_co->stack->align_highptr -
>> +				(uintptr_t)owner_co->stack->align_limit
>> +			<= (uintptr_t)owner_co->reg[CO_REG_IDX_SP]);
>> +		owner_co->save_stack.valid_sz =
>> +			(uintptr_t)owner_co->stack->align_retptr -
>> +			(uintptr_t)owner_co->reg[CO_REG_IDX_SP];
>> +		if (owner_co->save_stack.sz < owner_co->save_stack.valid_sz) {
>> +			free(owner_co->save_stack.ptr);
>> +			owner_co->save_stack.ptr = NULL;
>> +			do {
>> +				owner_co->save_stack.sz <<= 1;
>> +				assert(owner_co->save_stack.sz > 0);
>> +			} while (owner_co->save_stack.sz <
>> +				 owner_co->save_stack.valid_sz);
>> +			owner_co->save_stack.ptr =
>> +				malloc(owner_co->save_stack.sz);
>> +			assert(owner_co->save_stack.ptr);
>> +		}
>> +		if (owner_co->save_stack.valid_sz > 0)
>> +			memcpy(owner_co->save_stack.ptr,
>> +			       owner_co->reg[CO_REG_IDX_SP],
>> +			       owner_co->save_stack.valid_sz);
>> +		if (owner_co->save_stack.valid_sz >
>> +		    owner_co->save_stack.max_cpsz)
>> +			owner_co->save_stack.max_cpsz =
>> +				owner_co->save_stack.valid_sz;
>> +		owner_co->stack->owner = NULL;
>> +		owner_co->stack->align_validsz = 0;
>> +	}
>> +	assert(!resume_co->stack->owner);
>> +	assert(resume_co->save_stack.valid_sz <=
>> +	       resume_co->stack->align_limit - sizeof(void *));
>> +	if (resume_co->save_stack.valid_sz > 0)
>> +		memcpy((void*)
>> +		       (uintptr_t)(resume_co->stack->align_retptr) -
>> +				resume_co->save_stack.valid_sz,
>> +		       resume_co->save_stack.ptr,
>> +		       resume_co->save_stack.valid_sz);
>> +	if (resume_co->save_stack.valid_sz > resume_co->save_stack.max_cpsz)
>> +		resume_co->save_stack.max_cpsz = resume_co->save_stack.valid_sz;
>> +	resume_co->stack->align_validsz =
>> +		resume_co->save_stack.valid_sz + sizeof(void *);
>> +	resume_co->stack->owner = resume_co;
>> +}
>> +
>> +void co_resume(struct co *resume_co)
>> +{
>> +	assert(resume_co && resume_co->main_co && !resume_co->done);
>> +
>> +	if (resume_co->stack->owner != resume_co)
>> +		grab_stack(resume_co);
>> +
>> +	current_co = resume_co;
>> +	_co_switch(resume_co->main_co, resume_co);
>> +	current_co = resume_co->main_co;
>> +}
>> +
>> +void co_destroy(struct co *co){
>> +	if (!co)
>> +		return;
>> +
>> +	if(co_is_main_co(co)){
>> +		free(co);
>> +		current_co = NULL;
>> +	} else {
>> +		if(co->stack->owner == co){
>> +			co->stack->owner = NULL;
>> +			co->stack->align_validsz = 0;
>> +		}
>> +		free(co->save_stack.ptr);
>> +		co->save_stack.ptr = NULL;
>> +		free(co);
>> +	}
>> +}
>> -- 
>> 2.43.0
>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
