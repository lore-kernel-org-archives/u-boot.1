Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27B3FA3727
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 09:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8B083FB2;
	Fri,  2 Jan 2026 10:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fkEj+DOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4670D841E6; Fri,  2 Jan 2026 10:26:51 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E790E83B22
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 10:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 802EB3F5A1
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767346008;
 bh=3PK81PnvsLWce2reDqIDRi4FM6B9rAklKJ9IVw+Yz7I=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=fkEj+DOPeOtGB1CE79BNvYAi58NAsd+c9XkpNKV56dmLs+/ErUk++LTJkOqH306It
 nq0LtiJEHMmSa9v0KOCWUzPgSxOuyWFOphWxDnZy9MvWkm6m7dIiDbpnXFMIF1xztn
 Vwig+m7H50DMcGT1elUOsrrbvXPrIy6LOcOi3Z3M4vLpuZYoq1m3XezlDM39zJtNWS
 H9bPKp5Udo5/SrmXYozc4+ecvCoXhtDELpRSAokHQHIm5oApWFIaAGakDVQHnLxJZi
 sZRG1Xg1oKesmwOiz4bS/+U/MCBK4bc45P4ayMw6jALNaOh2+/Pl7Myv+6+Xy1D1BR
 O84KtA34egrbC8M2h8wML/oYu2yehxYwEWuT26kKhVira46z4F6JYSbPelHtQU3TYd
 2GjRkjnihy1mAaHhs3RqWenDbYKgrHrKYL4/GrE9iPFXbWwad4P+gx5auY/pslTt8M
 UoRKae5WPdAJG+Sp49IOsEYSiA6aceLSzZaSHy/qAy/y+j+uXbKEUVntpESDU3lcvn
 WeyNYyP4NezvJSPvpHub476ASb/m+hF+Ixhce2wPWzS9PDUHuBw2J1hDLNtG2sezHg
 wID0V7Bz0QVOIpbrZ9EdGpECUlACoXO3wlxsIsyHY4LTmSFOaQmoChrx9leTsHnt4H
 pKVAScYoLJlcVEzrCdwiO9eM=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso6609734f8f.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 01:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767346008; x=1767950808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3PK81PnvsLWce2reDqIDRi4FM6B9rAklKJ9IVw+Yz7I=;
 b=l5AVqD+LFyT/9JxiG9Z0BS59ZVJ/+RRSaM/vcMh8LbruOel0Rv7/a0mXE5r8WGBRKv
 2pWTTvy25wk2CIcB9VnzNXrmBgOVaS6Gj3byCVJlQ1/ohbb84J3v2D9BP9XQiLjsDHbF
 nYH5OxO2uSGf+oNX18WBziMtNhPq4WpKAMqh1oMF6Fo/B55K2nH0b1ajmmYpo8PmWPcn
 DSf3C0WMnE++mdPIX9pRPT0QfPCbkjCIlQTUtmNOOkwEyK3Lv1HTw2rMdKniQgU+6/77
 zA3dKaNQLBjuQcGf7XTj+xh1aO3D7nNCjExJoX36XbD5TqJLtwm/ysEBr1X939VtntnF
 KxMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFL4ZQ2Si56xjg25dniILP2oKYBHsqU4ZKyC+57tW4A8A4Mrcu0sCRJWktxlZgJgncoI0vcLU=@lists.denx.de
X-Gm-Message-State: AOJu0YweJXPmT4jFxKCN/uU8qjICd5d0Xy76T8SioS1oJY0sxWLRDL9S
 aa8BruadOhL4YfUvILA2vL8B49st4zdR50MzQTef+fPfebIz9iqnIAXpgXm0faN/HXJX2yPtMO5
 OrdyWMe89liUI1W+g8DwF/MH7hcZY1/+U2QJCNFvfd+za+HnvextqkRMSKy3anCiM0oFqkSA=
