Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A085CC36008
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 21:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9262D81D25;
	Sat, 22 Mar 2025 22:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EzvWNh8M";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xne1433z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185C181CFD; Sat, 22 Mar 2025 22:56:51 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0059881219
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 22:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZKtSZ4pcCz9shn;
 Sat, 22 Mar 2025 22:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BP3GHqTKb8Afl5TCPKBWnDCeYeG2DH91wyaJxuVZ50k=;
 b=EzvWNh8MHlAvxhSoXTMijtLU7e9uTaaER67cKoQWb7yiLZYPUW1dwcI1e3i/Arr8PLO6/u
 dbFOWeZT6NcpW3mYTNWlQa/Iz/simLWgWTajs0gY/4AD+WiDDOEIgtboEO8JZVGpUpQ2Ql
 AnOW2uaIa/s9KMre2XKtOzd2y15L5tzlV+WNGWFz6I6+hiCWgBdSwOB50rS/qUj8n7ML88
 xIG8+I/WLSnNcK08PFGoQxwmJBmwcNNVWfJ/3LMOw8/Wv5fqiamyNVqCsDJGa0TNajE69b
 O9vClefngbvNxkb2Atun4GiTEurlI4Kqv01bM+c3a9miiveti9tudXFq4KDCmQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BP3GHqTKb8Afl5TCPKBWnDCeYeG2DH91wyaJxuVZ50k=;
 b=xne1433zYrkbvRUYHthazUea9avHGM8jquZ4bEy8xhmqJRiL5NYjYWro+5cpVdzzEc6/tp
 nJWDqFNL39DP7TSdGlzezLfjWOM/A1nylwh+WtvtrLe3JIf9rCqpLmHnDmztuz1g5R0boc
 AZOL0gtYvkFQveC8od3QqsuFC2LK+mocm0WAnNetI6gRGX1PaGGz6hQZvtmxp1WyQirU85
 puj2Xy8nggVdKKuFsOF1DYiCxsUFoQhMfc+PnfQwK/Ch9dU6M9DCpwdDH6gYEZod8X0RfG
 j7ueVHPE7VyMcKU0Ioj+DYNWmWCHJxnb4Js9yAplrREEofuEyT3kxRwJ8OxnJQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] env: Rename SYS_REDUNDAND_ENVIRONMENT to
 ENV_REDUNDAND_ENVIRONMENT
