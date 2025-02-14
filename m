Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A9C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D358880B98;
	Fri, 14 Feb 2025 15:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SIYWcooC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D4080C6F; Fri, 14 Feb 2025 15:47:12 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C075780756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 32C8A3FE6F
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739544427;
 bh=FRpr0m0XY34PJwdLqt4kiQ7UhiFjr+E5C5NIbA38MWg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SIYWcooCG4L8B8JV29dF2A7GLzodjDZesuIk1MCT7JbHpU8tkLOYID8QU+88CWDLs
 Hqz/711GyaO1xZY+hiCxjfGNBsc85RClqcAHVsod2yjIVkLGNgw2cXX0XBvNCKRytQ
 /txpK5mV9jPeEdsUGo6a96ELqZMK4j9l06LB2+cUn9K1bauYFwVh/V+Sciuu9QCOo/
 bpw9onXxapiuP+uUU6z5Terqj/PNz7kLhiOg3r+QeeB7FaFTVTzcAXPqCrpaF+gM7k
 bfVo+KU53bx5uCU3rBBcdPKIux37Xh2vsY5zyN/iqWyPXqNw+lO4rIYfHNF0EyyJ+g
 8RLxguey48MAQ==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab7e1beaa45so326756166b.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739544427; x=1740149227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FRpr0m0XY34PJwdLqt4kiQ7UhiFjr+E5C5NIbA38MWg=;
 b=YlY+Xm7zLQHKU4L8bdFlguZ5XGz6Z0XSyhmLIuDAStQyJ+4DfCuec5IJzhufHcfie9
 iSeYqz2i71G+2ji+OQ0xo4Jgi11Cz9LmygXVTQZ6BSq3ZhnllM7qzDsMgPmuARyueWxB
 LKOTuBZV2qyXoX2QxvWeXqFYD6s7orleYkffJ0zuWcUbyzc6EC0Id975QvYsdIzo8EfA
 ob0li5wmPuk7vmqTniYKosAzHNWKSsAfQpISydl1zp8m5JkjhDtXo6tbZHxPx4sZ4IYO
 a83LmdO5HwHNpVcU+xQd9yYZcHMtBarV9BdA8i2ia6naBYZVuze4xuZjnKHdPI1JLAkQ
 Y81g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ12p0aISxkSWIHVtG9J89zHmRhzgp+aJVaXH9o+2PrPe0d5BwFWcwtd5EUTcUrBqBJSifdnE=@lists.denx.de
X-Gm-Message-State: AOJu0YwzT3q2tFp2UY/ojPQBs3uDMjsh5NUM17Q1N8/foSApJQpxk0hm
 HSsx/f8pcFVJPNXp7c+Kk6vq//qqJMHuiUuXRu7G5RtrDIODXXEhnqGGCWDVyTQ6UnOniK5G2UQ
 wB9oBDCxNufFagjhyZmIgN2JVgfxXWVaRcHvMfpentEwBOltLmfy4fJpT1O5mNKFd4fg=
X-Gm-Gg: ASbGncslR/7+I/Xyaol3rtq9rjoKdSPmV+jqw3mtjxyjUdyfrAEY7eqNODvKGiOovmN
 Orp+hHi430Oiqqa1RDx9/CEBlw9f8DsGiztV+Tld7FhBIbKJ65N6hX8TRNuQPxY2SDKI9+bEbse
 RgIgFStWYyGo7R1XawaHkg/TBubVhFb8ZpSibAKZrGcE10XJ7mETIAzxdjxeOv7yalsQFwgcYGP
 kUVcjdfcLrBfxzL39yscGqLY2YKZhK2nf9RiQjpIFHagQOfjSfIePO/37Jdsc0lBcrBewHayxZX
 wAtzIZgGVw9b/GP3j4nkAyV7fAMCrfWbr7umAP6LoUai2QkKsjHAFddtM2EwCi5/yMoE
X-Received: by 2002:a17:906:6a0d:b0:ab2:bd0b:acdf with SMTP id
 a640c23a62f3a-ab7f38768bdmr1309087766b.36.1739544426704; 
 Fri, 14 Feb 2025 06:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGHGttPQ88shP+g7JAkk4M1t/6rW0NWFlifPty9qkpCzUplyXd+y2sqrtFxkgLk0TvQTzFuA==
