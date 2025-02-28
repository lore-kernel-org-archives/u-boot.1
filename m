Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF2CC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F6E781100;
	Fri, 28 Feb 2025 14:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rOR1QNEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3EE811E0; Fri, 28 Feb 2025 14:21:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A777C81113
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740748872; x=1741353672; i=xypron.glpk@gmx.de;
 bh=MyQlpYGZ8SM8N13sRcxVrZW31vBrkyHyBjrnty/rIe0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rOR1QNEVqqpGbv34cYeO5HENltGqbM97FAHsLY5QA2p9dpNGk09AfE5WjgxP0dQh
 K5eeCaTz/fbz4qYZtmCyNEnLhI05hjoon4U5pBa7GIG3ih/i598p0H05Z4VK07IYy
 5A7CRRecNhAM6O4BCq3SqdTIdxv6rqry5zVw3UBBHxEkht/jaRzuIzHI2W5olKWAc
 fZs91DgxA9aYPmLX9SZ8JN8hL3DxhKWaMmCx01VsYWWXkqa6wQJ3xI8E/+vS2hGXM
 zG/A7wSqflJ2cw2m7VUHKZHgPxpvBQYOtHHh/kuIAOID6NQQMpr18QwBV5nKV5dSM
 xeSkVDZVcpBPewkz5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCOK-1tbxb940hA-00RkLf; Fri, 28
 Feb 2025 14:21:12 +0100
Message-ID: <e5b1a22c-a51b-4c9c-b653-3170a04bb165@gmx.de>
Date: Fri, 28 Feb 2025 14:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] uthread: add cooperative multi-tasking interface
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Raymond Mao
 <raymond.mao@linaro.org>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <0b793a3251dbd9cf41066e3e358269fdb1aac3f8.1740499185.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <0b793a3251dbd9cf41066e3e358269fdb1aac3f8.1740499185.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1egBUAv3EppeaDWYim0hyKBO1QMfyxpcBxZI7qo0WP2c5cTnJX8
 wUzpLlfIQUmwf4GZ0wM/K8jNbftcJ2G4aeW8JTEr4ePWFZx4fLthm7gixsNqPolxtqmSB8k
 yA9aECO/IDTLsXbjY+jk6qW7bfB2RHqHMpFkeUQ6zFXSwXhCEOMjuZ9urBDw0hyovAr6cwH
 Xm1BHZGr5wyMjncyr5qmg==
UI-OutboundReport: notjunk:1;M01:P0:pAhpl1WeJzI=;xAb6uQoPCr71vMsek8PkcMBmyYV
 7il8jwRDzi01rqwVEpnO6BMlxD5KLrfkyBjw2dGQpRVWZ8aznWQs2JWDEGulJXMbm0NrPr10P
 QFQhr7X5Ih3RuDPSMK79Ombsn/ZM9ATcyB1VMBlQgu4kdCvs9gUUHWiqwwVnWgZTjxZidQ+wP
 VfHTasIeL9TEdGSZxYRL6AuJgtLsbYsUIvxAtK6CUsoxMA/8h0yqWnS09bpE35BEFmFHZw3ol
 PGRb5juTpoQe1FxmrBmFLDDDi2xHyZCw79Znh81L60gCqqPHlfh8nzePBQGYtarMKQkE6wSB+
 p7z37wzREYSVKythbHVChErH8t8hduVEWV2XfO92LkyXjNWYo3zv8Zki4STGQ/pvp+PMLUiGG
 oBADGNVkvP+P7Rjt+m7zL9RRtqhncnSfV6E0batB2+tmmMOIXg33udzE27K4uhq5PQBSVm6Py
 iTQc7oM751WMXCBWX3hXbY9fj0q4+XRY1BdjBQdVDy6xK2jYjskK5KqC2mFPFb2MYn5ELQYQs
 k6vXaX/3M/SI+uyw72RL9jtxjT0QBm6e2ZmWFiQB7x8IxTh+b7XxOme7oL9BSpD93uM8g6vyv
 5UUKKUHtg+IyfdiDCxKTWSHtfPqBzQCuhr1ahD95HXJhfFZ6zjMml5kiUa7rE3Hh8MtnDsYtE
 4N1ysbHhn/Sos/TmLauFgZfA7686RJKZxgki0QnwByRGvlJUuteD9Pv7FQCOnnM3UE787bYkW
 ZteVHKYXDH/KZR8VfQykDA/3a8zSxDF24jbI6Mx6FdlhxRu0/IVauq2wVS7heLGxaMGfP89Ku
 EBrex0i95XtD66+hIbNeNFo0VcVityG9otc4bZ0/R9jhksXZv4M+bM4GsU8XPQLb/OX8zQr9v
 YJ5oUTuSe7CudNgfNbwIH4xrGSSOI1EpUbrmJpxNCxrtWbNOJRhl3T95dYSE2nFWj5SnmAFfW
 GCw5QYsmcph+joaqM+rxklVJ0ydrnsBWI+54Z2M+EXy395YLEIePSOpcpcUUNk5Fvuc/bJjdB
 LQwUJZjQ7FOTtLIN9XPxm+0Y+Z+6rcY1IBPGfZgHgXUSFM6s3200WSxFVbOAjrqNTkPh5G5p0
 166oALUlEFkiTnBCjSjiDN4jCF54lrFQ4NHy/dTBReWheXw3QM6X//4wCBC7De+MZkMKt8t+z
 G8hOywiGO8ANkKvpZpDxlBeEYvzAuXaie1+/b7ij875j82lhJiyVg+PSm5cXKVH+/i7AMuOUQ
 fajpErTe6CQ1FXMvjPEc6jPbfPsUu7ciAN2pEqbc/mSfi7c+V/Ua0AcGBwlp8ucrHaq6sgsgh
 SWMgOPHQErG2YPChvRU/E1GhdXc2TxaQfWZ8dtvbLpM/LjwXXNwYJcTcpagm2zZzlxVFZRFxr
 bK3LjHTYrPKnCgZkAEueGLUTQ0qUm7A9d/PO5k4UMJcjpQIr1M4tV21tdR8icPg6AMA4koejt
 dLMlFZI0HABuXzx9hhb4PmWtS9ImlYSFWRMYNSt1cqGzG1KIl
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

