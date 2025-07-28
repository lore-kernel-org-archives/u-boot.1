Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86988C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA2082E52;
	Mon, 28 Jul 2025 18:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306B282F00; Mon, 28 Jul 2025 18:48:19 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC4982E34
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1ugR1K-0098YX-K3;
 Mon, 28 Jul 2025 16:48:14 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 1/2] usb: common: allow dr_mode to come from gpio-id based
 usb-connector
Date: Mon, 28 Jul 2025 09:48:11 -0700
Message-Id: <20250728164812.1522111-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

If a usb host with dr_mode of "otg" has a usb-connector using a GPIO ID
pin use this to determine host vs peripheral.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
 - use function from ofnode_graph.h
 - use log_debug instead of debug and pr_debug

v2:
 - do not display error if 'port' node not found
 - change print to debug
---
 drivers/usb/common/common.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 13e9a61072a9..3c2d9b352c57 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -8,6 +8,8 @@
 
 #include <dm.h>
 #include <asm/global_data.h>
+#include <asm/gpio.h>
+#include <dm/ofnode_graph.h>
 #include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
@@ -22,6 +24,28 @@ static const char *const usb_dr_modes[] = {
 	[USB_DR_MODE_OTG]		= "otg",
 };
 
+static enum usb_dr_mode get_connector_drmode(ofnode node)
+{
+	ofnode conn = ofnode_graph_get_remote_node(node, -1, -1);
+	enum usb_dr_mode dr_mode = USB_DR_MODE_OTG;
+	struct gpio_desc id;
+
+	if (ofnode_valid(conn) &&
+	    ofnode_device_is_compatible(conn, "gpio-usb-b-connector") &&
+	    !gpio_request_by_name_nodev(conn, "id-gpios", 0, &id, GPIOD_IS_IN)) {
+		if (dm_gpio_get_value(&id))
+			dr_mode = USB_DR_MODE_PERIPHERAL;
+		else
+			dr_mode = USB_DR_MODE_HOST;
+		gpio_free_list_nodev(&id, 1);
+		log_debug("%s got dr_mode from connector %s dr_mode=%s\n", __func__,
+			  ofnode_get_name(node),
+			  dr_mode == USB_DR_MODE_HOST ? "host" : "peripheral");
+	}
+
+	return dr_mode;
+}
+
 enum usb_dr_mode usb_get_dr_mode(ofnode node)
 {
 	const char *dr_mode;
@@ -35,7 +59,7 @@ enum usb_dr_mode usb_get_dr_mode(ofnode node)
 
 	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
 		if (!strcmp(dr_mode, usb_dr_modes[i]))
-			return i;
+			return (i == USB_DR_MODE_OTG) ?  get_connector_drmode(node) : i;
 
 	return USB_DR_MODE_UNKNOWN;
 }
-- 
2.25.1