Date: Sat, 22 Mar 2025 22:55:22 +0100
Message-ID: <20250322215624.18994-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7642c181ebc78ba10b3
X-MBO-RS-META: nfz3imn413at1d84je6nc44a73enkft7
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

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/am335x_guardian_defconfig                |  2 +-
 configs/am335x_igep003x_defconfig                |  2 +-
 configs/am335x_shc_defconfig                     |  2 +-
 configs/am335x_shc_ict_defconfig                 |  2 +-
 configs/am335x_shc_netboot_defconfig             |  2 +-
 configs/am335x_shc_sdboot_defconfig              |  2 +-
 configs/am335x_sl50_defconfig                    |  2 +-
 configs/am43xx_evm_qspiboot_defconfig            |  2 +-
 configs/am43xx_hs_evm_qspi_defconfig             |  2 +-
 configs/am57xx_evm_defconfig                     |  2 +-
 configs/am57xx_hs_evm_defconfig                  |  2 +-
 configs/am57xx_hs_evm_usb_defconfig              |  2 +-
 configs/am65x_evm_a53_defconfig                  |  2 +-
 configs/amd_versal2_virt_defconfig               |  2 +-
 configs/aristainetos2c_defconfig                 |  2 +-
 configs/aristainetos2ccslb_defconfig             |  2 +-
 configs/at91sam9260ek_nandflash_defconfig        |  2 +-
 configs/at91sam9261ek_nandflash_defconfig        |  2 +-
 configs/at91sam9263ek_nandflash_defconfig        |  2 +-
 configs/at91sam9263ek_norflash_boot_defconfig    |  2 +-
 configs/at91sam9263ek_norflash_defconfig         |  2 +-
 configs/at91sam9g10ek_nandflash_defconfig        |  2 +-
 configs/at91sam9g20ek_2mmc_nandflash_defconfig   |  2 +-
 configs/at91sam9g20ek_nandflash_defconfig        |  2 +-
 configs/at91sam9m10g45ek_nandflash_defconfig     |  2 +-
 configs/at91sam9n12ek_nandflash_defconfig        |  2 +-
 configs/at91sam9rlek_nandflash_defconfig         |  2 +-
 configs/at91sam9x5ek_nandflash_defconfig         |  2 +-
 configs/at91sam9xeek_nandflash_defconfig         |  2 +-
 configs/axm_defconfig                            |  2 +-
 configs/bcm7260_defconfig                        |  2 +-
 configs/bcm7445_defconfig                        |  2 +-
 configs/bk4r1_defconfig                          |  2 +-
 configs/brppt1_mmc_defconfig                     |  2 +-
 configs/brsmarc1_defconfig                       |  2 +-
 configs/brxre1_defconfig                         |  2 +-
 configs/capricorn_cxg3_defconfig                 |  2 +-
 configs/chiliboard_defconfig                     |  2 +-
 configs/corvus_defconfig                         |  2 +-
 configs/display5_defconfig                       |  2 +-
 configs/display5_factory_defconfig               |  2 +-
 configs/dra7xx_evm_defconfig                     |  2 +-
 configs/dra7xx_hs_evm_defconfig                  |  2 +-
 configs/dra7xx_hs_evm_usb_defconfig              |  2 +-
 configs/draco-etamin_defconfig                   |  2 +-
 configs/draco-rastaban_defconfig                 |  2 +-
 configs/draco-thuban_defconfig                   |  2 +-
 configs/e850-96_defconfig                        |  2 +-
 configs/edison_defconfig                         |  2 +-
 configs/gardena-smart-gateway-at91sam_defconfig  |  2 +-
 configs/gardena-smart-gateway-mt7688_defconfig   |  2 +-
 configs/gazerbeam_defconfig                      |  2 +-
 configs/gwventana_emmc_defconfig                 |  2 +-
 configs/gwventana_nand_defconfig                 |  2 +-
 configs/gxp_defconfig                            |  2 +-
 configs/igep00x0_defconfig                       |  2 +-
 configs/imx28_xea_defconfig                      |  2 +-
 configs/imx28_xea_sb_defconfig                   |  2 +-
 configs/imx6q_bosch_acc_defconfig                |  2 +-
 configs/imx8m_data_modul.config                  |  2 +-
 configs/imx8mm-cl-iot-gate_defconfig             |  2 +-
 configs/imx8mm-mx8menlo_defconfig                |  2 +-
 configs/imx8mm-phygate-tauri-l_defconfig         |  2 +-
 configs/imx8mm_phg_defconfig                     |  2 +-
 configs/imx8mm_venice_defconfig                  |  2 +-
 configs/imx8mn_venice_defconfig                  |  2 +-
 configs/imx8mp_venice_defconfig                  |  2 +-
 configs/imx93-phycore_defconfig                  |  2 +-
 configs/imx_dhsom.config                         |  2 +-
 configs/iot2050_defconfig                        |  2 +-
 configs/j7200_evm_a72_defconfig                  |  2 +-
 configs/j721e_beagleboneai64_a72_defconfig       |  2 +-
 configs/j721e_evm_a72_defconfig                  |  2 +-
 configs/j721s2_evm_a72_defconfig                 |  2 +-
 configs/j784s4_evm_a72_defconfig                 |  2 +-
 configs/kmcent2_defconfig                        |  2 +-
 configs/kmcoge5ne_defconfig                      |  2 +-
 configs/kmeter1_defconfig                        |  2 +-
 configs/kmopti2_defconfig                        |  2 +-
 configs/kmsupx5_defconfig                        |  2 +-
 configs/kmtepr2_defconfig                        |  2 +-
 configs/kontron-sl-mx8mm_defconfig               |  2 +-
 configs/kontron_sl28_defconfig                   |  2 +-
 configs/kp_imx53_defconfig                       |  2 +-
 configs/kp_imx6q_tpc_defconfig                   |  2 +-
 configs/lxr2_defconfig                           |  2 +-
 configs/m53menlo_defconfig                       |  2 +-
 configs/mccmon6_nor_defconfig                    |  2 +-
 configs/mccmon6_sd_defconfig                     |  2 +-
 configs/microblaze-generic_defconfig             |  2 +-
 configs/msc_sm2s_imx8mp_defconfig                |  2 +-
 configs/mscc_jr2_defconfig                       |  2 +-
 configs/mscc_luton_defconfig                     |  2 +-
 configs/mscc_ocelot_defconfig                    |  2 +-
 configs/mscc_serval_defconfig                    |  2 +-
 configs/mscc_servalt_defconfig                   |  2 +-
 configs/novena_defconfig                         |  2 +-
 configs/opos6uldev_defconfig                     |  2 +-
 configs/pcm052_defconfig                         |  2 +-
 configs/pcm058_defconfig                         |  2 +-
 configs/pg_wcom_expu1_defconfig                  |  2 +-
 configs/pg_wcom_expu1_update_defconfig           |  2 +-
 configs/pg_wcom_seli8_defconfig                  |  2 +-
 configs/pg_wcom_seli8_update_defconfig           |  2 +-
 configs/phycore-imx8mm_defconfig                 |  2 +-
 configs/phycore-imx8mp_defconfig                 |  2 +-
 configs/phycore_am62ax_a53_defconfig             |  2 +-
 configs/phycore_am62x_a53_defconfig              |  2 +-
 configs/phycore_am64x_a53_defconfig              |  2 +-
 configs/pm9g45_defconfig                         |  2 +-
 configs/sam9x60ek_nandflash_defconfig            |  2 +-
 configs/sama5d2_ptc_ek_nandflash_defconfig       |  2 +-
 configs/sama5d36ek_cmp_nandflash_defconfig       |  2 +-
 configs/sama5d3_xplained_nandflash_defconfig     |  2 +-
 configs/sama5d3xek_nandflash_defconfig           |  2 +-
 configs/sama5d4_xplained_nandflash_defconfig     |  2 +-
 configs/sama5d4ek_nandflash_defconfig            |  2 +-
 configs/smartweb_defconfig                       |  2 +-
 configs/smegw01_defconfig                        |  2 +-
 configs/socfpga_secu1_defconfig                  |  2 +-
 configs/socfpga_sr1500_defconfig                 |  2 +-
 configs/socfpga_vining_fpga_defconfig            |  2 +-
 configs/socrates_defconfig                       |  2 +-
 configs/stm32mp13_defconfig                      |  2 +-
 .../stm32mp15-icore-stm32mp1-ctouch2_defconfig   |  2 +-
 .../stm32mp15-icore-stm32mp1-edimm2.2_defconfig  |  2 +-
 ...p15-microgea-stm32mp1-microdev2-of7_defconfig |  2 +-
 ...m32mp15-microgea-stm32mp1-microdev2_defconfig |  2 +-
 configs/stm32mp15_basic_defconfig                |  2 +-
 configs/stm32mp15_defconfig                      |  2 +-
 configs/stm32mp15_trusted_defconfig              |  2 +-
 configs/stm32mp_dhsom.config                     |  2 +-
 configs/taurus_defconfig                         |  2 +-
 ...dorable-x86-conga-qa3-e3845-pcie-x4_defconfig |  2 +-
 .../theadorable-x86-conga-qa3-e3845_defconfig    |  2 +-
 configs/theadorable-x86-dfi-bt700_defconfig      |  2 +-
 configs/tqma6dl_mba6_spi_defconfig               |  2 +-
 configs/tqma6q_mba6_spi_defconfig                |  2 +-
 configs/tqma6s_mba6_spi_defconfig                |  2 +-
 configs/tuge1_defconfig                          |  2 +-
 configs/tuxx1_defconfig                          |  2 +-
 configs/vining_2000_defconfig                    |  2 +-
 configs/work_92105_defconfig                     |  2 +-
 configs/xilinx_versal_net_virt_defconfig         |  2 +-
 configs/xilinx_versal_virt_defconfig             |  2 +-
 configs/xilinx_zynq_virt_defconfig               |  2 +-
 configs/xilinx_zynqmp_kria_defconfig             |  2 +-
 configs/xilinx_zynqmp_virt_defconfig             |  2 +-
 env/Kconfig                                      | 10 +++++-----
 env/common.c                                     |  6 +++---
 env/fat.c                                        |  8 ++++----
 env/mmc.c                                        | 14 +++++++-------
 env/sf.c                                         |  6 +++---
 env/ubi.c                                        | 16 ++++++++--------
 include/env_default.h                            |  2 +-
 include/env_internal.h                           |  4 ++--
 tools/envcrc.c                                   |  2 +-
 157 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index c550e5e121e..d97786560ed 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -66,7 +66,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index 19943881973..ef6b6440548 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -65,7 +65,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 2dfcd182cca..b839f75f69c 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index 61527e2724a..0751ae64f1d 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index da9c1b3d753..3eb07c459f0 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -60,7 +60,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index 46e9e49a377..778b20094fb 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 1a48c05f06e..46038ea0a7e 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index c538c1ae352..652cbe83e8c 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -35,7 +35,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 75725e179d7..4d9a51bd47c 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -36,7 +36,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 13260edf3f0..f5f19c25251 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -54,7 +54,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am5729-beagleboneai am572x-idk am571x-idk am574x-idk"
 # CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index a406e899d42..67aeec1724d 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -50,7 +50,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am5729-beagleboneai am572x-idk am571x-idk am574x-idk"
 # CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index d865b123b90..e13e94f44b9 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -54,7 +54,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am572x-idk am571x-idk am574x-idk"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 12c4cb96815..705cfa5380a 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -79,7 +79,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 9911caa0e46..b49748b6318 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -66,7 +66,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/aristainetos2c_defconfig b/configs/aristainetos2c_defconfig
