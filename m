Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AEFC7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 01:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04AD82CCE;
	Sat, 21 Jun 2025 03:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lp8yTTP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A3182CF4; Sat, 21 Jun 2025 03:33:29 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D249782AA4
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 03:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73a45bb28f1so1243801a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 18:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750469605; x=1751074405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zO5dtYNwOrP+eb3BL9P/VzxRc4PaUAjMa1BJPcdusiQ=;
 b=lp8yTTP+Jtanu8L76lPANu5E/BZ8JQW0E+ndxD9mzsQaaufnJ8cnHFvv+r1r2L241Q
 V89AjvM0hEO13JMWT1NHEwclJ/Ed3NUQDMskZTQ5riIBoHDJxLHrHxf6MEMiEnGJVe9l
 5uVzF2GPzabA507qdz0B949rn8cw4gxDHf3UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750469605; x=1751074405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zO5dtYNwOrP+eb3BL9P/VzxRc4PaUAjMa1BJPcdusiQ=;
 b=NmIvnds9VG9CmXHUkhLmq3tSAyzZq0C9pkh8CpIZfBqQMOj1QKYFO3XREhavMuY6U6
 XArOLJs/71ADOqjT6yc7auB8eHTflsPbEax4B0E165vy7wvYeb4B9EyiGX+MJydvG5WM
 R52optXZoqkCY7GZcSvzgvu/HnWJIc8B84ygqA9Rg1+Aqf8sM9/5mEEyW5DNCFwpzZo1
 RkBT8pJva2xtoCx3HzQsrW2RRPZ8AU5JyMb39/8EsRXP1OdkaKn6D+IcvKRrad5M8WRr
 j8kjGJ7uQA+1BIQjlwYmsA9MboP/yJh6o5E6Y5GgLAQNL+A1PldlCIGBBu/yta2c1aXA
 i4Ag==
X-Gm-Message-State: AOJu0Yxc8FbliMoKFE8QJ0ey+DOBnocZDq51olJNLKSbyacijudX/jXr
 mOxEqh7gk+pD448tTFGM0KGA212LZXzYswyynaOTdZ/jdya+Mp5uJ0xYRM4HnMimZ0o=
X-Gm-Gg: ASbGncvSNAI+X4bT85lNbaT3ZGEaAObjKcZBsfrYkDatOFiBxJTYfZNZ7cq2CmE3d8G
 Vbd1mtYAPVeHtP7eEurWDB3BohTf+QvPngxVFGLnE2mH32q2mO/qGRlM4JyAxV0qgjhqzYBzSkr
 kj1uyHQxnW1HITOjrm6Bhsig8XXD0T1b1WkPXOne7DSK/Og4HuyFDe41pojAAQV8ZvBds1a1kMc
 JRkb4dwUirVifEZQnHQSzUYP5BcCZVbJisfoU/QZWQYx57xPz6RRQPIsToHAZI9S6LZIqeZfQyM
 CXIMaPmjXYZsWcc+IMlAK/dR4cUBTOROuxbFyioduYNlkcfDcCsRRYY45mvGKQBOXzCPj0IXf0w
 QeufHKe2cZBRCMicTwv6SmQp4D7kkpQNKZw==
X-Google-Smtp-Source: AGHT+IGfkYuk5S8p/TdEzhUksTEIBjlIJ6vW38NuegXkKBybT1/KD+e9A1kjQZmp06sBj6PUHPEFzQ==
X-Received: by 2002:a05:6808:1314:b0:408:fef8:9c91 with SMTP id
 5614622812f47-40ac9610cd3mr3186197b6e.5.1750469605267; 
 Fri, 20 Jun 2025 18:33:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6ced44esm501552b6e.24.2025.06.20.18.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 18:33:24 -0700 (PDT)
Date: Fri, 20 Jun 2025 19:33:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Luka Perkov <luka@openwrt.org>
Subject: Re: [PATCH] arm: Remove ib62x0 board
Message-ID: <20250621013321.GO216500@bill-the-cat>
References: <20250620162142.3419101-1-trini@konsulko.com>
 <CAJaLiFxHHrj1EBDEXuKka43GnjyJXOQAzN+3DYgCS7vOGbS1Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zgHNbXZ5o6yeBRZ6"
