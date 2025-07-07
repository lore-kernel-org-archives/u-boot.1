Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97170C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189B1831AC;
	Mon,  7 Jul 2025 17:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="H/r761WP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EIk8/HVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F24830E4; Mon,  7 Jul 2025 17:52:22 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3948830E4
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bbTJh4nRkz9sTb;
 Mon,  7 Jul 2025 17:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDfqdba5uG70qYwMta8qb04xO3oyG25ctGGDld2YbAs=;
 b=H/r761WPPMaxNF+nIjJHuY1xG3ra1XcGCYxX8Cup2RfWeLYmCCFkgCEpzktsX48EQGGNeW
 vquKar0YWiluel7g0NxJ9ZEwsJo26d6IPjG8q0u/1XdLbsaDRwPqUKA/zX3ANRKqHororV
 Aftu9L6o9uZPb3qk7VkUWJQegFm9NGzJ4rHlYRnL1oW8s4/G4fLGUIpVxydpR8oyq9888r
 QtZHVzICagZA0eKF/js0lz+ZBrpteC0TRkiJFgtRgxxvePHOCF193JHz7K7uMgw1FSZMs2
 GjnoB57sBF4W8uj2S/HPx/RJrWHiLmP3/kpYsQqkjv8s6849xOKS9jV7Le/0Jw==
Message-ID: <977f8136-8eb6-4bdb-b43f-269260bf9061@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDfqdba5uG70qYwMta8qb04xO3oyG25ctGGDld2YbAs=;
 b=EIk8/HVsUOdc4jS97WymjIxnKfPDf9HbHVp8DoTds49S/9AduZOT6XpMkYXzIrzO13/Po1
 lf782UwDbkA1fqVQTBHdGJ8dkeFlF+M06tuJ6R6vGq9PY5evftCKZvZgvx7GsANo3spr/N
 /G5nnS4qqod47NnyRuuW7ZwmOQoAz+VY+5zjRBqYAIuINmS5YVsgSJekPKB4m6uKpqyIDj
 C8pU/6vp77o3D4so8cqLF8w005JhHR1NFTRKXLSTK1DxFM1BRC6tYHSkCXZ7FxwkcyQpkJ
 jqfNk9GPi8kogbT7Z2D1gcBoGfDCA+OllWNSKvwDKz6Rb7OMDfjJZP5716m1DA==
Date: Mon, 7 Jul 2025 17:42:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/9] ARM: renesas: Add RZ/A2 support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, Chris.Brandt@renesas.com,
 geert+renesas@glider.be
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
 <175180133910.86839.13058093142062106846.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175180133910.86839.13058093142062106846.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 886cc5968933ca9cb3e
X-MBO-RS-META: r86khu3j99aw3skz7ehp3erzdawro5wd
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

On 7/6/25 1:28 PM, Magnus Damm wrote:

[...]

