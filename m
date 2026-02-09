Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF14E78D70
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 09:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6193083C14;
	Mon,  9 Feb 2026 10:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uj5QG2rO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1675183BE1; Mon,  9 Feb 2026 10:25:36 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0203A83BE1
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 10:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so39926205e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 01:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770629131; x=1771233931;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L2Ve1cm++bvkG7uXFa8zm4pJ0Gk87BHPDjfWedYi12w=;
 b=uj5QG2rO5F7AyGlCiJwZb+dsm3gXFXQex6fAOXvAMxRwM7SRn7M8lm7qdLuhKi5MV1
 nf4eSnDhL02K7v3MAiigNNax4Iuj1E4fJbqTsH6Oae20iAcRNjjd/IsvRx2qE/YWtW0h
 PL12ihlsrPeoaKxTNbaUX32ZH/WKzwvdOBe0qSs+Zm1jn5Ml5ZhTxaB0uj4XF181f1PS
 ZiafAYlKH9iUqgOXsOoYaHKo2po4M78dTlNTc/2FrFgoxnWLEjoiLSrjpFUtfhZSZDb7
 AW32/cvyVcFi2xpKD8mSw4sQfM5QX+IgxpY77es/+CvpvpgGztF3hS+xN9nzDKw09TAf
 rXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770629131; x=1771233931;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L2Ve1cm++bvkG7uXFa8zm4pJ0Gk87BHPDjfWedYi12w=;
 b=HuFT5zckIgy0cGQYjDrCFI2sbKMrb/jjsAcGsvuWGb1XcN3Mif4/pY60AoLEX+ES+j
 LWPP/heiaBQCFKNoLjvw4f2nSGatPgJ0FyLKLlfG9ZtkYHG8GoMqn4NlHk1Tre5McMr2
 A6pbDIFkA6M+M8qcNNtUPwP5crr+Mg/yKlLKlt481kdvDrn3SDh4K6qBmu86MnMZKdTm
 wu5UMMA2EcDTl9kRKtVOpSAQNu8QsulANeeNUeREFZD2tC891umMTSVvSaGTj3Fegz/D
 MWHGolfEY1sqdYdyCkDXrm1/YjW6CD7VGPmamBlKrK7yDYOFlbdPwNsPHQ6t9DMxTGMs
 E16g==
X-Gm-Message-State: AOJu0YyU5nb+O5+/peJ6UoXsgVie4MBAz1hsaWL73E2EH7mhh8O+7byK
 9xH+3pp+XxTjK9BqgsBenWM5ZcpeVW4a/h0ZPZRQpT90LYJcrCcWXjKLT/IJ5Wwo+DdOlZNIY1o
 f/mFc
X-Gm-Gg: AZuq6aI0sqIj978q9alwZrQenB+dtbHqrgXUO8SuaXq1KilwXmMRQ+6g1tWIosToL3E
 S8myXPH+Obh0VziTocIvmJ/NbN6VQP20M4vGpJaPZ/KfewtKqS2XjryM+3kk6ovX6hjEKYXsp3V
 xSvnhnst7hEUbbKyeoxOmC8Kl47pJ+EO4yCTvNvevv9LZtP+YIZ1ekI/idw8qq9ccNuUb5FWxae
 mJPxMiKug3WMdK/PUY1QdfHRiEwPRoJ5HYU3vxKMACKGwv8fJpv1CWvpb+8+DVWKif29UZVup/x
 JbxjVVCAIsXN/9+Oh4QeKZudiWHNjKW+cOAye+RqtxvSrybrspLapU9EzexzU/nkMoZoxg6U7CI
 s3H4k7xpYWyGvRnrpCMbgnJNnVyuPWWvACZf5sbE2+haQY2xXEOfGkXK5Jadlg8BHY0ILB6l44J
 k55wlm0ALl
X-Received: by 2002:a05:600c:3b20:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4832020df6amr139163845e9.13.1770629131359; 
 Mon, 09 Feb 2026 01:25:31 -0800 (PST)
Received: from localhost ([2001:4090:a244:8139:5278:cf5a:3494:5e80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320719b8fsm252871515e9.9.2026.02.09.01.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 01:25:31 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 09 Feb 2026 10:24:38 +0100
Subject: [PATCH v6 2/2] usb: musb-new: Add compatibles for ti,musb-am33xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-topic-musb-probing-v2026-01-v6-2-efce26b4917a@baylibre.com>
References: <20260209-topic-musb-probing-v2026-01-v6-0-efce26b4917a@baylibre.com>
In-Reply-To: <20260209-topic-musb-probing-v2026-01-v6-0-efce26b4917a@baylibre.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2695; i=msp@baylibre.com;
 h=from:subject:message-id; bh=NI4IjsSpyydiEIhY530/Gs+lVR1hP+x9L0QTHle1Fuw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszOFcy3z79cuI2RRUnm7B3tO3UF0+9tvnQ+MsZq9t6As
 teiO16s7yhlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJlLozMmyM2ros94joObcg
 9fW6xx3U1glumDVvQWz497SrHxYzmT9jZDj7qXZLyjLjA0sf5zExFmeE1p4+vF5Z43ZFuPG/j+l
 2AcwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/usb/musb-new/ti-musb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 75dc2dc18748e33785c7312a24145544b659579d..cc6c3b94a659a2d60fcb2583cb44baafc22deb69 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -183,6 +183,21 @@ static int ti_musb_host_remove(struct udevice *dev)
 }
 
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+static const struct udevice_id ti_musb_host_periph_ids[] = {
+	{ .compatible = "ti,musb-am33xx" },
+	{ }
+};
+
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
@@ -206,6 +221,8 @@ U_BOOT_DRIVER(ti_musb_host) = {
 	.name	= "ti-musb-host",
 	.id	= UCLASS_USB,
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+	.of_match = ti_musb_host_periph_ids,
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
@@ -283,6 +310,8 @@ U_BOOT_DRIVER(ti_musb_peripheral) = {
 	.name	= "ti-musb-peripheral",
 	.id	= UCLASS_USB_GADGET_GENERIC,
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+	.of_match = ti_musb_host_periph_ids,
+	.bind = ti_musb_peripheral_bind,
 	.of_to_plat = ti_musb_peripheral_of_to_plat,
 #endif
 	.ops	= &ti_musb_gadget_ops,

-- 
2.51.0

