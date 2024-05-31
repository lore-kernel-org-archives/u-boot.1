Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CEEC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAA8887E2;
	Fri, 31 May 2024 18:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="poqFfz+X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Atm/okcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720AE887EF; Fri, 31 May 2024 18:47:59 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C937887DD
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 18:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VrTZM6xfKz9sTN;
 Fri, 31 May 2024 18:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717174076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DKK6eCpYqZ9siSF9dORF3/i9CPehvss9s7sAuNTMfE=;
 b=poqFfz+XvaSjqgCHed+c/84oQQJ0zVP1md8Az4oZjVgwm2gMVMjrn3LfbQ1xsFzvD/PB0W
 nO6olAGfRvU53VzYHFdzCvmYEGpaF9uOAC13VncX7w5r6KP7JTNBuoALiIqhxN4zMP6Aof
 KDrfnropd+GbCjTcwt0GuI9YLA6nfJT6MZpZVZvCne8wLqWVGVrJmNPYZoGWCv1fLvrw5M
 cA5e4uWbRRjrYSeaHnrCpj5Y0f9IyhLYqGUReFqdV6d/DSyBrH3ictMf4UmcAd/Mu6/i2K
 1GhCQxeqhUZ3HBh+vTRrCfaaMBk1xn+NKiwBPjQc/uJyil0T84eYuUL4bK/F0A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717174074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DKK6eCpYqZ9siSF9dORF3/i9CPehvss9s7sAuNTMfE=;
 b=Atm/okcXRXAhbLqsGmK4qC9q8DciYvyfp2uGP1KWxmLSkSz9UG1BPO2LxWqjyMSddsl2ef
 jLPbyxv+msBMBpJzaLc94/3K5Xvw9sL7FOzNRZMtmvLIyeGqPPDuLeZ81OfstYFLBHJ8xX
 XEXYIy/hx+INL4xP+F151PX2qqEF424ejZ+tneD8cBSPXVji2J6kKHv8YBmf2mLLWljRtM
 dCIEdGi4bWPV6cT0NF9uafr3vgAbU7fkXR53GWGZ8XmJ+dtWS14Uw+0Wts3Jv9eV/62iqU
 m369hQsMnrjngDG0hCPsdu4unqjabz/+00g3LDBAO8cEX1G2oHu/JaGQ13BMkg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] net: phy: Replace PHY_ANEG_TIMEOUT with Kconfig symbol
Date: Fri, 31 May 2024 18:47:17 +0200
Message-ID: <20240531164733.192105-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c78f1c6c3e19da22b36
X-MBO-RS-META: dfygma31hf37zjb6hwftjnpqnqaaai4w
X-Rspamd-Queue-Id: 4VrTZM6xfKz9sTN
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

