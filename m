Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC6EE78480
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119B6870C1;
	Sun,  1 Oct 2023 21:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EzWaUnpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261ED870F1; Sun,  1 Oct 2023 21:18:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6707870E5
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696187882; bh=0BIsu3F8LHHVfoel640m6D1NetaISz9T6aZG0/L/4Rg=;
 b=EzWaUnpmTsNCOJ/+3jK2kFk8VERU+QbuQMfcI6xfny91nlrslnkPBRxfmFkv6qSgUzuF7jIf7
 lyPYWrmp+ACpivHGz8TXCnmSCWExpNSzznTP3LqiYNgC7GwbunsT64RuI1vW96lTEsOgI0EDETt
 AEpm56SWZUd03seUKD417FZcZuqYtrbuBcmdGSMwo2OB5FFWpNRj62rNdGVDGy/WAvwkS0C1CwW
 xeSOi0PdboZXwdpV3tCixPcMKNUZRSE3kO7OdbM1B7AI0yRhY/1qKl+bnRdoTMhSYbbmdsgAaXU
 0FkdG+8HycoIMOWtayz9J8VhIZbl4hcARXbiZwcx1YjQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jagan Teki <jagan@edgeble.ai>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman
 <jonas@kwiboo.se>
Cc: David Wu <david.wu@rock-chips.com>, Frank Wunderlich
 <frank-w@public-files.de>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 7/7] configs: rockchip: Enable ethernet driver on RK3588
 boards
Date: Sun,  1 Oct 2023 19:17:22 +0000
Message-ID: <20231001191730.4167035-8-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 6519c5e925909c3c56c79dd7
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

Enable DWC_ETH_QOS_ROCKCHIP and related PHY driver on RK3588 boards that
have an enabled gmac node and drop ETH_DESIGNWARE and GMAC_ROCKCHIP for
remaining RK3588 boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Collect r-b tag
- Remove already meged rock5a-rk3588s_defconfig change
- Add rock5b-rk3588_defconfig changes

 configs/evb-rk3588_defconfig      | 5 +++--
 configs/neu6a-io-rk3588_defconfig | 2 --
 configs/neu6b-io-rk3588_defconfig | 2 --
 configs/rock5a-rk3588s_defconfig  | 5 +++--
 configs/rock5b-rk3588_defconfig   | 3 +--
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index f49c2ca686a8..0b7b4f2f627a 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -58,8 +58,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index 09729a0ea429..d5301c630b2a 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -53,8 +53,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index c7bc3b1965f0..b13c9b5db1b0 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -53,8 +53,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index 39e352509a5c..bccdb1e3ecd6 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -58,8 +58,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 3fa65cbf9b07..6428aab42033 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -78,9 +78,8 @@ CONFIG_SF_DEFAULT_BUS=5
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_XTX=y
-CONFIG_ETH_DESIGNWARE=y
+CONFIG_PHYLIB=y
 CONFIG_RTL8169=y
-CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
-- 
2.42.0

