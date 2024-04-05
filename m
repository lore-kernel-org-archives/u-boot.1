Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4CAC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1A6884B7;
	Fri,  5 Apr 2024 10:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bw1QbbSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A4988433; Fri,  5 Apr 2024 10:27:31 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC21884B3
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d68cf90ec4so22367811fa.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305649; x=1712910449; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5tG9OEKHZ9GG9A3n0H5H0kdpfyuBggnADdmpWFzu+8Y=;
 b=Bw1QbbSHN+R4swSVfIOdMRYwEC/BVyczq7ZAWM5PsO45pqTKSbZZ8Z+qKI87Uv/FI0
 laKkP447dI4zUKcAGDNos8+IUwHzqEX65xIOzgnbNLcS2lBdeZmHs4IV+Oyvf34V9o2y
 0pX/HOdnQjZd3CBMpysinpGvxoN5ef+cdaIx2itKWCKBT8vdhs80qXgEjF5rpzurlzFx
 X/GDimM5xnOSDL1tJbItz1/eVGY3eYxdQJ/BuMvxELjz0G4Ld44mFswwaK46gN+FawtW
 re1Yf84DpNie7wyYw9Ax9OiSj+SSJrAhohNgamofyuEIpOqtI6TAejZaBtuw1VebCUB+
 MgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305649; x=1712910449;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tG9OEKHZ9GG9A3n0H5H0kdpfyuBggnADdmpWFzu+8Y=;
 b=K/3HPyN2XQanX2eBHCjYkVT2cJRCWYgZcvcL1htrkI9aQ1U0IAX287xEXz1cS+PvZU
 kNTblUd38FD70h3YbI2wHCivpPkscgN4vFi3B0a/D55yq6SWoQXL82RsngGJhHWb+B0G
 RAdb744YGd2c1g5IefKeK2wNZErhgoypUU2QRUbswJXLeGouzWcB701HISysQan/BO6I
 XBVqqw5/CcLTRTwG0mAnP2osJG/UlDmKB3QFXezgjldcgN0kMT17g85mj2K9V6gV/bXi
 sL7VG/dlSjtDh4DE46AWzzG1R2aZ1odSEfZ4tL3u05AljduBCpA473UPY5qzsm/0rpYW
 k2xA==
X-Gm-Message-State: AOJu0Yx1q6eG+rzEmEAj7rOeFqe/qjngPLW/8BaUbUcerIp7YDBK48rg
 kQMo1thQZm/hnEin8/KCMTCfiJlWacBMRNKAF2z8lFjYSdCoyYZfh4HC5uFABpA=
X-Google-Smtp-Source: AGHT+IEqA3jjCxHiBKUscncYn6JxyvpL9EwGGZfEZR7UVP6lFT82zqIogfmj7AZj3bYiCUDexBwB5g==
X-Received: by 2002:a05:651c:1545:b0:2d8:394c:6e7e with SMTP id
 y5-20020a05651c154500b002d8394c6e7emr740049ljp.15.1712305649225; 
 Fri, 05 Apr 2024 01:27:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b004162d06768bsm2721593wmo.21.2024.04.05.01.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:27:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:27:24 +0200
Subject: [PATCH 1/3] gpio: qcom_pmic_gpio: add support for pm8550-gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-spmi-clients-v1-1-c28603ebcf18@linaro.org>
References: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xkMJDuFEMyhRf5H8OJG4VW0ni9nAowsKz123H//kizI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7XuAmoEUzgr4bdEkIN9tr6mYBglVw/+RmeR2MGs
 zEcevQeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+17gAKCRB33NvayMhJ0fP8EA
 C+meNekyNp8128i8zlvIp5z6NwcuhLvpiDfE3eDn/VB4wwWfpYc0Zntl5VDbFMEVIpw7wonqUX2qFI
 kekuaETWklMzxyA1tEA5xO1qoH+SewJb6b9H7RYSg++y4NE1HH932qPd+EXNBEechxmjY+NsubaANh
 ApPRRbmU8n5usCi6jd4/V/1UtuwOgb5cMV39Wk5q9UHqFIr8x6itAhkRtXfCs22MUCyL2zc+S+SyDX
 u9lsDKrU828xCS4nJzORBIndXux9OC7uI5gy8EJk8UhtqnfETfS3mq/qFxehbO5JgeuJnm8sb+FbPV
 mneO8KigU5zFwc5GzN/KWZcOs1uuQifCBlNyXz+o2TuQf076RFXGIvtE2LBKel6oSb3ilVZQAZ9cJ7
 JedEfXKKoYlQa3bOJl6be4b5j8JErrOYeAcXlIRPtuCyZmUcdMSAjsCZvaS0RfuaimuuLCYGvD6+aR
 oEyi9Jkmp/s6yNtWHF9VM87pu4T6eR8L0pVR1QnoYAj5LLnQRCynCRDGANadglQucvsYKi7SllI8BH
 TmldaFQnIa26cH8hs42huZp2UX8hvsmz3bg+ZMBqpPcc7Dav1Xwu4Qu8hqPN2sCbg/T682ojcaFEEp
 gA+AAXXnndjX2/izb0xE/gKkB+QyrglpKuvY/0QpidiyDcqz9IQ3dPbw6NOw==
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

