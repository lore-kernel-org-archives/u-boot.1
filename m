Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E87C83F07
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579C782F8F;
	Mon,  7 Jul 2025 00:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291C781D6A; Sun,  6 Jul 2025 13:28:50 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0CB981D6A
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fafd3cc8f9so45832806d6.3
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801326; x=1752406126;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YaWxM3iby/QH0XOkA1zP2vtmaT0H51E7Sps5uU71v/4=;
 b=Ty+NcyMcqDzMEqL1xxjmf7okR1i+voTQQ0OlIgwoGaTGdgTVf33ivqZbMLIXwTcZty
 Uft5o0LhNTSikhdV3S3vyOsu0gfkc/80duqIupJzOtKd0CMlRd2qiWTl0E+AU4j1C8it
 +M1o7mn5OYs1DFz33yydBvKNWi1IneAnNIP8VFl3IVfCgV8yk/bzjVRFf2p0KRI2ObOr
 QBTK87nOYQlMDQe230muMUtkWGhgfz8qzcbD8r/GuX8j5KTSL6MqRy+QHzsDmtvTPBSL
 VdY8PmsxUh6DB6XYIvBDougwEUzyHwPjzY4BsGDYJN6tvRovclbqfPwrTQ3HO/uF4tj4
 8iKQ==
X-Gm-Message-State: AOJu0Ywo/bXr0R82qcLyfVFHc9ZopBtvLzE5N5rfF/LD1YoPmx0CjMso
 mw3fTKFwV3LWKHodx7X5/iAg66pyr5L2TWoUNZCXalPWrWszHuvkMQ6TeUm5F96G
X-Gm-Gg: ASbGncuaSARTC/TLcmQvXvi3ayB7cxXVPcU8D8EGqM8DpifjxYKUAksCmCCdaGxUILK
 HCeexpM8uHeUvSLM1EaT0jEyRRLG4+JKV05C7FVK62Rn0UwXBMelo0hVz7ZIHQDahTafzMi21j9
 qtVfTCFa3Pf1JihipcajaOEnEMHJn0h2Jk4oao5CsnflvzuHmxrnhcwoGNBGQI4n3bjfAbnob8q
 jp094F9YbvYfukO8aQJpLFJv5zLkohN0L4YHGQwob0ruqTr35Ge2/R3hzbGkEkOOtvVrXZQOqjc
 1l53vMmjy3OEr8TZueU8mW2TpoGFYq6EE5Eh9AXQb+HKolviFY9F8S5wD7FrsbqaEMdtg7T5ZII
 O7lfljOA=
X-Google-Smtp-Source: AGHT+IH9WqshQIT+/gju1+XVnM3du95Te4c1jlxpW0p8MFRAp6pU+v5IIkKATJqr66OYEHz5x9CJjg==
X-Received: by 2002:a05:6214:2405:b0:703:98ef:8a71 with SMTP id
 6a1803df08f44-70398ef8a73mr3332476d6.0.1751801326269; 
 Sun, 06 Jul 2025 04:28:46 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccd6a1sm42703436d6.39.2025.07.06.04.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:28:45 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 Magnus Damm <damm@opensource.se>, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:28:43 +0200
Message-Id: <175180132368.86839.14736148757234075249.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 1/9] ARM: renesas: Put common RZ/A1 code in
 board/renesas/common
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

Break out SoC specific code from the GR-Peach board and put it into the
board/renesas/common directory so it can be easily shared between the
GR-Peach and Genmai boards.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes from v2:
 - None

 Changes since v1:
 - Include fixup changes from Marek, thank you.
 - Rebase on top of u-boot next and patches from Marek.

 board/renesas/common/Makefile             |    8 ++
 board/renesas/common/rza1-common.c        |   27 +++++++
 board/renesas/common/rza1-lowlevel_init.S |  106 +++++++++++++++++++++++++++++
 board/renesas/grpeach/Makefile            |    1 
 board/renesas/grpeach/grpeach.c           |   22 ------
 board/renesas/grpeach/lowlevel_init.S     |  106 -----------------------------
 6 files changed, 141 insertions(+), 129 deletions(-) 

