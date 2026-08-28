Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71704C61DD3
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1988E80F5A;
	Fri, 28 Aug 2026 13:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TcL7VDVAG5T8; Fri, 28 Aug 2026 13:58:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925495;
	bh=juzkq+Qlsic9qsyI7SMSshLQvbtgqEoonME6N+s1kcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rhNsZskClIqc8uRRv+lgRruYlW7od05wdSPWg4CvIWv8z/z0MW29bz4i3pvxRY9LC
	 u27IG6VaKrDRcc26YXf1FNvGcd6MxLaJnwWn4pVAfb33460CkPkLmEsDsZ7YF5iQNi
	 Wt5YKDqN15chqwksdQEGc/hIfEdoZRxqJqf95tX3/InLfS9LN0IsjwYs2tY06j10xL
	 iVQ5IGgsLI4YM/7bu/b7yfW8Hghu0pXimN9CmEg6l+mOOyQAmc/7H0TtXLQ4vFIWKu
	 7D+odwZdH81b0/CWwPl6SVdyRAMiyCJRfcqlg3j8Aar7GOl89myy51KzQbYeTrWHtI
	 Gk3CpyQC3J1Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72DA380F54;
	Fri, 28 Aug 2026 13:58:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D97C7334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C040B403A1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lq0izKjjQdut for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=ohuKbnlE
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A83BF40317
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9AD4D1A18A3;
 Fri, 28 Aug 2026 13:58:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6EC5260537;
 Fri, 28 Aug 2026 13:58:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7F50611C781B3; 
 Fri, 28 Aug 2026 15:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925488; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=juzkq+Qlsic9qsyI7SMSshLQvbtgqEoonME6N+s1kcM=;
 b=ohuKbnlErjdmVtdA868GpJWI+3qTynM3XcVL4Cr6zamfrjF2hQA1SZQDOdxasSbgEDhv1l
 +b2LUYYZJVwiFIO5t8kCWLKya/GLc1qPxoodRVcBK4erUA3K6TvE1eKu0IbEnnhQ25wAi4
 k1JMT0I+Z2KTH4fpHoWvc6KmZ8kQCTcIKhfpcCSt96lqfDffE5+qaVWnwNPfCfYka4mmz0
 ys2Ttc2lnsu6Yd3g5uDz752nmRDqYwfbzSc28W04d8bNnp1JarayinKrK05phs22HYat+2
 5UrCKTaBULGigjOLO5ScNv2QicitNpaglEDB7Xu2LWOR7HsXbZKXSL1gSiOwZw==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 06/21] mach-k3: r5: common: introduce
 j7xx_board_is_resuming()
Date: Fri, 28 Aug 2026 15:57:15 +0200
Message-ID: <20260828135730.1565643-7-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the capability to detect a resume on J7200, J784s4, J721e, j722s,
j721s2 SoCs.

To detect the resume, SPL searches a magic value (0xBA) in a register
of PMIC.
This value is set by DM-Firmware during the suspend sequence.

NB: As this is called in board_init_f(), there's no BSS, so we can't
use global/static variables.

NB2: For j722s HS-* devices, we need an extra call to ctrl_mmr_unlock(),
and we have to use I2C API instead of PMIC API for this to work.
This is because bind is called before anything comes up, in between either
bootrom or TIFS messing up, clearing pad config and pd config.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/common.c                |  6 ++
 arch/arm/mach-k3/include/mach/hardware.h |  1 +
 arch/arm/mach-k3/r5/lpm-common.c         | 78 +++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3be..d934f732b330 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -713,3 +713,9 @@ int spl_start_uboot(void)
 	return 0;
 }
 #endif
+
+/* if r5/lpm-common.c is compiled, this will be overridden */
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 2c771a1195f5..c45bd3747163 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -137,6 +137,7 @@ u32 get_boot_device(void);
 const char *get_reset_reason(void);
 enum k3_device_type get_device_type(void);
 int k3_fit_config_match_security_state(const char *name);
+bool j7xx_board_is_resuming(void);
 
 #define writel_verify(val, addr) \
 do { \
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 9b91081e4f0f..c1a8c8e940de 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -6,18 +6,28 @@
  * Copyright (C) 2026 Bootlin
  */
 
+#include <asm/global_data.h>
 #include <clk.h>
+#include <dm/device.h>
 #include <dm/read.h>
 #include <elf.h>
+#include <i2c.h>
 #include <linux/printk.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <power-domain.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 #include <mach/security.h>
 
 #include "../common.h"
 #include "../lpm-common.h"
 
+/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
+#define K3_LPM_MAGIC_SUSPEND 0xba
+
+/* PMIC register where the magic value resides */
+#define K3_LPM_SCRATCH_PAD_REG_3 0xcb
+
 #define FW_IMAGE_SIZE 0x80000
 
 struct lpm_addr_info {
@@ -28,9 +38,73 @@ struct lpm_addr_info {
 	u32 size;
 };
 
-__weak bool j7xx_board_is_resuming(void)
+/* This is used by J722s */
+__weak void ctrl_mmr_unlock(void) { }
+
+/* in board_init_f(), there's no BSS, so we can't use global/static variables */
+bool j7xx_board_is_resuming(void)
 {
-	return false;
+	struct udevice *pmic, *i2c;
+	int ret, magic;
+
+	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
+		goto end;
+
+	if (IS_ENABLED(CONFIG_SOC_K3_J722S)) {
+		/*
+		 * On J722S devices, i2c access fails unless MMR
+		 * registers are unlocked.
+		 * Moreover, it fails also if we use PMIC API instead of I2C API.
+		 */
+		ctrl_mmr_unlock();
+		ret = uclass_get_device_by_name(UCLASS_I2C,
+						"i2c@2b200000", &i2c);
+		if (ret) {
+			printf("Getting I2C failed: %d\n", ret);
+			goto end;
+		}
+		ret = dm_i2c_probe(i2c, 0x48, 0, &pmic);
+		if (ret) {
+			printf("Getting PMIC failed: %d\n", ret);
+			goto end;
+		}
+	} else {
+		ret = uclass_get_device_by_name(UCLASS_PMIC,
+						"pmic@48", &pmic);
+		if (ret) {
+			printf("Getting PMIC init failed: %d\n", ret);
+			goto end;
+		}
+	}
+	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
+
+	if (IS_ENABLED(CONFIG_SOC_K3_J722S))
+		magic = dm_i2c_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG_3);
+	else
+		magic = pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG_3);
+
+	if (magic == K3_LPM_MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+
+		/* clean magic suspend */
+		if (IS_ENABLED(CONFIG_SOC_K3_J722S))
+			ret = dm_i2c_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG_3, 0);
+		else
+			ret = pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG_3, 0);
+
+		if (ret)
+			printf("Failed to clean magic value for suspend detection in PMIC\n");
+		/*
+		 * For robustness, the DM should also clean the magic value at
+		 * startup.
+		 */
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
+	}
+end:
+	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
 }
 
 static const char *lpm_core_compatible;