index b6e259b490b..da3b5d28fea 100644
--- a/configs/aristainetos2c_defconfig
+++ b/configs/aristainetos2c_defconfig
@@ -60,7 +60,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/aristainetos2ccslb_defconfig b/configs/aristainetos2ccslb_defconfig
index 0ea13d46f31..940f532f397 100644
--- a/configs/aristainetos2ccslb_defconfig
+++ b/configs/aristainetos2ccslb_defconfig
@@ -60,7 +60,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/at91sam9260ek_nandflash_defconfig b/configs/at91sam9260ek_nandflash_defconfig
index 4ee101ff641..418124aee30 100644
--- a/configs/at91sam9260ek_nandflash_defconfig
+++ b/configs/at91sam9260ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9261ek_nandflash_defconfig b/configs/at91sam9261ek_nandflash_defconfig
index f53bf3c0450..ca44d83d190 100644
--- a/configs/at91sam9261ek_nandflash_defconfig
+++ b/configs/at91sam9261ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/at91sam9263ek_nandflash_defconfig b/configs/at91sam9263ek_nandflash_defconfig
index e51581848ac..82267e8c982 100644
--- a/configs/at91sam9263ek_nandflash_defconfig
+++ b/configs/at91sam9263ek_nandflash_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9263ek_norflash_boot_defconfig b/configs/at91sam9263ek_norflash_boot_defconfig
index 488c370581a..7fab9253917 100644
--- a/configs/at91sam9263ek_norflash_boot_defconfig
+++ b/configs/at91sam9263ek_norflash_boot_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x107D0000
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9263ek_norflash_defconfig b/configs/at91sam9263ek_norflash_defconfig
index d8c490d80de..0f58b3bfe3c 100644
--- a/configs/at91sam9263ek_norflash_defconfig
+++ b/configs/at91sam9263ek_norflash_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x107D0000
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9g10ek_nandflash_defconfig b/configs/at91sam9g10ek_nandflash_defconfig
index 580960e8181..d0f1989d1d7 100644
--- a/configs/at91sam9g10ek_nandflash_defconfig
+++ b/configs/at91sam9g10ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/at91sam9g20ek_2mmc_nandflash_defconfig b/configs/at91sam9g20ek_2mmc_nandflash_defconfig
index c4d12524282..2a604eb4783 100644
--- a/configs/at91sam9g20ek_2mmc_nandflash_defconfig
+++ b/configs/at91sam9g20ek_2mmc_nandflash_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9g20ek_nandflash_defconfig b/configs/at91sam9g20ek_nandflash_defconfig
index e68f5036ca7..c6b1aa0cd16 100644
--- a/configs/at91sam9g20ek_nandflash_defconfig
+++ b/configs/at91sam9g20ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9m10g45ek_nandflash_defconfig b/configs/at91sam9m10g45ek_nandflash_defconfig
index e57bd2c8296..a8ba8206d7e 100644
--- a/configs/at91sam9m10g45ek_nandflash_defconfig
+++ b/configs/at91sam9m10g45ek_nandflash_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9n12ek_nandflash_defconfig b/configs/at91sam9n12ek_nandflash_defconfig
index e7b4107f1e5..37fe4162d1a 100644
--- a/configs/at91sam9n12ek_nandflash_defconfig
+++ b/configs/at91sam9n12ek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=atmel_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:256k(bootstrap)ro,512k(uboot)ro,256k(env),256k(env_redundant),256k(spare),512k(dtb),6M(kernel)ro,-(rootfs)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9rlek_nandflash_defconfig b/configs/at91sam9rlek_nandflash_defconfig
index c40e99817b9..194d50194c4 100644
--- a/configs/at91sam9rlek_nandflash_defconfig
+++ b/configs/at91sam9rlek_nandflash_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_NAND=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_CLK=y
diff --git a/configs/at91sam9x5ek_nandflash_defconfig b/configs/at91sam9x5ek_nandflash_defconfig
index 3f593953140..974056acd99 100644
--- a/configs/at91sam9x5ek_nandflash_defconfig
+++ b/configs/at91sam9x5ek_nandflash_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9xeek_nandflash_defconfig b/configs/at91sam9xeek_nandflash_defconfig
index 4ee101ff641..418124aee30 100644
--- a/configs/at91sam9xeek_nandflash_defconfig
+++ b/configs/at91sam9xeek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index 6098e5caf5b..bf0a94b2f50 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -75,7 +75,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
diff --git a/configs/bcm7260_defconfig b/configs/bcm7260_defconfig
index ed026e58617..c3cecb91827 100644
--- a/configs/bcm7260_defconfig
+++ b/configs/bcm7260_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/bcm7445_defconfig b/configs/bcm7445_defconfig
index 07294451100..cc6f20a7a75 100644
--- a/configs/bcm7445_defconfig
+++ b/configs/bcm7445_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 2b72ec91632..45982d3e6ee 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=500
 CONFIG_NETCONSOLE=y
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index d96fdaa2887..c5ea166bcc6 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -79,7 +79,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent interrupt-controller interrupt-cells dma-names dmas "
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index ee70220ebad..e30d203f98d 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -83,7 +83,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index 245e4a582f2..431b76865f7 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -73,7 +73,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS=""
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 3cc46067f7d..49c1c3c517a 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -87,7 +87,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index 8cb6b34ce76..7272a42689f 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=8000000.nand:128k(NAND.SPL),128k(NAND.SPL.back
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
index 85cd4623c48..5b8ce0b2fc9 100644
--- a/configs/corvus_defconfig
+++ b/configs/corvus_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_DOS_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index 55f9bbaa1cf..4849cfc74bf 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -92,7 +92,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=02008000.spi.1:128k(SPL),1m(u-boot),64k(env1),
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index 4007c8900ce..acd6466cb91 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -90,7 +90,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 2448befb295..41af0ce0d8f 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -60,7 +60,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index f6f00454aaa..b13dd598f35 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 850ccd934b7..4dee0f5f0fc 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x9000
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index 6c175dd73b9..7aa02d094ef 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x200000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 521a090e376..85eef75ff6e 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -66,7 +66,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 2c16db237f8..3623f4f2135 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -66,7 +66,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 5facd418260..f96ce3fc560 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_RNG=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_NO_NET=y
diff --git a/configs/edison_defconfig b/configs/edison_defconfig
index 1294577ea8f..33bf91a5483 100644
--- a/configs/edison_defconfig
+++ b/configs/edison_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CPU=y
 CONFIG_DFU_TIMEOUT=y
diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs/gardena-smart-gateway-at91sam_defconfig
index fbcc84da9ae..c4ad38bdee8 100644
--- a/configs/gardena-smart-gateway-at91sam_defconfig
+++ b/configs/gardena-smart-gateway-at91sam_defconfig
@@ -78,7 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupts interrupt-parent interrupts-extended dmas dma-names"
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_UBI_PART="ubi"
 CONFIG_ENV_UBI_VOLUME="uboot_env0"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_env1"
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index b7f4a76ce68..49fd6e9e606 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -70,7 +70,7 @@ CONFIG_MTDIDS_DEFAULT="spi-nand0=spi0.1,nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="spi0.0:640k(uboot),64k(uboot_env0),64k(uboot_env1),64k(factory),-(unused);spi0.1:-(nand)"
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/gazerbeam_defconfig b/configs/gazerbeam_defconfig
index 1fe7d2fc40b..a0c2b1bebf9 100644
--- a/configs/gazerbeam_defconfig
+++ b/configs/gazerbeam_defconfig
@@ -133,7 +133,7 @@ CONFIG_DOS_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xFE090000
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index 95d5b1172ff..cb51fb76256 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -91,7 +91,7 @@ CONFIG_OF_LIST="imx6q-gw51xx imx6dl-gw51xx imx6q-gw52xx imx6dl-gw52xx imx6q-gw53
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_defconfig
index 1d8af5ce103..335636c3c3f 100644
--- a/configs/gwventana_nand_defconfig
+++ b/configs/gwventana_nand_defconfig
@@ -95,7 +95,7 @@ CONFIG_OF_LIST="imx6q-gw51xx imx6dl-gw51xx imx6q-gw52xx imx6dl-gw52xx imx6q-gw53
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NETCONSOLE=y
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index ec05c2572e8..dbfa20174ea 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MISC=y
 CONFIG_CMD_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_NETCONSOLE=y
 CONFIG_MISC=y
 # CONFIG_MMC is not set
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 51c825d3fbe..4e265dbf686 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -54,7 +54,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index d1f6eef178e..b9e75556b31 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -91,7 +91,7 @@ CONFIG_SPL_OF_PLATDATA=y
 # CONFIG_SPL_OF_PLATDATA_PARENT is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/imx28_xea_sb_defconfig b/configs/imx28_xea_sb_defconfig
index c7751b5dc93..18bae15fa3f 100644
--- a/configs/imx28_xea_sb_defconfig
+++ b/configs/imx28_xea_sb_defconfig
@@ -62,7 +62,7 @@ CONFIG_SPL_OF_PLATDATA=y
 # CONFIG_SPL_OF_PLATDATA_PARENT is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 017c27479d2..728a57478bb 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -76,7 +76,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 37e11e518a8..d05d9b2fa43 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -202,7 +202,7 @@ CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_PBSIZE=2081
 CONFIG_SYS_PROMPT="u-boot=> "
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_TEXT_BASE=0x40200000
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index ea6a8789eea..1bc89d0041f 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -79,7 +79,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 8435bcc316a..b80df0c088e 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -91,7 +91,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 43c50e97726..00cb5e78e39 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -73,7 +73,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 58dd8eb83f6..659b67a9085 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -62,7 +62,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 0d3875d6a19..0937a812d20 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -83,7 +83,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="freescale/imx8mm-venice-gw71xx-0x freescale/imx8mm-venice-gw72xx-0x freescale/imx8mm-venice-gw73xx-0x freescale/imx8mm-venice-gw7901 freescale/imx8mm-venice-gw7902 freescale/imx8mm-venice-gw7903 freescale/imx8mm-venice-gw7904 freescale/imx8mm-venice-gw75xx-0x"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 76353712936..354e0907d19 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -82,7 +82,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 1b3849c3096..51856a74399 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -85,7 +85,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="freescale/imx8mp-venice-gw71xx-2x freescale/imx8mp-venice-gw72xx-2x freescale/imx8mp-venice-gw73xx-2x freescale/imx8mp-venice-gw74xx freescale/imx8mp-venice-gw75xx-2x"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index af1fbc74698..a3b59ec8294 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -86,7 +86,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx_dhsom.config b/configs/imx_dhsom.config
index d166b2cda2b..b8f14f4338c 100644
--- a/configs/imx_dhsom.config
+++ b/configs/imx_dhsom.config
@@ -25,7 +25,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 
 CONFIG_REGMAP=y
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 72d4b8e3695..6022c50718b 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -84,7 +84,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_OF_LIST="ti/k3-am6528-iot2050-basic"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 4760f7509f5..764a7a6effd 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -79,7 +79,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index fad01c27104..8022e17bd6f 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 71e6c2061b3..141c70ac617 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -84,7 +84,7 @@ CONFIG_OF_LIST="ti/k3-j721e-common-proc-board"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 5e84abf8f21..4eea6895569 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -76,7 +76,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 1280194c7a7..d3ef9089166 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -66,7 +66,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/kmcent2_defconfig b/configs/kmcent2_defconfig
index 76e98c9b2a4..df73c048cc3 100644
--- a/configs/kmcent2_defconfig
+++ b/configs/kmcent2_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xebf00000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="fm1-mac5"
diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index cf50e2d27d8..3aaf239c126 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -158,7 +158,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig
index 7638fc2f5cf..b898ea5c376 100644
--- a/configs/kmeter1_defconfig
+++ b/configs/kmeter1_defconfig
@@ -137,7 +137,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig
index 1c750455fc6..66c0cc85c80 100644
--- a/configs/kmopti2_defconfig
+++ b/configs/kmopti2_defconfig
@@ -144,7 +144,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig
index 5dd98175cd3..2943a864805 100644
--- a/configs/kmsupx5_defconfig
+++ b/configs/kmsupx5_defconfig
@@ -129,7 +129,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig
index 2b240b3380d..63db61cfb06 100644
--- a/configs/kmtepr2_defconfig
+++ b/configs/kmtepr2_defconfig
@@ -143,7 +143,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 54b5510085e..b9bb476c73f 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="imx8mm-kontron-bl imx8mm-kontron-bl-osm-s"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="kontron-mx8mm"
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index c5f145aadc1..b7458d896dd 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -82,7 +82,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_OF_LIST="freescale/fsl-ls1028a-kontron-sl28 freescale/fsl-ls1028a-kontron-sl28-var1 freescale/fsl-ls1028a-kontron-sl28-var2 freescale/fsl-ls1028a-kontron-sl28-var3 freescale/fsl-ls1028a-kontron-sl28-var4"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SATA=y
diff --git a/configs/kp_imx53_defconfig b/configs/kp_imx53_defconfig
index 25edee32462..035f954af5a 100644
--- a/configs/kp_imx53_defconfig
+++ b/configs/kp_imx53_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/kp_imx6q_tpc_defconfig b/configs/kp_imx6q_tpc_defconfig
index 7fd2bfb0efa..cedff063e06 100644
--- a/configs/kp_imx6q_tpc_defconfig
+++ b/configs/kp_imx6q_tpc_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents interrupts dmas dma-names"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index 0bc4ae0c7a5..dfe3d4a1246 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -71,7 +71,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index cc6ef49b1d0..7215a02a891 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -70,7 +70,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
diff --git a/configs/mccmon6_nor_defconfig b/configs/mccmon6_nor_defconfig
index 682ce3035b5..d9ab8b5d8e7 100644
--- a/configs/mccmon6_nor_defconfig
+++ b/configs/mccmon6_nor_defconfig
@@ -48,7 +48,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=8000000.nor:32m@0x0(mccmon6-image.nor),256k@0x
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x8060000
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/mccmon6_sd_defconfig b/configs/mccmon6_sd_defconfig
index 665dc9ee45a..14da7652b36 100644
--- a/configs/mccmon6_sd_defconfig
+++ b/configs/mccmon6_sd_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=8000000.nor:32m@0x0(mccmon6-image.nor),256k@0x
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x8060000
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 08f8bdb4240..cad67ee06bc 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="microblaze-generic"
 CONFIG_NETCONSOLE=y
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 5829898a3c6..0867c976dd8 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -65,7 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/mscc_jr2_defconfig b/configs/mscc_jr2_defconfig
index 0577b12d17f..15a1a2271f0 100644
--- a/configs/mscc_jr2_defconfig
+++ b/configs/mscc_jr2_defconfig
@@ -52,7 +52,7 @@ CONFIG_OF_LIST="jr2_pcb110 jr2_pcb111 serval2_pcb112"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_luton_defconfig b/configs/mscc_luton_defconfig
index dfd6bc08873..27c3bbb7b9f 100644
--- a/configs/mscc_luton_defconfig
+++ b/configs/mscc_luton_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_LIST="luton_pcb090 luton_pcb091"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_ocelot_defconfig b/configs/mscc_ocelot_defconfig
index 23aff7ea462..4083ff594e5 100644
--- a/configs/mscc_ocelot_defconfig
+++ b/configs/mscc_ocelot_defconfig
@@ -54,7 +54,7 @@ CONFIG_OF_LIST="ocelot_pcb120 ocelot_pcb123"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_serval_defconfig b/configs/mscc_serval_defconfig
index 6ddcbe1efee..20326d268f6 100644
--- a/configs/mscc_serval_defconfig
+++ b/configs/mscc_serval_defconfig
@@ -49,7 +49,7 @@ CONFIG_OF_LIST="serval_pcb106 serval_pcb105"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_servalt_defconfig b/configs/mscc_servalt_defconfig
index 629b55561a1..3ee8e92b6ae 100644
--- a/configs/mscc_servalt_defconfig
+++ b/configs/mscc_servalt_defconfig
@@ -47,7 +47,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi_flash:1m(UBoot),256k(Env),256k(Env.bk)"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index bcd40b3f5e5..586efb9c6e8 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_PARTITION_UUIDS is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index f7ed9e49359..ec721bc3246 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/pcm052_defconfig b/configs/pcm052_defconfig
index d0d558ab11a..f536dd06edc 100644
--- a/configs/pcm052_defconfig
+++ b/configs/pcm052_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VYBRID_GPIO=y
 CONFIG_DM_I2C=y
diff --git a/configs/pcm058_defconfig b/configs/pcm058_defconfig
index 8ab2c1c069e..b44557ee716 100644
--- a/configs/pcm058_defconfig
+++ b/configs/pcm058_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_UBI=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 4b82b077ea7..217413bc27f 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x60040000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index 53d54789687..3d5e93f46c9 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x60200000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index 731ca435089..e11ca66c456 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x60040000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index 2598e477ed5..57d93c659cb 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0x60200000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 7de40106883..905347ae76b 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -79,7 +79,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index cc583e8665c..2bec4f6c018 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -92,7 +92,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index d86e19d914f..d8b51fd731f 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -91,7 +91,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index d7aa59bf1dd..c6b8d31d6f3 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -86,7 +86,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 4ee1bd829a3..2ff26b73792 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -93,7 +93,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/pm9g45_defconfig b/configs/pm9g45_defconfig
index fa8b53848b4..6b79c0547eb 100644
--- a/configs/pm9g45_defconfig
+++ b/configs/pm9g45_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/sam9x60ek_nandflash_defconfig b/configs/sam9x60ek_nandflash_defconfig
index c1754e80dd1..cb69908f2c2 100644
--- a/configs/sam9x60ek_nandflash_defconfig
+++ b/configs/sam9x60ek_nandflash_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/sama5d2_ptc_ek_nandflash_defconfig b/configs/sama5d2_ptc_ek_nandflash_defconfig
index 0729cad701b..9d9366a2973 100644
--- a/configs/sama5d2_ptc_ek_nandflash_defconfig
+++ b/configs/sama5d2_ptc_ek_nandflash_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama5d36ek_cmp_nandflash_defconfig b/configs/sama5d36ek_cmp_nandflash_defconfig
index 595cb9cb17f..d5bd2b18c90 100644
--- a/configs/sama5d36ek_cmp_nandflash_defconfig
+++ b/configs/sama5d36ek_cmp_nandflash_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_CLK=y
diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sama5d3_xplained_nandflash_defconfig
index 0e3eb7d7b01..473434909ae 100644
--- a/configs/sama5d3_xplained_nandflash_defconfig
+++ b/configs/sama5d3_xplained_nandflash_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3xek_nandflash_defconfig
index 995c9de1c80..9080cd11100 100644
--- a/configs/sama5d3xek_nandflash_defconfig
+++ b/configs/sama5d3xek_nandflash_defconfig
@@ -67,7 +67,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sama5d4_xplained_nandflash_defconfig
index 5401f34adc6..30cb8f7f0a8 100644
--- a/configs/sama5d4_xplained_nandflash_defconfig
+++ b/configs/sama5d4_xplained_nandflash_defconfig
@@ -65,7 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek_nandflash_defconfig
index b22e0dd18a3..d2ea94d65e4 100644
--- a/configs/sama5d4ek_nandflash_defconfig
+++ b/configs/sama5d4ek_nandflash_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
index 7253c997b24..c5b8e12a6c3 100644
--- a/configs/smartweb_defconfig
+++ b/configs/smartweb_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index ae6c9b60cd5..71a925552c1 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_WRITEABLE_LIST=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index f7ae13c891b..dd7fa7ef5bb 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="zImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index 820b935b70a..9711e1b7f54 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index b4e303ed6dd..7eec45569b8 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -61,7 +61,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
diff --git a/configs/socrates_defconfig b/configs/socrates_defconfig
index 93d2736ba89..b86af187c0f 100644
--- a/configs/socrates_defconfig
+++ b/configs/socrates_defconfig
@@ -68,7 +68,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=fe000000.nor_flash:13312k(system1),13312k(syst
 # CONFIG_CMD_IRQ is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xFFF00000
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index 4c6a7f82fe5..078f58f0c72 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
index 28a5d93912a..ac1f326770f 100644
--- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
index efac47645a9..aa2bee4a61a 100644
--- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
index f9f55d12a87..79e947065d9 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
index d5732358376..8ae00b15188 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index cda17e5a40b..157683cb062 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -86,7 +86,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index d31349e3f2b..bde8d3b076f 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -58,7 +58,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index 1f807f37c69..a4ff84109af 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -59,7 +59,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp_dhsom.config b/configs/stm32mp_dhsom.config
index 01d65cfd893..179e4b12dfb 100644
--- a/configs/stm32mp_dhsom.config
+++ b/configs/stm32mp_dhsom.config
@@ -83,7 +83,7 @@ CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_SYS_I2C_STM32F7=y
 CONFIG_SYS_LOAD_ADDR=0xc2000000
 CONFIG_SYS_PROMPT="STM32MP> "
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_USB=y
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index 29fa4ea42af..2969b8e1b7b 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -81,7 +81,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
diff --git a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
index fed54bc8207..c12382d123c 100644
--- a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_ISO_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/theadorable-x86-conga-qa3-e3845_defconfig b/configs/theadorable-x86-conga-qa3-e3845_defconfig
index af81e78ccf5..48796d1cd90 100644
--- a/configs/theadorable-x86-conga-qa3-e3845_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/theadorable-x86-dfi-bt700_defconfig b/configs/theadorable-x86-dfi-bt700_defconfig
index 0c9e6090617..516c64fbf9b 100644
--- a/configs/theadorable-x86-dfi-bt700_defconfig
+++ b/configs/theadorable-x86-dfi-bt700_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index 953ceba6626..ecdae0b54fc 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 28b1bfc41f4..305071827fe 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 0af80d5c2e1..ef41b39e08a 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig
index ab0fd12bc48..b6f235afdd2 100644
--- a/configs/tuge1_defconfig
+++ b/configs/tuge1_defconfig
@@ -129,7 +129,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig
index e5a99b24dab..8d16bcac5b9 100644
--- a/configs/tuxx1_defconfig
+++ b/configs/tuxx1_defconfig
@@ -143,7 +143,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index 5842916fbdb..a25dd3101b6 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/work_92105_defconfig b/configs/work_92105_defconfig
index 0b4989ca002..b862991d425 100644
--- a/configs/work_92105_defconfig
+++ b/configs/work_92105_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 1604b5915db..17937b2c31e 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -66,7 +66,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index baa4b8e412e..160607d8dd2 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_BOARD=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 1578edf6a41..8c5ae65a046 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -90,7 +90,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 6f868739079..9c2d3a1dcd0 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -114,7 +114,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 9641998a2ab..51a0ba87aeb 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -113,7 +113,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
diff --git a/env/Kconfig b/env/Kconfig
index a177a354c8b..9ef45a7e3fe 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -463,7 +463,7 @@ config ENV_IS_IN_UBI
 	  the environment in.  This will enable redundant environments in UBI.
 	  It is assumed that both volumes are in the same MTD partition.
 
-config SYS_REDUNDAND_ENVIRONMENT
+config ENV_REDUNDAND_ENVIRONMENT
 	bool "Enable redundant environment support"
 	help
 	  Normally, the environemt is stored in a single location.  By
@@ -517,7 +517,7 @@ config ENV_FAT_FILE
 
 config ENV_FAT_FILE_REDUND
 	string "Name of the FAT file to use for the environment"
-	depends on ENV_IS_IN_FAT && SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_IS_IN_FAT && ENV_REDUNDAND_ENVIRONMENT
 	default "uboot-redund.env"
 	help
 	  It's a string of the FAT file name. This file use to store the
@@ -569,7 +569,7 @@ config ENV_ADDR
 
 config ENV_ADDR_REDUND
 	hex "Redundant environment address"
-	depends on ENV_IS_IN_FLASH && SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_IS_IN_FLASH && ENV_REDUNDAND_ENVIRONMENT
 	help
 	  Offset from the start of the device (or partition) of the redundant
 	  environment location.
@@ -599,7 +599,7 @@ config ENV_OFFSET
 config ENV_OFFSET_REDUND
 	hex "Redundant environment offset"
 	depends on (ENV_IS_IN_EEPROM || ENV_IS_IN_MMC || ENV_IS_IN_NAND || \
-		    ENV_IS_IN_SPI_FLASH) && SYS_REDUNDAND_ENVIRONMENT
+		    ENV_IS_IN_SPI_FLASH) && ENV_REDUNDAND_ENVIRONMENT
 	default 0x10C0000 if MICROBLAZE
 	default 0x0
 	help
@@ -649,7 +649,7 @@ config ENV_UBI_VOLUME
 
 config ENV_UBI_VOLUME_REDUND
 	string "UBI redundant volume name"
-	depends on ENV_IS_IN_UBI && SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_IS_IN_UBI && ENV_REDUNDAND_ENVIRONMENT
 	help
 	  Name of the redundant volume that you want to store the environment in.
 
diff --git a/env/common.c b/env/common.c
index a58955a4f42..b4cd8b64b73 100644
--- a/env/common.c
+++ b/env/common.c
@@ -447,7 +447,7 @@ int env_import(const char *buf, int check, int flags)
 	return -EIO;
 }
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 static unsigned char env_flags;
 
 int env_check_redund(const char *buf1, int buf1_read_fail,
@@ -524,7 +524,7 @@ int env_import_redund(const char *buf1, int buf1_read_fail,
 
 	return env_import((char *)ep, 0, flags);
 }
-#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#endif /* CONFIG_ENV_REDUNDAND_ENVIRONMENT */
 
 /* Export the environment and generate CRC for it. */
 int env_export(env_t *env_out)
@@ -541,7 +541,7 @@ int env_export(env_t *env_out)
 
 	env_out->crc = crc32(0, env_out->data, ENV_SIZE);
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 	env_out->flags = ++env_flags; /* increase the serial */
 #endif
 
diff --git a/env/fat.c b/env/fat.c
index 1ad301eaaff..b8557858f73 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -86,7 +86,7 @@ static int env_fat_save(void)
 		return 1;
 	}
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 	if (gd->env_valid == ENV_VALID)
 		file = CONFIG_ENV_FAT_FILE_REDUND;
 #endif
