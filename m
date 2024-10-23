Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F079CFA466
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 20:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45398919C;
	Wed, 23 Oct 2024 22:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A538919D; Wed, 23 Oct 2024 22:29:19 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1CFD891A5
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 22:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1t3hya-001CNZ-09;
 Wed, 23 Oct 2024 20:29:04 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/4] imx: power-domain: Convert to use livetree API for fdt
 access
Date: Wed, 23 Oct 2024 13:28:53 -0700
Message-Id: <20241023202855.1571188-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023202855.1571188-1-tharvey@gateworks.com>
References: <20241023202855.1571188-1-tharvey@gateworks.com>
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

Convert to using livetree API functions.

Without this if livetree is enabled (OF_LIVE) the imx8m-power-domain
driver will (silently) fail to probe its children leaving you with
no power domain support causing issues with certain devices.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/power/domain/imx8m-power-domain.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index 8b6870c86463..c22fbe60675e 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -456,25 +456,22 @@ static int imx8m_power_domain_of_xlate(struct power_domain *power_domain,
 
 static int imx8m_power_domain_bind(struct udevice *dev)
 {
-	int offset;
+	ofnode subnode;
 	const char *name;
 	int ret = 0;
 
-	offset = dev_of_offset(dev);
-	for (offset = fdt_first_subnode(gd->fdt_blob, offset); offset > 0;
-	     offset = fdt_next_subnode(gd->fdt_blob, offset)) {
+	ofnode_for_each_subnode(subnode, dev_ofnode(dev)) {
 		/* Bind the subnode to this driver */
-		name = fdt_get_name(gd->fdt_blob, offset, NULL);
+		name = ofnode_get_name(subnode);
 
 		/* Descend into 'pgc' subnode */
 		if (!strstr(name, "power-domain")) {
-			offset = fdt_first_subnode(gd->fdt_blob, offset);
-			name = fdt_get_name(gd->fdt_blob, offset, NULL);
+			subnode = ofnode_first_subnode(subnode);
+			name = ofnode_get_name(subnode);
 		}
-
 		ret = device_bind_with_driver_data(dev, dev->driver, name,
 						   dev->driver_data,
-						   offset_to_ofnode(offset),
+						   subnode,
 						   NULL);
 
 		if (ret == -ENODEV)
@@ -514,8 +511,7 @@ static int imx8m_power_domain_of_to_plat(struct udevice *dev)
 	struct imx_pgc_domain_data *domain_data =
 		(struct imx_pgc_domain_data *)dev_get_driver_data(dev);
 
-	pdata->resource_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					    "reg", -1);
+	pdata->resource_id = ofnode_read_u32_default(dev_ofnode(dev), "reg", -1);
 	pdata->domain = &domain_data->domains[pdata->resource_id];
 	pdata->regs = domain_data->pgc_regs;
 	pdata->base = dev_read_addr_ptr(dev->parent);
-- 
2.25.1