X-Gm-Gg: AY/fxX72YLA+QqCFk4yHzYiAQAuZrccXS9jECeWPUqSlbY4/7BsYCztbq97sfyRG+vj
 OYOvWBmnOrT3qqto/EUjHPTJiG/ckrpD1VBosMJdR2OgEt52cS+y+LMaWPWl2xkpMecKwOKOkGU
 BRRQE4xiYEk290tG0F5hJEpyfg4V88Abs/sl81gGJ/W1v1ERFzhmJziagOLtmg7x0BbkgsCYGhi
 p1ejI0R+09QOnuJD4mQxYdAkVoJ/XC1kd7H3Md4uIV7umnjs4AHjNJ9YBPuMPHfh0/Y2UsWd+Nq
 v1ggwKte884C9s6pjEwpt/tiI6aE3FjqTgiGwXB/sFzSjr0VE/0pt4MzT+orIgRaIIJUJabFkC7
 /VfMWi8pkIrLe55jXlX1jfvvlpRj421ZeDezw8U5t40rwrDpjT/GuNd+8USmrjHHUAFh9YeQlLY
 BaFTUzdmg=
X-Received: by 2002:a5d:4a4d:0:b0:432:5c43:76 with SMTP id
 ffacd0b85a97d-4325c4302eamr41884690f8f.39.1767346007956; 
 Fri, 02 Jan 2026 01:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoHrwODGVnaUDVQRDWkrTNh8CGI2ExuKLbYHnpERp/9/ipnJqZ5KwWALWLX2yk7yJnGiIvpg==
X-Received: by 2002:a5d:4a4d:0:b0:432:5c43:76 with SMTP id
 ffacd0b85a97d-4325c4302eamr41884660f8f.39.1767346007452; 
 Fri, 02 Jan 2026 01:26:47 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227e0sm85897809f8f.17.2026.01.02.01.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 01:26:46 -0800 (PST)
Message-ID: <e30ef59f-41e9-4b59-bc65-c963bdfd7e40@canonical.com>
Date: Fri, 2 Jan 2026 10:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] board: Add QEMU m68k virt board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-6-visitorckw@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260101175420.4118024-6-visitorckw@gmail.com>
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

On 1/1/26 18:54, Kuan-Wei Chiu wrote:
> Add support for the QEMU 'virt' machine on the m68k architecture. This
> board emulates a generic machine based on the Motorola 68040 CPU
> equipped with Goldfish virtual peripherals.
> 
> Introduce the necessary board configuration and initialization
> infrastructure. The implementation includes logic to parse the QEMU
> bootinfo interface, enabling dynamic detection of system RAM size to
> adapt to the virtual machine's configuration.
> 
> Enable the Goldfish TTY driver for serial console output. Additionally,
> enable Goldfish RTC and timer drivers to support real-time clock
> functionality and nanosecond-resolution delays. Include comprehensive
> documentation covering build instructions and usage examples.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@0x0f.com>
> ---
> No changes in v4.
> 
>   arch/m68k/Kconfig                     |   8 ++
>   board/emulation/qemu-m68k/Kconfig     |  12 +++
>   board/emulation/qemu-m68k/MAINTAINERS |   8 ++
>   board/emulation/qemu-m68k/Makefile    |   5 ++
>   board/emulation/qemu-m68k/qemu-m68k.c | 115 ++++++++++++++++++++++++++
>   configs/qemu-m68k_defconfig           |  16 ++++
>   doc/board/emulation/index.rst         |   1 +
>   doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
>   include/configs/qemu-m68k.h           |  18 ++++
>   9 files changed, 222 insertions(+)
>   create mode 100644 board/emulation/qemu-m68k/Kconfig
>   create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
>   create mode 100644 board/emulation/qemu-m68k/Makefile
>   create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
>   create mode 100644 configs/qemu-m68k_defconfig
>   create mode 100644 doc/board/emulation/qemu-m68k.rst
>   create mode 100644 include/configs/qemu-m68k.h
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index de7c673c376..605ae5ec20c 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -183,6 +183,13 @@ config TARGET_STMARK2
>           select CF_DSPI
>           select M54418
>   
> +config TARGET_QEMU_M68K
> +    bool "Support QEMU m68k virt"
> +    select M68040

Not even the dm command is available on the board by default. How about 
letting TARGET_QEMU_M68K imply CMD_DM like other targets do?

Best regards

Heinrich

