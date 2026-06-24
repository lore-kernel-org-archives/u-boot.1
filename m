Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3BECDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B1F849ED;
	Wed, 24 Jun 2026 09:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="AnrO56jG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069A384A26; Wed, 24 Jun 2026 09:45:34 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D8C84A0B
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AEDD94E407B2;
 Wed, 24 Jun 2026 07:45:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7D5BF601C5;
 Wed, 24 Jun 2026 07:45:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 49B9C106C85CF; 
 Wed, 24 Jun 2026 09:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782287129; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=1H0w5GbHirg2OohcwmMAN9xkH8jpdDKfgtPWGCWLEsQ=;
 b=AnrO56jGFyEhQRhCf16mNn9UUmDSjHhFPlXVqpat0b95zPfr8m8FLRQf8ovN6vKf37cks7
 NQB1NGqdDffp7VqO331699VM5/VA0O4crcUkheZ905eddqDfXEFfljVCamLc2l/pY1rXCK
 kHgGAGH73i2PTIljwr1VQwCdAKsUfisoE2I2l1kvDeVhFdzfCJ5NT7ZQHByGnJrdENi9yK
 hBTqd0LbsIsmdMlfGrfKh6mD/12T1UUCP6n9IivSvkGKwMycjrnnIeMfKIJC6hISv6JihZ
 Oh2anwaGx9P6ga09xFQgjyak1D2g2Tk2Ax7O2IMRr2r9tbj0X0OI4cKragWrjw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v3 09/19] board: mach-k3: r5: common: Set PMIC NSLEEP triggers
 bits at resume
Date: Wed, 24 Jun 2026 09:44:49 +0200
Message-ID: <20260624074459.873906-10-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624074459.873906-1-richard.genoud@bootlin.com>
References: <20260624074459.873906-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

If we are resuming NSLEEP triggers bits of PMIC-A and PMIC-B shall be set
to prevent transition to S2R state while clearing interrupts.
For example PMIC RTC Linux driver accesses to interrupt registers, in this
case if NSLEEP triggers bits are not set it triggers a S2R transition.

Suggested-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 862f5ab62a3d..426166006afa 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -29,6 +29,9 @@
 /* PMIC register where the magic value resides */
 #define K3_LPM_SCRATCH_PAD_REG_3 0xcb
 
+/* PMIC NSLEEP register */
+#define K3_LPM_NSLEEP_TRIGGER_REG 0x86
+
 /* Wake-up source IDs */
 #define K3_LPM_WAKE_SOURCE_MAIN_IO 0x80
 #define K3_LPM_WAKE_SOURCE_MCU_IO 0x81
@@ -161,6 +164,30 @@ bool j7xx_board_is_resuming(void)
 
 		if (ret)
 			printf("Failed to clean magic value for suspend detection in PMIC\n");
+
+		/*
+		 * Ensure that NSLEEP triggers bits are set to prevent a
+		 * suspend/resume transition when accessing PMIC interrupt
+		 * registers.
+		 */
+		if (IS_ENABLED(CONFIG_SOC_K3_J722S)) {
+			ret = dm_i2c_reg_write(pmic, K3_LPM_NSLEEP_TRIGGER_REG, 0x3);
+		} else {
+			struct udevice *pmic_b;
+
+			/* Some boards may have more than one pmic */
+			ret = uclass_get_device_by_name(UCLASS_PMIC, "pmic@4c", &pmic_b);
+			if (ret == 0) {
+				ret = pmic_reg_write(pmic_b, K3_LPM_NSLEEP_TRIGGER_REG, 0x03);
+				if (ret)
+					printf("Failed to set NSLEEP triggers bits on PMIC-B\n");
+			}
+
+			ret = pmic_reg_write(pmic, K3_LPM_NSLEEP_TRIGGER_REG, 0x3);
+		}
+		if (ret)
+			printf("Failed to set PMIC NSLEEP triggers. Spurious suspend/resume may happen.\n");
+
 		/*
 		 * For robustness, the DM should also clean the magic value at
 		 * startup.
