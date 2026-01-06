Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B98CEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 21:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD7C83B9D;
	Tue,  6 Jan 2026 22:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="FKLkkGx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41BE0838A5; Tue,  6 Jan 2026 22:55:17 +0100 (CET)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0B283B32
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 22:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767736513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdfNMvbS1S0z/z8D5JUzbKD91ZMgynvaqWY3NNAUnEM=;
 b=FKLkkGx04Ryn+Y075jdLgaZU+IDkNbLDHVqy7UOOM17+1JVt/Rd1+2g08nAFPIaCYj9EUq
 1QO0BeJ3nEqIEY2O+BGk6xa93+8liY/5VjAHVUQSuNjqJ9fWDbbsjs9R+BBAOb7Kz+Jp68
 FFMCeP2CAfqGtzF+S1284ySMmux6UP4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Frantisek Bohacek <rutherther@ditigal.xyz>,
 Sean Anderson <sean.anderson@linux.dev>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/4] phy: zynqmp: Store instance instead of type
Date: Tue,  6 Jan 2026 16:55:00 -0500
Message-Id: <20260106215501.727524-4-sean.anderson@linux.dev>
In-Reply-To: <20260106215501.727524-1-sean.anderson@linux.dev>
References: <20260106215501.727524-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

The phy "type" is just the combination of protocol and instance, and is
never used apart from that. Store the instance directly, instead of
converting to a type first. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://lore.kernel.org/r/20240628205540.3098010-3-sean.anderson@linux.dev
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Linux commit 6959d2367bc3503ac4ba3eb4ec6584a43150d6b3 ]
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/phy/phy-zynqmp.c | 121 +++++++++++----------------------------
 1 file changed, 33 insertions(+), 88 deletions(-)

diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
index 706903c5b52..6316f0b7619 100644
--- a/drivers/phy/phy-zynqmp.c
+++ b/drivers/phy/phy-zynqmp.c
@@ -150,24 +150,6 @@
 /* Total number of controllers */
 #define CONTROLLERS_PER_LANE		5
 
-/* Protocol Type parameters */
-enum {
-	XPSGTR_TYPE_USB0 = 0, /* USB controller 0 */
-	XPSGTR_TYPE_USB1 = 1, /* USB controller 1 */
-	XPSGTR_TYPE_SATA_0 = 2, /* SATA controller lane 0 */
-	XPSGTR_TYPE_SATA_1 = 3, /* SATA controller lane 1 */
-	XPSGTR_TYPE_PCIE_0 = 4, /* PCIe controller lane 0 */
-	XPSGTR_TYPE_PCIE_1 = 5, /* PCIe controller lane 1 */
-	XPSGTR_TYPE_PCIE_2 = 6, /* PCIe controller lane 2 */
-	XPSGTR_TYPE_PCIE_3 = 7, /* PCIe controller lane 3 */
-	XPSGTR_TYPE_DP_0 = 8, /* Display Port controller lane 0 */
-	XPSGTR_TYPE_DP_1 = 9, /* Display Port controller lane 1 */
-	XPSGTR_TYPE_SGMII0 = 10, /* Ethernet SGMII controller 0 */
-	XPSGTR_TYPE_SGMII1 = 11, /* Ethernet SGMII controller 1 */
-	XPSGTR_TYPE_SGMII2 = 12, /* Ethernet SGMII controller 2 */
-	XPSGTR_TYPE_SGMII3 = 13, /* Ethernet SGMII controller 3 */
-};
-
 /* Timeout values */
 #define TIMEOUT_US			10000
 
@@ -196,14 +178,15 @@ struct xpsgtr_ssc {
  * struct xpsgtr_phy - representation of a lane
  * @dev: pointer to the xpsgtr_dev instance
  * @refclk: reference clock index
- * @type: controller which uses this lane
+ * @instance: instance of the protocol type (such as the lane within a
+ *            protocol, or the USB/Ethernet controller)
  * @lane: lane number
  * @protocol: protocol in which the lane operates
  */
 struct xpsgtr_phy {
 	struct xpsgtr_dev *dev;
 	unsigned int refclk;
-	u8 type;
+	u8 instance;
 	u8 lane;
 	u8 protocol;
 };
@@ -461,8 +444,8 @@ static int xpsgtr_init(struct phy *x)
 		break;
 	}
 
-	dev_dbg(gtr_dev->dev, "lane %u (type %u, protocol %u): init done\n",
-		gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
+	dev_dbg(gtr_dev->dev, "lane %u (protocol %u, instance %u): init done\n",
+		gtr_phy->lane, gtr_phy->protocol, gtr_phy->instance);
 
 	return 0;
 }
@@ -498,8 +481,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
 
 	if (ret == -ETIMEDOUT)
 		dev_err(gtr_dev->dev,
-			"lane %u (type %u, protocol %u): PLL lock timeout\n",
-			gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
+			"lane %u (protocol %u, instance %u): PLL lock timeout\n",
+			gtr_phy->lane, gtr_phy->protocol, gtr_phy->protocol);
 
 	return ret;
 }