Switch PHY_ANEG_TIMEOUT to CONFIG_PHY_ANEG_TIMEOUT Kconfig symbol.
This removes one more configuration headers option finalizes its
Kconfig symbol conversion. No functional change expected.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/am43xx_evm_defconfig                  | 1 +
 configs/am43xx_evm_qspiboot_defconfig         | 1 +
 configs/am43xx_evm_rtconly_defconfig          | 1 +
 configs/am43xx_evm_usbhost_boot_defconfig     | 1 +
 configs/am43xx_hs_evm_defconfig               | 1 +
 configs/am43xx_hs_evm_qspi_defconfig          | 1 +
 configs/am57xx_evm_defconfig                  | 1 +
 configs/am57xx_hs_evm_defconfig               | 1 +
 configs/am57xx_hs_evm_usb_defconfig           | 1 +
 configs/apalis_imx6_defconfig                 | 1 +
 configs/clearfog_defconfig                    | 1 +
 configs/clearfog_sata_defconfig               | 1 +
 configs/clearfog_spi_defconfig                | 1 +
 configs/controlcenterdc_defconfig             | 1 +
 configs/db-88f6720_defconfig                  | 1 +
 configs/db-88f6820-amc_defconfig              | 1 +
 configs/db-88f6820-amc_nand_defconfig         | 1 +
 configs/db-88f6820-gp_defconfig               | 1 +
 configs/db-mv784mp-gp_defconfig               | 1 +
 configs/ds116_defconfig                       | 1 +
 configs/ds414_defconfig                       | 1 +
 configs/helios4_defconfig                     | 1 +
 configs/hihope_rzg2_defconfig                 | 1 +
 configs/hmibsc_defconfig                      | 2 ++
 configs/imx8mm-mx8menlo_defconfig             | 1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig   | 1 +
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig | 1 +
 configs/imx8mp_beacon_defconfig               | 1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig   | 1 +
 configs/imx8mp_debix_model_a_defconfig        | 1 +
 configs/imx8mp_dhcom_pdk2_defconfig           | 1 +
 configs/imx8mp_dhcom_pdk3_defconfig           | 1 +
 configs/imx8mp_evk_defconfig                  | 1 +
 configs/imx8mp_rsb3720a1_4G_defconfig         | 1 +
 configs/imx8mp_rsb3720a1_6G_defconfig         | 1 +
 configs/imx8ulp_evk_defconfig                 | 1 +
 configs/imx93_11x11_evk_defconfig             | 1 +
 configs/imx93_11x11_evk_ld_defconfig          | 1 +
 configs/imx93_var_som_defconfig               | 1 +
 configs/k2g_evm_defconfig                     | 1 +
 configs/k2g_hs_evm_defconfig                  | 1 +
 configs/kontron_pitx_imx8m_defconfig          | 1 +
 configs/lion-rk3368_defconfig                 | 1 +
 configs/maxbcm_defconfig                      | 1 +
 configs/msc_sm2s_imx8mp_defconfig             | 1 +
 configs/n2350_defconfig                       | 1 +
 configs/octeon_ebb7304_defconfig              | 1 +
 configs/r8a77970_eagle_defconfig              | 1 +
 configs/r8a77970_v3msk_defconfig              | 1 +
 configs/r8a77980_condor_defconfig             | 1 +
 configs/r8a77980_v3hsk_defconfig              | 1 +
 configs/r8a77990_ebisu_defconfig              | 1 +
 configs/r8a77995_draak_defconfig              | 1 +
 configs/r8a779a0_falcon_defconfig             | 1 +
 configs/r8a779f0_spider_defconfig             | 1 +
 configs/r8a779g0_whitehawk_defconfig          | 1 +
 configs/r8a779h0_grayhawk_defconfig           | 1 +
 configs/rcar3_salvator-x_defconfig            | 1 +
 configs/rcar3_ulcb_defconfig                  | 1 +
 configs/rzg2_beacon_defconfig                 | 1 +
 configs/silinux_ek874_defconfig               | 1 +
 configs/socfpga_sr1500_defconfig              | 1 +
 configs/stm32mp15_dhcom_basic_defconfig       | 1 +
 configs/stm32mp15_dhcor_basic_defconfig       | 1 +
 configs/theadorable_debug_defconfig           | 1 +
 configs/turris_omnia_defconfig                | 1 +
 configs/xilinx_versal_net_virt_defconfig      | 1 +
 configs/xilinx_versal_virt_defconfig          | 1 +
 configs/xilinx_zynqmp_kria_defconfig          | 1 +
 configs/xilinx_zynqmp_virt_defconfig          | 1 +
 drivers/net/phy/aquantia.c                    | 4 ++--
 drivers/net/phy/phy.c                         | 2 +-
 drivers/net/xilinx_axi_emac.c                 | 2 +-
 include/configs/am43xx_evm.h                  | 2 --
 include/configs/am57xx_evm.h                  | 1 -
 include/configs/apalis_imx6.h                 | 1 -
 include/configs/clearfog.h                    | 2 --
 include/configs/controlcenterdc.h             | 2 --
 include/configs/db-88f6720.h                  | 2 --
 include/configs/db-88f6820-amc.h              | 2 --
 include/configs/db-88f6820-gp.h               | 2 --
 include/configs/db-mv784mp-gp.h               | 2 --
 include/configs/ds116.h                       | 2 --
 include/configs/ds414.h                       | 1 -
 include/configs/helios4.h                     | 2 --
 include/configs/hmibsc.h                      | 1 -
 include/configs/imx8mm-mx8menlo.h             | 1 -
 include/configs/imx8mm_data_modul_edm_sbc.h   | 1 -
 include/configs/imx8mp_beacon.h               | 4 ----
 include/configs/imx8mp_data_modul_edm_sbc.h   | 1 -
 include/configs/imx8mp_debix_model_a.h        | 2 --
 include/configs/imx8mp_dhcom_pdk2.h           | 1 -
 include/configs/imx8mp_evk.h                  | 2 --
 include/configs/imx8mp_icore_mx8mp.h          | 2 --
 include/configs/imx8mp_rsb3720.h              | 2 --
 include/configs/imx8ulp_evk.h                 | 2 --
 include/configs/imx93_evk.h                   | 4 ----
 include/configs/imx93_var_som.h               | 4 ----
 include/configs/k2g_evm.h                     | 1 -
 include/configs/kontron_pitx_imx8m.h          | 2 --
 include/configs/lion_rk3368.h                 | 1 -
 include/configs/maxbcm.h                      | 2 --
 include/configs/msc_sm2s_imx8mp.h             | 1 -
 include/configs/n2350.h                       | 2 --
 include/configs/octeon_ebb7304.h              | 2 --
 include/configs/rcar-gen3-common.h            | 4 ----
 include/configs/rcar-gen4-common.h            | 1 -
 include/configs/socfpga_sr1500.h              | 1 -
 include/configs/stm32mp15_dh_dhsom.h          | 1 -
 include/configs/theadorable.h                 | 2 --
 include/configs/turris_omnia.h                | 2 --
 include/configs/x530.h                        | 2 --
 include/configs/xilinx_versal.h               | 3 ---
 include/configs/xilinx_versal_net.h           | 3 ---
 include/configs/xilinx_zynqmp.h               | 3 ---
 include/phy.h                                 | 4 ----
 116 files changed, 75 insertions(+), 89 deletions(-)

diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index e1f0ab4e472..d73b1cb804b 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -74,6 +74,7 @@ CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
 CONFIG_SYS_NAND_U_BOOT_OFFS=0x180000
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index ea5b69f58e0..89e212595af 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -50,6 +50,7 @@ CONFIG_DFU_SF=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_POWER_TPS65218=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 89411324720..2ff01193285 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -64,6 +64,7 @@ CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
 CONFIG_SYS_NAND_U_BOOT_OFFS=0x180000
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index bf8cdba189e..845b686ac93 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -77,6 +77,7 @@ CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
 CONFIG_SYS_NAND_U_BOOT_OFFS=0x180000
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index 8a7a3dfbd66..ff5073cbb2b 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -70,6 +70,7 @@ CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
 CONFIG_SYS_NAND_U_BOOT_OFFS=0x180000
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index ebfad6a9c52..5ef59d830e5 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -51,6 +51,7 @@ CONFIG_DFU_SF=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_POWER_TPS65218=y
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index bfa78f0e100..7c3ceeb07db 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -94,6 +94,7 @@ CONFIG_HSMMC2_8BIT=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_MII=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 7be94aef27a..1f7eca4691e 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -90,6 +90,7 @@ CONFIG_HSMMC2_8BIT=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_MII=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 055e29b43d8..807e1d66a6d 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -88,6 +88,7 @@ CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_MII=y
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index e8dc60c6ce1..6d70cc201c7 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -99,6 +99,7 @@ CONFIG_SYS_MXC_I2C3_SPEED=400000
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=15000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_FEC_MXC=y
diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
index 9bbc723f9c7..62dbf2aa48f 100644
--- a/configs/clearfog_defconfig
+++ b/configs/clearfog_defconfig
@@ -64,6 +64,7 @@ CONFIG_MMC_SDHCI_MV=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defconfig
index 9ddd5d295fe..41382f995d3 100644
--- a/configs/clearfog_sata_defconfig
+++ b/configs/clearfog_sata_defconfig
@@ -65,6 +65,7 @@ CONFIG_MMC_SDHCI_MV=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
index 4175fdb17a1..f345b12e6c7 100644
--- a/configs/clearfog_spi_defconfig
+++ b/configs/clearfog_spi_defconfig
@@ -65,6 +65,7 @@ CONFIG_MMC_SDHCI_MV=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/controlcenterdc_defconfig b/configs/controlcenterdc_defconfig
index cf7499bb16f..6fe9750841f 100644
--- a/configs/controlcenterdc_defconfig
+++ b/configs/controlcenterdc_defconfig
@@ -85,6 +85,7 @@ CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/db-88f6720_defconfig b/configs/db-88f6720_defconfig
index 33b8b806652..22a1e834247 100644
--- a/configs/db-88f6720_defconfig
+++ b/configs/db-88f6720_defconfig
@@ -64,6 +64,7 @@ CONFIG_MISC=y
 # CONFIG_MMC is not set
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVPP2=y
diff --git a/configs/db-88f6820-amc_defconfig b/configs/db-88f6820-amc_defconfig
index 540a348fdcf..a6c862234a0 100644
--- a/configs/db-88f6820-amc_defconfig
+++ b/configs/db-88f6820-amc_defconfig
@@ -71,6 +71,7 @@ CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/db-88f6820-amc_nand_defconfig b/configs/db-88f6820-amc_nand_defconfig
index 4d4cf36749a..54457820568 100644
--- a/configs/db-88f6820-amc_nand_defconfig
+++ b/configs/db-88f6820-amc_nand_defconfig
@@ -75,6 +75,7 @@ CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/db-88f6820-gp_defconfig b/configs/db-88f6820-gp_defconfig
index 4f98ee4f382..ee8cb8ae66c 100644
--- a/configs/db-88f6820-gp_defconfig
+++ b/configs/db-88f6820-gp_defconfig
@@ -68,6 +68,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/db-mv784mp-gp_defconfig b/configs/db-mv784mp-gp_defconfig
index d776693b600..f10a6fbccab 100644
--- a/configs/db-mv784mp-gp_defconfig
+++ b/configs/db-mv784mp-gp_defconfig
@@ -70,6 +70,7 @@ CONFIG_NAND_PXA3XX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
index 1fc73802160..56bd56b1aaf 100644
--- a/configs/ds116_defconfig
+++ b/configs/ds116_defconfig
@@ -71,6 +71,7 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
index ecf9501ba5a..18c741d4f28 100644
--- a/configs/ds414_defconfig
+++ b/configs/ds414_defconfig
@@ -68,6 +68,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ANEG_TIMEOUT=16000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index c4c5d48f4eb..29b6230e901 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -64,6 +64,7 @@ CONFIG_MMC_SDHCI_MV=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index 149ce0bac0d..fc412d04ac7 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -68,6 +68,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index a07689894ef..b92488587d8 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -61,6 +61,8 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 68b24ce3fb0..5e6bbb3e508 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -124,6 +124,7 @@ CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_PHY_FIXED=y
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index 53249f44a4e..f26a8791cd0 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -193,6 +193,7 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ATHEROS=y
 CONFIG_PHY_BROADCOM=y
 CONFIG_DM_MDIO=y
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index 3a622727232..05f68c7e2ae 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -87,6 +87,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index b0dcbc723ba..3c337d4bd25 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -113,6 +113,7 @@ CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_ATMEL=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index 209d896b00c..fe3e757eefd 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -206,6 +206,7 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ATHEROS=y
 CONFIG_PHY_BROADCOM=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/imx8mp_debix_model_a_defconfig b/configs/imx8mp_debix_model_a_defconfig
index 70126c961f3..aa1de6d6909 100644
--- a/configs/imx8mp_debix_model_a_defconfig
+++ b/configs/imx8mp_debix_model_a_defconfig
@@ -76,6 +76,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index 76f2fe8fcc9..5944c6c5304 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -201,6 +201,7 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_PHY_SMSC=y
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 5b338f22195..7b3dae504f8 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -208,6 +208,7 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_PHY_SMSC=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index d907aedb05a..f5ba022b075 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -93,6 +93,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index 393a1316cd9..54789365aa9 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -126,6 +126,7 @@ CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index 6dd51a3f1fc..4b0b71d03d9 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -127,6 +127,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index 721c4cb9d11..b302df1f351 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -74,6 +74,7 @@ CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_FEC_MXC=y
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 5ad770f91e1..2246715d822 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -98,6 +98,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/imx93_11x11_evk_ld_defconfig b/configs/imx93_11x11_evk_ld_defconfig
index abda6d12662..deed068550a 100644
--- a/configs/imx93_11x11_evk_ld_defconfig
+++ b/configs/imx93_11x11_evk_ld_defconfig
@@ -95,6 +95,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index e39d7dc5e88..94ce213f93a 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -112,6 +112,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ADIN=y
 CONFIG_PHY_ATHEROS=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
