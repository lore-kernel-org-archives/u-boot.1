Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424F8CE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E13188FA7;
	Thu, 24 Oct 2024 17:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DA489024; Thu, 24 Oct 2024 17:25:42 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 8E9D989003
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="226888007"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:36 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id DD32040065A3;
 Fri, 25 Oct 2024 00:25:27 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 07/14] net: phy: ksz90x1: Load skew values from device tree
Date: Thu, 24 Oct 2024 16:24:41 +0100
Message-Id: <20241024152448.102-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
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

Various signal skew values may be set in the device tree for the ksz9131
Ethernet PHY. For example, the RZ/G2L board requires non-default values
for rxc-skew-psec & txc-skew-psec.

This is based on the ksz9131 phy driver in Linux v6.11.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/phy/micrel_ksz90x1.c | 115 +++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index 4f99b115a3c7..b64046e0bc72 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -389,6 +389,117 @@ U_BOOT_PHY_DRIVER(ksz9031) = {
 #define KSZ9131RN_DLL_ENABLE_DELAY	0
 #define KSZ9131RN_DLL_DISABLE_DELAY	BIT(12)
 
+#define KSZ9131RN_CONTROL_PAD_SKEW	4
+#define KSZ9131RN_RX_DATA_PAD_SKEW	5
+#define KSZ9131RN_TX_DATA_PAD_SKEW	6
+#define KSZ9131RN_CLK_PAD_SKEW		8
+
+#define KSZ9131RN_SKEW_5BIT_MAX		2400
+#define KSZ9131RN_SKEW_4BIT_MAX		800
+#define KSZ9131RN_OFFSET		700
+#define KSZ9131RN_STEP			100
+
+static int ksz9131_of_load_skew_values(struct phy_device *phydev,
+				       ofnode of_node,
+				       u16 reg, size_t field_sz,
+				       const char *field[], u8 numfields)
+{
+	int val[4] = {-(1 + KSZ9131RN_OFFSET), -(2 + KSZ9131RN_OFFSET),
+		      -(3 + KSZ9131RN_OFFSET), -(4 + KSZ9131RN_OFFSET)};
+	int skewval, skewmax = 0;
+	int matches = 0;
+	u16 maxval;
+	u16 newval;
+	u16 mask;
+	int i;
+
+	/* psec properties in dts should mean x pico seconds */
+	if (field_sz == 5)
+		skewmax = KSZ9131RN_SKEW_5BIT_MAX;
+	else
+		skewmax = KSZ9131RN_SKEW_4BIT_MAX;
+
+	for (i = 0; i < numfields; i++)
+		if (!ofnode_read_s32(of_node, field[i], &skewval)) {
+			if (skewval < -KSZ9131RN_OFFSET)
+				skewval = -KSZ9131RN_OFFSET;
+			else if (skewval > skewmax)
+				skewval = skewmax;
+
+			val[i] = skewval + KSZ9131RN_OFFSET;
+			matches++;
+		}
+
+	if (!matches)
+		return 0;
+
+	if (matches < numfields)
+		newval = phy_read_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG, reg);
+	else
+		newval = 0;
+
+	maxval = (field_sz == 4) ? 0xf : 0x1f;
+	for (i = 0; i < numfields; i++)
+		if (val[i] != -(i + 1 + KSZ9131RN_OFFSET)) {
+			mask = 0xffff;
+			mask ^= maxval << (field_sz * i);
+			newval = (newval & mask) |
+				(((val[i] / KSZ9131RN_STEP) & maxval)
+					<< (field_sz * i));
+		}
+
+	return phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG, reg, newval);
+}
+
+static int ksz9131_of_load_all_skew_values(struct phy_device *phydev)
+{
+	const char *control_skews[2] = { "txen-skew-psec", "rxdv-skew-psec" };
+	const char *clk_skews[2] = { "rxc-skew-psec", "txc-skew-psec" };
+	const char *rx_data_skews[4] = {
+		"rxd0-skew-psec", "rxd1-skew-psec",
+		"rxd2-skew-psec", "rxd3-skew-psec"
+	};
+	const char *tx_data_skews[4] = {
+		"txd0-skew-psec", "txd1-skew-psec",
+		"txd2-skew-psec", "txd3-skew-psec"
+	};
+	struct ofnode_phandle_args phandle_args;
+	int ret;
+
+	/*
+	 * Silently ignore failure here as the device tree is not required to
+	 * contain a phy node.
+	 */
+	if (dev_read_phandle_with_args(phydev->dev, "phy-handle", NULL, 0, 0,
+				       &phandle_args))
+		return 0;
+
+	if (!ofnode_valid(phandle_args.node))
+		return 0;
+
+	ret = ksz9131_of_load_skew_values(phydev, phandle_args.node,
+					  KSZ9131RN_CLK_PAD_SKEW, 5,
+					  clk_skews, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = ksz9131_of_load_skew_values(phydev, phandle_args.node,
+					  KSZ9131RN_CONTROL_PAD_SKEW, 4,
+					  control_skews, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = ksz9131_of_load_skew_values(phydev, phandle_args.node,
+					  KSZ9131RN_RX_DATA_PAD_SKEW, 4,
+					  rx_data_skews, 4);
+	if (ret < 0)
+		return ret;
+
+	return ksz9131_of_load_skew_values(phydev, phandle_args.node,
+					   KSZ9131RN_TX_DATA_PAD_SKEW, 4,
+					   tx_data_skews, 4);
+}
+
 static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
 {
 	struct phy_driver *drv = phydev->drv;
@@ -466,6 +577,10 @@ static int ksz9131_config(struct phy_device *phydev)
 			return ret;
 	}
 
+	ret = ksz9131_of_load_all_skew_values(phydev);
+	if (ret < 0)
+		return ret;
+
 	ret = ksz9131_led_errata(phydev);
 	if (ret < 0)
 		return ret;
-- 
2.43.0

