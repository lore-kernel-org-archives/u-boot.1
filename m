Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A9DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DCFC877C4;
	Thu,  2 Nov 2023 15:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T3vDdLNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAFD9877C6; Thu,  2 Nov 2023 15:20:11 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01CF486FAE
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b2e22f1937so526679b6e.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698934804; x=1699539604;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5c7Lk+lR/88MoMNme8CBmqXsd/i0nQQtNr10vppG5yI=;
 b=T3vDdLNQVYZJ+pabcgS+5961MKubF8mYY4biRfwplRDyavUA2hfaU7jIqMiCOINo2L
 qG13+nefvbBDJDE1oEcsxTrKyhT2InwgBDmbMAexf/Cm41byjc05Gy/pdRbOe8yRS6Yl
 w3pqrTeYvUtzcswJU6HMOIPUm/fvgLmv9+y6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698934804; x=1699539604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5c7Lk+lR/88MoMNme8CBmqXsd/i0nQQtNr10vppG5yI=;
 b=pSC2DHwXLMZ0POAjkCBeMOXmbaw5vDH17oiIRvbTszClx6Fukh9BbeezMiNKZmwZYl
 ZFYS8DbH0Ahv4GwpWVOY7SOlC1gUwf6FXv7Zby4K7DDenI97UaLuvkLULHc+yTmpqxuZ
 f9eIB72q7FHt+gTK3of8+frUAAR8nie4dvXddBhyrt8KJSRouQNrC7tnlwXHLotoqX1V
 xh0Wo10VZzazSQSR5pqhuWZzi3TwLZ64gfaOqW5aNqkG7hg5My2Sh+a+Z/XY1z4aJjv0
 utq4U6QlSDvj5fhaIfDR4FDhccHhxJJ4mIQOdS24ssKwoxLbdxwtXW7MOqjj4MXwgm/5
 chuA==
X-Gm-Message-State: AOJu0YwCz+jp6fQpPojA9FAtWg9jz4DJbD65kU418tAaPs31CytIf/LP
 5vx2MMdSgX4gBg/M6Ct6iQpuqjaWI1oWI0+k+5FTFQ==
X-Google-Smtp-Source: AGHT+IF9B8R0V0agBNmCgBYAba6FMvfyrFV/HpF2D6Kh19iaGiDYxN582XgHizpD0SG7o7V32X76nQszyJ6Mk2ctI2w=
X-Received: by 2002:a05:6808:aaf:b0:3a8:f3e7:d696 with SMTP id
 r15-20020a0568080aaf00b003a8f3e7d696mr19147532oij.45.1698934804198; Thu, 02
 Nov 2023 07:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-4-seanga2@gmail.com>
 <CABGWkvoD4gkLzp5XrV3d6iuupCPimRPpgOgQNV_7C6YgZtCqrg@mail.gmail.com>
 <4d592edb-8f59-a13b-2c03-4798e73d372e@gmail.com>
In-Reply-To: <4d592edb-8f59-a13b-2c03-4798e73d372e@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 15:19:53 +0100
Message-ID: <CABGWkvqcax+jEBbLMSwd92KwcTG6HseO1YEu_zgndtfEe+wEzQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] nand: Calculate SYS_NAND_PAGE_COUNT automatically
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>
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

Sean, All

