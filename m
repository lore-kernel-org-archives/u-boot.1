Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E35E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 17:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19B3801BF;
	Thu, 12 Dec 2024 18:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="W/wbeVNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B7B801FE; Thu, 12 Dec 2024 18:25:36 +0100 (CET)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12325801B0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 18:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20241212172533682635317660639d34 for <u-boot@lists.denx.de>;
 Thu, 12 Dec 2024 18:25:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9Kp+3JKY3GkIruGfWZm3AE5mUd4RzbiVbF5A8JxSw9o=;
 b=W/wbeVNQ/t6g0jT4PJA+XpDfc7PfAmy3lpnkGB45U5eCTehcn1ULb5W7fQYWm6kF5cZSaW
 TyApyWVfJ2Nf8s6JtUuUmsaVolJ6pzCg56RhL6lVGzYcTYfbj1bYcNL68ZpnDAhGO79OxYaz
 EPQ6TlIl2Yi5BTw0evg2oji6xxEzpUrpja6wI8xMXs92EZmDOxFdOnhdqwF1H7m8nTshdqyQ
 glpKZtP5I3BiP4ucrIV3DIbjBCKBdq2TuNaA8KoG/E4b8EtK824uqlJDt8KoDJOWau9hzDDx
 zth7h4KHV/Aeh8zoUM20MwLIpOruFxWO+uPmj+ir6BScSmsyIeXgXTVQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Heiko Schocher <hs@denx.de>
Subject: [PATCH] net: fec: phy: Don't advertise Gbit on (R)MII
Date: Thu, 12 Dec 2024 18:25:24 +0100
Message-ID: <20241212172530.2551014-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Currently if a gigabit-capable PHY is connected to FEC via RMII or MII, it
will advertise 1000FULL and 1000HALF to a link partner.

Different problems may arise here:
- usually with (R)MII between MAC and PHY the PHY's connection to magnetics
would have only 2 pairs routed as well, otherwise a PHY can negotiate 1000
speed and there will be no traffic possible;
- but even if there is no way to negotiate 1000 speed in HW (only 2 signal
pairs routed), it may take a lot of time for PHY to figure this out; in
case of AD1300 it takes 17-20 seconds, which is waay longer than default
4s PHY_ANEG_TIMEOUT.

Use phy_set_supported() in such cases to disable gigabit advertised
options.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/fec_mxc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index eca681b16d1..7d2170ae72c 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1162,6 +1162,7 @@ static int fec_phy_init(struct fec_priv *priv, struct udevice *dev)
 {
 	struct phy_device *phydev = NULL;
 	int addr;
+	int ret;
 
 	addr = device_get_phy_addr(priv, dev);
 #ifdef CFG_FEC_MXC_PHYADDR
@@ -1175,6 +1176,17 @@ static int fec_phy_init(struct fec_priv *priv, struct udevice *dev)
 	if (!phydev)
 		return -ENODEV;
 
+	switch (priv->interface) {
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_RMII:
+		ret = phy_set_supported(phydev, SPEED_100);
+		if (ret)
+			return ret;
+		break;
+	default:
+		break;
+	}
+
 	priv->phydev = phydev;
 	priv->phydev->node = priv->phy_of_node;
 	phy_config(phydev);
-- 
2.47.1

