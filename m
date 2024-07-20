Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C60C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B0588BC7;
	Sat, 20 Jul 2024 14:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="APNG9qvM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L1k6zKll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9935888A5; Sat, 20 Jul 2024 14:43:41 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12A0888A5
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nR3KMRz9sGV;
 Sat, 20 Jul 2024 14:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIMCBZ71U+HuH6VS6fwOVIbFPvWWcsrB53iQiWmNZLk=;
 b=APNG9qvMfpKDLe6rGNfGjE3yjX06Ve3Knt5Eiexf0PYuQzTs9nIct7OePjUk2iocKDqfuG
 DuKLIrd43UiriCZcTykGT2aRhhqro1Jh6VtRWUUda+tIm5UTXakaZkL8H1L/d+eq6kRpmM
 zmABG3DORKWqd7qkGXlECA01/LqngZW8/qoMERU1CjcbFdPpUUm4Lomm2+V9c/vbU5vxR9
 QXJVi8iE//ml+20B5PPtjGWTvPLFkxBOprsVY9VdGmEZct6U1brS79QfKTTEiF+OqrOYOj
 YhvTCDJFG0W9PoybSkTFpM0P9GX4ZoZwGk2Ve8zBgXa4gX+G5T41M47FOFPfvg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIMCBZ71U+HuH6VS6fwOVIbFPvWWcsrB53iQiWmNZLk=;
 b=L1k6zKlllHyqPBw3xWtmUC1+Zwl59NKWCX4UIHltpnqD1uCEEo18AD6oFrnmd4A9+ZbNUy
 A/i96UxewPQk6dp6uyC8Q7CUJxgn8MmqsGVWxr20/mV4Wsy755/zbNCwpqcEwSx1V1TWhw
 y2vgB4Py5PYF3tGHdk8R0tEKLw1D96SvUYwoNEQzPzbo5GEB57FhvxpgfLyZ5Y2mTSTMh0
 LLJ27smpJr4MiQVG8OsHnrvdXkI/ZZ0WQpJ/BeFBDdtNAejazzbUQL20d7EU370zhcTOUc
 YhOW7Q3LxDFijIlXUTLzObVYoA3+EPCb027Xwc/lEeXcEcrPOlzcnRcYPIrbrw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/40] drivers: ddr: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:33 +0200
