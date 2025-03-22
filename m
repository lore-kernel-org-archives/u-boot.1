Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD35C36008
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 21:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B446D81DCD;
	Sat, 22 Mar 2025 22:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nOhjzzlZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qRXDuRPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F77981A0C; Sat, 22 Mar 2025 22:56:55 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C0381A0C
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 22:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZKtSd1Llwz9ssw;
 Sat, 22 Mar 2025 22:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkFlnr+MXahM/piggl5fh8Xv0Ply1bvR19+Baz2vMXE=;
 b=nOhjzzlZlMzWFuYA0jIOLsRd2a/VMZqjVWabVYzBm3E9L0BTlfT6ONDX+C1umpKqqERp0t
 0/jlXn1KdTIgaAHFuweRa+pEYxM178prvURsiEIGSniA1wQ5PYNOGGbJqbe+MFYjRvAbjM
 Vbsl1gM0V3D4o9GG/QXHHrefpzXrZvOcTfeDYEwXiEjSmVlwdDUIzeQLU902hSbMOSzL0n
 HPMFhr0pWuyi+vq85vhGRI4DsgxABM+7vO6axloN1ve+GsQhuij/dKkaXsNIIm25BfuN7O
 QnRN59grFfOxPS+jqaNBYONPfD9Vz+AWPzHSbv2iRF6v1XsSIS76z3ncqTbAkA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkFlnr+MXahM/piggl5fh8Xv0Ply1bvR19+Baz2vMXE=;
 b=qRXDuRPZ4BEOKPJKAR1wkVBbabwY7btBJaXg0YUEglL/8TsPcMK5o4HTYah6fuXlR8FgeY
 Yq+F70Tq7aN4Q3VgQdMBsi51gF3FCapji+/fKbpTGuqsCpPqZPFgp1ebQsOi66iUGR/jrQ
 /i9jngxj7OaX8p2VolnvTPVrVSxWLkOBVOjqkyWH0BPSAmjUba4/4FkRh5Ea9bRjJz14dw
 gwqG95lnTO0Kerdh3IoOcph4knK3Xw432X/Zfnzq4694POLvQn1YxxxZRYlQNlByc0h2Vc
 p/vctdb1eupTsC3NFf5aGutped64WnQEx0qUvTlaLYQbSCCwAHL2l1nC099zEA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] env: Rename SYS_MMC_ENV_DEV to ENV_SDMMC_DEVICE_INDEX
Date: Sat, 22 Mar 2025 22:55:24 +0100
Message-ID: <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 70f43e873be266ef6aa
X-MBO-RS-META: 4q8ypzfkm5nft64ktnagjd5ays59iwpu
X-Rspamd-Queue-Id: 4ZKtSd1Llwz9ssw
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

Rename the variable and add ENV_ prefix, so that all configuration
options which are related to environment would have an CONFIG_ENV_
prefix. No functional change.

