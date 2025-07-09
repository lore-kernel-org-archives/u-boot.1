Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB8C83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 15:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D7D83535;
	Wed,  9 Jul 2025 17:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEF883423; Wed,  9 Jul 2025 17:36:30 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5EE6832BC
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 17:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uZWqP-008cpJ-7W;
 Wed, 09 Jul 2025 15:36:25 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [v2 PATCH 1/2] usb: common: allow dr_mode to come from gpio-id based
 usb-connector
Date: Wed,  9 Jul 2025 08:36:22 -0700
Message-Id: <20250709153623.3038697-1-tharvey@gateworks.com>
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
v2
 - do not display error if 'port' node not found
 - change print to debug
---
 drivers/usb/common/common.c | 94 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 13e9a61072a9..85865712bfcc 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -8,6 +8,7 @@
 
 #include <dm.h>
 #include <asm/global_data.h>
+#include <asm/gpio.h>
 #include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
@@ -22,6 +23,97 @@ static const char *const usb_dr_modes[] = {
 	[USB_DR_MODE_OTG]		= "otg",
 };
 
+/**
+ * get_remote_node_from_graph - Resolve the remote node from a graph binding
+ * @node: Starting ofnode (e.g., connector)
+ * @port_id: Port unit address (e.g., 0 for port@0, or -1 for first port)
+ * @endpoint_id: Endpoint unit address (e.g., 0 for endpoint@0, or -1 for first endpoint)
+ * Return: ofnode of the remote node, or ofnode_null() on failure
+ */
+static ofnode get_remote_node_from_graph(ofnode node, int port_id, int endpoint_id)
+{
+	ofnode port_node, endpoint_node, remote_node;
+	u32 phandle_value;
+	char port_name[16];
+	char endpoint_name[16];
+
+	/* Validate the starting node */
+	if (!ofnode_valid(node)) {
+		debug("Invalid starting node\n");
+		return ofnode_null();
+	}
+
+	/* Construct port name (e.g., "port" or "port@0") */
+	if (port_id == -1)
+		strcpy(port_name, "port");
+	else
+		snprintf(port_name, sizeof(port_name), "port@%d", port_id);
+
+	/* look for a 'port' node */
+	port_node = ofnode_find_subnode(node, port_name);
+	if (!ofnode_valid(port_node))
+		return ofnode_null();
+
+	/* Construct endpoint name (e.g., "endpoint" or "endpoint@0") */
+	if (endpoint_id == -1)
+		strcpy(endpoint_name, "endpoint");
+	else
+		snprintf(endpoint_name, sizeof(endpoint_name), "endpoint@%d", endpoint_id);
+
+	/* Find the 'endpoint' node */
+	endpoint_node = ofnode_find_subnode(port_node, endpoint_name);
+	if (!ofnode_valid(endpoint_node)) {
+		printf("No '%s' node found under '%s'\n", endpoint_name, port_name);
+		return ofnode_null();
+	}
+
+	/* Read the remote-endpoint phandle */
+	phandle_value = ofnode_read_u32_default(endpoint_node, "remote-endpoint", 0);
+	if (phandle_value == 0) {
+		printf("No valid 'remote-endpoint' phandle in '%s'\n", endpoint_name);
+		return ofnode_null();
+	}
+
+	/* Resolve the phandle to the remote node */
+	remote_node = ofnode_get_by_phandle(phandle_value);
+	if (!ofnode_valid(remote_node)) {
+		printf("Failed to resolve phandle %u\n", phandle_value);
+		return ofnode_null();
+	}
+
+	return remote_node;
+}
+
+static enum usb_dr_mode get_connector_drmode(ofnode node)
+{
+	struct gpio_desc id;
+	enum usb_dr_mode dr_mode = USB_DR_MODE_OTG;
+	ofnode conn;
+
+	/* get remote endpoint */
+	conn = get_remote_node_from_graph(node, -1, -1);
+	/* get port endpoint */
+	if (ofnode_valid(conn))
+		conn = ofnode_get_parent(conn);
+	/* get connector */
+	if (ofnode_valid(conn))
+		conn = ofnode_get_parent(conn);
+	if (ofnode_valid(conn) &&
+	    ofnode_device_is_compatible(conn, "gpio-usb-b-connector") &&
+	    !gpio_request_by_name_nodev(conn, "id-gpios", 0, &id, GPIOD_IS_IN)) {
+		if (dm_gpio_get_value(&id))
+			dr_mode = USB_DR_MODE_PERIPHERAL;
+		else
+			dr_mode = USB_DR_MODE_HOST;
+		gpio_free_list_nodev(&id, 1);
+		pr_debug("%s got dr_mode from connector %s dr_mode=%s\n", __func__,
+			 ofnode_get_name(node),
+			 dr_mode == USB_DR_MODE_HOST ? "host" : "peripheral");
+	}
+
+	return dr_mode;
+}
+
 enum usb_dr_mode usb_get_dr_mode(ofnode node)
 {
 	const char *dr_mode;
@@ -35,7 +127,7 @@ enum usb_dr_mode usb_get_dr_mode(ofnode node)
 
 	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
 		if (!strcmp(dr_mode, usb_dr_modes[i]))
-			return i;
+			return (i == USB_DR_MODE_OTG) ?  get_connector_drmode(node) : i;
 
 	return USB_DR_MODE_UNKNOWN;
 }
-- 
2.25.1

