Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D06C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D1588158;
	Mon, 15 Apr 2024 18:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oltKEC/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07E087A0E; Mon, 15 Apr 2024 18:30:57 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2DB87B35
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id ED3DCCE0E63;
 Mon, 15 Apr 2024 16:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D93C113CC;
 Mon, 15 Apr 2024 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198653;
 bh=6Ax4fjG2eoBsLYf4FK6S+51VCHoVxPX3L2ALo9cV7iY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oltKEC/Px7ulbath58bgFsgokqjglq2wjiq9JPDux1eT+ks+Ff2FhdsYnrTO1P2sz
 sKUIlVimJwAbA9Eo/6CIqiSkO41223gLV8cFJadBqcTQum4S8Q4uYn3N02y+8X03IV
 atuLJ3CQAHtWpDBqy4ujMCWV8C9kWa6POwB7GMWkCpdmNKSsQbx1GdeqoXr6BnYWWa
 G8wVa9nNNnYbU/IwNMou2VL4X3Npo/F6xuI6XIu9WwcjKtzcLEmtCZn6ovurISQfb+
 SVrZQLZnyG4ZFTpUDnk7TncTUz9KXzB87JV9gYCE5RTazdhZatmFKpPoXbhoywpnEE
 T8BZriVXUQvLA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 04/10] ddr: marvell: a38x: debug: Allow compiling
 with immutable debug settings to reduce binary size
Date: Mon, 15 Apr 2024 18:30:37 +0200
Message-ID: <20240415163043.7482-5-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415163043.7482-1-kabel@kernel.org>
References: <20240415163043.7482-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Allow compiling with immutable debug settings:
- DEBUG_LEVEL is always set to DEBUG_LEVEL_ERROR
- register dumps are disabled

This can save around 10 KiB of space in the resulting binary, which is a
lot in U-Boot SPL.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Kconfig           | 10 +++++++
 drivers/ddr/marvell/a38x/ddr3_debug.c |  9 ++++--
 drivers/ddr/marvell/a38x/ddr3_init.c  |  3 +-
 drivers/ddr/marvell/a38x/ddr3_init.h  | 42 ++++++++++++++++++++++-----
 4 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index f15d3cc5ed..a320793a30 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -250,6 +250,16 @@ config DDR_LOG_LEVEL
 	  At level 3, rovides the windows margin of each DQ as a results of
 	  DQS centeralization.
 
+config DDR_IMMUTABLE_DEBUG_SETTINGS
+	bool "Immutable DDR debug level (always DEBUG_LEVEL_ERROR)"
+	depends on ARMADA_38X
+	help
+	  Makes the DDR training code debug level settings immutable.
+	  The debug level setting from board topology definition is ignored.
+	  The debug level is always set to DEBUG_LEVEL_ERROR and register
+	  dumps are disabled.
+	  This can save around 10 KiB of space in SPL binary.
+
 config DDR_RESET_ON_TRAINING_FAILURE
 	bool "Reset the board on DDR training failure instead of hanging"
 	depends on ARMADA_38X || ARMADA_XP
diff --git a/drivers/ddr/marvell/a38x/ddr3_debug.c b/drivers/ddr/marvell/a38x/ddr3_debug.c
index d32d42c408..0b65168d82 100644
--- a/drivers/ddr/marvell/a38x/ddr3_debug.c
+++ b/drivers/ddr/marvell/a38x/ddr3_debug.c
@@ -7,18 +7,21 @@
 #include "mv_ddr_training_db.h"
 #include "mv_ddr_regs.h"
 
+#if !defined(CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS)
 u8 is_reg_dump = 0;
 u8 debug_pbs = DEBUG_LEVEL_ERROR;
+#endif
 
 /*
  * API to change flags outside of the lib
  */
-#if defined(SILENT_LIB)
+#if defined(SILENT_LIB) || defined(CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS)
 void ddr3_hws_set_log_level(enum ddr_lib_debug_block block, u8 level)
 {
 	/* do nothing */
 }
-#else /* SILENT_LIB */
+#else /* !SILENT_LIB && !CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS */
+
 /* Debug flags for other Training modules */
 u8 debug_training_static = DEBUG_LEVEL_ERROR;
 u8 debug_training = DEBUG_LEVEL_ERROR;
@@ -104,7 +107,7 @@ void ddr3_hws_set_log_level(enum ddr_lib_debug_block block, u8 level)
 #endif /* CONFIG_DDR4 */
 	}
 }
