Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FC8E6B242
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE51892CE;
	Fri,  1 Nov 2024 11:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXPWjj7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D7F892CE; Fri,  1 Nov 2024 11:35:37 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFCFD88CD9
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb3ce15172so27863991fa.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730457335; x=1731062135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYxnIs5WJauxrnO3QUoMo6T608oLOwNY+0tAfuvIE10=;
 b=WXPWjj7yViY8l98lc05kRwjbcNV8+aMT+qJX9Hq/J7up8QhY+n0NPYM9AOzLrikpB9
 YJ6SYQUv+bGCU8pJKY/RJMLMP0pTesqKFW3GdpvXvRTmOw+oXAMQdlR9MkTExBbi3nb0
 d3wL0tzJ8vpB2EqxKRq2qIbym5Jd/bavz0XrCnFGOuM4a/ko3b/703kXCtP3aSVE45dc
 Mk12X8otflQ6HHfEo2nSQ0IyKGbI2p82uC5wkNCzlNii0moD/PE40gGdxZDQGtj4Osxi
 08IHDxFColb6hcm/c2HkFOW26/k0DneNMrcdFl7zosAdkWEqtaZ9ac22z2cyokdePe9r
 4j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730457335; x=1731062135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYxnIs5WJauxrnO3QUoMo6T608oLOwNY+0tAfuvIE10=;
 b=uSEPODghkNLVxKcbWVej8Y8f8PNG3kBtXE2LwUu8VlU1GoB7JsgxxqWI+lfLBSTt5I
 2Jlq53SxD19+AE0OFb9sCVFn1+MHC/hAsz7N6lylzjc1EOll8MvokRhfQQLxtt9trdw1
 ThfI4A2uKfnnGM5r8jScNwVIV0QHRZiDScfWDvrScjLyeny7uUZHkGk7fxhfpoIfXlkq
 6UTpWlGJsx1iiXweEua5eydnYlEq7pG1eIQSthVerZwBa99LiWq/BcUACE3VjQZgaIR1
 mvpqhEbf3ZaCEpkeHDdKLQnkSlEM5qihQh4VeYRS2WAvYtWdI2ehLslwZnKaVg6MprK9
 M6VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW96arcd9IfpKNe2OIxDPVwQvMLSxXOtYLs7+fbUlBCiPRcmiv2U5i75Q8ypCrKb1jEz/xc/tI=@lists.denx.de
X-Gm-Message-State: AOJu0YwUvP2aDYeUd5KQ/jyrsYnvJa7Y+hAimF8eBIpdFLdFvlLbMUjS
 veRXvfDhLSDwPqGxR951zNQ4wtbt0Cfca/cvGdKWwPQeAZuf6B7m
X-Google-Smtp-Source: AGHT+IHhI2fI0LDYsp97eH0Zkjev1ZTlPvZ6TvF7qK36GYgOwzC8G4FmyOPVNsFe5dsEdIJRe4opBw==
X-Received: by 2002:a05:651c:985:b0:2fb:569a:5543 with SMTP id
 38308e7fff4ca-2fedb488babmr9699401fa.19.1730457334887; 
 Fri, 01 Nov 2024 03:35:34 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-63-138.dsl.sura.ru. [95.152.63.138])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef5d7400sm5163051fa.45.2024.11.01.03.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 03:35:34 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Wang Jie <dave.wang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH v1 2/3] usb: tcpm: fusb302: add support for set_vbus()
 callback.
Date: Fri,  1 Nov 2024 13:34:51 +0300
Message-ID: <20241101103501.21432-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101103501.21432-1-bigunclemax@gmail.com>
References: <20241101103501.21432-1-bigunclemax@gmail.com>
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

Add support for VBUS supply regulator.

When our type-c port acts as a host(SRC), this regulator
used for control VBUS supply.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/usb/tcpm/fusb302.c | 44 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
index ee283782792..2a258d6429b 100644
--- a/drivers/usb/tcpm/fusb302.c
+++ b/drivers/usb/tcpm/fusb302.c
@@ -10,6 +10,7 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <power/regulator.h>
 #include <dm/device_compat.h>
 #include <usb/tcpm.h>
 #include "fusb302_reg.h"
@@ -50,10 +51,13 @@ struct fusb302_chip {
 
 	/* port status */
 	bool vconn_on;
+	bool vbus_on;
 	bool vbus_present;
 	enum typec_cc_polarity cc_polarity;
 	enum typec_cc_status cc1;
 	enum typec_cc_status cc2;
+
+	struct udevice *vbus;
 };
 
 static int fusb302_i2c_write(struct udevice *dev, u8 address, u8 data)
@@ -506,7 +510,28 @@ done:
 
 static int fusb302_set_vbus(struct udevice *dev, bool on, bool charge)
 {
-	return 0;
+	struct fusb302_chip *chip = dev_get_priv(dev);
+	int ret = 0;
+
+	if (chip->vbus_on == on) {
+		dev_dbg(dev, "vbus is already %s\n", on ? "On" : "Off");
+	} else {
+		if (CONFIG_IS_ENABLED(DM_REGULATOR) && chip->vbus) {
+			if (on)
+				ret = regulator_set_enable(chip->vbus, true);
+			else
+				ret = regulator_set_enable(chip->vbus, false);
+			if (ret < 0) {
+				dev_dbg(dev, "cannot %s vbus regulator, ret=%d\n",
+					on ? "enable" : "disable", ret);
+				return ret;
+			}
+		}
+		chip->vbus_on = on;
+		dev_dbg(dev, "vbus := %s\n", on ? "On" : "Off");
+	}
+
+	return ret;
 }
 
 static int fusb302_pd_tx_flush(struct udevice *dev)
@@ -1293,6 +1318,22 @@ static int fusb302_get_connector_node(struct udevice *dev, ofnode *connector_nod
 	return 0;
 }
 
+static int fusb302_probe(struct udevice *dev)
+{
+	struct fusb302_chip *chip = dev_get_priv(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vbus-supply", &chip->vbus);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Failed to get vbus-supply regulator\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static struct dm_tcpm_ops fusb302_ops = {
 	.get_connector_node = fusb302_get_connector_node,
 	.init = fusb302_init,
@@ -1320,4 +1361,5 @@ U_BOOT_DRIVER(fusb302) = {
 	.of_match = fusb302_ids,
 	.ops = &fusb302_ops,
 	.priv_auto = sizeof(struct fusb302_chip),
+	.probe = fusb302_probe,
 };
-- 
2.45.2

