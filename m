Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFABC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3FD82B45;
	Mon,  9 Jun 2025 21:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UGtLqi5T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UymX6WbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD2E82BF6; Mon,  9 Jun 2025 21:27:26 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C8182B18
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bGMPk14pvz9swJ;
 Mon,  9 Jun 2025 21:27:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0mRePZ4OmEzFQydCDTXum/KagZz19Q2IUGm25uBuyM=;
 b=UGtLqi5TcP4rSIbDEsbZOBq30fATODmWBJ6/Pu1Kd25Wln/DSpFkKsrDm/5xmh0lQlk1JM
 KuQzqaJJluQDcRyczbe9aYqfG63/Vz5QaowvJ6EXKFkGxRv/LFs4Ebgn1bl+ez/VwqoeVR
 Rt40LtydfoVaCGbwpyZL2aCUDlOspsx0RGaMsfVErf2B+WOdAG1QJEbmBrzEiNdcBl/3Sb
 eZ2NreRceNUR5Md7XxAhZSAuzcfpv6pKq89fSm1ibujDatJBRmLxfJRHj960MKt3A+3FWD
 7woIOvcMZve5qMSPrezzFY7uIcZ6T6nHypPnE0VIY8tP5R4he42DTMqb0MRVqQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0mRePZ4OmEzFQydCDTXum/KagZz19Q2IUGm25uBuyM=;
 b=UymX6WbHsqXXbHlNf+/VKT+vz4WQFiMPDDiEKrTsOiZZWKXL55WEbckShn9mMzMv96EaU/
 sPvszxailJddwpuo11Vu1reLLjYpovD9nSN80aNQSH4jpNiKL39fdhQ3DeKV/F3dX5SMeo
 MBFNLk8cR+S4AfyqTSfS2cYd9ngZo9e181QxwKIyDVivD0B4QY82YZXiTjFVGghYUoJ1Rf
 Hq1M+t1321jzTWZjk3vo1eq/uf7qcaGHIhd+sQJ2PIK6jWxyN+BNZXey9cJdDCgV51pB/Q
 O4hme5sgIjnp8KR1CpDFyOPX8GO7MmwDStQu7FmAdeKvqG5roanAGug/Sumc1A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/8] env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUNDANT
Date: Mon,  9 Jun 2025 21:26:37 +0200
Message-ID: <20250609192701.20260-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: u8waw74wathiixd4bei5faxn3hhkf4nw
X-MBO-RS-ID: 8f58f80d7fae91156ea
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
V2: Replace ENV_REDUNDAND_ENVIRONMENT with ENV_REDUNDANT to fix
    typo and abbreviate the symbol name
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
 configs/brcp150_defconfig                        |  2 +-
 configs/brcp170_defconfig                        |  2 +-
 configs/brcp1_1r_defconfig                       |  2 +-
 configs/brcp1_1r_switch_defconfig                |  2 +-
 configs/brcp1_2r_defconfig                       |  2 +-
 configs/brppt1_mmc_defconfig                     |  2 +-
 configs/brsmarc1_defconfig                       |  2 +-
 configs/brsmarc2_defconfig                       |  2 +-
 configs/brxre1_defconfig                         |  2 +-
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
 configs/imx8qxp_capricorn.config                 |  2 +-
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
 configs/stm32mp15-odyssey_defconfig              |  2 +-
 configs/stm32mp15_basic_defconfig                |  2 +-
 configs/stm32mp15_defconfig                      |  2 +-
 configs/stm32mp15_trusted_defconfig              |  2 +-
 configs/stm32mp25_defconfig                      |  2 +-
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
 165 files changed, 190 insertions(+), 190 deletions(-)

diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index c550e5e121e..7bfc39ed653 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -66,7 +66,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index 19943881973..580b8fbb291 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -65,7 +65,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 2dfcd182cca..32790e852bc 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index 61527e2724a..82532c9e20b 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index da9c1b3d753..dc8582b9b18 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -60,7 +60,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index 46e9e49a377..88b1a9fefb2 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 1a48c05f06e..1e0e1fd66cc 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index d6c21869372..d735af9674b 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -35,7 +35,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index f7ae7f51077..dd346d23946 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -36,7 +36,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index ab45f5f7f10..8eb25f090a0 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am5729-beagleboneai am572x-idk am571x-idk am574x-idk"
 # CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index e1fd680803f..2b10fb50698 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -50,7 +50,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am5729-beagleboneai am572x-idk am571x-idk am574x-idk"
 # CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index d865b123b90..579e8d58734 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -54,7 +54,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am572x-idk am571x-idk am574x-idk"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index a41f67a43fe..4ee406b8347 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -72,7 +72,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 6ec7dd317fd..88e8fbd1566 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -66,7 +66,7 @@ CONFIG_OF_BOARD=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/aristainetos2c_defconfig b/configs/aristainetos2c_defconfig
