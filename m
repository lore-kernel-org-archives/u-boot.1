Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC348C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297C188712;
	Mon,  8 Jul 2024 14:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF888858B; Mon,  8 Jul 2024 08:07:26 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D22884C6
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Jul
 2024 14:07:18 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Jul
 2024 14:07:19 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 8 Jul 2024 14:07:18 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
 <BMC-SW@aspeedtech.com>, <joel@jms.id.au>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <kobedylan@gmail.com>, <jacky_chou@aspeedtech.com>, <u-boot@lists.denx.de>
Subject: [PATCH] net: ftgmac100: Add Aspeed AST2700 support
Date: Mon, 8 Jul 2024 14:07:18 +0800
Message-ID: <20240708060718.186075-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jacky_chou@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

Add support of Aspeed AST2700 SoC.  AST2700 is based on ARM64 so modify
the DMA address related code to fit both ARM and ARM64.  Besides, the
RMII/RGMII mode control register is moved from SCU500 to MAC50 so
initialize the register in ftgmac100_start correspondingly.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ftgmac100.c | 66 +++++++++++++++++++++++++++++++++--------
 drivers/net/ftgmac100.h | 12 ++++++++
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 9fb8c12838..a909a0b309 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/printk.h>
+#include <linux/bitfield.h>
 
 #include "ftgmac100.h"
 
@@ -58,6 +59,15 @@
 enum ftgmac100_model {
 	FTGMAC100_MODEL_FARADAY,
 	FTGMAC100_MODEL_ASPEED,
+	FTGMAC100_MODEL_ASPEED_AST2700,
+};
+
+union ftgmac100_dma_addr {
+	dma_addr_t addr;
+	struct {
+		u32 lo;
+		u32 hi;
+	};
 };
 
 /**
@@ -97,6 +107,8 @@ struct ftgmac100_data {
 	/* End of RX/TX ring buffer bits. Depend on model */
 	u32 rxdes0_edorr_mask;
 	u32 txdes0_edotr_mask;
+
+	bool is_ast2700;
 };
 
 /*
@@ -321,6 +333,7 @@ static int ftgmac100_start(struct udevice *dev)
 	struct eth_pdata *plat = dev_get_plat(dev);
 	struct ftgmac100_data *priv = dev_get_priv(dev);
 	struct ftgmac100 *ftgmac100 = priv->iobase;
+	union ftgmac100_dma_addr dma_addr = {.hi = 0, .lo = 0};
 	struct phy_device *phydev = priv->phydev;
 	unsigned int maccr, dblac, desc_size;
 	ulong start, end;
@@ -342,6 +355,7 @@ static int ftgmac100_start(struct udevice *dev)
 	priv->rx_index = 0;
 
 	for (i = 0; i < PKTBUFSTX; i++) {
+		priv->txdes[i].txdes2 = 0;
 		priv->txdes[i].txdes3 = 0;
 		priv->txdes[i].txdes0 = 0;
 	}
@@ -352,7 +366,14 @@ static int ftgmac100_start(struct udevice *dev)
 	flush_dcache_range(start, end);
 
 	for (i = 0; i < PKTBUFSRX; i++) {
-		priv->rxdes[i].rxdes3 = (unsigned int)net_rx_packets[i];
+		unsigned int ip_align = 0;
+
+		dma_addr.addr = (dma_addr_t)net_rx_packets[i];
+		priv->rxdes[i].rxdes2 = FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI, dma_addr.hi);
+		/* For IP alignment */
+		if ((dma_addr.lo & (PKTALIGN - 1)) == 0)
+			ip_align = 2;
+		priv->rxdes[i].rxdes3 = dma_addr.lo + ip_align;
 		priv->rxdes[i].rxdes0 = 0;
 	}
 	priv->rxdes[PKTBUFSRX - 1].rxdes0 = priv->rxdes0_edorr_mask;
@@ -362,10 +383,14 @@ static int ftgmac100_start(struct udevice *dev)
 	flush_dcache_range(start, end);
 
 	/* transmit ring */
