Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992C4C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79D4874D5;
	Tue, 16 Jan 2024 17:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/OJ//ph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0362186FCE; Tue, 16 Jan 2024 17:05:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFC486F80
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3376ead25e1so7902443f8f.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705421155; x=1706025955; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMdJ1bKvF5vc3aCaRDE4BeazLlKKXCF8yoBM+ewZ7eU=;
 b=C/OJ//phZzGzAUOa463D/plelkZHBBdYdG1MY+TP3z4MHlDIBySzXV/m8JAiDtBMaj
 rPg25HaU0swCpDBD/LHMzbl6kRM04K8kv+14QHo4tfWuX2bB3k+X1u87sRSGC/yUvRPp
 6PESgvTlW51LOtW1/WCadzbUWp34+3Ax+TuyDqNDQmdzjtSGCPQEe4ybE3VwsgrHDQlZ
 LDDexkWM7kxVQSB3woTpV6K78DFVTsI6FC+G2N+Pjls2BzbsyzG2E7nLz53d1MnAQEiX
 BPqbI4gWgekjnjyQ63ckuBP+nSGIC1AccEg6PFcvzoVuGQL0996OqCjZ1C2q2tIhyyx3
 Nsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705421155; x=1706025955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMdJ1bKvF5vc3aCaRDE4BeazLlKKXCF8yoBM+ewZ7eU=;
 b=GZ9jXSnmhB/gaWX+EnM3sUKCAZuIN55JK1TI3tnlQC1HB3F79RACLKXyNTzCnowyB4
 YLV3wIdOCpqgj5pVm8uIEV/DqlSCblTOvu055hUc4t47yoKX7sRwhaBZN99Tm7p7GCHx
 jkpN3y/5cwoHO6qE4iX3BfUImzT5iuUSMzwcSNGVB1FdPO/CIsjhv1fWa/g7SOnbf5EY
 iKVKkoEReZWRHI3yFmLMKlRr5jTlUZSZl+EdoYCVIpyVLdVxGeV4YqKBbA0n2S1MhwTV
 pp4+k8Dj8m2pzYk1IvwY96cdWSTOAYE8rzTW4YnxYw9sRbIeuxTRjYcd4dsVrNXbW5Vh
 davg==
X-Gm-Message-State: AOJu0YyIY3+atxU8XueoaPi6iUFVogdKRhwWN4l9dl0PicGBDG7PWeFJ
 0C0RkZMIDLuLB7BZToiu6dtZP0hczOcqRpR1X08=
X-Google-Smtp-Source: AGHT+IE1/29VyiqfpyvWMk2ltLiy00KDrVKVm2WycbBKoI1GUixwyaAcaFapryCj15v+S85VR0gTntDJuyTBuKsan68=
X-Received: by 2002:a05:600c:a018:b0:40e:530c:f371 with SMTP id
 jg24-20020a05600ca01800b0040e530cf371mr3638780wmb.113.1705421154846; Tue, 16
 Jan 2024 08:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20240114180741.2114-1-seashell11234455@gmail.com>
 <20240114180741.2114-2-seashell11234455@gmail.com>
 <96f389a2-0f59-402a-8381-25ee1ee66ce2@gmx.de>
In-Reply-To: <96f389a2-0f59-402a-8381-25ee1ee66ce2@gmx.de>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Wed, 17 Jan 2024 00:05:42 +0800
Message-ID: <CAOKwTdrWrpSeDf2LO8=nT3jQWf=fgvz=ruCueewt0A+uJP=kmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] riscv: sophgo: milkv_duo: initial support added
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>, 
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>, 
 Shengyu Qu <wiagn233@outlook.com>, Yu Chien Peter Lin <peterlin@andestech.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Jan 2024 17:47:14 +0100
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

Heinrich Schuchardt <xypron.glpk@gmx.de> =E4=BA=8E2024=E5=B9=B41=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=B8=80 05:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On 1/14/24 19:07, Kongyang Liu wrote:
> > Add support for Sophgo's Milk-V Duo board, only minimal device tree and
> > serial console are enabled, and it can boot via vendor first stage
> > bootloader.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
>
> The sequence of patches seems to be wrong.
>
> We expect that after each single patch building succeeds. But the
> device-tree is neither in this patch nor in a preceding patch. Please,
> swap patch 1 and 2.
>
> make[2]: *** No rule to make target
> 'arch/riscv/dts/cv1800b-milkv-duo.dtb', needed by 'dtbs'.
>
>
I forgot defconfig relies on dts files, I will swap patch 1 and 2.

> >
> > ---
> >
> > Changes in v2:
> > - Fold the defconfig patch to first patch
> > - Remove unnecessary environment settings of consoledev and baudrate in
> > config
> >
> >   arch/riscv/Kconfig                 |  4 ++++
> >   board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
> >   board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
> >   board/sophgo/milkv_duo/Makefile    |  5 +++++
> >   board/sophgo/milkv_duo/board.c     |  9 +++++++++
> >   configs/milkv_duo_defconfig        | 24 ++++++++++++++++++++++++
> >   include/configs/milkv_duo.h        | 12 ++++++++++++
> >   7 files changed, 88 insertions(+)
> >   create mode 100644 board/sophgo/milkv_duo/Kconfig
> >   create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
> >   create mode 100644 board/sophgo/milkv_duo/Makefile
> >   create mode 100644 board/sophgo/milkv_duo/board.c
> >   create mode 100644 configs/milkv_duo_defconfig
> >   create mode 100644 include/configs/milkv_duo.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 6d0d812ddb..de99ce3a28 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -14,6 +14,9 @@ config TARGET_ANDES_AE350
> >   config TARGET_MICROCHIP_ICICLE
> >       bool "Support Microchip PolarFire-SoC Icicle Board"
> >
> > +config TARGET_MILKV_DUO
> > +     bool "Support Milk-v Duo Board"
> > +
> >   config TARGET_OPENPITON_RISCV64
> >       bool "Support RISC-V cores on OpenPiton SoC"
> >
> > @@ -80,6 +83,7 @@ source "board/openpiton/riscv64/Kconfig"
> >   source "board/sifive/unleashed/Kconfig"
> >   source "board/sifive/unmatched/Kconfig"
> >   source "board/sipeed/maix/Kconfig"
> > +source "board/sophgo/milkv_duo/Kconfig"
> >   source "board/starfive/visionfive2/Kconfig"
> >   source "board/thead/th1520_lpi4a/Kconfig"
>
> error: patch failed: arch/riscv/Kconfig:80
>
> Please, rebase.
>
>
I will rebase it.