Use ENV_SDMMC_DEVICE_INDEX to clarify this is the SD/MMC device
index, a number, as enumerated by U-Boot. Update the help text
accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c                |  2 +-
 arch/arm/mach-imx/imx8/cpu.c                           |  4 ++--
 arch/arm/mach-imx/imx8ulp/soc.c                        |  4 ++--
 arch/arm/mach-imx/imx9/soc.c                           |  4 ++--
 arch/arm/mach-imx/mmc_env.c                            |  4 ++--
 arch/arm/mach-imx/mx6/soc.c                            |  4 ++--
 arch/arm/mach-imx/mx7ulp/soc.c                         |  4 ++--
 arch/arm/mach-mvebu/armada8k/cpu.c                     |  2 +-
 arch/arm/mach-rockchip/board.c                         |  4 ++--
 .../advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20-a1.env  |  2 +-
 board/freescale/imx8mm_evk/imx8mm_evk.env              |  2 +-
 board/freescale/imx8mn_evk/imx8mn_evk.env              |  2 +-
 board/freescale/imx8mp_evk/imx8mp_evk.env              |  2 +-
 board/freescale/imx8mq_evk/imx8mq_evk.env              |  2 +-
 board/freescale/imx91_evk/imx91_evk.env                |  2 +-
 board/freescale/imx93_evk/imx93_evk.env                |  2 +-
 board/freescale/imx93_qsb/imx93_qsb.env                |  2 +-
 board/grinn/liteboard/board.c                          |  2 +-
 board/phytec/common/k3/board.c                         |  2 +-
 board/phytec/phycore_imx8mm/phycore_imx8mm.env         |  2 +-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env         |  2 +-
 board/phytec/phycore_imx93/phycore_imx93.env           |  2 +-
 board/st/stm32mp1/stm32mp1.c                           |  2 +-
 board/sunxi/board.c                                    |  4 ++--
 cmd/mvebu/bubt.c                                       |  4 ++--
 configs/am335x_shc_defconfig                           |  2 +-
 configs/am335x_shc_ict_defconfig                       |  2 +-
 configs/am335x_sl50_defconfig                          |  2 +-
 configs/am57xx_evm_defconfig                           |  2 +-
 configs/am57xx_hs_evm_defconfig                        |  2 +-
 configs/am57xx_hs_evm_usb_defconfig                    |  2 +-
 configs/brppt1_mmc_defconfig                           |  2 +-
 configs/brxre1_defconfig                               |  2 +-
 configs/cgtqmx8_defconfig                              |  2 +-
 configs/dra7xx_evm_defconfig                           |  2 +-
 configs/dra7xx_hs_evm_defconfig                        |  2 +-
 configs/dra7xx_hs_evm_usb_defconfig                    |  2 +-
 configs/evb-rk3328_defconfig                           |  2 +-
 configs/ficus-rk3399_defconfig                         |  2 +-
 configs/hihope_rzg2_defconfig                          |  2 +-
 configs/imx6dl_mamoj_defconfig                         |  2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig             |  2 +-
 configs/imx8mm-cl-iot-gate_defconfig                   |  2 +-
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig           |  2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig          |  2 +-
 configs/imx8mm-phygate-tauri-l_defconfig               |  2 +-
 configs/imx8mm_beacon_defconfig                        |  2 +-
 configs/imx8mm_beacon_fspi_defconfig                   |  2 +-
 configs/imx8mm_evk_defconfig                           |  2 +-
 configs/imx8mm_evk_fspi_defconfig                      |  2 +-
 configs/imx8mm_venice_defconfig                        |  2 +-
 configs/imx8mn_beacon_2g_defconfig                     |  2 +-
 configs/imx8mn_beacon_defconfig                        |  2 +-
 configs/imx8mn_beacon_fspi_defconfig                   |  2 +-
 configs/imx8mn_ddr4_evk_defconfig                      |  2 +-
 configs/imx8mn_var_som_defconfig                       |  2 +-
 configs/imx8mn_venice_defconfig                        |  2 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig          |  2 +-
 configs/imx8mp_beacon_defconfig                        |  2 +-
 configs/imx8mp_debix_model_a_defconfig                 |  2 +-
 configs/imx8mp_evk_defconfig                           |  2 +-
 configs/imx8mp_navqp_defconfig                         |  2 +-
 configs/imx8mp_rsb3720a1_4G_defconfig                  |  2 +-
 configs/imx8mp_rsb3720a1_6G_defconfig                  |  2 +-
 configs/imx8mp_venice_defconfig                        |  2 +-
 configs/imx8mq_cm_defconfig                            |  2 +-
 configs/imx8mq_evk_defconfig                           |  2 +-
 configs/imx8mq_phanbell_defconfig                      |  2 +-
 configs/imx8mq_reform2_defconfig                       |  2 +-
 configs/imx8qm_dmsse20a1_defconfig                     |  2 +-
 configs/imx8qm_mek_defconfig                           |  2 +-
 configs/imx8qm_rom7720_a1_4G_defconfig                 |  2 +-
 configs/imx8qxp_mek_defconfig                          |  2 +-
 configs/imx91_11x11_evk_defconfig                      |  2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig           |  2 +-
 configs/imx93-phycore_defconfig                        |  2 +-
 configs/imx93_11x11_evk_defconfig                      |  2 +-
 configs/imx93_9x9_qsb_defconfig                        |  2 +-
 configs/imx93_9x9_qsb_inline_ecc_defconfig             |  2 +-
 configs/imx93_var_som_defconfig                        |  2 +-
 configs/khadas-vim3_android_ab_defconfig               |  2 +-
 configs/khadas-vim3_android_defconfig                  |  2 +-
 configs/khadas-vim3l_android_ab_defconfig              |  2 +-
 configs/khadas-vim3l_android_defconfig                 |  2 +-
 configs/kp_imx6q_tpc_defconfig                         |  2 +-
 configs/mvebu_crb_cn9130_defconfig                     |  2 +-
 configs/mvebu_db_cn9130_defconfig                      |  2 +-
 configs/mx6sabresd_defconfig                           |  2 +-
 configs/mx6sxsabresd_defconfig                         |  2 +-
 configs/mx6ul_14x14_evk_defconfig                      |  2 +-
 configs/mx6ul_9x9_evk_defconfig                        |  2 +-
 configs/mx6ull_14x14_evk_defconfig                     |  2 +-
 configs/mx6ull_14x14_evk_plugin_defconfig              |  2 +-
 configs/mx6ulz_14x14_evk_defconfig                     |  2 +-
 configs/nanopi-r2c-plus-rk3328_defconfig               |  2 +-
 configs/nanopi-r2c-rk3328_defconfig                    |  2 +-
 configs/nanopi-r2s-rk3328_defconfig                    |  2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig          |  2 +-
 configs/orangepi-r1-plus-rk3328_defconfig              |  2 +-
 configs/phycore-imx8mm_defconfig                       |  2 +-
 configs/phycore-imx8mp_defconfig                       |  2 +-
 configs/phycore-rk3288_defconfig                       |  2 +-
 configs/phycore_am62ax_a53_defconfig                   |  2 +-
 configs/phycore_am62x_a53_defconfig                    |  2 +-
 configs/phycore_am64x_a53_defconfig                    |  2 +-
 configs/pico-imx8mq_defconfig                          |  2 +-
 configs/puma-rk3399_defconfig                          |  2 +-
 configs/riotboard_defconfig                            |  2 +-
 configs/roc-cc-rk3328_defconfig                        |  2 +-
 configs/rock-pi-e-rk3328_defconfig                     |  2 +-
 configs/rock-pi-e-v3-rk3328_defconfig                  |  2 +-
 configs/rock64-rk3328_defconfig                        |  2 +-
 configs/rock960-rk3399_defconfig                       |  2 +-
 configs/s5p4418_nanopi2_defconfig                      |  2 +-
 configs/sei510_defconfig                               |  2 +-
 configs/sei610_defconfig                               |  2 +-
 configs/smegw01_defconfig                              |  2 +-
 configs/somlabs_visionsom_6ull_defconfig               |  2 +-
 configs/stm32mp13_defconfig                            |  2 +-
 configs/stm32mp13_dhcor_defconfig                      |  2 +-
 configs/stm32mp15_basic_defconfig                      |  2 +-
 configs/stm32mp15_defconfig                            |  2 +-
 configs/stm32mp15_trusted_defconfig                    |  2 +-
 configs/tbs2910_defconfig                              |  2 +-
 configs/tinker-rk3288_defconfig                        |  2 +-
 configs/tinker-s-rk3288_defconfig                      |  2 +-
 configs/udoo_defconfig                                 |  2 +-
 configs/udoo_neo_defconfig                             |  2 +-
 configs/verdin-imx8mp_defconfig                        |  2 +-
 configs/vyasa-rk3288_defconfig                         |  2 +-
 configs/x250_defconfig                                 |  2 +-
 doc/device-tree-bindings/config.txt                    |  2 +-
 drivers/mmc/mmc.c                                      |  4 ++--
 drivers/net/fm/fm.c                                    |  8 ++++----
 drivers/net/phy/cortina.c                              |  8 ++++----
 drivers/qe/qe.c                                        |  8 ++++----
 env/Kconfig                                            | 10 ++++++----
 env/mmc.c                                              |  2 +-
 include/configs/cgtqmx8.h                              |  2 +-
 include/configs/imx7-cm.h                              |  2 +-
 include/configs/imx8mm-cl-iot-gate.h                   |  2 +-
 include/configs/imx8mp_rsb3720.h                       |  2 +-
 include/configs/imx8mq_phanbell.h                      |  2 +-
 include/configs/imx8qm_mek.h                           |  2 +-
 include/configs/imx8qm_rom7720.h                       |  2 +-
 include/configs/imx8qxp_mek.h                          |  2 +-
 include/configs/imx93_evk.h                            |  4 ++--
 include/configs/liteboard.h                            |  2 +-
 include/configs/mx6cuboxi.h                            |  2 +-
 include/configs/mx6sabre_common.h                      |  2 +-
 include/configs/mx6sllevk.h                            |  2 +-
 include/configs/mx6ul_14x14_evk.h                      |  2 +-
 include/configs/mx6ullevk.h                            |  2 +-
 include/configs/mx7ulp_com.h                           |  2 +-
 include/configs/mx7ulp_evk.h                           |  2 +-
 include/configs/pico-imx6.h                            |  2 +-
 include/configs/pico-imx8mq.h                          |  2 +-
 include/configs/tqma6.h                                |  2 +-
 include/configs/vf610twr.h                             |  2 +-
 include/configs/wandboard.h                            |  2 +-
 include/configs/warp7.h                                |  2 +-
 include/configs/xpress.h                               |  2 +-
 162 files changed, 187 insertions(+), 185 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index d2d3e346a36..9daf6cfbc22 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -802,7 +802,7 @@ enum boot_src get_boot_src(void)
 int mmc_get_env_dev(void)
 {
 	enum boot_src src = get_boot_src();
-	int dev = CONFIG_SYS_MMC_ENV_DEV;
+	int dev = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 
 	switch (src) {
 	case BOOT_SOURCE_SD_MMC:
diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 37a5473ac7c..933fef2be2e 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -451,7 +451,7 @@ void get_board_serial(struct tag_serialnr *serialnr)
 #ifdef CONFIG_ENV_IS_IN_MMC
 __weak int board_mmc_get_env_dev(int devno)
 {
-	return CONFIG_SYS_MMC_ENV_DEV;
+	return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 }
 
 int mmc_get_env_dev(void)
@@ -473,7 +473,7 @@ int mmc_get_env_dev(void)
 		break;
 	default:
 		/* If not boot from sd/mmc, use default value */
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 	}
 
 	return board_mmc_get_env_dev(devno);
diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index b5dc45296d1..d7ff694cefc 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -56,7 +56,7 @@ int mmc_get_env_dev(void)
 
 	if (ret != ROM_API_OKAY) {
 		puts("ROMAPI: failure at query_boot_info\n");
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 	}
 
 	boot_type = boot >> 16;
@@ -64,7 +64,7 @@ int mmc_get_env_dev(void)
 
 	/* If not boot from sd/mmc, use default value */
 	if (boot_type != BOOT_TYPE_SD && boot_type != BOOT_TYPE_MMC)
-		return env_get_ulong("mmcdev", 10, CONFIG_SYS_MMC_ENV_DEV);
+		return env_get_ulong("mmcdev", 10, CONFIG_ENV_SDMMC_DEVICE_INDEX);
 
 	return board_mmc_get_env_dev(boot_instance);
 }
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index bb13ca742e3..6d1c9ab7040 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -48,8 +48,8 @@ __weak int board_mmc_get_env_dev(int devno)
 	return devno;
 }
 
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-#define IMX9_MMC_ENV_DEV CONFIG_SYS_MMC_ENV_DEV
+#ifdef CONFIG_ENV_SDMMC_DEVICE_INDEX
+#define IMX9_MMC_ENV_DEV CONFIG_ENV_SDMMC_DEVICE_INDEX
 #else
 #define IMX9_MMC_ENV_DEV 0
 #endif