Content-Disposition: inline
In-Reply-To: <CAJaLiFxHHrj1EBDEXuKka43GnjyJXOQAzN+3DYgCS7vOGbS1Yg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--zgHNbXZ5o6yeBRZ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 05:31:05PM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> On Fri, Jun 20, 2025 at 9:21=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > This board is unmaintained. Remove it.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Stefan Roese <sr@denx.de>
> > Cc: Tony Dinh <mibodhi@gmail.com>
> > Cc: Luka Perkov <luka@openwrt.org>
> > ---
> >  arch/arm/mach-kirkwood/Kconfig      |   7 --
> >  board/raidsonic/ib62x0/Kconfig      |  12 ---
> >  board/raidsonic/ib62x0/MAINTAINERS  |   6 --
> >  board/raidsonic/ib62x0/Makefile     |   7 --
> >  board/raidsonic/ib62x0/ib62x0.c     |  68 -------------
> >  board/raidsonic/ib62x0/ib62x0.h     |  29 ------
> >  board/raidsonic/ib62x0/kwbimage.cfg | 153 ----------------------------
> >  configs/ib62x0_defconfig            |  63 ------------
> >  include/configs/ib62x0.h            |  34 -------
> >  9 files changed, 379 deletions(-)
> >  delete mode 100644 board/raidsonic/ib62x0/Kconfig
> >  delete mode 100644 board/raidsonic/ib62x0/MAINTAINERS
> >  delete mode 100644 board/raidsonic/ib62x0/Makefile
> >  delete mode 100644 board/raidsonic/ib62x0/ib62x0.c
> >  delete mode 100644 board/raidsonic/ib62x0/ib62x0.h
> >  delete mode 100644 board/raidsonic/ib62x0/kwbimage.cfg
> >  delete mode 100644 configs/ib62x0_defconfig
> >  delete mode 100644 include/configs/ib62x0.h
> >
> > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kc=
onfig
> > index f1ccedba5d74..ff53718f991c 100644
> > --- a/arch/arm/mach-kirkwood/Kconfig
> > +++ b/arch/arm/mach-kirkwood/Kconfig
> > @@ -113,12 +113,6 @@ config TARGET_NETSPACE_V2
> >         select FEROCEON_88FR131
> >         select KIRKWOOD_COMMON
> >
> > -config TARGET_IB62X0
> > -       bool "ib62x0 Board"
> > -       select FEROCEON_88FR131
> > -       select KW88F6281
> > -       select KIRKWOOD_COMMON
> > -
> >  config TARGET_DOCKSTAR
> >         bool "Dockstar Board"
> >         select FEROCEON_88FR131
> > @@ -190,7 +184,6 @@ source "board/d-link/dns325/Kconfig"
> >  source "board/iomega/iconnect/Kconfig"
> >  source "board/LaCie/net2big_v2/Kconfig"
> >  source "board/LaCie/netspace_v2/Kconfig"
> > -source "board/raidsonic/ib62x0/Kconfig"
> >  source "board/Seagate/dockstar/Kconfig"
> >  source "board/Seagate/goflexhome/Kconfig"
> >  source "board/Seagate/nas220/Kconfig"
> > diff --git a/board/raidsonic/ib62x0/Kconfig b/board/raidsonic/ib62x0/Kc=
onfig
> > deleted file mode 100644
> > index 129aac8b6d46..000000000000
> > --- a/board/raidsonic/ib62x0/Kconfig
> > +++ /dev/null
> > @@ -1,12 +0,0 @@
> > -if TARGET_IB62X0
> > -
> > -config SYS_BOARD
> > -       default "ib62x0"
> > -
> > -config SYS_VENDOR
> > -       default "raidsonic"
> > -
> > -config SYS_CONFIG_NAME
> > -       default "ib62x0"
> > -
> > -endif
> > diff --git a/board/raidsonic/ib62x0/MAINTAINERS b/board/raidsonic/ib62x=
0/MAINTAINERS
> > deleted file mode 100644
> > index 423aa0cf253a..000000000000
> > --- a/board/raidsonic/ib62x0/MAINTAINERS
> > +++ /dev/null
> > @@ -1,6 +0,0 @@
> > -IB62X0 BOARD
> > -M:     Luka Perkov <luka@openwrt.org>
> > -S:     Maintained
> > -F:     board/raidsonic/ib62x0/
> > -F:     include/configs/ib62x0.h
> > -F:     configs/ib62x0_defconfig
> > diff --git a/board/raidsonic/ib62x0/Makefile b/board/raidsonic/ib62x0/M=
akefile
> > deleted file mode 100644
> > index 3e6bc688e7af..000000000000
> > --- a/board/raidsonic/ib62x0/Makefile
> > +++ /dev/null
> > @@ -1,7 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0+
> > -#
> > -# (C) Copyright 2009
> > -# Marvell Semiconductor <www.marvell.com>
> > -# Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> > -
> > -obj-y  :=3D ib62x0.o
> > diff --git a/board/raidsonic/ib62x0/ib62x0.c b/board/raidsonic/ib62x0/i=
b62x0.c
> > deleted file mode 100644
> > index 8d1d549a217c..000000000000
> > --- a/board/raidsonic/ib62x0/ib62x0.c
> > +++ /dev/null
> > @@ -1,68 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > -/*
> > - * Copyright (C) 2011-2012
> > - * Gerald Kerma <dreagle@doukki.net>
> > - * Luka Perkov <luka@openwrt.org>
> > - * Simon Baatz <gmbnomis@gmail.com>
> > - */
> > -
> > -#include <init.h>
> > -#include <miiphy.h>
> > -#include <asm/global_data.h>
> > -#include <asm/io.h>
> > -#include <asm/arch/cpu.h>
> > -#include <asm/arch/soc.h>
> > -#include <asm/arch/mpp.h>
> > -#include "ib62x0.h"
> > -
> > -DECLARE_GLOBAL_DATA_PTR;
> > -
> > -int board_early_init_f(void)
> > -{
> > -       /*
> > -        * default gpio configuration
> > -        * There are maximum 64 gpios controlled through 2 sets of regi=
sters
> > -        * the below configuration configures mainly initial LED status
> > -        */
> > -       mvebu_config_gpio(IB62x0_OE_VAL_LOW,
> > -                         IB62x0_OE_VAL_HIGH,
> > -                         IB62x0_OE_LOW, IB62x0_OE_HIGH);
> > -
> > -       /* Set SATA activity LEDs to default off */
> > -       writel(MVSATAHC_LED_POLARITY_CTRL, MVSATAHC_LED_CONF_REG);
> > -       /* Multi-Purpose Pins Functionality configuration */
> > -       static const u32 kwmpp_config[] =3D {
> > -               MPP0_NF_IO2,
> > -               MPP1_NF_IO3,
> > -               MPP2_NF_IO4,
> > -               MPP3_NF_IO5,
> > -               MPP4_NF_IO6,
> > -               MPP5_NF_IO7,
> > -               MPP6_SYSRST_OUTn,
> > -               MPP8_TW_SDA,
> > -               MPP9_TW_SCK,
> > -               MPP10_UART0_TXD,
> > -               MPP11_UART0_RXD,
> > -               MPP18_NF_IO0,
> > -               MPP19_NF_IO1,
> > -               MPP20_SATA1_ACTn,
> > -               MPP21_SATA0_ACTn,
> > -               MPP22_GPIO,     /* Power LED red */
> > -               MPP24_GPIO,     /* Power off device */
> > -               MPP25_GPIO,     /* Power LED green */
> > -               MPP27_GPIO,     /* USB transfer LED */
> > -               MPP28_GPIO,     /* Reset button */
> > -               MPP29_GPIO,     /* USB Copy button */
> > -               0
> > -       };
> > -       kirkwood_mpp_conf(kwmpp_config, NULL);
> > -       return 0;
> > -}
> > -
> > -int board_init(void)
> > -{
> > -       /* adress of boot parameters */
> > -       gd->bd->bi_boot_params =3D mvebu_sdram_bar(0) + 0x100;
> > -
> > -       return 0;
> > -}
> > diff --git a/board/raidsonic/ib62x0/ib62x0.h b/board/raidsonic/ib62x0/i=
b62x0.h
> > deleted file mode 100644
> > index 3690e13533ab..000000000000
> > --- a/board/raidsonic/ib62x0/ib62x0.h
> > +++ /dev/null
> > @@ -1,29 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0+ */
> > -/*
> > - * Copyright (C) 2011-2012
> > - * Gerald Kerma <dreagle@doukki.net>
> > - * Simon Baatz <gmbnomis@gmail.com>
> > - * Luka Perkov <luka@openwrt.org>
> > - */
> > -
> > -#ifndef __IB62x0_H
> > -#define __IB62x0_H
> > -
> > -#define IB62x0_OE_LOW          (~(1 << 22 | 1 << 24 | 1 << 25 | 1 << 2=
7))
> > -#define IB62x0_OE_HIGH         (~(0))
> > -#define IB62x0_OE_VAL_LOW      0
> > -#define IB62x0_OE_VAL_HIGH     0
> > -
> > -/* PHY related */
> > -#define MV88E1116_LED_FCTRL_REG                10
> > -#define MV88E1116_CPRSP_CR3_REG                21
> > -#define MV88E1116_MAC_CTRL_REG         21
> > -#define MV88E1116_PGADR_REG            22
> > -#define MV88E1116_RGMII_TXTM_CTRL      (1 << 4)
> > -#define MV88E1116_RGMII_RXTM_CTRL      (1 << 5)
> > -
> > -/* SATAHC related */
> > -#define MVSATAHC_LED_CONF_REG       (MV_SATA_BASE + 0x2C)
> > -#define MVSATAHC_LED_POLARITY_CTRL  (1 << 3)
> > -
> > -#endif /* __IB62x0_H */
> > diff --git a/board/raidsonic/ib62x0/kwbimage.cfg b/board/raidsonic/ib62=
x0/kwbimage.cfg
> > deleted file mode 100644
> > index 1249a0e4bc0a..000000000000
> > --- a/board/raidsonic/ib62x0/kwbimage.cfg
> > +++ /dev/null
> > @@ -1,153 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0+
> > -#
> > -# Copyright (C) 2011-2012
> > -# Gerald Kerma <dreagle@doukki.net>
> > -# Simon Baatz <gmbnomis@gmail.com>
> > -# Luka Perkov <luka@openwrt.org>
> > -# Refer doc/README.kwbimage for more details about how-to configure
> > -# and create kirkwood boot image
> > -#
> > -
> > -# Boot Media configurations
> > -BOOT_FROM      nand
> > -NAND_ECC_MODE  default
> > -NAND_PAGE_SIZE 0x0800
> > -
> > -# SOC registers configuration using bootrom header extension
> > -# Maximum KWBIMAGE_MAX_CONFIG configurations allowed
> > -
> > -# Configure RGMII-0 interface pad voltage to 1.8V
> > -DATA 0xffd100e0 0x1b1b1b9b
> > -
> > -# Dram initalization for SINGLE x16 CL=3D5 @ 400MHz
> > -DATA 0xffd01400 0x43000c30     # DDR Configuration register
> > -# bit13-0:  0xc30, (3120 DDR2 clks refresh rate)
> > -# bit23-14: 0x0,
> > -# bit24:    0x1,   enable exit self refresh mode on DDR access
> > -# bit25:    0x1,   required
> > -# bit29-26: 0x0,
> > -# bit31-30: 0x1,
> > -
> > -DATA 0xffd01404 0x37543000     # DDR Controller Control Low
> > -# bit4:     0x0, addr/cmd in smame cycle
> > -# bit5:     0x0, clk is driven during self refresh, we don't care for =
APX
> > -# bit6:     0x0, use recommended falling edge of clk for addr/cmd
> > -# bit14:    0x0, input buffer always powered up
> > -# bit18:    0x1, cpu lock transaction enabled
> > -# bit23-20: 0x5, recommended value for CL=3D5 and STARTBURST_DEL disab=
led bit31=3D0
> > -# bit27-24: 0x7, CL+2, STARTBURST sample stages, for freqs 400MHz, unb=
uffered DIMM
> > -# bit30-28: 0x3, required
> > -# bit31:    0x0, no additional STARTBURST delay
> > -
> > -DATA 0xffd01408 0x22125451     # DDR Timing (Low) (active cycles value=
 +1)