@@ -101,7 +101,7 @@ static int env_fat_save(void)
 		return 1;
 	}
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 	gd->env_valid = (gd->env_valid == ENV_REDUND) ? ENV_VALID : ENV_REDUND;
 #endif
 
@@ -112,7 +112,7 @@ static int env_fat_save(void)
 static int env_fat_load(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf1, CONFIG_ENV_SIZE);
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf2, CONFIG_ENV_SIZE);
 	int err2;
 #endif
@@ -153,7 +153,7 @@ static int env_fat_load(void)
 	}
 
 	err1 = file_fat_read(CONFIG_ENV_FAT_FILE, buf1, CONFIG_ENV_SIZE);
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 	err2 = file_fat_read(CONFIG_ENV_FAT_FILE_REDUND, buf2, CONFIG_ENV_SIZE);
 
 	err1 = (err1 >= 0) ? 0 : -1;
diff --git a/env/mmc.c b/env/mmc.c
index 2ef15fb72e7..025d6e33c27 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -186,7 +186,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	defvalue = ENV_MMC_OFFSET;
 	propname = dt_prop.offset;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && copy) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT) && copy) {
 		defvalue = ENV_MMC_OFFSET_REDUND;
 		propname = dt_prop.offset_redund;
 	}
@@ -198,7 +198,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 {
 	s64 offset = ENV_MMC_OFFSET;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && copy)
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT) && copy)
 		offset = ENV_MMC_OFFSET_REDUND;
 
 	return offset;
