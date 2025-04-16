Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D22AC369C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69BF082BA2;
	Wed, 16 Apr 2025 14:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rFMsKBkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FC782C96; Wed, 16 Apr 2025 14:56:59 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C4B82B5B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GCumZo2659441
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 07:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744808208;
 bh=89zxXgy5d30nG2/8vs4jbqDKJjPV7gx6ou449/J35A0=;
 h=From:To:CC:Subject:Date;
 b=rFMsKBkEgJqdPx5bKbIJbsBfarMLPs5TwO1LAGGs4Cdh5rb9EkRNEDRAacs+/KGE3
 14/JTfGAJ5/i9YdtpRBnjmYC9eX2W76Ruer9x17VMCfdMvK2/wW3j+fZov0BEtaTM0
 CfMgfWX3kd3X0/Xf1cOBVxMEUI/kWqwePL9hiSYo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GCumMh076119
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 07:56:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 07:56:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 07:56:47 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GCuiuE055204; 
 Wed, 16 Apr 2025 07:56:44 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <matthias.schiffer@ew.tq-group.com>, <richard.genoud@bootlin.com>,
 <c-vankar@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] net: ti: am65-cpsw-nuss: invoke phy_config() in driver's
 .start callback
Date: Wed, 16 Apr 2025 18:26:43 +0530
Message-ID: <20250416125643.2234165-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Currently, the phy_config() API is invoked by the driver only once since it
has been probed. While this works in general, it doesn't allow the driver
to bring the PHY back to its default reset state. As a result, the driver
might not be able to recover the PHY from a bad state. To address this,
move phy_config() into the driver's start callback (am65_cpsw_start()).

Apart from providing the means to recover the PHY in the event of failure,
the implementation is in line with the idea of "reset and configure" that
is already followed by am65_cpsw_start() when it comes to programming the
CPSW MAC.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
f892a7f397a Revert "Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE""
of the next branch of U-Boot.

Regards,
Siddharth.

 drivers/net/ti/am65-cpsw-nuss.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 3c62fc0b428..9b69f36d04d 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -438,6 +438,12 @@ static int am65_cpsw_start(struct udevice *dev)
 		       port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_REG);
 	}
 
+	ret = phy_config(priv->phydev);
+	if (ret < 0) {
+		dev_err(dev, "phy_config failed: %d", ret);
+		goto err_dis_rx;
+	}
+
 	ret = phy_startup(priv->phydev);
 	if (ret) {
 		dev_err(dev, "phy_startup failed\n");
@@ -639,9 +645,6 @@ static int am65_cpsw_phy_init(struct udevice *dev)
 	phydev->advertising = phydev->supported;
 
 	priv->phydev = phydev;
-	ret = phy_config(phydev);
-	if (ret < 0)
-		dev_err(dev, "phy_config() failed: %d", ret);
 
 	return ret;
 }
-- 
2.34.1