X-Received: by 2002:a17:906:6a0d:b0:ab2:bd0b:acdf with SMTP id
 a640c23a62f3a-ab7f38768bdmr1309082166b.36.1739544425894; 
 Fri, 14 Feb 2025 06:47:05 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:1996:486:9a43:1d02:85b1?
 ([2a02:3035:6e0:1996:486:9a43:1d02:85b1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532322c4sm354777566b.34.2025.02.14.06.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 06:47:05 -0800 (PST)
Message-ID: <57368c2f-3003-4264-a3e6-0c8705b401da@canonical.com>
Date: Fri, 14 Feb 2025 15:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/10] uthread: add cooperative multi-tasking interface
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Raymond Mao
 <raymond.mao@linaro.org>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-7-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250214140031.484344-7-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 14.02.25 15:00, Jerome Forissier wrote:
> Add an new internal API called uthread (Kconfig symbol: UTHREAD) which
> provides cooperative multi-tasking. The goal is to be able to improve
> the performance of some parts of U-Boot by overlapping lengthy
> operations. Each uthread has its own stack allocated on the heap. The
> default stack size is defined by the UTHREAD_STACK_SIZE symbol and is
> used when uthread_create() is passed zero for the stack_sz argument.
> 
> The implementation is based on context-switching via initjmp()/setjmp()/
> longjmp() and is inspired from barebox threads [1].
> 
> [1] https://github.com/barebox/barebox/blob/master/common/bthread.c
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   include/uthread.h |  31 ++++++++++++++
>   lib/Kconfig       |  19 ++++++++
>   lib/Makefile      |   2 +
>   lib/uthread.c     | 107 ++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 159 insertions(+)
>   create mode 100644 include/uthread.h
>   create mode 100644 lib/uthread.c
> 
> diff --git a/include/uthread.h b/include/uthread.h
> new file mode 100644
> index 00000000000..ea1389e82c6
> --- /dev/null
> +++ b/include/uthread.h
> @@ -0,0 +1,31 @@
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
> +int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz);
> +void uthread_free_all(void);
> +/* Returns false when all threads are done */
> +bool uthread_schedule(void);
> +
> +#else
> +
> +static inline int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz)
> +{
> +	fn(arg);
> +	return 0;
> +}
> +
> +static inline void uthread_free_all(void) { }
> +
> +static inline bool uthread_schedule(void) { return false; }
> +
> +#endif /* CONFIG_UTHREAD */
> +#endif /* _UTHREAD_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1a683dea670..c3416bbd0be 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1255,6 +1255,25 @@ config PHANDLE_CHECK_SEQ
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
> +	default 32168
> +	help
> +	  The default stask size for uthreads. Each uthread has its own stack.
> +
>   endmenu
>   
>   source "lib/fwu_updates/Kconfig"
> diff --git a/lib/Makefile b/lib/Makefile
> index a7bc2f3134a..3610694de7a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -164,6 +164,8 @@ obj-$(CONFIG_LIB_ELF) += elf.o
>   
>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += semihosting.o
>   
> +obj-$(CONFIG_UTHREAD) += uthread.o
> +
>   #
>   # Build a fast OID lookup registry from include/linux/oid_registry.h
>   #
> diff --git a/lib/uthread.c b/lib/uthread.c
> new file mode 100644
> index 00000000000..bb132001fb6
> --- /dev/null
> +++ b/lib/uthread.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (C) 2021 Ahmad Fatoum, Pengutronix
> +// Copyright (C) 2025 Linaro Limited
> +//
> +// An implementation of cooperative multi-tasking inspired from barebox threads
> +// https://github.com/barebox/barebox/blob/master/common/bthread.c
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
> +	struct list_head list;
> +} main_thread = {
> +	.list = LIST_HEAD_INIT(main_thread.list),
> +};
> +
> +static struct uthread *current = &main_thread;
> +
> +static void __noreturn uthread_trampoline(void)
> +{
> +	current->fn(current->arg);
> +	current->done = true;
> +	current = &main_thread;
> +	longjmp(current->ctx, 1);
> +	/* Not reached */
> +	while (true)
> +		;
> +}
> +
> +static void uthread_free(struct uthread *uthread)
> +{
> +	if (!uthread)
> +		return;
> +	free(uthread->stack);
> +	free(uthread);
> +}
> +
> +int uthread_create(void (*fn)(void *), void *arg, size_t stack_sz)
> +{
> +	struct uthread *uthread;
> +
> +	if (!stack_sz)
> +		stack_sz = CONFIG_UTHREAD_STACK_SIZE;
> +
> +	uthread = calloc(1, sizeof(*uthread));
> +	if (!uthread)
> +		return -1;
> +
> +	uthread->stack = memalign(16, stack_sz);
> +	if (!uthread->stack)
> +		goto err;
> +
> +	uthread->fn = fn;
> +	uthread->arg = arg;
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
> +void uthread_free_all(void)
> +{
> +	struct uthread *next;
> +	struct uthread *tmp;
> +
> +	list_for_each_entry_safe(next, tmp, &current->list, list) {
> +		list_del(&next->list);
> +		uthread_free(next);
> +	}
> +}
> +

For every function, please, create a Sphinx style documentation.

For the whole uthread library, please, create a document in 
/doc/develop/ explaining how to use the API functions.

Best regards

Heinrich

> +static void uthread_resume(struct uthread *uthread)
> +{
> +	if (!setjmp(current->ctx)) {
> +		current = uthread;
> +		longjmp(uthread->ctx, 1);
> +	}
> +}
> +
> +bool uthread_schedule(void)
> +{
> +	struct uthread *next;
> +
> +	list_for_each_entry(next, &current->list, list) {
> +		if (!next->done) {
> +			uthread_resume(next);
> +			return true;
> +		}
> +	}
> +	return false;
> +}