-	writel((u32)priv->txdes, &ftgmac100->txr_badr);
+	dma_addr.addr = (dma_addr_t)priv->txdes;
+	writel(dma_addr.lo, &ftgmac100->txr_badr);
+	writel(dma_addr.hi, &ftgmac100->txr_badr_hi);
 
 	/* receive ring */
-	writel((u32)priv->rxdes, &ftgmac100->rxr_badr);
+	dma_addr.addr = (dma_addr_t)priv->rxdes;
+	writel(dma_addr.lo, &ftgmac100->rxr_badr);
+	writel(dma_addr.hi, &ftgmac100->rxr_badr_hi);
 
 	/* Configure TX/RX decsriptor size
 	 * This size is calculated based on cache line.
@@ -394,6 +419,10 @@ static int ftgmac100_start(struct udevice *dev)
 		FTGMAC100_MACCR_RX_RUNT |
 		FTGMAC100_MACCR_RX_BROADPKT;
 
+	if (priv->is_ast2700 && (priv->phydev->interface == PHY_INTERFACE_MODE_RMII ||
+				 priv->phydev->interface == PHY_INTERFACE_MODE_NCSI))
+		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
+
 	writel(maccr, &ftgmac100->maccr);
 
 	ret = phy_startup(phydev);
@@ -443,9 +472,11 @@ static int ftgmac100_recv(struct udevice *dev, int flags, uchar **packetp)
 	ulong des_start = ((ulong)curr_des) & ~(ARCH_DMA_MINALIGN - 1);
 	ulong des_end = des_start +
 		roundup(sizeof(*curr_des), ARCH_DMA_MINALIGN);
-	ulong data_start = curr_des->rxdes3;
+	union ftgmac100_dma_addr data_start = { .lo = 0, .hi = 0 };
 	ulong data_end;
 
+	data_start.hi = FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI, curr_des->rxdes2);
+	data_start.lo = curr_des->rxdes3;
 	invalidate_dcache_range(des_start, des_end);
 
 	if (!(curr_des->rxdes0 & FTGMAC100_RXDES0_RXPKT_RDY))
@@ -465,9 +496,9 @@ static int ftgmac100_recv(struct udevice *dev, int flags, uchar **packetp)
 	       __func__, priv->rx_index, rxlen);
 
 	/* Invalidate received data */
-	data_end = data_start + roundup(rxlen, ARCH_DMA_MINALIGN);
-	invalidate_dcache_range(data_start, data_end);
-	*packetp = (uchar *)data_start;
+	data_end = data_start.addr + roundup(rxlen, ARCH_DMA_MINALIGN);
+	invalidate_dcache_range(data_start.addr, data_end);
+	*packetp = (uchar *)data_start.addr;
 
 	return rxlen;
 }
@@ -493,6 +524,7 @@ static int ftgmac100_send(struct udevice *dev, void *packet, int length)
 	struct ftgmac100_data *priv = dev_get_priv(dev);
 	struct ftgmac100 *ftgmac100 = priv->iobase;
 	struct ftgmac100_txdes *curr_des = &priv->txdes[priv->tx_index];
+	union ftgmac100_dma_addr dma_addr;
 	ulong des_start = ((ulong)curr_des) & ~(ARCH_DMA_MINALIGN - 1);
 	ulong des_end = des_start +
 		roundup(sizeof(*curr_des), ARCH_DMA_MINALIGN);
@@ -511,10 +543,12 @@ static int ftgmac100_send(struct udevice *dev, void *packet, int length)
 
 	length = (length < ETH_ZLEN) ? ETH_ZLEN : length;
 
-	curr_des->txdes3 = (unsigned int)packet;
+	dma_addr.addr = (dma_addr_t)packet;
+	curr_des->txdes2 = FIELD_PREP(FTGMAC100_TXDES2_TXBUF_BADR_HI, dma_addr.hi);
+	curr_des->txdes3 = dma_addr.lo;
 
 	/* Flush data to be sent */
-	data_start = curr_des->txdes3;
+	data_start = (ulong)dma_addr.addr;
 	data_end = data_start + roundup(length, ARCH_DMA_MINALIGN);
 	flush_dcache_range(data_start, data_end);
 
