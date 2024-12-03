Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DFBD49797
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4BA8964A;
	Tue,  3 Dec 2024 10:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w8hEClCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02E4989637; Tue,  3 Dec 2024 10:38:08 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A12F8962E
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B39bwnQ1866575
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Dec 2024 03:37:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733218678;
 bh=YyJsyWb2FzdhH2pqkHwdba2JSFKV9DDs45d53qTVAGI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=w8hEClCxoiM3cHpyXSOYqqUmXPbrRgN+lkAc8Nbj/UP5EOae2tnvYCr+NIS+zzipE
 HHutz9PoBtVgT6ATUG8ZzASpiXwseWBo8i1HLDwrLIuHOTOsVvEAnzn8hVdNI25zz7
 MkL1Ez55Xkdokjd4nPvAMuG7BAfiWmRd6A05yvo0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B39bwjG073032
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Dec 2024 03:37:58 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 03:37:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 03:37:57 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B39bnbr032386;
 Tue, 3 Dec 2024 03:37:54 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <marex@denx.de>,
 <hnagalla@ti.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <jan.kiszka@siemens.com>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
Date: Tue, 3 Dec 2024 15:07:44 +0530
Message-ID: <20241203093748.138260-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203093748.138260-1-s-vadapalli@ti.com>
References: <20241203093748.138260-1-s-vadapalli@ti.com>
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

There are only two callers of "dwc3_generic_probe()", namely:
1. dwc3_generic_peripheral_probe()
2. dwc3_generic_host_probe()
Currently, the "mode" is set based on the device-tree node of the
platform device. Also, the DWC3 core doesn't support updating the "mode"
dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
separate mode in itself, rather than being treated as a mode which should
eventually lead to "host"/"peripheral".

Given that the callers of "dwc3_generic_probe()" clarify the expected
"mode" of the USB Controller, use that "mode" instead of the one
specified in the device-tree. This shall allow the USB Controller to
function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
in the device-tree, based on the caller of "dwc3_generic_probe()".

Ideally, the USB ID pin should be used to determine whether or not the
requested role can be enabled. However, that can be implemented in the
future as an incremental feature over the current implementation.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://patchwork.ozlabs.org/project/uboot/list/?series=434253&state=%2A&archive=both
Changes since v1:
- Based on the feedback received on the v1 series, the device-tree
  specified role is also taken into account in dwc3_generic_probe(), in
  addition to the caller of dwc3_generic_probe().

 drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2ab41cbae45..fe98b50c42c 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
 };
 
 static int dwc3_generic_probe(struct udevice *dev,
-			      struct dwc3_generic_priv *priv)
+			      struct dwc3_generic_priv *priv,
+			      enum usb_dr_mode mode)
 {
 	int rc;
 	struct dwc3_generic_plat *plat = dev_get_plat(dev);
@@ -62,7 +63,19 @@ static int dwc3_generic_probe(struct udevice *dev,
 
 	dwc3->dev = dev;
 	dwc3->maximum_speed = plat->maximum_speed;
-	dwc3->dr_mode = plat->dr_mode;
+
+	/*
+	 * If the controller supports OTG as indicated by plat->dr_mode,
+	 * then either Host or Peripheral mode is acceptable.
+	 * Otherwise, error out since the platform cannot support the mode
+	 * being requested by the caller of dwc3_generic_probe().
+	 */
+	if (plat->dr_mode != mode && plat->dr_mode != USB_DR_MODE_OTG) {
+		pr_err("Requested usb mode is not supported by platform\n");
+		return -EINVAL;
+	}
+	dwc3->dr_mode = mode;
+
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 	dwc3_of_parse(dwc3);
 
@@ -197,7 +210,7 @@ static int dwc3_generic_peripheral_probe(struct udevice *dev)
 {
 	struct dwc3_generic_priv *priv = dev_get_priv(dev);
 
-	return dwc3_generic_probe(dev, priv);
+	return dwc3_generic_probe(dev, priv, USB_DR_MODE_PERIPHERAL);
 }
 
 static int dwc3_generic_peripheral_remove(struct udevice *dev)
@@ -241,7 +254,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
 	int rc;
 
-	rc = dwc3_generic_probe(dev, &priv->gen_priv);
+	rc = dwc3_generic_probe(dev, &priv->gen_priv, USB_DR_MODE_HOST);
 	if (rc)
 		return rc;
 
-- 
2.43.0

