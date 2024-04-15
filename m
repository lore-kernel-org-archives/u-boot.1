Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B038EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8723E87E75;
	Mon, 15 Apr 2024 18:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kDNRuBqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F3387F16; Mon, 15 Apr 2024 18:31:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B4E88005
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1E49A60F09;
 Mon, 15 Apr 2024 16:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212C9C2BD10;
 Mon, 15 Apr 2024 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198658;
 bh=27PJYr1fnta4DIY5G1TpH+wfZjakss/6D9J/Vq9+K8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kDNRuBqiFzR1YE+fIY6WfxLG11OVtWF/0kbisstM9/Ge26nrT+qqZ98Qpv8P2axCn
 Is2LpgkjRW+m+YIqh64N+JdOnKon1ucU3rEu7EOls5HvDaf293OYSlKzm2bEboANzv
 Q7nMdmbueLqy4qyPUxL5k8Dd+bPuYJTPYDg2qClPoKmJ+8jJodVxnKuFVlpWBeN+Cq
 b3d/WD9qc3Azg/9XNiH2vFiObXCfQ1ELTi2rnZnJiBAFVBhmm/X2IJw357Qc9Z9p0W
 rkkTEVwJNz7WzZbQtXnc5gyjC+mah52gw7VS4EtbZZaKQXNkS4jjH710p/I/CfvUlr
 z3hrMUyUL7B2g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 08/10] ddr: marvell: a38x: old: Backport
 immutable debug settings
Date: Mon, 15 Apr 2024 18:30:41 +0200
Message-ID: <20240415163043.7482-9-kabel@kernel.org>
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

Backport the option to compile with immutable debug settings also to
the old implementation of the DDR3 training code.

The original PR for mv-ddr-marvell can be seen at
  https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/45/

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/ddr/marvell/a38x/old/ddr3_debug.c | 32 ++++++++++++++----
 drivers/ddr/marvell/a38x/old/ddr3_init.c  |  3 +-
 drivers/ddr/marvell/a38x/old/ddr3_init.h  | 40 ++++++++++++++---------
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/ddr/marvell/a38x/old/ddr3_debug.c b/drivers/ddr/marvell/a38x/old/ddr3_debug.c
index a704a3e9d3..e1ae46dc82 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_debug.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_debug.c
@@ -13,13 +13,15 @@
 
 #include "ddr3_init.h"
 
+#if !defined(CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS)
 u8 is_reg_dump = 0;
 u8 debug_pbs = DEBUG_LEVEL_ERROR;
+#endif
 
 /*
  * API to change flags outside of the lib
  */
-#ifndef SILENT_LIB
+#if !defined(SILENT_LIB) && !defined(CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS)
 /* Debug flags for other Training modules */
 u8 debug_training_static = DEBUG_LEVEL_ERROR;
 u8 debug_training = DEBUG_LEVEL_ERROR;
@@ -84,12 +86,13 @@ void ddr3_hws_set_log_level(enum ddr_lib_debug_block block, u8 level)
 #endif
 
 struct hws_tip_config_func_db config_func_info[HWS_MAX_DEVICE_NUM];
-u8 is_default_centralization = 0;
-u8 is_tune_result = 0;
-u8 is_validate_window_per_if = 0;
-u8 is_validate_window_per_pup = 0;
-u8 sweep_cnt = 1;
-u32 is_bist_reset_bit = 1;
+
+#if 0
+static u8 is_validate_window_per_if = 0;
+static u8 is_validate_window_per_pup = 0;
+static u8 sweep_cnt = 1;
+#endif
+
 static struct hws_xsb_info xsb_info[HWS_MAX_DEVICE_NUM];
 
 /*
@@ -292,6 +295,7 @@ int print_device_info(u8 dev_num)
 	return MV_OK;
 }
 
+#if 0
 void hws_ddr3_tip_sweep_test(int enable)
 {
 	if (enable) {
@@ -304,6 +308,7 @@ void hws_ddr3_tip_sweep_test(int enable)
 	}
 }
 #endif
+#endif
 
 char *ddr3_tip_convert_tune_result(enum hws_result tune_result)
 {
@@ -327,6 +332,7 @@ int ddr3_tip_print_log(u32 dev_num, u32 mem_addr)
 	u32 if_id = 0;
 	struct hws_topology_map *tm = ddr3_get_topology_map();
 
+#if 0
 #ifndef EXCLUDE_SWITCH_DEBUG
 	if ((is_validate_window_per_if != 0) ||
 	    (is_validate_window_per_pup != 0)) {
@@ -347,8 +353,18 @@ int ddr3_tip_print_log(u32 dev_num, u32 mem_addr)
 		CHECK_STATUS(ddr3_tip_restore_dunit_regs(dev_num));
 		ddr3_tip_reg_dump(dev_num);
 	}
+#endif
 #endif
 
+	/* return early if we won't print anything anyway */
+	if (
+#if defined(SILENT_LIB)
+	    1 ||
+#endif
+	    debug_training < DEBUG_LEVEL_INFO) {
+		return MV_OK;
+	}
+
 	for (if_id = 0; if_id <= MAX_INTERFACE_NUM - 1; if_id++) {
 		VALIDATE_ACTIVE(tm->if_act_mask, if_id);
 
@@ -789,6 +805,7 @@ int ddr3_tip_print_adll(void)
 	return MV_OK;
 }
 
