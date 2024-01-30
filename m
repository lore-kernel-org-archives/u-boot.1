Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA1C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2906687E97;
	Tue, 30 Jan 2024 15:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uig8bhWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C088187DEA; Tue, 30 Jan 2024 15:06:08 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 711AF87ED5
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40ef6da20feso12617135e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623547; x=1707228347; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=avqKrHLwyid0MN1DV+VFGik2W8b2pB0dhYE68wKHW0g=;
 b=uig8bhWMevo7T6FhMRYcU6NluEafFVV8H9kZHcwqJRVZom4C2CzH+rtq6pDJPXPsVT
 4UFJmlLBnbesqp/P9Wo4FE8HlkbrASR0Z6SqGaw+PcAvqmwRXgBhPmWowumr5BwXmmZZ
 J9dYtYQ706fI1LlrSKB5MLx5E7xzDGxLklWBCaiTRmI5w3EdENmJfJ6ZyxMEuOPlPzQ8
 61923V3gar1ldTHKWXu2ZpNuwsbK3WTwjcmycKB7vJ+jAVRnHNh2u5jJzK0/sfnPSKH6
 bSpCh/uwGazn539T6/QoCGrH8z/45l7NwCEaW8KHJmjMOnB4VTZ7FFx6C9nzjNHt24tg
 K9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623547; x=1707228347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avqKrHLwyid0MN1DV+VFGik2W8b2pB0dhYE68wKHW0g=;
 b=TavnHNzGndEL8yFGA0B1MLePUls77jkJ8+hRfZ5fQJ2ZJS+dXeMzDtOTdELPNkeiAG
 fOkN+qou8moOOARb9pArJ4arkEMfES5xf220e/svHntA8E+djSu7qbSiIKBpz8Ib8fsU
 lJOxBAV7ueog9rQuM3mFqHW7NoybPOiVrC0jZeyjnWtnI8Wvo5yMvMnhM9Mukb0CT8dk
 YJqpfId0Me42dTgMYndWO+dq9Ti5GCUTfuA4E0/cxexhZ219tw5FfJ/0DN4VQuzcaveX
 YckthGOfOD/Ogq5FaNHQ1LjqVf2p/B8RqzGvD3CeFYVkd0Jp/etoR0rGCFlZGnLE9PF7
 xBTQ==
X-Gm-Message-State: AOJu0YwZyAoyr7aa66XknCpcxZAkpBxrjiMl9A4BENF4N7qiR3zPaVQz
 ErCCFEBc9W+k+1AegSOnDd3dQWjJUwg16rIFqN5WYpsuYl2TAHxsJrAtq6nUvUM=
X-Google-Smtp-Source: AGHT+IHDfJAiRhxU27EVCZmNJ1qNBHMTbBWNIbKv7OHGeHING4x4yXYv53Q6zfuFxk8o9aTd4EthiQ==
X-Received: by 2002:a05:600c:5491:b0:40e:6ca9:98a0 with SMTP id
 iv17-20020a05600c549100b0040e6ca998a0mr1779570wmb.15.1706623547042; 
 Tue, 30 Jan 2024 06:05:47 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:46 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:23 +0000
Subject: [PATCH v3 35/36] pinctrl: qcom: fix DT compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-35-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=tetrCOcVmh3zSJ7gD5X5FyE0LFpHNwXpgZhqPq7Pg40=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTMLK4d+zA+I4dA0Wqd1r/u3JuD/2yifdGh33C6ttP
 s0NSH7ZUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYyrZPhN5vQWa5nYYs+FzFO
 zFj49HWZ5Y6i2e7fmh42Hnyw+McPjakMfzg05f8VvjMRXv5SVM015N/56SICIee3x82YyvD/qsD
 1g8EA
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
 drivers/pinctrl/qcom/pinctrl-apq8016.c | 26 +++++++++++++-------------
 drivers/pinctrl/qcom/pinctrl-apq8096.c | 16 ++++++++--------
 drivers/pinctrl/qcom/pinctrl-qcs404.c  | 16 ++++++++--------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 8e698085d78b..bcff6abca4a0 100644
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
index ac00afa2a1f4..2718afc7859f 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -13,13 +13,13 @@
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
@@ -49,7 +49,7 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
 				       unsigned int selector)
 {
 	if (selector < 120) {
-		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 		return pin_name;
 	} else {
 		return msm_pinctrl_pins[selector - 120];

-- 
2.43.0

