Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6D5C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D50F4809A5;
	Fri, 28 Feb 2025 15:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MTuyjhGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511AC80FF2; Fri, 28 Feb 2025 15:39:54 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8C1807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abb892fe379so305224066b.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740753591; x=1741358391; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ODgOD2k4WhtC/QJm7eQpqpCADC+BW4Eendj64/Om3T8=;
 b=MTuyjhGFgEkoAwpwGA3d8Qff0HVZf6uZ5hMJ+L+qaqf5qV8EYAZhXtvqA3P41yeKYQ
 N/yOcGqja5Z4H13z3W7C17LqSl4MOQl+DYzjUUCxSq3FsDmZUsVhS66a+qdpsm15+9U5
 6Smm7qwIQHqrDe3Z0I/ZibnxuyHxAhMfsveyrnPWAudiJ48wiSPpzIfzaO2DRCpTn53D
 gU08osOOjuJDaRjv57S0xpAfErrySq1/oa1H9kkracHfrfbNO9cirwv4iDuTf/i9n9j0
 3n3JbuGRBClYBfNWvb0+sbzYcmauS1wdwpefAe7BkTjOkIQVmGqu+1uk9ySev80IRp+M
 cGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740753591; x=1741358391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODgOD2k4WhtC/QJm7eQpqpCADC+BW4Eendj64/Om3T8=;
 b=B1U0Z+tR0isrTH6e5egmuqH52J8/OurnK/5Wavuqi9VyI9qLWt2aTs2cugywfUkmh8
 kCSuwN7VqI7/KxryxhMvdE2HW/4YHlLy7iG71M5mrCvLRNjAr4vpBDF805yHFCz2tLct
 vT8UAS2E2mTkUjX+owsk6yVRaEy4E/rQ0tkq6tUjIIOUDxPvhS3Cp5tLpFgCzTGRy4E9
 rLTE1NSkbRSNOf395CXrJkAkeHXaJwpI2QQ4R65jHsPkp7do47s0QEnr5f+KRNSAuA5p
 4Bgq/3+J0zVpD8e3qWs9RNuesqMUWoWf7nsE6WOfROfZTwmWIbQ/sV6X10b88yjRMh85
 bsJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxhNNfhsNHN5TrpPGHoFsQ5ypxIoidgMl0pJEjAOzHRac3xExGpoUfFEvG5af9ZVvyjybAQ3s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4zzOA9RlH9rWJ9jYJ0+lSLvlxdiTR4pu+jSMVuUdkthIlueNf
 nHH5cnyyhPlaZemTviSkoM6ci6nuNOWx1NaUD1oZnQg/lV74hsSvM7fveUpbcMs=
X-Gm-Gg: ASbGnct1yuwkjtm63MDfTv3f8BGdKIfJ93YOriX3dpJzJ13XqSMahpCJp47hPDIwjk+
 IjKYHCAb16OlP2YRMLNPeRdH5eKb5tGHQy/Ftxdz168Azo0mlIfU8nChTtfFnc/u8rkeXT7hvIV
 8SJ9dRj5TaK8duQ/6dcdX4ZgJOuSX0O8U/2rEVNAyM1XJvhteJ+/fwjPgha/uzD3N2FGIhfSAnJ
 yY4n90MlXzlWTyAVTiXjuNCPMqtcyM4CF7Q5o3c0vrWGQocPQrbRMN2xliif1Qal1PYirvArEjb
 bRsTkf7YMl564uLjUVFc0jEsACynPlzWvIwRuBYdhxnqX9WBUt0tW/mJtRHhbPmON9lswmcpGfj
 w7yD9SQ==
X-Google-Smtp-Source: AGHT+IEM8pekXEKdQVmIGoP8BMn2L71+oGob2+VeTCHp3UuntYhhLAVPZr+6rJVJ9P4Lg1S9h/tKIw==
X-Received: by 2002:a05:6402:2692:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5e4d6b4baabmr5656773a12.23.1740753590792; 
 Fri, 28 Feb 2025 06:39:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b98e1sm296938966b.9.2025.02.28.06.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 06:39:50 -0800 (PST)
