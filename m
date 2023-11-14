Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE30AC4167B
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 02:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264C9871AB;
	Tue, 14 Nov 2023 03:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wx/B11Xo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6B5870F6; Tue, 14 Nov 2023 03:14:51 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B13E87183
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 03:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc4d306fe9so8109475ad.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 18:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699928088; x=1700532888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzrl0Keos0SLcEaLtLMYI7oJd1R9TXvnv53DOnHM4r0=;
 b=Wx/B11Xo7R+FbrJwF5anVBIkpMSsuFR58d/7ymoXd+X7O4d1mNiqsssJUb/m6EkBQn
 HU2rTR8iPCq7tfaaa19RbJd4We65oZTC56xfZQbmU6qeowqcSICX67VKGPZNLQe5ZuQt
 XMXA+VHMEAmrzG7CqHOav3L7WJKahHJkJ49h4HLtv8T8WUtIkZJc73u1LO84YcF3Pt4B
 mQH89imrC/vlRP797WOM5LsXvgbCjpckeK+9GButv0/TXVFO/mNmBsooQ6b9jgv2tZ6p
 ex0RLJ8kIUj0yVo3ZANYl9Kxc2wCnvLNc0S8Zd5TJ0opwk1mJxFwCNQq3ZNuqwvJdzZj
 rIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699928088; x=1700532888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzrl0Keos0SLcEaLtLMYI7oJd1R9TXvnv53DOnHM4r0=;
 b=vssCtr105P6hpBDOMemiv4b9kxlTRdPPE0Mk1t8DyZJAIxvR3/bD0uGKnbcmFieZqq
 NRBxfyQa4G4bhPqTuTHkiQVqK9mwsS5jZnfyzeO52gBDLPavApJL7UiWENWQPNyDY5Vp
 HdIuGkx5EqEP9ogIvsIYpnn1AxcHXWTYBYSt6j+R36skvPctIiyZz50SAFucCfU9kj8M
 3oPHKryvHGKpwSfq891PBvQaETWOE3DRJ2obQuLQ5IpxG3emgUl2Mi3FJBpQwe/Dmum3
 XW/uX8oaoJirTfDY8J53jBTBmE5EqUTRZ9AcEjQ8l5smLIqB8uxjNXq8yO0zkrfhzuiD
 JofQ==
X-Gm-Message-State: AOJu0YwX3vIPRmLkNU79Kx4ayNcKhitpODBdJumSH/WCXfQey5ISczwK
 u9QnSVqiN0Dfr5bzL371WhNTEqcHBJRmuvm04lOK1w==
X-Google-Smtp-Source: AGHT+IEkex8scI9hPtHtzAY7023ZqXTbmadG+HFgi2tKsfyARrAwiJjHcDjUQ5Qg5iK09qY/jN+GKw==
X-Received: by 2002:a17:902:ce92:b0:1cc:2ba2:55f4 with SMTP id
 f18-20020a170902ce9200b001cc2ba255f4mr1204312plg.0.1699928087682; 
 Mon, 13 Nov 2023 18:14:47 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a170902c94400b001c61afa7009sm4680475pla.114.2023.11.13.18.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 18:14:47 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 2/5] firmware: scmi: support protocols on sandbox only if
 enabled
Date: Tue, 14 Nov 2023 11:14:25 +0900
Message-Id: <20231114021428.531887-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114021428.531887-1-takahiro.akashi@linaro.org>
References: <20231114021428.531887-1-takahiro.akashi@linaro.org>
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

This change will be useful when we manually test SCMI on sandbox
by enabling/disabling a specific SCMI protocol.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v9
* use CONFIG_IS_ENABLED() rather than IS_ENABLED()
* remove goto by introducing a not_supported() function
---
 drivers/firmware/scmi/sandbox-scmi_agent.c   | 30 ++++++--
 drivers/firmware/scmi/sandbox-scmi_devices.c | 78 ++++++++++++--------
 2 files changed, 71 insertions(+), 37 deletions(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index d13180962662..cc9011c7312f 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -66,10 +66,10 @@ struct scmi_channel {
 };
 
 static u8 protocols[] = {
-	SCMI_PROTOCOL_ID_POWER_DOMAIN,
-	SCMI_PROTOCOL_ID_CLOCK,
-	SCMI_PROTOCOL_ID_RESET_DOMAIN,
-	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
+	CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN, (SCMI_PROTOCOL_ID_POWER_DOMAIN,))
+	CONFIG_IS_ENABLED(CLK_SCMI, (SCMI_PROTOCOL_ID_CLOCK,))
+	CONFIG_IS_ENABLED(RESET_SCMI, (SCMI_PROTOCOL_ID_RESET_DOMAIN,))
+	CONFIG_IS_ENABLED(DM_REGULATOR_SCMI, (SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,))
 };
 
 #define NUM_PROTOCOLS ARRAY_SIZE(protocols)
@@ -1124,6 +1124,13 @@ unsigned int sandbox_scmi_channel_id(struct udevice *dev)
 	return chan->channel_id;
 }
 
