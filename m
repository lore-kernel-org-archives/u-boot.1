Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D44E78482
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38A0870F0;
	Sun,  1 Oct 2023 21:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lCq7Jtyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AA3846DF; Sun,  1 Oct 2023 21:18:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C99687105
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696187879; bh=64SlE/flgXo0aPf0tGrEGgx89GKxjooT8J9wP3aDstY=;
 b=lCq7Jtypr7L2L/JjkvGmELWKMZcN/djMIxxUzSgeZNecvtqc78ZTfAMWrAa8sN857TGvNVMKp
 GWO8sPKqn5CJKMqk/r9C56fj3W+EnXiBEsnWtKWXPotsntSpnQoq1Dsi3g3zBad8Dmcc7or8GGP
 KSsIEYlZxlZVu97/KSHjUjrjI50YUkbZnkGxwZFKkbxebkRp3O9bhIoMHJeuk2O+dUIEJULUIp6
 IuMZ6E3mPXoJwncM/h+pV89wAF/6bsHHowOTOj92SdjTfV8VRFEkyAwEAxDdjx68PTOuLsROriu
 o4jJcIiKXwwsLbiRSeMPLT1z5A4HrtrvGo6+sliynJWg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Joseph Chen
 <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>, Tianling Shen
 <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: David Wu <david.wu@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Frank Wunderlich <frank-w@public-files.de>,
 u-boot@lists.denx.de
Subject: [PATCH v2 6/7] configs: rockchip: Enable ethernet driver on RK356x
 boards
Date: Sun,  1 Oct 2023 19:17:21 +0000
Message-ID: <20231001191730.4167035-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001191730.4167035-1-jonas@kwiboo.se>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6519c5e625909c3c56c79dca
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

Enable DWC_ETH_QOS_ROCKCHIP and related PHY driver on RK356x boards that
have an enabled gmac node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Collect r-b tag
- Update evb-rk3568_defconfig changes
- Add lubancat-2-rk3568_defconfig changes

 configs/evb-rk3568_defconfig              | 6 ++++--
 configs/lubancat-2-rk3568_defconfig       | 3 +++
 configs/nanopi-r5s-rk3568_defconfig       | 3 +++
 configs/odroid-m1-rk3568_defconfig        | 3 +++
 configs/quartz64-a-rk3566_defconfig       | 3 +++
 configs/quartz64-b-rk3566_defconfig       | 3 +++
 configs/radxa-cm3-io-rk3566_defconfig     | 6 ++++--
 configs/rock-3a-rk3568_defconfig          | 5 +++--
 configs/soquartz-blade-rk3566_defconfig   | 3 +++
 configs/soquartz-cm4-rk3566_defconfig     | 3 +++
 configs/soquartz-model-a-rk3566_defconfig | 3 +++
 11 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index 5f3fab7304c2..cb9b87ff12cb 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -46,6 +46,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
@@ -58,8 +59,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_RK8XX=y
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index b01d3bd2a1a2..80ae6ec3a2e9 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -61,6 +61,9 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 # CONFIG_SPI_FLASH is not set
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_SPL_PINCTRL=y
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index c278ce083d9a..2736d382a352 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -65,6 +65,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_RTL8169=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index 3dda5c1f9170..96b4e9ecdaff 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -82,6 +82,9 @@ CONFIG_SF_DEFAULT_BUS=4
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index 6853cd6c44b4..bf4d4cd2b8ed 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -81,6 +81,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index aa29fff14643..358687ab5d7f 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -79,6 +79,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index f89777184ceb..4b606dcb8e94 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
@@ -59,8 +60,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_SPL_PINCTRL=y
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 409aa95acf06..28d157dbd7a7 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -77,8 +77,9 @@ CONFIG_SF_DEFAULT_BUS=4
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_XTX=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 181c284e73e9..1d993a5b71b0 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -67,6 +67,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index 7e290351477e..f01aa7269a1c 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -67,6 +67,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index a0884a797d58..2f3145745d58 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -68,6 +68,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-- 
2.42.0

