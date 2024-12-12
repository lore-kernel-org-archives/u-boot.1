Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136EEE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F09E8023C;
	Thu, 12 Dec 2024 14:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fr0oiLpz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l7xIzjFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BDF8022F; Thu, 12 Dec 2024 14:38:19 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E285801CE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y8D7X3Ymmz9snL;
 Thu, 12 Dec 2024 14:38:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CBQh4KNMRcXBpdzzqB0FAHWGz/qNi/JOgSLcup6S7+w=;
 b=fr0oiLpzIzKl9LXmKuqXsZbbZicrGjV+yHtLsdnoM0uTEx65Tq8v0I/PxPNxohamJ+0T5p
 VGFggVSJXxbAyOu7iDVYr06WUEj4IdDadx+Nf5YB41LfEKwJ3OtU7NsyE2Oibenx+ulmx6
 fufM/8kTuNVe3p42fgp822hiy80QNQY0VuPbcywlxi/I+vB1lBLWcxY+kKksSP37IDxiSt
 qk/svIOND8nhElo+5v56bZVig7mlrUET1cwWSPBVTK1ROiAGyzKH7E9zgXg3TPyv/vXxax
 GvFUBZHr2yTYxjRky0ry8E1G3El158Hb7slpOCo15fyQsEXsNPkb59UH9sgR+A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CBQh4KNMRcXBpdzzqB0FAHWGz/qNi/JOgSLcup6S7+w=;
 b=l7xIzjFPfMvD7SMmsTY00UfWNCG8FCtB9+l991awzYdl1hamjfZ702nk13Z7cDiQ92I/5E
 ah25hY4FVz1YdH1oRVDsiQhz9DzK1QPqF5PKqZ/o2St8HFNBEC7G8TmrGPiK4Gwq+iwQf7
 mnRUtbCpBZk5Ugx59+yhewa0rqJKVKpQ+ZfcgW+64qrBSV1DYmqgUEJiUB9VZ1uh1F+AmH
 m6xdOQF5grbrwNdtNidqmD03DriP3DJUL51rdmss7zBZXohc6oEwFm75nAQcxipKddTjWo
 xxvRoS6QdKqHeNqSLwzTnFXWgS8Zvwp7mxOzT5VvAKQFHfK3UyqG67Rk7Wm0bA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Deduplicate R-Car Gen4 board files
Date: Thu, 12 Dec 2024 14:37:34 +0100
Message-ID: <20241212133755.84552-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m6wfyn5rd8zy3kbao5atfnxud5u1sbxg
X-MBO-RS-ID: bc07113ef6b0e35f0c5
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

All R-Car Gen4 board files are copies of one another at this point.
Deduplicate them into single board/renesas/rcar-common/gen4-common.c
and remove all the duplicates. The one exception is R-Car V3U Falcon
board, which enables RWDT reset in board_init(), conditionally build
RWDT enablement in board_init() in the new common code for V3U.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/falcon/Makefile                 |   2 +-
 board/renesas/falcon/falcon.c                 | 102 ------------------
 board/renesas/grayhawk/Makefile               |   2 +-
 .../grayhawk.c => rcar-common/gen4-common.c}  |  22 ++--
 board/renesas/spider/Makefile                 |   2 +-
 board/renesas/spider/spider.c                 |  66 ------------
 board/renesas/whitehawk/Makefile              |   2 +-
 board/renesas/whitehawk/whitehawk.c           |  66 ------------
 8 files changed, 20 insertions(+), 244 deletions(-)
 delete mode 100644 board/renesas/falcon/falcon.c
 rename board/renesas/{grayhawk/grayhawk.c => rcar-common/gen4-common.c} (71%)
 delete mode 100644 board/renesas/spider/spider.c
 delete mode 100644 board/renesas/whitehawk/whitehawk.c

diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
index 2e240d3bad6..48fcfac9105 100644
--- a/board/renesas/falcon/Makefile
+++ b/board/renesas/falcon/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
-obj-y	:= falcon.o ../rcar-common/common.o
+obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
 endif
