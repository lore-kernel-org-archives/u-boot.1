Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70BBC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 23:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F7880A55;
	Mon, 10 Feb 2025 00:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Tr4GbBx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E62F80A23; Mon, 10 Feb 2025 00:28:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30FC809A4
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 00:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e522=VB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1739143696; bh=X00FmBcXStNgpTNlG+mLBpAbzCI+lFV0Njh4gF/ZOhY=;
 b=Tr4GbBx84S0tL6Eqa7Dl7Ox+KUB6BP12Y3cNcmuYNhxCh03FiTdfoW5zekEgab/+ppOzkLHxF
 uz5uATytXoM0+OHPh+1iy/cvhZb3vD/334Qfg7Y49TZlsju8FvcK3mDJM0E3Y8tzIpjKgwsQPhg
 1pNW3IiwFIeUo8C6ns0nyyoKtGRICbhEMk8oVTVI9z0m3aR6CvqHFbtIbEfLMqeF+OIxC+CtrFx
 2jZv6jQgU5hb6vdNILkadnwc/eb8JYmpmpm+uzpMedUd56S/eM61WH8LbTeSWCBr7l0BzmLFifm
 zNulUQ2xUeSs/khuDMHYyTYIc6Dpkx+k95+MM+aCUXuA==
X-Forward-Email-ID: 67a93a096e258c2c4c42a504
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
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
Subject: [PATCH 1/2] net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay for
 RK356x
Date: Sun,  9 Feb 2025 23:27:55 +0000
Message-ID: <20250209232801.3185681-2-jonas@kwiboo.se>
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
index 9fc8c686b889..3e10e07403c1 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -46,6 +46,10 @@ struct rockchip_platform_data {
 #define GRF_BIT(nr)	(BIT(nr) | BIT((nr) + 16))
 #define GRF_CLR_BIT(nr)	(BIT((nr) + 16))
 
+#define DELAY_ENABLE(soc, tx, rx) \
+	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
+	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
+
 #define RK3568_GRF_GMAC0_CON0		0x0380
 #define RK3568_GRF_GMAC0_CON1		0x0384
 #define RK3568_GRF_GMAC1_CON0		0x0388
@@ -85,8 +89,7 @@ static int rk3568_set_to_rgmii(struct udevice *dev,
 
 	regmap_write(data->grf, con1,
 		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
-		     RK3568_GMAC_RXCLK_DLY_ENABLE |
-		     RK3568_GMAC_TXCLK_DLY_ENABLE);
+		     DELAY_ENABLE(RK3568, tx_delay, rx_delay));
 
 	return 0;
 }
-- 
2.48.1