> +++ work/board/renesas/common/rza2-lowlevel_init.S	2025-07-06 18:40:28.930399371 +0900
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2018 Renesas Electronics Corporation
> + * Copyright (C) 2018 Chris Brandt
> + */
> +#include <config.h>
> +#include <asm/macro.h>
> +
> +.macro  dummy_read32, addr
> +	ldr     r4, =\addr
> +	ldr     r5, [r4]
> +.endm
> +
> +.macro  dummy_read8, addr
> +	ldr     r4, =\addr
> +	ldrb    r6, [r4]
> +.endm
> +
> +#define RZA2_WDT_BASE	0xFCFE7000
> +#define RZA2_STBCR_BASE	0xFCFE0020
> +
> +/* Watchdog Registers */
> +#define WTCSR		(RZA2_WDT_BASE + 0x00) /* Watchdog Timer Control Register */
> +#define WTCNT		(RZA2_WDT_BASE + 0x02) /* Watchdog Timer Counter Register */
> +#define WRCSR		(RZA2_WDT_BASE + 0x04) /* Watchdog Reset Control Register */
> +
> +/* Disable WDT */
> +#define WTCSR_D		0xA518
> +#define WTCNT_D		0x5A00
> +
> +/* PL310 L2 Cache */
> +#define PL310_BASE	0x1F003000
> +#define REG15_PWR_CTRL	0xf80
> +
> +/* Clock Registers */
> +#define FRQCR		0xFCFE0010
> +#define CKIOSEL		0xFCFE0100
> +
> +#define FRQCR_D		0x1012
> +#define CKIOSEL_D	0x0000 /* CKIO Output = B Clock  */
> +
> +/* Standby controller registers */
> +#define STBCR1		(RZA2_STBCR_BASE + 0x000)
> +#define STBCR2		(RZA2_STBCR_BASE + 0x004)
> +#define STBCR3		(RZA2_STBCR_BASE + 0x400)
> +#define STBCR4		(RZA2_STBCR_BASE + 0x404)
> +#define STBCR5		(RZA2_STBCR_BASE + 0x408)
> +#define STBCR6		(RZA2_STBCR_BASE + 0x40c)
> +#define STBCR7		(RZA2_STBCR_BASE + 0x410)
> +#define STBCR8		(RZA2_STBCR_BASE + 0x414)
> +#define STBCR9		(RZA2_STBCR_BASE + 0x418)
> +#define STBCR10		(RZA2_STBCR_BASE + 0x41c)
> +#define STBCR11		(RZA2_STBCR_BASE + 0x420)
> +#define STBCR12		(RZA2_STBCR_BASE + 0x424)
> +#define STBCR13		(RZA2_STBCR_BASE + 0x450)
> +
> +/* Enable all peripheral clocks */
> +#define STBCR2_D        0x6A
> +#define STBCR3_D        0x80 /* OSTM0, OSTM1, OSTM3, MTU3, CAN-FD, ADC, GPT */
> +#define STBCR4_D        0x00 /* SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCI0, SCI1,IrDA */
> +#define STBCR5_D        0x31 /* A/D, CEU, RTC0, RTC1, JCU */
> +#define STBCR6_D        0x80 /* VIN, ETHER0, ETHER1, EtherPTR, EtherM, USB0, USB1 */
> +#define STBCR7_D        0x10 /* IMR-LS2, DAVE-2D, MIPI, SSIF0, SSIF1, SSIF2, SSIF3 */
> +#define STBCR8_D        0x05 /* IIC0, IIC1, IIC2, IIC3, SPIBSC, VDC6 */
> +#define STBCR9_D        0x10 /* RSPI0, RSPI1, RSPI2, HYPER, OCTA, SPDIF, DRP */
> +#define STBCR10_D       0x00 /* TSIP, SDHI00, SDHI01, SDHI10, SDHI11 */
> +#define STBCR11_D       0x3F /* POE3, POEG */
> +
> +#define SYSCR1		0xFCFE0400 /* System control register 1 */
> +#define SYSCR2		0xFCFE0404 /* System control register 2 */
> +#define SYSCR3		0xFCFE0408 /* System control register 3 */
> +
> +	.global	lowlevel_init
> +
> +	.text
> +	.align	2
> +
> +lowlevel_init:
> +	/* PL310 init: Power Control Register */
> +	write32 (PL310_BASE + REG15_PWR_CTRL), 1   /* Standby mode enable */
> +	dummy_read32 (PL310_BASE + REG15_PWR_CTRL) /* dummy read */
> +
> +	/* Set clocks */
> +	write16 FRQCR, FRQCR_D
> +	write16 CKIOSEL, CKIOSEL_D
> +
> +	/* Enable all peripherals (Standby Control) */
> +	write8 STBCR3, STBCR3_D
> +	dummy_read8 STBCR3
> +	write8 STBCR4, STBCR4_D
> +	dummy_read8 STBCR4
> +	write8 STBCR5, STBCR5_D
> +	dummy_read8 STBCR5
> +	write8 STBCR6, STBCR6_D
> +	dummy_read8 STBCR6
> +	write8 STBCR7, STBCR7_D
> +	dummy_read8 STBCR7
> +	write8 STBCR8, STBCR8_D
> +	dummy_read8 STBCR8
> +	write8 STBCR9, STBCR9_D
> +	dummy_read8 STBCR9
> +	write8 STBCR10, STBCR10_D
> +	dummy_read8 STBCR10
> +	write8 STBCR11, STBCR11_D
> +	dummy_read8 STBCR11
> +
> +	b part2
> +
> +	.pool
> +	.align 4
> +part2:
> +	/* Disable WDT */
> +	write16 WTCSR, WTCSR_D
> +	write16 WTCNT, WTCNT_D
> +
> +	/* For serial booting, enable read ahead caching to speed things up */
> +#define DRCR  0x1F80000C
> +	write32 DRCR, 0x00010300        /* Read Burst ON, Length=2, Flush cache */
> +
> +	/* Enable all internal RAM */
> +	write8 SYSCR1, 0xFF
> +	write8 SYSCR2, 0xFF
> +	write8 SYSCR3, 0x0F
> +	dummy_read8 SYSCR3
Can any of this be converted into s_init() (early init) C code ?

-- 
Best regards,
Marek Vasut
