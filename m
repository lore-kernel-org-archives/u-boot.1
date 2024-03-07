Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE36C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 10:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94425879E8;
	Thu,  7 Mar 2024 11:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lJIi4BkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADBC871C7; Thu,  7 Mar 2024 11:03:36 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E801871C7
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 11:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so810233a12.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 02:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1709805812; x=1710410612;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/PuwuUF49Gn95TSWqNeNGT1ugtiMKxAeySF+nzJ1p0=;
 b=lJIi4BkOBSh8lhF4Kw2nUpBVxXzN/fMeybsDT8RWs1ROAfh2R9cWXYvJewZeMIXeqz
 9KxXU22L/iaS/evVD5ia17XCc2uzH1lmZB654f/fU3T2e/GBFj8PCJO26saRLEd4QFGf
 UPPxCx2Kpx1USTwlI2wvny1eiC2Pd8wtMHZLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709805812; x=1710410612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/PuwuUF49Gn95TSWqNeNGT1ugtiMKxAeySF+nzJ1p0=;
 b=aW/HH/o6P/3k7ZSXifFGpjIX1xhqGrYIjuZYGJSfKyWygZgoLaKAFVCVBVyGWViCxZ
 tEL4/GhZeDRxl96I36HVsxU2KMy1z3hzgGox8oJXgxLx7xjccdEU/CTjvis46Ay17jxS
 DxUEE8zLIO42P35L34S0tRqJJMo7bpLZRInDpC/G0MtYoAYNR7PM1x4RALW2gw6LZSVq
 UwopeDjDAEoNjvbBJUwH/FK6DqF2hcHses3+uVhhsnUF4Ia2NP49rEvfh4poB/oNurZk
 cGZq1E9ePE/FOpwn+OlK4uVacvcwXrw6RUy6j2j21OpDCeHStFEZwggmspnvu7R9Y/Ht
 1P+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWECNoJy0FcZ7VGy6+kSCGBBcuxy7ld5mAochXkAsqjyvIBeB9DmKRPO+iS6Xc6F/I3T1LsnoaE31HO7z2JJgwTk0HpEw==
X-Gm-Message-State: AOJu0YyYvHm+SSbhuiWdxsdLnx1Yk5qK3WRVoXhuA+TJrodyFfMHWMOu
 MCmepg3VWNeowu5nzq7Nnjm0dVabmndFTjS9BvvSJA5DZ7pSXcLwTlZWDvaWf2azwm0GFtX+9y8
 Y3lwNJOL38jxsK8U+6B7vPpjkFl3c/sxFviCbtw==
X-Google-Smtp-Source: AGHT+IHMLickTzY4cmpUpZBfsg9pKOu8TSFWtOnJJwQkoefsHLhF/Hd601RrXXy/TDhKm3pLjvRTfy3EPOH/qbQUKUE=
X-Received: by 2002:aa7:c2d8:0:b0:567:612:1149 with SMTP id
 m24-20020aa7c2d8000000b0056706121149mr10258510edp.27.1709805811928; Thu, 07
 Mar 2024 02:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-4-ada@thorsis.com>
In-Reply-To: <20240307091014.39796-4-ada@thorsis.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Mar 2024 11:03:21 +0100
Message-ID: <CAOf5uw=81059i1Kvioa2F_1SMfGBx+pw5DQHATar_BDX_L82kg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mtd: nand: raw: Fix (most) Kconfig indentation
To: Alexander Dahl <ada@thorsis.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
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

Hi

