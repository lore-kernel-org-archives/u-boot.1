Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95218C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E486A8144A;
	Mon,  9 Jun 2025 21:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fx4JF4df";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e/fSQBKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEB182C7D; Mon,  9 Jun 2025 21:27:30 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787C182BD6
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bGMPp2Lhnz9sp2;
 Mon,  9 Jun 2025 21:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NEIBYGYA0H98u8jNseSZT+OpJhcpDcN8kDD0WPlJ0s=;
 b=fx4JF4dfanBeIsWRE9A1eMEWF4Kqx2xx1DMZl2R/B6BG/qpkci1ljCcKr7LNT99x9C+Yhr
 lsKY6rrVooyemmKfX0BUJ98Ya85hApIIMHMMA9CpTwzl2dqJJ4EVwxi3bDdm4kliYifR1b
 k3P/+6cJvt4slv8iKjlDhdPQm0h1l2F9cKMg4bGAn3oEjXZKN/1Rn7jNQj31QX3aa/dL8l
 bt3H1fYn1W4oyrW3l7np1fUo+Y/zRybk+Y0gKxjo0wtkQ5i3PllPvGoMW2eS9NyW2g27Ka
 asajKCxd8yCEc+2xEldir3co1iBcy5KcPQhts4tp04sBponHJCrCDYX2zZg6ZQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NEIBYGYA0H98u8jNseSZT+OpJhcpDcN8kDD0WPlJ0s=;
 b=e/fSQBKZT7VvBeWDkS4Rrb/8+SqrVGj+zVZ4LqjLj6ivqQULNd16Xlcy6lG2afD0JpCYlu
 v1cZK2oe0QL8OVJERCwyHGZxxEGopul3F0VNCPxgdiVcRKvhhjQ1DAIx45MsQuwC7MAQYI
 8WPebfqwND224hjqssa5gZGeVpzvwmKBpyHg8lU/zEZg+ceW5ZthhYZzJuregYTPJXWU+D
 oIAlG0wUZGaf363dmexdkjrH+j9hwdSHH285X2M7tolpEaTRdtzpwnaY1lylSaXxy+TyB2
 37BGREWWf//4ZHJ/zuzRYRmiWRmiMyKCVO02bi261z9ewX64Ifa2jHWvTpPFCw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/8] env: Rename SYS_MMC_ENV_PART to
 ENV_MMC_EMMC_HW_PARTITION
Date: Mon,  9 Jun 2025 21:26:40 +0200
Message-ID: <20250609192701.20260-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ojg61ohfg3gcayym4xdks7oz1i5qib5p
X-MBO-RS-ID: 86300715f4602b3686a
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

Use ENV_MMC_EMMC_HW_PARTITION to clarify this is the eMMC hardware
partition selector, not a software partition table entry selector.
Retain the ENV_MMC_ prefix to make it easier to search for all the
SD/MMC related ENV options. Update the help text accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Rename to ENV_MMC_EMMC_HW_PARTITION
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
 configs/imx8qxp_capricorn.config          | 2 +-
 configs/j722s_evm_r5_defconfig            | 2 +-
 configs/jetson-tk1_defconfig              | 2 +-
 configs/khadas-vim3_android_ab_defconfig  | 2 +-
 configs/khadas-vim3_android_defconfig     | 2 +-
 configs/khadas-vim3l_android_ab_defconfig | 2 +-
 configs/khadas-vim3l_android_defconfig    | 2 +-
 configs/mocha_defconfig                   | 2 +-
 configs/mot_defconfig                     | 2 +-
 configs/mt8183_pumpkin_defconfig          | 2 +-
 configs/nyan-big_defconfig                | 2 +-
 configs/opos6uldev_defconfig              | 2 +-
 configs/ouya_defconfig                    | 2 +-
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
 configs/star_defconfig                    | 2 +-
 configs/stm32mp13_dhcor_defconfig         | 2 +-
 configs/surface-rt_defconfig              | 2 +-
 configs/tbs2910_defconfig                 | 2 +-
 configs/tec-ng_defconfig                  | 2 +-
 configs/tegratab_defconfig                | 2 +-
 configs/tf701t_defconfig                  | 2 +-
 configs/toradex-smarc-imx8mp_defconfig    | 2 +-
 configs/transformer_t20_defconfig         | 2 +-
 configs/transformer_t30_defconfig         | 2 +-
 configs/turris_mox_defconfig              | 2 +-
 configs/venice2_defconfig                 | 2 +-
 configs/ventana_defconfig                 | 2 +-
 configs/verdin-am62_a53_defconfig         | 2 +-
 configs/verdin-am62p_a53_defconfig        | 2 +-
 configs/verdin-imx8mm_defconfig           | 2 +-
 configs/verdin-imx8mp_defconfig           | 2 +-
 configs/vining_2000_defconfig             | 2 +-
 configs/x3_t30_defconfig                  | 2 +-
 env/Kconfig                               | 8 ++++----
 env/mmc.c                                 | 8 ++++----
 include/mmc.h                             | 2 +-
 92 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 90fe9e7c19b..50521490b35 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -540,10 +540,10 @@ int mmc_get_env_dev(void)
 	return board_mmc_get_env_dev(devno);
 }
 
