Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E92C54ED0
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F45282B34;
	Sun, 25 May 2025 21:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TtBftzBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1219182B37; Sun, 25 May 2025 21:19:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8641182B0E
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=671e=YK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748200752;
 bh=51jeYbLa0dk/nMYrRmVylFvbHH0RmBxK7Ct8ao+URE0=;
 b=TtBftzBBQVKqla0fXWQt43A079wbKEqVaV6enyGPJxB64fGXQgO7MiyC+c5x9WHdxl2si4LFs
 CadU9OLhbp9iQol7mWT8ySQW5PT7TPHoRON5wIW+qlv/a2hqeS6InoyfEUU6tQBizc06xXAh8bu
 81zVIPZfs1WYWDjq5j5x+fdH5NTYyN70fBQXR8ruumIm6tMoSnYauMC4d87yzkVDZfn4zXSMhqf
 pph/AJ6ym55mDeuWNyLj9hFO2A4pwDftcxEGPiqDvHVIpH8Z0/qHcwxJ/QYV/QX1JSSwXTP8oJd
 hAJn/uDIp2HAEDs/hyCXOJx75RrjQiW/kdRega7QmHmQ==
X-Forward-Email-ID: 68336d2ca0e3f2dd0ce2359a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7a0bf1d9-e5ae-4a11-862c-b8fa01b6324b@kwiboo.se>
Date: Sun, 25 May 2025 21:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/25] rockchip: Provide a VPL phase on rk3399
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Anshul Dalal
 <anshuld@ti.com>, Daniel Semkowicz <dse@thaumatec.com>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, huang lin <hl@rock-chips.com>
References: <20250525104801.1440260-1-sjg@chromium.org>
 <20250525104801.1440260-14-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250525104801.1440260-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

On 2025-05-25 12:47, Simon Glass wrote:
> Add support for this new phase, which runs after TPL. It determines the
> state of the machine, then selects which SPL image to use. 

Please mention that this new VPL phase is related to VBE.

> SDRAM init is
> then done in SPL, so that it is updatable.

DRAM init currently done in TPL is also updatable, please add more
context to what you mean by this.

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Add a value for SPL_STACK_R_ADDR
> 
> Changes in v2:
> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> - Skip spl-boot-order.c for VPL (rather than modifying it)
> 
>  arch/arm/include/asm/spl.h               |   1 +
>  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
>  arch/arm/mach-rockchip/Makefile          |  11 ++-
>  arch/arm/mach-rockchip/rk3399/Kconfig    |  12 +++
>  arch/arm/mach-rockchip/spl.c             |   3 +
>  arch/arm/mach-rockchip/tpl.c             |   2 +-
>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
>  common/spl/Kconfig                       |   1 +
>  9 files changed, 208 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>  create mode 100644 arch/arm/mach-rockchip/vpl.c
> 
> diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
> index ee79a19c05c..62844d64cab 100644
> --- a/arch/arm/include/asm/spl.h
> +++ b/arch/arm/include/asm/spl.h
> @@ -30,6 +30,7 @@ enum {
>  	BOOT_DEVICE_XIP,
>  	BOOT_DEVICE_BOOTROM,
>  	BOOT_DEVICE_SMH,
> +	BOOT_DEVICE_VBE,
>  	BOOT_DEVICE_NONE
>  };
>  #endif
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 9210877a4a4..96f73b42a8c 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -259,13 +259,15 @@ config ROCKCHIP_RK3399
>  	select SPL_ATF
>  	select SPL_BOARD_INIT if SPL
>  	select SPL_LOAD_FIT
> -	select SPL_CLK if SPL
> +	select SPL_CLK if SPL && !VPL
>  	select SPL_PINCTRL if SPL
>  	select SPL_RAM if SPL
>  	select SPL_REGMAP if SPL
>  	select SPL_SYSCON if SPL
>  	select TPL_HAVE_INIT_STACK if TPL
> -	select SPL_SEPARATE_BSS
> +	select VPL_HAVE_INIT_STACK if VPL
> +	select SPL_SEPARATE_BSS if !VPL
> +	select SPL_RAW_IMAGE_SUPPORT if VPL
>  	select CLK
>  	select FIT
>  	select PINCTRL
> @@ -275,6 +277,7 @@ config ROCKCHIP_RK3399
>  	select DM_PMIC
>  	select DM_REGULATOR_FIXED
>  	select BOARD_LATE_INIT
> +	select SUPPORT_VPL

This should be added next to the existing SUPPORT_xPL options.

