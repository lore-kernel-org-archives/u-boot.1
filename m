Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59172CA0EC9
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF0C86E32;
	Tue, 12 Sep 2023 08:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y3lh9FRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F2886E24; Tue, 12 Sep 2023 08:21:25 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38C186E20
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fee7789f5so20732b3a.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499680; x=1695104480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suOR8ml2BoYdJFj2jj49bSg3MWoPt2Rew0i5CAnocQo=;
 b=y3lh9FRNQ3KcZkdpaMovymg6/gbXscLH9jgwnm/onOQrzjn2nZrKZ8IToGx5eR2T3z
 wJDjp0J1Jpr0RPbtCfplLK5FBDq8KF3O1tsV1JyGSr9F2m5wLsbmdo7i8c13jnP0ZW0q
 KS9KOGFVnS/pAOT48RCyU4deLsgCfZcmEDvuh4LUeP9EafVT7XwyjEJLEYIJ1ZH+ZC7I
 u6Q1wnahWJ+Bte/H/7ojJInEpmCMrOrIylxSYBNiBlLKnqhZo9bbH+tAGfkBh9YEEzC8
 hV8Fd+PzpcAZbXzGkOtukBMO+LVZ6cdHwMIW3679IMWA75ikwDCbVRN1t+RBxBwIPku3
 RIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499680; x=1695104480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suOR8ml2BoYdJFj2jj49bSg3MWoPt2Rew0i5CAnocQo=;
 b=HWUK6WXdm6sU0+YU7RtXNDjHHTCJtxj2nvYFhj4chTCj96ogeMu58niqvOsfrPX1FT
 verrIWea2JLIItaHS3ro5nHcQ2WQmfSqCNlcHPHjBA5V3u4DOs88wDyeqMJE5NJamXH5
 +EJMJY01oPVNWPD3Z5Ja/bveI2WwpSx7XJV7YoMZ1vzs7GlbMbrkMla+le7qE2Fzye+r
 WiJ1J6q3Q1X7GArxMhaCdkTgWjYYtkMkfVrJcFlbCwBhBksC+KT6nIp4UG6N9S7Cv3WE
 Bc1k3buXsLrul5T940G58U0gDrmbjNK4DIr+BXqHgHLFtGrz03ZLF7Tn8jZVUC2ZhxUK
 DgFA==
X-Gm-Message-State: AOJu0YwFAMF7kYmiSOnKDLtSyOSY1sxH3k2GlEoDkX/W8+wsrWIrcd/i
 6xe0HoXPgmzb7Di5K48WAvZKHQ==
X-Google-Smtp-Source: AGHT+IFBFm9ZdW80H/uxZSq8z0Z2VTdMWsTD5eSgHDun8zzA1gEi/idWrTMgnAONF30YSiVrTuEtAw==
X-Received: by 2002:a05:6a20:4308:b0:13d:fff1:c672 with SMTP id
 h8-20020a056a20430800b0013dfff1c672mr15974402pzk.4.1694499679938; 
 Mon, 11 Sep 2023 23:21:19 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:19 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 01/13] scmi: refactor the code to hide a channel from
 devices
Date: Tue, 12 Sep 2023 15:19:50 +0900
Message-Id: <20230912062002.57361-2-takahiro.akashi@linaro.org>
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