Message-ID: <54255b8d-cc2b-4d0a-90f5-833322fe0955@linaro.org>
Date: Fri, 28 Feb 2025 15:39:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] uthread: add cooperative multi-tasking interface
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Raymond Mao
 <raymond.mao@linaro.org>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <0b793a3251dbd9cf41066e3e358269fdb1aac3f8.1740499185.git.jerome.forissier@linaro.org>
 <e5b1a22c-a51b-4c9c-b653-3170a04bb165@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <e5b1a22c-a51b-4c9c-b653-3170a04bb165@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 2/28/25 14:21, Heinrich Schuchardt wrote:
> On 25.02.25 17:34, Jerome Forissier wrote:
>> Add an new internal API called uthread (Kconfig symbol: UTHREAD) which
> 
> nits:
> 
> %s/an/a/

Fixed in v3

> 
>> provides cooperative multi-tasking. The goal is to be able to improve
>> the performance of some parts of U-Boot by overlapping lengthy
>> operations, and also implement background jobs in the U-Boot shell.
>> Each uthread has its own stack allocated on the heap. The default stack
>> size is defined by the UTHREAD_STACK_SIZE symbol and is used when
>> uthread_create() receives zero for the stack_sz argument.
>>
>> The implementation is based on context-switching via initjmp()/setjmp()/
>> longjmp() and is inspired from barebox threads [1]. A notion of thread
>> group helps with dependencies, such as when a thread needs to block
>> until a number of other threads have returned.
>>
>> The name "uthread" comes from "user-space threads" because the
>> scheduling happens with no help from a higher privileged mode, contrary
>> to more complex models where kernel threads are defined. But the 'u'
>> may as well stand for 'U-Boot' since the bootloader may actually be
>> running at any privilege level and the notion of user vs. kernel may
>> not make much sense in this context.
>>
>> [1] https://github.com/barebox/barebox/blob/master/common/bthread.c
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   include/uthread.h |  44 ++++++++++++
>>   lib/Kconfig       |  21 ++++++
>>   lib/Makefile      |   2 +
>>   lib/uthread.c     | 178 ++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 245 insertions(+)
>>   create mode 100644 include/uthread.h
>>   create mode 100644 lib/uthread.c
>>
>> diff --git a/include/uthread.h b/include/uthread.h
>> new file mode 100644
>> index 00000000000..f1f86d210d5
>> --- /dev/null
>> +++ b/include/uthread.h
>> @@ -0,0 +1,44 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright 2025 Linaro Limited
>> + */
>> +
>> +#include <linux/types.h>
>> +
>> +#ifndef _UTHREAD_H_
>> +#define _UTHREAD_H_
>> +
>> +#ifdef CONFIG_UTHREAD
>> +
>> +int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
>> +           unsigned int grp_id);
> 
> Every function needs a Shinx style documentation.

Ack.

