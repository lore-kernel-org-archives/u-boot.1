Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74594C36008
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 21:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524C381D1F;
	Sat, 22 Mar 2025 22:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bCeLX7+b";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GrP4MEtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD1D81D6C; Sat, 22 Mar 2025 22:56:54 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC7581C84
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 22:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZKtSf0nkbz9shr;
 Sat, 22 Mar 2025 22:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bA1svar6GigrBC/udrkkDo/u1uNaD2bsvNVeMxWMTM0=;
 b=bCeLX7+b00SPUtF8yKZjuIGvsvf6/qljLxhpdyier01eMjcok0m9sBJF0r9NJn0ls+saT8
 jsgItiZ58DqOLH1uH2OYA+1A73o62wg2IgOhixFKqbyDUQ1eHBnelEIUqUHwaEJah0jbWB
 QaCZDBSPSFl02ugy60HlBs9BTepAsNs6RhgIepbV4XLTYWrjdGmQS/Oim58EQykglcGsk4
 EV+3mwClaSOnPuBIrhe3DsYnxV0pzxwl6qxLko4APnpSV+gw30wonXFD42H9JDqJ5tnprz
 42FQrtCh7AXEWYE+HZkPKPNvGE4AGm3Jz/S1jLGf16Y/yD5ZCBDrpXrSCRZpcw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bA1svar6GigrBC/udrkkDo/u1uNaD2bsvNVeMxWMTM0=;
 b=GrP4MEtbvY7O+CpBYcCmx3vA2SniFehpgp98+4TLBmJ2NRd6eUUH+b7KqbLIqWlylglF8F
 WSskfvzrmaEAmEvV5vlVXWncnl6YkPiuERq5mv4EFLqgIudqxuUK7Wg6yb2EsEg+nctjgc
 X047jddFZxL7gHZIlbAz+siXwcn9EXGrME9dqQ2ziWicby/J0v519ge9qD8T3X439xHSMj
 2ujk3G/qinNFtKIJKj3WpaVYLCa8Mzjp493MA9lZ/hxNCbVu174FDWJ/xbqHonoeKIhbD3
 bOKm5Eb+LLewpfuJpZg8yHAXt8nA37fVbsjby+E8Fm3IIulcrAtGbTJbnqUUAw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] env: Rename SYS_MMC_ENV_PART to
 ENV_SDMMC_EMMC_HW_PARTITION
Date: Sat, 22 Mar 2025 22:55:25 +0100
Message-ID: <20250322215624.18994-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3ad55e8463a26fadd55
X-MBO-RS-META: 9ejxjx67md7e5cti36dqxjux1x6e35i7
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