-#ifdef CONFIG_SYS_MMC_ENV_PART
+#ifdef CONFIG_ENV_MMC_EMMC_HW_PARTITION
 __weak int board_mmc_get_env_part(int devno)
 {
-	return CONFIG_SYS_MMC_ENV_PART;
+	return CONFIG_ENV_MMC_EMMC_HW_PARTITION;
 }
 
 uint mmc_get_env_part(struct mmc *mmc)
@@ -552,7 +552,7 @@ uint mmc_get_env_part(struct mmc *mmc)
 
 	/* If not boot from sd/mmc, use default value */
 	if (devno < 0)
-		return CONFIG_SYS_MMC_ENV_PART;
+		return CONFIG_ENV_MMC_EMMC_HW_PARTITION;
 
 	return board_mmc_get_env_part(devno);
 }
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 4887bf7b181..32c8e9bd39f 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -58,7 +58,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index fdee4d0bf07..86fa5d30373 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -74,7 +74,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index 3872e8cd9b0..dfd586b1c14 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index 539060c5282..de30fa1b961 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index fd08432e57a..7d54205938e 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index 9937344cb6f..e9c9cfe940e 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/beaver_defconfig b/configs/beaver_defconfig
index 56f0362e201..caf2ae196f8 100644
--- a/configs/beaver_defconfig
+++ b/configs/beaver_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 2bdd0f9c40b..58da63d11dd 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -82,7 +82,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index fdb7b8b5db2..2af491b065d 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -76,7 +76,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/cardhu_defconfig b/configs/cardhu_defconfig
index ad220c19788..318fbaa529b 100644
--- a/configs/cardhu_defconfig
+++ b/configs/cardhu_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_RTL8169=y
diff --git a/configs/cei-tk1-som_defconfig b/configs/cei-tk1-som_defconfig
index f9965bba23e..01c3117e364 100644
--- a/configs/cei-tk1-som_defconfig
+++ b/configs/cei-tk1-som_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index 20469aa1973..f1c6373c31e 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -48,7 +48,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index cf027bc1c75..431987d3f90 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 7ce17b0bad9..1aea1d40c4e 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index fa53b29eaac..e23cc993542 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_IP_DEFRAG=y
 CONFIG_USE_IPADDR=y
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index 23ce3d9bbfd..8d7a6bf7060 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/dalmore_defconfig b/configs/dalmore_defconfig
index 0aed9ebad58..c44980e9227 100644
--- a/configs/dalmore_defconfig
+++ b/configs/dalmore_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 20b2794b618..c01d22abe2b 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_SYSBOOT=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_APQ8016=y
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 34bfc75ea31..e07e4cffd0a 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -35,7 +35,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
 CONFIG_SUPPORT_EMMC_BOOT=y
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 7aac11192fc..804b00697a1 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
index 76ec9a39a7c..b9068e18b03 100644
--- a/configs/grouper_defconfig
+++ b/configs/grouper_defconfig
@@ -55,7 +55,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index 9aabd6be88a..807e48f50e4 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -93,7 +93,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NETCONSOLE=y
 CONFIG_USE_IPADDR=y
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index 88ce24c6572..f5bb28cb0c7 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -25,7 +25,7 @@ CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=0
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_GPIO_HOG=y
 CONFIG_DM_PCA953X=y
 CONFIG_SYS_I2C_RCAR_I2C=y
