Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AC2CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFF3880FC;
	Mon,  8 Apr 2024 15:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rRVw4LY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B45880FB; Mon,  8 Apr 2024 15:08:09 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A5187FBF
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a51addddbd4so294144866b.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581687; x=1713186487; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zAKZhYDSuQcqPl1qjLpWz1cUc8FnuEEAUAT2nyBVm4Y=;
 b=rRVw4LY5KZi9w79/VG2HSxLmRacMsKRn5EaOIV2tTzja5ylDcVO9EyJMCizoGMI4P1
 CRwi40ufDkOTIr8mWVmQFw4Ev0z/Q9ApacTFN8kg9z6tWKGVgq+0v6hD1C7MORQJE80m
 Dw4UA0dq8FEdCKZ8Duek14evQF1uQ7/H0eXiMXlWTgE6rpOBSgWoG02R5Y8SB3H3G/+j
 PoCzyH+nih+F4GmCPmI2VoPj/PL0S+9i3alxM19Qu08tVhfjAXwPseeynZyYgja83Ym5
 JXWg0exs5BAae2zMcr7bTao3drXZI0gGdCaWYIYdG76dR6FY3zGwbxj/B1F/kkj8GTuZ
 1KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581687; x=1713186487;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAKZhYDSuQcqPl1qjLpWz1cUc8FnuEEAUAT2nyBVm4Y=;
 b=EERuDHlksh0djuNrrk9oBl/aIGi/R//YRWwr0+cX3JQ69KGhu90lBDxfxHZ4DGu7Br
 0lTbkDG6ZbrTVmp2OYtLGzC1njIjQwdDtJRT+pfHRJA6N5tCflfDTQGwM2DWZ3INc7+D
 iSbhDCZe+qW8PgundJNHvkDaMPCY1zuZkR+MhIVkX2+8GM+vwFPEqgENHxGTCzQKFw8T
 1XI6NcBZskddp2wUeRfuBpAfXqredGg/H+nJaAeD7KXHgDpR0UY+ohsa7CqL9Sc1F0sv
 nmKRIYjRlWV/cD5jVrbSXWlZGnP1YI8otHt5booOQt3ZSUEy/iGD2/ZsSJi8dg08HBHu
 YNPA==
X-Gm-Message-State: AOJu0Yy1wmCSw60EvNXPB/NfOLAUP/anqdgrOd8NkhhV1bxxBq95WHcn
 nVP14wmaEcNy9duzHWXQe+14O64ca+wp6msRb3qKsT9sBRSZtL7Wa/1wGMV0AkM=
X-Google-Smtp-Source: AGHT+IHfBctIlVbgSdDIt5N3kjKtM3CCSwMIs53FoQMYluwFzFrwRL08gVtxr3aJLGxC52jML0MLfA==
X-Received: by 2002:a17:907:9810:b0:a4e:299f:7f4f with SMTP id
 ji16-20020a170907981000b00a4e299f7f4fmr6517050ejc.48.1712581687092; 
 Mon, 08 Apr 2024 06:08:07 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170906844b00b00a4e23486a5dsm4394815ejy.20.2024.04.08.06.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:08:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:07:40 +0200
Subject: [PATCH 2/4] pinctrl: qcom: add sm6115 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-2-900db37b8bdf@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5760;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=EiH6heaJx3ch02x6lG1mmDB6rdmgcxf+so3ByUaPDzk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+w0+NCjFhK7JzgXYP6Hcm6OA10UCe2rhlK/l
 /qwYkwxQFiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsNAAKCRAFgzErGV9k
 tkoyD/kBfWUmqvdCgwdZxjnooIzlPnH9QYQs034mY6eU7S63TAOJvB8uHjKKuUOPP3UzFc2aODw
 lUvxZku/Re0Ijdm45qLBWVIksefNX2irUDAkI915mn33pHbO+GzGT78nik38kYspgNPhGpP8CY4
 rqUiQI09vhIFyiyn5GIT87aw3klkGimGaIxWaQvq8kzr5P7gJsLcIjAQl3vYXDsDHZEa8DGKb0+
 J1xwH/A76PLT8wnfUPPZainWV1I+TuB5JU4SV1a4Tjh4A+RqUvyTQ0cnSqnLW85fh8Y6cT+HSJH
 b5fL2SZpaQrg8wtMPQo6FLEwmUNhRGP7fHy3cYzfzKYI/FCayuFdDjEpBs/peelT0Vi/rRP7Rg7
 sC1mLn/HqL1nFZUbg6KS3SGKMOIsFCiT1QyUExTiw733k2bCIjRT7QzjQk1QANUvNTlPWUf99Fn
 gfQtHAvCEHq5Q+jAtiBks3MGUiwHbfiOG2KoYBBaTcUd+ZTtl3p5FXrOjkz+1ptzHoCojFaT64q
 wYbLPSYMjuBMPYgRWBCuMEdstIbrW3fZSeskj3CbILhrPdfWP0+uvOmz7nx91nHoSNAgrUzvBsM
 ohb4K2S3n000D72PqbzruJ/zVY/D3rgTV3Hf9F9yLkc+0W+9Mi0lIvhaRI1VJ8HsFETfCZ9f1se
 Pd2u/raMN7rkiJg==
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

