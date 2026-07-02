Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F25C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1ED8849AC;
	Thu,  2 Jul 2026 12:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UKcHkmSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9600A849B1; Thu,  2 Jul 2026 12:25:54 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933CB84987
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so1306561a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782987952; cv=none;
 d=google.com; s=arc-20260327;
 b=K/FMER4G01IBcdjinBBfpHeu1v/8VS6qrPg2YFBRmNgHLct+1bURppjlwPqFzU5k3p
 vW3ZkbS7Nm8OUCHYGs79zWfIUw1XCZQzNw3nrb7w3RV7Lj3k+0+kVPOV6JuNUatEfZqo
 GoC6UjYs479UkGYU8AZ4SvqmF8Fr/wKhJ8kjeQxy0B8omZmL4SJEa0e/0NtLoIPijtXY
 RawvFguFXgm2LZuEODRaSIS2/96DImcM5/JuZEEPUC2XbcrPIAQGViZfteBdPDY+hUam
 rkDdXa+VxEAQx/pzSxUr9wayuuRgrn4XzEwsKBBlTzLQO4Qy6GiWA3JSqAGJvPZpbYqE
 VJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P6NmeaqQC7GcpyQrhGDPBwvgdqHryPw7YXG74uotkhY=;
 fh=0QEfosCPx3otTY3mplChiH+h0mnPXmsrtfAPHD8uy/M=;
 b=sRTLjJJMB0Y2TqHRSOw0ZByoKYEaGss3shM7pa9ADlS8j6nkQayXdIHi6bUbl/rlzk
 vYHN5WJZDITRMyWCZUk/YPBtkQDS4dqnc2sThfCf2g2LAAggtr1zT7CSL3o4Xz+T0dzD
 J5RVUbR/ecUNv8N8IN5/y4oNt6ZDCCJf+m3NdP8iqGy2yAZYgMthIsmpU1nDisuKZiVb
 byZMYMyIO5H+0ne2YHmgkBCPP+qP6Z33dY3dFy+Vwe4hhozxcIVO45Dm+z5BqugXTT+X
 Z2yu7SaJDmvcKnkxobcFqbdU347eACQ6Qvm8GuRlUURSQgnlOjlcxbawTNMFmWusGRh7
 pP7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782987952; x=1783592752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P6NmeaqQC7GcpyQrhGDPBwvgdqHryPw7YXG74uotkhY=;
 b=UKcHkmShlX5AETCFrjyzS2R7m98iHw/n1Bmtfj+zCmBSv5hlT3ZiguZ1sbz1x5YiJP
 Y5pK90Jydd7IH8DmixVlimyZO5oBKMPcOufdP+nPZGMqjyGTDRR6zDjMLqtZmYTlDvoX
 zL/ntjpAENcqvzY58Sjglm20gQyPXNMUfoWAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782987952; x=1783592752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6NmeaqQC7GcpyQrhGDPBwvgdqHryPw7YXG74uotkhY=;
 b=SDlYZmIQYPt8Dr8n3oQgf8/cfzDFv72gwF8TMIKEJOTirRBqhNmeyfxDRUCN6zMBT7
 u9gNaCwlc6bgXuW3zBpoZwMm2nSc/Knj7WdD0PrOmdr531UclETf9iMYkVGUXUNslqZL
 UgaYUiksYrL/yC6kpBFEVvsoGQvFmfs0J1aQQdG7GgfWh0lrJSWiHxzfvwTUmkF9CWkG
 E8lVd1yLXgbSomdnOR7qjm5/csgy0Fqp26ZHkVfjBFHTW4XFC59Sh7u1HQA2wEcbmdWc
 DNH6P8W/e/9+LOGZe8rOFb9QX3WoHT8bRbQWhkfRAHQBpsIU6eOy9E1Z5v3ATIlMkVgc
 zYFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5/3uwy4vJh52xVs7TJZOcok50UVX5vD3NdYewiARBI7qLbczfGI5N0aPg+u6YzNOqliqBaao=@lists.denx.de
X-Gm-Message-State: AOJu0YwwjOyZQrpUJem9j6jVCVlUDktrS3nDdD/0ipqqpfrk+yzfhrS4
 FpQweAF74vF+wHnMHQo7xPnjhLD7FBfDFzDnYobSIDDCrOaYp2Fjo8wgpKwJ7xqrcOK5tRypQGo
 zYmmdra5NRYO+8rauBkoFKbu+ttEWRObCRA7I/MMn
X-Gm-Gg: AfdE7cnF7sZPuIdUCHaCDRsmCPeBxqVxCsLYa2tkDWM+kG6IYtUZJWxBxvcf0bTOL8e
 qZmg8e/R8TRF28Fh3KGZf7mmT5g0KOUB6c409gq7/ozC2WS3v78oZK2eB2OeJlMl3XMsQ8iMyxE
 INRyb8E8rlwFOGQ71V94xfL4WCd7eF4UZuV9Hp75LHm35VT3W9hxGK9SL3p6O9FIOgzFFbcwdJN
 Ux324U0+vJVd1NWZ/K1QetUcYNc2VUEjz8rwyrAZH1tC8ujIJtWT77bTyQI0cPSN9oZ95vLxg==