diff --git a/configs/hikey_defconfig b/configs/hikey_defconfig
index c63e66cf383..59c2101110e 100644
--- a/configs/hikey_defconfig
+++ b/configs/hikey_defconfig
@@ -29,7 +29,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_HIKEY_GPIO=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_K3=y
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index 6832ed46077..b45245729a7 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_FS_GENERIC=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_BUTTON_QCOM_PMIC=y
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
index 350dbcc4dcd..d5befae419d 100644
--- a/configs/ideapad-yoga-11_defconfig
+++ b/configs/ideapad-yoga-11_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index b6cbd9fbb66..6f0ef2eaee3 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -77,7 +77,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 0c9f85b7671..07390037c46 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -198,7 +198,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_PBSIZE=2081
 CONFIG_SYS_PROMPT="u-boot=> "
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index d7be3f0c679..eb8e90a1251 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -93,7 +93,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 52c9f007892..06cc4bb7dde 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -76,7 +76,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index 77db48da38f..5e60c9d3a08 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -79,7 +79,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index 0fd446c6e36..b71cdbb2e4e 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -84,7 +84,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index 860d1a9bd27..bb483653db2 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -85,7 +85,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index 4fb7cfded51..f163871bfaa 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -84,7 +84,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index 3b41cdddddf..26b2a3be64d 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -62,7 +62,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 51b547c448f..1c2f7a8501a 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -83,7 +83,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_SPL_DM=y
diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index 7b034d5ff1e..62babf2626f 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -11,7 +11,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 
 CONFIG_DM_GPIO=y
 CONFIG_AHAB_BOOT=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index ab0d4ebb825..f4562bd0d68 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -69,7 +69,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/jetson-tk1_defconfig b/configs/jetson-tk1_defconfig
index 9594c30dec6..13d43c02b9f 100644
--- a/configs/jetson-tk1_defconfig
+++ b/configs/jetson-tk1_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index e763f564ad1..765a154c150 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index af34a379e84..d105c2b40b0 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index c95cd2831d6..0625c101085 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index d1141cd8cb9..be65d0feb12 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
index 8d352e49551..ab8cea69a02 100644
--- a/configs/mocha_defconfig
+++ b/configs/mocha_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/mot_defconfig b/configs/mot_defconfig
index 8f0a52d719f..c5004c250fb 100644
--- a/configs/mot_defconfig
+++ b/configs/mot_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x11000000
diff --git a/configs/mt8183_pumpkin_defconfig b/configs/mt8183_pumpkin_defconfig
index 9d0495f470c..4aceb73c34c 100644
--- a/configs/mt8183_pumpkin_defconfig
+++ b/configs/mt8183_pumpkin_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_DEVRES=y
 CONFIG_CLK=y
diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 4294194ede6..6d2b1a17edf 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index 0379b4bbfe9..e9184549601 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -75,7 +75,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_VERSION_VARIABLE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_ROOTPATH="/tftpboot/opos6ul-root"
diff --git a/configs/ouya_defconfig b/configs/ouya_defconfig
index d8f3f389b5e..60cc3796c5e 100644
--- a/configs/ouya_defconfig
+++ b/configs/ouya_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/p2371-0000_defconfig b/configs/p2371-0000_defconfig
index 422e3530e64..4d3bfaa6982 100644
--- a/configs/p2371-0000_defconfig
+++ b/configs/p2371-0000_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/p2371-2180_defconfig b/configs/p2371-2180_defconfig
index 1815b24a4b7..fdbe87574d5 100644
--- a/configs/p2371-2180_defconfig
+++ b/configs/p2371-2180_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/p2571_defconfig b/configs/p2571_defconfig
index a8f80486791..4fd72ffbbf4 100644
--- a/configs/p2571_defconfig
+++ b/configs/p2571_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/p2771-0000-000_defconfig b/configs/p2771-0000-000_defconfig
index 21937a0decf..462bec3bae2 100644
--- a/configs/p2771-0000-000_defconfig
+++ b/configs/p2771-0000-000_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA186_BPMP_I2C=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/p2771-0000-500_defconfig b/configs/p2771-0000-500_defconfig
index 4cd32e60a99..42043277e2d 100644
--- a/configs/p2771-0000-500_defconfig
+++ b/configs/p2771-0000-500_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA186_BPMP_I2C=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
index 22afce410e8..492f1e29c8a 100644
--- a/configs/paz00_defconfig
+++ b/configs/paz00_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
index e37e3eca651..8ee6ed73adc 100644
--- a/configs/phycore_am62ax_r5_defconfig
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -65,7 +65,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
index e8a47f8cbf6..11cf01ee0ef 100644
--- a/configs/picasso_defconfig
+++ b/configs/picasso_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x11000000
diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index 0088580513e..3f85890bdbd 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 7864fc50773..414bfdebab1 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -32,7 +32,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index b0da941e9ce..12d92067de5 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -31,7 +31,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 8dcf8e35ee0..fefe356ed2b 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -19,7 +19,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_REMOTEPROC_RENESAS_APMU=y
 CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BITBANGMII=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 5b9ad93a596..33009429315 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -14,7 +14,7 @@ CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779h0-gray
 CONFIG_DEFAULT_FDT_FILE="r8a779h0-gray-hawk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BITBANGMII=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 61183be948a..15ec0a45901 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -38,7 +38,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index dab1c9a7353..41bdee19682 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -33,7 +33,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index f9847de261d..e7c0a7e1eae 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -42,7 +42,7 @@ CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 5e19d365027..0b91337b17b 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -23,7 +23,7 @@ CONFIG_OF_LIST="renesas/r8a774a1-beacon-rzg2m-kit renesas/r8a774b1-beacon-rzg2n-
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DM_PCA953X=y
 CONFIG_SYS_I2C_RCAR_I2C=y
 CONFIG_SYS_I2C_RCAR_IIC=y
diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
index 5e04090ef2b..d3611591e57 100644
--- a/configs/seaboard_defconfig
+++ b/configs/seaboard_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA_KEYBOARD=y
 CONFIG_MTD_RAW_NAND=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 65f7e8c212c..bebe6870da4 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 90f7a6fbf27..b7de10d71a9 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
diff --git a/configs/star_defconfig b/configs/star_defconfig
index 1ba3c00b063..a783fd86c74 100644
--- a/configs/star_defconfig
+++ b/configs/star_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x11000000
diff --git a/configs/stm32mp13_dhcor_defconfig b/configs/stm32mp13_dhcor_defconfig
index 2357692c4c4..e5aaadd3920 100644
--- a/configs/stm32mp13_dhcor_defconfig
+++ b/configs/stm32mp13_dhcor_defconfig
@@ -35,7 +35,7 @@ CONFIG_CLK_SCMI=y
 CONFIG_SET_DFU_ALT_INFO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_ENV_MMC_DEVICE_INDEX=0
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_REGULATOR_SCMI=y
 CONFIG_RESET_SCMI=y
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
index 71ee397d55a..4cd543ccb9c 100644
--- a/configs/surface-rt_defconfig
+++ b/configs/surface-rt_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index efc3f195c1b..070dce234d6 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -69,7 +69,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
diff --git a/configs/tec-ng_defconfig b/configs/tec-ng_defconfig
index fd8e96dfb09..39fb127ce35 100644
--- a/configs/tec-ng_defconfig
+++ b/configs/tec-ng_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SYS_NS16550=y
diff --git a/configs/tegratab_defconfig b/configs/tegratab_defconfig
index 93c9841e35f..00a0843d4d0 100644
--- a/configs/tegratab_defconfig
+++ b/configs/tegratab_defconfig
@@ -53,7 +53,7 @@ CONFIG_TEGRA_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/tf701t_defconfig b/configs/tf701t_defconfig
index 620f8539273..a9976bf0388 100644
--- a/configs/tf701t_defconfig
+++ b/configs/tf701t_defconfig
@@ -53,7 +53,7 @@ CONFIG_TEGRA_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x91000000
diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index 0e7f1813dc1..dd6815d3465 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -89,7 +89,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index bbda38b2a3b..b4cc4130217 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x11000000
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index b1ebd9b9012..eb3e41e68c5 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -56,7 +56,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_CLK_GPIO=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index 7792da7b90e..acfab5755ba 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -54,7 +54,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_OF_LIST="armada-3720-turris-mox armada-3720-ripe-atlas"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NETCONSOLE=y
diff --git a/configs/venice2_defconfig b/configs/venice2_defconfig
index 9e201bfbf41..810dc3f523f 100644
--- a/configs/venice2_defconfig
+++ b/configs/venice2_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/ventana_defconfig b/configs/ventana_defconfig
index f94c6cf6623..5fa952f98a5 100644
--- a/configs/ventana_defconfig
+++ b/configs/ventana_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 49431f503c6..4b8e7d9f490 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -89,7 +89,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index a9a18def354..e782ad4faca 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -92,7 +92,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 66c0d944208..7db6e81ee6d 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -84,7 +84,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index c2f78a9e90f..4cc69de041b 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -97,7 +97,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index 7a7e45c65de..e65d0fb9ef2 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index e593a542239..3081d1203cf 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_BUTTON=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14526=y
diff --git a/env/Kconfig b/env/Kconfig
index 1decdd89648..3317f3c5603 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -219,7 +219,7 @@ config ENV_IS_IN_MMC
 
 	  Specifies which MMC device the environment is stored in.
 