index b6e259b490b..09cab1b3513 100644
--- a/configs/aristainetos2c_defconfig
+++ b/configs/aristainetos2c_defconfig
@@ -60,7 +60,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/aristainetos2ccslb_defconfig b/configs/aristainetos2ccslb_defconfig
index 0ea13d46f31..61fa5011385 100644
--- a/configs/aristainetos2ccslb_defconfig
+++ b/configs/aristainetos2ccslb_defconfig
@@ -60,7 +60,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/at91sam9260ek_nandflash_defconfig b/configs/at91sam9260ek_nandflash_defconfig
index 4ee101ff641..bb5930cfbcd 100644
--- a/configs/at91sam9260ek_nandflash_defconfig
+++ b/configs/at91sam9260ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9261ek_nandflash_defconfig b/configs/at91sam9261ek_nandflash_defconfig
index f53bf3c0450..07d7a792da5 100644
--- a/configs/at91sam9261ek_nandflash_defconfig
+++ b/configs/at91sam9261ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/at91sam9263ek_nandflash_defconfig b/configs/at91sam9263ek_nandflash_defconfig
index e51581848ac..284bf22c95e 100644
--- a/configs/at91sam9263ek_nandflash_defconfig
+++ b/configs/at91sam9263ek_nandflash_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9263ek_norflash_boot_defconfig b/configs/at91sam9263ek_norflash_boot_defconfig
index 488c370581a..dcf6b417990 100644
--- a/configs/at91sam9263ek_norflash_boot_defconfig
+++ b/configs/at91sam9263ek_norflash_boot_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x107D0000
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9263ek_norflash_defconfig b/configs/at91sam9263ek_norflash_defconfig
index d8c490d80de..337ba577fd9 100644
--- a/configs/at91sam9263ek_norflash_defconfig
+++ b/configs/at91sam9263ek_norflash_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x107D0000
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9g10ek_nandflash_defconfig b/configs/at91sam9g10ek_nandflash_defconfig
index 580960e8181..3b53a17b693 100644
--- a/configs/at91sam9g10ek_nandflash_defconfig
+++ b/configs/at91sam9g10ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/at91sam9g20ek_2mmc_nandflash_defconfig b/configs/at91sam9g20ek_2mmc_nandflash_defconfig
index c4d12524282..58a75830bb0 100644
--- a/configs/at91sam9g20ek_2mmc_nandflash_defconfig
+++ b/configs/at91sam9g20ek_2mmc_nandflash_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9g20ek_nandflash_defconfig b/configs/at91sam9g20ek_nandflash_defconfig
index e68f5036ca7..15378f5e128 100644
--- a/configs/at91sam9g20ek_nandflash_defconfig
+++ b/configs/at91sam9g20ek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9m10g45ek_nandflash_defconfig b/configs/at91sam9m10g45ek_nandflash_defconfig
index e57bd2c8296..62f2a46425b 100644
--- a/configs/at91sam9m10g45ek_nandflash_defconfig
+++ b/configs/at91sam9m10g45ek_nandflash_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9n12ek_nandflash_defconfig b/configs/at91sam9n12ek_nandflash_defconfig
index e7b4107f1e5..30470b5f450 100644
--- a/configs/at91sam9n12ek_nandflash_defconfig
+++ b/configs/at91sam9n12ek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=atmel_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:256k(bootstrap)ro,512k(uboot)ro,256k(env),256k(env_redundant),256k(spare),512k(dtb),6M(kernel)ro,-(rootfs)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9rlek_nandflash_defconfig b/configs/at91sam9rlek_nandflash_defconfig
index c40e99817b9..7e31d11d0f2 100644
--- a/configs/at91sam9rlek_nandflash_defconfig
+++ b/configs/at91sam9rlek_nandflash_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_NAND=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_CLK=y
diff --git a/configs/at91sam9x5ek_nandflash_defconfig b/configs/at91sam9x5ek_nandflash_defconfig
index 3f593953140..c6fa5a01359 100644
--- a/configs/at91sam9x5ek_nandflash_defconfig
+++ b/configs/at91sam9x5ek_nandflash_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9xeek_nandflash_defconfig b/configs/at91sam9xeek_nandflash_defconfig
index 4ee101ff641..bb5930cfbcd 100644
--- a/configs/at91sam9xeek_nandflash_defconfig
+++ b/configs/at91sam9xeek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index 6098e5caf5b..bc54795395e 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -75,7 +75,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
diff --git a/configs/bcm7260_defconfig b/configs/bcm7260_defconfig
index ed026e58617..83008602004 100644
--- a/configs/bcm7260_defconfig
+++ b/configs/bcm7260_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/bcm7445_defconfig b/configs/bcm7445_defconfig
index 07294451100..7f940e58339 100644
--- a/configs/bcm7445_defconfig
+++ b/configs/bcm7445_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 2b72ec91632..511c86313c3 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=500
 CONFIG_NETCONSOLE=y