--- 0001/board/renesas/common/Makefile
+++ work/board/renesas/common/Makefile	2025-07-02 21:57:30.700079872 +0900
@@ -5,6 +5,7 @@
 #
 
 # R-Car SoCs
+ifndef CONFIG_RZA1
 ifndef CONFIG_RZG2L
 
 # 32 bit SoCs
@@ -45,3 +46,10 @@ endif
 endif
 
 endif
+endif
+
+# RZ/A1 SoCs
+ifdef CONFIG_RZA1
+obj-y	+= rza1-common.o
+obj-y	+= rza1-lowlevel_init.o
+endif
--- /dev/null
+++ work/board/renesas/common/rza1-common.c	2025-07-02 21:51:15.045933926 +0900
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Renesas Electronics
+ * Copyright (C) Chris Brandt
+ */
+
+#include <init.h>
+#include <asm/io.h>
+
+#define RZA1_WDT_BASE	0xfcfe0000
+#define WTCSR		0x00
+#define WTCNT		0x02
+#define WRCSR		0x04
+
+void __weak reset_cpu(void)
+{
+	/* Dummy read (must read WRCSR:WOVF at least once before clearing) */
+	readb(RZA1_WDT_BASE + WRCSR);
+
+	writew(0xa500, RZA1_WDT_BASE + WRCSR);
+	writew(0x5a5f, RZA1_WDT_BASE + WRCSR);
+	writew(0x5a00, RZA1_WDT_BASE + WTCNT);
+	writew(0xa578, RZA1_WDT_BASE + WTCSR);
+
+	for (;;)
+		asm volatile("wfi");
+}
--- /dev/null
+++ work/board/renesas/common/rza1-lowlevel_init.S	2025-07-02 21:51:15.054933975 +0900
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2017 Renesas Electronics
+ * Copyright (C) 2017 Chris Brandt
+ */
+#include <config.h>
+#include <asm/macro.h>
+
+/* Watchdog Registers */
+#define RZA1_WDT_BASE	0xFCFE0000
+#define WTCSR	(RZA1_WDT_BASE + 0x00) /* Watchdog Timer Control Register */
+#define WTCNT	(RZA1_WDT_BASE + 0x02) /* Watchdog Timer Counter Register */
+#define WRCSR	(RZA1_WDT_BASE + 0x04) /* Watchdog Reset Control Register */
+
+/* Standby controller registers (chapter 55) */
+#define RZA1_STBCR_BASE	0xFCFE0020
+#define STBCR1	(RZA1_STBCR_BASE + 0x00)
+#define STBCR2	(RZA1_STBCR_BASE + 0x04)
+#define STBCR3	(RZA1_STBCR_BASE + 0x400)
+#define STBCR4	(RZA1_STBCR_BASE + 0x404)
+#define STBCR5	(RZA1_STBCR_BASE + 0x408)
+#define STBCR6	(RZA1_STBCR_BASE + 0x40c)
+#define STBCR7	(RZA1_STBCR_BASE + 0x410)
+#define STBCR8	(RZA1_STBCR_BASE + 0x414)
+#define STBCR9	(RZA1_STBCR_BASE + 0x418)
+#define STBCR10	(RZA1_STBCR_BASE + 0x41c)
+#define STBCR11	(RZA1_STBCR_BASE + 0x420)
+#define STBCR12	(RZA1_STBCR_BASE + 0x424)
+#define STBCR13	(RZA1_STBCR_BASE + 0x450)
+
+/* Clock Registers */
+#define RZA1_FRQCR_BASE	0xFCFE0010
+#define FRQCR	(RZA1_FRQCR_BASE + 0x00)
+#define FRQCR2	(RZA1_FRQCR_BASE + 0x04)
+
+#define SYSCR1	0xFCFE0400 /* System control register 1 */
+#define SYSCR2	0xFCFE0404 /* System control register 2 */
+#define SYSCR3	0xFCFE0408 /* System control register 3 */
+
+/* Disable WDT */
+#define WTCSR_D		0xA518
+#define WTCNT_D		0x5A00
+
+/* Enable all peripheral clocks */
+#define STBCR3_D	0x00000000
+#define STBCR4_D	0x00000000
+#define STBCR5_D	0x00000000
+#define STBCR6_D	0x00000000
+#define STBCR7_D	0x00000024
+#define STBCR8_D	0x00000005
+#define STBCR9_D	0x00000000
+#define STBCR10_D	0x00000000
+#define STBCR11_D	0x000000c0
+#define STBCR12_D	0x000000f0
+
+/*
+ * Set all system clocks to full speed.
+ * On reset, the CPU will be running at 1/2 speed.
+ * In the Hardware Manual, see Table 6.3 Settable Frequency Ranges
+ */
+#define FRQCR_D		0x0035
+#define FRQCR2_D	0x0001
+
+	.global	lowlevel_init
+
+	.text
+	.align	2
+
+lowlevel_init:
+	/* PL310 init */
+	write32 0x3fffff80, 0x00000001
+
+	/* Disable WDT */
+	write16	WTCSR, WTCSR_D
+	write16	WTCNT, WTCNT_D
+
+	/* Set clocks */
+	write16	FRQCR, FRQCR_D
+	write16	FRQCR2, FRQCR2_D
+
+	/* Enable all peripherals(Standby Control) */
+	write8 STBCR3, STBCR3_D
+	write8 STBCR4, STBCR4_D
+	write8 STBCR5, STBCR5_D
+	write8 STBCR6, STBCR6_D
+	write8 STBCR7, STBCR7_D
+	write8 STBCR8, STBCR8_D
+	write8 STBCR9, STBCR9_D
+	write8 STBCR10, STBCR10_D
+	write8 STBCR11, STBCR11_D
+	write8 STBCR12, STBCR12_D
+
+	/* For serial booting, enable read ahead caching to speed things up */
+#define DRCR_0  0x3FEFA00C
+	write32 DRCR_0, 0x00010100	/* Read Burst ON, Length=2 */
+
+	/* Enable all internal RAM */
+	write8 SYSCR1, 0xFF
+	write8 SYSCR2, 0xFF
+	write8 SYSCR3, 0xFF
+
+	nop
+	/* back to arch calling code */
+	mov	pc, lr
+
+	.align 4
--- 0001/board/renesas/grpeach/Makefile
+++ work/board/renesas/grpeach/Makefile	2025-07-02 21:51:14.025928096 +0900
@@ -5,4 +5,3 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y	:= grpeach.o
-obj-y	+= lowlevel_init.o
--- 0001/board/renesas/grpeach/grpeach.c
+++ work/board/renesas/grpeach/grpeach.c	2025-07-02 21:51:14.024928090 +0900
@@ -4,17 +4,9 @@
  * Copyright (C) Chris Brandt
  */
 
