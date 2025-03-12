Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B9EC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FD081DE3;
	Wed, 12 Mar 2025 19:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ls2KZIzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D83E819AA; Wed, 12 Mar 2025 19:23:25 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212558141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5e1a38c1aso83638a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803802; x=1742408602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFhGFxr5H4wAp1lBl9tzekaCgbGh6HmGc0MsEmmPLkM=;
 b=Ls2KZIzKkcuYoo7BRsIzP5y/0Kj+QtDBquLwxIYWGdYH1zrZYWKLnh+XGawhyFtoNs
 NB7j8V9rdibfYDwoHVB0Xai6/4AUYLjhUQuCb89tfdNaj8RfG4fA3zBqtvqivCVP6yJ/
 MzNOI99c/h4ozRqp6NvuONPtoZkqzosqyRLmn3nfj/vKp39bVPOAxTRfYMWbj4EHqNd4
 0BLWxnndOLkbJ3p6lT9dgpB8w8sTlSgHfXXEPCbEd+zpfrgrcAXj2ZogHbhO69a0uQah
 RNcK28O2PI9+cJUOlErvBUJyaZcjIXgliFx80ikuVu1SIrnCWqpR8ZLN9LQ3DglR32jp
 hBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803802; x=1742408602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFhGFxr5H4wAp1lBl9tzekaCgbGh6HmGc0MsEmmPLkM=;
 b=QwYRIB/rpw+/hAghwFrj7SeRnST3DqbtI5YdMEat7QYEfJL79SFHR6xUdd46tAW++b
 ODP2wtuH7vFs+TlKUoS007y3PbCqspogFP+AoGZNl702kBNq7A9xlTyKMeR0xX965ybz
 zpl/zAm+HyYcmqluk33q+jQW9iyHOcLUkpAoZgUEdVDGH8UsH0vAAsg96kTcaFFLviZj
 X0RrFT59Wk1sdSGCEPIcsBM7jCjqhmOetv8jC3Hd9vQ6cHa9pEVvQlxdrShsQcULO1c6
 T912qucPhMlO/eJawSTiqj7jFaEhQAllQkaf2Dgf/DTW5Ecl8W/aQ4Bq1Jh6IcfuboGg
 35UA==
X-Gm-Message-State: AOJu0YySA/ZqG2GRsNZg7MeE0IqVj1srs2hWwUcXCne4bXkm6gZrDtL8
 j4zmfw2EKachm8fnNHysFdgXL6RYm6GrTNmiRgQqBGV/UfjcXRd7
X-Gm-Gg: ASbGncs4OGC4Q4XZur4mlw21JfyfSWctQyCzjJNx4YXsR6GrgFlvM5teOFJm26Kvf/q
 jRSdlVLVmn5qR4Ig4/P1oxrs8X2Vx66NYNrsV020CCyUFpuM67AYlMqsi23Fkwjk8H6SGLbEJrl
 k9ZfCn/s09gDUf6f6dXT3pdv6F/uspbHulfcNdEM930mUQ1H6A9Gu42cdc1Y8+3fcxLVj1EJ8Tu
 9t0TLFNd054Qu5/e8yee1V3n8C0fVGjjWSDtAf/vhtqvQcEGJUdqN/1ajM7jfwY7ktcj7z3eCzL
 m6J67CQn5qtp4yj7f4egd264AzFzX5RfRn9N
X-Google-Smtp-Source: AGHT+IGF9j+mWCa+89DdN59Kw1F4dnjYKhHYsw7IXhGksmLLbp9RaNwhnfFh6S77UofL6/7hUtVVCA==
X-Received: by 2002:a05:6402:268a:b0:5e0:49e4:2180 with SMTP id
 4fb4d7f45d1cf-5e5e24688d1mr55300642a12.25.1741803802457; 
 Wed, 12 Mar 2025 11:23:22 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c7669ff1sm9851674a12.53.2025.03.12.11.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:23:22 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] video: backlight: lm3533: set up backlight according
 to device tree
Date: Wed, 12 Mar 2025 20:20:14 +0200
Message-ID: <20250312182014.121568-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312182014.121568-1-clamor95@gmail.com>
References: <20250312182014.121568-1-clamor95@gmail.com>
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

