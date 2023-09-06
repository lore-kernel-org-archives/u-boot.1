Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CCBEB8FAE
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D68865A6;
	Wed,  6 Sep 2023 04:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rgmvNNiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2ABC8679F; Wed,  6 Sep 2023 04:41:11 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4310A86590
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 04:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bf106fb6a0so656944a34.0
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693968066; x=1694572866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJ/cP6pxLpHcUCBMifor8Z4cNVKkDimfyI0l3gabecs=;
 b=rgmvNNiL9ysSMPaGrvBWZJN9b18IOwE79BSZxLPK1Y4sYPCkTndVNo94yvmFl8g53q
 kP/weAbLVkK28fhhC4FvUP/Q2kXUKse9TXP41m70dg27FnQaHGDePCINgUU0wXvsVowO
 ACp3ZmlVawDIOyzyYCz7dkTbogtLrCol7JMY0SRCDd814IWxhWxqie6VDggbfJ1Kdu/R
 NQCvizKt+QQswFCqigOONz4Ce624NsuZBdbk5CZF1cgnUXs30g0bJfu7Ui/aUik28pXs
 QUYHIKpMJvWMKoR/XkntMnHKImDOp03SeHLu56oTSJs8c7MnKwjL8FFo8OKmx/PLtn4l
 Ki7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693968066; x=1694572866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJ/cP6pxLpHcUCBMifor8Z4cNVKkDimfyI0l3gabecs=;
 b=Cad3wnkilC3vcmHUfhI26QMVd/EpvkBA2V5NnaEz5ryCsZF7MKnkt4e9JUS9OypZSS
 Ks+PpRqPCmyod7xc/h/xL3ipB9m4e0GFdpzbs9pg966Pai6UbEnFc4eQwQ+smR5yXAcB
 F+pZvPfUaColx9vsrXCnSDcQxaedYFiNCK9YTaGVu/sPHwo6/XJpDG1jqr+Dyi7hhWUf
 miSgYW3hy5ZMc5kfQ0yl88T9c2DO4SuYmYX9RHo8MBpK9SFfdp96a6yewe8yTyhDTcgh
 yQ5zeJ4DiCUeqTErSi1xC+fbqnQBrr/mVjhYqfNxJbKcoq0DjK7PbpDTUZTB277fm5qL
 euQg==
X-Gm-Message-State: AOJu0YxBtIb31dA2qa2YF/YudchKy67RM9jKnsHIXU3Rp40nISd1wi3k
 ZWwYngjxpHY/lXrBJ++E7FJhaOQQP37RyeEsw62QBg==
X-Google-Smtp-Source: AGHT+IGh0Zxh2HA/tfwZ58JaKjccJFzlWbEezETYGTG886XvItNsa1BMS1neWZKWVT//d/nijUV4gA==
X-Received: by 2002:a05:6830:46a3:b0:6bd:9d65:fce with SMTP id
 ay35-20020a05683046a300b006bd9d650fcemr14260807otb.2.1693968065689; 
 Tue, 05 Sep 2023 19:41:05 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a6566c5000000b0056428865aadsm9145378pgw.82.2023.09.05.19.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 19:41:05 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 4/6] gpio: add scmi driver based on pinctrl
Date: Wed,  6 Sep 2023 11:40:09 +0900
Message-Id: <20230906024011.17488-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906024011.17488-1-takahiro.akashi@linaro.org>
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
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

This DM-compliant driver deals with SCMI pinctrl protocol and presents
gpio devices exposed by SCMI firmware (server).

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/pinctrl/pinctrl-scmi.c | 544 ++++++++++++++++++++++++++++++++-
 1 file changed, 539 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 3ebdad57b86c..73d385bdbfcc 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -11,21 +11,20 @@
 #include <malloc.h>
 #include <scmi_agent.h>
 #include <scmi_protocols.h>
+#include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/pinctrl.h>
 
 /**
  * struct scmi_pin - attributes for a pin
  * @name:	Name of pin
- * @value:	Value of pin
- * @flags:	A set of flags
  * @function:	Function selected
  * @status:	An array of status of configuration types
  */
 struct scmi_pin {
 	char		*name;
-	u32		value;
-	u32		flags;
 	unsigned int	function;
 	u32		status[SCMI_PINCTRL_CONFIG_RESERVED];
 };
@@ -308,7 +307,6 @@ static int scmi_pinmux_group_set(struct udevice *dev,
 	return 0;
 }
 
