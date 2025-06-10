Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D318C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7715582BA7;
	Tue, 10 Jun 2025 10:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="PoLbFhfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE18580C83; Tue, 10 Jun 2025 10:02:38 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F9A182B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-ad56cbc7b07so746280866b.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1749542556; x=1750147356;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZgtU+TIuHQNf/ZRzt7dyQbU9JWxXVIun5DqUgtsEIFo=;
 b=PoLbFhfvMBHPEZsOf6EmC+z6HNr4O5AVcnEVlus37sE/TSSq9ZKUgSpPkvyldia6YM
 ug6pb9jed3GIcv7v6QbxbEff78AevA+y7s6I4sN0hC9LdF1qdGKjAyFbMm6yIkcSE1Rt
 YXfaK/UHw9LRw88Y0xkxjZjjnPAMyvBYiwXfwecnGuIds/ooRGSEyJ2vE3UC4oJk3h08
 cS8en2OVkkpsvwkTTJmD9EF+YF2Hx2Fe7+OHy75ZtPxXi8Ik7WjT0xq7CVr3T3F8qbkI
 pywYjld7vKAH7euzrk0AkSvWY9bL7lXXmXDYO8UD8VQISdob9FSzCAlLk4LBLI3HjHgl
 M/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542556; x=1750147356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgtU+TIuHQNf/ZRzt7dyQbU9JWxXVIun5DqUgtsEIFo=;
 b=EvLMChFrs8TpVq3L5wE01kDwelFW6ZmFwQGrz5rzHGmQlROdPnKRnr1koKSpX/F02U
 AaynraxT9h1Fi8pbQxn0av7VSdAikQZ7X2Pqze+CjJ0ee2dN49KcH3RmR2Gj1VyZeFWA
 +19JssiVTYMujrWFwp/CKk76+Ai43sZXgfLV8jU1ZK61sim5WPf3P3DL4lkC2X9apbkq
 BQtncqk1VF9sX3elK5zJIQblOaUz9ZekT3tuburNYrWqgS3r/SS6vMHFLmhXXVjXiaQD
 VG030rpTzIahSCQEOa3J1CYJPM1onYQX23CKvYGYplkXq1tOM96qDz2igBuK7B3XYfNd
 t/9Q==
X-Gm-Message-State: AOJu0YweKgBlezcih1XfsYBBVtlphty3vnuMmT2U+O1ZcI7+eEvnmY0E
 CtI3t4mvI6W8S4iXi3GJa93J27uLsnaJ+LIM610bAPAd90mth7NbYei9xfaSMAON+zY=
X-Gm-Gg: ASbGncs8x9MFxO+Djpaobe6De9Ei3w1b1FHXdUbpSucMi/iyf97B30W8M0XQY0dVWnG
 Wa1IQ0d+LczeRviK50COtiLDw4e0Re5HBEUCML4oXtGh6mCIKBEBDUdH+8rBKd3hHFQROaJdCZW
 aeqhBuHXvkZbpXaLj6RjP6Ja0IivCL+pzL/OZ+Gu/hpjqM0yokjAAIxGk76lxqA0EhWJ+/+C6mr
 yuLmmHdzhIOiW8Lo1CaeadKcDMjbw+OMgMIBd2nO+EyAGc7Eih7B8g8WkaaOK5Cw40ET1sm5xlY
 9M3AAIkvwd6lZHe5U3nhmwMow+mbPyxBHVPOhvUQ4NmnG7ud+z0KOWe5fg2OkeLouBXcjqpUeM0
 cciWGRHA0vg==
X-Google-Smtp-Source: AGHT+IGE1ck95DEhnN+YnGOU0jEBFTdT5QSQ2VSVhnUDONv7CitwtiUu3JthS8xILXxE0h7PwwlnWA==
X-Received: by 2002:a17:907:7246:b0:ada:4b3c:ea81 with SMTP id
 a640c23a62f3a-ade1a9c7cf3mr1470914366b.39.1749542555877; 
 Tue, 10 Jun 2025 01:02:35 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade343eeea1sm578233766b.74.2025.06.10.01.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 01:02:35 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 10 Jun 2025 10:02:12 +0200
Subject: [PATCH v3 4/5] usb: onboard-hub: Add support for multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-usb_onboard_hub_cypress_hx3-v3-4-53f03dbc3017@thaumatec.com>
References: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
In-Reply-To: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
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
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 67 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 046831d09668..273b626dbaee 100644
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
 
@@ -139,30 +143,58 @@ int usb_onboard_hub_reset(struct udevice *dev)
 	return 0;
 }
 
+static int usb_onboard_hub_power_off(struct udevice *dev)
+{
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
+	struct onboard_hub *hub = dev_get_priv(dev);
+	int ret = 0, ret2;
+	int i;
+
+	for (i = data->num_supplies - 1; i >= 0; i--)
+		if (hub->vdd[i]) {
+			ret2 = regulator_set_enable_if_allowed(hub->vdd[i], false);
+			if (ret2 && ret2 != -ENOSYS) {
+				dev_err(dev, "can't disable %s: %d\n", data->supply_names[i], ret2);
+				ret |= ret2;
+			}
+		}
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
@@ -174,6 +206,8 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	return 0;
 err:
 	dm_gpio_set_value(hub->reset_gpio, 0);
+err_supply:
+	usb_onboard_hub_power_off(dev);
 	return ret;
 }
 
@@ -218,24 +252,23 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

