Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF7AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EFB88137;
	Mon, 15 Apr 2024 18:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pKVtjTR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6486787B35; Mon, 15 Apr 2024 18:31:05 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9769B881C3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C9D12CE0E62;
 Mon, 15 Apr 2024 16:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532CCC113CC;
 Mon, 15 Apr 2024 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198660;
 bh=iEKrE2Fr5gCo091ws98+jz2bIWnkzodSPU90e2vv6OE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pKVtjTR64AYjSZmKXvXQRsXpRSowrRAVigCoElDoGPHRBehP8OZ3pvu0IIsjuHdVt
 bUcYXRtkdwJEO7u9uL3z5aK/PK89RJwLRUvXdVl2IxSzoIM714b256maAz5LJQSELT
 /2jB9YwJatr6EKHC17FOT6wn+kZh8DA7UCxdv044/SQ7TRj3BNfc+rvGYOxlnvizZx
 Nc2FPX//XoxD3vFjuw54XQGbhh7AhJSIzuzIJkoHcc5o2fEB4Qj108NOg6CIifZaOT
 dgFU8/0/vM5uTnUpbvR+5yeP7FxjybLBvQlow57Q7Ip8qcAv+wUVrzuz0DR/FTQMHQ
 aHKNcQ3APAx6g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 09/10] arm: mvebu: a38x: Add optional support for
 using old DDR3 training code
Date: Mon, 15 Apr 2024 18:30:42 +0200
Message-ID: <20240415163043.7482-10-kabel@kernel.org>
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

Add optional support for using old DDR3 training code from 2017.

The code lives in drivers/ddr/marvell/a38x/old/. To prevent symbol
clashing with new DDR3 training code, a special header which renames all
clashing symbols via macros is included and the symbols are prefixed
with 'old_'.

If old DDR3 training support is selected for a board, then the SPL
initialization code calls a new function
  board_use_old_ddr3_training()
to check whether it should use old DDR3 training code. The default
weak implementation returns false, defaulting to new DDR3 training code.

Boards that wish to support this need to select the
  ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
config option and implement the old version of DDR topology provider,
ddr3_get_topology_map().

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Kconfig                   |   4 +
 arch/arm/mach-mvebu/include/mach/cpu.h        |   1 +
 arch/arm/mach-mvebu/spl.c                     |  37 ++-
 drivers/ddr/marvell/a38x/Makefile             |   2 +
 drivers/ddr/marvell/a38x/old/Makefile         |  11 +
 .../marvell/a38x/old/glue_symbol_renames.h    | 247 ++++++++++++++++++
 6 files changed, 293 insertions(+), 9 deletions(-)
 create mode 100644 drivers/ddr/marvell/a38x/old/glue_symbol_renames.h

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index a320793a30..e377e8a48a 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -37,6 +37,10 @@ config ARMADA_38X_HS_IMPEDANCE_THRESH
 	default 0x6
 	range 0x0 0x7
 
+config ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
+	bool
+	depends on ARMADA_38X
+
 config ARMADA_XP
 	bool
 	select ARMADA_32BIT
diff --git a/arch/arm/mach-mvebu/include/mach/cpu.h b/arch/arm/mach-mvebu/include/mach/cpu.h
index 904e7157ba..af6ce2920e 100644
--- a/arch/arm/mach-mvebu/include/mach/cpu.h
+++ b/arch/arm/mach-mvebu/include/mach/cpu.h
@@ -174,6 +174,7 @@ int serdes_phy_config(void);
  * drivers/ddr/marvell
  */
 int ddr3_init(void);
+int old_ddr3_init(void);
 
 /* Auto Voltage Scaling */
 #if defined(CONFIG_ARMADA_38X)
diff --git a/arch/arm/mach-mvebu/spl.c b/arch/arm/mach-mvebu/spl.c
index 79f8877745..fd1030b33b 100644
--- a/arch/arm/mach-mvebu/spl.c
+++ b/arch/arm/mach-mvebu/spl.c
@@ -314,6 +314,33 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
 	hang();
 }
 
