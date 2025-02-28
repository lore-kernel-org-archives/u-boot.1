Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926E2C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2AC6809A5;
	Fri, 28 Feb 2025 15:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nkFW1wmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A7D809D4; Fri, 28 Feb 2025 15:30:41 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EAB807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso381916566b.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740753038; x=1741357838; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TnGn6wloC5n555w5TCSIu/L2qn14XQXee9ke4oHcd6Q=;
 b=nkFW1wmKXPW1SVXwmOmAG2wybrPveFB5QdxOe4ceXXA7DQnERycw4hfcj7WsZMEuO0
 o5TXqjbvbMvReFeeSTPlFNv8j/sMWAsIpjffKrJMVzQDF99DD5hYCx2AxeqYXIErL2GL
 KGseInAnOAJ2xACvmmmCmLyMvHf4CJp1WMFVH0kwiaMgbv4oiM9I9ni8MN4si8QYSqLd
 71AGFKUflLr/eRj/lKs+jlGT8prrLKILfMOQjUX4fmw/UmzI44TYuyTnB3a2rsvAsTTA
 P35U3Pi51ndcm5vyZue2VC5eFapM8VDpgRrKj7xMSrHL5FRSPlYNuPB3i0JYLXXiv8+c
 O5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740753038; x=1741357838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TnGn6wloC5n555w5TCSIu/L2qn14XQXee9ke4oHcd6Q=;
 b=Vyvw7xVrtytbum3ixul+phTlVaFX1xXa1u05mSgMXaVGtKrW5zu/ByRG8MdmjXdZ/u
 sJQAfusxcl7wKzXbngsYbewCELIR2ePWI63xhuSFoAu11CJRMvPdgLy5axTxW+dA19I+
 2jhPtPs107UVv+ljElPxLIUWQ9TiiEahAcU148X/KKkaJ4gCrBX7wScxQ0/tx2uRTxtE
 faHO1vVmXsjMsh6GdPGSGsq+VKGbhldKmA+a2iCtVi2gpQGCaDcyvPz+i7Dg/DTKU/HV
 0xLOz85pZR9NZZqxwzVOL8S/rj5fcWBunztkuYLuvgEu5arOcVMkMY/fJQJT6YaDMbww
 FOzg==
X-Gm-Message-State: AOJu0YyvhYAu8Ew8HV6Y0dNIVbvTIjY2LYDJpPqt3rNhj6PMHEVHqkIq
 qvovSQJEkovDV5dzsJSDy/J6zI+khLqlpeq7AoTAQcwavNcS6cYQlG0DEa91HPo=
X-Gm-Gg: ASbGncvDqkJd4lBfTPPVFH3oGh4BKxmfOQ35BziIV1Lpgio32wCcNVYcXzzw7WzSYjC
 8rdVKj6oIPaZAAQk//ply7vVJXbwELGvR8OIDdB5Y742A/VWZWoMnhMM7sO2xOnm0bvN/D4RB+A
 1srn7m2jsv+4FrUE6odSJB8iDfI79MTrj71PT3oI497/Omp4AwFjtNu7605PL3yPaYATkpcMId0
 9cZzu7dGk0fuEOk/eg2kjRsopQbY20Nva3GtIjRU6Lp5GGTwiPv5PTj3BsKCdHlVUAUBuUiYZWu
 qPO5hyFfRxDiCqklxcrEQbP71RJWet6WqhPqEnNvo4MbaYpYleZ5++bPM3iLFP8ciPlSq4iapZy
 i0B0X1w==
X-Google-Smtp-Source: AGHT+IGLRhGUwyp9oe+xJZXNtohGp97FhkUthJ8qG2bqhpas4UlvU/NzrB0Z1quAq9aJplw0ZdT5ZQ==
X-Received: by 2002:a17:907:7b87:b0:ab7:bcc0:9050 with SMTP id
 a640c23a62f3a-abf26561731mr371111866b.27.1740753037772; 
 Fri, 28 Feb 2025 06:30:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b91dcsm295838166b.21.2025.02.28.06.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 06:30:37 -0800 (PST)
Message-ID: <f78e80bf-5e2b-49d8-867c-19c60b31780c@linaro.org>
Date: Fri, 28 Feb 2025 15:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] uthread: add cooperative multi-tasking interface
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <0b793a3251dbd9cf41066e3e358269fdb1aac3f8.1740499185.git.jerome.forissier@linaro.org>
 <CAC_iWjLFHOV4D4_SxvEf7i4HMTwFqd6S9Sqk1SGp88J_PJ31jA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjLFHOV4D4_SxvEf7i4HMTwFqd6S9Sqk1SGp88J_PJ31jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 2/28/25 14:09, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Add an new
> 
> 'a'

Fixed in v3

