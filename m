Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB00C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 12:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDA687D33;
	Tue,  2 Jul 2024 14:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h5Rza/82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BDC87837; Tue,  2 Jul 2024 14:07:46 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA918824C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 14:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 462C7TD4039831;
 Tue, 2 Jul 2024 07:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719922049;
 bh=u+RwEsMG2ovLIGCtmDf0KKFh5k6xuQBwWyivnutCfxE=;
 h=From:To:CC:Subject:Date;
 b=h5Rza/82xvzBvrLau/NVzrw5sXPv+xOnq0vfJjQBxfaiaTJQ7u1psUu+FbnNUMBHm
 ULTACGnJWI6iEtbyTZW2V13xFoUTqrUzjWi3vAr5RGJ3Qx9ZpMKlC+z1ZSJL9/WORg
 Fd6mq6vBfb3dGGPWmA6xV5HX8NhluSIJY2f9dpdw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 462C7TIb023110
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jul 2024 07:07:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 07:07:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 07:07:28 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 462C7Pen054812; 
 Tue, 2 Jul 2024 07:07:25 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>, <rogerq@kernel.org>,
 <mkorpershoek@baylibre.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <danishanwar@ti.com>,
 <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] usb: cdns3: continue probe even when USB PHY device does not
 exist
Date: Tue, 2 Jul 2024 17:37:24 +0530
Message-ID: <20240702120724.368102-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
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

Prior to commit cd295286c786 ("usb: cdns3: avoid error messages if phys
don't exist"), cdns3_probe() errors out only on failing to initialize the
USB2/USB3 PHY. However, since commit cd295286c786, absence of the PHY
device is also treated as an error, resulting in a regression.

Extend commit cd295286c786 to treat -ENODEV as an acceptable return value
of generic_phy_get_by_name() and continue device probe as was the case
prior to the commit.

Fixes: cd295286c786 ("usb: cdns3: avoid error messages if phys don't exist")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
b4cbd1a257 Merge tag 'u-boot-amlogic-20240701' of https://source.denx.de/u-boot/custodians/u-boot-amlogic into next
of the next branch of U-Boot.

Regards,
Siddharth.

 drivers/usb/cdns3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index b4e931646b..5b3e32953e 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -338,7 +338,7 @@ static int cdns3_probe(struct cdns3 *cdns)
 			dev_err(dev, "USB2 PHY init failed: %d\n", ret);
 			return ret;
 		}
-	} else if (ret != -ENOENT && ret != -ENODATA) {
+	} else if (ret != -ENOENT && ret != -ENODATA && ret != -ENODEV) {
 		dev_err(dev, "Couldn't get USB2 PHY:  %d\n", ret);
 		return ret;
 	}
@@ -350,7 +350,7 @@ static int cdns3_probe(struct cdns3 *cdns)
 			dev_err(dev, "USB3 PHY init failed: %d\n", ret);
 			return ret;
 		}
-	} else if (ret != -ENOENT && ret != -ENODATA) {
+	} else if (ret != -ENOENT && ret != -ENODATA && ret != -ENODEV) {
 		dev_err(dev, "Couldn't get USB3 PHY:  %d\n", ret);
 		return ret;
 	}
-- 
2.40.1