diff --git a/configs/brcp150_defconfig b/configs/brcp150_defconfig
index badde918f41..a3e7fc664b3 100644
--- a/configs/brcp150_defconfig
+++ b/configs/brcp150_defconfig
@@ -74,7 +74,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/brcp170_defconfig b/configs/brcp170_defconfig
index 209c4dfcec2..60b623bbdbe 100644
--- a/configs/brcp170_defconfig
+++ b/configs/brcp170_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/brcp1_1r_defconfig b/configs/brcp1_1r_defconfig
index f4a7071e8eb..023665566bb 100644
--- a/configs/brcp1_1r_defconfig
+++ b/configs/brcp1_1r_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/brcp1_1r_switch_defconfig b/configs/brcp1_1r_switch_defconfig
index c15033db9ee..2077b73c47e 100644
--- a/configs/brcp1_1r_switch_defconfig
+++ b/configs/brcp1_1r_switch_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/brcp1_2r_defconfig b/configs/brcp1_2r_defconfig
index ead2f1f5450..a881d5d4803 100644
--- a/configs/brcp1_2r_defconfig
+++ b/configs/brcp1_2r_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index d96fdaa2887..743c3255e46 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -79,7 +79,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent interrupt-controller interrupt-cells dma-names dmas "
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index ee70220ebad..a31049d1f6b 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -83,7 +83,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/brsmarc2_defconfig b/configs/brsmarc2_defconfig
index 5fdc669a12c..2bef76a3521 100644
--- a/configs/brsmarc2_defconfig
+++ b/configs/brsmarc2_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index 245e4a582f2..030ce1a3158 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -73,7 +73,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS=""
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index 8cb6b34ce76..3b4b04c9c88 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=8000000.nand:128k(NAND.SPL),128k(NAND.SPL.back
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
index 85cd4623c48..729ebf7a6c8 100644
--- a/configs/corvus_defconfig
+++ b/configs/corvus_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_DOS_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index a00a042ada6..950e4c5d84d 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -95,7 +95,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=02008000.spi.1:128k(SPL),1m(u-boot),64k(env1),
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index 9965e00a1d0..3e545e5e12c 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -93,7 +93,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index f9cb732357c..ee4c91a2ed2 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -63,7 +63,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index f6f00454aaa..930abba1c84 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 850ccd934b7..9589d796464 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x9000
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index 6c175dd73b9..7fd2d87dfb9 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x200000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 521a090e376..9d8b5aff7a1 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -66,7 +66,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 2c16db237f8..84fdd247c55 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -66,7 +66,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 5facd418260..5f2009ca1f2 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_RNG=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_NO_NET=y
diff --git a/configs/edison_defconfig b/configs/edison_defconfig
index 1294577ea8f..7e85a91898e 100644
--- a/configs/edison_defconfig
+++ b/configs/edison_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CPU=y
 CONFIG_DFU_TIMEOUT=y
diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs/gardena-smart-gateway-at91sam_defconfig
index fbcc84da9ae..e62e6ed397d 100644
--- a/configs/gardena-smart-gateway-at91sam_defconfig
+++ b/configs/gardena-smart-gateway-at91sam_defconfig
@@ -78,7 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupts interrupt-parent interrupts-extended dmas dma-names"
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="ubi"
 CONFIG_ENV_UBI_VOLUME="uboot_env0"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_env1"
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index 109e7d0fc6c..d9ccf35afa3 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -71,7 +71,7 @@ CONFIG_MTDIDS_DEFAULT="spi-nand0=spi0.1,nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="spi0.0:640k(uboot),64k(uboot_env0),64k(uboot_env1),64k(factory),-(unused);spi0.1:-(nand)"
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/gazerbeam_defconfig b/configs/gazerbeam_defconfig
index 1fe7d2fc40b..a7a04bfa206 100644
--- a/configs/gazerbeam_defconfig
+++ b/configs/gazerbeam_defconfig
@@ -133,7 +133,7 @@ CONFIG_DOS_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xFE090000
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index 95d5b1172ff..cf1b3b6fa66 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -91,7 +91,7 @@ CONFIG_OF_LIST="imx6q-gw51xx imx6dl-gw51xx imx6q-gw52xx imx6dl-gw52xx imx6q-gw53
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_defconfig
index 1d8af5ce103..2bc28f6203c 100644
--- a/configs/gwventana_nand_defconfig
+++ b/configs/gwventana_nand_defconfig
@@ -95,7 +95,7 @@ CONFIG_OF_LIST="imx6q-gw51xx imx6dl-gw51xx imx6q-gw52xx imx6dl-gw52xx imx6q-gw53
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NETCONSOLE=y
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index ec05c2572e8..9578468bc48 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MISC=y
 CONFIG_CMD_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_NETCONSOLE=y
 CONFIG_MISC=y
 # CONFIG_MMC is not set
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 0855081c9be..c2ece13e2a1 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index bf80a19bd96..8715893bbcc 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -94,7 +94,7 @@ CONFIG_SPL_OF_PLATDATA=y
 # CONFIG_SPL_OF_PLATDATA_PARENT is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/imx28_xea_sb_defconfig b/configs/imx28_xea_sb_defconfig
index c7751b5dc93..d7b54baa749 100644
--- a/configs/imx28_xea_sb_defconfig
+++ b/configs/imx28_xea_sb_defconfig
@@ -62,7 +62,7 @@ CONFIG_SPL_OF_PLATDATA=y
 # CONFIG_SPL_OF_PLATDATA_PARENT is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 017c27479d2..b6cbd9fbb66 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -76,7 +76,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 37e11e518a8..ab883259f09 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -202,7 +202,7 @@ CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_PBSIZE=2081
 CONFIG_SYS_PROMPT="u-boot=> "
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_TEXT_BASE=0x40200000
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index ea6a8789eea..064293c0f51 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -79,7 +79,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 8a4bb896663..32063bc9280 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -91,7 +91,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 2b3c0969cfd..c57b63c1e75 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -73,7 +73,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 58dd8eb83f6..e6d0f41f418 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -62,7 +62,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index cc7dfcb1400..979c7b9d7f4 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -89,7 +89,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_LIST="freescale/imx8mm-venice-gw71xx-0x freescale/imx8mm-venice-gw72xx-0x freescale/imx8mm-venice-gw73xx-0x freescale/imx8mm-venice-gw7901 freescale/imx8mm-venice-gw7902 freescale/imx8mm-venice-gw7903 freescale/imx8mm-venice-gw7904 freescale/imx8mm-venice-gw75xx-0x"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index a7a838b61bb..2d9b716c862 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -88,7 +88,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 2e4cacf166d..bb43cf7ebfe 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -91,7 +91,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_LIST="freescale/imx8mp-venice-gw71xx-2x freescale/imx8mp-venice-gw72xx-2x freescale/imx8mp-venice-gw73xx-2x freescale/imx8mp-venice-gw74xx freescale/imx8mp-venice-gw75xx-2x freescale/imx8mp-venice-gw82xx-2x"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index 463e584530f..7b034d5ff1e 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_PART=2
 
 CONFIG_DM_GPIO=y
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 66a431244b0..fc6f4c77df2 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -85,7 +85,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx_dhsom.config b/configs/imx_dhsom.config
index d166b2cda2b..e293d61a488 100644
--- a/configs/imx_dhsom.config
+++ b/configs/imx_dhsom.config
@@ -25,7 +25,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 
 CONFIG_REGMAP=y
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 5bb692ef3ad..55477c85807 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -83,7 +83,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_OF_LIST="ti/k3-am6528-iot2050-basic"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index a446074ad5d..2ae1743ac7b 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -78,7 +78,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index e3cd59343f0..25d2302bf1f 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -79,7 +79,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 99461cf6007..8aeeeb8bdc6 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -83,7 +83,7 @@ CONFIG_OF_LIST="ti/k3-j721e-common-proc-board"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 084deea28d0..1f216ffdf25 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -75,7 +75,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 56af0230860..4589629c9ad 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -65,7 +65,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/kmcent2_defconfig b/configs/kmcent2_defconfig
index 76e98c9b2a4..1668ce51883 100644
--- a/configs/kmcent2_defconfig
+++ b/configs/kmcent2_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xebf00000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="fm1-mac5"
diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index cf50e2d27d8..69ef6cf3b9b 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -158,7 +158,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig
index 7638fc2f5cf..267bbff81ae 100644
--- a/configs/kmeter1_defconfig
+++ b/configs/kmeter1_defconfig
@@ -137,7 +137,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig
index 1c750455fc6..803eae06696 100644
--- a/configs/kmopti2_defconfig
+++ b/configs/kmopti2_defconfig
@@ -144,7 +144,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig
index 5dd98175cd3..cd9bbc91e52 100644
--- a/configs/kmsupx5_defconfig
+++ b/configs/kmsupx5_defconfig
@@ -129,7 +129,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig
index 2b240b3380d..f3bec1d569f 100644
--- a/configs/kmtepr2_defconfig
+++ b/configs/kmtepr2_defconfig
@@ -143,7 +143,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 9d37280138f..cdf8e406483 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="imx8mm-kontron-bl imx8mm-kontron-bl-osm-s"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="kontron-mx8mm"
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index c5f145aadc1..6ddd21bd295 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -82,7 +82,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_OF_LIST="freescale/fsl-ls1028a-kontron-sl28 freescale/fsl-ls1028a-kontron-sl28-var1 freescale/fsl-ls1028a-kontron-sl28-var2 freescale/fsl-ls1028a-kontron-sl28-var3 freescale/fsl-ls1028a-kontron-sl28-var4"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SATA=y
diff --git a/configs/kp_imx53_defconfig b/configs/kp_imx53_defconfig
index 25edee32462..54cfc855f1e 100644
--- a/configs/kp_imx53_defconfig
+++ b/configs/kp_imx53_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/kp_imx6q_tpc_defconfig b/configs/kp_imx6q_tpc_defconfig
index 7fd2bfb0efa..abc7f9fa3fe 100644
--- a/configs/kp_imx6q_tpc_defconfig
+++ b/configs/kp_imx6q_tpc_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents interrupts dmas dma-names"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index 0bc4ae0c7a5..a54f4ecbbef 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -71,7 +71,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index cc6ef49b1d0..a3333c2280c 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -70,7 +70,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
diff --git a/configs/mccmon6_nor_defconfig b/configs/mccmon6_nor_defconfig
index 682ce3035b5..d9192617812 100644
--- a/configs/mccmon6_nor_defconfig
+++ b/configs/mccmon6_nor_defconfig
@@ -48,7 +48,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=8000000.nor:32m@0x0(mccmon6-image.nor),256k@0x
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x8060000
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/mccmon6_sd_defconfig b/configs/mccmon6_sd_defconfig
index 665dc9ee45a..41ae748c97e 100644
--- a/configs/mccmon6_sd_defconfig
+++ b/configs/mccmon6_sd_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=8000000.nor:32m@0x0(mccmon6-image.nor),256k@0x
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x8060000
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 7497d20ee64..07612ef5e93 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="microblaze-generic"
 CONFIG_NETCONSOLE=y
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 6b2bb716293..9b0c529b3b2 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -65,7 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/mscc_jr2_defconfig b/configs/mscc_jr2_defconfig
index 0577b12d17f..dc509426162 100644
--- a/configs/mscc_jr2_defconfig
+++ b/configs/mscc_jr2_defconfig
@@ -52,7 +52,7 @@ CONFIG_OF_LIST="jr2_pcb110 jr2_pcb111 serval2_pcb112"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_luton_defconfig b/configs/mscc_luton_defconfig
index dfd6bc08873..c4fe30c5255 100644
--- a/configs/mscc_luton_defconfig
+++ b/configs/mscc_luton_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_LIST="luton_pcb090 luton_pcb091"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_ocelot_defconfig b/configs/mscc_ocelot_defconfig
index 23aff7ea462..9c978201ee1 100644
--- a/configs/mscc_ocelot_defconfig
+++ b/configs/mscc_ocelot_defconfig
@@ -54,7 +54,7 @@ CONFIG_OF_LIST="ocelot_pcb120 ocelot_pcb123"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_serval_defconfig b/configs/mscc_serval_defconfig
index 6ddcbe1efee..c6835153066 100644
--- a/configs/mscc_serval_defconfig
+++ b/configs/mscc_serval_defconfig
@@ -49,7 +49,7 @@ CONFIG_OF_LIST="serval_pcb106 serval_pcb105"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/mscc_servalt_defconfig b/configs/mscc_servalt_defconfig
index 629b55561a1..0979143e4a3 100644
--- a/configs/mscc_servalt_defconfig
+++ b/configs/mscc_servalt_defconfig
@@ -47,7 +47,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi_flash:1m(UBoot),256k(Env),256k(Env.bk)"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index bf8fec5566f..dbd04b16786 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_PARTITION_UUIDS is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index f7ed9e49359..1c96fd01eb8 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/pcm052_defconfig b/configs/pcm052_defconfig
index d0d558ab11a..550e45b52ee 100644
--- a/configs/pcm052_defconfig
+++ b/configs/pcm052_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VYBRID_GPIO=y
 CONFIG_DM_I2C=y
diff --git a/configs/pcm058_defconfig b/configs/pcm058_defconfig
index 8ab2c1c069e..789c4c0f5ba 100644
--- a/configs/pcm058_defconfig
+++ b/configs/pcm058_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_UBI=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 4b82b077ea7..321e46e8c52 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x60040000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index 53d54789687..b53af5be52c 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x60200000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index 731ca435089..561df3ee009 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x60040000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index 2598e477ed5..2a631176095 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0x60200000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d90000"
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 8f52ec2ab90..4558bf89c12 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -79,7 +79,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index ed2171540af..9c88d53b8e4 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -92,7 +92,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 11aaec67e2e..dd55893bddd 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -89,7 +89,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 5f91ca647fd..6a811ca4e7e 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -92,7 +92,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 8b508d011e0..11482223247 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -92,7 +92,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/pm9g45_defconfig b/configs/pm9g45_defconfig
index fa8b53848b4..6d8ff63ba6c 100644
--- a/configs/pm9g45_defconfig
+++ b/configs/pm9g45_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/sam9x60ek_nandflash_defconfig b/configs/sam9x60ek_nandflash_defconfig
index c1754e80dd1..2fab32b51d0 100644
--- a/configs/sam9x60ek_nandflash_defconfig
+++ b/configs/sam9x60ek_nandflash_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/sama5d2_ptc_ek_nandflash_defconfig b/configs/sama5d2_ptc_ek_nandflash_defconfig
index 0729cad701b..320be1be89f 100644
--- a/configs/sama5d2_ptc_ek_nandflash_defconfig
+++ b/configs/sama5d2_ptc_ek_nandflash_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama5d36ek_cmp_nandflash_defconfig b/configs/sama5d36ek_cmp_nandflash_defconfig
index 595cb9cb17f..91fcd73f01e 100644
--- a/configs/sama5d36ek_cmp_nandflash_defconfig
+++ b/configs/sama5d36ek_cmp_nandflash_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_CLK=y
diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sama5d3_xplained_nandflash_defconfig
index 0e3eb7d7b01..831fccc485e 100644
--- a/configs/sama5d3_xplained_nandflash_defconfig
+++ b/configs/sama5d3_xplained_nandflash_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3xek_nandflash_defconfig
index 995c9de1c80..4eefe091c90 100644
--- a/configs/sama5d3xek_nandflash_defconfig
+++ b/configs/sama5d3xek_nandflash_defconfig
@@ -67,7 +67,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sama5d4_xplained_nandflash_defconfig
index 5401f34adc6..43a40d370ad 100644
--- a/configs/sama5d4_xplained_nandflash_defconfig
+++ b/configs/sama5d4_xplained_nandflash_defconfig
@@ -65,7 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek_nandflash_defconfig
index b22e0dd18a3..268e04676a5 100644
--- a/configs/sama5d4ek_nandflash_defconfig
+++ b/configs/sama5d4ek_nandflash_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
index 7253c997b24..cca9cb8f6e7 100644
--- a/configs/smartweb_defconfig
+++ b/configs/smartweb_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index ae6c9b60cd5..fe7cbc765b7 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_WRITEABLE_LIST=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index f7ae13c891b..5fe35fe6eb8 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="zImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index 820b935b70a..39126d38d2b 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index b4e303ed6dd..031a0f25086 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -61,7 +61,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
diff --git a/configs/socrates_defconfig b/configs/socrates_defconfig
index 93d2736ba89..d17b86b344d 100644
--- a/configs/socrates_defconfig
+++ b/configs/socrates_defconfig
@@ -68,7 +68,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=fe000000.nor_flash:13312k(system1),13312k(syst
 # CONFIG_CMD_IRQ is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xFFF00000
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index 530f6aa6380..a327d792579 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
index fc095ac0de1..ff7afa02789 100644
--- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
index b243c45d690..0828e0cccb5 100644
--- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
index e635c726459..da37b553367 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
index 9e7849ff8f0..90962431ce4 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
diff --git a/configs/stm32mp15-odyssey_defconfig b/configs/stm32mp15-odyssey_defconfig
index 74fd2fb8e63..6c7cbc82c67 100644
--- a/configs/stm32mp15-odyssey_defconfig
+++ b/configs/stm32mp15-odyssey_defconfig
@@ -59,7 +59,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index e3090ec2a50..89735f5f5c6 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -88,7 +88,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index 5ddec18b520..af5f30509a6 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -60,7 +60,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index f0e6b64ffde..56a76e226ff 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -61,7 +61,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 317a6d5ecd6..f87812fa080 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -43,7 +43,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
diff --git a/configs/stm32mp_dhsom.config b/configs/stm32mp_dhsom.config
index 01d65cfd893..2e69a047ba9 100644
--- a/configs/stm32mp_dhsom.config
+++ b/configs/stm32mp_dhsom.config
@@ -83,7 +83,7 @@ CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_SYS_I2C_STM32F7=y
 CONFIG_SYS_LOAD_ADDR=0xc2000000
 CONFIG_SYS_PROMPT="STM32MP> "
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_USB=y
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index 29fa4ea42af..dab30ce295e 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -81,7 +81,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
diff --git a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
index fed54bc8207..393284fa5c4 100644
--- a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_ISO_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/theadorable-x86-conga-qa3-e3845_defconfig b/configs/theadorable-x86-conga-qa3-e3845_defconfig
index af81e78ccf5..803152b0b59 100644
--- a/configs/theadorable-x86-conga-qa3-e3845_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/theadorable-x86-dfi-bt700_defconfig b/configs/theadorable-x86-dfi-bt700_defconfig
index 0c9e6090617..9b64b6ef9d0 100644
--- a/configs/theadorable-x86-dfi-bt700_defconfig
+++ b/configs/theadorable-x86-dfi-bt700_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index 953ceba6626..c2bd47359ab 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 28b1bfc41f4..1a1248f2314 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 0af80d5c2e1..39d2d8ab5e1 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig
index ab0fd12bc48..dad17b39436 100644
--- a/configs/tuge1_defconfig
+++ b/configs/tuge1_defconfig
@@ -129,7 +129,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig
index e5a99b24dab..1ef7a472ace 100644
--- a/configs/tuxx1_defconfig
+++ b/configs/tuxx1_defconfig
@@ -143,7 +143,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=boot:768k(u-boot),128k(env),128k(envred),-(ubi
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xF00E0000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="UEC0"
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index 5842916fbdb..e6de7431788 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/work_92105_defconfig b/configs/work_92105_defconfig
index 0b4989ca002..0091a897ab6 100644
--- a/configs/work_92105_defconfig
+++ b/configs/work_92105_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_DOS_PARTITION=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index a82ccdc9a0c..2dce60298ef 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -66,7 +66,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index ba4519ce303..82e346f5ba4 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_BOARD=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 6859e24b731..9a058d5bc15 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -93,7 +93,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index ae79f101701..3c9fcf59400 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -117,7 +117,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 29aa5891b23..f736f17466d 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -116,7 +116,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
diff --git a/env/Kconfig b/env/Kconfig
index ee47b565213..414db543b82 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -489,7 +489,7 @@ config ENV_IS_IN_UBI
 	  the environment in.  This will enable redundant environments in UBI.
 	  It is assumed that both volumes are in the same MTD partition.
 
-config SYS_REDUNDAND_ENVIRONMENT
+config ENV_REDUNDANT
 	bool "Enable redundant environment support"
 	help
 	  Normally, the environemt is stored in a single location.  By
@@ -543,7 +543,7 @@ config ENV_FAT_FILE
 
 config ENV_FAT_FILE_REDUND
 	string "Name of the FAT file to use for the environment"
-	depends on ENV_IS_IN_FAT && SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_IS_IN_FAT && ENV_REDUNDANT
 	default "uboot-redund.env"
 	help
 	  It's a string of the FAT file name. This file use to store the
@@ -595,7 +595,7 @@ config ENV_ADDR
 
 config ENV_ADDR_REDUND
 	hex "Redundant environment address"
-	depends on ENV_IS_IN_FLASH && SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_IS_IN_FLASH && ENV_REDUNDANT
 	help
 	  Offset from the start of the device (or partition) of the redundant
 	  environment location.
@@ -625,7 +625,7 @@ config ENV_OFFSET
 config ENV_OFFSET_REDUND
 	hex "Redundant environment offset"
 	depends on (ENV_IS_IN_EEPROM || ENV_IS_IN_MMC || ENV_IS_IN_NAND || \
-		    ENV_IS_IN_SPI_FLASH) && SYS_REDUNDAND_ENVIRONMENT
+		    ENV_IS_IN_SPI_FLASH) && ENV_REDUNDANT
 	default 0x10C0000 if MICROBLAZE
 	default 0x0
 	help
@@ -675,7 +675,7 @@ config ENV_UBI_VOLUME
 
 config ENV_UBI_VOLUME_REDUND
 	string "UBI redundant volume name"
-	depends on ENV_IS_IN_UBI && SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_IS_IN_UBI && ENV_REDUNDANT
 	help
 	  Name of the redundant volume that you want to store the environment in.
 
diff --git a/env/common.c b/env/common.c
index 86122582bc1..1e23c5de436 100644
--- a/env/common.c
+++ b/env/common.c
@@ -466,7 +466,7 @@ int env_import(const char *buf, int check, int flags)
 	return -EIO;
 }
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 static unsigned char env_flags;
 
 int env_check_redund(const char *buf1, int buf1_read_fail,
@@ -543,7 +543,7 @@ int env_import_redund(const char *buf1, int buf1_read_fail,
 
 	return env_import((char *)ep, 0, flags);
 }
-#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#endif /* CONFIG_ENV_REDUNDANT */
 
 /* Export the environment and generate CRC for it. */
 int env_export(env_t *env_out)
@@ -560,7 +560,7 @@ int env_export(env_t *env_out)
 
 	env_out->crc = crc32(0, env_out->data, ENV_SIZE);
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 	env_out->flags = ++env_flags; /* increase the serial */
 #endif
 
diff --git a/env/fat.c b/env/fat.c
index 1ad301eaaff..65ee1c8e086 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -86,7 +86,7 @@ static int env_fat_save(void)
 		return 1;
 	}
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 	if (gd->env_valid == ENV_VALID)
 		file = CONFIG_ENV_FAT_FILE_REDUND;
 #endif
@@ -101,7 +101,7 @@ static int env_fat_save(void)
 		return 1;
 	}
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 	gd->env_valid = (gd->env_valid == ENV_REDUND) ? ENV_VALID : ENV_REDUND;
 #endif
 