@@ -577,6 +611,11 @@ static int ftgmac100_of_to_plat(struct udevice *dev)
 	if (dev_get_driver_data(dev) == FTGMAC100_MODEL_ASPEED) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
+		priv->is_ast2700 = false;
+	} else if (dev_get_driver_data(dev) == FTGMAC100_MODEL_ASPEED_AST2700) {
+		priv->rxdes0_edorr_mask = BIT(30);
+		priv->txdes0_edotr_mask = BIT(30);
+		priv->is_ast2700 = true;
 	} else {
 		priv->rxdes0_edorr_mask = BIT(15);
 		priv->txdes0_edotr_mask = BIT(15);
@@ -667,10 +706,11 @@ static const struct eth_ops ftgmac100_ops = {
 };
 
 static const struct udevice_id ftgmac100_ids[] = {
-	{ .compatible = "faraday,ftgmac100",  .data = FTGMAC100_MODEL_FARADAY },
-	{ .compatible = "aspeed,ast2500-mac", .data = FTGMAC100_MODEL_ASPEED  },
-	{ .compatible = "aspeed,ast2600-mac", .data = FTGMAC100_MODEL_ASPEED  },
-	{ }
+	{ .compatible = "faraday,ftgmac100", .data = FTGMAC100_MODEL_FARADAY },
+	{ .compatible = "aspeed,ast2500-mac", .data = FTGMAC100_MODEL_ASPEED },
+	{ .compatible = "aspeed,ast2600-mac", .data = FTGMAC100_MODEL_ASPEED },
+	{ .compatible = "aspeed,ast2700-mac", .data = FTGMAC100_MODEL_ASPEED_AST2700 },
+	{}
 };
 
 U_BOOT_DRIVER(ftgmac100) = {
diff --git a/drivers/net/ftgmac100.h b/drivers/net/ftgmac100.h
index 37c029aded..c38b57c954 100644
--- a/drivers/net/ftgmac100.h
+++ b/drivers/net/ftgmac100.h
@@ -66,6 +66,13 @@ struct ftgmac100 {
 	unsigned int	rx_runt;	/* 0xc0 */
 	unsigned int	rx_crcer_ftl;	/* 0xc4 */
 	unsigned int	rx_col_lost;	/* 0xc8 */
+	unsigned int	reserved[43];	/* 0xcc - 0x174 */
+	unsigned int	txr_badr_lo;	/* 0x178, defined in ast2700 */
+	unsigned int	txr_badr_hi;	/* 0x17c, defined in ast2700 */
+	unsigned int	hptxr_badr_lo;	/* 0x180, defined in ast2700 */
+	unsigned int	hptxr_badr_hi;	/* 0x184, defined in ast2700 */
+	unsigned int	rxr_badr_lo;	/* 0x188, defined in ast2700 */
+	unsigned int	rxr_badr_hi;	/* 0x18c, defined in ast2700 */
 };
 
 /*
@@ -158,6 +165,7 @@ struct ftgmac100 {
 #define FTGMAC100_MACCR_RX_BROADPKT	BIT(17)
 #define FTGMAC100_MACCR_DISCARD_CRCERR	BIT(18)
 #define FTGMAC100_MACCR_FAST_MODE	BIT(19)
+#define FTGMAC100_MACCR_RMII_ENABLE	BIT(20)	/* defined in ast2700 */
 #define FTGMAC100_MACCR_SW_RST		BIT(31)
 
 /*
@@ -202,6 +210,8 @@ struct ftgmac100_txdes {
 #define FTGMAC100_TXDES1_TX2FIC		BIT(30)
 #define FTGMAC100_TXDES1_TXIC		BIT(31)
 
+#define FTGMAC100_TXDES2_TXBUF_BADR_HI	GENMASK(18, 16)
+
 /*
  * Receive descriptor, aligned to 16 bytes
  */
@@ -241,4 +251,6 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	BIT(26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	BIT(27)
 
+#define FTGMAC100_RXDES2_RXBUF_BADR_HI	GENMASK(18, 16)
+
 #endif /* __FTGMAC100_H */
-- 
2.25.1

