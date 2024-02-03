Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5B0C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 14:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6C38799D;
	Sat,  3 Feb 2024 15:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQP3OMX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA39875E9; Sat,  3 Feb 2024 15:02:24 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E61871DF
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 15:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33b0e5d1e89so2243154f8f.0
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 06:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706968942; x=1707573742; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkYEEd9Gqosa9Owd3cikEfHef/xAvf3F9yjaKhUBdsM=;
 b=LQP3OMX1yAgdI0/A+aFN1oorX+EAzTvHhqBTBaXSo0f9TRKV5SF4ceJ+N1ja6Xyhxm
 8DkkEn027xtOIADIrRPjuWzym5OojiVKIKS8ogmc41ykU20ebFOSOsEPg2wY071rxpnZ
 ddwO1h0LhUH6gQRgT/cwgsoU2i6niXZF8hfugriIHFttVJjNZmTl89Gba2mDP62nI7bZ
 s2O4fF6gQxqtRip6A5wk9HoJhT1Idr5vbemLhMCifZ6PZgnwqr3e2HkU72VFJDbmIMru
 N5iojxYBXa9lw5ajXFCXsAnGhQ2kcx1vhavKnUYsXUhJgKa7NyhJrTIaZ4Vgg3OEaT0Z
 ekGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706968942; x=1707573742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkYEEd9Gqosa9Owd3cikEfHef/xAvf3F9yjaKhUBdsM=;
 b=AbjCTaOtkuE7jLUX5kEJ1vGZ64ntin380gVCOuqUBct7lpNOcNaC+3Fn0YPw625yF1
 Fc/I9LC6aE0Gn9rpau00lTT09SloKooDYb+sUiawXAv5b7QqxSmIlnAJcpJBV2fKR+0d
 YrMIJhKEsX+g3c/OUhBVxUCNxPb/wbU93pxzQC+ZNRWdTjHjpI3bljXyEcPEMWu7u6oN
 sOvb9COj2DtaX65losxpbSIPm9fuFqAMFVkp6owr/H1bq0uWoHilRgb0SPnMIeGqBOkL
 BmFPIHjQo3l8vnojgbmy+gxIyh/7TK+UGn/V37k30x3SzzxbBBtQq6/WHMiomZ25XUfT
 qsGg==
X-Gm-Message-State: AOJu0YzJXvkxRBhKAwuQ++auHsfP5hgJsTwfmixufWtfn7BNL05zjEIw
 g+FkR78opj8VjX95wt2OpXDZK4abGSrUCY4W3jYhU52ljZFZUuKlxFE/bX4x9UpvQwOZQzmv5Lb
 vczdiWGWFPtmQpYxqDwtxuK79sL8=
X-Google-Smtp-Source: AGHT+IFSKCN6OkUuZoS3YpLqjkdHLVny1WLqhMaAj6nD3aUNRULM4b/gfwwT6LwMQK8PHq3fQNF/XZoy83aFFSv+qko=
X-Received: by 2002:a5d:51d1:0:b0:33b:1ac8:aebe with SMTP id
 n17-20020a5d51d1000000b0033b1ac8aebemr5289770wrv.44.1706968941928; Sat, 03
 Feb 2024 06:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20240202093748.330658-1-seashell11234455@gmail.com>
 <20240202093748.330658-2-seashell11234455@gmail.com>
 <8186f3b4-267c-4865-bee7-f59a49e5bea2@canonical.com>
