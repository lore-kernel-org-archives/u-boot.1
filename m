Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F37D31A2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143B1839D5;
	Wed, 14 Jan 2026 10:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RcIXmOWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F365830A0; Wed, 14 Jan 2026 09:34:45 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE3783642
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so16598883a12.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768379683; x=1768984483;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=RcIXmOWHUSVimgDeOLbcKVqkztA8zPj2DTosjkUuZjwE20uGhep5MW2u0Wqrej42Zy
 A632VgwTfxRa5rRhj2z1/YqSEeZOK2dQTHZBFiv9gVDhBSmRAdiK8FkaXSLyACR9fGEF
 Omp9uITwCQO4/qF9XVsG9yoRgas8j6CzpCHhXDl6Abce4ZobO/LeewervtRf9VB+Ugs+
 MKZ64M3lRqneelsH4oykLdkb7x+F1ghUgb10N+3tSRT1lvV9vGOUI7XIQSlla58Yiu8d
 0p+8/d5GPZq4R/AOJTz7dlIG+0pV/XGdp/G3cniSWInzgibRBzrGk9Fa+8p+F9JE2gZx
 F4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379683; x=1768984483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=wMbLLL3IFohs7eVEiOQBTdTaPnFsaiPjgyydeJqRc2WIHyDxtWBw4mEa3w2+YFDbsA
 ogGGL3Y8GCmFofa6dHvJo3bns0CpFlx1OhLomlFTQjzajHM5qdihiUe3xwPEuZPPzX7K
 PobrlTQdvSiekLVYMmvz0DlWkt2L7V3DY5/0IjYk+K8bX42aSNBvUpN3l29RjE2b/hsD
 C9TdMd4n+a3jDANgVF7LNphdy9t7tnWJ0Lg2aPNnX1xJ6sIqSCBq7+XwKr8yTxLW2Wbn
 vpfjiG+VAkVWrzVTTm4+aDuFT+DPZQS70u9D80dpLpRHgJv9YAlntwEHe9kLxoDRBE5c
 TRrw==
X-Gm-Message-State: AOJu0YxNkGsLwcRICHhOHa0q7TxWhoWBq6W1pIOZ+QO44cpqkoIWKJoq
 r92SxhHDFy27s/S5O92tfjk0GeyPMkHLPPPPa9WNq1lVNm2kvRTx+kV+S9IWdcPXpjI=
X-Gm-Gg: AY/fxX4pJMpzwmKMwbxig8mTNWunk9359xgjqeszP45H+haDi0RFLzegS3lsWA1l/Aq
 IRImgx9l9/fPU87ggtVNkxL+utecs/IeL6MHcJmPTINBv7KTYkLfnqD8Pf2rH5nKHp32OgpSbO1
 EExcOZF8L/X6VVV7G8alxsibUqXITdN56rMgUMiy4EBtw2PsV6Z1IZKIcuMKa/ikjmWmd3vMHNB
 zGvW/UpAEPLWWCpD1sl9XjFev77xKHND6HaCCZNxOW1e3Luou8OeqASeLv36EK+/hStvJyeIpaZ
 aJLmIpFX38Fy98qtBvXLIx7Qi8y4YvBMEj4M+ybUabs6R44RYAE/s+lRxr6+EK8A36YEDbDaPQP
 1pAsURy/lEZsK+iaqS/fi24UpU+cIY5pYq0TPMm6ncS59LzyEqcGn3ZgpMECsUTfhjhH1Ou7M0v
 OFcF/ylWmv
X-Received: by 2002:a05:6402:2809:b0:653:db2e:c451 with SMTP id
 4fb4d7f45d1cf-653ec473a3dmr1526050a12.34.1768379682962; 
 Wed, 14 Jan 2026 00:34:42 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be65197sm22087107a12.19.2026.01.14.00.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:34:42 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 14 Jan 2026 09:33:53 +0100
Subject: [PATCH v3 6/6] usb: musb-new: Add compatibles for ti,musb-am33xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-topic-musb-probing-v2026-01-v3-6-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz0UOGGWaujr3m0MacKsJb29pY4qjgsv5k3NSnzgbXyt
 +IPOZs7SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCLeJowMXW8Wdbsf5vm7vInv
 goD05dvvb0vW3bwYbn2SQeH3jTytM4wMDfsXX5yvqf5RhLUk++uNWb+Mft1ff/Hrney/86IXrqm
 2YAUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 14 Jan 2026 10:17:21 +0100
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