index 88965e273e2..5d54d75f974 100644
--- a/configs/k2g_evm_defconfig
+++ b/configs/k2g_evm_defconfig
@@ -81,6 +81,7 @@ CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=10000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
diff --git a/configs/k2g_hs_evm_defconfig b/configs/k2g_hs_evm_defconfig
index 3a45c41ef74..9adab3af305 100644
--- a/configs/k2g_hs_evm_defconfig
+++ b/configs/k2g_hs_evm_defconfig
@@ -57,6 +57,7 @@ CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=10000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index e2a87c4a81d..c2133470fc9 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -83,6 +83,7 @@ CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_TI=y
 CONFIG_PHY_GIGE=y
 CONFIG_FEC_MXC=y
diff --git a/configs/lion-rk3368_defconfig b/configs/lion-rk3368_defconfig
index a4a7f1a5cbd..868eeaf6c8e 100644
--- a/configs/lion-rk3368_defconfig
+++ b/configs/lion-rk3368_defconfig
@@ -77,6 +77,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MSCC=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/maxbcm_defconfig b/configs/maxbcm_defconfig
index 9906099e8c5..51a9d0f4f68 100644
--- a/configs/maxbcm_defconfig
+++ b/configs/maxbcm_defconfig
@@ -53,6 +53,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index dc5a45fb0d8..2e1d112a3e7 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -85,6 +85,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_TI=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
index 5e13d2cb768..e7d7deabfe6 100644
--- a/configs/n2350_defconfig
+++ b/configs/n2350_defconfig
@@ -75,6 +75,7 @@ CONFIG_NAND_PXA3XX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/octeon_ebb7304_defconfig b/configs/octeon_ebb7304_defconfig
index 00fcd57f929..cb711f0ad4c 100644
--- a/configs/octeon_ebb7304_defconfig
+++ b/configs/octeon_ebb7304_defconfig
@@ -63,6 +63,7 @@ CONFIG_SPI_FLASH_ATMEL=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 09ea1c54f13..0c4b1eed567 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -67,6 +67,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 089c7544e5e..ab49d547d38 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -72,6 +72,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index 9f5212f93d8..1e7e430cd8b 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -75,6 +75,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
index 8c85f42ed42..e942acd83a8 100644
--- a/configs/r8a77980_v3hsk_defconfig
+++ b/configs/r8a77980_v3hsk_defconfig
@@ -68,6 +68,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 3960a250d9e..7418d390d1d 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -89,6 +89,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 01f5b135959..29d921d16c4 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -86,6 +86,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index 40097f9dc34..7dbd1457d87 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -61,6 +61,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 9ab46a4d5e0..e822e95eb81 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -64,6 +64,7 @@ CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHYLIB_10G=y
 CONFIG_PHY_MARVELL_10G=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index abc9a3ba611..a0abc45b72a 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -60,6 +60,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index a986a09b8e0..6cbe27a316d 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -60,6 +60,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 45d2446b8a1..318a9ab03e6 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -92,6 +92,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index b5d81219246..f8e8c92b670 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -90,6 +90,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_ETH_PHY=y
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 4aabb1fe03e..ac61656530f 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -65,6 +65,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ATHEROS=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index 4c6009dbe45..d1b1c03cf4c 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -68,6 +68,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_REALTEK=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index 603b74401ea..c415248bb6e 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -67,6 +67,7 @@ CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index 8442f0bfe94..c3e6b097db0 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -133,6 +133,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_DWC_ETH_QOS=y
 CONFIG_KS8851_MLL=y
 CONFIG_PHY=y
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index 91b64f7537a..1eac11b5a44 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -131,6 +131,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DWC_ETH_QOS=y
diff --git a/configs/theadorable_debug_defconfig b/configs/theadorable_debug_defconfig
index ed468b8fe9a..d237092bb96 100644
--- a/configs/theadorable_debug_defconfig
+++ b/configs/theadorable_debug_defconfig
@@ -78,6 +78,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
 CONFIG_MVNETA=y
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 9753e270951..225a76f993d 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -96,6 +96,7 @@ CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_FIXED=y
 CONFIG_DM_DSA=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 40c6a29a16e..4207974dbdd 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -101,6 +101,7 @@ CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_NATSEMI=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index c9b8a6de013..06c192ce9d0 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -102,6 +102,7 @@ CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ADIN=y
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_NATSEMI=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index ba42f0c7848..8c6032532a2 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -158,6 +158,7 @@ CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ADIN=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_XILINX_GMII2RGMII=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index ee87beb19c6..89187972fec 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -169,6 +169,7 @@ CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ADIN=y
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_MICREL=y
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 4517a6b13ba..d2db8d9f792 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -566,9 +566,9 @@ int aquantia_startup(struct phy_device *phydev)
 			if ((i++ % 500) == 0)
 				printf(".");
 		} while (!aquantia_link_is_up(phydev) &&
-			 i < (4 * PHY_ANEG_TIMEOUT));
+			 i < (4 * CONFIG_PHY_ANEG_TIMEOUT));
 