>  	imply ARMV8_CRYPTO
>  	imply ARMV8_SET_SMPEN
>  	imply BOOTSTD_FULL
> @@ -304,13 +307,14 @@ config ROCKCHIP_RK3399
>  	imply TPL_LIBCOMMON_SUPPORT
>  	imply TPL_LIBGENERIC_SUPPORT
>  	imply TPL_OF_CONTROL
> -	imply TPL_RAM
> +	imply TPL_RAM if !VPL
>  	imply TPL_REGMAP
>  	imply TPL_ROCKCHIP_COMMON_BOARD
>  	imply TPL_SERIAL
>  	imply TPL_SYS_MALLOC_SIMPLE
>  	imply TPL_SYSCON
>  	imply TPL_TINY_MEMSET
> +	imply TPL_DM_MMC if VPL

All imply are in alphabetical order, please keep it.

>  	help
>  	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
>  	  and quad-core Cortex-A53.
> @@ -569,7 +573,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
>  
>  config TPL_ROCKCHIP_BACK_TO_BROM
>  	bool "TPL returns to bootrom"
> -	default y
> +	default y if !VPL
>  	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>  	select TPL_BOOTROM_SUPPORT
>  	depends on TPL
> @@ -609,6 +613,16 @@ config ROCKCHIP_EXTERNAL_TPL
>  	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
>  	  include the external TPL in the image built by binman.
>  
> +config VPL_ROCKCHIP_COMMON_BOARD
> +	bool "Rockchip VPL common board file"
> +	depends on VPL
> +	default y
> +	help
> +	  Enable the VPL phase for rockchip, which selects which SPL/U-Boot
> +	  will be used on each boot. With this flow, used by Verified Boot for
> +	  Embedded (VBE), TPL is loaded by the boot ROM. Then TPL loads VPL,
> +	  VPL loads SPL and SPL loads U-Boot.
> +

This new config option should be placed before ROCKCHIP_EXTERNAL_TPL close
to all other existing ROCKCHIP_COMMON_BOARD variants.

>  config ROCKCHIP_BOOT_MODE_REG
>  	hex "Rockchip boot mode flag register address"
>  	help
> @@ -700,6 +714,9 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
>  config SPL_MMC
>  	default y if !SPL_ROCKCHIP_BACK_TO_BROM
>  
> +config TPL_MMC
> +	default y if !TPL_ROCKCHIP_BACK_TO_BROM
> +
>  config ROCKCHIP_SPI_IMAGE
>  	bool "Build a SPI image for rockchip"
>  	help
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index ae15a9f8a2d..6cf60bc911c 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -8,11 +8,16 @@
>  # inaccessible/protected memory (and the bootrom-helper assumes that
>  # the stack-pointer is valid before switching to the U-Boot stack).
>  obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
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
> @@ -49,9 +54,11 @@ obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
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
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index 5c21b08a5ae..7b2d47fcb49 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -150,6 +150,18 @@ config TPL_STACK
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
> +	default "arch/arm/mach-rockchip/u-boot-vpl-v8.lds"

Please keep the alphabetical order with the existing config options
above.

> +
> +config SPL_STACK_R_ADDR
> +	default 0x04000000 if !SPL_SHARES_INIT_SP_ADDR

SPL_STACK_R_ADDR was removed from here with the move to use
ROCKCHIP_COMMON_STACK_ADDR for (almost) all rockchip boards.

Suggest you add this VBE/VPL specific SPL_STACK_R_ADDR to you vbe board
defconfig.

