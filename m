Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F1BCE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8643788FE4;
	Thu, 24 Oct 2024 17:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9EE488FE2; Thu, 24 Oct 2024 17:26:11 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 98C3688FAC
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="222903832"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:52 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 07B6E40065A3;
 Fri, 25 Oct 2024 00:25:38 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 10/14] net: ravb: Simplify max-speed handling in
 ravb_of_to_plat
Date: Thu, 24 Oct 2024 16:24:44 +0100
Message-Id: <20241024152448.102-11-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
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

We can call dev_read_u32_default() instead of calling fdt_getprop() then
fdt32_to_cpu().

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ravb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 9b33ce929618..fb869cd0872e 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -676,10 +676,7 @@ int ravb_of_to_plat(struct udevice *dev)
 	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA)
 		return -EINVAL;
 
-	pdata->max_speed = 1000;
-	cell = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), "max-speed", NULL);
-	if (cell)
-		pdata->max_speed = fdt32_to_cpu(*cell);
+	pdata->max_speed = dev_read_u32_default(dev, "max-speed", 1000);
 
 	pdata->priv_pdata = &bb_miiphy_buses[bb_miiphy_index];
 	sprintf(bb_miiphy_buses[bb_miiphy_index++].name, dev->name);
-- 
2.43.0

