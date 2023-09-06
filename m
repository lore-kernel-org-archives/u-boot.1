Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC92EB8FAE
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B9B8664A;
	Wed,  6 Sep 2023 04:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KCySzshv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C10086590; Wed,  6 Sep 2023 04:41:07 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47830865B0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 04:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a32506e90so700508b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693968061; x=1694572861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZwraZo0t3tnCWHq4TbRwxe/8ErYV/OER8HmEq9/qS4=;
 b=KCySzshv02S0Nodf4/vQVUxg5s/8euPmHdbNcvdYLPF+Jbh2rpTCd7OYShtBCZAoUl
 tofjUoMd3dNjpdZYsdhOJ6oNugBS2EfAsSu+3/IqBMNL22wzemQtBFv5076Clx6NkhMA
 Oo6mUirrJQrZfmXh8f4AXc5dgOPDwrZw5ytTlN/TAtqqWkqF9Bhknyvi/lIXC7VgjjAj
 o0ibJeSihHnxYj9l2v5VYYhUPkcbH9m5eiqoxA1edIe1Z3tbSXR2UmV1rbXCRlZ2T1fv
 FRVP7IiGkxJWEZFXtR1JtZO+tda8I9VfVJk5+AivQmqg4zXQQzWbYsOUvYxf4gMH6FbY
 PhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693968061; x=1694572861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZwraZo0t3tnCWHq4TbRwxe/8ErYV/OER8HmEq9/qS4=;
 b=Fi7QY7TF8s6FfDY7kHK6s2Z+UtV14JTGdhy1xrCOEfy5AEbkJaXG9ZpZs8A6PIsO3m
 6i55XpGSjvs6BAOwxApNuC+ah3iwPuub4vxuwHwbWrNrXaJLvwwzz/r0eDCuO0tuXrGV
 WgWmpXKpJ+x9k5lhZz0a3v+LjgX1hrkSNA0ol1wTOjbjMDCihQ8bGWfqPGMvectitrob
 b1SFcig+QzxckoWqgqzv8u/2WTZ5KcwPyzZc4r1u15YW7weLoiRZ+282rccyxWkh2qu2
 /fhije6aub6ryN8UTeRL5qg9xACfUW07FL96PYeRBJBnCAnSdAXMuYKaGVZbYL0wYdoQ
 O4/A==
X-Gm-Message-State: AOJu0YyvdcrZl9jhPlJwv8XosCUnwZn5Sc/ylAs3b9O9UWrRUw9apOeF
 /ZEONCnwJJexSrxOQsW//IT/KRKr/EC7lzwuVT8WHA==
X-Google-Smtp-Source: AGHT+IGOpa+pOsBfQTVCmOyxlty+CSNHSdKTc9qL1Gnql3UD4D5esNe3Mrx4URS+ZVrSS4hQc1/JDg==
X-Received: by 2002:a05:6a00:f0e:b0:68b:c562:da46 with SMTP id
 cr14-20020a056a000f0e00b0068bc562da46mr16015314pfb.1.1693968061405; 
 Tue, 05 Sep 2023 19:41:01 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a6566c5000000b0056428865aadsm9145378pgw.82.2023.09.05.19.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 19:41:01 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 2/6] firmware: scmi: add pinctrl protocol support
Date: Wed,  6 Sep 2023 11:40:07 +0900
Message-Id: <20230906024011.17488-3-takahiro.akashi@linaro.org>
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

With this patch, transport-level utility functions for SCMI pinctrl
protocol are added. DM-compliant device drivers, pinctrl and gpio, are
added in the following patches.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/scmi.c                                |   1 +
 drivers/firmware/scmi/Kconfig             |   3 +
 drivers/firmware/scmi/Makefile            |   1 +
 drivers/firmware/scmi/pinctrl.c           | 412 ++++++++++++++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c |  11 +
 include/scmi_agent-uclass.h               |   2 +
 include/scmi_protocols.h                  | 435 ++++++++++++++++++++++
 7 files changed, 865 insertions(+)
 create mode 100644 drivers/firmware/scmi/pinctrl.c

