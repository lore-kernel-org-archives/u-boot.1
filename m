Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF39C5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 17:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3007A82B5B;
	Sun,  1 Jun 2025 19:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50413829F5; Sun,  1 Jun 2025 17:42:58 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DC082103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id BCE261F0004D
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:42:55 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 354E7AC32F8; Sun,  1 Jun 2025 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 6703BAC32E3;
 Sun,  1 Jun 2025 15:40:00 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 6/6] net: sun8i-emac: Add support for active-low leds with
 internal PHY
Date: Sun,  1 Jun 2025 17:39:43 +0200
Message-ID: <20250601153943.2690123-7-contact@paulk.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601153943.2690123-1-contact@paulk.fr>
References: <20250601153943.2690123-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Jun 2025 19:14:22 +0200
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

A device-tree property is already defined to indicate that the internal
PHY should be used with active-low leds, which corresponds to a
specific bit in the dedicated syscon register.

Add support for setting this bit when the property is present.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/net/sun8i_emac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 8433e7db2654..990a184e4b1f 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -176,6 +176,7 @@ struct sun8i_eth_pdata {
 	u32 reset_delays[3];
 	int tx_delay_ps;
 	int rx_delay_ps;
+	bool leds_active_low;
 };
 
 static int sun8i_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
@@ -287,7 +288,8 @@ static void sun8i_adjust_link(struct emac_eth_dev *priv,
 	writel(v, priv->mac_reg + EMAC_CTL0);
 }
 
-static u32 sun8i_emac_set_syscon_ephy(struct emac_eth_dev *priv, u32 reg)
+static u32 sun8i_emac_set_syscon_ephy(struct sun8i_eth_pdata *pdata,
+				      struct emac_eth_dev *priv, u32 reg)
 {
 	if (priv->use_internal_phy) {
 		/* H3 based SoC's that has an Internal 100MBit PHY
@@ -295,6 +297,10 @@ static u32 sun8i_emac_set_syscon_ephy(struct emac_eth_dev *priv, u32 reg)
 		*/
 		reg &= ~H3_EPHY_DEFAULT_MASK;
 		reg |=  H3_EPHY_DEFAULT_VALUE;
+
+		if (pdata->leds_active_low)
+			reg |= H3_EPHY_LED_POL;
+
 		reg |= priv->phyaddr << H3_EPHY_ADDR_SHIFT;
 		reg &= ~H3_EPHY_SHUTDOWN;
 		return reg | H3_EPHY_SELECT;
@@ -314,7 +320,7 @@ static int sun8i_emac_set_syscon(struct sun8i_eth_pdata *pdata,
 
 	reg = readl(priv->sysctl_reg);
 
-	reg = sun8i_emac_set_syscon_ephy(priv, reg);
+	reg = sun8i_emac_set_syscon_ephy(pdata, priv, reg);
 
 	reg &= ~(SC_ETCS_MASK | SC_EPIT);
 	if (priv->variant->support_rmii)
@@ -859,6 +865,10 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
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

