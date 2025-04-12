Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D119C369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 17:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4A582E7D;
	Sat, 12 Apr 2025 19:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rbS0mVVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDDA582E81; Sat, 12 Apr 2025 19:42:12 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B725282E28
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 19:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rui.silva@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so21461245e9.1
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744479730; x=1745084530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ClpbE4vbfE6icHgZKRO1lDV7vT9jnEYfSOgx1i9lL8s=;
 b=rbS0mVVX5mAG6bSBmgzuPN64/X4tOdHFYPlqtiTA7Av+GNan16zNWuFe415oAvJwJK
 uqY4B595yrb7uJob5+J2qJOsM7MxCbtz8qPMtJ//WsE9lQ6B1SVKm2OCIIYKmQhMlJ3p
 aEEtrGc6nmPBvqJMWqhbZuJIiPmSCxeG1tzKzGMIZ2blrVnp4iajVdJugUvrMkJby3k/
 HkykHU5qO9ZCJI1sUiiZzHY8WWoJT3jblXflG8nHgBQ5w0vhJuiZlNOd5MMI4oyxBz8A
 WQF8hHfA0haHmjpDnRL/EpY3Q8QnyRClBEEzuPIRzJkqMlFx0n+9DZ5r0mQIAXN5E7U0
 158Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744479730; x=1745084530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ClpbE4vbfE6icHgZKRO1lDV7vT9jnEYfSOgx1i9lL8s=;
 b=PgBI4RSo6PZgRvjf7s52fIfzhvstPaZd8P6J7Oq6Xjz7dShWUEY09ET9E147i65yuK
 98ewvERQlRxAUd/Hhs5o6FGZgG4nVHIQMUeKRr3oirPlvqJQ+dQRzCRhqQOunrdITUCH
 bA5DrnkzTooX9g/8R27JzXMWBiIVI8tczebLhGRzHYn+RIsFi7eIv6y8hqY11d5KL9SZ
 HWvUXz/o6aTL3BZY9IYzpEP6nZPmLLX0oS9XaKnZ2VHji6NxGWKfGei+fQBtGFQj0DNS
 qZIuRXdaDSeQchiN82inda+aHBqywveGNjG3DkSS9uJKZC+xD5gAbkflREFV10yfS/8C
 lapQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhDDkLrT4JEjjEU1jPDw5v9YJ1lVEk64d0u7+WjuECVrpqI/ujI5QDQiIRIqu2YGllwskWuQY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5E454AJrX/0F0yp3S6oFWyhi91Z9gQD98azzbM1xg9kYn/xXH
 Z5pV8n/k5a5Mf+LfwnhVdVmnkk3a/wd+HxyGbPypdJOWJVkn+FEu8Q5C+KEIU5U=
X-Gm-Gg: ASbGncsXXmY0dYGyW/Udc5K4t+ktlcTkWdcBLJeVf70s6BnEiZ5FcS4Y2vW0iE7jU+M
 +FiTwJjv5YW7kASn7wNopMxS+gNuACnsOXxr/oS3jnIg8tfvqOaoQc904uE39WNoMtQM7ss6K4a
 qQYExPku7HEXsiH5N5ERf+rAe8NRG2So+Z4oPx0pyral7T0uMDwdYPnZ+TcUglPM826Kbq0brQj
 z/177egyTfVoCLPahnYBLB2sEULqDMyUe+KXFsIGms08MLrh+WaUmTS5BeBDMuw+nr+AEH0nd62
 V8dP8w7DcvGGgnNXLXRXPdjkI/fNosFPLNj8Lf7s8/x12iMP7YZ7dmbm15GtokHvrzrH8VSo/nQ
 =
X-Google-Smtp-Source: AGHT+IHDJNS8QB9ivW+lcAts9gRMXqInAB7Gk+cpD8EGT5qVZewxaAxyy/FSmMlYtmJDcaahK+2zMw==
X-Received: by 2002:a05:600c:3c98:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-43f3a93cc56mr77384875e9.10.1744479730065; 
 Sat, 12 Apr 2025 10:42:10 -0700 (PDT)
