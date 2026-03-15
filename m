Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D2AF30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9841984439;
	Mon, 16 Mar 2026 00:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bbp/rDys";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VbOkENz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEBF784441; Mon, 16 Mar 2026 00:51:30 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9006C8442E
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fYw3h2HpQz9v98;
 Mon, 16 Mar 2026 00:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tACFCq5DkdVLeMfppBC0z9C1ikTLiwaacJ+BYpOPGlE=;
 b=bbp/rDysQrCC+zHQvsRoKEiOCa2QNvckrx7CXwDd1r9f9hiVTKvXH66synBmBKtrLaMatK
 ZuMl1A3lon+yTnF9e8HWskw32LGATIv40iXObQjUCgqCkNI0O0sP7KyBmfO2EOlUzO2PgP
 RRmr/GAJAzjkHPXEQOzlm53ZBQBPLt/VSsvruGVELgHv+1Hd0RXbBZ0VbzezffSrVXZTk9
 77dQTwqvHa4LLjngZn/JWLXcOOYrlQhm3bW/yi7qLEROTeoZcPrDSO2MeZ684ce+etQaXh
 9y24hmQi+BLmnS8sD1QyxjSqJ800c09uTZpD30ehb5Re309/lo8K++0XujQS+A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tACFCq5DkdVLeMfppBC0z9C1ikTLiwaacJ+BYpOPGlE=;
 b=VbOkENz8BeXgxnEH6DcGZsLaYTG30L/qe2Fd4aQueVaAfLwY5kruZh/zRwdo8fT2r2+Nhc
 bnI/r4ChrA6j14BKYFPt6JAvkZsPrW4x2V+4lfcGIXKf1JFzr4OglHH5+RWeUGbfiJdl2j
 6LUgl7IBCdOq/hyCtK/umsR2WykXj7gFYscOvtv1CC2M4H5B9dFGOoWEtB6IhXzOootqoX
 vHutLC2xzKwD5KugyVYmYd63IxdKAC9lwzwfDZct12hVCnYD8srK3F+Vmke3jfyUO8yPZZ
 kbtrGgmTtuyYq5R4zqNxcelwh7LUjYR+IRYotnk/ntaG3fsGRMBfi+UaVYMtiw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Use stock lowlevel_init function and remove
 s_init
Date: Mon, 16 Mar 2026 00:51:01 +0100
Message-ID: <20260315235125.304518-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 81b7a6dd20bd20168d9
X-MBO-RS-META: exoaicy16bctm5kgo8wnym8pc9z1jaog
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

Replace s_init() early initialization at the end of lowlevel_init
by invoking the same code in mach_cpu_init(). The mach_cpu_init()
is called a bit later, but as the code initializes timer and no
code uses timer until mach_cpu_init(), this does not pose a problem.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/lowlevel_init_gen3.S | 71 ----------------------
 board/renesas/common/gen3-spl.c            |  4 --
 board/renesas/common/gen4-common.c         |  4 +-
 board/renesas/common/gen4-spl.c            |  4 +-
 board/renesas/common/gen5-common.c         |  4 +-
 5 files changed, 9 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-renesas/lowlevel_init_gen3.S b/arch/arm/mach-renesas/lowlevel_init_gen3.S
index 0d7780031ac..d0dd140f7a7 100644
--- a/arch/arm/mach-renesas/lowlevel_init_gen3.S
+++ b/arch/arm/mach-renesas/lowlevel_init_gen3.S
@@ -30,74 +30,3 @@ ENTRY(save_boot_params)
 	stp	x2, x3, [x8], #16
 	b	save_boot_params_ret
 ENDPROC(save_boot_params)
