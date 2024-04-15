Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D88C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 10:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA1487E91;
	Mon, 15 Apr 2024 12:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="CmdDo0Wg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE6D87F41; Mon, 15 Apr 2024 12:54:11 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED77787DE5
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 12:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516d2b9cd69so3553394e87.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713178449; x=1713783249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TeYrfHdX0hY7/NcgZqYBkN3GUj7rSR9LneCos7EN7lg=;
 b=CmdDo0Wgirg9ndwP50ii4Cp1iArOePqglXZwDEO8cJ0NXW7nvl1XyKJx9evcEAbW3h
 lQUQsluVhL8T5MItlKlFwN8KmFkVtw8kwBjw5YyeO0yJiyE4r0XIT7FHTL8Jsiyq+NEI
 n2mBL4aDfsbPEGJIB8Fztutwai8gEQzSuM0dfyj6LJZ7grvxMOpQF8qmshhsiVna+pW+
 WCyMbra77yjp4gxiC7+9r0s4axQRNZh2N3NQ9kliUbERgpj1AHOEFVG8KSpGGGGuVaD1
 zNImT6eXL+/eU0w70wacR5y6lGZEn62chOjgSmwdIeNKeb83BRmUUqPSUxeiN+HpVdyb
 oP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178449; x=1713783249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TeYrfHdX0hY7/NcgZqYBkN3GUj7rSR9LneCos7EN7lg=;
 b=edt83kWuAle5GfNYWYdIUAscDtiYjJBWKYr1y/YhJL46INmQlTBgmJj9zaj4+oRmyo
 l1symvln+vQLSYnih6oI0bXvDc2gm/fJTEoKtbjuuV/Q4PatLtUgSbeu2q0X3fHEdtAm
 r6f4w2LROoIN5pr6lnGLCj6uMJFV9zLiw9RNkGGCxpE8hYdSFpml9BUh7oJ0oC0t+N3Y
 ZMKcTLWNW4NdIngnYiqp3CMaOz46p7qQ4meK4o65F5Yi2E+UaPffg3saordhpmECTkTV
 wRc3FsbUummohPYMH8PD80IrtpHaM95wPxVhGHkcQH3wCGGC62GPpX7EtEsUJ9fhN/KA
 MqWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpjfq0tH6noJ1+kANOUIG9EZH4VCDadecUATevZjd91rCoiHVZh8MpA2C6yALpjdiRIwqJzyZYKcxBBuGM0XFj9q0XsQ==
X-Gm-Message-State: AOJu0YyaP6pKvCX9mO5opwGIIqita2EGDi7PSkNXGkI3Yj+WRYV7gHeo
 Zj+CJajL46fCbmqm69qcpEAHSvkBEU+co8wIQFfZvXpPBCJADFPe2IhxL7rVi+4=
X-Google-Smtp-Source: AGHT+IHgKpwQHbj5xyN3Elp6c0x+4ovEm0B/UYIaU+ls+yZWwAuK2zLAJTcwnafdpDNwM/U9jYUcQg==
X-Received: by 2002:a05:6512:b15:b0:518:c057:6ab1 with SMTP id
 w21-20020a0565120b1500b00518c0576ab1mr3768810lfu.66.1713178449207; 
 Mon, 15 Apr 2024 03:54:09 -0700 (PDT)
Received: from fedora.. (cpe-109-60-83-25.zg3.cable.xnet.hr. [109.60.83.25])
 by smtp.googlemail.com with ESMTPSA id
 g21-20020aa7c595000000b0057017b6931dsm2152669edq.13.2024.04.15.03.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 03:54:08 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: marex@denx.de, trini@konsulko.com, jonas@kwiboo.se,
 kever.yang@rock-chips.com, jagan@amarulasolutions.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org, peter@korsgaard.com,
 sjg@chromium.org, neil.armstrong@linaro.org, u-boot@lists.denx.de,
 j.beck@linefinity.com
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] usb: dwc3-generic: fix support without DM_REGULATOR
Date: Mon, 15 Apr 2024 12:53:06 +0200
Message-ID: <20240415105405.432679-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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

Recent addition of vbus-supply support has broke platform which dont use
controllable regulators for USB.

Issue is that even withou DM_REGULATOR being enabled regulator related
functions will still build as there is a stub in regulator.h but they will
simply return -ENOSYS which will then make dwc3_generic_host_probe()
return the same error thus breaking probe.

Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulator")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/usb/dwc3/dwc3-generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 7a00529a2a..784d3ec2ed 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -242,6 +242,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	if (rc)
 		return rc;
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_supply);
 	if (rc)
 		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
@@ -250,14 +251,17 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
 	if (rc)
 		return rc;
+#endif
 
 	hccr = (struct xhci_hccr *)priv->gen_priv.base;
 	hcor = (struct xhci_hcor *)(priv->gen_priv.base +
 			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
 
 	rc = xhci_register(dev, hccr, hcor);
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (rc)
 		regulator_set_enable_if_allowed(priv->vbus_supply, false);
+#endif
 
 	return rc;
 }
@@ -265,14 +269,18 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 static int dwc3_generic_host_remove(struct udevice *dev)
 {
 	struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	int rc;
+#endif
 
 	/* This function always returns 0 */
 	xhci_deregister(dev);
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	rc = regulator_set_enable_if_allowed(priv->vbus_supply, false);
 	if (rc)
 		debug("%s: Failed to disable vbus regulator: %d\n", dev->name, rc);
+#endif
 
 	return dwc3_generic_remove(dev, &priv->gen_priv);
 }
-- 
2.44.0

