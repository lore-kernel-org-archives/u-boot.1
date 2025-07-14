Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60FEC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 21:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0073582E37;
	Mon, 14 Jul 2025 23:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=novatechautomation.com header.i=@novatechautomation.com header.b="Bn8WC8WR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1AA83020; Mon, 14 Jul 2025 23:03:08 +0200 (CEST)
Received: from gw1.cammew.com (gw1.cammew.com [64.182.209.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4653582CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 23:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
Received: from eric-Desktop.novatech-llc.local (unknown [38.62.160.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gw1.cammew.com (Postfix) with ESMTPSA id BF0F811A5CB;
 Mon, 14 Jul 2025 17:03:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 gw1.cammew.com BF0F811A5CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=novatechautomation.com; s=relay; t=1752526983;
 bh=ghtxWQBgAFKaTUx65c6vBM4xw5hIMi9QXRw2papJkIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bn8WC8WRFJjFZ6NJvCP9Mjx764rii+yzP95LYpuQ3p7RXXgRhDRnsQcpYTpWkAJk9
 WINZgG3vVJSawY7IxCwq/2bdWUHpXT+nFhAqlPg7j5V7xp1ggEqmP0JtbEJjh+7uIk
 o7OZyGDgKl5o+FiLi846gmGKS+Rr1odcHTCkXCHA=
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Subject: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
Date: Mon, 14 Jul 2025 16:02:49 -0500
Message-ID: <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
MIME-Version: 1.0
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

The VPD has been updated to include additional values found in the Intel
FSP_MR5 Integration Guide.

Disable MRC_CACHE for the baytrail platform as this will break the boot flow
as well. This issue has not been diagnosed further, but I suspect it is similar
to my previous patch and related to how modern GCC generates the low level
op-codes.

Patch 2 of 2

Upstream-Status: Pending

Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
---
 arch/x86/cpu/baytrail/fsp_configs.c           | 193 +++++++-----------
 .../include/asm/arch-baytrail/fsp/fsp_vpd.h   |   4 +-
 arch/x86/lib/fsp1/fsp_common.c                |   2 +-
 3 files changed, 75 insertions(+), 124 deletions(-)

diff --git a/arch/x86/cpu/baytrail/fsp_configs.c b/arch/x86/cpu/baytrail/fsp_configs.c
index fb3f946c45f..ddbd727120d 100644
--- a/arch/x86/cpu/baytrail/fsp_configs.c
+++ b/arch/x86/cpu/baytrail/fsp_configs.c
@@ -35,137 +35,86 @@ void fsp_update_configs(struct fsp_config_data *config,
 	struct upd_region *fsp_upd = &config->fsp_upd;
 	struct memory_down_data *mem;
 	const void *blob = gd->fdt_blob;
-	int node;
 
 	/* Initialize runtime buffer for fsp_init() */
 	rt_buf->common.stack_top = config->common.stack_top - 32;
 	rt_buf->common.boot_mode = config->common.boot_mode;
 	rt_buf->common.upd_data = &config->fsp_upd;
 
-	node = fdtdec_next_compatible(blob, 0, COMPAT_INTEL_BAYTRAIL_FSP);
-	if (node < 0) {
-		debug("%s: Cannot find FSP node\n", __func__);
-		return;
-	}
+	/* Set all values to known good defaults as documented in 	*
+	 * Intel FSP_MR5 file: BAYTRAIL_FSP.bsf				*/
+
+	/* NOTE: This breaks u-boot ability to set board options via	*
+	 * device tree, but guarantees specific known values..		*
+	 * you wouldnt use an uninitialized variable would you??	*/
+	fsp_upd->mrc_init_tseg_size = 0x0001;
+	fsp_upd->mrc_init_mmio_size = 0x0800;
+	fsp_upd->mrc_init_spd_addr1 = 0xa0;
+	fsp_upd->mrc_init_spd_addr2 = 0xa2;
+	fsp_upd->emmc_boot_mode = 2;
+	fsp_upd->enable_sdio = 1;
+	fsp_upd->enable_sdcard = 1;
+	fsp_upd->enable_hsuart0 = 1;
+	fsp_upd->enable_hsuart1 = 1;
+	fsp_upd->enable_spi = 1;
+	// Skip 1 byte
+	fsp_upd->enable_sata = 1;
+	fsp_upd->sata_mode = 1;
+	fsp_upd->enable_azalia = 0;
 
-	fsp_upd->mrc_init_tseg_size = fdtdec_get_int(blob, node,
-						     "fsp,mrc-init-tseg-size",
-						     MRC_INIT_TSEG_SIZE_1MB);
-	fsp_upd->mrc_init_mmio_size = fdtdec_get_int(blob, node,
-						     "fsp,mrc-init-mmio-size",
-						     MRC_INIT_MMIO_SIZE_2048MB);
-	fsp_upd->mrc_init_spd_addr1 = fdtdec_get_int(blob, node,
-						     "fsp,mrc-init-spd-addr1",
-						     0xa0);
-	fsp_upd->mrc_init_spd_addr2 = fdtdec_get_int(blob, node,
-						     "fsp,mrc-init-spd-addr2",
-						     0xa2);
-	fsp_upd->emmc_boot_mode = fdtdec_get_int(blob, node,
-						 "fsp,emmc-boot-mode",
-						 EMMC_BOOT_MODE_EMMC41);
-	fsp_upd->enable_sdio = fdtdec_get_bool(blob, node, "fsp,enable-sdio");
-	fsp_upd->enable_sdcard = fdtdec_get_bool(blob, node,
-						 "fsp,enable-sdcard");
-	fsp_upd->enable_hsuart0 = fdtdec_get_bool(blob, node,
-						  "fsp,enable-hsuart0");
-	fsp_upd->enable_hsuart1 = fdtdec_get_bool(blob, node,
-						  "fsp,enable-hsuart1");
-	fsp_upd->enable_spi = fdtdec_get_bool(blob, node, "fsp,enable-spi");
-	fsp_upd->enable_sata = fdtdec_get_bool(blob, node, "fsp,enable-sata");
-	fsp_upd->sata_mode = fdtdec_get_int(blob, node, "fsp,sata-mode",
-					    SATA_MODE_AHCI);
-	fsp_upd->enable_azalia = fdtdec_get_bool(blob, node,
-						 "fsp,enable-azalia");
 	if (fsp_upd->enable_azalia)
 		update_fsp_azalia_configs(&fsp_upd->azalia_cfg_ptr);
-	fsp_upd->enable_xhci = fdtdec_get_bool(blob, node, "fsp,enable-xhci");
-	fsp_upd->lpe_mode = fdtdec_get_int(blob, node, "fsp,lpe-mode",
-					   LPE_MODE_PCI);
-	fsp_upd->lpss_sio_mode = fdtdec_get_int(blob, node, "fsp,lpss-sio-mode",
-					   LPSS_SIO_MODE_PCI);
-	fsp_upd->enable_dma0 = fdtdec_get_bool(blob, node, "fsp,enable-dma0");
-	fsp_upd->enable_dma1 = fdtdec_get_bool(blob, node, "fsp,enable-dma1");
-	fsp_upd->enable_i2_c0 = fdtdec_get_bool(blob, node, "fsp,enable-i2c0");
-	fsp_upd->enable_i2_c1 = fdtdec_get_bool(blob, node, "fsp,enable-i2c1");
-	fsp_upd->enable_i2_c2 = fdtdec_get_bool(blob, node, "fsp,enable-i2c2");
-	fsp_upd->enable_i2_c3 = fdtdec_get_bool(blob, node, "fsp,enable-i2c3");
-	fsp_upd->enable_i2_c4 = fdtdec_get_bool(blob, node, "fsp,enable-i2c4");
-	fsp_upd->enable_i2_c5 = fdtdec_get_bool(blob, node, "fsp,enable-i2c5");
-	fsp_upd->enable_i2_c6 = fdtdec_get_bool(blob, node, "fsp,enable-i2c6");
-	fsp_upd->enable_pwm0 = fdtdec_get_bool(blob, node, "fsp,enable-pwm0");
-	fsp_upd->enable_pwm1 = fdtdec_get_bool(blob, node, "fsp,enable-pwm1");
-	fsp_upd->enable_hsi = fdtdec_get_bool(blob, node, "fsp,enable-hsi");
-	fsp_upd->igd_dvmt50_pre_alloc = fdtdec_get_int(blob, node,
-			"fsp,igd-dvmt50-pre-alloc", IGD_DVMT50_PRE_ALLOC_64MB);
-	fsp_upd->aperture_size = fdtdec_get_int(blob, node, "fsp,aperture-size",
-						APERTURE_SIZE_256MB);
-	fsp_upd->gtt_size = fdtdec_get_int(blob, node, "fsp,gtt-size",
-					   GTT_SIZE_2MB);
-	fsp_upd->mrc_debug_msg = fdtdec_get_bool(blob, node,
-						 "fsp,mrc-debug-msg");
-	fsp_upd->isp_enable = fdtdec_get_bool(blob, node, "fsp,isp-enable");
-	fsp_upd->scc_mode = fdtdec_get_int(blob, node, "fsp,scc-mode",
-					   SCC_MODE_PCI);
-	fsp_upd->igd_render_standby = fdtdec_get_bool(blob, node,
-						      "fsp,igd-render-standby");
-	fsp_upd->txe_uma_enable = fdtdec_get_bool(blob, node,
-						  "fsp,txe-uma-enable");
-	fsp_upd->os_selection = fdtdec_get_int(blob, node, "fsp,os-selection",
-					       OS_SELECTION_LINUX);
-	fsp_upd->emmc45_ddr50_enabled = fdtdec_get_bool(blob, node,
-			"fsp,emmc45-ddr50-enabled");
-	fsp_upd->emmc45_hs200_enabled = fdtdec_get_bool(blob, node,
-			"fsp,emmc45-hs200-enabled");
-	fsp_upd->emmc45_retune_timer_value = fdtdec_get_int(blob, node,
-			"fsp,emmc45-retune-timer-value", 8);
-	fsp_upd->enable_igd = fdtdec_get_bool(blob, node, "fsp,enable-igd");
 
+	fsp_upd->enable_xhci = 1;
+	fsp_upd->lpe_mode = 1;
+	fsp_upd->lpss_sio_mode = 1;
+	fsp_upd->enable_dma0 = 1;
+	fsp_upd->enable_dma1 = 1;
+	fsp_upd->enable_i2_c0 = 1;
+	fsp_upd->enable_i2_c1 = 1;
+	fsp_upd->enable_i2_c2 = 1;
+	fsp_upd->enable_i2_c3 = 1;
+	fsp_upd->enable_i2_c4 = 1;
+	fsp_upd->enable_i2_c5 = 1;
+	fsp_upd->enable_i2_c6 = 1;
+	fsp_upd->enable_pwm0 = 1;
+	fsp_upd->enable_pwm1 = 1;
+	fsp_upd->enable_hsi = 0;
+	fsp_upd->igd_dvmt50_pre_alloc = 2;
+	fsp_upd->aperture_size = 2;
+	fsp_upd->gtt_size = 2;
+	// Skip 5 bytes
+	fsp_upd->mrc_debug_msg = 0;
+	fsp_upd->isp_enable = 0;
+	fsp_upd->scc_mode = 1;
+	fsp_upd->igd_render_standby = 0;
+	fsp_upd->txe_uma_enable = 0;
+	fsp_upd->os_selection = 0x4;
+	fsp_upd->emmc45_ddr50_enabled = 1;
+	fsp_upd->emmc45_hs200_enabled = 0;
+	fsp_upd->emmc45_retune_timer_value = 8;
+	fsp_upd->enable_igd = 1;
+	fsp_upd->auto_self_refresh = 2;
+	fsp_upd->task_timeout_count = 100;
+	// Skip 152 bytes
 	mem = &fsp_upd->memory_params;
-	mem->enable_memory_down = fdtdec_get_bool(blob, node,
-						  "fsp,enable-memory-down");
-	if (mem->enable_memory_down) {
-		node = fdtdec_next_compatible(blob, node,
-					      COMPAT_INTEL_BAYTRAIL_FSP_MDP);
-		if (node < 0) {
-			debug("%s: Cannot find FSP memory-down-params node\n",
-			      __func__);
-		} else {
-			mem->dram_speed = fdtdec_get_int(blob, node,
-							 "fsp,dram-speed",
-							 DRAM_SPEED_1333MTS);
-			mem->dram_type = fdtdec_get_int(blob, node,
-							"fsp,dram-type",
-							DRAM_TYPE_DDR3L);
-			mem->dimm_0_enable = fdtdec_get_bool(blob, node,
-					"fsp,dimm-0-enable");
-			mem->dimm_1_enable = fdtdec_get_bool(blob, node,
-					"fsp,dimm-1-enable");
-			mem->dimm_width = fdtdec_get_int(blob, node,
-							 "fsp,dimm-width",
-							 DIMM_WIDTH_X8);
-			mem->dimm_density = fdtdec_get_int(blob, node,
-							   "fsp,dimm-density",
-							   DIMM_DENSITY_2GBIT);
-			mem->dimm_bus_width = fdtdec_get_int(blob, node,
-					"fsp,dimm-bus-width",
-					DIMM_BUS_WIDTH_64BITS);
-			mem->dimm_sides = fdtdec_get_int(blob, node,
-							 "fsp,dimm-sides",
-							 DIMM_SIDES_1RANKS);
-			mem->dimm_tcl = fdtdec_get_int(blob, node,
-						       "fsp,dimm-tcl", 0x09);
-			mem->dimm_trpt_rcd = fdtdec_get_int(blob, node,
-					"fsp,dimm-trpt-rcd", 0x09);
-			mem->dimm_twr = fdtdec_get_int(blob, node,
-						       "fsp,dimm-twr", 0x0a);
-			mem->dimm_twtr = fdtdec_get_int(blob, node,
-							"fsp,dimm-twtr", 0x05);
-			mem->dimm_trrd = fdtdec_get_int(blob, node,
-							"fsp,dimm-trrd", 0x04);
-			mem->dimm_trtp = fdtdec_get_int(blob, node,
-							"fsp,dimm-trtp", 0x05);
-			mem->dimm_tfaw = fdtdec_get_int(blob, node,
-							"fsp,dimm-tfaw", 0x14);
-		}
-	}
+	// We make the assumption that 0x00 = DISABLED
+	mem->enable_memory_down = 0x00;
+#if 0
+	mem->dram_speed = 0x02;
+	mem->dram_type = 0x01;
+	mem->dimm_0_enable = 0x01;
+	mem->dimm_1_enable = 0x00;
+	mem->dimm_width = 0x00;
+	mem->dimm_density = 0x01;
+	mem->dimm_bus_width = 0x03;
+	mem->dimm_sides = 0x00;
+	mem->dimm_tcl = 0x09;
+	mem->dimm_trpt_rcd = 0x09;
+	mem->dimm_twr = 0x0a;
+	mem->dimm_twtr = 0x05;
+	mem->dimm_trrd = 0x04;
+	mem->dimm_trtp = 0x05;
+	mem->dimm_tfaw = 0x14;
+#endif
 }
diff --git a/arch/x86/include/asm/arch-baytrail/fsp/fsp_vpd.h b/arch/x86/include/asm/arch-baytrail/fsp/fsp_vpd.h
index c6544ea409c..09924d7393a 100644
--- a/arch/x86/include/asm/arch-baytrail/fsp/fsp_vpd.h
+++ b/arch/x86/include/asm/arch-baytrail/fsp/fsp_vpd.h
@@ -74,7 +74,9 @@ struct __packed upd_region {
 	uint8_t emmc45_hs200_enabled;		/* Offset 0x0052 */
 	uint8_t emmc45_retune_timer_value;	/* Offset 0x0053 */
 	uint8_t enable_igd;			/* Offset 0x0054 */
-	uint8_t unused_upd_space1[155];		/* Offset 0x0055 */
+	uint8_t auto_self_refresh;		/* Offset 0x0055 */
+	uint16_t task_timeout_count;		/* Offset 0x0056 */
+	uint8_t unused_upd_space1[152];		/* Offset 0x0057 */
 	struct memory_down_data memory_params;	/* Offset 0x00f0 */
 	uint16_t terminator;			/* Offset 0x0100 */
 };
diff --git a/arch/x86/lib/fsp1/fsp_common.c b/arch/x86/lib/fsp1/fsp_common.c
index df18f476756..e6a1276986b 100644
--- a/arch/x86/lib/fsp1/fsp_common.c
+++ b/arch/x86/lib/fsp1/fsp_common.c
@@ -55,7 +55,7 @@ int arch_fsp_init(void)
 	}
 
 	if (!gd->arch.hob_list) {
-		if (IS_ENABLED(CONFIG_ENABLE_MRC_CACHE))
+		if (!IS_ENABLED(CONFIG_INTEL_BAYTRAIL) && IS_ENABLED(CONFIG_ENABLE_MRC_CACHE))
 			nvs = fsp_prepare_mrc_cache();
 		else
 			nvs = NULL;
-- 
2.43.0