@@ -112,7 +112,7 @@ static int env_fat_save(void)
 static int env_fat_load(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf1, CONFIG_ENV_SIZE);
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf2, CONFIG_ENV_SIZE);
 	int err2;
 #endif
@@ -153,7 +153,7 @@ static int env_fat_load(void)
 	}
 
 	err1 = file_fat_read(CONFIG_ENV_FAT_FILE, buf1, CONFIG_ENV_SIZE);
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 	err2 = file_fat_read(CONFIG_ENV_FAT_FILE_REDUND, buf2, CONFIG_ENV_SIZE);
 
 	err1 = (err1 >= 0) ? 0 : -1;
diff --git a/env/mmc.c b/env/mmc.c
index 8848371eb4f..5451f914027 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -186,7 +186,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	defvalue = ENV_MMC_OFFSET;
 	propname = dt_prop.offset;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && copy) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT) && copy) {
 		defvalue = ENV_MMC_OFFSET_REDUND;
 		propname = dt_prop.offset_redund;
 	}
@@ -198,7 +198,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 {
 	s64 offset = ENV_MMC_OFFSET;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && copy)
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT) && copy)
 		offset = ENV_MMC_OFFSET_REDUND;
 
 	return offset;
@@ -213,7 +213,7 @@ static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
 	 * identical, store the environment and redundant environment in both
 	 * eMMC boot partitions, one copy in each.
 	 */
