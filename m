Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D88EB8FAE
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F964866A0;
	Wed,  6 Sep 2023 04:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mCGuD78X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6882833DE; Wed,  6 Sep 2023 04:41:09 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3899B866A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 04:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68a4dab8172so647493b3a.0
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 19:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693968063; x=1694572863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPYCnBRLWg4g7sl74QYJVP75Z/zmBm7PNVaK8xYbfG8=;
 b=mCGuD78XqGtgC4ymz8mMQMfZmYCeiD0oe7074mODiiOcin2PChvApLsJG+M/1j/uKo
 z0v0d6m9vr935Mv4ZEwhBciOsQePydtyhd0u5HxikicYYTqXsmVHhLbb+0pyBEAjwLe1
 qsBJ2ft9hKoIbu+K4pT+f1AApIocE67ZBrzA3tkwZYi5E27u1jMbVHsGQYZD5JqUU56x
 3dQaaftDzWm8vHMZJ1rNP2VXmr9Rlb08vsYvuF6AesSbg4yuiaw0KbF3ewC6vt9Dgkz8
 dWPGIQGGr9HC+1d/JV6jikx7/6XGEKnxaNaSR8wMBjtepfDJV3QVuiGFVcFL9PMnsBRv
 JxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693968063; x=1694572863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPYCnBRLWg4g7sl74QYJVP75Z/zmBm7PNVaK8xYbfG8=;
 b=HSmMIkIYT8VTgcGNF3I1XJWyEF/wNH9AcG25wCaGVKfxyVgvhIVBSmIkBHbSHELwwb
 LIHQ4X/UVkjd8WMpfKxCOshupqRdn57BsHoU8o3SYN0t2P9xygwq/EBW4FoOCYCaU3/Q
 Iplar0w3wLQdapyJNeLOVFann6daiSHaxcnnDE5s2U5aJrG8wdmQLLVF/mNcaVbFCvd8
 0LzhG8d/h66By3AP/wOx/Y3caYQe8NgPLuomTFhCJd9Rd0IZzQCw5HquWdacRlodvpx0
 sjf1E134PD4EnB/osITsYH/js48++lXBV5rM8lURxnH9xiCHAoZ0wZ673ohaFfLb0VoZ
 sgcA==
X-Gm-Message-State: AOJu0YzqVpbMrjldUrRnNsAPw3kn3xe+1QgTPRIYZiD+nCQL3eqh5MJY
 coS3s8yZeyDu9rBKf7mQeGVKnWG64ej++QIt6MWqxw==
X-Google-Smtp-Source: AGHT+IEpAau0JlfDFRUej9/PnC+yEDD4DXyTB/TnCOFrs8PhXOG7mfn62Wup4E3KelDh8SPzm+Nc6Q==
X-Received: by 2002:a05:6a20:a122:b0:13e:1d49:7249 with SMTP id
 q34-20020a056a20a12200b0013e1d497249mr19515911pzk.2.1693968063455; 
 Tue, 05 Sep 2023 19:41:03 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a6566c5000000b0056428865aadsm9145378pgw.82.2023.09.05.19.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 19:41:03 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 3/6] pinctrl: add scmi driver
Date: Wed,  6 Sep 2023 11:40:08 +0900
Message-Id: <20230906024011.17488-4-takahiro.akashi@linaro.org>
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
pinctrl devices exposed by SCMI firmware (server).

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 537 +++++++++++++++++++++++++++++++++
 3 files changed, 549 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 75b3ff47a2e8..d02f5db550c8 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -256,6 +256,17 @@ config PINCTRL_SANDBOX
 	  Currently, this driver actually does nothing but print debug
 	  messages when pinctrl operations are invoked.
 
+config PINCTRL_SCMI
+	bool "SCMI pinctrl driver"
+	depends on SCMI_FIRMWARE
+	select SCMI_PINCTRL
+	help
+	  This enables pinctrl driver base on  SCMI.
+
+	  The driver is controlled by a device tree node which contains
+	  both the GPIO definitions and pin control functions for each
+	  available multiplex function.
+
 config PINCTRL_SINGLE
 	bool "Single register pin-control and pin-multiplex driver"
 	depends on DM
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index fc1f01a02cbd..a791df022b7d 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
 obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
 obj-$(CONFIG_ARCH_NEXELL)	+= nexell/
 obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
 obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
