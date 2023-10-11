Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2ADCD6E54
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EBD86D94;
	Wed, 11 Oct 2023 12:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GpwhXPrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B461A86D05; Wed, 11 Oct 2023 12:08:05 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C13A686D05
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3af59a017a5so1172036b6e.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018864; x=1697623664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0VkA5ZEvMMrQPxzvrsI3HC9P2fb4sVO3QHTMu1u/8Y=;
 b=GpwhXPrVFr+pPgljRjgl50HnBU22wkyINy9GAF4ZUPQal9xYgqEo67zV0rGZS1aSUJ
 qSClpPPXj6GEUEiPoZHCQU7/yWvteYMBZgohm71iRDSpUesI9KyEAbCbfVb3giBZKHWG
 Y5eAlgHBoB3CVIPVJcE8sXEQ04bgEA8ZFmzA7n/gOO9COsAWdXhWfWZqqXeDAyFDk4Sc
 Rh/v71896ehsEoKL8pK5cI1UtUr863gKILD1fK2UtU36a33HzWUKGqSIDqKYxnIwIo3E
 6hru/bRTK8Wpx3qT1TXuPxG47rOV3SuAAgFmAlr5KA1qMuf8+khf07AJSdNFAjLOP+bk
 arFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018864; x=1697623664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0VkA5ZEvMMrQPxzvrsI3HC9P2fb4sVO3QHTMu1u/8Y=;
 b=CY5qt+2zgLWDCOZIT27lk+t+DmEmrVKX2vY+EOff/rJVtJeiNmKQ4K0mkohIksQZX6
 umxjrE9y2fXqMNOu25RMpq1ejQmq2FUn8Pq/c0snLfe2gTJnaccBSETOcEQsUrnhBavF
 wk41Sr2NSb4zUFvPgNnTwbopgxCskrHjHYSQCTvV86WUsTqSNKdf0UfDIelv6yhVK13V
 2jM7NNmSDQPT6J1c1kEiN4DzF9puCo/edJdHBtaBbyhKveP6+SIJUFZC4S2iyJIgRoyu
 oo1du7lTWRWueZXQ+qYJFPeT93kOZo+UR6Z4o9eL/NnH4/lxV81hmUZEESH774YLoF49
 WP+w==
X-Gm-Message-State: AOJu0YzOl/8sP47d9UdxLnNBICDdM0e7zYeP6sAPwVaXY6nSnRvs/Jaq
 oXa6148WHAIqXL/135/zhi1sAw==
X-Google-Smtp-Source: AGHT+IEaHxvUvlaStA063mbI4YnOElnyWqzcsJnYbx9cil1GGSTBJZggTi2V86uc9rTFv5EXeaxmaA==
X-Received: by 2002:a05:6808:3008:b0:3ad:af12:2fe0 with SMTP id
 ay8-20020a056808300800b003adaf122fe0mr23806415oib.3.1697018864363; 
 Wed, 11 Oct 2023 03:07:44 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:44 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 09/14] firmware: scmi: fake base protocol commands on
 sandbox
Date: Wed, 11 Oct 2023 19:07:02 +0900
Message-Id: <20231011100707.1007417-10-takahiro.akashi@linaro.org>
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

This is a simple implementation of SCMI base protocol for sandbox.
The main use is in SCMI unit test.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v4
* move this patch forward in this series before installing base
  protocol to avoid collapsing existing SCMI test.
v3
* type fixes: s/udevice/dev/ in function descriptions
---
 drivers/firmware/scmi/sandbox-scmi_agent.c | 359 ++++++++++++++++++++-
 1 file changed, 358 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 394df043918f..716bbf97d5c9 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -14,11 +14,14 @@
 #include <asm/io.h>
 #include <asm/scmi_test.h>
 #include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/kernel.h>
 
 /*
  * The sandbox SCMI agent driver simulates to some extend a SCMI message
  * processing. It simulates few of the SCMI services for some of the
  * SCMI protocols embedded in U-Boot. Currently:
+ * - SCMI base protocol
  * - SCMI clock protocol emulates an agent exposing 2 clocks
  * - SCMI reset protocol emulates an agent exposing a reset controller
  * - SCMI voltage domain protocol emulates an agent exposing 2 regulators
@@ -33,6 +36,13 @@
  * various uclass devices, as clocks and reset controllers.
  */
 
