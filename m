Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDBEE7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9C886D92;
	Tue, 26 Sep 2023 09:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i8MjxFnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82DF886D90; Tue, 26 Sep 2023 09:01:08 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0258286D86
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-578e174660dso453901a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711664; x=1696316464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01wfWo6U8HLTHAg24OdY6ODw0XQDBEVowfapOuQgWQE=;
 b=i8MjxFnRPzmMQc+nSK7JtX9i3poXjQbZPLD/odNrDNuYZfnbhxRaDPyPPseQ6NFBfC
 4SlDvMAYxVrB+Ouvn3IcqvTEOpPb6JM2B70aX+Nodz47OibUJxo94DQeo6UzWuIVRBp6
 kIMOUj3uMvrEW0O8MEYLSnJ3GAXflKgXQ8kmoHYEZxrrXZC5A2gbXSNP4cG36+Wx2ejK
 i3lzttCUSgeW5RzB+4bsKqflrzrmVis8ZM7Jhwrojy/1Ze/AU05Pgw7o7WAt0vfdJSTk
 DdJZGJDZCgcYy4NK97H33HqVll85lIhqb2rJvrhvFG0HGSUrhj7yGfUiaBBe8IjcturH
 OqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711664; x=1696316464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01wfWo6U8HLTHAg24OdY6ODw0XQDBEVowfapOuQgWQE=;
 b=kHnEIvcmhWxTdwE5qycRdaqeI0ZPE0dziRiwhMePzay4Q8O9CkBt5vJdaYW9+x8f4Q
 y8cT5EmMPHF8NhlFcyVIz+CGCEIMn7aiZ3bEx8Ipe8VDMrIMGhzuvKX8U4cJq8Ivtg4r
 clwvq/tt6N5YMzjNPKJzWOxx+dv2RxEMGzz0KnljwNd18jVI6pkdjcgi79CQEuFwXFbe
 EEyzTgP9lneMbApfY887rQp2qSjBFx6q54KqWCUCdTJejIpG9bF80T9zqIDog9SE+dRP
 8HsGFiPtkT0ckGvvwKrGAM3Lf7fjc0ZLvX32YV3vCtxcR4/3COArREynKygR1bNyTOoj
 /Jvg==
X-Gm-Message-State: AOJu0Yyi0VzkDOAhUhm5JYN34nYQWwrwpTQmHuGWDKI8VJ6HNZVHRhoH
 F0hxBTlowMYTUMqy/95BaFGzkQ==
X-Google-Smtp-Source: AGHT+IHzgQ1tdCAR/23IwEpiQ0bYQFLn4QETv6mHat2yKynYY0Q9Kx4+Ay4HxjsXDtlLBbW/3uCSVg==
X-Received: by 2002:a17:90a:bc9:b0:268:38a7:842e with SMTP id
 x9-20020a17090a0bc900b0026838a7842emr7876157pjd.2.1695711664253; 
 Tue, 26 Sep 2023 00:01:04 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b0027758c7f585sm3178480pjb.52.2023.09.26.00.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 00:01:03 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 1/4] firmware: scmi: add power domain protocol support
Date: Tue, 26 Sep 2023 16:00:40 +0900
Message-Id: <20230926070043.738340-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926070043.738340-1-takahiro.akashi@linaro.org>
References: <20230926070043.738340-1-takahiro.akashi@linaro.org>
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

In this patch, added are helper functions to directly manipulate
SCMI power domain management protocol. DM compliant power domain
driver will be implemented on top of those interfaces in a succeeding
patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/firmware/scmi/Makefile |   1 +
 drivers/firmware/scmi/pwdom.c  | 189 +++++++++++++++++++++++++++++++++
 include/scmi_protocols.h       | 178 +++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 drivers/firmware/scmi/pwdom.c

diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makefile
index 1a23d4981709..dae42863589a 100644
--- a/drivers/firmware/scmi/Makefile
+++ b/drivers/firmware/scmi/Makefile
@@ -4,4 +4,5 @@ obj-y	+= smt.o
 obj-$(CONFIG_SCMI_AGENT_SMCCC)		+= smccc_agent.o
 obj-$(CONFIG_SCMI_AGENT_MAILBOX)	+= mailbox_agent.o
 obj-$(CONFIG_SCMI_AGENT_OPTEE)	+= optee_agent.o
+obj-$(CONFIG_SCMI_POWER_DOMAIN)		+= pwdom.o
 obj-$(CONFIG_SANDBOX)		+= sandbox-scmi_agent.o sandbox-scmi_devices.o
