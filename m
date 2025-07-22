Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB6C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BED83394;
	Tue, 22 Jul 2025 11:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="kNJl6CEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A5283346; Tue, 22 Jul 2025 11:56:04 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2E2837E4
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae0dd7ac1f5so957950966b.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1753178161; x=1753782961;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kO6S/6YkRTR2u48NadmqjbFgDg0Z0uQTR90vDUBTn74=;
 b=kNJl6CEm6wVFVSPOyLT05xAYWuJfHlE4fQB4BQp09S2VGsOWgnq6sfMsvEN9miQs6P
 nc/WRkmUFalcfxGmFUlPY0Z0akQ6UDHLtcR1R1xnob8viI8TY1hqFGrINkzvklpqle11
 jxKbSb63nz7mvypofZL0MeWhtW0NHWEUzrivZ+uJrHp4+KUEDmGCVeV8JSyqQugW6nbU
 4uUzpHw8qHV9mIIg9LgoUVVzNtbfHsA+ql+6fsLWNtNy3UlTUIDUtO6Hn0b0Tq+/vybt
 Q9J9BEOLcdG6MvRoSC4MY4oGtf01cZlOGqHtiuHxbw4Lrc6b5asGpw1kMnZJyJwxHxuZ
 pNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753178161; x=1753782961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kO6S/6YkRTR2u48NadmqjbFgDg0Z0uQTR90vDUBTn74=;
 b=sMRebw2VjSvEqJK829OzREMQZIY3eU6mcpdeF5J8EBIFjPm1y2p3zLnG0Z46jhntJ4
 fmv1hgtU7jOunAT1KqrAEySaCdCJ6zNwToRC9wc0dpp91kq4Kz1CL5bd9WTS3KSxxImX
 9j3CYoUY/C6Kot3M5+l/QYVqQxKAAHZdQimqXAgCoQBAXO71hFTVKPmq+ezcBzOLXpIM
 NmwS2S1CwRbfZJRGkRWtLlga4mRhW32IgS6uZJbybUEzAp5r3whPHV0T4CbbtZgyuXZ6
 51yXHcxUG+h9RCEnir4X+CWB8CccthISEvQLGu+CDZofmSKRecYcxkU5jOLhDK5yKq6e
 GlzA==
X-Gm-Message-State: AOJu0YzsAulvem9FhSDmVRe0pL7Dt3lS9S6cGCjYOORnb6myAk2qj2/C
 /9hoFE2/ADw0zysxZSS/YbEzLGpyVGxE7lEJBPdQKIlpFlnuak53C5GXuR1AHyMUPiw=
X-Gm-Gg: ASbGncuwNSLf7fOUs0kkmOguyk12wdHqMtdvH3mCZBw20uCT86SN8QLNESj6u49rril
 s4K2UomMqQ3W+C/qXu5y6KRzhKG5yLTMvxC5KJ1IWnMwD+wHlOvd0x6BlpLoqpDwLCc+hw3/JpQ
 m+W9UJFaSHis6tl2aOhn+PGSn6VUeRZeQLYDr27LHUOt+WNNnTLFhyFL1kN2+nCAe4HKliAPsko
 UUL/PB9sRabyd0a+K8rzohbwNKMUXXOM1syTxE4KJ29QyHL1rlk5BBvu6Y0nyHb6b6qp8QWnVX4
 Mg1rTB1d/TYAXn79QjSfadevHQqjuacDnK5O+i6wFHqj0pU7980Ia3Ur1H9JZRuRRie49ZJl95N
 gxEGrm7uQHGUGthjNJ1eRxr+Q4Zgb6OTGhw==
X-Google-Smtp-Source: AGHT+IEPzBqWgbXBptBHKPHncqcR1Hz5UxE4CHvwtxAyampFiv5GEO8QpZow8IANpsEgrF2znsAzyQ==
X-Received: by 2002:a17:907:d06:b0:ae0:cc9c:b5e2 with SMTP id
 a640c23a62f3a-aec6a623b06mr1463976066b.48.1753178161181; 
 Tue, 22 Jul 2025 02:56:01 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6c79c279sm834754866b.28.2025.07.22.02.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 02:56:00 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 22 Jul 2025 11:55:36 +0200
