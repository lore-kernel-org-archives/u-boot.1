Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CD0CF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 16:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69FEC88C0F;
	Thu, 19 Sep 2024 18:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1dqDYhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F9A88C0F; Thu, 19 Sep 2024 18:09:20 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0404488BBF
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 18:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5365b6bd901so1195684e87.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726762158; x=1727366958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ccksuvHqUa9N9ALwz1qR4pNHUdNqjveGl+CcTJz4jwM=;
 b=d1dqDYhprBj5Kw5Ptupi2xNTLX0qziLpKnVKt/9gQNNMstLQwtst+fBbI/SQzFhbYH
 Ej5rces9tjgENV3HPWyoGdNre0ldi4HIEh68b8ptaonrMtuO0zCFocM+pCv0xthOksLa
 RPXyaafbwFpJy6MPyX/H3V4gGRMIIR83/w3+pmZ+BXV7xJxh9mXpchAqrKo6L1l4qoLf
 HDyI+k7RUqpKMKD27A3WQh5DIaKC4yBVGscKV+WsGwqRnSjV2/Ro+S4ZN1Bo/SYWbBWf
 6H0EWBcoG3XJZ28e7/PqoxYrlBNW/ZpvLL10Sn78hyggkN/0X4wLrzzHFDothFARuY5G
 rbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726762158; x=1727366958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ccksuvHqUa9N9ALwz1qR4pNHUdNqjveGl+CcTJz4jwM=;
 b=a3HYl+ea7ETPx9aghfkwVJ9Q1SrU46ksIrP8njDZQnsUAo7mT0Nj8bR/rWwEKHIG1E
 /8DsxZvmMwOIN3+zc/9BoTbqr36AX7FPh+k1NbJ864z1GWE0IsiB0p/Xom74+7Z8xXv1
 rDX5MbutWV9BRwJQMq4y0N4ZDeZHGe0+Rr3csePO1a+grMbEiFdOPadKS9MNpSKdGQZb
 KbmAsLhbRxcAV5VZpGtlSZR2GV9QGsi5+YYMQ1DXb0NKyY5JJm2Mn2aB4ouy2zkD5OTr
 iBIsjrMuE0za1guRT0SQCu2OuXzMjVMvO40cNitJSk+N3cv1kbuJNVpnduGCnZcNHRRa
 jQmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnuxH9icQHDgKM3aMDbK3PKjLgEsi5nVyQPXZzeI3p5J2rz7WPYgnYs3tktfk+4Y+Q3/Ely+U=@lists.denx.de
X-Gm-Message-State: AOJu0YzOtUh/BFgoCGzdOgMkJnR0KPLIfEK3UOhmtTF6HIxLNC1Ls12T
 lsRdI8RrUT0ObJrlTEAcBCDzyldGiCJVFWTjxCIUqCwsfGY6r/uE
X-Google-Smtp-Source: AGHT+IF3Ejwm6shaim9pRazJE7Q6TPaE2WrDc7n4/M1O1s/E+aP6n3JiMt746o8YSC9VaGv8gJ0cCQ==
X-Received: by 2002:a05:6512:3195:b0:530:aa4b:81c7 with SMTP id
 2adb3069b0e04-53678ff4d82mr15978326e87.59.1726762157845; 
 Thu, 19 Sep 2024 09:09:17 -0700 (PDT)
Received: from wpc.. (host-95-152-62-174.dsl.sura.ru. [95.152.62.174])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870b402asm1900929e87.243.2024.09.19.09.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 09:09:17 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1] i2c: muxes: pca954x: Add MAX735x/MAX736x support
Date: Thu, 19 Sep 2024 19:06:56 +0300
Message-ID: <20240919160658.197534-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Add support for the following Maxim chips using the existing PCA954x
driver:
- MAX7356
- MAX7357
- MAX7358
- MAX7367
- MAX7368
- MAX7369

All added Maxim chips behave like the PCA954x, where a single SMBUS byte
write selects up to 8 channels to be bridged to the primary bus.

Tested using the MAX7358.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
Hi, friends!

I have a custom board with MAX7358 GPIO expander.
This patch is the port of Linux commit:
 > 81694437b6eb i2c: muxes: pca954x: Add MAX735x/MAX736x support

Best wishes, Maksim.

 drivers/i2c/muxes/Kconfig   |  5 +++++
 drivers/i2c/muxes/pca954x.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 323c4fbe9c..cd5579aa55 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -36,6 +36,11 @@ config I2C_MUX_PCA954x
 	  device. Supported chips are PCA9543, PCA9544, PCA9546, PCA9547,
 	  PCA9548 and PCA9646.
 
+	  It's also compatible to Maxims MAX735x I2C switch chips, which are controlled
+	  as the NXP PCA9548 and the MAX736x chips that act like the PCA9544.
+	  This includes the:
+		MAX7356, MAX7357, MAX7358, MAX7367, MAX7368 and MAX7369
+
 config I2C_MUX_GPIO
         tristate "GPIO-based I2C multiplexer"
 	depends on I2C_MUX && DM_GPIO
diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
index 795288fe2e..9dd2697270 100644
--- a/drivers/i2c/muxes/pca954x.c
+++ b/drivers/i2c/muxes/pca954x.c
@@ -14,6 +14,12 @@
 #include <asm-generic/gpio.h>
 
 enum pca_type {
+	MAX7356,
+	MAX7357,
+	MAX7358,
+	MAX7367,
+	MAX7368,
+	MAX7369,
 	PCA9543,
 	PCA9544,
 	PCA9546,
@@ -39,6 +45,31 @@ struct pca954x_priv {
 };
 
 static const struct chip_desc chips[] = {
+	[MAX7356] = {
+		.muxtype = pca954x_isswi,
+		.width = 8,
+	},
+	[MAX7357] = {
+		.muxtype = pca954x_isswi,
+		.width = 8,
+	},
+	[MAX7358] = {
+		.muxtype = pca954x_isswi,
+		.width = 8,
+	},
+	[MAX7367] = {
+		.muxtype = pca954x_isswi,
+		.width = 4,
+	},
+	[MAX7368] = {
+		.muxtype = pca954x_isswi,
+		.width = 4,
+	},
+	[MAX7369] = {
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+		.width = 4,
+	},
 	[PCA9543] = {
 		.muxtype = pca954x_isswi,
 		.width = 2,
@@ -102,6 +133,12 @@ static const struct i2c_mux_ops pca954x_ops = {
 };
 
 static const struct udevice_id pca954x_ids[] = {
+	{ .compatible = "maxim,max7356", .data = MAX7356 },
+	{ .compatible = "maxim,max7357", .data = MAX7357 },
+	{ .compatible = "maxim,max7358", .data = MAX7358 },
+	{ .compatible = "maxim,max7367", .data = MAX7367 },
+	{ .compatible = "maxim,max7368", .data = MAX7368 },
+	{ .compatible = "maxim,max7369", .data = MAX7369 },
 	{ .compatible = "nxp,pca9543", .data = PCA9543 },
 	{ .compatible = "nxp,pca9544", .data = PCA9544 },
 	{ .compatible = "nxp,pca9546", .data = PCA9546 },
-- 
2.45.2

