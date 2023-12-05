Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBE0C07E97
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C04878CF;
	Tue,  5 Dec 2023 14:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GZEuZ+Gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D512E87626; Tue,  5 Dec 2023 14:47:08 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E188756E
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9f9db9567so30390211fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701784026; x=1702388826; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pNzDeS4jLfZs8jyIubeuNekC0RpWcM0qlQMwk11zzE4=;
 b=GZEuZ+GxyRYH83z3TFcLZ6gHwioOxet3O+ZZzRAYkLVy1tZ1XllQzNKyFU4d5/5RBt
 6VNYaZP2N/PXya7y7mPJqO1KqGG9c1pvZO3ueA7IRpePDcTsxV4Z5HbpDwq9s/+eX6An
 3S/PtwB3NFi2AIRbsmac9kZiKZqlN+zh6ZL7tINRV7DGnYLe0RpQ9eUCQjfduNcRTNZX
 NsA7BR4L9Qe2EAsnFRxpWS54YLsbljYhSRLNkPE51zuRtNUIEHO/Zwg12mPlr1VfQtvQ
 UVvHQsKTf8fO0fPxYJOA+g3zELc2uK2QGHmDwd0QmRzEDxeiZaA07ZQUuZ8WxN67HBxX
 +XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784026; x=1702388826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNzDeS4jLfZs8jyIubeuNekC0RpWcM0qlQMwk11zzE4=;
 b=X2WG05HXdOHn0XPIVoSc8CExlvSWYdQouaebE2e04IIyqVx3oTwSysxc4IuT36p6tR
 UMDU2wPxngPNY0LcymoAMQr1DU4Cy5Qg+lkvYFkSTHwDm1SNSyxFUo33cBRT3qTWxn4j
 4KCwkE6Ku1cR/+4+wwSp/P7dgNplYIkZFQPTiEUsRQTd5zbMwruI8V/uPczMl7LL6CFS
 l5esch+QnpWEEGku0v++iivgG1EHqOxDRrm2P3oM7k3O/z96o/CMppvt45IhlM7jr8Kv
 iU79rNJ2giTUmJ1FlUXLZAjd46qI44naPc6mPs0YEcG5wba02qdpWZ+1QAkAGnPekYGZ
 cJeg==
X-Gm-Message-State: AOJu0YxJXY4z+NKc/+iYuBKtgDuudDw7WGVBhK7FXXDxMBTJ56a8wfIL
 H5l1BeNv1gwlTW2TG7obkNkKsQ==
X-Google-Smtp-Source: AGHT+IG+xgrTJkH5OUtmD+/DR9hDdL+TJURI/Pnp/lV30wMCWonJs8wlGaWl6KIjSveJ2Z9qQ2UgxA==
X-Received: by 2002:a2e:9b97:0:b0:2c9:eb97:b76c with SMTP id
 z23-20020a2e9b97000000b002c9eb97b76cmr2872717lji.88.1701784026358; 
 Tue, 05 Dec 2023 05:47:06 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a2e928a000000b002ca0e0c837asm369688ljh.100.2023.12.05.05.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 05:47:05 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 05 Dec 2023 13:46:52 +0000
Subject: [PATCH v6 7/9] gpio: qcom_pmic: drop gpio-count property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-b4-qcom-dt-compat-v6-7-61d104a8f920@linaro.org>
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KIbcCNwhjqBjvG3k7+wa2fqlrubCe/j4Q+RD3LW3KPE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtR8zXN1S22fbi3u3uHTV7Ttl5nao7LOnL1FIRtW7/z59
 +4qXRvLjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRAGGG/0Ev1378E2V902m7
 Jle3xP8W24tdh/hEG9c8OdOyTrqoPZLhn5Kp3cUTXguqVc6sM7AQ0GPXDHbt/Fnx5bRYWw3Tzwf
 yzQA=
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

This property is not part of the dt bindings and all boards use the new
gpio-ranges property instead. Drop support for this.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/device-tree-bindings/gpio/pm8916_gpio.txt | 48 ---------------------------
 drivers/gpio/qcom_pmic_gpio.c                 | 13 +++-----
 2 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/doc/device-tree-bindings/gpio/pm8916_gpio.txt b/doc/device-tree-bindings/gpio/pm8916_gpio.txt
deleted file mode 100644
index 58185b833524..000000000000
--- a/doc/device-tree-bindings/gpio/pm8916_gpio.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Driver for part of pm8916 PMIC - gpio and power/reset keys
-
-This device should be child of SPMI pmic.
-
-1) GPIO driver
-
-Required properties:
-- compatible: "qcom,pm8916-gpio"
-- reg: peripheral ID, size of register block
-- gpio-controller
-- gpio-count: number of GPIOs
-- #gpio-cells: 2
-
-Optional properties:
-- gpio-bank-name: name of bank (as default "pm8916" is used)
-
-Example:
-
-pmic_gpios: gpios@c000 {
-	compatible = "qcom,pm8916-gpio";
-	reg = <0xc000 0x400>;
-	gpio-controller;
-	gpio-count = <4>;
-	#gpio-cells = <2>;
-	gpio-bank-name="pmic";
-};
-
-
-2) Power/Reset key driver
-
-Required properties:
-- compatible: "qcom,pm8916-pwrkey"
-- reg: peripheral ID, size of register block
-- gpio-controller
-- #gpio-cells: 2
-
-Optional properties:
-- gpio-bank-name: name of bank (as default "pm8916_key" is used)
-
-
-Example:
-
-pmic_pon: pon@800 {
-	compatible = "qcom,pm8916-pwrkey";
-	reg = <0x800 0x96>;
-	#gpio-cells = <2>;
-	gpio-controller;
-};
diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 5221bd27825e..6167c8411678 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -268,14 +268,11 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	int ret;
 
-	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
-	if (!uc_priv->gpio_count) {
-		ret = qcom_gpio_of_parse_ranges(dev);
-		if (ret > 0)
-			uc_priv->gpio_count = ret;
-		else
-			return ret;
-	}
+	ret = qcom_gpio_of_parse_ranges(dev);
+	if (ret > 0)
+		uc_priv->gpio_count = ret;
+	else
+		return ret;
 
 	uc_priv->bank_name = "pmic";
 

-- 
2.42.1