Configure backlight lm3533 child according to device tree description.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/lm3533_backlight.c | 50 ++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/video/lm3533_backlight.c b/drivers/video/lm3533_backlight.c
index f97f17fec4e..7b87b6bd40b 100644
--- a/drivers/video/lm3533_backlight.c
+++ b/drivers/video/lm3533_backlight.c
@@ -18,9 +18,13 @@
 #define LM3533_BL_MAX_BRIGHTNESS			0xFF
 
 #define LM3533_SINK_OUTPUT_CONFIG_1			0x10
-#define LM3533_CONTROL_BANK_A_PWM			0x14
+#define LM3533_CONTROL_PWM_BASE				0x14
+#define   PWM_MAX					GENMASK(5, 0)
 #define LM3533_CONTROL_BANK_AB_BRIGHTNESS		0x1A
-#define LM3533_CONTROL_BANK_A_FULLSCALE_CURRENT		0x1F
+#define LM3533_CONTROL_FULLSCALE_CURRENT_BASE		0x1F
+#define   MAX_CURRENT_MIN				5000
+#define   MAX_CURRENT_MAX				29800
+#define   MAX_CURRENT_STEP				800
 #define LM3533_CONTROL_BANK_ENABLE			0x27
 #define LM3533_OVP_FREQUENCY_PWM_POLARITY		0x2C
 #define   BOOST_OVP_MASK				GENMASK(2, 1)
@@ -51,34 +55,42 @@ struct lm3533_backlight_priv {
 static int lm3533_backlight_enable(struct udevice *dev)
 {
 	struct lm3533_backlight_priv *priv = dev_get_priv(dev);
+	u8 val, id = priv->reg;
 	int ret;
 
-	/* HVLED 1 & 2 are controlled by Bank A */
-	ret = dm_i2c_reg_write(dev, LM3533_SINK_OUTPUT_CONFIG_1, 0x00);
-	if (ret)
-		return ret;
+	if (priv->linear) {
+		ret = dm_i2c_reg_clrset(dev, LM3533_CONTROL_BANK_AB_BRIGHTNESS,
+					BIT(2 * id + 1), BIT(2 * id + 1));
+		if (ret)
+			return ret;
+	}
 
-	/* PWM input is disabled for CABC */
-	ret = dm_i2c_reg_write(dev, LM3533_CONTROL_BANK_A_PWM, 0x00);
-	if (ret)
-		return ret;
+	if (priv->hvled) {
+		ret = dm_i2c_reg_clrset(dev, LM3533_SINK_OUTPUT_CONFIG_1,
+					BIT(0) | BIT(1), id | id << 1);
+		if (ret)
+			return ret;
+	}
 
-	/* Linear & Control Bank A is configured for register Current control */
-	ret = dm_i2c_reg_write(dev, LM3533_CONTROL_BANK_AB_BRIGHTNESS, 0x02);
-	if (ret)
-		return ret;
+	/* Set current */
+	if (priv->max_current < MAX_CURRENT_MIN || priv->max_current > MAX_CURRENT_MAX)
+		return -EINVAL;
 
-	/* Full-Scale Current (20.2mA) */
-	ret = dm_i2c_reg_write(dev, LM3533_CONTROL_BANK_A_FULLSCALE_CURRENT, 0x13);
+	val = (priv->max_current - MAX_CURRENT_MIN) / MAX_CURRENT_STEP;
+	ret = dm_i2c_reg_write(dev, LM3533_CONTROL_FULLSCALE_CURRENT_BASE + id, val);
 	if (ret)
 		return ret;
 
-	/* Control Bank A is enable */
-	ret = dm_i2c_reg_write(dev, LM3533_CONTROL_BANK_ENABLE, 0x01);
+	/* Set PWM mask */
+	if (priv->pwm > PWM_MAX)
+		return -EINVAL;
+
+	ret = dm_i2c_reg_write(dev, LM3533_CONTROL_PWM_BASE + id, priv->pwm);
 	if (ret)
 		return ret;
 
-	return 0;
+	/* Enable Control Bank */
+	return dm_i2c_reg_clrset(dev, LM3533_CONTROL_BANK_ENABLE, BIT(id), BIT(id));
 }
 
 static int lm3533_backlight_set_brightness(struct udevice *dev, int percent)
-- 
2.43.0

