Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCF1E9412E
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 21:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA2886D3C;
	Fri,  6 Oct 2023 23:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktOIdNls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC2286DB5; Fri,  6 Oct 2023 14:24:44 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77DEB86CF4
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 14:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=debrabander@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so3510608a12.2
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696595082; x=1697199882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YO48bivJ9H5mlQ2OEyPlCTdMOcJ1xMHvdPJpgHLD/BM=;
 b=ktOIdNlsoujQolrqXXW0ONG53iFKtdIHIo2pEKumLX40bqLfAap73iVeaMjfg/UHeX
 LDSUrs8bmntVhhJmw80XKvD5p3KWjWiNZjGXnpiC1s/fC+w+yLAF1hYY7kMgAQwLxndI
 6yJ7YmqOGaEJecWxB8uWRuMKSzyA7Nvpb8p8vuHm9v4QY9oUhj2J2JtZdOCVwWCNgh+1
 hML2FZzSoSn68ejQw8a1TNMkDcS1CMej6dQjKacoC3OFaVl0md/IPrYBvSu4s9yKK70I
 BCl7W5zZ+Z68kMKsSbobJDoR4pqBkA8j9oDx0ZHHkfy25c8Yee3iaeSUckAHqm+vie5z
 e5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696595082; x=1697199882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YO48bivJ9H5mlQ2OEyPlCTdMOcJ1xMHvdPJpgHLD/BM=;
 b=Y4INcYcA/WzcBpFD3BomWPmz9B57/yYT/bjwsbDfKkLPVr+zJUvif/rPX7VrJTlT1F
 KZdQCUfnRA0rjFt7aMj3M0yQTZn0X6EWts+65YXF7NiKZCwa5dpSpP95tYT+gSipBXHO
 X1Da55QqkQnL8W76pCgkbgd8+XJsrnVvUdGKg8/Bk9nfHrBLwvDljQjvHJaEYBTLG55j
 y5sPjWXmCnjhYcV/4Ud8+OgoIz9umvtmCarLwBpahpviUoUFuUTdVwbYHjhqbe4/CnQv
 2XS3dcT/urChewouDu0IPhWxKkcuZ0A7SZdwqGu7bEsvJtwAyacZDdbt0U8Dvr+D2p5W
 g+ag==
X-Gm-Message-State: AOJu0YwUEHmvXMjSk7kZ+wK5X0dsAue9I3NySQ5Qr6F14vu4jLYGlejl
 NdB3ZIImYJzNDf1yrL3Y5PptD99zRKa7HA==
X-Google-Smtp-Source: AGHT+IFBDYAVqcb7+BNRp8vyzoUvsz6Osezl+2D1Mv7BTrR0ouAFJGy8HVzib4MNqIIREOLp6iLOoQ==
X-Received: by 2002:aa7:d998:0:b0:51a:3159:53c7 with SMTP id
 u24-20020aa7d998000000b0051a315953c7mr7528897eds.30.1696595081739; 
 Fri, 06 Oct 2023 05:24:41 -0700 (PDT)
Received: from win95.FOX.local (186-153-172-081.dynamic.caiway.nl.
 [81.172.153.186]) by smtp.gmail.com with ESMTPSA id
 k18-20020a05640212d200b00537fa467ddasm2497376edx.65.2023.10.06.05.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 05:24:41 -0700 (PDT)
From: Frank de Brabander <debrabander@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 Frank de Brabander <debrabander@gmail.com>
Subject: [PATCH] net: phy: TI DP83869 fix invalid clock delay configuration
Date: Fri,  6 Oct 2023 14:24:39 +0200
Message-Id: <20231006122439.10720-1-debrabander@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Oct 2023 23:32:20 +0200
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

Setting the clock delay from the device tree settings
rx-internal-delay-ps and tx-internal-delay-ps was broken:

 - The expected value in the device tree is suppose to be a
   delay in picoseconds, but the driver only allowed an array index.
 - Driver converted this array index to the actual delay in
   picoseconds and tried to apply this in the device register. This
   however is not a valid register value. The actual logic here was
   reversed, it converted an register representation of the delay to
   the device tree delay in picoseconds.

Only when the internal delays were NOT configured in the device tree
and they default value of 7 (=2000ps) was used, a valid value was
loaded in the register.

Signed-off-by: Frank de Brabander <debrabander@gmail.com>
---
 drivers/net/phy/dp83869.c | 53 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 8d32d73b07..f9d4782580 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -81,7 +81,10 @@
 
 /* RGMIIDCTL bits */
 #define DP83869_RGMII_TX_CLK_DELAY_SHIFT	4