-	if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (!IS_ENABLED(CONFIG_ENV_REDUNDANT))
 		return false;
 
 	if (CONFIG_SYS_MMC_ENV_PART != 1)
@@ -337,7 +337,7 @@ static int env_mmc_save(void)
 	if (ret)
 		goto fini;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT)) {
 		if (gd->env_valid == ENV_VALID)
 			copy = 1;
 
@@ -362,7 +362,7 @@ static int env_mmc_save(void)
 
 	ret = 0;
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT))
 		gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
 
 fini:
@@ -411,7 +411,7 @@ static int env_mmc_erase(void)
 	printf("\n");
 	ret = erase_env(mmc, CONFIG_ENV_SIZE, offset);
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT)) {
 		copy = 1;
 
 		if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
@@ -555,7 +555,7 @@ static int env_mmc_load(void)
 {
 	if (IS_ENABLED(ENV_IS_EMBEDDED))
 		return 0;
-	else if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	else if (IS_ENABLED(CONFIG_ENV_REDUNDANT))
 		return env_mmc_load_redundant();
 	else
 		return env_mmc_load_singular();
diff --git a/env/sf.c b/env/sf.c
index eb4c8d5ec95..0b70e18b9af 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -380,7 +380,7 @@ static int env_sf_init_early(void)
 
 	tmp_env1 = (env_t *)memalign(ARCH_DMA_MINALIGN,
 			CONFIG_ENV_SIZE);
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT))
 		tmp_env2 = (env_t *)memalign(ARCH_DMA_MINALIGN,
 					     CONFIG_ENV_SIZE);
 
