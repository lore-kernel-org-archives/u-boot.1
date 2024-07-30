Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265F2C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 15:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A1A8887A;
	Tue, 30 Jul 2024 17:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mz6fucin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411388887A; Tue, 30 Jul 2024 17:25:59 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6711488881
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 17:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a8a4f21aeso619377866b.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722353155; x=1722957955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz1UAAZ/6+eGpRzDoQgzMqzHnxMAYgnxa5pbWPUdONM=;
 b=mz6fucineNKoMhbOWGpetW8rk8WT/sbY08LsT2+alhJHqkO9bwkZH88+ftroO7879y
 AZRPidY1vXdEgGa/QPseeZF1gBOO4WsNQ/kkBvS+D+x9DFUGcfO+QktWVCSsj6hrAuz1
 MRylz2XUF1r/Z4mw76M/2X7VTZ8u1PF/3BLToUUuw8aR2sUejrp0xam3SU0MwpQOeswA
 vq+0w3J6gNwPWbQh+or7IYby6NObAJ25LwQNJuBIGexSYgauE7pIOuA/GZbV53+PtTps
 soSu0k5faBB25GlmNszbAwTiY0l/2ha3lDKKWU2WG/PJ4qQBV+pNhgKmULDyrPTgWnkB
 31FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722353155; x=1722957955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fz1UAAZ/6+eGpRzDoQgzMqzHnxMAYgnxa5pbWPUdONM=;
 b=LrhX2JjiqbZNc6VX8r4dfuPAAIfuT5Ap7bC9P3JNxwiS77Cn4x3HD0mUU0e6kamn/y
 D18Ek1BTA0jWoq4m/VKMsEGIIVYkmOXlKpnwjmWybOLJiKP6GCJ8nUgtTqVPOIm8rSP2
 OgtXBke0XAX503bQb24JgirjPuKEju/MGRBjZun+t9nzC5/keQW6Cu2DzTWeZ5TuPxNI
 4e/s445Wj16x614H888hs9UCxnlbg4rCH7vqkVKIBFWetP8q9ShxYl2RhBOG0xbNtJCS
 8mf7agIoD8l3BwR9RxvADqer5wi3hvC0Eq7EPk0ODUE0F+PesZ8OfYsuQxGhStD5r5jR
 zsZA==
X-Gm-Message-State: AOJu0YwJ4Dsb7uvtyOnBZAjf9GcFLQvVeuuwR8S8gk03UB5xCgYxFy1B
 xbVHjZK4IOGAcW+Oc1duaC9GVtTzBoERETsEU6+/YIxwem43jeFHzbQwtA==
X-Google-Smtp-Source: AGHT+IEqXiu52gbrAsdBAzZMTirmGpdsEy1hLq3EZZeRBgV4+z9+zxcgc2Iqm6wZzCxoSqUR3OkU3g==
X-Received: by 2002:a17:907:94cb:b0:a7a:d1ba:af30 with SMTP id
 a640c23a62f3a-a7d40160872mr812776566b.57.1722353155096; 
 Tue, 30 Jul 2024 08:25:55 -0700 (PDT)
Received: from localhost.localdomain ([147.161.231.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab535a6sm654333466b.88.2024.07.30.08.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 08:25:54 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCHv2 2/3] i2c: imx_lpi2c: Replace hard-coded bus speed value with
 bus->speed_hz
Date: Tue, 30 Jul 2024 17:25:28 +0200
Message-Id: <20240730152529.143651-2-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730152529.143651-1-fedor.ross@ifm.com>
References: <20240730152529.143651-1-fedor.ross@ifm.com>
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