diff --git a/arch/arm/mach-imx/mmc_env.c b/arch/arm/mach-imx/mmc_env.c
index 34a7d1706f3..e2fa3d3f236 100644
--- a/arch/arm/mach-imx/mmc_env.c
+++ b/arch/arm/mach-imx/mmc_env.c
@@ -10,7 +10,7 @@
 
 __weak int board_mmc_get_env_dev(int devno)
 {
-	return CONFIG_SYS_MMC_ENV_DEV;
+	return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 }
 
 int mmc_get_env_dev(void)
@@ -22,7 +22,7 @@ int mmc_get_env_dev(void)
 
 	/* If not boot from sd/mmc, use default value */
 	if ((boot_type != BOOT_TYPE_SD) && (boot_type != BOOT_TYPE_MMC))
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 
 	return board_mmc_get_env_dev(devno);
 }
diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index d4a61731a67..beb4488b0c8 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -502,7 +502,7 @@ int arch_cpu_init(void)
 #ifdef CONFIG_ENV_IS_IN_MMC
 __weak int board_mmc_get_env_dev(int devno)
 {
-	return CONFIG_SYS_MMC_ENV_DEV;
+	return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 }
 
 static int mmc_get_boot_dev(void)
@@ -535,7 +535,7 @@ int mmc_get_env_dev(void)
 
 	/* If not boot from sd/mmc, use default value */
 	if (devno < 0)
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 
 	return board_mmc_get_env_dev(devno);
 }
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 61d331e0181..d0d7467e822 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -362,7 +362,7 @@ static char *get_reset_cause(char *ret)
 #ifdef CONFIG_ENV_IS_IN_MMC
 __weak int board_mmc_get_env_dev(int devno)
 {
-	return CONFIG_SYS_MMC_ENV_DEV;
+	return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 }
 
 int mmc_get_env_dev(void)
@@ -372,7 +372,7 @@ int mmc_get_env_dev(void)
 
 	/* If not boot from sd/mmc, use default value */
 	if (get_boot_mode() == LOW_POWER_BOOT)
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 
 	bt1_cfg = readl(CMC1_RBASE + 0x40);
 	devno = (bt1_cfg >> 9) & 0x7;
diff --git a/arch/arm/mach-mvebu/armada8k/cpu.c b/arch/arm/mach-mvebu/armada8k/cpu.c
index 7908f75809c..ceaf3954041 100644
--- a/arch/arm/mach-mvebu/armada8k/cpu.c
+++ b/arch/arm/mach-mvebu/armada8k/cpu.c
@@ -109,5 +109,5 @@ int mmc_get_env_dev(void)
 		return 1;
 	}
 
-	return CONFIG_SYS_MMC_ENV_DEV;
+	return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 }
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 75d6693e28a..3e1cd74baf9 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -512,8 +512,8 @@ int mmc_get_env_dev(void)
 	const char *boot_device;
 	struct udevice *dev;
 
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-	devnum = CONFIG_SYS_MMC_ENV_DEV;
+#ifdef CONFIG_ENV_SDMMC_DEVICE_INDEX
+	devnum = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 #else
 	devnum = 0;
 #endif
diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20-a1.env b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20-a1.env
index 0c9f9c4178a..c6fadc574de 100644
--- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20-a1.env
+++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20-a1.env
@@ -6,7 +6,7 @@ earlycon=lpuart32,0x5a060000
 fdt_addr=0x83000000
 boot_fdt=try
 fdt_file=imx8qm-dmsse20-a1.dtb
-mmcdev= __stringify(CONFIG_SYS_MMC_ENV_DEV)
+mmcdev= __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)
 mmcpart= __stringify(CONFIG_SYS_MMC_IMG_LOAD_PART)
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.env b/board/freescale/imx8mm_evk/imx8mm_evk.env
index 29690e75b15..f4dcefebc64 100644
--- a/board/freescale/imx8mm_evk/imx8mm_evk.env
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.env
@@ -14,7 +14,7 @@ ip_dyn=yes
 kernel_addr_r=0x42000000
 loadaddr=CONFIG_SYS_LOAD_ADDR
 mmcautodetect=yes
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 prepare_mcore=setenv mcore_clk clk-imx8mm.mcore_booted;
diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.env b/board/freescale/imx8mn_evk/imx8mn_evk.env
index 16a6543ffc6..acc76ef44dc 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.env
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.env
@@ -14,7 +14,7 @@ ip_dyn=yes
 kernel_addr_r=0x42000000
 loadaddr=CONFIG_SYS_LOAD_ADDR
 mmcautodetect=yes
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted;
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.env b/board/freescale/imx8mp_evk/imx8mp_evk.env
index f70e18fa9d9..5717ad23dba 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.env
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.env
@@ -10,7 +10,7 @@ fdt_addr=0x43000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
 ip_dyn=yes
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.env b/board/freescale/imx8mq_evk/imx8mq_evk.env
index dcfe1c2f2d4..a0d9b5ca551 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.env
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.env
@@ -12,7 +12,7 @@ ip_dyn=yes
 kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 loadaddr=CONFIG_SYS_LOAD_ADDR
 mmcautodetect=yes
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 prepare_mcore=setenv mcore_clk clk-imx8mq.mcore_booted;
diff --git a/board/freescale/imx91_evk/imx91_evk.env b/board/freescale/imx91_evk/imx91_evk.env
index c972d3eb251..3084ef706ea 100644
--- a/board/freescale/imx91_evk/imx91_evk.env
+++ b/board/freescale/imx91_evk/imx91_evk.env
@@ -10,7 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
diff --git a/board/freescale/imx93_evk/imx93_evk.env b/board/freescale/imx93_evk/imx93_evk.env
index 8c3aef6b557..d014f31cd50 100644
--- a/board/freescale/imx93_evk/imx93_evk.env
+++ b/board/freescale/imx93_evk/imx93_evk.env
@@ -10,7 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
diff --git a/board/freescale/imx93_qsb/imx93_qsb.env b/board/freescale/imx93_qsb/imx93_qsb.env
index c972d3eb251..3084ef706ea 100644
--- a/board/freescale/imx93_qsb/imx93_qsb.env
+++ b/board/freescale/imx93_qsb/imx93_qsb.env
@@ -10,7 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
diff --git a/board/grinn/liteboard/board.c b/board/grinn/liteboard/board.c
index c2a44b4aa2d..d61474cdc9a 100644
--- a/board/grinn/liteboard/board.c
+++ b/board/grinn/liteboard/board.c
@@ -84,7 +84,7 @@ static int mmc_get_env_devno(void)
 
 	/* If not boot from sd/mmc, use default value */
 	if (bootsel != 1)
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 
 	/* BOOT_CFG2[3] and BOOT_CFG2[4] */
 	dev_no = (soc_sbmr & 0x00001800) >> 11;
diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 7d2146d5727..92f1f8107a6 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -102,7 +102,7 @@ int mmc_get_env_dev(void)
 		return 1;
 	};
 
-	return CONFIG_SYS_MMC_ENV_DEV;
+	return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 }
 #endif
 
diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index a7d14e774a0..c5ea90a69ea 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -34,7 +34,7 @@ mmcboot=
 			echo WARN: Cannot load the DT;
 		fi;
 	fi;
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=2
 netargs=
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 2c12fc65432..41d7c698cf4 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -51,7 +51,7 @@ mmcboot=
 	else
 		echo WARN: Cannot load the DT;
 	fi;
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=2
 netargs=
diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index ab65cfce5fd..d12a3acd031 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -9,7 +9,7 @@ fdtoverlay_addr_r=0x830c0000
 bootenv_addr_r=0x83500000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 ip_dyn=yes
-mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcdev=CONFIG_ENV_SDMMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=2
 mmcautodetect=yes
diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index 15fb9e4b062..ac1e01a8532 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -828,7 +828,7 @@ const char *env_ext4_get_dev_part(void)
 
 int mmc_get_env_dev(void)
 {
-	const int mmc_env_dev = CONFIG_IS_ENABLED(ENV_IS_IN_MMC, (CONFIG_SYS_MMC_ENV_DEV), (-1));
+	const int mmc_env_dev = CONFIG_IS_ENABLED(ENV_IS_IN_MMC, (CONFIG_ENV_SDMMC_DEVICE_INDEX), (-1));
 
 	if (mmc_env_dev >= 0)
 		return mmc_env_dev;
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index c7a2205ed61..bd1825e697d 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -516,7 +516,7 @@ int board_mmc_init(struct bd_info *bis)
 	return 0;
 }
 
-#ifdef CONFIG_SYS_MMC_ENV_DEV
+#ifdef CONFIG_ENV_SDMMC_DEVICE_INDEX
 int mmc_get_env_dev(void)
 {
 	switch (sunxi_get_boot_device()) {
@@ -525,7 +525,7 @@ int mmc_get_env_dev(void)
 	case BOOT_DEVICE_MMC2:
 		return 1;
 	default:
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 	}
 }
 #endif
diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index 5e4ffc40d72..5707947d3ed 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -185,7 +185,7 @@ static int mmc_burn_image(size_t image_size)
 	lbaint_t	blk_count;
 	ulong		blk_written;
 	int		err;
-	const u8	mmc_dev_num = CONFIG_SYS_MMC_ENV_DEV;
+	const u8	mmc_dev_num = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 #ifdef CONFIG_BLK
 	struct blk_desc *blk_desc;
 #endif
@@ -290,7 +290,7 @@ static size_t mmc_read_file(const char *file_name)
 	loff_t		act_read = 0;
 	int		rc;
 	struct mmc	*mmc;