@@ -394,7 +394,7 @@ static int env_sf_init_early(void)
 	read1_fail = spi_flash_read(env_flash, CONFIG_ENV_OFFSET,
 				    CONFIG_ENV_SIZE, tmp_env1);
 
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT)) {
 		read2_fail = spi_flash_read(env_flash,
 					    CONFIG_ENV_OFFSET_REDUND,
 					    CONFIG_ENV_SIZE, tmp_env2);
@@ -429,7 +429,7 @@ err_read:
 	spi_flash_free(env_flash);
 
 	free(tmp_env1);
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT))
 		free(tmp_env2);
 out:
 	/* env is not valid. always return 0 */
diff --git a/env/ubi.c b/env/ubi.c
index 2f4ca571edb..f424b1a16e8 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -27,14 +27,14 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#if CONFIG_ENV_REDUNDANT
 #define ENV_UBI_VOLUME_REDUND CONFIG_ENV_UBI_VOLUME_REDUND
 #else
 #define ENV_UBI_VOLUME_REDUND "invalid"
 #endif
 
 #ifdef CONFIG_CMD_SAVEENV
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 static int env_ubi_save(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(env_t, env_new, 1);
@@ -76,7 +76,7 @@ static int env_ubi_save(void)
 
 	return 0;
 }