> +
>  if BOOTCOUNT_LIMIT
>  
>  config BOOTCOUNT_BOOTLIMIT
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index f4d29bbdd17..305373a161c 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -61,6 +61,9 @@ u32 spl_boot_device(void)
>  {
>  	u32 boot_device = BOOT_DEVICE_MMC1;
>  
> +	if (IS_ENABLED(CONFIG_VPL))
> +		return BOOT_DEVICE_VBE;
> +
>  #if defined(CONFIG_TARGET_CHROMEBOOK_JERRY) || \
>  		defined(CONFIG_TARGET_CHROMEBIT_MICKEY) || \
>  		defined(CONFIG_TARGET_CHROMEBOOK_MINNIE) || \
> diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> index 6b880f19f84..cc794a7dca2 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -84,5 +84,5 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
>  
>  u32 spl_boot_device(void)
>  {
> -	return BOOT_DEVICE_BOOTROM;
> +	return IS_ENABLED(CONFIG_VPL) ? BOOT_DEVICE_VBE : BOOT_DEVICE_BOOTROM;

nitpic:

Please be consistent, I would suggest you keep a similar if -> early
return as you do in spl.c above.

Regards,
Jonas

>  }
> diff --git a/arch/arm/mach-rockchip/u-boot-vpl-v8.lds b/arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> new file mode 100644
> index 00000000000..d2a5cf61581
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier:	GPL-2.0+
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
> + *	Aneesh V <aneesh@ti.com>
> + */
> +
> +OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
> +OUTPUT_ARCH(aarch64)
> +ENTRY(_start)
> +SECTIONS
> +{
> +	. = 0x00000000;
> +
> +	.text : {
> +		. = ALIGN(8);
> +		__image_copy_start = .;
> +		CPUDIR/start.o (.text*)
> +
> +		/* put relocation code all together */
> +		//. = . + 0xc0;
> +		_rcode_start = .;
> +		*(.text.rcode)
> +		*(.text.rdata)
> +		_rcode_end = .;
> +
> +		*(.text*)
> +	}
> +
> +	.rodata : {
> +		. = ALIGN(8);
> +		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> +	}
> +
> +	.data : {
> +		. = ALIGN(8);
> +		*(.data*)
> +	}
> +
> +	__u_boot_list : {
> +		. = ALIGN(8);
> +		KEEP(*(SORT(__u_boot_list*)));
> +	}
> +
> +	.image_copy_end : {
> +		. = ALIGN(8);
> +		*(.__image_copy_end)
> +	}
> +
> +	.end : {
> +		. = ALIGN(8);
> +		*(.__end)
> +	}
> +
> +	_image_binary_end = .;
> +	_end = .;
> +	__image_copy_end = .;
> +
> +	__bss_start = .;
> +	.bss_start (NOLOAD) : {
> +		. = ALIGN(8);
> +		KEEP(*(.__bss_start));
> +	}
> +
> +	.bss (NOLOAD) : {
> +		*(.bss*)
> +		 . = ALIGN(8);
> +	}
> +
> +	.bss_end (NOLOAD) : {
> +		KEEP(*(.__bss_end));
> +	}
> +	__bss_end = .;
> +	__bss_size = __bss_end - __bss_start;
> +
> +	/DISCARD/ : { *(.dynsym) }
> +	/DISCARD/ : { *(.dynstr*) }
> +	/DISCARD/ : { *(.dynamic*) }
> +	/DISCARD/ : { *(.plt*) }
> +	/DISCARD/ : { *(.interp*) }
> +	/DISCARD/ : { *(.gnu*) }
> +}
> +
> +#if defined(CONFIG_TPL_MAX_SIZE)
> +ASSERT(__image_copy_end - __image_copy_start < (CONFIG_TPL_MAX_SIZE), \
> +	"TPL image too big");
> +#endif
> +
> +#if defined(CONFIG_TPL_BSS_MAX_SIZE)
> +ASSERT(__bss_end - __bss_start < (CONFIG_TPL_BSS_MAX_SIZE), \
> +	"TPL image BSS too big");
> +#endif
> +
> +#if defined(CONFIG_TPL_MAX_FOOTPRINT)
> +ASSERT(__bss_end - _start < (CONFIG_TPL_MAX_FOOTPRINT), \
> +	"TPL image plus BSS too big");
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
> +	int ret;
> +
> +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_VPL_SERIAL)
> +	/*
> +	 * Debug UART can be used from here if required:
> +	 *
> +	 * debug_uart_init();
> +	 * printch('a');
> +	 * printhex8(0x1234);
> +	 * printascii("string");
> +	 */
> +	debug_uart_init();
> +#ifdef CONFIG_VPL_BANNER_PRINT
> +	printascii("\nU-Boot VPL " PLAIN_VERSION " (" U_BOOT_DATE " - "
> +		   U_BOOT_TIME ")\n");
> +#endif
> +#endif
> +
> +	ret = spl_early_init();
> +	if (ret) {
> +		debug("spl_early_init() failed: %d\n", ret);
> +		hang();
> +	}
> +}
> +
> +u32 spl_boot_device(void)
> +{
> +	return BOOT_DEVICE_VBE;
> +}
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index a84a0f83924..fb6c90733ee 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -582,6 +582,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
>  	default 0x200 if ARCH_SOCFPGA || ARCH_AT91
>  	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>  		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
> +	default 0x800 if ARCH_ROCKCHIP && VPL
>  	default 0x4000 if ARCH_ROCKCHIP
>  	default 0x822 if TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
>  	help