@@ -213,7 +213,7 @@ static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
 	 * identical, store the environment and redundant environment in both
 	 * eMMC boot partitions, one copy in each.
 	 */
-	if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (!IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT))
 		return false;
 
 	if (CONFIG_SYS_MMC_ENV_PART != 1)
@@ -337,7 +337,7 @@ static int env_mmc_save(void)
 	if (ret)
 		goto fini;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT)) {
 		if (gd->env_valid == ENV_VALID)
 			copy = 1;
 
@@ -362,7 +362,7 @@ static int env_mmc_save(void)
 
 	ret = 0;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT))
 		gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
 
 fini:
@@ -411,7 +411,7 @@ static int env_mmc_erase(void)
 	printf("\n");
 	ret = erase_env(mmc, CONFIG_ENV_SIZE, offset);
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT)) {
 		copy = 1;
 
 		if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
@@ -555,7 +555,7 @@ static int env_mmc_load(void)
 {
 	if (IS_ENABLED(CONFIG_ENV_IS_EMBEDDED))
 		return 0;
-	else if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	else if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT))
 		return env_mmc_load_redundant();
 	else
 		return env_mmc_load_singular();
diff --git a/env/sf.c b/env/sf.c
index eb4c8d5ec95..31f549af091 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -380,7 +380,7 @@ static int env_sf_init_early(void)
 
 	tmp_env1 = (env_t *)memalign(ARCH_DMA_MINALIGN,
 			CONFIG_ENV_SIZE);
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT))
 		tmp_env2 = (env_t *)memalign(ARCH_DMA_MINALIGN,
 					     CONFIG_ENV_SIZE);
 
