Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45D1C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 16:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95648881A0;
	Tue,  2 Apr 2024 18:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wA2hLZ0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A8A88818C; Tue,  2 Apr 2024 18:09:17 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBCB87CB7
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 18:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432G9AoW108153;
 Tue, 2 Apr 2024 11:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712074150;
 bh=V35Z4UJklFQUrTOl7i1yFIWsx8LT66ZDMyo9VZHGMjg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wA2hLZ0W1QGPotfkUbYtwMIxv4gYIDSW/hOMZ8NbUPH0TBE3GDaWKeiWqIydsM9hn
 gIR126ZympMSgWJDC5PyMZlp0yVc3prPs2sIm0Zfv7Ndog1fVdW/703mgObCqk4lOh
 grYBYz1n/Bfw68raAjFxf9bH6XUumbp0rTofv7+c=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432G9AHI007948
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Apr 2024 11:09:10 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 11:09:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 11:09:10 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432G99qS029595;
 Tue, 2 Apr 2024 11:09:10 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] firmware: ti_sci: Bind sysreset driver when enabled
Date: Tue, 2 Apr 2024 11:09:07 -0500
Message-ID: <20240402160908.508974-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402160908.508974-1-afd@ti.com>
References: <20240402160908.508974-1-afd@ti.com>
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

The sysreset TI-SCI API is available with TI-SCI always, there is no need
for a DT node to describe the availability of this. If the sysreset driver
is available then bind it during ti-sci probe.

Remove the unneeded device tree matching.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/firmware/ti_sci.c          | 7 +++++++
 drivers/sysreset/sysreset-ti-sci.c | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ee092185588..6c581b9df9c 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -16,6 +16,7 @@
 #include <dm/device.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <dm/lists.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/err.h>
@@ -2840,6 +2841,12 @@ static int ti_sci_probe(struct udevice *dev)
 
 	INIT_LIST_HEAD(&info->dev_list);
 
+	if (IS_ENABLED(CONFIG_SYSRESET_TI_SCI)) {
+		ret = device_bind_driver(dev, "ti-sci-sysreset", "sysreset", NULL);
+		if (ret)
+			dev_warn(dev, "cannot bind SYSRESET (ret = %d)\n", ret);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/sysreset/sysreset-ti-sci.c b/drivers/sysreset/sysreset-ti-sci.c
index 5fc05c46cb0..0de132633a8 100644
--- a/drivers/sysreset/sysreset-ti-sci.c
+++ b/drivers/sysreset/sysreset-ti-sci.c
@@ -60,15 +60,9 @@ static struct sysreset_ops ti_sci_sysreset_ops = {
 	.request = ti_sci_sysreset_request,
 };
 
-static const struct udevice_id ti_sci_sysreset_of_match[] = {
-	{ .compatible = "ti,sci-sysreset", },
-	{ /* sentinel */ },
-};
-
 U_BOOT_DRIVER(ti_sci_sysreset) = {
 	.name = "ti-sci-sysreset",
 	.id = UCLASS_SYSRESET,
-	.of_match = ti_sci_sysreset_of_match,
 	.probe = ti_sci_sysreset_probe,
 	.priv_auto	= sizeof(struct ti_sci_sysreset_data),
 	.ops = &ti_sci_sysreset_ops,
-- 
2.39.2

