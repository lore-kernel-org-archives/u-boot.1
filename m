Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC31D185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699698419C;
	Thu,  8 Jan 2026 14:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="plJKXvEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B9C84129; Thu,  8 Jan 2026 12:17:33 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E055483B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64d4d8b3ad7so4794904a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767871051; x=1768475851;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=plJKXvEV+/H0gUtKAhUJ2smtm7Omtvu1I54S+/CGrngpUDnSe9AbwtBtgrmzuVegwV
 VMMtn/3Ke/Tud1aHJgN2OYQJk1z5pbmtlSNskRrYDki+yaEj1/Tscjt6kGqBMliUQLM6
 o69FksdVHT59fd2H7BXd0Tb99DNgbge4ocbacgeyFUX456rOan3m0nswmxFjzvBf4i7x
 ag23uFQ4qBKNFk0rJh30IyOxTDjmV8lFMj8jFys+qTRcQaWJTCY7Izacvw37TBy2AcCb
 b/7RGF7mLusShwv6IOSPkFO0EC5+bbqDEGXDs3jHSbyZLLoxiR9HOv77yYJamz9A6sW/
 uWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871051; x=1768475851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=esdaacKNXlZSDywCvznD2HGXxa87ZAAFesr5GiRsaL6vaU9b+c4sAksxcZFCrBHWGC
 jKpM1C3r6JNuNR0avZWvnzJExLvnKlvw9ioFnZOy/K/k3ZylZY2U89phGlbDTJSeN8FO
 0+zMWzDHC/chhp1fO0uHiWRzcAhxqRreo7QZyuWvYM3n5hOcyNJNH9KALa29Yxq0z/Bl
 SGw+5+dhMww//HoOed8KMAyQUCi52dewvZmY4go+9K/MxdXJFvE6Jud7xqG/cTUi+uLZ
 yiT0C/8Ow2k26Nj9E5r89Dsc3b78AUnAFXNaKgdVLD26wOD1wQ3EsYDQZWh7NVWQa5QR
 WVXA==
X-Gm-Message-State: AOJu0YxzxvOUu4YwFXTdu7I6yX0KOk9zo1CNPmGif6ESDijjr+R9/IkG
 Q2KDUl0wWdMSbmPlimprE5xAcSRN8RASegaYwbzTwqq7iFBiaPTSBGq0uPvQZByJkFo=
X-Gm-Gg: AY/fxX5SyP4PR8XtBfQfu1OFG0J1JBb2jpmriZMe1orRBSft+nxk2guDEyCjxA5rQ9H
 O68psxEN2GGMQ/Cj0fhvuW0CwOX+cBvwPReFpSPIb4SgW55xMMibPvBTfIfRelTe6VTzkQ1QXLr
 Dn3dY3LwVAzPif3p26kLLfLNDUsbZ3rAQFXe+C3pjx4NLd7yT62UAgzuC7LXX6BUdUtAap1DMjM
 iGzbYH46xtPh7r4flEa1V+wpHRiK3m3RMFPA8eAYfgBw12ugOsjO6MVgAoc2K5P3GLUp9N6KEes
 /7vu9+kSHjmbdP37R3sIu+9lb9FCxasU6Pval9iAsAk3W+9M/7O/hX+vPrX/aF7i592m+ajHSW7
 alo1552X/0eyRKmxrfiNfrro+21UPaLGu92APhJwjT2VpaOz0Nx4TiOyXmWqDv+pi2Tx6conrlm
 R6nR0MtTw0+ZyyjeaBP48=
X-Google-Smtp-Source: AGHT+IHOlj0Q3GaFuXbmCxLlWjhYQrZWWGd7eXJfWhhzaB/Ts0Jm9D7iMcyDCeeGZC0hb3D7um/NrQ==
X-Received: by 2002:a17:907:868f:b0:b83:246c:c857 with SMTP id
 a640c23a62f3a-b84451dac03mr543440766b.17.1767871051083; 
 Thu, 08 Jan 2026 03:17:31 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27bfbfsm773317966b.17.2026.01.08.03.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 03:17:30 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 08 Jan 2026 12:16:32 +0100
Subject: [PATCH v2 6/6] usb: musb-new: Add compatibles for ti,musb-am33xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-topic-musb-probing-v2026-01-v2-6-2a47c6e0e73a@baylibre.com>
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=msp@baylibre.com;
 h=from:subject:message-id; bh=uGzKJN7DWL3FCQ5D6PF2C0uZHVuSAaEIbFx2MIt0MlM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz4SXZxkp2BeWa19/U9z16KtSlT/RFfxSid8HJdxtndZ
 evyD/7sKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInsLWf4Z/ytdduR+btieX6u
 2vao/eShdRtcp87p++yd93PhtXXbyqIZGdbz9butzROdMWN9WmLfFZNJbJu1HmsnZ4TP2Fzq1fj
 4ACMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