-#else /* ! CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#else /* ! CONFIG_ENV_REDUNDANT */
 static int env_ubi_save(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(env_t, env_new, 1);
@@ -102,10 +102,10 @@ static int env_ubi_save(void)
 	puts("done\n");
 	return 0;
 }
-#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#endif /* CONFIG_ENV_REDUNDANT */
 #endif /* CONFIG_CMD_SAVEENV */
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 static int env_ubi_load(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, env1_buf, CONFIG_ENV_SIZE);
@@ -149,7 +149,7 @@ static int env_ubi_load(void)
 	return env_import_redund((char *)tmp_env1, read1_fail, (char *)tmp_env2,
 				 read2_fail, H_EXTERNAL);
 }
-#else /* ! CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#else /* ! CONFIG_ENV_REDUNDANT */
 static int env_ubi_load(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, CONFIG_ENV_SIZE);
@@ -180,7 +180,7 @@ static int env_ubi_load(void)
 
 	return env_import(buf, 1, H_EXTERNAL);
 }
-#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+#endif /* CONFIG_ENV_REDUNDANT */
 
 static int env_ubi_erase(void)
 {
@@ -202,7 +202,7 @@ static int env_ubi_erase(void)
 		       CONFIG_ENV_UBI_VOLUME);
 		ret = 1;
 	}
