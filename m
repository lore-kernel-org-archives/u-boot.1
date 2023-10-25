Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF54C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 08:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4814E87A75;
	Wed, 25 Oct 2023 10:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=tkos.co.il header.i=@tkos.co.il header.b="jsbqRtU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E1587A5F; Wed, 25 Oct 2023 10:09:52 +0200 (CEST)
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC02887A55
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=tkos.co.il
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baruch@tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.tkos.co.il (Postfix) with ESMTPS id 579F344064C;
 Wed, 25 Oct 2023 11:09:09 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
 s=default; t=1698221349;
 bh=HVWRirlGZWvRY4v8XfJ5Ob7XaPd12wWDB04Rcz9eJlE=;
 h=From:To:Cc:Subject:Date:From;
 b=jsbqRtU9lDB0BFWMVEq7my5fgz4DnkIU8oY4E1s0pYR5uaX7cr/qK8w5wVwh+AjcY
 wEIfb9Wy0Mh2K+gTQs46UIeLx28TfXOovH8AY/ICh+d0MWUG0ZvpLUsM812zaTvmjf
 quhN2zW6ZA35DaJV0YfCozQXtNVsoldoNfehR+zravaFoerdHghgR9XTgaAUmkGosa
 wgPA70JO2UtVa9j9DapoUMjDwZYy2HewoLqOrAanUWcA81UlNycbYI4AGO+QrH3T26
 oVQ28MZng0xkgZl4kxu5zIWaYubjIfJi/I8ZjM53II3uUmUlZ8sQm5E43ur2GNLYlX
 pYndA7o/MTArw==
From: Baruch Siach <baruch@tkos.co.il>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] net: designware: add DMA offset awareness
Date: Wed, 25 Oct 2023 11:08:44 +0300
Message-ID: <da63602bf3f102a3c997362842a959832c97dca6.1698221324.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
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

Older DesignWare Ethernet MAC versions that this driver supports can
only work with 32-bit DMA source/destination addresses. Some platforms
have no physical RAM at the lowest 4GB address space. For these
platforms the driver must translate DMA addresses to/from physical
memory addresses.

Call translation routines so that properly configured platforms can use
the DesignWare Ethernet MAC. For platforms using device-tree this
usually means adding dma-ranges property to the bus the device node is
in.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/net/designware.c | 31 ++++++++++++++++++++-----------
 drivers/net/designware.h |  1 +
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 20b86e74cecf..a174344b3ef5 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -19,6 +19,7 @@
 #include <net.h>
 #include <pci.h>
 #include <reset.h>
+#include <phys2bus.h>
 #include <asm/cache.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
@@ -232,8 +233,10 @@ static void tx_descs_init(struct dw_eth_dev *priv)
 
 	for (idx = 0; idx < CFG_TX_DESCR_NUM; idx++) {
 		desc_p = &desc_table_p[idx];
-		desc_p->dmamac_addr = (ulong)&txbuffs[idx * CFG_ETH_BUFSIZE];
-		desc_p->dmamac_next = (ulong)&desc_table_p[idx + 1];
+		desc_p->dmamac_addr = dev_phys_to_bus(priv->dev,
+				(ulong)&txbuffs[idx * CFG_ETH_BUFSIZE]);
+		desc_p->dmamac_next = dev_phys_to_bus(priv->dev,
+				(ulong)&desc_table_p[idx + 1]);
 
 #if defined(CONFIG_DW_ALTDESCRIPTOR)
 		desc_p->txrx_status &= ~(DESC_TXSTS_TXINT | DESC_TXSTS_TXLAST |
@@ -251,14 +254,15 @@ static void tx_descs_init(struct dw_eth_dev *priv)
 	}
 
 	/* Correcting the last pointer of the chain */
-	desc_p->dmamac_next = (ulong)&desc_table_p[0];
+	desc_p->dmamac_next = dev_phys_to_bus(priv->dev, (ulong)&desc_table_p[0]);
 
 	/* Flush all Tx buffer descriptors at once */
 	flush_dcache_range((ulong)priv->tx_mac_descrtable,
 			   (ulong)priv->tx_mac_descrtable +
 			   sizeof(priv->tx_mac_descrtable));
 
-	writel((ulong)&desc_table_p[0], &dma_p->txdesclistaddr);
+	writel(dev_phys_to_bus(priv->dev, (ulong)&desc_table_p[0]),
+			&dma_p->txdesclistaddr);
 	priv->tx_currdescnum = 0;
 }
 
