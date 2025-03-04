Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AD0C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 20:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD445812BC;
	Tue,  4 Mar 2025 21:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 029FE81298; Tue,  4 Mar 2025 21:07:38 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 15123810DC
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 21:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: QwbnwuWbReudOL0eF67G1A==
X-CSE-MsgGUID: IitW4JvfQzKsbaiwFz9DHg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 05 Mar 2025 05:07:33 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 43026400B9FE;
 Wed,  5 Mar 2025 05:07:29 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/3] net: ravb: Fix error handling in ravb_probe
Date: Tue,  4 Mar 2025 20:07:09 +0000
Message-ID: <20250304200712.92514-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
References: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
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

In ravb_probe(), we were missing a couple of things in the error
handling path:

  * We must unregister the MDIO bus before freeing the corresponding
    struct mii_dev instance to avoid the potential for use-after-free
    bugs.

  * We must free the resources acquired by clk_get_bulk() even if the
    clocks have not yet been enabled.

Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ravb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 6bd94cf6bb1b..83cf6e0d19f4 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -591,7 +591,7 @@ static int ravb_probe(struct udevice *dev)
 
 	ret = clk_get_bulk(dev, &eth->clks);
 	if (ret < 0)
-		goto err_mdio_alloc;
+		goto err_clk_get;
 
 	mdiodev = mdio_alloc();
 	if (!mdiodev) {
@@ -613,23 +613,25 @@ static int ravb_probe(struct udevice *dev)
 	/* Bring up PHY */
 	ret = clk_enable_bulk(&eth->clks);
 	if (ret)
-		goto err_mdio_register;
+		goto err_clk_enable;
 
 	ret = ravb_reset(dev);
 	if (ret)
-		goto err_mdio_reset;
+		goto err_clk_enable;
 
 	ret = ravb_phy_config(dev);
 	if (ret)
-		goto err_mdio_reset;
+		goto err_clk_enable;
 
 	return 0;
 
-err_mdio_reset:
-	clk_release_bulk(&eth->clks);
+err_clk_enable:
+	mdio_unregister(mdiodev);
 err_mdio_register:
 	mdio_free(mdiodev);
 err_mdio_alloc:
+	clk_release_bulk(&eth->clks);
+err_clk_get:
 	unmap_physmem(eth->iobase, MAP_NOCACHE);
 	return ret;
 }
-- 
2.43.0

