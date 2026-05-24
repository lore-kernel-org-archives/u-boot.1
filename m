Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8079CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 12:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEFD284659;
	Sun, 24 May 2026 14:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="iYE/doSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E546183AA9; Sun, 24 May 2026 14:38:25 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB0F84659
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 14:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A0D3625FE1;
 Sun, 24 May 2026 14:38:23 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FC8Q_EiQSa8u; Sun, 24 May 2026 14:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779626303; bh=bJ1hgHgN5Z/7ZgDl0ADM1bhh2C0JR99iz6oBXa/9ABc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iYE/doSDkvAlhvND9jXh7pZ4uZMFJbAoFhpAQJlk0aspIo+IyM8Bo03N5mM3NUGF5
 UqHlHjpqdeanUhYcDpg5+rL4vvdgTd4jy9Mr0/Ws731nDArcl/IRs0XCW5h5MkAxBI
 AapQknCovY5wTJ9RnCkxBqEmeIuSTLEjMUpU/CLuqZGSo9bxNYDWIkRzdVZy6Q+tRX
 5gX2uyF6Zv3VAIfJFW3YXsQDfY6Uz2Ewsyl1Co+TB0AANUeTy393YBQGf92tEgFpA1
 If9QmyRT4o4A3W83rzDHpvr1X2NtpFUOs/2kwE6R7nR8qPK1F+hc+dNRbB3q3ey34S
 xr8RTsHEslH+A==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Josh Law <josh2@disroot.org>
Subject: [PATCH 1/1] armv8: reduce core errata dispatch work
Date: Sun, 24 May 2026 12:38:22 +0000
Message-ID: <20260524123822.7244-2-josh2@disroot.org>
In-Reply-To: <20260524123822.7244-1-josh2@disroot.org>
References: <20260524123822.7244-1-josh2@disroot.org>
MIME-Version: 1.0
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

apply_core_errata() currently runs both Cortex A53 and A57 part
checks even when no matching erratum is built in. For boards with no
ARM core errata, that means two MIDR_EL1 reads and two comparisons
on every CPU entry before lowlevel_init().

Only build the dispatch code when one of the supported errata is
enabled. When A57 errata are enabled, read MIDR_EL1 once and reuse
the extracted part number.

Measured on qemu_arm64_defconfig and ls2080aqds_qspi_defconfig:

Case                         before   after
qemu start.o text bytes      392      336
qemu linked text bytes       1437007  1436963
qemu dispatch instructions   15       1
ls2080 start.o text bytes    600      576
ls2080 dispatch instructions 33       26

A KVM virt microbench using the same dispatch instruction sequences
and one million calls gave:

Case            before ticks/call  after ticks/call  speedup
no errata path  27.09              20.78             1.30x
A57 miss path   28.93              26.50             1.09x

Signed-off-by: Josh Law <josh2@disroot.org>
---
 arch/arm/cpu/armv8/start.S | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 40c342e97e9..5c847ed0f85 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -209,30 +209,41 @@ master_cpu:
 
 /*-----------------------------------------------------------------------*/
 
+#if defined(CONFIG_ARM_ERRATA_826974) || defined(CONFIG_ARM_ERRATA_828024) || \
+	defined(CONFIG_ARM_ERRATA_829520) || defined(CONFIG_ARM_ERRATA_833069) || \
+	defined(CONFIG_ARM_ERRATA_833471)
+#define ARMV8_CORTEX_A57_ERRATA
+#endif
+
 WEAK(apply_core_errata)
 
+#if defined(CONFIG_ARM_ERRATA_855873) || defined(ARMV8_CORTEX_A57_ERRATA)
 	mov	x29, lr			/* Save LR */
 	/* For now, we support Cortex-A53, Cortex-A57 specific errata */
+	mrs	x0, midr_el1
+	ubfx	x1, x0, #4, #12		/* CPU part number */
 
-	/* Check if we are running on a Cortex-A53 core */
-	branch_if_a53_core x0, apply_a53_core_errata
+#ifdef CONFIG_ARM_ERRATA_855873
+	cmp	x1, #0xD03		/* Cortex-A53 MPCore processor */
+	b.eq	apply_a53_core_errata
+#endif
 
-	/* Check if we are running on a Cortex-A57 core */
-	branch_if_a57_core x0, apply_a57_core_errata
+#ifdef ARMV8_CORTEX_A57_ERRATA
+	cmp	x1, #0xD07		/* Cortex-A57 MPCore processor */
+	b.eq	apply_a57_core_errata
+#endif
 0:
 	mov	lr, x29			/* Restore LR */
+#endif
 	ret
 
-apply_a53_core_errata:
-
 #ifdef CONFIG_ARM_ERRATA_855873
-	mrs	x0, midr_el1
+apply_a53_core_errata:
 	tst	x0, #(0xf << 20)
 	b.ne	0b
 
-	mrs	x0, midr_el1
-	and	x0, x0, #0xf
-	cmp	x0, #3
+	and	x1, x0, #0xf
+	cmp	x1, #3
 	b.lt	0b
 
 	mrs	x0, S3_1_c15_c2_0	/* cpuactlr_el1 */
@@ -240,9 +251,10 @@ apply_a53_core_errata:
 	orr	x0, x0, #1 << 44
 	msr	S3_1_c15_c2_0, x0	/* cpuactlr_el1 */
 	isb
-#endif
 	b 0b
+#endif
 
+#ifdef ARMV8_CORTEX_A57_ERRATA
 apply_a57_core_errata:
 
 #ifdef CONFIG_ARM_ERRATA_828024
@@ -294,6 +306,7 @@ apply_a57_core_errata:
 	isb
 #endif
 	b 0b
+#endif
 ENDPROC(apply_core_errata)
 
 /*-----------------------------------------------------------------------*/
-- 
2.47.3