-#define DP83869_CLK_DELAY_DEF				7
+#define DP83869_CLK_DELAY_STEP			250
+#define DP83869_CLK_DELAY_MIN			250
+#define DP83869_CLK_DELAY_MAX			4000
+#define DP83869_CLK_DELAY_DEFAULT		2000
 
 /* CFG2 bits */
 #define MII_DP83869_CFG2_SPEEDOPT_10EN		0x0040
@@ -157,10 +160,6 @@ static int dp83869_config_port_mirroring(struct phy_device *phydev)
 	return 0;
 }
 
-static const int dp83869_internal_delay[] = {250, 500, 750, 1000, 1250, 1500,
-					     1750, 2000, 2250, 2500, 2750, 3000,
-					     3250, 3500, 3750, 4000};
-
 static int dp83869_set_strapped_mode(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869 = phydev->priv;
@@ -183,7 +182,6 @@ static int dp83869_set_strapped_mode(struct phy_device *phydev)
 static int dp83869_of_init(struct phy_device *phydev)
 {
 	struct dp83869_private * const dp83869 = phydev->priv;
-	const int delay_entries = ARRAY_SIZE(dp83869_internal_delay);
 	int ret;
 	ofnode node;
 
@@ -238,32 +236,45 @@ static int dp83869_of_init(struct phy_device *phydev)
 	dp83869->tx_fifo_depth = ofnode_read_s32_default(node, "tx-fifo-depth",
 							 DP83869_PHYCR_FIFO_DEPTH_4_B_NIB);
 
+	/* Internal clock delay values can be configured in steps of
+	 * 250ps (0.25ns). The register field for clock delay is 4-bits wide,
+	 * the values range from 0b0000 for 0.25ns to 0b1111 for 4ns.
+	 */
+
 	/* RX delay *must* be specified if internal delay of RX is used. */
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) {
-		dp83869->rx_int_delay = ofnode_read_u32_default(node, "rx-internal-delay-ps",
-								DP83869_CLK_DELAY_DEF);
-		if (dp83869->rx_int_delay > delay_entries) {
-			dp83869->rx_int_delay = DP83869_CLK_DELAY_DEF;
-			pr_debug("rx-internal-delay-ps not set/invalid, default to %ups\n",
-				 dp83869_internal_delay[dp83869->rx_int_delay]);
+		dp83869->rx_int_delay = ofnode_read_u32_default(node,
+			"rx-internal-delay-ps", DP83869_CLK_DELAY_DEFAULT);
+		if (dp83869->rx_int_delay > DP83869_CLK_DELAY_MAX ||
+		    dp83869->rx_int_delay < DP83869_CLK_DELAY_MIN ||
+		    dp83869->rx_int_delay % DP83869_CLK_DELAY_STEP) {
+			dp83869->rx_int_delay = DP83869_CLK_DELAY_DEFAULT;
+			pr_warn("rx-internal-delay-ps not set/invalid, default"
+				" to %ups\n", DP83869_CLK_DELAY_DEFAULT);
 		}
 
-		dp83869->rx_int_delay = dp83869_internal_delay[dp83869->rx_int_delay];
+		dp83869->rx_int_delay =
+			(dp83869->rx_int_delay - DP83869_CLK_DELAY_STEP)
+			/ DP83869_CLK_DELAY_STEP;
 	}
 
-	/* TX delay *must* be specified if internal delay of RX is used. */
+	/* TX delay *must* be specified if internal delay of TX is used. */
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) {
-		dp83869->tx_int_delay = ofnode_read_u32_default(node, "tx-internal-delay-ps",
-								DP83869_CLK_DELAY_DEF);
-		if (dp83869->tx_int_delay > delay_entries) {
-			dp83869->tx_int_delay = DP83869_CLK_DELAY_DEF;
-			pr_debug("tx-internal-delay-ps not set/invalid, default to %ups\n",
-				 dp83869_internal_delay[dp83869->tx_int_delay]);
+		dp83869->tx_int_delay = ofnode_read_u32_default(node,
+			"tx-internal-delay-ps", DP83869_CLK_DELAY_DEFAULT);
+		if (dp83869->tx_int_delay > DP83869_CLK_DELAY_MAX ||
+		    dp83869->tx_int_delay < DP83869_CLK_DELAY_MIN ||
+		    dp83869->tx_int_delay % DP83869_CLK_DELAY_STEP) {
+			dp83869->tx_int_delay = DP83869_CLK_DELAY_DEFAULT;
+			pr_warn("tx-internal-delay-ps not set/invalid, default"
+				" to %ups\n", DP83869_CLK_DELAY_DEFAULT);
 		}
 
-		dp83869->tx_int_delay = dp83869_internal_delay[dp83869->tx_int_delay];
+		dp83869->tx_int_delay =
+			(dp83869->tx_int_delay - DP83869_CLK_DELAY_STEP)
+			/ DP83869_CLK_DELAY_STEP;
 	}
 
 	return 0;
-- 
2.30.2