> > -# bit3-0:   TRAS lsbs
> > -# bit7-4:   TRCD
> > -# bit11-8:  TRP
> > -# bit15-12: TWR
> > -# bit19-16: TWTR
> > -# bit20:    TRAS msb
> > -# bit23-21: 0x0
> > -# bit27-24: TRRD
> > -# bit31-28: TRTP
> > -
> > -DATA 0xffd0140c 0x00000a33     # DDR Timing (High)
> > -# bit6-0:   TRFC
> > -# bit8-7:   TR2R
> > -# bit10-9:  TR2W
> > -# bit12-11: TW2W
> > -# bit31-13: 0x0, required
> > -
> > -DATA 0xffd01410 0x0000000c     # DDR Address Control
> > -# bit1-0:   00,  Cs0width (x8)
> > -# bit3-2:   11,  Cs0size (1Gb)
> > -# bit5-4:   00,  Cs1width (x8)
> > -# bit7-6:   11,  Cs1size (1Gb)
> > -# bit9-8:   00,  Cs2width (nonexistent)
> > -# bit11-10: 00,  Cs2size (nonexistent)
> > -# bit13-12: 00,  Cs3width (nonexistent)
> > -# bit15-14: 00,  Cs3size (nonexistent)
> > -# bit16:    0,   Cs0AddrSel
> > -# bit17:    0,   Cs1AddrSel
> > -# bit18:    0,   Cs2AddrSel
> > -# bit19:    0,   Cs3AddrSel
> > -# bit31-20: 0x0, required
> > -
> > -DATA 0xffd01414 0x00000000     # DDR Open Pages Control
> > -# bit0:    0,   OpenPage enabled
> > -# bit31-1: 0x0, required
> > -
> > -DATA 0xffd01418 0x00000000     # DDR Operation
> > -# bit3-0:   0x0, DDR cmd
> > -# bit31-4:  0x0, required
> > -
> > -DATA 0xffd0141c 0x00000c52     # DDR Mode
> > -# bit2-0:   0x2, BurstLen=3D2 required
> > -# bit3:     0x0, BurstType=3D0 required
> > -# bit6-4:   0x4, CL=3D5
> > -# bit7:     0x0, TestMode=3D0 normal
> > -# bit8:     0x0, DLL reset=3D0 normal
> > -# bit11-9:  0x6, auto-precharge write recovery
> > -# bit12:    0x0, PD must be zero
> > -# bit31-13: 0x0, required
> > -
> > -DATA 0xffd01420 0x00000040     # DDR Extended Mode
> > -# bit0:     0,   DDR DLL enabled
> > -# bit1:     0,   DDR drive strenght normal
> > -# bit2:     1,   DDR ODT control lsd (disabled)
> > -# bit5-3:   0x0, required
> > -# bit6:     0,   DDR ODT control msb, (disabled)
> > -# bit9-7:   0x0, required
> > -# bit10:    0,   differential DQS enabled
> > -# bit11:    0,   required
> > -# bit12:    0,   DDR output buffer enabled
> > -# bit31-13: 0x0, required
> > -
> > -DATA 0xffd01424 0x0000f17f     # DDR Controller Control High
> > -# bit2-0:   0x7, required
> > -# bit3:     0x1, MBUS Burst Chop disabled
> > -# bit6-4:   0x7, required
> > -# bit7:     0x0,
> > -# bit8:     0x1, add writepath sample stage, must be 1 for DDR freq >=
=3D 300MHz
> > -# bit9:     0x0, no half clock cycle addition to dataout
> > -# bit10:    0x0, 1/4 clock cycle skew enabled for addr/ctl signals
> > -# bit11:    0x0, 1/4 clock cycle skew disabled for write mesh
> > -# bit15-12: 0xf, required
> > -# bit31-16: 0,   required
> > -
> > -DATA 0xffd01428 0x00085520     # DDR2 ODT Read Timing (default values)
> > -DATA 0xffd0147c 0x00008552     # DDR2 ODT Write Timing (default values)
> > -
> > -DATA 0xffd01500 0x00000000     # CS[0]n Base address to 0x0
> > -DATA 0xffd01504 0x0ffffff1     # CS[0]n Size
> > -# bit0:     0x1,     Window enabled
> > -# bit1:     0x0,     Write Protect disabled
> > -# bit3-2:   0x0,     CS0 hit selected
> > -# bit23-4:  0xfffff, required
> > -# bit31-24: 0x0f,    Size (i.e. 256MB)
> > -
> > -DATA 0xffd01508 0x10000000     # CS[1]n Base address to 256Mb
> > -DATA 0xffd0150c 0x00000000     # CS[1]n Size, window disabled
> > -
> > -DATA 0xffd01514 0x00000000     # CS[2]n Size, window disabled
> > -DATA 0xffd0151c 0x00000000     # CS[3]n Size, window disabled
> > -
> > -DATA 0xffd01494 0x00030000     # DDR ODT Control (Low)
> > -# bit3-0:     ODT0Rd, MODT[0] asserted during read from DRAM CS1
> > -# bit7-4:     ODT0Rd, MODT[0] asserted during read from DRAM CS0
> > -# bit19-16:2, ODT0Wr, MODT[0] asserted during write to DRAM CS1
> > -# bit23-20:1, ODT0Wr, MODT[0] asserted during write to DRAM CS0
> > -
> > -DATA 0xffd01498 0x00000000     # DDR ODT Control (High)
> > -# bit1-0:  0x0, ODT0 controlled by ODT Control (low) register above
> > -# bit3-2:  0x1, ODT1 active NEVER!
> > -# bit31-4: 0x0, required
> > -
> > -DATA 0xffd0149c 0x0000e803     # CPU ODT Control
> > -DATA 0xffd01480 0x00000001     # DDR Initialization Control
> > -# bit0: 0x1, enable DDR init upon this register write
> > -
> > -DATA 0xffd20134 0x66666666     # L2 RAM Timing 0 Register
> > -DATA 0xffd20138 0x66666666     # L2 RAM Timing 1 Register
> > -
> > -# End of Header extension
> > -DATA 0x0 0x0
> > diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
> > deleted file mode 100644
> > index 1beb5837bb44..000000000000
> > --- a/configs/ib62x0_defconfig
> > +++ /dev/null
> > @@ -1,63 +0,0 @@
> > -CONFIG_ARM=3Dy
> > -CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > -CONFIG_SYS_DCACHE_OFF=3Dy
> > -CONFIG_ARCH_CPU_INIT=3Dy
> > -CONFIG_ARCH_KIRKWOOD=3Dy
> > -CONFIG_SYS_KWD_CONFIG=3D"board/raidsonic/ib62x0/kwbimage.cfg"
> > -CONFIG_TEXT_BASE=3D0x600000
> > -CONFIG_NR_DRAM_BANKS=3D2
> > -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xc8012000
> > -CONFIG_TARGET_IB62X0=3Dy
> > -CONFIG_ENV_SIZE=3D0x20000
> > -CONFIG_ENV_OFFSET=3D0xE0000
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/kirkwood-ib62x0"
> > -CONFIG_SYS_LOAD_ADDR=3D0x800000
> > -CONFIG_IDENT_STRING=3D" RaidSonic ICY BOX IB-NAS62x0"
> > -CONFIG_BOOTDELAY=3D3
> > -CONFIG_USE_BOOTCOMMAND=3Dy
> > -CONFIG_BOOTCOMMAND=3D"setenv bootargs ${console} ${mtdparts} ${bootarg=
s_root}; ubi part root; ubifsmount ubi:rootfs; ubifsload 0x800000 ${kernel}=
; ubifsload 0x700000 ${fdt}; ubifsumount; fdt addr 0x700000; fdt resize; fd=
t chosen; bootz 0x800000 - 0x700000"
> > -CONFIG_USE_PREBOOT=3Dy
> > -CONFIG_SYS_PBSIZE=3D1051
> > -# CONFIG_DISPLAY_BOARDINFO is not set
> > -CONFIG_HUSH_PARSER=3Dy
> > -CONFIG_SYS_PROMPT=3D"ib62x0 =3D> "
> > -CONFIG_SYS_MAXARGS=3D32
> > -CONFIG_CMD_BOOTZ=3Dy
> > -CONFIG_CMD_IDE=3Dy
> > -CONFIG_CMD_NAND=3Dy
> > -CONFIG_CMD_USB=3Dy
> > -# CONFIG_CMD_SETEXPR is not set
> > -CONFIG_CMD_DHCP=3Dy
> > -CONFIG_CMD_MII=3Dy
> > -CONFIG_CMD_PING=3Dy
> > -CONFIG_CMD_EXT2=3Dy
> > -CONFIG_CMD_FAT=3Dy
> > -CONFIG_CMD_JFFS2=3Dy
> > -CONFIG_CMD_MTDPARTS=3Dy
> > -CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dorion_nand"
> > -CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dorion_nand:0xe0000@0x0(uboot),0x=
20000@0xe0000(uboot_env),-@0x100000(root)"
> > -CONFIG_CMD_UBI=3Dy
> > -CONFIG_ISO_PARTITION=3Dy
> > -CONFIG_OF_CONTROL=3Dy
> > -CONFIG_ENV_OVERWRITE=3Dy
> > -CONFIG_ENV_IS_IN_NAND=3Dy
> > -CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> > -CONFIG_NETCONSOLE=3Dy
> > -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=3Dy
> > -CONFIG_SYS_ATA_STRIDE=3D4
> > -CONFIG_SYS_ATA_DATA_OFFSET=3D0x100
> > -CONFIG_SYS_ATA_REG_OFFSET=3D0x100
> > -CONFIG_SYS_ATA_ALT_OFFSET=3D0x100
> > -CONFIG_SYS_ATA_IDE0_OFFSET=3D0x2000
> > -CONFIG_SYS_ATA_IDE1_OFFSET=3D0x4000
> > -CONFIG_LBA48=3Dy
> > -# CONFIG_MMC is not set
> > -CONFIG_MTD=3Dy
> > -CONFIG_MTD_RAW_NAND=3Dy
> > -CONFIG_MVGBE=3Dy
> > -CONFIG_MII=3Dy
> > -CONFIG_USB=3Dy
> > -CONFIG_USB_EHCI_HCD=3Dy
> > -CONFIG_USB_STORAGE=3Dy
> > -CONFIG_LZMA=3Dy
> > -CONFIG_BZIP2=3Dy
> > diff --git a/include/configs/ib62x0.h b/include/configs/ib62x0.h
> > deleted file mode 100644
> > index e1b62f78b21e..000000000000
> > --- a/include/configs/ib62x0.h
> > +++ /dev/null
> > @@ -1,34 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0+ */
> > -/*
> > - * Copyright (C) 2011-2012
> > - * Gerald Kerma <dreagle@doukki.net>
> > - * Luka Perkov <luka@openwrt.org>
> > - */
> > -
> > -#ifndef _CONFIG_IB62x0_H
> > -#define _CONFIG_IB62x0_H
> > -
> > -#include "mv-common.h"
> > -
> > -/*
> > - * Environment variables configuration
> > - */
> > -
> > -/*
> > - * Default environment variables
> > - */
> > -
> > -#define CFG_EXTRA_ENV_SETTINGS \
> > -       "console=3Dconsole=3DttyS0,115200\0"                           =
     \
