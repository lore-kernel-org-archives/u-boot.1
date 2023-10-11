Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33414CD6E58
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B8786E15;
	Wed, 11 Oct 2023 12:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D4PpJ2Kt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA6E86DF6; Wed, 11 Oct 2023 12:08:09 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D6A86D77
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-692af7b641cso1184276b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018869; x=1697623669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTdm6SW79mLHljnSGoRxWGpVn8avzB5Z44W3qR0Rq5k=;
 b=D4PpJ2KtLi5RRg7Sp+R4pB5gxIJJMcQZkTQlUFlBgvEt5K1z2jseHP+M1QX90bs1o5
 kjgGdHiamREDlVa8ZJz77P7o62AM+1AOc71qwPa4Sa2AigEd68Zv/lYVAom9E6Maojst
 TlJOFVBtKQYnAKgsPHgV6rs0cAmDC/S6wmfkHGlCQJ79RLzg/RnYMIoo6IO6GLFpxAyG
 XM+9sAAdjqymdWs0rPATXFL/dQDsTR5lP4+Q6THvRRdgHBsmMorhfQYf//C36C6Z5QQv
 JsznbQZPAXLnqFoJ1FcSWdP6aHD7p6LR93jCxVLHldBo3RPOAZItoI3lSt7x74D4Ol4j
 IKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018869; x=1697623669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTdm6SW79mLHljnSGoRxWGpVn8avzB5Z44W3qR0Rq5k=;
 b=MO1uy2/a89AhBfNTkLRXh7iKAI6EPYZ2K/Kzrs8lcsP/L9+/43DRhUx6YJRQH83mjS
 fmcIPG0ztqmAJY3byXwaBIW/vk3gy/feVkiWTGsSIldesnxckDyj0Hlq4458giRvdd4g
 WS8kb950O9ALr9PsvPodzrzTNboJpkwr7vA310Aq1DOKy2uo2VPqInBWkxJivKtEIb2o
 twRtpRm8ZGHmH4TAsIZ9Pcimmd7prvbzL8GWqfv5fF/qTxBNIrejv57xFLN9M3nytyCR
 eswhEMwUEJKyphNcVL2vJUKfoPah0+KPHFPqTY+Lmkk8OVIYE3XrGKg0o0oAH4naDL2f
 MqZw==
X-Gm-Message-State: AOJu0YyCW4DAwpFq65V2DY8Xy/kuVpWPRUmyG3kHMKV46MKMvMnYtvW/
 o0RgMXjDGuoE//rqAXPgWJKVqg==
X-Google-Smtp-Source: AGHT+IESBBLRbIgj6sYFZmHbfVS58R6g9hnRNHfnc4kEVbuyjWV5YdXavwmQwReO++1hu1cAfOuR2g==
X-Received: by 2002:a05:6a00:3916:b0:68e:2fd4:288a with SMTP id
 fh22-20020a056a00391600b0068e2fd4288amr23374521pfb.3.1697018868805; 
 Wed, 11 Oct 2023 03:07:48 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:48 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 11/14] firmware: scmi: install base protocol to SCMI agent
Date: Wed, 11 Oct 2023 19:07:04 +0900
Message-Id: <20231011100707.1007417-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
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
 drivers/firmware/scmi/scmi_agent-uclass.c | 118 +++++++++++++++++++++-
 include/scmi_agent-uclass.h               |  66 ++++++++++++
 2 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index b4d008835180..b1a9c36310c1 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -51,6 +51,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	}
 
 	switch (id) {
+	case SCMI_PROTOCOL_ID_BASE:
+		proto = priv->base_dev;
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		proto = priv->clock_dev;
 		break;
@@ -95,6 +98,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	}
 
 	switch (proto_id) {
+	case SCMI_PROTOCOL_ID_BASE:
+		priv->base_dev = proto;
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		priv->clock_dev = proto;
 		break;
@@ -232,6 +238,83 @@ int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
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
+ * Return: 0 on success, error code on failure
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
@@ -243,7 +326,40 @@ static int scmi_bind_protocols(struct udevice *dev)
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
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 258aa0f37596..35d96069645e 100644
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