@@ -394,7 +394,7 @@ static int env_sf_init_early(void)
 	read1_fail = spi_flash_read(env_flash, CONFIG_ENV_OFFSET,
 				    CONFIG_ENV_SIZE, tmp_env1);
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT)) {
 		read2_fail = spi_flash_read(env_flash,
 					    CONFIG_ENV_OFFSET_REDUND,
 					    CONFIG_ENV_SIZE, tmp_env2);
@@ -429,7 +429,7 @@ err_read:
 	spi_flash_free(env_flash);
 
 	free(tmp_env1);
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT))
 		free(tmp_env2);
 out:
 	/* env is not valid. always return 0 */
diff --git a/env/ubi.c b/env/ubi.c
index 2f4ca571edb..40e4c093c21 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -27,14 +27,14 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#if CONFIG_ENV_REDUNDAND_ENVIRONMENT
 #define ENV_UBI_VOLUME_REDUND CONFIG_ENV_UBI_VOLUME_REDUND
 #else
 #define ENV_UBI_VOLUME_REDUND "invalid"
 #endif
 
 #ifdef CONFIG_CMD_SAVEENV
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 static int env_ubi_save(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(env_t, env_new, 1);
@@ -76,7 +76,7 @@ static int env_ubi_save(void)
 
 	return 0;
 }
