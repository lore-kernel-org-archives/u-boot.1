Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE7ECD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7948848E;
	Fri,  5 Apr 2024 10:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BPf61OGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011FC88484; Fri,  5 Apr 2024 10:15:19 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4628A88432
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4156a29ff70so14282275e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712304916; x=1712909716; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XNw7H4h9tBIJdMkPNkN8fruVLcAsQdsm8koqfKOZADk=;
 b=BPf61OGkAlYtKZ9ropaWe11wHygy5Q5Tg395f3AM/sMMKHPccsxN/WXqOfU9Ulw0sE
 r7eHAjuwOC2Ga0oe3N+Vss1jC4+UYx72tQ0C3pgf/2jdMrLU3KcU31Ecl/x3ChKt0Rdr
 aUWsBl9SKmwEp71iY7MNGVHeGYB/MRoE2aNT4gPTElg8CotRqsCzD/s0L8ANKHI9Rrvw
 ZAX7EgDuCjUgGfhuRu4C9W8Z4oNC2+aVPhDSqRbDiE7lZLpAgdttL733UqnJFPtK7CzO
 Z98C9a9AnYEwpvKSZ5sUKNcdVVeh5sCIYCU7XkgDInVJud/HwbaIWVrth2JkUE7Wex3Y
 DfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712304916; x=1712909716;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNw7H4h9tBIJdMkPNkN8fruVLcAsQdsm8koqfKOZADk=;
 b=c2KDIfeG6wC1jNiIqBtAb3W+/VxSYGyEThPW35f0YSxt2J8pMbhubzWhdnxQJaV6/E
 VMTDnjHQcVq8VqOB42XMQ275dnSPgo+A9u34g4w9V98NMrzBJbNkAych1AvtY8tU85dx
 NQQk52UKGhmlnlpwy8rpHIQb3oITo+IQT65EkXhRrrBPJG6hNizoDpP3oLDwiMZHgK7q
 lTdss2G82Xl12+AP+RH3qHsfhgAwZl3ZLuZeG4tIRY1gR6YXPYn/KxV/ilSkInT4wZJT
 /eTO9a2ehlkEypzSvwAAb2QLKXgo/5I/AkFCrAHS5SSp42P0A9mjiAFClPkBnyHUabMm
 j5XA==
X-Gm-Message-State: AOJu0YzUYHunZFjdHm8JIuiPdYwBYECM7nwCl2NP3Mj0kOgzC282mFOe
 N5TUXKbgEG3Yfb4nVYGu/GamDN8mVOzj+GAbeMShApXW3zfCJDaTFVrgofp9WlQ=
X-Google-Smtp-Source: AGHT+IG2ho/yOwKLp5kVI62aOyHZ0kpYk+QTS0J3qBO097vi+sIabjTZg8ecajqTfDDU9v2h9HJgMg==
X-Received: by 2002:a05:600c:154c:b0:414:610b:13c3 with SMTP id
 f12-20020a05600c154c00b00414610b13c3mr555071wmg.27.1712304915570; 
 Fri, 05 Apr 2024 01:15:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b004162d5233d5sm2034407wmb.42.2024.04.05.01.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:15:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:15:11 +0200
Subject: [PATCH 2/3] pinctrl: qcom: Add SM8650 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-pinctrl-v1-2-92d563c28c90@linaro.org>
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3613;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ND9WBZB5yIbN+7Yg5uso4afTkuYvBW9o2C8lWVIGqyI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7MQt5rTVnjZm97qiAv7RsQiCDZm0M1EH9QNbDpt
 Jqv9eaOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+zEAAKCRB33NvayMhJ0QtgD/
 9bwECnDCMsvsfDh0uspbnoFj9r8HbHBzOIfbBxR0yOZL1QPl84ugza9p2I/otvJ/9aFXqDusYdNQSn
 Cm8I/2ydd7Fvhn/hBImM5QF+cdZJofL5WNxXebKovrYC95H+s/sJI3hIo2ZaIej+qZMKJj/ahL2PpD
 1wy5u1npK4we7ONX9C6KKCslz3xku/jCJckrzC+RbrIbdCClQxzexPWGX8XQeeXPw5R6SeWA/JrLSS
 nFvqRsmfIix4yAWk6KjYxoEX2UDtxGDvsQp/2Y9Le+NQOnbgH7bIkjCGSKSIAePH0RAj71VcYO5k3Y
 dfPC5370BkjacRoMRYQdMj4ryF+HC0wCJJFwQpi9WctNisI8L3/Hi6vWUCtr26BIA8NtUyBchhGRCm
 G2O9mgPQ0chMFUS81Z9QMpJ8wpYhfEcs/JjXac910fgKnt0323kjecXJJ0Ga8a/2Rpm0cmcthNbaC/
 G6UQIjptH+Ycc7y/6wIcSgkFf6SCUBIkeeAU+FArfqzW6A6NInMbYk9jc7RszJ7Dl8UBxy+ddUqJap
 Xy5nGwh4QtMPIX4xZIBlbxpuESedZnDXpar/GUgcEXOWkVwF5SX1wF+Fg0s0gqXyw7cMJGYK2uUpib
 YuJWzOSlo6z9T9Xjm358yQzvMKM4iWln4yfJ7jmt9Jh6ikODSlMl85BdKgbA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add pinctrl driver for the TLMM block found in the SM8650 SoC.

This driver only handles the gpio and qup2_se7 pinmux, and makes sure
the pinconf applies on SDC2 pins.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig          |  7 ++++
 drivers/pinctrl/qcom/Makefile         |  1 +
 drivers/pinctrl/qcom/pinctrl-sm8650.c | 75 +++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index f760bbcdd52..e0196a83e60 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -48,6 +48,13 @@ config PINCTRL_QCOM_SM8550
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM8650
+	bool "Qualcomm SM8650 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 970902e28c8..d83e89ef4f0 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
+obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8650.c b/drivers/pinctrl/qcom/pinctrl-sm8650.c
new file mode 100644
index 00000000000..932132fa4a6
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8650.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sm8650 pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ *
+ */
+
+#include <common.h>
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"qup2_se7", 1},
+	{"gpio", 0},
+};
+
+static const char *sm8650_get_function_name(struct udevice *dev,
+						 unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm8650_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	static const char *special_pins_names[] = {
+		"ufs_reset",
+		"sdc2_clk",
+		"sdc2_cmd",
+		"sdc2_data",
+	};
+
+	if (selector >= 210 && selector <= 213)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 210]);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int sm8650_get_function_mux(__maybe_unused unsigned int pin,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sm8650_data = {
+	.pin_data = {
+		.pin_count = 214,
+		.special_pins_start = 210,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm8650_get_function_name,
+	.get_function_mux = sm8650_get_function_mux,
+	.get_pin_name = sm8650_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sm8650-tlmm", .data = (ulong)&sm8650_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sm8650) = {
+	.name		= "pinctrl_sm8650",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
+

-- 
2.34.1