+#define SANDBOX_SCMI_BASE_PROTOCOL_VERSION SCMI_BASE_PROTOCOL_VERSION
+#define SANDBOX_SCMI_VENDOR "U-Boot"
+#define SANDBOX_SCMI_SUB_VENDOR "Sandbox"
+#define SANDBOX_SCMI_IMPL_VERSION 0x1
+#define SANDBOX_SCMI_AGENT_NAME "OSPM"
+#define SANDBOX_SCMI_PLATFORM_NAME "platform"
+
 /**
  * struct sandbox_channel - Description of sandbox transport
  * @channel_id:		Channel identifier
@@ -53,6 +63,14 @@ struct scmi_channel {
 	struct sandbox_channel ref;
 };
 
+static u8 protocols[] = {
+	SCMI_PROTOCOL_ID_CLOCK,
+	SCMI_PROTOCOL_ID_RESET_DOMAIN,
+	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
+};
+
+#define NUM_PROTOCOLS ARRAY_SIZE(protocols)
+
 static struct sandbox_scmi_clk scmi_clk[] = {
 	{ .rate = 333 },
 	{ .rate = 200 },
@@ -134,6 +152,316 @@ static struct sandbox_scmi_voltd *get_scmi_voltd_state(uint domain_id)
  * Sandbox SCMI agent ops
  */
 
