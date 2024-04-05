Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DE7C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F89788482;
	Fri,  5 Apr 2024 10:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xcIhAmqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F61D87F52; Fri,  5 Apr 2024 10:15:17 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9545A88177
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4162f7ea4d0so1556995e9.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712304915; x=1712909715; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sZqjhdW8KArdrFeB83vXNBozzA4ogD98yfJMZyoYuOc=;
 b=xcIhAmqamX861rOZNEM+FGo/ogt2ul2BmE9GHLu8iQpPXHgwAdUa3JG/Paw6zjTCQZ
 hiXROsLaWNsD8H4Os61GJDaT9NEeI9UQFulbRejzF3yjh5vdFICqvGdmDEOVD+LiC7wA
 U9lvgUd3xKBb8W3BfJY1l0MJvFFVUKaHXUQkeOE4kaHS8010nLAO5jTT9cGaqcTb0AMn
 Opex9MmpcyPP5XvmRDEoNXjD9wXKxjCc+bssQ6kxCx3TyBo/tF3zUJ8p2FhDh/HubYry
 6ypnY4XTkktapUZ7RlyWyp30UxTsPwZWmmE+LFzKk/WG7JtKeTqmn4hLMliaU37WQQ3j
 3+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712304915; x=1712909715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZqjhdW8KArdrFeB83vXNBozzA4ogD98yfJMZyoYuOc=;
 b=nvX1aOWJqE0CE9IrZbNdzMtSt8ilb0Mjd6NSxhv6OCyYYoGzpNd9THSUku6jtc/65Z
 AtSxMpifO7mmWc/h6RrFmdjt0VdZvPcns/1wrNo+YOnzkWAN22WwSbELzsa0jdxv49Vu
 bvrnOHADYv+CPlHJlNtUh5VAknbXEWUv0Qxvb+W4hlxxImybuWgK9t6tQovkA5z1bPnO
 bGHlym8Okds2/7J2eG9GBcdUZWfJ60ZPKt2vJ1wRbT1UesGozlckh2X/+Z6Tr/ZIyp5s
 3bpOSCv0Lv0C0OK9mZZIX/fhfl4SDgbPnSn+H4V3zQr494PRvI0pOvyMJaQ2Yh08/wmB
 0usg==
X-Gm-Message-State: AOJu0Yy84RhV7MzHNYXE+gUlCPcbbXttktTG7amnXDfWOEtnFo2RMoWf
 a8EMs97INZWRXUfO6pA7wmgrHf6sPf+kpjwX0gc/nSeRMdZBkpJpCY3k0AQrHLmN4uQpXgIbDED
 6c3M=
X-Google-Smtp-Source: AGHT+IG0FneK+xnd4Y37Qe/pRAiPPM0B5PK/DJnr2SVd5JFVBntouL9Kdti/nxfvyAk+hyVFr+ULHg==
X-Received: by 2002:a05:600c:3502:b0:416:1b17:ba4 with SMTP id
 h2-20020a05600c350200b004161b170ba4mr1601648wmq.16.1712304914883; 
 Fri, 05 Apr 2024 01:15:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b004162d5233d5sm2034407wmb.42.2024.04.05.01.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:15:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:15:10 +0200
Subject: [PATCH 1/3] pinctrl: qcom: Add SM8550 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-pinctrl-v1-1-92d563c28c90@linaro.org>
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3612;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kPJE3UPg8M7mU9/CNo/+NPvMOmVzSu6bDOYbQocrEJY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7MQqkhq2QDTieroMKIJVLhnnPVjDDKAPEaFew6D
 sL5XGWKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+zEAAKCRB33NvayMhJ0berD/
 9BmKB/gtn2B2+UJKCEUXazeH3zS3kd82l9Nw50psz+fdyM15Jm+hD2LqQE0vuAtxQWpccp7si+kHbx
 dF4pT6nfRHgmDwHc/IoZ+rBFbHSSMd/v6WrbaTKkvwAKdspjhk+X4MZ8/NY7CBxSBiHszludEmSF2B
 +JEUNXWu0aSH8pA1b2EtGKKKMAovYeUZ/VY7v31QS2it8sNAWVaBVGA87GdMATq67SJjHTE/JOEtul
 tiae/7/Cbu1B4C8jpnsqA/D1fwk1Eawsva89jBjAo4gkketpA7OzWhHL0ImsIUL/cZin9Rg2vOn1++
 oNQUDuq1+ZonxpxZL9pFFP2VIfUNP8hpDnj6BC38lEovh0zXz87aTEd5t1UI0svGVN9kRinVpOBjm/
 Z8fAkzdi0OVwmvJS18js3xJZmE7nTAPTTvojUSYFbJF8dxizqIwm+YVxzrO9m8wf06iHSi0vdXrAUq
 FhVRZm4vxptzNgNv1jzFex3U1MXPj5ckKmjH5jfGa8I1lriIx3RtyYrfb07XuRCL5S9HTEewo/FIDs
 OZWsqPb5Od/57TT6uhGtsNId0tDl1mHvJ8WuWXyNBcVtr6kpHigS710eeJy8UUvKW64zUOA0LgeV+O
 D7uPNpCAy8OMO1j3NieLwtUY3j1GKOrcjj4hKXYGDT+b33qBbP3SFP4CRqog==
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

Add pinctrl driver for the TLMM block found in the SM8550 SoC.

This driver only handles the gpio and qup1_se7 pinmux, and makes sure
the pinconf applies on SDC2 pins.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig          |  7 ++++
 drivers/pinctrl/qcom/Makefile         |  1 +
 drivers/pinctrl/qcom/pinctrl-sm8550.c | 75 +++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2fe63981478..f760bbcdd52 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -41,6 +41,13 @@ config PINCTRL_QCOM_SDM845
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM8550
+	bool "Qualcomm SM8550 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6d9aca6d7b7..970902e28c8 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
+obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
new file mode 100644
index 00000000000..d9a8a652111
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sm8550 pinctrl
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
+	{"qup1_se7", 1},
+	{"gpio", 0},
+};
+
+static const char *sm8550_get_function_name(struct udevice *dev,
+						 unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm8550_get_pin_name(struct udevice *dev,
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
+static unsigned int sm8550_get_function_mux(__maybe_unused unsigned int pin,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sm8550_data = {
+	.pin_data = {
+		.pin_count = 214,
+		.special_pins_start = 210,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm8550_get_function_name,
+	.get_function_mux = sm8550_get_function_mux,
+	.get_pin_name = sm8550_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sm8550-tlmm", .data = (ulong)&sm8550_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sm8550) = {
+	.name		= "pinctrl_sm8550",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
+

-- 
2.34.1