On 25.02.25 17:34, Jerome Forissier wrote:
> Add an new internal API called uthread (Kconfig symbol: UTHREAD) which

nits:

%s/an/a/

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
>   include/uthread.h |  44 ++++++++++++
>   lib/Kconfig       |  21 ++++++
>   lib/Makefile      |   2 +
>   lib/uthread.c     | 178 ++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 245 insertions(+)
>   create mode 100644 include/uthread.h
>   create mode 100644 lib/uthread.c
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
> +		   unsigned int grp_id);

Every function needs a Shinx style documentation.

> +bool uthread_schedule(void);
> +unsigned int uthread_grp_new_id(void);
> +bool uthread_grp_done(unsigned int grp_id);
> +
> +#else
> +
> +static inline int uthread_create(void (*fn)(void *), void *arg, size_t =
stack_sz,
> +				 unsigned int grp_id)
> +{
> +	fn(arg);
> +	return 0;
> +}
> +
> +static inline bool uthread_schedule(void)
> +{
> +	return false;
> +}
> +
> +static inline unsigned int uthread_grp_new_id(void)
> +{
> +	return 0;
> +}
> +
> +static inline bool uthread_grp_done(unsigned int grp_id)
> +{
> +	return true;
> +}
> +
> +#endif /* CONFIG_UTHREAD */
> +#endif /* _UTHREAD_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1a683dea670..b32740ecbcc 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1255,6 +1255,27 @@ config PHANDLE_CHECK_SEQ
>   	  enable this config option to distinguish them using
>   	  phandles in fdtdec_get_alias_seq() function.
>
> +config UTHREAD
> +	bool "Enable thread support"
> +	depends on HAVE_INITJMP
> +	help
> +	  Implement a simple form of cooperative multi-tasking based on
> +	  context-switching via initjmp(), setjmp() and longjmp(). The
> +	  uthread_ interface enables the main thread of execution to create
> +	  one or more secondary threads and schedule them until they all have
> +	  returned. At any point a thread may suspend its execution and
> +	  schedule another thread, which allows for the efficient multiplexing
> +	  of leghthy operations.
> +
> +config UTHREAD_STACK_SIZE
> +	int "Default uthread stack size"
> +	depends on UTHREAD
> +	default 32768
> +	help
> +	  The default stak size for uthreads. Each uthread has its own stack.
> +	  When the stack_sz argument to uthread_create() is zero then this
> +	  value is used.
> +
>   endmenu
>
>   source "lib/fwu_updates/Kconfig"
> diff --git a/lib/Makefile b/lib/Makefile
> index a7bc2f3134a..3610694de7a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -164,6 +164,8 @@ obj-$(CONFIG_LIB_ELF) +=3D elf.o
>
>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) +=3D semihosting.o
>
> +obj-$(CONFIG_UTHREAD) +=3D uthread.o
> +
>   #
>   # Build a fast OID lookup registry from include/linux/oid_registry.h
>   #
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
> + * An implementation of cooperative multi-tasking inspired from barebox=
 threads
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
> +	void (*fn)(void *);
> +	void *arg;
> +	jmp_buf ctx;
> +	void *stack;
> +	bool done;
> +	unsigned int grp_id;
> +	struct list_head list;

The structure and all its components need to be documented.