+static int sandbox_proto_not_supported(struct scmi_msg *msg)
+{
+	*(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
+
+	return 0;
+}
+
 static int sandbox_scmi_test_process_msg(struct udevice *dev,
 					 struct scmi_channel *channel,
 					 struct scmi_msg *msg)
@@ -1160,6 +1167,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
+		if (!CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN))
+			return sandbox_proto_not_supported(msg);
+
 		switch (msg->message_id) {
 		case SCMI_PROTOCOL_VERSION:
 			return sandbox_scmi_pwd_protocol_version(dev, msg);
@@ -1180,6 +1190,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
+		if (!CONFIG_IS_ENABLED(CLK_SCMI))
+			return sandbox_proto_not_supported(msg);
+
 		switch (msg->message_id) {
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
@@ -1196,6 +1209,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
+		if (!CONFIG_IS_ENABLED(RESET_SCMI))
+			return sandbox_proto_not_supported(msg);
+
 		switch (msg->message_id) {
 		case SCMI_RESET_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_rd_attribs(dev, msg);
@@ -1206,6 +1222,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
+		if (!CONFIG_IS_ENABLED(DM_REGULATOR_SCMI))
+			return sandbox_proto_not_supported(msg);
+
 		switch (msg->message_id) {
 		case SCMI_VOLTAGE_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_voltd_attribs(dev, msg);
@@ -1224,8 +1243,7 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_SYSTEM:
 	case SCMI_PROTOCOL_ID_PERF:
 	case SCMI_PROTOCOL_ID_SENSOR:
-		*(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
-		return 0;
+		return sandbox_proto_not_supported(msg);
 	default:
 		break;
 	}
diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
index facb5b06ffb5..603e2bb40aff 100644
--- a/drivers/firmware/scmi/sandbox-scmi_devices.c
+++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
@@ -62,12 +62,13 @@ static int sandbox_scmi_devices_remove(struct udevice *dev)
 	if (!devices)
 		return 0;
 
-	for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
-		int ret2 = reset_free(devices->reset + n);
+	if (CONFIG_IS_ENABLED(RESET_SCMI))
+		for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
+			int ret2 = reset_free(devices->reset + n);
 
-		if (ret2 && !ret)
-			ret = ret2;
-	}
+			if (ret2 && !ret)
+				ret = ret2;
+		}
 
 	return ret;
 }
@@ -89,39 +90,53 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
 		.regul_count = SCMI_TEST_DEVICES_VOLTD_COUNT,
 	};
 
-	ret = power_domain_get_by_index(dev, priv->devices.pwdom, 0);
-	if (ret) {
-		dev_err(dev, "%s: Failed on power domain\n", __func__);
-		return ret;
-	}
-
-	for (n = 0; n < SCMI_TEST_DEVICES_CLK_COUNT; n++) {
-		ret = clk_get_by_index(dev, n, priv->devices.clk + n);
+	if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN)) {
+		ret = power_domain_get_by_index(dev, priv->devices.pwdom, 0);
 		if (ret) {
-			dev_err(dev, "%s: Failed on clk %zu\n", __func__, n);
+			dev_err(dev, "%s: Failed on power domain\n", __func__);
 			return ret;
 		}
 	}
 
-	for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
-		ret = reset_get_by_index(dev, n, priv->devices.reset + n);
-		if (ret) {
-			dev_err(dev, "%s: Failed on reset %zu\n", __func__, n);
-			goto err_reset;
+	if (CONFIG_IS_ENABLED(CLK_SCMI)) {
+		for (n = 0; n < SCMI_TEST_DEVICES_CLK_COUNT; n++) {
+			ret = clk_get_by_index(dev, n, priv->devices.clk + n);
+			if (ret) {
+				dev_err(dev, "%s: Failed on clk %zu\n",
+					__func__, n);
+				return ret;
+			}
 		}
 	}
 
-	for (n = 0; n < SCMI_TEST_DEVICES_VOLTD_COUNT; n++) {
-		char name[32];
-
-		ret = snprintf(name, sizeof(name), "regul%zu-supply", n);
-		assert(ret >= 0 && ret < sizeof(name));
+	if (CONFIG_IS_ENABLED(RESET_SCMI)) {
+		for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
+			ret = reset_get_by_index(dev, n,
+						 priv->devices.reset + n);
+			if (ret) {
+				dev_err(dev, "%s: Failed on reset %zu\n",
+					__func__, n);
+				goto err_reset;
+			}
+		}
+	}
 
-		ret = device_get_supply_regulator(dev, name,
-						  priv->devices.regul + n);
-		if (ret) {
-			dev_err(dev, "%s: Failed on voltd %zu\n", __func__, n);
-			goto err_regul;
+	if (CONFIG_IS_ENABLED(DM_REGULATOR_SCMI)) {
+		for (n = 0; n < SCMI_TEST_DEVICES_VOLTD_COUNT; n++) {
+			char name[32];
+
+			ret = snprintf(name, sizeof(name), "regul%zu-supply",
+				       n);
+			assert(ret >= 0 && ret < sizeof(name));
+
+			ret = device_get_supply_regulator(dev, name,
+							  priv->devices.regul
+								+ n);
+			if (ret) {
+				dev_err(dev, "%s: Failed on voltd %zu\n",
+					__func__, n);
+				goto err_regul;
+			}
 		}
 	}
 
@@ -130,8 +145,9 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
 err_regul:
 	n = SCMI_TEST_DEVICES_RD_COUNT;
 err_reset:
-	for (; n > 0; n--)
-		reset_free(priv->devices.reset + n - 1);
+	if (CONFIG_IS_ENABLED(RESET_SCMI))
+		for (; n > 0; n--)
+			reset_free(priv->devices.reset + n - 1);
 
 	return ret;
 }
-- 
2.34.1

