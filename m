Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75BCCE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F208589051;
	Thu, 24 Oct 2024 17:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0BD88FB9; Thu, 24 Oct 2024 17:25:47 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id D50D088FB9
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="226888011"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:38 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 54F1D4008C7C;
 Fri, 25 Oct 2024 00:25:35 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 09/14] net: ravb: Support up to two instances
Date: Thu, 24 Oct 2024 16:24:43 +0100
Message-Id: <20241024152448.102-10-paul.barker.ct@bp.renesas.com>
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

Several Renesas SoCs in the RZ/G2L family have two Ethernet interfaces.
To support this second interface, we extend the bb_miiphy_buses[] array
and keep track of the current bus index in ravb_of_to_plat().

Support for an arbitrary number of instances is not implemented - it is
expected that bb_miiphy_buses will be replaced with a proper device
model/uclass implementation before that is needed.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ravb.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index f1401d2f6ed2..9b33ce929618 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -11,6 +11,7 @@
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <errno.h>
 #include <log.h>
 #include <miiphy.h>
@@ -494,6 +495,7 @@ static int ravb_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
+	struct bb_miiphy_bus *phybus;
 	struct mii_dev *mdiodev;
 	void __iomem *iobase;
 	int ret;
@@ -513,7 +515,8 @@ static int ravb_probe(struct udevice *dev)
 
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
-	bb_miiphy_buses[0].priv = eth;
+	phybus = (struct bb_miiphy_bus *)pdata->priv_pdata;
+	phybus->priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	ret = mdio_register(mdiodev);
@@ -625,7 +628,17 @@ int ravb_bb_delay(struct bb_miiphy_bus *bus)
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name		= "ravb",
+		.name		= "ravb0",
+		.init		= ravb_bb_init,
+		.mdio_active	= ravb_bb_mdio_active,
+		.mdio_tristate	= ravb_bb_mdio_tristate,
+		.set_mdio	= ravb_bb_set_mdio,
+		.get_mdio	= ravb_bb_get_mdio,
+		.set_mdc	= ravb_bb_set_mdc,
+		.delay		= ravb_bb_delay,
+	},
+	{
+		.name		= "ravb1",
 		.init		= ravb_bb_init,
 		.mdio_active	= ravb_bb_mdio_active,
 		.mdio_tristate	= ravb_bb_mdio_tristate,
@@ -646,10 +659,16 @@ static const struct eth_ops ravb_ops = {
 	.write_hwaddr		= ravb_write_hwaddr,
 };
 
+static int bb_miiphy_index;
+
 int ravb_of_to_plat(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
-	const fdt32_t *cell;
+
+	if (bb_miiphy_index >= bb_miiphy_buses_num) {
+		dev_err(dev, "ravb driver supports only 1 or 2 devices!\n");
+		return -EOVERFLOW;
+	}
 
 	pdata->iobase = dev_read_addr(dev);
 
@@ -662,7 +681,8 @@ int ravb_of_to_plat(struct udevice *dev)
 	if (cell)
 		pdata->max_speed = fdt32_to_cpu(*cell);
 
-	sprintf(bb_miiphy_buses[0].name, dev->name);
+	pdata->priv_pdata = &bb_miiphy_buses[bb_miiphy_index];
+	sprintf(bb_miiphy_buses[bb_miiphy_index++].name, dev->name);
 
 	return 0;
 }
-- 
2.43.0

