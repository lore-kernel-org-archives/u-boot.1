Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B4DC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3360780FF0;
	Thu, 20 Feb 2025 22:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C6wOyWPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6199180F53; Thu, 20 Feb 2025 21:59:09 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE17380F5C
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22114b800f7so26849945ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085145; x=1740689945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oqe8ctvKUO8g4sgneoPY2lMjaiJRhsU1wz4QbcA8Uok=;
 b=C6wOyWPmFts0rxrCHA5dumZRC5ozj4kHjojStAOSEUNAFChignsYzIOBbqf+M8g0wH
 mLZ5YzTF/QObvHVC/VTrGiEIWV4his2S1fVJHYvAxRy0Qz+sA7WSq6jIhmZ9tkPOYj36
 +HSEx2mScBWiaztosm+M/tP0U4/NrRVkV8Gnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085145; x=1740689945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oqe8ctvKUO8g4sgneoPY2lMjaiJRhsU1wz4QbcA8Uok=;
 b=k8igBuJBSkhjmgsqfLYG5LM8J4FLFxbrayezMQiWfQa7oE600UUdoTMjLxVErhsbxy
 WKDNP3E/d9Povs7XiXqEpl3KSLO/e3HBBuOGADJszGqIAkEw0CsF16T1RTJY9gZTDmnG
 XJBPSRyKpx7h/qfyix3r52eXD0v/XhJ7SEje/jaW5afMGXw1oqBS4iCsbOg/NbgO9LKh
 zHB/QNsczl6sL5wp1a8dzHzHd9inZ8eHWIBwRW51SBzpsBf/h3tSfqFTIPL3T3TKHGi4
 riDjIru4Xx6ub/VGe8xhdc5raV3CyOQFRNVuhYti73ClyaPFh09P6qtTXskWvlgba+jP
 k6xw==
X-Gm-Message-State: AOJu0YxLqnwYH+1bZVrm1/hKFEsAVGfEuZwBIHgftUErZVZxoyEzlr+2
 JRy8uCfDEm/D8RcneNDbd7A5De3seB81fl7AQYnGG0M/eQbHzf70Jy8TguV6BS1BnVOq1Fx344g
 =
X-Gm-Gg: ASbGncuhZvYg9+T1SnlrhiEAXj1CbLoBTgOBscblvWEGb2MBpx51anWpxCJOJ7QPaDH
 vW447HZ8fSAmasAiXKVkocuqpsSV/b/T+OwQIO3PvGyIcLbC5a1lc7lgSR229/bEO2AHJvX9I13
 qfscR8dmAJPCakNMGnDdyzlxRDxzkBlZo3Z96BwLsCwkToKBKwH5DAxRRmX4bMDcbN9hrcsn2Jq
 TMmIKgLHr+sLB93s6bb3FvDUn0hknj2EZzxRW5yimChP3RwKEFdT+tD/CTVWpVnsLltTzaXqdxi
 ZkR5rKkHJjN9PmR7uqeHMvAhokncyEodRaRn2ATTWLflzkEBVhrdCD4=
X-Google-Smtp-Source: AGHT+IEGNqhA4DUmD2diM2rqgge8B231enHZE34J3Wa4yRWqEUv2Aqnadc7RhiJNLDkoSsgDaaMImA==
X-Received: by 2002:a17:903:32c2:b0:220:cddb:590f with SMTP id
 d9443c01a7336-2219fff43f7mr7295495ad.50.1740085145096; 
 Thu, 20 Feb 2025 12:59:05 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73277ef2b66sm8819200b3a.171.2025.02.20.12.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:04 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 02/12] pinctrl: qcom: Add driver for sc7180
Date: Thu, 20 Feb 2025 12:58:44 -0800
Message-ID: <20250220205900.3127680-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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
 drivers/pinctrl/qcom/Kconfig          |   7 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c | 106 ++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 4f93a34281d5..85f6d72aa7da 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -41,6 +41,13 @@ config PINCTRL_QCOM_QCS404
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SC7180
+	bool "Qualcomm SC7180 Pinctrl (TLMM)"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SC7180 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SDM845
 	bool "Qualcomm SDM845 GCC"
 	select PINCTRL_QCOM
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 43d0dd292225..294848db8092 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
+obj-$(CONFIG_PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
 obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
new file mode 100644
index 000000000000..1edc74e5da95
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
@@ -0,0 +1,106 @@
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
+static const char *sc7180_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sc7180_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	static const char * const special_pins_names[] = {
+		"ufs_reset",
+		"sdc1_rclk",
+		"sdc1_clk",
+		"sdc1_cmd",
+		"sdc1_data",
+		"sdc2_clk",
+		"sdc2_cmd",
+		"sdc2_data",
+	};
+
+	if (selector >= 119 && selector <= 126)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 119]);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static unsigned int sc7180_get_function_mux(__maybe_unused unsigned int pin,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].val;
+}
+
+static const struct msm_pinctrl_data sc7180_data = {
+	.pin_data = {
+		.pin_offsets = sc7180_pin_offsets,
+		.pin_count = 127,
+		.special_pins_start = 119,
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

