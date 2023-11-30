Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41224C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC74876FE;
	Thu, 30 Nov 2023 21:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N81aTcTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213438770B; Thu, 30 Nov 2023 21:22:56 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DA987709
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-332e58d4219so866545f8f.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375773; x=1701980573; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3hXZHxuecfif5wU/f4nXhH4eCzZfa91dmy97EKVy4RQ=;
 b=N81aTcTiY141CsFm4fQhi5E+RcFzTOJFv9hi4g7L4HchQ+zs2wPCuAqJddcX4u+OTe
 /SuLXM2pM5zRjm4OjzA/w0E4F5+dnQs9xBWHOZ9cG5hmzA9cKoWZj72ZZUPXpqSA15Dd
 JlHybAhIqRBp4QB85HO4KwgRwL2HBMz3HdqS8xYk0HgseYhTqN93zzhgfDyHkLtQFHwc
 hF+k1VmUHOKcO7VsHc5hq4jlcr7A8wtC42N4POweYmaPptBeTwcptXW66vWszPGs6k5r
 tPY3wicczM3x1AGUvEmTRzl+DnAvSs+fy86q2PieoA/7tSKMCokiSSvj4XlSj/TIc38h
 vkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375773; x=1701980573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hXZHxuecfif5wU/f4nXhH4eCzZfa91dmy97EKVy4RQ=;
 b=CUvRdMy8mqNkyWq6lfUidX9B+9aV3uW38/vuWxGMah05D8QEg6wDKJhPEzYAum/sQA
 gwrxgF+j5IK7aHi1vAYsDQEGzAIqd03W2IKxZL7zCbvM+Nehsy5tySusJXOloxM1VD0b
 BQIVReqOE1oZfHgvUdaiwb9OAxP1oSpicLljeqO5h0iu8d3HcG+w0rC3LWLyYF6A6kCI
 YrrkIpozuvXfdKFmpB3Abinn44GiyaP7TLuDbKnCkuMxWrqXTrvYu/Qod961Rek2S6r8
 S3l6TM4n+PP46Hox1hu6etj4FlMDRG5/pSWC62A+a3RL6UXu3FmfYmlANYyReoLQvEWh
 IMPQ==
X-Gm-Message-State: AOJu0Yy9WvQZxuigmwYHs6nbRWzDzgnLEh/ni7f3R6l/CCG0eDWRmcrB
 wIIv181yZG4XXjiQHBrx1uJJGQ==
X-Google-Smtp-Source: AGHT+IGytYnedXWIYHHXYvgkKdTNiPpMDM2YbIgmAwO1m/DTkfm8TvHPsNJfDtFUcRo2wAXHVzAN3A==
X-Received: by 2002:adf:a4cf:0:b0:332:f3c9:1c8f with SMTP id
 h15-20020adfa4cf000000b00332f3c91c8fmr74990wrb.16.1701375773758; 
 Thu, 30 Nov 2023 12:22:53 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:31 +0000
Subject: [PATCH v5 7/9] gpio: qcom_pmic: drop gpio-count property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-7-41500e237ad0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=n4wzavWlWHVsZCehd+UmTwVOMCnMK4Qqs6PAhPleRjQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM92IXY/aVvZyzXW2Wn6fOtdJj35Zc72bPtCtqmGO05
 vCk5/NtOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBErrcy/DOPbNJeKD9h5rvd
 J/6Lz7m973Wu9N2XAvEVs6qnsru0+S1j+Kfg7djf/H9xYOWEjBwTG5Oj2mEX2P7/vSF2wSq3o/q
 z7hsA
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
index 54f4dbd2b84e..1adc6566a36d 100644
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

