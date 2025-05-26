Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE50DC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8035782E17;
	Mon, 26 May 2025 16:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="cmoK3S3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B3582EA2; Mon, 26 May 2025 16:24:52 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC16D82F4E
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-ad5574b59c0so442756066b.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1748269489; x=1748874289;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NYCXKwjdHiEzjnGqkFqOetEkE+T0IatW9TWPO/+0gLk=;
 b=cmoK3S3I8aiHDyqb53AtykqSWTOlpzBiz1b27ykSVAmQfv6O6vOkhV7y0nm3ypc/4M
 B9p/N0/KfJxPQ2+U4xnxcPm2eqWacpm2vmBnqS/d3z21NWICS6/ThQno1p1dUIlZvjhl
 1h7olmE0FPOryc9PAPBqI+d3FY5wNOoHnImXv6QWeGqMh9bdtxPdjHiY5K7AXYemYhH0
 9eZ2diWflWJNYIBy5OSh9LoMLBY6AHryr/7q6kfFTQCBnCCKKvaxZkgjBD0jFbJnTGev
 rqDUT26NaxGL4ZsEvaypM1RaqvROKqvF4R33p8Ow/0AcCKbU1KqokGEsXzjSIvOZqv3V
 779A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269489; x=1748874289;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYCXKwjdHiEzjnGqkFqOetEkE+T0IatW9TWPO/+0gLk=;
 b=o8EYRDkyrS07Nsq/cDTj2fe4XXOS+AMzenez34WD0NysQ7x6x1gQIFDB3IrKLdf9j2
 WAgbuNjfGvrTaOCZ5neAomMYnNmg17Fo4bYiT0TFOSjTIrsO3aDMOsscaUqvbdYbN5WI
 cuCs96XmLFHJGIePAmY4NkN2gs5lUFJFZiDmYwk3ENs7HfzyeHcQPlJOpNpZ5Ak6Sy/i
 XgB/2duSlvQDK19ktmwPsDgN+6vyFDld7IsTravgqBPr/GjNQ+hmZiBTOVPcyACOJyLi
 ArbYV8wCCj5zmGANcQRZrLJiwrgJLyHbxuUcRhXi8oiF1++roiQPaCyrFCeF78uQr3vv
 4rtQ==
X-Gm-Message-State: AOJu0YzuOI4/1FJf6oXGY6SucE0h9j4zed4CRH9IWyNJobh6jYPLGNlW
 wB6Swf0FmusztkBdn54vgp79SrRRe2yxVLodqj3+HTloDl6ZN1FQH4UDSjksahFwEwP9zZO9N4v
 GBNlO2K//PQ==
X-Gm-Gg: ASbGncs7MUsZy3fYyK8WptxXsKIXdtyu2F7sBJhU1Ptsr6xzxCYCzqsh66W/HBVkt9R
 8pqrTy5rX3ivXmgf0vE2VU8oaIP8tlJXGK2Tu+kBgscysSHXh1YzaWdYIiv9rpmdbLDeDhdly+Z
 M8g1rBqZPTyss/sasREYb1GgoTKuRDlk0+zC8302acrQPAYJ3qtOCszk8yySDh0vQsWWbKErNDX
 ghVvu/B4ITEVajJFYfHhYPdfxdSiS9fb19dONYCQxad3EumZWMeXQbJ6fOTZt0Fs2E55FJimaKZ
 epZ08XmwzBG/40IfSIPC/lmCviaalE1XOfmw3pi5QLLREi5eCPf52/8/tjvsfSj9
X-Google-Smtp-Source: AGHT+IEXr8Z/AEUu90JQait0jDIGN8vIrsOadqGZQisWnZZbLOHDOHbgAy/9g8FRqmssJPOJniOriQ==
X-Received: by 2002:a17:907:3d12:b0:acf:15d:2385 with SMTP id
 a640c23a62f3a-ad85b08523fmr906765866b.16.1748269488691; 
 Mon, 26 May 2025 07:24:48 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6045c6d25dcsm2926950a12.8.2025.05.26.07.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:48 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Mon, 26 May 2025 16:24:23 +0200
Subject: [PATCH v2 4/5] usb: onboard-hub: Add support for multiple power
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-usb_onboard_hub_cypress_hx3-v2-4-f382415da84f@thaumatec.com>
References: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
In-Reply-To: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
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
 common/usb_onboard_hub.c | 65 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index dcaa24d30ece..2d2114ea6d17 100644
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
 
@@ -139,30 +143,53 @@ int usb_onboard_hub_reset(struct udevice *dev)
 	return 0;
 }
 
+static int usb_onboard_hub_power_off(struct udevice *dev)
+{
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
+	struct onboard_hub *hub = dev_get_priv(dev);
+	int ret = 0;
+	int i;
+
+	for (i = data->num_supplies - 1; i >= 0; i--)
+		if (hub->vdd[i])
+			ret |= regulator_set_enable_if_allowed(hub->vdd[i], false);
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
-	if (ret && ret != -ENOENT) {
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
+		if (ret && ret != -ENOENT) {
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
@@ -174,6 +201,8 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	return 0;
 err:
 	dm_gpio_set_value(hub->reset_gpio, 0);
+err_supply:
+	usb_onboard_hub_power_off(dev);
 	return ret;
 }
 
@@ -209,7 +238,7 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
-	int ret;
+	int ret = 0, ret2;
 
 	if (hub->reset_gpio) {
 		ret = dm_gpio_set_value(hub->reset_gpio, 1);
@@ -218,22 +247,26 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 				ret);
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, false);
-	if (ret)
-		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
+	ret2 = usb_onboard_hub_power_off(dev);
+	if (ret2)
+		dev_err(dev, "can't disable regulators: %d\n", ret2);
 
-	return ret;
+	return ret | ret2;
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