-	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
+	if (IS_ENABLED(CONFIG_ENV_REDUNDANT)) {
 		if (ubi_volume_write(ENV_UBI_VOLUME_REDUND,
 				     (void *)env_buf, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to erase env to %s:%s **\n",
diff --git a/include/env_default.h b/include/env_default.h
index 60c39f9853f..6e8f2ea90e7 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -16,7 +16,7 @@
 #ifdef DEFAULT_ENV_INSTANCE_EMBEDDED
 env_t embedded_environment __UBOOT_ENV_SECTION__(environment) = {
 	ENV_CRC,	/* CRC Sum */
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 	1,		/* Flags: valid */
 #endif
 	{
diff --git a/include/env_internal.h b/include/env_internal.h
index 75b46d0bcb0..0589c435e84 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -53,7 +53,7 @@ extern unsigned long nand_env_oob_offset;
 
 #include "compiler.h"
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 # define ENV_HEADER_SIZE	(sizeof(uint32_t) + 1)
 #else
 # define ENV_HEADER_SIZE	(sizeof(uint32_t))
@@ -77,7 +77,7 @@ extern unsigned long nand_env_oob_offset;
 
 typedef struct environment_s {
 	uint32_t	crc;		/* CRC32 over data bytes	*/
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 	unsigned char	flags;		/* active/obsolete flags ENVF_REDUND_ */
 #endif
 	unsigned char	data[ENV_SIZE]; /* Environment data		*/
diff --git a/tools/envcrc.c b/tools/envcrc.c
index 09051800364..7f680fb8a95 100644
--- a/tools/envcrc.c
+++ b/tools/envcrc.c
@@ -40,7 +40,7 @@
 # endif
 #endif	/* CONFIG_ENV_IS_IN_FLASH */
 
-#ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
+#ifdef CONFIG_ENV_REDUNDANT
 # define ENV_HEADER_SIZE	(sizeof(uint32_t) + 1)
 #else
 # define ENV_HEADER_SIZE	(sizeof(uint32_t))
-- 
2.47.2

