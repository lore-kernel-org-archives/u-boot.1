Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B80DCA0EC9
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958B386E27;
	Tue, 12 Sep 2023 08:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KgkRrvMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782B486E20; Tue, 12 Sep 2023 08:21:32 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E64486CD9
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf1876ef69so12871965ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499687; x=1695104487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAPA01IHC8Ey8Bv8JPjb4hiITF2m+YGlBkWrtW1X+dk=;
 b=KgkRrvMdUluq+PrfdTF4nVRZreYXdALzbgEfTXSeNZVeakTpBTRXgWlXwUxEl76je0
 rFW9+B18ZXcEM4ZF0z+T/xyncEThnlvrk/5zPKLiXjkZBFWJ/Hb8Rb7Dov8ZDtKY106b
 o/MdlB2iEf0FTD+hgi44VX0CPk0wuitbeiHNqYkujwJWclLKYRmZfZ5suc2gTOFCppWe
 drZSHNW23JdUpUKoedf/gVEpWTOTmpLIeTPT3DUTDS31TQeumJdbXwNnMfgqa0WrIa2Z
 7cb1xaQtH31SFFcXeu8Jv2Tkfsz/3G9K8ni0AuNDMGUuIHs36uTE+qGCPEFMwOciHN5J
 gKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499687; x=1695104487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAPA01IHC8Ey8Bv8JPjb4hiITF2m+YGlBkWrtW1X+dk=;
 b=E5WBzZbTOi5bIgST1N4roT9yq/GwQyhgdyQd8gpjYI3eA+XIuTf+VRLpCEQfEYSa6t
 sxY2iWjiq2RqF9Q3d6pnfmUBmi6z73J3bT5Ey0DdgO9c+cEnLzM6bN60R9ibEXvMD3rc
 4mQ0gK6leugzdaWvbwx09Wo45KQOqQhX/OuP/3jmbtPjwz5UutVTKsqApgJ/0X/h2iiO
 GLxqlr3Vsu93DpmFXi2c3O3AqqO3Fy9stgpfaKuPAi+QBrk88LbM6qUBlfid/hZwwCM5
 LG8Iv/5eSsN+2tsLQB1l0fne9il0GqDmkT+1kryGVu+6WsHTMOoKhRG4mdWcaBICBpls
 8wNw==
X-Gm-Message-State: AOJu0YwJL8V2f0DyXrLysOTeBreTMc7JYW6XuCRwGOWIb32pzmq3OQ5L
 4rZcW8xRDVcN+2SEsnBpSZOUWQ==
X-Google-Smtp-Source: AGHT+IFGESOwcde2ZK0kZPy5/5naal3TKrZWuU4kAtfK7gTEa79RNjBV+gt+Jp5ZgzfVVJQD2E5xyQ==
X-Received: by 2002:a17:902:cf44:b0:1c3:a4f2:7c87 with SMTP id
 e4-20020a170902cf4400b001c3a4f27c87mr7560701plg.4.1694499687517; 
 Mon, 11 Sep 2023 23:21:27 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:27 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 05/13] firmware: scmi: fake base protocol commands on
 sandbox
Date: Tue, 12 Sep 2023 15:19:54 +0900
Message-Id: <20230912062002.57361-6-takahiro.akashi@linaro.org>
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
index 031882998dfa..42a5a1f37f8b 100644
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
@@ -33,6 +36,21 @@
  * various uclass devices, as clocks and reset controllers.
  */
 
+#define SANDBOX_SCMI_BASE_PROTOCOL_VERSION SCMI_BASE_PROTOCOL_VERSION
+#define SANDBOX_SCMI_VENDOR "U-Boot"
+#define SANDBOX_SCMI_SUB_VENDOR "Sandbox"
+#define SANDBOX_SCMI_IMPL_VERSION 0x1
+#define SANDBOX_SCMI_AGENT_NAME "OSPM"
+#define SANDBOX_SCMI_PLATFORM_NAME "platform"
+
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
@@ -114,6 +132,316 @@ static struct sandbox_scmi_voltd *get_scmi_voltd_state(uint domain_id)
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
@@ -475,6 +803,36 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
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
@@ -517,7 +875,6 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			break;
 		}
 		break;
-	case SCMI_PROTOCOL_ID_BASE:
 	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
 	case SCMI_PROTOCOL_ID_SYSTEM:
 	case SCMI_PROTOCOL_ID_PERF:
-- 
2.34.1

