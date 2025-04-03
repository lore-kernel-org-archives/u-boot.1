Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F3FC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C023E820B0;
	Thu,  3 Apr 2025 14:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZZKjsaQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96C881FC0; Thu,  3 Apr 2025 09:39:26 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBEC380194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BBDC4437E;
 Thu,  3 Apr 2025 07:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743665964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjsSq2YGPDJbJs+50kA3dJg9RN79jQhmYEtS2ViYJmY=;
 b=ZZKjsaQP7VVIaELeSu6ltzyBabJ3Q88pQwSK+j99MCMRBAwsi0VBNnRmhCNhx3h1TENtNG
 6RYIShHdtJR0Tm3mGQY9NHFcW9FYH3OA2LwMSiBiFoFTJFB6Cyxp33qFylXaJ3iKXxhmDV
 tG+1AMKRxtrd+Oby4PdzNGy+eGqKJvdZtWVOkoKrN4mH73cS6gEf2jV+SAFyOVRjmSoD41
 Wo6TmvRuHkd7usxgPPXHgfCjThEKTiVM8x+xYFGTEVgna0o9JhlqnnaUuwOGOWkA9gH8V8
 3O3mRJUgdWMH00BIh8m+l6GxbDhD2Ar7drzWEXuu5VoKgHmpaRHipXNSm79keQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 03 Apr 2025 09:39:03 +0200
Subject: [PATCH v6 03/12] dm: core: Add a helper to retrieve devices
 through graph endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-ge-mainline-display-support-v6-3-478b5e3dd872@bootlin.com>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrdduuddtrdduleelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleelpdhhvghloheplgduledvrdduieekrddurddutdeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopegrghhushhtseguvghng
 idruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtoheptghlrghmohhrleehsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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

There are already several helpers to find a udevice based on its
position in a device tree, like getting a child or a node pointed by a
phandle, but there was no support for graph endpoints, which are very
common in display pipelines.

Add a new helper, named uclass_get_device_by_endpoint() which enters the
child graph reprensentation, looks for a specific port, then follows the
remote endpoint, and finally retrieves the first parent of the given
uclass_id.

This is a very handy and straightforward way to get a bridge or a panel
handle.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/core/uclass.c | 19 +++++++++++++++++++
 include/dm/uclass.h   | 24 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index f846a35d6b2537bab56bca158cedfb134b37f477..ce5e61bbaa63a181a1ea6781ad6a7f06be67c7e0 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -16,6 +16,7 @@
 #include <dm/device.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <dm/ofnode_graph.h>
 #include <dm/uclass.h>
 #include <dm/uclass-internal.h>
 #include <dm/util.h>
@@ -582,6 +583,24 @@ int uclass_get_device_by_phandle(enum uclass_id id, struct udevice *parent,
 	ret = uclass_find_device_by_phandle(id, parent, name, &dev);
 	return uclass_get_device_tail(dev, ret, devp);
 }
+
+int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevice *dev,
+				  int port_idx, int ep_idx, struct udevice **devp)
+{
+	ofnode node_source = dev_ofnode(dev);
+	ofnode node_dest = ofnode_graph_get_remote_node(node_source, port_idx, ep_idx);
+	struct udevice *target = NULL;
+	int ret;
+
+	if (!ofnode_valid(node_dest))
+		return -EINVAL;
+
+	ret = uclass_find_device_by_ofnode(class_id, node_dest, &target);
+	if (ret)
+		return -ENODEV;
+
+	return uclass_get_device_tail(target, 0, devp);
+}
 #endif
 
 /*
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index c279304092352200d5297ad2d17f527173ec506b..8fdd72725119aae6ad2b62f4b0c38866a910389c 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -333,6 +333,30 @@ int uclass_get_device_by_phandle(enum uclass_id id, struct udevice *parent,
 int uclass_get_device_by_driver(enum uclass_id id, const struct driver *drv,
 				struct udevice **devp);
 
+/**
+ * uclass_get_device_by_endpoint() - Get a uclass device for a remote endpoint
+ *
+ * This searches through the parents of the specified remote endpoint
+ * for the first device matching the uclass. Said otherwise, this helper
+ * goes through the graph (endpoint) representation and searches for
+ * matching devices. Endpoints can be subnodes of the "port" node or
+ * subnodes of ports identified with a reg property, themselves in a
+ * "ports" container.
+ *
+ * The device is probed to activate it ready for use.
+ *
+ * @class_id: uclass ID to look up
+ * @dev: Device to start from
+ * @port_idx: Index of the port to follow, -1 if there is a single 'port'
+ *            node without reg.
+ * @ep_idx: Index of the endpoint to follow, -1 if there is a single 'endpoint'
+ *          node without reg.
+ * @target: Returns pointer to the first device matching the expected uclass.
+ * Return: 0 if OK, -ve on error
+ */
+int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevice *dev,
+				  int port_idx, int ep_idx, struct udevice **target);
+
 /**
  * uclass_first_device() - Get the first device in a uclass
  *

-- 
2.48.1

