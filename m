Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623A1C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 17:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898CA806D8;
	Thu, 27 Mar 2025 18:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vJhvusI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFBE806FC; Thu, 27 Mar 2025 18:10:12 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81F9805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 18:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so14272965e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743095409; x=1743700209; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4oRv5gEjql/SJlFtNREyBIA/Iv6ozTS/VTB2IsUFz9I=;
 b=vJhvusI+hdyqLiiVJ4prV4hoQMJ3+0GDGU3Idy2EpKhJSq89YKvkVE/DvczP5QoN12
 lZZxuyFFKnGA5oF9uOx2ajuyDrT1Uk1eh0Ufm8v5GOJBqlg8XikNeJ1GFENHNPgQPF7/
 Aj8zf6HLXNlpPsv5Shj8xEjBQKZnonqnXltivTfZPivAG0BgnvgzxV6iWVigJrK86w3M
 pv28Pob9rOl4DWZzhM+wpaqlYscV4dOuZTLtrHWTl1j5pf6/Qim3J6WLTx07nfPcfKWM
 /lnUKW/OFX6wHxIAKXCsf/4zUkylAxYEJevjKAMivf8IE2sWdFoXixFUtQ9sXNiimLLQ
 ajxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743095409; x=1743700209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4oRv5gEjql/SJlFtNREyBIA/Iv6ozTS/VTB2IsUFz9I=;
 b=dfqF7Eq5GSedyFXFIhrN0U+ph2n7xPmRt2v+Gr3bc9psXf2yt83jhgVOtJ0wlg82Qs
 lGegBnUYOSZnpFPswBpm35tNInxnhoviOgYbL13ObBvLUSwevyxG+3cgP6TXl6B+C+Bk
 SmwCoeTmi3OfAXiReyNwyzwRCrV5FtV4B8TvJOubmJqdfqL9hd2ausjKgoffuxqTEZf4
 6KrhqXMghdgORumq8BtMfpoO6uoeFA8M6oH6b/dWbujKug4L2E8xhT1Oyqqa/5LdF8g1
 3+j8Kh1XSRP7pUVKKtAGH9zIcAxnwyHMgK2vyqwJx0LKDSh8dN/UsYodxvK37YAg7nkp
 GCTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaHbKHtbjUwvvjXAon9TRdgmB1CbT/YHkElZzyLr2ZXd+Dm+ymJVFTZq0chcBgiETnSPkJkXo=@lists.denx.de
X-Gm-Message-State: AOJu0YyPutNDbnD1+Y+eHmfRmQ4CU5An5fsOKGYDHXVTk1aAO5gBMUVY
 e70tr7ldWodYUiD4mTgFBtrJIPUAdDV67sGgDIEUIAf/aILq065JYmSCQGUuojg=
X-Gm-Gg: ASbGncsZ495/mVDGcvqKcN8xHjNJ6ImUH56fGqfKMNlJEe4uVD9mPs5HLhfVSnhUvkj
 bUU1GhP26BRkrluSZ0LLtmECUOqQ25A2zzSRcjNQNUV63ycA/9wd8UhWCBdXLVFR9vK1vQl5cVs
 jpfOj902WfcWjnNEOeqssGMvluyksEugRU0PZQD9UM0p137D432iLzw9OkQUDZgCst8Iih+9PCQ
 BZG95JATyogJHoV2fxiXax8+cJkjqIqtfIgqcE4aIKMd+RJwToPi65oKSfdfisUwVNToA/hnBaY
 nL6cvqIdmk/JFtzaa6IV2ph3KZQnC5gdHRGc2JiNdpPMPDcVwchAQBrZJZgItAJZuoTbdGMVH6E
 =
X-Google-Smtp-Source: AGHT+IFp10ow1Ilrm4J3UqBUDbc8Om5y7qo21epdQNAa1FcmgRWuzTXP/7VEuUZU7qKWoOD1dvxFsA==
X-Received: by 2002:a05:600c:1c28:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-43d84e67696mr50809065e9.0.1743095409086; 
 Thu, 27 Mar 2025 10:10:09 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90001531sm720865e9.40.2025.03.27.10.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 10:10:08 -0700 (PDT)
Message-ID: <bab4ee26-2c36-462a-997b-aaaeab5944b0@linaro.org>
Date: Thu, 27 Mar 2025 18:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/29] efi: arm: Add an EFI app for arm64
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Robert Marko
 <robert.marko@sartura.hr>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-30-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-30-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2/15/25 04:22, Simon Glass wrote:
