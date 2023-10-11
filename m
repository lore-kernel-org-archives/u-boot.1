Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CB3CD6E59
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1150A86CFD;
	Wed, 11 Oct 2023 12:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v5X38XXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EA186D0A; Wed, 11 Oct 2023 12:07:49 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D400086CFF
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6c61dd1c229so1793008a34.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018860; x=1697623660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R9WQiMopt71oBdYFpeWzlpOzx8LaAQ3Ht40XSMAvaA=;
 b=v5X38XXvL8SjS6hKTAt1z6arbvCuFDmqSUBa10c3/DbqGvmxgOOEuriNTGtF8O7/my
 YhqfSmPxmvcNVxMDJFNX7xIKkL4B+m9x/6RGMduRBwhfl52CDJAzgv54qSn7xBplVSVM
 S5VCoelBa3mrLjJbAFI5IkGWHOST4jPFpTTVcimj0UnuboMwWwLFQG7NTmD9YejKa/7p
 S+7og6Aa4eGQK44tHreLuTzBCbBg767oTiCBSEdyfaWa2OLfZW0A3v6wJdiWobdQCgKQ
 XcW603XjwmK7pdiAql+Gq2pdo1Xzy8dpOL4jBwFxJeiRDD1yMFK8+BI+huWRnsIiGqVt
 YLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018860; x=1697623660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2R9WQiMopt71oBdYFpeWzlpOzx8LaAQ3Ht40XSMAvaA=;
 b=NHRsQhGs3a/ur9GCnb2cXMN4amDUv4HxVak2Qm2not1QTfCTOVUau648OV+Barn8c/
 7D3UlRk+9ZRaVzScA8Y4DfWPLyjmTS2B5waEHesolBMlYJR13Utbk6NTPeWIRc0T3VQj
 IAgG1Woc1FQ/bTA8m1/DyYte9UTAhETPYH6GnNk8ViutpWOJD6pUZDiccRUoozComh52
 lBQ8bBBCxUdSCAFq42u/IKQ5jhgzE1DGqoC16fv3P9j3LWSEJ0b8c2KPEfT6W8V/OUtS
 /+KJ2sjnOBpqFRzgjaqEqJ1w2RAEvgAECbIrSd/9UxRnz9hbnGqyj0hgNq/37yiT9F5w
 NQfg==
X-Gm-Message-State: AOJu0Ywx7aHZPmdJrQ+Dk0L5kdpgCdDA7KXWg7UT14AZpDhUiDQL0nwM
 9UxWMgmVUChx66NkdsZVy6Ck8T484+YTFOq+yIZZ9w==
X-Google-Smtp-Source: AGHT+IGltPnVWaJdG4jAkE3sxsELDfEN4egxLLOPSrot8CxJH6mJVTekLoTk0KUYT27n7bPX0g1gNg==
X-Received: by 2002:a9d:5f88:0:b0:6c7:aab5:6e50 with SMTP id
 g8-20020a9d5f88000000b006c7aab56e50mr19759609oti.2.1697018859900; 
 Wed, 11 Oct 2023 03:07:39 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:39 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 07/14] firmware: scmi: implement SCMI base protocol
Date: Wed, 11 Oct 2023 19:07:00 +0900
Message-Id: <20231011100707.1007417-8-takahiro.akashi@linaro.org>
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

SCMI base protocol is mandatory according to the SCMI specification.

With this patch, SCMI base protocol can be accessed via SCMI transport
layers. All the commands, except SCMI_BASE_NOTIFY_ERRORS, are supported.
This is because U-Boot doesn't support interrupts and the current transport
layers are not able to handle asynchronous messages properly.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v6
* add comments to all the global helper functions
* declare scmi_base_ops as static
v3
* strncpy (TODO)
* remove a duplicated function prototype
* use newly-allocated memory when return vendor name or agent name
* revise function descriptions in a header
v2
* add helper functions, removing direct uses of ops
* add function descriptions for each of functions in ops
---
 drivers/firmware/scmi/Makefile |   1 +
 drivers/firmware/scmi/base.c   | 656 +++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h         |   1 +
 include/scmi_protocols.h       | 495 +++++++++++++++++++++++++
 4 files changed, 1153 insertions(+)
 create mode 100644 drivers/firmware/scmi/base.c

diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makefile
index b2ff483c75a1..1a23d4981709 100644
--- a/drivers/firmware/scmi/Makefile
+++ b/drivers/firmware/scmi/Makefile
@@ -1,4 +1,5 @@
 obj-y	+= scmi_agent-uclass.o