-	  CONFIG_SYS_MMC_ENV_PART (optional):
+	  CONFIG_ENV_MMC_EMMC_HW_PARTITION (optional):
 
 	  Specifies which MMC partition the environment is stored in. If not
 	  set, defaults to partition 0, the user area. Common values might be
@@ -252,7 +252,7 @@ config ENV_IS_IN_MMC
 	  This value may also be positive or negative; this is handled in the
 	  same way as CONFIG_ENV_OFFSET.
 
-	  In case CONFIG_SYS_MMC_ENV_PART is 1 (i.e. environment in eMMC boot
+	  In case CONFIG_ENV_MMC_EMMC_HW_PARTITION is 1 (i.e. environment in eMMC boot
 	  partition) then setting CONFIG_ENV_OFFSET_REDUND to the same value
 	  as CONFIG_ENV_OFFSET makes use of the second eMMC boot partition for
 	  the redundant environment copy.
@@ -708,8 +708,8 @@ config ENV_MMC_DEVICE_INDEX
 	  The index is often derived from DT aliases mmcN node ordering, and
 	  matches the 'mmc list' command output.
 
-config SYS_MMC_ENV_PART
-	int "mmc partition number"
+config ENV_MMC_EMMC_HW_PARTITION
+	int "eMMC hardware partition number"
 	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT
 	default 0
 	help
diff --git a/env/mmc.c b/env/mmc.c
index dba99bd4d3d..5d1cb78e5ca 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -157,7 +157,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	int hwpart = 0;
 	int err;
 
-#if defined(CONFIG_SYS_MMC_ENV_PART)
+#if defined(CONFIG_ENV_MMC_EMMC_HW_PARTITION)
 	hwpart = mmc_get_env_part(mmc);
 #endif
 
@@ -216,7 +216,7 @@ static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
 	if (!IS_ENABLED(CONFIG_ENV_REDUNDANT))
 		return false;
 
-	if (CONFIG_SYS_MMC_ENV_PART != 1)
+	if (CONFIG_ENV_MMC_EMMC_HW_PARTITION != 1)
 		return false;
 
 	return mmc_offset(mmc, 0) == mmc_offset(mmc, 1);
@@ -239,10 +239,10 @@ __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
 	return 0;
 }
 
-#ifdef CONFIG_SYS_MMC_ENV_PART
+#ifdef CONFIG_ENV_MMC_EMMC_HW_PARTITION
 __weak uint mmc_get_env_part(struct mmc *mmc)
 {
-	return CONFIG_SYS_MMC_ENV_PART;
+	return CONFIG_ENV_MMC_EMMC_HW_PARTITION;
 }
 
 static unsigned char env_mmc_orig_hwpart;
diff --git a/include/mmc.h b/include/mmc.h
index 87f7ef131b6..c6b2ab4a29f 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -996,7 +996,7 @@ void board_mmc_power_init(void);
 int board_mmc_init(struct bd_info *bis);
 int cpu_mmc_init(struct bd_info *bis);
 int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr);
-# ifdef CONFIG_SYS_MMC_ENV_PART
+# ifdef CONFIG_ENV_MMC_EMMC_HW_PARTITION
 extern uint mmc_get_env_part(struct mmc *mmc);
 # endif
 int mmc_get_env_dev(void);
-- 
2.47.2