-	const u8	mmc_dev_num = CONFIG_SYS_MMC_ENV_DEV;
+	const u8	mmc_dev_num = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 
 	mmc = find_mmc_device(mmc_dev_num);
 	if (!mmc) {
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 6c1386cf8d3..6233e109539 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -60,7 +60,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index 90bed496e82..942f1f23c6d 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -58,7 +58,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index cc5e1b8db19..aa3cdc0ab8e 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -57,7 +57,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 514ac7ca9a6..920c037c720 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -56,7 +56,7 @@ CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index a8e769cefa1..bb5b61574c4 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -52,7 +52,7 @@ CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 6fc04a82fda..e7d997cf7e1 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -56,7 +56,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 459e78baa53..cb76bea5610 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -81,7 +81,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index 20d0bf9dc25..7d8624bbc91 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -75,7 +75,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/cgtqmx8_defconfig b/configs/cgtqmx8_defconfig
index 3f45e9efdde..58dc11b87d2 100644
--- a/configs/cgtqmx8_defconfig
+++ b/configs/cgtqmx8_defconfig
@@ -68,7 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index ad42ab847c8..edaf2f62c53 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -62,7 +62,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 704bfe95e62..3a0058cbbfa 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -57,7 +57,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index f6ababb30bf..ea9d5250780 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -53,7 +53,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index 6aa60c2e868..0e34020ffa2 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index 215caf3ba23..3739b71a7e8 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -32,7 +32,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index 5169b089687..9d0724b6480 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -24,7 +24,7 @@ CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=0
+CONFIG_ENV_SDMMC_DEVICE_INDEX=0
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_GPIO_HOG=y
 CONFIG_DM_PCA953X=y
diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defconfig
index c5326c7c383..918e419576f 100644
--- a/configs/imx6dl_mamoj_defconfig
+++ b/configs/imx6dl_mamoj_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index b52341c1a49..9ea260ad82f 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -78,7 +78,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index fd4aeddc4a8..044e3411c84 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -81,7 +81,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index 05707323d70..a624e36a33b 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -59,7 +59,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 41faec932ad..0c47c80e2a2 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -59,7 +59,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 8b7b7c61da2..ccf995b5027 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -75,7 +75,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_COMPOSITE_CCF=y
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index ffb4ac78cda..bb010df9652 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -74,7 +74,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index 7d1772c5d09..f3e046ce78d 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -78,7 +78,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index f7684959972..6355cd7d772 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -61,7 +61,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index a194eeb7dc5..386a0746504 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -63,7 +63,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 0937a812d20..0fbe471aa7b 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -84,7 +84,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="freescale/imx8mm-venice-gw71xx-0x freescale/imx8mm-venice-gw72xx-0x freescale/imx8mm-venice-gw73xx-0x freescale/imx8mm-venice-gw7901 freescale/imx8mm-venice-gw7902 freescale/imx8mm-venice-gw7903 freescale/imx8mm-venice-gw7904 freescale/imx8mm-venice-gw75xx-0x"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index 0f9bf8586bd..ae6d5afdd0f 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -83,7 +83,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index 989368282b8..a295b790437 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -83,7 +83,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index f340cb1b7c5..f6b13305d20 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -83,7 +83,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 4edcda0dc85..05b3be99b0a 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -66,7 +66,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_IMX8MN=y
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index cfa07c59901..34bf452ebc3 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -61,7 +61,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 354e0907d19..99c70b9d328 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -83,7 +83,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index 0679d041a6e..7df09a3b776 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -67,7 +67,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 1a4aa74f0a6..b77a83fb9be 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -81,7 +81,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx8mp_debix_model_a_defconfig b/configs/imx8mp_debix_model_a_defconfig
index 9654a45d1db..41250db748f 100644
--- a/configs/imx8mp_debix_model_a_defconfig
+++ b/configs/imx8mp_debix_model_a_defconfig
@@ -60,7 +60,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 48748a0d660..7b1dd2df52c 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -68,7 +68,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx8mp_navqp_defconfig b/configs/imx8mp_navqp_defconfig
index f7ae8c0a5b0..1a9191f4cf8 100644
--- a/configs/imx8mp_navqp_defconfig
+++ b/configs/imx8mp_navqp_defconfig
@@ -59,7 +59,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index 000c536c9b7..a966ea34add 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -96,7 +96,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index c7623f23aa7..fb7fd6dac13 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -96,7 +96,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 51856a74399..3a9bcef8f27 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -86,7 +86,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="freescale/imx8mp-venice-gw71xx-2x freescale/imx8mp-venice-gw72xx-2x freescale/imx8mp-venice-gw73xx-2x freescale/imx8mp-venice-gw74xx freescale/imx8mp-venice-gw75xx-2x"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_IP_DEFRAG=y
 CONFIG_PROT_TCP_SACK=y
diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
index ac65565009e..e64e8aa835a 100644
--- a/configs/imx8mq_cm_defconfig
+++ b/configs/imx8mq_cm_defconfig
@@ -57,7 +57,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 6be4b95148e..7125030f697 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index ab53f90093e..7f9ef694f57 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index 9cd1bb5e4e9..40f8f1aa4cf 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
diff --git a/configs/imx8qm_dmsse20a1_defconfig b/configs/imx8qm_dmsse20a1_defconfig
index dfee90bc6fb..06fe8f1c0c0 100644
--- a/configs/imx8qm_dmsse20a1_defconfig
+++ b/configs/imx8qm_dmsse20a1_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_FAT=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index e882add95db..bf2a452aaf7 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -74,7 +74,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK=y
diff --git a/configs/imx8qm_rom7720_a1_4G_defconfig b/configs/imx8qm_rom7720_a1_4G_defconfig
index aa913f32500..59ee5ad5257 100644
--- a/configs/imx8qm_rom7720_a1_4G_defconfig
+++ b/configs/imx8qm_rom7720_a1_4G_defconfig
@@ -56,7 +56,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index 655301c8619..344106afa4d 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -75,7 +75,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index b86ff25bbda..82817aadccb 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -81,7 +81,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index a79f33a2211..0b6bced3270 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -81,7 +81,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index f6cc5fe6316..69360b2be27 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -88,7 +88,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index f638c4a40e3..ceef891bc13 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -76,7 +76,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
index 83121c8b321..62558bfee11 100644
--- a/configs/imx93_9x9_qsb_defconfig
+++ b/configs/imx93_9x9_qsb_defconfig
@@ -79,7 +79,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
index 3807fe17989..b5ba65a7b80 100644
--- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
+++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
@@ -79,7 +79,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index 1ea51450ba8..1e2b8b3068c 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -88,7 +88,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index ef68e1cf1f5..8d9a7674bab 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 3ad82c9afff..3d36db66f68 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 8e439cad3c1..28186e91dad 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 56b4086ee3f..ad37ad0df1f 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
diff --git a/configs/kp_imx6q_tpc_defconfig b/configs/kp_imx6q_tpc_defconfig
index 710bbe4283a..0e766834731 100644
--- a/configs/kp_imx6q_tpc_defconfig
+++ b/configs/kp_imx6q_tpc_defconfig
@@ -49,7 +49,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
 # CONFIG_BLOCK_CACHE is not set
diff --git a/configs/mvebu_crb_cn9130_defconfig b/configs/mvebu_crb_cn9130_defconfig
index 75b7f95be77..0dbbbfd2657 100644
--- a/configs/mvebu_crb_cn9130_defconfig
+++ b/configs/mvebu_crb_cn9130_defconfig
@@ -43,7 +43,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_AHCI_GENERIC=y
diff --git a/configs/mvebu_db_cn9130_defconfig b/configs/mvebu_db_cn9130_defconfig
index 000e5d3f3eb..0fe009f3bda 100644
--- a/configs/mvebu_db_cn9130_defconfig
+++ b/configs/mvebu_db_cn9130_defconfig
@@ -44,7 +44,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_AHCI_GENERIC=y
diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index c29f38fa49e..99b4c3495d7 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -69,7 +69,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/mx6sxsabresd_defconfig b/configs/mx6sxsabresd_defconfig
index 0dc2e2595f1..87ef0990058 100644
--- a/configs/mx6sxsabresd_defconfig
+++ b/configs/mx6sxsabresd_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index 15709a1fcc7..1457fcd0d6e 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/mx6ul_9x9_evk_defconfig b/configs/mx6ul_9x9_evk_defconfig
index 127a64f6af9..cdbb9a2a128 100644
--- a/configs/mx6ul_9x9_evk_defconfig
+++ b/configs/mx6ul_9x9_evk_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/mx6ull_14x14_evk_defconfig b/configs/mx6ull_14x14_evk_defconfig
index 17f46e06627..869b54517e0 100644
--- a/configs/mx6ull_14x14_evk_defconfig
+++ b/configs/mx6ull_14x14_evk_defconfig
@@ -38,7 +38,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/mx6ull_14x14_evk_plugin_defconfig b/configs/mx6ull_14x14_evk_plugin_defconfig
index 2a9f85c1313..7e10c1ee14a 100644
--- a/configs/mx6ull_14x14_evk_plugin_defconfig
+++ b/configs/mx6ull_14x14_evk_plugin_defconfig
@@ -39,7 +39,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/mx6ulz_14x14_evk_defconfig b/configs/mx6ulz_14x14_evk_defconfig
index a01bff6d8a8..44fe9faad6c 100644
--- a/configs/mx6ulz_14x14_evk_defconfig
+++ b/configs/mx6ulz_14x14_evk_defconfig
@@ -34,7 +34,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index d4250d076bc..ff0becaec44 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -44,7 +44,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index c3335cee30b..c066fe099a8 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -44,7 +44,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 7ae3d93bfb9..9a175f8c53c 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -44,7 +44,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 09f8effd937..5c1635d7042 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -49,7 +49,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index 98fe2d14a1c..b95b7c1a006 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -49,7 +49,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index e68384d4278..0d4581f861d 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -81,7 +81,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_COMPOSITE_CCF=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 47059a8ee6b..ca4eed10a7d 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -94,7 +94,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index 8e47c727c5a..4d2f39cd49f 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index d8b51fd731f..24be4a9d60f 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -92,7 +92,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index c6b8d31d6f3..59989a84c35 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -87,7 +87,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 2ff26b73792..c97b120aac6 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -94,7 +94,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index 0e14944eed7..6ba0eb98774 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index d100fae9154..423f7ec6526 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -56,7 +56,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
index b3f6498d528..381d83e5732 100644
--- a/configs/riotboard_defconfig
+++ b/configs/riotboard_defconfig
@@ -45,7 +45,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 19ab9f8a427..16246bab3b6 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index bb0f213a368..5ce22a64db1 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
index 0568e551de4..794934a5677 100644
--- a/configs/rock-pi-e-v3-rk3328_defconfig
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index d13890c9f41..de2eb3dfd99 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -47,7 +47,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index b5cedbbe824..e7d4fdd751e 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -37,7 +37,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/configs/s5p4418_nanopi2_defconfig b/configs/s5p4418_nanopi2_defconfig
index 548963c933f..bfeade2ff2e 100644
--- a/configs/s5p4418_nanopi2_defconfig
+++ b/configs/s5p4418_nanopi2_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_NO_NET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_NEXELL=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index b9bedcc4baf..d60964aefe7 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 770a487398f..ba2b212a106 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index ddfec1fa7f3..356db1257ce 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -51,7 +51,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/somlabs_visionsom_6ull_defconfig b/configs/somlabs_visionsom_6ull_defconfig
index d487a2e728e..bf956020159 100644
--- a/configs/somlabs_visionsom_6ull_defconfig
+++ b/configs/somlabs_visionsom_6ull_defconfig
@@ -39,7 +39,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index d9192ed849a..1804ece92b3 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -52,7 +52,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=-1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_BUTTON=y
diff --git a/configs/stm32mp13_dhcor_defconfig b/configs/stm32mp13_dhcor_defconfig
index 2da9287ea7b..a08d9f53896 100644
--- a/configs/stm32mp13_dhcor_defconfig
+++ b/configs/stm32mp13_dhcor_defconfig
@@ -34,7 +34,7 @@ CONFIG_ENV_SPI_MAX_HZ=50000000
 CONFIG_CLK_SCMI=y
 CONFIG_SET_DFU_ALT_INFO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_SYS_MMC_ENV_DEV=0
+CONFIG_ENV_SDMMC_DEVICE_INDEX=0
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_REGULATOR_SCMI=y
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index b095c24ddd1..474c34f2b7b 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -91,7 +91,7 @@ CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=-1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=-1
 CONFIG_ENV_MMC_USE_DT=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 # CONFIG_SPL_ENV_IS_IN_SPI_FLASH is not set
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index fdd3655abce..86ecfe51cba 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -63,7 +63,7 @@ CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=-1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index 84a8a08db40..a00450c9918 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -64,7 +64,7 @@ CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=-1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_USE_SERVERIP=y
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index 57d452f960c..b4c32441315 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-ex
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 6abc49ddeed..34b254493db 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -47,7 +47,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 1b4496b570c..f1ceadc32c3 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -47,7 +47,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/udoo_defconfig b/configs/udoo_defconfig
index cb9ae022c99..22c9e07c69c 100644
--- a/configs/udoo_defconfig
+++ b/configs/udoo_defconfig
@@ -39,7 +39,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 517313be9a5..85db7fa619a 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 445aad7f4c8..a4809270e25 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -96,7 +96,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_SDMMC_DEVICE_INDEX=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index 4dd2b4d8ddb..52ec12c4951 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -57,7 +57,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/x250_defconfig b/configs/x250_defconfig
index 628ce40fc91..f8d9129719b 100644
--- a/configs/x250_defconfig
+++ b/configs/x250_defconfig
@@ -46,7 +46,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_SDMMC_DEVICE_INDEX=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_IPV6=y
diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
index f50c68bbdc3..8584cc6dcf4 100644
--- a/doc/device-tree-bindings/config.txt
+++ b/doc/device-tree-bindings/config.txt
@@ -70,7 +70,7 @@ u-boot,mmc-env-offset-redundant (int)
 u-boot,mmc-env-partition (int)
 	if present, the environment shall be placed at the last
 	CONFIG_ENV_SIZE blocks of the partition on the
-	CONFIG_SYS_MMC_ENV_DEV.
+	CONFIG_ENV_SDMMC_DEVICE_INDEX.
 
 	if u-boot,mmc-env-offset* is present, this setting will take
 	precedence. In that case, only if the partition is not found,
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 31a72366206..7bf9248305a 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3271,8 +3271,8 @@ int mmc_set_bkops_enable(struct mmc *mmc, bool autobkops, bool enable)
 
 __weak int mmc_get_env_dev(void)
 {
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-	return CONFIG_SYS_MMC_ENV_DEV;
+#ifdef CONFIG_ENV_SDMMC_DEVICE_INDEX
+	return CONFIG_ENV_SDMMC_DEVICE_INDEX;
 #else
 	return 0;
 #endif
diff --git a/drivers/net/fm/fm.c b/drivers/net/fm/fm.c
index a8caa0f0927..06d47e70a80 100644
--- a/drivers/net/fm/fm.c
+++ b/drivers/net/fm/fm.c
@@ -410,12 +410,12 @@ int fm_init_common(int index, struct ccsr_fman *reg, const char *firmware_name)
 			spi_flash_free(ucode_flash);
 		}
 	} else if (src == BOOT_SOURCE_SD_MMC) {
-		int dev = CONFIG_SYS_MMC_ENV_DEV;
+		int dev = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 
 		addr = malloc(CONFIG_SYS_QE_FMAN_FW_LENGTH);
 		u32 cnt = CONFIG_SYS_QE_FMAN_FW_LENGTH / 512;
 		u32 blk = CONFIG_SYS_FMAN_FW_ADDR / 512;
-		struct mmc *mmc = find_mmc_device(CONFIG_SYS_MMC_ENV_DEV);
+		struct mmc *mmc = find_mmc_device(CONFIG_ENV_SDMMC_DEVICE_INDEX);
 
 		if (!mmc) {
 			printf("\nMMC cannot find device for ucode\n");
@@ -514,11 +514,11 @@ int fm_init_common(int index, struct ccsr_fman *reg, const char *firmware_name)
 		spi_flash_free(ucode_flash);
 	}
 #elif defined(CONFIG_SYS_QE_FMAN_FW_IN_MMC)
-	int dev = CONFIG_SYS_MMC_ENV_DEV;
+	int dev = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 	void *addr = malloc(CONFIG_SYS_QE_FMAN_FW_LENGTH);
 	u32 cnt = CONFIG_SYS_QE_FMAN_FW_LENGTH / 512;
 	u32 blk = CONFIG_SYS_FMAN_FW_ADDR / 512;
-	struct mmc *mmc = find_mmc_device(CONFIG_SYS_MMC_ENV_DEV);
+	struct mmc *mmc = find_mmc_device(CONFIG_ENV_SDMMC_DEVICE_INDEX);
 
 	if (!mmc)
 		printf("\nMMC cannot find device for ucode\n");
diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
index d043e859bad..adea8742833 100644
--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -170,10 +170,10 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 			spi_flash_free(ucode_flash);
 		}
 	} else if (src == BOOT_SOURCE_SD_MMC) {
-		int dev = CONFIG_SYS_MMC_ENV_DEV;
+		int dev = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 		u32 cnt = CONFIG_CORTINA_FW_LENGTH / 512;
 		u32 blk = cortina_fw_addr / 512;
-		struct mmc *mmc = find_mmc_device(CONFIG_SYS_MMC_ENV_DEV);
+		struct mmc *mmc = find_mmc_device(CONFIG_ENV_SDMMC_DEVICE_INDEX);
 
 		if (!mmc) {
 			puts("Failed to find MMC device for Cortina ucode\n");
@@ -223,10 +223,10 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 		spi_flash_free(ucode_flash);
 	}
 #elif defined(CONFIG_SYS_CORTINA_FW_IN_MMC)
-	int dev = CONFIG_SYS_MMC_ENV_DEV;
+	int dev = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 	u32 cnt = CONFIG_CORTINA_FW_LENGTH / 512;
 	u32 blk = cortina_fw_addr / 512;
-	struct mmc *mmc = find_mmc_device(CONFIG_SYS_MMC_ENV_DEV);
+	struct mmc *mmc = find_mmc_device(CONFIG_ENV_SDMMC_DEVICE_INDEX);
 
 	if (!mmc) {
 		puts("Failed to find MMC device for Cortina ucode\n");
diff --git a/drivers/qe/qe.c b/drivers/qe/qe.c
index 9631337b8d9..b70c3f3c2a2 100644
--- a/drivers/qe/qe.c
+++ b/drivers/qe/qe.c
@@ -243,7 +243,7 @@ void u_qe_init(void)
 				CFG_SYS_FSL_QSPI_BASE);
 
 	if (src == BOOT_SOURCE_SD_MMC) {
-		int dev = CONFIG_SYS_MMC_ENV_DEV;
+		int dev = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 		u32 cnt = CONFIG_SYS_QE_FMAN_FW_LENGTH / 512;
 		u32 blk = CONFIG_SYS_QE_FW_ADDR / 512;
 
@@ -252,7 +252,7 @@ void u_qe_init(void)
 			return;
 		}
 		addr = malloc(CONFIG_SYS_QE_FMAN_FW_LENGTH);
-		struct mmc *mmc = find_mmc_device(CONFIG_SYS_MMC_ENV_DEV);
+		struct mmc *mmc = find_mmc_device(CONFIG_ENV_SDMMC_DEVICE_INDEX);
 
 		if (!mmc) {
 			free(addr);
@@ -277,7 +277,7 @@ void u_qe_init(void)
 
 	void *addr = (void *)CONFIG_SYS_QE_FW_ADDR;
 #ifdef CONFIG_SYS_QE_FMAN_FW_IN_MMC
-	int dev = CONFIG_SYS_MMC_ENV_DEV;
+	int dev = CONFIG_ENV_SDMMC_DEVICE_INDEX;
 	u32 cnt = CONFIG_SYS_QE_FMAN_FW_LENGTH / 512;
 	u32 blk = CONFIG_SYS_QE_FW_ADDR / 512;
 
@@ -286,7 +286,7 @@ void u_qe_init(void)
 		return;
 	}
 	addr = malloc(CONFIG_SYS_QE_FMAN_FW_LENGTH);
-	struct mmc *mmc = find_mmc_device(CONFIG_SYS_MMC_ENV_DEV);
+	struct mmc *mmc = find_mmc_device(CONFIG_ENV_SDMMC_DEVICE_INDEX);
 
 	if (!mmc) {
 		printf("\nMMC cannot find device for ucode\n");
diff --git a/env/Kconfig b/env/Kconfig
index b9840665640..6bb882baa9e 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -215,7 +215,7 @@ config ENV_IS_IN_MMC
 	  Define this if you have an MMC device which you want to use for the
 	  environment.
 
-	  CONFIG_SYS_MMC_ENV_DEV:
+	  CONFIG_ENV_SDMMC_DEVICE_INDEX:
 
 	  Specifies which MMC device the environment is stored in.
 
@@ -666,13 +666,15 @@ config ENV_RELOC_GD_ENV_ADDR
 	  Relocate the early env_addr pointer so we know it is not inside
 	  the binary. Some systems need this and for the rest, it doesn't hurt.
 
-config SYS_MMC_ENV_DEV
-	int "mmc device number"
+config ENV_SDMMC_DEVICE_INDEX
+	int "SD/MMC device index"
 	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || ENV_IS_IN_EXT4 || \
 		CMD_MVEBU_BUBT || FMAN_ENET || QE || PHY_CORTINA
 	default 0
 	help
-	  MMC device number on the platform where the environment is stored.
+	  SD/MMC device index on the platform where the environment is stored.
+	  The index is often derived from DT aliases mmcN node ordering, and
+	  matches the 'mmc list' command output.
 
 config SYS_MMC_ENV_PART
 	int "mmc partition number"
diff --git a/env/mmc.c b/env/mmc.c
index 025d6e33c27..2e3edbff21d 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -164,7 +164,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 #if defined(CONFIG_ENV_MMC_PARTITION)
 	str = CONFIG_ENV_MMC_PARTITION;
 #else
-	/* look for the partition in mmc CONFIG_SYS_MMC_ENV_DEV */
+	/* look for the partition in mmc CONFIG_ENV_SDMMC_DEVICE_INDEX */
 	str = ofnode_conf_read_str(dt_prop.partition);
 #endif
 
diff --git a/include/configs/cgtqmx8.h b/include/configs/cgtqmx8.h
index 0d338389cb9..2acbdbaf405 100644
--- a/include/configs/cgtqmx8.h
+++ b/include/configs/cgtqmx8.h
@@ -64,7 +64,7 @@
 	"fdt_addr=0x83000000\0"			\
 	"boot_fdt=try\0" \
 	"fdt_file=imx8qm-cgt-qmx8.dtb\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/imx7-cm.h b/include/configs/imx7-cm.h
index 36c4c5b8b50..9257ecd4964 100644
--- a/include/configs/imx7-cm.h
+++ b/include/configs/imx7-cm.h
@@ -28,7 +28,7 @@
 	"console=ttymxc0\0" \
 	"fdt_file=imx7-cm.dtb\0" \
 	"fdt_addr=0x83000000\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
 	"mmcargs=setenv bootargs console=${console},${baudrate} " \
diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8mm-cl-iot-gate.h
index 6ed4a6fd3fc..466ff20bcb8 100644
--- a/include/configs/imx8mm-cl-iot-gate.h
+++ b/include/configs/imx8mm-cl-iot-gate.h
@@ -76,7 +76,7 @@
 	"fdtfile=sb-iotgimx8.dtb\0" \
 	"initrd_addr=0x43800000\0"		\
 	"bootm_size=0x10000000\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/imx8mp_rsb3720.h b/include/configs/imx8mp_rsb3720.h
index 8b96f7fd1e4..f58aa372121 100644
--- a/include/configs/imx8mp_rsb3720.h
+++ b/include/configs/imx8mp_rsb3720.h
@@ -77,7 +77,7 @@
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"initrd_addr=0x43800000\0"		\
 	"bootm_size=0x10000000\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/imx8mq_phanbell.h b/include/configs/imx8mq_phanbell.h
index 3bc4b0034e8..ffca1e22da5 100644
--- a/include/configs/imx8mq_phanbell.h
+++ b/include/configs/imx8mq_phanbell.h
@@ -39,7 +39,7 @@
 	"fdt_file=imx8mq-phanbell.dtb\0" \
 	"initrd_addr=0x43800000\0"		\
 	"initrd_high=0xffffffffffffffff\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/imx8qm_mek.h b/include/configs/imx8qm_mek.h
index 842184bcae2..e12aec0316f 100644
--- a/include/configs/imx8qm_mek.h
+++ b/include/configs/imx8qm_mek.h
@@ -34,7 +34,7 @@
 	"fdt_file=undefined\0" \
 	"initrd_addr=0x83800000\0"		\
 	"initrd_high=0xffffffffffffffff\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/imx8qm_rom7720.h b/include/configs/imx8qm_rom7720.h
index df2cb8d9ced..528794d53b9 100644
--- a/include/configs/imx8qm_rom7720.h
+++ b/include/configs/imx8qm_rom7720.h
@@ -58,7 +58,7 @@
 	"boot_fdt=try\0" \
 	"fdt_file=imx8qm-rom7720-a1.dtb\0" \
 	"initrd_addr=0x83800000\0"		\
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk2p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/imx8qxp_mek.h b/include/configs/imx8qxp_mek.h
index 1b6eb2b81cf..7cfb9b1d804 100644
--- a/include/configs/imx8qxp_mek.h
+++ b/include/configs/imx8qxp_mek.h
@@ -34,7 +34,7 @@
 	"fdt_file=undefined\0" \
 	"initrd_addr=0x83800000\0"		\
 	"initrd_high=0xffffffffffffffff\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index eb40a69d20c..d9960e61e78 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -17,8 +17,8 @@
 #define CFG_MALLOC_F_ADDR		0x204D0000
 #endif
 
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-#define IMX93_EVK_MMC_ENV_DEV CONFIG_SYS_MMC_ENV_DEV
+#ifdef CONFIG_ENV_SDMMC_DEVICE_INDEX
+#define IMX93_EVK_MMC_ENV_DEV CONFIG_ENV_SDMMC_DEVICE_INDEX
 #else
 #define IMX93_EVK_MMC_ENV_DEV 0
 #endif
diff --git a/include/configs/liteboard.h b/include/configs/liteboard.h
index fc6bc6b28ba..7b1b92db670 100644
--- a/include/configs/liteboard.h
+++ b/include/configs/liteboard.h
@@ -30,7 +30,7 @@
 	"fdt_addr=0x83000000\0" \
 	"boot_fdt=try\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/mx6cuboxi.h b/include/configs/mx6cuboxi.h
index 068b9e4d25f..a39a2e61f4d 100644
--- a/include/configs/mx6cuboxi.h
+++ b/include/configs/mx6cuboxi.h
@@ -33,7 +33,7 @@
 	"ip_dyn=yes\0" \
 	"console=ttymxc0\0" \
 	"bootm_size=0x10000000\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	"finduuid=part uuid mmc 1:1 uuid\0" \
 	"update_sd_firmware=" \
 		"if test ${ip_dyn} = yes; then " \
diff --git a/include/configs/mx6sabre_common.h b/include/configs/mx6sabre_common.h
index 9c61350a33b..168b2a69738 100644
--- a/include/configs/mx6sabre_common.h
+++ b/include/configs/mx6sabre_common.h
@@ -50,7 +50,7 @@
 	"fdt_high=0xffffffff\0"	  \
 	"initrd_high=0xffffffff\0" \
 	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	"mmcpart=1\0" \
 	"finduuid=part uuid mmc ${mmcdev}:2 uuid\0" \
 	"update_sd_firmware=" \
diff --git a/include/configs/mx6sllevk.h b/include/configs/mx6sllevk.h
index 0ba4054bbe4..6ba47353b0c 100644
--- a/include/configs/mx6sllevk.h
+++ b/include/configs/mx6sllevk.h
@@ -23,7 +23,7 @@
 	"fdt_addr=0x83000000\0" \
 	"boot_fdt=try\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/mx6ul_14x14_evk.h b/include/configs/mx6ul_14x14_evk.h
index 3716dc75b96..679f31babf5 100644
--- a/include/configs/mx6ul_14x14_evk.h
+++ b/include/configs/mx6ul_14x14_evk.h
@@ -42,7 +42,7 @@
 	"ip_dyn=yes\0" \
 	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"videomode=video=ctfb:x:480,y:272,depth:24,pclk:108695,le:8,ri:4,up:2,lo:4,hs:41,vs:10,sync:0,vmode:0\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/mx6ullevk.h b/include/configs/mx6ullevk.h
index 910140ab4b7..78ed091d005 100644
--- a/include/configs/mx6ullevk.h
+++ b/include/configs/mx6ullevk.h
@@ -34,7 +34,7 @@
 	"boot_fdt=try\0" \
 	"ip_dyn=yes\0" \
 	"videomode=video=ctfb:x:480,y:272,depth:24,pclk:108695,le:8,ri:4,up:2,lo:4,hs:41,vs:10,sync:0,vmode:0\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/mx7ulp_com.h b/include/configs/mx7ulp_com.h
index f8e3950fa32..7008c8c7b1b 100644
--- a/include/configs/mx7ulp_com.h
+++ b/include/configs/mx7ulp_com.h
@@ -35,7 +35,7 @@
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx7ulp-com.dtb\0" \
 	"fdt_addr=0x63000000\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
 	"mmcargs=setenv bootargs console=${console},${baudrate} " \
diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index d1c1202d061..d80939524f1 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -38,7 +38,7 @@
 	"boot_fdt=try\0" \
 	"earlycon=lpuart32,0x402D0010\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
diff --git a/include/configs/pico-imx6.h b/include/configs/pico-imx6.h
index 500dd8c069a..df08afea649 100644
--- a/include/configs/pico-imx6.h
+++ b/include/configs/pico-imx6.h
@@ -42,7 +42,7 @@
 	"initrd_high=0xffffffff\0" \
 	"fdt_addr_r=0x18000000\0" \
 	"fdt_addr=0x18000000\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	CFG_DFU_ENV_SETTINGS \
 	"finduuid=part uuid mmc 0:1 uuid\0" \
 	"findfdt="\
diff --git a/include/configs/pico-imx8mq.h b/include/configs/pico-imx8mq.h
index 3012f64c0ae..8dc00503c2a 100644
--- a/include/configs/pico-imx8mq.h
+++ b/include/configs/pico-imx8mq.h
@@ -33,7 +33,7 @@
 	"fdt_file=imx8mq-pico-pi.dtb\0"					\
 	"initrd_addr=0x43800000\0"					\
 	"initrd_high=0xffffffffffffffff\0"				\
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0"		\
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0"		\
 	"mmcpart=1\0"	\
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0"			\
 	"mmcautodetect=yes\0"						\
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index fd4d170456a..78eea1def40 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -54,7 +54,7 @@
 	"fdt_size="__stringify(TQMA6_FDT_SECTOR_COUNT)"\0"                     \
 	"kernel_start="__stringify(TQMA6_KERNEL_SECTOR_START)"\0"              \
 	"kernel_size="__stringify(TQMA6_KERNEL_SECTOR_COUNT)"\0"               \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0"                       \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0"                       \
 	"loadimage=mmc dev ${mmcdev}; "                                        \
 		"mmc read ${loadaddr} ${kernel_start} ${kernel_size};\0"       \
 	"loadfdt=mmc dev ${mmcdev}; "                                          \
diff --git a/include/configs/vf610twr.h b/include/configs/vf610twr.h
index d10b88f1575..91aa400c5ee 100644
--- a/include/configs/vf610twr.h
+++ b/include/configs/vf610twr.h
@@ -52,7 +52,7 @@
 	"fdt_file=vf610-twr.dtb\0" \
 	"boot_fdt=try\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
 	"update_sd_firmware_filename=u-boot.imx\0" \
diff --git a/include/configs/wandboard.h b/include/configs/wandboard.h
index b5b342b3538..2d39175b9d5 100644
--- a/include/configs/wandboard.h
+++ b/include/configs/wandboard.h
@@ -26,7 +26,7 @@
 	"fdt_addr_r=0x18000000\0" \
 	"fdt_addr=0x18000000\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcdev=" __stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX) "\0" \
 	"finduuid=part uuid mmc 0:1 uuid\0" \
 	"update_sd_firmware_filename=u-boot.imx\0" \
 	"update_sd_firmware=" \
diff --git a/include/configs/warp7.h b/include/configs/warp7.h
index a5278d1cb9b..5086928241d 100644
--- a/include/configs/warp7.h
+++ b/include/configs/warp7.h
@@ -42,7 +42,7 @@
 	"fdtovaddr=0x83100000\0" \
 	"boot_fdt=try\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"rootpart=" __stringify(CONFIG_WARP7_ROOT_PART) "\0" \
 	"finduuid=part uuid mmc 0:${rootpart} uuid\0" \
diff --git a/include/configs/xpress.h b/include/configs/xpress.h
index 8efebf77c3d..9c1d8ce1694 100644
--- a/include/configs/xpress.h
+++ b/include/configs/xpress.h
@@ -40,7 +40,7 @@
 	"fdt_addr=0x83000000\0" \
 	"boot_fdt=try\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev="__stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev="__stringify(CONFIG_ENV_SDMMC_DEVICE_INDEX)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
-- 
2.47.2

