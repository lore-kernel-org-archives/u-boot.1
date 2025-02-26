Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD42C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF180811B3;
	Wed, 26 Feb 2025 23:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H7tpQvmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359B58118B; Wed, 26 Feb 2025 23:16:18 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDFC80F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fc33aef343so704294a91.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608174; x=1741212974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T88J1jc/SgLp7bzdu/5QZq24u24WIWr+Z+ahJJ+GinM=;
 b=H7tpQvmWHW6y+DkhVBBpvRbq+Nwp2pxnnixNsP9BkH9prPALMtS6Hsb/H6igTHOzuH
 9cOhADBzmsii0WLbvJ8clvQ3R2EfVUqLShMczMC4U4l8HJUgW3kx8R4kKaYkmUvjeRN3
 ts3tdtpKUo3jv8/ntgkOkTD9ONiWwTnhCewR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608174; x=1741212974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T88J1jc/SgLp7bzdu/5QZq24u24WIWr+Z+ahJJ+GinM=;
 b=qXi3OoF29ZV5eifgKnovpkzmbIMB0pmPVgLe9ENjFNFv802JtdGbGha1ZzVmK5Ul1q
 TkzGe3sA/E8J9sTMvyUBnAFQd+aVvkTkrB8dDt1F/Ct08A3VC4YNsW2OHrypGEvv6mNU
 BwebmAdfro37Zr6IShSVkvai4u9+WJJBIC5CT3JSYzxdlJn25wLgWGg54GF05LNhEZq5
 2CYClZ50A7fxgao90FvK8Jb59TwdG3MpPaUxis3OTM6I4ypNDiIWcBPhf7/7/HWSnQRZ
 UWHaWWv493SFrnacHuLG+oE+8jry4WGU/0x2wmh3dvV5qwuT71Ms6xouPHcJPVowNAn6
 GOLQ==
X-Gm-Message-State: AOJu0YwnKTJsAMy5mLYDCxoG+usdn9o94auKfxlfKcWNUKZkWeQ2ybF9
 v65/RjLmd2rm9l2LRQ6UkNb8fz47pS7X+scIRvMPUy+IzfAnYsGAhur/M+tZI0gTVk26kUSFHeI
 =
X-Gm-Gg: ASbGncv0KALe1uFavbYoStcLMw8VVlPsv2DY3MnQZPEM+mIccAqHiXHNIsk9CugBFsC
 6N4NfBwDm/zOFHIOucJua/gMmd7AqY8o0Hs+8dSjzCyNPAbFGrtvH6IJNyvhN937xpwdy5sBUCL
 P2VFrWs3XmZCIEscHJt7OdZjbXzuOOaPiLpqRFbvWYyH21A7ukbXpXuH1D2CRtGpEAYJgqQpvfc
 XSddFc4gk9G9FHSlbzkVKGMY+6hZQg/7qIGm/+Gc1ahadOd9+WrIzW6NvmxTobN3gfR/YCZf/RR
 3INKjYqzlNevp1jSDqYWMcVeUXXRWM9EAVfO3D6Ln9z8YIC92CrBxf7S30M9qlrdJg==
X-Google-Smtp-Source: AGHT+IEEtMsL83yiBn7HZWBP4TYBXbTqbO/uuIdWgfNcOLbqo3Y/Z4jIgFqygfILefoyThudL5fjgQ==
X-Received: by 2002:a17:90b:2f4b:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-2fe7e21f8c8mr9713860a91.0.1740608173933; 
 Wed, 26 Feb 2025 14:16:13 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fe825d2be3sm2200001a91.27.2025.02.26.14.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:13 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 03/15] pinctrl: qcom: Add driver for sc7180
Date: Wed, 26 Feb 2025 14:15:49 -0800
Message-ID: <20250226221607.1283592-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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
index d3eb69985510..4772daba1ef3 100644
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
index 06d3c95f93a6..ac5dfd1feb91 100644
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

