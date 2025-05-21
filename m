Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F68C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 03:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9669D82B7C;
	Wed, 21 May 2025 05:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JGm9ArvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D284682AE9; Wed, 21 May 2025 05:14:09 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8995C82B7C
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 05:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=woods.technical@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70825de932bso75624267b3.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 20:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747797240; x=1748402040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=orQFlufA2aSYGQxpvcwiI5BhoH+tL9ZUKDhD7K3YNy8=;
 b=JGm9ArvCbi8YKH6m2EmL/8Ih+O484C2rMClOsqt/Mq/MPq7TnLX+9P/MmGhGyoi5da
 sIvZr1YNrXbBJL74aQAgoAeVt86AmTpfugRsXyghfnzSJCj2AD1GHDcchaFFzQSlH0iN
 xr8z1Oev2efrQHWkNZj3IjwoAAI7DvK1fenfjNKMAvPGaGtZUzLsU0L3CKb9axic8y4J
 oZmIF6BEYSAWgJoNyDhIzoE8FBZcTJOfXmLC2Lt1QZL4+nyhoKGI/zASqBpvFYu80iUW
 xbBAoIgtluNFFSUndmG1OAooCdrTX3Jyv3QT4rnDFaDRkzidpH3WhUptfQrAdyPjAepz
 4VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747797240; x=1748402040;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orQFlufA2aSYGQxpvcwiI5BhoH+tL9ZUKDhD7K3YNy8=;
 b=t4uWI3MqyVw4ba2aopEI9sGd9lMY6lsDk7hGCAgd55dSk8hlu/edzPPe4FW0quLP2N
 zw9yqKNNqF87FAVdrzYyNmYmYnDVYHg50B01zwnEEcKb2xZdcViJo3q62G4HBcHvbPkg
 eQUt6GBn9OmSHf1oMk/JYCZ6ZJAfHpSZO73vCA0YWESgsXFOjp1Bucgh5O76nPAiV9Q0
 JZ3LjkxILl6lHldXQTOEkjiBcP2t9szdmpO87Eh4BoHYkLgDowtxZi6kbi4daS297C7n
 zdnMmZ7cs8OXrh2nEX5jwhAgb8S5P49xRGNcOQyEFE3SKmNvgPhhR+PDjdevXxs5Oq4r
 k0ow==
X-Gm-Message-State: AOJu0YxoOwrcFaTcdqUdWMkTzTuwgDa7nkJQm0wWOfG+IBCOulZyzFFU
 puNiZPYXsjGhJew7l3biUpCb5Aliy+urIVsBYvAXHloynXM/Vr1TQVjh
X-Gm-Gg: ASbGncs+C1DWD1JKmAsAaaX2qUyOSFZIIGseLKal9UIYbAtRoHMSpVYZn9JjZB2VPkT
 I/qEpu0pOkWge9GnDwSIIX0clMsEL5fQmBrBr57rkgNGwwxrgiSt8fIbFlIfeyMB1wDbQqBXQyz
 NSVvrSF/YlozRB+hQXd2spwmlwe5llqGw+DuIDG+UH1NLFcMJCjxo7RRhZsxzaytUdrJxfbYIQf
 AfrsH5F5527J1AcSqMnfRfnr11Wl92qbrtkGqJYnynicinecpWWfNetfUV0Z8Hx8HEAzzobjRVx
 YPbEJL/Dft8VCgDVz4aCbYdM8XhczNTlj0Vvw4g8WT95ScTmagFkyqRrUCgsz4NYVUqNXJIouOw
 dPtw9FZls6z2DuYd70RTvkH7rHIaNvw1Z
X-Google-Smtp-Source: AGHT+IFLHqcHLbSdPh1gJpYadhcLHuy95IvGHnrOzgvrYfKOxeP4DgWJxzJ3Gx/czGSOs3PP6DlWeg==
X-Received: by 2002:a05:6902:2b86:b0:e78:f196:5d48 with SMTP id
 3f1490d57ef6-e7b6b18c7d4mr23334748276.13.1747797239478; 
 Tue, 20 May 2025 20:13:59 -0700 (PDT)
Received: from nubia. (162-228-215-203.lightspeed.tukrga.sbcglobal.net.
 [162.228.215.203]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e7d56fee104sm463639276.6.2025.05.20.20.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 20:13:58 -0700 (PDT)
Message-ID: <682d44f6.250a0220.1eefc.291d@mx.google.com>
X-Google-Original-Message-ID: <aC1E9DU5ONh0J6rv@nubia.>
Date: Tue, 20 May 2025 23:13:56 -0400
From: "Derald D. Woods" <woods.technical@gmail.com>
To: OMAP at BSF <omapbsf@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/2] BeagleBoard: Bring it back with updates.
References: <qGUwuf16r8DyviFIr-y8PVzG36Fp4Q9yiMZWn6l1V7dsu9-OmwHLFXXKEOOZHdQNBFxW6SB8tU5jL3MzuDmxq0SRl1lELPpnwJqcKMqPeZY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qGUwuf16r8DyviFIr-y8PVzG36Fp4Q9yiMZWn6l1V7dsu9-OmwHLFXXKEOOZHdQNBFxW6SB8tU5jL3MzuDmxq0SRl1lELPpnwJqcKMqPeZY=@protonmail.com>
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

