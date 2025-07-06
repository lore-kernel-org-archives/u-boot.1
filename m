Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC7C83F03
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9ED83018;
	Mon,  7 Jul 2025 00:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5FD82F00; Sun,  6 Jul 2025 13:29:06 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9DE81D6A
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6fafd3cc8f9so45834676d6.3
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801342; x=1752406142;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5hKOnKl8AGKhc5xA/jLCrsejvguBPRqm1JI8X88FT0=;
 b=k9fa1A2/MusPaFe10gxg4uaq42JHp+6luS+XmGuEoFRQXUeM0kYEwJj2h5iw+uF1R6
 pefyx7joN7WJz684brk9SgrIyiB5QCLeRIY7eOgt0I64QT+xzRHmmcM4T9TqYs7FZMsr
 lK4pmMPYIgqjBn5vgPZs5m2XLMkNpbaqqSerEguFMV2lRBgf9WeSCJ2mJH7SmGcO7vq0
 TMgXwJ9xWTIX6IfI5kz/5bDTkGvvgcpdtGkhw9glg9bZR6mMxGPENE0EDP8L/iPEIecN
 22RTV2uvDHe+sCBsL96AfHDijvoZu/ZiAhRQVGZ6rb4rVM96R7U6OvBGG9glTEosZSui
 obOQ==
X-Gm-Message-State: AOJu0Yx/+J+VneZGr51RvZw/PmYxRjrYPLogUN6uwYwskHhWj9ixEPEC
 tnJiNlXYRpLoS2ZJ7Ly5DBg1NNy8zzOmafdaBiycr09qhAUKTwbjfkMLbJSMvX9m
X-Gm-Gg: ASbGncv8t/uZyX2LIbKtYrutkObdFP0WMs68ymxHO7NQqP5jkYwkuJPYVPYgNViTtx1
 f/zkZdZfx62wH8WmS9qWPFRZepg3QuK//sU/xh2sctqzQJT61twKys4B+Bp1akTb0YfkrPoNNbt
 pEWCR9rV4fYelyfYqC/OBflzDlFeprgFzNYpPLSw7GBDZTXVjLQdtKRxfYoGBMXf8P1pz34MAeP
 6Sg1xm117GjeKd9u1tnrzvXp/i0o/6YFJaJD/QdQMVks2uSu9OA9E5A+Mce08y+r7sIfAYzH6A/
 e7OUrnVnBBBIiYMOS5pOB1x7gMUQYOC8FpvYSaRHsnes20Ej6pSPf/HvEPlpnGVUcgRHC5ceZAI
 yWETvoBA=
X-Google-Smtp-Source: AGHT+IHG+VvmYlf6cDErXlTzXEF67ymma/HbxObZmADgctXkWGphqwpYp0ipnT0N+A/mLbP8NaNYEA==
X-Received: by 2002:a05:6214:5016:b0:6fb:5249:59fe with SMTP id
 6a1803df08f44-702c6cdff96mr121476356d6.2.1751801341730; 
 Sun, 06 Jul 2025 04:29:01 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d5ac60sm42982196d6.97.2025.07.06.04.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:29:01 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, marek.vasut+renesas@mailbox.org,
 Chris.Brandt@renesas.com, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:28:59 +0200
Message-Id: <175180133910.86839.13058093142062106846.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 3/9] ARM: renesas: Add RZ/A2 support
X-Mailman-Approved-At: Mon, 07 Jul 2025 00:18:49 +0200
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

From: Magnus Damm <damm@opensource.se>

Add bare minimal RZ/A2M SoC support including a shared defconfig

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since v2:
 - new patch

 arch/arm/mach-renesas/Kconfig             |    5 +
 arch/arm/mach-renesas/Kconfig.rza2        |    7 +
 board/renesas/common/Makefile             |    8 +
 board/renesas/common/rza2-common.c        |   28 ++++++
 board/renesas/common/rza2-lowlevel_init.S |  130 +++++++++++++++++++++++++++++
 configs/renesas_rza2.config               |   53 +++++++++++
 6 files changed, 231 insertions(+)
 
--- 0001/arch/arm/mach-renesas/Kconfig
+++ work/arch/arm/mach-renesas/Kconfig	2025-07-06 17:59:05.492000849 +0900
@@ -50,6 +50,10 @@ config RZA1
 	prompt "Renesas ARM SoCs RZ/A1 (32bit)"
 	select CPU_V7A
 
+config RZA2
+	prompt "Renesas ARM SoCs RZ/A2 (32bit)"
+	select CPU_V7A
+
 config RZN1
 	prompt "Renesas ARM SoCs RZ/N1 (32bit)"
 	select CPU_V7A
@@ -96,6 +100,7 @@ config SYS_SOC
 source "arch/arm/mach-renesas/Kconfig.32"
 source "arch/arm/mach-renesas/Kconfig.64"
 source "arch/arm/mach-renesas/Kconfig.rza1"
