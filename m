Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771DBC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C8A87F78;
	Mon, 26 Feb 2024 18:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bbVMaUkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0038387FCE; Mon, 26 Feb 2024 18:26:46 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7967D87F48
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41296dce264so22700165e9.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968395; x=1709573195; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g6K4OQ8hcQmgPiqssAjfXnKQuvmhbhjHWz0/91brEKc=;
 b=bbVMaUkxQjPi46x08Y3f7ETZHX+RkCr5KwQyY804RCZYbBlElMq1KtGDo261s2Yszx
 UE7HZvrsiDQ8CwczIstiCWbkH6/z2ZvUum1Qp6Q5WUlViSk2vbIM34m8qODI9GlSgYn7
 3QZpcEuele49lkeb9yUwbZEviv8t7FCCM488R/Z3KDnQ8E9oGWnKbEkWTwnd80SP/E+D
 0JtYAA4CBx9WcOvVBFTL0qJVdzQEeXHORNzhiBYkfXRwSWqEpC82M1nK9FMn7YEsNuyW
 CZaWqhOF3XCAZ3vQeTPqDO7fjLDCM8VIEBXC1EyohPfXUqV1Cn+0bddQ5PU96FJVEOan
 gIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968395; x=1709573195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6K4OQ8hcQmgPiqssAjfXnKQuvmhbhjHWz0/91brEKc=;
 b=PxkqxL3bS4jAnaeEjtfoMEeM3Ga347gcGYhP7q6z0mP/5p+Uuj2D+SDix1zrudln1I
 QxjuuIUwvAXQEn4UnUTii0k9O3TIzl4dvOKmoeop+aoZ8VDsiON419/+GDnFGizjpSl4
 Ob9VDuW78Htvt/K+x9yHAfa0PpSFkn3MlSd5PMSE3S5jDL4mW0NN/IZx2Ig7qODOr5Ws
 jnHm+nyAytZvs3zNopM9LhH8LwjxYdTGNyLkSC9s2bQAFPzMI4DBsJVoRw2KgXT0ls7j
 F3rNzyA+vgKcAHLWA/K91CCGfVXkt/B1G9h93HxzV6/oImsQfq8cXUJdS84OVnc6HecL
 jaYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXolkqqIY8OIzFz0thyMdrkcliYHMhDxUXlpJE3s5PtYrW56U1afCeR+iL13VPOnYg4vD8RJgfj1vINwxgZOLpB1oIYHA==
X-Gm-Message-State: AOJu0Yy1uaAQzCJuyfusKXD5x50jHz3bR2Y8p4iwvJS5STilJcZzApUl
 Y/hrJIMx3V4wzQd65s22DUMxMDeZMeAeWo6I0JMcggZ8uOZ4bULrj7WiQo2+Q9c=
X-Google-Smtp-Source: AGHT+IFHEo7FzfpJcezkJu5FjHpp6jsTd6QSLmy3xQykDdvrUSbfiSoUyTfIEiSqR2grd2E6M+3xNg==
X-Received: by 2002:a05:600c:5408:b0:412:9868:97ed with SMTP id
 he8-20020a05600c540800b00412986897edmr5651428wmb.9.1708968395023; 
 Mon, 26 Feb 2024 09:26:35 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:34 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:18 +0000
Subject: [PATCH v5 14/39] pinctrl: qcom: fix DT compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-14-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=7159;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=a3HaOZbOEJTyZRTSRtHc0/ojDiMxMVUaBhB+8NYHlWM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3cx5s3dNsNARV128/t/9pPymnvi9fc8/pSpM3dF7
 reZxf0dHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAizxUZ/pdtWRlbsPvZy0/L
 viS/2PfgR8uWdxq19X+fRSiKLjB9I8bByNB2LOrHQkW/f4VXUnTTJ9zr/6QVrLLHcInpokrnh/v
 NtscCAA==
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