On Thu, Nov 2, 2023 at 3:17=E2=80=AFPM Sean Anderson <seanga2@gmail.com> wr=
ote:
>
> On 11/2/23 05:53, Dario Binacchi wrote:
> > Sean, All
> >
> > On Sun, Oct 29, 2023 at 4:48=E2=80=AFAM Sean Anderson <seanga2@gmail.co=
m> wrote:
> >>
> >> Contrary to what the help message says, this is the number of pages pe=
r
> >> block. Calculate it automatically based on SYS_NAND_BLOCK_SIZE and
> >> SYS_NAND_PAGE_SIZE.
> >>
> >> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >> ---
> >>
> >>   README                                          | 9 ++++-----
> >>   configs/am335x_baltos_defconfig                 | 1 -
> >>   configs/am335x_evm_defconfig                    | 1 -
> >>   configs/am335x_guardian_defconfig               | 1 -
> >>   configs/am335x_igep003x_defconfig               | 1 -
> >>   configs/am3517_evm_defconfig                    | 1 -
> >>   configs/am43xx_evm_defconfig                    | 1 -
> >>   configs/am43xx_evm_rtconly_defconfig            | 1 -
> >>   configs/am43xx_evm_usbhost_boot_defconfig       | 1 -
> >>   configs/am43xx_hs_evm_defconfig                 | 1 -
> >>   configs/axm_defconfig                           | 1 -
> >>   configs/chiliboard_defconfig                    | 1 -
> >>   configs/corvus_defconfig                        | 1 -
> >>   configs/da850evm_nand_defconfig                 | 1 -
> >>   configs/devkit3250_defconfig                    | 1 -
> >>   configs/devkit8000_defconfig                    | 1 -
> >>   configs/dra7xx_evm_defconfig                    | 1 -
> >>   configs/draco_defconfig                         | 1 -
> >>   configs/etamin_defconfig                        | 1 -
> >>   configs/gardena-smart-gateway-at91sam_defconfig | 1 -
> >>   configs/igep00x0_defconfig                      | 1 -
> >>   configs/m53menlo_defconfig                      | 1 -
> >>   configs/omap35_logic_defconfig                  | 1 -
> >>   configs/omap35_logic_somlv_defconfig            | 1 -
> >>   configs/omap3_beagle_defconfig                  | 1 -
> >>   configs/omap3_evm_defconfig                     | 1 -
> >>   configs/omap3_logic_defconfig                   | 1 -
> >>   configs/omap3_logic_somlv_defconfig             | 1 -
> >>   configs/omapl138_lcdk_defconfig                 | 1 -
> >>   configs/phycore-am335x-r2-regor_defconfig       | 1 -
> >>   configs/phycore-am335x-r2-wega_defconfig        | 1 -
> >>   configs/pxm2_defconfig                          | 1 -
> >>   configs/rastaban_defconfig                      | 1 -
> >>   configs/rut_defconfig                           | 1 -
> >>   configs/sama5d3_xplained_nandflash_defconfig    | 1 -
> >>   configs/sama5d3xek_nandflash_defconfig          | 1 -
> >>   configs/sama5d4_xplained_nandflash_defconfig    | 1 -
> >>   configs/sama5d4ek_nandflash_defconfig           | 1 -
> >>   configs/smartweb_defconfig                      | 1 -
> >>   configs/taurus_defconfig                        | 1 -
> >>   configs/thuban_defconfig                        | 1 -
> >>   drivers/mtd/nand/raw/Kconfig                    | 8 --------
> >>   drivers/mtd/nand/raw/am335x_spl_bch.c           | 3 ++-
> >>   drivers/mtd/nand/raw/atmel_nand.c               | 5 +++--
> >>   drivers/mtd/nand/raw/mxc_nand_spl.c             | 5 +++--
> >>   drivers/mtd/nand/raw/nand_spl_loaders.c         | 2 +-
> >>   drivers/mtd/nand/raw/nand_spl_simple.c          | 5 +++--
> >>   drivers/mtd/nand/raw/omap_gpmc.c                | 3 ++-
> >>   include/system-constants.h                      | 3 +++
> >>   49 files changed, 21 insertions(+), 62 deletions(-)
> >>
> >> diff --git a/README b/README
> >> index 60c6b8a19db..00d422737fb 100644
> >> --- a/README
> >> +++ b/README
> >> @@ -1191,11 +1191,10 @@ The following options need to be configured:
> >>                  Support for a lightweight UBI (fastmap) scanner and
> >>                  loader
> >>
> >> -               CONFIG_SYS_NAND_5_ADDR_CYCLE, CONFIG_SYS_NAND_PAGE_COU=
NT,
> >> -               CONFIG_SYS_NAND_PAGE_SIZE, CONFIG_SYS_NAND_OOBSIZE,
> >> -               CONFIG_SYS_NAND_BLOCK_SIZE, CONFIG_SYS_NAND_BAD_BLOCK_=
POS,
> >> -               CFG_SYS_NAND_ECCPOS, CFG_SYS_NAND_ECCSIZE,
> >> -               CFG_SYS_NAND_ECCBYTES
> >> +               CONFIG_SYS_NAND_5_ADDR_CYCLE, CONFIG_SYS_NAND_PAGE_SIZ=
E,
> >> +               CONFIG_SYS_NAND_OOBSIZE, CONFIG_SYS_NAND_BLOCK_SIZE,
> >> +               CONFIG_SYS_NAND_BAD_BLOCK_POS, CFG_SYS_NAND_ECCPOS,
> >> +               CFG_SYS_NAND_ECCSIZE, CFG_SYS_NAND_ECCBYTES
> >>                  Defines the size and behavior of the NAND that SPL us=
es
> >>                  to read U-Boot
> >>
> >> diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_d=
efconfig
> >> index 16993ef5386..3891e48e9c7 100644
> >> --- a/configs/am335x_baltos_defconfig
> >> +++ b/configs/am335x_baltos_defconfig
> >> @@ -67,7 +67,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconf=
ig
> >> index f048e60f7f3..73f221d55bc 100644
> >> --- a/configs/am335x_evm_defconfig
> >> +++ b/configs/am335x_evm_defconfig
> >> @@ -84,7 +84,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardi=
an_defconfig
> >> index 01d848ceede..5369e46bc1b 100644
> >> --- a/configs/am335x_guardian_defconfig
> >> +++ b/configs/am335x_guardian_defconfig
> >> @@ -99,7 +99,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x100
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep00=
3x_defconfig
> >> index 4dd6366ef67..4c5c82f9bdd 100644
> >> --- a/configs/am335x_igep003x_defconfig
> >> +++ b/configs/am335x_igep003x_defconfig
> >> @@ -85,7 +85,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_MTD_UBI_FASTMAP=3Dy
> >> diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconf=
ig
> >> index 0a83ac9378c..111929fb912 100644
> >> --- a/configs/am3517_evm_defconfig
> >> +++ b/configs/am3517_evm_defconfig
> >> @@ -75,7 +75,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconf=
ig
> >> index 6571afd345e..5f2356bcd32 100644
> >> --- a/configs/am43xx_evm_defconfig
> >> +++ b/configs/am43xx_evm_defconfig
> >> @@ -72,7 +72,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0xe0
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm=
_rtconly_defconfig
> >> index e84aed4d54d..30681e7eeb6 100644
> >> --- a/configs/am43xx_evm_rtconly_defconfig
> >> +++ b/configs/am43xx_evm_rtconly_defconfig
> >> @@ -62,7 +62,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0xe0
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43x=
x_evm_usbhost_boot_defconfig
> >> index 0cae3242b04..6c4cc99e5ff 100644
> >> --- a/configs/am43xx_evm_usbhost_boot_defconfig
> >> +++ b/configs/am43xx_evm_usbhost_boot_defconfig
> >> @@ -75,7 +75,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0xe0
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_d=
efconfig
> >> index 370ee967258..49ecb4c9e66 100644
> >> --- a/configs/am43xx_hs_evm_defconfig
> >> +++ b/configs/am43xx_hs_evm_defconfig
> >> @@ -68,7 +68,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0xe0
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/axm_defconfig b/configs/axm_defconfig
> >> index f9c02144c4a..e1a01b24b88 100644
> >> --- a/configs/axm_defconfig
> >> +++ b/configs/axm_defconfig
> >> @@ -86,7 +86,6 @@ CONFIG_MTD=3Dy
> >>   # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
> >>   CONFIG_NAND_ATMEL=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconf=
ig
> >> index 06642d282d1..0cd649d643a 100644
> >> --- a/configs/chiliboard_defconfig
> >> +++ b/configs/chiliboard_defconfig
> >> @@ -63,7 +63,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
> >> index ecf61f0d1e6..5eaa6dbb5fc 100644
> >> --- a/configs/corvus_defconfig
> >> +++ b/configs/corvus_defconfig
> >> @@ -81,7 +81,6 @@ CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT=3Dy
> >>   # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
> >>   CONFIG_NAND_ATMEL=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_d=
efconfig
> >> index 5f6f5d788d0..62b8edde248 100644
> >> --- a/configs/da850evm_nand_defconfig
> >> +++ b/configs/da850evm_nand_defconfig
> >> @@ -88,7 +88,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
> >>   CONFIG_NAND_DAVINCI=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/devkit3250_defconfig b/configs/devkit3250_defconf=
ig
> >> index ec4031da51d..569b156c997 100644
> >> --- a/configs/devkit3250_defconfig
> >> +++ b/configs/devkit3250_defconfig
> >> @@ -73,7 +73,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
> >>   CONFIG_NAND_LPC32XX_SLC=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   # CONFIG_SYS_NAND_5_ADDR_CYCLE is not set
> >> diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconf=
ig
> >> index ef16da176a9..a7f82442eb0 100644
> >> --- a/configs/devkit8000_defconfig
> >> +++ b/configs/devkit8000_defconfig
> >> @@ -77,7 +77,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_HAM1_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconf=
ig
> >> index 19ca89fa867..c3a3ec2cd42 100644
> >> --- a/configs/dra7xx_evm_defconfig
> >> +++ b/configs/dra7xx_evm_defconfig
> >> @@ -104,7 +104,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/draco_defconfig b/configs/draco_defconfig
> >> index ee19920a703..2a82087ab31 100644
> >> --- a/configs/draco_defconfig
> >> +++ b/configs/draco_defconfig
> >> @@ -100,7 +100,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/etamin_defconfig b/configs/etamin_defconfig
> >> index c0ce7a33569..4ac0abc56b0 100644
> >> --- a/configs/etamin_defconfig
> >> +++ b/configs/etamin_defconfig
> >> @@ -104,7 +104,6 @@ CONFIG_SYS_MAX_NAND_DEVICE=3D3
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x80000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x80
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0xe0
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs=
/gardena-smart-gateway-at91sam_defconfig
> >> index 439fcc05753..0fb92ff1638 100644
> >> --- a/configs/gardena-smart-gateway-at91sam_defconfig
> >> +++ b/configs/gardena-smart-gateway-at91sam_defconfig
> >> @@ -99,7 +99,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_NAND_ATMEL=3Dy
> >>   CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
> >> index 993bbe29c6b..3b1af07f057 100644
> >> --- a/configs/igep00x0_defconfig
> >> +++ b/configs/igep00x0_defconfig
> >> @@ -78,7 +78,6 @@ CONFIG_SYS_MTDPARTS_RUNTIME=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
> >> index ef9e15d1520..e1ddc0af5db 100644
> >> --- a/configs/m53menlo_defconfig
> >> +++ b/configs/m53menlo_defconfig
> >> @@ -90,7 +90,6 @@ CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
> >>   CONFIG_NAND_MXC=3Dy
> >>   CONFIG_MXC_NAND_HWECC=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_def=
config
> >> index 539b0cfa4f7..3a656072534 100644
> >> --- a/configs/omap35_logic_defconfig
> >> +++ b/configs/omap35_logic_defconfig
> >> @@ -74,7 +74,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_log=
ic_somlv_defconfig
> >> index f14ce3d23db..868e89114b7 100644
> >> --- a/configs/omap35_logic_somlv_defconfig
> >> +++ b/configs/omap35_logic_somlv_defconfig
> >> @@ -83,7 +83,6 @@ CONFIG_SYS_MAX_FLASH_SECT=3D256
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_def=
config
> >> index cabd3659385..7f0b927528d 100644
> >> --- a/configs/omap3_beagle_defconfig
> >> +++ b/configs/omap3_beagle_defconfig
> >> @@ -83,7 +83,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_HAM1_CODE_HW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
> >> index 33ff39ff548..3434783d45b 100644
> >> --- a/configs/omap3_evm_defconfig
> >> +++ b/configs/omap3_evm_defconfig
> >> @@ -74,7 +74,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defco=
nfig
> >> index 7d3d602c9d9..78bfbbd1a22 100644
> >> --- a/configs/omap3_logic_defconfig
> >> +++ b/configs/omap3_logic_defconfig
> >> @@ -73,7 +73,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic=
_somlv_defconfig
> >> index 0141a425e07..aefd8861db3 100644
> >> --- a/configs/omap3_logic_somlv_defconfig
> >> +++ b/configs/omap3_logic_somlv_defconfig
> >> @@ -84,7 +84,6 @@ CONFIG_SYS_MAX_FLASH_SECT=3D256
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/omapl138_lcdk_defconfig b/configs/omapl138_lcdk_d=
efconfig
> >> index 47feff21bd4..63554d56016 100644
> >> --- a/configs/omapl138_lcdk_defconfig
> >> +++ b/configs/omapl138_lcdk_defconfig
> >> @@ -84,7 +84,6 @@ CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
> >>   CONFIG_NAND_DAVINCI=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
> >> diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phyco=
re-am335x-r2-regor_defconfig
> >> index 4bdf8822181..85d53d06357 100644
> >> --- a/configs/phycore-am335x-r2-regor_defconfig
> >> +++ b/configs/phycore-am335x-r2-regor_defconfig
> >> @@ -76,7 +76,6 @@ CONFIG_DM_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycor=
e-am335x-r2-wega_defconfig
> >> index 7644fbec273..60607548a25 100644
> >> --- a/configs/phycore-am335x-r2-wega_defconfig
> >> +++ b/configs/phycore-am335x-r2-wega_defconfig
> >> @@ -76,7 +76,6 @@ CONFIG_DM_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
> >> index 2ea007d0de5..e1d1066815b 100644
> >> --- a/configs/pxm2_defconfig
> >> +++ b/configs/pxm2_defconfig
> >> @@ -99,7 +99,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/rastaban_defconfig b/configs/rastaban_defconfig
> >> index 9f538a2f83d..21495341e26 100644
> >> --- a/configs/rastaban_defconfig
> >> +++ b/configs/rastaban_defconfig
> >> @@ -100,7 +100,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/rut_defconfig b/configs/rut_defconfig
> >> index ccf25667b50..248073be1f2 100644
> >> --- a/configs/rut_defconfig
> >> +++ b/configs/rut_defconfig
> >> @@ -99,7 +99,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sa=
ma5d3_xplained_nandflash_defconfig
> >> index a1b6122f8eb..a0802f9c5fe 100644
> >> --- a/configs/sama5d3_xplained_nandflash_defconfig
> >> +++ b/configs/sama5d3_xplained_nandflash_defconfig
> >> @@ -86,7 +86,6 @@ CONFIG_PMECC_CAP=3D4
> >>   CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3x=
ek_nandflash_defconfig
> >> index 6278a6c68a7..d96bb91e65d 100644
> >> --- a/configs/sama5d3xek_nandflash_defconfig
> >> +++ b/configs/sama5d3xek_nandflash_defconfig
> >> @@ -90,7 +90,6 @@ CONFIG_PMECC_CAP=3D4
> >>   CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sa=
ma5d4_xplained_nandflash_defconfig
> >> index d12f749d7f4..68101a12fc2 100644
> >> --- a/configs/sama5d4_xplained_nandflash_defconfig
> >> +++ b/configs/sama5d4_xplained_nandflash_defconfig
> >> @@ -84,7 +84,6 @@ CONFIG_PMECC_CAP=3D8
> >>   CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0xe0
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek=
_nandflash_defconfig
> >> index 27bfcdf0084..b8062db775d 100644
> >> --- a/configs/sama5d4ek_nandflash_defconfig
> >> +++ b/configs/sama5d4ek_nandflash_defconfig
> >> @@ -81,7 +81,6 @@ CONFIG_PMECC_CAP=3D8
> >>   CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x40000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x1000
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0xe0
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
> >> index 10cbccb69b0..80d2c0f1cc1 100644
> >> --- a/configs/smartweb_defconfig
> >> +++ b/configs/smartweb_defconfig
> >> @@ -84,7 +84,6 @@ CONFIG_MTD=3Dy
> >>   # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
> >>   CONFIG_NAND_ATMEL=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
> >> index cc5755178b7..9be30c8d8a4 100644
> >> --- a/configs/taurus_defconfig
> >> +++ b/configs/taurus_defconfig
> >> @@ -94,7 +94,6 @@ CONFIG_MTD=3Dy
> >>   # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
> >>   CONFIG_NAND_ATMEL=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/configs/thuban_defconfig b/configs/thuban_defconfig
> >> index 116700e0df0..1134624f9d2 100644
> >> --- a/configs/thuban_defconfig
> >> +++ b/configs/thuban_defconfig
> >> @@ -100,7 +100,6 @@ CONFIG_MTD=3Dy
> >>   CONFIG_MTD_RAW_NAND=3Dy
> >>   CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> >>   CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> >> -CONFIG_SYS_NAND_PAGE_COUNT=3D0x40
> >>   CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> >>   CONFIG_SYS_NAND_OOBSIZE=3D0x40
> >>   CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> >> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconf=
ig
> >> index 72547f00fbe..ee484dc0f51 100644
> >> --- a/drivers/mtd/nand/raw/Kconfig
> >> +++ b/drivers/mtd/nand/raw/Kconfig
> >> @@ -660,14 +660,6 @@ config SYS_NAND_ONFI_DETECTION
> >>            And fetching device parameters flashed on device, by parsin=
g
> >>            ONFI parameter page.
> >>
> >> -config SYS_NAND_PAGE_COUNT
> >> -       hex "NAND chip page count"
> >> -       depends on SPL_NAND_SUPPORT && (NAND_ATMEL || NAND_MXC || \
> >> -               SPL_NAND_AM33XX_BCH || SPL_NAND_LOAD || SPL_NAND_SIMPL=
E || \
> >> -               NAND_OMAP_GPMC)
> >> -       help
> >> -         Number of pages in the NAND chip.
> >> -
> >>   config SYS_NAND_PAGE_SIZE
> >>          hex "NAND chip page size"
> >>          depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC |=
| \
> >> diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c b/drivers/mtd/nand/=
raw/am335x_spl_bch.c
> >> index 6ab3f1f42c5..3843ffc9a24 100644
> >> --- a/drivers/mtd/nand/raw/am335x_spl_bch.c
> >> +++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
> >> @@ -11,6 +11,7 @@
> >>
> >>   #include <common.h>
> >>   #include <nand.h>
> >> +#include <system-constants.h>
> >>   #include <asm/io.h>
> >>   #include <linux/delay.h>
> >>   #include <linux/mtd/nand_ecc.h>
> >> @@ -32,7 +33,7 @@ static int nand_command(int block, int page, uint32_=
t offs,
> >>          u8 cmd)
> >>   {
> >>          struct nand_chip *this =3D mtd_to_nand(mtd);
> >> -       int page_addr =3D page + block * CONFIG_SYS_NAND_PAGE_COUNT;
> >> +       int page_addr =3D page + block * SYS_NAND_PAGE_COUNT;
> >>          void (*hwctrl)(struct mtd_info *mtd, int cmd,
> >>                          unsigned int ctrl) =3D this->cmd_ctrl;
> >>
> >> diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/=
atmel_nand.c
> >> index 6b17e744a69..cfc6578ae83 100644
> >> --- a/drivers/mtd/nand/raw/atmel_nand.c
> >> +++ b/drivers/mtd/nand/raw/atmel_nand.c
> >> @@ -12,6 +12,7 @@
> >>
> >>   #include <common.h>
> >>   #include <log.h>
> >> +#include <system-constants.h>
> >>   #include <asm/gpio.h>
> >>   #include <asm/arch/gpio.h>
> >>   #include <dm/device_compat.h>
> >> @@ -1258,7 +1259,7 @@ static struct nand_chip nand_chip;
> >>   static int nand_command(int block, int page, uint32_t offs, u8 cmd)
> >>   {
> >>          struct nand_chip *this =3D mtd_to_nand(mtd);
> >> -       int page_addr =3D page + block * CONFIG_SYS_NAND_PAGE_COUNT;
> >> +       int page_addr =3D page + block * SYS_NAND_PAGE_COUNT;
> >>          void (*hwctrl)(struct mtd_info *mtd, int cmd,
> >>                          unsigned int ctrl) =3D this->cmd_ctrl;
> >>
> >> @@ -1359,7 +1360,7 @@ int spl_nand_erase_one(int block, int page)
> >>          if (nand_chip.select_chip)
> >>                  nand_chip.select_chip(mtd, 0);
> >>
> >> -       page_addr =3D page + block * CONFIG_SYS_NAND_PAGE_COUNT;
> >> +       page_addr =3D page + block * SYS_NAND_PAGE_COUNT;
> >>          hwctrl(mtd, NAND_CMD_ERASE1, NAND_CTRL_CLE | NAND_CTRL_CHANGE=
);
> >>          /* Row address */
> >>          hwctrl(mtd, (page_addr & 0xff), NAND_CTRL_ALE | NAND_CTRL_CHA=
NGE);
> >> diff --git a/drivers/mtd/nand/raw/mxc_nand_spl.c b/drivers/mtd/nand/ra=
w/mxc_nand_spl.c
> >> index 309e75d01e5..059bf38f50e 100644
> >> --- a/drivers/mtd/nand/raw/mxc_nand_spl.c
> >> +++ b/drivers/mtd/nand/raw/mxc_nand_spl.c
> >> @@ -13,6 +13,7 @@
> >>   #include <common.h>
> >>   #include <hang.h>
> >>   #include <nand.h>
> >> +#include <system-constants.h>
> >>   #include <linux/mtd/rawnand.h>
> >>   #include <asm/arch/imx-regs.h>
> >>   #include <asm/io.h>
> >> @@ -304,13 +305,13 @@ int nand_spl_load_image(uint32_t from, unsigned =
int size, void *buf)
> >>                   * Check if we have crossed a block boundary, and if =
so
> >>                   * check for bad block.
> >>                   */
> >> -               if (!(page % CONFIG_SYS_NAND_PAGE_COUNT)) {
> >> +               if (!(page % SYS_NAND_PAGE_COUNT)) {
> >>                          /*
> >>                           * Yes, new block. See if this block is good.=
 If not,
> >>                           * loop until we find a good block.
> >>                           */
> >>                          while (is_badblock(page)) {
> >> -                               page =3D page + CONFIG_SYS_NAND_PAGE_C=
OUNT;
> >> +                               page =3D page + SYS_NAND_PAGE_COUNT;
> >>                                  /* Check i we've reached the end of f=
lash. */
> >>                                  if (page >=3D maxpages)
> >>                                          return -1;
> >> diff --git a/drivers/mtd/nand/raw/nand_spl_loaders.c b/drivers/mtd/nan=
d/raw/nand_spl_loaders.c
> >> index 156b44d8358..8848cb27db9 100644
> >> --- a/drivers/mtd/nand/raw/nand_spl_loaders.c
> >> +++ b/drivers/mtd/nand/raw/nand_spl_loaders.c
> >> @@ -12,7 +12,7 @@ int nand_spl_load_image(uint32_t offs, unsigned int =
size, void *dst)
> >>          while (block <=3D lastblock) {
> >>                  if (!nand_is_bad_block(block)) {
> >>                          /* Skip bad blocks */
> >> -                       while (page < CONFIG_SYS_NAND_PAGE_COUNT) {
> >> +                       while (page < SYS_NAND_PAGE_COUNT) {
> >>                                  nand_read_page(block, page, dst);
> >>                                  /*
> >>                                   * When offs is not aligned to page a=
ddress the
> >> diff --git a/drivers/mtd/nand/raw/nand_spl_simple.c b/drivers/mtd/nand=
/raw/nand_spl_simple.c
> >> index 2f3af9edd4c..2ebcac56900 100644
> >> --- a/drivers/mtd/nand/raw/nand_spl_simple.c
> >> +++ b/drivers/mtd/nand/raw/nand_spl_simple.c
> >> @@ -6,6 +6,7 @@
> >>
> >>   #include <common.h>
> >>   #include <nand.h>
> >> +#include <system-constants.h>
> >>   #include <asm/io.h>
> >>   #include <linux/mtd/nand_ecc.h>
> >>   #include <linux/mtd/rawnand.h>
> >> @@ -27,7 +28,7 @@ static int nand_command(int block, int page, uint32_=
t offs,
> >>          u8 cmd)
> >>   {
> >>          struct nand_chip *this =3D mtd_to_nand(mtd);
> >> -       int page_addr =3D page + block * CONFIG_SYS_NAND_PAGE_COUNT;
> >> +       int page_addr =3D page + block * SYS_NAND_PAGE_COUNT;
> >>
> >>          while (!this->dev_ready(mtd))
> >>                  ;
> >> @@ -59,7 +60,7 @@ static int nand_command(int block, int page, uint32_=
t offs,
> >>          u8 cmd)
> >>   {
> >>          struct nand_chip *this =3D mtd_to_nand(mtd);
> >> -       int page_addr =3D page + block * CONFIG_SYS_NAND_PAGE_COUNT;
> >> +       int page_addr =3D page + block * SYS_NAND_PAGE_COUNT;
> >>          void (*hwctrl)(struct mtd_info *mtd, int cmd,
> >>                          unsigned int ctrl) =3D this->cmd_ctrl;
> >>
> >> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/o=
map_gpmc.c
> >> index 1a5ed0de31a..6e99538dea1 100644
> >> --- a/drivers/mtd/nand/raw/omap_gpmc.c
> >> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> >> @@ -6,6 +6,7 @@
> >>
> >>   #include <common.h>
> >>   #include <log.h>
> >> +#include <system-constants.h>
> >>   #include <asm/io.h>
> >>   #include <dm/uclass.h>
> >>   #include <linux/errno.h>
> >> @@ -1298,7 +1299,7 @@ static int nand_is_bad_block(int block)
> >>
> >>   static int nand_read_page(int block, int page, uchar *dst)
> >>   {
> >> -       int page_addr =3D block * CONFIG_SYS_NAND_PAGE_COUNT + page;
> >> +       int page_addr =3D block * SYS_NAND_PAGE_COUNT + page;
> >>          loff_t ofs =3D page_addr * CONFIG_SYS_NAND_PAGE_SIZE;
> >>          int ret;
> >>          size_t len =3D CONFIG_SYS_NAND_PAGE_SIZE;
> >> diff --git a/include/system-constants.h b/include/system-constants.h
> >> index 59371568d1e..c50d54f37a4 100644
> >> --- a/include/system-constants.h
> >> +++ b/include/system-constants.h
> >> @@ -41,4 +41,7 @@
> >>   #define SPL_PAYLOAD_ARGS_ADDR  0
> >>   #endif
> >>
> >> +#define SYS_NAND_PAGE_COUNT \
> >> +       (CONFIG_SYS_NAND_BLOCK_SIZE / CONFIG_SYS_NAND_PAGE_SIZE)
> >> +
> >>   #endif
> >> --
> >> 2.37.1
> >>
> >
> > Reviewed-by:  Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > What do you think about adding another patch to modify SYS_NAND_PAGE_CO=
UNT
> > so that it is clearer that it refers to the number of pages in a block?
>
> I would probably just merge that into this patch. How about SYS_NAND_BLOC=
K_PAGES?

It's okay with me.

Thanks and regards,
Dario

>
> --Sean



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