diff --git a/drivers/firmware/scmi/pwdom.c b/drivers/firmware/scmi/pwdom.c
new file mode 100644
index 000000000000..61b4338663de
--- /dev/null
+++ b/drivers/firmware/scmi/pwdom.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SCMI Power domain management protocol
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
+
+int scmi_pwd_protocol_attrs(struct udevice *dev, int *num_pwdoms,
+			    u64 *stats_addr, size_t *stats_len)
+{
+	struct scmi_pwd_protocol_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_POWER_DOMAIN,
+		.message_id = SCMI_PROTOCOL_ATTRIBUTES,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !num_pwdoms || !stats_addr || !stats_len)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*num_pwdoms = SCMI_PWD_PROTO_ATTRS_NUM_PWD(out.attributes);
+	*stats_addr = ((u64)out.stats_addr_high << 32) + out.stats_addr_low;
+	*stats_len = out.stats_len;
+
+	return 0;
+}
+
+int scmi_pwd_protocol_message_attrs(struct udevice *dev, s32 message_id,
+				    u32 *attributes)
+{
+	struct scmi_pwd_protocol_msg_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_POWER_DOMAIN,
+		.message_id = SCMI_PROTOCOL_MESSAGE_ATTRIBUTES,
+		.in_msg = (u8 *)&message_id,
+		.in_msg_sz = sizeof(message_id),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !attributes)
+		return -EINVAL;
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
+int scmi_pwd_attrs(struct udevice *dev, u32 domain_id, u32 *attributes,
+		   u8 **name)
+{
+	struct scmi_pwd_attrs_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_POWER_DOMAIN,
+		.message_id = SCMI_PWD_ATTRIBUTES,
+		.in_msg = (u8 *)&domain_id,
+		.in_msg_sz = sizeof(domain_id),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !attributes || !name)
+		return -EINVAL;
+
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
+	*attributes = out.attributes;
+
+	return 0;
+}
+
+int scmi_pwd_state_set(struct udevice *dev, u32 flags, u32 domain_id,
+		       u32 pstate)
+{
+	struct scmi_pwd_state_set_in in;
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_POWER_DOMAIN,
+		.message_id = SCMI_PWD_STATE_SET,
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
+	in.flags = flags;
+	in.domain_id = domain_id;
+	in.pstate = pstate;
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+int scmi_pwd_state_get(struct udevice *dev, u32 domain_id, u32 *pstate)
+{
+	struct scmi_pwd_state_get_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_POWER_DOMAIN,
+		.message_id = SCMI_PWD_STATE_GET,
+		.in_msg = (u8 *)&domain_id,
+		.in_msg_sz = sizeof(domain_id),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !pstate)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*pstate = out.pstate;
+
+	return 0;
+}
+
+int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name)
+{
+	struct scmi_pwd_name_get_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_POWER_DOMAIN,
+		.message_id = SCMI_PWD_NAME_GET,
+		.in_msg = (u8 *)&domain_id,
+		.in_msg_sz = sizeof(domain_id),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !name)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*name = strdup(out.extended_name);
+	if (!*name)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ee551b38deb4..9e0ba26f8632 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -400,6 +400,184 @@ int scmi_base_reset_agent_configuration(struct udevice *dev, u32 agent_id,
 int scmi_generic_protocol_version(struct udevice *dev,
 				  enum scmi_std_protocol id, u32 *version);
 
+/*
+ * SCMI Power Domain Management Protocol
+ */
+
+#define SCMI_PWD_PROTOCOL_VERSION 0x30000
+#define SCMI_PWD_PSTATE_TYPE_LOST BIT(30)
+#define SCMI_PWD_PSTATE_ID GENMASK(27, 0)
+
+enum scmi_power_domain_message_id {
+	SCMI_PWD_ATTRIBUTES = 0x3,
+	SCMI_PWD_STATE_SET = 0x4,
+	SCMI_PWD_STATE_GET = 0x5,
+	SCMI_PWD_STATE_NOTIFY = 0x6,
+	SCMI_PWD_STATE_CHANGE_REQUESTED_NOTIFY = 0x7,
+	SCMI_PWD_NAME_GET = 0x8,
+};
+
+/**
+ * struct scmi_pwd_protocol_attrs_out
+ * @status:		SCMI command status
+ * @attributes:		Protocol attributes
+ * @stats_addr_low:	Lower 32 bits of address of statistics memory region
+ * @stats_addr_high:	Higher 32 bits of address of statistics memory region
+ * @stats_len:		Length of statistics memory region
+ */
+struct scmi_pwd_protocol_attrs_out {
+	s32 status;
+	u32 attributes;
+	u32 stats_addr_low;
+	u32 stats_addr_high;
+	u32 stats_len;
+};
+
+#define SCMI_PWD_PROTO_ATTRS_NUM_PWD(attributes) ((attributes) & GENMASK(15, 0))
+
+/**
+ * struct scmi_pwd_protocol_msg_attrs_out
+ * @status:		SCMI command status
+ * @attributes:		Message-specific attributes
+ */
+struct scmi_pwd_protocol_msg_attrs_out {
+	s32 status;
+	u32 attributes;
+};
+
+#define SCMI_PWD_NAME_LENGTH_MAX 16
+
+/**
+ * struct scmi_pwd_attrs_out
+ * @status:	SCMI command status
+ * @attributes:	Power domain attributes
+ * @name:	Name of power domain
+ */
+struct scmi_pwd_attrs_out {
+	s32 status;
+	u32 attributes;
+	u8 name[SCMI_PWD_NAME_LENGTH_MAX];
+};
+
+#define SCMI_PWD_ATTR_PSTATE_CHANGE_NOTIFY	BIT(31)
+#define SCMI_PWD_ATTR_PSTATE_ASYNC		BIT(30)
+#define SCMI_PWD_ATTR_PSTATE_SYNC		BIT(29)
+#define SCMI_PWD_ATTR_PSTATE_CHANGE_RQ_NOTIFY	BIT(28)
+#define SCMI_PWD_ATTR_EXTENDED_NAME		BIT(27)
+
+/**
+ * struct scmi_pwd_state_set_in
+ * @flags:	Flags
+ * @domain_id:	Identifier of power domain
+ * @pstate:	Power state of the domain
+ */
+struct scmi_pwd_state_set_in {
+	u32 flags;
+	u32 domain_id;
+	u32 pstate;
+};
+
+#define SCMI_PWD_SET_FLAGS_ASYNC BIT(0)
+
+/**
+ * struct scmi_pwd_state_get_out
+ * @status:	SCMI command status
+ * @pstate:	Power state of the domain
+ */
+struct scmi_pwd_state_get_out {
+	s32 status;
+	u32 pstate;
+};
+
+#define SCMI_PWD_EXTENDED_NAME_MAX 64
+/**
+ * struct scmi_pwd_name_get_out
+ * @status:		SCMI command status
+ * @flags:		Parameter flags
+ * @extended_name:	Extended name of power domain
+ */
+struct scmi_pwd_name_get_out {
+	s32 status;
+	u32 flags;
+	u8 extended_name[SCMI_PWD_EXTENDED_NAME_MAX];
+};
+
+/**
+ * scmi_pwd_protocol_attrs - get protocol attributes
+ * @dev:	SCMI protocol device
+ * @num_pwdoms:	Number of power domains
+ * @stats_addr:	Address of statistics memory region
+ * @stats_len:	Length of statistics memory region
+ *
+ * Obtain the protocol attributes, the number of power domains and
+ * the information of statistics memory region.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pwd_protocol_attrs(struct udevice *dev, int *num_pwdoms,
+			    u64 *stats_addr, size_t *stats_len);
+/**
+ * scmi_pwd_protocol_message_attrs - get message-specific attributes
+ * @dev:		SCMI protocol device
+ * @message_id:		SCMI message ID
+ * @attributes:		Message-specific attributes
+ *
+ * Obtain the message-specific attributes in @attributes.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pwd_protocol_message_attrs(struct udevice *dev, s32 message_id,
+				    u32 *attributes);
+/**
+ * scmi_pwd_attrs - get power domain attributes
+ * @dev:	SCMI protocol device
+ * @domain_id:	Identifier of power domain
+ * @attributes:	Power domain attributes
+ * @name:	Name of power domain
+ *
+ * Obtain the attributes of the given power domain, @domain_id, in @attributes
+ * as well as its name in @name.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pwd_attrs(struct udevice *dev, u32 message_id, u32 *attributes,
+		   u8 **name);
+/**
+ * scmi_pwd_state_set - set power state
+ * @dev:	SCMI protocol device
+ * @flags:	Parameter flags
+ * @domain_id:	Identifier of power domain
+ * @pstate:	Power state
+ *
+ * Change the power state of the given power domain, @domain_id.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pwd_state_set(struct udevice *dev, u32 flags, u32 domain_id,
+		       u32 pstate);
+/**
+ * scmi_pwd_state_get - get power state
+ * @dev:	SCMI protocol device
+ * @domain_id:	Identifier of power domain
+ * @pstate:	Power state
+ *
+ * Obtain the power state of the given power domain, @domain_id.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pwd_state_get(struct udevice *dev, u32 domain_id, u32 *pstate);
+/**
+ * scmi_pwd_name_get - get extended name
+ * @dev:	SCMI protocol device
+ * @domain_id:	Identifier of power domain
+ * @name:	Extended name of the domain
+ *
+ * Obtain the extended name of the given power domain, @domain_id, in @name.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
+
 /*
  * SCMI Clock Protocol
  */
-- 
2.34.1

