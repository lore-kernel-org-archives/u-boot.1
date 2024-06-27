Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4B8C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B98D08852E;
	Thu, 27 Jun 2024 13:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACDFC8851B; Thu, 27 Jun 2024 08:26:10 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB80188418
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 08:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 27 Jun
 2024 14:26:00 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 27 Jun 2024 14:26:00 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
 <BMC-SW@aspeedtech.com>, <joel@jms.id.au>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <trini@konsulko.com>, <jacky_chou@aspeedtech.com>,
 <sjg@chromium.org>, <kobedylan@gmail.com>, <u-boot@lists.denx.de>
Subject: [PATCH] net: ftgmac100: Fixed the cache coherency issues of rx memory
Date: Thu, 27 Jun 2024 14:26:00 +0800
Message-ID: <20240627062600.3142388-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 27 Jun 2024 13:09:53 +0200
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

When executing TFTP, the ARP will be replied to after receiving
the ARP. U-boot's ARP routine modifies the data in the receive
packet in response to the ARP packet and then copies it
into the transmit packet.
At this point, the received packet cache is inconsistent.
It is possible that the cache will perform a writeback action to
affect the MAC receiving packets.

Avoid the same problem that occurs in other networking protocols.
In the free_pkt function, ensure cache and memory consistency.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ftgmac100.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 9b536fd5ab..56854dfab8 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -411,6 +411,14 @@ static int ftgmac100_free_pkt(struct udevice *dev, uchar *packet, int length)
 	ulong des_end = des_start +
 		roundup(sizeof(*curr_des), ARCH_DMA_MINALIGN);
 
+	/*
+	 * Make sure there are no stale data in write-back over this area, which
+	 * might get written into the memory while the ftgmac100 also writes
+	 * into the same memory area.
+	 */
+	flush_dcache_range((ulong)net_rx_packets[priv->rx_index],
+			   (ulong)net_rx_packets[priv->rx_index] + PKTSIZE_ALIGN);
+
 	/* Release buffer to DMA and flush descriptor */
 	curr_des->rxdes0 &= ~FTGMAC100_RXDES0_RXPKT_RDY;
 	flush_dcache_range(des_start, des_end);
-- 
2.34.1