diff --git a/board/renesas/falcon/falcon.c b/board/renesas/falcon/falcon.c
deleted file mode 100644
index c88257d9677..00000000000
--- a/board/renesas/falcon/falcon.c
+++ /dev/null
@@ -1,102 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * board/renesas/falcon/falcon.c
- *     This file is Falcon board support.
- *
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-
-#include <asm/arch/renesas.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/mach-types.h>
-#include <asm/processor.h>
-#include <linux/errno.h>
-#include <asm/system.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#define CPGWPR		0xE6150000
-#define CPGWPCR		0xE6150004
-
-#define EXTAL_CLK	16666600u
-#define CNTCR_BASE	0xE6080000
-#define CNTFID0		(CNTCR_BASE + 0x020)
-#define CNTCR_EN	BIT(0)
-
-static void init_generic_timer(void)
-{
-	u32 freq;
-
-	/* Set frequency data in CNTFID0 */
-	freq = EXTAL_CLK;
-
-	/* Update memory mapped and register based freqency */
-	asm volatile ("msr cntfrq_el0, %0" :: "r" (freq));
-	writel(freq, CNTFID0);
-
-	/* Enable counter */
-	setbits_le32(CNTCR_BASE, CNTCR_EN);
-}
-
-/* Distributor Registers */
-#define GICD_BASE	0xF1000000
-
-/* ReDistributor Registers for Control and Physical LPIs */
-#define GICR_LPI_BASE	0xF1060000
-#define GICR_WAKER	0x0014
-#define GICR_PWRR	0x0024
-#define GICR_LPI_WAKER	(GICR_LPI_BASE + GICR_WAKER)
-#define GICR_LPI_PWRR	(GICR_LPI_BASE + GICR_PWRR)
-
-/* ReDistributor Registers for SGIs and PPIs */
-#define GICR_SGI_BASE	0xF1070000
-#define GICR_IGROUPR0	0x0080
-
-static void init_gic_v3(void)
-{
-	 /* GIC v3 power on */
-	writel(0x00000002, (GICR_LPI_PWRR));
-
-	/* Wait till the WAKER_CA_BIT changes to 0 */
-	writel(readl(GICR_LPI_WAKER) & ~0x00000002, (GICR_LPI_WAKER));
-	while (readl(GICR_LPI_WAKER) & 0x00000004)
-		;
-
-	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
-}
-
-void s_init(void)
-{
-	if (current_el() == 3)
-		init_generic_timer();
-}
-
-int board_early_init_f(void)
-{
-	/* Unlock CPG access */
-	writel(0x5A5AFFFF, CPGWPR);
-	writel(0xA5A50000, CPGWPCR);
-
-	return 0;
-}
-
-#define RST_BASE	0xE6160000 /* Domain0 */
-#define RST_WDTRSTCR	(RST_BASE + 0x10)
-#define RST_RWDT	0xA55A8002
-
-int board_init(void)
-{
-	/* address of boot parameters */
-	gd->bd->bi_boot_params = CONFIG_TEXT_BASE + 0x50000;
-
-	if (current_el() == 3) {
-		init_gic_v3();
-
-		/* Enable RWDT reset */
-		writel(RST_RWDT, RST_WDTRSTCR);
-	}
-
-	return 0;
-}
diff --git a/board/renesas/grayhawk/Makefile b/board/renesas/grayhawk/Makefile
index 9c5b8c9a12f..7414b773326 100644
--- a/board/renesas/grayhawk/Makefile
+++ b/board/renesas/grayhawk/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= grayhawk.o ../rcar-common/common.o
+obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
diff --git a/board/renesas/grayhawk/grayhawk.c b/board/renesas/rcar-common/gen4-common.c
similarity index 71%
rename from board/renesas/grayhawk/grayhawk.c
rename to board/renesas/rcar-common/gen4-common.c
index 6c8fca89679..36a51bc4190 100644
--- a/board/renesas/grayhawk/grayhawk.c
+++ b/board/renesas/rcar-common/gen4-common.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * board/renesas/grayhawk/grayhawk.c
- *     This file is Gray Hawk board support.
+ * board/renesas/rcar-common/gen4-common.c
  *
- * Copyright (C) 2023 Renesas Electronics Corp.
+ * Copyright (C) 2021-2024 Renesas Electronics Corp.
  */
 
 #include <asm/arch/renesas.h>
@@ -12,8 +11,12 @@
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/processor.h>
-#include <linux/errno.h>
 #include <asm/system.h>
+#include <linux/errno.h>
+
+#define RST_BASE	0xE6160000 /* Domain0 */
+#define RST_WDTRSTCR	(RST_BASE + 0x10)
+#define RST_RWDT	0xA55A8002
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -59,8 +62,15 @@ int board_early_init_f(void)
 
 int board_init(void)
 {
-	if (current_el() == 3)
-		init_gic_v3();
+	if (current_el() != 3)
+		return 0;
+	init_gic_v3();
+
+	/* Enable RWDT reset on V3U in EL3 */
+	if (IS_ENABLED(CONFIG_R8A779A0) &&
+	    renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A779A0) {
+		writel(RST_RWDT, RST_WDTRSTCR);
+	}
 
 	return 0;
 }
