Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DDCC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0A2888F8;
	Wed, 24 Jul 2024 12:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JlzTeWhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D5C88800; Wed, 24 Jul 2024 12:00:06 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0873C88901
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52f04b3cb33so6239250e87.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721815203; x=1722420003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVVSXRhpOBa7ocIYRBn62ebHia3zTARrtTG1IU5voyA=;
 b=JlzTeWhg4cr4WGxcPB4/5DhP9+TY5pgEgqdQtDEuD258wAQPqtvQcB/T98DXHeIb0a
 yBgKlYZS+4mSurqjQkY5mS4VbqoRtnqLe5WFzTTtqz7L6TqxRPtvrgUGjvk9Y+KxlVgf
 wx8kT1/Gza1Kw6gx7zjKQaF3RNtAlaogn1akpDiuas79OQosZJheFlmYUlHFfT8R7RJA
 YzaYuB2gFZVrvVz3Tyv4gfBqzZuZosnlzzqB8duSvQTw5PfvjZJz7PRq3VdU9n6lgY+T
 SPNj338jpKCTnFCsc+rIU3y8Qqqit+fygi++IF7M0PiTF3TGOrH3kw+gtmrOYtZXg+kf
 23UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721815203; x=1722420003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVVSXRhpOBa7ocIYRBn62ebHia3zTARrtTG1IU5voyA=;
 b=PzZpx9IOxl0t38uqSq4UgbCJ92CQS83/ys1gCtMI/+UBGufxEySr0C3PW5cWFU6/cM
 ZLrbt8YemirRIvZupIGLhE3T9d5ELgtCOwQXf9ZSHsmcu1wu3DWe5tRigbd2h+b5uior
 lNHwgTALbMjyaIVRv1nhJYvr7ANQIxxrKAX3abGuGmZm0QvWqVPQBEmXVcuwFPbb4Oin
 9YRwyKTYt7JREdhAeq1Wu66XAP9LtsIuQljBSVjQu3DR4qIkgZjI2r1flMuG0onqb+JK
 cHyXN4CK54fYjNcowaNwzbOJcBbziqm375//UGOdKexPJ0LWQfRTf0+yBGuQvbJrv4L5
 ydVQ==
X-Gm-Message-State: AOJu0YyY74M5xrWb6dpeZvOQZWAo1gG4Uy7uN/HMYdbTdTsfpAI/wfNy
 c3RL+3gJCUAGgqw2a8UczoDeO9/xAoxaAIsLrxMs3I9PiveF/cv5vPYrlw==
X-Google-Smtp-Source: AGHT+IGIKfMIhaL8LIehIRAoPN5iDSLASK/2GhM4IVuaRGB4S0VoxZ1MYVMjZhWJBCJr0V6nztHvrg==
X-Received: by 2002:a05:6512:3b28:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52fcda71619mr1897767e87.36.1721815202370; 
 Wed, 24 Jul 2024 03:00:02 -0700 (PDT)
Received: from localhost.localdomain ([147.161.231.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785d64sm625226666b.28.2024.07.24.03.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:00:02 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH 2/3] i2c: imx_lpi2c: Replace hard-coded bus speed value with
 bus->speed_hz
Date: Wed, 24 Jul 2024 11:59:42 +0200
Message-Id: <20240724095943.214967-2-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724095943.214967-1-fedor.ross@ifm.com>
References: <20240724095943.214967-1-fedor.ross@ifm.com>
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
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/i2c/imx_lpi2c.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index 3c43f61d819..7b10b2b252d 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -163,6 +163,7 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
 static int bus_i2c_start(struct udevice *bus, u8 addr, u8 dir)
 {
 	lpi2c_status_t result;
+	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
 	struct imx_lpi2c_bus *i2c_bus = dev_get_priv(bus);
 	struct imx_lpi2c_reg *regs = (struct imx_lpi2c_reg *)(i2c_bus->base);
 	u32 val;
@@ -172,7 +173,7 @@ static int bus_i2c_start(struct udevice *bus, u8 addr, u8 dir)
 		debug("i2c: start check busy bus: 0x%x\n", result);
 
 		/* Try to init the lpi2c then check the bus busy again */
-		bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+		bus_i2c_init(bus, i2c->speed_hz);
 		result = imx_lpci2c_check_busy_bus(regs);
 		if (result) {
 			printf("i2c: Error check busy bus: 0x%x\n", result);
@@ -383,18 +384,19 @@ static int bus_i2c_init(struct udevice *bus, int speed)
 static int imx_lpi2c_probe_chip(struct udevice *bus, u32 chip,
 				u32 chip_flags)
 {
+	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
 	lpi2c_status_t result;
 
 	result = bus_i2c_start(bus, chip, 0);
 	if (result) {
 		bus_i2c_stop(bus);
-		bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+		bus_i2c_init(bus, i2c->speed_hz);
 		return result;
 	}
 
 	result = bus_i2c_stop(bus);
 	if (result)
-		bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+		bus_i2c_init(bus, i2c->speed_hz);
 
 	return result;
 }
@@ -439,6 +441,7 @@ __weak int enable_i2c_clk(unsigned char enable, unsigned int i2c_num)
 
 static int imx_lpi2c_probe(struct udevice *bus)
 {
+	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
 	struct imx_lpi2c_bus *i2c_bus = dev_get_priv(bus);
 	fdt_addr_t addr;
 	int ret;
@@ -489,7 +492,7 @@ static int imx_lpi2c_probe(struct udevice *bus)
 			return ret;
 	}
 
-	ret = bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
+	ret = bus_i2c_init(bus, i2c->speed_hz);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

