Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20672D68BC6
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 15:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1BD89358;
	Fri, 15 Nov 2024 16:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W2gAIl0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720AC89362; Fri, 15 Nov 2024 16:44:22 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 690F989251
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 16:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37ed7eb07a4so563045f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685460; x=1732290260; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dkh8Jt10A3nP/ytR7/E369WaFWR3kynGlq7+K5XIVpg=;
 b=W2gAIl0lD0XxRv5W+IhA5S9UfrW9RZPAvRzSSie609aqor4ZZQTVZZJPp5uNwRLS2d
 YVcVsJnIoNcPOKgM9+jBr8b5+/tP0GwK2DcnltHp/UbJaejSGLXS/ihPOMZEIYwPbwhF
 qQwpX/HP2kCnK5Hf92fL8hIqXo1FGW9MCp24FmeMfaCAqhug/tsYHg3/CaS8qnpihcCT
 H9YFRyK+0tqNVeIPrbtxBo6dd+DeA8XIyG9nDx9bdE1HlYPymUGo+49xx1pEe0fVsit0
 20Ggp6fINy+p8WRT4GWnGPJVQbKSizMefH5M5nibr64PVdYuq3i+SFFBzgfiJ/5xiApJ
 EOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685460; x=1732290260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dkh8Jt10A3nP/ytR7/E369WaFWR3kynGlq7+K5XIVpg=;
 b=DSfPv03Ux5euIuxKbKTK5jRob2tCFg/UDBYUm3qBzeCXEV5AA0RkSDItX6e/+ECeY8
 +I+sHvI0913Tgp4H7C6p9PL/EmZ6jSxrfzDqKR1qc8oooPwwSMzlvqI/piLfju5SAlGF
 dqeN18IFksTLg7pF6e+2rmjINLPIeQBA+TNSALLdwNOxw+FMPNEnh+k9mAyjrKZP1qyc
 Sq43QjTtzibzf7a33eO+9CSD4kiNn0TEJXZXByh/J/1W65viTPy9PCbzHfHc6C0rTtAq
 Ze74kfZvU0Sa4hUrf0v0uW4lLS3UyMqqjjhNmKYWZC27F4vxhtlV4fytpJPjRauGG+4H
 7JzQ==
X-Gm-Message-State: AOJu0YxnCXvEz46I8wsXYKothxqLRVSY9esc2Yjnm137LLPpZsOyDBMj
 flRBL5PlO3rDdnJdMp1gdlBrM381+rufZv6WYEoxe/e2RFCnTn8UWJBSUoMhET0=
X-Google-Smtp-Source: AGHT+IFwaiiR1BGOLuBR0UNx7wKykwXpuJrr8zemtJKWBwxBToTCfE3aB7VOQZRL5oxwYmNS8jW5zw==
X-Received: by 2002:adf:e18a:0:b0:37d:3e8b:846f with SMTP id
 ffacd0b85a97d-38225a0cd83mr2623969f8f.24.1731685459455; 
 Fri, 15 Nov 2024 07:44:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3fc9sm4637773f8f.20.2024.11.15.07.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 07:44:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 15 Nov 2024 16:44:15 +0100
Subject: [PATCH 1/2] pinctrl: qcom: Add X1E80100 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-topic-x1e80100-pinctrl-v1-1-35f984226e47@linaro.org>
References: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
In-Reply-To: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4478;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wn0cDa2tN9puRZMOsTzMtjvuja94YCzXDuR+VHk30RE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnN2xRDcsPgVvrV9Eys7ij2dumfa5kPYd9TkFmNKms
 oZiT5YeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzdsUQAKCRB33NvayMhJ0VVvD/
 9gw+Kux7dKFOLXEOMH0RcTiqYv1q0EaSspVXUhk3XQ5wz2YGv64HpT20tchdGzLAdh1bf5kBKx+X+l
 MfVELMLV3nXeafV5K8ZSL2MhlKYlnbBYNCbxRDLEu5v+RRE9S7elVLC+2mwmwriN6DuEMUBazon2ya
 UxsDJe8BpIUPKcry9KRwgrXW3VKMege3hQ+uAo9G15VhkkN8jhKDMY2LFjBDCRUh+LtodauXJK4Bzm
 toh2asFeHmPmlHbCQxwLLfQPwYIygt71/ChXAjgjqIoz9EYwlCeZPhithUX8kA8MddqrAF/yY0Ah7m
 x1Ltr2iV6pnXXkVZHe2OhF7bmus9mYWdVdWdXJ/9K5HC5BvUs1Fkg/4OjXSIfY/8uvw+uw28LEuNPk
 8dIQECNoCCfz3EwqeQOJHM6Wx0vbkMMquE+vMq3VUK6NlzdA9X2xX1vUeerv/W1Axsqh/Wx4JB5X4P
 +ef1G42nYfe2MQ10c0j3k1U6hn/2eTxT80AXR8XjMCHFwWlGVu3KK6kiugTjuMClA+VKdUGp6eDLCZ
 aKEzrBft9V/mGGJK0l5EVwmftO4/DBVfj2Qh1OvHVan/IosMzu71gdGE8xS9454ONvxQszF11SjDJu
 llbEtb2DEGSOJtAf9GkczGA0deAxZ3oCOnJ3W9S7hBdQH+9ZCKc2xgrwnhrA==
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

Add pinctrl driver for the TLMM block found in the X1E80100 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig            |   7 +++
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 100 ++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 4f93a34281d5327e2bb53e5b628106a1c5227755..d3eb699855103ae586e60afedb571cc93702a4ee 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -83,6 +83,13 @@ config PINCTRL_QCOM_SM8650
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_X1E80100
+	bool "Qualcomm X1E80100 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 43d0dd2922253e93510242d66e8b56f9de72ea4e..06d3c95f93a624bd3cccbd8521f37cfa95a5d022 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
+obj-$(CONFIG_PINCTRL_QCOM_X1E80100) += pinctrl-x1e80100.o
diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
new file mode 100644
index 0000000000000000000000000000000000000000..2e2f5093272cf8c2a60eecf642ad9c567b539f84
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm x1e80100 pinctrl
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
+	{"qup2_se5", 1},
+	{"gpio", 0},
+};
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+#define UFS_RESET(pg_name, ctl)				\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = ctl + 0x4,			\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0xf9000),
+	[1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xf2000, 14, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xf2000, 11, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc2_data", 0xf2000, 9, 0),
+};
+
+static const char *x1e80100_get_function_name(struct udevice *dev,
+					      unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *x1e80100_get_pin_name(struct udevice *dev,
+					 unsigned int selector)
+{
+	if (selector >= 238 && selector <= 241)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 238].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int x1e80100_get_function_mux(__maybe_unused unsigned int pin,
+					      unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data x1e80100_data = {
+	.pin_data = {
+		.pin_count = 242,
+		.special_pins_start = 238,
+		.special_pins_data = msm_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = x1e80100_get_function_name,
+	.get_function_mux = x1e80100_get_function_mux,
+	.get_pin_name = x1e80100_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,x1e80100-tlmm", .data = (ulong)&x1e80100_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_x1e80100) = {
+	.name		= "pinctrl_x1e80100",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
+

-- 
2.34.1

