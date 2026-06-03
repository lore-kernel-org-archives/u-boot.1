Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956A8CD6E64
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BBB848DC;
	Wed,  3 Jun 2026 11:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="K5iAKzew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65069848EB; Wed,  3 Jun 2026 11:55:15 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB188469D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 27F904E42D80;
 Wed,  3 Jun 2026 09:55:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EAA765FFA8;
 Wed,  3 Jun 2026 09:55:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D64B010888CC5; 
 Wed,  3 Jun 2026 11:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480511; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=OzaM13L/ST2g7hwV9PkPSIL3xQKMrOIF7y5jxUdDxm8=;
 b=K5iAKzewsgkoKKgXE+omXNfKhAfoGz7rvlJxze4zsn4DcFZVxxTuJ7Hksg2kAEBdhRAqrz
 KaLBud0VWqO1VsVAMEBotTiMLRWTCeSbCl9yRqHIqVWit+LMfiA3cwD8bjl87ILrDOYOqp
 ZakXswEbAZxzstiJI+V6Res/Zow1UESOD+hnXzBm7MRu9uMZ5NopqmbdYxzdw4WS4kRzvd
 sLO5g2k6CrypRq5J0kfQMl2FydiUJGgZiTy6MUe7PElpyrAa+qMlOoIb9T4OFaqU2q8L7C
 hH2cTEDPptHXSpDDZrgleiTyLB2uhdQbUhq0534mT8i5yP6q52wwL4lqcExwMw==
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
Subject: [PATCH v2 06/16] board: ti: evm: Store wakeup reason on scratchpad
 memory
Date: Wed,  3 Jun 2026 11:54:39 +0200
Message-ID: <20260603095449.2089514-7-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603095449.2089514-1-richard.genoud@bootlin.com>
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
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
index 4b7cef64935c..667e23bf2293 100644
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
index 1b3660f8243b..539a2207f986 100644
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
@@ -48,6 +58,7 @@ __weak void ctrl_mmr_unlock(void) { }
 /* in board_init_f(), there's no BSS, so we can't use global/static variables */
 bool j7xx_board_is_resuming(void)
 {
+	struct lpm_scratch_space *lpm_scratch;
 	struct udevice *pmic, *i2c;
 	u32 pmctrl_val = 0;
 	int ret;
@@ -58,7 +69,18 @@ bool j7xx_board_is_resuming(void)
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
@@ -100,6 +122,8 @@ bool j7xx_board_is_resuming(void)
 
 	if (ret == K3_LPM_MAGIC_SUSPEND) {
 		debug("%s: board is resuming\n", __func__);
+		if (lpm_scratch)
+			lpm_scratch->wake_src = K3_LPM_WAKE_SOURCE_PMIC_GPIO;
 		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
 
 		/* clean magic suspend */
-- 
2.47.3