> Introduce an EFI app for arm64 and update the documentation.
> 
> Provide a value for LOAD_ADDR to avoid a link error.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Use ARCH_EFI instead of VENDOR_EFI
> - Merge the linker-script rules into Kconfig in this patch
> - Drop patch 'Select the EFI linker script for the app'
> 
>   Kconfig                               |  1 +
>   MAINTAINERS                           |  4 ++-
>   arch/arm/dts/efi-arm_app.dts          | 31 ++++++++++++++++
>   board/efi/Kconfig                     | 23 ++++++++++++
>   board/efi/efi-arm_app/Kconfig         | 19 ++++++++++
>   board/efi/efi-arm_app/MAINTAINERS     | 13 +++++++
>   board/efi/efi-arm_app/Makefile        |  5 +++
>   board/efi/efi-arm_app/board.c         | 18 ++++++++++
>   board/efi/efi-arm_app/efi-arm_app.env | 11 ++++++
>   configs/efi-arm_app64_defconfig       | 51 +++++++++++++++++++++++++++
>   doc/develop/uefi/u-boot_on_efi.rst    | 17 ++++-----
>   lib/efi/Kconfig                       |  2 +-
>   12 files changed, 185 insertions(+), 10 deletions(-)
>   create mode 100644 arch/arm/dts/efi-arm_app.dts
>   create mode 100644 board/efi/efi-arm_app/Kconfig
>   create mode 100644 board/efi/efi-arm_app/MAINTAINERS
>   create mode 100644 board/efi/efi-arm_app/Makefile
>   create mode 100644 board/efi/efi-arm_app/board.c
>   create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
>   create mode 100644 configs/efi-arm_app64_defconfig
> 
> diff --git a/Kconfig b/Kconfig
> index 2e63896c477..5ffdc481827 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -551,6 +551,7 @@ config SYS_LOAD_ADDR
>   	default 0x12000000 if ARCH_MX6 && !(MX6SL || MX6SLL  || MX6SX || MX6UL || MX6ULL)
>   	default 0x80800000 if ARCH_MX7
>   	default 0x90000000 if FSL_LSCH2 || FSL_LSCH3
> +	default 0x02000000 if ARCH_EFI

This value should be clearly wrong like 0x0 or 0xdeada555 or something. 
So when it gets used at runtime by mistake it's more obvious what happened.
>   	default 0x0 if ARCH_SC5XX
>   	help
>   	  Address in memory to use as the default safe load address.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8132ab3987d..494d4424ce2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1066,12 +1066,14 @@ M:	Simon Glass <sjg@chromium.org>
>   M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
>   S:	Maintained
>   W:	https://docs.u-boot.org/en/latest/develop/uefi/u-boot_on_efi.html
> +F:	board/efi/efi-arm_app
>   F:	board/efi/efi-x86_app
> +F:	configs/efi-arm_app*
>   F:	configs/efi-x86_app*
>   F:	doc/develop/uefi/u-boot_on_efi.rst
>   F:	drivers/block/efi-media-uclass.c
>   F:	drivers/block/sb_efi_media.c
> -F:	lib/efi/efi_app.c
> +F:	lib/efi/
>   F:	scripts/build-efi.py
>   F:	test/dm/efi_media.c
>   
> diff --git a/arch/arm/dts/efi-arm_app.dts b/arch/arm/dts/efi-arm_app.dts
> new file mode 100644
> index 00000000000..38cab04e510
> --- /dev/null
> +++ b/arch/arm/dts/efi-arm_app.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2015 Google, Inc
> + */
> +
> +/dts-v1/;
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "EFI ARM Application";
> +	compatible = "efi,arm-app";
> +
> +	chosen {
> +		stdout-path = &serial;
> +	};
> +
> +	serial: serial {
> +		compatible = "efi,uart";
> +	};
> +
> +	reset {
> +		compatible = "efi,reset";
> +		bootph-all;
> +	};
> +	efi-fb {
> +		compatible = "efi-fb";
> +		bootph-some-ram;
> +	};

what is this?? We shouldn't be using devicetree, we're running on EFI. 
This makes absolutely no sense.

