Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4E1D73E89
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 21:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 318E484114;
	Thu, 29 Jan 2026 22:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EqH03gRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC39C84105; Thu, 29 Jan 2026 22:02:28 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AC184114
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 22:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769720544; bh=HCQAPUrAJTdTG7CBQdoC5V5I7e5EW0AtacSPgdHVF78=;
 b=EqH03gRMdwojMfB2wi0ldDhoKpTlnWOavWuphexqN31w0L9tCZyo0/6ilAXpzNZgXfToImzga
 LODOwf4vKcD93FIYTCYf/YpLJEWlSD1r5HSEbhTwunELQjepbnyQi7wxtpZ/F95o9mq/+gZsARl
 GJNGdgQlBFSMDTm/8DHyIAFceQqgbpuD93wlGv4V37JABtxqK16uQTlYVP/HPDN9e43ljOs3aXJ
 kqeCUfaBYkor8BBDiT/jy0rIwBIPv3T2pV7gzPE9cEy64Wc0214KJXruwwRK/Qeo05xo/iOMT4h
 qqSbrR7zBgXHX4r7UGpQ5UVN6dRP7r5dm6OOoiHRutow==
X-Forward-Email-ID: 697bcadc8bac728cb531c6f3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/4] net: dwc_eth_qos: Define more of the unused MAC regs
Date: Thu, 29 Jan 2026 21:01:52 +0000
Message-ID: <20260129210159.2279888-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210159.2279888-1-jonas@kwiboo.se>
References: <20260129210159.2279888-1-jonas@kwiboo.se>
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

Multicast and Broadcast Queue Enable and Promiscuous Mode Enable bits
are currently written to "unused" registers using magic values.

Define more of the "unused" MAC regs based on information in the
DesignWare Cores Ethernet Quality-of-Service databook.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos.c | 10 +++++-----
 drivers/net/dwc_eth_qos.h | 28 ++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index b104d4e47255..8a396d0b29ea 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -890,11 +890,11 @@ static int eqos_start(struct udevice *dev)
 			EQOS_MAC_RXQ_CTRL0_RXQ0EN_SHIFT);
 
 	/* Multicast and Broadcast Queue Enable */
-	setbits_le32(&eqos->mac_regs->unused_0a4,
-		     0x00100000);
-	/* enable promise mode */
-	setbits_le32(&eqos->mac_regs->unused_004[1],
-		     0x1);
+	setbits_le32(&eqos->mac_regs->rxq_ctrl1,
+		     EQOS_MAC_RXQ_CTRL1_MCBCQEN);
+	/* Promiscuous Mode Enable */
+	setbits_le32(&eqos->mac_regs->packet_filter,
+		     EQOS_MAC_PACKET_FILTER_PR);
 
 	/* Set TX flow control parameters */
 	/* Set Pause Time */
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index c239a5c7aca4..ba16f1a37cb1 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -14,23 +14,31 @@
 #define EQOS_MAC_REGS_BASE 0x000
 struct eqos_mac_regs {
 	u32 configuration;				/* 0x000 */
-	u32 unused_004[(0x070 - 0x004) / 4];	/* 0x004 */
+	u32 ext_configuration;				/* 0x004 */
+	u32 packet_filter;				/* 0x008 */
+	u32 watchdog_timeout;				/* 0x00c */
+	u32 unused_010[(0x070 - 0x010) / 4];	/* 0x010 */
 	u32 q0_tx_flow_ctrl;			/* 0x070 */
-	u32 unused_070[(0x090 - 0x074) / 4];	/* 0x074 */
+	u32 unused_074[(0x090 - 0x074) / 4];	/* 0x074 */
 	u32 rx_flow_ctrl;				/* 0x090 */
-	u32 unused_094;				/* 0x094 */
+	u32 rxq_ctrl4;				/* 0x094 */
 	u32 txq_prty_map0;				/* 0x098 */
-	u32 unused_09c;				/* 0x09c */
+	u32 txq_prty_map1;				/* 0x09c */
 	u32 rxq_ctrl0;				/* 0x0a0 */
-	u32 unused_0a4;				/* 0x0a4 */
+	u32 rxq_ctrl1;				/* 0x0a4 */
 	u32 rxq_ctrl2;				/* 0x0a8 */
-	u32 unused_0ac[(0x0dc - 0x0ac) / 4];	/* 0x0ac */
+	u32 rxq_ctrl3;				/* 0x0ac */
+	u32 unused_0b0[(0x0dc - 0x0b0) / 4];	/* 0x0b0 */
 	u32 us_tic_counter;			/* 0x0dc */
-	u32 unused_0e0[(0x11c - 0x0e0) / 4];	/* 0x0e0 */
+	u32 unused_0e0[(0x110 - 0x0e0) / 4];	/* 0x0e0 */
+	u32 version;					/* 0x110 */
+	u32 debug;					/* 0x114 */
+	u32 unused_118;					/* 0x118 */
 	u32 hw_feature0;				/* 0x11c */
 	u32 hw_feature1;				/* 0x120 */
 	u32 hw_feature2;				/* 0x124 */
-	u32 unused_128[(0x200 - 0x128) / 4];	/* 0x128 */
+	u32 hw_feature3;				/* 0x128 */
+	u32 unused_12c[(0x200 - 0x12c) / 4];	/* 0x12c */
 	u32 mdio_address;				/* 0x200 */
 	u32 mdio_data;				/* 0x204 */
 	u32 unused_208[(0x300 - 0x208) / 4];	/* 0x208 */
@@ -51,6 +59,8 @@ struct eqos_mac_regs {
 #define EQOS_MAC_CONFIGURATION_TE			BIT(1)
 #define EQOS_MAC_CONFIGURATION_RE			BIT(0)
 
+#define EQOS_MAC_PACKET_FILTER_PR			BIT(0)
+
 #define EQOS_MAC_Q0_TX_FLOW_CTRL_PT_SHIFT		16
 #define EQOS_MAC_Q0_TX_FLOW_CTRL_PT_MASK		0xffff
 #define EQOS_MAC_Q0_TX_FLOW_CTRL_TFE			BIT(1)
@@ -66,6 +76,8 @@ struct eqos_mac_regs {
 #define EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB		2
 #define EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_AV		1
 
+#define EQOS_MAC_RXQ_CTRL1_MCBCQEN			BIT(20)
+
 #define EQOS_MAC_RXQ_CTRL2_PSRQ0_SHIFT			0
 #define EQOS_MAC_RXQ_CTRL2_PSRQ0_MASK			0xff
 
-- 
2.52.0

