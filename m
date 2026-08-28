Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F17C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E511C4088A;
	Fri, 28 Aug 2026 13:58:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-f2N70ti_Dn; Fri, 28 Aug 2026 13:58:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925509;
	bh=k+1y1mZsoC3eSlDWgt5pwMmILdah9EiJkWlqBguyy/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y4tC+Dmmw9gHyEGaLhFt/pfPGwisZsqATplYCPowQ2XrrxFUIX3w9MpHzvfBnM1eA
	 wSGe65/f27lNLZSRwmOPOJi0hLL0job1ArpzMVOT9YguIPkkGKUGOpbR2lLcvMgFfd
	 dkYrzm+9rTVHi+FnQiqjvtC1I1UfP/a9+1DH7vsosdel/ZTy89wIZYWJQUkq8fH/gA
	 K1YOXG/R3mA2xozECHE0ACutgelDe7eDsjxWBfNArkybcyf4jMo4z4coAjqeSjYrJP
	 6YjVrowMKuVGw1f/X9aukSEW/zB/MwM5aqSPLLvK+vL2taroYZ+U7cGPFpxzXyP3Vq
	 ANE7yC+dtRVBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CDF240861;
	Fri, 28 Aug 2026 13:58:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA772386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC70A403A1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8kL6mrgnpDC for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=hG2WQtIZ
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B594240317
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D8B1A4E41402;
 Fri, 28 Aug 2026 13:58:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A585C60537;
 Fri, 28 Aug 2026 13:58:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CD19D11C781B3; 
 Fri, 28 Aug 2026 15:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925501; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=k+1y1mZsoC3eSlDWgt5pwMmILdah9EiJkWlqBguyy/A=;
 b=hG2WQtIZjVCK+4xh+xJv5D6bqz8/FFmxKKqpvBQWF52TujSDtAD+qEDLmipNfCf0FjQSPe
 JBcg0fT4wkHEI+ppUFOoZGf3dUauiSC7inLMJAAE3a4uVUXCGap7kwdyIFFc4dWqdozU8u
 RV5R5HHzSEcU0TFMe08n4m+nf22uwrTXilMS0EWhVRK4oV/BIJKpbia9XT2uEiSoGNbI+w
 Sv1fXaSqPFaM9YfXGZDomnIaACe9UQRgo0Ur5nKyUZFV72ecDkYjf3x/VDDMN33L77zaRM
 JdtAGtGE5ecYeiiTpo5K+I4QfBCTJ1JyFmbhwZtelMd+3mvynfMJ30E4VEqUqA==
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
Subject: [PATCH v5 10/21] board: mach-k3: r5: common: Store wakeup reason on
 scratchpad memory
Date: Fri, 28 Aug 2026 15:57:19 +0200
Message-ID: <20260828135730.1565643-11-richard.genoud@bootlin.com>
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

While resuming from suspend, the wakeup reason need to be stored
and this will be used by the Linux kernel once its up.

Use the 32 bytes of MCU_PSRAM0_RAM area (addr = 0x40280000) to
store the wakeup reason.

Read the value as soon as it starts and store it internally.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/Kconfig         | 10 ++++++++++
 arch/arm/mach-k3/r5/lpm-common.c | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..bbb62fa617fc 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -101,6 +101,16 @@ config SYS_K3_BOOT_CORE_ID
 	int
 	default 16
 
+config SYS_K3_SCRATCH_LPM_ADDR
+	hex
+	default 0x40280000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J784S4
+	default 0x0
+	help
+	  Address where the wake-up reason is stored at resume (32 bits).
+	  It will be read by the Linux kernel once its up.
+	  On J7200/J784s4 the MCU_PSRAM0_RAM is used by default.
+	  Set it to 0 if unused.
+
 config K3_EARLY_CONS
 	bool "Activate to allow for an early console during SPL"
 	depends on SPL
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 559e1b5f681a..0e5feae6d12d 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -29,6 +29,11 @@
 /* PMIC register where the magic value resides */
 #define K3_LPM_SCRATCH_PAD_REG_3 0xcb
 
+/* Wake-up source IDs */
+#define K3_LPM_WAKE_SOURCE_MAIN_IO 0x80
+#define K3_LPM_WAKE_SOURCE_MCU_IO 0x81
+#define K3_LPM_WAKE_SOURCE_PMIC_GPIO 0xB0
+
 #define IO_ISO_STATUS BIT(25)
 #define FW_IMAGE_SIZE 0x80000
 
@@ -40,6 +45,11 @@ struct lpm_addr_info {
 	u32 size;
 };
 
+struct lpm_scratch_space {
+	u16 wake_src;
+	u16 reserved;
+} __packed;
+
 __weak void clear_isolation(void) { }
 
 /* This is used by J722s */
@@ -75,6 +85,7 @@ void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
 /* in board_init_f(), there's no BSS, so we can't use global/static variables */
 bool j7xx_board_is_resuming(void)
 {
+	struct lpm_scratch_space *lpm_scratch;
 	struct udevice *pmic, *i2c;
 	u32 pmctrl_val = 0;
 	int ret, magic;
@@ -85,7 +96,18 @@ bool j7xx_board_is_resuming(void)
 #ifdef PMCTRL_IO_LPM
 	pmctrl_val = readl(PMCTRL_IO_LPM);
 #endif
+	lpm_scratch = (struct lpm_scratch_space *)CONFIG_SYS_K3_SCRATCH_LPM_ADDR;
+	if (lpm_scratch) {
+		lpm_scratch->wake_src = 0;
+		lpm_scratch->reserved = 0;
+	}
 	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		if (lpm_scratch) {
+			if (IS_ENABLED(CONFIG_SOC_K3_J784S4))
+				lpm_scratch->wake_src = K3_LPM_WAKE_SOURCE_MCU_IO;
+			else
+				lpm_scratch->wake_src = K3_LPM_WAKE_SOURCE_MAIN_IO;
+		}
 		clear_isolation();
 		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
 		debug("board is resuming from IO_DDR mode\n");
@@ -127,6 +149,8 @@ bool j7xx_board_is_resuming(void)
 
 	if (magic == K3_LPM_MAGIC_SUSPEND) {
 		debug("%s: board is resuming\n", __func__);
+		if (lpm_scratch)
+			lpm_scratch->wake_src = K3_LPM_WAKE_SOURCE_PMIC_GPIO;
 		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
 
 		/* clean magic suspend */