-#include <cpu_func.h>
 #include <errno.h>
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/arch/sys_proto.h>
-
-#define RZA1_WDT_BASE	0xfcfe0000
-#define WTCSR		0x00
-#define WTCNT		0x02
-#define WRCSR		0x04
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -39,17 +31,3 @@ int dram_init_banksize(void)
 
 	return 0;
 }
-
-void reset_cpu(void)
-{
-	/* Dummy read (must read WRCSR:WOVF at least once before clearing) */
-	readb(RZA1_WDT_BASE + WRCSR);
-
-	writew(0xa500, RZA1_WDT_BASE + WRCSR);
-	writew(0x5a5f, RZA1_WDT_BASE + WRCSR);
-	writew(0x5a00, RZA1_WDT_BASE + WTCNT);
-	writew(0xa578, RZA1_WDT_BASE + WTCSR);
-
-	for (;;)
-		asm volatile("wfi");
-}
--- 0001/board/renesas/grpeach/lowlevel_init.S
+++ /dev/null	2024-05-09 17:39:54.740296459 +0900
@@ -1,106 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Renesas Electronics
- * Copyright (C) 2017 Chris Brandt
- */
-#include <config.h>
-#include <asm/macro.h>
-
-/* Watchdog Registers */
-#define RZA1_WDT_BASE	0xFCFE0000
-#define WTCSR	(RZA1_WDT_BASE + 0x00) /* Watchdog Timer Control Register */
-#define WTCNT	(RZA1_WDT_BASE + 0x02) /* Watchdog Timer Counter Register */
-#define WRCSR	(RZA1_WDT_BASE + 0x04) /* Watchdog Reset Control Register */
-
-/* Standby controller registers (chapter 55) */
-#define RZA1_STBCR_BASE	0xFCFE0020
-#define STBCR1	(RZA1_STBCR_BASE + 0x00)
-#define STBCR2	(RZA1_STBCR_BASE + 0x04)
-#define STBCR3	(RZA1_STBCR_BASE + 0x400)
-#define STBCR4	(RZA1_STBCR_BASE + 0x404)
-#define STBCR5	(RZA1_STBCR_BASE + 0x408)
-#define STBCR6	(RZA1_STBCR_BASE + 0x40c)
-#define STBCR7	(RZA1_STBCR_BASE + 0x410)
-#define STBCR8	(RZA1_STBCR_BASE + 0x414)
-#define STBCR9	(RZA1_STBCR_BASE + 0x418)
-#define STBCR10	(RZA1_STBCR_BASE + 0x41c)
-#define STBCR11	(RZA1_STBCR_BASE + 0x420)
-#define STBCR12	(RZA1_STBCR_BASE + 0x424)
-#define STBCR13	(RZA1_STBCR_BASE + 0x450)
-
-/* Clock Registers */
-#define RZA1_FRQCR_BASE	0xFCFE0010
-#define FRQCR	(RZA1_FRQCR_BASE + 0x00)
-#define FRQCR2	(RZA1_FRQCR_BASE + 0x04)
-
-#define SYSCR1	0xFCFE0400 /* System control register 1 */
-#define SYSCR2	0xFCFE0404 /* System control register 2 */
-#define SYSCR3	0xFCFE0408 /* System control register 3 */
-
-/* Disable WDT */
-#define WTCSR_D		0xA518
-#define WTCNT_D		0x5A00
-
-/* Enable all peripheral clocks */
-#define STBCR3_D	0x00000000
-#define STBCR4_D	0x00000000
-#define STBCR5_D	0x00000000
-#define STBCR6_D	0x00000000
-#define STBCR7_D	0x00000024
-#define STBCR8_D	0x00000005
-#define STBCR9_D	0x00000000
-#define STBCR10_D	0x00000000
-#define STBCR11_D	0x000000c0
-#define STBCR12_D	0x000000f0
-
-/*
- * Set all system clocks to full speed.
- * On reset, the CPU will be running at 1/2 speed.
- * In the Hardware Manual, see Table 6.3 Settable Frequency Ranges
- */
-#define FRQCR_D		0x0035
-#define FRQCR2_D	0x0001
-
-	.global	lowlevel_init
-
-	.text
-	.align	2
-
-lowlevel_init:
-	/* PL310 init */
-	write32 0x3fffff80, 0x00000001
-
-	/* Disable WDT */
-	write16	WTCSR, WTCSR_D
-	write16	WTCNT, WTCNT_D
-
-	/* Set clocks */
-	write16	FRQCR, FRQCR_D
-	write16	FRQCR2, FRQCR2_D
-
-	/* Enable all peripherals(Standby Control) */
-	write8 STBCR3, STBCR3_D
-	write8 STBCR4, STBCR4_D
-	write8 STBCR5, STBCR5_D
-	write8 STBCR6, STBCR6_D
-	write8 STBCR7, STBCR7_D
-	write8 STBCR8, STBCR8_D
-	write8 STBCR9, STBCR9_D
-	write8 STBCR10, STBCR10_D
-	write8 STBCR11, STBCR11_D
-	write8 STBCR12, STBCR12_D
-
-	/* For serial booting, enable read ahead caching to speed things up */
-#define DRCR_0  0x3FEFA00C
-	write32 DRCR_0, 0x00010100	/* Read Burst ON, Length=2 */
-
-	/* Enable all internal RAM */
-	write8 SYSCR1, 0xFF
-	write8 SYSCR2, 0xFF
-	write8 SYSCR3, 0xFF
-
-	nop
-	/* back to arch calling code */
-	mov	pc, lr
-
-	.align 4
