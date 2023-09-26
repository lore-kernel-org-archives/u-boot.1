Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62A4E7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E84686D3B;
	Tue, 26 Sep 2023 08:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VVGpMFRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5241C86D38; Tue, 26 Sep 2023 08:58:29 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DE786CBC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c2107685cbso927190a34.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711505; x=1696316305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLRWsm6IYFzlIfmeMDJ8a5yW5HlQGLkW5IyvUDi5CKg=;
 b=VVGpMFRnTeA+9RCSyaIn06zG5z9ROJPIqXMsc2sJwccKdMZO4bavzMYERvXKjIL60Q
 fWV4Jog00DtHd+D0McVFjh91xMylMFX/x+W/51M41eKbueeCcTy18C+5rV949o0dVOPB
 moDfc6+arcobEN79uJjV8znRHFsqtdPdkMCqO3p2KJlr1rczTsBauq1LH9Ve2V8PuhAc
 PPk+a+TxuYSFOyGc9IPVLPN3j000ehMOUD4YkRO/F8V/fakC6avSzh9eUL0kKncdCxMq
 25XbY4K42HvgOUDV0IPcmpztXEf2bdRj1LYG5SMOBFWD1VROz2d49uOVleZCArZJ4V4K
 9YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711505; x=1696316305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLRWsm6IYFzlIfmeMDJ8a5yW5HlQGLkW5IyvUDi5CKg=;
 b=jmjQjJgCrfVIeE4HBIBIq9iG/URluBFbxro0Lbrtzm7kS+tDkgO1XPOnjyJl+VoYHg
 m3+FtaopHjE8GYw6EBg5zFRj1sFZiARt3fjHo5jqd7oQnNnFCMuz5aw77uAtDcQnVBKs
 OUwaPHKNaeCw2O4moVRZ1hUcUUrlplOIW5r/TThwSw1AoefiV8YUGfET22PH3ULA4I0u
 9IW1Y8DZochYH4dZZachs+c7ik8nHeGjcZJYt1RhMN2NKwXgDGilfs66+H/vEzAoO3dh
 eGNwZjjk8aLPGTl71ELnWX5CWTlepqohKXOYCBsYQlV9wgArf0Fk3eU17HeEz3fppt+5
 jE/A==
X-Gm-Message-State: AOJu0YxXBaGIjXWEF6mL4MnQeArctkEggDyHSgIjqmrUCwgCbxsoNGwd
 IL/lgpUcHVCx9iTy0c1rdLak3Q==
X-Google-Smtp-Source: AGHT+IHxXtVHuyQ6atHSqnDKlk7kvPopAZtEYGgNVylyb6JagpRSFb+JsfCtk1OPDVUvEvesf/lOLg==
X-Received: by 2002:a9d:4c03:0:b0:6bf:500f:b570 with SMTP id
 l3-20020a9d4c03000000b006bf500fb570mr8284624otf.3.1695711505640; 
 Mon, 25 Sep 2023 23:58:25 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:25 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v5 07/16] firmware: scmi: framework for installing additional
 protocols
Date: Tue, 26 Sep 2023 15:57:41 +0900
Message-Id: <20230926065750.734440-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
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
index 1fa1e9eef966..482cdaf0c6db 100644
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
+ * Return:	0 on success, error code on failure
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
@@ -168,9 +248,10 @@ static int scmi_bind_protocols(struct udevice *dev)
 	int ret = 0;
 	ofnode node;
 	const char *name;
+	struct driver *drv;
+	struct udevice *proto;
 
 	dev_for_each_subnode(node, dev) {
-		struct driver *drv = NULL;
 		u32 protocol_id;
 
 		if (!ofnode_is_enabled(node))
@@ -179,6 +260,7 @@ static int scmi_bind_protocols(struct udevice *dev)
 		if (ofnode_read_u32(node, "reg", &protocol_id))
 			continue;
 
+		drv = NULL;
 		name = ofnode_get_name(node);
 		switch (protocol_id) {
 		case SCMI_PROTOCOL_ID_CLOCK:
@@ -209,11 +291,22 @@ static int scmi_bind_protocols(struct udevice *dev)
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
 
@@ -221,5 +314,6 @@ UCLASS_DRIVER(scmi_agent) = {
 	.id		= UCLASS_SCMI_AGENT,
 	.name		= "scmi_agent",
 	.post_bind	= scmi_bind_protocols,
+	.per_device_plat_auto = sizeof(struct scmi_agent_priv),
 	.per_child_auto	= sizeof(struct scmi_agent_proto_priv),
 };
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index eee46c880a56..258aa0f37596 100644
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