This SoC features a pinctrl block with west, east, and south tiles.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig          |   7 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6115.c | 197 ++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 35140efd5b62..e7a9853ce47a 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -47,7 +47,14 @@ config PINCTRL_QCOM_SDM845
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SM6115
+	bool "Qualcomm SM6115 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 0b1d610ea3e8..f00c4e6e10cc 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
+obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115.c b/drivers/pinctrl/qcom/pinctrl-sm6115.c
new file mode 100644
index 000000000000..740931a74104
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm6115.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm sm6115 pinctrl
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
+#define EAST 0x00800000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{ "qup4", 1 },
+	{ "gpio", 0 },
+};
+
+static const unsigned int sm6115_pin_offsets[] = {
+	[0] = WEST,
+	[1] = WEST,
+	[2] = WEST,
+	[3] = WEST,
+	[4] = WEST,
+	[5] = WEST,
+	[6] = WEST,
+	[7] = WEST,
+	[8] = EAST,
+	[9] = EAST,
+	[10] = EAST,
+	[11] = EAST,
+	[12] = WEST,
+	[13] = WEST,
+	[14] = WEST,
+	[15] = WEST,
+	[16] = WEST,
+	[17] = WEST,
+	[18] = EAST,
+	[19] = EAST,
+	[20] = EAST,
+	[21] = EAST,
+	[22] = EAST,
+	[23] = EAST,
+	[24] = EAST,
+	[25] = EAST,
+	[26] = EAST,
+	[27] = EAST,
+	[28] = EAST,
+	[29] = EAST,
+	[30] = EAST,
+	[31] = EAST,
+	[32] = EAST,
+	[33] = EAST,
+	[34] = EAST,
+	[35] = EAST,
+	[36] = EAST,
+	[37] = EAST,
+	[38] = EAST,
+	[39] = EAST,
+	[40] = EAST,
+	[41] = EAST,
+	[42] = EAST,
+	[43] = EAST,
+	[44] = EAST,
+	[45] = EAST,
+	[46] = EAST,
+	[47] = EAST,
+	[48] = EAST,
+	[49] = EAST,
+	[50] = EAST,
+	[51] = EAST,
+	[52] = EAST,
+	[53] = EAST,
+	[54] = EAST,
+	[55] = EAST,
+	[56] = EAST,
+	[57] = EAST,
+	[58] = EAST,
+	[59] = EAST,
+	[60] = EAST,
+	[61] = EAST,
+	[62] = EAST,
+	[63] = EAST,
+	[64] = EAST,
+	[65] = WEST,
+	[66] = WEST,
+	[67] = WEST,
+	[68] = WEST,
+	[69] = WEST,
+	[70] = WEST,
+	[71] = WEST,
+	[72] = SOUTH,
+	[73] = SOUTH,
+	[74] = SOUTH,
+	[75] = SOUTH,
+	[76] = SOUTH,
+	[77] = SOUTH,
+	[78] = SOUTH,
+	[79] = SOUTH,
+	[80] = WEST,
+	[81] = WEST,
+	[82] = WEST,
+	[83] = WEST,
+	[84] = WEST,
+	[85] = WEST,
+	[86] = WEST,
+	[87] = EAST,
+	[88] = EAST,
+	[89] = WEST,
+	[90] = EAST,
+	[91] = EAST,
+	[92] = WEST,
+	[93] = WEST,
+	[94] = WEST,
+	[95] = WEST,
+	[96] = WEST,
+	[97] = WEST,
+	[98] = SOUTH,
+	[99] = SOUTH,
+	[100] = SOUTH,
+	[101] = SOUTH,
+	[102] = SOUTH,
+	[103] = SOUTH,
+	[104] = SOUTH,
+	[105] = SOUTH,
+	[106] = SOUTH,
+	[107] = SOUTH,
+	[108] = SOUTH,
+	[109] = SOUTH,
+	[110] = SOUTH,
+	[111] = SOUTH,
+	[112] = SOUTH,
+	/* Special pins */
+	[113] = 0,
+	[114] = 0,
+	[115] = 0,
+	[116] = 0,
+	[117] = 0,
+	[118] = 0,
+	[119] = 0,
+	[120] = 0,
+};
+
+static const char *sm6115_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm6115_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	static const char *special_pins_names[] = {
+		"ufs_reset", "sdc1_rclk", "sdc1_clk", "sdc1_cmd",
+		"sdc1_data", "sdc2_clk",  "sdc2_cmd", "sdc2_data",
+	};
+
+	if (selector >= 113 && selector <= 120)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 113]);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int sm6115_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+struct msm_pinctrl_data sm6115_data = {
+	.pin_data = {
+		.pin_offsets = sm6115_pin_offsets,
+		.pin_count = ARRAY_SIZE(sm6115_pin_offsets),
+		.special_pins_start = 113,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sm6115_get_function_name,
+	.get_function_mux = sm6115_get_function_mux,
+	.get_pin_name = sm6115_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = { { .compatible = "qcom,sm6115-tlmm",
+						       .data = (ulong)&sm6115_data },
+						     { /* Sentinal */ } };
+
+U_BOOT_DRIVER(pinctrl_sm6115) = {
+	.name = "pinctrl_sm6115",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.44.0

