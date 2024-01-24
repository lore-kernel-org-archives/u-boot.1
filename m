Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36711C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 09:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9939A8793F;
	Wed, 24 Jan 2024 10:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IqmEShBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8B187BDB; Wed, 24 Jan 2024 10:07:18 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B95F87752
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 10:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O97Cba073987;
 Wed, 24 Jan 2024 03:07:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706087232;
 bh=ygNbFrxXAKg1EACyRSLIi7L/i5kCY7qBMWbR2EfbgOE=;
 h=From:To:CC:Subject:Date;
 b=IqmEShBkDD2y3ZZxzC3/aO8i/FdY9lO2h0awwfYr0YTVLtFGvgEcc47b73PsITueh
 Pta3ThRCLxf+jHB/sTSnsxYwwHZbFwqkrO0smS2xuvGFDJ2H06C44YC+uxKuWiz+sc
 3+IEMJQ/oOsDBy3QFfmErxqJeyqNJZRZZjGEDPzI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O97CGd019233
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 03:07:12 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 03:07:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 03:07:12 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O97B7o126996;
 Wed, 24 Jan 2024 03:07:12 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <n-jain1@ti.com>, <agust@denx.de>
CC: <sjg@chromium.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <a-bhatia1@ti.com>, <j-luthra@ti.com>, <nsekhar@ti.com>, <devarsht@ti.com>
Subject: [PATCH] video: tidss: Use DT property names for parsing nodes
Date: Wed, 24 Jan 2024 14:37:11 +0530
Message-ID: <20240124090711.305690-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Use device-tree node property names for parsing nodes instead of
indexing as indexing could be different between different SoCs based on
number of DSS entities available on that particular SoC.

Also correct the video layer naming in driver to match to actual one
being used in upstream DSS device-tree node [1].

This also fixes AM62x splash screen usage using the latest upstream DSS
device-tree nodes where hard-coded indexing which driver was using
before this patch was not matching the correct properties in the DT
node.

[1]: Upstream AM62x DSS node:
https://github.com/torvalds/linux/blob/v6.8-rc1/arch/arm64/boot/dts/ti/k3-am62-main.dtsi#L774

Fixes: 5f9f816bb8 ("drivers: video: tidss: TIDSS video driver support
for AM62x")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/video/tidss/tidss_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index e285f255d7..1380c6b693 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -107,7 +107,7 @@ const struct dss_features dss_am625_feats = {
 
 	.num_planes = 2,
 	/* note: vid is plane_id 0 and vidl1 is plane_id 1 */
-	.vid_name = { "vidl1", "vid1" },
+	.vid_name = { "vidl1", "vid" },
 	.vid_lite = { true, false },
 	.vid_order = { 1, 0 },
 };
@@ -814,13 +814,13 @@ static int tidss_drv_probe(struct udevice *dev)
 		priv->bus_format = &dss_bus_formats[8];
 
 	/* Common address */
-	priv->base_common = dev_remap_addr_index(dev, 0);
+	priv->base_common = dev_remap_addr_name(dev, priv->feat->common);
 	if (!priv->base_common)
 		return -EINVAL;
 
 	/* plane address setup and enable */
 	for (i = 0; i < priv->feat->num_planes; i++) {
-		priv->base_vid[i] = dev_remap_addr_index(dev, i + 2);
+		priv->base_vid[i] = dev_remap_addr_name(dev, priv->feat->vid_name[i]);
 		if (!priv->base_vid[i])
 			return -EINVAL;
 	}
@@ -841,8 +841,8 @@ static int tidss_drv_probe(struct udevice *dev)
 
 	/* video port address clocks and enable */
 	for (i = 0; i < priv->feat->num_vps; i++) {
-		priv->base_ovr[i] = dev_remap_addr_index(dev, i + 4);
-		priv->base_vp[i] = dev_remap_addr_index(dev, i + 6);
+		priv->base_ovr[i] = dev_remap_addr_name(dev, priv->feat->ovr_name[i]);
+		priv->base_vp[i] = dev_remap_addr_name(dev, priv->feat->vp_name[i]);
 	}
 
 	ret = clk_get_by_name(dev, "vp1", &priv->vp_clk[0]);
-- 
2.34.1

