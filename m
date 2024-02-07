Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF850C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 10:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE7187CEA;
	Wed,  7 Feb 2024 11:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="i8tD4pvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BAE87CF6; Wed,  7 Feb 2024 11:10:51 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98433878E2
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 11:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d0a0e40672so4398491fa.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707300649; x=1707905449; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuqDReu/h48FqaZAJ5gWRQ3JLtYvpvYc3P2aREsiXGQ=;
 b=i8tD4pvdTSSh2qUmRFUe2yO3IJv58wIsTJgY34y7X7IlVFq/x5ptPfz6S0f1DzXmsL
 KBFrc0JOzeUqjDlP8J8/xBAtRuC0VVadZxBC+ubTdxh6iOdkMuoOoBg3vNz7hYfAXN/h
 GJClq06a1iXC0YpNdEwgM5BARcCdkOAYOcMLazvDcYggJoDr5p8kY+zxgpoQ7pvQfaki
 sEPml0SYV8+7W4d2L4ThGQyEuHmw2VU2fRQIGl3ne2NE6+VeXIvNKnom33OkHWfywGfK
 KPUQtNCPJVLZ94rNL+murTNVORtYkL/4O1KT0+f0l2yyL7BNyPfX3tZKFPqkZIQAY9uo
 oKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707300649; x=1707905449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FuqDReu/h48FqaZAJ5gWRQ3JLtYvpvYc3P2aREsiXGQ=;
 b=ij7DpNyQV88/805EcZm5gwl5+haxyr9frYrHjrE62SZhIClrmvpa3t5HpJ/KumwasP
 iOkF7v1sCItTsMLdcOZ5ZMxrV1x5CNtMwMRMK70EUCThgMatc2RHlIeUJI7vlbAECBR/
 Nkv31jg1hKui+ToNb5wEvXQ8UootaWdUjz9UcoCb7vk3Y4OxjUQ6D6taNDw/TH/oznQI
 9cOaU12VCuNCqFMUTZCMT6vyLU+yORpOL09Ezk8Ku4tuzkENB8pioAM9pT2E0V2Fxk+w
 O1CmjB5R9g86QTJkBxU3Fi7VjeTKWfUigyzOc+NUUrZovu13dI2u0azKDMDRQ2txssi3
 4fCA==
X-Gm-Message-State: AOJu0YwgJaiZLwDKqEPp5v8GHpGRo8ET/l1AcqhwacMQgw0Tc4Rc561c
 u6Mqu7qjvIKs9LZu6Vyi7+oSTAHbSLVNwQOweaOrx1AnEGZJ20tZzBAP7knMnIfQav3FtSULZzu
 8li7WjR4Kp4cYNAF1ZJj8/iuXH+vqBit7aWGtYSezuQ4nvCMlnqc=
X-Google-Smtp-Source: AGHT+IEaX/0SwzgVD+YQbNMD7DYt1vuD96hym+U4/MyMZs81j+w2qxpt4+RHirPL8U4NFexfS1UjHxkMWkp2Oe6rr3s=
X-Received: by 2002:a2e:95d3:0:b0:2d0:af6e:5cb4 with SMTP id
 y19-20020a2e95d3000000b002d0af6e5cb4mr1931902ljh.16.1707300648895; Wed, 07
 Feb 2024 02:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20240202002448.1116407-1-afd@ti.com>
 <20240202002448.1116407-2-afd@ti.com>
In-Reply-To: <20240202002448.1116407-2-afd@ti.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Wed, 7 Feb 2024 11:10:37 +0100
Message-ID: <CAL6CDMHMJWkVv9J1BjeGhATtjRPzk6BRZg8SCBMPMjWOsBgJQw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm: mach-k3: Move disable_linefill_optimization()
 into R5 directory
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Andrew,

On Fri, Feb 2, 2024 at 1:26=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> The disable_linefill_optimization() function is only ever loaded by the
> R5 core, move the code into the R5 directory.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/common.c    | 25 -------------------------
>  arch/arm/mach-k3/r5/Makefile |  1 +
>  arch/arm/mach-k3/r5/common.c | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 25 deletions(-)
>  create mode 100644 arch/arm/mach-k3/r5/common.c
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index f411366778f..5d53efed85b 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -453,31 +453,6 @@ void board_prep_linux(struct bootm_headers *images)
>  }
>  #endif
>
> -#ifdef CONFIG_CPU_V7R
> -void disable_linefill_optimization(void)
> -{
> -       u32 actlr;
> -
> -       /*
> -        * On K3 devices there are 2 conditions where R5F can deadlock:
> -        * 1.When software is performing series of store operations to
> -        *   cacheable write back/write allocate memory region and later
> -        *   on software execute barrier operation (DSB or DMB). R5F may
> -        *   hang at the barrier instruction.
> -        * 2.When software is performing a mix of load and store operatio=
ns
> -        *   within a tight loop and store operations are all writing to
> -        *   cacheable write back/write allocates memory regions, R5F may
> -        *   hang at one of the load instruction.
> -        *
> -        * To avoid the above two conditions disable linefill optimizatio=
n
> -        * inside Cortex R5F.
> -        */
> -       asm("mrc p15, 0, %0, c1, c0, 1" : "=3Dr" (actlr));
> -       actlr |=3D (1 << 13); /* Set DLFO bit  */
> -       asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
> -}
> -#endif
> -
>  static void remove_fwl_regions(struct fwl_data fwl_data, size_t num_regi=
ons,
>                                enum k3_firewall_region_type fwl_type)
>  {
> diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
> index b99199d3374..8ad86eb2798 100644
> --- a/arch/arm/mach-k3/r5/Makefile
> +++ b/arch/arm/mach-k3/r5/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_K3_J721S2) +=3D j721s2/
>  obj-$(CONFIG_SOC_K3_AM625) +=3D am62x/
>  obj-$(CONFIG_SOC_K3_AM62A7) +=3D am62ax/
>
> +obj-y +=3D common.o
>  obj-y +=3D lowlevel_init.o
>  obj-y +=3D r5_mpu.o
>
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> new file mode 100644
> index 00000000000..ef81f50c6c7
> --- /dev/null
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * K3: R5 Common Architecture initialization
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +#include <linux/types.h>
> +#include <asm/hardware.h>
> +#include <asm/io.h>
> +
> +#include "../common.h"
> +
> +void disable_linefill_optimization(void)
> +{
> +       u32 actlr;
> +
> +       /*
> +        * On K3 devices there are 2 conditions where R5F can deadlock:
> +        * 1.When software is performing series of store operations to
> +        *   cacheable write back/write allocate memory region and later
> +        *   on software execute barrier operation (DSB or DMB). R5F may
> +        *   hang at the barrier instruction.
> +        * 2.When software is performing a mix of load and store operatio=
ns
> +        *   within a tight loop and store operations are all writing to
> +        *   cacheable write back/write allocates memory regions, R5F may
> +        *   hang at one of the load instruction.
> +        *
> +        * To avoid the above two conditions disable linefill optimizatio=
n
> +        * inside Cortex R5F.
> +        */
> +       asm("mrc p15, 0, %0, c1, c0, 1" : "=3Dr" (actlr));
> +       actlr |=3D (1 << 13); /* Set DLFO bit  */
> +       asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
> +}
> --
> 2.39.2
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
