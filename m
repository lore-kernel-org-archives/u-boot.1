Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CDEC83F03
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 20:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6341382F14;
	Wed,  2 Jul 2025 22:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDD782F03; Wed,  2 Jul 2025 19:13:52 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03EB82A76
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6facf4d8ea8so42089796d6.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476429; x=1752081229;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8y4Cw1TyTYO8ji9k3Sw8k87Z5dXcxWfgkJPzuD/6cA=;
 b=eYDHIHxlOd66xyrPJXLctqo3gpW6tnpUEVFtGd7HJweWVg6LqV4t66jC9rXlsdt7NL
 Vsb8nX8VSjVaxEdT3J8XHefqImekMiaKV6NCZeySOX0evVOn7xKbIceg/PVPdzP3Whqk
 L596hAibvtbywmv0Ev9GI3gniyb4K/bzJRQTh2q90Jnxslqjd7j5oHdqmQ+HbxumI6pa
 Sh3OOvKhO0GQaEWW6WsbTUNp2yZOOv1udMtp3kzz5s8D1V0sY6hqqwobMMpaMK7SfDxw
 6oZYtJRbbyX/INKP3ChpPZupawDnzmwB8JcTZERKcJ7hTSLuK+kg6Hj4sK6npi8faS49
 +83g==
X-Gm-Message-State: AOJu0YwrjWOzF0epeLeoeOTmHOk1LgYKudeI1nF0aRFz+REB13J0TYXe
 e7+KJvXTXJs9gg29EY72eU+IOsfvHVGKg8jgXA5r8nwF52vP9fgqCVugiC9Ss+vX
X-Gm-Gg: ASbGnctDX5o1FBSZgMBiKzoewVRmPhStE73UV7KkRp/+lQ39sEqGeRHcGyMNtt6V3Qr
 lIbHJKfh1d4BApvT+HqtNsILn0CKng/224r9cySqnAwtfEKpbF7QnzDC56y+5Yzjm2jb6k2kpUX
 zVOUX5EEegSQNoFdzh1+gfbVBICvEW3lqT2a5CX121vO1S1T4RlwJWLBTsYrmq2MEdzE8wKVsUM
 NFBctZbyMwZrv0AMIcBs4JvxzIDa2fE2IWIEdNGeMQWyKuQlLozKHDxRmHqsnJ05uJD1S9BwsiP
 DLVFR8eqOBBrufNhAssgyQN6krQKNdiSPI7Zd5jh0ZXrrsZaty7cMSR3B2K8NP2cv8fNUBPt+W6
 +WwHz+eQBafT9
X-Google-Smtp-Source: AGHT+IGiQpa/Z5lQ+JbncNRnClh0fidRy0IXmokS12K3e73jN4rAI3sC5LhQHXnx2i1uIHKLq9cPQA==
X-Received: by 2002:a05:6214:3f88:b0:701:a37:ac9c with SMTP id
 6a1803df08f44-702bcb46c0dmr977176d6.0.1751476429082; 
 Wed, 02 Jul 2025 10:13:49 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7718e76esm104085036d6.12.2025.07.02.10.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:13:48 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 Magnus Damm <damm@opensource.se>, geert+renesas@glider.be
Date: Wed, 02 Jul 2025 19:13:46 +0200
Message-Id: <175147642650.69121.6274791716831061946.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175147641895.69121.4718662283609078812.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175147641895.69121.4718662283609078812.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v2 1/2] ARM: renesas: Put common r7s72100 code in
 board/renesas/common
X-Mailman-Approved-At: Wed, 02 Jul 2025 22:17:46 +0200
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
