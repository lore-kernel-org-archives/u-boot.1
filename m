Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DD6C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2527981197;
	Fri, 28 Feb 2025 14:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="An6o20px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6D4811B3; Fri, 28 Feb 2025 14:10:00 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FCF810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fd57a856c4so2294167b3.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740748196; x=1741352996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oyfar66Y//4fmWAZ9kkhXAvITLYSvNuWYLcohKTRzyo=;
 b=An6o20pxnPLrasEXlvUK2uLdl+tHAZFOcSBWqnELZXYMgzUnf6Ovd0oKVDzCSQxPlN
 bjkIQpucrOu4ryCPjjlXLCUdCE1VLnADtTKPinZwZPPHeUQSLMa3kpZpudXmQbafz/E+
 tbZqBTa5W4Cph1aHg1U8zkaHQ5eMjdjzn1V2vpANmhlZ/cFl6efVz5xEY6BVVaOmqfAr
 lg8DoEMRcAsow4giTfZXV81AEp5tK407h4ASlQbamcDrcaCzy5oaqkFEhM7jdD6ushEc
 DOxsdnjgk5cM3Hx7SgsZzgG2/Z+HkmLq0pbWw0p9J5VEXmDyUyVuaxWv22Ekwx3p4Wb2
 aVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740748196; x=1741352996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oyfar66Y//4fmWAZ9kkhXAvITLYSvNuWYLcohKTRzyo=;
 b=COvz34jSJzx3532Nyn7hGGIPNd3JB0pxGuVVq0tnBrL3F5nBFL446mDhDuvAkMPrMH
 wLlV6PaXkamr4HCKtnaICkwgT7zS1aEgWcwbcEdSRHrz7vCsizUpCcuztaS8z72eXQ7m
 sKpuyyy1GeVBMtHWJ+edxPiNErTaBpUQP6Dg0hp8P1z9W7VZ7i+9bFExWrfV2lPjaHMQ
 QnxBhnLsPJD+fNKKKFSaasldH4e8s6s/ctzNF77ukun5w23Rc+gmRgv+lp68H0QUdjE9
 45mubkd2tDEKnt+DZVVFPWbHsjc33vNa/4ijx1HRyFL2g4ty2hij4pqGF5E5L25gVa7e
 3qyA==
X-Gm-Message-State: AOJu0Yw8mYDmrkr29+q/3olF/sXJCeMVJsWO7OxhIcCuyqw4hgt3oMSC
 /0osmZnb5E77QdKuEzSD3W5+INNMnt2D6/gZkuQ2EwhK/KB7xOoQ6eyCAT8oPmdXMHhIIS8v+2h
 9ux885msklCEO2pWiA3p/cwtVizppVoM9oB2SOA==
X-Gm-Gg: ASbGncuOLsEe1t3WpFnZpitSYw81pVxzdHB7wjctW8zpVz0yiktinoIBSYkWGO152fA
 vE78LyxGtJ+uY963Y2hZtgOFjzr5a0wZWLp4aSlNrtczC40pGFfzHhspMTKtZ8nwbeNcnb2m/zf
 n+6/FL2M1WaRC0KaX199W0ENlCKphGaVQKeI6UbGY=
X-Google-Smtp-Source: AGHT+IGQ8yIJ2U+yM2zG69iyU28Rcm4Nx85Ej8AhmdHj6bgixSKvjmlGbfseedMB5f6MrPQ1SahslaMLVwzo0oWmBlA=
X-Received: by 2002:a05:690c:3349:b0:6fd:41e1:83d8 with SMTP id
 00721157ae682-6fd4a03dc9dmr52536987b3.6.1740748196524; Fri, 28 Feb 2025
 05:09:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <0b793a3251dbd9cf41066e3e358269fdb1aac3f8.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <0b793a3251dbd9cf41066e3e358269fdb1aac3f8.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 15:09:19 +0200
X-Gm-Features: AQ5f1JovsoEJPLmJHnOzoverFsUTWBKYR998S6GStDrh9-Gx9OQUYK5OGgJ-FAU
Message-ID: <CAC_iWjLFHOV4D4_SxvEf7i4HMTwFqd6S9Sqk1SGp88J_PJ31jA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] uthread: add cooperative multi-tasking interface
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Michal Simek <michal.simek@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jerome,

On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add an new

'a'

