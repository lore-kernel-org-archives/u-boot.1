Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FBAC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 06:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447B582977;
	Wed, 25 Jun 2025 08:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="ElqeaE1B";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="h0aujWo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043E182B18; Wed, 25 Jun 2025 08:57:42 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD03803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 08:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id b63d1869;
 Wed, 25 Jun 2025 06:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=xV
 jPscoBn4S9oYWoKj81oQcP+K0=; b=ElqeaE1B0jxlglspm9gXfp0L2Ki7Tfbtd0
 BUVDiGyoBUpA1Q4ForNwDsBKF4/vjnXvjijVoRUczGw7/V9mNsfJUntPGo1XYxUA
 l+G6tvda5DGWFdHEn/TnBGinmMk5tVG9aZHezk2lWEdYkrLNYo/JdFJnSNcNBABa
 q+yFL2vfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 zlyH8QH5h35gfGM9YwGoZjX4H8wORpQZpEMPSsBAj9kO1a6HXBjrEtBAeZHGzRUd
 rMEWfjBig2eBspfK3MVlUpZFqVM4otVuqQbGVaK6YlFlJjae8lPMKyMveh1BZSyK
 vBrZunUMq6XdhG5qNk00Tvl32QQ5Hy8F5t2vH53EgmI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1750834657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88do25oza/d8rwmtAPt+13T/1G+V7vQSGRR8esziqp4=;
 b=h0aujWo9cqrS93mshagWUizEV3n9ZZnvNoP4jj8bspDCS7B7JNEKUUBrTwZrD/JHO4T6NS
 m/IpD3+5LBziXaO5AAkpkPbmEX0zIlxNOkxJotgFKOp2v/1ehtMDMav8aETM+ELt3ol03v
 UOQqW62IeVGV0Aoak2COCDETE+ccFRs=
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it
 [80.116.51.117])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 5b98c2e1
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 25 Jun 2025 06:57:37 +0000 (UTC)
Message-ID: <d75973bb-ff77-4367-8532-e5dead905664@kernel-space.org>
Date: Wed, 25 Jun 2025 08:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: Remove astro_mcf5373l board
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Huan Wang <alison.wang@nxp.com>, Wolfgang Wegner <w.wegner@astro-kom.de>
References: <20250620162147.3419120-1-trini@konsulko.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20250620162147.3419120-1-trini@konsulko.com>
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

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 6/20/25 18:21, Tom Rini wrote:
> This board is currently unmaintained. Remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Wolfgang Wegner <w.wegner@astro-kom.de>
> ---
>   arch/m68k/Kconfig                |   5 -
>   arch/m68k/dts/Makefile           |   1 -
>   arch/m68k/dts/astro_mcf5373l.dts |  27 --
>   board/astro/mcf5373l/Kconfig     |  15 --
>   board/astro/mcf5373l/MAINTAINERS |   6 -
>   board/astro/mcf5373l/Makefile    |   6 -
>   board/astro/mcf5373l/astro.h     |  44 ----
>   board/astro/mcf5373l/fpga.c      | 407 -------------------------------
>   board/astro/mcf5373l/mcf5373l.c  | 201 ---------------
>   configs/astro_mcf5373l_defconfig |  51 ----
>   include/configs/astro_mcf5373l.h | 187 --------------
>   11 files changed, 950 deletions(-)
>   delete mode 100644 arch/m68k/dts/astro_mcf5373l.dts
>   delete mode 100644 board/astro/mcf5373l/Kconfig
>   delete mode 100644 board/astro/mcf5373l/MAINTAINERS
>   delete mode 100644 board/astro/mcf5373l/Makefile
>   delete mode 100644 board/astro/mcf5373l/astro.h
>   delete mode 100644 board/astro/mcf5373l/fpga.c
>   delete mode 100644 board/astro/mcf5373l/mcf5373l.c
>   delete mode 100644 configs/astro_mcf5373l_defconfig
>   delete mode 100644 include/configs/astro_mcf5373l.h
>
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index b288c65e7fd1..8ade6f7b9d18 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -155,10 +155,6 @@ config TARGET_M5282EVB
>   	bool "Support M5282EVB"
>   	select M5282
>   
> -config TARGET_ASTRO_MCF5373L
> -	bool "Support astro_mcf5373l"
> -	select M5373
> -
>   config TARGET_M53017EVB
>   	bool "Support M53017EVB"
>   	select M53015
> @@ -183,7 +179,6 @@ config TARGET_STMARK2
>   endchoice
>   
>   source "board/BuS/eb_cpu5282/Kconfig"
> -source "board/astro/mcf5373l/Kconfig"
>   source "board/cobra5272/Kconfig"
>   source "board/freescale/m5208evbe/Kconfig"
>   source "board/freescale/m5235evb/Kconfig"
> diff --git a/arch/m68k/dts/Makefile b/arch/m68k/dts/Makefile
> index 0f06109aa06c..c89559be309f 100644
> --- a/arch/m68k/dts/Makefile
> +++ b/arch/m68k/dts/Makefile
> @@ -11,7 +11,6 @@ dtb-$(CONFIG_TARGET_M5253DEMO) += M5253DEMO.dtb
>   dtb-$(CONFIG_TARGET_M5272C3) += M5272C3.dtb
>   dtb-$(CONFIG_TARGET_M5275EVB) += M5275EVB.dtb
>   dtb-$(CONFIG_TARGET_M5282EVB) += M5282EVB.dtb
> -dtb-$(CONFIG_TARGET_ASTRO_MCF5373L) += astro_mcf5373l.dtb
>   dtb-$(CONFIG_TARGET_M53017EVB) += M53017EVB.dtb
>   dtb-$(CONFIG_TARGET_M5329EVB) += M5329AFEE.dtb M5329BFEE.dtb
>   dtb-$(CONFIG_TARGET_M5373EVB) += M5373EVB.dtb
> diff --git a/arch/m68k/dts/astro_mcf5373l.dts b/arch/m68k/dts/astro_mcf5373l.dts
> deleted file mode 100644
> index 40f84dd64b62..000000000000
> --- a/arch/m68k/dts/astro_mcf5373l.dts
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> - */
> -
> -/dts-v1/;
> -/include/ "mcf537x.dtsi"
> -
> -/ {
> -	model = "Astro mcf5373l";
> -	compatible = "astro,mcf5373l";
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&uart0 {
> -	bootph-all;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <80000>;
> -	u-boot,i2c-slave-addr = <0x7f>;
> -	status = "okay";
> -};
> diff --git a/board/astro/mcf5373l/Kconfig b/board/astro/mcf5373l/Kconfig
> deleted file mode 100644
> index a7c04cef83dc..000000000000
> --- a/board/astro/mcf5373l/Kconfig
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -if TARGET_ASTRO_MCF5373L
> -
> -config SYS_CPU
> -	default "mcf532x"
> -
> -config SYS_BOARD
> -	default "mcf5373l"
> -
> -config SYS_VENDOR
> -	default "astro"
> -
> -config SYS_CONFIG_NAME
> -	default "astro_mcf5373l"
> -
> -endif
> diff --git a/board/astro/mcf5373l/MAINTAINERS b/board/astro/mcf5373l/MAINTAINERS
> deleted file mode 100644
> index 6c23da719685..000000000000
> --- a/board/astro/mcf5373l/MAINTAINERS
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -MCF5373L BOARD
> -M:	Wolfgang Wegner <w.wegner@astro-kom.de>
> -S:	Maintained
> -F:	board/astro/mcf5373l/
> -F:	include/configs/astro_mcf5373l.h
> -F:	configs/astro_mcf5373l_defconfig
> diff --git a/board/astro/mcf5373l/Makefile b/board/astro/mcf5373l/Makefile
> deleted file mode 100644
> index d3ea0d06a8d9..000000000000
> --- a/board/astro/mcf5373l/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# (C) Copyright 2000-2006
> -# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> -
> -obj-y	= mcf5373l.o fpga.o
> diff --git a/board/astro/mcf5373l/astro.h b/board/astro/mcf5373l/astro.h
> deleted file mode 100644
> index b55a6f785cef..000000000000
> --- a/board/astro/mcf5373l/astro.h
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -#ifndef __ASTRO_H__
> -#define __ASTRO_H__
> -
> -/* in mcf5373l.c */
> -int rs_serial_init(int port, int baud);
> -void astro_put_char(char ch);
> -int astro_is_char(void);
> -int astro_get_char(void);
> -
> -/* in fpga.c */
> -int astro5373l_altera_load(void);
> -int astro5373l_xilinx_load(void);
> -
> -/* data structures used for communication (update.c) */
> -typedef struct card_id {
> -	char card_type;
> -	char hardware_version;
> -	char software_version;
> -	char software_subversion;	/* " ","a".."z" */
> -	char fpga_version_altera;
> -	char fpga_version_xilinx;
> -} card_id_t;
> -
> -typedef struct {
> -	unsigned char mode;
> -	unsigned char deviation;
> -	unsigned short freq;
> -} __attribute__ ((packed)) output_params_t;
> -
> -typedef struct {
> -	unsigned short satfreq;
> -	unsigned char satdatallg;
> -	unsigned short symbolrate;
> -	unsigned char viterbirate;
> -	unsigned char symbolrate_l;
> -	output_params_t output_params;
> -	unsigned char reserve;
> -	unsigned char card_error;
> -	unsigned short dummy_ts_id;
> -	unsigned char dummy_pat_ver;
> -	unsigned char dummy_sdt_ver;
> -} __attribute__ ((packed)) parameters_t;
> -
> -#endif /* __ASTRO_H__ */
> diff --git a/board/astro/mcf5373l/fpga.c b/board/astro/mcf5373l/fpga.c
> deleted file mode 100644
> index 6e505c630d12..000000000000
> --- a/board/astro/mcf5373l/fpga.c
> +++ /dev/null
> @@ -1,407 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2006
> - * Wolfgang Wegner, ASTRO Strobel Kommunikationssysteme GmbH,
> - * w.wegner@astro-kom.de
> - *
> - * based on the files by
> - * Heiko Schocher, DENX Software Engineering, hs@denx.de
> - * and
> - * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
> - * Keith Outwater, keith_outwater@mvis.com.
> - */
> -
> -/* Altera/Xilinx FPGA configuration support for the ASTRO "URMEL" board */
> -
> -#include <console.h>
> -#include <watchdog.h>
> -#include <altera.h>
> -#include <ACEX1K.h>
> -#include <spartan3.h>
> -#include <command.h>
> -#include <asm/immap_5329.h>
> -#include <asm/io.h>
> -#include "fpga.h"
> -
> -int altera_pre_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -	unsigned char tmp_char;
> -	unsigned short tmp_short;
> -
> -	/* first, set the required pins to GPIO function */
> -	/* PAR_T0IN -> GPIO */
> -	tmp_char = readb(&gpiop->par_timer);
> -	tmp_char &= 0xfc;
> -	writeb(tmp_char, &gpiop->par_timer);
> -	/* all QSPI pins -> GPIO */
> -	writew(0x0000, &gpiop->par_qspi);
> -	/* U0RTS, U0CTS -> GPIO */
> -	tmp_short = __raw_readw(&gpiop->par_uart);
> -	tmp_short &= 0xfff3;
> -	__raw_writew(tmp_short, &gpiop->par_uart);
> -	/* all PWM pins -> GPIO */
> -	writeb(0x00, &gpiop->par_pwm);
> -	/* next, set data direction registers */
> -	writeb(0x01, &gpiop->pddr_timer);
> -	writeb(0x25, &gpiop->pddr_qspi);
> -	writeb(0x0c, &gpiop->pddr_uart);
> -	writeb(0x04, &gpiop->pddr_pwm);
> -
> -	/* ensure other SPI peripherals are deselected */
> -	writeb(0x08, &gpiop->ppd_uart);
> -	writeb(0x38, &gpiop->ppd_qspi);
> -
> -	/* CONFIG = 0 STATUS = 0 -> FPGA in reset state */
> -	writeb(0xFB, &gpiop->pclrr_uart);
> -	/* enable Altera configuration by clearing QSPI_CS2 and DT0IN */
> -	writeb(0xFE, &gpiop->pclrr_timer);
> -	writeb(0xDF, &gpiop->pclrr_qspi);
> -	return FPGA_SUCCESS;
> -}
> -
> -/* Set the state of CONFIG Pin */
> -int altera_config_fn(int assert_config, int flush, int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	if (assert_config)
> -		writeb(0x04, &gpiop->ppd_uart);
> -	else
> -		writeb(0xFB, &gpiop->pclrr_uart);
> -	return FPGA_SUCCESS;
> -}
> -
> -/* Returns the state of STATUS Pin */
> -int altera_status_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	if (readb(&gpiop->ppd_pwm) & 0x08)
> -		return FPGA_FAIL;
> -	return FPGA_SUCCESS;
> -}
> -
> -/* Returns the state of CONF_DONE Pin */
> -int altera_done_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	if (readb(&gpiop->ppd_pwm) & 0x20)
> -		return FPGA_FAIL;
> -	return FPGA_SUCCESS;
> -}
> -
> -/*
> - * writes the complete buffer to the FPGA
> - * writing the complete buffer in one function is much faster,
> - * then calling it for every bit
> - */
> -int altera_write_fn(const void *buf, size_t len, int flush, int cookie)
> -{
> -	size_t bytecount = 0;
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -	unsigned char *data = (unsigned char *)buf;
> -	unsigned char val = 0;
> -	int i;
> -	int len_40 = len / 40;
> -
> -	while (bytecount < len) {
> -		val = data[bytecount++];
> -		i = 8;
> -		do {
> -			writeb(0xFB, &gpiop->pclrr_qspi);
> -			if (val & 0x01)
> -				writeb(0x01, &gpiop->ppd_qspi);
> -			else
> -				writeb(0xFE, &gpiop->pclrr_qspi);
> -			writeb(0x04, &gpiop->ppd_qspi);
> -			val >>= 1;
> -			i--;
> -		} while (i > 0);
> -
> -		if (bytecount % len_40 == 0) {
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> -			schedule();
> -#endif
> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> -			putc('.');	/* let them know we are alive */
> -#endif
> -#ifdef CONFIG_SYS_FPGA_CHECK_CTRLC
> -			if (ctrlc())
> -				return FPGA_FAIL;
> -#endif
> -		}
> -	}
> -	return FPGA_SUCCESS;
> -}
> -
> -/* called, when programming is aborted */
> -int altera_abort_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	writeb(0x20, &gpiop->ppd_qspi);
> -	writeb(0x08, &gpiop->ppd_uart);
> -	return FPGA_SUCCESS;
> -}
> -
> -/* called, when programming was succesful */
> -int altera_post_fn(int cookie)
> -{
> -	return altera_abort_fn(cookie);
> -}
> -
> -/*
> - * Note that these are pointers to code that is in Flash. They will be
> - * relocated at runtime.
> - * FIXME: relocation not yet working for coldfire, see below!
> - */
> -Altera_CYC2_Passive_Serial_fns altera_fns = {
> -	altera_pre_fn,
> -	altera_config_fn,
> -	altera_status_fn,
> -	altera_done_fn,
> -	altera_write_fn,
> -	altera_abort_fn,
> -	altera_post_fn
> -};
> -
> -#define FPGA_COUNT	1
> -Altera_desc altera_fpga[FPGA_COUNT] = {
> -	{Altera_CYC2,
> -	 passive_serial,
> -	 85903,
> -	 (void *)&altera_fns,
> -	 NULL,
> -	 0}
> -};
> -
> -/* Initialize the fpga.  Return 1 on success, 0 on failure. */
> -int astro5373l_altera_load(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < FPGA_COUNT; i++) {
> -		/*
> -		 * I did not yet manage to get relocation work properly,
> -		 * so set stuff here instead of static initialisation:
> -		 */
> -		altera_fns.pre = altera_pre_fn;
> -		altera_fns.config = altera_config_fn;
> -		altera_fns.status = altera_status_fn;
> -		altera_fns.done = altera_done_fn;
> -		altera_fns.write = altera_write_fn;
> -		altera_fns.abort = altera_abort_fn;
> -		altera_fns.post = altera_post_fn;
> -		altera_fpga[i].iface_fns = (void *)&altera_fns;
> -		fpga_add(fpga_altera, &altera_fpga[i]);
> -	}
> -	return 1;
> -}
> -
> -/* Set the FPGA's PROG_B line to the specified level */
> -int xilinx_pgm_config_fn(int assert, int flush, int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	if (assert)
> -		writeb(0xFB, &gpiop->pclrr_uart);
> -	else
> -		writeb(0x04, &gpiop->ppd_uart);
> -	return assert;
> -}
> -
> -/*
> - * Test the state of the active-low FPGA INIT line.  Return 1 on INIT
> - * asserted (low).
> - */
> -int xilinx_init_config_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	return (readb(&gpiop->ppd_pwm) & 0x08) == 0;
> -}
> -
> -/* Test the state of the active-high FPGA DONE pin */
> -int xilinx_done_config_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	return (readb(&gpiop->ppd_pwm) & 0x20) >> 5;
> -}
> -
> -/* Abort an FPGA operation */
> -int xilinx_abort_config_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -	/* ensure all SPI peripherals and FPGAs are deselected */
> -	writeb(0x08, &gpiop->ppd_uart);
> -	writeb(0x01, &gpiop->ppd_timer);
> -	writeb(0x38, &gpiop->ppd_qspi);
> -	return FPGA_FAIL;
> -}
> -
> -/*
> - * FPGA pre-configuration function. Just make sure that
> - * FPGA reset is asserted to keep the FPGA from starting up after
> - * configuration.
> - */
> -int xilinx_pre_config_fn(int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -	unsigned char tmp_char;
> -	unsigned short tmp_short;
> -
> -	/* first, set the required pins to GPIO function */
> -	/* PAR_T0IN -> GPIO */
> -	tmp_char = readb(&gpiop->par_timer);
> -	tmp_char &= 0xfc;
> -	writeb(tmp_char, &gpiop->par_timer);
> -	/* all QSPI pins -> GPIO */
> -	writew(0x0000, &gpiop->par_qspi);
> -	/* U0RTS, U0CTS -> GPIO */
> -	tmp_short = __raw_readw(&gpiop->par_uart);
> -	tmp_short &= 0xfff3;
> -	__raw_writew(tmp_short, &gpiop->par_uart);
> -	/* all PWM pins -> GPIO */
> -	writeb(0x00, &gpiop->par_pwm);
> -	/* next, set data direction registers */
> -	writeb(0x01, &gpiop->pddr_timer);
> -	writeb(0x25, &gpiop->pddr_qspi);
> -	writeb(0x0c, &gpiop->pddr_uart);
> -	writeb(0x04, &gpiop->pddr_pwm);
> -
> -	/* ensure other SPI peripherals are deselected */
> -	writeb(0x08, &gpiop->ppd_uart);
> -	writeb(0x38, &gpiop->ppd_qspi);
> -	writeb(0x01, &gpiop->ppd_timer);
> -
> -	/* CONFIG = 0, STATUS = 0 -> FPGA in reset state */
> -	writeb(0xFB, &gpiop->pclrr_uart);
> -	/* enable Xilinx configuration by clearing QSPI_CS2 and U0CTS */
> -	writeb(0xF7, &gpiop->pclrr_uart);
> -	writeb(0xDF, &gpiop->pclrr_qspi);
> -	return 0;
> -}
> -
> -/*
> - * FPGA post configuration function. Should perform a test if FPGA is running.
> - */
> -int xilinx_post_config_fn(int cookie)
> -{
> -	int rc = 0;
> -
> -	/*
> -	 * no test yet
> -	 */
> -	return rc;
> -}
> -
> -int xilinx_clk_config_fn(int assert_clk, int flush, int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	if (assert_clk)
> -		writeb(0x04, &gpiop->ppd_qspi);
> -	else
> -		writeb(0xFB, &gpiop->pclrr_qspi);
> -	return assert_clk;
> -}
> -
> -int xilinx_wr_config_fn(int assert_write, int flush, int cookie)
> -{
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -
> -	if (assert_write)
> -		writeb(0x01, &gpiop->ppd_qspi);
> -	else
> -		writeb(0xFE, &gpiop->pclrr_qspi);
> -	return assert_write;
> -}
> -
> -int xilinx_fastwr_config_fn(void *buf, size_t len, int flush, int cookie)
> -{
> -	size_t bytecount = 0;
> -	gpio_t *gpiop = (gpio_t *)MMAP_GPIO;
> -	unsigned char *data = (unsigned char *)buf;
> -	unsigned char val = 0;
> -	int i;
> -	int len_40 = len / 40;
> -
> -	for (bytecount = 0; bytecount < len; bytecount++) {
> -		val = *(data++);
> -		for (i = 8; i > 0; i--) {
> -			writeb(0xFB, &gpiop->pclrr_qspi);
> -			if (val & 0x80)
> -				writeb(0x01, &gpiop->ppd_qspi);
> -			else
> -				writeb(0xFE, &gpiop->pclrr_qspi);
> -			writeb(0x04, &gpiop->ppd_qspi);
> -			val <<= 1;
> -		}
> -		if (bytecount % len_40 == 0) {
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> -			schedule();
> -#endif
> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> -			putc('.');	/* let them know we are alive */
> -#endif
> -#ifdef CONFIG_SYS_FPGA_CHECK_CTRLC
> -			if (ctrlc())
> -				return FPGA_FAIL;
> -#endif
> -		}
> -	}
> -	return FPGA_SUCCESS;
> -}
> -
> -/*
> - * Note that these are pointers to code that is in Flash.  They will be
> - * relocated at runtime.
> - * FIXME: relocation not yet working for coldfire, see below!
> - */
> -xilinx_spartan3_slave_serial_fns xilinx_fns = {
> -	xilinx_pre_config_fn,
> -	xilinx_pgm_config_fn,
> -	xilinx_clk_config_fn,
> -	xilinx_init_config_fn,
> -	xilinx_done_config_fn,
> -	xilinx_wr_config_fn,
> -	0,
> -	xilinx_fastwr_config_fn
> -};
> -
> -xilinx_desc xilinx_fpga[FPGA_COUNT] = {
> -	{xilinx_spartan3,
> -	 slave_serial,
> -	 XILINX_XC3S4000_SIZE,
> -	 (void *)&xilinx_fns,
> -	 0,
> -	 &spartan3_op}
> -};
> -
> -/* Initialize the fpga.  Return 1 on success, 0 on failure. */
> -int astro5373l_xilinx_load(void)
> -{
> -	int i;
> -
> -	fpga_init();
> -
> -	for (i = 0; i < FPGA_COUNT; i++) {
> -		/*
> -		 * I did not yet manage to get relocation work properly,
> -		 * so set stuff here instead of static initialisation:
> -		 */
> -		xilinx_fns.pre = xilinx_pre_config_fn;
> -		xilinx_fns.pgm = xilinx_pgm_config_fn;
> -		xilinx_fns.clk = xilinx_clk_config_fn;
> -		xilinx_fns.init = xilinx_init_config_fn;
> -		xilinx_fns.done = xilinx_done_config_fn;
> -		xilinx_fns.wr = xilinx_wr_config_fn;
> -		xilinx_fns.bwr = xilinx_fastwr_config_fn;
> -		xilinx_fpga[i].iface_fns = (void *)&xilinx_fns;
> -		fpga_add(fpga_xilinx, &xilinx_fpga[i]);
> -	}
> -	return 1;
> -}
> diff --git a/board/astro/mcf5373l/mcf5373l.c b/board/astro/mcf5373l/mcf5373l.c
> deleted file mode 100644
> index 43fcbc65513d..000000000000
> --- a/board/astro/mcf5373l/mcf5373l.c
> +++ /dev/null
> @@ -1,201 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2000-2003
> - * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> - * modified by Wolfgang Wegner <w.wegner@astro-kom.de> for ASTRO 5373l
> - */
> -
> -#include <config.h>
> -#include <init.h>
> -#include <serial.h>
> -#include <time.h>
> -#include <watchdog.h>
> -#include <command.h>
> -#include <asm/global_data.h>
> -#include <asm/m5329.h>
> -#include <asm/immap_5329.h>
> -#include <asm/io.h>
> -#include <linux/delay.h>
> -
> -/* needed for astro bus: */
> -#include <asm/uart.h>
> -#include "astro.h"
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -extern void uart_port_conf(void);
> -
> -int checkboard(void)
> -{
> -	puts("Board: ");
> -	puts("ASTRO MCF5373L (Urmel) Board\n");
> -	return 0;
> -}
> -
> -int dram_init(void)
> -{
> -#if !defined(CONFIG_MONITOR_IS_IN_RAM)
> -	sdram_t *sdp = (sdram_t *)(MMAP_SDRAM);
> -
> -	/*
> -	 * GPIO configuration for bus should be set correctly from reset,
> -	 * so we do not care! First, set up address space: at this point,
> -	 * we should be running from internal SRAM;
> -	 * so use CFG_SYS_SDRAM_BASE as the base address for SDRAM,
> -	 * and do not care where it is
> -	 */
> -	__raw_writel((CFG_SYS_SDRAM_BASE & 0xFFF00000) | 0x00000018,
> -			&sdp->cs0);
> -	__raw_writel((CFG_SYS_SDRAM_BASE & 0xFFF00000) | 0x00000000,
> -			&sdp->cs1);
> -	/*
> -	 * I am not sure from the data sheet, but it seems burst length
> -	 * has to be 8 for the 16 bit data bus we use;
> -	 * so these values are for BL = 8
> -	 */
> -	__raw_writel(0x33211530, &sdp->cfg1);
> -	__raw_writel(0x56570000, &sdp->cfg2);
> -	/* send PrechargeALL, REF and IREF remain cleared! */
> -	__raw_writel(0xE1462C02, &sdp->ctrl);
> -	udelay(1);
> -	/* refresh SDRAM twice */
> -	__raw_writel(0xE1462C04, &sdp->ctrl);
> -	udelay(1);
> -	__raw_writel(0xE1462C04, &sdp->ctrl);
> -	/* init MR  */
> -	__raw_writel(0x008D0000, &sdp->mode);
> -	/* initialize EMR */
> -	__raw_writel(0x80010000, &sdp->mode);
> -	/* wait until DLL is locked */
> -	udelay(1);
> -	/*
> -	 * enable automatic refresh, lock mode register,
> -	 * clear iref and ipall
> -	 */
> -	__raw_writel(0x71462C00, &sdp->ctrl);
> -	/* Dummy write to start SDRAM */
> -	writel(0, CFG_SYS_SDRAM_BASE);
> -#endif
> -
> -	/*
> -	 * for get_ram_size() to work, both CS areas have to be
> -	 * configured, i.e. CS1 has to be explicitely disabled, else
> -	 * probing for memory will cause the SDRAM bus to hang!
> -	 * (Do not rely on the SDCS register(s) being set to 0x00000000
> -	 * during reset as stated in the data sheet.)
> -	 */
> -	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE,
> -				0x80000000 - CFG_SYS_SDRAM_BASE);
> -
> -	return 0;
> -}
> -
> -#define UART_BASE MMAP_UART0
> -int rs_serial_init(int port, int baud)
> -{
> -	uart_t *uart;
> -	u32 counter;
> -
> -	switch (port) {
> -	case 0:
> -		uart = (uart_t *)(MMAP_UART0);
> -		break;
> -	case 1:
> -		uart = (uart_t *)(MMAP_UART1);
> -		break;
> -	case 2:
> -		uart = (uart_t *)(MMAP_UART2);
> -		break;
> -	default:
> -		uart = (uart_t *)(MMAP_UART0);
> -	}
> -
> -	uart_port_conf();
> -
> -	/* write to SICR: SIM2 = uart mode,dcd does not affect rx */
> -	writeb(UART_UCR_RESET_RX, &uart->ucr);
> -	writeb(UART_UCR_RESET_TX, &uart->ucr);
> -	writeb(UART_UCR_RESET_ERROR, &uart->ucr);
> -	writeb(UART_UCR_RESET_MR, &uart->ucr);
> -	__asm__ ("nop");
> -
> -	writeb(0, &uart->uimr);
> -
> -	/* write to CSR: RX/TX baud rate from timers */
> -	writeb(UART_UCSR_RCS_SYS_CLK | UART_UCSR_TCS_SYS_CLK, &uart->ucsr);
> -
> -	writeb(UART_UMR_BC_8 | UART_UMR_PM_NONE, &uart->umr);
> -	writeb(UART_UMR_SB_STOP_BITS_1, &uart->umr);
> -
> -	/* Setting up BaudRate */
> -	counter = (u32) (gd->bus_clk / (baud));
> -	counter >>= 5;
> -
> -	/* write to CTUR: divide counter upper byte */
> -	writeb((u8) ((counter & 0xff00) >> 8), &uart->ubg1);
> -	/* write to CTLR: divide counter lower byte */
> -	writeb((u8) (counter & 0x00ff), &uart->ubg2);
> -
> -	writeb(UART_UCR_RX_ENABLED | UART_UCR_TX_ENABLED, &uart->ucr);
> -
> -	return 0;
> -}
> -
> -void astro_put_char(char ch)
> -{
> -	uart_t *uart;
> -	unsigned long timer;
> -
> -	uart = (uart_t *)(MMAP_UART0);
> -	/*
> -	 * Wait for last character to go. Timeout of 6ms should
> -	 * be enough for our lowest baud rate of 2400.
> -	 */
> -	timer = get_timer(0);
> -	while (get_timer(timer) < 6) {
> -		if (readb(&uart->usr) & UART_USR_TXRDY)
> -			break;
> -	}
> -	writeb(ch, &uart->utb);
> -
> -	return;
> -}
> -
> -int astro_is_char(void)
> -{
> -	uart_t *uart;
> -
> -	uart = (uart_t *)(MMAP_UART0);
> -	return readb(&uart->usr) & UART_USR_RXRDY;
> -}
> -
> -int astro_get_char(void)
> -{
> -	uart_t *uart;
> -
> -	uart = (uart_t *)(MMAP_UART0);
> -	while (!(readb(&uart->usr) & UART_USR_RXRDY)) ;
> -	return readb(&uart->urb);
> -}
> -
> -int misc_init_r(void)
> -{
> -	int retval = 0;
> -
> -	puts("Configure Xilinx FPGA...");
> -	retval = astro5373l_xilinx_load();
> -	if (!retval) {
> -		puts("failed!\n");
> -		return retval;
> -	}
> -	puts("done\n");
> -
> -	puts("Configure Altera FPGA...");
> -	retval = astro5373l_altera_load();
> -	if (!retval) {
> -		puts("failed!\n");
> -		return retval;
> -	}
> -	puts("done\n");
> -
> -	return retval;
> -}
> diff --git a/configs/astro_mcf5373l_defconfig b/configs/astro_mcf5373l_defconfig
> deleted file mode 100644
> index 8dd369d68a12..000000000000
> --- a/configs/astro_mcf5373l_defconfig
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -CONFIG_M68K=y
> -CONFIG_TEXT_BASE=0x00000000
> -CONFIG_SYS_MALLOC_LEN=0x20000
> -CONFIG_ENV_SIZE=0x8000
> -CONFIG_ENV_SECT_SIZE=0x8000
> -CONFIG_DEFAULT_DEVICE_TREE="astro_mcf5373l"
> -CONFIG_SYS_MONITOR_LEN=262144
> -CONFIG_SYS_LOAD_ADDR=0x20000
> -CONFIG_ENV_ADDR=0x1FF8000
> -CONFIG_TARGET_ASTRO_MCF5373L=y
> -CONFIG_SYS_MONITOR_BASE=0x00000400
> -CONFIG_BOOTDELAY=1
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS=" console=ttyS2,115200 rootfstype=romfs loaderversion=$loaderversion"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="protect off 0x80000 0x1ffffff;run env_check;run xilinxload&&run alteraload&&bootm 0x80000;update;reset"
> -CONFIG_SYS_PBSIZE=281
> -# CONFIG_DISPLAY_BOARDINFO is not set
> -CONFIG_MISC_INIT_R=y
> -CONFIG_SYS_MALLOC_BOOTPARAMS=y
> -CONFIG_HUSH_PARSER=y
> -# CONFIG_AUTO_COMPLETE is not set
> -CONFIG_SYS_PROMPT="URMEL > "
> -CONFIG_CMD_IMLS=y
> -CONFIG_CMD_FPGA_LOADMK=y
> -CONFIG_CMD_I2C=y
> -# CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_CACHE=y
> -CONFIG_CMD_JFFS2=y
> -CONFIG_NO_NET=y
> -CONFIG_FPGA_ALTERA=y
> -CONFIG_FPGA_CYCLON2=y
> -CONFIG_FPGA_XILINX=y
> -CONFIG_FPGA_SPARTAN3=y
> -CONFIG_SYS_FPGA_PROG_FEEDBACK=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_FSL=y
> -CONFIG_MTD=y
> -CONFIG_MTD_NOR_FLASH=y
> -CONFIG_FLASH_CFI_DRIVER=y
> -CONFIG_FLASH_SHOW_PROGRESS=0
> -CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> -CONFIG_SYS_FLASH_PROTECTION=y
> -CONFIG_SYS_FLASH_CFI=y
> -CONFIG_SYS_MAX_FLASH_SECT=259
> -CONFIG_DM_RTC=y
> -CONFIG_MCFRTC=y
> -CONFIG_SYS_MCFRTC_BASE=0xFC0A8000
> -CONFIG_MCFUART=y
> -CONFIG_WDT=y
> -CONFIG_WDT_MCF=y
> diff --git a/include/configs/astro_mcf5373l.h b/include/configs/astro_mcf5373l.h
> deleted file mode 100644
> index 65224324fbc2..000000000000
> --- a/include/configs/astro_mcf5373l.h
> +++ /dev/null
> @@ -1,187 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Configuration settings for the Sentec Cobra Board.
> - *
> - * (C) Copyright 2003 Josef Baumgartner <josef.baumgartner@telex.de>
> - */
> -
> -/*
> - * configuration for ASTRO "Urmel" board.
> - * Originating from Cobra5272 configuration, messed up by
> - * Wolfgang Wegner <w.wegner@astro-kom.de>
> - * Please do not bother the original author with bug reports
> - * concerning this file.
> - */
> -
> -#ifndef _CONFIG_ASTRO_MCF5373L_H
> -#define _CONFIG_ASTRO_MCF5373L_H
> -
> -#include <linux/stringify.h>
> -
> -/*
> - * set the card type to actually compile for; either of
> - * the possibilities listed below has to be used!
> - */
> -#define ASTRO_V532	1
> -
> -#if ASTRO_V532
> -#define ASTRO_ID	0xF8
> -#elif ASTRO_V512
> -#define ASTRO_ID	0xFA
> -#elif ASTRO_TWIN7S2
> -#define ASTRO_ID	0xF9
> -#elif ASTRO_V912
> -#define ASTRO_ID	0xFC
> -#elif ASTRO_COFDMDUOS2
> -#define ASTRO_ID	0xFB
> -#else
> -#error No card type defined!
> -#endif
> -
> -/* I2C */
> -
> -/*
> - * Defines processor clock - important for correct timings concerning serial
> - * interface etc.
> - */
> -
> -#define CFG_SYS_CLK			80000000
> -#define CFG_SYS_CPU_CLK		(CFG_SYS_CLK * 3)
> -#define CFG_SYS_SDRAM_SIZE		32		/* SDRAM size in MB */
> -
> -/*
> - * Define baudrate for UART1 (console output, tftp, ...)
> - * default value of CONFIG_BAUDRATE for Sentec board: 19200 baud
> - * CFG_SYS_BAUDRATE_TABLE defines values that can be selected
> - * in u-boot command interface
> - */
> -
> -#define CFG_SYS_UART_PORT		(2)
> -#define CFG_SYS_UART2_ALT3_GPIO
> -
> -/* here we put our FPGA configuration... */
> -
> -/* Define user parameters that have to be customized most likely */
> -
> -/* AUTOBOOT settings - booting images automatically by u-boot after power on */
> -
> -/*
> - * The following settings will be contained in the environment block ; if you
> - * want to use a neutral environment all those settings can be manually set in
> - * u-boot: 'set' command
> - */
> -
> -#define CFG_EXTRA_ENV_SETTINGS			\
> -	"loaderversion=11\0"				\
> -	"card_id="__stringify(ASTRO_ID)"\0"			\
> -	"alterafile=0\0"				\
> -	"xilinxfile=0\0"				\
> -	"xilinxload=imxtract 0x540000 $xilinxfile 0x41000000&&"\
> -		"fpga load 0 0x41000000 $filesize\0" \
> -	"alteraload=imxtract 0x6c0000 $alterafile 0x41000000&&"\
> -		"fpga load 1 0x41000000 $filesize\0" \
> -	"env_default=1\0"				\
> -	"env_check=if test $env_default -eq 1;"\
> -		" then setenv env_default 0;saveenv;fi\0"
> -
> -/*
> - * "update" is a non-standard command that has to be supplied
> - * by external update.c; This is not included in mainline because
> - * it needs non-blocking CFI routines.
> - */
> -
> -#define CFG_SYS_FPGA_WAIT		1000
> -
> -/* End of user parameters to be customized */
> -
> -/* Defines memory range for test */
> -
> -/*
> - * Low Level Configuration Settings
> - * (address mappings, register initial values, etc.)
> - * You should know what you are doing if you make changes here.
> - */
> -
> -/* Base register address */
> -
> -#define CFG_SYS_MBAR		0xFC000000	/* Register Base Addrs */
> -
> -/* System Conf. Reg. & System Protection Reg. */
> -
> -#define CFG_SYS_SCR		0x0003;
> -#define CFG_SYS_SPR		0xffff;
> -
> -/*
> - * Definitions for initial stack pointer and data area (in internal SRAM)
> - */
> -#define CFG_SYS_INIT_RAM_ADDR	0x80000000
> -#define CFG_SYS_INIT_RAM_SIZE		0x8000
> -#define CFG_SYS_INIT_RAM_CTRL	0x221
> -
> -/*
> - * Start addresses for the final memory configuration
> - * (Set up by the startup code)
> - * for MCF5373, the allowable range is 0x40000000 to 0x7FF00000
> - */
> -#define CFG_SYS_SDRAM_BASE		0x40000000
> -
> -/*
> - * Chipselect bank definitions
> - *
> - * CS0 - Flash 32MB (first 16MB)
> - * CS1 - Flash 32MB (second half)
> - * CS2 - FPGA
> - * CS3 - FPGA
> - * CS4 - unused
> - * CS5 - unused
> - */
> -#define CFG_SYS_CS0_BASE		0
> -#define CFG_SYS_CS0_MASK		0x00ff0001
> -#define CFG_SYS_CS0_CTRL		0x00001fc0
> -
> -#define CFG_SYS_CS1_BASE		0x01000000
> -#define CFG_SYS_CS1_MASK		0x00ff0001
> -#define CFG_SYS_CS1_CTRL		0x00001fc0
> -
> -#define CFG_SYS_CS2_BASE		0x20000000
> -#define CFG_SYS_CS2_MASK		0x00ff0001
> -#define CFG_SYS_CS2_CTRL		0x0000fec0
> -
> -#define CFG_SYS_CS3_BASE		0x21000000
> -#define CFG_SYS_CS3_MASK		0x00ff0001
> -#define CFG_SYS_CS3_CTRL		0x0000fec0
> -
> -#define CFG_SYS_FLASH_BASE		0x00000000
> -
> -/* Reserve 256 kB for Monitor */
> -
> -/*
> - * For booting Linux, the board info and command line data
> - * have to be in the first 8 MB of memory, since this is
> - * the maximum mapped by the Linux kernel during initialization ??
> - */
> -#define CFG_SYS_BOOTMAPSZ		(CFG_SYS_SDRAM_BASE + \
> -						(CFG_SYS_SDRAM_SIZE << 20))
> -
> -/* FLASH organization */
> -
> -#define CFG_SYS_FLASH_SIZE		0x2000000
> -
> -#define LDS_BOARD_TEXT \
> -	. = DEFINED(env_offset) ? env_offset : .; \
> -	env/embedded.o(.text*)
> -
> -/* Cache Configuration */
> -
> -#define ICACHE_STATUS			(CFG_SYS_INIT_RAM_ADDR + \
> -					 CFG_SYS_INIT_RAM_SIZE - 8)
> -#define DCACHE_STATUS			(CFG_SYS_INIT_RAM_ADDR + \
> -					 CFG_SYS_INIT_RAM_SIZE - 4)
> -#define CFG_SYS_ICACHE_INV		(CF_CACR_CINVA)
> -#define CFG_SYS_CACHE_ACR0		(CFG_SYS_SDRAM_BASE | \
> -					 CF_ADDRMASK(CFG_SYS_SDRAM_SIZE) | \
> -					 CF_ACR_EN | CF_ACR_SM_ALL)
> -#define CFG_SYS_CACHE_ICACR		(CF_CACR_EC | CF_CACR_CINVA | \
> -					 CF_CACR_DCM_P)
> -
> -#endif	/* _CONFIG_ASTRO_MCF5373L_H */
