Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A28C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2F78144A;
	Fri, 28 Mar 2025 17:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aRjoUxRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3499281951; Fri, 28 Mar 2025 17:51:34 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94697810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5cded3e2eso3705065a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743180690; x=1743785490; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=54xQp1rSkgfTP916ub30kgqFDkwF75EFVt8Vnv95+eM=;
 b=aRjoUxRyV7xw2MLREszw9In2Dsdoc7loKSmJ93UuWBMw/P2RF1NCSwl2sqjHw+0tOV
 LglcGC+vAhjPpfRz6UDAeR2/bnm2U643pYq8iXD4EQ6U8BU4HdVSqFZuCCADKhaF6VFx
 W8anMqkTn2lA6eFX0UCkjhh4JlnczWLN5HBqvPdDzC+CFMRrV7xr+tLjjouVbZSI9+C2
 8Y81Z/t4v6Pnas4f4gZ828t5OgloeBQrIWnfCrLmI2SA4XO6en46y6ms/GTSgHRSOzVz
 mGl14Yc77PXXKtC9bC+SXErthsDsbm7Bd8xzftelSftOTBGhEh8yXQ4df/WraWXbDu0Q
 VE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743180690; x=1743785490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=54xQp1rSkgfTP916ub30kgqFDkwF75EFVt8Vnv95+eM=;
 b=LuM4+wlBDGRRYwRgeUs6ewNHdRlZtJEQc4CYjDmeYcdTFVlWFiOxyMjjurtam8s5Fk
 Hafd3EI1qq3AAgoCV/fOsvRGn3PPorVGGMUWO9XBJm4BRyEP+l1+D9aWHSZCP5reXr2D
 KMiGA570/COXkcpBxCuy3HuFu9ZdeqN6voxqDsvsnEnfl5iVfo+gjtdDgtSGarP6+W4d
 l30G9m+p/7s/7C2HxqbsvhH1PPSDeYygyIRKohOaiZWeFqMfntj2eePmUnOzc8IqUewD
 qaWGFFoUg0UVxFXLFpryElj8aoDC/+OuxNgGsDhO14ZJ5MCPjYzPW2fN03WVoFr5gG2J
 3YJQ==
X-Gm-Message-State: AOJu0YzLywHY81EO0OwqoLgXfZ/kOjCpZRkqpd30XOixDQpldg/gcvan
 6fBRqF+oiJukf4hBJPdGcmdnpi+HiDsuWUilLy8Su/yOGwSuE452MilE35H0uC2eAVZM1HP0MdZ
 MKrGXXPmd/1kp1jHZGxgQXjypOdI=
X-Gm-Gg: ASbGncsuON4O7vDnde30/WNSKauh2425he0yLQ9HgrduAlYszc088GwZTBxCJqT8L2Y
 CB4j0oEhpbqeDfl8ehWuNDkdXZjTx3RAJXYVsqtRBFFO21eNc+Z7tBUrtnNIe27BKMC0lKXF9dD
 Tp3PBNWUHjF8amEtPEd7gcEgrWyA==
X-Google-Smtp-Source: AGHT+IG4TEiN3qOkTUzBiTbE9y7Q2s6q3ibK2Al6frABlpdf9zmNCni6EwKeSHYjWf7qZP+c302TIZYAsLuzQiRViZY=
X-Received: by 2002:a05:6402:2711:b0:5ed:5fa2:98d9 with SMTP id
 4fb4d7f45d1cf-5ed8f90b345mr9458272a12.28.1743180689500; Fri, 28 Mar 2025
 09:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
In-Reply-To: <20250328153522.3555472-20-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 28 Mar 2025 16:51:18 +0000
X-Gm-Features: AQ5f1Jq7qgzjnDQIBMKzdUzJspXHCq1nI2WIHrOn2otaVUFT8UnfzZpQrgPDBGw
Message-ID: <CALeDE9N0CirXGSJe=Tunj5LdV6pJ=MRrdVdCZfb6-E=mGOvraw@mail.gmail.com>
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Henderson <richard.henderson@linaro.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, huang lin <hl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon,

On Fri, 28 Mar 2025 at 15:38, Simon Glass <sjg@chromium.org> wrote:

