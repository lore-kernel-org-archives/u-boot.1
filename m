Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C15CC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD728810D;
	Mon,  8 Apr 2024 15:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mcq66YvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE27787FBF; Mon,  8 Apr 2024 15:08:10 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D48487DEA
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a51b5633c9cso262285966b.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581688; x=1713186488; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=deXXf3sE+BihSot5OSTVzHWvLqNputjVfgKSamtGuMI=;
 b=Mcq66YvMkL+LGurebowHj+29lxCPmn7qc8kZxbwdbv7R1aKjGu/SQE/zD5CXMo5mvZ
 KGElWTgvYBPNeBE62fT854+LKcpuhuoYTsupvCg1XQ4OBqmWnikdI1ug8rePfJ/I3gUv
 3X6FWHoQ9/HE7LtHBlIoM+yHbfufpZOnxLo6x7c1YkxlV4mDG+VoPikDMYDS9D5CY9LF
 tvByrE6X2VIv1G1kNkwuwu5u6wtC4qGHFIQqDm7/KD06Xt8LSGdP/YYqulkktCaNyctS
 gAMtyBKO7gtpIwfzmsg82oL5OOBmVmj7fULZG/nND5YTVaBEkZghk8NpvEfovh0IgxFG
 YrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581688; x=1713186488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=deXXf3sE+BihSot5OSTVzHWvLqNputjVfgKSamtGuMI=;
 b=F4YwjAjQSjMtOBlIf9KUrEqQ42PAAGIjHI95EbtNh6Ti1+zkKiLkE6IB3I4dypj4mk
 460BLg7//Rtcos/iFLy9OSmciJH+9XEsdvftPTqJf031zdgA0+JEpoX6ot0YevUBytZd
 49j0/7sO4TN5TLE/REDeg7U49zQ9JsLdhf29XB7KIjXxGR/lsPVk/t8KC8sl/OWn2aUP
 7gzN2DimfRx4tZD1UdGc/9Ye3dw1EsRfyOpVJab8ZRlYgV37FyCkhnkSojYX8BBGHMl2
 ROlnzs5c3zTgegMqfFwL4fiw7Z9PEv/9yqtY69owI9wcPaLgrrkXic3Lb1qVg6TyxAAk
 b5Qg==
X-Gm-Message-State: AOJu0YxYeY79DlxsYvMgmfuTOd5dRdD3RdZHitIfauwhfWUkcDHS6KOY
 RG7lxoFW/XCpBvuOiOR4Leth9rqAxEL6Oo9OoWF6ZnvASxSDNc7ucYOA4v5KzSk=
X-Google-Smtp-Source: AGHT+IFi5x0hKD8x3XhEodv7510W7HaPXAaXi7lMDAMxiuGNxV9tCKWE4aNcBkT+8BZaL0pxj2BlWg==
X-Received: by 2002:a17:906:d10f:b0:a51:9002:3666 with SMTP id
 b15-20020a170906d10f00b00a5190023666mr5318332ejz.23.1712581688099; 
 Mon, 08 Apr 2024 06:08:08 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170906844b00b00a4e23486a5dsm4394815ejy.20.2024.04.08.06.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:08:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:07:41 +0200
Subject: [PATCH 3/4] pinctrl: qcom: add sm8250 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-3-900db37b8bdf@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6344;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=6of09R1npskPC8UAGsSQ3+yz8cFK7xiH61/wd3JRwtE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+w0rdDgAhXBvej4VJgS+/4ZlgwrhJPVJcIog
 bs1I2qTmquJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsNAAKCRAFgzErGV9k
 tv41EACdM+d9aUF3KDvnevif5YC+HCYLC1FDvBSFwGU9dKUPRUUDXWMUzK0PyGLAY78wYT6A93i
 Nk7pcGFDeYms5S1NOQIufwaPvV9k5twEgHGQp1DGRxVIx/Y/moU4s/ExKVdHDZGUPgP4FwfMtSo
 sWqNuVnOZs0xQwpXIKCnw/QkN4EMt8mWglJBeXipr8aU5gQvnq54HTNyIyIUCMyeBsTM4PubZld
 u3YJkDyhyujBuFNwhlInQRKxgExYJ1crrIaAXMR7AQPENen45bjHuQp3i6VNhQNFG+5XqOcRij2
 qoDJeLbmJR3kqPYOZvZgLPNLIWw/E3gyNNYq/FT1eCKyHoEZVUrlWp6tImeIO6rqCjuC9xDfCp5
 BMNnoe3OeOpwQO3Jrwnl8da4ZHGO9W0GsKEUlJ04IuDBqCq19Pgjbdkdl1zZPi0Y5pxRdutZE6n
 j7iefTJKV7B6p8cQ4vhWk4UfxVY7gEhe2k4+lH2h/DdneKYK0v0ABri/cgwTWPweoSPUkTzMikE
 SWzglP5i2TDZyVwYk4zA2xR//gf0Xm/ITTaU9iWI540O17Ili/5ZTobVd/lGe/480tMm04KeeUP
 MbQpeGxtuouKiZbZfC9VmcC3geVUGKG4jSkcw35+mdDpiza6cnKncUylxQh1HosRi2kwOD1+B99
 7WH7aNM4vqau0/w==
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

