Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20FEC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4058842C;
	Tue, 18 Jun 2024 17:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LeT8/g7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822908841E; Tue, 18 Jun 2024 17:34:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A022883C9
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 28A0A61A02;
 Tue, 18 Jun 2024 15:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDDFC4AF1C;
 Tue, 18 Jun 2024 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724893;
 bh=ykhfI4BEUMqi/KpQ3Faw3lvkHK5XKp8rYARlOHfEZ7M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LeT8/g7E2k8YiEVw85fDrMYbklFVsZYZQExz4Fzkxie6HP9X/1WgWUAwZW5lDhNvy
 FalrHAt+ROj03pgpCNL6q/ZiIpAutalf/gIfCG3hoFLbTIJV59TZ6B8aNGbOySVR9u
 poRfG0Pv7EvSg8MhY3C7zBJq1O+sSs3uPwB9DKVjQIdH3k6k9BSi/Dzs4kSigKzsgp
 SyaVUATmWuYIPK7QHuX/eSKXTe9IT8G0M8Pl3Nz+c60WHYm866HL0JeVQKAcdJq9SZ
 C+ZHozhBunmPtLDuWuGdtivIt12H/EoSwv3pTDEDMnNXg/S/l6V5kwvCBTcvXWQw3V
 AHOhfzF4sIbWg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 07/16] arm: mvebu: turris_omnia: Fix ethernet
 PHY reset gpio FDT fixup
Date: Tue, 18 Jun 2024 17:34:30 +0200
Message-ID: <20240618153439.9518-8-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For board revisions where the WAN ethernet PHY reset GPIO is controllable
via MCU we currently insert a phy-reset-gpios property into the ethernet
controller node. The mvneta driver parses this property and uses the
GPIO to reset the PHY.

But this phy-reset-gpios property is not a valid DT binding in upstream
kernel. Instead, a reset-gpios property should be inserted into the
ethernet PHY node. This correct DT binding is supported by the DM ETH PHY
U-Boot driver.

Insert the reset-gpios property into the WAN PHY node instead the
phy-reset-gpios property in WAN ETH node so that Linux will correctly use
the reset GPIO.

Enable the CONFIG_DM_ETH_PHY config option so that U-Boot will also use
the correct DT property.

Note: currently there are 4 ethernet controller drivers parsing the
wrong DT property: dwc_eth_qos, fex_mxc, mvneta and mvpp2. We should
convert all relevant device-trees to use reset-gpios so that we can get
rid of these drivers parsing this property.

Fixes: 1da53ae26afc ("arm: mvebu: turris_omnia: Add support for design with SW reset signals")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 44 ++++++++++++++----------
 configs/turris_omnia_defconfig           |  1 +
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 4ee1a394b0..100a991406 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -978,11 +978,21 @@ static int fixup_mcu_gpio_in_pcie_nodes(void *blob)
 	return 0;
 }
 
-static int fixup_mcu_gpio_in_eth_wan_node(void *blob)
+static int get_phy_wan_node_offset(const void *blob)
+{
+	u32 phy_wan_phandle;
+
+	phy_wan_phandle = fdt_getprop_u32_default(blob, "ethernet2", "phy-handle", 0);
+	if (!phy_wan_phandle)
+		return -FDT_ERR_NOTFOUND;
+
+	return fdt_node_offset_by_phandle(blob, phy_wan_phandle);
+}
+
+static int fixup_mcu_gpio_in_phy_wan_node(void *blob)
 {
 	unsigned int mcu_phandle;
-	int eth_wan_node;
-	int ret;
+	int phy_wan_node, ret;
 
 	ret = fdt_increase_size(blob, 64);
 	if (ret < 0) {
@@ -990,21 +1000,17 @@ static int fixup_mcu_gpio_in_eth_wan_node(void *blob)
 		return ret;
 	}
 
-	eth_wan_node = fdt_path_offset(blob, "ethernet2");
-	if (eth_wan_node < 0)
-		return eth_wan_node;
+	phy_wan_node = get_phy_wan_node_offset(blob);
+	if (phy_wan_node < 0)
+		return phy_wan_node;
 
 	mcu_phandle = fdt_create_phandle_by_compatible(blob, "cznic,turris-omnia-mcu");
 	if (!mcu_phandle)
 		return -FDT_ERR_NOPHANDLES;
 
-	/* insert: phy-reset-gpios = <&mcu 2 gpio GPIO_ACTIVE_LOW>; */
-	ret = insert_mcu_gpio_prop(blob, eth_wan_node, "phy-reset-gpios",
-				   mcu_phandle, 2, ilog2(EXT_CTL_nRES_PHY), GPIO_ACTIVE_LOW);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	/* insert: reset-gpios = <&mcu 2 gpio GPIO_ACTIVE_LOW>; */
+	return insert_mcu_gpio_prop(blob, phy_wan_node, "reset-gpios",
+				    mcu_phandle, 2, ilog2(EXT_CTL_nRES_PHY), GPIO_ACTIVE_LOW);
 }
 
 static void fixup_atsha_node(void *blob)
@@ -1033,7 +1039,7 @@ int board_fix_fdt(void *blob)
 {
 	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU)) {
 		fixup_mcu_gpio_in_pcie_nodes(blob);
-		fixup_mcu_gpio_in_eth_wan_node(blob);
+		fixup_mcu_gpio_in_phy_wan_node(blob);
 	}
 
 	fixup_msata_port_nodes(blob);
@@ -1218,14 +1224,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	int node;
 
 	/*
-	 * U-Boot's FDT blob contains phy-reset-gpios in ethernet2
-	 * node when MCU controls all peripherals resets.
+	 * U-Boot's FDT blob contains reset-gpios in ethernet2 PHY node when MCU
+	 * controls all peripherals resets.
 	 * Fixup MCU GPIO nodes in PCIe and eth wan nodes in this case.
 	 */
-	node = fdt_path_offset(gd->fdt_blob, "ethernet2");
-	if (node >= 0 && fdt_getprop(gd->fdt_blob, node, "phy-reset-gpios", NULL)) {
+	node = get_phy_wan_node_offset(gd->fdt_blob);
+	if (node >= 0 && fdt_getprop(gd->fdt_blob, node, "reset-gpios", NULL)) {
 		fixup_mcu_gpio_in_pcie_nodes(blob);
-		fixup_mcu_gpio_in_eth_wan_node(blob);
+		fixup_mcu_gpio_in_phy_wan_node(blob);
 	}
 
 	fixup_spi_nor_partitions(blob);
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 938ad88ae5..08e3e21215 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -101,6 +101,7 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_FIXED=y
 CONFIG_DM_DSA=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_MV88E6XXX=y
 CONFIG_MVNETA=y
-- 
2.44.2