> > -       "kernel=3D/boot/zImage\0"                                      =
   \
> > -       "fdt=3D/boot/ib62x0.dtb\0"                                     =
   \
> > -       "bootargs_root=3Dubi.mtd=3D2 root=3Dubi0:rootfs rootfstype=3Dub=
ifs rw\0"
> > -
> > -/*
> > - * SATA driver configuration
> > - */
> > -#ifdef CONFIG_IDE
> > -#define __io
> > -#endif /* CONFIG_IDE */
> > -
> > -#endif /* _CONFIG_IB62x0_H */
> > --
> > 2.43.0
> >
>=20
> Please keep this. Even though I don't have this board, we can use the
> Marvell Dreamplug as the surrogate for testing just fine. I'll send in
> patches to modernize it and remove JFFS2.

I thought you might say that Tony, thanks! Just send a patch for
MAINTAINERS for now please.

--=20
Tom

--zgHNbXZ5o6yeBRZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhWC94ACgkQFHw5/5Y0
tywYcwv+J1GBZgRru3Qq2ggvPyxh8lp8bTxel6ZTLRWLNtifWbS8fnDtnD/uNmBG
7nXXCleMgwZcB6ZDCuete6suTnGC6s83VaydljXIEQTRHUFvAjDu2sOpphq4KH0L
f7CJv+LiYCIONZ5MD6kZFvOG1lpesTO2EuZgJS2IjKZNLcgQSkMPqxzPYKAlZlJx
MURHDwtHUIQkLiCt5qiYgqJVQDtvIM5Fc7CEczWLEw0/RLoDic2c9jg1F/4Sjj52
zI0u1lUnjTVE+B7m5j/HVz314NPVSZ6j6sQlrl4pqetpj+EsMWA61h3kYt9Mj1mF
GjF9Wx28hJxAnLYIVtLXyV5nV+lJPhraxTJhG2bExytinI9VFmHGNnvHYRqcVIKt
nHrAZJSSIetwtcjjPqRSOoY/Ykp6X8N1mssCT7odyyQ2Yby/NMn1b1hSI/p/ZLxX
xS+Fp6aJvc35Py2g1JmljYVefFiPiQV5IsBs/WEX30MaJveGDHLU76fTai62A1ND
8KMoAErt
=tM9K
-----END PGP SIGNATURE-----

--zgHNbXZ5o6yeBRZ6--