> Add support for this new phase, which runs after TPL. It determines the
> state of the machine, then selects which SPL image to use. SDRAM init is
> then done in SPL, so that it is updatable.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> - Skip spl-boot-order.c for VPL (rather than modifying it)
>
>  arch/arm/include/asm/spl.h               |   1 +
>  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
>  arch/arm/mach-rockchip/Makefile          |  11 ++-
>  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
>  arch/arm/mach-rockchip/spl.c             |   3 +
>  arch/arm/mach-rockchip/tpl.c             |   2 +-
>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
>  common/spl/Kconfig                       |   1 +
>  9 files changed, 205 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>  create mode 100644 arch/arm/mach-rockchip/vpl.c
>
> diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
> index ee79a19c05c..62844d64cab 100644
> --- a/arch/arm/include/asm/spl.h
> +++ b/arch/arm/include/asm/spl.h
> @@ -30,6 +30,7 @@ enum {
>         BOOT_DEVICE_XIP,
>         BOOT_DEVICE_BOOTROM,
>         BOOT_DEVICE_SMH,
> +       BOOT_DEVICE_VBE,
>         BOOT_DEVICE_NONE
>  };
>  #endif
> diff --git a/arch/arm/mach-rockchip/Kconfig
> b/arch/arm/mach-rockchip/Kconfig
> index 4c515593718..58ba0e0468f 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -252,13 +252,15 @@ config ROCKCHIP_RK3399
>         select SPL_ATF
>         select SPL_BOARD_INIT if SPL
>         select SPL_LOAD_FIT
> -       select SPL_CLK if SPL
> +       select SPL_CLK if SPL && !VPL
>         select SPL_PINCTRL if SPL
>         select SPL_RAM if SPL
>         select SPL_REGMAP if SPL
>         select SPL_SYSCON if SPL
>         select TPL_HAVE_INIT_STACK if TPL
> -       select SPL_SEPARATE_BSS
> +       select VPL_HAVE_INIT_STACK if VPL
> +       select SPL_SEPARATE_BSS if !VPL
> +       select SPL_RAW_IMAGE_SUPPORT if VPL
>         select CLK
>         select FIT
>         select PINCTRL
> @@ -268,6 +270,7 @@ config ROCKCHIP_RK3399
>         select DM_PMIC
>         select DM_REGULATOR_FIXED
>         select BOARD_LATE_INIT
> +       select SUPPORT_VPL
>         imply ARMV8_CRYPTO
>         imply ARMV8_SET_SMPEN
>         imply BOOTSTD_FULL
> @@ -296,13 +299,14 @@ config ROCKCHIP_RK3399
>         imply TPL_LIBCOMMON_SUPPORT
>         imply TPL_LIBGENERIC_SUPPORT
>         imply TPL_OF_CONTROL
> -       imply TPL_RAM
> +       imply TPL_RAM if !VPL
>         imply TPL_REGMAP
>         imply TPL_ROCKCHIP_COMMON_BOARD
>         imply TPL_SERIAL
>         imply TPL_SYS_MALLOC_SIMPLE
>         imply TPL_SYSCON
>         imply TPL_TINY_MEMSET
> +       imply TPL_DM_MMC if VPL
>         help
>           The Rockchip RK3399 is a ARM-based SoC with a dual-core
> Cortex-A72
>           and quad-core Cortex-A53.
> @@ -457,7 +461,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
>
>  config TPL_ROCKCHIP_BACK_TO_BROM
>         bool "TPL returns to bootrom"
> -       default y
> +       default y if !VPL
>         select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>         select TPL_BOOTROM_SUPPORT
>         depends on TPL
> @@ -498,6 +502,16 @@ config ROCKCHIP_EXTERNAL_TPL
>           Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin
> to
>           include the external TPL in the image built by binman.
>
> +config VPL_ROCKCHIP_COMMON_BOARD
> +       bool "Rockchip VPL common board file"
> +       depends on VPL
> +       default y
>

This should be optional and opt in, at least to begin with. I honestly
don't see what value VBE provides, and I've not seen you describe your
vision for it anyway.