Use ENV_SDMMC_EMMC_HW_PARTITION to clarify this is the eMMC hardware
partition selector, not a software partition table entry selector.
Retain the ENV_SDMMC_ prefix to make it easier to search for all the
SD/MMC related ENV options. Update the help text accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-imx/mx6/soc.c               | 6 +++---
 configs/am335x_sl50_defconfig             | 2 +-
 configs/am65x_evm_a53_defconfig           | 2 +-
 configs/apalis-imx8_defconfig             | 2 +-
 configs/apalis-tk1_defconfig              | 2 +-
 configs/apalis_imx6_defconfig             | 2 +-
 configs/apalis_t30_defconfig              | 2 +-
 configs/beaver_defconfig                  | 2 +-
 configs/brppt1_mmc_defconfig              | 2 +-
 configs/brxre1_defconfig                  | 2 +-
 configs/capricorn_cxg3_defconfig          | 2 +-
 configs/cardhu_defconfig                  | 2 +-
 configs/cei-tk1-som_defconfig             | 2 +-
 configs/colibri-imx6ull-emmc_defconfig    | 2 +-
 configs/colibri-imx8x_defconfig           | 2 +-
 configs/colibri_imx6_defconfig            | 2 +-
 configs/colibri_imx7_emmc_defconfig       | 2 +-
 configs/colibri_t30_defconfig             | 2 +-
 configs/dalmore_defconfig                 | 2 +-
 configs/dragonboard410c_defconfig         | 2 +-
 configs/e850-96_defconfig                 | 2 +-
 configs/endeavoru_defconfig               | 2 +-
 configs/grouper_defconfig                 | 2 +-
 configs/gwventana_emmc_defconfig          | 2 +-
 configs/hihope_rzg2_defconfig             | 2 +-
 configs/hikey_defconfig                   | 2 +-
 configs/hmibsc_defconfig                  | 2 +-
 configs/ideapad-yoga-11_defconfig         | 2 +-
 configs/imx6q_bosch_acc_defconfig         | 2 +-
 configs/imx8m_data_modul.config           | 2 +-
 configs/imx8mm-mx8menlo_defconfig         | 2 +-
 configs/imx8mm_beacon_defconfig           | 2 +-
 configs/imx8mm_beacon_fspi_defconfig      | 2 +-
 configs/imx8mn_beacon_2g_defconfig        | 2 +-
 configs/imx8mn_beacon_defconfig           | 2 +-
 configs/imx8mn_beacon_fspi_defconfig      | 2 +-
 configs/imx8mn_var_som_defconfig          | 2 +-
 configs/imx8mp_beacon_defconfig           | 2 +-
 configs/j722s_evm_r5_defconfig            | 2 +-
 configs/jetson-tk1_defconfig              | 2 +-
 configs/khadas-vim3_android_ab_defconfig  | 2 +-
 configs/khadas-vim3_android_defconfig     | 2 +-
 configs/khadas-vim3l_android_ab_defconfig | 2 +-
 configs/khadas-vim3l_android_defconfig    | 2 +-
 configs/mocha_defconfig                   | 2 +-
 configs/mt8183_pumpkin_defconfig          | 2 +-
 configs/nyan-big_defconfig                | 2 +-
 configs/opos6uldev_defconfig              | 2 +-
 configs/p2371-0000_defconfig              | 2 +-
 configs/p2371-2180_defconfig              | 2 +-
 configs/p2571_defconfig                   | 2 +-
 configs/p2771-0000-000_defconfig          | 2 +-
 configs/p2771-0000-500_defconfig          | 2 +-
 configs/paz00_defconfig                   | 2 +-
 configs/phycore_am62ax_r5_defconfig       | 2 +-
 configs/picasso_defconfig                 | 2 +-
 configs/qc750_defconfig                   | 2 +-
 configs/r8a77990_ebisu_defconfig          | 2 +-
 configs/r8a77995_draak_defconfig          | 2 +-
 configs/r8a779g0_whitehawk_defconfig      | 2 +-
 configs/r8a779h0_grayhawk_defconfig       | 2 +-
 configs/rcar3_salvator-x_defconfig        | 2 +-
 configs/rcar3_ulcb_defconfig              | 2 +-
 configs/renesas_rzg2l_smarc_defconfig     | 2 +-
 configs/rzg2_beacon_defconfig             | 2 +-
 configs/seaboard_defconfig                | 2 +-
 configs/sei510_defconfig                  | 2 +-
 configs/sei610_defconfig                  | 2 +-
 configs/stm32mp13_dhcor_defconfig         | 2 +-
 configs/surface-rt_defconfig              | 2 +-
 configs/tbs2910_defconfig                 | 2 +-
 configs/tec-ng_defconfig                  | 2 +-
 configs/transformer_t20_defconfig         | 2 +-
 configs/transformer_t30_defconfig         | 2 +-
 configs/turris_mox_defconfig              | 2 +-
 configs/venice2_defconfig                 | 2 +-
 configs/ventana_defconfig                 | 2 +-
 configs/verdin-am62_a53_defconfig         | 2 +-
 configs/verdin-imx8mm_defconfig           | 2 +-
 configs/verdin-imx8mp_defconfig           | 2 +-
 configs/vining_2000_defconfig             | 2 +-
 configs/x3_t30_defconfig                  | 2 +-
 env/Kconfig                               | 6 +++---
 env/mmc.c                                 | 8 ++++----
 include/mmc.h                             | 2 +-
 85 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index beb4488b0c8..f96f599fe59 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -540,10 +540,10 @@ int mmc_get_env_dev(void)
 	return board_mmc_get_env_dev(devno);
 }
 
-#ifdef CONFIG_SYS_MMC_ENV_PART
+#ifdef CONFIG_ENV_SDMMC_EMMC_HW_PARTITION
 __weak int board_mmc_get_env_part(int devno)
 {
-	return CONFIG_SYS_MMC_ENV_PART;
+	return CONFIG_ENV_SDMMC_EMMC_HW_PARTITION;
 }
 
 uint mmc_get_env_part(struct mmc *mmc)
@@ -552,7 +552,7 @@ uint mmc_get_env_part(struct mmc *mmc)
 
 	/* If not boot from sd/mmc, use default value */
 	if (devno < 0)
