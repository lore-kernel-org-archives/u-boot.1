Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC58FE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9524A8951B;
	Thu,  5 Dec 2024 14:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jtfogdlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731F8894E7; Thu,  5 Dec 2024 14:54:49 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F9B894EA
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACC7E40003;
 Thu,  5 Dec 2024 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ljx41JCsNS0txOxEWX5UxxhLQLzJe/u196Ap/yKL7bc=;
 b=jtfogdlqrodr9scY6KVzun2sBzsihHOxQhDkAPwpOc07mcJCc6Nlhzc0v2W5eXmkbksf3l
 +BjWzkC19EMIX5F414BM8INSDkBM7YHzjChnKT9D3B3AiHVvu90LqSCFJWbSA8dbXOyfCA
 IBc9Z/0czKmQXIDE28yy1iIFtRJapCvXQAmTjjvzp9gZoFsM8xk/BUBO8R66wqyiGdJc3H
 P5AJSujEzZ9QoipSK3R1VSTgKKmncP643kmD78G2GjfMQSplo+vx+C/iSKCTls+E7/COmr
 lxiix9ci02JAu8LTMVr8MJSl1fmOcYYfvklm/lskS+JfEdfyDRteWCVYVnXvWg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:08 +0100
Subject: [PATCH v2 02/13] dm: core: Add a helper to retrieve devices
 through graph endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-2-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/core/uclass.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dm/uclass.h   | 21 +++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index f846a35d6b2537bab56bca158cedfb134b37f477..c9c5debbe7cd9ec44f95dc80d3199ee11521e997 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -582,6 +582,68 @@ int uclass_get_device_by_phandle(enum uclass_id id, struct udevice *parent,
 	ret = uclass_find_device_by_phandle(id, parent, name, &dev);
 	return uclass_get_device_tail(dev, ret, devp);
 }
+
+int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevice *dev,
+				  u32 ep_idx, struct udevice **devp)
+{
+	ofnode port = ofnode_null(), ep, remote_ep;
+	struct udevice *target = NULL;
+	u32 remote_phandle;
+	int ret;
+
+	if (!ep_idx)
+		port = dev_read_subnode(dev, "port");
+
+	if (!ofnode_valid(port)) {
+		char port_name[32];
+
+		port = dev_read_subnode(dev, "ports");
+		if (!ofnode_valid(port)) {
+			debug("%s: no 'port'/'ports' subnode\n",
+			      dev_read_name(dev));
+			return -EINVAL;
+		}
+
+		snprintf(port_name, sizeof(port_name), "port@%x", ep_idx);
+		port = ofnode_find_subnode(port, port_name);
+		if (!ofnode_valid(port)) {
+			debug("%s: no 'port@%x' subnode\n",
+			      dev_read_name(dev), ep_idx);
+			return -EINVAL;
+		}
+	}
+
+	ep = ofnode_find_subnode(port, "endpoint");
+	if (!ofnode_valid(ep)) {
+		debug("%s: no 'endpoint' in %s subnode\n",
+		      ofnode_get_name(port), dev_read_name(dev));
+		return -EINVAL;
+	}
+
+	ret = ofnode_read_u32(ep, "remote-endpoint", &remote_phandle);
+	if (ret)
+		return ret;
+
+	remote_ep = ofnode_get_by_phandle(remote_phandle);
+	if (!ofnode_valid(remote_ep))
+		return -EINVAL;
+
+	while (ofnode_valid(remote_ep)) {
+		remote_ep = ofnode_get_parent(remote_ep);
+		debug("trying subnode: %s\n", ofnode_get_name(remote_ep));
+		if (!ofnode_valid(remote_ep)) {
+			debug("%s: no more remote devices\n",
+			      ofnode_get_name(remote_ep));
+			return -ENODEV;
+		}
+
+		ret = uclass_find_device_by_ofnode(class_id, remote_ep, &target);
+		if (!ret)
+			break;
+	};
+
+	return uclass_get_device_tail(target, ret, devp);
+}
 #endif
 
 /*
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index c279304092352200d5297ad2d17f527173ec506b..6b76a9a588e70f487c2ce5398526d98b4547e2a7 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -333,6 +333,27 @@ int uclass_get_device_by_phandle(enum uclass_id id, struct udevice *parent,
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
+ * @ep_idx: Index of the endpoint to follow, 0 if there is none.
+ * @target: Returns pointer to the first device matching the expected uclass.
+ * Return: 0 if OK, -ve on error
+ */
+int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevice *dev,
+				  u32 ep_idx, struct udevice **target);
+
 /**
  * uclass_first_device() - Get the first device in a uclass
  *

-- 
2.47.0