I see the original x86 app back in the day did it this way, but this is 
just wrong. I can understanding reusing U-Boot's DM, but at least then 
build this DT at runtime based on discovering EFI drivers.
> +
> +};
> diff --git a/board/efi/Kconfig b/board/efi/Kconfig
> index 4c68d85a076..174e6ecd6f4 100644
> --- a/board/efi/Kconfig
> +++ b/board/efi/Kconfig
> @@ -45,4 +45,27 @@ source "board/efi/efi-x86_payload/Kconfig"
>   
>   endif  # X86
>   
> +if ARM
> +
> +choice
> +	prompt "Mainboard model"
> +	optional
> +
> +config TARGET_EFI_ARM_APP64
> +	bool "64-bit efi application"
> +	select EFI_APP
> +	select SYS_CUSTOM_LDSCRIPT
> +	select ARM64
> +	help
> +	  This target is used for running U-Boot on top of EFI in 64-bit mode.
> +	  In this case EFI does the early initialisation, and U-Boot
> +	  takes over once the RAM, video and CPU are fully running.

EFI boot services are still running (and stuff like interrupts will be 
handled by EFI drivers), I wouldn't say U-Boot "takes over" until/unless 
it calls EBS.
> +	  U-Boot is loaded as an application from EFI.
> +
> +endchoice
> +
> +source "board/efi/efi-arm_app/Kconfig"
> +
> +endif  # ARM
> +
>   endif  # ARCH_EFI
> diff --git a/board/efi/efi-arm_app/Kconfig b/board/efi/efi-arm_app/Kconfig
> new file mode 100644
> index 00000000000..6e64bc8a721
> --- /dev/null
> +++ b/board/efi/efi-arm_app/Kconfig
> @@ -0,0 +1,19 @@
> +if EFI_APP
> +
> +config SYS_BOARD
> +	default "efi-arm_app"
> +
> +config SYS_VENDOR
> +	default "efi"
> +
> +config SYS_SOC
> +	default "efi"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +	imply VIDEO_EFI

Why not just put this in TARGET_EFI_ARM_APP64?
> +
> +config SYS_LDSCRIPT
> +	default "arch/arm/lib/elf_aarch64_efi.lds"
> +
> +endif
> diff --git a/board/efi/efi-arm_app/MAINTAINERS b/board/efi/efi-arm_app/MAINTAINERS
> new file mode 100644
> index 00000000000..3114db69a35
> --- /dev/null
> +++ b/board/efi/efi-arm_app/MAINTAINERS
> @@ -0,0 +1,13 @@
> +EFI-ARM_APP32 BOARD
> +M:	Simon Glass <sjg@chromium.org>
> +S:	Maintained
> +F:	board/efi/Kconfig
> +F:	board/efi/efi-arm_app/
> +F:	configs/efi-arm_app32_defconfig

Am I missing something or is this not there?
> +
> +EFI-ARM_APP64 BOARD
> +M:	Simon Glass <sjg@chromium.org>
> +S:	Maintained
> +F:	board/efi/Kconfig
> +F:	board/efi/efi-arm_app/
> +F:	configs/efi-arm_app64_defconfig
> diff --git a/board/efi/efi-arm_app/Makefile b/board/efi/efi-arm_app/Makefile
> new file mode 100644
> index 00000000000..fc6ef159473
> --- /dev/null
> +++ b/board/efi/efi-arm_app/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> +
> +obj-y	+= board.o
> diff --git a/board/efi/efi-arm_app/board.c b/board/efi/efi-arm_app/board.c
> new file mode 100644
> index 00000000000..239e1fbaba4
> --- /dev/null
> +++ b/board/efi/efi-arm_app/board.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2015 Google, Inc

10 years out of date here
> + */
> +
> +#include <init.h>
> +
> +struct mm_region *mem_map;
> +
> +int print_cpuinfo(void)

Just disable CONFIG_DISPLAY_CPUINFO
> +{
> +	return 0;
> +}
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> diff --git a/board/efi/efi-arm_app/efi-arm_app.env b/board/efi/efi-arm_app/efi-arm_app.env
> new file mode 100644
> index 00000000000..b28c15556de
> --- /dev/null
> +++ b/board/efi/efi-arm_app/efi-arm_app.env
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Environment file for ARM EFI app
> + *
> + * Copyright 2025, Simon Glass <simon.glass@canonical.com>
> + */
> +
> +/* common console settings */
> +stdin=serial
> +stdout=serial,vidconsole
> +stderr=serial,vidconsole
> diff --git a/configs/efi-arm_app64_defconfig b/configs/efi-arm_app64_defconfig
> new file mode 100644
> index 00000000000..0199fb16467
> --- /dev/null
> +++ b/configs/efi-arm_app64_defconfig
> @@ -0,0 +1,51 @@
> +CONFIG_ARM=y
> +# CONFIG_ARM64_CRC32 is not set
> +CONFIG_ARCH_EFI_ARM=y
> +CONFIG_NR_DRAM_BANKS=8

