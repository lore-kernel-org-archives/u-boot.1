Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848B4C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 14:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD752807D7;
	Tue, 11 Mar 2025 15:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d+j4JMhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FC7801FB; Tue, 11 Mar 2025 15:21:48 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD17801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e63504bedd0so4015777276.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741702904; x=1742307704; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WBo3wvy2+w/OB5OacD6sLsWlB48pJd8fJfMZgkJPMpc=;
 b=d+j4JMhbGoZVTW6GU/Lro3DnDNXZoyJdPX9CYsXCPukd9zQ6fv/jVnLkJ9piJg8pF9
 25zOdq5+4mYXVYiQJQwzqSNHVtynoGIjJF2ydX1DlzarotOf6SPk6dLBS8txZa094mT5
 LmwEJl9QGSEzoN3vigAz8EGsxU9EKyXsGTEjQ+fg84zZ+6CYa91Tk+d+4XsI4YW/NMVh
 SeaeS8PmrqTGyb1ZkEL6r9iMHNHJrFA+h5bDy3MAWvxSfTxXUvk+ZJYEIqnWkJ5lE9yo
 CNklbrFZdkHGDaV8DSxyn6F4fzOjsY+DpdasEAJBE4++m1RoZxpchWJJipg3hBm3x9rN
 NwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741702904; x=1742307704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WBo3wvy2+w/OB5OacD6sLsWlB48pJd8fJfMZgkJPMpc=;
 b=ruXcU7Ga1Q8WBOjxcaut5VoxqWD/LNn38R7eGYSKDJvMpUYL3OiTApLSs65+assrNt
 0dGAvOIPi2tXjt2DlQK+j+uF9RDaW0Eladk+SqwrbS5I6zhOHPdse2MBMSBP9CqZ2iJ6
 EmgubsgNIQppc+AAsWIrBHCIEVTskvNMmf7zCOy/mYdvnTcdjV+LhB59nCFcpUeHgcWX
 UeWCSeu7TqdB6zY2Fh+iVeEzkQTuJNEu9qzMzsC1pm4VKBYIM5URzHKB8u2MiTxyQ1Uj
 3EV/kjMqPMQxmbqBbe1sVHqSGMg3jIOxb6Kiky5ZFznPgIUrRAeIPp4JMdkahZ6lMxmR
 SVrQ==
X-Gm-Message-State: AOJu0Yxh/wZ0Gf1HktQT/VfZPC/MKNKlfkBNOnGuC50povuAMmP5h9sM
 xI2I+5lGc3MZJnc/UHcrldIBSpWiQdEZZZP8JB5r8Ol5v1BslBpB9y8UgwPO1GMGNpqVfyEY9eL
 TxB4suIFuHZc+K4x8gABJ7M+QlAN8ZdnVnbLaaw==
X-Gm-Gg: ASbGncv/HgWXw27tJs9I9k9/XVzFojLHRmgfFlQiEQFd3RiXv42yRgiazuHaTPP7xZl
 mmQki3OppgYQ9MnMw0mFkGSVC2BlnFScFbcUoSGJHVLQebM7HVE+Cyv/m9ukZyBoBNNGUG9e6AX
 lgvHanlsrCZlnHo83yVPR9gUXIkrs=
X-Google-Smtp-Source: AGHT+IFy/z+Ag/0bnFOhk6LRKl59rgycxcrKVZ83SaemkZwiB8uT6JsHqX2ZEHnGaaSnyjO68TQmpJCHYVkvvrEqrXM=
X-Received: by 2002:a05:6902:2002:b0:e5d:aeb7:6e62 with SMTP id
 3f1490d57ef6-e63b51589a0mr4430270276.7.1741702904444; Tue, 11 Mar 2025
 07:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
 <20250304152510.2832340-7-jerome.forissier@linaro.org>
In-Reply-To: <20250304152510.2832340-7-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 16:21:07 +0200
X-Gm-Features: AQ5f1JrstAski7Dv7pMzsnpE-ev6T9X32bmo-fQz5jCLLy-7xLDr29t9xoZKTY4
Message-ID: <CAC_iWjKE+hrx9Y_GaV59T3Zea8OkcoR+gfybadWkVRYUjuMNzw@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] uthread: add cooperative multi-tasking interface
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
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