diff --git a/board/renesas/spider/Makefile b/board/renesas/spider/Makefile
index 545cb58a98f..9489917278c 100644
--- a/board/renesas/spider/Makefile
+++ b/board/renesas/spider/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= spider.o ../rcar-common/common.o
+obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
diff --git a/board/renesas/spider/spider.c b/board/renesas/spider/spider.c
deleted file mode 100644
index 414948f1831..00000000000
--- a/board/renesas/spider/spider.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * board/renesas/spider/spider.c
- *     This file is Spider board support.
- *
- * Copyright (C) 2021 Renesas Electronics Corp.
- */
-
-#include <asm/arch/renesas.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/mach-types.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <linux/errno.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-static void init_generic_timer(void)
-{
-	const u32 freq = CONFIG_SYS_CLK_FREQ;
-
-	/* Update memory mapped and register based freqency */
-	asm volatile ("msr cntfrq_el0, %0" :: "r" (freq));
-	writel(freq, CNTFID0);
-
-	/* Enable counter */
-	setbits_le32(CNTCR_BASE, CNTCR_EN);
-}
-
-static void init_gic_v3(void)
-{
-	 /* GIC v3 power on */
-	writel(BIT(1), GICR_LPI_PWRR);
-
-	/* Wait till the WAKER_CA_BIT changes to 0 */
-	clrbits_le32(GICR_LPI_WAKER, BIT(1));
-	while (readl(GICR_LPI_WAKER) & BIT(2))
-		;
-
-	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
-}
-
-void s_init(void)
-{
-	if (current_el() == 3)
-		init_generic_timer();
-}
-
-int board_early_init_f(void)
-{
-	/* Unlock CPG access */
-	writel(0x5A5AFFFF, CPGWPR);
-	writel(0xA5A50000, CPGWPCR);
-
-	return 0;
-}
-
-int board_init(void)
-{
-	if (current_el() == 3)
-		init_gic_v3();
-
-	return 0;
-}
diff --git a/board/renesas/whitehawk/Makefile b/board/renesas/whitehawk/Makefile
index ed5bdc04e01..38726cd79f3 100644
--- a/board/renesas/whitehawk/Makefile
+++ b/board/renesas/whitehawk/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= whitehawk.o ../rcar-common/common.o
+obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
diff --git a/board/renesas/whitehawk/whitehawk.c b/board/renesas/whitehawk/whitehawk.c
deleted file mode 100644
index 3a10b0220d1..00000000000
--- a/board/renesas/whitehawk/whitehawk.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * board/renesas/whitehawk/whitehawk.c
- *     This file is White Hawk board support.
- *
- * Copyright (C) 2021 Renesas Electronics Corp.
- */
-
-#include <asm/arch/renesas.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/mach-types.h>
-#include <asm/processor.h>
-#include <linux/errno.h>
-#include <asm/system.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-static void init_generic_timer(void)
-{
-	const u32 freq = CONFIG_SYS_CLK_FREQ;
-
-	/* Update memory mapped and register based freqency */
-	asm volatile ("msr cntfrq_el0, %0" :: "r" (freq));
-	writel(freq, CNTFID0);
-
-	/* Enable counter */
-	setbits_le32(CNTCR_BASE, CNTCR_EN);
-}
-
-static void init_gic_v3(void)
-{
-	/* GIC v3 power on */
-	writel(BIT(1), GICR_LPI_PWRR);
-
-	/* Wait till the WAKER_CA_BIT changes to 0 */
-	clrbits_le32(GICR_LPI_WAKER, BIT(1));
-	while (readl(GICR_LPI_WAKER) & BIT(2))
-		;
-
-	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
-}
-
-void s_init(void)
-{
-	if (current_el() == 3)
-		init_generic_timer();
-}
-
-int board_early_init_f(void)
-{
-	/* Unlock CPG access */
-	writel(0x5A5AFFFF, CPGWPR);
-	writel(0xA5A50000, CPGWPCR);
-
-	return 0;
-}
-
-int board_init(void)
-{
-	if (current_el() == 3)
-		init_gic_v3();
-
-	return 0;
-}
-- 
2.45.2

