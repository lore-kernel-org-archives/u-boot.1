Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83BBCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 16:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246B6881AF;
	Wed, 10 Apr 2024 17:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K0Jb33PP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183B988180; Wed, 10 Apr 2024 17:59:50 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BEC787F52
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 17:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so2665074f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712764788; x=1713369588; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5tG9OEKHZ9GG9A3n0H5H0kdpfyuBggnADdmpWFzu+8Y=;
 b=K0Jb33PPtokFHiyREe9SB2cNWP9mV1cSGkifas4w18ViY7+/Rg6alVM/XrXiN96H9V
 VBdgqs45ZRxcv+p7MOzYY5Pk3ElNPPONdyOC4S7z2EXJl2t1z2ZHCJR1PUHIYD/rkkIT
 Q8VJzuTdCH4kWbova59gRmXP2ezb149swbhjAHWJp725sgYAWkk81Fkgi7afGYFVKHGL
 70DALs9sL4Iz9E2MGZPsHxHLYd28TCX/IojZq1lCjKnxUy+loipJ0bhVEdLpj3F2PQOx
 GKlyP8NZmQwOOxLI7KfkGCxmDLOan99phrtCRS342DczaDH3FQXyn/KGsXbWWoirUwa2
 Xp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712764788; x=1713369588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tG9OEKHZ9GG9A3n0H5H0kdpfyuBggnADdmpWFzu+8Y=;
 b=F9rM00RnzbcSe1ve0Y/W0XSwp+94lbmULnVOaDgtoGxwMyM9mOL+D/DeLYB0j6LmF7
 +1X1xd+WT4Xgn1oExOE1I8Pjir4TjU45rzBQfxKQPVMsKdxDqWsYC89AfEjL2a549Got
 hKFyok/K6TB2sevjGZZyBRFLblH90JYckhEQTwMV2O0vzPknQD93+SrAB4Ho3VQJLhht
 7PSk1wCTTW2aDgsaXNDeIXSUJisof6xnZfImbe9BIOr/rX/45QDFqvqvJaaCDGsPXUVg
 XLog8yC73QRYlA8VDRSz5QiA5ghh2fmg1KF22CXjMavjtiCSjTYcLvR0Fak27cUiZjRV
 efnw==
X-Gm-Message-State: AOJu0Yyqv5v8bGeW37H7MGahnC4/wEhMV4XtPnk+zVuhJolD1Ls8dDm3
 6Ca3zmGVowXbIDRVKcnGWRpezcThBYDXBIXbWuY5kLM6M/jTmf3QWTSnksK9Y98=
X-Google-Smtp-Source: AGHT+IHvhIU9aiuWLZ93g30omAKuK5CeEV9lQk7PaNDBjs7GfikkRtnRXwWPwm2od6M0+c+FK+eMjw==
X-Received: by 2002:a5d:6651:0:b0:346:8111:c762 with SMTP id
 f17-20020a5d6651000000b003468111c762mr59967wrw.22.1712764787615; 
 Wed, 10 Apr 2024 08:59:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d638d000000b00343ad4bca7dsm14039431wru.85.2024.04.10.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 08:59:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 10 Apr 2024 17:59:43 +0200
Subject: [PATCH v2 1/3] gpio: qcom_pmic_gpio: add support for pm8550-gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-topic-sm8x50-spmi-clients-v2-1-783e20d66c25@linaro.org>
References: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
In-Reply-To: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xkMJDuFEMyhRf5H8OJG4VW0ni9nAowsKz123H//kizI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmFrdxyyYOw8EVWybjN7u98DK5rYewYOINkXcZT23Y
 GLbljjCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZha3cQAKCRB33NvayMhJ0fDyD/
 9uKT1e1wNKCeAd7wA+uPTNMbX+DsH0rehBRGUY0RSfwPqBgkMB9vOD8FQT/Wm0zTwzixp/w40nDSAn
 1QOYY4hOvg8nssuG4JTcu7yHvXBFExI5C+J/A7fmgk5/CpdQ4wubSbqR9X83dSmj/yy5QqPN+p3iPR
 SsR/kdJtzI9zt+Qx2vRkcDdMSwFZJbybKSKjMkLdhf9POxVxNh18Ql/J6g2vj+cay55YV5mLwZj5lX
 nvNb4DFKQ6iYhyBQB9S1No7iugZOJfLa5wKuZZQvSrrXF1WzHepooztd5Q+YcWn+j2gFXeZE1KTpDs
 +WIY952RIqnZv4Y0h+FAFBUBS11Xzp5WF88sn3vZa+Ei3XvQMp1eLMEn4x65uamIPpwUnE0apAo89z
 ByX1VlJoE7nGMo0+okBRmKeoNglG4R2XXeJaoIKpeAZ6sXuDvRmbkLIdUVUc55voBze7FyU0/8Spv/
 gehKZzno0tu/sHtz3IUGz8ALyOI2Vsv3mXFjDEkNETr8sOJOvMOeDNW283r483u/8LKGXh5LKu/U1I
 ycuKE1w2qpJRXbuZOV55+7vL66prd9gZLS/kIliO7BebxDUvSUg/Hlcl1CVVsbTzbN0P3MrrrHU+tO
 eq5Z3DmoQIdtNxxryJCLtPOhBTNiYS+sEFgdAwQ5xqMXBImMExdjoN4CuR3A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add support for PM8550 GPIO controller variant, keep read-only
until the GPIO and Pinctrl setup is fixed for new PMICs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 14a8210522b..dfb70faf94b 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -35,6 +35,8 @@
 #define REG_SUBTYPE_GPIOC_8CH	0xd
 #define REG_SUBTYPE_GPIO_LV	0x10
 #define REG_SUBTYPE_GPIO_MV	0x11
+#define REG_SUBTYPE_GPIO_LV_VIN2          0x12
+#define REG_SUBTYPE_GPIO_MV_VIN3          0x13
 
 #define REG_STATUS             0x08
 #define REG_STATUS_VAL_MASK    0x1
@@ -322,9 +324,20 @@ static int qcom_gpio_probe(struct udevice *dev)
 		return log_msg_ret("bad type", -ENXIO);
 
 	val = pmic_reg_read(plat->pmic, plat->pid + REG_SUBTYPE);
-	if (val != REG_SUBTYPE_GPIO_4CH && val != REG_SUBTYPE_GPIOC_4CH &&
-	    val != REG_SUBTYPE_GPIO_LV && val != REG_SUBTYPE_GPIO_MV)
+	switch (val) {
+	case REG_SUBTYPE_GPIO_4CH:
+	case REG_SUBTYPE_GPIOC_4CH:
+		plat->lv_mv_type = false;
+		break;
+	case REG_SUBTYPE_GPIO_LV:
+	case REG_SUBTYPE_GPIO_MV:
+	case REG_SUBTYPE_GPIO_LV_VIN2:
+	case REG_SUBTYPE_GPIO_MV_VIN3:
+		plat->lv_mv_type = true;
+		break;
+	default:
 		return log_msg_ret("bad subtype", -ENXIO);
+	}
 
 	plat->lv_mv_type = val == REG_SUBTYPE_GPIO_LV ||
 			   val == REG_SUBTYPE_GPIO_MV;
@@ -351,6 +364,7 @@ static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pms405-gpio" },
+	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ }
 };
 

-- 
2.34.1