The commit 85dc58289238 ("firmware: scmi: prepare uclass to pass channel
reference") added an explicit parameter, channel, but it seems to make
the code complex.

Hiding this parameter will allow for adding a generic (protocol-agnostic)
helper function, i.e. for PROTOCOL_VERSION, in a later patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4
* revive scmi_bind_protocols which was accidentally removed
* remove .per_child_auto from the driver declaration as it is not needed
v3
* fix an issue on ST board (reported by Etienne)
  by taking care of cases where probed devices are children of
  SCMI protocol device (i.e. clock devices under CCF)
  See find_scmi_protocol_device().
* move "per_device_plato_auto" to a succeeding right patch
v2
* new patch
---
 drivers/clk/clk_scmi.c                    |  27 ++----
 drivers/firmware/scmi/scmi_agent-uclass.c | 105 ++++++++++++++++------
 drivers/power/regulator/scmi_regulator.c  |  26 ++----
 drivers/reset/reset-scmi.c                |  19 +---
 include/scmi_agent.h                      |  15 ++--
 5 files changed, 104 insertions(+), 88 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index d172fed24c9d..34a49363a51a 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -13,17 +13,8 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
-/**
- * struct scmi_clk_priv - Private data for SCMI clocks
- * @channel: Reference to the SCMI channel to use
- */
-struct scmi_clk_priv {
-	struct scmi_channel *channel;
-};
-
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
-	struct scmi_clk_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_protocol_attr_out out;
 	struct scmi_msg msg = {
 		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
@@ -33,7 +24,7 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	};
 	int ret;
 
-	ret = devm_scmi_process_msg(dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret)
 		return ret;
 
@@ -44,7 +35,6 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 
 static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 {
-	struct scmi_clk_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
 	};
@@ -59,7 +49,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 	};
 	int ret;
 
-	ret = devm_scmi_process_msg(dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret)
 		return ret;
 
@@ -70,7 +60,6 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clk_priv *priv = dev_get_priv(clk->dev);
 	struct scmi_clk_state_in in = {
 		.clock_id = clk->id,
 		.attributes = enable,
@@ -81,7 +70,7 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(clk->dev, &msg);
 	if (ret)
 		return ret;
 
@@ -100,7 +89,6 @@ static int scmi_clk_disable(struct clk *clk)
 
 static ulong scmi_clk_get_rate(struct clk *clk)
 {
-	struct scmi_clk_priv *priv = dev_get_priv(clk->dev);
 	struct scmi_clk_rate_get_in in = {
 		.clock_id = clk->id,
 	};
@@ -110,7 +98,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(clk->dev, &msg);
 	if (ret < 0)
 		return ret;
 
@@ -123,7 +111,6 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 
 static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
-	struct scmi_clk_priv *priv = dev_get_priv(clk->dev);
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
 		.flags = SCMI_CLK_RATE_ROUND_CLOSEST,
@@ -136,7 +123,7 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(clk->dev, &msg);
 	if (ret < 0)
 		return ret;
 
@@ -149,12 +136,11 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct scmi_clk_priv *priv = dev_get_priv(dev);
 	struct clk *clk;
 	size_t num_clocks, i;
 	int ret;
 
-	ret = devm_scmi_of_get_channel(dev, &priv->channel);
+	ret = devm_scmi_of_get_channel(dev);
 	if (ret)
 		return ret;
 
@@ -205,5 +191,4 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.id = UCLASS_CLK,
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
-	.priv_auto = sizeof(struct scmi_clk_priv *),
 };
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 02de692d66f3..75744cb35d7c 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <dm.h>
 #include <errno.h>
+#include <scmi_agent.h>
 #include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <dm/device_compat.h>
@@ -110,18 +111,23 @@ static int scmi_bind_protocols(struct udevice *dev)
 	return ret;
 }
 
-static struct udevice *find_scmi_transport_device(struct udevice *dev)
+static struct udevice *find_scmi_protocol_device(struct udevice *dev)
 {
-	struct udevice *parent = dev;
+	struct udevice *parent = NULL, *protocol;
 
-	do {
-		parent = dev_get_parent(parent);
-	} while (parent && device_get_uclass_id(parent) != UCLASS_SCMI_AGENT);
+	for (protocol = dev; protocol; protocol = parent) {
+		parent = dev_get_parent(protocol);
+		if (!parent ||
+		    device_get_uclass_id(parent) == UCLASS_SCMI_AGENT)
+			break;
+	}
 
-	if (!parent)
+	if (!parent) {
 		dev_err(dev, "Invalid SCMI device, agent not found\n");
+		return NULL;
+	}
 
-	return parent;
+	return protocol;
 }
 
 static const struct scmi_agent_ops *transport_dev_ops(struct udevice *dev)
@@ -129,43 +135,90 @@ static const struct scmi_agent_ops *transport_dev_ops(struct udevice *dev)
 	return (const struct scmi_agent_ops *)dev->driver->ops;
 }
 
