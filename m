Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33413C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933B988BD3;
	Wed,  7 Aug 2024 16:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h5kH49qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255D788BD3; Wed,  7 Aug 2024 16:08:34 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2CB88D09
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7ad02501c3so208381466b.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723039709; x=1723644509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUGyqzPqOhQZDCGyynktzTS8d/XDVJAnmKrkeHoRc7Y=;
 b=h5kH49qrjzn72G2Y7MoE/0zECR2h9ygI1RYSr1KDeOvPDiJW0zi7JsM0+Y2ESMrz9x
 NUvspvwabX/seVrIllEUBQVJDJByZhX7XGDf6ybyV7xuhWVOAKvOk5US7H3wXmSQc+gf
 0qwSrgdAGOhknEwt6emLZkhqllhMz/8KQ5YLQaBNAwy2EdbVeo3BCVBEiNMDyFzZTm39
 lZAU6xjQoy7D3bL5SocTZMz8RX1tJDSA8/NlsEfzdB3JaVcOL4jVP/ZJ7kEMWMMNN6ld
 d9p7QhiJg40LsmFEUmHJDW9dm3aLCRvKKyc/EadHv7lyL6BEyddaFroPtSjGsyoR0T2F
 wOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723039709; x=1723644509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUGyqzPqOhQZDCGyynktzTS8d/XDVJAnmKrkeHoRc7Y=;
 b=ANWTcm19TQeoYmWoxjjzDREn0g+wTcqiSC9ommOV0EQnsS8YBQP30wwGOLvRU4cmiD
 5IudR2cpvv9aNEFXTEewNz0RpS1W58jK5ZruYBwArmIDLwgFuMPz8lr7NAB9I1ssvE3w
 csX4u/80f4gEhTWhYFMvRY6UnBW0N7nfSYQqLD6O+Iw1ItJr9YWWjfTC5mZT7vUsmCCp
 rk/jF9Cks/uvrjEeDXEH7kNv0B+ACO6cwYDDlotVIPAESCR5cOAECFFTaxCf9l4o2M+1
 oNkSM0TN8YI6Du56pECp2ngjn/vkF8IuyrTb36fx9GS8UgNwLiLKRb83Mb4QK51cApaY
 b1Pg==
X-Gm-Message-State: AOJu0Yyag7lbGgutZ5rDY0I6vhbyGf8w/NXAcv25DBO7z/9oZbmkX/qL
 3QK3+yx2c457Z582Dhwf96mQqYBhrh4LsDhhJPqi9H53RbW1pfTOtUr8NQ==
X-Google-Smtp-Source: AGHT+IHSupyRRH2DF5DJ2tx1aUFR62WRbeqEuz3/oTp+IORj4RYXVv4WBMkIrFeEccic9nFdHWmD4w==
X-Received: by 2002:a17:906:7315:b0:a7a:af5d:f314 with SMTP id
 a640c23a62f3a-a7dc51bd623mr1415781866b.63.1723039708711; 
 Wed, 07 Aug 2024 07:08:28 -0700 (PDT)
Received: from mafrox3.fritz.box
 (p200300c8071991002a9d74ab3dca2577.dip0.t-ipconnect.de.
 [2003:c8:719:9100:2a9d:74ab:3dca:2577])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0ca0bsm641278566b.74.2024.08.07.07.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:08:28 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 2/3] i2c: imx_lpi2c: Replace hard-coded bus speed value
 with bus->speed_hz
Date: Wed,  7 Aug 2024 16:08:00 +0200
Message-Id: <20240807140801.1718483-2-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807140801.1718483-1-fedor.ross@ifm.com>
References: <20240807140801.1718483-1-fedor.ross@ifm.com>
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

From: Fedor Ross <fedor.ross@ifm.com>

Instead of using the hard-coded bus speed value I2C_SPEED_STANDARD_RATE,
use the actual configured bus speed. This way the bus speed doesn't
change suddenly after calling the imx_lpi2c_probe_chip() function for
example.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---

Changes in v3:
- none

Changes in v2:
- Add additional '---' below SoB line to separate Cc list. This way it
  does not get included in the commit message when the patch is applied.
- Drop the second parameter of bus_i2c_init().

 drivers/i2c/imx_lpi2c.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index 3c43f61d819..54db6fa863f 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -19,7 +19,7 @@
 #define LPI2C_NACK_TOUT_MS 1
 #define LPI2C_TIMEOUT_MS 100
 
-static int bus_i2c_init(struct udevice *bus, int speed);
+static int bus_i2c_init(struct udevice *bus);
 
 /* Weak linked function for overridden by some SoC power function */
 int __weak init_i2c_power(unsigned i2c_num)
@@ -172,7 +172,7 @@ static int bus_i2c_start(struct udevice *bus, u8 addr, u8 dir)
 		debug("i2c: start check busy bus: 0x%x\n", result);
 
 		/* Try to init the lpi2c then check the bus busy again */
-		bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+		bus_i2c_init(bus);
 		result = imx_lpci2c_check_busy_bus(regs);
 		if (result) {
 			printf("i2c: Error check busy bus: 0x%x\n", result);
@@ -344,11 +344,14 @@ static int bus_i2c_set_bus_speed(struct udevice *bus, int speed)
 	return 0;
 }
 
-static int bus_i2c_init(struct udevice *bus, int speed)
+static int bus_i2c_init(struct udevice *bus)
 {
 	u32 val;
 	int ret;
 
+	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
+	int speed = i2c->speed_hz;
+
 	struct imx_lpi2c_bus *i2c_bus = dev_get_priv(bus);
 	struct imx_lpi2c_reg *regs = (struct imx_lpi2c_reg *)(i2c_bus->base);
 	/* reset peripheral */
@@ -388,13 +391,13 @@ static int imx_lpi2c_probe_chip(struct udevice *bus, u32 chip,
 	result = bus_i2c_start(bus, chip, 0);
 	if (result) {
 		bus_i2c_stop(bus);
-		bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+		bus_i2c_init(bus);
 		return result;
 	}
 
 	result = bus_i2c_stop(bus);
 	if (result)
-		bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+		bus_i2c_init(bus);
 
 	return result;
 }
@@ -489,7 +492,7 @@ static int imx_lpi2c_probe(struct udevice *bus)
 			return ret;
 	}
 
-	ret = bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+	ret = bus_i2c_init(bus);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