On Thu, Mar 7, 2024 at 10:10=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wr=
ote:
>
> One tab in general.  One tab plus two spaces for help text.
>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/mtd/nand/raw/Kconfig | 106 +++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index bb9994b8626..f6644899b0a 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -1,6 +1,6 @@
> -
>  menuconfig MTD_RAW_NAND
>         bool "Raw NAND Device Support"
> +
>  if MTD_RAW_NAND
>
>  config SYS_NAND_SELF_INIT
> @@ -49,12 +49,12 @@ config SYS_NAND_NO_SUBPAGE_WRITE
>         depends on NAND_ARASAN || NAND_DAVINCI || NAND_KIRKWOOD
>
>  config DM_NAND_ATMEL
> -       bool "Support Atmel NAND controller with DM support"
> -       select SYS_NAND_SELF_INIT
> -       imply SYS_NAND_USE_FLASH_BBT
> -       help
> -         Enable this driver for NAND flash platforms using an Atmel NAND
> -         controller.
> +       bool "Support Atmel NAND controller with DM support"
> +       select SYS_NAND_SELF_INIT
> +       imply SYS_NAND_USE_FLASH_BBT
> +       help
> +         Enable this driver for NAND flash platforms using an Atmel NAND
> +         controller.
>
>  config NAND_ATMEL
>         bool "Support Atmel NAND controller"
> @@ -133,35 +133,35 @@ config NAND_BRCMNAND_6753
>           Enable support for broadcom nand driver on bcm6753.
>
>  config NAND_BRCMNAND_68360
> -       bool "Support Broadcom NAND controller on bcm68360"
> -       depends on NAND_BRCMNAND && BCM6856
> -       help
> -         Enable support for broadcom nand driver on bcm68360.
> +       bool "Support Broadcom NAND controller on bcm68360"
> +       depends on NAND_BRCMNAND && BCM6856
> +       help
> +         Enable support for broadcom nand driver on bcm68360.
>
>  config NAND_BRCMNAND_6838
> -       bool "Support Broadcom NAND controller on bcm6838"
> -       depends on NAND_BRCMNAND && ARCH_BMIPS && SOC_BMIPS_BCM6838
> -       help
> -         Enable support for broadcom nand driver on bcm6838.
> +       bool "Support Broadcom NAND controller on bcm6838"
> +       depends on NAND_BRCMNAND && ARCH_BMIPS && SOC_BMIPS_BCM6838
> +       help
> +         Enable support for broadcom nand driver on bcm6838.
>
>  config NAND_BRCMNAND_6858
> -       bool "Support Broadcom NAND controller on bcm6858"
> -       depends on NAND_BRCMNAND && BCM6858
> -       help
> -         Enable support for broadcom nand driver on bcm6858.
> +       bool "Support Broadcom NAND controller on bcm6858"
> +       depends on NAND_BRCMNAND && BCM6858
> +       help
> +         Enable support for broadcom nand driver on bcm6858.
>
>  config NAND_BRCMNAND_63158
> -       bool "Support Broadcom NAND controller on bcm63158"
> -       depends on NAND_BRCMNAND && BCM63158
> -       help
> -         Enable support for broadcom nand driver on bcm63158.
> +       bool "Support Broadcom NAND controller on bcm63158"
> +       depends on NAND_BRCMNAND && BCM63158
> +       help
> +         Enable support for broadcom nand driver on bcm63158.
>
>  config NAND_BRCMNAND_IPROC
> -       bool "Support Broadcom NAND controller on the iproc family"
> -       depends on NAND_BRCMNAND
> -       help
> -         Enable support for broadcom nand driver on the Broadcom
> -         iproc family such as Northstar (BCM5301x, BCM4708...)
> +       bool "Support Broadcom NAND controller on the iproc family"
> +       depends on NAND_BRCMNAND
> +       help
> +         Enable support for broadcom nand driver on the Broadcom
> +         iproc family such as Northstar (BCM5301x, BCM4708...)
>
>  config NAND_DAVINCI
>         bool "Support TI Davinci NAND controller"
> @@ -413,10 +413,10 @@ config NAND_VF610_NFC
>  if NAND_VF610_NFC
>
>  config NAND_VF610_NFC_DT
> -        bool "Support Vybrid's vf610 NAND controller as a DT device"
> -        depends on OF_CONTROL && DM_MTD
> -        help
> -          Enable the driver for Vybrid's vf610 NAND flash on platforms
> +       bool "Support Vybrid's vf610 NAND controller as a DT device"
> +       depends on OF_CONTROL && DM_MTD
> +       help
> +         Enable the driver for Vybrid's vf610 NAND flash on platforms
>           using device tree.
>
>  choice
> @@ -472,11 +472,11 @@ config NAND_SUNXI
>         select SPL_NAND_SUPPORT
>         select SPL_SYS_NAND_SELF_INIT
>         imply CMD_NAND
> -       ---help---
> -       Enable support for NAND. This option enables the standard and
> -       SPL drivers.
> -       The SPL driver only supports reading from the NAND using DMA
> -       transfers.
> +       help
> +         Enable support for NAND. This option enables the standard and
> +         SPL drivers.
> +         The SPL driver only supports reading from the NAND using DMA
> +         transfers.
>
>  if NAND_SUNXI
>
> @@ -577,16 +577,16 @@ config NAND_OCTEONTX
>         select SYS_NAND_SELF_INIT
>         imply CMD_NAND
>         help
> -        This enables Nand flash controller hardware found on the OcteonT=
X
> -        processors.
> +         This enables Nand flash controller hardware found on the Octeon=
TX
> +         processors.
>
>  config NAND_OCTEONTX_HW_ECC
>         bool "Support Hardware ECC for OcteonTX NAND controller"
>         depends on NAND_OCTEONTX
>         default y
>         help
> -        This enables Hardware BCH engine found on the OcteonTX processor=
s to
> -        support ECC for NAND flash controller.
> +         This enables Hardware BCH engine found on the OcteonTX processo=
rs to
> +         support ECC for NAND flash controller.
>
>  config NAND_STM32_FMC2
>         bool "Support for NAND controller on STM32MP SoCs"
> @@ -751,37 +751,37 @@ config SYS_NAND_BAD_BLOCK_POS
>  config SYS_NAND_U_BOOT_LOCATIONS
>         bool "Define U-Boot binaries locations in NAND"
>         help
> -       Enable CONFIG_SYS_NAND_U_BOOT_OFFS though Kconfig.
> -       This option should not be enabled when compiling U-Boot for board=
s
> -       defining CONFIG_SYS_NAND_U_BOOT_OFFS in their include/configs/<bo=
ard>.h
> -       file.
> +         Enable CONFIG_SYS_NAND_U_BOOT_OFFS though Kconfig.
> +         This option should not be enabled when compiling U-Boot for boa=
rds
> +         defining CONFIG_SYS_NAND_U_BOOT_OFFS in their include/configs/<=
board>.h
> +         file.
>
>  config SYS_NAND_U_BOOT_OFFS
>         hex "Location in NAND to read U-Boot from"
>         default 0x800000 if NAND_SUNXI
>         depends on SYS_NAND_U_BOOT_LOCATIONS
>         help
> -       Set the offset from the start of the nand where u-boot should be
> -       loaded from.
> +         Set the offset from the start of the nand where u-boot should b=
e
> +         loaded from.
>
>  config SYS_NAND_U_BOOT_OFFS_REDUND
>         hex "Location in NAND to read U-Boot from"
>         default SYS_NAND_U_BOOT_OFFS
>         depends on SYS_NAND_U_BOOT_LOCATIONS
>         help
> -       Set the offset from the start of the nand where the redundant u-b=
oot
> -       should be loaded from.
> +         Set the offset from the start of the nand where the redundant u=
-boot
> +         should be loaded from.
>
>  config SPL_NAND_AM33XX_BCH
>         bool "Enables SPL-NAND driver which supports ELM based"
>         depends on SPL_NAND_SUPPORT && NAND_OMAP_GPMC && !OMAP34XX
>         default y
> -        help
> +       help
>           Hardware ECC correction. This is useful for platforms which hav=
e ELM
>           hardware engine and use NAND boot mode.
>           Some legacy platforms like OMAP3xx do not have in-built ELM h/w=
 engine,
>           so those platforms should use CONFIG_SPL_NAND_SIMPLE for enabli=
ng
> -          SPL-NAND driver with software ECC correction support.
> +         SPL-NAND driver with software ECC correction support.
>
>  config SPL_NAND_DENALI
>         bool "Support Denali NAND controller for SPL"
> @@ -810,6 +810,6 @@ config SYS_NAND_HW_ECC_OOBFIRST
>         bool "In SPL, read the OOB first and then the data from NAND"
>         depends on SPL_NAND_SIMPLE
>
> -endif
> +endif  # if SPL
>
> -endif   # if NAND
> +endif  # if MTD_RAW_NAND
> --
> 2.39.2
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