-int devm_scmi_of_get_channel(struct udevice *dev, struct scmi_channel **channel)
+/**
+ * scmi_of_get_channel() - Get SCMI channel handle
+ *
+ * @dev:	SCMI agent device
+ * @channel:	Output reference to the SCMI channel upon success
+ *
+ * On return, @channel will be set.
+ * Return	0 on success and a negative errno on failure
+ */
+static int scmi_of_get_channel(struct udevice *dev, struct scmi_channel **channel)
 {
-	struct udevice *parent;
+	const struct scmi_agent_ops *ops;
 
-	parent = find_scmi_transport_device(dev);
-	if (!parent)
+	ops = transport_dev_ops(dev);
+	if (ops->of_get_channel)
+		return ops->of_get_channel(dev, channel);
+	else
+		return -EPROTONOSUPPORT;
+}
+
+int devm_scmi_of_get_channel(struct udevice *dev)
+{
+	struct udevice *protocol;
+	struct scmi_agent_proto_priv *priv;
+	int ret;
+
+	protocol = find_scmi_protocol_device(dev);
+	if (!protocol)
 		return -ENODEV;
 
-	if (transport_dev_ops(parent)->of_get_channel)
-		return transport_dev_ops(parent)->of_get_channel(parent, channel);
+	priv = dev_get_parent_priv(protocol);
+	ret = scmi_of_get_channel(protocol->parent, &priv->channel);
+	if (ret == -EPROTONOSUPPORT) {
+		/* Drivers without a get_channel operator don't need a channel ref */
+		priv->channel = NULL;
 
-	/* Drivers without a get_channel operator don't need a channel ref */
-	*channel = NULL;
+		return 0;
+	}
 
-	return 0;
+	return ret;
 }
 
-int devm_scmi_process_msg(struct udevice *dev, struct scmi_channel *channel,
-			  struct scmi_msg *msg)
+/**
+ * scmi_process_msg() - Send and process an SCMI message
+ *
+ * Send a message to an SCMI server.
+ * Caller sets scmi_msg::out_msg_sz to the output message buffer size.
+ *
+ * @dev:	SCMI agent device
+ * @channel:	Communication channel for the device
+ * @msg:	Message structure reference
+ *
+ * On return, scmi_msg::out_msg_sz stores the response payload size.
+ * Return:	0 on success and a negative errno on failure
+ */
+static int scmi_process_msg(struct udevice *dev, struct scmi_channel *channel,
+			    struct scmi_msg *msg)
 {
 	const struct scmi_agent_ops *ops;
-	struct udevice *parent;
 
-	parent = find_scmi_transport_device(dev);
-	if (!parent)
-		return -ENODEV;
+	ops = transport_dev_ops(dev);
+	if (ops->process_msg)
+		return ops->process_msg(dev, channel, msg);
+	else
+		return -EPROTONOSUPPORT;
+}
 
-	ops = transport_dev_ops(parent);
+int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
+{
+	struct udevice *protocol;
+	struct scmi_agent_proto_priv *priv;
 
-	if (ops->process_msg)
-		return ops->process_msg(parent, channel, msg);
+	protocol = find_scmi_protocol_device(dev);
+	if (!protocol)
+		return -ENODEV;
+
+	priv = dev_get_parent_priv(protocol);
 
-	return -EPROTONOSUPPORT;
+	return scmi_process_msg(protocol->parent, priv->channel, msg);
 }
 
 UCLASS_DRIVER(scmi_agent) = {
 	.id		= UCLASS_SCMI_AGENT,
 	.name		= "scmi_agent",
 	.post_bind	= scmi_bind_protocols,
+	.per_child_auto	= sizeof(struct scmi_agent_proto_priv *),
 };
diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index 801148036ff6..9c72c35d039e 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -25,18 +25,9 @@ struct scmi_regulator_platdata {
 	u32 domain_id;
 };
 
