Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4A4C36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920CA815D1;
	Wed, 19 Mar 2025 13:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC98A81CE7; Wed, 19 Mar 2025 13:04:26 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id BDF06815D1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: qYZAcv6/TyOtFyUCihYg7g==
X-CSE-MsgGUID: JFi2IgDjT+iaQdDtozvs3w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 19 Mar 2025 21:04:21 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.1.74])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4EA434016D69;
 Wed, 19 Mar 2025 21:04:18 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/4] net: ravb: Refactor out R-Car specific code
Date: Wed, 19 Mar 2025 12:03:57 +0000
Message-ID: <20250319120401.8297-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
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

In order to add support for the Renesas RZ/G2L Ethernet IP in a
subsequent patch, we move all R-Car specific code into new functions and
introduce a device_ops function pointer table.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ravb.c | 80 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 539fd37ee59c..b433e5dfbdd3 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -107,6 +107,12 @@
 
 #define RAVB_TX_TIMEOUT_MS		1000
 
+struct ravb_device_ops {
+	void (*mac_init)(struct udevice *dev);
+	void (*dmac_init)(struct udevice *dev);
+	void (*config)(struct udevice *dev);
+};
+
 struct ravb_desc {
 	u32	ctrl;
 	u32	dptr;
@@ -349,10 +355,13 @@ static int ravb_write_hwaddr(struct udevice *dev)
 }
 
 /* E-MAC init function */
-static int ravb_mac_init(struct ravb_priv *eth)
+static void ravb_mac_init(struct udevice *dev)
 {
-	/* Disable MAC Interrupt */
-	writel(0, eth->iobase + RAVB_REG_ECSIPR);
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
+	struct ravb_priv *eth = dev_get_priv(dev);
+
+	device_ops->mac_init(dev);
 
 	/*
 	 * Set receive frame length
@@ -363,19 +372,23 @@ static int ravb_mac_init(struct ravb_priv *eth)
 	 * largest frames add the CRC length to the maximum Rx descriptor size.
 	 */
 	writel(RFLR_RFL_MIN + ETH_FCS_LEN, eth->iobase + RAVB_REG_RFLR);
+}
 
-	return 0;
+static void ravb_mac_init_rcar(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+
+	/* Disable MAC Interrupt */
+	writel(0, eth->iobase + RAVB_REG_ECSIPR);
 }
 
 /* AVB-DMAC init function */
 static int ravb_dmac_init(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
-	struct eth_pdata *pdata = dev_get_plat(dev);
-	int ret = 0;
-	int mode = 0;
-	unsigned int delay;
-	bool explicit_delay = false;
+	int ret;
 
 	/* Set CONFIG mode */
 	ret = ravb_reset(dev);
@@ -391,6 +404,18 @@ static int ravb_dmac_init(struct udevice *dev)
 	/* Set little endian */
 	clrbits_le32(eth->iobase + RAVB_REG_CCC, CCC_BOC);
 
+	device_ops->dmac_init(dev);
+	return 0;
+}
+
+static void ravb_dmac_init_rcar(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	int mode = 0;
+	unsigned int delay;
+	bool explicit_delay = false;
+
 	/* AVB rx set */
 	writel(0x18000001, eth->iobase + RAVB_REG_RCR);
 
@@ -400,7 +425,7 @@ static int ravb_dmac_init(struct udevice *dev)
 	/* Delay CLK: 2ns (not applicable on R-Car E3/D3) */
 	if ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77990) ||
 	    (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77995))
-		return 0;
+		return;
 
 	if (!dev_read_u32(dev, "rx-internal-delay-ps", &delay)) {
 		/* Valid values are 0 and 1800, according to DT bindings */
@@ -429,28 +454,37 @@ static int ravb_dmac_init(struct udevice *dev)
 	}
 
 	writel(mode, eth->iobase + RAVB_REG_APSR);
-
-	return 0;
 }
 
 static int ravb_config(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
 	struct phy_device *phy = eth->phydev;
-	u32 mask = ECMR_CHG_DM | ECMR_RE | ECMR_TE;
 	int ret;
 
 	/* Configure AVB-DMAC register */
 	ravb_dmac_init(dev);
 
 	/* Configure E-MAC registers */
-	ravb_mac_init(eth);
+	ravb_mac_init(dev);
 	ravb_write_hwaddr(dev);
 
 	ret = phy_startup(phy);
 	if (ret)
 		return ret;
 
+	device_ops->config(dev);
+	return 0;
+}
+
+static void ravb_config_rcar(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+	struct phy_device *phy = eth->phydev;
+	u32 mask = ECMR_CHG_DM | ECMR_RE | ECMR_TE;
+
 	/* Set the transfer speed */
 	if (phy->speed == 100)
 		writel(0, eth->iobase + RAVB_REG_GECMR);
@@ -462,8 +496,6 @@ static int ravb_config(struct udevice *dev)
 		mask |= ECMR_DM;
 
 	writel(mask, eth->iobase + RAVB_REG_ECMR);
-
-	return 0;
 }
 
 static int ravb_start(struct udevice *dev)
@@ -675,9 +707,21 @@ int ravb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static const struct ravb_device_ops ravb_device_ops_rcar = {
+	.mac_init = ravb_mac_init_rcar,
+	.dmac_init = ravb_dmac_init_rcar,
+	.config = ravb_config_rcar,
+};
+
 static const struct udevice_id ravb_ids[] = {
-	{ .compatible = "renesas,etheravb-rcar-gen3" },
-	{ .compatible = "renesas,etheravb-rcar-gen4" },
+	{
+		.compatible = "renesas,etheravb-rcar-gen3",
+		.data = (ulong)&ravb_device_ops_rcar,
+	},
+	{
+		.compatible = "renesas,etheravb-rcar-gen4",
+		.data = (ulong)&ravb_device_ops_rcar,
+	},
 	{ }
 };
 
-- 
2.43.0

