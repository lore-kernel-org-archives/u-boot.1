Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C75C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD5887771;
	Tue, 28 Nov 2023 17:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lhsLa1x9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9178776F; Tue, 28 Nov 2023 17:30:56 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6627D87753
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b4a8db331so10020455e9.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701189052; x=1701793852; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4jQx3qy4oEoXbaaicwhgrHVKD/HjDDuA+Ik7RdHhjic=;
 b=lhsLa1x9C7Z/Ju6K95iRgnkYi6+GNb+wicYZXpU36jZy6lNhtpDs18PlYRTwJ2Tn7v
 PAdC0O+WzQN729pqke17Dd5+Pw8zHoAeZ/+3jY4xiwzPhKg49w91zQXoM1fb9CAwZjPx
 CQBGMcokH+Z9DDnMaoW+EYuTwJmKda5e5VPpCG4LppLQCtitcWMY/Kwn1YAFs+rwyqIi
 SG5TekXWyPfaRm2HhamsOnyMLwBv0hGt8UWLnL5RiNiRfGh80tBqhl3RAZIRel5Ev9sx
 IzLeA9PgC0i5kwK+nOLoN5Zw7VjZoffV2mS6eCOi66X9TzsHwWk1b0K/cMDcT91+dGwv
 1alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701189052; x=1701793852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jQx3qy4oEoXbaaicwhgrHVKD/HjDDuA+Ik7RdHhjic=;
 b=xEU/c10w1FHRO3OlKiUH8oJTb7GExBHqYEeYZDQExthD0OAeacE+yh1K1SwB7sy6eM
 H7Nlfdi5qm0ajp37M1lMOTTBSHTD/THX04QvoWxffJqJM5pCoEEAVoKLCqdQBzzdgEER
 9jNqePg1yaGODHEz+MzUjjQDy1uYEmwzw/V9j8L58d7HpmHglbmqXUbcpVMkgKphSP7k
 DePd4kHpGHns0j8Iuz6HQvEc413wWlpeMxUxGDO1QzMagIunDzonyHa//yza5OTLSn46
 j7N2llwKNyAuTurSDcBc6ToB8b9xfA5aqvK/cEAanT6mfELunCZbh0bkrFsP+pl/cO7C
 +ung==
X-Gm-Message-State: AOJu0YzmRztDLGRJHrk9kRFx0eFbf15zimDSpGJWKxPAwTwliXULWbuA
 WAbCNXLliz7RcfyQKp2Mw2Et8SgNukQGk2eTO3a/Ow==
X-Google-Smtp-Source: AGHT+IHcnvWort8GB2S3bJdXGihaYkICtDc82wh7e0mLT37TdtxdrpFJWCd3+KKvGOVIEY88cqtJ4A==
X-Received: by 2002:adf:e352:0:b0:333:db9:47d2 with SMTP id
 n18-20020adfe352000000b003330db947d2mr1707911wrj.66.1701189052727; 
 Tue, 28 Nov 2023 08:30:52 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d21-20020adf9b95000000b003316debbde4sm15530041wrc.48.2023.11.28.08.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 08:30:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 28 Nov 2023 16:30:27 +0000
Subject: [PATCH v4 3/5] gpio: qcom_pmic: fix support for upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-b4-qcom-dt-compat-v4-3-949d0982d1de@linaro.org>
References: <20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org>
In-Reply-To: <20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4023;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=RkiyMNLxdULm4u53lAkdye3P6jXX+KjMEsZQXapXVyA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ00e1qKu3/z8ydzBrbwrVHTaPp3f7cG9GaMc+Wf19VE
 Cil4v2+o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEykdh/DX3HX6ZEb7bsZG+P1
 JTYZPbjPu0n2ssXMk2zrnwSnbtx1dCYjw8qMJ43lB/UeFU9QEL2zVMans/nPP81/WW/2LdyZd1n
 0yH0A
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