> >
> > diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kc=
onfig
> > new file mode 100644
> > index 0000000000..2a458f291c
> > --- /dev/null
> > +++ b/board/sophgo/milkv_duo/Kconfig
> > @@ -0,0 +1,28 @@
> > +if TARGET_MILKV_DUO
> > +
> > +config SYS_BOARD
> > +     default "milkv_duo"
> > +
> > +config SYS_VENDOR
> > +     default "sophgo"
> > +
> > +config SYS_CPU
> > +     default "generic"
> > +
> > +config SYS_CONFIG_NAME
> > +     default "milkv_duo"
> > +
> > +config TEXT_BASE
> > +     default 0x80200000
> > +
> > +config ENV_SIZE
> > +     default 0x20000
> > +
> > +config ENV_SECT_SIZE
> > +     default 0x40000
> > +
> > +config BOARD_SPECIFIC_OPTIONS
> > +     def_bool y
> > +     select GENERIC_RISCV
> > +
> > +endif
> > diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_du=
o/MAINTAINERS
> > new file mode 100644
> > index 0000000000..651a0592f7
> > --- /dev/null
> > +++ b/board/sophgo/milkv_duo/MAINTAINERS
> > @@ -0,0 +1,6 @@
> > +Milk-V Duo
> > +M:   Kongyang Liu <seashell11234455@gmail.com>
> > +S:   Maintained
> > +F:   board/sophgo/milkv_duo/
> > +F:   configs/milkv_duo_defconfig
> > +F:   doc/board/sophgo/milkv_duo.rst
> > diff --git a/board/sophgo/milkv_duo/Makefile b/board/sophgo/milkv_duo/M=
akefile
> > new file mode 100644
> > index 0000000000..a087013f5c
> > --- /dev/null
> > +++ b/board/sophgo/milkv_duo/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > +
> > +obj-y :=3D board.o
> > diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/bo=
ard.c
> > new file mode 100644
> > index 0000000000..eaa47be173
> > --- /dev/null
> > +++ b/board/sophgo/milkv_duo/board.c
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > + */
> > +
> > +int board_init(void)
> > +{
> > +     return 0;
> > +}
> > diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
> > new file mode 100644
> > index 0000000000..c4782639ef
> > --- /dev/null
> > +++ b/configs/milkv_duo_defconfig
> > @@ -0,0 +1,24 @@
> > +CONFIG_RISCV=3Dy
> > +CONFIG_SYS_MALLOC_LEN=3D0x820000
> > +CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> > +CONFIG_NR_DRAM_BANKS=3D1
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x82300000
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"cv1800b-milkv-duo"
> > +CONFIG_IDENT_STRING=3D"milkv_duo"
> > +CONFIG_SYS_LOAD_ADDR=3D0x80080000
> > +CONFIG_TARGET_MILKV_DUO=3Dy
> > +CONFIG_ARCH_RV64I=3Dy
> > +CONFIG_RISCV_SMODE=3Dy
> > +CONFIG_FIT=3Dy
> > +CONFIG_SUPPORT_RAW_INITRD=3Dy
> > +CONFIG_HUSH_PARSER=3Dy
> > +CONFIG_SYS_PROMPT=3D"milkv_duo# "
> > +CONFIG_SYS_MAXARGS=3D64
> > +CONFIG_SYS_CBSIZE=3D512
> > +CONFIG_SYS_PBSIZE=3D544
> > +CONFIG_SYS_BOOTM_LEN=3D0x4000000
> > +CONFIG_ENV_OVERWRITE=3Dy
> > +CONFIG_SYS_NS16550=3Dy
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +# CONFIG_EFI_LOADER is not set
>
> Is there a limitation on the size of the binary or why are you excluding
> this option?
>
> With the loady command you should be able to load an EFI binary via the
> UART and then launch it. U-Boot comes with some EFI test applications
> that you could run like smbiosdump.efi.
>
In my memory, enabling the CONFIG_EFI_LOADER option resulted in some
errors on this board, but I forgot what those errors were. I will
verify it, and if
there are no issues, I will enable this option.

Best regards
Kongyang Liu

> Best regards
>
> Heinrich
>
> > diff --git a/include/configs/milkv_duo.h b/include/configs/milkv_duo.h
> > new file mode 100644
> > index 0000000000..0b4109dc1f
> > --- /dev/null
> > +++ b/include/configs/milkv_duo.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > + *
> > + */
> > +
> > +#ifndef __CONFIG_H
> > +#define __CONFIG_H
> > +
> > +#define CFG_SYS_SDRAM_BASE         0x80000000
> > +
> > +#endif /* __CONFIG_H */
>