-		if (i > PHY_ANEG_TIMEOUT)
+		if (i > CONFIG_PHY_ANEG_TIMEOUT)
 			printf(" TIMEOUT !\n");
 	}
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fbf85d90f54..716a1d46111 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -250,7 +250,7 @@ int genphy_update_link(struct phy_device *phydev)
 			/*
 			 * Timeout reached ?
 			 */
-			if (i > (PHY_ANEG_TIMEOUT / 50)) {
+			if (i > (CONFIG_PHY_ANEG_TIMEOUT / 50)) {
 				printf(" TIMEOUT !\n");
 				phydev->link = 0;
 				return -ETIMEDOUT;
diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index a1a39f61488..4d87e2d1f36 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -361,7 +361,7 @@ static int pcs_pma_startup(struct axidma_priv *priv)
 	 * and the external PHY is not obtained.
 	 */
 	debug("axiemac: waiting for link status of the PCS/PMA PHY");
-	while (retry_cnt * 10 < PHY_ANEG_TIMEOUT) {
+	while (retry_cnt * 10 < CONFIG_PHY_ANEG_TIMEOUT) {
 		rc = phyread(priv, priv->pcsaddr, MII_BMSR, &mii_reg);
 		if ((mii_reg & BMSR_LSTATUS) && mii_reg != 0xffff && !rc) {
 			debug(".Done\n");
diff --git a/include/configs/am43xx_evm.h b/include/configs/am43xx_evm.h
index 983428920fa..87ffa769d15 100644
--- a/include/configs/am43xx_evm.h
+++ b/include/configs/am43xx_evm.h
@@ -102,8 +102,6 @@
 
 #endif
 
-#define PHY_ANEG_TIMEOUT	8000 /* PHY needs longer aneg time at 1G */
-
 /* NAND support */
 #ifdef CONFIG_MTD_RAW_NAND
 /* NAND: device related configs */
diff --git a/include/configs/am57xx_evm.h b/include/configs/am57xx_evm.h
index 06edde69028..4b4362ccfd8 100644
--- a/include/configs/am57xx_evm.h
+++ b/include/configs/am57xx_evm.h
@@ -36,7 +36,6 @@
 #include <configs/ti_omap5_common.h>
 
 /* CPSW Ethernet */
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs longer aneg time at 1G */
 
 /*
  * Default to using SPI for environment, etc.
diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx6.h
index 0df3917e200..6fd43511ee4 100644
--- a/include/configs/apalis_imx6.h
+++ b/include/configs/apalis_imx6.h
@@ -22,7 +22,6 @@
 #define CFG_SYS_FSL_USDHC_NUM	3
 
 /* Network */
-#define PHY_ANEG_TIMEOUT		15000 /* PHY needs longer aneg time */
 
 /* USB Configs */
 /* Host */
diff --git a/include/configs/clearfog.h b/include/configs/clearfog.h
index 062d3d87026..7c7ada15bd9 100644
--- a/include/configs/clearfog.h
+++ b/include/configs/clearfog.h
@@ -26,8 +26,6 @@
  * image and environment
  */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* Keep device tree and initrd in lower memory so the kernel can access them */
 #define RELOCATION_LIMITS_ENV_SETTINGS	\
 	"fdt_high=0x10000000\0"		\
diff --git a/include/configs/controlcenterdc.h b/include/configs/controlcenterdc.h
index 0e922b96644..1ba63b22d59 100644
--- a/include/configs/controlcenterdc.h
+++ b/include/configs/controlcenterdc.h
@@ -15,8 +15,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /*
  * Environment Configuration
  */
diff --git a/include/configs/db-88f6720.h b/include/configs/db-88f6720.h
index 54de2d0d833..cf00217a9ee 100644
--- a/include/configs/db-88f6720.h
+++ b/include/configs/db-88f6720.h
@@ -23,8 +23,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /*
  * mv-common.h should be defined after CMD configs since it used them
  * to enable certain macros
diff --git a/include/configs/db-88f6820-amc.h b/include/configs/db-88f6820-amc.h
index c4ae397e3e6..b174b0db66a 100644
--- a/include/configs/db-88f6820-amc.h
+++ b/include/configs/db-88f6820-amc.h
@@ -12,8 +12,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* NAND */
 
 /* Keep device tree and initrd in lower memory so the kernel can access them */
diff --git a/include/configs/db-88f6820-gp.h b/include/configs/db-88f6820-gp.h
index 2cbe4eb440b..4ac1f3cffd9 100644
--- a/include/configs/db-88f6820-gp.h
+++ b/include/configs/db-88f6820-gp.h
@@ -15,8 +15,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* Keep device tree and initrd in lower memory so the kernel can access them */
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"fdt_high=0x10000000\0"		\
diff --git a/include/configs/db-mv784mp-gp.h b/include/configs/db-mv784mp-gp.h
index 5c6d7fa1b77..67e62d6f34a 100644
--- a/include/configs/db-mv784mp-gp.h
+++ b/include/configs/db-mv784mp-gp.h
@@ -19,8 +19,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* NAND */
 
 /*
diff --git a/include/configs/ds116.h b/include/configs/ds116.h
index 0883ec4d53b..c2326596811 100644
--- a/include/configs/ds116.h
+++ b/include/configs/ds116.h
@@ -7,8 +7,6 @@
 #ifndef _CONFIG_DS116_H
 #define _CONFIG_DS116_H
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* Keep device tree and initrd in lower memory so the kernel can access them */
 #define RELOCATION_LIMITS_ENV_SETTINGS  \
 	"fdt_high=0x10000000\0"         \
diff --git a/include/configs/ds414.h b/include/configs/ds414.h
index 9446acba792..f1921dac5e7 100644
--- a/include/configs/ds414.h
+++ b/include/configs/ds414.h
@@ -55,6 +55,5 @@
 
 
 /* increase autoneg timeout, my NIC sucks */
-#define PHY_ANEG_TIMEOUT	16000
 
 #endif /* _CONFIG_SYNOLOGY_DS414_H */
diff --git a/include/configs/helios4.h b/include/configs/helios4.h
index 7d81d1cf1e4..a3b6335a541 100644
--- a/include/configs/helios4.h
+++ b/include/configs/helios4.h
@@ -26,8 +26,6 @@
  * image and environment
  */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* Keep device tree and initrd in lower memory so the kernel can access them */
 #define RELOCATION_LIMITS_ENV_SETTINGS	\
 	"fdt_high=0x10000000\0"		\
diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
index 27404c80fdf..950ec8b190d 100644
--- a/include/configs/hmibsc.h
+++ b/include/configs/hmibsc.h
@@ -9,7 +9,6 @@
 #define __CONFIGS_HMIBSC_H
 
 /* PHY needs a longer aneg time */
-#define PHY_ANEG_TIMEOUT		8000
 
 #define CFG_ENV_FLAGS_LIST_STATIC "BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw"
 
diff --git a/include/configs/imx8mm-mx8menlo.h b/include/configs/imx8mm-mx8menlo.h
index 5cc60af91e5..7058d632d67 100644
--- a/include/configs/imx8mm-mx8menlo.h
+++ b/include/configs/imx8mm-mx8menlo.h
@@ -9,7 +9,6 @@
 #include <configs/verdin-imx8mm.h>
 
 /* PHY needs a longer autoneg timeout */
-#define PHY_ANEG_TIMEOUT		20000
 
 /* Custom initial environment variables */
 #undef CFG_EXTRA_ENV_SETTINGS
diff --git a/include/configs/imx8mm_data_modul_edm_sbc.h b/include/configs/imx8mm_data_modul_edm_sbc.h
index b777fe6073b..9a5e5bd009d 100644
--- a/include/configs/imx8mm_data_modul_edm_sbc.h
+++ b/include/configs/imx8mm_data_modul_edm_sbc.h
@@ -28,7 +28,6 @@
 #define CFG_MXC_UART_BASE		UART3_BASE_ADDR
 
 /* PHY needs a longer autonegotiation timeout after reset */
-#define PHY_ANEG_TIMEOUT		20000
 
 /* USDHC */
 #define CFG_SYS_FSL_USDHC_NUM	2
diff --git a/include/configs/imx8mp_beacon.h b/include/configs/imx8mp_beacon.h
index ee0fd07e650..b36dae7c34f 100644
--- a/include/configs/imx8mp_beacon.h
+++ b/include/configs/imx8mp_beacon.h
@@ -10,10 +10,6 @@
 
 #define CFG_SYS_UBOOT_BASE	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#if defined(CONFIG_CMD_NET)
-#define PHY_ANEG_TIMEOUT 20000
-#endif
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
diff --git a/include/configs/imx8mp_data_modul_edm_sbc.h b/include/configs/imx8mp_data_modul_edm_sbc.h
index 8d7954004c2..f953847ce05 100644
--- a/include/configs/imx8mp_data_modul_edm_sbc.h
+++ b/include/configs/imx8mp_data_modul_edm_sbc.h
@@ -21,7 +21,6 @@
 #define CFG_MXC_UART_BASE		UART3_BASE_ADDR
 
 /* PHY needs a longer autonegotiation timeout after reset */
-#define PHY_ANEG_TIMEOUT		20000
 #define FEC_QUIRK_ENET_MAC
 
 #define CFG_EXTRA_ENV_SETTINGS						\
diff --git a/include/configs/imx8mp_debix_model_a.h b/include/configs/imx8mp_debix_model_a.h
index e82e8b16b1d..14b91100947 100644
--- a/include/configs/imx8mp_debix_model_a.h
+++ b/include/configs/imx8mp_debix_model_a.h
@@ -16,8 +16,6 @@
 #if defined(CONFIG_CMD_NET)
 #define CFG_FEC_MXC_PHYADDR          1
 
-#define PHY_ANEG_TIMEOUT 20000
-
 #endif
 
 #define BOOT_TARGET_DEVICES(func) \
diff --git a/include/configs/imx8mp_dhcom_pdk2.h b/include/configs/imx8mp_dhcom_pdk2.h
index ea32fe11a52..c848fce8bda 100644
--- a/include/configs/imx8mp_dhcom_pdk2.h
+++ b/include/configs/imx8mp_dhcom_pdk2.h
@@ -21,7 +21,6 @@
 #define CFG_MXC_UART_BASE		UART1_BASE_ADDR
 
 /* PHY needs a longer autonegotiation timeout after reset */
-#define PHY_ANEG_TIMEOUT		20000
 #define FEC_QUIRK_ENET_MAC
 
 /* USDHC */
diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
index 1759318fdd3..71452aa2833 100644
--- a/include/configs/imx8mp_evk.h
+++ b/include/configs/imx8mp_evk.h
@@ -15,8 +15,6 @@
 #if defined(CONFIG_CMD_NET)
 #define CFG_FEC_MXC_PHYADDR          1
 
-#define PHY_ANEG_TIMEOUT 20000
-
 #endif
 
 #define BOOT_TARGET_DEVICES(func) \
diff --git a/include/configs/imx8mp_icore_mx8mp.h b/include/configs/imx8mp_icore_mx8mp.h
index bbbd91776fe..0a861a107b2 100644
--- a/include/configs/imx8mp_icore_mx8mp.h
+++ b/include/configs/imx8mp_icore_mx8mp.h
@@ -18,8 +18,6 @@
 
 #define DWC_NET_PHYADDR			1
 
-#define PHY_ANEG_TIMEOUT 20000
-
 #endif
 
 #define BOOT_TARGET_DEVICES(func) \
diff --git a/include/configs/imx8mp_rsb3720.h b/include/configs/imx8mp_rsb3720.h
index e577f60ae72..10a166d781e 100644
--- a/include/configs/imx8mp_rsb3720.h
+++ b/include/configs/imx8mp_rsb3720.h
@@ -35,8 +35,6 @@
 #if defined(CONFIG_CMD_NET)
 #define CFG_FEC_MXC_PHYADDR          4
 
-#define PHY_ANEG_TIMEOUT 20000
-
 #endif
 
 #if IS_ENABLED(CONFIG_CMD_MMC)
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index d77510e1685..750aef1b597 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -19,8 +19,6 @@
 
 /* ENET Config */
 #if defined(CONFIG_FEC_MXC)
-#define PHY_ANEG_TIMEOUT		20000
-
 #define CFG_FEC_MXC_PHYADDR		1
 #endif
 
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index 2705587a015..ce6567e2af6 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -134,8 +134,4 @@
 /* Using ULP WDOG for reset */
 #define WDOG_BASE_ADDR          WDG3_BASE_ADDR
 
-#if defined(CONFIG_CMD_NET)
-#define PHY_ANEG_TIMEOUT 20000
-#endif
-
 #endif
diff --git a/include/configs/imx93_var_som.h b/include/configs/imx93_var_som.h
index 18a8ee5deed..9dc10aea407 100644
--- a/include/configs/imx93_var_som.h
+++ b/include/configs/imx93_var_som.h
@@ -41,8 +41,4 @@
 /* Using ULP WDOG for reset */
 #define WDOG_BASE_ADDR          WDG3_BASE_ADDR
 
-#if defined(CONFIG_CMD_NET)
-#define PHY_ANEG_TIMEOUT 20000
-#endif
-
 #endif
diff --git a/include/configs/k2g_evm.h b/include/configs/k2g_evm.h
index 2f25d393a37..ce7bd6652bb 100644
--- a/include/configs/k2g_evm.h
+++ b/include/configs/k2g_evm.h
@@ -11,7 +11,6 @@
 
 /* Network */
 #define CFG_KSNET_CPSW_NUM_PORTS	2
-#define PHY_ANEG_TIMEOUT	10000 /* PHY needs longer aneg time */
 
 #include <configs/ti_armv7_keystone2.h>
 
diff --git a/include/configs/kontron_pitx_imx8m.h b/include/configs/kontron_pitx_imx8m.h
index 5cf6b5a6dd4..101c59141f7 100644
--- a/include/configs/kontron_pitx_imx8m.h
+++ b/include/configs/kontron_pitx_imx8m.h
@@ -26,8 +26,6 @@
 #if defined(CONFIG_CMD_NET)
 #define CFG_FEC_MXC_PHYADDR          0
 
-#define PHY_ANEG_TIMEOUT		20000
-
 #endif
 
 #define ENV_MEM_LAYOUT_SETTINGS \
diff --git a/include/configs/lion_rk3368.h b/include/configs/lion_rk3368.h
index c5b78f9c896..0d29e1ddc73 100644
--- a/include/configs/lion_rk3368.h
+++ b/include/configs/lion_rk3368.h
@@ -12,6 +12,5 @@
 #define DTB_LOAD_ADDR			0x5600000
 #define INITRD_LOAD_ADDR		0x5bf0000
 /* PHY needs longer aneg time at 1G */
-#define PHY_ANEG_TIMEOUT		8000
 
 #endif
diff --git a/include/configs/maxbcm.h b/include/configs/maxbcm.h
index 413597e09b2..4c2b538f888 100644
--- a/include/configs/maxbcm.h
+++ b/include/configs/maxbcm.h
@@ -25,8 +25,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /*
  * mv-common.h should be defined after CMD configs since it used them
  * to enable certain macros
diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s_imx8mp.h
index 3c7d96cb3c0..1325859b039 100644
--- a/include/configs/msc_sm2s_imx8mp.h
+++ b/include/configs/msc_sm2s_imx8mp.h
@@ -18,7 +18,6 @@
 
 #if defined(CONFIG_CMD_NET)
 #define CFG_FEC_MXC_PHYADDR          1
-#define PHY_ANEG_TIMEOUT 20000
 #endif
 
 #ifndef CONFIG_SPL_BUILD
diff --git a/include/configs/n2350.h b/include/configs/n2350.h
index d8a9814d3e8..f98b9f8582d 100644
--- a/include/configs/n2350.h
+++ b/include/configs/n2350.h
@@ -7,8 +7,6 @@
 #ifndef _CONFIG_N2350_H
 #define _CONFIG_N2350_H
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* Keep device tree and initrd in lower memory so the kernel can access them */
 #define RELOCATION_LIMITS_ENV_SETTINGS  \
 	"fdt_high=0x10000000\0"         \
diff --git a/include/configs/octeon_ebb7304.h b/include/configs/octeon_ebb7304.h
index 5479bdedee5..7d99fd1b019 100644
--- a/include/configs/octeon_ebb7304.h
+++ b/include/configs/octeon_ebb7304.h
@@ -9,6 +9,4 @@
 
 #include "octeon_common.h"
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 #endif /* __CONFIG_H__ */
diff --git a/include/configs/rcar-gen3-common.h b/include/configs/rcar-gen3-common.h
index 5f4d5ced78f..3f0831a901c 100644
--- a/include/configs/rcar-gen3-common.h
+++ b/include/configs/rcar-gen3-common.h
@@ -20,11 +20,7 @@
 /* console */
 #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 38400 }
 
-/* PHY needs a longer autoneg timeout */
-#define PHY_ANEG_TIMEOUT		20000
-
 /* MEMORY */
-
 #define DRAM_RSV_SIZE			0x08000000
 #define CFG_SYS_SDRAM_BASE		(0x40000000 + DRAM_RSV_SIZE)
 #define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
diff --git a/include/configs/rcar-gen4-common.h b/include/configs/rcar-gen4-common.h
index 3465b4d1821..37a37c013df 100644
--- a/include/configs/rcar-gen4-common.h
+++ b/include/configs/rcar-gen4-common.h
@@ -21,7 +21,6 @@
 #define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
 
 /* PHY needs a longer autoneg timeout */
-#define PHY_ANEG_TIMEOUT		20000
 
 /* Environment setting */
 #define CFG_EXTRA_ENV_SETTINGS					\
diff --git a/include/configs/socfpga_sr1500.h b/include/configs/socfpga_sr1500.h
index caff0cf2523..aa33cf48140 100644
--- a/include/configs/socfpga_sr1500.h
+++ b/include/configs/socfpga_sr1500.h
@@ -12,7 +12,6 @@
 
 /* Ethernet on SoC (EMAC) */
 /* The PHY is autodetected, so no MII PHY address is needed here */
-#define PHY_ANEG_TIMEOUT	8000
 
 /* The rest of the configuration is shared */
 #include <configs/socfpga_common.h>
diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index de39b19219d..c1fca8359d2 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -9,7 +9,6 @@
 #define __CONFIG_STM32MP15_DH_DHSOM_H__
 
 /* PHY needs a longer autoneg timeout */
-#define PHY_ANEG_TIMEOUT		20000
 
 #ifdef CONFIG_SPL_BUILD
 #define CFG_EXTRA_ENV_SETTINGS						\
diff --git a/include/configs/theadorable.h b/include/configs/theadorable.h
index 2ce92845f1c..40432c9d6b2 100644
--- a/include/configs/theadorable.h
+++ b/include/configs/theadorable.h
@@ -32,8 +32,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* Keep device tree and initrd in lower memory so the kernel can access them */
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"fdt_high=0x10000000\0"		\
diff --git a/include/configs/turris_omnia.h b/include/configs/turris_omnia.h
index 47b220ff9ee..302194bc90f 100644
--- a/include/configs/turris_omnia.h
+++ b/include/configs/turris_omnia.h
@@ -19,8 +19,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* Keep device tree and initrd in lower memory so the kernel can access them */
 #define RELOCATION_LIMITS_ENV_SETTINGS	\
 	"fdt_high=0x10000000\0"		\
diff --git a/include/configs/x530.h b/include/configs/x530.h
index e1678e79e49..982b1292873 100644
--- a/include/configs/x530.h
+++ b/include/configs/x530.h
@@ -40,8 +40,6 @@
 
 /* Environment in SPI NOR flash */
 
-#define PHY_ANEG_TIMEOUT	8000	/* PHY needs a longer aneg time */
-
 /* NAND */
 
 #include <asm/arch/config.h>
diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
index b634bb1ab70..dc3f41b94a2 100644
--- a/include/configs/xilinx_versal.h
+++ b/include/configs/xilinx_versal.h
@@ -28,9 +28,6 @@
 #endif
 
 /* Ethernet driver */
-#if defined(CONFIG_ZYNQ_GEM)
-# define PHY_ANEG_TIMEOUT       20000
-#endif
 
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"fdt_addr_r=0x40000000\0" \
diff --git a/include/configs/xilinx_versal_net.h b/include/configs/xilinx_versal_net.h
index 9cb6b2bfea3..2a03f4c0c22 100644
--- a/include/configs/xilinx_versal_net.h
+++ b/include/configs/xilinx_versal_net.h
@@ -42,9 +42,6 @@
 #endif
 
 /* Ethernet driver */
-#if defined(CONFIG_ZYNQ_GEM)
-# define PHY_ANEG_TIMEOUT	20000
-#endif
 
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"fdt_addr_r=0x40000000\0" \
diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index 5bc117e1900..f76b3c6b163 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -45,9 +45,6 @@
 /* Console I/O Buffer Size */
 
 /* Ethernet driver */
-#if defined(CONFIG_ZYNQ_GEM)
-# define PHY_ANEG_TIMEOUT       20000
-#endif
 
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"fdt_addr_r=0x40000000\0" \
diff --git a/include/phy.h b/include/phy.h
index 072ed0961f4..36785031eeb 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -58,10 +58,6 @@ struct udevice;
 #define PHY_10G_FEATURES	(PHY_GBIT_FEATURES | \
 				SUPPORTED_10000baseT_Full)
 
-#ifndef PHY_ANEG_TIMEOUT
-#define PHY_ANEG_TIMEOUT	CONFIG_PHY_ANEG_TIMEOUT
-#endif
-
 struct phy_device;
 
 #define MDIO_NAME_LEN 32
-- 
2.43.0