> 
>>  internal API called uthread (Kconfig symbol: UTHREAD) which
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
>>  include/uthread.h |  44 ++++++++++++
>>  lib/Kconfig       |  21 ++++++
>>  lib/Makefile      |   2 +
>>  lib/uthread.c     | 178 ++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 245 insertions(+)
>>  create mode 100644 include/uthread.h
>>  create mode 100644 lib/uthread.c
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
>> +                  unsigned int grp_id);
>> +bool uthread_schedule(void);
>> +unsigned int uthread_grp_new_id(void);
>> +bool uthread_grp_done(unsigned int grp_id);
>> +
>> +#else
>> +
>> +static inline int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
>> +                                unsigned int grp_id)
>> +{
>> +       fn(arg);
>> +       return 0;
>> +}
>> +
>> +static inline bool uthread_schedule(void)
>> +{
>> +       return false;
>> +}
>> +
>> +static inline unsigned int uthread_grp_new_id(void)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline bool uthread_grp_done(unsigned int grp_id)
>> +{
>> +       return true;
>> +}
>> +
>> +#endif /* CONFIG_UTHREAD */
>> +#endif /* _UTHREAD_H_ */
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 1a683dea670..b32740ecbcc 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -1255,6 +1255,27 @@ config PHANDLE_CHECK_SEQ
>>           enable this config option to distinguish them using
>>           phandles in fdtdec_get_alias_seq() function.
>>
>> +config UTHREAD
>> +       bool "Enable thread support"
>> +       depends on HAVE_INITJMP
>> +       help
>> +         Implement a simple form of cooperative multi-tasking based on
>> +         context-switching via initjmp(), setjmp() and longjmp(). The
>> +         uthread_ interface enables the main thread of execution to create
>> +         one or more secondary threads and schedule them until they all have
>> +         returned. At any point a thread may suspend its execution and
>> +         schedule another thread, which allows for the efficient multiplexing
>> +         of leghthy operations.
>> +
>> +config UTHREAD_STACK_SIZE
>> +       int "Default uthread stack size"
>> +       depends on UTHREAD
>> +       default 32768
>> +       help
>> +         The default stak size for uthreads. Each uthread has its own stack.
> 
> stack size

Fixed in v3

> 
>> +         When the stack_sz argument to uthread_create() is zero then this
>> +         value is used.
>> +
>>  endmenu
>>
>>  source "lib/fwu_updates/Kconfig"
>> diff --git a/lib/Makefile b/lib/Makefile
>> index a7bc2f3134a..3610694de7a 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -164,6 +164,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
>>
>>  obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
>>
>> +obj-$(CONFIG_UTHREAD) += uthread.o
>> +
>>  #
>>  # Build a fast OID lookup registry from include/linux/oid_registry.h
>>  #
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
>> +       void (*fn)(void *);
>> +       void *arg;
>> +       jmp_buf ctx;
>> +       void *stack;
>> +       bool done;
>> +       unsigned int grp_id;
>> +       struct list_head list;
>> +} main_thread = {
>> +       .list = LIST_HEAD_INIT(main_thread.list),
>> +};
>> +
>> +static struct uthread *current = &main_thread;
>> +
>> +/**
>> + * uthread_trampoline() - Call the current thread's entry point then resume the
>> + * main thread.
>> + *
>> + * This is a helper function which is used as the @func argument to the inijmp()
> 
> initjump
> 
>> + * function, and ultimately invoked via setjmp(). It does not return, but
>> + * instead longjmp()'s back to the main thread.
>> + */
>> +static void __noreturn uthread_trampoline(void)
>> +{
>> +       struct uthread *curr = current;
>> +
>> +       curr->fn(curr->arg);
>> +       curr->done = true;
>> +       current = &main_thread;
>> +       longjmp(current->ctx, 1);
>> +       /* Not reached */
>> +       while (true)
>> +               ;
>> +}
>> +
>> +/**
>> + * uthread_free() - Free memory used by a uthread object.
>> + */
>> +static void uthread_free(struct uthread *uthread)
>> +{
>> +       if (!uthread)
>> +               return;
>> +       free(uthread->stack);
>> +       free(uthread);
>> +}
>> +
>> +/**
>> + * uthread_create() - Create a uthread object and make it ready for execution
>> + *
>> + * Threads are automatically deleted when then return from their entry point.
> 
> when they

Fixed in v3

> 
> [...]
>> +/**
>> + * uthread_grp_new_id() - return a new ID for a thread group
>> + *
>> + * Return: the new thread group ID
>> + */
>> +unsigned int uthread_grp_new_id(void)
>> +{
>> +       static unsigned int id = 0;
>> +
>> +       return ++id;
>> +}
> 
> This seems a bit weird. Why do we need this function?

As it should appear clearly in the subsequent patches, it is to help with
dependencies. Suppose the main thread creates a thread to perform the
"usb start" command. At this point we have two threads: let's call them
main and usb_start. The latter enumerates the busses and creates one
thread per bus to do the actual device scan. Let's assume we have two
busses, then usb_start creates scan1 and scan2.

The main thread needs to do:

while (!done(usb_start))
    uthread_schedule();

The usb_start on the other hand is only interested in is own two threads,
scan1 and scan2. It has to wait until both are done, and only those two:

while (!done(scan1) || !done(scan2))
    uthread_schedule();

This can easily be written if threads can be assigned group IDs:

/* Main */
usb_start_id = uthread_new_grp_id();
uthread_create(..., usb_start, NULL, usb_start_id);
while (!uthread_grp_done(usb_start_id))
    uthread_schedule();

/* usb_start() */
scan_id = uthread_new_grp_id();
uthread_create(..., usb_start, bus1, scan_id);
uthread_create(..., usb_start, bus2, scan_id);
while (!uthread_grp_done(scan_id))
    uthread_schedule();

> 
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
>> +       struct uthread *next;
>> +
>> +       list_for_each_entry(next, &main_thread.list, list) {
>> +               if (next->grp_id == grp_id && !next->done)
>> +                       return false;
>> +       }
>> +
>> +       return true;
>> +}
>> --
>> 2.43.0
>>
> 
> 
> Apart from the minor typos and the function that I can't figure out
> why we need this look pretty clean

Thanks!

Cheers,
-- 
Jerome

> 
> Thnaks
> /Ilias
