Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5FBC7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5C982E05;
	Sat, 28 Jun 2025 14:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1FC582DA1; Sat, 28 Jun 2025 10:36:19 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F503806D8
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 10:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d44e3a0169so17500485a.0
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 01:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751099769; x=1751704569;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TT8XmUGCaDyBJorzhstG0DOrZgSrjxqGYRcMchQgjAc=;
 b=Pq9PpPY0Z0hNPQYrezo44JNUvQC0IfbQXMh+hDFyeaVPdZmHM/9P6+WmWoDCQWha8q
 VGlNeqTVoj67d0MUVSfba6PistsNcrG3MAVXFfagX3JKUyLLXhEsFzJ//Hjiht4i2+Pm
 0LkRBeMzOTOeA4VEW3dpErsfQt7mn9NEaUMO4X1gQlap3lvDLxE+ZH1AqF9DuqGkL3na
 NTQQSbaaHnZMC07jQe0T6fws9pNML7OOZ2zRr0TxY4wVuywYkcZRdZ9jeU/BevT1yBgs
 VafXKTyq+80ZFdShiiQdu2MpbfiQ5+i3wZFoqt69wqSD9HOnNYzB6/xqfWDNItLXk1Ay
 oC+A==
X-Gm-Message-State: AOJu0Yw8+MT1jcob6pgpmYmvFfvYqqxRpSgLLMoVx/ajraXfvrq+E4uL
 BK9eB3jVnCh3Phq9cP/3FI1RyS/Awq8sgzmi5L4Edelm1/CiHwpv5HtkcHYnmTCI+Ao=
X-Gm-Gg: ASbGncvHQDrpZ/NuMwoQGAse9r/P5tD28GHXXPNe5K3r+Jh8S+57ug2ljF18S9x57Yw
 Khqm+nW0lr7F4iQEXBBt3O7D3edV0szHi61WcZ718uLz3jB9lmpCXg9xROGXt8IpSNVPH25HDNn
 Bw9Jtl4NDXjkr8ptFiQG5TFfSEO9YsLuzyf+FUNUxlh524rmZvhZ5dt05cfkOZ3DzM6UvZCkKs5
 w3OXiMlT1MHWbKVUVZw+lFX4qcXP2N+AOKNFb7Yjnznw4sZBGtwz87cyCi+LeCIiEzfPVjdfCZW
 eGE/De8PxuUBTSzkpaPobLsg2QxvTD++VnuPEuXUlWCG7CICr9Gk5thh1yJClDQsT4T1rUbX2zv
 Ea+zL6co=
X-Google-Smtp-Source: AGHT+IFHGZLFP8SmpQLSQv4mHdI3GoFbd9Gbi9j6ksugZzPERYpyIMVfPPZuj+kAXMfTnvKBoPNzVQ==
X-Received: by 2002:a05:620a:470c:b0:7d2:3db:6816 with SMTP id
 af79cd13be357-7d443a07613mr999789485a.47.1751099768950; 
 Sat, 28 Jun 2025 01:36:08 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7732bd1esm33698576d6.125.2025.06.28.01.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 01:36:08 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, Chris.Brandt@renesas.com,
 geert+renesas@glider.be, marek.vasut+renesas@gmail.com
Date: Sat, 28 Jun 2025 10:36:06 +0200
Message-Id: <175109976650.52679.843396826887967830.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH 1/2] Put common r7s72100 code in board/renesas/common
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:07 +0200
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

 board/renesas/common/Makefile             |    6 +
 board/renesas/common/rza1-common.c        |   27 +++++++
 board/renesas/common/rza1-lowlevel_init.S |  106 +++++++++++++++++++++++++++++
 board/renesas/grpeach/Makefile            |    1 
 board/renesas/grpeach/grpeach.c           |   22 ------
 board/renesas/grpeach/lowlevel_init.S     |  106 -----------------------------
 6 files changed, 139 insertions(+), 129 deletions(-)
 
diff -urN u-boot-v2025.07-rc5/board/renesas/common/Makefile u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/common/Makefile
--- u-boot-v2025.07-rc5/board/renesas/common/Makefile	2025-06-06 19:15:44.898179467 +0900
+++ u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/common/Makefile	2025-06-28 05:35:38.636922889 +0900
@@ -45,3 +45,9 @@
 endif
 
 endif
+
+ifdef CONFIG_RZA1
+obj-y	+= rza1-common.o
+obj-y	+= rza1-lowlevel_init.o
+endif
+
diff -urN u-boot-v2025.07-rc5/board/renesas/common/rza1-common.c u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/common/rza1-common.c
--- u-boot-v2025.07-rc5/board/renesas/common/rza1-common.c	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/common/rza1-common.c	2025-06-28 05:35:59.180039448 +0900
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
diff -urN u-boot-v2025.07-rc5/board/renesas/common/rza1-lowlevel_init.S u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/common/rza1-lowlevel_init.S
--- u-boot-v2025.07-rc5/board/renesas/common/rza1-lowlevel_init.S	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/common/rza1-lowlevel_init.S	2025-06-28 05:35:38.636922889 +0900
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
diff -urN u-boot-v2025.07-rc5/board/renesas/grpeach/grpeach.c u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/grpeach/grpeach.c
--- u-boot-v2025.07-rc5/board/renesas/grpeach/grpeach.c	2024-05-18 16:38:52.910534943 +0900
+++ u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/grpeach/grpeach.c	2025-06-28 05:44:36.525976339 +0900
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
 
@@ -39,17 +31,3 @@
 
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
diff -urN u-boot-v2025.07-rc5/board/renesas/grpeach/lowlevel_init.S u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/grpeach/lowlevel_init.S
--- u-boot-v2025.07-rc5/board/renesas/grpeach/lowlevel_init.S	2024-05-18 16:38:52.910534943 +0900
+++ u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/grpeach/lowlevel_init.S	1970-01-01 09:00:00.000000000 +0900
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
diff -urN u-boot-v2025.07-rc5/board/renesas/grpeach/Makefile u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/grpeach/Makefile
--- u-boot-v2025.07-rc5/board/renesas/grpeach/Makefile	2024-05-18 16:38:52.910534943 +0900
+++ u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/grpeach/Makefile	2025-06-28 05:35:38.636922889 +0900
@@ -5,4 +5,3 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y	:= grpeach.o
-obj-y	+= lowlevel_init.o