> +    help
> +      This target supports the QEMU m68k virtual machine (-M virt).
> +      It simulates a Motorola 68040 CPU with Goldfish peripherals.
> +
>   endchoice
>   
>   config SYS_CPU
> @@ -208,6 +215,7 @@ source "board/freescale/m5329evb/Kconfig"
>   source "board/freescale/m5373evb/Kconfig"
>   source "board/sysam/amcore/Kconfig"
>   source "board/sysam/stmark2/Kconfig"
> +source "board/emulation/qemu-m68k/Kconfig"
>   
>   config M68K_QEMU
>   	bool "Build with workarounds for incomplete QEMU emulation"
> diff --git a/board/emulation/qemu-m68k/Kconfig b/board/emulation/qemu-m68k/Kconfig
> new file mode 100644
> index 00000000000..aae6dfe400f
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_QEMU_M68K
> +
> +config SYS_BOARD
> +	default "qemu-m68k"
> +
> +config SYS_VENDOR
> +	default "emulation"
> +
> +config SYS_CONFIG_NAME
> +	default "qemu-m68k"
> +
> +endif
> diff --git a/board/emulation/qemu-m68k/MAINTAINERS b/board/emulation/qemu-m68k/MAINTAINERS
> new file mode 100644
> index 00000000000..90414c58465
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/MAINTAINERS
> @@ -0,0 +1,8 @@
> +QEMU M68K VIRT BOARD
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:	Maintained
> +F:	board/emulation/qemu-m68k/
> +F:	board/emulation/common/
> +F:	include/configs/qemu-m68k.h
> +F:	configs/qemu-m68k_defconfig
> +F:	doc/board/emulation/qemu-m68k.rst
> diff --git a/board/emulation/qemu-m68k/Makefile b/board/emulation/qemu-m68k/Makefile
> new file mode 100644
> index 00000000000..5cb2886ff5a
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> +
> +obj-y += qemu-m68k.o
> diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> new file mode 100644
> index 00000000000..3b911b95343
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/qemu-m68k.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include <asm-generic/sections.h>
> +#include <asm/bootinfo.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <config.h>
> +#include <dm/platdata.h>
> +#include <goldfish_rtc.h>
> +#include <goldfish_timer.h>
> +#include <goldfish_tty.h>
> +#include <init.h>
> +#include <linux/errno.h>
> +#include <serial.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* QEMU Virt Machine Hardware Map */
> +#define VIRT_GF_RTC_MMIO_BASE  0xff007000
> +#define VIRT_GF_TTY_MMIO_BASE  0xff008000
> +#define VIRT_CTRL_MMIO_BASE    0xff009000
> +#define VIRT_CTRL_RESET        0x01
> +
> +/*
> + * Theoretical limit derivation:
> + * Max Bootinfo Size (Standard Page) = 4096 bytes
> + * Min Record Size (Tag + Size)      = 4 bytes
> + * Max Records = 4096 / 4 = 1024
> + */
> +#define MAX_BOOTINFO_RECORDS  1024
> +
> +int board_early_init_f(void)
> +{
> +	return 0;
> +}
> +
> +int checkboard(void)
> +{
> +	puts("Board: QEMU m68k virt\n");
> +	return 0;
> +}
> +
> +int dram_init(void)
> +{
> +	struct bi_record *record;
> +	ulong addr;
> +	int loops = 0;
> +
> +	/* Default: 16MB */
> +	gd->ram_size = 0x01000000;
> +
> +	/* QEMU places bootinfo after _end, aligned to 2 bytes */
> +	addr = (ulong)&_end;
> +	addr = ALIGN(addr, 2);
> +
> +	record = (struct bi_record *)addr;
> +
> +	if (record->tag != BI_MACHTYPE)
> +		return 0;
> +
> +	while (record->tag != BI_LAST) {
> +		if (++loops > MAX_BOOTINFO_RECORDS)
> +			panic("Bootinfo loop exceeded");
> +		if (record->tag == BI_MEMCHUNK) {
> +			gd->ram_size = record->data[1];
> +			break;
> +		}
> +		record = (struct bi_record *)((ulong)record + record->size);
> +	}
> +
> +	return 0;
> +}
> +
> +void reset_cpu(unsigned long addr)
> +{
> +	writel(VIRT_CTRL_RESET, VIRT_CTRL_MMIO_BASE);
> +	while (1)
> +		;
> +}
> +
> +int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	reset_cpu(0);
> +	return 0;
> +}
> +
> +static const struct goldfish_rtc_plat rtc_plat = {
> +	.base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
> +};
> +
> +U_BOOT_DRVINFO(goldfish_rtc) = {
> +	.name = "rtc_goldfish",
> +	.plat = &rtc_plat,
> +};
> +
> +static const struct goldfish_timer_plat timer_plat = {
> +	.base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
> +};
> +
> +U_BOOT_DRVINFO(goldfish_timer) = {
> +	.name = "goldfish_timer",
> +	.plat = &timer_plat,
> +};
> +
> +static const struct goldfish_tty_plat serial_plat = {
> +	.base = (void __iomem *)VIRT_GF_TTY_MMIO_BASE,
> +};
> +
> +U_BOOT_DRVINFO(goldfish_serial) = {
> +	.name = "serial_goldfish",
> +	.plat = &serial_plat,
> +};
> diff --git a/configs/qemu-m68k_defconfig b/configs/qemu-m68k_defconfig
> new file mode 100644
> index 00000000000..f9294218429
> --- /dev/null
> +++ b/configs/qemu-m68k_defconfig
> @@ -0,0 +1,16 @@
> +CONFIG_M68K=y
> +CONFIG_TEXT_BASE=0x00000000
> +CONFIG_SYS_MALLOC_LEN=0x20000
> +CONFIG_SYS_MALLOC_F_LEN=0x2000
> +CONFIG_SYS_MONITOR_LEN=262144
> +CONFIG_SYS_BOOTM_LEN=0x1000000
> +CONFIG_SYS_LOAD_ADDR=0x00000000
> +CONFIG_TARGET_QEMU_M68K=y
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_GOLDFISH=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SERIAL_GOLDFISH=y
> +CONFIG_TIMER=y
> +CONFIG_GOLDFISH_TIMER=y
> diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> index f8908166276..4f7c812d493 100644
> --- a/doc/board/emulation/index.rst
> +++ b/doc/board/emulation/index.rst
> @@ -15,6 +15,7 @@ Emulation
>      qemu-sbsa
>      qemu-x86
>      qemu-xtensa
> +   qemu-m68k
>   
>   Also see
>   
> diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
> new file mode 100644
> index 00000000000..6c4de54cf6a
> --- /dev/null
> +++ b/doc/board/emulation/qemu-m68k.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> +
> +QEMU m68k
> +=========
> +
> +QEMU for m68k supports a special 'virt' machine designed for emulation and
> +virtualization purposes. This document describes how to run U-Boot under it.
> +
> +The QEMU virt machine models a generic m68k virtual machine with Goldfish
> +interfaces. It supports the Motorola 68040 CPU architecture.
> +
> +Building U-Boot
> +---------------
> +Set the CROSS_COMPILE environment variable to your m68k toolchain, and run:
> +
> +.. code-block:: bash
> +
> +    export CROSS_COMPILE=m68k-linux-gnu-
> +    make qemu-m68k_defconfig
> +    make
> +
> +Running U-Boot
> +--------------
> +The minimal QEMU command line to get U-Boot up and running is:
> +
> +.. code-block:: bash
> +
> +    qemu-system-m68k -M virt -cpu m68040 -nographic -kernel u-boot
> +
> +Note that the `-nographic` option is used to redirect the console to stdio,
> +which connects to the emulated Goldfish TTY device.
> +
> +Hardware Support
> +----------------
> +The following QEMU virt peripherals are supported in U-Boot:
> +
> +* Goldfish TTY (Serial Console)
> +* Goldfish RTC (Real Time Clock)
> diff --git a/include/configs/qemu-m68k.h b/include/configs/qemu-m68k.h
> new file mode 100644
> index 00000000000..1d8aa92fe80
> --- /dev/null
> +++ b/include/configs/qemu-m68k.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef __QEMU_M68K_H
> +#define __QEMU_M68K_H
> +
> +/* Memory Configuration */
> +#define CFG_SYS_SDRAM_BASE       0x00000000
> +
> +/*
> + * Initial Stack Pointer:
> + * Place the stack at 4MB offset to avoid overwriting U-Boot code/data.
> + */
> +#define CFG_SYS_INIT_SP_ADDR     (CFG_SYS_SDRAM_BASE + 0x400000)
> +
> +#endif /* __QEMU_M68K_H */