-
-.pushsection .text.s_init, "ax"
-WEAK(s_init)
-	ret
-ENDPROC(s_init)
-.popsection
-
-ENTRY(lowlevel_init)
-	mov	x29, lr			/* Save LR */
-
-#ifndef CONFIG_ARMV8_MULTIENTRY
-	/*
-	 * For single-entry systems the lowlevel init is very simple.
-	 */
-	ldr	x0, =GICD_BASE
-	bl	gic_init_secure
-
-#else /* CONFIG_ARMV8_MULTIENTRY is set */
-
-#if defined(CONFIG_GICV2) || defined(CONFIG_GICV3)
-	branch_if_slave x0, 1f
-	ldr	x0, =GICD_BASE
-	bl	gic_init_secure
-1:
-#if defined(CONFIG_GICV3)
-	ldr	x0, =GICR_BASE
-	bl	gic_init_secure_percpu
-#elif defined(CONFIG_GICV2)
-	ldr	x0, =GICD_BASE
-	ldr	x1, =GICC_BASE
-	bl	gic_init_secure_percpu
-#endif
-#endif
-
-	branch_if_master x0, 2f
-
-	/*
-	 * Slave should wait for master clearing spin table.
-	 * This sync prevent salves observing incorrect
-	 * value of spin table and jumping to wrong place.
-	 */
-#if defined(CONFIG_GICV2) || defined(CONFIG_GICV3)
-#ifdef CONFIG_GICV2
-	ldr	x0, =GICC_BASE
-#endif
-	bl	gic_wait_for_interrupt
-#endif
-
-	/*
-	 * All slaves will enter EL2 and optionally EL1.
-	 */
-	adr	x4, lowlevel_in_el2
-	ldr	x5, =ES_TO_AARCH64
-	bl	armv8_switch_to_el2
-
-lowlevel_in_el2:
-#ifdef CONFIG_ARMV8_SWITCH_TO_EL1
-	adr	x4, lowlevel_in_el1
-	ldr	x5, =ES_TO_AARCH64
-	bl	armv8_switch_to_el1
-
-lowlevel_in_el1:
-#endif
-#endif /* CONFIG_ARMV8_MULTIENTRY */
-
-	bl      s_init
-
-2:
-	mov	lr, x29			/* Restore LR */
-	ret
-ENDPROC(lowlevel_init)
diff --git a/board/renesas/common/gen3-spl.c b/board/renesas/common/gen3-spl.c
index 9590b5d6a2e..f833bfeaeee 100644
--- a/board/renesas/common/gen3-spl.c
+++ b/board/renesas/common/gen3-spl.c
@@ -29,10 +29,6 @@ u32 spl_boot_device(void)
 	return BOOT_DEVICE_UART;
 }
 
-void s_init(void)
-{
-}
-
 void reset_cpu(void)
 {
 }
diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
index 38fba7a5ea7..a45a8525151 100644
--- a/board/renesas/common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -43,10 +43,12 @@ static void init_gic_v3(void)
 	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
 }
 
-void s_init(void)
+int mach_cpu_init(void)
 {
 	if (current_el() == 3)
 		init_generic_timer();
+
+	return 0;
 }
 
 int board_early_init_f(void)
diff --git a/board/renesas/common/gen4-spl.c b/board/renesas/common/gen4-spl.c
index ebfefab7253..e4c1190eac7 100644
--- a/board/renesas/common/gen4-spl.c
+++ b/board/renesas/common/gen4-spl.c
@@ -82,7 +82,7 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 #define RTGRP3_BIT			BIT(19)
 #define APMU_ACC_ENB_FOR_ARM_CPU	(CL0GRP3_BIT | CL1GRP3_BIT | RTGRP3_BIT)
 
-void s_init(void)
+int mach_cpu_init(void)
 {
 	/* Unlock CPG access */
 	writel(0x5A5AFFFF, CPGWPR);
@@ -95,6 +95,8 @@ void s_init(void)
 	writel(0x00ff00ff, APMU_BASE + 0x18);
 	writel(0x00ff00ff, APMU_BASE + 0x1c);
 	clrbits_le32(APMU_BASE + 0x68, BIT(29));
+
+	return 0;
 }
 
 void reset_cpu(void)
diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5-common.c
index a05a3e8abef..665e60d8cfa 100644
--- a/board/renesas/common/gen5-common.c
+++ b/board/renesas/common/gen5-common.c
@@ -39,10 +39,12 @@ static void init_gic_v3(void)
 	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
 }
 
-void s_init(void)
+int mach_cpu_init(void)
 {
 	if (current_el() == 3)
 		init_generic_timer();
+
+	return 0;
 }
 
 int board_early_init_f(void)
-- 
2.51.0