-/* TODO: may be driver-specific */
 /**
  * pinmux_property_set - Enable a pinmux group
  * @dev:	SCMI pinctrl device to use
@@ -424,6 +422,539 @@ const struct pinctrl_ops scmi_pinctrl_ops = {
 	.set_state = pinctrl_generic_set_state,
 };
 
+#if CONFIG_IS_ENABLED(DM_GPIO)
+/*
+ * GPIO part
+ */
+
+/**
+ * struct scmi_pinctrl_gpio_plat - platform data
+ * @pinctrl_dev:	Associated SCMI pinctrl device
+ * @gpio_map:		A list of gpio mapping information
+ * @name:		Name of ?
+ * @ngpios:		A number of gpio pins
+ */
+struct scmi_pinctrl_gpio_plat {
+	struct list_head gpio_map;
+	char *name;
+	u32 ngpios;
+};
+
+/**
+ * struct scmi_pinctrl_gpio_map - gpio mapping information
+ * @gpio_pin:		Start gpio pin selector
+ * @pinctrl_pin:	Mapped start pinctrl pin selector, used for linear mapping
+ * @pinctrl_group:	Name of an associated group, used for group namee mapping
+ * @num_pins:		A number of pins
+ * @node:		Node for a mapping list
+ */
+struct scmi_pinctrl_gpio_map {
+	struct udevice *pinctrl_dev;
+	u32 gpio_pin;
+	u32 pinctrl_pin;
+	u16 *pinctrl_group;
+	u32 num_pins;
+	struct list_head node;
+};
+
+/**
+ * map_to_id - Map a gpio pin offset to a pinctrl pin selector
+ * @dev:	SCMI pinctrl device
+ * @offset:	Pin offset
+ * @id:		Pinctrl pin selector
+ *
+ * Map a gpio pin offset, @offset, to an associated pinctrl pin selector
+ *
+ * Return:	0 on success, -1 on failure
+ */
+static int map_to_id(struct udevice *dev, unsigned int offset,
+		     struct udevice **pinctrl_dev, u32 *id)
+{
+	struct scmi_pinctrl_gpio_plat *plat = dev_get_plat(dev);
+	struct scmi_pinctrl_gpio_map *map;
+
+	/* if no mapping is defined, return 1:1 pin */
+	if (list_empty(&plat->gpio_map)) {
+		uclass_first_device(UCLASS_PINCTRL, pinctrl_dev);
+		if (!*pinctrl_dev)
+			return -1;
+
+		*id = offset;
+		return 0;
+	}
+
+	list_for_each_entry(map, &plat->gpio_map, node) {
+		if (offset >= map->gpio_pin &&
+		    offset < (map->gpio_pin + map->num_pins)) {
+			*pinctrl_dev = map->pinctrl_dev;
+			if (!pinctrl_dev)
+				return -1;
+
+			if (map->pinctrl_group)
+				*id = map->pinctrl_group[offset
+							  - map->gpio_pin];
+			else
+				*id = map->pinctrl_pin
+					+ (offset - map->gpio_pin);
+
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+/**
+ * scmi_gpio_get_value - Get a value of a gpio pin
+ * @dev:	SCMI gpio device
+ * @offset:	Pin offset
+ *
+ * Get a value of a gpio pin in @offset
+ *
+ * Return:	Value of a pin on success, error code on failure
+ */
+static int scmi_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct scmi_pinctrl_priv *priv;
+	u32 id;
+	struct udevice *pinctrl_dev;
+	struct scmi_pin_entry *config;
+	int config_type, ret;
+
+	if (map_to_id(dev, offset, &pinctrl_dev, &id)) {
+		dev_err(dev, "Invalid pin: %u\n", offset);
+		return -EINVAL;
+	}
+
+	priv = dev_get_priv(pinctrl_dev);
+	if (priv->pins[id].status[SCMI_PINCTRL_CONFIG_INPUT_MODE]) {
+		config_type = SCMI_PINCTRL_CONFIG_INPUT_VALUE;
+	} else if (priv->pins[id].status[SCMI_PINCTRL_CONFIG_OUTPUT_MODE]) {
+		config_type = SCMI_PINCTRL_CONFIG_OUTPUT_VALUE;
+	} else {
+		dev_err(dev, "Invalid pin mode: %u\n", offset);
+		return -EINVAL;
+	}
+
+	ret = scmi_pinctrl_config_get(pinctrl_dev, id, false,
+				      SCMI_PINCTRL_TYPE_PIN, config_type,
+				      &config);
+	if (ret) {
+		dev_err(dev, "config_get failed (%d)\n", ret);
+		return ret;
+	}
+
+	return config->value;
+}
+
+/**
+ * config_pin_set - Configure a pinctrl pin
+ * @dev:		SCMI pinctrl device
+ * @id:			Pin selector
+ * @config_type:	Configuration type
+ * @value:		Value
+ *
+ * Set a configuration of @config_type of a pinctrl pin, @id, to @value.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int config_pin_set(struct udevice *dev, u32 id, u32 config_type,
+			  u32 value)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	struct scmi_pin_entry config;
+	int ret;
+
+	config.type = config_type;
+	config.value = value;
+	ret = scmi_pinctrl_config_set(dev, id, SCMI_PINCTRL_TYPE_PIN,
+				      1, &config);
+	if (ret) {
+		dev_err(dev, "config_set failed (%d)\n", ret);
+		return ret;
+	}
+
+	priv->pins[id].status[config_type] = value;
+
+	return 0;
+}
+
+/**
+ * scmi_gpio_set_value - Set a value of a gpio pin
+ * @dev:	SCMI gpio device
+ * @offset:	Pin offset
+ * @value:	Value
+ *
+ * Set a value of a gpio pin in @offset to @value.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int scmi_gpio_set_value(struct udevice *dev, unsigned int offset,
+			       int value)
+{
+	struct udevice *pinctrl_dev;
+	u32 id;
+
+	if (map_to_id(dev, offset, &pinctrl_dev, &id)) {
+		dev_err(dev, "Invalid pin: %u\n", offset);
+		return -EINVAL;
+	}
+
+	return config_pin_set(pinctrl_dev, id,
+			      SCMI_PINCTRL_CONFIG_OUTPUT_VALUE,
+			      (u32)value);
+}
+
+/**
+ * scmi_gpio_get_function - Get a gpio function of a gpio pin
+ * @dev:	SCMI gpio device
+ * @offset:	Pin offset
+ *
+ * Get a gpio function of a gpio pin in @offset.
+ *
+ * Return:	GPIOF_OUTPUT or GPIO_INPUT on success, otherwise GPIOF_UNKNOWN
+ */
+static int scmi_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct udevice *pinctrl_dev;
+	u32 id;
+	struct scmi_pin_entry *config;
+	int ret;
+
+	if (map_to_id(dev, offset, &pinctrl_dev, &id)) {
+		dev_err(dev, "Invalid pin: %u\n", offset);
+		return -EINVAL;
+	}
+
+	ret = scmi_pinctrl_config_get(pinctrl_dev, id, false,
+				      SCMI_PINCTRL_TYPE_PIN,
+				      SCMI_PINCTRL_CONFIG_INPUT_MODE, &config);
+	if (!ret && config->value == 1)
+		return GPIOF_INPUT;
+
+	ret = scmi_pinctrl_config_get(pinctrl_dev, id, false,
+				      SCMI_PINCTRL_TYPE_PIN,
+				      SCMI_PINCTRL_CONFIG_OUTPUT_MODE,
+				      &config);
+	if (!ret && config->value == 1)
+		return GPIOF_OUTPUT;
+
+	return GPIOF_UNKNOWN;
+}
+
+/**
+ * set_flags - Adjust GPIO flags
+ * @dev:        SCMI gpio device
+ * @offset:     Pin offset
+ * @flags:      New flags value
+ *
+ * This function should set up the GPIO configuration according to information
+ * provided by @flags (GPIOD_xxx).
+ *
+ * @return 0 if OK, otherwise -ve on error
+ */
+static int scmi_gpio_set_flags(struct udevice *dev, unsigned int offset,
+			       ulong flags)
+{
+	struct udevice *pinctrl_dev;
+	struct scmi_pin_entry config[5]; /* 5 is enough for now */
+	u32 id;
+	struct scmi_pinctrl_priv *priv;
+	int i = 0, ret;
+
+	if (map_to_id(dev, offset, &pinctrl_dev, &id)) {
+		dev_err(dev, "Invalid pin: %u\n", offset);
+		return -EINVAL;
+	}
+
+	if (flags & GPIOD_IS_OUT) {
+		config[i].type = SCMI_PINCTRL_CONFIG_INPUT_MODE;
+		config[i++].value = 0;
+
+		config[i].type = SCMI_PINCTRL_CONFIG_OUTPUT_MODE;
+		config[i++].value = 1;
+		config[i].type = SCMI_PINCTRL_CONFIG_OUTPUT_VALUE;
+		config[i++].value = (u32)!!(flags & GPIOD_IS_OUT_ACTIVE);
+	} else if (flags & GPIOD_IS_IN) {
+		config[i].type = SCMI_PINCTRL_CONFIG_OUTPUT_MODE;
+		config[i++].value = 0;
+
+		config[i].type = SCMI_PINCTRL_CONFIG_INPUT_MODE;
+		config[i++].value = 1;
+	}
+
+	if (flags & GPIOD_OPEN_DRAIN) {
+		config[i].type = SCMI_PINCTRL_CONFIG_DRIVE_OPEN_DRAIN;
+		config[i++].value = 1;
+	} else if (flags & GPIOD_OPEN_SOURCE) {
+		config[i].type = SCMI_PINCTRL_CONFIG_DRIVE_OPEN_SOURCE;
+		config[i++].value = 1;
+	}
+
+	if (flags & GPIOD_PULL_UP) {
+		config[i].type = SCMI_PINCTRL_CONFIG_BIAS_PULL_UP;
+		config[i++].value = 1;
+	} else if (flags & GPIOD_PULL_DOWN) {
+		config[i].type = SCMI_PINCTRL_CONFIG_BIAS_PULL_DOWN;
+		config[i++].value = 1;
+	}
+
+	ret = scmi_pinctrl_config_set(pinctrl_dev, id, SCMI_PINCTRL_TYPE_PIN,
+				      i, config);
+	if (ret) {
+		dev_err(dev, "config_set failed (%d)\n", ret);
+		return ret;
+	}
+
+	/* update local status */
+	priv = dev_get_priv(pinctrl_dev);
+
+	if (flags & GPIOD_IS_OUT) {
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_OUTPUT_MODE] = 1;
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_OUTPUT_VALUE] = 1;
+
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_INPUT_MODE] = 0;
+	} else if (flags & GPIOD_IS_IN) {
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_INPUT_MODE] = 1;
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_OUTPUT_MODE] = 0;
+	}
+
+	if (flags & GPIOD_OPEN_DRAIN)
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_DRIVE_OPEN_DRAIN] = 1;
+	else if (flags & GPIOD_OPEN_SOURCE)
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_DRIVE_OPEN_SOURCE] =
+				1;
+
+	if (flags & GPIOD_PULL_UP)
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_BIAS_PULL_UP] = 1;
+	else if (flags & GPIOD_PULL_DOWN)
+		priv->pins[id].status[SCMI_PINCTRL_CONFIG_BIAS_PULL_DOWN] = 1;
+
+	return 0;
+}
+
+/**
+ * lookup_pin_group - find out a list of pins for group name
+ * @dev:	SCMI pinctrl device
+ * @name:	Name of a group
+ * @num_pins:	Pointer to a number of pins
+ * @pins:	Pointer to array of pin selectors
+ *
+ * Look up a group named @name and return a list of pin selectors associated with
+ * the group in @pins.
+ *
+ * Return:	0 on success, -1 on failure
+ */
+static int lookup_pin_group(struct udevice *dev, const char *name,
+			    u32 *num_pins, u16 **pins)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int i;
+
+	for (i = 0; i < priv->num_groups; i++)
+		if (!strcmp(name, priv->groups[i].name)) {
+			*num_pins = priv->groups[i].num_pins;
+			*pins = priv->groups[i].pins;
+			return 0;
+		}
+
+	return -1;
+}
+
+/**
+ * get_pinctrl_dev - Get a pin control device at node
+ * @node:	Reference to the node
+ *
+ * Get a pin control device at @node.
+ *
+ * Return:	0 on success, otherwise NULL
+ */
+static struct udevice *get_pinctrl_dev(ofnode *node)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+
+	if (uclass_get(UCLASS_PINCTRL, &uc))
+		return NULL;
+
+	uclass_foreach_dev(dev, uc)
+		if (dev->node_.np == node->np)
+			return dev;
+
+	return NULL;
+}
+
+/**
+ * scmi_gpio_probe - Probe a SCMI gpio device
+ * @dev:	SCMI gpio device
+ *
+ * Probe and initialize a SCMI gpio device.
+ *
+ * 0 on success, error code on failure
+ */
+static int scmi_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct scmi_pinctrl_gpio_plat *plat = dev_get_plat(dev);
+
+	struct scmi_pinctrl_gpio_map *range;
+	struct ofnode_phandle_args args;
+	const char *name;
+	int num_pins = 0, index, ret;
+
+	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
+	if (!uc_priv->bank_name)
+		uc_priv->bank_name = dev->name;
+
+	INIT_LIST_HEAD(&plat->gpio_map);
+	for (index = 0; ; index++) {
+		ret = dev_read_phandle_with_args(dev, "gpio-ranges",
+						 NULL, 3, index, &args);
+		if (ret)
+			break;
+
+		range = malloc(sizeof(*range));
+		if (!range) {
+			dev_err(dev, "Memory not available\n");
+			return -ENOMEM;
+		}
+
+		range->pinctrl_dev = get_pinctrl_dev(&args.node);
+		if (!range->pinctrl_dev) {
+			dev_err(dev, "Pin control device not found\n");
+			return -ENODEV;
+		}
+
+		/* make sure pinctrl is activated */
+		ret = device_probe(range->pinctrl_dev);
+		if (ret)
+			return ret;
+
+		if (args.args[2]) {
+			range->gpio_pin = args.args[0];
+			range->pinctrl_pin = args.args[1];
+			range->num_pins = args.args[2];
+			range->pinctrl_group = NULL;
+		} else {
+			ret = of_property_read_string_index(dev_np(dev),
+						"gpio-ranges-group-names",
+						index, &name);
+			if (ret) {
+				dev_err(dev,
+					"gpio-ranges-group-names required\n");
+				return ret;
+			}
+
+			ret = lookup_pin_group(range->pinctrl_dev, name,
+					       &range->num_pins,
+					       &range->pinctrl_group);
+			if (ret) {
+				dev_err(dev, "Group not found: %s\n", name);
+				return -EINVAL;
+			}
+
+			range->gpio_pin = args.args[0];
+		}
+		num_pins += range->num_pins;
+		list_add_tail(&range->node, &plat->gpio_map);
+	}
+
+	uc_priv->gpio_count = num_pins;
+
+	return 0;
+}
+
+static const struct dm_gpio_ops scmi_gpio_ops = {
+	.get_function = scmi_gpio_get_function,
+	.get_value = scmi_gpio_get_value,
+	.set_value = scmi_gpio_set_value,
+	.set_flags = scmi_gpio_set_flags,
+};
+
+static const struct udevice_id scmi_gpio_ids[] = {
+	{ .compatible = "arm,scmi-gpio-generic" },
+	{ }
+};
+
+U_BOOT_DRIVER(scmi_gpio) = {
+	.name = "scmi_gpio",
+	.id = UCLASS_GPIO,
+	.of_match = scmi_gpio_ids,
+	.of_to_plat = scmi_gpio_probe,
+	.ops = &scmi_gpio_ops,
+	.plat_auto = sizeof(struct scmi_pinctrl_gpio_plat),
+};
+
+/**
+ * scmi_gpiochip_register - Create a pinctrl-controlled gpio device
+ * @parent:	SCMI pinctrl device
+ *
+ * Create a pinctrl-controlled gpio device
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int scmi_gpiochip_register(struct udevice *parent)
+{
+	ofnode node;
+	struct driver *drv;
+	struct udevice *gpio_dev;
+	int ret;
+
+	/* TODO: recovery if failed */
+	dev_for_each_subnode(node, parent) {
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		if (!ofnode_read_prop(node, "gpio-controller", NULL))
+			/* not a GPIO node */
+			continue;
+
+		drv = DM_DRIVER_GET(scmi_gpio);
+		if (!drv) {
+			dev_err(parent, "No gpio driver?\n");
+			return -ENODEV;
+		}
+
+		ret = device_bind(parent, drv, ofnode_get_name(node), NULL,
+				  node, &gpio_dev);
+		if (ret) {
+			dev_err(parent, "failed to bind %s to gpio (%d)\n",
+				ofnode_get_name(node), ret);
+			return -ENODEV;
+		}
+
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * scmi_pinctrl_bind - Bind a pinctrl-controlled gpio device
+ * @dev:	SCMI pinctrl device
+ *
+ * Bind a pinctrl-controlled gpio device
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int scmi_pinctrl_bind(struct udevice *dev)
+{
+	int ret;
+
+	/* gpiochip register */
+	if (CONFIG_IS_ENABLED(DM_GPIO)) {
+		ret = scmi_gpiochip_register(dev);
+		if (ret && ret != -ENODEV) {
+			dev_err(dev, "failed to register gpio driver (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+#endif /* CONFIG_DM_GPIO */
+
 /**
  * scmi_pinctrl_probe - probe a device
  * @dev:	SCMI pinctrl device
@@ -532,6 +1063,9 @@ U_BOOT_DRIVER(scmi_pinctrl) = {
 	.name = "scmi_pinctrl",
 	.id = UCLASS_PINCTRL,
 	.ops = &scmi_pinctrl_ops,
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	.bind = scmi_pinctrl_bind,
+#endif
 	.probe = scmi_pinctrl_probe,
 	.priv_auto	= sizeof(struct scmi_pinctrl_priv),
 };
-- 
2.34.1

