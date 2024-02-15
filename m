Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46C4C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB0087EF6;
	Thu, 15 Feb 2024 21:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fyCBd2Jt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41C187F44; Thu, 15 Feb 2024 21:53:11 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC3987E86
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-411d231ea71so10391345e9.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030355; x=1708635155; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R0kFbeejCuT/GZe/lYkO7yMHcAX15oeReIjH/Ny6yjk=;
 b=fyCBd2Jt15KAkDYNuZs9YOlI4LltRGpPFLIMPuU7ISz/LVKPU+MGJXZBQAuOCbdzW6
 QY8xhiTgR/lV5k+1sPotFy/ypS/Lmil+o3GB5Yb01TWtksOSCs3ulDTwfcmVV5FUbnJz
 JhK6bZlDm9QkzWsd1qP2zOFuqW2j/FoXzZyAzDTHdarJ1mVM2XhsEMjaGaRYdyoNT3bw
 uQrAeHOKQSlR+EfxxQ6b4WxUT1F7S8j7KX28mrduWyyG9RDkQLGc35sjwgCLzj1KwO8Y
 UTu0t57a1aFCTGTiRiFKQw5d7czSAq4krQiDdJgp66qlNXo9Uz4uQD+5j3g4QDBLolYc
 BLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030355; x=1708635155;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0kFbeejCuT/GZe/lYkO7yMHcAX15oeReIjH/Ny6yjk=;
 b=CPNi1E0Th5pWgJGa5MUknmn1k5fulrDT8FxWyq1mw9s6Fnl4afCAoSMy3OaVAVXeP3
 oh/p3CgRA5BmteEEDOmreu6GyFWkJtgtqsc201d02uil52gSfjKmTphS+VIj+7iHkbRD
 PWY+JCEhxIYsL5w07MVbW1pwF5cXEAgnTcFFVUP46OjpKEY8VQ4QQBMvOzmI1cW0rH/V
 vY7bD//SCKTJ5BNBXpZdQtV5GPP8UK5nn4N5lMpgB6rP2YjfsfUBVzroCne/xlZWfvEy
 OBQ2BhbC6JwebmWOTcoto16lMBrxhm7m/JjHt1dFOuIisEMwqCiBDghL3LDFJU4fQ15R
 L++w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsT/hOkuOAkvXkNrkF66d+mMqt7DfC7PkpoLa7wZP1bSqr7vC5fJcsBd7qY5BEIvC/R2uSL/6nd7Frq61NOjIBKgriiw==
X-Gm-Message-State: AOJu0Yylvpzd09Wu3vBYJy1RT2H4y5oYQ7MetclNegX0/KXHfASCnFT4
 QhLlx+sRigUIwVixdc+vNubdLCtTpAOtRSU23gwBxZmGY1XFZO8FdmxvyQjAAhbFCAxKo93DoLG
 W
X-Google-Smtp-Source: AGHT+IERCWqiFpj7Ad9gxatUbRU2UF5PD6lCEUSt0OHz971iKZgn4wm9DbkG1xd+2SUC8o3LJbtK/A==
X-Received: by 2002:a7b:c850:0:b0:40f:ed18:f74b with SMTP id
 c16-20020a7bc850000000b0040fed18f74bmr2264479wml.35.1708030355142; 
 Thu, 15 Feb 2024 12:52:35 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:34 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:28 +0000
Subject: [PATCH v4 10/39] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-10-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xdStU/W+T5cpkGEsLGe473/TzSYkvUKiMzCleKraZX0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS01r19vvmjbdM5QYsreXj7tXc5OC+Zf5Xq678u7s
 hnNEZ2GHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi2WKMDIu1N87Ya9K4UmuC
 GI+WRbMnY8u9190sGueCHJhXB4Zl6TP8D/dZfNpkzi4VuY7y3y/vRbJfNZwlGLJixjyJJx2ek/4
 KHwAA
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

Some platforms hard reset when attempting to configure PMIC GPIOs. Add
support for quirks specified in match data with a single quirk to skip
this configuration. We rely on the GPIO already be configured correctly,
which is always the case for volume up (the only current user of these
GPIOs).

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 2a4fef8d28cb..198cd84bc31e 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -64,6 +64,15 @@
 #define REG_EN_CTL             0x46
 #define REG_EN_CTL_ENABLE      (1 << 7)
 
+/**
+ * pmic_gpio_match_data - platform specific configuration
+ *
+ * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them
+ */
+enum pmic_gpio_quirks {
+	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
+};
+
 struct qcom_gpio_bank {
 	uint32_t pid; /* Peripheral ID on SPMI bus */
 	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
@@ -75,7 +84,12 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
 	uint32_t reg_ctl_val;
-	int ret;
+	ulong quirks = dev_get_driver_data(dev);
+	int ret = 0;
+
+	/* Some PMICs don't like their GPIOs being configured */
+	if (quirks & QCOM_PMIC_QUIRK_READONLY)
+		return 0;
 
 	/* Disable the GPIO */
 	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
@@ -304,7 +318,7 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
 static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8916-gpio" },
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio" },
+	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pms405-gpio" },
 	{ }
 };

-- 
2.43.1