X-Received: by 2002:a05:6402:a292:10b0:698:99bd:8b1 with SMTP id
 4fb4d7f45d1cf-698a2c6d606mr1419292a12.10.1782987951976; Thu, 02 Jul 2026
 03:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-9-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-9-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:25:39 +0100
X-Gm-Features: AVVi8CdIwm48_8LdUUDaicDhjCocYnsh4flJrGpG-Ro3MM9D1J3aEERUnW26b7U
Message-ID: <CAFLszTh8G5hxAOUocaaXffKA=7PM5sp90M3+JBsieG908nFBBw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] LoongArch: CPU assembly routines
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: CPU assembly routines
>
> start.S for initialisation, smp_secondary routine for
> a spin-table like interface for secondary cpus.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/loongarch/cpu/Makefile        |   4 +
>  arch/loongarch/cpu/cpu.c           |  27 ++++++
>  arch/loongarch/cpu/smp_secondary.S |  55 ++++++++++++
>  arch/loongarch/cpu/start.S         | 170 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 256 insertions(+)

> diff --git a/arch/loongarch/cpu/cpu.c b/arch/loongarch/cpu/cpu.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> + */

Good to keep that copyright (if that is where the code was derived)
but you could add your own too.

> diff --git a/arch/loongarch/cpu/cpu.c b/arch/loongarch/cpu/cpu.c
> @@ -0,0 +1,27 @@
> +#include <command.h>
> +#include <cpu.h>
> +#include <cpu_func.h>
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <event.h>
> +#include <hang.h>
> +#include <init.h>
> +#include <log.h>
> +#include <asm/system.h>
> +#include <dm/uclass-internal.h>
> +#include <linux/bitops.h>

Most of these are unused - only printf() and hang() are referenced.
Please prune to the minimum required.

> diff --git a/arch/loongarch/cpu/cpu.c b/arch/loongarch/cpu/cpu.c
> @@ -0,0 +1,27 @@
> +#if !CONFIG_IS_ENABLED(SYSRESET)
> +void reset_cpu(void)
> +{
> +     printf("resetting ...\n");
> +
> +     printf("reset not supported yet\n");
> +     hang();
> +}
> +#endif

Printing 'resetting ...' immediately followed by 'reset not supported
yet' is confusing. Please drop the first message.

> diff --git a/arch/loongarch/cpu/start.S b/arch/loongarch/cpu/start.S
> @@ -0,0 +1,170 @@
> +call_board_init_f_0:
> +     /* find top of reserve space */
> +     PTR_LI          t1, 1
> +     PTR_SLL         t1, t1, CONFIG_STACK_SIZE_SHIFT
> +     PTR_SUB         a0, t0, t1              /* t1 -> size of all CPU stacks */

The comment is misleading - t1 holds a single stack's size, not the
combined size of all CPU stacks. Please match arch/riscv/cpu/start.S
('top of stack of first CPU').

> diff --git a/arch/loongarch/cpu/start.S b/arch/loongarch/cpu/start.S
> @@ -0,0 +1,170 @@
> +     move            a0, zero                /* a0 <-- boot_flags = 0 */
> +     la.pcrel        t5, board_init_f
> +     jirl            ra, t5, 0               /* jump to board_init_f() */
> +
> +     move            sp, s0

s0 is never assigned before this point, so if board_init_f() ever
returned here sp would be zero. Today this is dead code because
jump_to_copy() reaches relocate_code() via a normal C call, but the
instruction is misleading. Please remove it, or if you intend to
mirror the RISC-V flow, add the missing 'move s0, a0' after
board_init_f_alloc_reserve() and a comment explaining what s0 holds.

> diff --git a/arch/loongarch/cpu/start.S b/arch/loongarch/cpu/start.S
> @@ -0,0 +1,170 @@
> +     csrrd           t0, LOONGARCH_CSR_CPUID
> +     andi            t0, t0, CSR_CPUID_COREID
> +     LONG_LI         t1, BOOTCORE_ID
> +     bne                     t1, t0, secondary_core_loop

Stray extra tab after bne

> diff --git a/arch/loongarch/cpu/smp_secondary.S b/arch/loongarch/cpu/smp_secondary.S
> @@ -0,0 +1,55 @@
> +1:
> +     /* Query spin table */
> +     idle 0
> +     nop
> +     iocsrrd.w       t0, t1
> +     beqz            t0, 1b

Is the nop after idle 0 required by the ISA (to guarantee the
wake-up completes before the load) or just padding? A
one-line comment would help.

Regards,
Simon