>  internal API called uthread (Kconfig symbol: UTHREAD) which
> provides cooperative multi-tasking. The goal is to be able to improve
> the performance of some parts of U-Boot by overlapping lengthy
> operations, and also implement background jobs in the U-Boot shell.
> Each uthread has its own stack allocated on the heap. The default stack
> size is defined by the UTHREAD_STACK_SIZE symbol and is used when
> uthread_create() receives zero for the stack_sz argument.
>
> The implementation is based on context-switching via initjmp()/setjmp()/
> longjmp() and is inspired from barebox threads [1]. A notion of thread
> group helps with dependencies, such as when a thread needs to block
> until a number of other threads have returned.
>
> The name "uthread" comes from "user-space threads" because the
> scheduling happens with no help from a higher privileged mode, contrary
> to more complex models where kernel threads are defined. But the 'u'
> may as well stand for 'U-Boot' since the bootloader may actually be
> running at any privilege level and the notion of user vs. kernel may
> not make much sense in this context.
>
> [1] https://github.com/barebox/barebox/blob/master/common/bthread.c
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  include/uthread.h |  44 ++++++++++++
>  lib/Kconfig       |  21 ++++++
>  lib/Makefile      |   2 +
>  lib/uthread.c     | 178 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 245 insertions(+)
>  create mode 100644 include/uthread.h
>  create mode 100644 lib/uthread.c
>
> diff --git a/include/uthread.h b/include/uthread.h
> new file mode 100644
> index 00000000000..f1f86d210d5
> --- /dev/null
> +++ b/include/uthread.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 Linaro Limited
> + */
> +
> +#include <linux/types.h>
> +
> +#ifndef _UTHREAD_H_
> +#define _UTHREAD_H_
> +
> +#ifdef CONFIG_UTHREAD
> +
> +int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
> +                  unsigned int grp_id);
> +bool uthread_schedule(void);
> +unsigned int uthread_grp_new_id(void);
> +bool uthread_grp_done(unsigned int grp_id);
> +
> +#else
> +
> +static inline int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
> +                                unsigned int grp_id)
> +{
> +       fn(arg);
> +       return 0;
> +}
> +
> +static inline bool uthread_schedule(void)
> +{
> +       return false;
> +}
> +
> +static inline unsigned int uthread_grp_new_id(void)
> +{
> +       return 0;
> +}
> +
> +static inline bool uthread_grp_done(unsigned int grp_id)
> +{
> +       return true;
> +}
> +
> +#endif /* CONFIG_UTHREAD */
> +#endif /* _UTHREAD_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1a683dea670..b32740ecbcc 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1255,6 +1255,27 @@ config PHANDLE_CHECK_SEQ
>           enable this config option to distinguish them using
>           phandles in fdtdec_get_alias_seq() function.
>
> +config UTHREAD
> +       bool "Enable thread support"
> +       depends on HAVE_INITJMP
> +       help
> +         Implement a simple form of cooperative multi-tasking based on
> +         context-switching via initjmp(), setjmp() and longjmp(). The
> +         uthread_ interface enables the main thread of execution to create
> +         one or more secondary threads and schedule them until they all have
> +         returned. At any point a thread may suspend its execution and
> +         schedule another thread, which allows for the efficient multiplexing
> +         of leghthy operations.
> +
> +config UTHREAD_STACK_SIZE
> +       int "Default uthread stack size"
> +       depends on UTHREAD
> +       default 32768
> +       help
> +         The default stak size for uthreads. Each uthread has its own stack.

stack size

> +         When the stack_sz argument to uthread_create() is zero then this
> +         value is used.
> +
>  endmenu
>
>  source "lib/fwu_updates/Kconfig"
> diff --git a/lib/Makefile b/lib/Makefile
> index a7bc2f3134a..3610694de7a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -164,6 +164,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
>
>  obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
>
> +obj-$(CONFIG_UTHREAD) += uthread.o
> +
>  #
>  # Build a fast OID lookup registry from include/linux/oid_registry.h
>  #
> diff --git a/lib/uthread.c b/lib/uthread.c
> new file mode 100644
> index 00000000000..430d1c0de32
> --- /dev/null
> +++ b/lib/uthread.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Ahmad Fatoum, Pengutronix
> + * Copyright (C) 2025 Linaro Limited
> + *
> + * An implementation of cooperative multi-tasking inspired from barebox threads
> + * https://github.com/barebox/barebox/blob/master/common/bthread.c
> + */
> +
> +#include <compiler.h>
> +#include <asm/setjmp.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <malloc.h>
> +#include <stdint.h>
> +#include <uthread.h>
> +
> +static struct uthread {
> +       void (*fn)(void *);
> +       void *arg;
> +       jmp_buf ctx;
> +       void *stack;
> +       bool done;
> +       unsigned int grp_id;
> +       struct list_head list;
> +} main_thread = {
> +       .list = LIST_HEAD_INIT(main_thread.list),
> +};
> +
> +static struct uthread *current = &main_thread;
> +
> +/**
> + * uthread_trampoline() - Call the current thread's entry point then resume the
> + * main thread.
> + *
> + * This is a helper function which is used as the @func argument to the inijmp()

initjump

> + * function, and ultimately invoked via setjmp(). It does not return, but
> + * instead longjmp()'s back to the main thread.
> + */
> +static void __noreturn uthread_trampoline(void)
> +{
> +       struct uthread *curr = current;
> +
> +       curr->fn(curr->arg);
> +       curr->done = true;
> +       current = &main_thread;
> +       longjmp(current->ctx, 1);
> +       /* Not reached */
> +       while (true)
> +               ;
> +}
> +
> +/**
> + * uthread_free() - Free memory used by a uthread object.
> + */
> +static void uthread_free(struct uthread *uthread)
> +{
> +       if (!uthread)
> +               return;
> +       free(uthread->stack);
> +       free(uthread);
> +}
> +
> +/**
> + * uthread_create() - Create a uthread object and make it ready for execution
> + *
> + * Threads are automatically deleted when then return from their entry point.

when they

[...]
> +/**
> + * uthread_grp_new_id() - return a new ID for a thread group
> + *
> + * Return: the new thread group ID
> + */
> +unsigned int uthread_grp_new_id(void)
> +{
> +       static unsigned int id = 0;
> +
> +       return ++id;
> +}

This seems a bit weird. Why do we need this function?

> +
> +/**
> + * uthread_grp_done() - test if all threads in a group are done
> + *
> + * @grp: the ID of the thread group that should be considered
> + * Return: false if the group contains at least one runnable thread (i.e., one
> + * thread which entry point has not returned yet), true otherwise
> + */
> +bool uthread_grp_done(unsigned int grp_id)
> +{
> +       struct uthread *next;
> +
> +       list_for_each_entry(next, &main_thread.list, list) {
> +               if (next->grp_id == grp_id && !next->done)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> --
> 2.43.0
>


Apart from the minor typos and the function that I can't figure out
why we need this look pretty clean

Thnaks
/Ilias
