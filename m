Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08A7C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 13:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82BC988B75;
	Fri, 16 Aug 2024 15:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=johanneskirchmair.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=johanneskirchmair.de header.i=@johanneskirchmair.de header.b="rlVaQ3Mg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B22FC88ABF; Fri, 16 Aug 2024 10:20:11 +0200 (CEST)
Received: from mx8.mail-out.lima-city.de (mx8.mail-out.lima-city.de
 [91.216.248.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94BBB88A99
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 10:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=johanneskirchmair.de
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=mailinglist1@johanneskirchmair.de
From: mailinglist1@johanneskirchmair.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=johanneskirchmair.de;
 s=securedbylima-20161106; t=1723796395;
 bh=JQ5AlgtYulkCf8nUA0jIKHQaQtRgUEtWOpu8R05N33s=;
 h=From:To:Cc:Subject:Date:From;
 b=rlVaQ3Mgk5BWs+Kqu8xVxGwyewF3HpUyQrWfxv+aG9t6Ytg7DcUK6IhzMWFBawIDw
 ilc5JxyXE1nJnZ3uDCkMczLID8aGmZ3VMeRjQY1/AS95JrXkLmUNyG9Z7GXlZfrIcW
 XFhi2v8Sk3Pa34dPJusQqfsIeuKikV7qa/hVtupI=
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>
Subject: [PATCH] usb: add reset pin handling to onboard-hub driver
Date: Fri, 16 Aug 2024 10:19:22 +0200
Message-Id: <20240816081922.282155-1-mailinglist1@johanneskirchmair.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Aug 2024 15:36:32 +0200
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

From: Johannes Kirchmair <johannes.kirchmair@skidata.com>

Some onboard-hub chips have external reset pins. This patch adds
handling of said pin to the onboard-hub driver. The naming for the
devicetree binding is done in the same way as in the Linux kernel to
ensure good compatibility between u-boot's and Linux's devicetrees.

Signed-off-by: Johannes Kirchmair <johannes.kirchmair@skidata.com>
---
 common/usb_onboard_hub.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..5b1bb79c55 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -10,9 +10,11 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <power/regulator.h>
+#include <asm/gpio.h>
 
 struct onboard_hub {
 	struct udevice *vdd;
+	struct gpio_desc reset_pin;
 };
 
 static int usb_onboard_hub_probe(struct udevice *dev)
@@ -27,8 +29,23 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	}
 
 	ret = regulator_set_enable_if_allowed(hub->vdd, true);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &hub->reset_pin,
+				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "can't get reset-gpios 0: %d\n", ret);
+		return ret;
+	}
+
+	if (hub->reset_pin.dev) {
+		ret = dm_gpio_set_value(&hub->reset_pin, 0);
+		if (ret)
+			dev_err(dev, "failed setting reset-gpios to 0: %d\n", ret);
+	}
 
 	return ret;
 }
@@ -42,12 +59,25 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
 
+	if (hub->reset_pin.dev) {
+		ret = dm_gpio_set_value(&hub->reset_pin, 1);
+		if (ret)
+			dev_err(dev, "failed setting reset-gpios to 0: %d\n", ret);
+	}
+
+	if (hub->reset_pin.dev) {
+		ret = dm_gpio_free(dev, &hub->reset_pin);
+		if (ret)
+			dev_err(dev, "can't free reset-gpios: %d\n", ret);
+	}
+
 	return ret;
 }
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
+	{ .compatible = "usb4b4,6504" },
 	{ }
 };
 
-- 
2.34.1

