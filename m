Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B71CCA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D1FD86E45;
	Tue, 12 Sep 2023 08:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DvTFbR8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83BC186E4C; Tue, 12 Sep 2023 08:21:36 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6051586CD9
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68fc94307bfso356804b3a.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499692; x=1695104492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8miJdVBjrIJcYZQNn0qXZMR4Smbj9SYYMbC2jC5QrzI=;
 b=DvTFbR8a4fJuDNxfebhYjcCRB0s9WW7QeHaqCwMAwbqbI7bjy+tFFtXM02eA/Rsrgz
 q5KT6FKn3AzmX3ph+Y4xpVO5zgAh9njc4sgXjWLvQkKgednEq2GVoy0ax2z7TYBTXFBr
 kI9RUdCkj3ZEhZcNIIsfBsN8sf6eBKEobXEmZK1Gz4uCV93R1+GoSWCngJSdkXa+AL98
 nZ4jj8rxPVIS6GcFQi02YJXeHxXS3fxk0UVaygfmigOKLISNKLbPNnYC+yHGhckTv9q2
 owpmONWro9QojDLXVweT6k5gLKkRGoLQKSMW1MuntaLj0JHQ01MkPL+t5JWDHbcUAekk
 GGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499692; x=1695104492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8miJdVBjrIJcYZQNn0qXZMR4Smbj9SYYMbC2jC5QrzI=;
 b=J99cT4lqjiPOZ90Ew75k/DEyPx0Ueo2BEqMwK0aGy4dIpuPsn3l4F/HB2G3JswZFFu
 /7Ech8rTHo2eow9bHr2Szon2Z6TAvOQwOyl1stTFkMAzAkbENv8Ak3sw7z6bM/1USwNX
 WJJ4ZEYVj7n1xqzNt1GuPJzNhIS+r4b7pLG03iAznf2lJEHR0Pq8j8bQaonjRudmbidJ
 clAoGqy10j9OUcYI5cXHP3G8cITYb0SiGBTt0erE/s8QgSTwkpMWMi2CuCk3gydeqL24
 sVKbf3wpRISx3IilnouZC4D/xy4hXzRCxfZfFu914d/LR9dmgLTJuUkGSHjrThrd54n+
 IBdQ==
X-Gm-Message-State: AOJu0YxvmsZLmb4vNManHTQDpP6bm/D5jBRenNY7xyPV5xZrMLANCRSu
 n4JGBBouC3mILuiG+6xPOSiydg==
X-Google-Smtp-Source: AGHT+IHOEqftcN5B9sN7TUytEg+hLN2SOM60E8/4e1vZuwUgPATxGF/eieMpukDTtwq0FY3FquGIGQ==
X-Received: by 2002:a05:6a20:e11b:b0:14c:c393:69e with SMTP id
 kr27-20020a056a20e11b00b0014cc393069emr16319320pzb.1.1694499691631; 
 Mon, 11 Sep 2023 23:21:31 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:31 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 07/13] firmware: scmi: install base protocol to SCMI agent
Date: Tue, 12 Sep 2023 15:19:56 +0900
Message-Id: <20230912062002.57361-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912062002.57361-1-takahiro.akashi@linaro.org>
References: <20230912062002.57361-1-takahiro.akashi@linaro.org>
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

SCMI base protocol is mandatory, and once SCMI node is found in a device
tree, the protocol handle (udevice) is unconditionally installed to
the agent. Then basic information will be retrieved from SCMI server via
the protocol and saved into the agent instance's local storage.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v4
* remove 'scmi_agent' global variable as it is never utilized
* add 'agent' variable in scmi_bind_protocols()
* return an appropriate error (EPROTO) when
  scmi_base_discover_list_protocols() fails
* fix misc typos
v3
* typo fix: add '@' for argument name in function description
* eliminate dev_get_uclass_plat()'s repeated in inline
* modify the code for dynamically allocated sub-vendor/agent names
v2
* use helper functions, removing direct uses of ops
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 127 ++++++++++++++++++++--
 include/scmi_agent-uclass.h               |  66 +++++++++++
 2 files changed, 183 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 64878f04359e..cd72345b8e54 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -38,12 +38,6 @@ static const struct error_code scmi_linux_errmap[] = {
 	{ .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, },
 };
 
-/*
- * NOTE: The only one instance should exist according to
- * the current specification and device tree bindings.
- */
-struct udevice *scmi_agent;
-
 struct udevice *scmi_get_protocol(struct udevice *dev,
 				  enum scmi_std_protocol id)
 {
@@ -57,6 +51,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	}
 
 	switch (id) {
+	case SCMI_PROTOCOL_ID_BASE:
+		proto = priv->base_dev;
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		proto = priv->clock_dev;
 		break;
@@ -101,6 +98,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	}
 
 	switch (proto_id) {
+	case SCMI_PROTOCOL_ID_BASE:
+		priv->base_dev = proto;
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		priv->clock_dev = proto;
 		break;
@@ -237,6 +237,83 @@ int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
 	return scmi_process_msg(protocol->parent, priv->channel, msg);
 }
 
