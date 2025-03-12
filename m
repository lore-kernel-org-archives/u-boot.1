Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6D7C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5119281E06;
	Wed, 12 Mar 2025 19:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="adO2VUI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6A8807D7; Wed, 12 Mar 2025 19:23:25 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63DE481A0C
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e6194e9d2cso108596a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803802; x=1742408602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZfJLHVfYrm/RFSd2m6Tj00gYWNoOjU2jmPJCiCb6Mc=;
 b=adO2VUI8gEy75UrYcreFTMogCWiXaUHQP6mk5g2jIBpbuLj97+IKW7V0ba+Q96ogpo
 BaSJHlnORj342h5JZ43DOcFnKuqwuB5Ir/a39rQ6rrs3Ik5VRGMLHC7chJtLZzRO61hO
 VruHdmWLCrzSBY7i0JI0XCTu0x2yYKvkl2+t7sLtVEGxH0xWJWiARiMv4+eyu8VQl4pH
 Zpb2pAqi6+wY1wqScl+vc+0dh92bt5qMa51Xwu6Ft272MJkRBz5P/j6MqukCO8wxn5gr
 VQgQo7Zx2sbfktCY1KKl0P2MHnxyGbuXV7bg4TIjLOK2KL5RHdsjwHMuRq9qTNA1OEGK
 wawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803802; x=1742408602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZfJLHVfYrm/RFSd2m6Tj00gYWNoOjU2jmPJCiCb6Mc=;
 b=nnKMzoDCxDZMEhFvbOqm0exXbBUE+e8uyiM13yYCzqcm8IonabJVKhToMy5XEFssnR
 OXeGnz72aRuOZLoGqgv02I8w3z3SigNCTijqKH/b5wSHYGytGhBHvuf2mDVeqSSg2kTM
 FRLyu/iW8TF0aX2W0msjMtvUQyXXPWDZSPjEfv3OfsAQdF4OcyrxN/emSqWBeyU0cD89
 Nzwbe8qbCVuKKHZVP0PzzujhVMkKRvq8QXlPSMmfbftuyvBoGThjqddHZ1fQCbUmfGpp
 9q4Mlc0hFDIL9W4HeJz3xzL16PbbdGhcLrsNIHK/dh9kATDFvqwzyeUx5K8HveZV/zn/
 MJ/Q==
X-Gm-Message-State: AOJu0Yz5bPMHego1UaoHKphra/leLVzPmlKv131N/y3RmxdoRwwJF6f/
 PAd4n2c5aj/7xJGNvRYRjtUk4pcHQj16dk3nm4hYzhTX9VRXgmGz
X-Gm-Gg: ASbGnctLNgAVIzpM3Dg0M67Iwqy1wEP3e34vgTsKI3DSBsqjdnxYTNudP+JgOMJDPmI
 Q0doUs6DoJv8cJ8UssP/cMHhGnBPSRpxeWeNJgmmQmGN/bqMX1rNMPfVBGVHL/7dJq5ZSAa52pw
 BT+UGjXtl5wKzib9xcWZxympjKHz93bWKIqLBxxnpCXGPrlrEEeKJe29K29psURXsZoDiSKiL+4
 s2VMOOaaSkH+QObRMvACLAV4mk+nGmR+JPgthnPOIpkviSwR3+IMfjfLncgqkb24Z3iJKGv8yNh
 Nah3eO4QtH81Q4Hj4OtmDQQKNzvYNJ9Kg9Re
X-Google-Smtp-Source: AGHT+IGcqIM0/0/UogNYCx1Gi70tnra5J5ncwYyeNNouA2QffMzvjoOkopHozZ9BHk3EVsZPJkwtiQ==
X-Received: by 2002:a05:6402:50cb:b0:5e7:b015:c636 with SMTP id
 4fb4d7f45d1cf-5e7b015c666mr7579933a12.6.1741803801676; 
 Wed, 12 Mar 2025 11:23:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c7669ff1sm9851674a12.53.2025.03.12.11.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:23:21 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] video: backlight: lm3533: configure core in the probe
Date: Wed, 12 Mar 2025 20:20:13 +0200
Message-ID: <20250312182014.121568-3-clamor95@gmail.com>
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

Configure core stuff in the probe.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/lm3533_backlight.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/video/lm3533_backlight.c b/drivers/video/lm3533_backlight.c
index a1a7397cbdc..f97f17fec4e 100644
--- a/drivers/video/lm3533_backlight.c
+++ b/drivers/video/lm3533_backlight.c
@@ -23,6 +23,10 @@
 #define LM3533_CONTROL_BANK_A_FULLSCALE_CURRENT		0x1F
 #define LM3533_CONTROL_BANK_ENABLE			0x27
 #define LM3533_OVP_FREQUENCY_PWM_POLARITY		0x2C
+#define   BOOST_OVP_MASK				GENMASK(2, 1)
+#define   BOOST_OVP_SHIFT				1
+#define   BOOST_FREQ_MASK				BIT(0)
+#define   BOOST_FREQ_SHIFT				0
 #define LM3533_BRIGHTNESS_REGISTER_A			0x40
 
 #define LM3533_BOOST_OVP_16V				16000000UL
@@ -49,9 +53,6 @@ static int lm3533_backlight_enable(struct udevice *dev)
 	struct lm3533_backlight_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	dm_gpio_set_value(&priv->enable_gpio, 1);
-	mdelay(5);
-
 	/* HVLED 1 & 2 are controlled by Bank A */
 	ret = dm_i2c_reg_write(dev, LM3533_SINK_OUTPUT_CONFIG_1, 0x00);
 	if (ret)
@@ -77,10 +78,6 @@ static int lm3533_backlight_enable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = dm_i2c_reg_write(dev, LM3533_OVP_FREQUENCY_PWM_POLARITY, 0x0A);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -159,9 +156,29 @@ static int lm3533_backlight_of_to_plat(struct udevice *dev)
 
 static int lm3533_backlight_probe(struct udevice *dev)
 {
+	struct lm3533_backlight_priv *priv = dev_get_priv(dev);
+	int ret;
+
 	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
 		return -EPROTONOSUPPORT;
 
+	dm_gpio_set_value(&priv->enable_gpio, 1);
+	mdelay(5);
+
+	ret = dm_i2c_reg_clrset(dev, LM3533_OVP_FREQUENCY_PWM_POLARITY,
+				BOOST_FREQ_MASK, priv->boost_freq << BOOST_FREQ_SHIFT);
+	if (ret) {
+		log_debug("%s: freq config failed %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dm_i2c_reg_clrset(dev, LM3533_OVP_FREQUENCY_PWM_POLARITY,
+				BOOST_OVP_MASK, priv->boost_ovp << BOOST_OVP_SHIFT);
+	if (ret) {
+		log_debug("%s: ovp config failed %d\n", __func__, ret);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