On Sat, May 17, 2025 at 09:28:00PM +0000, OMAP at BSF wrote:
> * Converted to using DM_I2C.
> * New config file for xM.
> * Run 'patman' on patches.
> * Use upstream device tree files.
> 
> Signed-off-by: Steven Hill <omapbsf@protonmail.com>
> ---
> v2: Use upstream device trees.
> v3: No change.
> v4: Update name in MAINTAINERS file.
> 
> ---
>  arch/arm/dts/Makefile                       |   9 +
>  arch/arm/dts/omap3-beagle-u-boot.dtsi       |  14 +
>  arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi |  14 +
>  arch/arm/dts/omap3-beagle-xm-u-boot.dtsi    |  14 +
>  arch/arm/dts/omap3-u-boot.dtsi              |  34 +-
>  arch/arm/include/asm/arch-omap3/cpu.h       |   3 +-
>  arch/arm/include/asm/arch-omap3/hardware.h  |  22 +
>  arch/arm/include/asm/arch-omap3/mem.h       |   8 +-
>  arch/arm/mach-omap2/omap3/Kconfig           |  14 +
>  board/beagle/beagle/Kconfig                 |  14 +
>  board/beagle/beagle/MAINTAINERS             |   7 +
>  board/beagle/beagle/Makefile                |   7 +
>  board/beagle/beagle/beagle.c                | 541 +++++++++++++++++++
>  board/beagle/beagle/beagle.h                | 545 ++++++++++++++++++++
>  board/beagle/beagle/led.c                   |  70 +++
>  board/isee/igep00x0/spl.c                   |   6 +-
>  board/lg/sniper/sniper.c                    |   2 +-
>  board/logicpd/omap3som/omap3logic.c         |   4 +-
>  board/ti/omap3evm/evm.c                     |   2 +-
>  board/timll/devkit8000/devkit8000.c         |   2 +-
>  configs/omap3_beagle_defconfig              | 124 +++++
>  configs/omap3_beagle_xm_defconfig           | 109 ++++
>  include/configs/omap3_beagle.h              | 201 ++++++++
>  23 files changed, 1736 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/dts/omap3-beagle-u-boot.dtsi
>  create mode 100644 arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi
>  create mode 100644 arch/arm/dts/omap3-beagle-xm-u-boot.dtsi
>  create mode 100644 arch/arm/include/asm/arch-omap3/hardware.h
>  create mode 100644 board/beagle/beagle/Kconfig
>  create mode 100644 board/beagle/beagle/MAINTAINERS
>  create mode 100644 board/beagle/beagle/Makefile
>  create mode 100644 board/beagle/beagle/beagle.c
>  create mode 100644 board/beagle/beagle/beagle.h
>  create mode 100644 board/beagle/beagle/led.c
>  create mode 100644 configs/omap3_beagle_defconfig
>  create mode 100644 configs/omap3_beagle_xm_defconfig
>  create mode 100644 include/configs/omap3_beagle.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 32b698a7f41..ceb6dade534 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -966,6 +966,15 @@ dtb-$(CONFIG_TARGET_GARDENA_SMART_GATEWAY_AT91SAM) += \
>  
>  dtb-$(CONFIG_TARGET_USB_A9263) += usb_a9263.dtb
>  
> +dtb-$(CONFIG_TARGET_OMAP3_EVM) += \
> +	omap3-evm-37xx.dtb \
> +	omap3-evm.dtb
> +
> +dtb-$(CONFIG_TARGET_OMAP3_BEAGLE) += \
> +	omap3-beagle-xm-ab.dtb \
> +	omap3-beagle-xm.dtb \
> +	omap3-beagle.dtb
> +
>  dtb-$(CONFIG_TARGET_DEVKIT8000) += omap3-devkit8000.dtb
>  
>  dtb-$(CONFIG_TARGET_SAMA7G5EK) += \
> diff --git a/arch/arm/dts/omap3-beagle-u-boot.dtsi b/arch/arm/dts/omap3-beagle-u-boot.dtsi
> new file mode 100644
> index 00000000000..2c03701c896
> --- /dev/null
> +++ b/arch/arm/dts/omap3-beagle-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
> + */
> +
> +#include "omap3-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +};
> diff --git a/arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi b/arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi
> new file mode 100644
> index 00000000000..2c03701c896
> --- /dev/null
> +++ b/arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
> + */
> +
> +#include "omap3-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +};
> diff --git a/arch/arm/dts/omap3-beagle-xm-u-boot.dtsi b/arch/arm/dts/omap3-beagle-xm-u-boot.dtsi
> new file mode 100644
> index 00000000000..2c03701c896
> --- /dev/null
> +++ b/arch/arm/dts/omap3-beagle-xm-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
> + */
> +
> +#include "omap3-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +};
> diff --git a/arch/arm/dts/omap3-u-boot.dtsi b/arch/arm/dts/omap3-u-boot.dtsi
> index bc2793757b7..b17790e758b 100644
> --- a/arch/arm/dts/omap3-u-boot.dtsi
> +++ b/arch/arm/dts/omap3-u-boot.dtsi
> @@ -9,74 +9,74 @@
>  
>  /{
>  	ocp@68000000 {
> -		bootph-pre-ram;
> +		bootph-all;
>  
>  		bandgap@48002524 {
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>  	};
>  };
>  
>  &uart1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	reg-shift = <2>;
>  };
>  
>  &uart2 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	reg-shift = <2>;
>  };
>  
>  &uart3 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	reg-shift = <2>;
>  };
>  
>  &mmc1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &mmc2 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &l4_core {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &scm {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &scm_conf {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &gpio1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &gpio2 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &gpio3 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &gpio4 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &gpio5 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &gpio6 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &i2c1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	clock-frequency = <100000>;
>  };
> diff --git a/arch/arm/include/asm/arch-omap3/cpu.h b/arch/arm/include/asm/arch-omap3/cpu.h
> index d2fbf919a5b..917e7def378 100644
> --- a/arch/arm/include/asm/arch-omap3/cpu.h
> +++ b/arch/arm/include/asm/arch-omap3/cpu.h
> @@ -12,6 +12,8 @@
>  #include <asm/types.h>
>  #endif /* !(__KERNEL_STRICT_NAMES || __ASSEMBLY__) */
>  
> +#include <asm/arch/hardware.h>
> +
>  /* Register offsets of common modules */
>  /* Control */
>  #ifndef __KERNEL_STRICT_NAMES
> @@ -67,7 +69,6 @@ struct ctrl_id {
>  #define SKUID_CLK_600MHZ	0x0
>  #define SKUID_CLK_720MHZ	0x8
>  
> -#define GPMC_BASE		(OMAP34XX_GPMC_BASE)
>  #define GPMC_CONFIG_CS0		0x60
>  #define GPMC_CONFIG_CS0_BASE	(GPMC_BASE + GPMC_CONFIG_CS0)
>  
> diff --git a/arch/arm/include/asm/arch-omap3/hardware.h b/arch/arm/include/asm/arch-omap3/hardware.h
> new file mode 100644
> index 00000000000..108830912ad
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-omap3/hardware.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * hardware.h
> + *
> + * hardware specific header
> + *
> + * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com/
> + */
> +
> +#ifndef __OMAP_HARDWARE_H
> +#define __OMAP_HARDWARE_H
> +
> +#include <asm/arch/omap.h>
> +
> +/*
> + * Common hardware definitions
> + */
> +
> +/* GPMC Base address */
> +#define GPMC_BASE		(OMAP34XX_GPMC_BASE)
> +
> +#endif
> diff --git a/arch/arm/include/asm/arch-omap3/mem.h b/arch/arm/include/asm/arch-omap3/mem.h
> index 2b6cfde4114..e5b57ca0dbf 100644
> --- a/arch/arm/include/asm/arch-omap3/mem.h
> +++ b/arch/arm/include/asm/arch-omap3/mem.h
> @@ -37,10 +37,10 @@ enum {
>   * enable at bits 0:1 and an autorefresh counter value in bits 8:23.  The
>   * counter is a result of ( tREFI / tCK ) - 50.
>   */
> -#define SDP_3430_SDRC_RFR_CTRL_100MHz	0x0002da01
> -#define SDP_3430_SDRC_RFR_CTRL_133MHz	0x0003de01 /* 7.8us/7.5ns - 50=0x3de */
> -#define SDP_3430_SDRC_RFR_CTRL_165MHz	0x0004e201 /* 7.8us/6ns - 50=0x4e2 */
> -#define SDP_3430_SDRC_RFR_CTRL_200MHz	0x0005e601 /* 7.8us/5ns - 50=0x5e6 */
> +#define SDP_3430_SDRC_RFR_CTRL_100MHZ	0x0002da01
> +#define SDP_3430_SDRC_RFR_CTRL_133MHZ	0x0003de01 /* 7.8us/7.5ns - 50=0x3de */
> +#define SDP_3430_SDRC_RFR_CTRL_165MHZ	0x0004e201 /* 7.8us/6ns - 50=0x4e2 */
> +#define SDP_3430_SDRC_RFR_CTRL_200MHZ	0x0005e601 /* 7.8us/5ns - 50=0x5e6 */
>  
>  #define DLL_OFFSET		0
>  #define DLL_WRITEDDRCLKX2DIS	1
> diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
> index b50b8a5f6bd..ed8dc77a353 100644
> --- a/arch/arm/mach-omap2/omap3/Kconfig
> +++ b/arch/arm/mach-omap2/omap3/Kconfig
> @@ -34,6 +34,19 @@ config TARGET_AM3517_EVM
>  	select MMC
>  	imply CMD_DM
>  
> +config TARGET_OMAP3_BEAGLE
> +	bool "TI OMAP3 BeagleBoard"
> +	select DM
> +	select DM_GPIO
> +	select DM_I2C
> +	select DM_SERIAL
> +	select OMAP3_GPIO_5
> +	select OMAP3_GPIO_6
> +	select TI_I2C_BOARD_DETECT
> +	select SUPPORT_EXTENSION_SCAN
> +	imply CMD_DM
> +	imply OF_UPSTREAM
> +
>  config TARGET_CM_T35
>  	bool "CompuLab CM-T3530 and CM-T3730 boards"
>  	select OMAP3_GPIO_2
> @@ -145,6 +158,7 @@ config SYS_SOC
>  	default "omap3"
>  
>  source "board/logicpd/am3517evm/Kconfig"
> +source "board/beagle/beagle/Kconfig"
>  source "board/timll/devkit8000/Kconfig"
>  source "board/ti/omap3evm/Kconfig"
>  source "board/isee/igep00x0/Kconfig"
> diff --git a/board/beagle/beagle/Kconfig b/board/beagle/beagle/Kconfig
> new file mode 100644
> index 00000000000..7e8fb365698
> --- /dev/null
> +++ b/board/beagle/beagle/Kconfig
> @@ -0,0 +1,14 @@
> +if TARGET_OMAP3_BEAGLE
> +
> +config SYS_BOARD
> +	default "beagle"
> +
> +config SYS_VENDOR
> +	default "beagle"
> +
> +config SYS_CONFIG_NAME
> +	default "omap3_beagle"
> +
> +endif
> +
> +source "board/ti/common/Kconfig"
> diff --git a/board/beagle/beagle/MAINTAINERS b/board/beagle/beagle/MAINTAINERS
> new file mode 100644
> index 00000000000..70e71b6a7ed
> --- /dev/null
> +++ b/board/beagle/beagle/MAINTAINERS
> @@ -0,0 +1,7 @@
> +BEAGLE BOARD
> +M:	Steven Hill <omapbsf@protonmail.com>
> +S:	Maintained
> +F:	board/beagle/beagle/
> +F:	include/configs/omap3_beagle.h
> +F:	configs/omap3_beagle_defconfig
> +F:	configs/omap3_beagle_xm_defconfig
> diff --git a/board/beagle/beagle/Makefile b/board/beagle/beagle/Makefile
> new file mode 100644
> index 00000000000..fc9288cf186
> --- /dev/null
> +++ b/board/beagle/beagle/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2000, 2001, 2002
> +# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> +
> +obj-y	:= beagle.o
> +obj-$(CONFIG_LED_STATUS) += led.o
> diff --git a/board/beagle/beagle/beagle.c b/board/beagle/beagle/beagle.c
> new file mode 100644
> index 00000000000..660a50afd0d
> --- /dev/null
> +++ b/board/beagle/beagle/beagle.c
> @@ -0,0 +1,541 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2004-2011
> + * Texas Instruments, <www.ti.com>
> + *
> + * Author :
> + *	Sunil Kumar <sunilsaini05@gmail.com>
> + *	Shashi Ranjan <shashiranjanmca05@gmail.com>
> + *
> + * Derived from Beagle Board and 3430 SDP code by
> + *	Richard Woodruff <r-woodruff2@ti.com>
> + *	Syed Mohammed Khasim <khasim@ti.com>
> + *
> + */
> +#include <bootstage.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <init.h>
> +#include <net.h>
> +#include <ns16550.h>
> +#include <serial.h>
> +#if (IS_ENABLED(CONFIG_LED_STATUS))
> +#include <status_led.h>
> +#endif
> +#include <twl4030.h>
> +#include <asm/global_data.h>
> +#include <linux/mtd/rawnand.h>
> +#include <asm/io.h>
> +#include <asm/arch/mmc_host_def.h>
> +#include <i2c.h>
> +#include <asm/arch/mux.h>
> +#include <asm/arch/mem.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/gpio.h>
> +#include <asm/mach-types.h>
> +#include <asm/omap_musb.h>
> +#include <linux/errno.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/musb.h>
> +#include "beagle.h"
> +#include <command.h>
> +
> +#define TWL4030_I2C_BUS			0
> +
> +#define TINCANTOOLS_ZIPPY		0x01000100
> +#define TINCANTOOLS_ZIPPY2		0x02000100
> +#define TINCANTOOLS_TRAINER		0x04000100
> +#define TINCANTOOLS_SHOWDOG		0x03000100
> +#define KBADC_BEAGLEFPGA		0x01000600
> +#define LW_BEAGLETOUCH			0x01000700
> +#define BRAINMUX_LCDOG			0x01000800
> +#define BRAINMUX_LCDOGTOUCH		0x02000800
> +#define BBTOYS_WIFI			0x01000B00
> +#define BBTOYS_VGA			0x02000B00
> +#define BBTOYS_LCD			0x03000B00
> +#define BCT_BRETTL3			0x01000F00
> +#define BCT_BRETTL4			0x02000F00
> +#define LSR_COM6L_ADPT			0x01001300
> +#define BEAGLE_NO_EEPROM		0xffffffff
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static struct {
> +	unsigned int device_vendor;
> +	unsigned char revision;
> +	unsigned char content;
> +	char fab_revision[8];
> +	char env_var[16];
> +	char env_setting[64];
> +} expansion_config;
> +
> +/*
> + * Routine: board_init
> + * Description: Early hardware init.
> + */
> +int board_init(void)
> +{
> +	gpmc_init(); /* in SRAM or SDRAM, finish GPMC */
> +	/* board id for Linux */
> +	gd->bd->bi_arch_number = MACH_TYPE_OMAP3_BEAGLE;
> +	/* boot param addr */
> +	gd->bd->bi_boot_params = (OMAP34XX_SDRC_CS0 + 0x100);
> +
> +#if (IS_ENABLED(CONFIG_LED_STATUS)) && (IS_ENABLED(CONFIG_LED_STATUS_BOOT_ENABLE))
> +	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_ON);
> +#endif
> +
> +	return 0;
> +}
> +
> +#if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
> +int spl_start_uboot(void)
> +{
> +	/* break into full u-boot on 'c' */
> +	if (serial_tstc() && serial_getc() == 'c')
> +		return 1;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_SPL_OS_BOOT */
> +
> +/*
> + * Routine: get_board_revision
> + * Description: Detect if we are running on a Beagle revision Ax/Bx,
> + *		C1/2/3, C4, xM Ax/Bx or xM Cx. This can be done by reading
> + *		the level of GPIO173, GPIO172 and GPIO171. This should
> + *		result in
> + *		GPIO173, GPIO172, GPIO171: 1 1 1 => Ax/Bx
> + *		GPIO173, GPIO172, GPIO171: 1 1 0 => C1/2/3
> + *		GPIO173, GPIO172, GPIO171: 1 0 1 => C4
> + *		GPIO173, GPIO172, GPIO171: 0 1 0 => xM Cx
> + *		GPIO173, GPIO172, GPIO171: 0 0 0 => xM Ax/Bx
> + */
> +static int get_board_revision(void)
> +{
> +	static int revision = -1;
> +
> +	if (revision == -1) {
> +		if (!gpio_request(171, "rev0") &&
> +		    !gpio_request(172, "rev1") &&
> +		    !gpio_request(173, "rev2")) {
> +			gpio_direction_input(171);
> +			gpio_direction_input(172);
> +			gpio_direction_input(173);
> +
> +			revision = gpio_get_value(173) << 2 |
> +				gpio_get_value(172) << 1 |
> +				gpio_get_value(171);
> +		} else {
> +			printf("Error: unable to acquire board revision GPIOs\n");
> +		}
> +	}
> +
> +	return revision;
> +}
> +
> +#if (IS_ENABLED(CONFIG_SPL_BUILD))
> +/*
> + * Routine: get_board_mem_timings
> + * Description: If we use SPL then there is no x-loader nor config header
> + * so we have to setup the DDR timings ourself on both banks.
> + */
> +void get_board_mem_timings(struct board_sdrc_timings *timings)
> +{
> +	int pop_mfr, pop_id;
> +
> +	/*
> +	 * We need to identify what PoP memory is on the board so that
> +	 * we know what timings to use.  If we can't identify it then
> +	 * we know it's an xM.  To map the ID values please see nand_ids.c
> +	 */
> +	identify_nand_chip(&pop_mfr, &pop_id);
> +
> +	timings->mr = MICRON_V_MR_165;
> +	switch (get_board_revision()) {
> +	case REVISION_C4:
> +		if (pop_mfr == NAND_MFR_STMICRO && pop_id == 0xba) {
> +			/* 512MB DDR */
> +			timings->mcfg = NUMONYX_V_MCFG_165(512 << 20);
> +			timings->ctrla = NUMONYX_V_ACTIMA_165;
> +			timings->ctrlb = NUMONYX_V_ACTIMB_165;
> +			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
> +			break;
> +		} else if (pop_mfr == NAND_MFR_MICRON && pop_id == 0xba) {
> +			/* Beagleboard Rev C4, 512MB Nand/256MB DDR*/
> +			timings->mcfg = MICRON_V_MCFG_165(128 << 20);
> +			timings->ctrla = MICRON_V_ACTIMA_165;
> +			timings->ctrlb = MICRON_V_ACTIMB_165;
> +			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
> +			break;
> +		} else if (pop_mfr == NAND_MFR_MICRON && pop_id == 0xbc) {
> +			/* Beagleboard Rev C5, 256MB DDR */
> +			timings->mcfg = MICRON_V_MCFG_200(256 << 20);
> +			timings->ctrla = MICRON_V_ACTIMA_200;
> +			timings->ctrlb = MICRON_V_ACTIMB_200;
> +			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHZ;
> +			break;
> +		}
> +	case REVISION_XM_AB:
> +	case REVISION_XM_C:
> +		if (pop_mfr == 0) {
> +			/* 256MB DDR */
> +			timings->mcfg = MICRON_V_MCFG_200(256 << 20);
> +			timings->ctrla = MICRON_V_ACTIMA_200;
> +			timings->ctrlb = MICRON_V_ACTIMB_200;
> +			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHZ;
> +		} else {
> +			/* 512MB DDR */
> +			timings->mcfg = NUMONYX_V_MCFG_165(512 << 20);
> +			timings->ctrla = NUMONYX_V_ACTIMA_165;
> +			timings->ctrlb = NUMONYX_V_ACTIMB_165;
> +			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
> +		}
> +		break;
> +	default:
> +		/* Assume 128MB and Micron/165MHz timings to be safe */
> +		timings->mcfg = MICRON_V_MCFG_165(128 << 20);
> +		timings->ctrla = MICRON_V_ACTIMA_165;
> +		timings->ctrlb = MICRON_V_ACTIMB_165;
> +		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
> +	}
> +}
> +#endif
> +
> +/*
> + * Routine: get_expansion_id
> + * Description: This function checks for expansion board by checking I2C
> + *		bus 1 for the availability of an AT24C01B serial EEPROM.
> + *		returns the device_vendor field from the EEPROM
> + */
> +static unsigned int get_expansion_id(void)
> +{
> +#if (IS_ENABLED(CONFIG_DM_I2C))
> +	struct udevice *dev;
> +	struct udevice *bus;
> +	int rc;
> +
> +	rc = uclass_get_device_by_seq(UCLASS_I2C, CONFIG_EEPROM_BUS_ADDRESS,
> +				      &bus);
> +	if (rc)
> +		return rc;
> +	rc = dm_i2c_probe(bus, CONFIG_EEPROM_CHIP_ADDRESS, 0, &dev);
> +	if (rc)
> +		return rc;
> +
> +	/* Read configuration data. */
> +	(void)dm_i2c_read(dev, 1, (u8 *)&expansion_config,
> +			  sizeof(expansion_config));
> +
> +	/* Retry reading configuration data with 16-bit addressing */
> +	if (expansion_config.device_vendor == 0xFFFFFF00 ||
> +	    expansion_config.device_vendor == 0xFFFFFFFF) {
> +		printf("EEPROM may be blank, retrying with 16-bit:\n");
> +		(void)dm_i2c_read(dev, 2, (u8 *)&expansion_config,
> +				  sizeof(expansion_config));
> +	}
> +#else
> +	/* Read configuration data. */
> +	i2c_read(CONFIG_EEPROM_CHIP_ADDRESS, 0, 1, (u8 *)&expansion_config,
> +		 sizeof(expansion_config));
> +
> +	/* Retry reading configuration data with 16bit addressing. */
> +	if (expansion_config.device_vendor == 0xFFFFFF00 ||
> +	    expansion_config.device_vendor == 0xFFFFFFFF) {
> +		printf("EEPROM is blank or 8bit addressing failed: retrying with 16bit:\n");
> +		i2c_read(CONFIG_EEPROM_CHIP_ADDRESS, 0, 2, (u8 *)&expansion_config,
> +			 sizeof(expansion_config));
> +	}
> +
> +	i2c_set_bus_num(TWL4030_I2C_BUS);
> +#endif
> +	return expansion_config.device_vendor;
> +}
> +
> +#if (IS_ENABLED(CONFIG_VIDEO_OMAP3))
> +/*
> + * Configure DSS to display background color on DVID
> + * Configure VENC to display color bar on S-Video
> + */
> +static void beagle_display_init(void)
> +{
> +	omap3_dss_venc_config(&venc_config_std_tv, VENC_HEIGHT, VENC_WIDTH);
> +	switch (get_board_revision()) {
> +	case REVISION_AXBX:
> +	case REVISION_CX:
> +	case REVISION_C4:
> +		omap3_dss_panel_config(&dvid_cfg);
> +		break;
> +	case REVISION_XM_AB:
> +	case REVISION_XM_C:
> +	default:
> +		omap3_dss_panel_config(&dvid_cfg_xm);
> +		break;
> +	}
> +}
> +
> +/*
> + * Enable DVI power
> + */
> +static void beagle_dvi_pup(void)
> +{
> +	uchar val;
> +
> +	switch (get_board_revision()) {
> +	case REVISION_AXBX:
> +	case REVISION_CX:
> +	case REVISION_C4:
> +		gpio_request(170, "dvi");
> +		gpio_direction_output(170, 0);
> +		gpio_set_value(170, 1);
> +		break;
> +	case REVISION_XM_AB:
> +	case REVISION_XM_C:
> +	default:
> +		#define GPIODATADIR1 (TWL4030_BASEADD_GPIO + 3)
> +		#define GPIODATAOUT1 (TWL4030_BASEADD_GPIO + 6)
> +
> +#if (IS_ENABLED(CONFIG_DM_I2C))
> +		struct udevice *dev;
> +		struct udevice *bus;
> +		int rc;
> +
> +		rc = uclass_get_device_by_seq(UCLASS_I2C, TWL4030_I2C_BUS,
> +					      &bus);
> +		if (rc)
> +			return;
> +		rc = dm_i2c_probe(bus, TWL4030_CHIP_GPIO, 0, &dev);
> +		if (rc)
> +			return;
> +
> +		(void)dm_i2c_read(dev, GPIODATADIR1, &val, 1);
> +		val |= 4;
> +		(void)dm_i2c_write(dev, GPIODATADIR1, &val, 1);
> +
> +		(void)dm_i2c_read(dev, GPIODATAOUT1, &val, 1);
> +		val |= 4;
> +		(void)dm_i2c_write(dev, GPIODATAOUT1, &val, 1);
> +#else
> +		i2c_read(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
> +		val |= 4;
> +		i2c_write(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
> +
> +		i2c_read(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
> +		val |= 4;
> +		i2c_write(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
> +#endif
> +		break;
> +	}
> +}
> +#endif
> +
> +/*
> + * Routine: misc_init_r
> + * Description: Configure board specific parts
> + */
> +int misc_init_r(void)
> +{
> +	struct gpio *gpio5_base = (struct gpio *)OMAP34XX_GPIO5_BASE;
> +	struct gpio *gpio6_base = (struct gpio *)OMAP34XX_GPIO6_BASE;
> +	struct control_prog_io *prog_io_base = (struct control_prog_io *)OMAP34XX_CTRL_BASE;
> +	bool generate_fake_mac = false;
> +	u32 value;
> +
> +	/* Enable i2c2 pullup resisters */
> +	value = readl(&prog_io_base->io1);
> +	value &= ~(PRG_I2C2_PULLUPRESX);
> +	writel(value, &prog_io_base->io1);
> +
> +	switch (get_board_revision()) {
> +	case REVISION_AXBX:
> +		printf("Beagle Rev Ax/Bx\n");
> +		env_set("beaglerev", "AxBx");
> +		break;
> +	case REVISION_CX:
> +		printf("Beagle Rev C1/C2/C3\n");
> +		env_set("beaglerev", "Cx");
> +		MUX_BEAGLE_C();
> +		break;
> +	case REVISION_C4:
> +		printf("Beagle Rev C4\n");
> +		env_set("beaglerev", "C4");
> +		MUX_BEAGLE_C();
> +		/* Set VAUX2 to 1.8V for EHCI PHY */
> +		twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
> +					TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
> +					TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
> +					TWL4030_PM_RECEIVER_DEV_GRP_P1);
> +		break;
> +	case REVISION_XM_AB:
> +		printf("Beagle xM Rev A/B\n");
> +		env_set("beaglerev", "xMAB");
> +		MUX_BEAGLE_XM();
> +		/* Set VAUX2 to 1.8V for EHCI PHY */
> +		twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
> +					TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
> +					TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
> +					TWL4030_PM_RECEIVER_DEV_GRP_P1);
> +		generate_fake_mac = true;
> +		break;
> +	case REVISION_XM_C:
> +		printf("Beagle xM Rev C\n");
> +		env_set("beaglerev", "xMC");
> +		MUX_BEAGLE_XM();
> +		/* Set VAUX2 to 1.8V for EHCI PHY */
> +		twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
> +					TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
> +					TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
> +					TWL4030_PM_RECEIVER_DEV_GRP_P1);
> +		generate_fake_mac = true;
> +		break;
> +	default:
> +		printf("Beagle unknown 0x%02x\n", get_board_revision());
> +		MUX_BEAGLE_XM();
> +		/* Set VAUX2 to 1.8V for EHCI PHY */
> +		twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
> +					TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
> +					TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
> +					TWL4030_PM_RECEIVER_DEV_GRP_P1);
> +		generate_fake_mac = true;
> +	}
> +
> +	switch (get_expansion_id()) {
> +	case TINCANTOOLS_ZIPPY:
> +		printf("Recognized Tincantools Zippy board (rev %d %s)\n",
> +		       expansion_config.revision,
> +		       expansion_config.fab_revision);
> +		MUX_TINCANTOOLS_ZIPPY();
> +		env_set("buddy", "zippy");
> +		break;
> +	case TINCANTOOLS_ZIPPY2:
> +		printf("Recognized Tincantools Zippy2 board (rev %d %s)\n",
> +		       expansion_config.revision,
> +		       expansion_config.fab_revision);
> +		MUX_TINCANTOOLS_ZIPPY();
> +		env_set("buddy", "zippy2");
> +		break;
> +	case TINCANTOOLS_TRAINER:
> +		printf("Recognized Tincantools Trainer board (rev %d %s)\n",
> +		       expansion_config.revision,
> +		       expansion_config.fab_revision);
> +		MUX_TINCANTOOLS_ZIPPY();
> +		MUX_TINCANTOOLS_TRAINER();
> +		env_set("buddy", "trainer");
> +		break;
> +	case TINCANTOOLS_SHOWDOG:
> +		printf("Recognized Tincantools Showdow board (rev %d %s)\n",
> +		       expansion_config.revision,
> +		       expansion_config.fab_revision);
> +		/* Place holder for DSS2 definition for showdog lcd */
> +		env_set("defaultdisplay", "showdoglcd");
> +		env_set("buddy", "showdog");
> +		break;
> +	case KBADC_BEAGLEFPGA:
> +		printf("Recognized KBADC Beagle FPGA board\n");
> +		MUX_KBADC_BEAGLEFPGA();
> +		env_set("buddy", "beaglefpga");
> +		break;
> +	case LW_BEAGLETOUCH:
> +		printf("Recognized Liquidware BeagleTouch board\n");
> +		env_set("buddy", "beagletouch");
> +		break;
> +	case BRAINMUX_LCDOG:
> +		printf("Recognized Brainmux LCDog board\n");
> +		env_set("buddy", "lcdog");
> +		break;
> +	case BRAINMUX_LCDOGTOUCH:
> +		printf("Recognized Brainmux LCDog Touch board\n");
> +		env_set("buddy", "lcdogtouch");
> +		break;
> +	case BBTOYS_WIFI:
> +		printf("Recognized BeagleBoardToys WiFi board\n");
> +		MUX_BBTOYS_WIFI()
> +		env_set("buddy", "bbtoys-wifi");
> +		break;
> +	case BBTOYS_VGA:
> +		printf("Recognized BeagleBoardToys VGA board\n");
> +		break;
> +	case BBTOYS_LCD:
> +		printf("Recognized BeagleBoardToys LCD board\n");
> +		break;
> +	case BCT_BRETTL3:
> +		printf("Recognized bct electronic GmbH brettl3 board\n");
> +		break;
> +	case BCT_BRETTL4:
> +		printf("Recognized bct electronic GmbH brettl4 board\n");
> +		break;
> +	case LSR_COM6L_ADPT:
> +		printf("Recognized LSR COM6L Adapter Board\n");
> +		MUX_BBTOYS_WIFI()
> +		env_set("buddy", "lsr-com6l-adpt");
> +		break;
> +	case BEAGLE_NO_EEPROM:
> +		printf("No EEPROM on expansion board\n");
> +		env_set("buddy", "none");
> +		break;
> +	default:
> +		printf("Unrecognized expansion board: %x\n",
> +		       expansion_config.device_vendor);
> +		env_set("buddy", "unknown");
> +	}
> +
> +	if (expansion_config.content == 1)
> +		env_set(expansion_config.env_var, expansion_config.env_setting);
> +
> +	twl4030_power_init();
> +	twl4030_power_mmc_init(0);
> +
> +	switch (get_board_revision()) {
> +	case REVISION_XM_AB:
> +		twl4030_led_init(TWL4030_LED_LEDEN_LEDBON);
> +		break;
> +	default:
> +		twl4030_led_init(TWL4030_LED_LEDEN_LEDAON | TWL4030_LED_LEDEN_LEDBON);
> +		break;
> +	}
> +
> +	/* Set GPIO states before they are made outputs */
> +	writel(GPIO23 | GPIO10 | GPIO8 | GPIO2 | GPIO1,
> +	       &gpio6_base->setdataout);
> +	writel(GPIO31 | GPIO30 | GPIO29 | GPIO28 | GPIO22 | GPIO21 |
> +	       GPIO15 | GPIO14 | GPIO13 | GPIO12, &gpio5_base->setdataout);
> +
> +	/* Configure GPIOs to output */
> +	writel(~(GPIO23 | GPIO10 | GPIO8 | GPIO2 | GPIO1), &gpio6_base->oe);
> +	writel(~(GPIO31 | GPIO30 | GPIO29 | GPIO28 | GPIO22 | GPIO21 |
> +		GPIO15 | GPIO14 | GPIO13 | GPIO12), &gpio5_base->oe);
> +
> +	omap_die_id_display();
> +
> +#if (IS_ENABLED(CONFIG_VIDEO_OMAP3))
> +	beagle_dvi_pup();
> +	beagle_display_init();
> +	omap3_dss_enable();
> +#endif
> +
> +	if (generate_fake_mac)
> +		omap_die_id_usbethaddr();
> +
> +#if defined(CONFIG_MTDIDS_DEFAULT) && defined(CONFIG_MTDPARTS_DEFAULT)
> +	if (strlen(CONFIG_MTDIDS_DEFAULT))
> +		env_set("mtdids", CONFIG_MTDIDS_DEFAULT);
> +
> +	if (strlen(CONFIG_MTDPARTS_DEFAULT))
> +		env_set("mtdparts", CONFIG_MTDPARTS_DEFAULT);
> +#endif
> +
> +	return 0;
> +}
> +
> +/*
> + * Routine: set_muxconf_regs
> + * Description: Setting up the configuration Mux registers specific to the
> + *		hardware. Many pins need to be moved from protect to primary
> + *		mode.
> + */
> +void set_muxconf_regs(void)
> +{
> +	/* Convert to be like am335x/mux.c file. */
> +	MUX_BEAGLE();
> +}
> diff --git a/board/beagle/beagle/beagle.h b/board/beagle/beagle/beagle.h
> new file mode 100644
> index 00000000000..ce78ea661b9
> --- /dev/null
> +++ b/board/beagle/beagle/beagle.h
> @@ -0,0 +1,545 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2008
> + * Dirk Behme <dirk.behme@gmail.com>
> + */
> +#ifndef _BEAGLE_H_
> +#define _BEAGLE_H_
> +
> +#include <asm/arch/dss.h>
> +
> +const omap3_sysinfo sysinfo = {
> +	DDR_STACKED,
> +	"OMAP3 Beagle board",
> +#if defined(CONFIG_ENV_IS_IN_ONENAND)
> +	"OneNAND",
> +#else
> +	"NAND",
> +#endif
> +};
> +
> +/* BeagleBoard revisions */
> +#define REVISION_AXBX	0x7
> +#define REVISION_CX	0x6
> +#define REVISION_C4	0x5
> +#define REVISION_XM_AB	0x0
> +#define REVISION_XM_C	0x2
> +
> +/*
> + * IEN  - Input Enable
> + * IDIS - Input Disable
> + * PTD  - Pull type Down
> + * PTU  - Pull type Up
> + * DIS  - Pull type selection is inactive
> + * EN   - Pull type selection is active
> + * M0   - Mode 0
> + * The commented string gives the final mux configuration for that pin
> + */
> +#define MUX_BEAGLE() \
> + /*SDRC*/\
> +	MUX_VAL(CP(SDRC_D0),		(IEN  | PTD | DIS | M0)) /*SDRC_D0*/\
> +	MUX_VAL(CP(SDRC_D1),		(IEN  | PTD | DIS | M0)) /*SDRC_D1*/\
> +	MUX_VAL(CP(SDRC_D2),		(IEN  | PTD | DIS | M0)) /*SDRC_D2*/\
> +	MUX_VAL(CP(SDRC_D3),		(IEN  | PTD | DIS | M0)) /*SDRC_D3*/\
> +	MUX_VAL(CP(SDRC_D4),		(IEN  | PTD | DIS | M0)) /*SDRC_D4*/\
> +	MUX_VAL(CP(SDRC_D5),		(IEN  | PTD | DIS | M0)) /*SDRC_D5*/\
> +	MUX_VAL(CP(SDRC_D6),		(IEN  | PTD | DIS | M0)) /*SDRC_D6*/\
> +	MUX_VAL(CP(SDRC_D7),		(IEN  | PTD | DIS | M0)) /*SDRC_D7*/\
> +	MUX_VAL(CP(SDRC_D8),		(IEN  | PTD | DIS | M0)) /*SDRC_D8*/\
> +	MUX_VAL(CP(SDRC_D9),		(IEN  | PTD | DIS | M0)) /*SDRC_D9*/\
> +	MUX_VAL(CP(SDRC_D10),		(IEN  | PTD | DIS | M0)) /*SDRC_D10*/\
> +	MUX_VAL(CP(SDRC_D11),		(IEN  | PTD | DIS | M0)) /*SDRC_D11*/\
> +	MUX_VAL(CP(SDRC_D12),		(IEN  | PTD | DIS | M0)) /*SDRC_D12*/\
> +	MUX_VAL(CP(SDRC_D13),		(IEN  | PTD | DIS | M0)) /*SDRC_D13*/\
> +	MUX_VAL(CP(SDRC_D14),		(IEN  | PTD | DIS | M0)) /*SDRC_D14*/\
> +	MUX_VAL(CP(SDRC_D15),		(IEN  | PTD | DIS | M0)) /*SDRC_D15*/\
> +	MUX_VAL(CP(SDRC_D16),		(IEN  | PTD | DIS | M0)) /*SDRC_D16*/\
> +	MUX_VAL(CP(SDRC_D17),		(IEN  | PTD | DIS | M0)) /*SDRC_D17*/\
> +	MUX_VAL(CP(SDRC_D18),		(IEN  | PTD | DIS | M0)) /*SDRC_D18*/\
> +	MUX_VAL(CP(SDRC_D19),		(IEN  | PTD | DIS | M0)) /*SDRC_D19*/\
> +	MUX_VAL(CP(SDRC_D20),		(IEN  | PTD | DIS | M0)) /*SDRC_D20*/\
> +	MUX_VAL(CP(SDRC_D21),		(IEN  | PTD | DIS | M0)) /*SDRC_D21*/\
> +	MUX_VAL(CP(SDRC_D22),		(IEN  | PTD | DIS | M0)) /*SDRC_D22*/\
> +	MUX_VAL(CP(SDRC_D23),		(IEN  | PTD | DIS | M0)) /*SDRC_D23*/\
> +	MUX_VAL(CP(SDRC_D24),		(IEN  | PTD | DIS | M0)) /*SDRC_D24*/\
> +	MUX_VAL(CP(SDRC_D25),		(IEN  | PTD | DIS | M0)) /*SDRC_D25*/\
> +	MUX_VAL(CP(SDRC_D26),		(IEN  | PTD | DIS | M0)) /*SDRC_D26*/\
> +	MUX_VAL(CP(SDRC_D27),		(IEN  | PTD | DIS | M0)) /*SDRC_D27*/\
> +	MUX_VAL(CP(SDRC_D28),		(IEN  | PTD | DIS | M0)) /*SDRC_D28*/\
> +	MUX_VAL(CP(SDRC_D29),		(IEN  | PTD | DIS | M0)) /*SDRC_D29*/\
> +	MUX_VAL(CP(SDRC_D30),		(IEN  | PTD | DIS | M0)) /*SDRC_D30*/\
> +	MUX_VAL(CP(SDRC_D31),		(IEN  | PTD | DIS | M0)) /*SDRC_D31*/\
> +	MUX_VAL(CP(SDRC_CLK),		(IEN  | PTD | DIS | M0)) /*SDRC_CLK*/\
> +	MUX_VAL(CP(SDRC_DQS0),		(IEN  | PTD | DIS | M0)) /*SDRC_DQS0*/\
> +	MUX_VAL(CP(SDRC_DQS1),		(IEN  | PTD | DIS | M0)) /*SDRC_DQS1*/\
> +	MUX_VAL(CP(SDRC_DQS2),		(IEN  | PTD | DIS | M0)) /*SDRC_DQS2*/\
> +	MUX_VAL(CP(SDRC_DQS3),		(IEN  | PTD | DIS | M0)) /*SDRC_DQS3*/\
> + /*GPMC*/\
> +	MUX_VAL(CP(GPMC_A1),		(IDIS | PTD | DIS | M0)) /*GPMC_A1*/\
> +	MUX_VAL(CP(GPMC_A2),		(IDIS | PTD | DIS | M0)) /*GPMC_A2*/\
> +	MUX_VAL(CP(GPMC_A3),		(IDIS | PTD | DIS | M0)) /*GPMC_A3*/\
> +	MUX_VAL(CP(GPMC_A4),		(IDIS | PTD | DIS | M0)) /*GPMC_A4*/\
> +	MUX_VAL(CP(GPMC_A5),		(IDIS | PTD | DIS | M0)) /*GPMC_A5*/\
> +	MUX_VAL(CP(GPMC_A6),		(IDIS | PTD | DIS | M0)) /*GPMC_A6*/\
> +	MUX_VAL(CP(GPMC_A7),		(IDIS | PTD | DIS | M0)) /*GPMC_A7*/\
> +	MUX_VAL(CP(GPMC_A8),		(IDIS | PTD | DIS | M0)) /*GPMC_A8*/\
> +	MUX_VAL(CP(GPMC_A9),		(IDIS | PTD | DIS | M0)) /*GPMC_A9*/\
> +	MUX_VAL(CP(GPMC_A10),		(IDIS | PTD | DIS | M0)) /*GPMC_A10*/\
> +	MUX_VAL(CP(GPMC_D0),		(IEN  | PTD | DIS | M0)) /*GPMC_D0*/\
> +	MUX_VAL(CP(GPMC_D1),		(IEN  | PTD | DIS | M0)) /*GPMC_D1*/\
> +	MUX_VAL(CP(GPMC_D2),		(IEN  | PTD | DIS | M0)) /*GPMC_D2*/\
> +	MUX_VAL(CP(GPMC_D3),		(IEN  | PTD | DIS | M0)) /*GPMC_D3*/\
> +	MUX_VAL(CP(GPMC_D4),		(IEN  | PTD | DIS | M0)) /*GPMC_D4*/\
> +	MUX_VAL(CP(GPMC_D5),		(IEN  | PTD | DIS | M0)) /*GPMC_D5*/\
> +	MUX_VAL(CP(GPMC_D6),		(IEN  | PTD | DIS | M0)) /*GPMC_D6*/\
> +	MUX_VAL(CP(GPMC_D7),		(IEN  | PTD | DIS | M0)) /*GPMC_D7*/\
> +	MUX_VAL(CP(GPMC_D8),		(IEN  | PTD | DIS | M0)) /*GPMC_D8*/\
> +	MUX_VAL(CP(GPMC_D9),		(IEN  | PTD | DIS | M0)) /*GPMC_D9*/\
> +	MUX_VAL(CP(GPMC_D10),		(IEN  | PTD | DIS | M0)) /*GPMC_D10*/\
> +	MUX_VAL(CP(GPMC_D11),		(IEN  | PTD | DIS | M0)) /*GPMC_D11*/\
> +	MUX_VAL(CP(GPMC_D12),		(IEN  | PTD | DIS | M0)) /*GPMC_D12*/\
> +	MUX_VAL(CP(GPMC_D13),		(IEN  | PTD | DIS | M0)) /*GPMC_D13*/\
> +	MUX_VAL(CP(GPMC_D14),		(IEN  | PTD | DIS | M0)) /*GPMC_D14*/\
> +	MUX_VAL(CP(GPMC_D15),		(IEN  | PTD | DIS | M0)) /*GPMC_D15*/\
> +	MUX_VAL(CP(GPMC_NCS0),		(IDIS | PTU | EN  | M0)) /*GPMC_nCS0*/\
> +	MUX_VAL(CP(GPMC_NCS1),		(IDIS | PTU | EN  | M0)) /*GPMC_nCS1*/\
> +	MUX_VAL(CP(GPMC_NCS2),		(IDIS | PTU | EN  | M0)) /*GPMC_nCS2*/\
> +	MUX_VAL(CP(GPMC_NCS3),		(IDIS | PTU | EN  | M0)) /*GPMC_nCS3*/\
> +	MUX_VAL(CP(GPMC_NCS4),		(IDIS | PTU | EN  | M0)) /*GPMC_nCS4*/\
> +	MUX_VAL(CP(GPMC_NCS5),		(IDIS | PTD | DIS | M0)) /*GPMC_nCS5*/\
> +	MUX_VAL(CP(GPMC_NCS6),		(IEN  | PTD | DIS | M1)) /*SYS_nDMA_REQ2*/\
> +	MUX_VAL(CP(GPMC_NCS7),		(IEN  | PTU | EN  | M1)) /*SYS_nDMA_REQ3*/\
> +	MUX_VAL(CP(GPMC_NBE1),		(IEN  | PTD | DIS | M0)) /*GPMC_nBE1*/\
> +	MUX_VAL(CP(GPMC_WAIT2),		(IEN  | PTU | EN  | M0)) /*GPMC_WAIT2*/\
> +	MUX_VAL(CP(GPMC_WAIT3),		(IEN  | PTU | EN  | M0)) /*GPMC_WAIT3*/\
> +	MUX_VAL(CP(GPMC_CLK),		(IDIS | PTD | DIS | M0)) /*GPMC_CLK*/\
> +	MUX_VAL(CP(GPMC_NADV_ALE),	(IDIS | PTD | DIS | M0)) /*GPMC_nADV_ALE*/\
> +	MUX_VAL(CP(GPMC_NOE),		(IDIS | PTD | DIS | M0)) /*GPMC_nOE*/\
> +	MUX_VAL(CP(GPMC_NWE),		(IDIS | PTD | DIS | M0)) /*GPMC_nWE*/\
> +	MUX_VAL(CP(GPMC_NBE0_CLE),	(IDIS | PTD | DIS | M0)) /*GPMC_nBE0_CLE*/\
> +	MUX_VAL(CP(GPMC_NWP),		(IEN  | PTD | DIS | M0)) /*GPMC_nWP*/\
> +	MUX_VAL(CP(GPMC_WAIT0),		(IEN  | PTU | EN  | M0)) /*GPMC_WAIT0*/\
> +	MUX_VAL(CP(GPMC_WAIT1),		(IEN  | PTU | EN  | M0)) /*GPMC_WAIT1*/\
> + /*DSS*/\
> +	MUX_VAL(CP(DSS_PCLK),		(IDIS | PTD | DIS | M0)) /*DSS_PCLK*/\
> +	MUX_VAL(CP(DSS_HSYNC),		(IDIS | PTD | DIS | M0)) /*DSS_HSYNC*/\
> +	MUX_VAL(CP(DSS_VSYNC),		(IDIS | PTD | DIS | M0)) /*DSS_VSYNC*/\
> +	MUX_VAL(CP(DSS_ACBIAS),		(IDIS | PTD | DIS | M0)) /*DSS_ACBIAS*/\
> +	MUX_VAL(CP(DSS_DATA0),		(IDIS | PTD | DIS | M0)) /*DSS_DATA0*/\
> +	MUX_VAL(CP(DSS_DATA1),		(IDIS | PTD | DIS | M0)) /*DSS_DATA1*/\
> +	MUX_VAL(CP(DSS_DATA2),		(IDIS | PTD | DIS | M0)) /*DSS_DATA2*/\
> +	MUX_VAL(CP(DSS_DATA3),		(IDIS | PTD | DIS | M0)) /*DSS_DATA3*/\
> +	MUX_VAL(CP(DSS_DATA4),		(IDIS | PTD | DIS | M0)) /*DSS_DATA4*/\
> +	MUX_VAL(CP(DSS_DATA5),		(IDIS | PTD | DIS | M0)) /*DSS_DATA5*/\
> +	MUX_VAL(CP(DSS_DATA6),		(IDIS | PTD | DIS | M0)) /*DSS_DATA6*/\
> +	MUX_VAL(CP(DSS_DATA7),		(IDIS | PTD | DIS | M0)) /*DSS_DATA7*/\
> +	MUX_VAL(CP(DSS_DATA8),		(IDIS | PTD | DIS | M0)) /*DSS_DATA8*/\
> +	MUX_VAL(CP(DSS_DATA9),		(IDIS | PTD | DIS | M0)) /*DSS_DATA9*/\
> +	MUX_VAL(CP(DSS_DATA10),		(IDIS | PTD | DIS | M0)) /*DSS_DATA10*/\
> +	MUX_VAL(CP(DSS_DATA11),		(IDIS | PTD | DIS | M0)) /*DSS_DATA11*/\
> +	MUX_VAL(CP(DSS_DATA12),		(IDIS | PTD | DIS | M0)) /*DSS_DATA12*/\
> +	MUX_VAL(CP(DSS_DATA13),		(IDIS | PTD | DIS | M0)) /*DSS_DATA13*/\
> +	MUX_VAL(CP(DSS_DATA14),		(IDIS | PTD | DIS | M0)) /*DSS_DATA14*/\
> +	MUX_VAL(CP(DSS_DATA15),		(IDIS | PTD | DIS | M0)) /*DSS_DATA15*/\
> +	MUX_VAL(CP(DSS_DATA16),		(IDIS | PTD | DIS | M0)) /*DSS_DATA16*/\
> +	MUX_VAL(CP(DSS_DATA17),		(IDIS | PTD | DIS | M0)) /*DSS_DATA17*/\
> +	MUX_VAL(CP(DSS_DATA18),		(IDIS | PTD | DIS | M0)) /*DSS_DATA18*/\
> +	MUX_VAL(CP(DSS_DATA19),		(IDIS | PTD | DIS | M0)) /*DSS_DATA19*/\
> +	MUX_VAL(CP(DSS_DATA20),		(IDIS | PTD | DIS | M0)) /*DSS_DATA20*/\
> +	MUX_VAL(CP(DSS_DATA21),		(IDIS | PTD | DIS | M0)) /*DSS_DATA21*/\
> +	MUX_VAL(CP(DSS_DATA22),		(IDIS | PTD | DIS | M0)) /*DSS_DATA22*/\
> +	MUX_VAL(CP(DSS_DATA23),		(IDIS | PTD | DIS | M0)) /*DSS_DATA23*/\
> + /*CAMERA*/\
> +	MUX_VAL(CP(CAM_HS),		(IEN  | PTU | EN  | M0)) /*CAM_HS */\
> +	MUX_VAL(CP(CAM_VS),		(IEN  | PTU | EN  | M0)) /*CAM_VS */\
> +	MUX_VAL(CP(CAM_XCLKA),		(IDIS | PTD | DIS | M0)) /*CAM_XCLKA*/\
> +	MUX_VAL(CP(CAM_PCLK),		(IEN  | PTU | EN  | M0)) /*CAM_PCLK*/\
> +	MUX_VAL(CP(CAM_FLD),		(IDIS | PTD | DIS | M4)) /*GPIO_98*/\
> +	MUX_VAL(CP(CAM_D0),		(IEN  | PTD | DIS | M0)) /*CAM_D0*/\
> +	MUX_VAL(CP(CAM_D1),		(IEN  | PTD | DIS | M0)) /*CAM_D1*/\
> +	MUX_VAL(CP(CAM_D2),		(IEN  | PTD | DIS | M0)) /*CAM_D2*/\
> +	MUX_VAL(CP(CAM_D3),		(IEN  | PTD | DIS | M0)) /*CAM_D3*/\
> +	MUX_VAL(CP(CAM_D4),		(IEN  | PTD | DIS | M0)) /*CAM_D4*/\
> +	MUX_VAL(CP(CAM_D5),		(IEN  | PTD | DIS | M0)) /*CAM_D5*/\
> +	MUX_VAL(CP(CAM_D6),		(IEN  | PTD | DIS | M0)) /*CAM_D6*/\
> +	MUX_VAL(CP(CAM_D7),		(IEN  | PTD | DIS | M0)) /*CAM_D7*/\
> +	MUX_VAL(CP(CAM_D8),		(IEN  | PTD | DIS | M0)) /*CAM_D8*/\
> +	MUX_VAL(CP(CAM_D9),		(IEN  | PTD | DIS | M0)) /*CAM_D9*/\
> +	MUX_VAL(CP(CAM_D10),		(IEN  | PTD | DIS | M0)) /*CAM_D10*/\
> +	MUX_VAL(CP(CAM_D11),		(IEN  | PTD | DIS | M0)) /*CAM_D11*/\
> +	MUX_VAL(CP(CAM_XCLKB),		(IDIS | PTD | DIS | M0)) /*CAM_XCLKB*/\
> +	MUX_VAL(CP(CAM_WEN),		(IEN  | PTD | DIS | M4)) /*GPIO_167*/\
> +	MUX_VAL(CP(CAM_STROBE),		(IDIS | PTD | DIS | M0)) /*CAM_STROBE*/\
> +	MUX_VAL(CP(CSI2_DX0),		(IEN  | PTD | DIS | M0)) /*CSI2_DX0*/\
> +	MUX_VAL(CP(CSI2_DY0),		(IEN  | PTD | DIS | M0)) /*CSI2_DY0*/\
> +	MUX_VAL(CP(CSI2_DX1),		(IEN  | PTD | DIS | M0)) /*CSI2_DX1*/\
> +	MUX_VAL(CP(CSI2_DY1),		(IEN  | PTD | DIS | M0)) /*CSI2_DY1*/\
> + /*Audio Interface */\
> +	MUX_VAL(CP(MCBSP2_FSX),		(IEN  | PTD | DIS | M0)) /*McBSP2_FSX*/\
> +	MUX_VAL(CP(MCBSP2_CLKX),	(IEN  | PTD | DIS | M0)) /*McBSP2_CLKX*/\
> +	MUX_VAL(CP(MCBSP2_DR),		(IEN  | PTD | DIS | M0)) /*McBSP2_DR*/\
> +	MUX_VAL(CP(MCBSP2_DX),		(IDIS | PTD | DIS | M0)) /*McBSP2_DX*/\
> + /*Expansion card */\
> +	MUX_VAL(CP(MMC1_CLK),		(IDIS | PTU | EN  | M0)) /*MMC1_CLK*/\
> +	MUX_VAL(CP(MMC1_CMD),		(IEN  | PTU | EN  | M0)) /*MMC1_CMD*/\
> +	MUX_VAL(CP(MMC1_DAT0),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT0*/\
> +	MUX_VAL(CP(MMC1_DAT1),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT1*/\
> +	MUX_VAL(CP(MMC1_DAT2),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT2*/\
> +	MUX_VAL(CP(MMC1_DAT3),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT3*/\
> +	MUX_VAL(CP(MMC1_DAT4),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT4*/\
> +	MUX_VAL(CP(MMC1_DAT5),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT5*/\
> +	MUX_VAL(CP(MMC1_DAT6),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT6*/\
> +	MUX_VAL(CP(MMC1_DAT7),		(IEN  | PTU | EN  | M0)) /*MMC1_DAT7*/\
> + /*Wireless LAN */\
> +	MUX_VAL(CP(MMC2_CLK),		(IEN  | PTU | EN  | M4)) /*GPIO_130*/\
> +	MUX_VAL(CP(MMC2_CMD),		(IEN  | PTU | EN  | M4)) /*GPIO_131*/\
> +	MUX_VAL(CP(MMC2_DAT0),		(IEN  | PTU | EN  | M4)) /*GPIO_132*/\
> +	MUX_VAL(CP(MMC2_DAT1),		(IEN  | PTU | EN  | M4)) /*GPIO_133*/\
> +	MUX_VAL(CP(MMC2_DAT2),		(IEN  | PTU | EN  | M4)) /*GPIO_134*/\
> +	MUX_VAL(CP(MMC2_DAT3),		(IEN  | PTU | EN  | M4)) /*GPIO_135*/\
> +	MUX_VAL(CP(MMC2_DAT4),		(IEN  | PTU | EN  | M4)) /*GPIO_136*/\
> +	MUX_VAL(CP(MMC2_DAT5),		(IEN  | PTU | EN  | M4)) /*GPIO_137*/\
> +	MUX_VAL(CP(MMC2_DAT6),		(IEN  | PTU | EN  | M4)) /*GPIO_138*/\
> +	MUX_VAL(CP(MMC2_DAT7),		(IEN  | PTU | EN  | M4)) /*GPIO_139*/\
> + /*Bluetooth*/\
> +	MUX_VAL(CP(MCBSP3_DX),		(IEN  | PTD | DIS | M1)) /*UART2_CTS*/\
> +	MUX_VAL(CP(MCBSP3_DR),		(IDIS | PTD | DIS | M1)) /*UART2_RTS*/\
> +	MUX_VAL(CP(MCBSP3_CLKX),	(IDIS | PTD | DIS | M1)) /*UART2_TX*/\
> +	MUX_VAL(CP(MCBSP3_FSX),		(IEN  | PTD | DIS | M1)) /*UART2_RX*/\
> +	MUX_VAL(CP(UART2_CTS),		(IEN  | PTD | DIS | M4)) /*GPIO_144*/\
> +	MUX_VAL(CP(UART2_RTS),		(IEN  | PTD | DIS | M4)) /*GPIO_145*/\
> +	MUX_VAL(CP(UART2_TX),		(IEN  | PTD | DIS | M4)) /*GPIO_146*/\
> +	MUX_VAL(CP(UART2_RX),		(IEN  | PTD | DIS | M4)) /*GPIO_147*/\
> + /*Modem Interface */\
> +	MUX_VAL(CP(UART1_TX),		(IDIS | PTD | DIS | M0)) /*UART1_TX*/\
> +	MUX_VAL(CP(UART1_RTS),		(IDIS | PTD | DIS | M4)) /*GPIO_149*/ \
> +	MUX_VAL(CP(UART1_CTS),		(IDIS | PTD | DIS | M4)) /*GPIO_150*/ \
> +	MUX_VAL(CP(UART1_RX),		(IEN  | PTD | DIS | M0)) /*UART1_RX*/\
> +	MUX_VAL(CP(MCBSP4_CLKX),	(IEN  | PTD | DIS | M1)) /*SSI1_DAT_RX*/\
> +	MUX_VAL(CP(MCBSP4_DR),		(IEN  | PTD | DIS | M1)) /*SSI1_FLAG_RX*/\
> +	MUX_VAL(CP(MCBSP4_DX),		(IEN  | PTD | DIS | M1)) /*SSI1_RDY_RX*/\
> +	MUX_VAL(CP(MCBSP4_FSX),		(IEN  | PTD | DIS | M1)) /*SSI1_WAKE*/\
> +	MUX_VAL(CP(MCBSP1_CLKR),	(IDIS | PTD | DIS | M4)) /*GPIO_156*/\
> +	MUX_VAL(CP(MCBSP1_FSR),		(IDIS | PTU | EN  | M4)) /*GPIO_157*/\
> +	MUX_VAL(CP(MCBSP1_DX),		(IDIS | PTD | DIS | M4)) /*GPIO_158*/\
> +	MUX_VAL(CP(MCBSP1_DR),		(IDIS | PTD | DIS | M4)) /*GPIO_159*/\
> +	MUX_VAL(CP(MCBSP_CLKS),		(IEN  | PTU | DIS | M0)) /*McBSP_CLKS*/\
> +	MUX_VAL(CP(MCBSP1_FSX),		(IDIS | PTD | DIS | M4)) /*GPIO_161*/\
> +	MUX_VAL(CP(MCBSP1_CLKX),	(IDIS | PTD | DIS | M4)) /*GPIO_162*/\
> + /*Serial Interface*/\
> +	MUX_VAL(CP(UART3_CTS_RCTX),	(IEN  | PTD | EN  | M0)) /*UART3_CTS_RCTX*/\
> +	MUX_VAL(CP(UART3_RTS_SD),	(IDIS | PTD | DIS | M0)) /*UART3_RTS_SD */\
> +	MUX_VAL(CP(UART3_RX_IRRX),	(IEN  | PTD | DIS | M0)) /*UART3_RX_IRRX*/\
> +	MUX_VAL(CP(UART3_TX_IRTX),	(IDIS | PTD | DIS | M0)) /*UART3_TX_IRTX*/\
> +	MUX_VAL(CP(HSUSB0_CLK),		(IEN  | PTD | DIS | M0)) /*HSUSB0_CLK*/\
> +	MUX_VAL(CP(HSUSB0_STP),		(IDIS | PTU | EN  | M0)) /*HSUSB0_STP*/\
> +	MUX_VAL(CP(HSUSB0_DIR),		(IEN  | PTD | DIS | M0)) /*HSUSB0_DIR*/\
> +	MUX_VAL(CP(HSUSB0_NXT),		(IEN  | PTD | DIS | M0)) /*HSUSB0_NXT*/\
> +	MUX_VAL(CP(HSUSB0_DATA0),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA0*/\
> +	MUX_VAL(CP(HSUSB0_DATA1),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA1*/\
> +	MUX_VAL(CP(HSUSB0_DATA2),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA2*/\
> +	MUX_VAL(CP(HSUSB0_DATA3),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA3*/\
> +	MUX_VAL(CP(HSUSB0_DATA4),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA4*/\
> +	MUX_VAL(CP(HSUSB0_DATA5),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA5*/\
> +	MUX_VAL(CP(HSUSB0_DATA6),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA6*/\
> +	MUX_VAL(CP(HSUSB0_DATA7),	(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA7*/\
> +	MUX_VAL(CP(I2C1_SCL),		(IEN  | PTU | EN  | M0)) /*I2C1_SCL*/\
> +	MUX_VAL(CP(I2C1_SDA),		(IEN  | PTU | EN  | M0)) /*I2C1_SDA*/\
> +	MUX_VAL(CP(I2C2_SCL),		(IEN  | PTU | EN  | M0)) /*I2C2_SCL*/\
> +	MUX_VAL(CP(I2C2_SDA),		(IEN  | PTU | EN  | M0)) /*I2C2_SDA*/\
> +	MUX_VAL(CP(I2C3_SCL),		(IEN  | PTU | EN  | M0)) /*I2C3_SCL*/\
> +	MUX_VAL(CP(I2C3_SDA),		(IEN  | PTU | EN  | M0)) /*I2C3_SDA*/\
> +	MUX_VAL(CP(I2C4_SCL),		(IEN  | PTU | EN  | M0)) /*I2C4_SCL*/\
> +	MUX_VAL(CP(I2C4_SDA),		(IEN  | PTU | EN  | M0)) /*I2C4_SDA*/\
> +	MUX_VAL(CP(HDQ_SIO),		(IDIS | PTU | EN  | M4)) /*GPIO_170*/\
> +	MUX_VAL(CP(MCSPI1_CLK),		(IEN  | PTU | EN  | M4)) /*GPIO_171*/\
> +	MUX_VAL(CP(MCSPI1_SIMO),	(IEN  | PTU | EN  | M4)) /*GPIO_172*/\
> +	MUX_VAL(CP(MCSPI1_SOMI),	(IEN  | PTU | EN  | M4)) /*GPIO_173*/\
> +	MUX_VAL(CP(MCSPI1_CS0),		(IEN  | PTD | EN  | M0)) /*McSPI1_CS0*/\
> +	MUX_VAL(CP(MCSPI1_CS1),		(IDIS | PTD | EN  | M0)) /*McSPI1_CS1*/\
> +	MUX_VAL(CP(MCSPI1_CS2),		(IDIS | PTD | DIS | M4)) /*GPIO_176*/\
> + /* USB EHCI (port 2) */\
> +	MUX_VAL(CP(MCSPI1_CS3),		(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA2*/\
> +	MUX_VAL(CP(MCSPI2_CLK),		(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA7*/\
> +	MUX_VAL(CP(MCSPI2_SIMO),	(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA4*/\
> +	MUX_VAL(CP(MCSPI2_SOMI),	(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA5*/\
> +	MUX_VAL(CP(MCSPI2_CS0),		(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA6*/\
> +	MUX_VAL(CP(MCSPI2_CS1),		(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA3*/\
> +	MUX_VAL(CP(ETK_D10_ES2),	(IDIS | PTD | DIS | M3)) /*HSUSB2_CLK*/\
> +	MUX_VAL(CP(ETK_D11_ES2),	(IDIS | PTD | DIS | M3)) /*HSUSB2_STP*/\
> +	MUX_VAL(CP(ETK_D12_ES2),	(IEN  | PTD | EN  | M3)) /*HSUSB2_DIR*/\
> +	MUX_VAL(CP(ETK_D13_ES2),	(IEN  | PTD | EN  | M3)) /*HSUSB2_NXT*/\
> +	MUX_VAL(CP(ETK_D14_ES2),	(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA0*/\
> +	MUX_VAL(CP(ETK_D15_ES2),	(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA1*/\
> + /*Control and debug */\
> +	MUX_VAL(CP(SYS_32K),		(IEN  | PTD | DIS | M0)) /*SYS_32K*/\
> +	MUX_VAL(CP(SYS_CLKREQ),		(IEN  | PTD | DIS | M0)) /*SYS_CLKREQ*/\
> +	MUX_VAL(CP(SYS_NIRQ),		(IEN  | PTU | EN  | M0)) /*SYS_nIRQ*/\
> +	MUX_VAL(CP(SYS_BOOT0),		(IEN  | PTD | DIS | M4)) /*GPIO_2*/\
> +	MUX_VAL(CP(SYS_BOOT1),		(IEN  | PTD | DIS | M4)) /*GPIO_3*/\
> +	MUX_VAL(CP(SYS_BOOT2),		(IEN  | PTD | DIS | M4)) /*GPIO_4 - MMC1_WP*/\
> +	MUX_VAL(CP(SYS_BOOT3),		(IEN  | PTD | DIS | M4)) /*GPIO_5*/\
> +	MUX_VAL(CP(SYS_BOOT4),		(IEN  | PTD | DIS | M4)) /*GPIO_6*/\
> +	MUX_VAL(CP(SYS_BOOT5),		(IEN  | PTD | DIS | M4)) /*GPIO_7*/\
> +	MUX_VAL(CP(SYS_BOOT6),		(IDIS | PTD | DIS | M4)) /*GPIO_8*/ \
> +	MUX_VAL(CP(SYS_OFF_MODE),	(IEN  | PTD | DIS | M0)) /*SYS_OFF_MODE*/\
> +	MUX_VAL(CP(SYS_CLKOUT1),	(IEN  | PTD | DIS | M0)) /*SYS_CLKOUT1*/\
> +	MUX_VAL(CP(SYS_CLKOUT2),	(IEN  | PTU | EN  | M4)) /*GPIO_186*/\
> +	MUX_VAL(CP(ETK_CLK_ES2),	(IDIS | PTU | EN  | M3)) /*HSUSB1_STP*/\
> +	MUX_VAL(CP(ETK_CTL_ES2),	(IDIS | PTU | DIS | M3)) /*HSUSB1_CLK*/\
> +	MUX_VAL(CP(ETK_D0_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA0*/\
> +	MUX_VAL(CP(ETK_D1_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA1*/\
> +	MUX_VAL(CP(ETK_D2_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA2*/\
> +	MUX_VAL(CP(ETK_D3_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA7*/\
> +	MUX_VAL(CP(ETK_D4_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA4*/\
> +	MUX_VAL(CP(ETK_D5_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA5*/\
> +	MUX_VAL(CP(ETK_D6_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA6*/\
> +	MUX_VAL(CP(ETK_D7_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA3*/\
> +	MUX_VAL(CP(ETK_D8_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_DIR*/\
> +	MUX_VAL(CP(ETK_D9_ES2),		(IEN  | PTU | DIS | M3)) /*HSUSB1_NXT*/\
> +	MUX_VAL(CP(D2D_MCAD1),		(IEN  | PTD | EN  | M0)) /*d2d_mcad1*/\
> +	MUX_VAL(CP(D2D_MCAD2),		(IEN  | PTD | EN  | M0)) /*d2d_mcad2*/\
> +	MUX_VAL(CP(D2D_MCAD3),		(IEN  | PTD | EN  | M0)) /*d2d_mcad3*/\
> +	MUX_VAL(CP(D2D_MCAD4),		(IEN  | PTD | EN  | M0)) /*d2d_mcad4*/\
> +	MUX_VAL(CP(D2D_MCAD5),		(IEN  | PTD | EN  | M0)) /*d2d_mcad5*/\
> +	MUX_VAL(CP(D2D_MCAD6),		(IEN  | PTD | EN  | M0)) /*d2d_mcad6*/\
> +	MUX_VAL(CP(D2D_MCAD7),		(IEN  | PTD | EN  | M0)) /*d2d_mcad7*/\
> +	MUX_VAL(CP(D2D_MCAD8),		(IEN  | PTD | EN  | M0)) /*d2d_mcad8*/\
> +	MUX_VAL(CP(D2D_MCAD9),		(IEN  | PTD | EN  | M0)) /*d2d_mcad9*/\
> +	MUX_VAL(CP(D2D_MCAD10),		(IEN  | PTD | EN  | M0)) /*d2d_mcad10*/\
> +	MUX_VAL(CP(D2D_MCAD11),		(IEN  | PTD | EN  | M0)) /*d2d_mcad11*/\
> +	MUX_VAL(CP(D2D_MCAD12),		(IEN  | PTD | EN  | M0)) /*d2d_mcad12*/\
> +	MUX_VAL(CP(D2D_MCAD13),		(IEN  | PTD | EN  | M0)) /*d2d_mcad13*/\
> +	MUX_VAL(CP(D2D_MCAD14),		(IEN  | PTD | EN  | M0)) /*d2d_mcad14*/\
> +	MUX_VAL(CP(D2D_MCAD15),		(IEN  | PTD | EN  | M0)) /*d2d_mcad15*/\
> +	MUX_VAL(CP(D2D_MCAD16),		(IEN  | PTD | EN  | M0)) /*d2d_mcad16*/\
> +	MUX_VAL(CP(D2D_MCAD17),		(IEN  | PTD | EN  | M0)) /*d2d_mcad17*/\
> +	MUX_VAL(CP(D2D_MCAD18),		(IEN  | PTD | EN  | M0)) /*d2d_mcad18*/\
> +	MUX_VAL(CP(D2D_MCAD19),		(IEN  | PTD | EN  | M0)) /*d2d_mcad19*/\
> +	MUX_VAL(CP(D2D_MCAD20),		(IEN  | PTD | EN  | M0)) /*d2d_mcad20*/\
> +	MUX_VAL(CP(D2D_MCAD21),		(IEN  | PTD | EN  | M0)) /*d2d_mcad21*/\
> +	MUX_VAL(CP(D2D_MCAD22),		(IEN  | PTD | EN  | M0)) /*d2d_mcad22*/\
> +	MUX_VAL(CP(D2D_MCAD23),		(IEN  | PTD | EN  | M0)) /*d2d_mcad23*/\
> +	MUX_VAL(CP(D2D_MCAD24),		(IEN  | PTD | EN  | M0)) /*d2d_mcad24*/\
> +	MUX_VAL(CP(D2D_MCAD25),		(IEN  | PTD | EN  | M0)) /*d2d_mcad25*/\
> +	MUX_VAL(CP(D2D_MCAD26),		(IEN  | PTD | EN  | M0)) /*d2d_mcad26*/\
> +	MUX_VAL(CP(D2D_MCAD27),		(IEN  | PTD | EN  | M0)) /*d2d_mcad27*/\
> +	MUX_VAL(CP(D2D_MCAD28),		(IEN  | PTD | EN  | M0)) /*d2d_mcad28*/\
> +	MUX_VAL(CP(D2D_MCAD29),		(IEN  | PTD | EN  | M0)) /*d2d_mcad29*/\
> +	MUX_VAL(CP(D2D_MCAD30),		(IEN  | PTD | EN  | M0)) /*d2d_mcad30*/\
> +	MUX_VAL(CP(D2D_MCAD31),		(IEN  | PTD | EN  | M0)) /*d2d_mcad31*/\
> +	MUX_VAL(CP(D2D_MCAD32),		(IEN  | PTD | EN  | M0)) /*d2d_mcad32*/\
> +	MUX_VAL(CP(D2D_MCAD33),		(IEN  | PTD | EN  | M0)) /*d2d_mcad33*/\
> +	MUX_VAL(CP(D2D_MCAD34),		(IEN  | PTD | EN  | M0)) /*d2d_mcad34*/\
> +	MUX_VAL(CP(D2D_MCAD35),		(IEN  | PTD | EN  | M0)) /*d2d_mcad35*/\
> +	MUX_VAL(CP(D2D_MCAD36),		(IEN  | PTD | EN  | M0)) /*d2d_mcad36*/\
> +	MUX_VAL(CP(D2D_CLK26MI),	(IEN  | PTD | DIS | M0)) /*d2d_clk26mi*/\
> +	MUX_VAL(CP(D2D_NRESPWRON),	(IEN  | PTD | EN  | M0)) /*d2d_nrespwron*/\
> +	MUX_VAL(CP(D2D_NRESWARM),	(IEN  | PTU | EN  | M0)) /*d2d_nreswarm */\
> +	MUX_VAL(CP(D2D_ARM9NIRQ),	(IEN  | PTD | DIS | M0)) /*d2d_arm9nirq */\
> +	MUX_VAL(CP(D2D_UMA2P6FIQ),	(IEN  | PTD | DIS | M0)) /*d2d_uma2p6fiq*/\
> +	MUX_VAL(CP(D2D_SPINT),		(IEN  | PTD | EN  | M0)) /*d2d_spint*/\
> +	MUX_VAL(CP(D2D_FRINT),		(IEN  | PTD | EN  | M0)) /*d2d_frint*/\
> +	MUX_VAL(CP(D2D_DMAREQ0),	(IEN  | PTD | DIS | M0)) /*d2d_dmareq0*/\
> +	MUX_VAL(CP(D2D_DMAREQ1),	(IEN  | PTD | DIS | M0)) /*d2d_dmareq1*/\
> +	MUX_VAL(CP(D2D_DMAREQ2),	(IEN  | PTD | DIS | M0)) /*d2d_dmareq2*/\
> +	MUX_VAL(CP(D2D_DMAREQ3),	(IEN  | PTD | DIS | M0)) /*d2d_dmareq3*/\
> +	MUX_VAL(CP(D2D_N3GTRST),	(IEN  | PTD | DIS | M0)) /*d2d_n3gtrst*/\
> +	MUX_VAL(CP(D2D_N3GTDI),		(IEN  | PTD | DIS | M0)) /*d2d_n3gtdi*/\
> +	MUX_VAL(CP(D2D_N3GTDO),		(IEN  | PTD | DIS | M0)) /*d2d_n3gtdo*/\
> +	MUX_VAL(CP(D2D_N3GTMS),		(IEN  | PTD | DIS | M0)) /*d2d_n3gtms*/\
> +	MUX_VAL(CP(D2D_N3GTCK),		(IEN  | PTD | DIS | M0)) /*d2d_n3gtck*/\
> +	MUX_VAL(CP(D2D_N3GRTCK),	(IEN  | PTD | DIS | M0)) /*d2d_n3grtck*/\
> +	MUX_VAL(CP(D2D_MSTDBY),		(IEN  | PTU | EN  | M0)) /*d2d_mstdby*/\
> +	MUX_VAL(CP(D2D_SWAKEUP),	(IEN  | PTD | EN  | M0)) /*d2d_swakeup*/\
> +	MUX_VAL(CP(D2D_IDLEREQ),	(IEN  | PTD | DIS | M0)) /*d2d_idlereq*/\
> +	MUX_VAL(CP(D2D_IDLEACK),	(IEN  | PTU | EN  | M0)) /*d2d_idleack*/\
> +	MUX_VAL(CP(D2D_MWRITE),		(IEN  | PTD | DIS | M0)) /*d2d_mwrite*/\
> +	MUX_VAL(CP(D2D_SWRITE),		(IEN  | PTD | DIS | M0)) /*d2d_swrite*/\
> +	MUX_VAL(CP(D2D_MREAD),		(IEN  | PTD | DIS | M0)) /*d2d_mread*/\
> +	MUX_VAL(CP(D2D_SREAD),		(IEN  | PTD | DIS | M0)) /*d2d_sread*/\
> +	MUX_VAL(CP(D2D_MBUSFLAG),	(IEN  | PTD | DIS | M0)) /*d2d_mbusflag*/\
> +	MUX_VAL(CP(D2D_SBUSFLAG),	(IEN  | PTD | DIS | M0)) /*d2d_sbusflag*/\
> +	MUX_VAL(CP(SDRC_CKE0),		(IDIS | PTU | EN  | M0)) /*sdrc_cke0*/\
> +	MUX_VAL(CP(SDRC_CKE1),		(IDIS | PTU | EN  | M0)) /*sdrc_cke1*/
> +
> +#define MUX_BEAGLE_C() \
> +	MUX_VAL(CP(MCBSP3_DX),		(IEN  | PTD | DIS | M4)) /*GPIO_140*/\
> +	MUX_VAL(CP(MCBSP3_DR),		(IEN  | PTD | DIS | M4)) /*GPIO_142*/\
> +	MUX_VAL(CP(MCBSP3_CLKX),	(IEN  | PTD | DIS | M4)) /*GPIO_141*/\
> +	MUX_VAL(CP(UART2_CTS),		(IEN  | PTU | EN  | M0)) /*UART2_CTS*/\
> +	MUX_VAL(CP(UART2_RTS),		(IDIS | PTD | DIS | M0)) /*UART2_RTS*/\
> +	MUX_VAL(CP(UART2_TX),		(IDIS | PTD | DIS | M0)) /*UART2_TX*/\
> +	MUX_VAL(CP(UART2_RX),		(IDIS | PTU | EN  | M4)) /*GPIO_147*/
> +
> +#define MUX_BEAGLE_XM() \
> +	MUX_VAL(CP(GPMC_NCS5),		(IDIS | PTD | EN  | M4)) /*GPIO_56*/\
> +	MUX_VAL(CP(GPMC_WAIT1),		(IDIS | PTU | EN  | M4)) /*GPIO_63*/\
> +	MUX_VAL(CP(MMC1_DAT7),		(IDIS | PTU | EN  | M4)) /*GPIO_129*/\
> +	MUX_VAL(CP(HDQ_SIO),		(IDIS | PTU | EN  | M4)) /*GPIO_170*/\
> +	MUX_VAL(CP(MCBSP3_DX),		(IEN  | PTD | DIS | M4)) /*GPIO_140*/\
> +	MUX_VAL(CP(MCBSP3_DR),		(IEN  | PTD | DIS | M4)) /*GPIO_142*/\
> +	MUX_VAL(CP(MCBSP3_CLKX),	(IEN  | PTD | DIS | M4)) /*GPIO_141*/\
> +	MUX_VAL(CP(UART2_CTS),		(IEN  | PTU | EN  | M0)) /*UART2_CTS*/\
> +	MUX_VAL(CP(UART2_RTS),		(IDIS | PTD | DIS | M0)) /*UART2_RTS*/\
> +	MUX_VAL(CP(UART2_TX),		(IDIS | PTD | DIS | M0)) /*UART2_TX*/\
> +	MUX_VAL(CP(DSS_DATA0),		(IDIS | PTD | DIS | M7)) /*safe_mode*/\
> +	MUX_VAL(CP(DSS_DATA1),		(IDIS | PTD | DIS | M7)) /*safe_mode*/\
> +	MUX_VAL(CP(DSS_DATA2),		(IDIS | PTD | DIS | M7)) /*safe_mode*/\
> +	MUX_VAL(CP(DSS_DATA3),		(IDIS | PTD | DIS | M7)) /*safe_mode*/\
> +	MUX_VAL(CP(DSS_DATA4),		(IDIS | PTD | DIS | M7)) /*safe_mode*/\
> +	MUX_VAL(CP(DSS_DATA5),		(IDIS | PTD | DIS | M7)) /*safe_mode*/\
> +	MUX_VAL(CP(DSS_DATA18),		(IDIS | PTD | DIS | M3)) /*DSS_DATA0*/\
> +	MUX_VAL(CP(DSS_DATA19),		(IDIS | PTD | DIS | M3)) /*DSS_DATA1*/\
> +	MUX_VAL(CP(DSS_DATA20),		(IDIS | PTD | DIS | M3)) /*DSS_DATA2*/\
> +	MUX_VAL(CP(DSS_DATA21),		(IDIS | PTD | DIS | M3)) /*DSS_DATA3*/\
> +	MUX_VAL(CP(DSS_DATA22),		(IDIS | PTD | DIS | M3)) /*DSS_DATA4*/\
> +	MUX_VAL(CP(DSS_DATA23),		(IDIS | PTD | DIS | M3)) /*DSS_DATA5*/\
> +	MUX_VAL(CP(SYS_BOOT0),		(IDIS | PTD | DIS | M3)) /*DSS_DATA18*/\
> +	MUX_VAL(CP(SYS_BOOT1),		(IDIS | PTD | DIS | M3)) /*DSS_DATA19*/\
> +	MUX_VAL(CP(SYS_BOOT3),		(IDIS | PTD | DIS | M3)) /*DSS_DATA20*/\
> +	MUX_VAL(CP(SYS_BOOT4),		(IDIS | PTD | DIS | M3)) /*DSS_DATA21*/\
> +	MUX_VAL(CP(SYS_BOOT5),		(IDIS | PTD | DIS | M3)) /*DSS_DATA22*/\
> +	MUX_VAL(CP(SYS_BOOT6),		(IDIS | PTD | DIS | M3)) /*DSS_DATA23*/
> +
> +#define MUX_TINCANTOOLS_ZIPPY() \
> +	MUX_VAL(CP(MMC2_CLK),       (IEN  | PTU | EN  | M0)) /*MMC2_CLK*/\
> +	MUX_VAL(CP(MMC2_CMD),       (IEN  | PTU | EN  | M0)) /*MMC2_CMD*/\
> +	MUX_VAL(CP(MMC2_DAT0),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT0*/\
> +	MUX_VAL(CP(MMC2_DAT1),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT1*/\
> +	MUX_VAL(CP(MMC2_DAT2),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT2*/\
> +	MUX_VAL(CP(MMC2_DAT3),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT3*/\
> +	MUX_VAL(CP(MMC2_DAT4),      (IEN  | PTU | EN  | M1)) /*MMC2_DIR_DAT0*/\
> +	MUX_VAL(CP(MMC2_DAT5),      (IEN  | PTU | EN  | M1)) /*MMC2_DIR_DAT1*/\
> +	MUX_VAL(CP(MMC2_DAT6),      (IEN  | PTU | EN  | M1)) /*MMC2_DIR_CMD*/\
> +	MUX_VAL(CP(MMC2_DAT7),      (IEN  | PTU | EN  | M1)) /*MMC2_CLKIN*/\
> +	MUX_VAL(CP(MCBSP1_CLKR),    (IEN  | PTU | EN  | M1)) /*MCSPI4_CLK*/\
> +	MUX_VAL(CP(MCBSP1_FSR),     (IEN  | PTU | EN  | M4)) /*GPIO_157*/\
> +	MUX_VAL(CP(MCBSP1_DX),      (IEN  | PTD | EN  | M1)) /*MCSPI4_SIMO*/\
> +	MUX_VAL(CP(MCBSP1_DR),      (IEN  | PTD | DIS | M1)) /*MCSPI4_SOMI*/\
> +	MUX_VAL(CP(MCBSP1_FSX),     (IEN  | PTD | EN  | M1)) /*MCSPI4_CS0*/\
> +	MUX_VAL(CP(MCBSP1_CLKX),    (IEN  | PTD | DIS | M4)) /*GPIO_162*/\
> +	MUX_VAL(CP(MCBSP3_DX),      (IEN  | PTD | DIS | M4)) /*GPIO_140*/\
> +	MUX_VAL(CP(MCBSP3_DR),      (IEN  | PTD | DIS | M4)) /*GPIO_142*/\
> +	MUX_VAL(CP(MCBSP3_CLKX),    (IEN  | PTD | DIS | M4)) /*GPIO_141*/
> +
> +#define MUX_TINCANTOOLS_TRAINER() \
> +	MUX_VAL(CP(MMC2_CLK),       (IEN  | PTU | EN  | M4)) /*GPIO_130*/\
> +	MUX_VAL(CP(MMC2_CMD),       (IEN  | PTU | EN  | M4)) /*GPIO_131*/\
> +	MUX_VAL(CP(MMC2_DAT0),      (IEN  | PTU | EN  | M4)) /*GPIO_132*/\
> +	MUX_VAL(CP(MMC2_DAT1),      (IEN  | PTU | EN  | M4)) /*GPIO_133*/\
> +	MUX_VAL(CP(MMC2_DAT2),      (IEN  | PTU | EN  | M4)) /*GPIO_134*/\
> +	MUX_VAL(CP(MMC2_DAT3),      (IEN  | PTU | EN  | M4)) /*GPIO_135*/\
> +	MUX_VAL(CP(MMC2_DAT4),      (IEN  | PTU | EN  | M4)) /*GPIO_136*/\
> +	MUX_VAL(CP(MMC2_DAT5),      (IEN  | PTU | EN  | M4)) /*GPIO_137*/\
> +	MUX_VAL(CP(MMC2_DAT6),      (IEN  | PTU | EN  | M4)) /*GPIO_138*/\
> +	MUX_VAL(CP(MMC2_DAT7),      (IEN  | PTU | EN  | M4)) /*GPIO_139*/\
> +	MUX_VAL(CP(MCBSP3_DX),      (IEN  | PTU | EN  | M4)) /*GPIO_140*/\
> +	MUX_VAL(CP(MCBSP3_CLKX),    (IEN  | PTU | EN  | M4)) /*GPIO_141*/\
> +	MUX_VAL(CP(MCBSP1_CLKX),    (IEN  | PTU | EN  | M4)) /*GPIO_162*/
> +
> +#define MUX_KBADC_BEAGLEFPGA() \
> +	MUX_VAL(CP(MCBSP1_CLKR),    (IEN  | PTU | DIS | M1)) /*MCSPI4_CLK*/\
> +	MUX_VAL(CP(MCBSP1_DX),      (IDIS | PTU | DIS | M1)) /*MCSPI4_SIMO*/\
> +	MUX_VAL(CP(MCBSP1_DR),      (IEN  | PTU | EN  | M1)) /*MCSPI4_SOMI*/\
> +	MUX_VAL(CP(MCBSP1_FSX),     (IDIS | PTU | DIS | M1)) /*MCSPI4_CS0*/
> +
> +#define MUX_BBTOYS_WIFI() \
> +	MUX_VAL(CP(MMC2_CLK),       (IEN  | PTU | EN  | M0)) /*MMC2_CLK*/\
> +	MUX_VAL(CP(MMC2_CMD),       (IEN  | PTU | EN  | M0)) /*MMC2_CMD*/\
> +	MUX_VAL(CP(MMC2_DAT0),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT0*/\
> +	MUX_VAL(CP(MMC2_DAT1),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT1*/\
> +	MUX_VAL(CP(MMC2_DAT2),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT2*/\
> +	MUX_VAL(CP(MMC2_DAT3),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT3*/\
> +	MUX_VAL(CP(MMC2_DAT4),      (IDIS | PTU | EN  | M4)) /*GPIO_136 FM_EN/BT_WU*/\
> +	MUX_VAL(CP(MMC2_DAT5),      (IEN  | PTU | EN  | M4)) /*GPIO_137 WLAN_IRQ*/\
> +	MUX_VAL(CP(MMC2_DAT6),      (IDIS | PTU | EN  | M4)) /*GPIO_138 BT_EN*/\
> +	MUX_VAL(CP(MMC2_DAT7),      (IDIS | PTU | EN  | M4)) /*GPIO_139 WLAN_EN*/
> +
> +/*
> + * Display Configuration
> + */
> +
> +#define DVI_BEAGLE_ORANGE_COL		0x00FF8000
> +#define VENC_HEIGHT			0x00ef
> +#define VENC_WIDTH			0x027f
> +
> +/*
> + * Configure VENC in DSS for Beagle to generate Color Bar
> + *
> + * Kindly refer to OMAP TRM for definition of these values.
> + */
> +static const struct venc_regs venc_config_std_tv = {
> +	.status					= 0x0000001B,
> +	.f_control				= 0x00000040,
> +	.vidout_ctrl				= 0x00000000,
> +	.sync_ctrl				= 0x00008000,
> +	.llen					= 0x00008359,
> +	.flens					= 0x0000020C,
> +	.hfltr_ctrl				= 0x00000000,
> +	.cc_carr_wss_carr			= 0x043F2631,
> +	.c_phase				= 0x00000024,
> +	.gain_u					= 0x00000130,
> +	.gain_v					= 0x00000198,
> +	.gain_y					= 0x000001C0,
> +	.black_level				= 0x0000006A,
> +	.blank_level				= 0x0000005C,
> +	.x_color				= 0x00000000,
> +	.m_control				= 0x00000001,
> +	.bstamp_wss_data			= 0x0000003F,
> +	.s_carr					= 0x21F07C1F,
> +	.line21					= 0x00000000,
> +	.ln_sel					= 0x00000015,
> +	.l21__wc_ctl				= 0x00001400,
> +	.htrigger_vtrigger			= 0x00000000,
> +	.savid__eavid				= 0x069300F4,
> +	.flen__fal				= 0x0016020C,
> +	.lal__phase_reset			= 0x00060107,
> +	.hs_int_start_stop_x			= 0x008D034E,
> +	.hs_ext_start_stop_x			= 0x000F0359,
> +	.vs_int_start_x				= 0x01A00000,
> +	.vs_int_stop_x__vs_int_start_y		= 0x020501A0,
> +	.vs_int_stop_y__vs_ext_start_x		= 0x01AC0024,
> +	.vs_ext_stop_x__vs_ext_start_y		= 0x020D01AC,
> +	.vs_ext_stop_y				= 0x00000006,
> +	.avid_start_stop_x			= 0x03480079,
> +	.avid_start_stop_y			= 0x02040024,
> +	.fid_int_start_x__fid_int_start_y	= 0x0001008A,
> +	.fid_int_offset_y__fid_ext_start_x	= 0x01AC0106,
> +	.fid_ext_start_y__fid_ext_offset_y	= 0x01060006,
> +	.tvdetgp_int_start_stop_x		= 0x00140001,
> +	.tvdetgp_int_start_stop_y		= 0x00010001,
> +	.gen_ctrl				= 0x00FF0000,
> +	.output_control				= 0x0000000D,
> +	.dac_b__dac_c				= 0x00000000
> +};
> +
> +/*
> + * Configure Timings for DVI D
> + */
> +static const struct panel_config dvid_cfg = {
> +	.timing_h	= 0x0ff03f31, /* Horizontal timing */
> +	.timing_v	= 0x01400504, /* Vertical timing */
> +	.pol_freq	= 0x00007028, /* Pol Freq */
> +	.divisor	= 0x00010006, /* 72Mhz Pixel Clock */
> +	.lcd_size	= 0x02ff03ff, /* 1024x768 */
> +	.panel_type	= 0x01, /* TFT */
> +	.data_lines	= 0x03, /* 24 Bit RGB */
> +	.load_mode	= 0x02, /* Frame Mode */
> +	.panel_color	= DVI_BEAGLE_ORANGE_COL, /* ORANGE */
> +	.gfx_format	= GFXFORMAT_RGB24_UNPACKED,
> +};
> +
> +static const struct panel_config dvid_cfg_xm = {
> +	.timing_h	= 0x1a4024c9, /* Horizontal timing */
> +	.timing_v	= 0x02c00509, /* Vertical timing */
> +	.pol_freq	= 0x00007028, /* Pol Freq */
> +	.divisor	= 0x00010001, /* 96MHz Pixel Clock */
> +	.lcd_size	= 0x02ff03ff, /* 1024x768 */
> +	.panel_type	= 0x01, /* TFT */
> +	.data_lines	= 0x03, /* 24 Bit RGB */
> +	.load_mode	= 0x02, /* Frame Mode */
> +	.panel_color	= DVI_BEAGLE_ORANGE_COL, /* ORANGE */
> +	.gfx_format	= GFXFORMAT_RGB24_UNPACKED,
> +};
> +#endif
> diff --git a/board/beagle/beagle/led.c b/board/beagle/beagle/led.c
> new file mode 100644
> index 00000000000..9daec4f48dc
> --- /dev/null
> +++ b/board/beagle/beagle/led.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2010 Texas Instruments, Inc.
> + * Jason Kridner <jkridner@beagleboard.org>
> + */
> +#include <status_led.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/io.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/gpio.h>
> +
> +/* GPIO pins for the LEDs */
> +#define BEAGLE_LED_USR0	150
> +#define BEAGLE_LED_USR1	149
> +
> +#if (IS_ENABLED(CONFIG_LED_STATUS_GREEN))
> +void green_led_off(void)
> +{
> +	__led_set(CONFIG_LED_STATUS_GREEN, 0);
> +}
> +
> +void green_led_on(void)
> +{
> +	__led_set(CONFIG_LED_STATUS_GREEN, 1);
> +}
> +#endif
> +
> +static int get_led_gpio(led_id_t mask)
> +{
> +#if (IS_ENABLED(CONFIG_LED_STATUS0))
> +	if (CONFIG_LED_STATUS_BIT & mask)
> +		return BEAGLE_LED_USR0;
> +#endif
> +#if (IS_ENABLED(CONFIG_LED_STATUS1))
> +	if (CONFIG_LED_STATUS_BIT1 & mask)
> +		return BEAGLE_LED_USR1;
> +#endif
> +
> +	return 0;
> +}
> +
> +void __led_init(led_id_t mask, int state)
> +{
> +	int toggle_gpio;
> +
> +	toggle_gpio = get_led_gpio(mask);
> +
> +	if (toggle_gpio && !gpio_request(toggle_gpio, "led"))
> +		__led_set(mask, state);
> +}
> +
> +void __led_toggle(led_id_t mask)
> +{
> +	int state, toggle_gpio;
> +
> +	toggle_gpio = get_led_gpio(mask);
> +	if (toggle_gpio) {
> +		state = gpio_get_value(toggle_gpio);
> +		gpio_direction_output(toggle_gpio, !state);
> +	}
> +}
> +
> +void __led_set(led_id_t mask, int state)
> +{
> +	int toggle_gpio;
> +
> +	toggle_gpio = get_led_gpio(mask);
> +	if (toggle_gpio)
> +		gpio_direction_output(toggle_gpio, state);
> +}
> diff --git a/board/isee/igep00x0/spl.c b/board/isee/igep00x0/spl.c
> index f814fe13542..18e15215c36 100644
> --- a/board/isee/igep00x0/spl.c
> +++ b/board/isee/igep00x0/spl.c
> @@ -34,19 +34,19 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
>  			/* Should not happen... */
>  			break;
>  		}
> -		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHz;
> +		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHZ;
>  		gpmc_cs0_flash = MTD_DEV_TYPE_NAND;
>  	} else {
>  		if (get_cpu_family() == CPU_OMAP34XX) {
>  			timings->mcfg = NUMONYX_V_MCFG_165(256 << 20);
>  			timings->ctrla = NUMONYX_V_ACTIMA_165;
>  			timings->ctrlb = NUMONYX_V_ACTIMB_165;
> -			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHz;
> +			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
>  		} else {
>  			timings->mcfg = NUMONYX_V_MCFG_200(256 << 20);
>  			timings->ctrla = NUMONYX_V_ACTIMA_200;
>  			timings->ctrlb = NUMONYX_V_ACTIMB_200;
> -			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHz;
> +			timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHZ;
>  		}
>  		gpmc_cs0_flash = MTD_DEV_TYPE_ONENAND;
>  	}
> diff --git a/board/lg/sniper/sniper.c b/board/lg/sniper/sniper.c
> index d4db32ee69b..8a04baf0094 100644
> --- a/board/lg/sniper/sniper.c
> +++ b/board/lg/sniper/sniper.c
> @@ -60,7 +60,7 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
>  	timings->mcfg = HYNIX_V_MCFG_200(256 << 20);
>  	timings->ctrla = HYNIX_V_ACTIMA_200;
>  	timings->ctrlb = HYNIX_V_ACTIMB_200;
> -	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHz;
> +	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHZ;
>  	timings->mr = MICRON_V_MR_165;
>  }
>  
> diff --git a/board/logicpd/omap3som/omap3logic.c b/board/logicpd/omap3som/omap3logic.c
> index 352b519b451..80bdfeab359 100644
> --- a/board/logicpd/omap3som/omap3logic.c
> +++ b/board/logicpd/omap3som/omap3logic.c
> @@ -86,13 +86,13 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
>  		timings->mcfg = MICRON_V_MCFG_200(256 << 20);
>  		timings->ctrla = MICRON_V_ACTIMA_200;
>  		timings->ctrlb = MICRON_V_ACTIMB_200;
> -		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHz;
> +		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHZ;
>  	} else {
>  		/* 165 MHz works for OMAP35 */
>  		timings->mcfg = MICRON_V_MCFG_165(256 << 20);
>  		timings->ctrla = MICRON_V_ACTIMA_165;
>  		timings->ctrlb = MICRON_V_ACTIMB_165;
> -		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHz;
> +		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
>  	}
>  }
>  
> diff --git a/board/ti/omap3evm/evm.c b/board/ti/omap3evm/evm.c
> index 8803643b032..252a2909d64 100644
> --- a/board/ti/omap3evm/evm.c
> +++ b/board/ti/omap3evm/evm.c
> @@ -147,7 +147,7 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
>  		timings->ctrla = MICRON_V_ACTIMA_165;
>  		timings->ctrlb = MICRON_V_ACTIMB_165;
>  	}
> -	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHz;
> +	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
>  	timings->mr = MICRON_V_MR_165;
>  }
>  #endif /* CONFIG_XPL_BUILD */
> diff --git a/board/timll/devkit8000/devkit8000.c b/board/timll/devkit8000/devkit8000.c
> index a2a3a9489aa..07aedc46cec 100644
> --- a/board/timll/devkit8000/devkit8000.c
> +++ b/board/timll/devkit8000/devkit8000.c
> @@ -198,7 +198,7 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
>  {
>  	/* General SDRC config */
>  	timings->mcfg = MICRON_V_MCFG_165(128 << 20);
> -	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHz;
> +	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHZ;
>  
>  	/* AC timings */
>  	timings->ctrla = MICRON_V_ACTIMA_165;
> diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_defconfig
> new file mode 100644
> index 00000000000..a6cf155426d
> --- /dev/null
> +++ b/configs/omap3_beagle_defconfig
> @@ -0,0 +1,124 @@
> +CONFIG_ARM=y
> +# CONFIG_SPL_USE_ARCH_MEMCPY is not set
> +# CONFIG_SPL_USE_ARCH_MEMSET is not set
> +CONFIG_ARCH_OMAP2PLUS=y
> +CONFIG_SYS_MALLOC_F_LEN=0x4000
> +CONFIG_EEPROM_BUS_ADDRESS=1
> +CONFIG_TI_COMMON_CMD_OPTIONS=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-beagle"
> +CONFIG_TARGET_OMAP3_BEAGLE=y
> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
> +CONFIG_SPL=y
> +CONFIG_ENV_VARS_UBOOT_CONFIG=y
> +# CONFIG_EFI_LOADER is not set
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +# CONFIG_BOOTSTD is not set
> +CONFIG_SUPPORT_RAW_INITRD=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_DEFAULT_FDT_FILE="omap3-beagle.dtb"
> +CONFIG_SYS_PBSIZE=1055
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +CONFIG_ANDROID_AB=y
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_FS_EXT4 is not set
> +CONFIG_SPL_MTD=y
> +CONFIG_SPL_NAND_DRIVERS=y
> +CONFIG_SPL_NAND_ECC=y
> +CONFIG_SPL_NAND_SIMPLE=y
> +CONFIG_SPL_NAND_BASE=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_PROMPT="BeagleBoard # "
> +CONFIG_CMD_CONFIG=y
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_XIMG is not set
> +# CONFIG_CMD_DFU is not set
> +# CONFIG_CMD_GPT is not set
> +# CONFIG_CMD_MMC_REG is not set
> +# CONFIG_MMC_SPEED_MODE_SET is not set
> +CONFIG_CMD_NAND=y
> +CONFIG_CMD_NAND_TRIMFFS=y
> +# CONFIG_CMD_NFS is not set
> +CONFIG_CMD_CACHE=y
> +# CONFIG_CMD_TIME is not set
> +CONFIG_CMD_SYSBOOT=y
> +# CONFIG_CMD_PMIC is not set
> +# CONFIG_CMD_REGULATOR is not set
> +CONFIG_CMD_SQUASHFS=y
> +CONFIG_CMD_FS_UUID=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
> +CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(spl),1920k(u-boot),128k(u-boot-env),128k(dtb),6m(kernel),-(rootfs)"
> +CONFIG_CMD_UBI=y
> +CONFIG_EFI_PARTITION=y
> +# CONFIG_SPL_EFI_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
> +CONFIG_ENV_OVERWRITE=y
> +# CONFIG_ENV_IS_IN_FAT is not set
> +CONFIG_ENV_IS_IN_NAND=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_VERSION_VARIABLE=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x82000000
> +CONFIG_LED_STATUS=y
> +CONFIG_LED_STATUS0=y
> +CONFIG_LED_STATUS_BIT=1
> +CONFIG_LED_STATUS_STATE=2
> +CONFIG_LED_STATUS1=y
> +CONFIG_LED_STATUS_BIT1=2
> +CONFIG_LED_STATUS_STATE1=2
> +CONFIG_LED_STATUS_BOOT_ENABLE=y
> +CONFIG_LED_STATUS_BOOT=1
> +CONFIG_LED_STATUS_GREEN_ENABLE=y
> +CONFIG_LED_STATUS_GREEN=2
> +CONFIG_LED_STATUS_CMD=y
> +CONFIG_TWL4030_LED=y
> +CONFIG_MMC_OMAP_HS=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_NAND_OMAP_ECCSCHEME_HAM1_CODE_HW=y
> +CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
> +CONFIG_SYS_NAND_PAGE_SIZE=0x800
> +CONFIG_SYS_NAND_OOBSIZE=0x40
> +CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
> +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> +CONFIG_SYS_NAND_U_BOOT_OFFS=0x80000
> +CONFIG_DM_PMIC=y
> +# CONFIG_SPL_DM_PMIC is not set
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_OMAP3_SPI=y
> +CONFIG_USB=y
> +# CONFIG_SPL_DM_USB is not set
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OMAP3=y
> +CONFIG_USB_MUSB_GADGET=y
> +CONFIG_USB_MUSB_OMAP2PLUS=y
> +CONFIG_TWL4030_USB=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_SMSC95XX=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="TI"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> +CONFIG_USB_ETHER=y
> +CONFIG_BCH=y
> +CONFIG_SPL_CRC8=y
> diff --git a/configs/omap3_beagle_xm_defconfig b/configs/omap3_beagle_xm_defconfig
> new file mode 100644
> index 00000000000..42e01d86361
> --- /dev/null
> +++ b/configs/omap3_beagle_xm_defconfig
> @@ -0,0 +1,109 @@
> +CONFIG_ARM=y
> +# CONFIG_SPL_USE_ARCH_MEMCPY is not set
> +# CONFIG_SPL_USE_ARCH_MEMSET is not set
> +CONFIG_ARCH_OMAP2PLUS=y
> +CONFIG_SYS_MALLOC_F_LEN=0x4000
> +CONFIG_EEPROM_BUS_ADDRESS=1
> +CONFIG_TI_COMMON_CMD_OPTIONS=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-beagle-xm"
> +CONFIG_TARGET_OMAP3_BEAGLE=y
> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
> +CONFIG_SPL=y
> +CONFIG_ENV_VARS_UBOOT_CONFIG=y
> +# CONFIG_EFI_LOADER is not set
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +# CONFIG_BOOTSTD is not set
> +CONFIG_SUPPORT_RAW_INITRD=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_DEFAULT_FDT_FILE="omap3-beagle-xm.dtb"
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +CONFIG_ANDROID_AB=y
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_FS_EXT4 is not set
> +CONFIG_SPL_MTD=y
> +# CONFIG_SPL_NAND_SUPPORT is not set
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_PROMPT="BeagleBoard-xM # "
> +CONFIG_CMD_CONFIG=y
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_XIMG is not set
> +# CONFIG_CMD_DFU is not set
> +# CONFIG_CMD_GPT is not set
> +# CONFIG_CMD_MMC_REG is not set
> +# CONFIG_MMC_SPEED_MODE_SET is not set
> +# CONFIG_CMD_NFS is not set
> +CONFIG_CMD_CACHE=y
> +# CONFIG_CMD_TIME is not set
> +CONFIG_CMD_SYSBOOT=y
> +# CONFIG_CMD_PMIC is not set
> +# CONFIG_CMD_REGULATOR is not set
> +CONFIG_CMD_SQUASHFS=y
> +CONFIG_CMD_FS_UUID=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
> +CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(spl),1920k(u-boot),128k(u-boot-env),128k(dtb),6m(kernel),-(rootfs)"
> +CONFIG_CMD_UBI=y
> +CONFIG_EFI_PARTITION=y
> +# CONFIG_SPL_EFI_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_PART=1
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_VERSION_VARIABLE=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x82000000
> +CONFIG_LED_STATUS=y
> +CONFIG_LED_STATUS0=y
> +CONFIG_LED_STATUS_BIT=1
> +CONFIG_LED_STATUS_STATE=2
> +CONFIG_LED_STATUS1=y
> +CONFIG_LED_STATUS_BIT1=2
> +CONFIG_LED_STATUS_STATE1=2
> +CONFIG_LED_STATUS_BOOT_ENABLE=y
> +CONFIG_LED_STATUS_BOOT=1
> +CONFIG_LED_STATUS_GREEN_ENABLE=y
> +CONFIG_LED_STATUS_GREEN=2
> +CONFIG_LED_STATUS_CMD=y
> +CONFIG_TWL4030_LED=y
> +CONFIG_MMC_OMAP_HS=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_DM_PMIC=y
> +# CONFIG_SPL_DM_PMIC is not set
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_OMAP3_SPI=y
> +CONFIG_USB=y
> +# CONFIG_SPL_DM_USB is not set
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OMAP3=y
> +CONFIG_USB_MUSB_GADGET=y
> +CONFIG_USB_MUSB_OMAP2PLUS=y
> +CONFIG_TWL4030_USB=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_SMSC95XX=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="TI"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> +CONFIG_USB_ETHER=y
> +CONFIG_BCH=y
> +CONFIG_SPL_CRC8=y
> diff --git a/include/configs/omap3_beagle.h b/include/configs/omap3_beagle.h
> new file mode 100644
> index 00000000000..d3737ce97dd
> --- /dev/null
> +++ b/include/configs/omap3_beagle.h
> @@ -0,0 +1,201 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2006-2008
> + * Texas Instruments.
> + * Richard Woodruff <r-woodruff2@ti.com>
> + * Syed Mohammed Khasim <x0khasim@ti.com>
> + *
> + * Configuration settings for the TI OMAP3530 Beagle board.
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <configs/ti_omap3_common.h>
> +
> +/*
> + * We are only ever GP parts and will utilize all of the "downloaded image"
> + * area in SRAM which starts at 0x40200000 and ends at 0x4020FFFF (64KB).
> + */
> +
> +/* NAND */
> +#if defined(CONFIG_MTD_RAW_NAND)
> +#define CFG_SYS_FLASH_BASE	NAND_BASE
> +#define CFG_SYS_NAND_ECCPOS	{ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }
> +#define CFG_SYS_NAND_ECCSIZE	512
> +#define CFG_SYS_NAND_ECCBYTES	3
> +/* NAND: SPL falcon mode configs */
> +#endif /* CONFIG_MTD_RAW_NAND */
> +
> +/* DSS Support */
> +
> +/* TWL4030 LED Support */
> +
> +#define MEM_LAYOUT_ENV_SETTINGS \
> +	DEFAULT_LINUX_BOOT_ENV
> +
> +#define BOOTENV_DEV_LEGACY_MMC(devtypeu, devtypel, instance) \
> +	"bootcmd_" #devtypel #instance "=" \
> +	"setenv mmcdev " #instance "; " \
> +	"run mmcboot\0"
> +#define BOOTENV_DEV_NAME_LEGACY_MMC(devtypeu, devtypel, instance) \
> +	#devtypel #instance " "
> +
> +#define BOOT_TARGET_DEVICES_MMC(func)		func(MMC, mmc, 0)
> +#define BOOT_TARGET_DEVICES_MMC_LEGACY(func)	func(LEGACY_MMC, legacy_mmc, 0)
> +
> +#if defined(CONFIG_MTD_RAW_NAND)
> +
> +#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
> +	"bootcmd_" #devtypel #instance "=" \
> +	"if test ${mtdids} = '' || test ${mtdparts} = '' ; then " \
> +		"echo NAND boot disabled: No mtdids and/or mtdparts; " \
> +	"else " \
> +		"run nandboot; " \
> +	"fi\0"
> +#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
> +	#devtypel #instance " "
> +
> +#define BOOT_TARGET_DEVICES_UBIFS(func)	func(UBIFS, ubifs, 0, rootfs, rootfs)
> +#define BOOT_TARGET_DEVICES_NAND(func)	func(NAND, nand, 0)
> +
> +#define BOOT_TARGET_DEVICES(func)		\
> +	BOOT_TARGET_DEVICES_MMC(func)		\
> +	BOOT_TARGET_DEVICES_MMC_LEGACY(func)	\
> +	BOOT_TARGET_DEVICES_UBIFS(func)		\
> +	BOOT_TARGET_DEVICES_NAND(func)
> +
> +#else /* !CONFIG_MTD_RAW_NAND */
> +
> +#define BOOT_TARGET_DEVICES(func)		\
> +	BOOT_TARGET_DEVICES_MMC(func)		\
> +	BOOT_TARGET_DEVICES_MMC_LEGACY(func)
> +
> +#endif /* CONFIG_MTD_RAW_NAND */
> +
> +#include <config_distro_bootcmd.h>
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	MEM_LAYOUT_ENV_SETTINGS \
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +	"console=ttyO2,115200n8\0" \
> +	"bootdir=/boot\0" \
> +	"bootenv=uEnv.txt\0" \
> +	"bootfile=zImage\0" \
> +	"bootpart=0:2\0" \
> +	"usbtty=cdc_acm\0" \
> +	"mpurate=auto\0" \
> +	"buddy=none\0" \
> +	"camera=none\0" \
> +	"vram=12M\0" \
> +	"dvimode=640x480MR-16@60\0" \
> +	"defaultdisplay=dvi\0" \
> +	"defaultargs=setenv defargs " \
> +		"mpurate=${mpurate} " \
> +		"buddy=${buddy} "\
> +		"camera=${camera} "\
> +		"vram=${vram} " \
> +		"omapfb.mode=dvi:${dvimode} " \
> +		"omapdss.def_disp=${defaultdisplay}\0" \
> +	"optargs=\0" \
> +	"findfdt=" \
> +		"if test $beaglerev = AxBx; then " \
> +			"setenv fdtfile omap3-beagle.dtb; fi; " \
> +		"if test $beaglerev = Cx; then " \
> +			"setenv fdtfile omap3-beagle.dtb; fi; " \
> +		"if test $beaglerev = C4; then " \
> +			"setenv fdtfile omap3-beagle.dtb; fi; " \
> +		"if test $beaglerev = xMAB; then " \
> +			"setenv fdtfile omap3-beagle-xm-ab.dtb; fi; " \
> +		"if test $beaglerev = xMC; then " \
> +			"setenv fdtfile omap3-beagle-xm.dtb; fi; " \
> +		"if test $fdtfile = undefined; then " \
> +			"echo WARNING: Could not determine device tree to use; fi\0" \
> +	"mmcdev=0\0" \
> +	"mmcpart=2\0" \
> +	"mmcroot=/dev/mmcblk0p2 rw\0" \
> +	"mmcrootfstype=ext4 rootwait\0" \
> +	"mmcargs=run defaultargs; setenv bootargs console=${console} " \
> +		"${mtdparts} " \
> +		"${defargs} " \
> +		"${optargs} " \
> +		"root=${mmcroot} " \
> +		"rootfstype=${mmcrootfstype}\0" \
> +	"userbutton_xm=gpio input 4;\0" \
> +	"userbutton_nonxm=gpio input 7;\0" \
> +	"userbutton=if gpio input 173; then " \
> +			"run userbutton_xm; " \
> +		"else " \
> +			"run userbutton_nonxm; " \
> +		"fi;\0" \
> +	"loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenv}\0" \
> +	"ext4bootenv=ext4load mmc ${bootpart} ${loadaddr} ${bootdir}/${bootenv}\0" \
> +	"importbootenv=echo Importing environment from mmc${mmcdev} ...; " \
> +		"env import -t ${loadaddr} ${filesize}\0" \
> +	"mmcbootenv=setenv bootpart ${mmcdev}:${mmcpart}; " \
> +		"mmc dev ${mmcdev}; " \
> +		"if mmc rescan; then " \
> +			"if run userbutton; then " \
> +				"setenv bootenv uEnv.txt;" \
> +			"else " \
> +				"setenv bootenv user.txt;" \
> +			"fi;" \
> +			"run loadbootenv && run importbootenv; " \
> +			"run ext4bootenv && run importbootenv; " \
> +			"if test -n $uenvcmd; then " \
> +				"echo Running uenvcmd ...; " \
> +				"run uenvcmd; " \
> +			"fi; " \
> +		"fi\0" \
> +	"validatefdt=" \
> +		"if test $beaglerev = xMAB; then " \
> +			"if test ! -e mmc ${bootpart} ${bootdir}/${fdtfile}; then " \
> +				"setenv fdtfile omap3-beagle-xm.dtb; " \
> +			"fi; " \
> +		"fi; \0" \
> +	"loadimage=ext4load mmc ${bootpart} ${loadaddr} ${bootdir}/${bootfile}\0" \
> +	"loaddtb=run validatefdt; ext4load mmc ${bootpart} ${fdtaddr} ${bootdir}/${fdtfile}\0" \
> +	"mmcboot=run mmcbootenv; " \
> +		"if run loadimage && run loaddtb; then " \
> +			"echo Booting ${bootdir}/${bootfile} from mmc ${bootpart} ...; " \
> +			"run mmcargs; " \
> +			"if test ${bootfile} = uImage; then " \
> +				"bootm ${loadaddr} - ${fdtaddr}; " \
> +			"fi; " \
> +			"if test ${bootfile} = zImage; then " \
> +				"bootz ${loadaddr} - ${fdtaddr}; " \
> +			"fi; " \
> +		"fi\0" \
> +	"nandroot=ubi0:rootfs ubi.mtd=rootfs rw\0" \
> +	"nandrootfstype=ubifs rootwait\0" \
> +	"nandargs=run defaultargs; setenv bootargs console=${console} " \
> +		"${mtdparts} " \
> +		"${defargs} " \
> +		"${optargs} " \
> +		"root=${nandroot} " \
> +		"rootfstype=${nandrootfstype}\0" \
> +	"nandboot=if nand read ${loadaddr} kernel && nand read ${fdtaddr} dtb; then " \
> +			"echo Booting uImage from NAND MTD 'kernel' partition ...; " \
> +			"run nandargs; " \
> +			"bootm ${loadaddr} - ${fdtaddr}; " \
> +		"fi\0" \
> +	"loadramdisk=ext4load mmc ${bootpart} ${rdaddr} ${bootdir}/${ramdisk}\0" \
> +	"ramdisk=rootfs.ext2.gz.uboot\0" \
> +	"ramdisk_size=16384\0" \
> +	"ramroot=/dev/ram rw\0" \
> +	"ramrootfstype=ext2\0" \
> +	"ramargs=run defaultargs; setenv bootargs console=${console} " \
> +		"${mtdparts} " \
> +		"${defargs} " \
> +		"${optargs} " \
> +		"root=${ramroot} ramdisk_size=${ramdisk_size} " \
> +		"rootfstype=${ramrootfstype}\0" \
> +	"ramboot=run mmcbootenv; " \
> +		"if run loadimage && run loaddtb && run loadramdisk; then " \
> +			"echo Booting ${bootdir}/${bootfile} from mmc ${bootpart} w/ramdisk ...; " \
> +			"run ramargs; " \
> +			"bootz ${loadaddr} ${rdaddr} ${fdtaddr}; " \
> +		"fi\0" \
> +	BOOTENV
> +
> +#endif /* __CONFIG_H */
> -- 
> 2.43.0
> 
> 


For BeagleBoard Rev. C [ SD/MMC boot ]

Tested-by: Derald D. Woods <woods.technical@gmail.com>

----------------------------------------------------------------
U-Boot SPL 2025.07-rc2-28-g17e0fd0e469-00028-g17e0fd0e4697 (May 20 2025 - 22:46:53 -0400)
Trying to boot from MMC1


U-Boot 2025.07-rc2-28-g17e0fd0e469-00028-g17e0fd0e4697 (May 20 2025 - 22:46:53 -0400)

OMAP3530-GP ES3.1, CPU-OPP2, L3-165MHz, Max CPU Clock 720 MHz
Model: TI OMAP3 BeagleBoard
OMAP3 Beagle board + LPDDR/NAND
DRAM:  256 MiB
Core:  50 devices, 16 uclasses, devicetree: separate
NAND:  256 MiB
MMC:   OMAP SD/MMC: 0
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1... 
Beagle Rev C4
Timed out in wait_for_event: status=0000
Check if pads/pull-ups of bus are properly configured
Unrecognized expansion board: 0
OMAP die ID: 1ffc0004000000000403a38103018017
Net:   No ethernet found.
Hit any key to stop autoboot:  0 
BeagleBoard # 
----------------------------------------------------------------

- Derald