@@ -280,8 +284,10 @@ static void rx_descs_init(struct dw_eth_dev *priv)
 
 	for (idx = 0; idx < CFG_RX_DESCR_NUM; idx++) {
 		desc_p = &desc_table_p[idx];
-		desc_p->dmamac_addr = (ulong)&rxbuffs[idx * CFG_ETH_BUFSIZE];
-		desc_p->dmamac_next = (ulong)&desc_table_p[idx + 1];
+		desc_p->dmamac_addr = dev_phys_to_bus(priv->dev,
+				(ulong)&rxbuffs[idx * CFG_ETH_BUFSIZE]);
+		desc_p->dmamac_next = dev_phys_to_bus(priv->dev,
+				(ulong)&desc_table_p[idx + 1]);
 
 		desc_p->dmamac_cntl =
 			(MAC_MAX_FRAME_SZ & DESC_RXCTRL_SIZE1MASK) |
@@ -291,14 +297,15 @@ static void rx_descs_init(struct dw_eth_dev *priv)
 	}
 
 	/* Correcting the last pointer of the chain */
-	desc_p->dmamac_next = (ulong)&desc_table_p[0];
+	desc_p->dmamac_next = dev_phys_to_bus(priv->dev, (ulong)&desc_table_p[0]);
 
 	/* Flush all Rx buffer descriptors at once */
 	flush_dcache_range((ulong)priv->rx_mac_descrtable,
 			   (ulong)priv->rx_mac_descrtable +
 			   sizeof(priv->rx_mac_descrtable));
 
-	writel((ulong)&desc_table_p[0], &dma_p->rxdesclistaddr);
+	writel(dev_phys_to_bus(priv->dev, (ulong)&desc_table_p[0]),
+			&dma_p->rxdesclistaddr);
 	priv->rx_currdescnum = 0;
 }
 
@@ -448,7 +455,7 @@ static int _dw_eth_send(struct dw_eth_dev *priv, void *packet, int length)
 	ulong desc_start = (ulong)desc_p;
 	ulong desc_end = desc_start +
 		roundup(sizeof(*desc_p), ARCH_DMA_MINALIGN);
-	ulong data_start = desc_p->dmamac_addr;
+	ulong data_start = dev_bus_to_phys(priv->dev, desc_p->dmamac_addr);
 	ulong data_end = data_start + roundup(length, ARCH_DMA_MINALIGN);
 	/*
 	 * Strictly we only need to invalidate the "txrx_status" field
@@ -515,7 +522,7 @@ static int _dw_eth_recv(struct dw_eth_dev *priv, uchar **packetp)
 	ulong desc_start = (ulong)desc_p;
 	ulong desc_end = desc_start +
 		roundup(sizeof(*desc_p), ARCH_DMA_MINALIGN);
-	ulong data_start = desc_p->dmamac_addr;
+	ulong data_start = dev_bus_to_phys(priv->dev, desc_p->dmamac_addr);
 	ulong data_end;
 
 	/* Invalidate entire buffer descriptor */
@@ -532,7 +539,8 @@ static int _dw_eth_recv(struct dw_eth_dev *priv, uchar **packetp)
 		/* Invalidate received data */
 		data_end = data_start + roundup(length, ARCH_DMA_MINALIGN);
 		invalidate_dcache_range(data_start, data_end);
-		*packetp = (uchar *)(ulong)desc_p->dmamac_addr;
+		*packetp = (uchar *)(ulong)dev_bus_to_phys(priv->dev,
+				desc_p->dmamac_addr);
 	}
 
 	return length;
@@ -757,6 +765,7 @@ int designware_eth_probe(struct udevice *dev)
 		goto mdio_err;
 	}
 	priv->bus = miiphy_get_dev_by_name(dev->name);
+	priv->dev = dev;
 
 	ret = dw_phy_init(priv, dev);
 	debug("%s, ret=%d\n", __func__, ret);
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index 9da4e902cb0d..918a38615ad6 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -241,6 +241,7 @@ struct dw_eth_dev {
 	int clock_count;	/* number of clock in clock list */
 #endif
 
+	struct udevice *dev;
 	struct phy_device *phydev;
 	struct mii_dev *bus;
 };
-- 
2.42.0