On Tue, 4 Mar 2025 at 17:31, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add a new internal API called uthread (Kconfig symbol: UTHREAD) which
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
>  doc/api/index.rst   |   1 +
>  doc/api/uthread.rst |   7 +++
>  include/uthread.h   | 123 +++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig         |  21 +++++++
>  lib/Makefile        |   2 +
>  lib/uthread.c       | 139 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 293 insertions(+)
>  create mode 100644 doc/api/uthread.rst
>  create mode 100644 include/uthread.h
>  create mode 100644 lib/uthread.c
>
> diff --git a/doc/api/index.rst b/doc/api/index.rst
> index 0dc9ad45d41..506843ed74a 100644
> --- a/doc/api/index.rst
> +++ b/doc/api/index.rst
> @@ -29,3 +29,4 @@ U-Boot API documentation
>     sysreset
>     timer
>     unicode
> +   uthread
> diff --git a/doc/api/uthread.rst b/doc/api/uthread.rst
> new file mode 100644
> index 00000000000..21233ff6b22
> --- /dev/null
> +++ b/doc/api/uthread.rst
> @@ -0,0 +1,7 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Uthread API
> +===========
> +
> +.. kernel-doc:: include/uthread.h
> +   :internal:
> diff --git a/include/uthread.h b/include/uthread.h
> new file mode 100644
> index 00000000000..ec3034c097a
> --- /dev/null
> +++ b/include/uthread.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 Linaro Limited
> + */
> +
> +#include <linux/list.h>
> +#include <linux/types.h>
> +#include <setjmp.h>
> +
> +#ifndef _UTHREAD_H_
> +#define _UTHREAD_H_
> +
> +/**
> + * DOC: Overview
> + *
> + * The uthread framework is a basic task scheduler that allows to run functions
> + * "in parallel" on a single CPU core. The scheduling is cooperative, not
> + * preemptive -- meaning that context switches from one task to another task is
> + * voluntary, via a call to uthread_schedule(). This characteristic makes thread
> + * synchronization much easier, because a thread cannot be interrupted in the
> + * middle of a critical section (reading from or writing to shared state, for
> + * instance).
> + *
> + * CONFIG_UTHREAD in lib/Kconfig enables the uthread framework. When disabled,
> + * the uthread_create()  and uthread_schedule() functions may still be used so
> + * that code differences between uthreads enabled and disabled can be reduced to
> + * a minimum.
> + */
> +
> +/**
> + * struct uthread - a thread object
> + *
> + * @fn: thread entry point
> + * @arg: argument passed to the entry point when the thread is started
> + * @ctx: context to resume execution of this thread (via longjmp())
> + * @stack: initial stack pointer for the thread
> + * @done: true once @fn has returned, false otherwise
> + * @grp_id: user-supplied identifier for this thread and possibly others. A
> + * thread can belong to zero or one group (not more), and a group may contain
> + * any number of threads.
> + * @list: link in the global scheduler list
> + */
> +struct uthread {
> +       void (*fn)(void *);
> +       void *arg;
> +       jmp_buf ctx;
> +       void *stack;
> +       bool done;
> +       unsigned int grp_id;
> +       struct list_head list;
> +};
> +
> +#ifdef CONFIG_UTHREAD
> +
> +/**
> + * uthread_create() - Create a uthread object and make it ready for execution
> + *
> + * Threads are automatically deleted when they return from their entry point.
> + *
> + * @uthr: a pointer to a user-allocated uthread structure to store information
> + * about the new thread, or NULL to let the framework allocate and manage its
> + * own structure.
> + * @fn: the thread's entry point
> + * @arg: argument passed to the thread's entry point
> + * @stack_sz: stack size for the new thread (in bytes). The stack is allocated
> + * on the heap.
> + * @grp_id: an optional thread group ID that the new thread should belong to
> + * (zero for no group)
> + */
> +int uthread_create(struct uthread *uthr, void (*fn)(void *), void *arg,
> +                  size_t stack_sz, unsigned int grp_id);
> +/**
> + * uthread_schedule() - yield the CPU to the next runnable thread
> + *
> + * This function is called either by the main thread or any secondary thread
> + * (that is, any thread created via uthread_create()) to switch execution to
> + * the next runnable thread.
> + *
> + * Return: true if a thread was scheduled, false if no runnable thread was found
> + */
> +bool uthread_schedule(void);
> +/**
> + * uthread_grp_new_id() - return a new ID for a thread group
> + *
> + * Return: the new thread group ID
> + */
> +unsigned int uthread_grp_new_id(void);
> +/**
> + * uthread_grp_done() - test if all threads in a group are done
> + *
> + * @grp_id: the ID of the thread group that should be considered
> + * Return: false if the group contains at least one runnable thread (i.e., one
> + * thread which entry point has not returned yet), true otherwise
> + */
> +bool uthread_grp_done(unsigned int grp_id);
> +
> +#else
> +
> +static inline int uthread_create(struct uthread *uthr, void (*fn)(void *),
> +                                void *arg, size_t stack_sz,
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
> index 1a683dea670..8321f20e154 100644
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
> +         The default stack size for uthreads. Each uthread has its own stack.
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
> index 00000000000..3cb25784556
> --- /dev/null
> +++ b/lib/uthread.c
> @@ -0,0 +1,139 @@
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
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <malloc.h>
> +#include <setjmp.h>
> +#include <stdint.h>
> +#include <uthread.h>
> +
> +static struct uthread main_thread = {
> +       .list = LIST_HEAD_INIT(main_thread.list),
> +};
> +
> +static struct uthread *current = &main_thread;
> +
> +/**
> + * uthread_trampoline() - Call the current thread's entry point then resume the
> + * main thread.
> + *
> + * This is a helper function which is used as the @func argument to the
> + * initjmp() function, and ultimately invoked via setjmp(). It does not return
> + * but instead longjmp()'s back to the main thread.
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
> +int uthread_create(struct uthread *uthr, void (*fn)(void *), void *arg,
> +                  size_t stack_sz, unsigned int grp_id)
> +{
> +       bool user_allocated = false;
> +
> +       if (!stack_sz)
> +               stack_sz = CONFIG_UTHREAD_STACK_SIZE;
> +
> +       if (uthr) {
> +               user_allocated = true;
> +       } else {
> +               uthr = calloc(1, sizeof(*uthr));
> +               if (!uthr)
> +                       return -1;
> +       }
> +
> +       uthr->stack = memalign(16, stack_sz);
> +       if (!uthr->stack)
> +               goto err;
> +
> +       uthr->fn = fn;
> +       uthr->arg = arg;
> +       uthr->grp_id = grp_id;
> +
> +       list_add_tail(&uthr->list, &current->list);
> +
> +       initjmp(uthr->ctx, uthread_trampoline, uthr->stack + stack_sz);
> +
> +       return 0;
> +err:
> +       if (!user_allocated)
> +               free(uthr);
> +       return -1;
> +}
> +
> +/**
> + * uthread_resume() - switch execution to a given thread
> + *
> + * @uthread: the thread object that should be resumed
> + */
> +static void uthread_resume(struct uthread *uthread)
> +{
> +       if (!setjmp(current->ctx)) {
> +               current = uthread;
> +               longjmp(uthread->ctx, 1);
> +       }
> +}
> +
> +bool uthread_schedule(void)
> +{
> +       struct uthread *next;
> +       struct uthread *tmp;
> +
> +       list_for_each_entry_safe(next, tmp, &current->list, list) {
> +               if (!next->done) {
> +                       uthread_resume(next);
> +                       return true;
> +               } else {
> +                       /* Found a 'done' thread, free its resources */
> +                       list_del(&next->list);
> +                       uthread_free(next);
> +               }
> +       }
> +       return false;
> +}
> +
> +unsigned int uthread_grp_new_id(void)
> +{
> +       static unsigned int id = 0;
> +
> +       return ++id;
> +}
> +
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
