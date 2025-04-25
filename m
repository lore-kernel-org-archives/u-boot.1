Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A43C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E34782114;
	Fri, 25 Apr 2025 12:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="Wa69EJOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7D6820EB; Fri, 25 Apr 2025 12:56:43 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4212C82064
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5f4b7211badso3430672a12.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1745578599; x=1746183399;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIcO4lT0l8GlcWSsybEE9OO5Dhe/8QVU/Ev+ZxnGi/k=;
 b=Wa69EJOV7V8agkUGNx/oPsDKx5G+IOvM19yAQcFyEC3E+K27gIyi9eI2CWs1U48OyY
 I6UOJNE7jzqa8fG4FwaH9lGvL7SJBOp20zx7hEDcSQGG9ux7RrC9P54yTHx0lTH3//Lh
 +Cqsenw25nJkgQ8VHdZMiE/lylKcS5VszzNUZI7K9R8oBba0FAd6z8KRJSRtmrQfX1tW
 XJeJ0hq1WfZq9nsl0uUW7hM/Ay0hZBlTbfSkrEdDH1gcDKoZ+YBLNhAFXDiq9i6bfahk
 iNkFMJ0IdVh9Qs6gI/aZ96A8vO3ZsLkbkAmq14UrYhYiSCAqTK8l2jaVrLcwfnFCDgHy
 Quog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578599; x=1746183399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIcO4lT0l8GlcWSsybEE9OO5Dhe/8QVU/Ev+ZxnGi/k=;
 b=sbdS2gYvtbbyzv7m+l6jwuXD0V8RMtKqGveJxnKOEkCMvsHpL2lv3pZ7WJxVKu6SWu
 ccWp5U1oH1ChpL/89EMijHJbIiA0ILtr+4gCB/FTtb6cLXWGsn05vJ/AAUoQYzaxEe6W
 jsg1mnhUTYQrt79PS4+2mO7ddDNehlZ7yU3cP/Gx3q+CBiKuUYd83MuoVxtuLAondL1Y
 igliuL7Na8AX0MhJvete9Jzx77RvFrQaS1ILzjh68Irs4rK7hpZwZEuTYWpQcq1kD/3b
 wn+s6L6Q/B0dFZaPuuNLll3XtC4QnFXvrjUP57HDtwriIHwvmLYPCQ8qG4QTtvii4Ej4
 yH9A==
X-Gm-Message-State: AOJu0Yzi/Idk1nxAQnWAHOvyxm7pKNmIKBIcwTfHd5O8vCM3erFoHGch
 N+OwV3K1iXkyP59HOhwJpqAprBcnwcNp7LAhGTtU+2X54l9B61xjGMMVnb2+mYFmHCkD+xaF/8O
 C
X-Gm-Gg: ASbGncvc3uuxfkGM6zR8rWl7PG3Gwsu8O92fx1VzTHkYQfoE7OvP+OjZXQAp2hgCfUP
 pRAtT/1ikGhu4YiDpjKBn60gREacCPb3xkeIdAh4mesZtqW2QvyZ/81sAONbWhIddPxQ0HsCIMx
 kChD+eStTxQ6djbIbAZ31HC8N2gM3yf9GTjgDXAeshI4RAxSRYppxHLmOtNIbqI0ABey3KtdcuE
 86RpNHeCY74v+ROFvjkblikH1rQ/VhoHBXKcwW1vhl7M284qhlC63c/GiGq42fKRcFQtVZZ+ihc
 4XG5HcvO5mPPtK9eXRnGip5+4LDa54rjuw6NT4fLEw6qWwuTKiyRCKyopw==
X-Google-Smtp-Source: AGHT+IG347PcXKtyNFD28QltTs1RUGLbUhraBIK45EECfZTfpTXk7ygYP3JN3FgjyJdHLxhMD2A7Ig==
X-Received: by 2002:a17:906:f590:b0:acb:5f17:624d with SMTP id
 a640c23a62f3a-ace714082f5mr176071066b.57.1745578599453; 
 Fri, 25 Apr 2025 03:56:39 -0700 (PDT)
Received: from [127.0.1.1] ([185.164.142.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf8978sm116839566b.98.2025.04.25.03.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 03:56:39 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Fri, 25 Apr 2025 12:56:34 +0200
Subject: [PATCH 3/4] usb: onboard-hub: Add support for multiple power supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-usb_onboard_hub_cypress_hx3-v1-3-3cc5a06087cf@thaumatec.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
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
 common/usb_onboard_hub.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 325c274ed952..b8fa38a4111d 100644
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
 
@@ -144,20 +148,28 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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
+	for (i = 0; i < data->num_supplies; i++) {
+		ret = device_get_supply_regulator(dev, data->supply_names[i], &hub->vdd[i]);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "can't get %s: %d\n", data->supply_names[i], ret);
 			return ret;
 		}
+
+		if (hub->vdd[i]) {
+			ret = regulator_set_enable_if_allowed(hub->vdd[i], true);
+			if (ret && ret != -ENOSYS) {
+				dev_err(dev, "can't enable %s: %d\n", data->supply_names[i], ret);
+				return ret;
+			}
+		}
 	}
 
 	ret = usb_onboard_hub_reset(dev);
@@ -208,7 +220,10 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
+	unsigned int i;
 	int ret;
 
 	if (hub->reset_gpio) {
@@ -216,9 +231,11 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, false);
-	if (ret)
-		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
+	for (i = 0; i < data->num_supplies; i++) {
+		ret = regulator_set_enable_if_allowed(hub->vdd[i], false);
+		if (ret)
+			dev_err(dev, "can't disable %s: %d\n", data->supply_names[i], ret);
+	}
 
 	return ret;
 }
@@ -226,12 +243,16 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

