Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C1DE6BF2A
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 16:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980CB84506;
	Fri, 30 Jan 2026 17:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kCfhXvp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7576B844DE; Fri, 30 Jan 2026 17:28:51 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8DF844C0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 17:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so1433580f8f.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769790529; x=1770395329;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pqKRSJiLBoMTLc2IzB6nr6mONfWHR3HethqOq9oFBhI=;
 b=kCfhXvp3S+fGrsB054CmVGVOTPVDeT7CsEtWmLeNYjedU2Zu2FnOgbE9uffZHZvAyz
 KVQGymb1iY5EYlphlne4gNe4bOIdix3odXUgjNU1xE8Wz35OdPm97H8BdWmIT3BpgGFk
 /wQNGa6/JLkHZT1a28a88xNZwKZUtQuei+SVVuVcly7x9ZzybvmswgZDkwAYi+0HCu0t
 ihqc1wxFExjIL5Lf6hUtXulZKZnPaXfopQtDZ/3/MRhsz7WohbQsz+khddZJ8jHh8jPx
 wXlDs7L9KbcDUVBZiCppsu3AU5pe29c67WsKjUVPxoVY6xvGHstU5uGzsb7oD7EgrCBw
 eLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769790529; x=1770395329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pqKRSJiLBoMTLc2IzB6nr6mONfWHR3HethqOq9oFBhI=;
 b=OzR9cc+1Ilc6u0EhTbgJWuq2VL9gDcKFN7pWsUJ6IihKvlugiy1U1jyR9OF3NxvVqh
 r/kPAQ6gUYhbhdZX3wL2tmK55SOeRwKR9SJpXz2d3MDfGAdDiGMNnhQ9LsafRTN/H+mK
 QO3JPKQBN0c6agvGqmBlm2+4pKO/Z3yX6nd3c50g4TsRCUobeOYwsezWMcCUUmBXVbdL
 Ut0P8EpSSR18FAunJW2XT5i1suJGe3bH9lyiq0JwIYjwrs3kiWQVge5L8D63jLDofyVA
 aaH7IrgP0XxOViDok9bk13KDIoWXEDNKyMILqP7quGvL2fkZqjFMdQH4TInTUpMQHwNb
 oEnw==
X-Gm-Message-State: AOJu0YziA79At4FBmyRRxTtfsqWW+uRb6h6DdkkrpwZcjq9waPLpokIU
 WSSEDbZt+2V/UDJq83u3pfSuD985mNPVEv68NmyoQKht0H3UiejIT/QMM/5VywDrnpY=
X-Gm-Gg: AZuq6aIUXQHdQslfU5XR/+I4/e5b9heZA2uN3Rt7pB0HdhLWs/9FvBvc6No94c5eiXa
 JxyqZdf2QKOIsBGQerFmXeHsXetxpf6kuTLaKbcBSsRqbCq8gd4kZTwPoJU3c3mV6pgBNT3JJUM
 n4BOe4TR9QHXhy4I8yU0h2vnMwHPt1F2vFiPCeLsz1m3M5ksrlR3mrhvdweQPurBQbExIhuQHML
 Uag/KbMqqBdeJHCtoNmm5YklDEwJ9gtxCDq+1QBvFGG6ZbCrWUwh2+CArDMue0b1Hcb9YA/zhjM
 5jxZ+iqX8bPgspKtNJbib2jyNfPtCqG2+lcpL0eaGk97a5g1f1lwJsu/Mzpv6AXYTjS5eFgZaua
 3n+iXha5LHJo2Wf06Ueh4svhb0UcbkwoRCTc3OCZEeCKeGcMM/farYHYxYYblmy7CfgUVK1LaVX
 JfCQAjI8U+
X-Received: by 2002:a05:6000:2309:b0:435:8fe2:e690 with SMTP id
 ffacd0b85a97d-435f3aba11bmr5746704f8f.58.1769790528802; 
 Fri, 30 Jan 2026 08:28:48 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10f82aesm25586327f8f.19.2026.01.30.08.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 08:28:48 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 30 Jan 2026 17:28:27 +0100
Subject: [PATCH v5 2/2] usb: musb-new: Add compatibles for ti,musb-am33xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-topic-musb-probing-v2026-01-v5-2-195b23c7948f@baylibre.com>
References: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
In-Reply-To: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3068; i=msp@baylibre.com;
 h=from:subject:message-id; bh=pxdruqC6ye0M25g5/n5sTz9RdsASNxuZk3+LLjGRBTE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyaO+aZwsIh8jkv6xpXsHfevZqx65xTT9Cm8K2CRcZZl
 5kMlol2lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwETyOxgZth2o0FkTk7n3SJW3
 v/shhhqFOa9yd73eutZGUOX0lT8ihxj+e/H/W1dvo7lbZu+OwyFldwPf9fv5KlibXBPdeegl9+I
 brAA=
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
 drivers/usb/musb-new/ti-musb.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 75dc2dc18748e33785c7312a24145544b659579d..2a537b5c498e5a760769b37b4a7a1515ac12f29b 100644
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