-		return CONFIG_SYS_MMC_ENV_PART;
+		return CONFIG_ENV_SDMMC_EMMC_HW_PARTITION;
 
 	return board_mmc_get_env_part(devno);
 }
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index aa3cdc0ab8e..b6d995a740d 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -58,7 +58,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=1
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index d88300fedc0..a36d86795e6 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -81,7 +81,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index 3e66083d31a..7f6765f5777 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index 539060c5282..3bc38a09591 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index fd08432e57a..fc8d0b4fb93 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index 9937344cb6f..0c3cf2b161d 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/beaver_defconfig b/configs/beaver_defconfig
index 56f0362e201..9e8d4b08f13 100644
--- a/configs/beaver_defconfig
+++ b/configs/beaver_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index cb76bea5610..a79a1e42c2b 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -82,7 +82,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=1
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index 7d8624bbc91..cc79f6d9d6d 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -76,7 +76,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=1
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 49c1c3c517a..267b6b86ed9 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -88,7 +88,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/cardhu_defconfig b/configs/cardhu_defconfig
index ad220c19788..24e44131758 100644
--- a/configs/cardhu_defconfig
+++ b/configs/cardhu_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_RTL8169=y
diff --git a/configs/cei-tk1-som_defconfig b/configs/cei-tk1-som_defconfig
index f9965bba23e..c2b5835bcc8 100644
--- a/configs/cei-tk1-som_defconfig
+++ b/configs/cei-tk1-som_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index 20469aa1973..f9438f1807e 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -48,7 +48,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index a79a602075d..e9180fc0dbe 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 7ce17b0bad9..c940b25f2b5 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index fa53b29eaac..24f3bc42250 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_IP_DEFRAG=y
 CONFIG_USE_IPADDR=y
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index 23ce3d9bbfd..4253e45bb79 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/dalmore_defconfig b/configs/dalmore_defconfig
index 0aed9ebad58..ddb96614a4e 100644
--- a/configs/dalmore_defconfig
+++ b/configs/dalmore_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 9b25bfd129b..cca9cfd081a 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_APQ8016=y
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 865f22348c8..acb396426d5 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -35,7 +35,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
 CONFIG_SUPPORT_EMMC_BOOT=y
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 11b9c00b765..8ff5c0513ec 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
index 48d14bc9f40..d74bbec60b3 100644
--- a/configs/grouper_defconfig
+++ b/configs/grouper_defconfig
@@ -55,7 +55,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index c29872b4abd..72d1b111728 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -93,7 +93,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NETCONSOLE=y
 CONFIG_USE_IPADDR=y
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index 9d0724b6480..2f54b91c4e2 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -25,7 +25,7 @@ CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=0
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_GPIO_HOG=y
 CONFIG_DM_PCA953X=y
 CONFIG_SYS_I2C_RCAR_I2C=y
diff --git a/configs/hikey_defconfig b/configs/hikey_defconfig
index c63e66cf383..d11fe3c9c8f 100644
--- a/configs/hikey_defconfig
+++ b/configs/hikey_defconfig
@@ -29,7 +29,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_HIKEY_GPIO=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_K3=y
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index 1a7e3c79e10..8fc6c9591f5 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_FS_GENERIC=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_BUTTON_QCOM_PMIC=y
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
index bb732f004e7..337c45beeae 100644
--- a/configs/ideapad-yoga-11_defconfig
+++ b/configs/ideapad-yoga-11_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 728a57478bb..0577faf75c2 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -77,7 +77,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index f885688f072..e6eeb12a7ba 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -198,7 +198,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_PBSIZE=2081
 CONFIG_SYS_PROMPT="u-boot=> "
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index dfa7de4e487..05e9e91a2a2 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -93,7 +93,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index bb010df9652..c3b8d804a3d 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -75,7 +75,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index f3e046ce78d..a229733d143 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -79,7 +79,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index ae6d5afdd0f..19a34047965 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -84,7 +84,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index a295b790437..23f12a2d5ca 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -84,7 +84,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index f6b13305d20..5a91dc0714e 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -84,7 +84,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index 34bf452ebc3..7c44d4da9b9 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -62,7 +62,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index b77a83fb9be..66567d5210d 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -82,7 +82,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_SPL_DM=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 700ce2f9249..12366ada9d7 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -68,7 +68,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/jetson-tk1_defconfig b/configs/jetson-tk1_defconfig
index 9594c30dec6..9237bda5109 100644
--- a/configs/jetson-tk1_defconfig
+++ b/configs/jetson-tk1_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 8d9a7674bab..6838891371c 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 3d36db66f68..cd7b58393ee 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 28186e91dad..1b2e49260c1 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index ad37ad0df1f..8f4750015c7 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
index ae1a92ff817..5301a5cffe4 100644
--- a/configs/mocha_defconfig
+++ b/configs/mocha_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/mt8183_pumpkin_defconfig b/configs/mt8183_pumpkin_defconfig
index 9d0495f470c..16c5ab057d2 100644
--- a/configs/mt8183_pumpkin_defconfig
+++ b/configs/mt8183_pumpkin_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_DEVRES=y
 CONFIG_CLK=y
diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index d04bcacf26d..6d0be8fb8b2 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index 90a8180876f..10c18ca0a05 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -75,7 +75,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_VERSION_VARIABLE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_ROOTPATH="/tftpboot/opos6ul-root"
diff --git a/configs/p2371-0000_defconfig b/configs/p2371-0000_defconfig
index 422e3530e64..f42c1f93b62 100644
--- a/configs/p2371-0000_defconfig
+++ b/configs/p2371-0000_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/p2371-2180_defconfig b/configs/p2371-2180_defconfig
index 1815b24a4b7..655f516739a 100644
--- a/configs/p2371-2180_defconfig
+++ b/configs/p2371-2180_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/p2571_defconfig b/configs/p2571_defconfig
index a8f80486791..23037e25138 100644
--- a/configs/p2571_defconfig
+++ b/configs/p2571_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/p2771-0000-000_defconfig b/configs/p2771-0000-000_defconfig
index 21937a0decf..b39e3e5e774 100644
--- a/configs/p2771-0000-000_defconfig
+++ b/configs/p2771-0000-000_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA186_BPMP_I2C=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/p2771-0000-500_defconfig b/configs/p2771-0000-500_defconfig
index 4cd32e60a99..548f0a70139 100644
--- a/configs/p2771-0000-500_defconfig
+++ b/configs/p2771-0000-500_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA186_BPMP_I2C=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
index 62e06db4280..450526cd2c4 100644
--- a/configs/paz00_defconfig
+++ b/configs/paz00_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
index 79ca23ecdf2..993f6ab7919 100644
--- a/configs/phycore_am62ax_r5_defconfig
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -66,7 +66,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
index 90f54e11ede..931f38e8cad 100644
--- a/configs/picasso_defconfig
+++ b/configs/picasso_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x11000000
diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index 36b9b88b144..81779a85ddd 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 7864fc50773..467430094a9 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -32,7 +32,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index b0da941e9ce..30e8e2c28c5 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -31,7 +31,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index b49a81dcd49..a7d6165de60 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -17,7 +17,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_REMOTEPROC_RENESAS_APMU=y
 CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BITBANGMII=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 5b9ad93a596..000adf35950 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -14,7 +14,7 @@ CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779h0-gray
 CONFIG_DEFAULT_FDT_FILE="r8a779h0-gray-hawk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BITBANGMII=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 61183be948a..875b332691f 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -38,7 +38,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index dab1c9a7353..579498a49a6 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -33,7 +33,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index 61697524518..983fd943a0f 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -39,7 +39,7 @@ CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_REGMAP=y
 CONFIG_CLK=y
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 5e19d365027..4d51fd80668 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -23,7 +23,7 @@ CONFIG_OF_LIST="renesas/r8a774a1-beacon-rzg2m-kit renesas/r8a774b1-beacon-rzg2n-
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DM_PCA953X=y
 CONFIG_SYS_I2C_RCAR_I2C=y
 CONFIG_SYS_I2C_RCAR_IIC=y
diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
index 4abb11e85f8..b49e364de2a 100644
--- a/configs/seaboard_defconfig
+++ b/configs/seaboard_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA_KEYBOARD=y
 CONFIG_MTD_RAW_NAND=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index d60964aefe7..4ec2702d025 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index ba2b212a106..4b32b23934e 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
