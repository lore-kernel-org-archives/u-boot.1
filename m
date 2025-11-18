Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EFFCEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF2283E16;
	Tue, 18 Nov 2025 14:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A6vBysp9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9914983CDF; Tue, 18 Nov 2025 11:42:28 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A57583CE8
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b735b7326e5so769758666b.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462546; x=1764067346;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=A6vBysp9dO8VN39jXmHjRg6zfWELeaSOzGq/BOhOtAz9eoeqwc5kCgJeS8aLeWjVye
 H/NOjmzvzm1gE6y2DDYQv/xcuJrozA1tSxSiPFjLBkZev4Sk7YN1baFDaJrCGCs/21Lp
 A2cVIKazx2dYp9UTVe+0eCU4xals0Y15i/sYNwGSwpv2OsWQBNP4x+VeeJa1cZBoFUI8
 xGEFC8Q6zGmyu6ewcclJlYpDl+YIGBM+Y3eOC0vcHIv/g85rbH9RGjADFHlCkqbBLTSe
 Yvs9ei2k6cMlrTjxndZAa6OEZn7IfcUp2ycQTYCo0RlL9dozbEmU0gdpRzm4tT9txiFn
 eyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462546; x=1764067346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qBMevSWWS675F5XB2fBesu/qT7soHlTFKsXd6dyA83w=;
 b=bFKp8RBF0IzTdmEjAi/U2j+6PS8mQL2SSGHyruaPpMvym9R93gOqdn4+qZWuqAl/k6
 W3OY1v5cR6cnKTSRDM8Cdxqi15B0nbGb1Omww62Dj96yw1zouwnfaxlsA4BxP73Mb/19
 2pH/iPTMSEGbFt3qM0Ee7BOhGziM5T6+2F1SNEyGfZ2hVZRHtI5V3iPFUF4VoJPdFpA9
 1hPCqW0sRMwkw/mBMnoX4yu2Q3GBIe3votiauygMay0S6XIeYdU6Nav/YpqrSSqPljX/
 S+ot7RuiQC512L73ADtvV9yxvljnAJXfL98Evui8vkBz2N41LKpQSn1HY1RBejUF9z11
 1VYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaEn+KdmAlpq6dMHy5S7a0hYLIzd3x4RhtjTeAP/m+INCtxAFI/Ye1i3HmeIndig/6psp7/M0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1x5VtQmM8T6kWXyUT6H26JCPI1L9/bQ1lF+P3xOOk8YSdH8q+
 H7KoXsCb1XIJb3vWJ3Dl2eQcHEoeThajB1i+PJW4mDlkkabnzkCEjpTpuvX5cNzGH9U=
X-Gm-Gg: ASbGnct+F0uZkWbQZMumm4tES4pPPR9RteumuYJiiToZr6EtBYKXNOyUl/qeb8+IEkx
 WcSwDYIGyxw6Fw5Pq5nKsvZoMzmP+LCZ6aUaFviWjnpsbs1MJTLmXCPJ7ciQzs9H55DPIZRK5J1
 0sVT+iRlHK4cHPyknFPuc4nPT4Gr9KcLDs/XSZ3Znq5thHV2d/bbzK84brysqvlBc21QG1PilvQ
 19bHTt/4ssHGNBByOfoTyrxFJiapA6gaw2ePq8EF3m5s/aStMvjbwSgt0Yocj2POVElMDPG3QYY
 D8S0a992rZv4kNqnnXuh2s7rQAfyGYAvyuRWK/4XUZ23zKMQuuGXsH8rIsMb83d3zVfiNBm2ZKm
 IBUwI+L0VNrSKeYJ68dRepitvIzuYKDmKutj6uqLX+uWWHrIqj727B0WXiEVm1cIKmiREEXKa9E
 VuoTzoMCA=
X-Google-Smtp-Source: AGHT+IGT7j9QJ2OWy8BGnfRl8kGL1cxc1Ig7bNuaa5mabvDr5jqzeK5tEB4NY88cW9gHcaMhD4FVVg==
X-Received: by 2002:a17:907:9449:b0:b71:ea7c:e501 with SMTP id
 a640c23a62f3a-b758bb218cfmr347758866b.4.1763462545967; 
 Tue, 18 Nov 2025 02:42:25 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fad4494sm1308599466b.18.2025.11.18.02.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:25 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:30 +0100
Subject: [PATCH 10/15] usb: musb-new: Add compatibles for ti,musb-am33xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-10-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=msp@baylibre.com;
 h=from:subject:message-id; bh=uGzKJN7DWL3FCQ5D6PF2C0uZHVuSAaEIbFx2MIt0MlM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ35TfplJz42IiKuL8Pd7MvL1nR7JE1UEOJ9m/Tj1n5
 6Sc95nfUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABMJ/Mnw3112+f0wr9nP76X3
 WIrpmUzYzp/0dOKUJUoaubJbOP33tDMyrOr6JNP87FiMbPXjq0lNr1gOhxxS59DJML59val/csY
 1ZgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

