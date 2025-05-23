Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2102C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D49B8347E;
	Sat, 24 May 2025 01:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WbXcL8U/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D4D883438; Sat, 24 May 2025 00:58:59 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4354E83340
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b27015122c4so197812a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041135; x=1748645935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LaRmE1XQnPRsKqyW0wtB65tM09tunv8VMS0SjGsOS4=;
 b=WbXcL8U/i0gJu4EdunLWHeTRfCWIfx/vtPkVLql8VDEhIsxRJmMkPbnW+Xd5bfbrzM
 0u7K64o7Zt7tCmvw8ac4ciao44OvjxgaBCWXpPxB4k15D0WVnw50LwjWKcVRdUuynz0Y
 0qSbe9Zivfl4FB7oUaYh4ahxnYwjUg0QVEoDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041135; x=1748645935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LaRmE1XQnPRsKqyW0wtB65tM09tunv8VMS0SjGsOS4=;
 b=jlphbB7FpMYR//TQ1pHutf+/gyNOVcNSENHR68S36E41xQK7a3YP7vceVFXIdgIFgr
 l3/c5r72HPo1ZGUKkkrlv/ECGFYaWION1R2kTYWXG7qJ/3Qig4Gb9KMoqBxkPKQAYOko
 Ex5RSpjZ3foB91p48uHmQaWkGKf6SYjVhwB3ZMaIaNooO59HEANxOco/wZOr5j9h/N0z
 SRtdgMXs0ucQv70Jmopg/UE/JkbJgqvfW56HF1zqtcaeJhVdbUyQN9qFfx5uPQ8kjMrP
 Npk7el8SWr9GJRTjnzFH0lum7OJuK6V6+SGiWAhQ3cCUCXBzrMUaWx3FL4/x1oUNUorK
 WCrg==
X-Gm-Message-State: AOJu0Yxjbn01jhLCVjCz8y0jX9vDvW9MV8woz659S1mJKTxQ3DjlsrNP
 Mis34sPQ5Gq1jZ4O9FiXBTBwHuXcgCYgvTBj1UVvEhXygZyN88ZaYOEnNTemzwMK1d0DWZlB3EX
 3Wo4=
X-Gm-Gg: ASbGnctYTMMcyKtJJjVjtctw0Al3BmyQs9xEHr8bKkLcVhxhjCgMvo4Zespe/utd4U+
 S1wtxFCSM0OiF3hNLXDYa/gV4uYFIfmli9vtTXquQGV85866gEhtZaLBMME8yOi/uhGBUImeTjG
 +ZrnTi4jmF6TN4ZZ72A1t2+JOFlAuw5l+7h4oOggLw/hCsMDyLS0qxoJNQn5JtrrxzIXMSrdYjv
 SimyCPqydpVVSVk6H9SDostYHuVGj6yxrjcu5bUBwLf/No5YdhBiU9caZUXXit/DVMesG0UNoM3
 +wkruQnncIX34S6W40mEKivFfXAVMtRWnW3WQSQncpFQv9Xa8WmlFsprKAF1Z2YWhOyEdTDApRA
 yQP5pkhHSbk3OAZQ=
X-Google-Smtp-Source: AGHT+IG0TsEDrVH9VYi9W3z8Xn9BqnIDkDyIzLs0Hp4NGnrbxtt15voapKnOrogTqddjnw2nLHq4gg==
X-Received: by 2002:a17:902:ec8a:b0:22e:4fe6:24f9 with SMTP id
 d9443c01a7336-23414f49efamr16552835ad.13.1748041135505; 
 Fri, 23 May 2025 15:58:55 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-233fe029abasm10787455ad.229.2025.05.23.15.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:58:55 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 05/28] pinctrl: qcom: Add driver for sc7180
Date: Fri, 23 May 2025 15:58:20 -0700
Message-ID: <20250523225845.2311989-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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
 drivers/pinctrl/qcom/pinctrl-sc7180.c | 133 ++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
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
index 000000000000..edb80cdd25ec
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm SC7180 pinctrl
+ */
+
+#include <dm.h>
+#include <dm/device.h>
+#include <stdio.h>
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
+	{ }
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