new file mode 100644
index 000000000000..3ebdad57b86c
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linaro Limited
+ *		Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#define LOG_CATEGORY UCLASS_PINCTRL
+
+#include <common.h>
+#include <dm.h>
+#include <malloc.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+
+/**
+ * struct scmi_pin - attributes for a pin
+ * @name:	Name of pin
+ * @value:	Value of pin
+ * @flags:	A set of flags
+ * @function:	Function selected
+ * @status:	An array of status of configuration types
+ */
+struct scmi_pin {
+	char		*name;
+	u32		value;
+	u32		flags;
+	unsigned int	function;
+	u32		status[SCMI_PINCTRL_CONFIG_RESERVED];
+};
+
+/**
+ * struct scmi_group - attributes for a group
+ * @name:	Name of group
+ * @num_pins:	A number of pins
+ * @pins:	An array of pin id's
+ */
+struct scmi_group {
+	char		*name;
+	unsigned int	num_pins;
+	u16		*pins;
+};
+
+/**
+ * struct scmi_pinctrl_priv - private data for pinctrl device
+ * @num_pins:		A number of pins
+ * @num_groups:		A number of groups
+ * @num_functions:	A number of functions
+ * @pins:		An array of pins
+ * @groups:		An array of groups
+ * @functions:		An array of function names
+ */
+struct scmi_pinctrl_priv {
+	unsigned int	num_pins;
+	unsigned int	num_groups;
+	unsigned int	num_functions;
+	struct scmi_pin	*pins;
+	struct scmi_group *groups;
+	char		**functions;
+};
+
+static const struct pinconf_param scmi_conf_params[] = {
+	{ "default", SCMI_PINCTRL_CONFIG_DEFAULT, 1 },
+	{ "bias-bus-hold", SCMI_PINCTRL_CONFIG_BIAS_BUS_HOLD, 1 },
+	{ "bias-disable", SCMI_PINCTRL_CONFIG_BIAS_DISABLE, 1 },
+	{ "bias-high-impedance", SCMI_PINCTRL_CONFIG_BIAS_HI_IMPEDANCE, 1 },
+	{ "bias-pull-up", SCMI_PINCTRL_CONFIG_BIAS_PULL_UP, 1 },
+	{ "bias-pull-default", SCMI_PINCTRL_CONFIG_BIAS_PULL_DEF, 1 },
+	{ "bias-pull-down", SCMI_PINCTRL_CONFIG_BIAS_PULL_DOWN, 1 },
+	{ "drive-open-drain", SCMI_PINCTRL_CONFIG_DRIVE_OPEN_DRAIN, 1 },
+	{ "drive-open-source", SCMI_PINCTRL_CONFIG_DRIVE_OPEN_SOURCE, 1 },
+	{ "drive-push-pull", SCMI_PINCTRL_CONFIG_DRIVE_PUSH_PULL, 1 },
+	{ "drive-strength", SCMI_PINCTRL_CONFIG_DRIVE_STRENGTH, 0 },
+	{ "input-debounce", SCMI_PINCTRL_CONFIG_INPUT_DEBOUNCE, 0 },
+	{ "input-mode", SCMI_PINCTRL_CONFIG_INPUT_MODE, 1 },
+	{ "pull-mode", SCMI_PINCTRL_CONFIG_PULL_MODE, 0 },
+	{ "input-value", SCMI_PINCTRL_CONFIG_INPUT_VALUE, 0 },
+	{ "input-schmitt", SCMI_PINCTRL_CONFIG_INPUT_SCHMITT, 1 },
+	{ "low-power-mode", SCMI_PINCTRL_CONFIG_LOW_POWER_MODE, 1 },
+	{ "output-mode", SCMI_PINCTRL_CONFIG_OUTPUT_MODE, 1 },
+	{ "output-value", SCMI_PINCTRL_CONFIG_OUTPUT_VALUE, 0 },
+	{ "power-source", SCMI_PINCTRL_CONFIG_POWER_SOURCE, 0 },
+	{ "slew-rate", SCMI_PINCTRL_CONFIG_SLEW_RATE, 0 },
+};
+
+/**
+ * pinctrl_get_name - get a name
+ * @dev:	SCMI pinctrl device
+ * @type:	Type of id
+ * @id:		Identifier of pin, group or function
+ *
+ * Get a name of @id.
+ * @type can be SCMI_PINCTRL_TYPE_PIN, GROUP or FUNCTION.
+ * An extended name is returned if it is provided.
+ *
+ * Return: A pointer to the name, NULL if failed.
+ */
+static char *pinctrl_get_name(struct udevice *dev, unsigned int type,
+			      unsigned int id)
+{
+	u8 *name, *extended_name;
+	bool extended;
+	int ret;
+
+	ret = scmi_pinctrl_attrs(dev, id, type, &extended, &name);
+	if (ret) {
+		dev_err(dev, "failed to get attributes (%d)\n", ret);
+		return NULL;
+	}
+
+	if (!extended)
+		return name;
+
+	ret = scmi_pinctrl_name_get(dev, id, type, &extended_name);
+	if (ret) {
+		dev_err(dev, "failed to get extended_name (%d)\n", ret);
+		return name;
+	}
+
+	free(name);
+	return extended_name;
+}
+
+/**
+ * get_pins_count - Get the number of selectable pins
+ * @dev:	SCMI pinctrl device to use
+ *
+ * Get the number of selectable named pins available in this driver
+ *
+ * Return: a number of pins
+ */
+static int scmi_get_pins_count(struct udevice *dev)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	return priv->num_pins;
+}
+
+/**
+ * get_pin_name - Get the name of a pin
+ * @dev:	SCMI pinctrl device of the pin
+ * @selector:	The pin selector
+ *
+ * Get the name of a pin
+ *
+ * Return: a pointer to the name of the pin
+ */
+static const char *scmi_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	return pinctrl_get_name(dev, SCMI_PINCTRL_TYPE_PIN, selector);
+}
+
+/**
+ * get_pin_muxing - Show pin muxing
+ * @dev:	SCMI pinctrl device to use
+ * @selector:	Pin selector
+ * @buf:	Buffer to fill with pin muxing description
+ * @size:	Size of @buf
+ *
+ * Create a displayable information in @buf about the muxing of a given pin.
+ *
+ * @Return: 0 if OK, or negative error code on failure
+ */
+static int scmi_get_pin_muxing(struct udevice *dev, unsigned int selector,
+			       char *buf, int size)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	char tmp[100];
+	int i;
+
+	if (priv->pins[selector].function == UINT_MAX) {
+		strlcpy(buf, "<unknown>", size);
+		return 0;
+	}
+
+	sprintf(tmp, "%s", priv->functions[priv->pins[selector].function]);
+	strlcpy(buf, tmp, size);
+
+	for (i = 0; i < SCMI_PINCTRL_CONFIG_RESERVED; i++) {
+		/* TODO: distinguish 0 and "disabled" in status */
+		if (priv->pins[selector].status[i]) {
+			strlcat(buf, " ", size);
+			strlcat(buf, scmi_conf_params[i].property, size);
+		}
+	}
+	strlcat(buf, ".", size);
+
+	return 0;
+}
+
+/**
+ * get_groups_count - Get the number of selectable groups
+ * @dev:	SCMI pinctrl device to use
+ *
+ * Get a number of selectable groups
+ *
+ * Return: a number of selectable named groups available in the driver
+ */
+static int scmi_get_groups_count(struct udevice *dev)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	return priv->num_groups;
+}
+
+/**
+ * get_group_name - Get the name of a group
+ * @dev:	SCMI pinctrl device of the group
+ * @selector:	The group selector
+ *
+ * Ge the name of a group
+ *
+ * Return: a pointer to the name of the group
+ */
+static const char *scmi_get_group_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	return pinctrl_get_name(dev, SCMI_PINCTRL_TYPE_GROUP, selector);
+}
+
+/**
+ * get_functions_count - Get the number of selectable functions
+ * @dev:	SCMI pinctrl device to use
+ *
+ * Get a number of selectable functions
+ *
+ * Return: a number of selectable named functions available in this driver
+ */
+static int scmi_get_functions_count(struct udevice *dev)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	return priv->num_functions;
+}
+
+/**
+ * get_function_name - Get the name of a function
+ * @dev:	SCMI pinmux device of the function
+ * @selector:	The function selector
+ *
+ * Get a name of a function
+ *
+ * Return: a pointer to the function name of the muxing selector
+ */
+static const char *scmi_get_function_name(struct udevice *dev,
+					  unsigned int selector)
+{
+	return pinctrl_get_name(dev, SCMI_PINCTRL_TYPE_FUNCTION, selector);
+}
+
+/**
+ * pinmux_set - Mux a pin to a function
+ * @dev:		SCMI pinctrl device to use
+ * @pin_selector:	The pin selector
+ * @func_selector:	The func selector
+ *
+ * Set a function, @function_selector, to @pin_selector.
+ *
+ * Return: 0 if OK, or negative error code on failure
+ */
+static int scmi_pinmux_set(struct udevice *dev, unsigned int pin_selector,
+			   unsigned int func_selector)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = scmi_pinctrl_function_select(dev, pin_selector, func_selector,
+					   SCMI_PINCTRL_TYPE_PIN);
+	if (ret) {
+		dev_err(dev, "failed to select function (%d)\n", ret);
+		return ret;
+	}
+
+	priv->pins[pin_selector].function = func_selector;
+
+	return 0;
+}
+
+/**
+ * pinmux_group_set - Mux a group of pins to a function
+ * @dev:		SCMI pinctrl device to use
+ * @group_selector:	The group selector
+ * @func_selector:	The func selector
+ *
+ * Set a function, @function_selector, to @group_selector.
+ *
+ * @Return: 0 if OK, or negative error code on failure
+ */
+static int scmi_pinmux_group_set(struct udevice *dev,
+				 unsigned int group_selector,
+				 unsigned int func_selector)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int i, ret;
+
+	ret = scmi_pinctrl_function_select(dev, group_selector, func_selector,
+					   SCMI_PINCTRL_TYPE_GROUP);
+	if (ret) {
+		dev_err(dev, "failed to select function (%d)\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < priv->groups[group_selector].num_pins; i++)
+		priv->pins[priv->groups[group_selector].pins[i]].function =
+				func_selector;
+
+	return 0;
+}
+
+/* TODO: may be driver-specific */
+/**
+ * pinmux_property_set - Enable a pinmux group
+ * @dev:	SCMI pinctrl device to use
+ * @pinmux_group: A u32 representing the pin identifier and mux
+ *                settings.
+ *
+ * Mux a single pin to a single function based on a driver-specific
+ * pinmux group.
+ * The format of @pinmux_group follows ...
+ *
+ * Return: Pin selector for the muxed pin if OK, or negative error code on
+ *      failure
+ */
+static int scmi_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
+{
+	unsigned int pin_selector = pinmux_group & 0xFFFF;
+	unsigned int func_selector = pinmux_group >> 16;
+	int ret;
+
+	ret = scmi_pinmux_set(dev, pin_selector, func_selector);
+
+	return ret ? ret : pin_selector;
+}
+
+/**
+ * pinconf_set - Configure an individual pin with a parameter
+ * @dev:		SCMI pinctrl device to use
+ * @pin_selector:	The pin selector
+ * @param:		An &enum pin_config_param from @pinconf_params
+ * @argument:		The argument to this param from the device tree, or
+ *			@pinconf_params.default_value
+ *
+ * Configure @param of a pin, @pin_selector, with @argument.
+ *
+ * @Return: 0 if OK, or negative error code on failure
+ */
+static int scmi_pinconf_set(struct udevice *dev, unsigned int pin_selector,
+			    unsigned int param, unsigned int argument)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	struct scmi_pin_entry config;
+	int ret;
+
+	config.type = param;
+	config.value = argument;
+	ret = scmi_pinctrl_config_set(dev, pin_selector, SCMI_PINCTRL_TYPE_PIN,
+				      1, &config);
+	if (ret) {
+		dev_err(dev, "failed to set config (%d)\n", ret);
+		return ret;
+	}
+
+	if (param < SCMI_PINCTRL_CONFIG_RESERVED)
+		priv->pins[pin_selector].status[param] = argument;
+
+	return 0;
+}
+
+/**
+ * pinconf_group_set - Configure all pins in a group with a parameter
+ * @dev:		SCmi pinctrl device to use
+ * @group_selector:	The group selector
+ * @param:		A &enum pin_config_param from @pinconf_params
+ * @argument:		The argument to this param from the device tree, or
+ *			@pinconf_params.default_value
+ *
+ * Configure @param of all the pins in a group, @group_selector, with @argument.
+ *
+ * @Return: 0 if OK, or negative error code on failure
+ */
+static int scmi_pinconf_group_set(struct udevice *dev,
+				  unsigned int group_selector,
+				  unsigned int param, unsigned int argument)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	struct scmi_pin_entry config;
+	int i, ret;
+
+	config.type = param;
+	config.value = argument;
+	ret = scmi_pinctrl_config_set(dev, group_selector,
+				      SCMI_PINCTRL_TYPE_GROUP, 1, &config);
+	if (ret) {
+		dev_err(dev, "failed to set config (%d)\n", ret);
+		return ret;
+	}
+
+	if (param >= SCMI_PINCTRL_CONFIG_RESERVED)
+		return 0;
+
+	for (i = 0; i < priv->groups[group_selector].num_pins; i++)
+		priv->pins[priv->groups[group_selector].pins[i]].status[param] =
+				argument;
+
+	return 0;
+}
+
+const struct pinctrl_ops scmi_pinctrl_ops = {
+	.get_pins_count = scmi_get_pins_count,
+	.get_pin_name = scmi_get_pin_name,
+	.get_pin_muxing = scmi_get_pin_muxing,
+	.get_groups_count = scmi_get_groups_count,
+	.get_group_name = scmi_get_group_name,
+	.get_functions_count = scmi_get_functions_count,
+	.get_function_name = scmi_get_function_name,
+	.pinmux_set = scmi_pinmux_set,
+	.pinmux_group_set = scmi_pinmux_group_set,
+	.pinmux_property_set = scmi_pinmux_property_set,
+	.pinconf_num_params = ARRAY_SIZE(scmi_conf_params),
+	.pinconf_params = scmi_conf_params,
+	.pinconf_set = scmi_pinconf_set,
+	.pinconf_group_set = scmi_pinconf_group_set,
+	.set_state = pinctrl_generic_set_state,
+};
+
+/**
+ * scmi_pinctrl_probe - probe a device
+ * @dev:	SCMI pinctrl device
+ *
+ * Probe and initialize a pinctrl device.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	u32 version;
+	char *name;
+	int i, ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "failed to get channel (%d)\n", ret);
+		return ret;
+	}
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_PIN_CONTROL,
+					    &version);
+	if (ret || version < SCMI_PIN_CONTROL_PROTOCOL_VERSION) {
+		dev_err(dev, "protocol version doesn't match (%d)\n", version);
+		return -EINVAL;
+	}
+
+	ret = scmi_pinctrl_protocol_attrs(dev, &priv->num_pins,
+					  &priv->num_groups,
+					  &priv->num_functions);
+	if (ret) {
+		dev_err(dev, "failed to get protocol attributes (%d)\n", ret);
+		return ret;
+	}
+
+	priv->pins = calloc(sizeof(struct scmi_pin), priv->num_pins);
+	if (!priv->pins) {
+		dev_err(dev, "memory not available\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < priv->num_pins; i++) {
+		priv->pins[i].function = UINT_MAX; /* unknown yet */
+		name = scmi_get_pin_name(dev, i);
+		if (!name) {
+			dev_err(dev, "failed to get pin name\n");
+			return ret;
+		}
+		priv->pins[i].name = strdup(name);
+		free(name);
+		if (!priv->pins[i].name) {
+			dev_err(dev, "memory not available\n");
+			return -ENOMEM;
+		}
+	}
+
+	priv->groups = calloc(sizeof(struct scmi_group), priv->num_groups);
+	if (!priv->groups)
+		return -ENOMEM;
+	for (i = 0; i < priv->num_groups; i++) {
+		name = scmi_get_group_name(dev, i);
+		if (!name) {
+			dev_err(dev, "failed to get group name\n");
+			return ret;
+		}
+		priv->groups[i].name = strdup(name);
+		free(name);
+		if (!priv->groups[i].name) {
+			dev_err(dev, "memory not available\n");
+			return -ENOMEM;
+		}
+
+		ret = scmi_pinctrl_list_assocs(dev, i, SCMI_PINCTRL_TYPE_GROUP,
+					       &priv->groups[i].pins);
+		if (ret < 0) {
+			dev_err(dev, "failed to enumerate pins (%d)\n", ret);
+			return ret;
+		}
+
+		priv->groups[i].num_pins = ret;
+	}
+
+	priv->functions = calloc(sizeof(char *), priv->num_functions);
+	if (!priv->functions) {
+		dev_err(dev, "memory not available\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < priv->num_functions; i++) {
+		name = scmi_get_function_name(dev, i);
+		if (!name) {
+			dev_err(dev, "failed to get group name\n");
+			return ret;
+		}
+		priv->functions[i] = strdup(name);
+		free(name);
+		if (!priv->functions[i]) {
+			dev_err(dev, "memory not available\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(scmi_pinctrl) = {
+	.name = "scmi_pinctrl",
+	.id = UCLASS_PINCTRL,
+	.ops = &scmi_pinctrl_ops,
+	.probe = scmi_pinctrl_probe,
+	.priv_auto	= sizeof(struct scmi_pinctrl_priv),
+};
-- 
2.34.1

