Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03BDD3B988
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 12:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0324489C6F;
	Tue, 26 Nov 2024 13:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hnSEigti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62DB89C70; Tue, 26 Nov 2024 13:03:51 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A81C89C79
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 13:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQC3XSs098421;
 Tue, 26 Nov 2024 06:03:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732622613;
 bh=3ESgzl35en0A4BJXZYNCumIeJ8oVRjpYzdVn7Z/oayo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hnSEigtiDrWCgRk07TfmzZ7MXki3/fIbfPYQz9xz/s4mTP4oRwZUa5iGpmTUPSePv
 j4QXiCQwgDylYAttNgz6PWSO3oXL3R7ZoOGjfYMEonGKegTuJbo33FtVvHWYE4ngKw
 FfekXA3oBadhVSfpf68jun4TkqSVQsM1zp6npeTM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQC3XAJ023923
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 06:03:33 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 06:03:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 06:03:33 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQC3N2t051888;
 Tue, 26 Nov 2024 06:03:28 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <marex@denx.de>,
 <hnagalla@ti.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <jan.kiszka@siemens.com>, <jonas@kwiboo.se>, <j-humphreys@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
Date: Tue, 26 Nov 2024 17:33:18 +0530
Message-ID: <20241126120322.1760862-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126120322.1760862-1-s-vadapalli@ti.com>
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
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

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2ab41cbae45..55e62b35c61 100644
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
@@ -62,7 +63,7 @@ static int dwc3_generic_probe(struct udevice *dev,
 
 	dwc3->dev = dev;
 	dwc3->maximum_speed = plat->maximum_speed;
-	dwc3->dr_mode = plat->dr_mode;
+	dwc3->dr_mode = mode;
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 	dwc3_of_parse(dwc3);
 
@@ -197,7 +198,7 @@ static int dwc3_generic_peripheral_probe(struct udevice *dev)
 {
 	struct dwc3_generic_priv *priv = dev_get_priv(dev);
 
-	return dwc3_generic_probe(dev, priv);
+	return dwc3_generic_probe(dev, priv, USB_DR_MODE_PERIPHERAL);
 }
 
 static int dwc3_generic_peripheral_remove(struct udevice *dev)
@@ -241,7 +242,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
 	int rc;
 
-	rc = dwc3_generic_probe(dev, &priv->gen_priv);
+	rc = dwc3_generic_probe(dev, &priv->gen_priv, USB_DR_MODE_HOST);
 	if (rc)
 		return rc;
 
-- 
2.43.0

