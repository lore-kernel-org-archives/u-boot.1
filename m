Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13538C4167B
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C448749A;
	Tue, 14 Nov 2023 14:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzxNRuus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329218745D; Tue, 14 Nov 2023 14:48:55 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F2A871E4
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c509f2c46cso79345561fa.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699969732; x=1700574532; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jI/l4CqgBGDD443rF4TTf/YO0j+k3/gQmH6HyMKvn1E=;
 b=nzxNRuusq0cMb91RPGlJBvQMQnS3AaWhzQfj8hJ3ajgw5S+uzIxMWbmdQquG/v8E9e
 jSF+v/hQeLxN9YEyCeIOW9iBxi8cB+oTsc01AOfiO9fszs73lRb2RHzJAK8U844Lmq+/
 PNEKVFRVcLw3J8VaDaCEBGQmZ64VaSuirhMSDXf/1HDZvzmx3jplH/jN0C6JIPXkDA3N
 T0QXI2lY7lvEM7ZcvX1eHXofh3JVxm/gr3q6Kwqg5Pl7dNG9makX0E4MF7ruiIUe/D01
 /rdHp2uwFrnzhHd4oeWkN4/Q+pTiuPiWWBEWso46XDsKxX6cUQpmVNr7b4bJSnriDF5X
 jiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699969732; x=1700574532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jI/l4CqgBGDD443rF4TTf/YO0j+k3/gQmH6HyMKvn1E=;
 b=XZYdu1YOa3zOCSiPvsmHknRkvxaYPGj70LWRZqRPvJnmARddmaorXLBS/yd0gyD6hl
 yqGgzYLwVsjKjNDtb2eH7QKfxN3AfrHWHdT9ZIVChtERrUcML3DWAfwhXNnmG2DGUhkj
 eacdFjof6aSCCm9r+JNKi4U2Pshw9aMqtNZJ2OzvXaU6x21p7uNuNshqPxuuA5O3RJRz
 DYVwwTQ5GQ006spNLgHXxX5A9+PAsP4XebjSGRdcxkkW65G4vMwjQLauIxreyooCMnXl
 CtV83ocNVVbThSZh65clD77i3xQu2GG2tyOEx/gfEyYioTvXAVU2fGgf2WTKjiabyf7j
 5q0Q==
X-Gm-Message-State: AOJu0YwcbAkaN+rF9wl5iZxKuHGWfQYYZL49O9FPV3Nv7xOFvgayzKnv
 gQXNNS2JT7KDc8bHWOHbd0fYbQ==
X-Google-Smtp-Source: AGHT+IGk2FEm7YXF0CrKNv441+IaqrTYzX4sMPTGS4CRso7DP7sJ8kDArsjywY6UqT0BFT8AeZmZgw==
X-Received: by 2002:a2e:3c03:0:b0:2c5:999:de64 with SMTP id
 j3-20020a2e3c03000000b002c50999de64mr1563819lja.16.1699969732584; 
 Tue, 14 Nov 2023 05:48:52 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d4b4a000000b003313426f136sm7804220wrs.39.2023.11.14.05.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 05:48:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 13:48:49 +0000
Subject: [PATCH v3 3/5] gpio: qcom_pmic: fix support for upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-dt-compat-v3-3-88a92f8f00ba@linaro.org>
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4167;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=biTuo/YGg0zWe6lK+r/M8Dw3vz9xAKbdjHOcAQ8XE/E=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgqgP88a/P3SnX/uLQe+Wr0twnB7rrp9+dfc3PplDwg
 pb2zP0rO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEbNcz/BV4ekvga+CDaSU5
 7xqOiZ2ftt7265pvvOpdR1Of8piLtM5l+F+QZVAW/lmL+aDM54Yv53N9AyyulGtWLut/2PCQo6o
 k6hcA
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
index 7b83c67fa464..f2424766e5cc 100644
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
+	uc_priv->bank_name = (const char *)dev->driver_data;
 
 	return 0;
 }
 
 static const struct udevice_id qcom_gpio_ids[] = {
-	{ .compatible = "qcom,pm8916-gpio" },
-	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio" },
-	{ .compatible = "qcom,pms405-gpio" },
+	{ .compatible = "qcom,pm8916-gpio", .data = (ulong)&"pm8916_gpio" },
+	{ .compatible = "qcom,pm8994-gpio", .data = (ulong)&"pm8994_gpio" },
+	{ .compatible = "qcom,pm8998-gpio", .data = (ulong)&"pm8998_gpio" },
+	{ .compatible = "qcom,pms405-gpio", .data = (ulong)&"pms405_gpio" },
 	{ }
 };
 

-- 
2.42.1

