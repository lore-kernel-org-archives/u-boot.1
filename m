Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5E6C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC118771E;
	Thu, 30 Nov 2023 21:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ga986KJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E188770B; Thu, 30 Nov 2023 21:22:54 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564A9876F6
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b399a6529so16460185e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375772; x=1701980572; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+LJakeFglSK5HTWJWr8yiQtiZQ8ZDLzW8xWntxzGnv4=;
 b=Ga986KJwMUmxPQBijFu0ekmu1KvLPTJ6a/n/WnLVB7WZXzwtX0Hh0X+ho1QtDz37bC
 GI8BmhBZflDt5g7T0hnmZpS3sVs3KMVLOSQ1nIBVGrMG3d9oU80csbpH9tGaM9O2rr8T
 7T/ERF78zbnzc2s+qfpVNpzbvfbTozK0M18ADrmnGpjO5hXFBRfT2+iftLMVfx/HmqZI
 haNNt3oOR9kiv7ewiyPke4GwMqVOCqjQSEOpfm9OjozakVYWgzNx5MmqhuDoG3tZ89iF
 shf3dZxHZtcGpyw8wMPkbBF97STe//ZHPCK30g/cuxlCmJFSJW1aNKgteK2rRNknvkUb
 G+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375772; x=1701980572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LJakeFglSK5HTWJWr8yiQtiZQ8ZDLzW8xWntxzGnv4=;
 b=mKbj6r5Qj78C7S3jZgPLSqRP1qBlXxvGphiFEoqnBBXwNGEKEmb5Ov+31OaU5+WWiQ
 yaAD1t5rIwY7OTII6LCFkwJbfnE35kHuxLVZeNsC1MU0m9VML3if2fKJvLdRBJrGX1Ng
 lmd5xo8L5i0Nt4xl3Y8cV7ANvnIdcof4vxGtLAZdAVoOWJK1vaKRc1WFoIhKPASizhdz
 5eulA0CL4eQxUL7bqRKcLcgbXRoC/8B5ml++NLfO9gyAGqMD2sxczb2iP1OEQLOofkwr
 hFztyd4THmkAqEu2SAhJQKxE/pGVUgj3o/UlI8Rk40q1KLrCYwlxqHVg3HBo2qa3Zl8+
 1bow==
X-Gm-Message-State: AOJu0YwbupqTpsG4kau8x5V7c+pRVNLjmFevPiBO84z/FIR+/zQWopBf
 3eLcHu3fMu5KU37aTuWJKXip+w==
X-Google-Smtp-Source: AGHT+IH5bkgagui9uE0gdYUxBtq3pfAxeh43QkwKHh8935s9k2H3Eg/kkWO36ccmOUv9aos7LQG9PQ==
X-Received: by 2002:a05:600c:5248:b0:40b:5e4a:234d with SMTP id
 fc8-20020a05600c524800b0040b5e4a234dmr43587wmb.79.1701375771871; 
 Thu, 30 Nov 2023 12:22:51 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:51 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:29 +0000
Subject: [PATCH v5 5/9] gpio: qcom_pmic: support upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-5-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZRJaS/vffm1bIpnsc4l89aGGwKuzPhD3ry9Iqf7YtrE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM92JNk+a8PrVSYaP3F0+2lgnqHP75FzgZFd2Yj+XFB
 NXWrDLrKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNRZGNk6Oz1yBS50JARarVv
 05oCTe3328wuek22VPkb+iKzUUx+AcN/n4mbFs7/+tLw9p6DXyJ23zwu56yz9ka+6xQvFg6z8DM
 s4QA=
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

Upstream uses the gpio-ranges property to define the number of GPIOs,
support for parsing this when gpio-count is unspecified

Additionally, drop the bank-name property as it isn't used in upstream,
and we can just hardcode the bank name instead.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 7b83c67fa464..54f4dbd2b84e 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -245,23 +245,48 @@ static int qcom_gpio_probe(struct udevice *dev)
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
 
 	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
-	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
-	if (uc_priv->bank_name == NULL)
-		uc_priv->bank_name = "qcom_pmic";
+	if (!uc_priv->gpio_count) {
+		ret = qcom_gpio_of_parse_ranges(dev);
+		if (ret > 0)
+			uc_priv->gpio_count = ret;
+		else
+			return ret;
+	}
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

