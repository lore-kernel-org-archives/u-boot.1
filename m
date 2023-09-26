Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4FAE7D240
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A9A86D86;
	Tue, 26 Sep 2023 09:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QGjiPwsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28AD286D8F; Tue, 26 Sep 2023 09:01:13 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD4286D85
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27197b0b733so1448012a91.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711669; x=1696316469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaNu8QTaKyIx4zU9QPEtFNp1K3jnA2Wr0NHrr1NxNT4=;
 b=QGjiPwsyW/MOto8VxZxX6DSqShW8ffq8DivyfIbxoTCXInSk1sEK1uxJgZHqIanut6
 NV7HJN/mxsML5wpeSRUxFGXrnzf08TgrgMtKQvx9Yxz+wufjoD7BJaGy448bvpY7agxc
 EsrrceTo6erbMNc8W7TrnG2OoH2+g52jpb/nwAtGn6J9ON8x8GxxOnADYZXatOPITXEo
 +FWOpGA5oz0H6d6tJkkrifD6a/QAq5upWP58BeWrK7JCrefG+Z4whvsVJ96R7mZ2DAVC
 u2kymt7K4ZgydZ1SHwJ57nnHpw0HyFU71j6EnfTignT1/JDHrZq7SBeqrS8/ahAYmzLY
 cbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711669; x=1696316469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaNu8QTaKyIx4zU9QPEtFNp1K3jnA2Wr0NHrr1NxNT4=;
 b=q4heSGwQ8d6mVav+FEc6Q21jM1jQBlxELE3DVLogAhps49l0KKKUmkb9pb/G6J8EPC
 lf3EygO4Xfl0N5oG3T0jS7k4mFFr80Am+avoqHcStJ1e/UZUzJGcjQ9/1vGXV31R8uxc
 qFgRs69KY1SbsR/8kgQQjmQ5RuNG+H1NBdRN+IDL1uSJ00YQI3WStT6io9DDnWtllTOW
 elpaBtDKVjRwGmbCgs540Z2jEgTip2JfwDccibquPmT86uJuDt/h8EvqaZshkBGWbN+a
 v4UJwXlFxmV5Vi5nym4W+zQhAAi+4R0yyYzJSJ9zoR7YQOATJ6mjW85LaPpvZsO+FMQS
 N0Eg==
X-Gm-Message-State: AOJu0Yxv8/KTyxuRnJl+1W21IsPoigvVUdGv20Zq1uhy0J6gxV4FDNh2
 Gx+hTmOFcHN4ZTf9RVHxyX7YJQ==
X-Google-Smtp-Source: AGHT+IGPsi6WREHv7Zg2qlduXI9Md+CVo1g90DhrqaGbvzIT7A1ZrJ5wRMugJrwisI4ux/LpsIqg6g==
X-Received: by 2002:a17:90a:bc9:b0:268:38a7:842e with SMTP id
 x9-20020a17090a0bc900b0026838a7842emr7876358pjd.2.1695711668936; 
 Tue, 26 Sep 2023 00:01:08 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b0027758c7f585sm3178480pjb.52.2023.09.26.00.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 00:01:08 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 3/4] sandbox: add SCMI power domain protocol support for
 testing
Date: Tue, 26 Sep 2023 16:00:42 +0900
Message-Id: <20230926070043.738340-4-takahiro.akashi@linaro.org>
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

SCMI power domain management protocol is supported on sandbox
for test purpose. Add fake agent interfaces and associated
power domain devices.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/sandbox/dts/test.dts                    |   6 +
 arch/sandbox/include/asm/scmi_test.h         |  20 ++
 configs/sandbox_defconfig                    |   1 +
 drivers/firmware/scmi/sandbox-scmi_agent.c   | 265 ++++++++++++++++++-
 drivers/firmware/scmi/sandbox-scmi_devices.c |  10 +
 5 files changed, 301 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 36de6a37cf6d..38fcf42cd23d 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -693,6 +693,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			pwrdom_scmi: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
 			clk_scmi: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