In-Reply-To: <8186f3b4-267c-4865-bee7-f59a49e5bea2@canonical.com>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Sat, 3 Feb 2024 22:02:09 +0800
Message-ID: <CAOKwTdpxm6n3w_RqvUAHVjkWhQjoS2va_3FQcYZfEjgt-ODcbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: cpu: cv1800b: Add support for cv1800b SoC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bmeng@tinylab.org>,
 Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>, 
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>, 
 Shengyu Qu <wiagn233@outlook.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 03 Feb 2024 15:12:12 +0100
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

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> =E4=BA=8E2024=E5=B9=
=B42=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 19:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On 02.02.24 10:37, Kongyang Liu wrote:
> > Add Sophgo cv1800b SoC to support RISC-V arch.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> >
> > ---
> >
> >   arch/riscv/Kconfig              |  1 +
> >   arch/riscv/cpu/cv1800b/Kconfig  | 12 ++++++++++++
> >   arch/riscv/cpu/cv1800b/Makefile |  6 ++++++
> >   arch/riscv/cpu/cv1800b/cpu.c    | 22 ++++++++++++++++++++++
> >   arch/riscv/cpu/cv1800b/dram.c   | 21 +++++++++++++++++++++
> >   board/sophgo/milkv_duo/Kconfig  |  4 ++--
> >   6 files changed, 64 insertions(+), 2 deletions(-)
> >   create mode 100644 arch/riscv/cpu/cv1800b/Kconfig
> >   create mode 100644 arch/riscv/cpu/cv1800b/Makefile
> >   create mode 100644 arch/riscv/cpu/cv1800b/cpu.c
> >   create mode 100644 arch/riscv/cpu/cv1800b/dram.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ac52c5e6da..2c92b0d9f6 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -93,6 +93,7 @@ source "board/xilinx/mbv/Kconfig"
> >
> >   # platform-specific options below
> >   source "arch/riscv/cpu/andesv5/Kconfig"
> > +source "arch/riscv/cpu/cv1800b/Kconfig"
> >   source "arch/riscv/cpu/fu540/Kconfig"
> >   source "arch/riscv/cpu/fu740/Kconfig"
> >   source "arch/riscv/cpu/generic/Kconfig"
> > diff --git a/arch/riscv/cpu/cv1800b/Kconfig b/arch/riscv/cpu/cv1800b/Kc=
onfig
> > new file mode 100644
> > index 0000000000..7225b1210c
> > --- /dev/null
> > +++ b/arch/riscv/cpu/cv1800b/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > +
> > +config SOPHGO_CV1800B
> > +     bool
> > +     select ARCH_EARLY_INIT_R
> > +     select SYS_CACHE_SHIFT_6
> > +     imply CPU
> > +     imply CPU_RISCV
> > +     imply RISCV_TIMER
> > +     imply CMD_CPU
> > diff --git a/arch/riscv/cpu/cv1800b/Makefile b/arch/riscv/cpu/cv1800b/M=
akefile
> > new file mode 100644
> > index 0000000000..da12e0f64e
> > --- /dev/null
> > +++ b/arch/riscv/cpu/cv1800b/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > +
> > +obj-y +=3D dram.o
> > +obj-y +=3D cpu.o
> > diff --git a/arch/riscv/cpu/cv1800b/cpu.c b/arch/riscv/cpu/cv1800b/cpu.=
c
> > new file mode 100644
> > index 0000000000..f13c18942f
> > --- /dev/null
> > +++ b/arch/riscv/cpu/cv1800b/cpu.c
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> > + */
> > +
> > +#include <irq_func.h>
> > +#include <asm/cache.h>
> > +
> > +/*
> > + * cleanup_before_linux() is called just before we call linux
> > + * it prepares the processor for linux
> > + *
> > + * we disable interrupt and caches.
> > + */
> > +int cleanup_before_linux(void)
> > +{
> > +     disable_interrupts();
> > +
> > +     cache_flush();
> > +
> > +     return 0;
> > +}
>
> Thank you for enabling another board.
>
> The same cleanup_before_linux() code can be found in:
>
> arch/riscv/cpu/fu740/cpu.c
> arch/riscv/cpu/andesv5/cpu.c
> arch/riscv/cpu/fu540/cpu.c
> arch/riscv/cpu/generic/cpu.c
> arch/riscv/cpu/jh7110/cpu.c
>
> We should try to avoid this code duplication.
>
> disable_interrupts() is already called by bootm_disable_interrupts().
>
> flushing the instruction cache after loading a binary is not
> architecture specific either. This is why bootm_load_os() calls
> flush_cache().
>
> It should be sufficient to let weak function flush_dcache_range() in
> arch/riscv/lib/cache.c call flush_dcache_all(). And then remove all
> cleanup_before_linux() implementations.
>

Thanks for your explanation.

Currently, we have only implemented cache for SoC cv1800b, and for the sake
of compatibility, the remaining code has been simply copied from the generi=
c
folder without a thorough examination.

If this function is unnecessary, it will be removed in the next version.

Best regards
Kongyang Liu

> Best regards
>
> Heinrich
>
>
> > diff --git a/arch/riscv/cpu/cv1800b/dram.c b/arch/riscv/cpu/cv1800b/dra=
m.c
> > new file mode 100644
> > index 0000000000..91007c0a3d
> > --- /dev/null
> > +++ b/arch/riscv/cpu/cv1800b/dram.c
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> > + */
> > +
> > +#include <fdtdec.h>
> > +#include <init.h>
> > +#include <asm/global_data.h>
> > +#include <linux/sizes.h>
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +int dram_init(void)
> > +{
> > +     return fdtdec_setup_mem_size_base();
> > +}
> > +
> > +int dram_init_banksize(void)
> > +{
> > +     return fdtdec_setup_memory_banksize();
> > +}
> > diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kc=
onfig
> > index 2a458f291c..040a7487f1 100644
> > --- a/board/sophgo/milkv_duo/Kconfig
> > +++ b/board/sophgo/milkv_duo/Kconfig
> > @@ -7,7 +7,7 @@ config SYS_VENDOR
> >       default "sophgo"
> >
> >   config SYS_CPU
> > -     default "generic"
> > +     default "cv1800b"
> >
> >   config SYS_CONFIG_NAME
> >       default "milkv_duo"
> > @@ -23,6 +23,6 @@ config ENV_SECT_SIZE
> >
> >   config BOARD_SPECIFIC_OPTIONS
> >       def_bool y
> > -     select GENERIC_RISCV
> > +     select SOPHGO_CV1800B
> >
> >   endif
>