This SoC features a pinctrl block with north, south, and west tiles
accessible to the AP.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig          |  7 +++
 drivers/pinctrl/qcom/Makefile         |  1 +
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 96 +++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index e7a9853ce47a..33c355ad3b24 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -54,7 +54,14 @@ config PINCTRL_QCOM_SM6115
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM8250
+	bool "Qualcomm SM8250 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index f00c4e6e10cc..7dce95e5acb2 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
+obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
\ No newline at end of file
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
new file mode 100644
index 000000000000..1a9d4534fa12
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sm8250 pinctrl
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define WEST 0x00000000
+#define SOUTH 0x00400000
+#define NORTH 0x00800000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = { { "qup12", 1 },
+								 { "gpio", 0 },
+								 {
+									 "sdc2_clk",
+								 } };
+
+static const unsigned int sm8250_pin_offsets[] = {
+	[0] = SOUTH,   [1] = SOUTH,   [2] = SOUTH,   [3] = SOUTH,   [4] = NORTH,   [5] = NORTH,
+	[6] = NORTH,   [7] = NORTH,   [8] = NORTH,   [9] = NORTH,   [10] = NORTH,  [11] = NORTH,
+	[12] = NORTH,  [13] = NORTH,  [14] = NORTH,  [15] = NORTH,  [16] = NORTH,  [17] = NORTH,
+	[18] = NORTH,  [19] = NORTH,  [20] = NORTH,  [21] = NORTH,  [22] = NORTH,  [23] = NORTH,
+	[24] = SOUTH,  [25] = SOUTH,  [26] = SOUTH,  [27] = SOUTH,  [28] = NORTH,  [29] = NORTH,
+	[30] = NORTH,  [31] = NORTH,  [32] = SOUTH,  [33] = SOUTH,  [34] = SOUTH,  [35] = SOUTH,
+	[36] = SOUTH,  [37] = SOUTH,  [38] = SOUTH,  [39] = SOUTH,  [40] = SOUTH,  [41] = SOUTH,
+	[42] = SOUTH,  [43] = SOUTH,  [44] = SOUTH,  [45] = SOUTH,  [46] = SOUTH,  [47] = SOUTH,
+	[48] = SOUTH,  [49] = SOUTH,  [50] = SOUTH,  [51] = SOUTH,  [52] = SOUTH,  [53] = SOUTH,
+	[54] = SOUTH,  [55] = SOUTH,  [56] = SOUTH,  [57] = SOUTH,  [58] = SOUTH,  [59] = SOUTH,
+	[60] = SOUTH,  [61] = SOUTH,  [62] = SOUTH,  [63] = SOUTH,  [64] = SOUTH,  [65] = SOUTH,
+	[66] = NORTH,  [67] = NORTH,  [68] = NORTH,  [69] = SOUTH,  [70] = SOUTH,  [71] = SOUTH,
+	[72] = SOUTH,  [73] = SOUTH,  [74] = SOUTH,  [75] = SOUTH,  [76] = SOUTH,  [77] = NORTH,
+	[78] = NORTH,  [79] = NORTH,  [80] = NORTH,  [81] = NORTH,  [82] = NORTH,  [83] = NORTH,
+	[84] = NORTH,  [85] = SOUTH,  [86] = SOUTH,  [87] = SOUTH,  [88] = SOUTH,  [89] = SOUTH,
+	[90] = SOUTH,  [91] = SOUTH,  [92] = NORTH,  [93] = NORTH,  [94] = NORTH,  [95] = NORTH,
+	[96] = NORTH,  [97] = NORTH,  [98] = NORTH,  [99] = NORTH,  [100] = NORTH, [101] = NORTH,
+	[102] = NORTH, [103] = NORTH, [104] = NORTH, [105] = NORTH, [106] = NORTH, [107] = NORTH,
+	[108] = NORTH, [109] = NORTH, [110] = NORTH, [111] = NORTH, [112] = NORTH, [113] = NORTH,
+	[114] = NORTH, [115] = NORTH, [116] = NORTH, [117] = NORTH, [118] = NORTH, [119] = NORTH,
+	[120] = NORTH, [121] = NORTH, [122] = NORTH, [123] = NORTH, [124] = NORTH, [125] = SOUTH,
+	[126] = SOUTH, [127] = SOUTH, [128] = SOUTH, [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
+	[132] = SOUTH, [133] = WEST,  [134] = WEST,  [135] = WEST,  [136] = WEST,  [137] = WEST,
+	[138] = WEST,  [139] = WEST,  [140] = WEST,  [141] = WEST,  [142] = WEST,  [143] = WEST,
+	[144] = WEST,  [145] = WEST,  [146] = WEST,  [147] = WEST,  [148] = WEST,  [149] = WEST,
+	[150] = WEST,  [151] = WEST,  [152] = WEST,  [153] = WEST,  [154] = WEST,  [155] = WEST,
+	[156] = WEST,  [157] = WEST,  [158] = WEST,  [159] = WEST,  [160] = WEST,  [161] = WEST,
+	[162] = WEST,  [163] = WEST,  [164] = WEST,  [165] = WEST,  [166] = WEST,  [167] = WEST,
+	[168] = WEST,  [169] = WEST,  [170] = WEST,  [171] = WEST,  [172] = WEST,  [173] = WEST,
+	[174] = WEST,  [175] = WEST,  [176] = WEST,  [177] = WEST,  [178] = WEST,  [179] = WEST,
+};
+
+static const char *sm8250_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm8250_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static unsigned int sm8250_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sm8250_data = {
+	.pin_data = {
+		.pin_offsets = sm8250_pin_offsets,
+		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm8250_get_function_name,
+	.get_function_mux = sm8250_get_function_mux,
+	.get_pin_name = sm8250_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = { { .compatible = "qcom,sm8250-pinctrl",
+						       .data = (ulong)&sm8250_data },
+						     { /* Sentinal */ } };
+
+U_BOOT_DRIVER(pinctrl_sm8250) = {
+	.name = "pinctrl_sm8250",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.44.0