@@ -518,8 +501,7 @@ static int xpsgtr_power_on(struct phy *phy)
 	 * cumulating waits for both lanes. The user is expected to initialize
 	 * lane 0 last.
 	 */
-	if (gtr_phy->protocol != ICM_PROTOCOL_DP ||
-	    gtr_phy->type == XPSGTR_TYPE_DP_0)
+	if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
 		ret = xpsgtr_wait_pll_lock(phy);
 
 	return ret;
@@ -529,73 +511,33 @@ static int xpsgtr_power_on(struct phy *phy)
  * OF Xlate Support
  */
 
-/* Set the lane type and protocol based on the PHY type and instance number. */
+/* Set the lane protocol and instance based on the PHY type and instance number. */
 static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
 				unsigned int phy_instance)
 {
 	unsigned int num_phy_types;
-	const int *phy_types;
 
 	switch (phy_type) {
-	case PHY_TYPE_SATA: {
-		static const int types[] = {
-			XPSGTR_TYPE_SATA_0,
-			XPSGTR_TYPE_SATA_1,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_SATA:
+		num_phy_types = 2;
 		gtr_phy->protocol = ICM_PROTOCOL_SATA;
 		break;
-	}
-	case PHY_TYPE_USB3: {
-		static const int types[] = {
-			XPSGTR_TYPE_USB0,
-			XPSGTR_TYPE_USB1,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_USB3:
+		num_phy_types = 2;
 		gtr_phy->protocol = ICM_PROTOCOL_USB;
 		break;
-	}
-	case PHY_TYPE_DP: {
-		static const int types[] = {
-			XPSGTR_TYPE_DP_0,
-			XPSGTR_TYPE_DP_1,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_DP:
+		num_phy_types = 2;
 		gtr_phy->protocol = ICM_PROTOCOL_DP;
 		break;
-	}
-	case PHY_TYPE_PCIE: {
-		static const int types[] = {
-			XPSGTR_TYPE_PCIE_0,
-			XPSGTR_TYPE_PCIE_1,
-			XPSGTR_TYPE_PCIE_2,
-			XPSGTR_TYPE_PCIE_3,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_PCIE:
+		num_phy_types = 4;
 		gtr_phy->protocol = ICM_PROTOCOL_PCIE;
 		break;
-	}
-	case PHY_TYPE_SGMII: {
-		static const int types[] = {
-			XPSGTR_TYPE_SGMII0,
-			XPSGTR_TYPE_SGMII1,
-			XPSGTR_TYPE_SGMII2,
-			XPSGTR_TYPE_SGMII3,
-		};
-
-		phy_types = types;
-		num_phy_types = ARRAY_SIZE(types);
+	case PHY_TYPE_SGMII:
+		num_phy_types = 4;
 		gtr_phy->protocol = ICM_PROTOCOL_SGMII;
 		break;
-	}
 	default:
 		return -EINVAL;
 	}
@@ -603,22 +545,25 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
 	if (phy_instance >= num_phy_types)
 		return -EINVAL;
 
-	gtr_phy->type = phy_types[phy_instance];
+	gtr_phy->instance = phy_instance;
 	return 0;
 }
 
 /*
- * Valid combinations of controllers and lanes (Interconnect Matrix).
+ * Valid combinations of controllers and lanes (Interconnect Matrix). Each
+ * "instance" represents one controller for a lane. For PCIe and DP, the
+ * "instance" is the logical lane in the link. For SATA, USB, and SGMII,
+ * the instance is the index of the controller.
+ *
+ * This information is only used to validate the devicetree reference, and is
+ * not used when programming the hardware.
  */
 static const unsigned int icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] = {
-	{ XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
-		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
-	{ XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
-		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
-	{ XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
-		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
-	{ XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
-		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
+	/* PCIe, SATA, USB, DP, SGMII */
+	{ 0, 0, 0, 1, 0 }, /* Lane 0 */
+	{ 1, 1, 0, 0, 1 }, /* Lane 1 */
+	{ 2, 0, 0, 1, 2 }, /* Lane 2 */
+	{ 3, 1, 1, 0, 3 }, /* Lane 3 */
 };
 
 /* Translate OF phandle and args to PHY instance. */
@@ -678,7 +623,7 @@ static int xpsgtr_of_xlate(struct phy *x,
 	 * is allowed to operate on the lane.
 	 */
 	for (i = 0; i < CONTROLLERS_PER_LANE; i++) {
-		if (icm_matrix[phy_lane][i] == gtr_phy->type) {
+		if (icm_matrix[phy_lane][i] == gtr_phy->instance) {
 			x->id = phy_lane;
 			return 0;
 		}
-- 
2.35.1.1320.gc452695387.dirty