> +       help
> +         Enable the VPL phase for rockchip, which selects which SPL/U-Boot
> +         will be used on each boot. With this flow, used by Verified Boot
> for
> +         Embedded (VBE), TPL is loaded by the boot ROM. Then TPL loads
> VPL,
> +         VPL loads SPL and SPL loads U-Boot.
> +
>  config ROCKCHIP_BOOT_MODE_REG
>         hex "Rockchip boot mode flag register address"
>         help
> @@ -589,6 +603,9 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
>  config SPL_MMC
>         default y if !SPL_ROCKCHIP_BACK_TO_BROM
>
> +config TPL_MMC
> +       default y if !TPL_ROCKCHIP_BACK_TO_BROM
> +
>  config ROCKCHIP_SPI_IMAGE
>         bool "Build a SPI image for rockchip"
>         help
> diff --git a/arch/arm/mach-rockchip/Makefile
> b/arch/arm/mach-rockchip/Makefile
> index 5e7edc99cdc..c39de1f78bb 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -8,11 +8,16 @@
>  # inaccessible/protected memory (and the bootrom-helper assumes that
>  # the stack-pointer is valid before switching to the U-Boot stack).
>  obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o
> spl_common.o
> +obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl_common.o
> +ifndef CONFIG_VPL
> +obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl-boot-order.o
> +endif
>  obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
>  obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
>  obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
>
> +obj-vpl-$(CONFIG_VPL_ROCKCHIP_COMMON_BOARD) += vpl.o
> +
>  obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
>
>  ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> @@ -47,9 +52,11 @@ obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
>  obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
>  obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
>
> -# Clear out SPL objects, in case this is a TPL build
> +# Clear out SPL objects, in case this is a TPL or VPL build
>  obj-spl-$(CONFIG_TPL_BUILD) =
> +obj-spl-$(CONFIG_VPL_BUILD) =
>
>  # Now add SPL/TPL objects back into the main build
>  obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
>  obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
> +obj-$(CONFIG_VPL_BUILD) += $(obj-vpl-y)
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig
> b/arch/arm/mach-rockchip/rk3399/Kconfig
> index 04a84e2f6a0..fc55b498111 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -164,6 +164,15 @@ config TPL_STACK
>  config TPL_TEXT_BASE
>          default 0xff8c2000
>
> +config VPL_STACK
> +        default 0xff8eff00
> +
> +config VPL_TEXT_BASE
> +        default 0xff8c2000
> +
> +config VPL_LDSCRIPT
> +       default "arch/arm/mach-rockchip/u-boot-vpl-v8.lds"
> +
>  config SPL_STACK_R_ADDR
>         default 0x04000000 if !SPL_SHARES_INIT_SP_ADDR
>
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index f4d29bbdd17..305373a161c 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -61,6 +61,9 @@ u32 spl_boot_device(void)
>  {
>         u32 boot_device = BOOT_DEVICE_MMC1;
>
> +       if (IS_ENABLED(CONFIG_VPL))
> +               return BOOT_DEVICE_VBE;
> +
>  #if defined(CONFIG_TARGET_CHROMEBOOK_JERRY) || \
>                 defined(CONFIG_TARGET_CHROMEBIT_MICKEY) || \
>                 defined(CONFIG_TARGET_CHROMEBOOK_MINNIE) || \
> diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> index 6b880f19f84..cc794a7dca2 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -84,5 +84,5 @@ int board_return_to_bootrom(struct spl_image_info
> *spl_image,
>
>  u32 spl_boot_device(void)
>  {
> -       return BOOT_DEVICE_BOOTROM;
> +       return IS_ENABLED(CONFIG_VPL) ? BOOT_DEVICE_VBE :
> BOOT_DEVICE_BOOTROM;
>  }
> diff --git a/arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> b/arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> new file mode 100644
> index 00000000000..d2a5cf61581
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier:    GPL-2.0+
> +/*
> + * (C) Copyright 2019
> + * Rockchip Electronics Co., Ltd
> + * Kever Yang<kever.yang@rock-chips.com>
> + *
> + * (C) Copyright 2013
> + * David Feng <fenghua@phytium.com.cn>
> + *
> + * (C) Copyright 2002
> + * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
> + *
> + * (C) Copyright 2010
> + * Texas Instruments, <www.ti.com>
> + *     Aneesh V <aneesh@ti.com>
> + */
> +
> +OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64",
> "elf64-littleaarch64")
> +OUTPUT_ARCH(aarch64)
> +ENTRY(_start)
> +SECTIONS
> +{
> +       . = 0x00000000;
> +
> +       .text : {
> +               . = ALIGN(8);
> +               __image_copy_start = .;
> +               CPUDIR/start.o (.text*)
> +
> +               /* put relocation code all together */
> +               //. = . + 0xc0;
> +               _rcode_start = .;
> +               *(.text.rcode)
> +               *(.text.rdata)
> +               _rcode_end = .;
> +
> +               *(.text*)
> +       }
> +
> +       .rodata : {
> +               . = ALIGN(8);
> +               *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> +       }
> +
> +       .data : {
> +               . = ALIGN(8);
> +               *(.data*)
> +       }
> +
> +       __u_boot_list : {
> +               . = ALIGN(8);
> +               KEEP(*(SORT(__u_boot_list*)));
> +       }
> +
> +       .image_copy_end : {
> +               . = ALIGN(8);
> +               *(.__image_copy_end)
> +       }
> +
> +       .end : {
> +               . = ALIGN(8);
> +               *(.__end)
> +       }
> +
> +       _image_binary_end = .;
> +       _end = .;
> +       __image_copy_end = .;
> +
> +       __bss_start = .;
> +       .bss_start (NOLOAD) : {
> +               . = ALIGN(8);
> +               KEEP(*(.__bss_start));
> +       }
> +
> +       .bss (NOLOAD) : {
> +               *(.bss*)
> +                . = ALIGN(8);
> +       }
> +
> +       .bss_end (NOLOAD) : {
> +               KEEP(*(.__bss_end));
> +       }
> +       __bss_end = .;
> +       __bss_size = __bss_end - __bss_start;
> +
> +       /DISCARD/ : { *(.dynsym) }
> +       /DISCARD/ : { *(.dynstr*) }
> +       /DISCARD/ : { *(.dynamic*) }
> +       /DISCARD/ : { *(.plt*) }
> +       /DISCARD/ : { *(.interp*) }
> +       /DISCARD/ : { *(.gnu*) }
> +}
> +
> +#if defined(CONFIG_TPL_MAX_SIZE)
> +ASSERT(__image_copy_end - __image_copy_start < (CONFIG_TPL_MAX_SIZE), \
> +       "TPL image too big");
> +#endif
> +
> +#if defined(CONFIG_TPL_BSS_MAX_SIZE)
> +ASSERT(__bss_end - __bss_start < (CONFIG_TPL_BSS_MAX_SIZE), \
> +       "TPL image BSS too big");
> +#endif
> +
> +#if defined(CONFIG_TPL_MAX_FOOTPRINT)
> +ASSERT(__bss_end - _start < (CONFIG_TPL_MAX_FOOTPRINT), \
> +       "TPL image plus BSS too big");
> +#endif
> diff --git a/arch/arm/mach-rockchip/vpl.c b/arch/arm/mach-rockchip/vpl.c
> new file mode 100644
> index 00000000000..55a8dabc2da
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/vpl.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2019 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <bootstage.h>
> +#include <debug_uart.h>
> +#include <dm.h>
> +#include <hang.h>
> +#include <init.h>
> +#include <log.h>
> +#include <ram.h>
> +#include <spl.h>
> +#include <version.h>
> +#include <asm/io.h>
> +#include <asm/arch-rockchip/bootrom.h>
> +#include <linux/bitops.h>
> +
> +#if CONFIG_IS_ENABLED(BANNER_PRINT)
> +#include <timestamp.h>
> +#endif
> +
> +void board_init_f(ulong dummy)
> +{
> +       int ret;
> +
> +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_VPL_SERIAL)
> +       /*
> +        * Debug UART can be used from here if required:
> +        *
> +        * debug_uart_init();
> +        * printch('a');
> +        * printhex8(0x1234);
> +        * printascii("string");
> +        */
> +       debug_uart_init();
> +#ifdef CONFIG_VPL_BANNER_PRINT
> +       printascii("\nU-Boot VPL " PLAIN_VERSION " (" U_BOOT_DATE " - "
> +                  U_BOOT_TIME ")\n");
> +#endif
> +#endif
> +
> +       ret = spl_early_init();
> +       if (ret) {
> +               debug("spl_early_init() failed: %d\n", ret);
> +               hang();
> +       }
> +}
> +
> +u32 spl_boot_device(void)
> +{
> +       return BOOT_DEVICE_VBE;
> +}
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 85566385c21..4e89b17815d 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -572,6 +572,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
>         default 0x200 if ARCH_SOCFPGA || ARCH_AT91
>         default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>                          OMAP54XX || AM33XX || AM43XX || ARCH_K3
> +       default 0x800 if ARCH_ROCKCHIP && VPL
>         default 0x4000 if ARCH_ROCKCHIP
>         default 0x822 if TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
>         help
> --
> 2.43.0
>
>
