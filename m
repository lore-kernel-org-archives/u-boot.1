Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF93C3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993E3885C4;
	Fri, 28 Jun 2024 15:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C822C88246; Fri, 28 Jun 2024 11:38:56 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C9687EB4
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 11:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 17:38:50 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 28 Jun 2024 17:38:50 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
 <BMC-SW@aspeedtech.com>, <joel@jms.id.au>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <kobedylan@gmail.com>, <jacky_chou@aspeedtech.com>, <u-boot@lists.denx.de>
Subject: [PATCH] net: ftgmac100: Modify desc. size to cache line
Date: Fri, 28 Jun 2024 17:38:50 +0800
Message-ID: <20240628093850.3063206-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 28 Jun 2024 15:00:50 +0200
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

The TX/RX descriptor size is 16 byte.
When the cache line size is larger than 16 bytes, descriptors
flushed to RAM will flush more than one descriptor.
It is possible that it may mistakenly flush to other descriptor
that has been updated by MAC in RAM.

To avoid this issue, align the descriptors to cache line size.
Only one desc will be flushed or invalidated at a time.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ftgmac100.c | 13 ++++++++++++-
 drivers/net/ftgmac100.h |  5 +++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 256a519020..9fb8c12838 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -322,7 +322,7 @@ static int ftgmac100_start(struct udevice *dev)
 	struct ftgmac100_data *priv = dev_get_priv(dev);
 	struct ftgmac100 *ftgmac100 = priv->iobase;
 	struct phy_device *phydev = priv->phydev;
-	unsigned int maccr;
+	unsigned int maccr, dblac, desc_size;
 	ulong start, end;
 	int ret;
 	int i;
@@ -367,6 +367,17 @@ static int ftgmac100_start(struct udevice *dev)
 	/* receive ring */
 	writel((u32)priv->rxdes, &ftgmac100->rxr_badr);
 
+	/* Configure TX/RX decsriptor size
+	 * This size is calculated based on cache line.
+	 */
+	desc_size = ARCH_DMA_MINALIGN / FTGMAC100_DESC_UNIT;
+	/* The descriptor size is at least 2 descriptor units. */
+	if (desc_size < 2)
+		desc_size = 2;
+	dblac = readl(&ftgmac100->dblac) & ~GENMASK(19, 12);
+	dblac |= FTGMAC100_DBLAC_RXDES_SIZE(desc_size) | FTGMAC100_DBLAC_TXDES_SIZE(desc_size);
+	writel(dblac, &ftgmac100->dblac);
+
 	/* poll receive descriptor automatically */
 	writel(FTGMAC100_APTC_RXPOLL_CNT(1), &ftgmac100->aptc);
 
diff --git a/drivers/net/ftgmac100.h b/drivers/net/ftgmac100.h
index f7874ae68b..37c029aded 100644
--- a/drivers/net/ftgmac100.h
+++ b/drivers/net/ftgmac100.h
@@ -111,6 +111,7 @@ struct ftgmac100 {
 #define FTGMAC100_DBLAC_TXBURST_SIZE(x)	(((x) & 0x3) << 10)
 #define FTGMAC100_DBLAC_RXDES_SIZE(x)	(((x) & 0xf) << 12)
 #define FTGMAC100_DBLAC_TXDES_SIZE(x)	(((x) & 0xf) << 16)
+#define FTGMAC100_DESC_UNIT		8
 #define FTGMAC100_DBLAC_IFG_CNT(x)	(((x) & 0x7) << 20)
 #define FTGMAC100_DBLAC_IFG_INC		BIT(23)
 
@@ -183,7 +184,7 @@ struct ftgmac100_txdes {
 	unsigned int	txdes1;
 	unsigned int	txdes2;	/* not used by HW */
 	unsigned int	txdes3;	/* TXBUF_BADR */
-} __aligned(16);
+} __aligned(ARCH_DMA_MINALIGN);
 
 #define FTGMAC100_TXDES0_TXBUF_SIZE(x)	((x) & 0x3fff)
 #define FTGMAC100_TXDES0_EDOTR		BIT(15)
@@ -209,7 +210,7 @@ struct ftgmac100_rxdes {
 	unsigned int	rxdes1;
 	unsigned int	rxdes2;	/* not used by HW */
 	unsigned int	rxdes3;	/* RXBUF_BADR */
-} __aligned(16);
+} __aligned(ARCH_DMA_MINALIGN);
 
 #define FTGMAC100_RXDES0_VDBC(x)	((x) & 0x3fff)
 #define FTGMAC100_RXDES0_EDORR		BIT(15)
-- 
2.25.1