+obj-y	+= base.o
 obj-y	+= smt.o
 obj-$(CONFIG_SCMI_AGENT_SMCCC)		+= smccc_agent.o
 obj-$(CONFIG_SCMI_AGENT_MAILBOX)	+= mailbox_agent.o
diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
new file mode 100644
index 000000000000..ee84e261945a
--- /dev/null
+++ b/drivers/firmware/scmi/base.c
@@ -0,0 +1,656 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SCMI Base protocol as U-Boot device
+ *
+ * Copyright (C) 2023 Linaro Limited
+ *		author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <stdlib.h>
+#include <string.h>
+#include <asm/types.h>
+#include <dm/device_compat.h>
+#include <linux/kernel.h>
+
+/**
+ * scmi_generic_protocol_version - get protocol version
+ * @dev:	SCMI device
+ * @id:		SCMI protocol ID
+ * @version:	Pointer to SCMI protocol version
+ *
+ * Obtain the protocol version number in @version.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_generic_protocol_version(struct udevice *dev,
+				  enum scmi_std_protocol id, u32 *version)
+{
+	struct scmi_protocol_version_out out;
+	struct scmi_msg msg = {
+		.protocol_id = id,
+		.message_id = SCMI_PROTOCOL_VERSION,
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
+	*version = out.version;
+
+	return 0;
+}
+
+/**
+ * scmi_base_protocol_version_int - get Base protocol version
+ * @dev:	SCMI device
+ * @version:	Pointer to SCMI protocol version
+ *
+ * Obtain the protocol version number in @version for Base protocol.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_protocol_version_int(struct udevice *dev, u32 *version)
+{
+	return scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_BASE,
+					     version);
+}
+
+/**
+ * scmi_protocol_attrs_int - get protocol attributes
+ * @dev:		SCMI device
+ * @num_agents:		Number of SCMI agents
+ * @num_protocols:	Number of SCMI protocols
+ *
+ * Obtain the protocol attributes, the number of agents and the number
+ * of protocols, in @num_agents and @num_protocols respectively, that
+ * the device provides.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_protocol_attrs_int(struct udevice *dev, u32 *num_agents,
+				   u32 *num_protocols)
+{
+	struct scmi_protocol_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
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
+	*num_agents = SCMI_PROTOCOL_ATTRS_NUM_AGENTS(out.attributes);
+	*num_protocols = SCMI_PROTOCOL_ATTRS_NUM_PROTOCOLS(out.attributes);
+
+	return 0;
+}
+
+/**
+ * scmi_protocol_message_attrs_int - get message-specific attributes
+ * @dev:		SCMI device
+ * @message_id:		SCMI message ID
+ * @attributes:		Message-specific attributes
+ *
+ * Obtain the message-specific attributes in @attributes.
+ * This command succeeds if the message is implemented and available.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_protocol_message_attrs_int(struct udevice *dev, u32 message_id,
+					   u32 *attributes)
+{
+	struct scmi_protocol_msg_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_PROTOCOL_MESSAGE_ATTRIBUTES,
+		.in_msg = (u8 *)&message_id,
+		.in_msg_sz = sizeof(message_id),
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
+	*attributes = out.attributes;
+
+	return 0;
+}
+
+/**
+ * scmi_base_discover_vendor_int - get vendor name
+ * @dev:	SCMI device
+ * @vendor:	Pointer to vendor name
+ *
+ * Obtain the vendor's name in @vendor.
+ * It is a caller's responsibility to free @vendor.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_discover_vendor_int(struct udevice *dev, u8 **vendor)
+{
+	struct scmi_base_discover_vendor_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_DISCOVER_VENDOR,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!vendor)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*vendor = strdup(out.vendor_identifier);
+	if (!*vendor)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * scmi_base_discover_sub_vendor_int - get sub-vendor name
+ * @dev:	SCMI device
+ * @sub_vendor:	Pointer to sub-vendor name
+ *
+ * Obtain the sub-vendor's name in @sub_vendor.
+ * It is a caller's responsibility to free @sub_vendor.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_discover_sub_vendor_int(struct udevice *dev,
+					     u8 **sub_vendor)
+{
+	struct scmi_base_discover_vendor_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_DISCOVER_SUB_VENDOR,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!sub_vendor)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*sub_vendor = strdup(out.vendor_identifier);
+	if (!*sub_vendor)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * scmi_base_discover_impl_version_int - get implementation version
+ * @dev:		SCMI device
+ * @impl_version:	Pointer to implementation version
+ *
+ * Obtain the implementation version number in @impl_version.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_discover_impl_version_int(struct udevice *dev,
+					       u32 *impl_version)
+{
+	struct scmi_base_discover_impl_version_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_DISCOVER_IMPL_VERSION,
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
+	*impl_version = out.impl_version;
+
+	return 0;
+}
+
+/**
+ * scmi_base_discover_list_protocols_int - get list of protocols
+ * @dev:	SCMI device
+ * @protocols:	Pointer to array of SCMI protocols
+ *
+ * Obtain the list of protocols provided in @protocols.
+ * The number of elements in @protocols always match to the number of
+ * protocols returned by smci_protocol_attrs() when this function succeeds.
+ * It is a caller's responsibility to free @protocols.
+ *
+ * Return: the number of protocols in @protocols on success, error code on
+ * failure
+ */
+static int scmi_base_discover_list_protocols_int(struct udevice *dev,
+						 u8 **protocols)
+{
+	struct scmi_base_discover_list_protocols_out out;
+	int cur;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_DISCOVER_LIST_PROTOCOLS,
+		.in_msg = (u8 *)&cur,
+		.in_msg_sz = sizeof(cur),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	u32 num_agents, num_protocols;
+	u8 *buf;
+	int i, ret;
+
+	ret = scmi_base_protocol_attrs(dev, &num_agents, &num_protocols);
+	if (ret)
+		return ret;
+
+	buf = calloc(sizeof(u8), num_protocols);
+	if (!buf)
+		return -ENOMEM;
+
+	cur = 0;
+	do {
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			goto err;
+		if (out.status) {
+			ret = scmi_to_linux_errno(out.status);
+			goto err;
+		}
+
+		for (i = 0; i < out.num_protocols; i++, cur++)
+			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
+	} while (cur < num_protocols);
+
+	*protocols = buf;
+
+	return num_protocols;
+err:
+	free(buf);
+
+	return ret;
+}
+
+/**
+ * scmi_base_discover_agent_int - identify agent
+ * @dev:		SCMI device
+ * @agent_id:		SCMI agent ID
+ * @ret_agent_id:	Pointer to SCMI agent ID
+ * @name:		Pointer to SCMI agent name
+ *
+ * Obtain the agent's name in @name. If @agent_id is equal to 0xffffffff,
+ * this function returns the caller's agent id in @ret_agent_id.
+ * It is a caller's responsibility to free @name.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_discover_agent_int(struct udevice *dev, u32 agent_id,
+					u32 *ret_agent_id, u8 **name)
+{
+	struct scmi_base_discover_agent_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_DISCOVER_AGENT,
+		.in_msg = (u8 *)&agent_id,
+		.in_msg_sz = sizeof(agent_id),
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
+	if (ret_agent_id)
+		*ret_agent_id = out.agent_id;
+	if (name) {
+		*name = strdup(out.name);
+		if (!*name)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * scmi_base_set_device_permissions_int - configure access permission to device
+ * @dev:	SCMI device
+ * @agent_id:	SCMI agent ID
+ * @device_id:	ID of device to access
+ * @flags:	A set of flags
+ *
+ * Ask for allowing or denying access permission to the device, @device_id.
+ * The meaning of @flags is defined in SCMI specification.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_set_device_permissions_int(struct udevice *dev, u32 agent_id,
+						u32 device_id, u32 flags)
+{
+	struct scmi_base_set_device_permissions_in in = {
+		.agent_id = agent_id,
+		.device_id = device_id,
+		.flags = flags,
+	};
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_SET_DEVICE_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+/**
+ * scmi_base_set_protocol_permissions_int - configure access permission to
+ *					    protocol on device
+ * @dev:	SCMI device
+ * @agent_id:	SCMI agent ID
+ * @device_id:	ID of device to access
+ * @command_id:	SCMI command ID
+ * @flags:	A set of flags
+ *
+ * Ask for allowing or denying access permission to the protocol, @command_id,
+ * on the device, @device_id.
+ * The meaning of @flags is defined in SCMI specification.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_set_protocol_permissions_int(struct udevice *dev,
+						  u32 agent_id, u32 device_id,
+						  u32 command_id, u32 flags)
+{
+	struct scmi_base_set_protocol_permissions_in in = {
+		.agent_id = agent_id,
+		.device_id = device_id,
+		.command_id = command_id,
+		.flags = flags,
+	};
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_SET_PROTOCOL_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+/**
+ * scmi_base_reset_agent_configuration_int - reset resource settings
+ * @dev:	SCMI device
+ * @agent_id:	SCMI agent ID
+ * @flags:	A set of flags
+ *
+ * Reset all the resource settings against @agent_id.
+ * The meaning of @flags is defined in SCMI specification.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_reset_agent_configuration_int(struct udevice *dev,
+						   u32 agent_id, u32 flags)
+{
+	struct scmi_base_reset_agent_configuration_in in = {
+		.agent_id = agent_id,
+		.flags = flags,
+	};
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_BASE,
+		.message_id = SCMI_BASE_RESET_AGENT_CONFIGURATION,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+/**
+ * scmi_base_probe - probe base protocol device
+ * @dev:	SCMI device
+ *
+ * Probe the device for SCMI base protocol and initialize the private data.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_base_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "get_channel failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct scmi_base_ops scmi_base_ops = {
+	/* Commands */
+	.protocol_version = scmi_base_protocol_version_int,
+	.protocol_attrs = scmi_protocol_attrs_int,
+	.protocol_message_attrs = scmi_protocol_message_attrs_int,
+	.base_discover_vendor = scmi_base_discover_vendor_int,
+	.base_discover_sub_vendor = scmi_base_discover_sub_vendor_int,
+	.base_discover_impl_version = scmi_base_discover_impl_version_int,
+	.base_discover_list_protocols = scmi_base_discover_list_protocols_int,
+	.base_discover_agent = scmi_base_discover_agent_int,
+	.base_notify_errors = NULL,
+	.base_set_device_permissions = scmi_base_set_device_permissions_int,
+	.base_set_protocol_permissions = scmi_base_set_protocol_permissions_int,
+	.base_reset_agent_configuration =
+			scmi_base_reset_agent_configuration_int,
+};
+
+int scmi_base_protocol_version(struct udevice *dev, u32 *version)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->protocol_version)
+		return (*ops->protocol_version)(dev, version);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_protocol_attrs(struct udevice *dev, u32 *num_agents,
+			     u32 *num_protocols)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->protocol_attrs)
+		return (*ops->protocol_attrs)(dev, num_agents, num_protocols);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_protocol_message_attrs(struct udevice *dev, u32 message_id,
+				     u32 *attributes)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->protocol_message_attrs)
+		return (*ops->protocol_message_attrs)(dev, message_id,
+						      attributes);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_discover_vendor(struct udevice *dev, u8 **vendor)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_discover_vendor)
+		return (*ops->base_discover_vendor)(dev, vendor);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_discover_sub_vendor(struct udevice *dev, u8 **sub_vendor)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_discover_sub_vendor)
+		return (*ops->base_discover_sub_vendor)(dev, sub_vendor);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_discover_impl_version(struct udevice *dev, u32 *impl_version)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_discover_impl_version)
+		return (*ops->base_discover_impl_version)(dev, impl_version);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_discover_list_protocols(struct udevice *dev, u8 **protocols)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_discover_list_protocols)
+		return (*ops->base_discover_list_protocols)(dev, protocols);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_discover_agent(struct udevice *dev, u32 agent_id,
+			     u32 *ret_agent_id, u8 **name)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_discover_agent)
+		return (*ops->base_discover_agent)(dev, agent_id, ret_agent_id,
+						   name);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_notify_errors(struct udevice *dev, u32 enable)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_notify_errors)
+		return (*ops->base_notify_errors)(dev, enable);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_set_device_permissions(struct udevice *dev, u32 agent_id,
+				     u32 device_id, u32 flags)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_set_device_permissions)
+		return (*ops->base_set_device_permissions)(dev, agent_id,
+							   device_id, flags);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_set_protocol_permissions(struct udevice *dev,
+				       u32 agent_id, u32 device_id,
+				       u32 command_id, u32 flags)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_set_protocol_permissions)
+		return (*ops->base_set_protocol_permissions)(dev, agent_id,
+							     device_id,
+							     command_id,
+							     flags);
+
+	return -EOPNOTSUPP;
+}
+
+int scmi_base_reset_agent_configuration(struct udevice *dev, u32 agent_id,
+					u32 flags)
+{
+	const struct scmi_base_ops *ops = device_get_ops(dev);
+
+	if (ops->base_reset_agent_configuration)
+		return (*ops->base_reset_agent_configuration)(dev, agent_id,
+							      flags);
+
+	return -EOPNOTSUPP;
+}
+
+U_BOOT_DRIVER(scmi_base_drv) = {
+	.id = UCLASS_SCMI_BASE,
+	.name = "scmi_base_drv",
+	.ops = &scmi_base_ops,
+	.probe = scmi_base_probe,
+};
+
+UCLASS_DRIVER(scmi_base) = {
+	.id		= UCLASS_SCMI_BASE,
+	.name		= "scmi_base",
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 0432c95c9edc..ab315803dad7 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -123,6 +123,7 @@ enum uclass_id {
 	UCLASS_RNG,		/* Random Number Generator */
 	UCLASS_RTC,		/* Real time clock device */
 	UCLASS_SCMI_AGENT,	/* Interface with an SCMI server */
+	UCLASS_SCMI_BASE,	/* Interface for SCMI Base protocol */
 	UCLASS_SCSI,		/* SCSI device */
 	UCLASS_SERIAL,		/* Serial UART */
 	UCLASS_SIMPLE_BUS,	/* Bus with child devices */
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index a220cb2a91ad..163647a57b95 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -49,6 +49,501 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+/*
+ * SCMI Base Protocol
+ */
+#define SCMI_BASE_PROTOCOL_VERSION 0x20000
+
+enum scmi_base_message_id {
+	SCMI_BASE_DISCOVER_VENDOR = 0x3,
+	SCMI_BASE_DISCOVER_SUB_VENDOR = 0x4,
+	SCMI_BASE_DISCOVER_IMPL_VERSION = 0x5,
+	SCMI_BASE_DISCOVER_LIST_PROTOCOLS = 0x6,
+	SCMI_BASE_DISCOVER_AGENT = 0x7,
+	SCMI_BASE_NOTIFY_ERRORS = 0x8,
+	SCMI_BASE_SET_DEVICE_PERMISSIONS = 0x9,
+	SCMI_BASE_SET_PROTOCOL_PERMISSIONS = 0xa,
+	SCMI_BASE_RESET_AGENT_CONFIGURATION = 0xb,
+};
+
+#define SCMI_BASE_NAME_LENGTH_MAX 16
+
+/**
+ * struct scmi_protocol_version_out - Response for SCMI_PROTOCOL_VERSION
+ *					command
+ * @status:	SCMI command status
+ * @version:	Protocol version
+ */
+struct scmi_protocol_version_out {
+	s32 status;
+	u32 version;
+};
+
+/**
+ * struct scmi_protocol_attrs_out - Response for SCMI_PROTOCOL_ATTRIBUTES
+ *					command
+ * @status:	SCMI command status
+ * @attributes:	Protocol attributes or implementation details
+ */
+struct scmi_protocol_attrs_out {
+	s32 status;
+	u32 attributes;
+};
+
+#define SCMI_PROTOCOL_ATTRS_NUM_AGENTS(attributes) \
+				(((attributes) & GENMASK(15, 8)) >> 8)
+#define SCMI_PROTOCOL_ATTRS_NUM_PROTOCOLS(attributes) \
+				((attributes) & GENMASK(7, 0))
+
+/**
+ * struct scmi_protocol_msg_attrs_out - Response for
+ *					SCMI_PROTOCOL_MESSAGE_ATTRIBUTES command
+ * @status:	SCMI command status
+ * @attributes:	Message-specific attributes
+ */
+struct scmi_protocol_msg_attrs_out {
+	s32 status;
+	u32 attributes;
+};
+
+/**
+ * struct scmi_base_discover_vendor_out - Response for
+ *					  SCMI_BASE_DISCOVER_VENDOR or
+ *					  SCMI_BASE_DISCOVER_SUB_VENDOR command
+ * @status:		SCMI command status
+ * @vendor_identifier:	Name of vendor or sub-vendor in string
+ */
+struct scmi_base_discover_vendor_out {
+	s32 status;
+	u8 vendor_identifier[SCMI_BASE_NAME_LENGTH_MAX];
+};
+
+/**
+ * struct scmi_base_discover_impl_version_out - Response for
+ *					SCMI_BASE_DISCOVER_IMPL_VERSION command
+ * @status:		SCMI command status
+ * @impl_version:	Vendor-specific implementation version
+ */
+struct scmi_base_discover_impl_version_out {
+	s32 status;
+	u32 impl_version;
+};
+
+/**
+ * struct scmi_base_discover_list_protocols_out - Response for
+ *				SCMI_BASE_DISCOVER_LIST_PROTOCOLS command
+ * @status:		SCMI command status
+ * @num_protocols:	Number of SCMI protocols in @protocol
+ * @protocols:		Array of packed SCMI protocol ID's
+ */
+struct scmi_base_discover_list_protocols_out {
+	s32 status;
+	u32 num_protocols;
+	u32 protocols[3];
+};
+
+/**
+ * struct scmi_base_discover_agent_out - Response for
+ *					 SCMI_BASE_DISCOVER_AGENT command
+ * @status:	SCMI command status
+ * @agent_id:	SCMI agent ID
+ * @name:	Name of agent in string
+ */
+struct scmi_base_discover_agent_out {
+	s32 status;
+	u32 agent_id;
+	u8 name[SCMI_BASE_NAME_LENGTH_MAX];
+};
+
+#define SCMI_BASE_NOTIFY_ERRORS_ENABLE BIT(0)
+
+/**
+ * struct scmi_base_set_device_permissions_in - Parameters for
+ *					SCMI_BASE_SET_DEVICE_PERMISSIONS command
+ * @agent_id:	SCMI agent ID
+ * @device_id:	device ID
+ * @flags:	A set of flags
+ */
+struct scmi_base_set_device_permissions_in {
+	u32 agent_id;
+	u32 device_id;
+	u32 flags;
+};
+
+#define SCMI_BASE_SET_DEVICE_PERMISSIONS_ACCESS BIT(0)
+
+/**
+ * struct scmi_base_set_protocol_permissions_in - Parameters for
+ *				SCMI_BASE_SET_PROTOCOL_PERMISSIONS command
+ * @agent_id:		SCMI agent ID
+ * @device_id:		device ID
+ * @command_id:		command ID
+ * @flags:		A set of flags
+ */
+struct scmi_base_set_protocol_permissions_in {
+	u32 agent_id;
+	u32 device_id;
+	u32 command_id;
+	u32 flags;
+};
+
+#define SCMI_BASE_SET_PROTOCOL_PERMISSIONS_COMMAND GENMASK(7, 0)
+#define SCMI_BASE_SET_PROTOCOL_PERMISSIONS_ACCESS BIT(0)
+
+/**
+ * struct scmi_base_reset_agent_configuration_in - Parameters for
+ *				SCMI_BASE_RESET_AGENT_CONFIGURATION command
+ * @agent_id:	SCMI agent ID
+ * @flags:	A set of flags
+ */
+struct scmi_base_reset_agent_configuration_in {
+	u32 agent_id;
+	u32 flags;
+};
+
+#define SCMI_BASE_RESET_ALL_ACCESS_PERMISSIONS BIT(0)
+
+/**
+ * struct scmi_base_ops - SCMI base protocol interfaces
+ */
+struct scmi_base_ops {
+	/**
+	 * protocol_version - get Base protocol version
+	 * @dev:	SCMI protocol device
+	 * @version:	Pointer to SCMI protocol version
+	 *
+	 * Obtain the protocol version number in @version for Base protocol.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*protocol_version)(struct udevice *dev, u32 *version);
+	/**
+	 * protocol_attrs - get protocol attributes
+	 * @dev:		SCMI protocol device
+	 * @num_agents:		Number of SCMI agents
+	 * @num_protocols:	Number of SCMI protocols
+	 *
+	 * Obtain the protocol attributes, the number of agents and the number
+	 * of protocols, in @num_agents and @num_protocols respectively, that
+	 * the device provides.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*protocol_attrs)(struct udevice *dev, u32 *num_agents,
+			      u32 *num_protocols);
+	/**
+	 * protocol_message_attrs - get message-specific attributes
+	 * @dev:		SCMI protocol device
+	 * @message_id:		SCMI message ID
+	 * @attributes:		Message-specific attributes
+	 *
+	 * Obtain the message-specific attributes in @attributes.
+	 * This command succeeds if the message is implemented and available.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*protocol_message_attrs)(struct udevice *dev, u32 message_id,
+				      u32 *attributes);
+	/**
+	 * base_discover_vendor - get vendor name
+	 * @dev:	SCMI protocol device
+	 * @vendor:	Pointer to vendor name
+	 *
+	 * Obtain the vendor's name in @vendor.
+	 * It is a caller's responsibility to free @vendor.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_discover_vendor)(struct udevice *dev, u8 **vendor);
+	/**
+	 * base_discover_sub_vendor - get sub-vendor name
+	 * @dev:	SCMI protocol device
+	 * @sub_vendor:	Pointer to sub-vendor name
+	 *
+	 * Obtain the sub-vendor's name in @sub_vendor.
+	 * It is a caller's responsibility to free @sub_vendor.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_discover_sub_vendor)(struct udevice *dev, u8 **sub_vendor);
+	/**
+	 * base_discover_impl_version - get implementation version
+	 * @dev:		SCMI protocol device
+	 * @impl_version:	Pointer to implementation version
+	 *
+	 * Obtain the implementation version number in @impl_version.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_discover_impl_version)(struct udevice *dev,
+					  u32 *impl_version);
+	/**
+	 * base_discover_list_protocols - get list of protocols
+	 * @dev:	SCMI protocol device
+	 * @protocols:	Pointer to array of SCMI protocols
+	 *
+	 * Obtain the list of protocols provided in @protocols.
+	 * The number of elements in @protocols always match to the number of
+	 * protocols returned by smci_protocol_attrs() when this function
+	 * succeeds.
+	 * It is a caller's responsibility to free @protocols.
+	 *
+	 * Return: the number of protocols in @protocols on success,
+	 * error code on failure
+	 */
+	int (*base_discover_list_protocols)(struct udevice *dev,
+					    u8 **protocols);
+	/**
+	 * base_discover_agent - identify agent
+	 * @dev:		SCMI protocol device
+	 * @agent_id:		SCMI agent ID
+	 * @ret_agent_id:	Pointer to SCMI agent ID
+	 * @name:		Pointer to SCMI agent name
+	 *
+	 * Obtain the agent's name in @name. If @agent_id is equal to
+	 * 0xffffffff, * this function returns the caller's agent id in
+	 * @ret_agent_id.
+	 * It is a caller's responsibility to free @name.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_discover_agent)(struct udevice *dev, u32 agent_id,
+				   u32 *ret_agent_id, u8 **name);
+	/**
+	 * base_notify_errors - configure error notification
+	 * @dev:	SCMI protocol device
+	 * @enable:	Operation
+	 *
+	 * Enable or disable error notification from SCMI firmware.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_notify_errors)(struct udevice *dev, u32 enable);
+	/**
+	 * base_set_device_permissions - configure access permission to device
+	 * @dev:	SCMI protocol device
+	 * @agent_id:	SCMI agent ID
+	 * @device_id:	ID of device to access
+	 * @flags:	A set of flags
+	 *
+	 * Ask for allowing or denying access permission to the device,
+	 * @device_id. The meaning of @flags is defined in SCMI specification.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_set_device_permissions)(struct udevice *dev, u32 agent_id,
+					   u32 device_id, u32 flags);
+	/**
+	 * base_set_protocol_permissions - configure access permission to
+	 *				   protocol on device
+	 * @dev:	SCMI protocol device
+	 * @agent_id:	SCMI agent ID
+	 * @device_id:	ID of device to access
+	 * @command_id:	command ID
+	 * @flags:	A set of flags
+	 *
+	 * Ask for allowing or denying access permission to the protocol,
+	 * @command_id, on the device, @device_id.
+	 * The meaning of @flags is defined in SCMI specification.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_set_protocol_permissions)(struct udevice *dev, u32 agent_id,
+					     u32 device_id, u32 command_id,
+					     u32 flags);
+	/**
+	 * base_reset_agent_configuration - reset resource settings
+	 * @dev:	SCMI protocol device
+	 * @agent_id:	SCMI agent ID
+	 * @flags:	A set of flags
+	 *
+	 * Reset all the resource settings against @agent_id.
+	 * The meaning of @flags is defined in SCMI specification.
+	 *
+	 * Return: 0 on success, error code on failure
+	 */
+	int (*base_reset_agent_configuration)(struct udevice *dev, u32 agent_id,
+					      u32 flags);
+};
+
+/**
+ * scmi_generic_protocol_version - get protocol version
+ * @dev:	SCMI protocol device
+ * @id:		SCMI protocol ID
+ * @version:	Pointer to SCMI protocol version
+ *
+ * Obtain the protocol version number in @version.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_generic_protocol_version(struct udevice *dev,
+				  enum scmi_std_protocol id, u32 *version);
+
+/**
+ * scmi_base_protocol_version - get Base protocol version
+ * @dev:	SCMI protocol device
+ * @version:	Pointer to SCMI protocol version
+ *
+ * Obtain the protocol version number in @version for Base protocol.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_protocol_version(struct udevice *dev, u32 *version);
+
+/**
+ * scmi_protocol_attrs - get protocol attributes
+ * @dev:		SCMI protocol device
+ * @num_agents:		Number of SCMI agents
+ * @num_protocols:	Number of SCMI protocols
+ *
+ * Obtain the protocol attributes, the number of agents and the number
+ * of protocols, in @num_agents and @num_protocols respectively, that
+ * the device provides.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_protocol_attrs(struct udevice *dev, u32 *num_agents,
+			     u32 *num_protocols);
+
+/**
+ * scmi_protocol_message_attrs - get message-specific attributes
+ * @dev:		SCMI protocol device
+ * @message_id:		SCMI message ID
+ * @attributes:		Message-specific attributes
+ *
+ * Obtain the message-specific attributes in @attributes.
+ * This command succeeds if the message is implemented and available.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_protocol_message_attrs(struct udevice *dev, u32 message_id,
+				     u32 *attributes);
+
+/**
+ * scmi_base_discover_vendor - get vendor name
+ * @dev:	SCMI protocol device
+ * @vendor:	Pointer to vendor name
+ *
+ * Obtain the vendor's name in @vendor.
+ * It is a caller's responsibility to free @vendor.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_discover_vendor(struct udevice *dev, u8 **vendor);
+
+/**
+ * scmi_base_discover_sub_vendor - get sub-vendor name
+ * @dev:	SCMI protocol device
+ * @sub_vendor:	Pointer to sub-vendor name
+ *
+ * Obtain the sub-vendor's name in @sub_vendor.
+ * It is a caller's responsibility to free @sub_vendor.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_discover_sub_vendor(struct udevice *dev, u8 **sub_vendor);
+
+/**
+ * scmi_base_discover_impl_version - get implementation version
+ * @dev:		SCMI protocol device
+ * @impl_version:	Pointer to implementation version
+ *
+ * Obtain the implementation version number in @impl_version.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_discover_impl_version(struct udevice *dev, u32 *impl_version);
+
+/**
+ * scmi_base_discover_list_protocols - get list of protocols
+ * @dev:	SCMI protocol device
+ * @protocols:	Pointer to array of SCMI protocols
+ *
+ * Obtain the list of protocols provided in @protocols.
+ * The number of elements in @protocols always match to the number of
+ * protocols returned by smci_protocol_attrs() when this function succeeds.
+ * It is a caller's responsibility to free @protocols.
+ *
+ * Return: the number of protocols in @protocols on success, error code on
+ * failure
+ */
+int scmi_base_discover_list_protocols(struct udevice *dev, u8 **protocols);
+
+/**
+ * scmi_base_discover_agent - identify agent
+ * @dev:		SCMI protocol device
+ * @agent_id:		SCMI agent ID
+ * @ret_agent_id:	Pointer to SCMI agent ID
+ * @name:		Pointer to SCMI agent name
+ *
+ * Obtain the agent's name in @name. If @agent_id is equal to 0xffffffff,
+ * this function returns the caller's agent id in @ret_agent_id.
+ * It is a caller's responsibility to free @name.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_discover_agent(struct udevice *dev, u32 agent_id,
+			     u32 *ret_agent_id, u8 **name);
+
+/**
+ * scmi_base_notify_errors - configure error notification
+ * @dev:	SCMI protocol device
+ * @enable:	Operation
+ *
+ * Enable or disable error notification from SCMI firmware.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_notify_errors(struct udevice *dev, u32 enable);
+
+/**
+ * scmi_base_set_device_permissions - configure access permission to device
+ * @dev:	SCMI protocol device
+ * @agent_id:	SCMI agent ID
+ * @device_id:	ID of device to access
+ * @flags:	A set of flags
+ *
+ * Ask for allowing or denying access permission to the device, @device_id.
+ * The meaning of @flags is defined in SCMI specification.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_set_device_permissions(struct udevice *dev, u32 agent_id,
+				     u32 device_id, u32 flags);
+
+/**
+ * scmi_base_set_protocol_permissions - configure access permission to
+ *					protocol on device
+ * @dev:	SCMI protocol device
+ * @agent_id:	SCMI agent ID
+ * @device_id:	ID of device to access
+ * @command_id:	SCMI command ID
+ * @flags:	A set of flags
+ *
+ * Ask for allowing or denying access permission to the protocol, @command_id,
+ * on the device, @device_id.
+ * The meaning of @flags is defined in SCMI specification.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_set_protocol_permissions(struct udevice *dev,
+				       u32 agent_id, u32 device_id,
+				       u32 command_id, u32 flags);
+
+/**
+ * scmi_base_reset_agent_configuration - reset resource settings
+ * @dev:	SCMI protocol device
+ * @agent_id:	SCMI agent ID
+ * @flags:	A set of flags
+ *
+ * Reset all the resource settings against @agent_id.
+ * The meaning of @flags is defined in SCMI specification.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_base_reset_agent_configuration(struct udevice *dev, u32 agent_id,
+					u32 flags);
+
 /*
  * SCMI Clock Protocol
  */
-- 
2.34.1