Received: from arch-thunder.lan (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43d046sm5792143f8f.63.2025.04.12.10.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 10:42:09 -0700 (PDT)
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH] power: qcom_vbus_regulator: add and fix support for pmic
 variants
Date: Sat, 12 Apr 2025 18:41:31 +0100
Message-ID: <20250412174157.104419-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix and add support for different pmic variants pm8x50b to handle
the vbus regulator.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 .../power/regulator/qcom_usb_vbus_regulator.c | 37 +++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/power/regulator/qcom_usb_vbus_regulator.c b/drivers/power/regulator/qcom_usb_vbus_regulator.c
index 2d58ef5e111e..07f118d47977 100644
--- a/drivers/power/regulator/qcom_usb_vbus_regulator.c
+++ b/drivers/power/regulator/qcom_usb_vbus_regulator.c
@@ -15,14 +15,33 @@
 #include <power/pmic.h>
 #include <power/regulator.h>
 
-#define CMD_OTG				0x50
+enum pm8x50b_vbus {
+	PM8150B,
+	PM8550B,
+};
+
 #define OTG_EN				BIT(0)
-// The 0 bit in this register's bit field is undocumented
-#define OTG_CFG				0x56
+
 #define OTG_EN_SRC_CFG			BIT(1)
 
+struct qcom_otg_regs {
+	u32 otg_cmd;
+	u32 otg_cfg;
+};
 struct qcom_usb_vbus_priv {
 	phys_addr_t base;
+	struct qcom_otg_regs *regs;
+};
+
+static const struct qcom_otg_regs qcom_otg[] = {
+	[PM8150B] = {
+		.otg_cmd = 0x40,
+		.otg_cfg = 0x53,
+	},
+	[PM8550B] = {
+		.otg_cmd = 0x50,
+		.otg_cfg = 0x56,
+	},
 };
 
 static int qcom_usb_vbus_regulator_of_to_plat(struct udevice *dev)
@@ -38,8 +57,9 @@ static int qcom_usb_vbus_regulator_of_to_plat(struct udevice *dev)
 
 static int qcom_usb_vbus_regulator_get_enable(struct udevice *dev)
 {
+	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
 	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
-	int otg_en_reg = priv->base + CMD_OTG;
+	int otg_en_reg = priv->base + regs->otg_cmd;
 	int ret;
 
 	ret = pmic_reg_read(dev->parent, otg_en_reg);
@@ -53,8 +73,9 @@ static int qcom_usb_vbus_regulator_get_enable(struct udevice *dev)
 
 static int qcom_usb_vbus_regulator_set_enable(struct udevice *dev, bool enable)
 {
+	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
 	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
-	int otg_en_reg = priv->base + CMD_OTG;
+	int otg_en_reg = priv->base + regs->otg_cmd;
 	int ret;
 
 	if (enable) {
@@ -76,8 +97,9 @@ static int qcom_usb_vbus_regulator_set_enable(struct udevice *dev, bool enable)
 
 static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
 {
+	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
 	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
-	int otg_cfg_reg = priv->base + OTG_CFG;
+	int otg_cfg_reg = priv->base + regs->otg_cfg;
 	int ret;
 
 	/* Disable HW logic for VBUS enable */
@@ -96,7 +118,8 @@ static const struct dm_regulator_ops qcom_usb_vbus_regulator_ops = {
 };
 
 static const struct udevice_id qcom_usb_vbus_regulator_ids[] = {
-	{ .compatible = "qcom,pm8150b-vbus-reg"},
+	{ .compatible = "qcom,pm8150b-vbus-reg", .data = PM8150B },
+	{ .compatible = "qcom,pm8550b-vbus-reg", .data = PM8550B },
 	{ },
 };
 
-- 
2.49.0