> +} main_thread =3D {
> +	.list =3D LIST_HEAD_INIT(main_thread.list),
> +};
> +
> +static struct uthread *current =3D &main_thread;
> +
> +/**
> + * uthread_trampoline() - Call the current thread's entry point then re=
sume the
> + * main thread.
> + *
> + * This is a helper function which is used as the @func argument to the=
 inijmp()
> + * function, and ultimately invoked via setjmp(). It does not return, b=
ut
> + * instead longjmp()'s back to the main thread.
> + */
> +static void __noreturn uthread_trampoline(void)
> +{
> +	struct uthread *curr =3D current;
> +
> +	curr->fn(curr->arg);
> +	curr->done =3D true;
> +	current =3D &main_thread;
> +	longjmp(current->ctx, 1);
> +	/* Not reached */
> +	while (true)
> +		;
> +}
> +
> +/**
> + * uthread_free() - Free memory used by a uthread object.
> + */
> +static void uthread_free(struct uthread *uthread)
> +{
> +	if (!uthread)
> +		return;
> +	free(uthread->stack);
> +	free(uthread);
> +}
> +
> +/**
> + * uthread_create() - Create a uthread object and make it ready for exe=
cution
> + *
> + * Threads are automatically deleted when then return from their entry =
point.
> + *
> + * @fn: the thread's entry point
> + * @arg: argument passed to the thread's entry point
> + * @stack_sz: stack size for the new thread (in bytes). The stack is al=
located
> + * on the heap.
> + * @grp_id: an optional thread group ID that the new thread should belo=
ng to
> + * (zero for no group)
> + */

This documentation should be move to the include and the include needs
to be added to doc/api/.

> +int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz,
> +		   unsigned int grp_id)

We should model the functions more like pthreads.

Let the caller provide struct uthread(). This will allow us to implement
pthread_cancel() and phthread_join().

Best regards

Heinrich

> +{
> +	struct uthread *uthread;
> +
> +	if (!stack_sz)
> +		stack_sz =3D CONFIG_UTHREAD_STACK_SIZE;
> +
> +	uthread =3D calloc(1, sizeof(*uthread));
> +	if (!uthread)
> +		return -1;
> +
> +	uthread->stack =3D memalign(16, stack_sz);
> +	if (!uthread->stack)
> +		goto err;
> +
> +	uthread->fn =3D fn;
> +	uthread->arg =3D arg;
> +	uthread->grp_id =3D grp_id;
> +
> +	list_add_tail(&uthread->list, &current->list);
> +
> +	initjmp(uthread->ctx, uthread_trampoline, uthread->stack + stack_sz);
> +
> +	return 0;
> +err:
> +	uthread_free(uthread);
> +	return -1;
> +}
> +
> +/**
> + * uthread_resume() - switch execution to a given thread
> + *
> + * @uthread: the thread object that should be resumed
> + */
> +static void uthread_resume(struct uthread *uthread)
> +{
> +	if (!setjmp(current->ctx)) {
> +		current =3D uthread;
> +		longjmp(uthread->ctx, 1);
> +	}
> +}
> +
> +/**
> + * uthread_schedule() - yield the CPU to the next runnable thread
> + *
> + * This function is called either by the main thread or any secondary t=
hread
> + * (that is, any thread created via uthread_create()) to switch executi=
on to
> + * the next runnable thread.
> + *
> + * Return: true if a thread was scheduled, false if no runnable thread =
was found
> + */
> +bool uthread_schedule(void)
> +{
> +	struct uthread *next;
> +	struct uthread *tmp;
> +
> +	if (list_empty(&current->list))
> +	    return false;
> +
> +	list_for_each_entry_safe(next, tmp, &current->list, list) {
> +		if (!next->done) {
> +			uthread_resume(next);
> +			return true;
> +		} else {
> +			/* Found a 'done' thread, free its resources */
> +			list_del(&next->list);
> +			uthread_free(next);
> +		}
> +	}
> +	return false;
> +}
> +
> +/**
> + * uthread_grp_new_id() - return a new ID for a thread group
> + *
> + * Return: the new thread group ID
> + */
> +unsigned int uthread_grp_new_id(void)
> +{
> +	static unsigned int id =3D 0;
> +
> +	return ++id;
> +}
> +
> +/**
> + * uthread_grp_done() - test if all threads in a group are done
> + *
> + * @grp: the ID of the thread group that should be considered
> + * Return: false if the group contains at least one runnable thread (i.=
e., one
> + * thread which entry point has not returned yet), true otherwise
> + */
> +bool uthread_grp_done(unsigned int grp_id)
> +{
> +	struct uthread *next;
> +
> +	list_for_each_entry(next, &main_thread.list, list) {
> +		if (next->grp_id =3D=3D grp_id && !next->done)
> +			return false;
> +	}
> +
> +	return true;
> +}