+#if !defined(CONFIG_ARMADA_375)
+__weak bool board_use_old_ddr3_training(void)
+{
+	return false;
+}
+
+static void ddr3_init_or_fail(void)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING) &&
+	    board_use_old_ddr3_training())
+		ret = old_ddr3_init();
+	else
+		ret = ddr3_init();
+
+	if (ret) {
+		printf("ddr3 init failed: %d\n", ret);
+		if (IS_ENABLED(CONFIG_DDR_RESET_ON_TRAINING_FAILURE) &&
+		    get_boot_device() != BOOT_DEVICE_UART)
+			reset_cpu();
+		else
+			hang();
+	}
+}
+#endif
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -348,15 +375,7 @@ void board_init_f(ulong dummy)
 	serdes_phy_config();
 
 	/* Setup DDR */
-	ret = ddr3_init();
-	if (ret) {
-		printf("ddr3_init() failed: %d\n", ret);
-		if (IS_ENABLED(CONFIG_DDR_RESET_ON_TRAINING_FAILURE) &&
-		    get_boot_device() != BOOT_DEVICE_UART)
-			reset_cpu();
-		else
-			hang();
-	}
+	ddr3_init_or_fail();
 #endif
 
 	/* Initialize Auto Voltage Scaling */
diff --git a/drivers/ddr/marvell/a38x/Makefile b/drivers/ddr/marvell/a38x/Makefile
index fcfb615686..4e8a9d190d 100644
--- a/drivers/ddr/marvell/a38x/Makefile
+++ b/drivers/ddr/marvell/a38x/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_SPL_BUILD) += mv_ddr_spd.o
 obj-$(CONFIG_SPL_BUILD) += mv_ddr_topology.o
 obj-$(CONFIG_SPL_BUILD) += xor.o
 
+obj-$(CONFIG_ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING) += old/
+
 ifdef CONFIG_DDR4
 	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_mpr_pda_if.o
 	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training.o
diff --git a/drivers/ddr/marvell/a38x/old/Makefile b/drivers/ddr/marvell/a38x/old/Makefile
index e7b723bb24..1645a79b40 100644
--- a/drivers/ddr/marvell/a38x/old/Makefile
+++ b/drivers/ddr/marvell/a38x/old/Makefile
@@ -16,3 +16,14 @@ obj-$(CONFIG_SPL_BUILD) += ddr3_training_ip_engine.o
 obj-$(CONFIG_SPL_BUILD) += ddr3_training_leveling.o
 obj-$(CONFIG_SPL_BUILD) += ddr3_training_pbs.o
 obj-$(CONFIG_SPL_BUILD) += ddr3_training_static.o
