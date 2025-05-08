Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E15C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C482182977;
	Thu,  8 May 2025 23:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="NjcgnRGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C278297E; Thu,  8 May 2025 23:23:55 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 145B082952
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739432; x=1746998632;
 bh=gTO8Up7rlrzS/NlZvZ8620TmChKP+eJMNInAHApsGdc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=NjcgnRGAlO916Yopr7bY+172IYeh/x95kAmSXVbCRFxS54aa1XrmIRXuLNJCrZZG8
 fM/9CnwYb99GExS/u0v62KYD3XT6q6R5ucEuRGWj4Zyf4s8WnDIeNjkiH7vvgiMzY3
 rxv12OjVlgnVQxn+0WfoNInpr1muBcgtQOUFR6oqXEVHufXkj09qanF+aWXRgIG8S+
 1NuHqj62kFF8AzifQGsIQrqnq6y2gH5AdelyRxgva+1/Ric1vaiNyBEhZRDnujP/cy
 f0Zc7JjYluJA04ezP7E+8jLTBOi7GKj/te05ZmT5rN3rkcClLWcj0Xxl9x2BTUHReJ
 KHOjdRZmFxMkQ==
Date: Thu, 08 May 2025 21:23:46 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 01/10] arm: mach-stm32: stm32h7: add initial lowlevel early
 function
Message-ID: <20250508212058.640483-2-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 1eff0b9179569a08bfbe00563f481606f8f7e400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add new assembly function 'arch_very_early_init'

This functions setups the power supply for STM32H7 SoC's to
direct SMPS mode, which is required for some boards like
the STM32H747I-DISCO in the default configuration.

If this isn't done in an early stage it cause a deadlock and
also the SoC is running in a limited mode according to the
TRM from the SoC.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32/stm32h7/lowlevel.S | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 arch/arm/mach-stm32/stm32h7/lowlevel.S

diff --git a/arch/arm/mach-stm32/stm32h7/lowlevel.S b/arch/arm/mach-stm32/s=
tm32h7/lowlevel.S
new file mode 100644
index 00000000000..97f4e383e3b
--- /dev/null
+++ b/arch/arm/mach-stm32/stm32h7/lowlevel.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025, Johannes Krottmayer <johannes@krotti42.com>
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * STM32H7 PWR registers
+ */
+#define PWR_CR3=09=09=090x5802480C
+#define PWR_CR3_LDOEN=09=091
+
+#define PWR_CSR1=09=09=090x58024804
+#define PWR_CSR1_ACTVOSRDY=0913
+
+ENTRY(arch_very_early_init)
+=09/*
+=09 * Setup power supply for STM32H7 to direct SMPS mode.
+=09 * This is the default configuration from some boards
+=09 * like the SMT32H747i-DISCO.
+=09 *
+=09 * If these steps will not be done, this cause a deadlock.
+=09 */
+=09ldr r6, =3DPWR_CR3
+=09/* Disable LDO */
+=09movs r0, #1
+=09lsl r1, r0, #PWR_CR3_LDOEN
+=09mvn r2, r1
+=09ldr r3, [r6]
+=09and r3, r2
+=09str r3, [r6]
+=09lsl r1, r0, #PWR_CSR1_ACTVOSRDY
+
+=09/* Loop until ACTVOSRDY is valid */
+1:
+=09ldr r6, =3DPWR_CSR1
+=09ldr r3, [r6]
+=09and r3, r1
+=09cmp r3, r1
+=09bne 1b
+
+=09/* Jump back to C runtime setup */
+=09bx lr
+ENDPROC(arch_very_early_init)
--=20
2.39.5