+/* Base Protocol */
+
+/**
+ * sandbox_scmi_base_protocol_version - implement SCMI_BASE_PROTOCOL_VERSION
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_PROTOCOL_VERSION command.
+ */
+static int sandbox_scmi_base_protocol_version(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = SANDBOX_SCMI_BASE_PROTOCOL_VERSION;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_protocol_attrs - implement SCMI_BASE_PROTOCOL_ATTRIBUTES
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_PROTOCOL_ATTRIBUTES command.
+ */
+static int sandbox_scmi_base_protocol_attrs(struct udevice *dev,
+					    struct scmi_msg *msg)
+{
+	struct scmi_protocol_attrs_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_attrs_out *)msg->out_msg;
+	out->attributes = FIELD_PREP(0xff00, 2) | NUM_PROTOCOLS;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_message_attrs - implement
+ *					SCMI_BASE_PROTOCOL_MESSAGE_ATTRIBUTES
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_PROTOCOL_MESSAGE_ATTRIBUTES command.
+ */
+static int sandbox_scmi_base_message_attrs(struct udevice *dev,
+					   struct scmi_msg *msg)
+{
+	u32 message_id;
+	struct scmi_protocol_msg_attrs_out *out = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(message_id) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	message_id = *(u32 *)msg->in_msg;
+	out = (struct scmi_protocol_msg_attrs_out *)msg->out_msg;
+
+	if (message_id >= SCMI_PROTOCOL_VERSION &&
+	    message_id <= SCMI_BASE_RESET_AGENT_CONFIGURATION &&
+	    message_id != SCMI_BASE_NOTIFY_ERRORS) {
+		out->attributes = 0;
+		out->status = SCMI_SUCCESS;
+	} else {
+		out->status = SCMI_NOT_FOUND;
+	}
+
+		return 0;
+}
+
+/**
+ * sandbox_scmi_base_discover_vendor - implement SCMI_BASE_DISCOVER_VENDOR
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_DISCOVER_VENDOR command
+ */
+static int sandbox_scmi_base_discover_vendor(struct udevice *dev,
+					     struct scmi_msg *msg)
+{
+	struct scmi_base_discover_vendor_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_base_discover_vendor_out *)msg->out_msg;
+	strcpy(out->vendor_identifier, SANDBOX_SCMI_VENDOR);
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_discover_sub_vendor - implement
+ *						SCMI_BASE_DISCOVER_SUB_VENDOR
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_DISCOVER_SUB_VENDOR command
+ */
+static int sandbox_scmi_base_discover_sub_vendor(struct udevice *dev,
+						 struct scmi_msg *msg)
+{
+	struct scmi_base_discover_vendor_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_base_discover_vendor_out *)msg->out_msg;
+	strcpy(out->vendor_identifier, SANDBOX_SCMI_SUB_VENDOR);
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_discover_impl_version - implement
+ *				SCMI_BASE_DISCOVER_IMPLEMENTATION_VERSION
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_DISCOVER_IMPLEMENTATION_VERSION command
+ */
+static int sandbox_scmi_base_discover_impl_version(struct udevice *dev,
+						   struct scmi_msg *msg)
+{
+	struct scmi_base_discover_impl_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_base_discover_impl_version_out *)msg->out_msg;
+	out->impl_version = SANDBOX_SCMI_IMPL_VERSION;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_discover_list_protocols - implement
+ *					SCMI_BASE_DISCOVER_LIST_PROTOCOLS
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_DISCOVER_LIST_PROTOCOLS command
+ */
+static int sandbox_scmi_base_discover_list_protocols(struct udevice *dev,
+						     struct scmi_msg *msg)
+{
+	struct scmi_base_discover_list_protocols_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_base_discover_list_protocols_out *)msg->out_msg;
+	memcpy(out->protocols, protocols, sizeof(protocols));
+	out->num_protocols = NUM_PROTOCOLS;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_discover_agent - implement SCMI_BASE_DISCOVER_AGENT
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_DISCOVER_AGENT command
+ */
+static int sandbox_scmi_base_discover_agent(struct udevice *dev,
+					    struct scmi_msg *msg)
+{
+	u32 agent_id;
+	struct scmi_base_discover_agent_out *out = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(agent_id) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	agent_id = *(u32 *)msg->in_msg;
+	out = (struct scmi_base_discover_agent_out *)msg->out_msg;
+	out->status = SCMI_SUCCESS;
+	if (agent_id == 0xffffffff || agent_id == 1) {
+		out->agent_id = 1;
+		strcpy(out->name, SANDBOX_SCMI_AGENT_NAME);
+	} else if (!agent_id) {
+		out->agent_id = agent_id;
+		strcpy(out->name, SANDBOX_SCMI_PLATFORM_NAME);
+	} else {
+		out->status = SCMI_NOT_FOUND;
+	}
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_set_device_permissions - implement
+ *						SCMI_BASE_SET_DEVICE_PERMISSIONS
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_SET_DEVICE_PERMISSIONS command
+ */
+static int sandbox_scmi_base_set_device_permissions(struct udevice *dev,
+						    struct scmi_msg *msg)
+{
+	struct scmi_base_set_device_permissions_in *in = NULL;
+	u32 *status;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_base_set_device_permissions_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	if (in->agent_id != 1 || in->device_id != 0)
+		*status = SCMI_NOT_FOUND;
+	else if (in->flags & ~SCMI_BASE_SET_DEVICE_PERMISSIONS_ACCESS)
+		*status = SCMI_INVALID_PARAMETERS;
+	else if (in->flags & SCMI_BASE_SET_DEVICE_PERMISSIONS_ACCESS)
+		*status = SCMI_SUCCESS;
+	else
+		/* unset not allowed */
+		*status = SCMI_DENIED;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_set_protocol_permissions - implement
+ *					SCMI_BASE_SET_PROTOCOL_PERMISSIONS
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_SET_PROTOCOL_PERMISSIONS command
+ */
+static int sandbox_scmi_base_set_protocol_permissions(struct udevice *dev,
+						      struct scmi_msg *msg)
+{
+	struct scmi_base_set_protocol_permissions_in *in = NULL;
+	u32 *status;
+	int i;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_base_set_protocol_permissions_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	for (i = 0; i < ARRAY_SIZE(protocols); i++)
+		if (protocols[i] == in->command_id)
+			break;
+	if (in->agent_id != 1 || in->device_id != 0 ||
+	    i == ARRAY_SIZE(protocols))
+		*status = SCMI_NOT_FOUND;
+	else if (in->flags & ~SCMI_BASE_SET_PROTOCOL_PERMISSIONS_ACCESS)
+		*status = SCMI_INVALID_PARAMETERS;
+	else if (in->flags & SCMI_BASE_SET_PROTOCOL_PERMISSIONS_ACCESS)
+		*status = SCMI_SUCCESS;
+	else
+		/* unset not allowed */
+		*status = SCMI_DENIED;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_base_reset_agent_configuration - implement
+ *					SCMI_BASE_RESET_AGENT_CONFIGURATION
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_BASE_RESET_AGENT_CONFIGURATION command
+ */
+static int sandbox_scmi_base_reset_agent_configuration(struct udevice *dev,
+						       struct scmi_msg *msg)
+{
+	struct scmi_base_reset_agent_configuration_in *in = NULL;
+	u32 *status;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_base_reset_agent_configuration_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	if (in->agent_id != 1)
+		*status = SCMI_NOT_FOUND;
+	else if (in->flags & ~SCMI_BASE_RESET_ALL_ACCESS_PERMISSIONS)
+		*status = SCMI_INVALID_PARAMETERS;
+	else
+		*status = SCMI_DENIED;
+
+	return 0;
+}
+
+/* Clock Protocol */
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -562,6 +890,36 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 					 struct scmi_msg *msg)
 {
 	switch (msg->protocol_id) {
+	case SCMI_PROTOCOL_ID_BASE:
+		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_base_protocol_version(dev, msg);
+		case SCMI_PROTOCOL_ATTRIBUTES:
+			return sandbox_scmi_base_protocol_attrs(dev, msg);
+		case SCMI_PROTOCOL_MESSAGE_ATTRIBUTES:
+			return sandbox_scmi_base_message_attrs(dev, msg);
+		case SCMI_BASE_DISCOVER_VENDOR:
+			return sandbox_scmi_base_discover_vendor(dev, msg);
+		case SCMI_BASE_DISCOVER_SUB_VENDOR:
+			return sandbox_scmi_base_discover_sub_vendor(dev, msg);
+		case SCMI_BASE_DISCOVER_IMPL_VERSION:
+			return sandbox_scmi_base_discover_impl_version(dev, msg);
+		case SCMI_BASE_DISCOVER_LIST_PROTOCOLS:
+			return sandbox_scmi_base_discover_list_protocols(dev, msg);
+		case SCMI_BASE_DISCOVER_AGENT:
+			return sandbox_scmi_base_discover_agent(dev, msg);
+		case SCMI_BASE_NOTIFY_ERRORS:
+			break;
+		case SCMI_BASE_SET_DEVICE_PERMISSIONS:
+			return sandbox_scmi_base_set_device_permissions(dev, msg);
+		case SCMI_BASE_SET_PROTOCOL_PERMISSIONS:
+			return sandbox_scmi_base_set_protocol_permissions(dev, msg);
+		case SCMI_BASE_RESET_AGENT_CONFIGURATION:
+			return sandbox_scmi_base_reset_agent_configuration(dev, msg);
+		default:
+			break;
+		}
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		switch (msg->message_id) {
 		case SCMI_PROTOCOL_ATTRIBUTES:
@@ -604,7 +962,6 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			break;
 		}
 		break;
-	case SCMI_PROTOCOL_ID_BASE:
 	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
 	case SCMI_PROTOCOL_ID_SYSTEM:
 	case SCMI_PROTOCOL_ID_PERF:
-- 
2.34.1