> 
>> +bool uthread_schedule(void);
>> +unsigned int uthread_grp_new_id(void);
>> +bool uthread_grp_done(unsigned int grp_id);
>> +
>> +#else
>> +
>> +static inline int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
>> +                 unsigned int grp_id)
>> +{
>> +    fn(arg);
>> +    return 0;
>> +}
>> +
>> +static inline bool uthread_schedule(void)
>> +{
>> +    return false;
>> +}
>> +
>> +static inline unsigned int uthread_grp_new_id(void)
>> +{
>> +    return 0;
>> +}
>> +
>> +static inline bool uthread_grp_done(unsigned int grp_id)
>> +{
>> +    return true;
>> +}
>> +
>> +#endif /* CONFIG_UTHREAD */
>> +#endif /* _UTHREAD_H_ */
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 1a683dea670..b32740ecbcc 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -1255,6 +1255,27 @@ config PHANDLE_CHECK_SEQ
>>         enable this config option to distinguish them using
>>         phandles in fdtdec_get_alias_seq() function.
>>
>> +config UTHREAD
>> +    bool "Enable thread support"
>> +    depends on HAVE_INITJMP
>> +    help
>> +      Implement a simple form of cooperative multi-tasking based on
>> +      context-switching via initjmp(), setjmp() and longjmp(). The
>> +      uthread_ interface enables the main thread of execution to create
>> +      one or more secondary threads and schedule them until they all have
>> +      returned. At any point a thread may suspend its execution and
>> +      schedule another thread, which allows for the efficient multiplexing
>> +      of leghthy operations.
>> +
>> +config UTHREAD_STACK_SIZE
>> +    int "Default uthread stack size"
>> +    depends on UTHREAD
>> +    default 32768
>> +    help
>> +      The default stak size for uthreads. Each uthread has its own stack.
>> +      When the stack_sz argument to uthread_create() is zero then this
>> +      value is used.
>> +
>>   endmenu
>>
>>   source "lib/fwu_updates/Kconfig"
>> diff --git a/lib/Makefile b/lib/Makefile
>> index a7bc2f3134a..3610694de7a 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -164,6 +164,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
>>
>>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
>>
>> +obj-$(CONFIG_UTHREAD) += uthread.o
>> +
>>   #
>>   # Build a fast OID lookup registry from include/linux/oid_registry.h
>>   #
>> diff --git a/lib/uthread.c b/lib/uthread.c
>> new file mode 100644
>> index 00000000000..430d1c0de32
>> --- /dev/null
>> +++ b/lib/uthread.c
>> @@ -0,0 +1,178 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2021 Ahmad Fatoum, Pengutronix
>> + * Copyright (C) 2025 Linaro Limited
>> + *
>> + * An implementation of cooperative multi-tasking inspired from barebox threads
>> + * https://github.com/barebox/barebox/blob/master/common/bthread.c
>> + */
>> +
>> +#include <compiler.h>
>> +#include <asm/setjmp.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <malloc.h>
>> +#include <stdint.h>
>> +#include <uthread.h>
>> +
>> +static struct uthread {
>> +    void (*fn)(void *);
>> +    void *arg;
>> +    jmp_buf ctx;
>> +    void *stack;
>> +    bool done;
>> +    unsigned int grp_id;
>> +    struct list_head list;
> 
> The structure and all its components need to be documented.

Ack.

> 
>> +} main_thread = {
>> +    .list = LIST_HEAD_INIT(main_thread.list),
>> +};
>> +
>> +static struct uthread *current = &main_thread;
>> +
>> +/**
>> + * uthread_trampoline() - Call the current thread's entry point then resume the
>> + * main thread.
>> + *
>> + * This is a helper function which is used as the @func argument to the inijmp()
>> + * function, and ultimately invoked via setjmp(). It does not return, but
>> + * instead longjmp()'s back to the main thread.
>> + */
>> +static void __noreturn uthread_trampoline(void)
>> +{
>> +    struct uthread *curr = current;
>> +
>> +    curr->fn(curr->arg);
>> +    curr->done = true;
>> +    current = &main_thread;
>> +    longjmp(current->ctx, 1);
>> +    /* Not reached */
>> +    while (true)
>> +        ;
>> +}
>> +
>> +/**
>> + * uthread_free() - Free memory used by a uthread object.
>> + */
>> +static void uthread_free(struct uthread *uthread)
>> +{
>> +    if (!uthread)
>> +        return;
>> +    free(uthread->stack);
>> +    free(uthread);
>> +}
>> +
>> +/**
>> + * uthread_create() - Create a uthread object and make it ready for execution
>> + *
>> + * Threads are automatically deleted when then return from their entry point.
>> + *
>> + * @fn: the thread's entry point
>> + * @arg: argument passed to the thread's entry point
>> + * @stack_sz: stack size for the new thread (in bytes). The stack is allocated
>> + * on the heap.
>> + * @grp_id: an optional thread group ID that the new thread should belong to
>> + * (zero for no group)
>> + */
> 
> This documentation should be move to the include and the include needs
> to be added to doc/api/.

