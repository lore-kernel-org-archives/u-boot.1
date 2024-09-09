Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40818CE7AB0
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 05:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA7888A1D;
	Mon,  9 Sep 2024 07:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BLFZt/vD";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="Sn4CfjuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA9688BBE; Mon,  9 Sep 2024 07:49:12 +0200 (CEST)
Received: from a7-41.smtp-out.eu-west-1.amazonses.com
 (a7-41.smtp-out.eu-west-1.amazonses.com [54.240.7.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3840388995
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 07:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020191d55419f4-a227619d-862f-4a38-8189-201657cba472-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725860944;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=38rLAcO9/Q1uTzwrmY3xPE1fllMbBedvxNCAT6sPWVM=;
 b=BLFZt/vDKPXCbHu/5mEAnaTOeYvUqH9OToMkVJdUpQtsQcxb8u8PBNcHocVGFaW6
 qQZ8E6/e6n2QZy9lLWeNVfLfbr0bt79myqywTke2zBWXcdj93L5hCN6lgU6rlmh2swy
 sNqUj1qFXPw7OYieckmCxLoLLmCnLVYC7F1PXrgPEhgCPYxDn718n3faUaZ2Fz8oTMn
 EMUBfqSVjLQqeEcZMK84vCWcQ67id04OqxKxmVnYyeNQ038Tqw3CdFzvQK6yG4LN6Nr
 OP5XojjLT+d8rnVtmCAg/Z96vjHh/VVh3q57Z/rXhvsx4UbKodxBDN8nRgNw7Q7/9/L
 8wpdN40g4A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725860944;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=38rLAcO9/Q1uTzwrmY3xPE1fllMbBedvxNCAT6sPWVM=;
 b=Sn4CfjuWANVmUfsLO0r9ZTqWKP4P3f1ywy07w0GePaONQxLxnZZodpRlGjMyupZ2
 bMdh7i2tTai6CMwKnfY7Vr9czheR9ZK+Xn5bPVptvJkJcez/7AJhfGBUJb2IkoVLJ8w
 8VBmmBBca+WRJVKJiJFZOIvN9iTpdFnR8K1DydiQ=
Message-ID: <01020191d55419f4-a227619d-862f-4a38-8189-201657cba472-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 05:49:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove ethernut5 board
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Harald Kipp <harald.kipp@egnite.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240907222013.10298-1-trini@konsulko.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240907222013.10298-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.41
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

On 9/8/24 01:20, Tom Rini wrote:
> As per the maintainers at egnite GmbH, they are no longer interested in
> supporting this board. Go and remove the platform here. Furthermore,
> this is the only AT91SAM9XE platform in-tree so remove supporting code
> for that as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Harald Kipp <harald.kipp@egnite.de>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>

CC: Alexandre Belloni, Nicolas Ferre

> ---
>  arch/arm/dts/Makefile                         |   2 -
>  arch/arm/dts/at91sam9xe.dtsi                  |  60 ----
>  arch/arm/dts/ethernut5.dts                    |  96 ------
>  arch/arm/mach-at91/Kconfig                    |  24 --
>  arch/arm/mach-at91/arm926ejs/Makefile         |   2 -
>  arch/arm/mach-at91/arm926ejs/eflash.c         | 255 --------------
>  arch/arm/mach-at91/include/mach/at91_dbu.h    |  37 --
>  arch/arm/mach-at91/include/mach/at91_eefc.h   |  47 ---
>  arch/arm/mach-at91/include/mach/at91sam9260.h |  12 +-
>  arch/arm/mach-at91/include/mach/hardware.h    |   3 +-
>  board/egnite/ethernut5/Kconfig                |  12 -
>  board/egnite/ethernut5/MAINTAINERS            |   6 -
>  board/egnite/ethernut5/Makefile               |  10 -
>  board/egnite/ethernut5/ethernut5.c            | 198 -----------
>  board/egnite/ethernut5/ethernut5_pwrman.c     | 323 ------------------
>  board/egnite/ethernut5/ethernut5_pwrman.h     |  51 ---
>  configs/ethernut5_defconfig                   |  87 -----
>  doc/board/atmel/at91ek.rst                    |   4 +-
>  drivers/bootcount/Kconfig                     |   1 -
>  include/configs/at91sam9260ek.h               |   6 +-
>  include/configs/ethernut5.h                   |  88 -----
>  21 files changed, 6 insertions(+), 1318 deletions(-)
>  delete mode 100644 arch/arm/dts/at91sam9xe.dtsi
>  delete mode 100644 arch/arm/dts/ethernut5.dts
>  delete mode 100644 arch/arm/mach-at91/arm926ejs/eflash.c
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_dbu.h
>  delete mode 100644 arch/arm/mach-at91/include/mach/at91_eefc.h
>  delete mode 100644 board/egnite/ethernut5/Kconfig
>  delete mode 100644 board/egnite/ethernut5/MAINTAINERS
>  delete mode 100644 board/egnite/ethernut5/Makefile
>  delete mode 100644 board/egnite/ethernut5/ethernut5.c
>  delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.c
>  delete mode 100644 board/egnite/ethernut5/ethernut5_pwrman.h
>  delete mode 100644 configs/ethernut5_defconfig
>  delete mode 100644 include/configs/ethernut5.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 64007a20e6cc..56d4af518d80 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -987,8 +987,6 @@ dtb-$(CONFIG_TARGET_AT91SAM9N12EK) += at91sam9n12ek.dtb
>  dtb-$(CONFIG_TARGET_GARDENA_SMART_GATEWAY_AT91SAM) += \
>  	at91sam9g25-gardena-smart-gateway.dtb
>  
> -dtb-$(CONFIG_TARGET_ETHERNUT5) += ethernut5.dtb
> -
>  dtb-$(CONFIG_TARGET_USB_A9263) += usb_a9263.dtb
>  
>  dtb-$(CONFIG_TARGET_DEVKIT8000) += omap3-devkit8000.dtb
> diff --git a/arch/arm/dts/at91sam9xe.dtsi b/arch/arm/dts/at91sam9xe.dtsi
> deleted file mode 100644
> index 0278f63b2daf..000000000000
> --- a/arch/arm/dts/at91sam9xe.dtsi
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/*
> - * at91sam9xe.dtsi - Device Tree Include file for AT91SAM9XE family SoC
> - *
> - *  Copyright (C) 2015 Atmel,
> - *                2015 Alexandre Belloni <alexandre.Belloni@free-electrons.com>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#include "at91sam9260.dtsi"
> -
> -/ {
> -	model = "Atmel AT91SAM9XE family SoC";
> -	compatible = "atmel,at91sam9xe", "atmel,at91sam9260";
> -
> -	sram0: sram@002ff000 {
> -		status = "disabled";
> -	};
> -
> -	sram1: sram@00300000 {
> -		compatible = "mmio-sram";
> -		reg = <0x00300000 0x4000>;
> -	};
> -};
> diff --git a/arch/arm/dts/ethernut5.dts b/arch/arm/dts/ethernut5.dts
> deleted file mode 100644
> index 5c24deaf4b64..000000000000
> --- a/arch/arm/dts/ethernut5.dts
> +++ /dev/null
> @@ -1,96 +0,0 @@
> -/*
> - * ethernut5.dts - Device Tree file for Ethernut 5 board
> - *
> - * Copyright (C) 2012 egnite GmbH <info@egnite.de>
> - *
> - * Licensed under GPLv2.
> - */
> -/dts-v1/;
> -#include "at91sam9xe.dtsi"
> -
> -/ {
> -	model = "Ethernut 5";
> -	compatible = "egnite,ethernut5", "atmel,at91sam9260", "atmel,at91sam9";
> -
> -	chosen {
> -		bootargs = "console=ttyS0,115200 root=/dev/mtdblock0 rw rootfstype=jffs2";
> -	};
> -
> -	memory {
> -		reg = <0x20000000 0x08000000>;
> -	};
> -
> -	clocks {
> -		slow_xtal {
> -			clock-frequency = <32768>;
> -		};
> -
> -		main_xtal {
> -			clock-frequency = <18432000>;
> -		};
> -	};
> -
> -	ahb {
> -		apb {
> -			dbgu: serial@fffff200 {
> -				status = "okay";
> -			};
> -
> -			usart0: serial@fffb0000 {
> -				status = "okay";
> -			};
> -
> -			usart1: serial@fffb4000 {
> -				status = "okay";
> -			};
> -
> -			macb0: ethernet@fffc4000 {
> -				phy-mode = "rmii";
> -				status = "okay";
> -			};
> -
> -			usb1: gadget@fffa4000 {
> -				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
> -				status = "okay";
> -			};
> -		};
> -
> -		nand0: nand@40000000 {
> -			nand-bus-width = <8>;
> -			nand-ecc-mode = "soft";
> -			nand-on-flash-bbt;
> -			status = "okay";
> -
> -			gpios = <0
> -				 &pioC 14 GPIO_ACTIVE_HIGH
> -				 0
> -				>;
> -
> -			root@0 {
> -				label = "root";
> -				reg = <0x0 0x08000000>;
> -			};
> -
> -			data@20000 {
> -				label = "data";
> -				reg = <0x08000000 0x38000000>;
> -			};
> -		};
> -
> -		usb0: ohci@00500000 {
> -			num-ports = <2>;
> -			status = "okay";
> -		};
> -	};
> -
> -	i2c-gpio-0 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "okay";
> -
> -		pcf8563@50 {
> -			compatible = "nxp,pcf8563";
> -			reg = <0x51>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 8a8ac53e4f86..7c4ccc427c87 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -11,10 +11,6 @@ config AT91SAM9G20
>  	bool
>  	select CPU_ARM926EJS
>  
> -config AT91SAM9XE
> -	bool
> -	select CPU_ARM926EJS
> -
>  config AT91SAM9261
>  	bool
>  	select CPU_ARM926EJS
> @@ -75,10 +71,6 @@ config TARGET_AT91SAM9260EK
>  	select AT91SAM9260
>  	select BOARD_EARLY_INIT_F
>  
> -config TARGET_ETHERNUT5
> -	bool "Ethernut5 board"
> -	select AT91SAM9XE
> -
>  config TARGET_GURNARD
>  	bool "Support gurnard"
>  	select AT91SAM9G45
> @@ -340,21 +332,6 @@ config AT91RESET_EXTRST
>  config SYS_SOC
>  	default "at91"
>  
> -config AT91_EFLASH
> -	bool "Support AT91 flash driver"
> -	depends on AT91SAM9XE
> -	select USE_SYS_MAX_FLASH_BANKS
> -	help
> -	  Enable the driver for the embedded flash used in the Atmel
> -	  AT91SAM9XE devices.
> -
> -config EFLASH_PROTSECTORS
> -	int "Number of flash sectors to protect from erasing"
> -	depends on AT91_EFLASH
> -	help
> -	  If non-zero, this will be the number of sectors of the flash to disallow
> -	  U-Boot to ease, starting from the beginning of flash.
> -
>  config AT91_GPIO_PULLUP
>  	bool "Keep pullups on peripheral pins"
>  	depends on CPU_ARM926EJS
> @@ -389,7 +366,6 @@ source "board/atmel/sama5d4ek/Kconfig"
>  source "board/bluewater/gurnard/Kconfig"
>  source "board/calao/usb_a9263/Kconfig"
>  source "board/conclusive/kstr-sama5d27/Kconfig"
> -source "board/egnite/ethernut5/Kconfig"
>  source "board/esd/meesc/Kconfig"
>  source "board/gardena/smart-gateway-at91sam/Kconfig"
>  source "board/l+g/vinco/Kconfig"
> diff --git a/arch/arm/mach-at91/arm926ejs/Makefile b/arch/arm/mach-at91/arm926ejs/Makefile
> index 902dd3a60e3b..a8916862b3f5 100644
> --- a/arch/arm/mach-at91/arm926ejs/Makefile
> +++ b/arch/arm/mach-at91/arm926ejs/Makefile
> @@ -5,7 +5,6 @@
>  
>  obj-$(CONFIG_AT91SAM9260)	+= at91sam9260_devices.o
>  obj-$(CONFIG_AT91SAM9G20)	+= at91sam9260_devices.o
> -obj-$(CONFIG_AT91SAM9XE)	+= at91sam9260_devices.o
>  obj-$(CONFIG_AT91SAM9261)	+= at91sam9261_devices.o
>  obj-$(CONFIG_AT91SAM9G10)	+= at91sam9261_devices.o
>  obj-$(CONFIG_AT91SAM9263)	+= at91sam9263_devices.o
> @@ -15,7 +14,6 @@ obj-$(CONFIG_AT91SAM9G45)	+= at91sam9m10g45_devices.o
>  obj-$(CONFIG_AT91SAM9N12)	+= at91sam9n12_devices.o
>  obj-$(CONFIG_AT91SAM9X5)	+= at91sam9x5_devices.o
>  obj-$(CONFIG_SAM9X60)		+= sam9x60_devices.o
> -obj-$(CONFIG_AT91_EFLASH)	+= eflash.o
>  obj-y += clock.o
>  obj-y += cpu.o
>  ifndef CONFIG_$(SPL_TPL_)SYSRESET
> diff --git a/arch/arm/mach-at91/arm926ejs/eflash.c b/arch/arm/mach-at91/arm926ejs/eflash.c
> deleted file mode 100644
> index bb66700566e5..000000000000
> --- a/arch/arm/mach-at91/arm926ejs/eflash.c
> +++ /dev/null
> @@ -1,255 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2010
> - * Reinhard Meyer, EMK Elektronik, reinhard.meyer@emk-elektronik.de
> - */
> -
> -/*
> - * this driver supports the enhanced embedded flash in the Atmel
> - * AT91SAM9XE devices with the following geometry:
> - *
> - * AT91SAM9XE128: 1 plane of  8 regions of 32 pages (total  256 pages)
> - * AT91SAM9XE256: 1 plane of 16 regions of 32 pages (total  512 pages)
> - * AT91SAM9XE512: 1 plane of 32 regions of 32 pages (total 1024 pages)
> - * (the exact geometry is read from the flash at runtime, so any
> - *  future devices should already be covered)
> - *
> - * Regions can be write/erase protected.
> - * Whole (!) pages can be individually written with erase on the fly.
> - * Writing partial pages will corrupt the rest of the page.
> - *
> - * The flash is presented to u-boot with each region being a sector,
> - * having the following effects:
> - * Each sector can be hardware protected (protect on/off).
> - * Each page in a sector can be rewritten anytime.
> - * Since pages are erased when written, the "erase" does nothing.
> - * The first "CONFIG_EFLASH_PROTSECTORS" cannot be unprotected
> - * by u-Boot commands.
> - *
> - * Note: Redundant environment will not work in this flash since
> - * it does use partial page writes. Make sure the environment spans
> - * whole pages!
> - */
> -
> -/*
> - * optional TODOs (nice to have features):
> - *
> - * make the driver coexist with other NOR flash drivers
> - *	(use an index into flash_info[], requires work
> - *	in those other drivers, too)
> - * Make the erase command fill the sectors with 0xff
> - *	(if the flashes grow larger in the future and
> - *	someone puts a jffs2 into them)
> - * do a read-modify-write for partially programmed pages
> - */
> -#include <display_options.h>
> -#include <flash.h>
> -#include <log.h>
> -#include <asm/io.h>
> -#include <asm/arch/hardware.h>
> -#include <asm/arch/at91_common.h>
> -#include <asm/arch/at91_eefc.h>
> -#include <asm/arch/at91_dbu.h>
> -
> -/* checks to detect configuration errors */
> -#if CONFIG_SYS_MAX_FLASH_BANKS!=1
> -#error eflash: this driver can only handle 1 bank
> -#endif
> -
> -/* global structure */
> -flash_info_t flash_info[CONFIG_SYS_MAX_FLASH_BANKS];
> -static u32 pagesize;
> -
> -unsigned long flash_init(void)
> -{
> -	at91_eefc_t *eefc = (at91_eefc_t *) ATMEL_BASE_EEFC;
> -	at91_dbu_t *dbu = (at91_dbu_t *) ATMEL_BASE_DBGU;
> -	u32 id, size, nplanes, planesize, nlocks;
> -	u32 addr, i, tmp=0;
> -
> -	debug("eflash: init\n");
> -
> -	flash_info[0].flash_id = FLASH_UNKNOWN;
> -
> -	/* check if its an AT91ARM9XE SoC */
> -	if ((readl(&dbu->cidr) & AT91_DBU_CID_ARCH_MASK) != AT91_DBU_CID_ARCH_9XExx) {
> -		puts("eflash: not an AT91SAM9XE\n");
> -		return 0;
> -	}
> -
> -	/* now query the eflash for its structure */
> -	writel(AT91_EEFC_FCR_KEY | AT91_EEFC_FCR_FCMD_GETD, &eefc->fcr);
> -	while ((readl(&eefc->fsr) & AT91_EEFC_FSR_FRDY) == 0)
> -		;
> -	id = readl(&eefc->frr);		/* word 0 */
> -	size = readl(&eefc->frr);	/* word 1 */
> -	pagesize = readl(&eefc->frr);	/* word 2 */
> -	nplanes = readl(&eefc->frr);	/* word 3 */
> -	planesize = readl(&eefc->frr);	/* word 4 */
> -	debug("id=%08x size=%u pagesize=%u planes=%u planesize=%u\n",
> -		id, size, pagesize, nplanes, planesize);
> -	for (i=1; i<nplanes; i++) {
> -		tmp = readl(&eefc->frr);	/* words 5..4+nplanes-1 */
> -	};
> -	nlocks = readl(&eefc->frr);	/* word 4+nplanes */
> -	debug("nlocks=%u\n", nlocks);
> -	/* since we are going to use the lock regions as sectors, check count */
> -	if (nlocks > CONFIG_SYS_MAX_FLASH_SECT) {
> -		printf("eflash: number of lock regions(%u) "\
> -			"> CONFIG_SYS_MAX_FLASH_SECT. reducing...\n",
> -			nlocks);
> -		nlocks = CONFIG_SYS_MAX_FLASH_SECT;
> -	}
> -	flash_info[0].size = size;
> -	flash_info[0].sector_count = nlocks;
> -	flash_info[0].flash_id = id;
> -
> -	addr = ATMEL_BASE_FLASH;
> -	for (i=0; i<nlocks; i++) {
> -		tmp = readl(&eefc->frr);	/* words 4+nplanes+1.. */
> -		flash_info[0].start[i] = addr;
> -		flash_info[0].protect[i] = 0;
> -		addr += tmp;
> -	};
> -
> -	/* now read the protection information for all regions */
> -	writel(AT91_EEFC_FCR_KEY | AT91_EEFC_FCR_FCMD_GLB, &eefc->fcr);
> -	while ((readl(&eefc->fsr) & AT91_EEFC_FSR_FRDY) == 0)
> -		;
> -	for (i=0; i<flash_info[0].sector_count; i++) {
> -		if (i%32 == 0)
> -			tmp = readl(&eefc->frr);
> -		flash_info[0].protect[i] = (tmp >> (i%32)) & 1;
> -#if CONFIG_VAL(EFLASH_PROTSECTORS)
> -		if (i < CONFIG_EFLASH_PROTSECTORS)
> -			flash_info[0].protect[i] = 1;
> -#endif
> -	}
> -
> -	return size;
> -}
> -
> -void flash_print_info(flash_info_t *info)
> -{
> -	int i;
> -
> -	puts("AT91SAM9XE embedded flash\n  Size: ");
> -	print_size(info->size, " in ");
> -	printf("%d Sectors\n", info->sector_count);
> -
> -	printf("  Sector Start Addresses:");
> -	for (i=0; i<info->sector_count; ++i) {
> -		if ((i % 5) == 0)
> -			printf("\n   ");
> -		printf(" %08lX%s",
> -			info->start[i],
> -			info->protect[i] ? " (RO)" : "     "
> -		);
> -	}
> -	printf ("\n");
> -	return;
> -}
> -
> -int flash_real_protect (flash_info_t *info, long sector, int prot)
> -{
> -	at91_eefc_t *eefc = (at91_eefc_t *) ATMEL_BASE_EEFC;
> -	u32 pagenum = (info->start[sector]-ATMEL_BASE_FLASH)/pagesize;
> -	u32 i, tmp=0;
> -
> -	debug("protect sector=%ld prot=%d\n", sector, prot);
> -
> -#if CONFIG_VAL(EFLASH_PROTSECTORS)
> -	if (sector < CONFIG_EFLASH_PROTSECTORS) {
> -		if (!prot) {
> -			printf("eflash: sector %lu cannot be unprotected\n",
> -				sector);
> -		}
> -		return 1; /* return anyway, caller does not care for result */
> -	}
> -#endif
> -	if (prot) {
> -		writel(AT91_EEFC_FCR_KEY | AT91_EEFC_FCR_FCMD_SLB |
> -			(pagenum << AT91_EEFC_FCR_FARG_SHIFT), &eefc->fcr);
> -	} else {
> -		writel(AT91_EEFC_FCR_KEY | AT91_EEFC_FCR_FCMD_CLB |
> -			(pagenum << AT91_EEFC_FCR_FARG_SHIFT), &eefc->fcr);
> -	}
> -	while ((readl(&eefc->fsr) & AT91_EEFC_FSR_FRDY) == 0)
> -		;
> -	/* now re-read the protection information for all regions */
> -	writel(AT91_EEFC_FCR_KEY | AT91_EEFC_FCR_FCMD_GLB, &eefc->fcr);
> -	while ((readl(&eefc->fsr) & AT91_EEFC_FSR_FRDY) == 0)
> -		;
> -	for (i=0; i<info->sector_count; i++) {
> -		if (i%32 == 0)
> -			tmp = readl(&eefc->frr);
> -		info->protect[i] = (tmp >> (i%32)) & 1;
> -	}
> -	return 0;
> -}
> -
> -static u32 erase_write_page (u32 pagenum)
> -{
> -	at91_eefc_t *eefc = (at91_eefc_t *) ATMEL_BASE_EEFC;
> -
> -	debug("erase+write page=%u\n", pagenum);
> -
> -	/* give erase and write page command */
> -	writel(AT91_EEFC_FCR_KEY | AT91_EEFC_FCR_FCMD_EWP |
> -		(pagenum << AT91_EEFC_FCR_FARG_SHIFT), &eefc->fcr);
> -	while ((readl(&eefc->fsr) & AT91_EEFC_FSR_FRDY) == 0)
> -		;
> -	/* return status */
> -	return readl(&eefc->fsr)
> -		& (AT91_EEFC_FSR_FCMDE | AT91_EEFC_FSR_FLOCKE);
> -}
> -
> -int flash_erase(flash_info_t *info, int s_first, int s_last)
> -{
> -	debug("erase first=%d last=%d\n", s_first, s_last);
> -	puts("this flash does not need and support erasing!\n");
> -	return 0;
> -}
> -
> -/*
> - * Copy memory to flash, returns:
> - * 0 - OK
> - * 1 - write timeout
> - */
> -
> -int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
> -{
> -	u32 pagenum;
> -	u32 *src32, *dst32;
> -	u32 i;
> -
> -	debug("write src=%08lx addr=%08lx cnt=%lx\n",
> -		(ulong)src, addr, cnt);
> -
> -	/* REQUIRE addr to be on a page start, abort if not */
> -	if (addr % pagesize) {
> -		printf ("eflash: start %08lx is not on page start\n"\
> -			"        write aborted\n", addr);
> -		return 1;
> -	}
> -
> -	/* now start copying data */
> -	pagenum = (addr-ATMEL_BASE_FLASH)/pagesize;
> -	src32 = (u32 *) src;
> -	dst32 = (u32 *) addr;
> -	while (cnt > 0) {
> -		i = pagesize / 4;
> -		/* fill page buffer */
> -		while (i--)
> -			*dst32++ = *src32++;
> -		/* write page */
> -		if (erase_write_page(pagenum))
> -			return 1;
> -		pagenum++;
> -		if (cnt > pagesize)
> -			cnt -= pagesize;
> -		else
> -			cnt = 0;
> -	}
> -	return 0;
> -}
> diff --git a/arch/arm/mach-at91/include/mach/at91_dbu.h b/arch/arm/mach-at91/include/mach/at91_dbu.h
> deleted file mode 100644
> index 91bb686bc10a..000000000000
> --- a/arch/arm/mach-at91/include/mach/at91_dbu.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2010
> - * Reinhard Meyer, reinhard.meyer@emk-elektronik.de
> - *
> - * Debug Unit
> - * Based on AT91SAM9XE datasheet
> - */
> -
> -#ifndef AT91_DBU_H
> -#define AT91_DBU_H
> -
> -#ifndef __ASSEMBLY__
> -
> -typedef struct at91_dbu {
> -	u32	cr;	/* Control Register WO */
> -	u32	mr;	/* Mode Register  RW */
> -	u32	ier;	/* Interrupt Enable Register WO */
> -	u32	idr;	/* Interrupt Disable Register WO */
> -	u32	imr;	/* Interrupt Mask Register RO */
> -	u32	sr;	/* Status Register RO */
> -	u32	rhr;	/* Receive Holding Register RO */
> -	u32	thr;	/* Transmit Holding Register WO */
> -	u32	brgr;	/* Baud Rate Generator Register RW */
> -	u32	res1[7];/* 0x0024 - 0x003C Reserved */
> -	u32	cidr;	/* Chip ID Register RO */
> -	u32	exid;	/* Chip ID Extension Register RO */
> -	u32	fnr;	/* Force NTRST Register RW */
> -} at91_dbu_t;
> -
> -#endif /* __ASSEMBLY__ */
> -
> -#define AT91_DBU_CID_ARCH_MASK		0x0ff00000
> -#define AT91_DBU_CID_ARCH_9xx		0x01900000
> -#define AT91_DBU_CID_ARCH_9XExx	0x02900000
> -
> -#endif
> diff --git a/arch/arm/mach-at91/include/mach/at91_eefc.h b/arch/arm/mach-at91/include/mach/at91_eefc.h
> deleted file mode 100644
> index e7bb2bfecbad..000000000000
> --- a/arch/arm/mach-at91/include/mach/at91_eefc.h
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2010
> - * Reinhard Meyer, reinhard.meyer@emk-elektronik.de
> - *
> - * Enhanced Embedded Flash Controller
> - * Based on AT91SAM9XE datasheet
> - */
> -
> -#ifndef AT91_EEFC_H
> -#define AT91_EEFC_H
> -
> -#ifndef __ASSEMBLY__
> -
> -typedef struct at91_eefc {
> -	u32	fmr;	/* Flash Mode Register RW */
> -	u32	fcr;	/* Flash Command Register WO */
> -	u32	fsr;	/* Flash Status Register RO */
> -	u32	frr;	/* Flash Result Register RO */
> -} at91_eefc_t;
> -
> -#endif /* __ASSEMBLY__ */
> -
> -#define AT91_EEFC_FMR_FWS_MASK	0x00000f00
> -#define AT91_EEFC_FMR_FRDY_BIT	0x00000001
> -
> -#define AT91_EEFC_FCR_KEY		0x5a000000
> -#define AT91_EEFC_FCR_FARG_MASK	0x00ffff00
> -#define AT91_EEFC_FCR_FARG_SHIFT	8
> -#define AT91_EEFC_FCR_FCMD_GETD	0x0
> -#define AT91_EEFC_FCR_FCMD_WP		0x1
> -#define AT91_EEFC_FCR_FCMD_WPL		0x2
> -#define AT91_EEFC_FCR_FCMD_EWP		0x3
> -#define AT91_EEFC_FCR_FCMD_EWPL	0x4
> -#define AT91_EEFC_FCR_FCMD_EA		0x5
> -#define AT91_EEFC_FCR_FCMD_SLB		0x8
> -#define AT91_EEFC_FCR_FCMD_CLB		0x9
> -#define AT91_EEFC_FCR_FCMD_GLB		0xA
> -#define AT91_EEFC_FCR_FCMD_SGPB	0xB
> -#define AT91_EEFC_FCR_FCMD_CGPB	0xC
> -#define AT91_EEFC_FCR_FCMD_GGPB	0xD
> -
> -#define AT91_EEFC_FSR_FRDY	1
> -#define AT91_EEFC_FSR_FCMDE	2
> -#define AT91_EEFC_FSR_FLOCKE	4
> -
> -#endif
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
> index 103db2695335..bdd46ee0eaed 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9260.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
> @@ -7,7 +7,7 @@
>   * Reinhard Meyer, EMK Elektronik, reinhard.meyer@emk-elektronik.de
>   *
>   * Definitions for the SoCs:
> - * AT91SAM9260, AT91SAM9G20, AT91SAM9XE
> + * AT91SAM9260, AT91SAM9G20
>   *
>   * Note that those SoCs are mostly software and pin compatible,
>   * therefore this file applies to all of them. Differences between
> @@ -142,15 +142,7 @@
>  /*
>   * SoC specific defines
>   */
> -#if defined(CONFIG_AT91SAM9XE)
> -# define ATMEL_CPU_NAME		"AT91SAM9XE"
> -# define ATMEL_ID_TWI1		25	/* TWI 1 */
> -# define ATMEL_BASE_FLASH	0x00200000	/* Internal FLASH */
> -# define ATMEL_BASE_SRAM	0x00300000	/* Internal SRAM */
> -# define ATMEL_BASE_TWI1	0xfffd8000
> -# define ATMEL_BASE_EEFC	0xfffffa00
> -# define ATMEL_BASE_GPBR	0xfffffd60
> -#elif defined(CONFIG_AT91SAM9260)
> +#if defined(CONFIG_AT91SAM9260)
>  # define ATMEL_CPU_NAME		"AT91SAM9260"
>  # define ATMEL_ID_USART5	25	/* USART 5 */
>  # define ATMEL_BASE_SRAM0	0x00200000	/* Internal SRAM 0 */
> diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
> index 0a16c8ff088b..988ef492b62f 100644
> --- a/arch/arm/mach-at91/include/mach/hardware.h
> +++ b/arch/arm/mach-at91/include/mach/hardware.h
> @@ -9,8 +9,7 @@
>  
>  #if defined(CONFIG_AT91RM9200)
>  # include <asm/arch/at91rm9200.h>
> -#elif defined(CONFIG_AT91SAM9260) || defined(CONFIG_AT91SAM9G20) || \
> -	defined(CONFIG_AT91SAM9XE)
> +#elif defined(CONFIG_AT91SAM9260) || defined(CONFIG_AT91SAM9G20)
>  # include <asm/arch/at91sam9260.h>
>  #elif defined(CONFIG_AT91SAM9261) || defined(CONFIG_AT91SAM9G10)
>  # include <asm/arch/at91sam9261.h>
> diff --git a/board/egnite/ethernut5/Kconfig b/board/egnite/ethernut5/Kconfig
> deleted file mode 100644
> index 5a6c1c5de1fa..000000000000
> --- a/board/egnite/ethernut5/Kconfig
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -if TARGET_ETHERNUT5
> -
> -config SYS_BOARD
> -	default "ethernut5"
> -
> -config SYS_VENDOR
> -	default "egnite"
> -
> -config SYS_CONFIG_NAME
> -	default "ethernut5"
> -
> -endif
> diff --git a/board/egnite/ethernut5/MAINTAINERS b/board/egnite/ethernut5/MAINTAINERS
> deleted file mode 100644
> index a4ad913b630e..000000000000
> --- a/board/egnite/ethernut5/MAINTAINERS
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -ETHERNUT5 BOARD
> -M:	egnite GmbH <info@egnite.de>
> -S:	Maintained
> -F:	board/egnite/ethernut5/
> -F:	include/configs/ethernut5.h
> -F:	configs/ethernut5_defconfig
> diff --git a/board/egnite/ethernut5/Makefile b/board/egnite/ethernut5/Makefile
> deleted file mode 100644
> index 580f440564e1..000000000000
> --- a/board/egnite/ethernut5/Makefile
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# (C) Copyright 2003-2008
> -# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> -#
> -# (C) Copyright 2010
> -# egnite GmbH
> -
> -obj-y	+= ethernut5.o
> -obj-y	+= ethernut5_pwrman.o
> diff --git a/board/egnite/ethernut5/ethernut5.c b/board/egnite/ethernut5/ethernut5.c
> deleted file mode 100644
> index 64e341c3779c..000000000000
> --- a/board/egnite/ethernut5/ethernut5.c
> +++ /dev/null
> @@ -1,198 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2011
> - * egnite GmbH <info@egnite.de>
> - *
> - * (C) Copyright 2010
> - * Ole Reinhardt <ole.reinhardt@thermotemp.de>
> - */
> -
> -/*
> - * Ethernut 5 general board support
> - *
> - * Ethernut is an open source hardware and software project for
> - * embedded Ethernet devices. Hardware layouts and CAD files are
> - * freely available under BSD-like license.
> - *
> - * Ethernut 5 is the first member of the Ethernut board family
> - * with U-Boot and Linux support. This implementation is based
> - * on the original work done by Ole Reinhardt, but heavily modified
> - * to support additional features and the latest board revision 5.0F.
> - *
> - * Main board components are by default:
> - *
> - * Atmel AT91SAM9XE512 CPU with 512 kBytes NOR Flash
> - * 2 x 64 MBytes Micron MT48LC32M16A2P SDRAM
> - * 512 MBytes Micron MT29F4G08ABADA NAND Flash
> - * 4 MBytes Atmel AT45DB321D DataFlash
> - * SMSC LAN8710 Ethernet PHY
> - * Atmel ATmega168 MCU used for power management
> - * Linear Technology LTC4411 PoE controller
> - *
> - * U-Boot relevant board interfaces are:
> - *
> - * 100 Mbit Ethernet with IEEE 802.3af PoE
> - * RS-232 serial port
> - * USB host and device
> - * MMC/SD-Card slot
> - * Expansion port with I2C, SPI and more...
> - *
> - * Typically the U-Boot image is loaded from serial DataFlash into
> - * SDRAM by the samboot boot loader, which is located in internal
> - * NOR Flash and provides all essential initializations like CPU
> - * and peripheral clocks and, of course, the SDRAM configuration.
> - *
> - * For testing purposes it is also possibly to directly transfer
> - * the image into SDRAM via JTAG. A tested configuration exists
> - * for the Turtelizer 2 hardware dongle and the OpenOCD software.
> - * In this case the latter will do the basic hardware configuration
> - * via its reset-init script.
> - *
> - * For additional information visit the project home page at
> - * http://www.ethernut.de/
> - */
> -
> -#include <config.h>
> -#include <init.h>
> -#include <net.h>
> -#include <netdev.h>
> -#include <miiphy.h>
> -#include <i2c.h>
> -#include <mmc.h>
> -#include <atmel_mci.h>
> -#include <asm/global_data.h>
> -
> -#include <asm/arch/at91sam9260.h>
> -#include <asm/arch/at91sam9260_matrix.h>
> -#include <asm/arch/at91sam9_smc.h>
> -#include <asm/arch/at91_common.h>
> -#include <asm/arch/clk.h>
> -#include <asm/arch/gpio.h>
> -#include <asm/io.h>
> -#include <asm/gpio.h>
> -
> -#include "ethernut5_pwrman.h"
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -/*
> - * This is called last during early initialization. Most of the basic
> - * hardware interfaces are up and running.
> - *
> - * The SDRAM hardware has been configured by the first stage boot loader.
> - * We only need to announce its size, using u-boot's memory check.
> - */
> -int dram_init(void)
> -{
> -	gd->ram_size = get_ram_size(
> -			(void *)CFG_SYS_SDRAM_BASE,
> -			CFG_SYS_SDRAM_SIZE);
> -	return 0;
> -}
> -
> -#ifdef CONFIG_CMD_NAND
> -static void ethernut5_nand_hw_init(void)
> -{
> -	struct at91_smc *smc = (struct at91_smc *)ATMEL_BASE_SMC;
> -	struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
> -	unsigned long csa;
> -
> -	/* Assign CS3 to NAND/SmartMedia Interface */
> -	csa = readl(&matrix->ebicsa);
> -	csa |= AT91_MATRIX_CS3A_SMC_SMARTMEDIA;
> -	writel(csa, &matrix->ebicsa);
> -
> -	/* Configure SMC CS3 for NAND/SmartMedia */
> -	writel(AT91_SMC_SETUP_NWE(1) | AT91_SMC_SETUP_NCS_WR(0) |
> -		AT91_SMC_SETUP_NRD(1) | AT91_SMC_SETUP_NCS_RD(0),
> -		&smc->cs[3].setup);
> -	writel(AT91_SMC_PULSE_NWE(3) | AT91_SMC_PULSE_NCS_WR(3) |
> -		AT91_SMC_PULSE_NRD(3) | AT91_SMC_PULSE_NCS_RD(3),
> -		&smc->cs[3].pulse);
> -	writel(AT91_SMC_CYCLE_NWE(5) | AT91_SMC_CYCLE_NRD(5),
> -		&smc->cs[3].cycle);
> -	writel(AT91_SMC_MODE_RM_NRD | AT91_SMC_MODE_WM_NWE |
> -		AT91_SMC_MODE_EXNW_DISABLE |
> -		AT91_SMC_MODE_DBW_8 |
> -		AT91_SMC_MODE_TDF_CYCLE(2),
> -		&smc->cs[3].mode);
> -
> -#ifdef CFG_SYS_NAND_READY_PIN
> -	/* Ready pin is optional. */
> -	at91_set_pio_input(CFG_SYS_NAND_READY_PIN, 1);
> -#endif
> -	gpio_direction_output(CFG_SYS_NAND_ENABLE_PIN, 1);
> -}
> -#endif
> -
> -/*
> - * This is called first during late initialization.
> - */
> -int board_init(void)
> -{
> -	at91_periph_clk_enable(ATMEL_ID_PIOA);
> -	at91_periph_clk_enable(ATMEL_ID_PIOB);
> -	at91_periph_clk_enable(ATMEL_ID_PIOC);
> -
> -	/* Set adress of boot parameters. */
> -	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
> -	/* Initialize UARTs and power management. */
> -	ethernut5_power_init();
> -#ifdef CONFIG_CMD_NAND
> -	ethernut5_nand_hw_init();
> -#endif
> -	return 0;
> -}
> -
> -#ifdef CONFIG_MACB
> -/*
> - * This is optionally called last during late initialization.
> - */
> -int board_eth_init(struct bd_info *bis)
> -{
> -	const char *devname;
> -	unsigned short mode;
> -
> -	at91_periph_clk_enable(ATMEL_ID_EMAC0);
> -
> -	/* Need to reset PHY via power management. */
> -	ethernut5_phy_reset();
> -	/* Set peripheral pins. */
> -	at91_macb_hw_init();
> -	/* Basic EMAC initialization. */
> -	if (macb_eth_initialize(0, (void *)ATMEL_BASE_EMAC0, CFG_PHY_ID))
> -		return -1;
> -	/*
> -	 * Early board revisions have a pull-down at the PHY's MODE0
> -	 * strap pin, which forces the PHY into power down. Here we
> -	 * switch to all-capable mode.
> -	 */
> -	devname = miiphy_get_current_dev();
> -	if (miiphy_read(devname, 0, 18, &mode) == 0) {
> -		/* Set mode[2:0] to 0b111. */
> -		mode |= 0x00E0;
> -		miiphy_write(devname, 0, 18, mode);
> -		/* Soft reset overrides strap pins. */
> -		miiphy_write(devname, 0, MII_BMCR, BMCR_RESET);
> -	}
> -	/* Sync environment with network devices, needed for nfsroot. */
> -	return eth_init();
> -}
> -#endif
> -
> -#ifdef CONFIG_GENERIC_ATMEL_MCI
> -int board_mmc_init(struct bd_info *bd)
> -{
> -	at91_periph_clk_enable(ATMEL_ID_MCI);
> -
> -	/* Initialize MCI hardware. */
> -	at91_mci_hw_init();
> -	/* Register the device. */
> -	return atmel_mci_init((void *)ATMEL_BASE_MCI);
> -}
> -
> -int board_mmc_getcd(struct mmc *mmc)
> -{
> -	return !at91_get_pio_value(CFG_SYS_MMC_CD_PIN);
> -}
> -#endif
> diff --git a/board/egnite/ethernut5/ethernut5_pwrman.c b/board/egnite/ethernut5/ethernut5_pwrman.c
> deleted file mode 100644
> index 42e1914a8759..000000000000
> --- a/board/egnite/ethernut5/ethernut5_pwrman.c
> +++ /dev/null
> @@ -1,323 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2011
> - * egnite GmbH <info@egnite.de>
> - */
> -
> -/*
> - * Ethernut 5 power management support
> - *
> - * This board may be supplied via USB, IEEE 802.3af PoE or an
> - * auxiliary DC input. An on-board ATmega168 microcontroller,
> - * the so called power management controller or PMC, is used
> - * to select the supply source and to switch on and off certain
> - * energy consuming board components. This allows to reduce the
> - * total stand-by consumption to less than 70mW.
> - *
> - * The main CPU communicates with the PMC via I2C. When
> - * CONFIG_CMD_BSP is defined in the board configuration file,
> - * then the board specific command 'pwrman' becomes available,
> - * which allows to manually deal with the PMC.
> - *
> - * Two distinct registers are provided by the PMC for enabling
> - * and disabling specific features. This avoids the often seen
> - * read-modify-write cycle or shadow register requirement.
> - * Additional registers are available to query the board
> - * status and temperature, the auxiliary voltage and to control
> - * the green user LED that is integrated in the reset switch.
> - *
> - * Note, that the AVR firmware of the PMC is released under BSDL.
> - *
> - * For additional information visit the project home page at
> - * http://www.ethernut.de/
> - */
> -#include <command.h>
> -#include <vsprintf.h>
> -#include <asm/arch/at91sam9260.h>
> -#include <asm/arch/at91_common.h>
> -#include <asm/arch/gpio.h>
> -#include <asm/io.h>
> -#include <i2c.h>
> -#include <linux/delay.h>
> -
> -#include "ethernut5_pwrman.h"
> -
> -/* PMC firmware version */
> -static int pwrman_major;
> -static int pwrman_minor;
> -
> -/*
> - * Enable Ethernut 5 power management.
> - *
> - * This function must be called during board initialization.
> - * While we are using u-boot's I2C subsystem, it may be required
> - * to enable the serial port before calling this function,
> - * in particular when debugging is enabled.
> - *
> - * If board specific commands are not available, we will activate
> - * all board components.
> - */
> -void ethernut5_power_init(void)
> -{
> -	pwrman_minor = i2c_reg_read(PWRMAN_I2C_ADDR, PWRMAN_REG_VERS);
> -	pwrman_major = pwrman_minor >> 4;
> -	pwrman_minor &= 15;
> -
> -#ifndef CONFIG_CMD_BSP
> -	/* Do not modify anything, if we do not have a known version. */
> -	if (pwrman_major == 2) {
> -		/* Without board specific commands we enable all features. */
> -		i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_ENA, ~PWRMAN_ETHRST);
> -		i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_DIS, PWRMAN_ETHRST);
> -	}
> -#endif
> -}
> -
> -/*
> - * Reset Ethernet PHY.
> - *
> - * This function allows the re-configure the PHY after
> - * changing its strap pins.
> - */
> -void ethernut5_phy_reset(void)
> -{
> -	/* Do not modify anything, if we do not have a known version. */
> -	if (pwrman_major != 2)
> -		return;
> -
> -	/*
> -	 * Make sure that the Ethernet clock is enabled and the PHY reset
> -	 * is disabled for at least 100 us.
> -	 */
> -	i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_ENA, PWRMAN_ETHCLK);
> -	i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_DIS, PWRMAN_ETHRST);
> -	udelay(100);
> -
> -	/*
> -	 * LAN8710 strap pins are
> -	 * PA14 => PHY MODE0
> -	 * PA15 => PHY MODE1
> -	 * PA17 => PHY MODE2 => 111b all capable
> -	 * PA18 => PHY ADDR0 => 0b
> -	 */
> -	at91_set_pio_input(AT91_PIO_PORTA, 14, 1);
> -	at91_set_pio_input(AT91_PIO_PORTA, 15, 1);
> -	at91_set_pio_input(AT91_PIO_PORTA, 17, 1);
> -	at91_set_pio_input(AT91_PIO_PORTA, 18, 0);
> -
> -	/* Activate PHY reset for 100 us. */
> -	i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_ENA, PWRMAN_ETHRST);
> -	udelay(100);
> -	i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_DIS, PWRMAN_ETHRST);
> -
> -	at91_set_pio_input(AT91_PIO_PORTA, 14, 1);
> -}
> -
> -/*
> - * Output the firmware version we got during initialization.
> - */
> -void ethernut5_print_version(void)
> -{
> -	printf("%u.%u\n", pwrman_major, pwrman_minor);
> -}
> -
> -/*
> - * All code below this point is optional and implements
> - * the 'pwrman' command.
> - */
> -#ifdef CONFIG_CMD_BSP
> -
> -/* Human readable names of PMC features */
> -char *pwrman_feat[8] = {
> -	"board", "vbin", "vbout", "mmc",
> -	"rs232", "ethclk", "ethrst", "wakeup"
> -};
> -
> -/*
> - * Print all feature names, that have its related flags enabled.
> - */
> -static void print_flagged_features(u8 flags)
> -{
> -	int i;
> -
> -	for (i = 0; i < 8; i++) {
> -		if (flags & (1 << i))
> -			printf("%s ", pwrman_feat[i]);
> -	}
> -}
> -
> -/*
> - * Return flags of a given list of feature names.
> - *
> - * The function stops at the first unknown list entry and
> - * returns the number of detected names as a function result.
> - */
> -static int feature_flags(char * const names[], int num, u8 *flags)
> -{
> -	int i, j;
> -
> -	*flags = 0;
> -	for (i = 0; i < num; i++) {
> -		for (j = 0; j < 8; j++) {
> -			if (strcmp(pwrman_feat[j], names[i]) == 0) {
> -				*flags |= 1 << j;
> -				break;
> -			}
> -		}
> -		if (j > 7)
> -			break;
> -	}
> -	return i;
> -}
> -
> -void ethernut5_print_power(void)
> -{
> -	u8 flags;
> -	int i;
> -
> -	flags = i2c_reg_read(PWRMAN_I2C_ADDR, PWRMAN_REG_ENA);
> -	for (i = 0; i < 2; i++) {
> -		if (flags) {
> -			print_flagged_features(flags);
> -			printf("%s\n", i ? "off" : "on");
> -		}
> -		flags = ~flags;
> -	}
> -}
> -
> -void ethernut5_print_celsius(void)
> -{
> -	int val;
> -
> -	/* Read ADC value from LM50 and return Celsius degrees. */
> -	val = i2c_reg_read(PWRMAN_I2C_ADDR, PWRMAN_REG_TEMP);
> -	val *= 5000;	/* 100mV/degree with 5V reference */
> -	val += 128;	/* 8 bit resolution */
> -	val /= 256;
> -	val -= 450;	/* Celsius offset, still x10 */
> -	/* Output full degrees. */
> -	printf("%d\n", (val + 5) / 10);
> -}
> -
> -void ethernut5_print_voltage(void)
> -{
> -	int val;
> -
> -	/* Read ADC value from divider and return voltage. */
> -	val = i2c_reg_read(PWRMAN_I2C_ADDR, PWRMAN_REG_VAUX);
> -	/* Resistors are 100k and 12.1k */
> -	val += 5;
> -	val *= 180948;
> -	val /= 100000;
> -	val++;
> -	/* Calculation was done in 0.1V units. */
> -	printf("%d\n", (val + 5) / 10);
> -}
> -
> -/*
> - * Process the board specific 'pwrman' command.
> - */
> -int do_pwrman(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> -{
> -	u8 val;
> -	int i;
> -
> -	if (argc == 1) {
> -		ethernut5_print_power();
> -	} else if (argc == 2 && strcmp(argv[1], "reset") == 0) {
> -		at91_set_pio_output(AT91_PIO_PORTB, 8, 1);
> -		udelay(100);
> -		at91_set_pio_output(AT91_PIO_PORTB, 8, 0);
> -		udelay(100000);
> -	} else if (argc == 2 && strcmp(argv[1], "temp") == 0) {
> -		ethernut5_print_celsius();
> -	} else if (argc == 2 && strcmp(argv[1], "vaux") == 0) {
> -		ethernut5_print_voltage();
> -	} else if (argc == 2 && strcmp(argv[1], "version") == 0) {
> -		ethernut5_print_version();
> -	} else if (strcmp(argv[1], "led") == 0) {
> -		/* Control the green status LED. Blink frequency unit
> -		** is 0.1s, very roughly. */
> -		if (argc == 2) {
> -			/* No more arguments, output current settings. */
> -			val = i2c_reg_read(PWRMAN_I2C_ADDR, PWRMAN_REG_LEDCTL);
> -			printf("led %u %u\n", val >> 4, val & 15);
> -		} else {
> -			/* First argument specifies the on-time. */
> -			val = (u8) simple_strtoul(argv[2], NULL, 0);
> -			val <<= 4;
> -			if (argc > 3) {
> -				/* Second argument specifies the off-time. */
> -				val |= (u8) (simple_strtoul(argv[3], NULL, 0)
> -						& 15);
> -			}
> -			/* Update the LED control register. */
> -			i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_LEDCTL, val);
> -		}
> -	} else {
> -		/* We expect a list of features followed an optional status. */
> -		argc--;
> -		i = feature_flags(&argv[1], argc, &val);
> -		if (argc == i) {
> -			/* We got a list only, print status. */
> -			val &= i2c_reg_read(PWRMAN_I2C_ADDR, PWRMAN_REG_STA);
> -			if (val) {
> -				if (i > 1)
> -					print_flagged_features(val);
> -				printf("active\n");
> -			} else {
> -				printf("inactive\n");
> -			}
> -		} else {
> -			/* More arguments. */
> -			if (i == 0) {
> -				/* No given feature, use despensibles. */
> -				val = PWRMAN_DISPENSIBLE;
> -			}
> -			if (strcmp(argv[i + 1], "on") == 0) {
> -				/* Enable features. */
> -				i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_ENA,
> -						val);
> -			} else if (strcmp(argv[i + 1], "off") == 0) {
> -				/* Disable features. */
> -				i2c_reg_write(PWRMAN_I2C_ADDR, PWRMAN_REG_DIS,
> -						val);
> -			} else {
> -				printf("Bad parameter %s\n", argv[i + 1]);
> -				return 1;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -U_BOOT_CMD(
> -	pwrman,	CONFIG_SYS_MAXARGS, 1, do_pwrman,
> -	"power management",
> -		   "- print settings\n"
> -	"pwrman feature ...\n"
> -	"       - print status\n"
> -	"pwrman [feature ...] on|off\n"
> -	"       - enable/disable specified or all dispensible features\n"
> -	"pwrman led [on-time [off-time]]\n"
> -	"       - print or set led blink timer\n"
> -	"pwrman temp\n"
> -	"       - print board temperature (Celsius)\n"
> -	"pwrman vaux\n"
> -	"       - print auxiliary input voltage\n"
> -	"pwrman reset\n"
> -	"       - reset power management controller\n"
> -	"pwrman version\n"
> -	"       - print firmware version\n"
> -	"\n"
> -	"        features, (*)=dispensible:\n"
> -	"          board  - 1.8V and 3.3V supply\n"
> -	"          vbin   - supply via USB device connector\n"
> -	"          vbout  - USB host connector supply(*)\n"
> -	"          mmc    - MMC slot supply(*)\n"
> -	"          rs232  - RS232 driver\n"
> -	"          ethclk - Ethernet PHY clock(*)\n"
> -	"          ethrst - Ethernet PHY reset\n"
> -	"          wakeup - RTC alarm"
> -);
> -#endif /* CONFIG_CMD_BSP */
> diff --git a/board/egnite/ethernut5/ethernut5_pwrman.h b/board/egnite/ethernut5/ethernut5_pwrman.h
> deleted file mode 100644
> index 103f5583289c..000000000000
> --- a/board/egnite/ethernut5/ethernut5_pwrman.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * (C) Copyright 2011
> - * egnite GmbH <info@egnite.de>
> - */
> -
> -/*
> - * Ethernut 5 power management support
> - *
> - * For additional information visit the project home page at
> - * http://www.ethernut.de/
> - */
> -
> -/* I2C address of the PMC */
> -#define PWRMAN_I2C_ADDR 0x22
> -
> -/* PMC registers */
> -#define PWRMAN_REG_VERS		0	/* Version register */
> -#define PWRMAN_REG_STA		1	/* Feature status register */
> -#define PWRMAN_REG_ENA		2	/* Feature enable register */
> -#define PWRMAN_REG_DIS		3	/* Feature disable register */
> -#define PWRMAN_REG_TEMP		4	/* Board temperature */
> -#define PWRMAN_REG_VAUX		6	/* Auxiliary input voltage */
> -#define PWRMAN_REG_LEDCTL	8	/* LED blinking timer. */
> -
> -/* Feature flags used in status, enable and disable registers */
> -#define PWRMAN_BOARD	0x01	/* 1.8V and 3.3V supply */
> -#define PWRMAN_VBIN	0x02	/* VBUS input at device connector */
> -#define PWRMAN_VBOUT	0x04	/* VBUS output at host connector */
> -#define PWRMAN_MMC	0x08	/* Memory card supply */
> -#define PWRMAN_RS232	0x10	/* RS-232 driver shutdown */
> -#define PWRMAN_ETHCLK	0x20	/* Ethernet clock enable */
> -#define PWRMAN_ETHRST	0x40	/* Ethernet PHY reset */
> -#define PWRMAN_WAKEUP	0x80	/* RTC wake-up */
> -
> -/* Features, which are not essential to keep u-boot alive */
> -#define PWRMAN_DISPENSIBLE	(PWRMAN_VBOUT | PWRMAN_MMC | PWRMAN_ETHCLK)
> -
> -/* Enable Ethernut 5 power management. */
> -extern void ethernut5_power_init(void);
> -
> -/* Reset Ethernet PHY. */
> -extern void ethernut5_phy_reset(void);
> -
> -extern void ethernut5_print_version(void);
> -
> -#ifdef CONFIG_CMD_BSP
> -extern void ethernut5_print_power(void);
> -extern void ethernut5_print_celsius(void);
> -extern void ethernut5_print_voltage(void);
> -#endif
> diff --git a/configs/ethernut5_defconfig b/configs/ethernut5_defconfig
> deleted file mode 100644
> index 004f18661624..000000000000
> --- a/configs/ethernut5_defconfig
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_SKIP_LOWLEVEL_INIT=y
> -CONFIG_ARCH_CPU_INIT=y
> -CONFIG_ARCH_AT91=y
> -CONFIG_TEXT_BASE=0x27000000
> -CONFIG_SYS_MALLOC_LEN=0x121000
> -CONFIG_TARGET_ETHERNUT5=y
> -CONFIG_AT91_EFLASH=y
> -CONFIG_EFLASH_PROTSECTORS=1
> -CONFIG_NR_DRAM_BANKS=1
> -CONFIG_ENV_SIZE=0x21000
> -CONFIG_ENV_OFFSET=0x3DE000
> -CONFIG_ENV_SECT_SIZE=0x21000
> -CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="ethernut5"
> -CONFIG_SYS_LOAD_ADDR=0x020000000
> -CONFIG_BOOTDELAY=3
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mtdblock0 mtdparts=atmel_nand:-(root) rw rootfstype=jffs2"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="sf probe 0:0; sf read 0x22000000 0xc6000 0x294000; bootm 0x22000000"
> -CONFIG_SYS_CBSIZE=256
> -CONFIG_SYS_PBSIZE=281
> -# CONFIG_DISPLAY_BOARDINFO is not set
> -CONFIG_HUSH_PARSER=y
> -# CONFIG_AUTO_COMPLETE is not set
> -CONFIG_SYS_PROMPT="U-Boot> "
> -# CONFIG_CMD_BDI is not set
> -CONFIG_CMD_IMLS=y
> -CONFIG_CMD_ASKENV=y
> -CONFIG_CMD_UNZIP=y
> -CONFIG_CMD_I2C=y
> -# CONFIG_CMD_LOADS is not set
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_NAND=y
> -CONFIG_CMD_SPI=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_BOOTP_BOOTFILESIZE=y
> -CONFIG_CMD_RARP=y
> -CONFIG_SYS_DISABLE_AUTOLOAD=y
> -CONFIG_CMD_MII=y
> -# CONFIG_CMD_MDIO is not set
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_CDP=y
> -CONFIG_CMD_SNTP=y
> -CONFIG_CMD_DNS=y
> -CONFIG_CMD_BSP=y
> -CONFIG_CMD_CACHE=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
> -CONFIG_CMD_MTDPARTS=y
> -CONFIG_MTDIDS_DEFAULT="nand0=atmel_nand"
> -CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:-(root)"
> -CONFIG_CMD_UBI=y
> -CONFIG_OF_CONTROL=y
> -CONFIG_ENV_IS_IN_SPI_FLASH=y
> -CONFIG_ENV_SPI_MAX_HZ=15000000
> -CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RETRY_COUNT=20
> -CONFIG_CLK=y
> -CONFIG_CLK_AT91=y
> -CONFIG_AT91_GPIO=y
> -CONFIG_SYS_I2C_LEGACY=y
> -CONFIG_SYS_I2C_SOFT=y
> -CONFIG_SYS_I2C_SOFT_SLAVE=0
> -CONFIG_GENERIC_ATMEL_MCI=y
> -CONFIG_MTD=y
> -CONFIG_MTD_NOR_FLASH=y
> -CONFIG_SYS_MAX_FLASH_SECT=32
> -CONFIG_MTD_RAW_NAND=y
> -# CONFIG_SYS_NAND_USE_FLASH_BBT is not set
> -CONFIG_NAND_ATMEL=y
> -CONFIG_DM_SPI_FLASH=y
> -CONFIG_SPI_FLASH_ATMEL=y
> -CONFIG_SPI_FLASH_DATAFLASH=y
> -CONFIG_MACB=y
> -CONFIG_RMII=y
> -CONFIG_PINCTRL=y
> -CONFIG_PINCTRL_AT91=y
> -CONFIG_RTC_PCF8563=y
> -CONFIG_DM_SERIAL=y
> -CONFIG_ATMEL_USART=y
> -CONFIG_SPI=y
> -CONFIG_DM_SPI=y
> -CONFIG_USB=y
> -CONFIG_JFFS2_NAND=y
> diff --git a/doc/board/atmel/at91ek.rst b/doc/board/atmel/at91ek.rst
> index 6185b1dfb289..a500b2f8950c 100644
> --- a/doc/board/atmel/at91ek.rst
> +++ b/doc/board/atmel/at91ek.rst
> @@ -6,8 +6,8 @@ AT91 Evaluation kits
>  Board mapping & boot media
>  --------------------------
>  
> -AT91SAM9260EK, AT91SAM9G20EK & AT91SAM9XEEK
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +AT91SAM9260EK & AT91SAM9G20EK
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  Memory map::
>  
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index 2105cea3d45e..b6ab31a314a7 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -13,7 +13,6 @@ if BOOTCOUNT_LIMIT
>  choice
>  	prompt "Boot count device"
>  	default BOOTCOUNT_AM33XX if AM33XX || SOC_DA8XX
> -	default BOOTCOUNT_AT91 if AT91SAM9XE
>  	default BOOTCOUNT_GENERIC
>  
>  config BOOTCOUNT_GENERIC
> diff --git a/include/configs/at91sam9260ek.h b/include/configs/at91sam9260ek.h
> index b9cc7ba974de..b75db7e7bac0 100644
> --- a/include/configs/at91sam9260ek.h
> +++ b/include/configs/at91sam9260ek.h
> @@ -35,11 +35,7 @@
>  #define CFG_SYS_SDRAM_SIZE		0x04000000
>  
>  #define CFG_SYS_INIT_RAM_SIZE	(16 * 1024)
> -#ifdef CONFIG_AT91SAM9XE
> -# define CFG_SYS_INIT_RAM_ADDR	ATMEL_BASE_SRAM
> -#else
> -# define CFG_SYS_INIT_RAM_ADDR	ATMEL_BASE_SRAM1
> -#endif
> +#define CFG_SYS_INIT_RAM_ADDR	ATMEL_BASE_SRAM1
>  
>  /* NAND flash */
>  #ifdef CONFIG_CMD_NAND
> diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
> deleted file mode 100644
> index c327bbbe07d0..000000000000
> --- a/include/configs/ethernut5.h
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * (C) Copyright 2011
> - * egnite GmbH <info@egnite.de>
> - *
> - * Configuation settings for Ethernut 5 with AT91SAM9XE.
> - */
> -
> -#ifndef __CONFIG_H
> -#define __CONFIG_H
> -
> -#include <asm/hardware.h>
> -
> -/* The first stage boot loader expects u-boot running at this address. */
> -
> -/* The first stage boot loader takes care of low level initialization. */
> -
> -/* CPU information */
> -
> -/* ARM asynchronous clock */
> -#define CFG_SYS_AT91_SLOW_CLOCK	32768	/* slow clock xtal */
> -#define CFG_SYS_AT91_MAIN_CLOCK	18432000 /* 18.432 MHz crystal */
> -
> -/* 32kB internal SRAM */
> -#define CFG_SYS_INIT_RAM_ADDR	0x00300000 /*AT91SAM9XE_SRAM_BASE */
> -#define CFG_SYS_INIT_RAM_SIZE	(32 << 10)
> -
> -/* 128MB SDRAM in 1 bank */
> -#define CFG_SYS_SDRAM_BASE		0x20000000
> -#define CFG_SYS_SDRAM_SIZE		(128 << 20)
> -
> -/* 512kB on-chip NOR flash */
> -# define CFG_SYS_FLASH_BASE		0x00200000 /* AT91SAM9XE_FLASH_BASE */
> -
> -/* bootstrap + u-boot + env + linux in dataflash on CS0 */
> -
> -/* NAND flash */
> -#ifdef CONFIG_CMD_NAND
> -#define CFG_SYS_NAND_BASE		0x40000000
> -/* our ALE is AD21 */
> -#define CFG_SYS_NAND_MASK_ALE	(1 << 21)
> -/* our CLE is AD22 */
> -#define CFG_SYS_NAND_MASK_CLE	(1 << 22)
> -#define CFG_SYS_NAND_ENABLE_PIN	GPIO_PIN_PC(14)
> -#endif
> -
> -/* JFFS2 */
> -
> -/* Ethernet */
> -#define CFG_PHY_ID			0
> -
> -/* MMC */
> -#ifdef CONFIG_CMD_MMC
> -#define CFG_SYS_MMC_CD_PIN		AT91_PIO_PORTC, 8
> -#endif
> -
> -/* RTC */
> -#if defined(CONFIG_CMD_DATE) || defined(CONFIG_CMD_SNTP)
> -#define CFG_SYS_I2C_RTC_ADDR		0x51
> -#endif
> -
> -#define I2C_SOFT_DECLARATIONS
> -
> -#define GPIO_I2C_SCL		AT91_PIO_PORTA, 24
> -#define GPIO_I2C_SDA		AT91_PIO_PORTA, 23
> -
> -#define I2C_INIT { \
> -	at91_set_pio_periph(AT91_PIO_PORTA, 23, 0); \
> -	at91_set_pio_multi_drive(AT91_PIO_PORTA, 23, 1); \
> -	at91_set_pio_periph(AT91_PIO_PORTA, 24, 0); \
> -	at91_set_pio_output(AT91_PIO_PORTA, 24, 0); \
> -	at91_set_pio_multi_drive(AT91_PIO_PORTA, 24, 1); \
> -}
> -
> -#define I2C_ACTIVE	at91_set_pio_output(AT91_PIO_PORTA, 23, 0)
> -#define I2C_TRISTATE	at91_set_pio_input(AT91_PIO_PORTA, 23, 0)
> -#define I2C_SCL(bit)	at91_set_pio_value(AT91_PIO_PORTA, 24, bit)
> -#define I2C_SDA(bit)	at91_set_pio_value(AT91_PIO_PORTA, 23, bit)
> -#define I2C_DELAY	udelay(100)
> -#define I2C_READ	at91_get_pio_value(AT91_PIO_PORTA, 23)
> -
> -/* File systems */
> -
> -/* Boot command */
> -
> -/* Misc. u-boot settings */
> -
> -#endif