Subject: [PATCH v4 4/5] usb: onboard-hub: Add support for multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-usb_onboard_hub_cypress_hx3-v4-4-91c3ee958c0e@thaumatec.com>
References: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
In-Reply-To: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Some of the onboard hubs require multiple power supplies, so extend
the driver to support them.
The implementation is inspired by the kernel driver, as introduced
by commit [1] in the v6.10 kernel.

[1] https://github.com/torvalds/linux/commit/ec1848cd5df426f57a7f6a8a6b95b69259c52cfc
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 68 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 046831d09668..dbe4c3cf9b83 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -20,14 +20,18 @@
 #define USB5744_CONFIG_REG_ACCESS	0x0037
 #define USB5744_CONFIG_REG_ACCESS_LSB	0x99
 
+#define MAX_SUPPLIES 2
+
 struct onboard_hub {
-	struct udevice *vdd;
+	struct udevice *vdd[MAX_SUPPLIES];
 	struct gpio_desc *reset_gpio;
 };
 
 struct onboard_hub_data {
 	unsigned long reset_us;
 	unsigned long power_on_delay_us;
+	unsigned int num_supplies;
+	const char * const supply_names[MAX_SUPPLIES];
 	int (*init)(struct udevice *dev);
 };
 
@@ -139,30 +143,59 @@ int usb_onboard_hub_reset(struct udevice *dev)
 	return 0;
 }
 
+static int usb_onboard_hub_power_off(struct udevice *dev)
+{
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
+	struct onboard_hub *hub = dev_get_priv(dev);
+	int ret = 0, ret2;
+	unsigned int i;
+
+	for (i = data->num_supplies; i > 0; i--) {
+		if (hub->vdd[i-1]) {
+			ret2 = regulator_set_enable_if_allowed(hub->vdd[i-1], false);
+			if (ret2 && ret2 != -ENOSYS) {
+				dev_err(dev, "can't disable %s: %d\n", data->supply_names[i-1], ret2);
+				ret |= ret2;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
 	struct onboard_hub_data *data =
 		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
+	unsigned int i;
 	int ret;
 
-	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret && ret != -ENOENT && ret != -ENOSYS) {
-		dev_err(dev, "can't get vdd-supply: %d\n", ret);
-		return ret;
+	if (data->num_supplies > MAX_SUPPLIES) {
+		dev_err(dev, "invalid supplies number, max supported: %d\n", MAX_SUPPLIES);
+		return -EINVAL;
 	}
 
-	if (hub->vdd) {
-		ret = regulator_set_enable_if_allowed(hub->vdd, true);
-		if (ret && ret != -ENOSYS) {
-			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
-			return ret;
+	for (i = 0; i < data->num_supplies; i++) {
+		ret = device_get_supply_regulator(dev, data->supply_names[i], &hub->vdd[i]);
+		if (ret && ret != -ENOENT && ret != -ENOSYS) {
+			dev_err(dev, "can't get %s: %d\n", data->supply_names[i], ret);
+			goto err_supply;
+		}
+
+		if (hub->vdd[i]) {
+			ret = regulator_set_enable_if_allowed(hub->vdd[i], true);
+			if (ret && ret != -ENOSYS) {
+				dev_err(dev, "can't enable %s: %d\n", data->supply_names[i], ret);
+				goto err_supply;
+			}
 		}
 	}
 
 	ret = usb_onboard_hub_reset(dev);
 	if (ret)
-		return ret;
+		goto err_supply;
 
 	if (data->init) {
 		ret = data->init(dev);
@@ -174,6 +207,8 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	return 0;
 err:
 	dm_gpio_set_value(hub->reset_gpio, 0);
+err_supply:
+	usb_onboard_hub_power_off(dev);
 	return ret;
 }
 
@@ -218,24 +253,23 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 				ret);
 	}
 
-	if (hub->vdd) {
-		ret = regulator_set_enable_if_allowed(hub->vdd, false);
-		if (ret)
-			dev_err(dev, "can't disable vdd-supply: %d\n", ret);
-	}
-
+	ret |= usb_onboard_hub_power_off(dev);
 	return ret;
 }
 
 static const struct onboard_hub_data usb2514_data = {
 	.power_on_delay_us = 500,
 	.reset_us = 1,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
 };
 
 static const struct onboard_hub_data usb5744_data = {
 	.init = usb5744_i2c_init,
 	.power_on_delay_us = 1000,
 	.reset_us = 5,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {

-- 
2.43.0

