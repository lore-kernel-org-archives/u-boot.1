Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1B6D2D8F9
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F4784067;
	Tue, 27 Jan 2026 12:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pI9NQ11p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A3684013; Tue, 27 Jan 2026 12:04:29 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE13183FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso24816135e9.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511867; x=1770116667;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PkCudbSndzFWb9vL2CyA/kmW53Mu5MtWTtUx+WKzsnc=;
 b=pI9NQ11pET/IZhSYNljVpCOyN5Z00DnAo37V9uvxUHgpeNs9nBFjF57hk+rQ43qDJ1
 VuUtKlNk0Iiq9C7S2WthwnQR17BexOn7FSfTuy0LYk8JVan1cA2dGvtElWPcXr5iJkx5
 bT81FcrUJJi3tinJcmEqg/h94GZxZrSEQF6d2UCZU64cflB3QEExEIVfrLyGbVwVwN9y
 xP82QUs5lOay97A3Cagw+fONg2V9K7pHoXNdlkcm3TB1cpJNfJAEXzgINlfYzEwcC1k/
 ogJZg3iOZrywU+t15szC31cDPzyPGBRLueDpGD6DEuEYcpqDtpZkgBPNonWMi46LtNm0
 wiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511867; x=1770116667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PkCudbSndzFWb9vL2CyA/kmW53Mu5MtWTtUx+WKzsnc=;
 b=Gg0tGejq2w17MoEcKXXfLd3B+cfkjMNzhoiWK+SnM/+MdMFePD1HVNlkgpK2wkU3Ge
 S/n1aVtGGi+qPui5V/2yB4MMekm/zg0cj461vDO5B1X4FzKRk4NjMyiCO9O15KC9clyj
 tjhGe+PdSK1lIB4CxlR8AgIXHg2x3QOOgTS74FgaAwWqnoPpN04fSQzevh1fdc4gaduX
 plzqWPRkjgYABRff636UxDEi0J62JhfqeCqa+hNDvUJymXGeaja1tq5GD2X+mG3r1LzE
 VGA4AHgLUCl2+Lu22d1AwNZxAnIVWp7rsUWS/xtgPinZcJkDDXkiUXJRpOv+REOK68vg
 s7wg==
X-Gm-Message-State: AOJu0YyR0HklymSwF42PuZINoRjvLlMxsDBkexHIOzDde6LccCbrlgKR
 xO4xcExI2iNeKrdfe/zXVQ6iE1Tq1bHtg7xWf0xIPfQqdEA934XE9aJepFLFS1Sx7m0=
X-Gm-Gg: AZuq6aIoII/zVfgk14nIbQeEmnK4QbfP8iUElZvfhBYuA0O3v4hfZ0NibQYzdl4qLwO
 +2E8MqYBzGHYmUHdk/l3NIsbdtWHqgCjMHgJwQp5xoBHBhtUXGGAmeazs9rli9DUc29XqAh34LF
 GugYBw+1xxTTzxNHVXu8/44V55XO2UV6uwXKpA8ZtcKBfMpP319fOg1Ba0xEM4yXyfLYDLjjByF
 nYWBCj92jNipqGR4Z1qBq+XvVhjqxYmUOT8gYf8wkUinyHMQoNcXqdErG2z6kOgXhbgxx8Ld483
 awFpVm1oiuNRlkx2W2TOs7PHcWckJSuJrPTxwZnadRhv6DYn9TF1tG0K16Ku2IcOWbw5b36e+qX
 x+7euOoHf72NWKBSNudy1VfB07AqTps46HT8Z1bKPQZETjW5cAKlGnQsHCVtwPUniekhpuyxmNp
 /Vd54X1HO2AuI0TkjY81w=
X-Received: by 2002:a05:600c:1e0d:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-48069c8bd00mr15979905e9.20.1769511867263; 
 Tue, 27 Jan 2026 03:04:27 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d3ae17esm132380505e9.0.2026.01.27.03.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:26 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 12:03:41 +0100
Subject: [PATCH v4 7/7] usb: musb-new: Add compatibles for ti,musb-am33xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-7-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3068; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5PgNxHpsakvb0pcJ1Ey8+1aoygTOIV0HPfZiPqCtTC4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2Wt2RjjHXH20q6LnfMIujbg5woaXz57lP3WF/dWJb
 yc3q/9f2lHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATKZFlZFhfVmysJS7Nw/E1
 ssgtOOW24xLOm8ZyfAazYq6dmLvhay4jw9N9Em7LpO+9mdLtycBuyftWT0vzx/eEqWtVi+SnuEV
 +5QUA
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