diff --git a/cmd/scmi.c b/cmd/scmi.c
index 5efec8ad87fd..ae7892381e0a 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -33,6 +33,7 @@ struct {
 	{SCMI_PROTOCOL_ID_SENSOR, "Sensor management"},
 	{SCMI_PROTOCOL_ID_RESET_DOMAIN, "Reset domain management"},
 	{SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN, "Voltage domain management"},
+	{SCMI_PROTOCOL_ID_PIN_CONTROL, "Pin control"},
 };
 
 /**
diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 8cf85f0d7a12..e0cb7b70dede 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -41,3 +41,6 @@ config SCMI_AGENT_OPTEE
 	help
 	  Enable the SCMI communication channel based on OP-TEE transport
 	  for compatible "linaro,scmi-optee".
+
+config SCMI_PINCTRL
+	bool
diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makefile
index 1a23d4981709..bf6381332e9e 100644
--- a/drivers/firmware/scmi/Makefile
+++ b/drivers/firmware/scmi/Makefile
@@ -4,4 +4,5 @@ obj-y	+= smt.o
 obj-$(CONFIG_SCMI_AGENT_SMCCC)		+= smccc_agent.o
 obj-$(CONFIG_SCMI_AGENT_MAILBOX)	+= mailbox_agent.o
 obj-$(CONFIG_SCMI_AGENT_OPTEE)	+= optee_agent.o
+obj-$(CONFIG_SCMI_PINCTRL)	+= pinctrl.o
 obj-$(CONFIG_SANDBOX)		+= sandbox-scmi_agent.o sandbox-scmi_devices.o
diff --git a/drivers/firmware/scmi/pinctrl.c b/drivers/firmware/scmi/pinctrl.c
new file mode 100644
index 000000000000..88ec57dc3d53
--- /dev/null
+++ b/drivers/firmware/scmi/pinctrl.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SCMI Pin control protocol as U-Boot device
+ *
+ * Copyright (C) 2023 Linaro Limited
+ *		author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <malloc.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <string.h>
+#include <asm/types.h>
+#include <dm/device_compat.h>
+#include <linux/kernel.h>
+
+/**
+ * struct scmi_pinctrl_priv - Private data for SCMI Pin control protocol
+ * @channel: Reference to the SCMI channel to use
+ */
+struct scmi_pinctrl_priv {
+	struct scmi_channel *channel;
+};
+
+int scmi_pinctrl_protocol_attrs(struct udevice *dev, u32 *num_pins,
+				u32 *num_groups, u32 *num_functions)
+{
+	struct scmi_pinctrl_protocol_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PROTOCOL_ATTRIBUTES,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !num_pins || !num_groups || !num_functions)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*num_groups = SCMI_PINCTRL_ATTRS_NUM_GROUPS(out.attributes_low);
+	*num_pins = SCMI_PINCTRL_ATTRS_NUM_PINS(out.attributes_low);
+	*num_functions = SCMI_PINCTRL_ATTRS_NUM_FUNCTIONS(out.attributes_high);
+
+	return 0;
+}
+
+int scmi_pinctrl_attrs(struct udevice *dev, u32 id, u32 flags,
+		       bool *extended_name, u8 **name)
+{
+	struct scmi_pinctrl_attrs_in in;
+	struct scmi_pinctrl_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_ATTRIBUTES,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !extended_name || !name)
+		return -EINVAL;
+
+	in.id = id;
+	in.flags = flags;
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*extended_name = SCMI_PINCTRL_ATTRS_EXTENDED_NAME(out.attributes);
+	*name = strdup(out.name);
+	if (!*name)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int scmi_pinctrl_list_assocs(struct udevice *dev, u32 id, u32 flags,
+			     u16 **array)
+{
+	struct scmi_pinctrl_list_assocs_in in;
+	struct scmi_pinctrl_list_assocs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_LIST_ASSOCIATIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	u32 index;
+	u16 *buf;
+	int i, ret;
+
+	if (!dev || !array)
+		return -EINVAL;
+
+	in.id = id;
+	in.flags = flags;
+
+	buf = calloc(sizeof(u16), SCMI_PINCTRL_ARRAY_SIZE);
+	if (!buf)
+		return -ENOMEM;
+
+	index = 0;
+	while (1) {
+		in.index = index;
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			goto err;
+		if (out.status) {
+			ret = scmi_to_linux_errno(out.status);
+			goto err;
+		}
+
+		for (i = 0; i < SCMI_PINCTRL_LIST_NUM_PINGROUP(out.flags);
+		     i++, index++)
+			buf[index] = out.array[i];
+
+		/* realloc should happen only once */
+		if (SCMI_PINCTRL_LIST_NUM_REMAINING(out.flags)) {
+			buf = realloc(buf, sizeof(u16) *
+				      (SCMI_PINCTRL_ARRAY_SIZE
+				       + SCMI_PINCTRL_LIST_NUM_REMAINING(out.flags)));
+			if (!buf)
+				return -ENOMEM;
+		} else {
+			break;
+		}
+	}
+
+	*array = buf;
+
+	return index;
+err:
+	free(buf);
+
+	return ret;
+}
+
+int scmi_pinctrl_config_get(struct udevice *dev, u32 id, bool all_configs,
+			    int selector, unsigned int config_type,
+			    struct scmi_pin_entry **configs)
+
+{
+	struct scmi_pinctrl_config_get_in in;
+	struct scmi_pinctrl_config_get_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_CONFIG_GET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	struct scmi_pin_entry *entry;
+	int cur, num, remaining, ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	if (!all_configs) {
+		in.id = id;
+		in.attributes = SCMI_PINCTRL_CONFIG_GET_ATTRS(0, selector, 0,
+							      config_type);
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			return ret;
+		if (out.status)
+			return scmi_to_linux_errno(out.status);
+
+		entry = malloc(sizeof(*entry));
+		if (!entry)
+			return -ENOMEM;
+
+		*entry = out.configs[0];
+		*configs = entry;
+
+		return 0;
+	}
+
+	entry = NULL;
+	cur = 0;
+	while (1) {
+		in.id = id;
+		in.attributes = SCMI_PINCTRL_CONFIG_GET_ATTRS(1, selector, cur,
+							      0);
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			return ret;
+		if (out.status)
+			return scmi_to_linux_errno(out.status);
+
+		num = SCMI_PINCTRL_CONFIG_GET_NUM_RET(out.num_configs);
+		remaining = SCMI_PINCTRL_CONFIG_GET_REMAINING(out.num_configs);
+
+		if (!entry)
+			entry = malloc(sizeof(*entry) * (num + remaining));
+		if (!entry)
+			return -ENOMEM;
+
+		memcpy(entry + cur, &out.configs, sizeof(*entry) * num);
+
+		if (!remaining)
+			break;
+
+		cur += num;
+	}
+
+	return 0;
+}
+
+int scmi_pinctrl_config_set(struct udevice *dev, u32 id, int selector,
+			    int num_configs, struct scmi_pin_entry *configs)
+{
+	s32 status;
+	struct scmi_pinctrl_config_set_in in;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_CONFIG_SET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int cur, num, ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	cur = 0;
+	while (num_configs) {
+		if (num_configs < SCMI_PINCTRL_CONFIG_ENTRY_MAX)
+			num =  num_configs;
+		else
+			num =  SCMI_PINCTRL_CONFIG_ENTRY_MAX;
+
+		in.id = id;
+		in.attributes = SCMI_PINCTRL_CONFIG_SET_ATTRS(num, selector);
+		memcpy(&in.configs[cur], configs,
+		       sizeof(struct scmi_pin_entry) * num);
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			return ret;
+		if (status)
+			return scmi_to_linux_errno(status);
+
+		num_configs -= num;
+		cur += num;
+	}
+
+	return 0;
+}
+
+int scmi_pinctrl_function_select(struct udevice *dev, u32 id, u32 function_id,
+				 u32 flags)
+{
+	s32 status;
+	struct scmi_pinctrl_function_select_in in;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_FUNCTION_SELECT,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	in.id = id;
+	in.function_id = function_id;
+	in.flags = flags;
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+int scmi_pinctrl_request(struct udevice *dev, u32 id, u32 flags)
+{
+	s32 status;
+	struct scmi_pinctrl_request_in in;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_REQUEST,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	in.id = id;
+	in.flags = flags;
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+int scmi_pinctrl_release(struct udevice *dev, u32 id, u32 flags)
+{
+	s32 status;
+	struct scmi_pinctrl_release_in in;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_RELEASE,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	in.id = id;
+	in.flags = flags;
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+int scmi_pinctrl_name_get(struct udevice *dev, u32 id, u32 flags, u8 **name)
+{
+	struct scmi_pinctrl_name_get_in in;
+	struct scmi_pinctrl_name_get_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_NAME_GET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !name)
+		return -EINVAL;
+
+	in.id = id;
+	in.flags = flags;
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*name = strdup(out.name);
+	if (!*name)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int scmi_pinctrl_set_permissions(struct udevice *dev, u32 agent_id, u32 id,
+				 u32 flags)
+{
+	s32 status;
+	struct scmi_pinctrl_set_permissions_in in;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_PIN_CONTROL,
+		.message_id = SCMI_PINCTRL_SET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	in.agent_id = agent_id;
+	in.id = id;
+	in.flags = flags;
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 79584c00a066..a5953cabbcee 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -95,6 +95,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_CLOCK:
 		proto = priv->clock_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PIN_CONTROL:
+		proto = priv->pinctrl_dev;
+		break;
 	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
 		proto = priv->resetdom_dev;
 		break;
@@ -142,6 +145,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_CLOCK:
 		priv->clock_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PIN_CONTROL:
+		priv->pinctrl_dev = proto;
+		break;
 	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
 		priv->resetdom_dev = proto;
 		break;
@@ -414,6 +420,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 			    scmi_protocol_is_supported(dev, protocol_id))
 				drv = DM_DRIVER_GET(scmi_clock);
 			break;
+		case SCMI_PROTOCOL_ID_PIN_CONTROL:
+			if (IS_ENABLED(CONFIG_PINCTRL_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl);
+			break;
 		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
 			if (IS_ENABLED(CONFIG_RESET_SCMI) &&
 			    scmi_protocol_is_supported(dev, protocol_id))
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 6fd6d54d6a5a..993ea81e09c8 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -25,6 +25,7 @@ struct scmi_channel;
  * @base_dev:		SCMI base protocol device
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
  */
 struct scmi_agent_priv {
@@ -40,6 +41,7 @@ struct scmi_agent_priv {
 	struct udevice *base_dev;
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
+	struct udevice *pinctrl_dev;
 	struct udevice *voltagedom_dev;
 };
 
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index f41d3f317ce2..699e27e0a84f 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PIN_CONTROL = 0x19,
 };
 
 enum scmi_status_code {
@@ -683,4 +684,438 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/*
+ * SCMI Pin Control Protocol
+ */
+#define SCMI_PIN_CONTROL_PROTOCOL_VERSION 0x10000
+
+enum scmi_pin_control_id {
+	SCMI_PINCTRL_ATTRIBUTES = 0x3,
+	SCMI_PINCTRL_LIST_ASSOCIATIONS = 0x4,
+	SCMI_PINCTRL_CONFIG_GET = 0x5,
+	SCMI_PINCTRL_CONFIG_SET = 0x6,
+	SCMI_PINCTRL_FUNCTION_SELECT = 0x7,
+	SCMI_PINCTRL_REQUEST = 0x8,
+	SCMI_PINCTRL_RELEASE = 0x9,
+	SCMI_PINCTRL_NAME_GET = 0xa,
+	SCMI_PINCTRL_SET_PERMISSIONS = 0xb,
+};
+
+#define SCMI_PINCTRL_NAME_LENGTH_MAX 16
+
+/**
+ * struct scmi_pinctrl_protocol_attrs_out - Response for PINCTRL's
+ *					    PROTOCOL_ATTRIBUTES command
+ * @status:		SCMI command status
+ * @attributes_low:	Protocol attributes (lower bytes)
+ * @attributes_high:	Protocol attributes (higher bytes)
+ */
+struct scmi_pinctrl_protocol_attrs_out {
+	s32 status;
+	u32 attributes_low;
+	u32 attributes_high;
+};
+
+#define SCMI_PINCTRL_ATTRS_NUM_GROUPS(attributes_low) \
+				(((attributes_low) & GENMASK(31, 16)) >> 16)
+#define SCMI_PINCTRL_ATTRS_NUM_PINS(attributes_low) \
+				((attributes_low) & GENMASK(15, 0))
+#define SCMI_PINCTRL_ATTRS_NUM_FUNCTIONS(attributes_high) \
+				((attributes_high) & GENMASK(15, 0))
+
+/**
+ * struct scmi_pinctrl_attrs_in - Message payload for
+ *				SCMI_PINCTRL_ATTRIBUTES command
+ * @id:		Identifier of pin, group or function
+ * @flags:	A set of flags
+ */
+struct scmi_pinctrl_attrs_in {
+	u32 id;
+	u32 flags;
+};
+
+/**
+ * struct scmi_pinctrl_attrs_out - Response payload for
+ *				SCMI_PINCTRL_ATTRIBUTES command
+ * @status:	SCMI command status
+ * @attributes:	Attributes of pin, group for function
+ * @name:	Name of pin, group or function
+ */
+struct scmi_pinctrl_attrs_out {
+	u32 status;
+	u32 attributes;
+	u8 name[SCMI_PINCTRL_NAME_LENGTH_MAX];
+};
+
+#define SCMI_PINCTRL_TYPE(flags)	((flags) & GENMASK(1, 0))
+#define SCMI_PINCTRL_TYPE_PIN		0x0
+#define SCMI_PINCTRL_TYPE_GROUP		0x1
+#define SCMI_PINCTRL_TYPE_FUNCTION	0x2
+
+#define SCMI_PINCTRL_ATTRS_EXTENDED_NAME(attributes) \
+				((attributes) & BIT(31))
+#define SCMI_PINCTRL_ATTRS_NUM_PINGROUP(attributes) \
+				((attributes) & GENMASK(15, 0))
+
+/**
+ * struct scmi_pinctrl_list_assocs_in - Message payload for
+ *				SCMI_PINCTRL_LIST_ASSOCIATIONS command
+ * @id:		Identifier of group or function
+ * @flags:	A set of flags
+ * @index:	Index of first group to be described
+ */
+struct scmi_pinctrl_list_assocs_in {
+	u32 id;
+	u32 flags;
+	u32 index;
+};
+
+#define SCMI_PINCTRL_ARRAY_SIZE	8
+
+/**
+ * struct scmi_pinctrl_list_assocs_out - Response payload for
+ *				SCMI_PINCTRL_LIST_ASSOCIATIONS command
+ * @status:	SCMI command status
+ * @attributes:	A set of flags
+ * @array:	Array of pin or group identifiers
+ */
+struct scmi_pinctrl_list_assocs_out {
+	u32 status;
+	u32 flags;
+	u16 array[SCMI_PINCTRL_ARRAY_SIZE];
+};
+
+#define SCMI_PINCTRL_LIST_NUM_REMAINING(flags) \
+				(((flags) & GENMASK(31, 16)) >> 16)
+#define SCMI_PINCTRL_LIST_NUM_PINGROUP(flags) \
+				((flags) & GENMASK(11, 0))
+
+/* FIXME: depends on transport */
+#define SCMI_PINCTRL_CONFIG_ENTRY_MAX 8
+
+struct scmi_pin_entry {
+	u32 type;
+	u32 value;
+};
+
+/**
+ * struct scmi_pinctrl_config_get_in - Message payload for
+ *				SCMI_PINCTRL_CONFIG_GET command
+ * @id:		Identifier of pin or group
+ * @attributes:	Configuration attributes
+ */
+struct scmi_pinctrl_config_get_in {
+	u32 id;
+	u32 attributes;
+};
+
+#define SCMI_PINCTRL_CONFIG_GET_ATTRS(all, selector, skip, type) \
+				(((all) << 18) | ((selector) << 16) | \
+				 (((skip) << 8) | (type)))
+
+#define SCMI_PINCTRL_CONFIG_GET_ALL BIT(18)
+#define SCMI_PINCTRL_CONFIG_GET_PINCTRL_TYPE(attributes) \
+				(((attributes) & GENMASK(17, 16)) >> 16)
+#define SCMI_PINCTRL_CONFIG_GET_SKIP(attributes) \
+				(((attributes) & GENMASK(15, 8)) >> 8)
+#define SCMI_PINCTRL_CONFIG_GET_TYPE(attributes) \
+				((attributes) & GENMASK(7, 0))
+
+/**
+ * struct scmi_pinctrl_confige_get_out - Response payload for
+ *				SCMI_PINCTRL_CONFIG_GET command
+ * @status:		SCMI command status
+ * @num_configs:	Number of configuration types
+ * @configs:		Values of configuration types
+ */
+struct scmi_pinctrl_config_get_out {
+	u32 status;
+	u32 num_configs;
+	struct scmi_pin_entry configs[SCMI_PINCTRL_CONFIG_ENTRY_MAX];
+};
+
+#define SCMI_PINCTRL_CONFIG_GET_REMAINING(attributes) \
+				(((attributes) & GENMASK(31, 24)) >> 24)
+#define SCMI_PINCTRL_CONFIG_GET_NUM_RET(attributes) \
+				((attributes) & GENMASK(7, 0))
+#define SCMI_PINCTRL_CONFIG_GET_NUM_CONFIGS(remaining, num) \
+				(((remaining) << 24) | (num))
+
+#define SCMI_PINCTRL_CONFIG_ID_SHIFT		8
+
+#define SCMI_PINCTRL_CONFIG_DEFAULT			0
+#define SCMI_PINCTRL_CONFIG_BIAS_BUS_HOLD		1
+#define SCMI_PINCTRL_CONFIG_BIAS_DISABLE		2
+#define SCMI_PINCTRL_CONFIG_BIAS_HI_IMPEDANCE		3
+#define SCMI_PINCTRL_CONFIG_BIAS_PULL_UP		4
+#define SCMI_PINCTRL_CONFIG_BIAS_PULL_DEF		5
+#define SCMI_PINCTRL_CONFIG_BIAS_PULL_DOWN		6
+#define SCMI_PINCTRL_CONFIG_DRIVE_OPEN_DRAIN		7
+#define SCMI_PINCTRL_CONFIG_DRIVE_OPEN_SOURCE		8
+#define SCMI_PINCTRL_CONFIG_DRIVE_PUSH_PULL		9
+#define SCMI_PINCTRL_CONFIG_DRIVE_STRENGTH		10
+#define SCMI_PINCTRL_CONFIG_INPUT_DEBOUNCE		11
+#define SCMI_PINCTRL_CONFIG_INPUT_MODE			12
+#define SCMI_PINCTRL_CONFIG_PULL_MODE			13
+#define SCMI_PINCTRL_CONFIG_INPUT_VALUE			14
+#define SCMI_PINCTRL_CONFIG_INPUT_SCHMITT		15
+#define SCMI_PINCTRL_CONFIG_LOW_POWER_MODE		16
+#define SCMI_PINCTRL_CONFIG_OUTPUT_MODE			17
+#define SCMI_PINCTRL_CONFIG_OUTPUT_VALUE		18
+#define SCMI_PINCTRL_CONFIG_POWER_SOURCE		19
+#define SCMI_PINCTRL_CONFIG_SLEW_RATE			20
+#define SCMI_PINCTRL_CONFIG_RESERVED			21
+#define SCMI_PINCTRL_CONFIG_OEM				192
+
+/**
+ * struct scmi_pinctrl_config_set_in - Message payload for
+ *				SCMI_PINCTRL_CONFIG_GET command
+ * @id:		Identifier of pin or group
+ * @attributes:	Configuration attributes
+ * @configs:	Values of configuration types
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 id;
+	u32 attributes;
+	struct scmi_pin_entry configs[SCMI_PINCTRL_CONFIG_ENTRY_MAX];
+};
+
+#define SCMI_PINCTRL_CONFIG_SET_ATTRS(num, type) \
+				(((num) << 2) | (type))
+#define SCMI_PINCTRL_CONFIG_SET_NUM_CONFIGS(attributes) \
+				(((attributes) & GENMASK(9, 2)) >> 2)
+#define SCMI_PINCTRL_CONFIG_SET_PINCTRL_TYPE(attributes) \
+				((attributes) & GENMASK(1, 0))
+
+/**
+ * struct scmi_pinctrl_function_select_in - Message payload for
+ *				SCMI_PINCTRL_FUNCTION_SELECT command
+ * @id:			Identifier of pin or group
+ * @function_id:	Identifier of function
+ * @flags:		A set of flags
+ */
+struct scmi_pinctrl_function_select_in {
+	u32 id;
+	u32 function_id;
+	u32 flags;
+};
+
+/**
+ * struct scmi_pinctrl_request_in - Message payload for
+ *				SCMI_PINCTRL_REQUEST command
+ * @id:			Identifier of pin or group
+ * @flags:		A set of flags
+ */
+struct scmi_pinctrl_request_in {
+	u32 id;
+	u32 flags;
+};
+
+/**
+ * struct scmi_pinctrl_release_in - Message payload for
+ *				SCMI_PINCTRL_RELEASE command
+ * @id:			Identifier of pin or group
+ * @flags:		A set of flags
+ */
+struct scmi_pinctrl_release_in {
+	u32 id;
+	u32 flags;
+};
+
+/**
+ * struct scmi_pinctrl_name_get_in - Message payload for
+ *				SCMI_PINCTRL_NAME_GET command
+ * @id:			Identifier of pin, group or function
+ * @flags:		A set of flags
+ */
+struct scmi_pinctrl_name_get_in {
+	u32 id;
+	u32 flags;
+};
+
+/**
+ * struct scmi_pinctrl_name_get_out - Response payload for
+ *				SCMI_PINCTRL_NAME_GET command
+ * @status:	SCMI command status
+ * @flags:	A set of flags (reserved)
+ * @name:	Name in string
+ */
+struct scmi_pinctrl_name_get_out {
+	u32 status;
+	u32 flags;
+	u8 name[64];
+};
+
+/**
+ * struct scmi_pinctrl_set_permissions_in - Message payload for
+ *				SCMI_PINCTRL_SET_PERMISSIONS command
+ * @agent_id:	Identifier of the agent
+ * @id:		Identifier of pin or group
+ * @flags:	A set of flags
+ */
+struct scmi_pinctrl_set_permissions_in {
+	u32 agent_id;
+	u32 id;
+	u32 flags;
+};
+
+#define SCMI_PINCTRL_PERMISSION BIT(2)
+
+/**
+ * scmi_pinctrl_protocol_attrs - get attributes of pinctrl protocol
+ * @dev:		SCMI pinctrl device
+ * @num_pins:		A number of pins
+ * @num_groups:		A number of groups
+ * @num_functions:	A number of functions
+ *
+ * Get a number of available pins, groups and functions, respectively,
+ * in @num_pins, @num_groups, @num_functions.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_protocol_attrs(struct udevice *dev, u32 *num_pins,
+				u32 *num_groups, u32 *num_functions);
+
+/**
+ * scmi_pinctrl_attrs - get attributes of pin, group or function
+ * @dev:		SCMI pinctrl device
+ * @id:			Identifier of pin, group or function
+ * @flags:		A set of flags
+ * @extended_name:	Bit flag for extended name
+ * @name:		Name of pin, group or function
+ *
+ * Get the name of @id in @name.
+ * @flags can be SCMI_PINCTRL_TYPE_PIN, GROUP or FUNCTION.
+ * If @id has an extended name, @extended_name is set to true.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_attrs(struct udevice *dev, u32 id, u32 flags,
+		       bool *extended_name, u8 **name);
+
+/**
+ * scmi_pinctrl_list_assocs - Get a list of pins or groups
+ * @dev:		SCMI pinctrl device
+ * @id:			Identifier of group or function
+ * @flags:		A set of flags
+ * @array:		A pointer to a list of pins, groups or functions
+ *
+ * Get a list of pins or groups associated with @id in @array.
+ * @flags can be SCMI_PINCTRL_TYPE_GROUP or FUNCTION.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_list_assocs(struct udevice *dev, u32 id, u32 flags,
+			     u16 **array);
+
+/**
+ * scmi_pinctrl_config_get - Get configuration
+ * @dev:		SCMI pinctrl device
+ * @id:			Identifier of pin or group
+ * @all_configs:	Identifier of pin or group
+ * @selector:		Type of id
+ * @config_type:	Type of configuration
+ * @configs:		A pointer to an array of configuration data
+ *
+ * If @all_configs is set, get a list of values of all configuration types
+ * associated with @id in @configs, otherwise get the configuration for
+ * a specific @config_type. Each configuration data is presented in a form
+ * of struct scmi_pin_entry.
+ * @selector can be SCMI_PINCTRL_TYPE_PIN or GROUP.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_config_get(struct udevice *dev, u32 id, bool all_configs,
+			    int selector, unsigned int config_type,
+			    struct scmi_pin_entry **configs);
+
+/**
+ * scmi_pinctrl_config_set - Set configuration
+ * @dev:		SCMI pinctrl device
+ * @id:			Identifier of pin or group
+ * @selector:		Type of id
+ * @num_configs:	A number of configuration data
+ * @configs:		A pointer to an array of configuration data
+ *
+ * Configure a pin or group associated with @id using @configs.
+ * Each configuration data is presented in a form of struct scmi_pin_entry.
+ * @selector can be SCMI_PINCTRL_TYPE_PIN or GROUP.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_config_set(struct udevice *dev, u32 id, int selector,
+			    int num_configs, struct scmi_pin_entry *configs);
+
+/**
+ * scmi_pinctrl_function_select - Select a function
+ * @dev:		SCMI pinctrl device
+ * @id:			Identifier of pin or group
+ * @function_id:	Identifier of function
+ * @flags:		A set of flags
+ *
+ * Select a function, @function_id, for a pin or group with @id.
+ * @flags can be SCMI_PINCTRL_TYPE_PIN or GROUP.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_function_select(struct udevice *dev, u32 id, u32 function_id,
+				 u32 flags);
+
+/**
+ * scmi_pinctrl_request - Request exclusive control
+ * @dev:	SCMI pinctrl device
+ * @id:		Identifier of pin or group
+ * @flags:	A set of flags
+ *
+ * Make a request for exclusive control of pin or group with @id by this agent.
+ * Once granted, no other agent can access @id until released.
+ * @flags can be SCMI_PINCTRL_TYPE_PIN or GROUP.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_request(struct udevice *dev, u32 id, u32 flags);
+
+/**
+ * scmi_pinctrl_release - Release exclusive control
+ * @dev:	SCMI pinctrl device
+ * @id:		Identifier of pin or group
+ * @flags:	A set of flags
+ *
+ * Release exclusive control of pin or group with @id by this agent.
+ * @flags can be SCMI_PINCTRL_TYPE_PIN or GROUP.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_release(struct udevice *dev, u32 id, u32 flags);
+
+/**
+ * scmi_pinctrl_name_get - Get extended name
+ * @dev:	SCMI pinctrl device
+ * @id:		Identifier of pin, group or function
+ * @flags:	A set of flags
+ *
+ * Get an extended name of pin, group or function with @id.
+ * @flags can be SCMI_PINCTRL_TYPE_PIN, GROUP or FUNCTION.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_name_get(struct udevice *dev, u32 id, u32 flags, u8 **name);
+
+/**
+ * scmi_pinctrl_set_permissions - Claim access permission
+ * @dev:	SCMI pinctrl device
+ * @agent_id:	Identifier of SCMI agent
+ * @id:		Identifier of pin or group
+ * @flags:	A set of flags
+ *
+ * Request to set or deny access permission against @id for the agent
+ * with @agent_id.
+ * Bit[2] of @flags indicates "allow access" if set, otherwise "deny access".
+ * @flags should have SCMI_PINCTRL_TYPE_PIN or GROUP.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int scmi_pinctrl_set_permissions(struct udevice *dev, u32 agent_id, u32 id,
+				 u32 flags);
+
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.34.1

