Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136C2CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281178808A;
	Mon,  8 Apr 2024 15:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VGHMNYzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9213F880AE; Mon,  8 Apr 2024 15:08:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4542875E9
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a4715991c32so629088066b.1
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581686; x=1713186486; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WpEo3xuwcmeG5XEZhc+q8FFKON3jx1or5TkMtm3IpG4=;
 b=VGHMNYztwq4zkWEvP4okPmgPJu2gsuo/bEmCzSIldxPNpysfN/aqTraE2EilE8OOAr
 6SOnDlKBrrkT9hwlQ2/8aywKF6wemxiyYu+0PaJzhKjJUYNMMq61KZMS8bM9s6OLHU/8
 kvNd45m1CssW+hSxBPh0XWTdkR1/gLT1jNuMh0R5s6IAgJaoTF6GWMWTDVl8XLAZm6Da
 V3XaZ3gWVPtu35200xZ7jzEpdKzTYV3mZ6GpOgCThbT44ctlb7w+2QYBfrt1xvqEL0Tc
 fwqsxuddw013j3xzLYdduOM+Ufls31UL63DkM9R2y5+Yp7Q52uV8zCXIezeUVDbhG2va
 5L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581686; x=1713186486;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpEo3xuwcmeG5XEZhc+q8FFKON3jx1or5TkMtm3IpG4=;
 b=DPeA1CUq4Hpt+aCkgJZwvgfmHSK1AXEuMw0SHQ66X3gkgfZM/8wbSuPFuqYTNz4FvW
 dFy2xt8Jas8AlJ2jaeWGmerhmTTngJ2bBNslARTPAeXOjfPbOa95n9Pq5lhIeOKam0VC
 wHsvv0EfAfK6ETxTistmHiB7tC85alZqzj01RamAoAv8dEJH/JckrXKLEgsgWDlarTCt
 IlENRRFLU3g8sbDvV3cclPdLGx5VughZnsqtwmGRJ1PEPJ9dhy9+N+Pz1N8KcTOGvCsV
 igXjYjaPmNXKpbZyADTDC8zdMKin5/TodwmpFddhe2y+2NyIFZ30YjEPXpb3MpZIXORr
 eWpQ==
X-Gm-Message-State: AOJu0YxG5b15yk/AM37m+y4+iD/JCNxx7vrNrbpTyzXPzOt8srJIJL13
 If/QXuyAOzv8d+5n7aVFcFBOD7uV7Np6WGeqWPUm8q/YUzPFCXMRHa++o5Jl2Dc=
X-Google-Smtp-Source: AGHT+IGe0REVk55dd9Yt/wbWc4rsHiqelhNIOQvzNzEIJX5AgNlkMvXG7D+n5zM/JWlgVF/lgiQI/g==
X-Received: by 2002:a17:907:72c2:b0:a4e:2570:ff56 with SMTP id
 du2-20020a17090772c200b00a4e2570ff56mr7637890ejc.0.1712581686137; 
 Mon, 08 Apr 2024 06:08:06 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170906844b00b00a4e23486a5dsm4394815ejy.20.2024.04.08.06.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:08:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:07:39 +0200
Subject: [PATCH 1/4] pinctrl: qcom: add qcm2290 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-1-900db37b8bdf@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3691;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dkjlxIYjmZqHcciS/NcT6tSSQUIBu5Zi+tWMsHILD6o=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+w01CVhWGC7dUsuA7Oyeyzg/uNYauPpfcIzI
 VTmQ6CLGVGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsNAAKCRAFgzErGV9k
 tk3OD/wJ/7ryHgEywbVDumIwh0WCzdyukrv5jXpLKmu7v3Ci/lejGSDvjZUB6KY7N2k6jeNq2+M
 5XqX99yAbuSG8ZOLv32oY7CMKkSKis1nvxEQM5aW0iSEVAZqgummH7+x1yR0LbxdUz17+heRE05
 AP7ys/6VkHdbkgXFQJbSIzY5xzVDWCgwqsNnrbqqkGLAHfUWs9rNZMtwBvrXu+uyqrDerYXTxNb
 29LGFB+zeswxXpqGWBSrWkmjpJZL3CfjoUCTmwRLGOVMHRu2zPKhmc+MA1GSQRFu6wwHzvGBR4e
 ogu8yenVvvXwept6Ty9wVDVQI5nji6Ji7Etw3KwxWddKU9UZKU8EHtJXNiqPh6Y2Z/cRLjFb7H4
 MLgSnzsgJkD81L2WQHSnwPjMHzDYXKVkF/QguM6nTsYMXqdWgZtkug7jYEKSpR8e0QrxPjjk8XM
 nF2MNBsXCSImGxp3x1iQflSqVg5VAyK9dD8ef5EN0DSVWv++mD0ZCIRDPQqkFkdXekN8pcZYzeC
 hufb2Ft+lPdgnIGJBj9t3IIVABxEgVAPz5qZUSUX6RKu75CB+DivHjRFeW1U+cN87yvlw7GNkgU
 nJQ9ANXLh0nmn+MlwXlTjb0ggulJ7MuwkBylGlZKS6MqYefS48p70t8qZFX49w9GeNrI3RMsFTR
 UdYtrR95BPWghBg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This SoC has a basic pinctrl block with no tiles.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig           |  7 ++++
 drivers/pinctrl/qcom/Makefile          |  1 +
 drivers/pinctrl/qcom/pinctrl-qcm2290.c | 67 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2fe639814785..35140efd5b62 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -26,8 +26,15 @@ config PINCTRL_QCOM_IPQ4019
 	help
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_QCM2290
+	bool "Qualcomm QCM2290 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCS404
 	bool "Qualcomm QCS404 GCC"
 	select PINCTRL_QCOM
 	help
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6d9aca6d7b7e..0b1d610ea3e8 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
+obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
new file mode 100644
index 000000000000..e2abb53ba4e5
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm qcm2290 pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{ "qup4", 1 },
+	{ "gpio", 0 },
+};
+
+static const char *qcm2290_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *qcm2290_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	static const char *const special_pins_names[] = {
+		"sdc1_rclk", "sdc1_clk", "sdc1_cmd",  "sdc1_data",
+		"sdc2_clk",  "sdc2_cmd", "sdc2_data",
+	};
+
+	if (selector >= 127 && selector <= 133)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 127]);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+struct msm_pinctrl_data qcm2290_data = {
+	.pin_data = {
+		.pin_count = 133,
+		.special_pins_start = 127,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = qcm2290_get_function_name,
+	.get_function_mux = qcm2290_get_function_mux,
+	.get_pin_name = qcm2290_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = { { .compatible = "qcom,qcm2290-tlmm",
+						       .data = (ulong)&qcm2290_data },
+						     { /* Sentinal */ } };
+
+U_BOOT_DRIVER(pinctrl_qcm2290) = {
+	.name = "pinctrl_qcm2290",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.44.0

