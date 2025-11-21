Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D64CFC296
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B8883ABF;
	Fri, 21 Nov 2025 18:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bvVM3vsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8BB83A5A; Fri, 21 Nov 2025 18:38:02 +0100 (CET)
Received: from mx-relay49-hz3.antispameurope.com
 (mx-relay49-hz3.antispameurope.com [94.100.134.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61647839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=QFn2YsuG16yKusOZ0k0jyvYz3t+dPQyjF3HPsF3Ft4s=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746679;
 b=B7tTHTDNRDCCZ8vWf0s454pcXPvPXwljbelte10ebRiWiKKM3Aty4/pNdx0JpbpT4Yjye1T+
 4DDTZpHoGxiiuOWkZUuPv5MrgUvbY4GuNaRri8mC6gLFQRP/3CS2sIsu7AhKxclFljSbPIR1XG9
 QWg0dj2kbloAaSCmS8CzNFKQrOAn067OsSTkEE2h/S/Ixh85GwS5SjW4KrpzrnX7lFRbtlCZMCN
 qzFozjzqMr/a8NDxeDV9xZssLHP409kAb626R0U3Jl0UerIEmsgxXyCWjXyHokbXHJCN3bk6kFP
 HRiGuiSciQSVy86PiCYWL9T1AZ99FGSLWynxlTIwPw5uQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746679;
 b=jRo4G8CKKfcRrArJaOKXxz9o5F/DdH8RfsYt3zFRhUA5UGL0vNYJhc2WC9wso/Kqhb8l28e2
 Lp+aw1RJSSznaSKEgKt0X3d1yCTTVGLi1YfJzVd4rNrAhn+i8nsqiBqIEIKtJWvvMkM9T0CJlBW
 bRgeiq3xxLNaaZxDFllUua8H4P70P6NM/H+EC4uA0GfOS9QjRsBzm4G0MMtK/x353V/ZDie5zTm
 mLN6lLZKVm3LfREBV97XKrGGzLPvghMvZ6+/zIfhTA+rV/3YHorcqiAlBoR70GX/jc5Yn1YgcCg
 wrGV7lQt6Yz2edLLKNeLwLCgw9vYNEdWcYAzcReYKybOw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay49-hz3.antispameurope.com; Fri, 21 Nov 2025 18:37:59 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 33FC7A404C3;
 Fri, 21 Nov 2025 18:37:37 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Fabio Estevam <festevam@denx.de>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 6/8] net: fec_mxc: fix usage of DM_MDIO and DM_ETH_PHY
Date: Fri, 21 Nov 2025 18:34:46 +0100
Message-Id: <20251121173505.6235-7-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
References: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay49-hz3.antispameurope.com with 4dCj8x626Tz3yZCX
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 378765e1ef6b98a6ce7ade9a13dc460d
X-cloud-security: scantime:2.109
DKIM-Signature: a=rsa-sha256;
 bh=QFn2YsuG16yKusOZ0k0jyvYz3t+dPQyjF3HPsF3Ft4s=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746678; v=1;
 b=bvVM3vsajIASiEgHkqfAbIez8zNx9jkM2seLxdHzSt4H7wK1ZtaYk5pAqdbWDqxtHDf+YBm4
 1pf2L+xOBCBgFJiCBHmfcSw9eaarKI6afXfZ7qRAxhhzDbnUGFCcehYSUM3XKk/wdDvzNt2qPJH
 QalcePCqCDOxdpewFo2vlVXhIqNjx+tC2ti4MeqJbmcujibOyz9WzvkIITJgRR4KkebDAUbSGjg
 MPW1LFd2PvlNyyp0/ahMbvpcqkbI/UNrFSu0Sc9TpdV7nW8G/SLZXW6m1IZWR9pnJfyqHJmMJrw
 uKlLUqeI0H0g+X+JGjJQ+0G7avPTW1YPQqubFyPZMDeVA==
X-Mailman-Approved-At: Fri, 21 Nov 2025 18:48:51 +0100
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

If DM_ETH_PHY is used and the FEC instance owns the shared MDIO bus,
eth_phy_get_mdio_bus returns NULL. If DM_MDIO bus is used, the
mdio_register API is called from dm_mdio_post_probe. Therefore the
bus should must be queried by name in this case.

For DM_MDIO case fec_mii_setspeed has already being called in
dm_fec_mdio_probe(), so skip setting this again.

Fixes: 3b8f99a3e762 ("net: fec: add support for DM_MDIO")
Fixes: e75d08821574 ("net: fec-mxc: prevent crash if no MAC address is set")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 7d1567fd88d..6789bfe2500 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -581,7 +581,7 @@ static int fecmxc_init(struct udevice *dev)
 
 	fec_reg_setup(fec);
 
-	if (fec->xcv_type != SEVENWIRE)
+	if (fec->xcv_type != SEVENWIRE && !IS_ENABLED(CONFIG_DM_MDIO))
 		fec_mii_setspeed(dev, fec->bus->priv);
 
 	/* Set Opcode/Pause Duration Register */
@@ -1363,16 +1363,26 @@ static int fecmxc_probe(struct udevice *dev)
 	priv->dev_id = dev_seq(dev);
 
 #ifdef CONFIG_DM_MDIO
+	/* If our instance manages the mdio bus, dm_fec_bind_mdio will bind, probe
+	 * and register the MDIO bus driver. To get access to the mii_dev structure
+	 * query it from the global mii_devs list.
+	 */
 	ret = dm_fec_bind_mdio(dev);
-	if (ret && ret != -ENODEV)
+	if (!ret)
+		bus = miiphy_get_dev_by_name("mdio");
+	else if (ret != -ENODEV)
 		return ret;
 #endif
 
 #ifdef CONFIG_DM_ETH_PHY
-	bus = eth_phy_get_mdio_bus(dev);
+	/* if our PHY is not on our mdio bus, this call queries the bus in case
+	 * we using the DM abstraction for shared MDIO busses.
+	 */
 	if (!bus)
-		bus = fec_get_miibus(dev, (ulong)priv->eth, dev_seq(dev));
-#else
+		bus = eth_phy_get_mdio_bus(dev);
+#endif
+
+#ifndef CONFIG_DM_MDIO
 	if (!bus) {
 		ulong regs = (ulong)priv->eth;
 
@@ -1384,8 +1394,8 @@ static int fecmxc_probe(struct udevice *dev)
 
 		bus = fec_get_miibus(dev, regs, dev_seq(dev));
 	}
+#endif /* !CONFIG_DM_MDIO */
 
-#endif /* CONFIG_DM_ETH_PHY */
 	if (!bus) {
 		ret = -ENOMEM;
 		goto err_mii;
-- 
2.34.1

