Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B311C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2628898F;
	Fri, 14 Jun 2024 02:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MsBTwPla";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vfkrPKmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23978897F; Fri, 14 Jun 2024 02:53:48 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62AD88898D
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W0gky2LrYz9slr;
 Fri, 14 Jun 2024 02:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VykgBsuRn1aZjIisKesotvrOyxqNJ7lXY78FQAY8g4=;
 b=MsBTwPlardymgwuvK1Ljyouigs9FMVC+ZM3z0UZ0Gc9xYK8qrG/hD1OenGPXzqyFJmg6of
 vmOVe3DAk6s5EL07lRWbZUrCsqqhrcrgWz7s0vWo1qdKc+PMtEWGL52QNLwc1IdYWK+541
 VejO0ziZ68OtoFnMHZeLNPvrlHYZTEuYfZXo2anOCEVnf7DfD/sqRAyHcJ8cjVuPhCrKTq
 uhqiuSFDk/ojIDHtgMA8aK2jpaOU5pC74QzVZKWOSM0AIy6FBLLh0FqSGA6YM0pDFzgIbS
 D6gbJy9K2gGRbr2Dun44u6sb2cSd8hEBvPOF/WGPjhF9knBDQKTW6EtRj1EJhQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VykgBsuRn1aZjIisKesotvrOyxqNJ7lXY78FQAY8g4=;
 b=vfkrPKmOO1mcMAbgYeAU9Zdwdvsc1b7lHVbp610pW02JOoyo64OZorVshak7H+kXnibpjq
 P5w/80U/n0pq4n2lUIoPlQzCfkmc+n7trz0lhocEAFev60k7O+BIADPcSAgYI3+m+oSOEB
 EsJedtMKYNGLvOSzqZI5wHF1P/N+dSfFbr1OdLq3OsjwbOTzVdUlcMQK02DL3rKOIOz3Oa
 8ypFiVQGXO5dy5hwXivIsx+/+39X6bC3zS0htJY2GqmfGZaovFpTRe7hpoBJmfueWR3ObI
 JYbbLW00iVBnWHi4tElYSvkqPPUes3vv51p2XXKn8JjGAtDXVV0qX8kYOiP68A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] usb: gadget: musb: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:23 +0200
Message-ID: <20240614005309.34433-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ak8o55b1qr443hqds537dcne9zp4oa5t
X-MBO-RS-ID: 941f4643c849dc3cb1e
X-Rspamd-Queue-Id: 4W0gky2LrYz9slr
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

Implement .handle_interrupts callback as a replacement for deprecated
dm_usb_gadget_handle_interrupts() function. The new callback allows
for each DM capable USB gadget controller driver to define its own
IRQ handling implementation without colliding with other controller
drivers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/musb-new/ti-musb.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 76e8b88369e..ec1baa9337d 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -233,15 +233,6 @@ static int ti_musb_peripheral_of_to_plat(struct udevice *dev)
 }
 #endif
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct ti_musb_peripheral *priv = dev_get_priv(dev);
-
-	priv->periph->isr(0, priv->periph);
-
-	return 0;
-}
-
 static int ti_musb_peripheral_probe(struct udevice *dev)
 {
 	struct ti_musb_peripheral *priv = dev_get_priv(dev);
@@ -269,12 +260,26 @@ static int ti_musb_peripheral_remove(struct udevice *dev)
 	return 0;
 }
 
+static int ti_musb_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct ti_musb_peripheral *priv = dev_get_priv(dev);
+
+	priv->periph->isr(0, priv->periph);
+
+	return 0;
+}
+
+static const struct usb_gadget_generic_ops ti_musb_gadget_ops = {
+	.handle_interrupts	= ti_musb_gadget_handle_interrupts,
+};
+
 U_BOOT_DRIVER(ti_musb_peripheral) = {
 	.name	= "ti-musb-peripheral",
 	.id	= UCLASS_USB_GADGET_GENERIC,
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 	.of_to_plat = ti_musb_peripheral_of_to_plat,
 #endif
+	.ops	= &ti_musb_gadget_ops,
 	.probe = ti_musb_peripheral_probe,
 	.remove = ti_musb_peripheral_remove,
 	.ops	= &musb_usb_ops,
-- 
2.43.0

