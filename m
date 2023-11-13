Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBE1C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 01:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75C386FF4;
	Mon, 13 Nov 2023 02:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n+S/v56H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439708703A; Mon, 13 Nov 2023 02:49:38 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 795BF86FF4
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 02:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2d9a9c824so473430b6e.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699840174; x=1700444974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3LRUUtYLKxzsp79cf17RY7bCQAiYMEVXLHLxjAU95k=;
 b=n+S/v56H0+9/5ABnvmz+VIjU6qpu+xyYl9WcQMaUfwO5QHqWToQnyW7IBLXBj1CPEq
 RwtdJ/k5/aw0u2zzWKEQuwcWKX9ETGMUFD6No4fVzndwYbS6qpl7sznJM2McB26bgK9r
 9TYCm/RsTteSR9rGPLnXGWdLcGh4IZK7FtbJONsf3RplOYWonMumnd0npeyL/0GtGb5R
 xh37KqxPyrpuY8dlY5n0OxEMCkpMxCL+jKLJLUZNOUyYPV/DceA5KolpfogH52LxU+pz
 tN+uSP7i7WVNMK5FJbGUKuj9MAccAFj3zbKftQuP+0VbmXjwId9nEx+KSu/CO5oFtbZO
 7oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699840174; x=1700444974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3LRUUtYLKxzsp79cf17RY7bCQAiYMEVXLHLxjAU95k=;
 b=JwqpNsSOMAUasd+hIfocmXLnfLmLF3o+h/0q+3WHZei7WHWx6gNFn4aIY5tXlE1K89
 Pq0vdX8ejoLhrZisTIc5A5eGD4ygva3+DS29nzC+jOkW6oe7p8D7qDL5tgWOy85cK/cN
 G6nZyjIrMn3NsAEjvcUohCs0wxO2AeqLgroVjRLVPrrbigYBvKSW2E7Rm5NAQ864k/5g
 M37vwZd357QwAK3UAtpQD4CErzEwVK+VA7lOEHYJd9+LOZQM72Hdf8BhEzlUmA8mwdVt
 bZ6+om54BL3QxZqeBVCL4v0fF5TWNfgdlPBq8JLGjcwjbwObphb347WGboVa69uy8Iby
 RiJg==
X-Gm-Message-State: AOJu0YwNXCdTMxRNVLSYFo30xa5vpVY1o6pACVF50cONnNDgi2HLPFIi
 fJExiEmnr8DTz1jZNIrSpK/SYZoaq5MPFX+Blpjbjg==
X-Google-Smtp-Source: AGHT+IFnBhPpTwyeJjT7sWLDugBRScBJHuuRq0lEugZqYBA7BMHxrfSscomoJHg0qxmxc7+k4+MQdA==
X-Received: by 2002:a05:6870:2888:b0:1e9:e605:27a1 with SMTP id
 gy8-20020a056870288800b001e9e60527a1mr6242870oab.2.1699840174001; 
 Sun, 12 Nov 2023 17:49:34 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:ba59:509b:48bc:9f1])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a65644e000000b005b92e60cf57sm2635549pgv.56.2023.11.12.17.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:49:33 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 2/5] firmware: scmi: support protocols on sandbox only if
 enabled
Date: Mon, 13 Nov 2023 10:49:08 +0900
Message-Id: <20231113014911.3308990-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
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
index d13180962662..1fc9a0f4ea7e 100644
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