Message-ID: <20240720124239.7553-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1171dd5247de8d69aec
X-MBO-RS-META: fgozphg6nt3qopefm6q7bzdtb41y5czw
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/ddr/altera/sdram_arria10.c                | 1 -
 drivers/ddr/altera/sequencer.c                    | 2 --
 drivers/ddr/altera/sequencer.h                    | 1 -
 drivers/ddr/fsl/arm_ddr_gen3.c                    | 1 -
 drivers/ddr/fsl/interactive.c                     | 5 -----
 drivers/ddr/fsl/lc_common_dimm_params.c           | 1 -
 drivers/ddr/imx/phy/ddrphy_train.c                | 1 -
 drivers/ddr/marvell/a38x/ddr3_init.c              | 2 --
 drivers/ddr/marvell/a38x/ddr3_training.c          | 4 ----
 drivers/ddr/marvell/a38x/ddr3_training_ip_def.h   | 1 -
 drivers/ddr/marvell/a38x/ddr3_training_leveling.c | 1 -
 drivers/ddr/marvell/a38x/ddr_ml_wrapper.h         | 1 -
 drivers/ddr/marvell/a38x/mv_ddr_plat.c            | 1 -
 drivers/ddr/marvell/a38x/mv_ddr_plat.h            | 1 -
 drivers/ddr/marvell/a38x/mv_ddr_regs.h            | 1 -
 15 files changed, 24 deletions(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index bd2af94bb0d..d3305a6c82d 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -645,7 +645,6 @@ static int of_sdram_firewall_setup(const void *blob)
 	writel(0, &socfpga_noc_fw_ddr_mpu_fpga2sdram_base->enable);
 	writel(0, &socfpga_noc_fw_ddr_l3_base->enable);
 
-
 	for (i = 0; i < ARRAY_SIZE(firewall_table); i++) {
 		sprintf(name, "%s", firewall_table[i].prop_name);
 		ret = fdtdec_get_int_array(blob, child, name,
diff --git a/drivers/ddr/altera/sequencer.c b/drivers/ddr/altera/sequencer.c
index 7636e71a0a6..69937fc2d56 100644
--- a/drivers/ddr/altera/sequencer.c
+++ b/drivers/ddr/altera/sequencer.c
@@ -689,7 +689,6 @@ static void scc_mgr_apply_group_dm_out1_delay(struct socfpga_sdrseq *seq,
 	}
 }
 
-
 /* apply and load delay on both DQS and OCT out1 */
 static void scc_mgr_apply_group_dqs_io_and_oct_out1(struct socfpga_sdrseq *seq,
 						    u32 write_group, u32 delay)
@@ -2580,7 +2579,6 @@ static int rw_mgr_mem_calibrate_vfifo_center(struct socfpga_sdrseq *seq,
 			 &sticky_bit_chk,
 			 left_edge, right_edge, use_read_test);
 
-
 	/* Search for the right edge of the window for each bit */
 	ret = search_right_edge(seq, 0, rank_bgn, rw_group, rw_group,
 				start_dqs, start_dqs_en,
diff --git a/drivers/ddr/altera/sequencer.h b/drivers/ddr/altera/sequencer.h
index 618ba00da64..96a6bac83b4 100644
--- a/drivers/ddr/altera/sequencer.h
+++ b/drivers/ddr/altera/sequencer.h
@@ -164,7 +164,6 @@ struct param_type {
 	u32	write_correct_mask_vg;
 };
 
-
 /* global variable holder */
 struct gbl_type {
 	uint32_t phy_debug_mode_flags;
diff --git a/drivers/ddr/fsl/arm_ddr_gen3.c b/drivers/ddr/fsl/arm_ddr_gen3.c
index 9f9aea804d9..f1dcba4603e 100644
--- a/drivers/ddr/fsl/arm_ddr_gen3.c
+++ b/drivers/ddr/fsl/arm_ddr_gen3.c
@@ -19,7 +19,6 @@
 #error Invalid setting for CONFIG_CHIP_SELECTS_PER_CTRL
 #endif
 
-
 /*
  * regs has the to-be-set values for DDR controller registers
  * ctrl_num is the DDR controller number
diff --git a/drivers/ddr/fsl/interactive.c b/drivers/ddr/fsl/interactive.c
index 94a5e447d56..52a20504bd9 100644
--- a/drivers/ddr/fsl/interactive.c
+++ b/drivers/ddr/fsl/interactive.c
@@ -1209,7 +1209,6 @@ void ddr2_spd_dump(const ddr2_spd_eeprom_t *spd)
 	for (i = 0; i < 18; i++)
 		printf("%c", spd->mpart[i]);
 
-
 	printf("<<* 73 Manufacturer's Part Number *\n");
 
 	printf("%-3d-%3d: %02x %02x %s\n", 91, 92, spd->rev[0], spd->rev[1],
@@ -1227,7 +1226,6 @@ void ddr2_spd_dump(const ddr2_spd_eeprom_t *spd)
 	for (i = 0; i < 27; i++)
 		printf("%02x", spd->mspec[i]);
 
-
 	printf("* 99 Manufacturer Specific Data *\n");
 }
 #endif
@@ -1946,7 +1944,6 @@ unsigned long long fsl_ddr_interactive(fsl_ddr_info_t *pinfo, int var_is_set)
 		if (argc == 0)
 			continue;
 
-
 		if (strcmp(argv[0], "help") == 0) {
 			puts(usage);
 			continue;
@@ -2042,7 +2039,6 @@ unsigned long long fsl_ddr_interactive(fsl_ddr_info_t *pinfo, int var_is_set)
 			debug("src_ctlr_num = %u, src_dimm_num = %u, dst_ctlr_num = %u, dst_dimm_num = %u, step_mask = %x\n",
 				src_ctlr_num, src_dimm_num, dst_ctlr_num, dst_dimm_num, step_mask);
 
-
 			switch (step_mask) {
 
 			case STEP_GET_SPD:
@@ -2117,7 +2113,6 @@ unsigned long long fsl_ddr_interactive(fsl_ddr_info_t *pinfo, int var_is_set)
 			if (error)
 				continue;
 
-
 			/* Check arguments */
 
 			/* ERROR: If no steps were found */
diff --git a/drivers/ddr/fsl/lc_common_dimm_params.c b/drivers/ddr/fsl/lc_common_dimm_params.c
index aaf9800b372..cc128112e4f 100644
--- a/drivers/ddr/fsl/lc_common_dimm_params.c
+++ b/drivers/ddr/fsl/lc_common_dimm_params.c
@@ -191,7 +191,6 @@ compute_cas_latency(const unsigned int ctrl_num,
 	      lowest_good_caslat);
 	outpdimm->lowest_common_spd_caslat = lowest_good_caslat;
 
-
 	/*
 	 * Compute a common 'de-rated' CAS latency.
 	 *
diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index ccc10df1845..2a2161dec33 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -78,7 +78,6 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 
 		dwc_ddrphy_apb_wr(0xd0000, 0x1);
 
-
 		fsp_msg++;
 	}
 
diff --git a/drivers/ddr/marvell/a38x/ddr3_init.c b/drivers/ddr/marvell/a38x/ddr3_init.c
index 7c5147f4745..b28b2c73a8b 100644
--- a/drivers/ddr/marvell/a38x/ddr3_init.c
+++ b/drivers/ddr/marvell/a38x/ddr3_init.c
@@ -75,7 +75,6 @@ int ddr3_init(void)
 #endif
 	}
 
-
 	status = ddr3_silicon_post_init();
 	if (MV_OK != status) {
 		printf("DDR3 Post Init - FAILED 0x%x\n", status);
@@ -89,7 +88,6 @@ int ddr3_init(void)
 		return status;
 	}
 
-
 	/* Post MC/PHY initializations */
 	mv_ddr_post_training_soc_config(ddr_type);
 
diff --git a/drivers/ddr/marvell/a38x/ddr3_training.c b/drivers/ddr/marvell/a38x/ddr3_training.c
index 790b01d031d..5b8747cc681 100644
--- a/drivers/ddr/marvell/a38x/ddr3_training.c
+++ b/drivers/ddr/marvell/a38x/ddr3_training.c
@@ -285,7 +285,6 @@ int ddr3_tip_tune_training_params(u32 dev_num,
 	if (params->g_rtt_park != PARAM_UNDEFINED)
 		g_rtt_park = params->g_rtt_park;
 
-
 	DEBUG_TRAINING_IP(DEBUG_LEVEL_INFO,
 			  ("DGL parameters: 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X\n",
 			   g_zpri_data, g_znri_data, g_zpri_ctrl, g_znri_ctrl, g_zpodt_data, g_znodt_data,
@@ -870,7 +869,6 @@ int ddr3_tip_validate_algo_components(u8 dev_num)
 	return (status == 1) ? MV_OK : MV_NOT_INITIALIZED;
 }
 
-
 int ddr3_pre_algo_config(void)
 {
 	struct mv_ddr_topology_map *tm = mv_ddr_topology_map_get();
@@ -1114,7 +1112,6 @@ int ddr3_tip_bus_write(u32 dev_num, enum hws_access_type interface_access,
 		mv_ddr_phy_write(phy_access, phy_id, phy_type, reg_addr, data_value, OPERATION_WRITE);
 }
 
-
 /*
  * Phy read-modify-write
  */
@@ -1406,7 +1403,6 @@ int ddr3_tip_freq_set(u32 dev_num, enum hws_access_type access_type,
 			t2t = (cs_num == 1) ? 0 : 1;
 		}
 
-
 		if (ddr3_tip_dev_attr_get(dev_num, MV_ATTR_INTERLEAVE_WA) == 1) {
 			/* Use 1T mode if 1:1 ratio configured */
 			if (config_func_info[dev_num].tip_get_clock_ratio(frequency) == 1) {
diff --git a/drivers/ddr/marvell/a38x/ddr3_training_ip_def.h b/drivers/ddr/marvell/a38x/ddr3_training_ip_def.h
index 8765df7cfbb..bdd7836b844 100644
--- a/drivers/ddr/marvell/a38x/ddr3_training_ip_def.h
+++ b/drivers/ddr/marvell/a38x/ddr3_training_ip_def.h
@@ -82,7 +82,6 @@
 #define ADDR_SIZE_8GB			0x40000000
 #define ADDR_SIZE_16GB			0x80000000
 
-
 enum hws_edge_compare {
 	EDGE_PF,
 	EDGE_FP,
diff --git a/drivers/ddr/marvell/a38x/ddr3_training_leveling.c b/drivers/ddr/marvell/a38x/ddr3_training_leveling.c
index 55abbad5a7a..bc58f55170c 100644
--- a/drivers/ddr/marvell/a38x/ddr3_training_leveling.c
+++ b/drivers/ddr/marvell/a38x/ddr3_training_leveling.c
@@ -1677,7 +1677,6 @@ static int mpr_rd_frmt_config(
 	u32 val, mask;
 	u8 cs_bitmask_inv;
 
-
 	if (dis_auto_refresh == 1) {
 		ddr3_tip_if_write(0, ACCESS_TYPE_UNICAST, 0, ODPG_CTRL_CTRL_REG,
 			  ODPG_CTRL_AUTO_REFRESH_DIS << ODPG_CTRL_AUTO_REFRESH_OFFS,
diff --git a/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h b/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h
index dff56338b19..e6b7cc5985e 100644
--- a/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h
+++ b/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h
@@ -79,7 +79,6 @@
 #define MV_DEBUG_WL_FULL
 #endif
 
-
 /* The following is a list of Marvell status */
 #define MV_ERROR	(-1)
 #define MV_OK		(0x00)	/* Operation succeeded                   */
diff --git a/drivers/ddr/marvell/a38x/mv_ddr_plat.c b/drivers/ddr/marvell/a38x/mv_ddr_plat.c
index 8ec9fb0874e..fb69539ef4c 100644
--- a/drivers/ddr/marvell/a38x/mv_ddr_plat.c
+++ b/drivers/ddr/marvell/a38x/mv_ddr_plat.c
@@ -1144,7 +1144,6 @@ static int ddr3_fast_path_dynamic_cs_size_config(u32 cs_ena)
 	uint64_t cs_mem_size = 0;
 	uint64_t mem_total_size_c, cs_mem_size_c;
 
-
 #ifdef DEVICE_MAX_DRAM_ADDRESS_SIZE
 	u32 physical_mem_size;
 	u32 max_mem_size = DEVICE_MAX_DRAM_ADDRESS_SIZE;
diff --git a/drivers/ddr/marvell/a38x/mv_ddr_plat.h b/drivers/ddr/marvell/a38x/mv_ddr_plat.h
index 01894f652cb..23f3dd62877 100644
--- a/drivers/ddr/marvell/a38x/mv_ddr_plat.h
+++ b/drivers/ddr/marvell/a38x/mv_ddr_plat.h
@@ -55,7 +55,6 @@
 
 #define MARVELL_BOARD				MARVELL_BOARD_ID_BASE
 
-
 #define REG_DEVICE_SAR1_ADDR			0xe4204
 #define RST2_CPU_DDR_CLOCK_SELECT_IN_OFFSET	17
 #define RST2_CPU_DDR_CLOCK_SELECT_IN_MASK	0x1f
diff --git a/drivers/ddr/marvell/a38x/mv_ddr_regs.h b/drivers/ddr/marvell/a38x/mv_ddr_regs.h
index a19000dbdd8..6a8a921e534 100644
--- a/drivers/ddr/marvell/a38x/mv_ddr_regs.h
+++ b/drivers/ddr/marvell/a38x/mv_ddr_regs.h
@@ -520,5 +520,4 @@ enum {
 #define RESULT_PHY_RX_OFFS			5
 #define RESULT_PHY_TX_OFFS			0
 
-
 #endif /* _MV_DDR_REGS_H */
-- 
2.43.0