+/**
+ * scmi_fill_base_info - get base information about SCMI server
+ * @agent:	SCMI agent device
+ * @dev:	SCMI protocol device
+ *
+ * By using Base protocol commands, collect the base information
+ * about SCMI server.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
+{
+	struct scmi_agent_priv *priv = dev_get_uclass_plat(agent);
+	int ret;
+
+	ret = scmi_base_protocol_version(dev, &priv->version);
+	if (ret) {
+		dev_err(dev, "protocol_version() failed (%d)\n", ret);
+		return ret;
+	}
+	/* check for required version */
+	if (priv->version < SCMI_BASE_PROTOCOL_VERSION) {
+		dev_err(dev, "base protocol version (%d) lower than expected\n",
+			priv->version);
+		return -EPROTO;
+	}
+
+	ret = scmi_base_protocol_attrs(dev, &priv->num_agents,
+				       &priv->num_protocols);
+	if (ret) {
+		dev_err(dev, "protocol_attrs() failed (%d)\n", ret);
+		return ret;
+	}
+	ret = scmi_base_discover_vendor(dev, &priv->vendor);
+	if (ret) {
+		dev_err(dev, "base_discover_vendor() failed (%d)\n", ret);
+		return ret;
+	}
+	ret = scmi_base_discover_sub_vendor(dev, &priv->sub_vendor);
+	if (ret) {
+		if (ret != -EOPNOTSUPP) {
+			dev_err(dev, "base_discover_sub_vendor() failed (%d)\n",
+				ret);
+			return ret;
+		}
+		priv->sub_vendor = "NA";
+	}
+	ret = scmi_base_discover_impl_version(dev, &priv->impl_version);
+	if (ret) {
+		dev_err(dev, "base_discover_impl_version() failed (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = scmi_base_discover_agent(dev, 0xffffffff,
+				       &priv->agent_id, &priv->agent_name);
+	if (ret) {
+		if (ret != -EOPNOTSUPP) {
+			dev_err(dev,
+				"base_discover_agent() failed for myself (%d)\n",
+				ret);
+			return ret;
+		}
+		priv->agent_id = 0xffffffff;
+		priv->agent_name = "NA";
+	}
+
+	ret = scmi_base_discover_list_protocols(dev, &priv->protocols);
+	if (ret != priv->num_protocols) {
+		dev_err(dev, "base_discover_list_protocols() failed (%d)\n",
+			ret);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
 /*
  * SCMI agent devices binds devices of various uclasses depending on
  * the FDT description. scmi_bind_protocol() is a generic bind sequence
@@ -248,7 +325,40 @@ static int scmi_bind_protocols(struct udevice *dev)
 	ofnode node;
 	const char *name;
 	struct driver *drv;
-	struct udevice *proto;
+	struct udevice *agent, *proto;
+
+	if (!uclass_get_device(UCLASS_SCMI_AGENT, 1, &agent)) {
+		/* This is a second SCMI agent */
+		dev_err(dev, "Cannot have more than one SCMI agent\n");
+		return -EEXIST;
+	}
+
+	/* initialize the device from device tree */
+	drv = DM_DRIVER_GET(scmi_base_drv);
+	name = "scmi-base.0";
+	ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
+	if (ret) {
+		dev_err(dev, "failed to bind base protocol\n");
+		return ret;
+	}
+	ret = scmi_add_protocol(dev, SCMI_PROTOCOL_ID_BASE, proto);
+	if (ret) {
+		dev_err(dev, "failed to add protocol: %s, ret: %d\n",
+			proto->name, ret);
+		return ret;
+	}
+
+	ret = device_probe(proto);
+	if (ret) {
+		dev_err(dev, "failed to probe base protocol\n");
+		return ret;
+	}
+
+	ret = scmi_fill_base_info(dev, proto);
+	if (ret) {
+		dev_err(dev, "failed to get base information\n");
+		return ret;
+	}
 
 	dev_for_each_subnode(node, dev) {
 		u32 protocol_id;
@@ -303,9 +413,6 @@ static int scmi_bind_protocols(struct udevice *dev)
 		}
 	}
 
-	if (!ret)
-		scmi_agent = dev;
-
 	return ret;
 }
 
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 3358c2b2d804..21b894dbc107 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -5,6 +5,7 @@
 #ifndef _SCMI_AGENT_UCLASS_H
 #define _SCMI_AGENT_UCLASS_H
 
+#include <scmi_protocols.h>
 #include <dm/device.h>
 
 struct scmi_msg;
@@ -12,16 +13,81 @@ struct scmi_channel;
 
 /**
  * struct scmi_agent_priv - private data maintained by agent instance
+ * @version:		Version
+ * @num_agents:		Number of agents
+ * @num_protocols:	Number of protocols
+ * @impl_version:	Implementation version
+ * @protocols:		Array of protocol IDs
+ * @vendor:		Vendor name
+ * @sub_vendor:		Sub-vendor name
+ * @agent_name:		Agent name
+ * @agent_id:		Identifier of agent
+ * @base_dev:		SCMI base protocol device
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
  */
 struct scmi_agent_priv {
+	u32 version;
+	u32 num_agents;
+	u32 num_protocols;
+	u32 impl_version;
+	u8 *protocols;
+	u8 *vendor;
+	u8 *sub_vendor;
+	u8 *agent_name;
+	u32 agent_id;
+	struct udevice *base_dev;
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
 };
 
+static inline u32 scmi_version(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->version;
+}
+
+static inline u32 scmi_num_agents(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->num_agents;
+}
+
+static inline u32 scmi_num_protocols(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->num_protocols;
+}
+
+static inline u32 scmi_impl_version(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->impl_version;
+}
+
+static inline u8 *scmi_protocols(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->protocols;
+}
+
+static inline u8 *scmi_vendor(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->vendor;
+}
+
+static inline u8 *scmi_sub_vendor(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->sub_vendor;
+}
+
+static inline u8 *scmi_agent_name(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->agent_name;
+}
+
+static inline u32 scmi_agent_id(struct udevice *dev)
+{
+	return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->agent_id;
+}
+
 /**
  * struct scmi_transport_ops - The functions that a SCMI transport layer must implement.
  */
-- 
2.34.1

