Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABB8EA4FCB
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 14:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E7383DEA;
	Mon, 23 Feb 2026 15:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x2LAZS43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26D583935; Mon, 23 Feb 2026 15:33:44 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF5280077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so3324570f8f.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771857219; x=1772462019; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pNXHGB+jdDk9jUyEETHQq/WQRiEUalSMF/y9fhvY/M4=;
 b=x2LAZS43hIdOGP5WhMRKc4wCQEpIayQfLNhCBsSvjBb/Ni8aRMslxJUKWmcR9eW424
 xg6yU0tjJHrMRKjlyidtQGIl8b2/KmpiwF8zEsfLbDsOomuzKwkO1kWA6FpJvwhfRmES
 CgbqoSOvRgqJguJdZISjuitBa6221S5NU64fvFdIz9akoYAYy5ss/sp+nwvE43FPhDPe
 6LI6bN8VlProMnwwFAL2SpyjEujevWSm/avPLojZXoa4naQVlgx8h89HyeRW8fXwkJ0E
 CIb9Z1KaV5rh7GXQwD46qL3FCs8Jw6zolexQTdJMD8/o+MdQnRQw2X2H3uRKPht5gpD+
 b/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771857219; x=1772462019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNXHGB+jdDk9jUyEETHQq/WQRiEUalSMF/y9fhvY/M4=;
 b=avsbKbcdqFjcu1wkMl2n2qjvZXb4dKXpNFVSokHOS2Pjrgoqci4BuWukD8EAGJ4NYm
 qaUAx/RAs4GDbwNwR5GxeWJHBT4nzKr/suD8LRC2OR9m4Mn+YI21FH8dm1sj9JB8vcfX
 0mKUapgyjCyEYum/JUzqSUi8W37XokrD5dLMBc8uGfCZ0IVjhR+xAOEHa2bN+zAplAzy
 7SnQ3AqWvChK8z/TCVZP0w+kEOen6yi1z94rO/BLbXqobe1rlHnzPwTc4Yr1A37g6om8
 V2vTcq6YS8I6GoRLgbYgm+TyLrFGpiaPPcxahdH0TIhnmLziwOfqdImxigir9cYnYvE0
 ibZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK9DYCGdELslaCZVkH955026LZlm1qOAnOb4I0yPa51YRFJBpmmQ1f19EbSIhInqppOq9jb8U=@lists.denx.de
X-Gm-Message-State: AOJu0YwxBwoMQKh8ssFzWmrwKvTngz9HoaXYQxSjiIYgNbuTLvnMyA/1
 qbZsSGMV8dEPyqUXiMiZLogx0WeMD24ER7vt7sOq8xCaJFf1CkXuZjRDA/25hWcMH4s=
X-Gm-Gg: AZuq6aLHwwv+6Nc/T7puAVCmc6A5h2qZ/O+lm8QgYv1q6DZrNnkldPbQCdaipooJ2dE
 Y1qefL37cUogBEUOzht0xvmiB4gX2cXNpn8XZjhp+z+T3CFqrKcasWET7lcoGFeibt1c/XsG71N
 2FV0WAqJYoyz3tMxleztSnpaHwg47aI2028Sp2Uf3urq62QnEk99CWj4b4FDzrkRTMdF3tREJfy
 HHNuS01Me0h2KGRR3HkF0X7mG4QvQRQt1tsT+6NZ0qYwhxOHOo2SezEBwZJKZXZwC21Szxiu4Gc
 EW2iA4X8lW4J2UrQJiJDBLFphRz2T+HvialxQZuuMJl/kvdcCEKQgWGUWYLq43pBX9sIA1JFMFW
 uE6/Lr7dbTl/hk7cfxvvjxsAQLi6AD4FIgSFR3xt/EUq3y3u+Sl/ysjVpr7uJPkUM+zNicrwZSA
 OHVxA7vn+ZPOYyrJPNJaepb/dN4eOw
X-Received: by 2002:a05:600c:8b88:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-483a9636340mr132992235e9.29.1771857219175; 
 Mon, 23 Feb 2026 06:33:39 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3dfd902sm87934355e9.7.2026.02.23.06.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 06:33:38 -0800 (PST)
Date: Mon, 23 Feb 2026 17:33:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@denx.de>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Anis Chali <chalianis1@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Ye Li <ye.li@nxp.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 3/4] scmi: pinctrl: add pinctrl driver for SCMI
Message-ID: <a9f8de77176cf0b8afa2f1addd0183f52da9d00c.1771856828.git.dan.carpenter@linaro.org>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771856828.git.dan.carpenter@linaro.org>
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

This driver adds the base support of pinctrl over SCMI.  The driver
does two main things.  First it allows you to configure the initial
pin states.  And second it's used a base to build a GPIO driver on
top of it.

To configure the states then add a pinmux config to the scmi_pinctrl
section:

                        scmi_pinctrl: protocol@19 {
                                reg = <0x19>;
                                pinmux1: pinmux_test {
                                        pinmux = <0 1 0xFFFFFFFF 18 1
                                                  0 2 0xFFFFFFFF 18 0
                                                  0 3 0xFFFFFFFF 18 1>;
                                };
                        };