Linux devicetrees use the "gpio-ranges" property, add support for
parsing it instead of "gpio-count" so that upstream DTs can be used with
U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts |  3 +--
 arch/arm/dts/dragonboard820c.dts |  3 +--
 arch/arm/dts/qcs404-evb.dts      |  2 +-
 arch/arm/dts/sdm845.dtsi         |  3 +--
 drivers/gpio/qcom_pmic_gpio.c    | 38 ++++++++++++++++++++++++++++++--------
 5 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index c41fee977813..6a4e3ccf17b1 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -170,9 +170,8 @@
 					compatible = "qcom,pm8916-gpio";
 					reg = <0xc000 0x400>;
 					gpio-controller;
-					gpio-count = <4>;
+					gpio-ranges = <&pm8916_gpios 0 0 4>;
 					#gpio-cells = <2>;
-					gpio-bank-name="pmic";
 				};
 			};
 
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index 0d9c9f7a4922..146a0af8aafe 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -132,9 +132,8 @@
 					compatible = "qcom,pm8994-gpio";
 					reg = <0xc000 0x400>;
 					gpio-controller;
-					gpio-count = <24>;
+					gpio-ranges = <&pm8994_gpios 0 0 22>;
 					#gpio-cells = <2>;
-					gpio-bank-name="pm8994.";
 				};
 			};
 
diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
index 84224a8a3d39..3bb580ba4e17 100644
--- a/arch/arm/dts/qcs404-evb.dts
+++ b/arch/arm/dts/qcs404-evb.dts
@@ -378,7 +378,7 @@
 					compatible = "qcom,pms405-gpio";
 					reg = <0xc000 0x400>;
 					gpio-controller;
-					gpio-count = <12>;
+					gpio-ranges = <&pms405_gpios 0 0 12>;
 					#gpio-cells = <2>;
 					gpio-bank-name="pmic";
 				};
diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index cd5d890e9a45..a26e9f411ee0 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -103,9 +103,8 @@
 					compatible = "qcom,pm8998-gpio";
 					reg = <0xc000 0x1a00>;
 					gpio-controller;
-					gpio-count = <21>;
+					gpio-ranges = <&pm8998_gpios 0 0 26>;
 					#gpio-cells = <2>;
-					gpio-bank-name = "pm8998.";
 				};
 			};
 
diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 7b83c67fa464..1adc6566a36d 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -245,23 +245,45 @@ static int qcom_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
+/*
+ * Parse basic GPIO count specified via the gpio-ranges property
+ * as specified in Linux devicetrees
+ * Returns < 0 on error, otherwise gpio count
+ */
+static int qcom_gpio_of_parse_ranges(struct udevice *dev)
+{
+	int ret;
+	struct ofnode_phandle_args args;
+
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
+					     NULL, 3, 0, &args);
+	if (ret)
+		return log_msg_ret("gpio-ranges", ret);
+
+	return args.args[2];
+}
+
 static int qcom_gpio_of_to_plat(struct udevice *dev)
 {
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	int ret;
 
-	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
-	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
-	if (uc_priv->bank_name == NULL)
-		uc_priv->bank_name = "qcom_pmic";
+	ret = qcom_gpio_of_parse_ranges(dev);
+	if (ret > 0)
+		uc_priv->gpio_count = ret;
+	else
+		return ret;
+
+	uc_priv->bank_name = "pmic";
 
 	return 0;
 }
 
 static const struct udevice_id qcom_gpio_ids[] = {
-	{ .compatible = "qcom,pm8916-gpio" },
-	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio" },
-	{ .compatible = "qcom,pms405-gpio" },
+	{ .compatible = "qcom,pm8916-gpio", },
+	{ .compatible = "qcom,pm8994-gpio", },
+	{ .compatible = "qcom,pm8998-gpio", },
+	{ .compatible = "qcom,pms405-gpio", },
 	{ }
 };
 

-- 
2.42.1