Real platforms have way more than this, 32 might be better.

Saying that, it doesn't seem like gd->bd->bi_dram is populated anywhere, 
am I missing something?

> +CONFIG_ENV_SIZE=0x1000
> +CONFIG_DEFAULT_DEVICE_TREE="efi-arm_app"
> +CONFIG_DEBUG_UART_BASE=0x0
> +CONFIG_DEBUG_UART_CLOCK=0
> +CONFIG_DEBUG_UART=y
> +CONFIG_TARGET_EFI_ARM_APP64=y
> +CONFIG_EFI=y
> +CONFIG_EFI_APP_64BIT=y

Looking at these next to each other, it seems odd to have 
CONFIG_TARGET_EFI_ARM_APP64 and CONFIG_EFI_APP_64BIT, would you ever 
have one but not the other?

CONFIG_TARGET_EFI_ARM_APP64 can just go I think.
> +CONFIG_FIT=y
> +# CONFIG_BOOTSTD is not set
> +CONFIG_SHOW_BOOT_PROGRESS=y
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_SYS_PBSIZE=532
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +CONFIG_LOG=y
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_DM=y
> +CONFIG_CMD_PART=y
> +CONFIG_CMD_DNS=y
> +CONFIG_CMD_WGET=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_EXT2=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_MAC_PARTITION=y
> +CONFIG_ISO_PARTITION=y
> +CONFIG_EFI_PARTITION=y
> +CONFIG_OF_LIVE=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_USE_BOOTFILE=y
> +CONFIG_BOOTFILE="bzImage"
> +CONFIG_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_EFI_NET=y
> +CONFIG_DM_RNG=y
> +CONFIG_SYSRESET=y
> +CONFIG_VIDEO=y
> +CONFIG_CONSOLE_SCROLL_LINES=5
> +CONFIG_CMD_DHRYSTONE=y
> diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
> index 9d441cdc2c5..b1d5faa3463 100644
> --- a/doc/develop/uefi/u-boot_on_efi.rst
> +++ b/doc/develop/uefi/u-boot_on_efi.rst
> @@ -27,16 +27,17 @@ Running U-Boot on EFI is useful in several situations:
>   
>   Status
>   ------
> -Only x86 is supported at present. If you are using EFI on another architecture
> -you may want to reconsider. However, much of the code is generic so could be
> -ported.
> +Only x86 and ARM64 are supported at present. If you are using EFI on another
> +architecture you may want to reconsider. However, much of the code is generic so
> +could be ported.
>   
> -U-Boot supports running as an EFI application for both 32- and 64-bit EFI.
> +U-Boot supports running as an EFI application for both 32- and 64-bit EFI on
> +x86, and for 64-bit on ARM.
>   
> -U-Boot supports building itself as a payload for either 32-bit or 64-bit EFI.
> -U-Boot is packaged up and loaded in its entirety by EFI. Once started, U-Boot
> -changes to 32-bit mode (currently) and takes over the machine. You can use
> -devices, boot a kernel, etc.
> +On x86, U-Boot supports building itself as a payload for either 32-bit or 64-bit
> +EFI. U-Boot is packaged up and loaded in its entirety by EFI. Once started,
> +U-Boot changes to 32-bit mode (currently) and takes over the machine. You can
> +use devices, boot a kernel, etc.
>   
>   
>   Build Instructions
> diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
> index 18f69bdcfbe..18b73965469 100644
> --- a/lib/efi/Kconfig
> +++ b/lib/efi/Kconfig
> @@ -17,7 +17,7 @@ choice
>   
>   config EFI_APP
>   	bool "Support running as an EFI application"
> -	depends on !ARM
> +	depends on X86 || ARM
>   	select CHARSET
>   	help
>   	  Build U-Boot as an application which can be started from EFI. This

-- 
Caleb (they/them)

