Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0658CD6E54
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2090786D0A;
	Wed, 11 Oct 2023 12:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jbjiH+lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E3C86D05; Wed, 11 Oct 2023 12:07:49 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9340380834
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ae473c0bd6so1173526b6e.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018855; x=1697623655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oj53KjJfNhldfcxUVxj9tMYDMweOvK4DG03MksuRKE=;
 b=jbjiH+lwCM6Xtp1U/kdN+/KaUE7oOls2TThvCChKNel+j+A6+jEDOad05Vle246sli
 8JYxA4ubd1xT8xEwoZeW4dYQ0b1G+HmU3xFze2sQoPsthFC7M456OMJIxQ0vGENmFF7X
 za9AoQsnF8m6caprIgAuXegMLbA8SJsEMhXOiRFgd6sppiX56oxwscKKyE9JRflwTEAM
 rLRb+CUfT/PqIGeSATzBjDsC4S5D/xgPyZnrDv+DvmK05gTs2S1PRT1vdy3Tmiqefnjo
 Lba2VghEqSKIv4VjO+tmfhu2Zn71qn6HFDO4a0ji94xu5BM22Kl+0p1WkTLT78sM+njA
 MrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018855; x=1697623655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oj53KjJfNhldfcxUVxj9tMYDMweOvK4DG03MksuRKE=;
 b=rTknk1VZ0KEcv59PTtr5LFzHBNJt0tI9SVIrpLYEWOwkuKRdA+JqR+vfbs2yXbqFHC
 X2UpOhDVVZEP/KQ+TNxk5poCMF+hHp1Fea8D96paAhApfcY5gWiyZvJjACNtXwabhMIU
 K7WQ8frVpXwTUwMtn5+yFVkdwpXuqWK3XByICdELYT1LLPX5hEQw64yy9IBGOofzqG0o
 is1tYBRcu5TkLGNKjIjruw084EBZ8hsQb22y/ItTBFnUTCQyg8B40IyyaOqg4Ne4v2+S
 EDC0vPW/zPzkm3vnxMTaaJWGY3tuDSu8jAn3LbynYrKxlRRy6nxG991JLW9B9F483bzs
 Kvog==
X-Gm-Message-State: AOJu0YwgYbbQSt9zfwP+zS4N3oCWhD1OgmcWFvZE2HCyWguL51nPW1V0
 oYEWzwjpoR6MqicRp5SpMIOQew==
X-Google-Smtp-Source: AGHT+IEW4wmVaB/+kFS4ICuzzU9tGPZXnOg/jQmCAyexJNrxA2mBissprbt9UH8ZcEiPk8ufN71WaQ==
X-Received: by 2002:a05:6358:e908:b0:147:47f2:2d54 with SMTP id
 gk8-20020a056358e90800b0014747f22d54mr16670157rwb.0.1697018855363; 
 Wed, 11 Oct 2023 03:07:35 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:35 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 05/14] firmware: scmi: framework for installing additional
 protocols
Date: Wed, 11 Oct 2023 19:06:58 +0900
Message-Id: <20231011100707.1007417-6-takahiro.akashi@linaro.org>
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

This framework allows SCMI protocols to be installed and bound to the agent
so that the agent can manage and utilize them later.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v6
* remove global 'scmi_agent' variable which is never used
v4
* remove 'agent' variable as it should be added in the following commit
v3
* move "per_device_plat_auto" from a earlier patch
* fix comments in "scmi_agent_priv"
* modify an order of include files in scmi_agent.h
v2
* check for availability of protocols
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 91 ++++++++++++++++++++++-
 include/scmi_agent-uclass.h               | 15 +++-
 include/scmi_agent.h                      | 14 ++++
 3 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 1fa1e9eef966..b4d008835180 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -38,6 +38,80 @@ static const struct error_code scmi_linux_errmap[] = {
 	{ .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, },
 };
 
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
@@ -168,9 +242,10 @@ static int scmi_bind_protocols(struct udevice *dev)
 	int ret = 0;
 	ofnode node;
 	const char *name;
+	struct driver *drv;
+	struct udevice *proto;
 
 	dev_for_each_subnode(node, dev) {
-		struct driver *drv = NULL;
 		u32 protocol_id;
 
 		if (!ofnode_is_enabled(node))
@@ -179,6 +254,7 @@ static int scmi_bind_protocols(struct udevice *dev)
 		if (ofnode_read_u32(node, "reg", &protocol_id))
 			continue;
 
+		drv = NULL;
 		name = ofnode_get_name(node);
 		switch (protocol_id) {
 		case SCMI_PROTOCOL_ID_CLOCK:
@@ -209,9 +285,17 @@ static int scmi_bind_protocols(struct udevice *dev)
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
 
 	return ret;
@@ -221,5 +305,6 @@ UCLASS_DRIVER(scmi_agent) = {
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

