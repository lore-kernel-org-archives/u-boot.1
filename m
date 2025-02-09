Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C38C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 23:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC97809A4;
	Mon, 10 Feb 2025 00:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cBEwxhIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B077680548; Mon, 10 Feb 2025 00:28:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210AF805C2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 00:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e522=VB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1739143694; bh=IQsKD6QrE0vLs8S8TwUUqhF1IhL0CImsyc5Ad3Ph/JI=;
 b=cBEwxhIq33WFJ0f1eaOIMLSETrjh1+U089OwD/9N8GVivgXj7Dgv24DrFQwJ7NNR4cMi6a5pU
 oH3T896pupSDwteyamMrebyqjtwPipSKxtDISKErCIc2+Wr9r92ktsSrdDp1IldNFSjdOTjPBo3
 nPyZSioI5f7OidaggsyPeTX7Ez9zrssstrf8yEn2WZcVGVJ1G74P7rkt2OZ9yrYso+uF8EpM5Ct
 keIRhzIo01Vin7Bpvhi/pD6kLpG//36wOgi6ohA0LDpDRq+iEpNhGkpv6wYuMggKLKEHMT1b+QU
 W9Xb4uVx/0BVDhSff0WQ20ZfDuuGaKaFiahkcmFHMyJw==
X-Forward-Email-ID: 67a93a0d6e258c2c4c42a514
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay for
 RK3588
Date: Sun,  9 Feb 2025 23:27:56 +0000
Message-ID: <20250209232801.3185681-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209232801.3185681-1-jonas@kwiboo.se>
References: <20250209232801.3185681-1-jonas@kwiboo.se>
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

When rgmii-rxid/txid/id phy-mode is used the MAC should not add RX
and/or TX delay. Currently RX/TX delay is configured as enabled using
zero as delay value for the rgmii-rxid/txid/id modes.

Change to disable RX and/or TX delay and using zero as delay value.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos_rockchip.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index 3e10e07403c1..f3a0f63003ea 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -134,6 +134,10 @@ static int rk3568_set_gmac_speed(struct udevice *dev)
 	return 0;
 }
 
+#define RK3588_DELAY_ENABLE(id, tx, rx) \
+	(((tx) ? RK3588_GMAC_TXCLK_DLY_ENABLE(id) : RK3588_GMAC_TXCLK_DLY_DISABLE(id)) | \
+	 ((rx) ? RK3588_GMAC_RXCLK_DLY_ENABLE(id) : RK3588_GMAC_RXCLK_DLY_DISABLE(id)))
+
 /* sys_grf */
 #define RK3588_GRF_GMAC_CON7			0x031c
 #define RK3588_GRF_GMAC_CON8			0x0320
@@ -192,8 +196,7 @@ static int rk3588_set_to_rgmii(struct udevice *dev,
 		     RK3588_GMAC_CLK_RGMII_MODE(id));
 
 	regmap_write(data->grf, RK3588_GRF_GMAC_CON7,
-		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
-		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
+		     RK3588_DELAY_ENABLE(id, tx_delay, rx_delay));
 
 	regmap_write(data->grf, offset_con,
 		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
-- 
2.48.1