diff --git a/configs/stm32mp13_dhcor_defconfig b/configs/stm32mp13_dhcor_defconfig
index a08d9f53896..82349d733ee 100644
--- a/configs/stm32mp13_dhcor_defconfig
+++ b/configs/stm32mp13_dhcor_defconfig
@@ -35,7 +35,7 @@ CONFIG_CLK_SCMI=y
 CONFIG_SET_DFU_ALT_INFO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_ENV_SDMMC_DEVICE_INDEX=0
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_REGULATOR_SCMI=y
 CONFIG_RESET_SCMI=y
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
index 8401623d9fe..a456d9b20bb 100644
--- a/configs/surface-rt_defconfig
+++ b/configs/surface-rt_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index b4c32441315..2c77729cf93 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -69,7 +69,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
diff --git a/configs/tec-ng_defconfig b/configs/tec-ng_defconfig
index fd8e96dfb09..2300c456cf6 100644
--- a/configs/tec-ng_defconfig
+++ b/configs/tec-ng_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SYS_NS16550=y
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index bfa3120ae48..46b2e6df68b 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x11000000
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index f9d920214b8..08e89faddca 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -56,7 +56,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_CLK_GPIO=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index 7792da7b90e..c0c4874d568 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -54,7 +54,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_OF_LIST="armada-3720-turris-mox armada-3720-ripe-atlas"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NETCONSOLE=y
diff --git a/configs/venice2_defconfig b/configs/venice2_defconfig
index 9e201bfbf41..983abc848e4 100644
--- a/configs/venice2_defconfig
+++ b/configs/venice2_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/ventana_defconfig b/configs/ventana_defconfig
index fd863980b09..3801a17a081 100644
--- a/configs/ventana_defconfig
+++ b/configs/ventana_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index d53d366c273..550a16d1dd4 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -95,7 +95,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 0bcb9f1f32c..16a0d2c4a26 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -84,7 +84,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index a4809270e25..96a78d90ae0 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -97,7 +97,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_SDMMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index 0d3c04c6f9e..af861f2c136 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index b36fe9c0c75..eb7f0f3a1a3 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_SDMMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14526=y
diff --git a/env/Kconfig b/env/Kconfig
index 6bb882baa9e..fbc03777040 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -219,7 +219,7 @@ config ENV_IS_IN_MMC
 
 	  Specifies which MMC device the environment is stored in.
 
-	  CONFIG_SYS_MMC_ENV_PART (optional):
+	  CONFIG_ENV_SDMMC_EMMC_HW_PARTITION (optional):
 
 	  Specifies which MMC partition the environment is stored in. If not
 	  set, defaults to partition 0, the user area. Common values might be
@@ -252,7 +252,7 @@ config ENV_IS_IN_MMC
 	  This value may also be positive or negative; this is handled in the
 	  same way as CONFIG_ENV_OFFSET.
 
-	  In case CONFIG_SYS_MMC_ENV_PART is 1 (i.e. environment in eMMC boot
+	  In case CONFIG_ENV_SDMMC_EMMC_HW_PARTITION is 1 (i.e. environment in eMMC boot
 	  partition) then setting CONFIG_ENV_OFFSET_REDUND to the same value
 	  as CONFIG_ENV_OFFSET makes use of the second eMMC boot partition for
 	  the redundant environment copy.
@@ -676,7 +676,7 @@ config ENV_SDMMC_DEVICE_INDEX
 	  The index is often derived from DT aliases mmcN node ordering, and
 	  matches the 'mmc list' command output.
 
-config SYS_MMC_ENV_PART
+config ENV_SDMMC_EMMC_HW_PARTITION
 	int "mmc partition number"
 	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT
 	default 0
diff --git a/env/mmc.c b/env/mmc.c
index 2e3edbff21d..4155a5c72f1 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -157,7 +157,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	int hwpart = 0;
 	int err;
 
-#if defined(CONFIG_SYS_MMC_ENV_PART)
+#if defined(CONFIG_ENV_SDMMC_EMMC_HW_PARTITION)
 	hwpart = mmc_get_env_part(mmc);
 #endif
 
@@ -216,7 +216,7 @@ static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
 	if (!IS_ENABLED(CONFIG_ENV_REDUNDAND_ENVIRONMENT))
 		return false;
 
-	if (CONFIG_SYS_MMC_ENV_PART != 1)
+	if (CONFIG_ENV_SDMMC_EMMC_HW_PARTITION != 1)
 		return false;
 
 	return mmc_offset(mmc, 0) == mmc_offset(mmc, 1);
@@ -239,10 +239,10 @@ __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
 	return 0;
 }
 
-#ifdef CONFIG_SYS_MMC_ENV_PART
+#ifdef CONFIG_ENV_SDMMC_EMMC_HW_PARTITION
 __weak uint mmc_get_env_part(struct mmc *mmc)
 {
-	return CONFIG_SYS_MMC_ENV_PART;
+	return CONFIG_ENV_SDMMC_EMMC_HW_PARTITION;
 }
 
 static unsigned char env_mmc_orig_hwpart;
diff --git a/include/mmc.h b/include/mmc.h
index 81bccb4cf12..50c1cb2037c 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -979,7 +979,7 @@ void board_mmc_power_init(void);
 int board_mmc_init(struct bd_info *bis);
 int cpu_mmc_init(struct bd_info *bis);
 int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr);
-# ifdef CONFIG_SYS_MMC_ENV_PART
+# ifdef CONFIG_ENV_SDMMC_EMMC_HW_PARTITION
 extern uint mmc_get_env_part(struct mmc *mmc);
 # endif
 int mmc_get_env_dev(void);
-- 
2.47.2