Upstream devicetrees label GPIOs with "gpioX", not "GPIO_X", fix this
for SoCs where we're now using upstream DT.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c | 26 ++++++++--------
 drivers/pinctrl/qcom/pinctrl-apq8096.c | 16 +++++-----
 drivers/pinctrl/qcom/pinctrl-qcs404.c  | 57 ++++++++++++++++++++++++++++------
 3 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index c860b748e999..796c4b49d578 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -13,20 +13,20 @@
 
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 static const char * const msm_pinctrl_pins[] = {
-	"SDC1_CLK",
-	"SDC1_CMD",
-	"SDC1_DATA",
-	"SDC2_CLK",
-	"SDC2_CMD",
-	"SDC2_DATA",
-	"QDSD_CLK",
-	"QDSD_CMD",
-	"QDSD_DATA0",
-	"QDSD_DATA1",
-	"QDSD_DATA2",
-	"QDSD_DATA3",
+	"sdc1_clk",
+	"sdc1_cmd",
+	"sdc1_data",
+	"sdc2_clk",
+	"sdc2_cmd",
+	"sdc2_data",
+	"qdsd_clk",
+	"qdsd_cmd",
+	"qdsd_data0",
+	"qdsd_data1",
+	"qdsd_data2",
+	"qdsd_data3",
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"blsp1_uart", 2},
@@ -41,9 +41,9 @@ static const char *apq8016_get_function_name(struct udevice *dev,
 static const char *apq8016_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
 	if (selector < 122) {
-		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 		return pin_name;
 	} else {
 		return msm_pinctrl_pins[selector - 122];
 	}
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
index 75d1d0956a30..880df8fe3c74 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -13,15 +13,15 @@
 
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 static const char * const msm_pinctrl_pins[] = {
-	"SDC1_CLK",
-	"SDC1_CMD",
-	"SDC1_DATA",
-	"SDC2_CLK",
-	"SDC2_CMD",
-	"SDC2_DATA",
-	"SDC1_RCLK",
+	"sdc1_clk",
+	"sdc1_cmd",
+	"sdc1_data",
+	"sdc2_clk",
+	"sdc2_cmd",
+	"sdc2_data",
+	"sdc1_rclk",
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"blsp_uart8", 2},
@@ -36,9 +36,9 @@ static const char *apq8096_get_function_name(struct udevice *dev,
 static const char *apq8096_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
 	if (selector < 150) {
-		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 		return pin_name;
 	} else {
 		return msm_pinctrl_pins[selector - 150];
 	}
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index b54c8d80b8df..3a2d4685997e 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -9,22 +9,26 @@
 #include <dm.h>
 
 #include "pinctrl-qcom.h"
 
+#define NORTH	0x00300000
+#define SOUTH	0x00000000
+#define EAST	0x06b00000
+
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 static const char * const msm_pinctrl_pins[] = {
-	"SDC1_RCLK",
-	"SDC1_CLK",
-	"SDC1_CMD",
-	"SDC1_DATA",
-	"SDC2_CLK",
-	"SDC2_CMD",
-	"SDC2_DATA",
+	"sdc1_rclk",
+	"sdc1_clk",
+	"sdc1_cmd",
+	"sdc1_data",
+	"sdc2_clk",
+	"sdc2_cmd",
+	"sdc2_data",
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
-	{"blsp_uart2", 1},
+	{"gpio", 0},
 	{"rgmii_int", 1},
 	{"rgmii_ck", 1},
 	{"rgmii_tx", 1},
 	{"rgmii_ctl", 1},
@@ -36,8 +40,42 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"blsp_i2c_sda_a2", 3},
 	{"blsp_i2c_scl_a2", 3},
 	{"blsp_i2c3", 2},
 	{"blsp_i2c4", 1},
+	{"blsp_uart_tx_a2", 1},
+	{"blsp_uart_rx_a2", 1},
+};
+
+static const unsigned int qcs404_pin_offsets[] = {
+	[0] = SOUTH,    [1] = SOUTH,    [2] = SOUTH,    [3] = SOUTH,    [4] = SOUTH,
+	[5] = SOUTH,   [6] = SOUTH,   [7] = SOUTH,   [8] = SOUTH,    [9] = SOUTH,
+	[10] = SOUTH,   [11] = SOUTH,   [12] = SOUTH,  [13] = SOUTH,  [14] = SOUTH,
+	[15] = SOUTH,  [16] = SOUTH,  [17] = NORTH,  [18] = NORTH,  [19] = NORTH,
+	[20] = NORTH,  [21] = SOUTH,  [22] = NORTH,  [23] = NORTH,  [24] = NORTH,
+	[25] = NORTH,  [26] = EAST,  [27] = EAST,   [28] = EAST,   [29] = EAST,
+	[30] = NORTH,   [31] = NORTH,  [32] = NORTH,  [33] = NORTH,  [34] = SOUTH,
+	[35] = SOUTH,  [36] = NORTH,  [37] = NORTH,  [38] = NORTH,  [39] = EAST,
+	[40] = EAST,  [41] = EAST,   [42] = EAST,   [43] = EAST,   [44] = EAST,
+	[45] = EAST,   [46] = EAST,   [47] = EAST,   [48] = EAST,   [49] = EAST,
+	[50] = EAST,  [51] = EAST,  [52] = EAST,  [53] = EAST,  [54] = EAST,
+	[55] = EAST,  [56] = EAST,  [57] = EAST,  [58] = EAST,  [59] = EAST,
+	[60] = NORTH,  [61] = NORTH,  [62] = NORTH,  [63] = NORTH,  [64] = NORTH,
+	[65] = NORTH,  [66] = NORTH,  [67] = NORTH,  [68] = NORTH,  [69] = NORTH,
+	[70] = NORTH,   [71] = NORTH,   [72] = NORTH,   [73] = NORTH,   [74] = NORTH,
+	[75] = NORTH,   [76] = NORTH,   [77] = NORTH,   [78] = EAST,   [79] = EAST,
+	[80] = EAST,  [81] = EAST,  [82] = NORTH,  [83] = NORTH,  [84] = NORTH,
+	[85] = NORTH,   [86] = EAST,   [87] = EAST,   [88] = EAST,   [89] = EAST,
+	[90] = EAST,  [91] = EAST,  [92] = EAST,  [93] = EAST,  [94] = EAST,
+	[95] = EAST,  [96] = EAST,  [97] = EAST,  [98] = EAST,  [99] = EAST,
+	[100] = EAST, [101] = EAST, [102] = EAST, [103] = EAST, [104] = EAST,
+	[105] = EAST, [106] = EAST, [107] = EAST, [108] = EAST, [109] = EAST,
+	[110] = EAST, [111] = EAST, [112] = EAST, [113] = EAST, [114] = EAST,
+	[115] = EAST, [116] = EAST, [117] = NORTH, [118] = NORTH, [119] = EAST,
+	/*
+	 * There's 126 pins but the last ones are special and have non-standard registers
+	 * so we leave them out here. The pinctrl and GPIO drivers both currently ignore
+	 * these pins.
+	 */
 };
 
 static const char *qcs404_get_function_name(struct udevice *dev,
 					    unsigned int selector)
@@ -48,9 +86,9 @@ static const char *qcs404_get_function_name(struct udevice *dev,
 static const char *qcs404_get_pin_name(struct udevice *dev,
 				       unsigned int selector)
 {
 	if (selector < 120) {
-		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 		return pin_name;
 	} else {
 		return msm_pinctrl_pins[selector - 120];
 	}
@@ -63,8 +101,9 @@ static unsigned int qcs404_get_function_mux(unsigned int selector)
 
 static const struct msm_pinctrl_data qcs404_data = {
 	.pin_data = {
 		.pin_count = 126,
+		.pin_offsets = qcs404_pin_offsets,
 		.special_pins_start = 120,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = qcs404_get_function_name,

-- 
2.43.1

