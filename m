Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948A2D11184
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F5D84284;
	Wed, 26 Nov 2025 23:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ORe0P5Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21EA183AA7; Wed, 26 Nov 2025 21:31:57 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA2D839D9
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso1118545e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764189114; x=1764793914;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=ORe0P5NhLoE12na+1/kwhloEG748YutxvVRx8thLhLcrjS18XPTVRv2AGIFexm87+2
 X1U2s9Iuldr9M2x5KSXcSrKIc0MWzb4XMouvAHQ5lP85CRjiITDryNSDxjXaSo5qRFay
 dKv7ty6q6H/UYc3GYMcxhxdZbLEMQgyYo6zpclp4a8fBndvwgzHZvRya/dYzoYf/3lKb
 MyO9DTdhamI9ssTHNPkmthJ1R0lQSWUGEphJEqbxcAITa2Bz0/DL94j0YzS5LdNe4jYd
 sTPM/6e2ywhWWZzuL6QlDwbKyWkRx8OFvhAyyId0PvNSI5A0+0SfsMmzzIxM0hSep7Lv
 jopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764189114; x=1764793914;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=Yd52fwJpbpDRX4tulZPNjKoj2COJcIHSkYla5gu4LYsh36xZzmajqPtU8mApvPthXk
 qLcthHEx7JI57dN6OVV4oC9tEBf7NnxBFWJ9pkiSa8JfAZVU5qynyxM03LA+loZ+nDDG
 DnP6Q1FLbReE50TNxLPQrbhwZkhefSgC0pTqPN2wSv46FmgxQmmQEGtQo8FX/PMl5E3l
 UsiDH9tKTmP709ugp/Q5L3P0Y8rwhsh9KXCah8g/VEpT4cOl91yGguTpLSbRvjm8xvcK
 fkGjHA9gnIq6NV5Swfb2C4UXf8od/yBeERWYkTomRs9yRRLj5bzs8CVjJT8y/c1pv17e
 1adQ==
X-Gm-Message-State: AOJu0YxEGWoNkFEyr7d8T51LHlRbjIR6eazasix3GVNtoTajA0kJk0a4
 pZ5u+zfxpFvwQeHM0JZC4EuJAbP1wyUAYzwfdgNzJRIORXmzaD0J96ApsyvsD3RUMzk=
X-Gm-Gg: ASbGncuh+df5ZcZoLQMzo2xU1m1A7qTzjBPpCzNNu+JDRV5IJSs+DxTJByjRdii9ovn
 GapIhPZ9Sq61WaUdK5YBCGZ+QiblEOhFDxwgc6hrQysoylga3+hn6O+1Nw/udNCqvj6e5BkcVIS
 Xp6Ipy6+aYBO9n3+6bMVPO7lxj5FYoUrxXnROy07TL8NhAfE4bzEOTVPfX9BIH4Zo1/kqWyaj3c
 GWc3oBdqeskvTZ61mQqa2zvlxRKS5qA2+fpE+V8V9RhXHlfhSQLkf0Ys/V5FHwF6/lh2wCz2mny
 lWTBiZ4fhzB1ayUCiLW3AZCwGskUtZlSqjvSTKOoEJcLfW8k2pHxkRKScD7hVd0VReYHGzc0N0b
 JnWgcQS/XPPYrXs8ljEnk0X/mPo91E66DSP9btlXbt7nVUOOzHWU1jpLvqlP/mEMo4BHuGf9YZ3
 CDIRdYtKvdAVmcJIQhSg==
X-Google-Smtp-Source: AGHT+IH4lWy3REKstU5GbUZXbkb50LEZ+7hkTAxjwu8+4QLPwzHAn35EtKaOWWzOudzw0pInJxPmhA==
X-Received: by 2002:a05:600c:3595:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-477c0184b34mr210965055e9.8.1764189114612; 
 Wed, 26 Nov 2025 12:31:54 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4790b0cc39csm63875905e9.14.2025.11.26.12.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 12:31:54 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 26 Nov 2025 21:31:10 +0100
Subject: [PATCH 4/4] usb: musb-new: Add compatibles for ti,musb-am33xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-topic-musb-probing-v2026-01-v1-4-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=msp@baylibre.com;
 h=from:subject:message-id; bh=uGzKJN7DWL3FCQ5D6PF2C0uZHVuSAaEIbFx2MIt0MlM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkz15A3LhTXDSmJvfVprt3ghs+DFw6/6wgM2P+pNKIrf0
 bGz4MfrjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhIJAsjw+ppkqXPI7dudA9z
 naz5/O9t75mWXk/jzZNSTyx2YXX3tmBkOLbe9pKPl5Xqw3W9fB3qRkfq5FdYlH8yY/n1j8Ph2tV
 CVgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 26 Nov 2025 23:50:13 +0100
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

The upstream devicetree am33xx.dtsi does not have a "ti,am33xx-usb"
compatible, it uses "ti,sysc-omap4" for the same node. The
implementation of ti-musb uses a wrapper driver that binds to
ti,am33xx-usb and creates new devices ti-musb-host and
ti-musb-peripheral depending on the dr_mode property.

To avoid this wrapper driver with the upstream devicetree, add
compatibles for "ti,musb-am33xx" to both ti-musb-host and
ti-musb-peripheral. Add a bind function that checks for the correct
dr_mode value and rejects binding if it is not the correct driver.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/usb/musb-new/ti-musb.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index d3c3d3057c1df2a5cc62df3c57d8b071bb0f12b8..3ed6428d09883cf5af28b212c0d614b3d8ef9227 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -183,6 +183,16 @@ static int ti_musb_host_remove(struct udevice *dev)
 }
 
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+static int ti_musb_host_bind(struct udevice *dev)
+{
+	enum usb_dr_mode dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+
+	if (dr_mode != USB_DR_MODE_HOST && dr_mode != USB_DR_MODE_OTG)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int ti_musb_host_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
@@ -200,12 +210,19 @@ static int ti_musb_host_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
+
+static const struct udevice_id ti_musb_host_ids[] = {
+	{ .compatible = "ti,musb-am33xx" },
+	{ }
+};
 #endif
 
 U_BOOT_DRIVER(ti_musb_host) = {
 	.name	= "ti-musb-host",
 	.id	= UCLASS_USB,
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+	.of_match = ti_musb_host_ids,
+	.bind = ti_musb_host_bind,
 	.of_to_plat = ti_musb_host_of_to_plat,
 #endif
 	.probe = ti_musb_host_probe,
@@ -221,6 +238,16 @@ struct ti_musb_peripheral {
 };
 
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+static int ti_musb_peripheral_bind(struct udevice *dev)
+{
+	enum usb_dr_mode dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+
+	if (dr_mode != USB_DR_MODE_PERIPHERAL)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int ti_musb_peripheral_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
@@ -237,6 +264,11 @@ static int ti_musb_peripheral_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
+
+static const struct udevice_id ti_musb_peripheral_ids[] = {
+	{ .compatible = "ti,musb-am33xx" },
+	{ }
+};
 #endif
 
 static int ti_musb_peripheral_probe(struct udevice *dev)
@@ -283,6 +315,8 @@ U_BOOT_DRIVER(ti_musb_peripheral) = {
 	.name	= "ti-musb-peripheral",
 	.id	= UCLASS_USB_GADGET_GENERIC,
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+	.of_match = ti_musb_peripheral_ids,
+	.bind = ti_musb_peripheral_bind,
 	.of_to_plat = ti_musb_peripheral_of_to_plat,
 #endif
 	.ops	= &ti_musb_gadget_ops,

-- 
2.51.0

