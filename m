Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A54CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27C9881EA;
	Wed, 10 Apr 2024 19:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lFvFq1CW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3CE4881BC; Wed, 10 Apr 2024 19:53:36 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B2687D8E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516d0162fa1so8428000e87.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712771614; x=1713376414; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c0foXhH40tJ4Jh+om91VjHMF1L8u/P4OhFGdcEOlCuY=;
 b=lFvFq1CWmbWyvgYzYFzu6iIgxlbK/pBMUEicnVegp8s7ZL3xkV11JG+GSvTEa7cn2u
 Zx8M4r0vZNuu7Z9abOlL2myvzuexZYY/R97E8nwkCrb1KJ5VyqzSxmYxd9hsDdCV5BnU
 kbkDWXNK2McWmoBEdVyWzsZTVVbt6vtJznAX9iPtDmoJ3DNmlgPx9m6ANiB90vFjeZNi
 gV6fIoiBU74LBgnHFm1vDmqI80SDy8L2GbgQuMFvryeczIepNqJUuAYwATP+zksgiH/s
 zspNbm9HVSwICpAc0VGBfI/CuOiGOSjK3saTQ6Jt7u60kb28ect1oIvc7AkVKROfTm4/
 aDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771614; x=1713376414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0foXhH40tJ4Jh+om91VjHMF1L8u/P4OhFGdcEOlCuY=;
 b=WFpCP0zdk2fWhzAPv6k6jjFkK496FKvNYUwlN0SW/0qjAhiU0Yf7WJTT+wyIDML5YD
 iY2XjW8j6wKCOVzg73TOdC1Fdw1TIVrymejWa4cSfXT3oacapbzCP/DTE/4cJTT6Gf9/
 SsdX0w94fFc1SRFiwlIVWfT2YRdogL3172z21aRpdYlb9dBbA2HOGXAOg2lbCk8wUPfg
 1LqjVaCGBJ6QKhRxL6n86ZEUQWbF6WvzXfFvsVsniB4Du9PnXZmB2rh6L3HnEq+6JLxd
 kwQWpzjeMbYBswAT8FE/h1jtJyF8hA7dPZP6ViKUZDai2o4B5ZuySM80XizX1UF/234C
 WmTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt9tsBzJzX6S2+wh8BAEd++rY6U0HUx0YOgi5KGdOdzF3vGCWj2iq5VQ7P8YdwFrvjvgsKYWmeVvwM0Db5En8NEROBJA==
X-Gm-Message-State: AOJu0YxYHH5sSkMrFZCMrng0Z7nQapDY/+rvN5gF+iHaM7pSEpz9YiM8
 5GXfnK4EJB8ALEXuX3yremjf2Sqhoe/dWkg+63UDThL0aMdkHdtKrBx6Gr0OWyiGYhUIAdODrRu
 5OnE=
X-Google-Smtp-Source: AGHT+IEXRvezekmZNr9E/URy89ttFcWZwZts19uNOg5prgStCSaxGLNlSGY5bIk7+02c/TCA7SA4mw==
X-Received: by 2002:ac2:4a84:0:b0:515:c17e:ddb1 with SMTP id
 l4-20020ac24a84000000b00515c17eddb1mr2429619lfp.50.1712771614110; 
 Wed, 10 Apr 2024 10:53:34 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a056402128100b0056e2b351956sm6543599edv.22.2024.04.10.10.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:53:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Apr 2024 19:52:38 +0200
Subject: [PATCH v2 3/4] pinctrl: qcom: add sm8250 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-b4-qcom-rbx-soc-v2-3-5120a9c7f6ce@linaro.org>
References: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
In-Reply-To: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6402;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=49xQ/kwOLQWRzikUppjgYvIvXbCCflE9/I3xdwBmhX4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFtIZQrWwXcoKDxE7MUPLkhkaYhZVRy/xAOQEN
 Jfy2ZSLTp+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbSGQAKCRAFgzErGV9k
 tiIyD/4iOZHEpLV0LJCszZK3k4CdFvQQwO2+DCM3bMmMZ/BwSLVz1KFlZEs3ov0FKpAjfWZg7tc
 FQMpf581/TlK9Ywq7bNs8XY6P7mGhRHDKtk/akHTNPDyrDY70CQfj0Hkdv5ibvKexQ8yz7OHigK
 ornGKmiWn5Q546SpLegssIJIWoICkWn+BS/oCVt6ly1SWbMBRBg1CdxDRI4xb0GOf2mSefh/Xjg
 1OGh2rFHx3tkGjhyh7FnkSEDVCxDjkv3O/VqhekQQKbG9qA2qhtSmHKOCqAoD44qt3quVPyXtNL
 N6Wyv4xIu5vU1pFaL28SVyVOXaZYgPXxPUh/IP9mNng5/6Foz7sttyryRiwkosAGKTJKf/2XHNz
 1m/cwT1+LvLYxbYk6KVPc5PgTxZDqQxT13XXTs0a9PgWn+bpVC+KFv9OvbbZ4AJr8/N25Yce1Dv
 j8z8SpaPABCxwT3o3jWqsrIo9mGpwfMoK8uLYOMpGhDgS4Aa0lyctyUAN7hDZSFk9o2B7JhR7ke
 jeLA6+w/3x86ArNhVywgBZW2R4Kwoo7yfaSyF63tuUHxCT8wzVgdSDlod1QFeLEKWnMaGU5jT03
 +K3gNXC0lTlomuFZEIDFIVIkkf6n5MuxhrR36Ly8Cob3TkXs+3Jzs1kbEtApy9AZrhzy0L+aDVv
 p0/i0NUBBtdyNnQ==
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
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 99 +++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

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
index 000000000000..dac24f11bc2c
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
@@ -0,0 +1,99 @@
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
+								 { "sdc2_clk", 0 } };
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
+	[180] = 0,     [181] = 0,     [182] = 0,     [183] = 0,
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
+		.special_pins_start = 180,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm8250_get_function_name,
+	.get_function_mux = sm8250_get_function_mux,
+	.get_pin_name = sm8250_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,sm8250-pinctrl",
+		.data = (ulong)&sm8250_data
+	},
+	{ /* Sentinel */ } };
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