+source "arch/arm/mach-renesas/Kconfig.rza2"
 source "arch/arm/mach-renesas/Kconfig.rzn1"
 source "arch/arm/mach-renesas/Kconfig.rzg2l"
 
--- /dev/null
+++ work/arch/arm/mach-renesas/Kconfig.rza2	2025-07-06 17:59:06.514006807 +0900
@@ -0,0 +1,7 @@
+if RZA2
+
+config CPU_RZA2
+	bool
+	default y
+
+endif
--- 0013/board/renesas/common/Makefile
+++ work/board/renesas/common/Makefile	2025-07-06 17:59:05.493000855 +0900
@@ -6,6 +6,7 @@
 
 # R-Car SoCs
 ifndef CONFIG_RZA1
+ifndef CONFIG_RZA2
 ifndef CONFIG_RZG2L
 
 # 32 bit SoCs
@@ -47,9 +48,16 @@ endif
 
 endif
 endif
+endif
 
 # RZ/A1 SoCs
 ifdef CONFIG_RZA1
 obj-y	+= rza1-common.o
 obj-y	+= rza1-lowlevel_init.o
 endif
+
+# RZ/A2 SoCs
+ifdef CONFIG_RZA2
+obj-y	+= rza2-common.o
+obj-y	+= rza2-lowlevel_init.o
+endif
--- /dev/null
+++ work/board/renesas/common/rza2-common.c	2025-07-06 17:59:56.673299299 +0900
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Renesas Electronics
+ * Copyright (C) Chris Brandt
+ */
+
+#include <init.h>
+#include <asm/io.h>
+
+#define RZA2_WDT_BASE	0xFCFE7000
+#define WTCSR		(RZA2_WDT_BASE + 0x00) /* Watchdog Timer Control Register */
+#define WTCNT		(RZA2_WDT_BASE + 0x02) /* Watchdog Timer Counter Register */
+#define WRCSR		(RZA2_WDT_BASE + 0x04) /* Watchdog Reset Control Register */
+
+void __weak reset_cpu(void)
+{
+	/* Dummy read (must read WRCSR:WOVF at least once before clearing) */
+	writeb(readb(WRCSR), WRCSR);
+
+	writew(0xa500, WRCSR); /* Clear WOVF */
+	writew(0x5a5f, WRCSR); /* Reset Enable */
+	writew(0x5a00, WTCNT); /* Counter to 00 */
+	writew(0xa578, WTCSR); /* Start timer */
+
+	/* Wait for WDT overflow */
+	for (;;)
+		asm volatile("wfi");
+}
--- /dev/null
+++ work/board/renesas/common/rza2-lowlevel_init.S	2025-07-06 18:40:28.930399371 +0900
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 Renesas Electronics Corporation
+ * Copyright (C) 2018 Chris Brandt
+ */
+#include <config.h>
+#include <asm/macro.h>
+
+.macro  dummy_read32, addr
+	ldr     r4, =\addr
+	ldr     r5, [r4]
+.endm
+
+.macro  dummy_read8, addr
+	ldr     r4, =\addr
+	ldrb    r6, [r4]
+.endm
+
+#define RZA2_WDT_BASE	0xFCFE7000
+#define RZA2_STBCR_BASE	0xFCFE0020
+
+/* Watchdog Registers */
+#define WTCSR		(RZA2_WDT_BASE + 0x00) /* Watchdog Timer Control Register */
+#define WTCNT		(RZA2_WDT_BASE + 0x02) /* Watchdog Timer Counter Register */
+#define WRCSR		(RZA2_WDT_BASE + 0x04) /* Watchdog Reset Control Register */
+
+/* Disable WDT */
+#define WTCSR_D		0xA518
+#define WTCNT_D		0x5A00
+
+/* PL310 L2 Cache */
+#define PL310_BASE	0x1F003000
+#define REG15_PWR_CTRL	0xf80
+
+/* Clock Registers */
+#define FRQCR		0xFCFE0010
+#define CKIOSEL		0xFCFE0100
+
+#define FRQCR_D		0x1012
+#define CKIOSEL_D	0x0000 /* CKIO Output = B Clock  */
+
+/* Standby controller registers */
+#define STBCR1		(RZA2_STBCR_BASE + 0x000)
+#define STBCR2		(RZA2_STBCR_BASE + 0x004)
+#define STBCR3		(RZA2_STBCR_BASE + 0x400)
+#define STBCR4		(RZA2_STBCR_BASE + 0x404)
+#define STBCR5		(RZA2_STBCR_BASE + 0x408)
+#define STBCR6		(RZA2_STBCR_BASE + 0x40c)
+#define STBCR7		(RZA2_STBCR_BASE + 0x410)
+#define STBCR8		(RZA2_STBCR_BASE + 0x414)
+#define STBCR9		(RZA2_STBCR_BASE + 0x418)
+#define STBCR10		(RZA2_STBCR_BASE + 0x41c)
+#define STBCR11		(RZA2_STBCR_BASE + 0x420)
+#define STBCR12		(RZA2_STBCR_BASE + 0x424)
+#define STBCR13		(RZA2_STBCR_BASE + 0x450)
+
+/* Enable all peripheral clocks */
+#define STBCR2_D        0x6A
+#define STBCR3_D        0x80 /* OSTM0, OSTM1, OSTM3, MTU3, CAN-FD, ADC, GPT */
+#define STBCR4_D        0x00 /* SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCI0, SCI1,IrDA */
+#define STBCR5_D        0x31 /* A/D, CEU, RTC0, RTC1, JCU */
+#define STBCR6_D        0x80 /* VIN, ETHER0, ETHER1, EtherPTR, EtherM, USB0, USB1 */
+#define STBCR7_D        0x10 /* IMR-LS2, DAVE-2D, MIPI, SSIF0, SSIF1, SSIF2, SSIF3 */
+#define STBCR8_D        0x05 /* IIC0, IIC1, IIC2, IIC3, SPIBSC, VDC6 */
+#define STBCR9_D        0x10 /* RSPI0, RSPI1, RSPI2, HYPER, OCTA, SPDIF, DRP */
+#define STBCR10_D       0x00 /* TSIP, SDHI00, SDHI01, SDHI10, SDHI11 */
+#define STBCR11_D       0x3F /* POE3, POEG */
+
+#define SYSCR1		0xFCFE0400 /* System control register 1 */
+#define SYSCR2		0xFCFE0404 /* System control register 2 */
+#define SYSCR3		0xFCFE0408 /* System control register 3 */
+
+	.global	lowlevel_init
+
+	.text
+	.align	2
+
+lowlevel_init:
+	/* PL310 init: Power Control Register */
+	write32 (PL310_BASE + REG15_PWR_CTRL), 1   /* Standby mode enable */
+	dummy_read32 (PL310_BASE + REG15_PWR_CTRL) /* dummy read */
+
+	/* Set clocks */
+	write16 FRQCR, FRQCR_D
+	write16 CKIOSEL, CKIOSEL_D
+
+	/* Enable all peripherals (Standby Control) */
+	write8 STBCR3, STBCR3_D
+	dummy_read8 STBCR3
+	write8 STBCR4, STBCR4_D
+	dummy_read8 STBCR4
+	write8 STBCR5, STBCR5_D
+	dummy_read8 STBCR5
+	write8 STBCR6, STBCR6_D
+	dummy_read8 STBCR6
+	write8 STBCR7, STBCR7_D
+	dummy_read8 STBCR7
+	write8 STBCR8, STBCR8_D
+	dummy_read8 STBCR8
+	write8 STBCR9, STBCR9_D
+	dummy_read8 STBCR9
+	write8 STBCR10, STBCR10_D
+	dummy_read8 STBCR10
+	write8 STBCR11, STBCR11_D
+	dummy_read8 STBCR11
+
+	b part2
+
+	.pool
+	.align 4
+part2:
+	/* Disable WDT */
+	write16 WTCSR, WTCSR_D
+	write16 WTCNT, WTCNT_D
+
+	/* For serial booting, enable read ahead caching to speed things up */
+#define DRCR  0x1F80000C
+	write32 DRCR, 0x00010300        /* Read Burst ON, Length=2, Flush cache */
+
+	/* Enable all internal RAM */
+	write8 SYSCR1, 0xFF
+	write8 SYSCR2, 0xFF
+	write8 SYSCR3, 0x0F
+	dummy_read8 SYSCR3
+
+	nop
+	/* back to arch calling code */
+	mov	pc, lr
+
+	.align 4
--- /dev/null
+++ work/configs/renesas_rza2.config	2025-07-06 17:59:06.544006983 +0900
@@ -0,0 +1,53 @@
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x400
+# CONFIG_BOARD_EARLY_INIT_F is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_EFI_LOADER is not set
+# CONFIG_MMC is not set
+CONFIG_BITBANGMII=y
+CONFIG_BOOTARGS="ignore_loglevel"
+CONFIG_BOOTDELAY=3
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_USB=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
+CONFIG_DM_ETH_PHY=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_SPI=y
+CONFIG_ENV_OFFSET=0x80000
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_HUSH_PARSER=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MAC_PARTITION=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_CONTROL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_PHY_SMSC=y
+CONFIG_PINCTRL=y
+CONFIG_RENESAS_OSTM_TIMER=y
+CONFIG_RENESAS_RPC_SPI=y
+CONFIG_RZA2=y
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SH_ETHER=y
+CONFIG_SPI=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_CLK_FREQ=66666666
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SYS_PBSIZE=256
+CONFIG_TIMER=y
+CONFIG_USE_BOOTARGS=y
