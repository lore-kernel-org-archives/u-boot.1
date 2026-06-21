Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC657CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 19:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32738499C;
	Sun, 21 Jun 2026 21:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VGEqhJWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF6484874; Sun, 21 Jun 2026 18:47:10 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD43E84119
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 18:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xerikasxx@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7e2fd65f968so35799187b3.3
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782060427; x=1782665227; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldboJQ2opZXPF2QT3G3a5Y1Pc2McCcUhG10c8BpavnA=;
 b=VGEqhJWKGid9usS30//yg3xF8M7hYk7A7HH1llGcogK+IXN8YY4RF77c+zKuVuivTJ
 drKTD+Ij95dYQwxjS0q4QkdOxMtK0lNsgPJ1dg9AU0tWileacG1/JHzWKLh4Wa8JFVWJ
 A22MIf1BmzkupghyWtD3fYeCxh2YJfBkjhNWpCv6JtcAaS4IBZlSFzrgA9Zjn4pfPkkO
 OxBX3538bPMN4VPXT8m+njmzhG/QqXTqvt/ZoAhh4edgAKpnrNnlt3l/r39BzkfMIsnK
 aFhF4uYV9zaoWOM50/5nV6r0UvL3nP19JQgIhzyEJco/UDPN4rYjvmRINEi9gROPpn7N
 /gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782060427; x=1782665227;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ldboJQ2opZXPF2QT3G3a5Y1Pc2McCcUhG10c8BpavnA=;
 b=NoL6ojeeoo+eFz9gJROmJjA/SUP5ssqn8mzj9iX9wFTvXZPdRuHZg+0oFIg+1xwYuG
 ppPn5jgLBA3X6fHE+tD+gzynLDgm1Z8gjPG8lbxCYEsHygdSK178hdkDEYKSgWM/aM4u
 c4g7xu9e1CX987QpgDNaGVpJzUJEmxysmrpY3Da7cssQgI/GFuI+YkugT809CAAiiMRL
 WCFUFZIgdfsagEtkOw+6TOuPfdqjLIiPk/p1qREanFl6RYjF/UHMjcvWBgtnMH2jOl5F
 FNOi6lWCBNSuYb/QkKEw/9B77EBqkSrdMEPapqAXi10O3msL6tenRYSPh/lCRuawtGNC
 vLpg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/yXOctpR8kdAUiv96/d6dTGhBDNwXU/DKb0BNRZTAUHDuXQXkBK2FRZj+EFBLrEpNRsxuswI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjjw2bn3gimOs7zE2H6D0fYPWqepzfcK5iRohzr+0HWDC1G2iA
 2gMdOiXY6G1VhgIt8AZq+OPxA5wkpQ8cAOZrIhGIOg/cms/ABWMBDwAU
X-Gm-Gg: AfdE7cnYhYg9Vx6oz+vbii5xJkycElnF5cSmLsj0eCbSNcJ7clyTpxjKDFdmaI/UmcQ
 jQr7beP0vKfjKMuOLAidQpXhWGDXcjsnW+De7mScOlud8v8zL0EO0jfImepYNoinHm6PsyxAY/F
 BjonzPDgUeBAIH1RzB7mF/uFXN5g08802O/6TKq/lIlF6n1V7pBOndKzl2XSOiYarRvLfOIg2kg
 00Bb+Ic7+gZpHZxj2N8FQ4n1g/O4nr6XhBVyK4O0n8stPrcrwzJW1cd5TtO0+dy5xVuEyyJncuv
 5yhxHHU4HZQc8qZmp5Mio6Quab9xADKGabpGKrTgduYUHsbebGmgqPPTegeFzuPcivpMYiFgW9+
 XI13tAzFiqAyTV49OzEcuSC3wP/z7Mj91ycRtcNoOd7gpcI59RWq/Natf2OT///G7OiSRJrOQ8u
 llA/Da4LcAR5HYAmOzrsSmuVrukQ==
X-Received: by 2002:a05:690e:43db:b0:660:265f:b4dc with SMTP id
 956f58d0204a3-66312e4df19mr5148663d50.28.1782060426596; 
 Sun, 21 Jun 2026 09:47:06 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314d8c3f1sm2498215d50.15.2026.06.21.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:47:06 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 21 Jun 2026 19:46:22 +0300
Subject: [PATCH 2/4] pinctrl: qcom: add SC7180 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-sm7125-support-v1-2-5ad69a39781a@gmail.com>
References: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
In-Reply-To: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 21 Jun 2026 21:02:28 +0200
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

From: Vitalii Skorkin <nikroks@mainlining.org>

This SoC features a pinctrl block with north, south, and west tiles
accessible to the AP. Add support for SC7180 pinctrl block.

