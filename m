Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41742D44171
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B60C89686;
	Wed, 20 Nov 2024 10:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6368964F; Wed, 20 Nov 2024 10:49:48 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id D5F278911A
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: ZF0j5c11R+KdRyUJJBtsEw==
X-CSE-MsgGUID: xmtn6QZdRvGhDTMZyNqDsw==
X-IronPort-AV: E=Sophos;i="6.12,169,1728918000"; d="scan'208";a="229404071"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2024 18:49:44 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.28])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1212D41A5E8D;
 Wed, 20 Nov 2024 18:49:41 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] net: ravb: Simplify max-speed handling in ravb_of_to_plat
Date: Wed, 20 Nov 2024 09:49:39 +0000
Message-Id: <20241120094939.129-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
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
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]
  - Added Marek's Reviewed-by tag

[1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/

 drivers/net/ravb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index f1401d2f6ed2..6393c3a7c3fe 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -657,10 +657,7 @@ int ravb_of_to_plat(struct udevice *dev)
 	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA)
 		return -EINVAL;
 
-	pdata->max_speed = 1000;
-	cell = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), "max-speed", NULL);
-	if (cell)
-		pdata->max_speed = fdt32_to_cpu(*cell);
+	pdata->max_speed = dev_read_u32_default(dev, "max-speed", 1000);
 
 	sprintf(bb_miiphy_buses[0].name, dev->name);
 
-- 
2.43.0

