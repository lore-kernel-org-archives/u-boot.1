Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AE6C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB854841CF;
	Tue,  5 Aug 2025 19:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC76841D2; Tue,  5 Aug 2025 19:53:50 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3429083885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 90E5D1F00036
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:53:47 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 1DF1EB01201; Tue,  5 Aug 2025 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id C3715B011F1;
 Tue,  5 Aug 2025 17:48:30 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 11/11] net: sun8i-emac: Add support for active-low leds
 with internal PHY
Date: Tue,  5 Aug 2025 19:48:27 +0200
Message-ID: <20250805174827.3696191-12-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805174827.3696191-1-paulk@sys-base.io>
References: <20250805174827.3696191-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

A device-tree property is already defined to indicate that the internal
PHY should be used with active-low leds, which corresponds to a
specific bit in the dedicated syscon register.

Add support for setting this bit when the property is present.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/net/sun8i_emac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 6e95392b379b..41c52f56d7a9 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -175,6 +175,7 @@ struct sun8i_eth_pdata {
 	u32 reset_delays[3];
 	int tx_delay_ps;
 	int rx_delay_ps;
+	bool leds_active_low;
 };
 
 static int sun8i_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
@@ -298,6 +299,9 @@ static int sun8i_emac_set_syscon(struct sun8i_eth_pdata *pdata,
 		reg |= priv->phyaddr << H3_EPHY_ADDR_SHIFT;
 		reg |= H3_EPHY_CLK_SEL;
 		reg |= H3_EPHY_SELECT;
+
+		if (pdata->leds_active_low)
+			reg |= H3_EPHY_LED_POL;
 	} else {
 		reg |= H3_EPHY_SHUTDOWN;
 	}
@@ -845,6 +849,10 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
 		printf("%s: Invalid RX delay value %d\n", __func__,
 		       sun8i_pdata->rx_delay_ps);
 
+	sun8i_pdata->leds_active_low =
+		fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
+				"allwinner,leds-active-low");
+
 	if (fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
 			    "snps,reset-active-low"))
 		reset_flags |= GPIOD_ACTIVE_LOW;
-- 
2.49.0