-#else /* ! CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#else /* ! CONFIG_ENV_REDUNDAND_ENVIRONMENT */
 static int env_ubi_save(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(env_t, env_new, 1);
@@ -102,10 +102,10 @@ static int env_ubi_save(void)
 	puts("done\n");
 	return 0;
 }
-#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#endif /* CONFIG_ENV_REDUNDAND_ENVIRONMENT */
 #endif /* CONFIG_CMD_SAVEENV */
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 static int env_ubi_load(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, env1_buf, CONFIG_ENV_SIZE);
@@ -149,7 +149,7 @@ static int env_ubi_load(void)
 	return env_import_redund((char *)tmp_env1, read1_fail, (char *)tmp_env2,
 				 read2_fail, H_EXTERNAL);
 }
-#else /* ! CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#else /* ! CONFIG_ENV_REDUNDAND_ENVIRONMENT */
 static int env_ubi_load(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, CONFIG_ENV_SIZE);
@@ -180,7 +180,7 @@ static int env_ubi_load(void)
 
 	return env_import(buf, 1, H_EXTERNAL);
 }
-#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#endif /* CONFIG_ENV_REDUNDAND_ENVIRONMENT */
 
 static int env_ubi_erase(void)
 {
@@ -202,7 +202,7 @@ static int env_ubi_erase(void)
 		       CONFIG_ENV_UBI_VOLUME);
 		ret = 1;
 	}
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT)) {
 		if (ubi_volume_write(ENV_UBI_VOLUME_REDUND,
 				     (void *)env_buf, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to erase env to %s:%s **\n",
diff --git a/include/env_default.h b/include/env_default.h
index 60c39f9853f..83a715c74f7 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -16,7 +16,7 @@
 #ifdef DEFAULT_ENV_INSTANCE_EMBEDDED
 env_t embedded_environment __UBOOT_ENV_SECTION__(environment) = {
 	ENV_CRC,	/* CRC Sum */
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 	1,		/* Flags: valid */
 #endif
 	{
diff --git a/include/env_internal.h b/include/env_internal.h
index c1c0727e4d0..3de9d3be401 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -53,7 +53,7 @@ extern unsigned long nand_env_oob_offset;
 
 #include "compiler.h"
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 # define ENV_HEADER_SIZE	(sizeof(uint32_t) + 1)
 #else
 # define ENV_HEADER_SIZE	(sizeof(uint32_t))
@@ -77,7 +77,7 @@ extern unsigned long nand_env_oob_offset;
 
 typedef struct environment_s {
 	uint32_t	crc;		/* CRC32 over data bytes	*/
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 	unsigned char	flags;		/* active/obsolete flags ENVF_REDUND_ */
 #endif
 	unsigned char	data[ENV_SIZE]; /* Environment data		*/
diff --git a/tools/envcrc.c b/tools/envcrc.c
index 09051800364..eab30c41224 100644
--- a/tools/envcrc.c
+++ b/tools/envcrc.c
@@ -40,7 +40,7 @@
 # endif
 #endif	/* CONFIG_ENV_IS_IN_FLASH */
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDAND_ENVIRONMENT
 # define ENV_HEADER_SIZE	(sizeof(uint32_t) + 1)
 #else
 # define ENV_HEADER_SIZE	(sizeof(uint32_t))
-- 
2.47.2

