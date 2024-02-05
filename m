Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD159C48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 09:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133F08771B;
	Mon,  5 Feb 2024 10:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hSbPFehE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3902A8777F; Mon,  5 Feb 2024 10:36:57 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8F28770F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 10:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-59a87156cb8so1825714eaf.2
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707125813; x=1707730613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4vkgxFgHIQnIhUAvoyDJL4wEi6wjyT0RXUN2DduDC9Y=;
 b=hSbPFehEA1tekci00W4TrcObMRqjRKFsq16PUAVHZhR1HyYFm1MuowjIyOsBZQSp+7
 BvsroDBp4jshmhF8QB0mG4LEIYZe4Q7mLdaFZSulh9s+6srpDtx5V3e9JNmytBSwxVVL
 d7mPL0j+vOwWVjMbmiA5AZCLjDQCT4FqXCuIQJH2TCYLuw3hDbluQOGxPkXYxHCKw7YC
 50Qd6roh1JEoJ0IkVD6dImkmtDW/ZtSf8NNABoD2cbqf09SWtKhwPD6PGNLzkwfgYPmp
 XPFAqQzHanxCYxX2RepTqLqytKF6xHh/oXCexNIhj4ug4OCkHlqMYqpKJirXhqw3Svhh
 3t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707125813; x=1707730613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4vkgxFgHIQnIhUAvoyDJL4wEi6wjyT0RXUN2DduDC9Y=;
 b=L72VV7xrH1NhCQvqNNGYZazqw1mMBO2mvBhey5H2rmwrMAm91kWEqzMXnGvFU2Xhh3
 ve/RD9iN5XlEEbplZijEY9P3uckWyXy9D8D+sja3WNwyZti2gPVNmeIJqjglDTL2SJRy
 5cEsGgRkB0zA9i4e+fqgUXyzEU5cUfI6Trw/+bqWRVH7BXatdlT1It8rXb+AtvNFaLll
 yiXJAFJE8iL8jsyin1TKIgKqbubvhrymBYPQqdcWIFwS9Mi4J413+i+jDXgwK+kW6F5T
 fyhqkEwkN3/gG+ACjckfKSjg0kJdqaFezU77luNHnVV9LZ88sPGZyZGlbxb6fmv/KTvb
 7aZQ==
X-Gm-Message-State: AOJu0Yz3LGqiTwfd+tzozY6Quj2LTIucnAa0l8uOlCzKll0LLeJH07q+
 iopyskobyZgyHcga1SRlQIZAZf39241Ox27PIVsC9/lWibtejv28Q4UeEZuH6URxnQLLY0V7UNL
 ABIobV2eofHF4m0wJUOBa65Y1Pug=
X-Google-Smtp-Source: AGHT+IHfYWYfEBLq6cH4pWJLX5EoEK2Cxqj8c8R2NLSOUOnwTGPxddcKiJxqh+eO+Er9WN/dXEmT4o6SpbsyOy21heY=
X-Received: by 2002:a4a:e6d3:0:b0:59a:3ad:4feb with SMTP id
 v19-20020a4ae6d3000000b0059a03ad4febmr13732541oot.2.1707125813073; Mon, 05
 Feb 2024 01:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20240126125056.16439-1-stefan_b@posteo.net>
 <20240126125056.16439-3-stefan_b@posteo.net>
In-Reply-To: <20240126125056.16439-3-stefan_b@posteo.net>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 5 Feb 2024 18:36:42 +0900
Message-ID: <CALrBrZ0_ot5ibSYskoK_quaBxgS-YR73Q3TOynV7oZEMfQAqJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm: s5p4418: fix relocation of vectors
To: Stefan Bosch <stefan_b@posteo.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


2024=EB=85=84 1=EC=9B=94 26=EC=9D=BC (=EA=B8=88) 21:53, Stefan Bosch <stefa=
n_b@posteo.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> The header (NSIH) used for the s5p4418-SoC is not loaded into RAM by the
> 2nd-bootloader, see boot0.h. Therefore, use an adapted version of
> relocate_vectors which relocates the vectors after the header (at _start)
> instead of the 'dummy'-vectors at the start of the header (at
> __image_copy_start).
>
> Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
> ---
>
> (no changes since v1)
>
>  arch/arm/cpu/armv7/s5p4418/Makefile   |  3 +++
>  arch/arm/cpu/armv7/s5p4418/relocate.S | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/arm/cpu/armv7/s5p4418/relocate.S
>
> diff --git a/arch/arm/cpu/armv7/s5p4418/Makefile
> b/arch/arm/cpu/armv7/s5p4418/Makefile
> index 321b257b6d..58042581c4 100644
> --- a/arch/arm/cpu/armv7/s5p4418/Makefile
> +++ b/arch/arm/cpu/armv7/s5p4418/Makefile
> @@ -2,5 +2,8 @@
>  #
>  # (C) Copyright 2016 Nexell
>  # Hyunseok, Jung <hsjung@nexell.co.kr>
> +#
> +# Copyright (C) 2023  Stefan Bosch <stefan_b@posteo.net>
>
>  obj-y +=3D cpu.o
> +obj-y +=3D relocate.o
> diff --git a/arch/arm/cpu/armv7/s5p4418/relocate.S
> b/arch/arm/cpu/armv7/s5p4418/relocate.S
> new file mode 100644
> index 0000000000..d6e76adceb
> --- /dev/null
> +++ b/arch/arm/cpu/armv7/s5p4418/relocate.S
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  relocate - S5P4418 specific relocation for ARM U-Boot
> + *
> + *  Copyright (c) 2013  Albert ARIBAUD <albert.u.boot@aribaud.net>
> + *  Copyright (C) 2023  Stefan Bosch <stefan_b@posteo.net>
> + */
> +
> +#include <asm-offsets.h>
> +#include <asm/assembler.h>
> +#include <linux/linkage.h>
> +
> +ENTRY(relocate_vectors)
> +
> +       /*
> +        * The s5p4418 SoC has the security extensions, so use VBAR to
> relocate
> +        * the exception vectors.
> +        */
> +       ldr     r0, [r9, #GD_RELOCADDR] /* r0 =3D gd->relocaddr */
> +       add     r0, #0x400                      /* vectors are after NSIH
> + 0x200 */
> +       mcr     p15, 0, r0, c12, c0, 0  /* Set VBAR */
> +       ret     lr
> +
> +ENDPROC(relocate_vectors)
> --
> 2.17.1
>

Reviewed-by: Minkyu Kang <mk7.kang@samsung.com>

Thanks.
Minkyu Kang.