+
+define IncludeSymbolRename
+  CFLAGS_$(1) = -include $(srctree)/drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
+endef
+
+$(foreach obj,$(obj-y),$(eval $(call IncludeSymbolRename,$(obj))))
+
+# The old version of DDR training fails weirdly on some boards if the whole
+# driver is compiled with LTO. It seems to work if at least ddr3_init.c is
+# compiled without LTO.
+CFLAGS_REMOVE_ddr3_init.o := $(LTO_CFLAGS)
diff --git a/drivers/ddr/marvell/a38x/old/glue_symbol_renames.h b/drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
new file mode 100644
index 0000000000..9bdfecd2d6
--- /dev/null
+++ b/drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Glue old A38x DDR training code with new U-Boot
+ *
+ * This header renames symbols so that they do not clash with new A38x DDR
+ * training code (the one living in the parent directory).
+ *
+ * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
+ */
+
+#ifndef GLUE_SYMBOL_RENAMES_H
+#define GLUE_SYMBOL_RENAMES_H
+
+#define activate_deselect_after_run_alg		old_activate_deselect_after_run_alg
+#define activate_select_before_run_alg		old_activate_select_before_run_alg
+#define adll_calibration			old_adll_calibration
+#define adll_shift_lock				old_adll_shift_lock
+#define adll_shift_val				old_adll_shift_val
+#define bus_end_window				old_bus_end_window
+#define bus_start_window			old_bus_start_window
+#define ca_delay				old_ca_delay
+#define calibration_update_control		old_calibration_update_control
+#define centralization_state			old_centralization_state
+#define ck_delay				old_ck_delay
+#define clamp_tbl				old_clamp_tbl
+#define cl_mask_table				old_cl_mask_table
+#define config_func_info			old_config_func_info
+#define ctrl_adll				old_ctrl_adll
+#define ctrl_sweepres				old_ctrl_sweepres
+#define current_valid_window			old_current_valid_window
+#define current_vref				old_current_vref
+#define cwl_mask_table				old_cwl_mask_table
+#define ddr3_calc_mem_cs_size			old_ddr3_calc_mem_cs_size
+#define ddr3_hws_set_log_level			old_ddr3_hws_set_log_level
+#define ddr3_init				old_ddr3_init
+#define ddr3_post_algo_config			old_ddr3_post_algo_config
+#define ddr3_post_run_alg			old_ddr3_post_run_alg
+#define ddr3_pre_algo_config			old_ddr3_pre_algo_config
+#define ddr3_silicon_post_init			old_ddr3_silicon_post_init
+#define ddr3_tip_bist_activate			old_ddr3_tip_bist_activate
+#define ddr3_tip_bist_read_result		old_ddr3_tip_bist_read_result
+#define ddr3_tip_bus_read			old_ddr3_tip_bus_read
+#define ddr3_tip_bus_read_modify_write		old_ddr3_tip_bus_read_modify_write
+#define ddr3_tip_bus_write			old_ddr3_tip_bus_write
+#define ddr3_tip_calc_cs_mask			old_ddr3_tip_calc_cs_mask
+#define ddr3_tip_centralization_rx		old_ddr3_tip_centralization_rx
+#define ddr3_tip_centralization_tx		old_ddr3_tip_centralization_tx
+#define ddr3_tip_centr_skip_min_win_check	old_ddr3_tip_centr_skip_min_win_check
+#define ddr3_tip_clean_pbs_result		old_ddr3_tip_clean_pbs_result
+#define ddr3_tip_cmd_addr_init_delay		old_ddr3_tip_cmd_addr_init_delay
+#define ddr3_tip_configure_cs			old_ddr3_tip_configure_cs
+#define ddr3_tip_configure_odpg			old_ddr3_tip_configure_odpg
+#define ddr3_tip_configure_phy			old_ddr3_tip_configure_phy
+#define ddr3_tip_convert_tune_result		old_ddr3_tip_convert_tune_result
+#define ddr3_tip_ddr3_reset_phy_regs		old_ddr3_tip_ddr3_reset_phy_regs
+#define ddr3_tip_dynamic_per_bit_read_leveling	old_ddr3_tip_dynamic_per_bit_read_leveling
+#define ddr3_tip_dynamic_read_leveling		old_ddr3_tip_dynamic_read_leveling
+#define ddr3_tip_dynamic_write_leveling		old_ddr3_tip_dynamic_write_leveling
+#define ddr3_tip_dynamic_write_leveling_supp	old_ddr3_tip_dynamic_write_leveling_supp
+#define ddr3_tip_enable_init_sequence		old_ddr3_tip_enable_init_sequence
+#define ddr3_tip_ext_read			old_ddr3_tip_ext_read
+#define ddr3_tip_ext_write			old_ddr3_tip_ext_write
+#define ddr3_tip_freq_set			old_ddr3_tip_freq_set
+#define ddr3_tip_get_buf_max			old_ddr3_tip_get_buf_max
+#define ddr3_tip_get_buf_min			old_ddr3_tip_get_buf_min
+#define ddr3_tip_get_buf_ptr			old_ddr3_tip_get_buf_ptr
+#define ddr3_tip_get_device_info		old_ddr3_tip_get_device_info
+#define ddr3_tip_get_mask_results_dq_reg	old_ddr3_tip_get_mask_results_dq_reg
+#define ddr3_tip_get_mask_results_pup_reg_map	old_ddr3_tip_get_mask_results_pup_reg_map
+#define ddr3_tip_get_pattern_table		old_ddr3_tip_get_pattern_table
+#define ddr3_tip_get_result_ptr			old_ddr3_tip_get_result_ptr
+#define ddr3_tip_if_polling			old_ddr3_tip_if_polling
+#define ddr3_tip_if_read			old_ddr3_tip_if_read
+#define ddr3_tip_if_write			old_ddr3_tip_if_write
+#define ddr3_tip_init_config_func		old_ddr3_tip_init_config_func
+#define ddr3_tip_ip_training			old_ddr3_tip_ip_training
+#define ddr3_tip_ip_training_wrapper		old_ddr3_tip_ip_training_wrapper
+#define ddr3_tip_ip_training_wrapper_int	old_ddr3_tip_ip_training_wrapper_int
+#define ddr3_tip_is_pup_lock			old_ddr3_tip_is_pup_lock
+#define ddr3_tip_legacy_dynamic_read_leveling	old_ddr3_tip_legacy_dynamic_read_leveling
+#define ddr3_tip_legacy_dynamic_write_leveling	old_ddr3_tip_legacy_dynamic_write_leveling
+#define ddr3_tip_load_all_pattern_to_mem	old_ddr3_tip_load_all_pattern_to_mem
+#define ddr3_tip_load_pattern_to_mem		old_ddr3_tip_load_pattern_to_mem
+#define ddr3_tip_load_pattern_to_odpg		old_ddr3_tip_load_pattern_to_odpg
+#define ddr3_tip_load_phy_values		old_ddr3_tip_load_phy_values
+#define ddr3_tip_pbs				old_ddr3_tip_pbs
+#define ddr3_tip_pbs_rx				old_ddr3_tip_pbs_rx
+#define ddr3_tip_pbs_tx				old_ddr3_tip_pbs_tx
+#define ddr3_tip_print_adll			old_ddr3_tip_print_adll
+#define ddr3_tip_print_bist_res			old_ddr3_tip_print_bist_res
+#define ddr3_tip_print_centralization_result	old_ddr3_tip_print_centralization_result
+#define ddr3_tip_print_log			old_ddr3_tip_print_log
+#define ddr3_tip_print_stability_log		old_ddr3_tip_print_stability_log
+#define ddr3_tip_print_wl_supp_result		old_ddr3_tip_print_wl_supp_result
+#define ddr3_tip_process_result			old_ddr3_tip_process_result
+#define ddr3_tip_read_training_result		old_ddr3_tip_read_training_result
+#define ddr3_tip_reg_dump			old_ddr3_tip_reg_dump
+#define ddr3_tip_register_dq_table		old_ddr3_tip_register_dq_table
+#define ddr3_tip_register_xsb_info		old_ddr3_tip_register_xsb_info
+#define ddr3_tip_reset_fifo_ptr			old_ddr3_tip_reset_fifo_ptr
+#define ddr3_tip_restore_dunit_regs		old_ddr3_tip_restore_dunit_regs
+#define ddr3_tip_special_rx			old_ddr3_tip_special_rx
+#define ddr3_tip_training_ip_test		old_ddr3_tip_training_ip_test
+#define ddr3_tip_tune_training_params		old_ddr3_tip_tune_training_params
+#define ddr3_tip_vref				old_ddr3_tip_vref
+#define ddr3_tip_write_additional_odt_setting	old_ddr3_tip_write_additional_odt_setting
+#define ddr3_tip_write_cs_result		old_ddr3_tip_write_cs_result
+#define ddr3_tip_write_mrs_cmd			old_ddr3_tip_write_mrs_cmd
+#define debug_acc				old_debug_acc
+#define debug_centralization			old_debug_centralization
+#define debug_dunit				old_debug_dunit
+#define debug_leveling				old_debug_leveling
+#define debug_mode				old_debug_mode
+#define debug_pbs				old_debug_pbs
+#define debug_training				old_debug_training
+#define debug_training_access			old_debug_training_access
+#define debug_training_bist			old_debug_training_bist
+#define debug_training_hw_alg			old_debug_training_hw_alg
+#define debug_training_ip			old_debug_training_ip
+#define debug_training_static			old_debug_training_static
+#define default_centrlization_value		old_default_centrlization_value
+#define delay_enable				old_delay_enable
+#define dfs_low_freq				old_dfs_low_freq
+#define dfs_low_phy1				old_dfs_low_phy1
+#define dq_map_table				old_dq_map_table
+#define effective_cs				old_effective_cs
+#define end_if					old_end_if
+#define end_pattern				old_end_pattern
+#define finger_test				old_finger_test
+#define first_active_if				old_first_active_if
+#define freq_info_table				old_freq_info_table
+#define g_dic					old_g_dic
+#define generic_init_controller			old_generic_init_controller
+#define get_valid_win_rx			old_get_valid_win_rx
+#define g_odt_config				old_g_odt_config
+#define g_rtt_nom				old_g_rtt_nom
+#define g_znodt_ctrl				old_g_znodt_ctrl
+#define g_znodt_data				old_g_znodt_data
+#define g_znri_ctrl				old_g_znri_ctrl
+#define g_znri_data				old_g_znri_data
+#define g_zpodt_ctrl				old_g_zpodt_ctrl
+#define g_zpodt_data				old_g_zpodt_data
+#define g_zpri_ctrl				old_g_zpri_ctrl
+#define g_zpri_data				old_g_zpri_data
+#define hws_ddr3_calc_mem_cs_size		old_hws_ddr3_calc_mem_cs_size
+#define hws_ddr3_cs_base_adr_calc		old_hws_ddr3_cs_base_adr_calc
+#define hws_ddr3_get_bus_width			old_hws_ddr3_get_bus_width
+#define hws_ddr3_get_device_size		old_hws_ddr3_get_device_size
+#define hws_ddr3_get_device_width		old_hws_ddr3_get_device_width
+#define hws_ddr3_run_bist			old_hws_ddr3_run_bist
+#define hws_ddr3_tip_init_controller		old_hws_ddr3_tip_init_controller
+#define hws_ddr3_tip_run_alg			old_hws_ddr3_tip_run_alg
+#define hws_ddr3_tip_select_ddr_controller	old_hws_ddr3_tip_select_ddr_controller
+#define interface_state				old_interface_state
+#define is_adll_calib_before_init		old_is_adll_calib_before_init
+#define is_bist_reset_bit			old_is_bist_reset_bit
+#define is_cbe_required				old_is_cbe_required
+#define is_default_centralization		old_is_default_centralization
+#define is_dfs_disabled				old_is_dfs_disabled
+#define is_dfs_in_init				old_is_dfs_in_init
+#define is_freq_old				old_is_freq_old
+#define is_pll_before_init			old_is_pll_before_init
+#define is_reg_dump				old_is_reg_dump
+#define is_rl_old				old_is_rl_old
+#define is_tune_result				old_is_tune_result
+#define is_validate_window_per_if		old_is_validate_window_per_if
+#define is_validate_window_per_pup		old_is_validate_window_per_pup
+#define last_valid_window			old_last_valid_window
+#define last_vref				old_last_vref
+#define lim_vref				old_lim_vref
+#define low_freq				old_low_freq
+#define mask_results_dq_reg_map			old_mask_results_dq_reg_map
+#define mask_results_dq_reg_map_pup3_ecc	old_mask_results_dq_reg_map_pup3_ecc
+#define mask_results_pup_reg_map		old_mask_results_pup_reg_map
+#define mask_results_pup_reg_map_pup3_ecc	old_mask_results_pup_reg_map_pup3_ecc
+#define mask_tune_func				old_mask_tune_func
+#define max_adll_per_pup			old_max_adll_per_pup
+#define max_pbs_per_pup				old_max_pbs_per_pup
+#define max_polling_for_done			old_max_polling_for_done
+#define medium_freq				old_medium_freq
+#define min_adll_per_pup			old_min_adll_per_pup
+#define min_pbs_per_pup				old_min_pbs_per_pup
+#define multicast_id				old_multicast_id
+#define n_finger_end				old_n_finger_end
+#define n_finger_start				old_n_finger_start
+#define n_finger_step				old_n_finger_step
+#define nominal_adll				old_nominal_adll
+#define odt_additional				old_odt_additional
+#define odt_config				old_odt_config
+#define pattern_table_16			old_pattern_table_16
+#define pattern_table_32			old_pattern_table_32
+#define pattern_table_get_word			old_pattern_table_get_word
+#define pbsdelay_per_pup			old_pbsdelay_per_pup
+#define pbs_pattern				old_pbs_pattern
+#define p_finger_end				old_p_finger_end
+#define p_finger_start				old_p_finger_start
+#define p_finger_step				old_p_finger_step
+#define phy_reg0_val				old_phy_reg0_val
+#define phy_reg1_val				old_phy_reg1_val
+#define phy_reg2_val				old_phy_reg2_val
+#define phy_reg3_val				old_phy_reg3_val
+#define phy_reg_bk				old_phy_reg_bk
+#define reset_read_fifo				old_reset_read_fifo
+#define result_all_bit				old_result_all_bit
+#define result_mat				old_result_mat
+#define result_mat_rx_dqs			old_result_mat_rx_dqs
+#define rl_mid_freq_wa				old_rl_mid_freq_wa
+#define rl_test					old_rl_test
+#define run_xsb_test				old_run_xsb_test
+#define speed_bin_table_t_rc			old_speed_bin_table_t_rc
+#define speed_bin_table_t_rcd_t_rp		old_speed_bin_table_t_rcd_t_rp
+#define start_if				old_start_if
+#define start_pattern				old_start_pattern
+#define start_xsb_offset			old_start_xsb_offset
+#define sweep_cnt				old_sweep_cnt
+#define sweep_pattern				old_sweep_pattern
+#define sys_env_device_rev_get			old_sys_env_device_rev_get
+#define train_control_element			old_train_control_element
+#define train_cs_num				old_train_cs_num
+#define train_dev_num				old_train_dev_num
+#define train_direction				old_train_direction
+#define train_edge_compare			old_train_edge_compare
+#define traine_search_dir			old_traine_search_dir
+#define train_if_acess				old_train_if_acess
+#define train_if_id				old_train_if_id
+#define train_if_select				old_train_if_select
+#define training_res				old_training_res
+#define training_result				old_training_result
+#define training_stage				old_training_stage
+#define train_init_value			old_train_init_value
+#define train_number_iterations			old_train_number_iterations
+#define train_pattern				old_train_pattern
+#define train_pup_access			old_train_pup_access
+#define train_pup_num				old_train_pup_num
+#define train_result_type			old_train_result_type
+#define train_status				old_train_status
+#define traintrain_cs_type			old_traintrain_cs_type
+#define twr_mask_table				old_twr_mask_table
+#define use_broadcast				old_use_broadcast
+#define vref_window_size			old_vref_window_size
+#define vref_window_size_th			old_vref_window_size_th
+#define window_mem_addr				old_window_mem_addr
+#define xsb_test_table				old_xsb_test_table
+#define xsb_validate_type			old_xsb_validate_type
+#define xsb_validation_base_address		old_xsb_validation_base_address
+
+#endif /* !GLUE_SYMBOL_RENAMES_H */
-- 
2.43.2

