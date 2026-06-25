Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4368CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 07:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BA9849EE;
	Thu, 25 Jun 2026 09:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QSfeyvIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF34849E5; Thu, 25 Jun 2026 09:15:39 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2CA80398
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6C586C5CD4A;
 Thu, 25 Jun 2026 07:15:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2871B5FF03;
 Thu, 25 Jun 2026 07:15:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E0AD5106C8077; 
 Thu, 25 Jun 2026 09:15:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782371735; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=1H0w5GbHirg2OohcwmMAN9xkH8jpdDKfgtPWGCWLEsQ=;
 b=QSfeyvIWE4oBgYGCHRJ80a+ArA8/y6IjTFEYMMc3WDhNiUjD/DHVHfk/IeY3vDb/ffIH5U
 B/GU89r7hPNJ4i7Rh/pboy8L5rKRqQChp2/7g2mmi+zTSV12eIMPMQt1ui4T+TiRcR4n4l
 aR3APx/5LuKtML35ZteowwEbc8vr1oCnvZZrVflxyRUfz0zLz2/TmIX/ftFHg2/KW9p/jw
 /+Vw+apPuS0pe7IHDSxHAkn92VONmZHonISwcrkfZ3RcL4RGmPFplVrR3RxAgc4FjA27Dy
 r7NoTmgHMHmzZ0fFB4mML8X3owhWsjrCN3nXHJs4wcXc2Ec3e9m54PCLkxTxeQ==
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
Subject: [PATCH v4 09/19] board: mach-k3: r5: common: Set PMIC NSLEEP triggers
 bits at resume
Date: Thu, 25 Jun 2026 09:15:05 +0200
Message-ID: <20260625071515.91243-10-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625071515.91243-1-richard.genoud@bootlin.com>
References: <20260625071515.91243-1-richard.genoud@bootlin.com>
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