@@ -1589,6 +1594,7 @@
 
 	sandbox_scmi {
 		compatible = "sandbox,scmi-devices";
+		power-domains = <&pwrdom_scmi 2>;
 		clocks = <&clk_scmi 2>, <&clk_scmi 0>;
 		resets = <&reset_scmi 3>;
 		regul0-supply = <&regul0_scmi>;
diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index ccb0df6c148f..1b0f4464b98f 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -6,10 +6,21 @@
 #ifndef __SANDBOX_SCMI_TEST_H
 #define __SANDBOX_SCMI_TEST_H
 
+#include <power-domain.h>
+
 struct udevice;
 struct sandbox_scmi_agent;
 struct sandbox_scmi_service;
 
+/**
+ * struct sandbox_scmi_pwd
+ * @id:		Identifier of the power domain used in the SCMI protocol
+ */
+struct sandbox_scmi_pwd {
+	uint id;
+	u32 pstate;
+};
+
 /**
  * struct sandbox_scmi_clk - Simulated clock exposed by SCMI
  * @id:		Identifier of the clock used in the SCMI protocol
@@ -45,6 +56,8 @@ struct sandbox_scmi_voltd {
 
 /**
  * struct sandbox_scmi_agent - Simulated SCMI service seen by SCMI agent
+ * @pwdom_version: Implemented power domain protocol version
+ * @pwdom_count:   Simulated power domains array size
  * @clk:	Simulated clocks
  * @clk_count:	Simulated clocks array size
  * @reset:	Simulated reset domains
@@ -53,6 +66,9 @@ struct sandbox_scmi_voltd {
  * @voltd_count: Simulated voltage domains array size
  */
 struct sandbox_scmi_agent {
+	int pwdom_version;
+	struct sandbox_scmi_pwd *pwdom;
+	size_t pwdom_count;
 	struct sandbox_scmi_clk *clk;
 	size_t clk_count;
 	struct sandbox_scmi_reset *reset;
@@ -71,6 +87,8 @@ struct sandbox_scmi_service {
 
 /**
  * struct sandbox_scmi_devices - Reference to devices probed through SCMI
+ * @pwdom:		Array of power domains
+ * @pwdom_count:	Number of power domains probed
  * @clk:		Array the clock devices
  * @clk_count:		Number of clock devices probed
  * @reset:		Array the reset controller devices
@@ -79,6 +97,8 @@ struct sandbox_scmi_service {
  * @regul_count:	Number of regulator devices probed
  */
 struct sandbox_scmi_devices {
+	struct power_domain *pwdom;
+	size_t pwdom_count;
 	struct clk *clk;
 	size_t clk_count;
 	struct reset_ctl *reset;
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 3906476bb4fc..b0a72e63f7da 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -241,6 +241,7 @@ CONFIG_PINCTRL_SANDBOX=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SANDBOX_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_ACT8846=y
 CONFIG_DM_PMIC_PFUZE100=y
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index eb567dd900d7..9f5f497e0a6c 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -43,6 +43,8 @@
 #define SANDBOX_SCMI_AGENT_NAME "OSPM"
 #define SANDBOX_SCMI_PLATFORM_NAME "platform"
 
+#define SANDBOX_SCMI_PWD_PROTOCOL_VERSION SCMI_PWD_PROTOCOL_VERSION
+
 /**
  * struct sandbox_channel - Description of sandbox transport
  * @channel_id:		Channel identifier
@@ -64,6 +66,7 @@ struct scmi_channel {
 };
 
 static u8 protocols[] = {
+	SCMI_PROTOCOL_ID_POWER_DOMAIN,
 	SCMI_PROTOCOL_ID_CLOCK,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
@@ -71,6 +74,12 @@ static u8 protocols[] = {
 
 #define NUM_PROTOCOLS ARRAY_SIZE(protocols)
 
+static struct sandbox_scmi_pwd scmi_pwdom[] = {
+	{ .id = 0 },
+	{ .id = 1 },
+	{ .id = 2 },
+};
+
 static struct sandbox_scmi_clk scmi_clk[] = {
 	{ .rate = 333 },
 	{ .rate = 200 },
@@ -458,6 +467,238 @@ static int sandbox_scmi_base_reset_agent_configuration(struct udevice *dev,
 	return 0;
 }
 
+/* Power Domain Management Protocol */
+
+/**
+ * sandbox_scmi_pwd_protocol_version - implement SCMI_PROTOCOL_VERSION
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_PROTOCOL_VERSION command.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int sandbox_scmi_pwd_protocol_version(struct udevice *dev,
+					     struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = SANDBOX_SCMI_PWD_PROTOCOL_VERSION;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_pwd_protocol_attribs - implement SCMI_PWD_PROTOCOL_ATTRS
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_PWD_PROTOCOL_ATTRS command.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int sandbox_scmi_pwd_protocol_attribs(struct udevice *dev,
+					     struct scmi_msg *msg)
+{
+	struct scmi_pwd_protocol_attrs_out *out;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_pwd_protocol_attrs_out *)msg->out_msg;
+
+	out->attributes = ARRAY_SIZE(scmi_pwdom);
+	out->stats_addr_low = 0;
+	out->stats_addr_high = 0;
+	out->stats_len = 0;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_pwd_protocol_msg_attribs - implement
+					SCMI_PWD_PROTOCOL_MESSAGE_ATTRS
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_PWD_PROTOCOL_MESSAGE_ATTRS command.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int sandbox_scmi_pwd_protocol_msg_attribs(struct udevice *dev,
+						 struct scmi_msg *msg)
+{
+	u32 message_id;
+	struct scmi_pwd_protocol_msg_attrs_out *out;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(message_id) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	message_id = *(u32 *)msg->in_msg;
+
+	out = (struct scmi_pwd_protocol_msg_attrs_out *)msg->out_msg;
+	if (message_id <= SCMI_PWD_STATE_GET ||
+	    message_id == SCMI_PWD_NAME_GET) {
+		out->attributes = 0;
+		out->status = SCMI_SUCCESS;
+	} else {
+		out->status = SCMI_NOT_FOUND;
+	}
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_pwd_attribs - implement SCMI_PWD_ATTRS
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_PWD_ATTRS command.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int sandbox_scmi_pwd_attribs(struct udevice *dev, struct scmi_msg *msg)
+{
+	u32 domain_id;
+	struct scmi_pwd_attrs_out *out;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(domain_id) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	domain_id = *(u32 *)msg->in_msg;
+	out = (struct scmi_pwd_attrs_out *)msg->out_msg;
+
+	if (domain_id > ARRAY_SIZE(scmi_pwdom)) {
+		out->status = SCMI_NOT_FOUND;
+
+		return 0;
+	}
+
+	out->attributes =
+		SCMI_PWD_ATTR_PSTATE_SYNC | SCMI_PWD_ATTR_EXTENDED_NAME;
+	/* just 15-char + NULL */
+	snprintf(out->name, SCMI_PWD_NAME_LENGTH_MAX, "power-domain--%d",
+		 domain_id);
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_pwd_state_set - implement SCMI_PWD_STATE_SET
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_PWD_STATE_SET command.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int sandbox_scmi_pwd_state_set(struct udevice *dev, struct scmi_msg *msg)
+{
+	struct scmi_pwd_state_set_in *in;
+	s32 *status;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_pwd_state_set_in *)msg->in_msg;
+	status = (s32 *)msg->out_msg;
+
+	if (in->domain_id > ARRAY_SIZE(scmi_pwdom)) {
+		*status = SCMI_NOT_FOUND;
+
+		return 0;
+	}
+
+	if ((in->flags & SCMI_PWD_SET_FLAGS_ASYNC) ||
+	    (in->pstate != SCMI_PWD_PSTATE_TYPE_LOST && in->pstate)) {
+		*status = SCMI_INVALID_PARAMETERS;
+
+		return 0;
+	}
+
+	scmi_pwdom[in->domain_id].pstate = in->pstate;
+	*status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_pwd_state_get - implement SCMI_PWD_STATE_GET
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_PWD_STATE_GET command.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int sandbox_scmi_pwd_state_get(struct udevice *dev, struct scmi_msg *msg)
+{
+	u32 domain_id;
+	struct scmi_pwd_state_get_out *out;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(domain_id) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	domain_id = *(u32 *)msg->in_msg;
+	out = (struct scmi_pwd_state_get_out *)msg->out_msg;
+
+	if (domain_id > ARRAY_SIZE(scmi_pwdom)) {
+		out->status = SCMI_NOT_FOUND;
+
+		return 0;
+	}
+
+	out->pstate = scmi_pwdom[domain_id].pstate;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_pwd_name_get - implement SCMI_PWD_NAME_GET
+ * @dev:	SCMI device
+ * @msg:	SCMI message
+ *
+ * Implement SCMI_PWD_NAME_GET command.
+ *
+ * Return:	0 on success, error code on failure
+ */
+static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
+{
+	u32 domain_id;
+	struct scmi_pwd_name_get_out *out;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(domain_id) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	domain_id = *(u32 *)msg->in_msg;
+	out = (struct scmi_pwd_name_get_out *)msg->out_msg;
+
+	if (domain_id > ARRAY_SIZE(scmi_pwdom)) {
+		out->status = SCMI_NOT_FOUND;
+
+		return 0;
+	}
+
+	snprintf(out->extended_name, SCMI_PWD_EXTENDED_NAME_MAX,
+		 "power-domain--%d-extended", domain_id);
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 /* Clock Protocol */
 
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
@@ -918,6 +1159,26 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			break;
 		}
 		break;
+	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
+		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_pwd_protocol_version(dev, msg);
+		case SCMI_PROTOCOL_ATTRIBUTES:
+			return sandbox_scmi_pwd_protocol_attribs(dev, msg);
+		case SCMI_PROTOCOL_MESSAGE_ATTRIBUTES:
+			return sandbox_scmi_pwd_protocol_msg_attribs(dev, msg);
+		case SCMI_PWD_ATTRIBUTES:
+			return sandbox_scmi_pwd_attribs(dev, msg);
+		case SCMI_PWD_STATE_SET:
+			return sandbox_scmi_pwd_state_set(dev, msg);
+		case SCMI_PWD_STATE_GET:
+			return sandbox_scmi_pwd_state_get(dev, msg);
+		case SCMI_PWD_NAME_GET:
+			return sandbox_scmi_pwd_name_get(dev, msg);
+		default:
+			break;
+		}
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		switch (msg->message_id) {
 		case SCMI_PROTOCOL_ATTRIBUTES:
@@ -960,7 +1221,6 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			break;
 		}
 		break;
-	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
 	case SCMI_PROTOCOL_ID_SYSTEM:
 	case SCMI_PROTOCOL_ID_PERF:
 	case SCMI_PROTOCOL_ID_SENSOR:
@@ -993,6 +1253,9 @@ static int sandbox_scmi_test_probe(struct udevice *dev)
 	struct sandbox_scmi_agent *agent = dev_get_priv(dev);
 
 	*agent = (struct sandbox_scmi_agent){
+		.pwdom_version = SANDBOX_SCMI_PWD_PROTOCOL_VERSION,
+		.pwdom = scmi_pwdom,
+		.pwdom_count = ARRAY_SIZE(scmi_pwdom),
 		.clk = scmi_clk,
 		.clk_count = ARRAY_SIZE(scmi_clk),
 		.reset = scmi_reset,
diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
index 9baeb469ec0a..facb5b06ffb5 100644
--- a/drivers/firmware/scmi/sandbox-scmi_devices.c
+++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
@@ -29,12 +29,14 @@
 
 /*
  * struct sandbox_scmi_device_priv - Storage for device handles used by test
+ * @pwdom:		Power domain device
  * @clk:		Array of clock instances used by tests
  * @reset_clt:		Array of the reset controller instances used by tests
  * @regulators:		Array of regulator device references used by the tests
  * @devices:		Resources exposed by sandbox_scmi_devices_ctx()
  */
 struct sandbox_scmi_device_priv {
+	struct power_domain pwdom;
 	struct clk clk[SCMI_TEST_DEVICES_CLK_COUNT];
 	struct reset_ctl reset_ctl[SCMI_TEST_DEVICES_RD_COUNT];
 	struct udevice *regulators[SCMI_TEST_DEVICES_VOLTD_COUNT];
@@ -77,6 +79,8 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
 	size_t n;
 
 	priv->devices = (struct sandbox_scmi_devices){
+		.pwdom = &priv->pwdom,
+		.pwdom_count = 1,
 		.clk = priv->clk,
 		.clk_count = SCMI_TEST_DEVICES_CLK_COUNT,
 		.reset = priv->reset_ctl,
@@ -85,6 +89,12 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
 		.regul_count = SCMI_TEST_DEVICES_VOLTD_COUNT,
 	};
 
+	ret = power_domain_get_by_index(dev, priv->devices.pwdom, 0);
+	if (ret) {
+		dev_err(dev, "%s: Failed on power domain\n", __func__);
+		return ret;
+	}
+
 	for (n = 0; n < SCMI_TEST_DEVICES_CLK_COUNT; n++) {
 		ret = clk_get_by_index(dev, n, priv->devices.clk + n);
 		if (ret) {
-- 
2.34.1