OK.

> 
>> +int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
>> +           unsigned int grp_id)
> 
> We should model the functions more like pthreads.
> 
> Let the caller provide struct uthread(). This will allow us to implement
> pthread_cancel() and phthread_join().

I'd like to keep the ability to let the framework do as much as possible
and the notion of grp_id already allows to wait and could be used to cancel
too. That said, the uthread struct would be helpful to get the return status.
I can do:

int uthread_create(struct uthread *uthread, void (*fn)(void *), void *arg,
                   size_t stack_sz, unsigned int grp_id);

...with uthread being optional (NULL allowed). Would that work for you?

Regards,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
>> +{
>> +    struct uthread *uthread;
>> +
>> +    if (!stack_sz)
>> +        stack_sz = CONFIG_UTHREAD_STACK_SIZE;
>> +
>> +    uthread = calloc(1, sizeof(*uthread));
>> +    if (!uthread)
>> +        return -1;
>> +
>> +    uthread->stack = memalign(16, stack_sz);
>> +    if (!uthread->stack)
>> +        goto err;
>> +
>> +    uthread->fn = fn;
>> +    uthread->arg = arg;
>> +    uthread->grp_id = grp_id;
>> +
>> +    list_add_tail(&uthread->list, &current->list);
>> +
>> +    initjmp(uthread->ctx, uthread_trampoline, uthread->stack + stack_sz);
>> +
>> +    return 0;
>> +err:
>> +    uthread_free(uthread);
>> +    return -1;
>> +}
>> +
>> +/**
>> + * uthread_resume() - switch execution to a given thread
>> + *
>> + * @uthread: the thread object that should be resumed
>> + */
>> +static void uthread_resume(struct uthread *uthread)
>> +{
>> +    if (!setjmp(current->ctx)) {
>> +        current = uthread;
>> +        longjmp(uthread->ctx, 1);
>> +    }
>> +}
>> +
>> +/**
>> + * uthread_schedule() - yield the CPU to the next runnable thread
>> + *
>> + * This function is called either by the main thread or any secondary thread
>> + * (that is, any thread created via uthread_create()) to switch execution to
>> + * the next runnable thread.
>> + *
>> + * Return: true if a thread was scheduled, false if no runnable thread was found
>> + */
>> +bool uthread_schedule(void)
>> +{
>> +    struct uthread *next;
>> +    struct uthread *tmp;
>> +
>> +    if (list_empty(&current->list))
>> +        return false;
>> +
>> +    list_for_each_entry_safe(next, tmp, &current->list, list) {
>> +        if (!next->done) {
>> +            uthread_resume(next);
>> +            return true;
>> +        } else {
>> +            /* Found a 'done' thread, free its resources */
>> +            list_del(&next->list);
>> +            uthread_free(next);
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +/**
>> + * uthread_grp_new_id() - return a new ID for a thread group
>> + *
>> + * Return: the new thread group ID
>> + */
>> +unsigned int uthread_grp_new_id(void)
>> +{
>> +    static unsigned int id = 0;
>> +
>> +    return ++id;
>> +}
>> +
>> +/**
>> + * uthread_grp_done() - test if all threads in a group are done
>> + *
>> + * @grp: the ID of the thread group that should be considered
>> + * Return: false if the group contains at least one runnable thread (i.e., one
>> + * thread which entry point has not returned yet), true otherwise
>> + */
>> +bool uthread_grp_done(unsigned int grp_id)
>> +{
>> +    struct uthread *next;
>> +
>> +    list_for_each_entry(next, &main_thread.list, list) {
>> +        if (next->grp_id == grp_id && !next->done)
>> +            return false;
>> +    }
>> +
>> +    return true;
>> +}
> 
