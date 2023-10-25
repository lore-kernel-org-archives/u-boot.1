Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159E1C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 05:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8215A879E1;
	Wed, 25 Oct 2023 07:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t3F7R5TA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3B8879E5; Wed, 25 Oct 2023 07:15:02 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1656F879EE
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9ba72f6a1so10082195ad.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698210898; x=1698815698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPAlpRoESH8lrGECxp00xcCu19eRpWsI/45A4TwB8Uk=;
 b=t3F7R5TAAi4eeElQS+fYoGltAj2LUermFtc37WZtpsoHSx0psqSFM8sQ8gCt2oVcW4
 ZIR/lzk2A5SQTuBQPUGoXrnyBhY54hj/+SKH/4MQ1VV3G7Co/X1NTuj/bOJkxQKU8o6T
 3Inug3N8FHBcPrXlxNY4FOisNnRd0iKn9chHUP0/8wN6ojEvsyid4N4S4EEPbbznHkNc
 qObMOkRoRdvxvHVJs90wDlH1xFq6kqLdhU9ptUxbTn0LDPo+9weiL//igzUqr7oJh1gl
 w/KX9eY0WFUWyws4+sHX4fFCVzdyflT1oaxxKLwfGPRK9Xm/9fn1sI294SRnzKy1p3Km
 E0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698210898; x=1698815698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPAlpRoESH8lrGECxp00xcCu19eRpWsI/45A4TwB8Uk=;
 b=FR39GuqFtlScq5B/3uTtX3L3D0AEwvN/MNz/U3kmoEKIPIQo7ifbW8ioTAoCFbowiQ
 gRkJJ5Xcte12EfOrbQxuTTCb+wbPbgNlQPMP4yLaPZxEd478RSxxynscJtgQGneyGcxF
 9LKSuuZpbTjdSGJjJehTDB+y2E7nhZeneFXPDpKVoDt2rFabJHqdQon0g9qoYxuLYTFi
 PVXYflLpJYnerpzBBXJvZHOcSVjbZwVQs/iTwWuzTUHpZYcU8iR+QqfdPCGZ0sxNWVps
 oY7GiOpccpkO4mmk3Tkq2/jW/FfA5+oDqKuIj2ImkNr14vBhYpTzLKcHqvsiEPp34vDT
 PpgQ==
X-Gm-Message-State: AOJu0YxSFsxZ5df7He82pqSBYvwnkn3sevQwH/n9QFd8bxhGw+oPhmlw
 bPJLicdwghub3Czpjku1QfBZID5QZbjBCfsplUJZVQ==
X-Google-Smtp-Source: AGHT+IEOmIPDmpA+0SayRWeEPFSkIZZNVdONOLywvijK/0FUbLQR0Dr6qA3pQGrCiO0CkhjzUgJM+A==
X-Received: by 2002:a17:90b:4b8f:b0:27c:f653:37b2 with SMTP id
 lr15-20020a17090b4b8f00b0027cf65337b2mr16464672pjb.1.1698210898333; 
 Tue, 24 Oct 2023 22:14:58 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:65fc:df7c:6edb:619f])
 by smtp.gmail.com with ESMTPSA id
 fz3-20020a17090b024300b002609cadc56esm7715815pjb.11.2023.10.24.22.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 22:14:58 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 2/5] firmware: scmi: support protocols on sandbox only if
 enabled
Date: Wed, 25 Oct 2023 14:14:24 +0900
Message-Id: <20231025051427.509602-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025051427.509602-1-takahiro.akashi@linaro.org>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
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
 drivers/firmware/scmi/sandbox-scmi_agent.c   | 27 ++++++-
 drivers/firmware/scmi/sandbox-scmi_devices.c | 78 ++++++++++++--------
 2 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 9f5f497e0a6c..e1b9b5f5f2d8 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -66,10 +66,18 @@ struct scmi_channel {
 };
 
 static u8 protocols[] = {
+#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
 	SCMI_PROTOCOL_ID_POWER_DOMAIN,
+#endif
+#if IS_ENABLED(CONFIG_CLK_SCMI)
 	SCMI_PROTOCOL_ID_CLOCK,
+#endif
+#if IS_ENABLED(CONFIG_RESET_SCMI)
 	SCMI_PROTOCOL_ID_RESET_DOMAIN,
+#endif
+#if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
+#endif
 };
 
 #define NUM_PROTOCOLS ARRAY_SIZE(protocols)
@@ -1160,6 +1168,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
+		if (!IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
+			goto not_supported;
+
 		switch (msg->message_id) {
 		case SCMI_PROTOCOL_VERSION:
 			return sandbox_scmi_pwd_protocol_version(dev, msg);
@@ -1180,6 +1191,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
+		if (!IS_ENABLED(CONFIG_CLK_SCMI))
+			goto not_supported;
+
 		switch (msg->message_id) {
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
@@ -1196,6 +1210,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
+		if (!IS_ENABLED(CONFIG_RESET_SCMI))
+			goto not_supported;
+
 		switch (msg->message_id) {
 		case SCMI_RESET_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_rd_attribs(dev, msg);
@@ -1206,6 +1223,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		}
 		break;
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
+		if (!IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
+			goto not_supported;
+
 		switch (msg->message_id) {
 		case SCMI_VOLTAGE_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_voltd_attribs(dev, msg);
@@ -1224,8 +1244,7 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_SYSTEM:
 	case SCMI_PROTOCOL_ID_PERF:
 	case SCMI_PROTOCOL_ID_SENSOR:
-		*(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
-		return 0;
+		goto not_supported;
 	default:
 		break;
 	}
@@ -1239,6 +1258,10 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 	/* Intentionnaly report unhandled IDs through the SCMI return code */
 	*(u32 *)msg->out_msg = SCMI_PROTOCOL_ERROR;
 	return 0;
+
+not_supported:
+	*(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
+	return 0;
 }
 
 static int sandbox_scmi_test_remove(struct udevice *dev)
diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
index facb5b06ffb5..0519cf889aa9 100644
--- a/drivers/firmware/scmi/sandbox-scmi_devices.c
+++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
@@ -62,12 +62,13 @@ static int sandbox_scmi_devices_remove(struct udevice *dev)
 	if (!devices)
 		return 0;
 
-	for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
-		int ret2 = reset_free(devices->reset + n);
+	if (IS_ENABLED(CONFIG_RESET_SCMI))
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
+	if (IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)) {
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
+	if (IS_ENABLED(CONFIG_CLK_SCMI)) {
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
+	if (IS_ENABLED(CONFIG_RESET_SCMI)) {
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
+	if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {
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
+	if (IS_ENABLED(CONFIG_RESET_SCMI))
+		for (; n > 0; n--)
+			reset_free(priv->devices.reset + n - 1);
 
 	return ret;
 }
-- 
2.34.1