-/**
- * struct scmi_regulator_priv - Private data for SCMI voltage regulator
- * @channel: Reference to the SCMI channel to use
- */
-struct scmi_regulator_priv {
-	struct scmi_channel *channel;
-};
-
 static int scmi_voltd_set_enable(struct udevice *dev, bool enable)
 {
 	struct scmi_regulator_platdata *pdata = dev_get_plat(dev);
-	struct scmi_regulator_priv *priv = dev_get_priv(dev);
 	struct scmi_voltd_config_set_in in = {
 		.domain_id = pdata->domain_id,
 		.config = enable ? SCMI_VOLTD_CONFIG_ON : SCMI_VOLTD_CONFIG_OFF,
@@ -47,7 +38,7 @@ static int scmi_voltd_set_enable(struct udevice *dev, bool enable)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret)
 		return ret;
 
@@ -57,7 +48,6 @@ static int scmi_voltd_set_enable(struct udevice *dev, bool enable)
 static int scmi_voltd_get_enable(struct udevice *dev)
 {
 	struct scmi_regulator_platdata *pdata = dev_get_plat(dev);
-	struct scmi_regulator_priv *priv = dev_get_priv(dev);
 	struct scmi_voltd_config_get_in in = {
 		.domain_id = pdata->domain_id,
 	};
@@ -67,7 +57,7 @@ static int scmi_voltd_get_enable(struct udevice *dev)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret < 0)
 		return ret;
 
@@ -80,7 +70,6 @@ static int scmi_voltd_get_enable(struct udevice *dev)
 
 static int scmi_voltd_set_voltage_level(struct udevice *dev, int uV)
 {
-	struct scmi_regulator_priv *priv = dev_get_priv(dev);
 	struct scmi_regulator_platdata *pdata = dev_get_plat(dev);
 	struct scmi_voltd_level_set_in in = {
 		.domain_id = pdata->domain_id,
@@ -92,7 +81,7 @@ static int scmi_voltd_set_voltage_level(struct udevice *dev, int uV)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret < 0)
 		return ret;
 
@@ -101,7 +90,6 @@ static int scmi_voltd_set_voltage_level(struct udevice *dev, int uV)
 
 static int scmi_voltd_get_voltage_level(struct udevice *dev)
 {
-	struct scmi_regulator_priv *priv = dev_get_priv(dev);
 	struct scmi_regulator_platdata *pdata = dev_get_plat(dev);
 	struct scmi_voltd_level_get_in in = {
 		.domain_id = pdata->domain_id,
@@ -112,7 +100,7 @@ static int scmi_voltd_get_voltage_level(struct udevice *dev)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret < 0)
 		return ret;
 
@@ -140,7 +128,6 @@ static int scmi_regulator_of_to_plat(struct udevice *dev)
 static int scmi_regulator_probe(struct udevice *dev)
 {
 	struct scmi_regulator_platdata *pdata = dev_get_plat(dev);
-	struct scmi_regulator_priv *priv = dev_get_priv(dev);
 	struct scmi_voltd_attr_in in = { 0 };
 	struct scmi_voltd_attr_out out = { 0 };
 	struct scmi_msg scmi_msg = {
@@ -153,14 +140,14 @@ static int scmi_regulator_probe(struct udevice *dev)
 	};
 	int ret;
 
-	ret = devm_scmi_of_get_channel(dev->parent, &priv->channel);
+	ret = devm_scmi_of_get_channel(dev);
 	if (ret)
 		return ret;
 
 	/* Check voltage domain is known from SCMI server */
 	in.domain_id = pdata->domain_id;
 
-	ret = devm_scmi_process_msg(dev, priv->channel, &scmi_msg);
+	ret = devm_scmi_process_msg(dev, &scmi_msg);
 	if (ret) {
 		dev_err(dev, "Failed to query voltage domain %u: %d\n",
 			pdata->domain_id, ret);
@@ -184,7 +171,6 @@ U_BOOT_DRIVER(scmi_regulator) = {
 	.probe = scmi_regulator_probe,
 	.of_to_plat = scmi_regulator_of_to_plat,
 	.plat_auto = sizeof(struct scmi_regulator_platdata),
-	.priv_auto = sizeof(struct scmi_regulator_priv *),
 };
 
 static int scmi_regulator_bind(struct udevice *dev)
diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 122556162ec3..b76711f0a8fb 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -13,17 +13,8 @@
 #include <scmi_protocols.h>
 #include <asm/types.h>
 
-/**
- * struct scmi_reset_priv - Private data for SCMI reset controller
- * @channel: Reference to the SCMI channel to use
- */
-struct scmi_reset_priv {
-	struct scmi_channel *channel;
-};
-
 static int scmi_reset_set_level(struct reset_ctl *rst, bool assert_not_deassert)
 {
-	struct scmi_reset_priv *priv = dev_get_priv(rst->dev);
 	struct scmi_rd_reset_in in = {
 		.domain_id = rst->id,
 		.flags = assert_not_deassert ? SCMI_RD_RESET_FLAG_ASSERT : 0,
@@ -35,7 +26,7 @@ static int scmi_reset_set_level(struct reset_ctl *rst, bool assert_not_deassert)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(rst->dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(rst->dev, &msg);
 	if (ret)
 		return ret;
 
@@ -54,7 +45,6 @@ static int scmi_reset_deassert(struct reset_ctl *rst)
 
 static int scmi_reset_request(struct reset_ctl *rst)
 {
-	struct scmi_reset_priv *priv = dev_get_priv(rst->dev);
 	struct scmi_rd_attr_in in = {
 		.domain_id = rst->id,
 	};
@@ -68,7 +58,7 @@ static int scmi_reset_request(struct reset_ctl *rst)
 	 * We don't really care about the attribute, just check
 	 * the reset domain exists.
 	 */
-	ret = devm_scmi_process_msg(rst->dev, priv->channel, &msg);
+	ret = devm_scmi_process_msg(rst->dev, &msg);
 	if (ret)
 		return ret;
 
@@ -83,9 +73,7 @@ static const struct reset_ops scmi_reset_domain_ops = {
 
 static int scmi_reset_probe(struct udevice *dev)
 {
-	struct scmi_reset_priv *priv = dev_get_priv(dev);
-
-	return devm_scmi_of_get_channel(dev, &priv->channel);
+	return devm_scmi_of_get_channel(dev);
 }
 
 U_BOOT_DRIVER(scmi_reset_domain) = {
@@ -93,5 +81,4 @@ U_BOOT_DRIVER(scmi_reset_domain) = {
 	.id = UCLASS_RESET,
 	.ops = &scmi_reset_domain_ops,
 	.probe = scmi_reset_probe,
-	.priv_auto = sizeof(struct scmi_reset_priv *),
 };
diff --git a/include/scmi_agent.h b/include/scmi_agent.h
index ee6286366df7..577892029ff8 100644
--- a/include/scmi_agent.h
+++ b/include/scmi_agent.h
@@ -15,6 +15,14 @@
 struct udevice;
 struct scmi_channel;
 
+/**
+ * struct scmi_agent_proto_priv - Private data in device for SCMI agent
+ * @channel: Reference to the SCMI channel to use
+ */
+struct scmi_agent_proto_priv {
+	struct scmi_channel *channel;
+};
+
 /*
  * struct scmi_msg - Context of a SCMI message sent and the response received
  *
@@ -49,10 +57,9 @@ struct scmi_msg {
  * devm_scmi_of_get_channel() - Get SCMI channel handle from SCMI agent DT node
  *
  * @dev:	Device requesting a channel
- * @channel:	Output reference to the SCMI channel upon success
  * @return 0 on success and a negative errno on failure
  */
-int devm_scmi_of_get_channel(struct udevice *dev, struct scmi_channel **channel);
+int devm_scmi_of_get_channel(struct udevice *dev);
 
 /**
  * devm_scmi_process_msg() - Send and process an SCMI message
@@ -62,12 +69,10 @@ int devm_scmi_of_get_channel(struct udevice *dev, struct scmi_channel **channel)
  * On return, scmi_msg::out_msg_sz stores the response payload size.
  *
  * @dev:	SCMI device
- * @channel:	Communication channel for the device
  * @msg:	Message structure reference
  * Return: 0 on success and a negative errno on failure
  */
-int devm_scmi_process_msg(struct udevice *dev, struct scmi_channel *channel,
-			  struct scmi_msg *msg);
+int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg);
 
 /**
  * scmi_to_linux_errno() - Convert an SCMI error code into a Linux errno code
-- 
2.34.1