+#if 0
 /*
  * Set attribute value
  */
@@ -1156,6 +1173,7 @@ static int ddr3_tip_access_atr(u32 dev_num, u32 flag_id, u32 value, u32 **ptr)
 
 	return MV_OK;
 }
+#endif
 
 #ifndef EXCLUDE_SWITCH_DEBUG
 /*
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_init.c b/drivers/ddr/marvell/a38x/old/ddr3_init.c
index 55baad498a..7230bc2a86 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_init.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_init.c
@@ -386,7 +386,8 @@ int ddr3_init(void)
 		return status;
 
 	/* Set log level for training lib */
-	ddr3_hws_set_log_level(DEBUG_BLOCK_ALL, DEBUG_LEVEL_ERROR);
+	if (!IS_ENABLED(CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS))
+		ddr3_hws_set_log_level(DEBUG_BLOCK_ALL, DEBUG_LEVEL_ERROR);
 
 	/* Start New Training IP */
 	status = ddr3_hws_hw_training();
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_init.h b/drivers/ddr/marvell/a38x/old/ddr3_init.h
index ad95cc9ef8..5090cf97a7 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_init.h
+++ b/drivers/ddr/marvell/a38x/old/ddr3_init.h
@@ -152,17 +152,38 @@ enum log_level  {
 };
 
 /* Globals */
-extern u8 debug_training;
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
+static const u8 debug_training_a38x = DEBUG_LEVEL_ERROR;
+static const u8 debug_pbs = DEBUG_LEVEL_ERROR;
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
+extern u8 debug_training_a38x;
+extern u8 debug_pbs;
+#endif /* !CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS */
+
 extern u8 generic_init_controller;
 extern u32 freq_val[];
 extern u32 is_pll_old;
 extern struct cl_val_per_freq cas_latency_table[];
 extern struct pattern_info pattern_table[];
 extern struct cl_val_per_freq cas_write_latency_table[];
-extern u8 debug_training;
-extern u8 debug_centralization, debug_training_ip, debug_training_bist,
-	debug_pbs, debug_training_static, debug_leveling;
 extern u32 pipe_multicast_mask;
 extern struct hws_tip_config_func_db config_func_info[];
 extern u8 cs_mask_reg[];
@@ -186,8 +207,6 @@ extern u32 g_dic;
 extern u32 g_odt_config;
 extern u32 g_rtt_nom;
 
-extern u8 debug_training_access;
-extern u8 debug_training_a38x;
 extern u32 first_active_if;
 extern enum hws_ddr_freq init_freq;
 extern u32 delay_enable, ck_delay, ck_delay_16, ca_delay;
@@ -227,7 +246,6 @@ extern u32 znri_data_phy_val;
 extern u32 zpri_data_phy_val;
 extern u32 znri_ctrl_phy_val;
 extern u32 zpri_ctrl_phy_val;
-extern u8 debug_training_access;
 extern u32 finger_test, p_finger_start, p_finger_end, n_finger_start,
 	n_finger_end, p_finger_step, n_finger_step;
 extern u32 mode2_t;
@@ -243,8 +261,6 @@ extern u32 freq_mask[HWS_MAX_DEVICE_NUM][DDR_FREQ_LIMIT];
 extern u32 start_pattern, end_pattern;
 
 extern u32 maxt_poll_tries;
-extern u32 is_bist_reset_bit;
-extern u8 debug_training_bist;
 
 extern u8 vref_window_size[MAX_INTERFACE_NUM][MAX_BUS_NUM];
 extern u32 debug_mode;
@@ -252,20 +268,16 @@ extern u32 effective_cs;
 extern int ddr3_tip_centr_skip_min_win_check;
 extern u32 *dq_map_table;
 extern enum auto_tune_stage training_stage;
-extern u8 debug_centralization;
 
 extern u32 delay_enable;
 extern u32 start_pattern, end_pattern;
 extern u32 freq_val[DDR_FREQ_LIMIT];
-extern u8 debug_training_hw_alg;
 extern enum auto_tune_stage training_stage;
 
-extern u8 debug_training_ip;
 extern enum hws_result training_result[MAX_STAGE_LIMIT][MAX_INTERFACE_NUM];
 extern enum auto_tune_stage training_stage;
 extern u32 effective_cs;
 
-extern u8 debug_leveling;
 extern enum hws_result training_result[MAX_STAGE_LIMIT][MAX_INTERFACE_NUM];
 extern enum auto_tune_stage training_stage;
 extern u32 rl_version;
@@ -276,7 +288,6 @@ extern u32 odt_config;
 extern u32 effective_cs;
 extern u32 phy_reg1_val;
 
-extern u8 debug_pbs;
 extern u32 effective_cs;
 extern u16 mask_results_dq_reg_map[];
 extern enum hws_ddr_freq medium_freq;
@@ -296,7 +307,6 @@ extern u32 init_freq;
 #endif
 /* list of allowed frequency listed in order of enum hws_ddr_freq */
 extern u32 freq_val[];
-extern u8 debug_training_static;
 extern u32 first_active_if;
 
 /* Prototypes */
-- 
2.43.2

