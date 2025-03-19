Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32D3C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D634481D27;
	Wed, 19 Mar 2025 13:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3E181D27; Wed, 19 Mar 2025 13:04:28 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 9F0B781101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: EbqJz997Qt+E+46GHlDLig==
X-CSE-MsgGUID: iBP4f1NdTxibt6Ae49FdaA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 19 Mar 2025 21:04:25 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.1.74])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 55EEF4016D69;
 Wed, 19 Mar 2025 21:04:22 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/4] net: ravb: Add optional reset deassertion
Date: Wed, 19 Mar 2025 12:03:58 +0000
Message-ID: <20250319120401.8297-3-paul.barker.ct@bp.renesas.com>
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
subsequent patch, we introduce optional de-assertion and re-assertion of
a reset signal in ravb_probe() and ravb_remove().

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ravb.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index b433e5dfbdd3..ecf6e05f47eb 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -23,6 +23,7 @@
 #include <asm/io.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
+#include <reset.h>
 
 /* Registers */
 #define RAVB_REG_CCC		0x000
@@ -111,6 +112,7 @@ struct ravb_device_ops {
 	void (*mac_init)(struct udevice *dev);
 	void (*dmac_init)(struct udevice *dev);
 	void (*config)(struct udevice *dev);
+	bool has_reset;
 };
 
 struct ravb_desc {
@@ -136,6 +138,7 @@ struct ravb_priv {
 	struct mii_dev		*bus;
 	void __iomem		*iobase;
 	struct clk_bulk		clks;
+	struct reset_ctl	rst;
 };
 
 static inline void ravb_flush_dcache(u32 addr, u32 len)
@@ -613,6 +616,8 @@ static int ravb_bb_miiphy_write(struct mii_dev *miidev, int addr,
 
 static int ravb_probe(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
 	struct mii_dev *mdiodev;
@@ -648,16 +653,32 @@ static int ravb_probe(struct udevice *dev)
 	if (ret)
 		goto err_clk_enable;
 
+	if (device_ops->has_reset) {
+		ret = reset_get_by_index(dev, 0, &eth->rst);
+		if (ret < 0)
+			goto err_clk_enable;
+
+		ret = reset_deassert(&eth->rst);
+		if (ret < 0)
+			goto err_reset_deassert;
+	}
+
 	ret = ravb_reset(dev);
 	if (ret)
-		goto err_clk_enable;
+		goto err_ravb_reset;
 
 	ret = ravb_phy_config(dev);
 	if (ret)
-		goto err_clk_enable;
+		goto err_ravb_reset;
 
 	return 0;
 
+err_ravb_reset:
+	if (device_ops->has_reset)
+		reset_assert(&eth->rst);
+err_reset_deassert:
+	if (device_ops->has_reset)
+		reset_free(&eth->rst);
 err_clk_enable:
 	mdio_unregister(mdiodev);
 err_mdio_register:
@@ -671,8 +692,14 @@ err_clk_get:
 
 static int ravb_remove(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
 
+	if (device_ops->has_reset) {
+		reset_assert(&eth->rst);
+		reset_free(&eth->rst);
+	}
 	clk_release_bulk(&eth->clks);
 
 	free(eth->phydev);
-- 
2.43.0