The numbers are from PINCTRL_SETTINGS_CONFIGURE: selector, identifier,
function_id, config_type, and config_value.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/scmi/Makefile            |   1 +
 drivers/firmware/scmi/pinctrl.c           | 363 ++++++++++++++++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c |   4 +-
 drivers/pinctrl/Kconfig                   |   9 +
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/pinctrl-scmi.c            | 357 +++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +-
 include/scmi_protocols.h                  | 356 +++++++++++++++++++++
 8 files changed, 1090 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makefile
index 6129726f8173..761d89a11615 100644
--- a/drivers/firmware/scmi/Makefile
+++ b/drivers/firmware/scmi/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_SCMI_AGENT_SMCCC)		+= smccc_agent.o
 obj-$(CONFIG_SCMI_AGENT_MAILBOX)	+= mailbox_agent.o
 obj-$(CONFIG_SCMI_AGENT_OPTEE)	+= optee_agent.o
 obj-$(CONFIG_SCMI_POWER_DOMAIN)		+= pwdom.o
+obj-$(CONFIG_PINCTRL_SCMI)		+= pinctrl.o
 obj-$(CONFIG_SANDBOX)		+= sandbox-scmi_agent.o sandbox-scmi_devices.o
 obj-y += vendors/imx/
diff --git a/drivers/firmware/scmi/pinctrl.c b/drivers/firmware/scmi/pinctrl.c
new file mode 100644
index 000000000000..981bf64cd74b
--- /dev/null
+++ b/drivers/firmware/scmi/pinctrl.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#define LOG_CATEGORY UCLASS_PINCTRL
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/pinctrl.h>
+#include <linux/bitfield.h>
+#include <linux/compat.h>
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <scmi_protocols.h>
+
+static int map_config_param_to_scmi(u32 config_param)
+{
+	switch (config_param) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		return SCMI_PIN_BIAS_BUS_HOLD;
+	case PIN_CONFIG_BIAS_DISABLE:
+		return SCMI_PIN_BIAS_DISABLE;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		return SCMI_PIN_BIAS_HIGH_IMPEDANCE;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return SCMI_PIN_BIAS_PULL_DOWN;
+	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		return SCMI_PIN_BIAS_PULL_DEFAULT;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return SCMI_PIN_BIAS_PULL_UP;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return SCMI_PIN_DRIVE_OPEN_DRAIN;
+	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		return SCMI_PIN_DRIVE_OPEN_SOURCE;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return SCMI_PIN_DRIVE_PUSH_PULL;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		return SCMI_PIN_DRIVE_STRENGTH;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return SCMI_PIN_INPUT_DEBOUNCE;
+	case PIN_CONFIG_INPUT_ENABLE:
+		return SCMI_PIN_INPUT_MODE;
+	case PIN_CONFIG_INPUT_SCHMITT:
+		return SCMI_PIN_INPUT_SCHMITT;
+	case PIN_CONFIG_LOW_POWER_MODE:
+		return SCMI_PIN_LOW_POWER_MODE;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		return SCMI_PIN_OUTPUT_MODE;
+	case PIN_CONFIG_OUTPUT:
+		return SCMI_PIN_OUTPUT_VALUE;
+	case PIN_CONFIG_POWER_SOURCE:
+		return SCMI_PIN_POWER_SOURCE;
+	case PIN_CONFIG_SLEW_RATE:
+		return SCMI_PIN_SLEW_RATE;
+	}
+
+	return -EINVAL;
+}
+
+int scmi_pinctrl_protocol_attrs(struct udevice *dev, int *num_pins,
+				int *num_groups, int *num_functions)
+{
+	struct scmi_pinctrl_protocol_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
+		.message_id = SCMI_PROTOCOL_ATTRIBUTES,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*num_groups = FIELD_GET(GENMASK(31, 16), out.attr_low);
+	*num_pins = FIELD_GET(GENMASK(15, 0), out.attr_low);
+	*num_functions = FIELD_GET(GENMASK(15, 0), out.attr_high);
+
+	return 0;
+}
+
+int scmi_pinctrl_attrs(struct udevice *dev, enum select_type select_type,
+		       unsigned int selector, bool *gpio, unsigned int *count,
+		       char *name)
+{
+	struct scmi_pinctrl_attrs_in in;
+	struct scmi_pinctrl_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
+		.message_id = SCMI_PINCTRL_ATTRIBUTES,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	in.select_type = select_type;
+	in.id = selector;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	//estended_name = FIELD_GET(BIT(31), out.attr);
+	if (gpio)
+		*gpio = FIELD_GET(BIT(17), out.attr);
+	//pin_only = FIELD_GET(BIT(16), out.attr);
+	if (count)
+		*count = FIELD_GET(GENMASK(15, 0), out.attr);
+	memcpy(name, out.name, sizeof(out.name));
+
+	return 0;
+}
+
+int scmi_pinctrl_list_associations(struct udevice *dev,
+				   enum select_type select_type,
+				   unsigned int selector,
+				   unsigned short *output,
+				   unsigned short num_out)
+{
+	struct scmi_pinctrl_list_associations_in in;
+	struct scmi_pinctrl_list_associations_out *out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
+		.message_id = SCMI_PINCTRL_LIST_ASSOCIATIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+	};
+	size_t out_sz = sizeof(*out) + num_out * sizeof(out->array[0]);
+	unsigned int count;
+	int ret = -EINVAL;
+
+	out = kzalloc(out_sz, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = out_sz;
+	in.select_type = select_type;
+	in.id = selector;
+	in.index = 0;
+
+	while (num_out > 0) {
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			goto free;
+		if (out->status) {
+			ret = scmi_to_linux_errno(out->status);
+			goto free;
+		}
+
+		count = FIELD_GET(GENMASK(11, 0), out->flags);
+		if (count > num_out)
+			return -EINVAL;
+		memcpy(&output[in.index], out->array, count * sizeof(u16));
+		num_out -= count;
+		in.index += count;
+	}
+free:
+	kfree(out);
+	return ret;
+}
+
+#define SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION -2u
+
+int scmi_pinctrl_settings_get_one(struct udevice *dev, enum select_type select_type,
+				  unsigned int selector,
+				  u32 config_type, u32 *value)
+{
+	struct scmi_pinctrl_settings_get_in in;
+	struct scmi_pinctrl_settings_get_out *out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
+		.message_id = SCMI_PINCTRL_SETTINGS_GET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+	};
+	size_t out_sz = sizeof(*out) + (1 * sizeof(u32) * 2);
+	u32 num_configs;
+	int ret;
+
+	out = kzalloc(out_sz, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = out_sz;
+	in.id = selector;
+	in.attr = 0;
+	if (config_type == SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION)
+		in.attr = FIELD_PREP(GENMASK(19, 18), 2);
+	in.attr |= FIELD_PREP(GENMASK(17, 16), select_type);
+	if (config_type != SCMI_PINCTRL_CONFIG_SETTINGS_FUNCTION)
+		in.attr |= FIELD_PREP(GENMASK(7, 0), config_type);
+
+	if (config_type == SCMI_PINCTRL_CONFIG_SETTINGS_ALL) {
+		/* FIXME: implement */
+		return -EIO;
+	}
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		goto free;
+	if (out->status) {
+		ret = scmi_to_linux_errno(out->status);
+		goto free;
+	}
+	num_configs = FIELD_GET(GENMASK(7, 0), out->num_configs);
+	if (out->num_configs == 0) {
+		*value = out->function_selected;
+		goto free;
+	}
+	if (num_configs != 1) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	*value = out->configs[1];
+free:
+	kfree(out);
+	return ret;
+}
+
+static int scmi_pinctrl_settings_configure_helper(struct udevice *dev,
+						  enum select_type select_type,
+						  unsigned int selector,
+						  u32 function_id,
+						  u16 num_configs, u32 *configs)
+{
+	struct scmi_pinctrl_settings_configure_in *in;
+	struct scmi_pinctrl_settings_configure_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
+		.message_id = SCMI_PINCTRL_SETTINGS_CONFIGURE,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	size_t in_sz = sizeof(*in) + (num_configs * sizeof(u32) * 2);
+	int ret;
+
+	in = kzalloc(in_sz, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	msg.in_msg = (u8 *)in;
+	msg.in_msg_sz = in_sz;
+	in->id = selector;
+	in->function_id = function_id;
+	in->attr = 0;
+	in->attr |= FIELD_PREP(GENMASK(9, 2), num_configs);
+	in->attr |= FIELD_PREP(GENMASK(1, 0), select_type);
+	memcpy(in->configs, configs, num_configs * sizeof(32) * 2);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		goto free;
+	if (out.status) {
+		ret = scmi_to_linux_errno(out.status);
+		goto free;
+	}
+free:
+	kfree(in);
+	return ret;
+}
+
+int scmi_pinctrl_settings_configure(struct udevice *dev, enum select_type select_type,
+				    unsigned int selector, u16 num_configs,
+				    u32 *configs)
+{
+	return scmi_pinctrl_settings_configure_helper(dev, select_type,
+						      selector,
+						      SCMI_PINCTRL_FUNCTION_NONE,
+						      num_configs, configs);
+}
+
+int scmi_pinctrl_settings_configure_one(struct udevice *dev, enum select_type select_type,
+					unsigned int selector,
+					u32 param, u32 argument)
+{
+	u32 config_value[2];
+	int scmi_config;
+
+	/* see stmfx_pinctrl_conf_set() */
+	scmi_config = map_config_param_to_scmi(param);
+	if (scmi_config < 0)
+		return scmi_config;
+
+	config_value[0] = scmi_config;
+	config_value[1] = argument;
+
+	return scmi_pinctrl_settings_configure(dev, select_type, selector, 1,
+					       &config_value[0]);
+}
+
+int scmi_pinctrl_set_function(struct udevice *dev, enum select_type select_type,
+			      unsigned int selector, u32 function_id)
+{
+	return scmi_pinctrl_settings_configure_helper(dev, select_type, selector,
+						      function_id, 0, NULL);
+}
+
+int scmi_pinctrl_request(struct udevice *dev, enum select_type select_type,
+			 unsigned int selector)
+{
+	struct scmi_pinctrl_request_in in;
+	struct scmi_pinctrl_request_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
+		.message_id = SCMI_PINCTRL_REQUEST,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	in.id = selector;
+	in.flags = FIELD_PREP(GENMASK(1, 0), select_type);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	return 0;
+}
+
+int scmi_pinctrl_release(struct udevice *dev, enum select_type select_type,
+			 unsigned int selector)
+{
+	struct scmi_pinctrl_release_in in;
+	struct scmi_pinctrl_release_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PINCTRL,
+		.message_id = SCMI_PINCTRL_RELEASE,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	in.id = selector;
+	in.flags = FIELD_PREP(GENMASK(1, 0), select_type);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	return 0;
+}
+
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index ad825d66da2d..cd458a7f4588 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -106,7 +106,7 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 		proto = priv->voltagedom_dev;
 		break;
 #endif
-#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
+#if IS_ENABLED(CONFIG_PINCTRL_SCMI) || IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
 	case SCMI_PROTOCOL_ID_PINCTRL:
 		proto = priv->pinctrl_dev;
 		break;
@@ -179,7 +179,7 @@ static int scmi_add_protocol(struct udevice *dev,
 		priv->voltagedom_dev = proto;
 		break;
 #endif
-#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
+#if IS_ENABLED(CONFIG_PINCTRL_SCMI) || IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
 	case SCMI_PROTOCOL_ID_PINCTRL:
 		priv->pinctrl_dev = proto;
 		break;
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index ea90713ec6ca..512c396880c4 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -291,6 +291,15 @@ config PINCTRL_SANDBOX
 	  Currently, this driver actually does nothing but print debug
 	  messages when pinctrl operations are invoked.
 
+config PINCTRL_SCMI
+	bool "Support SCMI pin controllers"
+	depends on PINCTRL_FULL && SCMI_FIRMWARE
+	help
+	  This is for pinctrl over the SCMI protocol.  This allows the
+	  initial pin configuration to be set up from the device tree.  The
+	  gpio_scmi driver is built on top of this driver if GPIO is
+	  required.
+
 config PINCTRL_SINGLE
 	bool "Single register pin-control and pin-multiplex driver"
 	depends on DM
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 33ff7b95ef22..8ab163531821 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
 obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
 obj-$(CONFIG_ARCH_NEXELL)	+= nexell/
 obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
 obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
new file mode 100644
index 000000000000..32594489178a
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <scmi_protocols.h>
+
+static const struct pinconf_param pinctrl_scmi_conf_params[] = {
+	{ "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0},
+	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
+	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
+	{ "bias-pull-pin-default", PIN_CONFIG_BIAS_PULL_PIN_DEFAULT, 0 },
+	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 0 },
+	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
+	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
+	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
+	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
+	{ "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
+	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
+	{ "input-schmitt", PIN_CONFIG_INPUT_SCHMITT, 0 },
+	{ "low-power-mode", PIN_CONFIG_LOW_POWER_MODE, 0 },
+	{ "output-mode", PIN_CONFIG_OUTPUT_ENABLE, 0 },
+	{ "output-value", PIN_CONFIG_OUTPUT, 0 },
+	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
+	{ "slew-rate", PIN_CONFIG_SLEW_RATE, 0 },
+	/* The SCMI spec also include "default", "pull-mode" and "input-value */
+};
+
+static bool valid_selector(struct udevice *dev, enum select_type select_type, u32 selector)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	if (select_type == SCMI_PIN)
+		return selector < priv->num_pins;
+	if (select_type == SCMI_GROUP)
+		return selector < priv->num_groups;
+	if (select_type == SCMI_FUNCTION)
+		return selector < priv->num_functions;
+
+	return false;
+}
+
+static int pinctrl_scmi_get_pins_count(struct udevice *dev)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	return priv->num_pins;
+}
+
+static int pinctrl_scmi_get_groups_count(struct udevice *dev)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	return priv->num_groups;
+}
+
+static int pinctrl_scmi_get_functions_count(struct udevice *dev)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	return priv->num_functions;
+}
+
+static const char *pinctrl_scmi_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	if (selector >= priv->num_pins)
+		return NULL;
+
+	return (const char *)priv->pin_info[selector].name;
+}
+
+static const char *pinctrl_scmi_get_group_name(struct udevice *dev, unsigned int selector)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	if (selector >= priv->num_groups)
+		return NULL;
+
+	return (const char *)priv->group_info[selector].name;
+}
+
+static const char *pinctrl_scmi_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	if (selector >= priv->num_functions)
+		return NULL;
+
+	return (const char *)priv->function_info[selector].name;
+}
+
+static int pinctrl_scmi_pinmux_set(struct udevice *dev, u32 pin, u32 function)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	if (pin >= priv->num_pins || function >= priv->num_functions)
+		return -EINVAL;
+
+	return scmi_pinctrl_set_function(dev, SCMI_PIN, pin, function);
+}
+
+static int pinctrl_scmi_pinmux_group_set(struct udevice *dev, u32 group, u32 function)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+
+	if (group >= priv->num_groups || function >= priv->num_functions)
+		return -EINVAL;
+
+	return scmi_pinctrl_set_function(dev, SCMI_GROUP, group, function);
+}
+
+static int pinctrl_scmi_set_state(struct udevice *dev, struct udevice *config)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+	const int batch_count = 20;
+	u32 prev_type = -1u;
+	u32 prev_selector;
+	u32 *configs;
+	const u32 *prop;
+	int offset, cnt, len;
+	int ret = 0;
+
+	prop = dev_read_prop(config, "pinmux", &len);
+	if (!prop)
+		return 0;
+
+	if (len % sizeof(u32) * 5) {
+		dev_err(dev, "invalid pin configuration: len=%d\n", len);
+		return -FDT_ERR_BADSTRUCTURE;
+	}
+
+	configs = kcalloc(batch_count, sizeof(u32), GFP_KERNEL);
+	if (!configs)
+		return -ENOMEM;
+
+	offset = 0;
+	cnt = 0;
+	while (offset + 4 < len / sizeof(u32)) {
+		u32 select_type  = fdt32_to_cpu(prop[offset]);
+		u32 selector     = fdt32_to_cpu(prop[offset + 1]);
+		u32 function     = fdt32_to_cpu(prop[offset + 2]);
+		u32 config_type  = fdt32_to_cpu(prop[offset + 3]);
+		u32 config_value = fdt32_to_cpu(prop[offset + 4]);
+
+		if (select_type > SCMI_GROUP ||
+		    !valid_selector(dev, select_type, selector) ||
+		    (function != SCMI_PINCTRL_FUNCTION_NONE &&
+		     function > priv->num_functions)) {
+			dev_err(dev, "invalid pinctrl data (%u %u %u %u %u)\n",
+				select_type, selector, function, config_type,
+				config_value);
+			ret = -EINVAL;
+			goto free;
+		}
+
+		if (function != SCMI_PINCTRL_FUNCTION_NONE) {
+			if (cnt) {
+				scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
+								cnt / 2, configs);
+				prev_type = -1u;
+				cnt = 0;
+			}
+			scmi_pinctrl_set_function(dev, select_type, selector, function);
+			offset += 5;
+			continue;
+		}
+
+		if (cnt == batch_count)
+			goto set;
+
+		if (prev_type == -1u)
+			goto store;
+
+		if (select_type == prev_type &&
+		    selector == prev_selector)
+			goto store;
+set:
+		scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
+						cnt / 2, configs);
+		cnt = 0;
+store:
+		prev_type = select_type;
+		prev_selector = selector;
+		configs[cnt++] = config_type;
+		configs[cnt++] = config_value;
+		offset += 5;
+	}
+
+	if (cnt)
+		scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
+						cnt / 2, configs);
+free:
+	kfree(configs);
+
+	return ret;
+}
+
+static int get_pin_muxing(struct udevice *dev, unsigned int selector,
+			  char *buf, int size)
+{
+	u32 value;
+	int ret;
+
+	ret = scmi_pinctrl_settings_get_one(dev, SCMI_PIN, selector,
+					    SCMI_PIN_INPUT_VALUE, &value);
+	if (ret) {
+		dev_err(dev, "settings_get() failed: %d\n", ret);
+		return ret;
+	}
+
+	snprintf(buf, size, "%d", value);
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_set(struct udevice *dev, u32 pin, u32 param, u32 argument)
+{
+	return scmi_pinctrl_settings_configure_one(dev, SCMI_PIN, pin, param, argument);
+}
+
+static int pinctrl_scmi_pinconf_group_set(struct udevice *dev, u32 group, u32 param, u32 argument)
+{
+	return scmi_pinctrl_settings_configure_one(dev, SCMI_GROUP, group, param, argument);
+}
+
+static struct pinctrl_ops scmi_pinctrl_ops = {
+	.get_pins_count = pinctrl_scmi_get_pins_count,
+	.get_pin_name = pinctrl_scmi_get_pin_name,
+
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+
+	.get_functions_count = pinctrl_scmi_get_functions_count,
+	.get_function_name = pinctrl_scmi_get_function_name,
+
+	.pinmux_set = pinctrl_scmi_pinmux_set,
+	.pinmux_group_set = pinctrl_scmi_pinmux_group_set,
+
+	.pinconf_num_params = ARRAY_SIZE(pinctrl_scmi_conf_params),
+	.pinconf_params = pinctrl_scmi_conf_params,
+
+	.pinconf_set = pinctrl_scmi_pinconf_set,
+	.pinconf_group_set = pinctrl_scmi_pinconf_group_set,
+	.set_state = pinctrl_scmi_set_state,
+	.get_pin_muxing = get_pin_muxing,
+};
+
+static int scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+	int ret;
+	int i;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "get_channel() failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = scmi_pinctrl_protocol_attrs(dev, &priv->num_pins,
+					  &priv->num_groups,
+					  &priv->num_functions);
+	if (ret) {
+		dev_err(dev, "failed to get protocol attributes: %d\n", ret);
+		return ret;
+	}
+
+	priv->pin_info = devm_kcalloc(dev, priv->num_pins,
+				      sizeof(*priv->pin_info), GFP_KERNEL);
+	priv->group_info = devm_kcalloc(dev, priv->num_groups,
+					sizeof(*priv->group_info), GFP_KERNEL);
+	priv->function_info = devm_kcalloc(dev, priv->num_functions,
+					   sizeof(*priv->function_info), GFP_KERNEL);
+	if (!priv->pin_info || !priv->group_info || !priv->function_info)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_pins; i++) {
+		ret = scmi_pinctrl_attrs(dev, SCMI_PIN, i, NULL, NULL,
+					 priv->pin_info[i].name);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < priv->num_groups; i++) {
+		ret = scmi_pinctrl_attrs(dev, SCMI_GROUP, i, NULL,
+					 &priv->group_info[i].num_pins,
+					 priv->group_info[i].name);
+		if (ret) {
+			dev_err(dev, "loading group %d failed: %d\n", i, ret);
+			return ret;
+		}
+		priv->group_info[i].pins = devm_kcalloc(dev,
+							priv->group_info[i].num_pins,
+							sizeof(*priv->group_info[i].pins),
+							GFP_KERNEL);
+		if (!priv->group_info[i].pins)
+			return -ENOMEM;
+
+		ret = scmi_pinctrl_list_associations(dev, SCMI_GROUP, i,
+						     priv->group_info[i].pins,
+						     priv->group_info[i].num_pins);
+		if (ret) {
+			dev_err(dev, "list association %d failed for group: %d\n", i, ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < priv->num_functions; i++) {
+		ret = scmi_pinctrl_attrs(dev, SCMI_FUNCTION, i, NULL,
+					 &priv->function_info[i].num_groups,
+					 priv->function_info[i].name);
+		if (ret) {
+			dev_err(dev, "loading function %d failed: %d\n", i, ret);
+			return ret;
+		}
+		priv->function_info[i].groups = devm_kcalloc(dev,
+					priv->function_info[i].num_groups,
+					sizeof(*priv->function_info[i].groups),
+					GFP_KERNEL);
+		if (!priv->function_info[i].groups)
+			return -ENOMEM;
+
+		ret = scmi_pinctrl_list_associations(dev, SCMI_FUNCTION, i,
+						     priv->function_info[i].groups,
+						     priv->function_info[i].num_groups);
+		if (ret) {
+			dev_err(dev, "list association %d failed for function: %d\n", i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(pinctrl_scmi) = {
+	.name = "scmi_pinctrl",
+	.id = UCLASS_PINCTRL,
+	.ops = &scmi_pinctrl_ops,
+	.probe = scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct pinctrl_scmi_priv),
+};
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_PINCTRL },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(pinctrl_scmi, match);
+
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 9b36d3ae67bb..c40b448bcba1 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -52,7 +52,7 @@ struct scmi_agent_priv {
 #if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
 	struct udevice *voltagedom_dev;
 #endif
-#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
+#if IS_ENABLED(CONFIG_PINCTRL_SCMI) || IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
 	struct udevice *pinctrl_dev;
 #endif
 #if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_80)
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index a4efadafa73c..3e862adb8035 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1146,4 +1146,360 @@ struct scmi_perf_in {
 struct scmi_perf_out {
 	s32 status;
 };
+
+#define SCMI_PIN_NAME_LEN 16
+
+struct pin_info {
+	char name[SCMI_PIN_NAME_LEN];
+};
+
+struct group_info {
+	char name[SCMI_PIN_NAME_LEN];
+	u16 *pins;
+	u32 num_pins;
+};
+
+struct function_info {
+	char name[SCMI_PIN_NAME_LEN];
+	u16 *groups;
+	u32 num_groups;
+};
+
+/* This is used by both the SCMI pinctrl and gpio drivers */
+struct pinctrl_scmi_priv {
+	int num_pins;
+	struct pin_info *pin_info;
+	int num_groups;
+	struct group_info *group_info;
+	int num_functions;
+	struct function_info *function_info;
+};
+
+/* SCMI Pinctrl selector type */
+enum select_type {
+	SCMI_PIN,
+	SCMI_GROUP,
+	SCMI_FUNCTION,
+};
+
+/**
+ * struct scmi_pinctrl_protocol_attrs_out - Response to SCMI_PROTOCOL_ATTRIBUTES
+ *					command.
+ * @status:	SCMI command status
+ * @attr_low:	Number of pins and groups
+ * @attr_high:	Number of functions
+ */
+struct scmi_pinctrl_protocol_attrs_out {
+	s32 status;
+	u32 attr_low;
+	u32 attr_high;
+};
+
+/**
+ * struct scmi_pinctrl_attrs_in - Parameters for SCMI_PINCTRL_ATTRIBUTES command
+ * @id:			Identifier for pin, group or function
+ * @select_type:	Pin, group or function
+ */
+struct scmi_pinctrl_attrs_in {
+	u32 id;
+	u32 select_type;
+};
+
+/**
+ * struct scmi_pinctrl_attrs_out - Response to SCMI_PINCTRL_ATTRIBUTES command
+ * @status:	SCMI command status
+ * @attr:	GPIO, number of pins or groups
+ * @name:	Name of pin, group or function
+ */
+struct scmi_pinctrl_attrs_out {
+	s32 status;
+	u32 attr;
+	u8 name[SCMI_PIN_NAME_LEN];
+};
+
+/**
+ * struct scmi_pinctrl_list_associations_in - Parameters for
+ *					SCMI_PINCTRL_LIST_ASSOCIATIONS command
+ * @id:			Identifier for group or function
+ * @select_type:	Group or function
+ * @index:		Index within the group or function
+ */
+struct scmi_pinctrl_list_associations_in {
+	u32 id;
+	u32 select_type;
+	u32 index;
+};
+
+/**
+ * struct scmi_pinctrl_list_associations_out - Response to
+ *					SCMI_PINCTRL_LIST_ASSOCIATIONS command
+ * @status:	SCMI command status
+ * @flags:	Number of items returned and number still remaining
+ * @array:	List of groups or pins
+ */
+struct scmi_pinctrl_list_associations_out {
+	s32 status;
+	u32 flags;
+	u16 array[];
+};
+
+/**
+ * struct scmi_pinctrl_settings_get_in - Parameters for
+ *					SCMI_PINCTRL_SETTINGS_GET command
+ * @id:		Identifier for pin or group
+ * @attr:	Config flag: one setting, function or all settings
+ *		Selector: Pin or Group
+ *		Skip: Number of config types to skip
+ *		Config type: Type of config to read
+ */
+struct scmi_pinctrl_settings_get_in {
+	u32 id;
+	u32 attr;
+};
+
+#define SCMI_PINCTRL_CONFIG_SETTINGS_ALL -2u
+#define SCMI_PINCTRL_FUNCTION_NONE 0xFFFFFFFF
+
+/**
+ * struct scmi_pinctrl_settings_get_out - Response to SCMI_PINCTRL_SETTINGS_GET
+ *					command
+ * @status:		SCMI command status
+ * @function_selected:	The function enabled by the pin or group
+ * @num_configs:	The number of settings returned and number still remaining
+ * @configs:		The list of config data
+ */
+struct scmi_pinctrl_settings_get_out {
+	s32 status;
+	u32 function_selected;
+	u32 num_configs;
+	u32 configs[];
+};
+
+/**
+ * struct scmi_pinctrl_settings_configure_in - Parameters for
+ *					SCMI_PINCTRL_SETTINGS_CONFIGURE command
+ * @id:			Identifier for pin or group
+ * @function_id:	The function to enable for this pin or group (optional)
+ * @attr:		Function id: Set the function or not
+ *			Number of configs to set
+ *			Selector: pin or group
+ * @configs:		List of config type value pairs
+ */
+struct scmi_pinctrl_settings_configure_in {
+	u32 id;
+	u32 function_id;
+	u32 attr;
+	u32 configs[];
+};
+
+/**
+ * struct scmi_pinctrl_settings_configure_out - Response to
+ *					SCMI_PINCTRL_SETTINGS_CONFIGURE command
+ * @status:	SCMI command status
+ */
+struct scmi_pinctrl_settings_configure_out {
+	s32 status;
+};
+
+/**
+ * struct scmi_pinctrl_request_in - Parameters for SCMI_PINCTRL_REQUEST command
+ * @id:		Identifier for pin or group
+ * @flags:	Pin, group or function
+ */
+struct scmi_pinctrl_request_in {
+	u32 id;
+	u32 flags;
+};
+
+/**
+ * struct scmi_pinctrl_request_out - Response to SCMI_PINCTRL_REQUEST command
+ * @status:	SCMI command status
+ */
+struct scmi_pinctrl_request_out {
+	s32 status;
+};
+
+/**
+ * struct scmi_pinctrl_release_in - Parameters for SCMI_PINCTRL_RELEASE command
+ * @id:		Identifier for pin or group
+ * @flags:	Pin, group or function
+ */
+struct scmi_pinctrl_release_in {
+	u32 id;
+	u32 flags;
+};
+
+/**
+ * struct scmi_pinctrl_release_out - Response to SCMI_PINCTRL_RELEASE command
+ * @status:	SCMI command status
+ */
+struct scmi_pinctrl_release_out {
+	s32 status;
+};
+
+/* SCMI Pinctrl Config Types */
+enum scmi_config_type {
+	SCMI_PIN_DEFUALT = 0,
+	SCMI_PIN_BIAS_BUS_HOLD = 1,
+	SCMI_PIN_BIAS_DISABLE = 2,
+	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 3,
+	SCMI_PIN_BIAS_PULL_UP = 4,
+	SCMI_PIN_BIAS_PULL_DEFAULT = 5,
+	SCMI_PIN_BIAS_PULL_DOWN = 6,
+	SCMI_PIN_DRIVE_OPEN_DRAIN = 7,
+	SCMI_PIN_DRIVE_OPEN_SOURCE = 8,
+	SCMI_PIN_DRIVE_PUSH_PULL = 9,
+	SCMI_PIN_DRIVE_STRENGTH = 10,
+	SCMI_PIN_INPUT_DEBOUNCE = 11,
+	SCMI_PIN_INPUT_MODE = 12,
+	SCMI_PIN_PULL_MODE = 13,
+	SCMI_PIN_INPUT_VALUE = 14,
+	SCMI_PIN_INPUT_SCHMITT = 15,
+	SCMI_PIN_LOW_POWER_MODE = 16,
+	SCMI_PIN_OUTPUT_MODE = 17,
+	SCMI_PIN_OUTPUT_VALUE = 18,
+	SCMI_PIN_POWER_SOURCE = 19,
+	SCMI_PIN_SLEW_RATE = 20,
+};
+
+/**
+ * scmi_pinctrl_protocol_attrs - get pinctrl information
+ * @dev: SCMI protocol device
+ * @num_pins: Number of pins
+ * @num_groups: Number of groups
+ * @num_functions: Number of functions
+ *
+ * Obtain the number of pins, groups and functions.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_protocol_attrs(struct udevice *dev, int *num_pins,
+				int *num_groups, int *num_functions);
+
+/**
+ * scmi_pinctrl_attrs - get information for a specific pin, group or function
+ * @dev: SCMI protocol device
+ * @select_type: pin, group or function
+ * @selector: id of pin, group or function
+ * @gpio: set to true if the pin or group supports gpio
+ * @count: number of groups in function or pins in group
+ * @name: name of pin, group or function
+ *
+ * Obtain information about a specific pin, group or function.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_attrs(struct udevice *dev, enum select_type select_type,
+		       unsigned int selector, bool *gpio, unsigned int *count,
+		       char *name);
+
+/**
+ * scmi_pinctrl_request - claim a pin or group
+ * @dev: SCMI protocol device
+ * @select_type: pin or group
+ * @selector: id of pin or group
+ *
+ * Claim ownership of a pin or group.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_request(struct udevice *dev, enum select_type select_type,
+			 unsigned int selector);
+/**
+ * scmi_pinctrl_release - release a claimed pin or group
+ * @dev: SCMI protocol device
+ * @select_type: pin or group
+ * @selector: id of pin or group
+ *
+ * Release a pin or group that you previously claimed.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_release(struct udevice *dev, enum select_type select_type,
+			 unsigned int selector);
+
+/**
+ * scmi_pinctrl_list_associations - get list of pins in group or groups in function
+ * @dev: SCMI protocol device
+ * @select_type: group or function
+ * @selector: id of group or function
+ * @output: list of groups in function or pins in group
+ * @num_out: How many groups are in the function or pins in the group
+ *
+ * Obtain the list of groups or pins in the function or group respectively.
+ * We know how many items will be in the list from calling scmi_pinctrl_attrs().
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_list_associations(struct udevice *dev,
+				   enum select_type select_type,
+				   unsigned int selector,
+				   unsigned short *output,
+				   unsigned short num_out);
+
+/**
+ * scmi_pinctrl_settings_get_one - get a configuration setting
+ * @dev: SCMI protocol device
+ * @select_type: pin or group
+ * @selector: id of pin or group
+ * @config_type: Which configuration type to read
+ * @value: returned configuration value
+ *
+ * This reads a single config setting.  Most importantly the
+ * SCMI_PIN_INPUT_VALUE setting is used to read from a pin.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_settings_get_one(struct udevice *dev, enum select_type select_type,
+				  unsigned int selector,
+				  u32 config_type, u32 *value);
+
+/**
+ * scmi_pinctrl_settings_configure - set multiple configuration settings
+ * @dev: SCMI protocol device
+ * @select_type: pin or group
+ * @selector: id of pin or group
+ * @num_configs: number of settings to set
+ * @configs: Config type and value pairs
+ *
+ * Configure multiple settings at once to reduce overhead.  The
+ * SCMI_PIN_OUTPUT_VALUE setting is used to write to a pin.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_settings_configure(struct udevice *dev, enum select_type select_type,
+				    unsigned int selector, u16 num_configs,
+				    u32 *configs);
+
+/**
+ * scmi_pinctrl_settings_configure_one - set a configuration setting
+ * @dev: SCMI protocol device
+ * @select_type: pin or group
+ * @selector: id of pin or group
+ * @param: The setting type to configure
+ * @argument: The value of the configuration
+ *
+ * Configure a single setting.  The SCMI_PIN_OUTPUT_VALUE setting is used to
+ * write to a pin.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_settings_configure_one(struct udevice *dev, enum select_type select_type,
+					unsigned int selector,
+					u32 param, u32 argument);
+
+/**
+ * scmi_pinctrl_set_function - set the function for a group or pin
+ * @dev: SCMI protocol device
+ * @select_type: pin or group
+ * @selector: id of pin or group
+ * @function_id: id of the function
+ *
+ * Set the function for a group or pin.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pinctrl_set_function(struct udevice *dev, enum select_type select_type,
+			      unsigned int selector, u32 function_id);
+
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.51.0

