Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825B5EB8FDE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB62486998;
	Fri,  8 Sep 2023 04:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IH31gBKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5CAF866CF; Fri,  8 Sep 2023 04:52:23 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88606866CF
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf1876ef69so3578375ad.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141539; x=1694746339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzkgTxanHuGRyCSlSZ9PXe+d68+baw/Nk/8TmPTifpc=;
 b=IH31gBKufjmpHUNwG+aHqqIM8f9gBzxYTWkUuH8KE8ekp8cNQeAXd4ZzabBonxrMNL
 Ht4NVxpP1CBNt8XCmFYCXncVZBXit9B3wQg8O42OikSEeBBB+gGiPGSuCuiTgcFq4d1P
 mz12PvF6okrBnmaokJ5T9wuTzpg3UEbeMNuzetpB72xjj+GoPL7NBEu8HFcjd+8ybfYM
 cewr8GfZW9Efecl0GvZC17iK2NkhzRszJXjGOm1yqc32vwMCQpubPurPM+y9zJeiDUHX
 so7XyJNBZKcX4QZz3sUjQIbFJbCqTaFFQglVbje44aiTBxaatdWF9UEPl5o/7GGUmaLy
 58rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141539; x=1694746339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzkgTxanHuGRyCSlSZ9PXe+d68+baw/Nk/8TmPTifpc=;
 b=U9S6WPYDadoIjU48TH8Zs2yUWVTKsjK4o3GP+6S3OTKa6Vy6QgzjSwVmqSSgJtYJZO
 DZb8OH5LFgpW0cui82GOwql+U6ZBVzAAkdwNMOxakCm2pwyA5WRRK2bcrAho4NN+cdtm
 N2IMsQNHFRx7vT1iVh7YWX0J2p7he74UNmP9DhgujU0TwjTUdY1MoGhKy7ITzYdLDbq0
 dgAuzFi1VVZJAe/dt9Vh3uoGIYIPb/gFJ234pxw7ch+xO9wQCe6IriIazket+xwkb5Xk
 +45mvC/DiFV09T3s/5BErraIMySnH8WN2oAm8tK/8/upVCT5IJv8FadQu15d82vLXw+5
 Mjwg==
X-Gm-Message-State: AOJu0Ywm5G3o3b1Z++t7TwlFPJTn53+EQ9Xj5S98ad3ksak/YS7ABS5s
 JCLOxsXN9xCPh3ahJw7dgkhnWQ==
X-Google-Smtp-Source: AGHT+IHYM6KSmAsB5KWKE6HicVkb+pqLEplRy4QkbGJPyKslmDDKmeAT4gpbJyrIb5q+mgXjuDQuSg==
X-Received: by 2002:a17:902:e84f:b0:1b8:b55d:4cff with SMTP id
 t15-20020a170902e84f00b001b8b55d4cffmr1517661plg.2.1694141538692; 
 Thu, 07 Sep 2023 19:52:18 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:18 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 01/13] scmi: refactor the code to hide a channel from
 devices
Date: Fri,  8 Sep 2023 11:51:26 +0900
Message-Id: <20230908025138.44405-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908025138.44405-1-takahiro.akashi@linaro.org>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
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
v3
* fix an issue on ST board (reported by Etienne)
  by taking care of cases where probed devices are children of
  SCMI protocol device (i.e. clock devices under CCF)
  See find_scmi_protocol_device().
* move "per_device_plato_auto" to a succeeding right patch
v2
* new patch
---
 drivers/clk/clk_scmi.c                    |  27 +---
 drivers/firmware/scmi/scmi_agent-uclass.c | 160 +++++++++++-----------
 drivers/power/regulator/scmi_regulator.c  |  27 +---
 drivers/reset/reset-scmi.c                |  19 +--
 include/scmi_agent.h                      |  15 +-
 5 files changed, 103 insertions(+), 145 deletions(-)

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
index 02de692d66f3..feb31809e715 100644
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
@@ -51,77 +52,23 @@ int scmi_to_linux_errno(s32 scmi_code)
 	return -EPROTO;
 }
 
-/*
- * SCMI agent devices binds devices of various uclasses depeding on
- * the FDT description. scmi_bind_protocol() is a generic bind sequence
- * called by the uclass at bind stage, that is uclass post_bind.
- */
-static int scmi_bind_protocols(struct udevice *dev)
+static struct udevice *find_scmi_protocol_device(struct udevice *dev)
 {
-	int ret = 0;
-	ofnode node;
-	const char *name;
-
-	dev_for_each_subnode(node, dev) {
-		struct driver *drv = NULL;
-		u32 protocol_id;
-
-		if (!ofnode_is_enabled(node))
-			continue;
-
-		if (ofnode_read_u32(node, "reg", &protocol_id))
-			continue;
+	struct udevice *parent = NULL, *protocol;
 
-		name = ofnode_get_name(node);
-		switch (protocol_id) {
-		case SCMI_PROTOCOL_ID_CLOCK:
-			if (CONFIG_IS_ENABLED(CLK_SCMI))
-				drv = DM_DRIVER_GET(scmi_clock);
-			break;
-		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
-			if (IS_ENABLED(CONFIG_RESET_SCMI))
-				drv = DM_DRIVER_GET(scmi_reset_domain);
-			break;
-		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
-			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {
-				node = ofnode_find_subnode(node, "regulators");
-				if (!ofnode_valid(node)) {
-					dev_err(dev, "no regulators node\n");
-					return -ENXIO;
-				}
-				drv = DM_DRIVER_GET(scmi_voltage_domain);
-			}
-			break;
-		default:
-			break;
-		}
-
-		if (!drv) {
-			dev_dbg(dev, "Ignore unsupported SCMI protocol %#x\n",
-				protocol_id);
-			continue;
-		}
-
-		ret = device_bind(dev, drv, name, NULL, node, NULL);
-		if (ret)
+	for (protocol = dev; protocol; protocol = parent) {
+		parent = dev_get_parent(protocol);
+		if (!parent ||
+		    device_get_uclass_id(parent) == UCLASS_SCMI_AGENT)
 			break;
 	}
 
-	return ret;
-}
-
-static struct udevice *find_scmi_transport_device(struct udevice *dev)
-{
-	struct udevice *parent = dev;
-
-	do {
-		parent = dev_get_parent(parent);
-	} while (parent && device_get_uclass_id(parent) != UCLASS_SCMI_AGENT);
-
-	if (!parent)
+	if (!parent) {
 		dev_err(dev, "Invalid SCMI device, agent not found\n");
+		return NULL;
+	}
 
-	return parent;
+	return protocol;
 }
 
 static const struct scmi_agent_ops *transport_dev_ops(struct udevice *dev)
@@ -129,43 +76,90 @@ static const struct scmi_agent_ops *transport_dev_ops(struct udevice *dev)
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
index 801148036ff6..08918b20872c 100644
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
@@ -209,4 +195,5 @@ U_BOOT_DRIVER(scmi_voltage_domain) = {
 	.name = "scmi_voltage_domain",
 	.id = UCLASS_NOP,
 	.bind = scmi_regulator_bind,
+	.per_child_auto = sizeof(struct scmi_agent_proto_priv *),
 };
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

