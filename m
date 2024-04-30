Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2261BC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A471885A4;
	Tue, 30 Apr 2024 15:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XOqHupp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E36D08824A; Tue, 30 Apr 2024 15:36:06 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9504E8824A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6eb8ea5ac95so3433240a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484163; x=1715088963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6jFUKq3f7KH2tplJyy2uRjjP50APNad7TIAGVaB6ef4=;
 b=XOqHupp2yGzWM3rLDVCWaHS6+b3qC9yGtlSwRxo+RVxquUbrcYgUZ3/VOBk/w7B1K0
 kxNrLjy9EZG6SDbm44bgqmzCDVZSiwMAsIlTDzHtgDAUMI8fAr1yrMcRhpCBAgqrqGGW
 +Uqg9b8p18LnYFx2LxePQUb0bb8Vu2fjekkCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484163; x=1715088963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jFUKq3f7KH2tplJyy2uRjjP50APNad7TIAGVaB6ef4=;
 b=P+AphN2nm1SEqqutnwFsMZFJkDGDE7/r2ufQZNYvEccFVodTxYqYApw6STq9bnX1cD
 xvsrW2dtSInYbaI7MB8muRNqXbX3Z0VbJfajn2UrDh7rR4vjS8vh52JJaWrVgAxB1aTE
 VIE//zrLCyqzIiEutDLhUH+r2Fy2YetV8oqsMaTRZXyViLdntq+1eiLkY7czDJRq+1sT
 GRinhUSmC430E4bm4Eh434uhkO+QlguOm/okQGEyAbcNLV72IFJglIOmOOPRMcNGecyh
 9xK3c34+DXPRkobjfWKUhlBzoMVQz/AU9xzBSPH4o75jmrkJ8SV+Kyxv1itl7APnbvbK
 CmtA==
X-Gm-Message-State: AOJu0Yx4unaC9Op3mkCq2QQCRodva33SUYy/A1rRXQk2Dzk7XJj+DP5U
 Xwcc3V25IZWz8UIfCXnqXAwsFCGyx4BsU4rRHOKKKHIEseqlMR/plVfTBKEF6qoTO0UC+xdg+xQ
 e4FP5DQ==
X-Google-Smtp-Source: AGHT+IFU70SbdN8Zy5qC42BRHy8O/gXLV7fcwtmsy9ph8ZKa2MuBZRAgxTldpdbGzFtofVeCAqFskw==
X-Received: by 2002:a05:6830:12d8:b0:6ee:32ab:8124 with SMTP id
 a24-20020a05683012d800b006ee32ab8124mr2831233otq.25.1714484162713; 
 Tue, 30 Apr 2024 06:36:02 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 01/33] arm: mach-versatile: Remove dead code
Date: Tue, 30 Apr 2024 07:35:27 -0600
Message-Id: <20240430133559.1836389-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This platform is no longer supported in tree, remove.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-versatile/Makefile |  7 ----
 arch/arm/mach-versatile/reset.S  | 28 ---------------
 arch/arm/mach-versatile/timer.c  | 62 --------------------------------
 3 files changed, 97 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/Makefile
 delete mode 100644 arch/arm/mach-versatile/reset.S
 delete mode 100644 arch/arm/mach-versatile/timer.c

diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
deleted file mode 100644
index 858ca9414c05..000000000000
--- a/arch/arm/mach-versatile/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2000-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-
-obj-y	= timer.o
-obj-y	+= reset.o
diff --git a/arch/arm/mach-versatile/reset.S b/arch/arm/mach-versatile/reset.S
deleted file mode 100644
index c7f1225fb298..000000000000
--- a/arch/arm/mach-versatile/reset.S
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  armboot - Startup Code for ARM926EJS CPU-core
- *
- *  Copyright (c) 2003  Texas Instruments
- *
- *  ----- Adapted for OMAP1610 OMAP730 from ARM925t code ------
- *
- *  Copyright (c) 2001	Marius Gröger <mag@sysgo.de>
- *  Copyright (c) 2002	Alex Züpke <azu@sysgo.de>
- *  Copyright (c) 2002	Gary Jennejohn <garyj@denx.de>
- *  Copyright (c) 2003	Richard Woodruff <r-woodruff2@ti.com>
- *  Copyright (c) 2003	Kshitij <kshitij@ti.com>
- */
-
-	.align	5
-.globl reset_cpu
-reset_cpu:
-	ldr	r1, rstctl1	/* get clkm1 reset ctl */
-	mov	r3, #0x0
-	strh	r3, [r1]	/* clear it */
-	mov	r3, #0x8
-	strh	r3, [r1]	/* force dsp+arm reset */
-_loop_forever:
-	b	_loop_forever
-
-rstctl1:
-	.word	0xfffece10
diff --git a/arch/arm/mach-versatile/timer.c b/arch/arm/mach-versatile/timer.c
deleted file mode 100644
index b471412186d1..000000000000
--- a/arch/arm/mach-versatile/timer.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2003
- * Texas Instruments <www.ti.com>
- *
- * (C) Copyright 2002
- * Sysgo Real-Time Solutions, GmbH <www.elinos.com>
- * Marius Groeger <mgroeger@sysgo.de>
- *
- * (C) Copyright 2002
- * Sysgo Real-Time Solutions, GmbH <www.elinos.com>
- * Alex Zuepke <azu@sysgo.de>
- *
- * (C) Copyright 2002-2004
- * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
- *
- * (C) Copyright 2004
- * Philippe Robin, ARM Ltd. <philippe.robin@arm.com>
- */
-
-#include <common.h>
-
-#define TIMER_ENABLE	(1 << 7)
-#define TIMER_MODE_MSK	(1 << 6)
-#define TIMER_MODE_FR	(0 << 6)
-#define TIMER_MODE_PD	(1 << 6)
-
-#define TIMER_INT_EN	(1 << 5)
-#define TIMER_PRS_MSK	(3 << 2)
-#define TIMER_PRS_8S	(1 << 3)
-#define TIMER_SIZE_MSK	(1 << 2)
-#define TIMER_ONE_SHT	(1 << 0)
-
-int timer_init (void)
-{
-	ulong	tmr_ctrl_val;
-
-	/* 1st disable the Timer */
-	tmr_ctrl_val = *(volatile ulong *)(CFG_SYS_TIMERBASE + 8);
-	tmr_ctrl_val &= ~TIMER_ENABLE;
-	*(volatile ulong *)(CFG_SYS_TIMERBASE + 8) = tmr_ctrl_val;
-
-	/*
-	 * The Timer Control Register has one Undefined/Shouldn't Use Bit
-	 * So we should do read/modify/write Operation
-	 */
-
-	/*
-	 * Timer Mode : Free Running
-	 * Interrupt : Disabled
-	 * Prescale : 8 Stage, Clk/256
-	 * Tmr Siz : 16 Bit Counter
-	 * Tmr in Wrapping Mode
-	 */
-	tmr_ctrl_val = *(volatile ulong *)(CFG_SYS_TIMERBASE + 8);
-	tmr_ctrl_val &= ~(TIMER_MODE_MSK | TIMER_INT_EN | TIMER_PRS_MSK | TIMER_SIZE_MSK | TIMER_ONE_SHT );
-	tmr_ctrl_val |= (TIMER_ENABLE | TIMER_PRS_8S);
-
-	*(volatile ulong *)(CFG_SYS_TIMERBASE + 8) = tmr_ctrl_val;
-
-	return 0;
-}
-- 
2.34.1