-#endif /* SILENT_LIB */
+#endif /* !SILENT_LIB && !CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS */
 
 #if defined(DDR_VIEWER_TOOL)
 static char *convert_freq(enum mv_ddr_freq freq);
diff --git a/drivers/ddr/marvell/a38x/ddr3_init.c b/drivers/ddr/marvell/a38x/ddr3_init.c
index 27eb3ac173..7c5147f474 100644
--- a/drivers/ddr/marvell/a38x/ddr3_init.c
+++ b/drivers/ddr/marvell/a38x/ddr3_init.c
@@ -41,7 +41,8 @@ int ddr3_init(void)
 	mv_ddr_pre_training_soc_config(ddr_type);
 
 	/* Set log level for training library */
-	mv_ddr_user_log_level_set(DEBUG_BLOCK_ALL);
+	if (!IS_ENABLED(CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS))
+		mv_ddr_user_log_level_set(DEBUG_BLOCK_ALL);
 
 	mv_ddr_early_init();
 
diff --git a/drivers/ddr/marvell/a38x/ddr3_init.h b/drivers/ddr/marvell/a38x/ddr3_init.h
index 9288073a78..b513a13c53 100644
--- a/drivers/ddr/marvell/a38x/ddr3_init.h
+++ b/drivers/ddr/marvell/a38x/ddr3_init.h
@@ -45,15 +45,46 @@ enum log_level  {
 #define MISL_PHY_ODT_N_OFFS	0x0
 
 /* Globals */
-extern u8 debug_training, debug_calibration, debug_ddr4_centralization,
-	debug_tap_tuning, debug_dm_tuning;
+#if defined(CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS)
+static const u8 is_reg_dump = 0;
+static const u8 debug_training_static = DEBUG_LEVEL_ERROR;
+static const u8 debug_training = DEBUG_LEVEL_ERROR;
+static const u8 debug_leveling = DEBUG_LEVEL_ERROR;
+static const u8 debug_centralization = DEBUG_LEVEL_ERROR;
+static const u8 debug_training_ip = DEBUG_LEVEL_ERROR;
+static const u8 debug_training_bist = DEBUG_LEVEL_ERROR;
+static const u8 debug_training_hw_alg = DEBUG_LEVEL_ERROR;
+static const u8 debug_training_access = DEBUG_LEVEL_ERROR;
+static const u8 debug_training_device = DEBUG_LEVEL_ERROR;
+static const u8 debug_pbs = DEBUG_LEVEL_ERROR;
+
+static const u8 debug_tap_tuning = DEBUG_LEVEL_ERROR;
+static const u8 debug_calibration = DEBUG_LEVEL_ERROR;
+static const u8 debug_ddr4_centralization = DEBUG_LEVEL_ERROR;
+static const u8 debug_dm_tuning = DEBUG_LEVEL_ERROR;
+#else /* !CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS */
 extern u8 is_reg_dump;
+extern u8 debug_training_static;
+extern u8 debug_training;
+extern u8 debug_leveling;
+extern u8 debug_centralization;
+extern u8 debug_training_ip;
+extern u8 debug_training_bist;
+extern u8 debug_training_hw_alg;
+extern u8 debug_training_access;
+extern u8 debug_training_device;
+extern u8 debug_pbs;
+
+extern u8 debug_tap_tuning;
+extern u8 debug_calibration;
+extern u8 debug_ddr4_centralization;
+extern u8 debug_dm_tuning;
+#endif /* !CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS */
+
 extern u8 generic_init_controller;
 /* list of allowed frequency listed in order of enum mv_ddr_freq */
 extern u32 is_pll_old;
 extern struct pattern_info pattern_table[];
-extern u8 debug_centralization, debug_training_ip, debug_training_bist,
-	debug_pbs, debug_training_static, debug_leveling;
 extern struct hws_tip_config_func_db config_func_info[];
 extern u8 twr_mask_table[];
 extern u8 cl_mask_table[];
@@ -76,7 +107,6 @@ extern u32 g_rtt_nom;
 extern u32 g_rtt_wr;
 extern u32 g_rtt_park;
 
-extern u8 debug_training_access;
 extern u32 first_active_if;
 extern u32 delay_enable, ck_delay, ca_delay;
 extern u32 mask_tune_func;
@@ -122,8 +152,6 @@ extern u32 effective_cs;
 extern int ddr3_tip_centr_skip_min_win_check;
 extern u32 *dq_map_table;
 
-extern u8 debug_training_hw_alg;
-
 extern u32 start_xsb_offset;
 extern u32 odt_config;
 
-- 
2.43.2

