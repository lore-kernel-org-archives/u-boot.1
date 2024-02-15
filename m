Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E29C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242C087F55;
	Thu, 15 Feb 2024 21:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jKrrvX+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F083787F44; Thu, 15 Feb 2024 21:53:11 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9746F87EBA
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d07ee22eeso42497f8f.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030359; x=1708635159; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jljmpNROP/ujLYOxOHZ5DIDbFvK6mXm9zJpTRfVAI/E=;
 b=jKrrvX+o+HVjrAJj9lYqvws13DThDV5Xr2Y5+5BTM8pOQNJO3Lc7OdoHuULtaIbXED
 q8jy+LPut6xBJdjrtn+Q3tireN6DePOq3f/SQ12UiWyBtQ9kyQWGacZE8ZFu57n/pzop
 u60Q6HWGpJGXfJxvTA5XdSLvQYYlztNwYE0pGEWIBHJDYAXPKh6SkEz69VRRvaz4IGFU
 Crrml/G+1ebfR0SW35LCdlD7Ego2jyj/jd7gJ/YWKOysmqm/gbk5+ZRHIgI97dKANQRl
 fPtHL4WKSvOkKSKjrzZHNPOrzftqGhwgT5aFcGqnmUMKUTPTu9sEQ+xgyvcVciAGo2Aj
 cQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030359; x=1708635159;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jljmpNROP/ujLYOxOHZ5DIDbFvK6mXm9zJpTRfVAI/E=;
 b=Ltg9g4zInwkmNwso0NMe+jxQ8fAjJKo2YySi7zuCZARqr2ngypYNGPBriUYFWGYOSG
 7+YGylh6PGGrUT12/H59IOerS8tj6+hlDRHyZp6ICWSugYquUReDfiOBUP4BX89BuLML
 7yDYfIPpQ5BDxgncbrk/UUFXQxA2SvbX0+oY0Evpc5vaKY8BBWrvmJ7FXwNvguiP/q+o
 8EcrY1rdOvmxhhryjkilNgayymesdjx83MyGuFOBplRxq8aSV//BJ4Q+G6NvxXtwheWl
 c2dyfkimY06UcMgObfok9mbfJkAQ0OVzbGMHipVXG3E2CDP8dAa+JL+bm3W6FPWA3SJq
 BtNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzfDLaB/A2dOiyEVlI1hXyNmFV6f2TVao80qh962TdVyhMivUyasfVWGech1G5NIaSFb6UVatEv64T3XgQMiNQKT/YZw==
X-Gm-Message-State: AOJu0Yx9v9K63pm5fFtaPHi10eu2p5s7ECnd2QJBVlrMyY36qOKunvZt
 9bEbxEgtJo5X2RTFRAgKmE4OhVbDl56IY9SsMQXwXBRKvgbuNoNfaKijbaWwZfoOvyv+P7jjPZT
 r
X-Google-Smtp-Source: AGHT+IHLDF8BxPECdTyvGhdtCBjpfe0K2PpklN4Qdo+mTak8N53lXRcQ2x3sVtYAf1KSUEoZsDE3Fw==
X-Received: by 2002:a5d:658b:0:b0:33b:641e:ff5d with SMTP id
 q11-20020a5d658b000000b0033b641eff5dmr1997441wru.27.1708030358792; 
 Thu, 15 Feb 2024 12:52:38 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:38 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:32 +0000
Subject: [PATCH v4 14/39] pinctrl: qcom: fix DT compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-14-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6700;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=CXU1dPgDhW2nR9gF0fpm0ywxckRm4UsmUZQejPeSRMw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzla3/w5gnf7iYKG6SG3FO+bU340On5se3ONoYv76sk
 TB0tvLvKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABMRZGL4n534s3Pr2V7L1HXz
 DPPdb90uyOdaLBPCebA4MuvzZ1arYIb/CQdXH+TgVy7Pblq6c+Na1ueuR71vn3F6f3CR8fF11Zb
 37gIA
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c | 26 +++++++--------
 drivers/pinctrl/qcom/pinctrl-apq8096.c | 16 +++++-----
 drivers/pinctrl/qcom/pinctrl-qcs404.c  | 58 ++++++++++++++++++++++++++++------
 3 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 8149ffd83cc4..10796710ba7a 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -14,18 +14,18 @@
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
@@ -42,7 +42,7 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
 	if (selector < 122) {
-		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 		return pin_name;
 	} else {
 		return msm_pinctrl_pins[selector - 122];
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
index d64ab1ff7bee..f2eeb4cf469a 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -14,13 +14,13 @@
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
@@ -37,7 +37,7 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
 	if (selector < 150) {
-		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 		return pin_name;
 	} else {
 		return msm_pinctrl_pins[selector - 150];
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index ac00afa2a1f4..5066f2bba6b3 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -10,20 +10,24 @@
 
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
@@ -37,6 +41,40 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
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
@@ -49,7 +87,7 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
 				       unsigned int selector)
 {
 	if (selector < 120) {
-		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 		return pin_name;
 	} else {
 		return msm_pinctrl_pins[selector - 120];
@@ -62,7 +100,7 @@ static unsigned int qcs404_get_function_mux(unsigned int selector)
 }
 
 static struct msm_pinctrl_data qcs404_data = {
-	.pin_data = { .pin_count = 126, },
+	.pin_data = { .pin_count = 126, .pin_offsets = qcs404_pin_offsets, .special_pins_start = 120, },
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = qcs404_get_function_name,
 	.get_function_mux = qcs404_get_function_mux,

-- 
2.43.1

