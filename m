Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC23CCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 05:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29ED83710;
	Fri, 17 Oct 2025 07:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZEIL8RDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6126B83775; Fri, 17 Oct 2025 07:25:31 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5656983835
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 07:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59H5PN2H2189311;
 Fri, 17 Oct 2025 00:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760678723;
 bh=D2XOxTDO1MVaitiVu/dc8ZF7dGYU9RByGZxosbnrrmo=;
 h=From:To:CC:Subject:Date;
 b=ZEIL8RDguqhqsscseo5wz6PHGsl9hyjIsMKXWhHM9DhU+pPdzn/DGkjLwOdpoYMdv
 vCZFpkjEsHmLviPWIr2oy4W/cqm+y9nsnLeBVgeWFcYpMjSKo0B/BfxzaLxQrJ6Vel
 mZ4iQp3CGCWAwGDZfFdH1DhUnZOf7P86KLF/eY+k=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59H5PN2x1756531
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 00:25:23 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 00:25:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 00:25:22 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59H5PKwR756200;
 Fri, 17 Oct 2025 00:25:20 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <andrew.goodbody@linaro.org>
CC: <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, <h-salunke@ti.com>,
 <danishanwar@ti.com>
Subject: [PATCH] phy: ti: phy-j721e-wiz: Allow reinitialization when SERDES is
 pre-configured
Date: Fri, 17 Oct 2025 10:55:19 +0530
Message-ID: <20251017052519.2632922-1-h-salunke@ti.com>
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

Move the SERDES configuration check after clock and reset initialization
and change it from a hard failure to a skip of WIZ initialization. This
allows the driver to probe successfully when the SERDES has been
pre-configured by a previous boot stage (e.g., ROM or SPL).

This approach aligns with how the Linux kernel handles pre-configured
SERDES, where the driver gracefully skips reinitialization rather than
failing to probe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on commit
4e4a9de31de Merge branch 'next' of git://source.denx.de/u-boot-usb into next

 drivers/phy/ti/phy-j721e-wiz.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 6e2d4bc2b05..eaf68d18f3a 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1180,6 +1180,7 @@ static int j721e_wiz_probe(struct udevice *dev)
 	ofnode node;
 	struct regmap *regmap;
 	u32 num_lanes;
+	bool already_configured = false;
 
 	node = get_child_by_name(dev, "serdes");
 
@@ -1243,15 +1244,6 @@ static int j721e_wiz_probe(struct udevice *dev)
 		goto err_addr_to_resource;
 	}
 
-	for (i = 0; i < wiz->num_lanes; i++) {
-		regmap_field_read(wiz->p_enable[i], &val);
-		if (val & (P_ENABLE | P_ENABLE_FORCE)) {
-			dev_err(dev, "SERDES already configured\n");
-			rc = -EBUSY;
-			goto err_addr_to_resource;
-		}
-	}
-
 	rc = j721e_wiz_bind_of_clocks(wiz);
 	if (rc) {
 		dev_err(dev, "Failed to bind clocks\n");
@@ -1270,10 +1262,21 @@ static int j721e_wiz_probe(struct udevice *dev)
 		goto err_addr_to_resource;
 	}
 
-	rc = wiz_init(wiz);
-	if (rc) {
-		dev_err(dev, "WIZ initialization failed\n");
-		goto err_addr_to_resource;
+	for (i = 0; i < wiz->num_lanes; i++) {
+		regmap_field_read(wiz->p_enable[i], &val);
+		if (val & (P_ENABLE | P_ENABLE_FORCE)) {
+			dev_info(dev, "SERDES already configured, skipping wiz initialization\n");
+			already_configured = true;
+			break;
+		}
+	}
+
+	if (!already_configured) {
+		rc = wiz_init(wiz);
+		if (rc) {
+			dev_err(dev, "WIZ initialization failed\n");
+			goto err_addr_to_resource;
+		}
 	}
 
 	return 0;
-- 
2.34.1

