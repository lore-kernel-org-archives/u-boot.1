Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590E5C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72643822D7;
	Mon, 28 Apr 2025 21:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cIifUxiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1B08210E; Mon, 28 Apr 2025 21:24:40 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3321E80FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736a72220edso5160731b3a.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868276; x=1746473076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MhOIKrN6syWVJpBkxr2i45CnxNLBwtZVychVJh67Zo=;
 b=cIifUxiuTBrIp0ZO8rE3rlfyP69RGFZ3WuTGhrG08f4baysizoOCPtZKn/9tlS0SUq
 B0w+hXv+ynQHm86VENbQjGCgmIPrTAHyJmFvgx8lPmNBtd55+i36YI0MthMYy1mBpIS/
 UjhMrpScPAjHGuuMYSD9fAfbQBaEO0B3MOyLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868276; x=1746473076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MhOIKrN6syWVJpBkxr2i45CnxNLBwtZVychVJh67Zo=;
 b=Q/wXWGFrBYPxGgfv7VIzOQ9KJqQMkJuH94SER/fLMvCqV6CAQoRGtAVsBgsL30Eh4O
 4DVINx1ocBPJeYleR0YlilxNNW3IhHyj3xW8tI1qmRq6TFMmC7oBl6FyrOl8n8B1+fW+
 SkXwnGBX8WU6EcBFC4VnG3MnSLO2/nBApyuZY54qEbC4sGp2lxuXcbAjMczENQrO8dGR
 jw9gcgG6/X0AG3h8c4y7uRZgI+WH7V9aqPEIci38hd4dHK+ix/yGYrgeAJo5N6fubIeU
 CxWWeX1IZUkK2Z4pmYMVSmdvMMuvuzTBz/fxMEB2afRO0kjpe8z0Mndq6P5FVomxwlbw
 +rxQ==
X-Gm-Message-State: AOJu0Yym5cETKeParau3LboNMk/UJsOFbG7orJHSuWqRJyh5tk5HD/92
 3L7hM1NQ1qMF6TYRp8pw7uHJwhQSWiGEjAH5Zzfbwi6ZJqkuauw6Otm+2Qcz9cnjKzsVihBc6uU
 =
X-Gm-Gg: ASbGnct5FrIG9R1PeIcQCGzaUgDhBaZGHc4x8AEMvsdV9fwAxWAGJ8j/R2welwgkOjj
 JwGBBRfPJ9UY3cV3akmd+A6CRQKDf14/EUpnsyCE2//f8ueNpje3Bjt0aghAM2qrCfH0TsMZyTq
 XSB8R/c4+m1EpLF/llshJedX5H8jOSMTLrc3Kp4KrptaQ+CQGAtk/inslx9NZzcxa1DIoFO6JZk
 gVuMobbjNDxh+LHRtIlaxEPNK1qU9g/j3y/en+NWzMmsrhBpqMz4rksJrCTEaNmDfsGnnYHcOOH
 e9gNMkXKOALdLk+EKZaMr5TrC5TYQkOg68kbtDdBq0m3h6Q/0zfFmWq+hJSqjXxWuoo8rodgHpi
 yBAjiq6eTfPnH
X-Google-Smtp-Source: AGHT+IGo8ziQrP4VVEWRG9uEsC2pUIBtrr5YF7A5dC2Vv7xPSVkewsIgIfan2o2u1sZNXYo5hzQs9A==
X-Received: by 2002:a05:6a00:3c83:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-740293e14bbmr340325b3a.20.1745868276482; 
 Mon, 28 Apr 2025 12:24:36 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e25a9a0e5sm8685593b3a.132.2025.04.28.12.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:36 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 04/17] pinctrl: qcom: Add driver for sc7180
Date: Mon, 28 Apr 2025 12:24:11 -0700
Message-ID: <20250428192427.3877612-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

Add a driver for Qualcomm's sc7180 pinctrl device (TLMM). This is
largely a copy of a similar driver in U-Boot along with reference to the
Linux driver to fix up the data properly.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/Kconfig          |   8 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c | 131 ++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index e567cb113a31..0617443d4db0 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -55,11 +55,19 @@ config PINCTRL_QCOM_SA8775P
 	  Say Y here to enable support for pinctrl on the Snapdragon SA8775P SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SC7180
