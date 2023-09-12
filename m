Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362DDCA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4545886E3A;
	Tue, 12 Sep 2023 08:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IiSq8nLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5C886E3B; Tue, 12 Sep 2023 08:21:30 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290E386E39
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c3aa44c0faso4083255ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499685; x=1695104485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwpjlVb3t11oQXlz/FlHGY4IS5RbsVMWi1+RGMS2XCI=;
 b=IiSq8nLG8myz71LEdSGbHeKLvTDoT39W7S8P0Z+697G1BtR4f2kakCOkMwmqIBshLV
 vD49UaQ9tk/+QbgxvSp3dpovI5MRrKuQEvJtZImfQN+p0lG11Jjlih11RoJ8QJOl+AlG
 qqPTFyYUJlqNmeND0EsbpW58ieCFivzvAvxuqqAF0F6TNYjcBNsnsb+4hVBZueb9Ojs/
 ioRfheujE+2UhaayBDoJc4hrFhUvDTxFKHgxOPE79gr5Xu/JusgzUf3iqRP8/nlvihOi
 NIHmO/Xaptc+cdThAiO5RRkpFdOlvPdeVS/LYukwE8mTK9D/zleSJwSuRSLdg9zx7Ttq
 0NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499685; x=1695104485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwpjlVb3t11oQXlz/FlHGY4IS5RbsVMWi1+RGMS2XCI=;
 b=cjtejD75srMJpALov1ShFVT76Pr2nBgyejM7RHpfyDCcISfgxSlpDFNB6Yitt9vUdD
 8qpnSkADlOzN4+1gTE1HS4nsgkGEdMMZ+L4CA3RL/xeSSx+hyylZOfIXi2TH9erh0gkF
 /b60t+v1Z7IBtNp6eYIJpH590yxPVyRhXIahbywWjxecXX6DyRHXQMAYEe1qmQwtUVkv
 OjMUNd4GLhi3bnur312Y/02CxnEdtOz5gAeFRpftyPDyomWx+afhIxjZ5PVtNFAamtxM
 Kk9Lzj0HN2H5xNSTKPuDF43RyB3dkV2zntRrTBhTlR/NUdLeg08eeAMkaYCmu9N+ueg0
 FGwQ==
X-Gm-Message-State: AOJu0YwbWmPeKAgikLgY3lSDdSXeEpFFA524iv0bg4CknkH/5wZpI9L7
 Eb7E/Efy/XsaNNAH1iD9rMfbmQ==
X-Google-Smtp-Source: AGHT+IFFAtBWSD1S2abMsME2LKQ1xiumU5RJlBeELgKbDNloGLUq+s9UHa9UF4D0qP/Rtsjc5PCC7g==
X-Received: by 2002:a17:902:da92:b0:1b8:2ba0:c9a8 with SMTP id
 j18-20020a170902da9200b001b82ba0c9a8mr14578360plx.2.1694499685474; 
 Mon, 11 Sep 2023 23:21:25 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:25 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 04/13] firmware: scmi: framework for installing additional
 protocols
Date: Tue, 12 Sep 2023 15:19:53 +0900
Message-Id: <20230912062002.57361-5-takahiro.akashi@linaro.org>
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

This framework allows SCMI protocols to be installed and bound to the agent
so that the agent can manage and utilize them later.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
V4
* remove 'agent' variable as it should be added in the following commit
v3
* move "per_device_plat_auto" from a earlier patch
* fix comments in "scmi_agent_priv"
* modify an order of include files in scmi_agent.h
v2
* check for availability of protocols
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 100 +++++++++++++++++++++-
 include/scmi_agent-uclass.h               |  15 +++-
 include/scmi_agent.h                      |  14 +++
 3 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 0b97569eb1a0..64878f04359e 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -38,6 +38,86 @@ static const struct error_code scmi_linux_errmap[] = {
 	{ .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, },
 };
 