Signed-off-by: Vitalii Skorkin <nikroks@mainlining.org>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/pinctrl/qcom/Kconfig          |  7 +++
 drivers/pinctrl/qcom/Makefile         |  1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c | 95 +++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 43100d5d981..8befcf24781 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -94,6 +94,13 @@ config PINCTRL_QCOM_SA8775P
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
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 87cb128c4d4..a7a9ad03569 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
 obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
+obj-$(CONFIG_PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
new file mode 100644
index 00000000000..5494094f2cb
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Pinctrl driver for Qualcomm SC7180
+ *
+ * (C) Copyright 2024 Nikroks <nikroksm@mail.ru>
+ *
+ * Based on Linux Kernel driver
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
+static const unsigned int sc7180_pin_offsets[] = {
+	[0] = SOUTH,   [1] = SOUTH,   [2] = SOUTH,   [3] = SOUTH,   [4] = NORTH,
+	[5] = NORTH,   [6] = NORTH,   [7] = NORTH,   [8] = NORTH,   [9] = NORTH,
+	[10] = NORTH,  [11] = NORTH,  [12] = SOUTH,  [13] = SOUTH,  [14] = SOUTH,
+	[15] = SOUTH,  [16] = SOUTH,  [17] = SOUTH,  [18] = SOUTH,  [19] = SOUTH,
+	[20] = SOUTH,  [21] = NORTH,  [22] = NORTH,  [23] = SOUTH,  [24] = SOUTH,
+	[25] = SOUTH,  [26] = SOUTH,  [27] = SOUTH,  [28] = SOUTH,  [29] = NORTH,
+	[30] = SOUTH,  [31] = NORTH,  [32] = NORTH,  [33] = NORTH,  [34] = SOUTH,
+	[35] = SOUTH,  [36] = SOUTH,  [37] = SOUTH,  [38] = SOUTH,  [39] = SOUTH,
+	[40] = SOUTH,  [41] = SOUTH,  [42] = NORTH,  [43] = NORTH,  [44] = NORTH,
+	[45] = NORTH,  [46] = NORTH,  [47] = NORTH,  [48] = NORTH,  [49] = WEST,
+	[50] = WEST,   [51] = WEST,   [52] = WEST,   [53] = WEST,   [54] = WEST,
+	[55] = WEST,   [56] = WEST,   [57] = WEST,   [58] = WEST,   [59] = NORTH,
+	[60] = NORTH,  [61] = NORTH,  [62] = NORTH,  [63] = NORTH,  [64] = NORTH,
+	[65] = NORTH,  [66] = NORTH,  [67] = NORTH,  [68] = NORTH,  [69] = WEST,
+	[70] = NORTH,  [71] = NORTH,  [72] = NORTH,  [73] = WEST,   [74] = WEST,
+	[75] = WEST,   [76] = WEST,   [77] = WEST,   [78] = WEST,   [79] = WEST,
+	[80] = WEST,   [81] = WEST,   [82] = WEST,   [83] = WEST,   [84] = WEST,
+	[85] = WEST,   [86] = NORTH,  [87] = NORTH,  [88] = NORTH,  [89] = NORTH,
+	[90] = NORTH,  [91] = NORTH,  [92] = NORTH,  [93] = NORTH,  [94] = SOUTH,
+	[95] = WEST,   [96] = WEST,   [97] = WEST,   [98] = WEST,   [99] = WEST,
+	[100] = WEST,  [101] = NORTH, [102] = NORTH, [103] = NORTH, [104] = WEST,
+	[105] = NORTH, [106] = NORTH, [107] = WEST,  [108] = SOUTH, [109] = SOUTH,
+	[110] = NORTH, [111] = NORTH, [112] = NORTH, [113] = NORTH, [114] = NORTH,
+	[115] = WEST,  [116] = WEST,  [117] = WEST,  [118] = WEST,  [119] = 0,
+	[120] = 0,     [121] = 0,     [122] = 0,     [123] = 0,     [124] = 0,
+	[125] = 0,     [126] = 0,
+};
+
+static const char *sc7180_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sc7180_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int sc7180_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static struct msm_pinctrl_data sc7180_data = {
+	.pin_data = {
+		.pin_offsets = sc7180_pin_offsets,
+		.pin_count = ARRAY_SIZE(sc7180_pin_offsets),
+		.special_pins_start = 120,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = sc7180_get_function_name,
+	.get_function_mux = sc7180_get_function_mux,
+	.get_pin_name = sc7180_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,sc7180-pinctrl",
+		.data = (ulong)&sc7180_data
+	},
+	{ /* Sentinel */ } };
+
+U_BOOT_DRIVER(pinctrl_sc7180) = {
+	.name = "pinctrl_sc7180",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};

-- 
2.54.0