+	bool "Qualcomm SC7180 Pinctrl"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SC7180 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SC7280
 	bool "Qualcomm SC7280/QCM6490 Pinctrl"
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
+	  as well as the associated GPIO driver.
 
 config PINCTRL_QCOM_SDM660
 	bool "Qualcomm SDM630/660 Pinctrl"
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6ffc6d48c155..8e3e377fa184 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
+obj-$(CONFIG_PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
new file mode 100644
index 000000000000..3e4098a713ae
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm SC7180 pinctrl
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define WEST	0x00000000
+#define NORTH	0x00400000
+#define SOUTH	0x00800000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"qup12", 1},
+	{"gpio", 0},
+};
+
+static const unsigned int sc7180_pin_offsets[] = {
+	[0] = SOUTH, [1] = SOUTH, [2] = SOUTH, [3] = SOUTH, [4] = NORTH,
+	[5] = NORTH, [6] = NORTH, [7] = NORTH, [8] = NORTH, [9] = NORTH,
+	[10] = NORTH, [11] = NORTH, [12] = SOUTH, [13] = SOUTH, [14] = SOUTH,
+	[15] = SOUTH, [16] = SOUTH, [17] = SOUTH, [18] = SOUTH, [19] = SOUTH,
+	[20] = SOUTH, [21] = NORTH, [22] = NORTH, [23] = SOUTH, [24] = SOUTH,
+	[25] = SOUTH, [26] = SOUTH, [27] = SOUTH, [28] = SOUTH, [29] = NORTH,
+	[30] = SOUTH, [31] = NORTH, [32] = NORTH, [33] = NORTH, [34] = SOUTH,
+	[35] = SOUTH, [36] = SOUTH, [37] = SOUTH, [38] = SOUTH, [39] = SOUTH,
+	[40] = SOUTH, [41] = SOUTH, [42] = NORTH, [43] = NORTH, [44] = NORTH,
+	[45] = NORTH, [46] = NORTH, [47] = NORTH, [48] = NORTH, [49] = WEST,
+	[50] = WEST, [51] = WEST, [52] = WEST, [53] = WEST, [54] = WEST,
+	[55] = WEST, [56] = WEST, [57] = WEST, [58] = WEST, [59] = NORTH,
+	[60] = NORTH, [61] = NORTH, [62] = NORTH, [63] = NORTH, [64] = NORTH,
+	[65] = NORTH, [66] = NORTH, [67] = NORTH, [68] = NORTH, [69] = WEST,
+	[70] = NORTH, [71] = NORTH, [72] = NORTH, [73] = WEST, [74] = WEST,
+	[75] = WEST, [76] = WEST, [77] = WEST, [78] = WEST, [79] = WEST,
+	[80] = WEST, [81] = WEST, [82] = WEST, [83] = WEST, [84] = WEST,
+	[85] = WEST, [86] = NORTH, [87] = NORTH, [88] = NORTH, [89] = NORTH,
+	[90] = NORTH, [91] = NORTH, [92] = NORTH, [93] = NORTH, [94] = SOUTH,
+	[95] = WEST, [96] = WEST, [97] = WEST, [98] = WEST, [99] = WEST,
+	[100] = WEST, [101] = NORTH, [102] = NORTH, [103] = NORTH, [104] = WEST,
+	[105] = NORTH, [106] = NORTH, [107] = WEST, [108] = SOUTH, [109] = SOUTH,
+	[110] = NORTH, [111] = NORTH, [112] = NORTH, [113] = NORTH, [114] = NORTH,
+	[115] = WEST, [116] = WEST, [117] = WEST, [118] = WEST,
+};
+
+#define SDC_PINGROUP(pg_name, ctl, pull, drv)		\
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
+#define UFS_RESET(pg_name, offset)			\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = offset,			\
+		.io_reg = offset + 0x4,			\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0x7f000),
+	[1] = SDC_PINGROUP("sdc1_rclk", 0x7a000, 15, 0),
+	[2] = SDC_PINGROUP("sdc1_clk", 0x7a000, 13, 6),
+	[3] = SDC_PINGROUP("sdc1_cmd", 0x7a000, 11, 3),
+	[4] = SDC_PINGROUP("sdc1_data", 0x7a000, 9, 0),
+	[5] = SDC_PINGROUP("sdc2_clk", 0x7b000, 14, 6),
+	[6] = SDC_PINGROUP("sdc2_cmd", 0x7b000, 11, 3),
+	[7] = SDC_PINGROUP("sdc2_data", 0x7b000, 9, 0),
+};
+
+static const char *sc7180_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sc7180_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	if (selector >= 119 && selector <= 126)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 119].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int sc7180_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static const struct msm_pinctrl_data sc7180_data = {
+	.pin_data = {
+		.pin_offsets = sc7180_pin_offsets,
+		.pin_count = 127,
+		.special_pins_start = 119,
+		.special_pins_data = msm_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sc7180_get_function_name,
+	.get_function_mux = sc7180_get_function_mux,
+	.get_pin_name = sc7180_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sc7180-pinctrl", .data = (ulong)&sc7180_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sc7180) = {
+	.name		= "pinctrl_sc7180",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
-- 
Sent by a computer, using git, on the internet