+/*
+ * NOTE: The only one instance should exist according to
+ * the current specification and device tree bindings.
+ */
+struct udevice *scmi_agent;
+
+struct udevice *scmi_get_protocol(struct udevice *dev,
+				  enum scmi_std_protocol id)
+{
+	struct scmi_agent_priv *priv;
+	struct udevice *proto;
+
+	priv = dev_get_uclass_plat(dev);
+	if (!priv) {
+		dev_err(dev, "No priv data found\n");
+		return NULL;
+	}
+
+	switch (id) {
+	case SCMI_PROTOCOL_ID_CLOCK:
+		proto = priv->clock_dev;
+		break;
+	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
+		proto = priv->resetdom_dev;
+		break;
+	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
+		proto = priv->voltagedom_dev;
+		break;
+	default:
+		dev_err(dev, "Protocol not supported\n");
+		proto = NULL;
+		break;
+	}
+	if (proto && device_probe(proto))
+		dev_err(dev, "Probe failed\n");
+
+	return proto;
+}
+
+/**
+ * scmi_add_protocol - add protocol to agent
+ * @dev:	SCMI agent device
+ * @proto_id:	SCMI protocol ID
+ * @proto:	SCMI protocol device
+ *
+ * Associate the protocol instance, @proto, to the agent, @dev,
+ * for later use.
+ *
+ * Return:	0 on success, error code otherwise
+ */
+static int scmi_add_protocol(struct udevice *dev,
+			     enum scmi_std_protocol proto_id,
+			     struct udevice *proto)
+{
+	struct scmi_agent_priv *priv;
+
+	priv = dev_get_uclass_plat(dev);
+	if (!priv) {
+		dev_err(dev, "No priv data found\n");
+		return -ENODEV;
+	}
+
+	switch (proto_id) {
+	case SCMI_PROTOCOL_ID_CLOCK:
+		priv->clock_dev = proto;
+		break;
+	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
+		priv->resetdom_dev = proto;
+		break;
+	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
+		priv->voltagedom_dev = proto;
+		break;
+	default:
+		dev_err(dev, "Protocol not supported\n");
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
 int scmi_to_linux_errno(s32 scmi_code)
 {
 	int n;
@@ -167,9 +247,10 @@ static int scmi_bind_protocols(struct udevice *dev)
 	int ret = 0;
 	ofnode node;
 	const char *name;
+	struct driver *drv;
+	struct udevice *proto;
 
 	dev_for_each_subnode(node, dev) {
-		struct driver *drv = NULL;
 		u32 protocol_id;
 
 		if (!ofnode_is_enabled(node))
@@ -178,6 +259,7 @@ static int scmi_bind_protocols(struct udevice *dev)
 		if (ofnode_read_u32(node, "reg", &protocol_id))
 			continue;
 
+		drv = NULL;
 		name = ofnode_get_name(node);
 		switch (protocol_id) {
 		case SCMI_PROTOCOL_ID_CLOCK:
@@ -208,11 +290,22 @@ static int scmi_bind_protocols(struct udevice *dev)
 			continue;
 		}
 
-		ret = device_bind(dev, drv, name, NULL, node, NULL);
-		if (ret)
+		ret = device_bind(dev, drv, name, NULL, node, &proto);
+		if (ret) {
+			dev_err(dev, "failed to bind %s protocol\n", drv->name);
 			break;
+		}
+		ret = scmi_add_protocol(dev, protocol_id, proto);
+		if (ret) {
+			dev_err(dev, "failed to add protocol: %s, ret: %d\n",
+				proto->name, ret);
+			break;
+		}
 	}
 
+	if (!ret)
+		scmi_agent = dev;
+
 	return ret;
 }
 
@@ -220,5 +313,6 @@ UCLASS_DRIVER(scmi_agent) = {
 	.id		= UCLASS_SCMI_AGENT,
 	.name		= "scmi_agent",
 	.post_bind	= scmi_bind_protocols,
+	.per_device_plat_auto = sizeof(struct scmi_agent_priv),
 	.per_child_auto	= sizeof(struct scmi_agent_proto_priv *),
 };
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index b1c93532c0ea..3358c2b2d804 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -5,10 +5,23 @@
 #ifndef _SCMI_AGENT_UCLASS_H
 #define _SCMI_AGENT_UCLASS_H
 
-struct udevice;
+#include <dm/device.h>
+
 struct scmi_msg;
 struct scmi_channel;
 
+/**
+ * struct scmi_agent_priv - private data maintained by agent instance
+ * @clock_dev:		SCMI clock protocol device
+ * @resetdom_dev:	SCMI reset domain protocol device
+ * @voltagedom_dev:	SCMI voltage domain protocol device
+ */
+struct scmi_agent_priv {
+	struct udevice *clock_dev;
+	struct udevice *resetdom_dev;
+	struct udevice *voltagedom_dev;
+};
+
 /**
  * struct scmi_transport_ops - The functions that a SCMI transport layer must implement.
  */
diff --git a/include/scmi_agent.h b/include/scmi_agent.h
index 577892029ff8..755986d6c424 100644
--- a/include/scmi_agent.h
+++ b/include/scmi_agent.h
@@ -10,6 +10,7 @@
 #ifndef SCMI_AGENT_H
 #define SCMI_AGENT_H
 
+#include <scmi_protocols.h>
 #include <asm/types.h>
 
 struct udevice;
@@ -74,6 +75,19 @@ int devm_scmi_of_get_channel(struct udevice *dev);
  */
 int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg);
 
+/**
+ * scmi_get_protocol() - get protocol instance
+ *
+ * @dev:	SCMI agent device
+ * @id:		SCMI protocol ID
+ *
+ * Obtain the device instance for given protocol ID, @id.
+ *
+ * Return:	Pointer to the device if found, null otherwise
+ */
+struct udevice *scmi_get_protocol(struct udevice *dev,
+				  enum scmi_std_protocol id);
+
 /**
  * scmi_to_linux_errno() - Convert an SCMI error code into a Linux errno code
  *
-- 
2.34.1

