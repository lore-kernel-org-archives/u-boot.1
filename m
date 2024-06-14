Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7692BC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746558897D;
	Fri, 14 Jun 2024 02:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p9hB0Zhc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JN2QerXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2671C88961; Fri, 14 Jun 2024 02:53:42 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC6E8895B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W0gkp6hJXz9sm9;
 Fri, 14 Jun 2024 02:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRecHNAQrJQCaerDU9mkooWWg7GUpfDkK3KDJDzySDc=;
 b=p9hB0Zhc6GF9BzKBTSC++1M5mG40NlzeGQw2qkEudXLxt44jfXHhZgaStaA8IToFxrsxe6
 qJWWrLqIst/yOiH+jT0XrGmrgZKq5+N7pmidx5hEfBT/UMt6No0svc9/MbK3iOFu9dtgEp
 KrSMkWVsM5zbyRr1lu9dAxFk+YXOeJcPdmKiyXMybdThvxccdYQS02d/cznRZ+Zz5jCsbE
 LLAa7jpRnfRjYiXPK9c/VL4BYmgfW90HO7LnmVR5CA4ewQj0cqzP5RaD7kdSWmovBcyj9l
 oOu/FOwBq8/NCmFbFobp5so1vnBKxxWmaG7EnKPxCu9VCJaxBvZLObXaE4pF3g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRecHNAQrJQCaerDU9mkooWWg7GUpfDkK3KDJDzySDc=;
 b=JN2QerXJip3CrSHf25xtoCaPLhKxcO5PZLAgx+b8KRqxHBgBrMFK+PDeXCgoBIa8Oz59Gy
 VZtUqShc116zNtAc90rVoHeKnHJ4ij5HgmViirXBMUUB2ZKdU+iJk8Er6w+Uy0cVCzFMGY
 IwX13nhkfnFaTG0z5d6j1+XeRICpKQTRXgCi5nBfUMmQkPdOrrpD0hG6rs1vQUg5Ybcd4p
 nT1Jj3CQ1xkr3In1XPM/7pCmdd73GdY0ff/JN5FoIHkaRc8vVQ1oze0dkXI/HxirhqVwH1
 USg5XBKg4ROoD9rn0g8jmvk8RfC01D6STyIveplV/KE4iAmYg1OYLlZxVziJFw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] usb: gadget: dwc2: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:18 +0200
Message-ID: <20240614005309.34433-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: h7fkjwzxca9dey6jcqmgget8swb8yxpj
X-MBO-RS-ID: 20a2d0c464ffb013e78
X-Rspamd-Queue-Id: 4W0gkp6hJXz9sm9
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
 drivers/usb/gadget/dwc2_udc_otg.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 6bd395a6235..7e9dd6f4268 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -941,11 +941,6 @@ int dwc2_udc_handle_interrupt(void)
 	return 0;
 }
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	return dwc2_udc_handle_interrupt();
-}
-
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
 struct dwc2_priv_data {
 	struct clk_bulk		clks;
@@ -1173,6 +1168,15 @@ static int dwc2_udc_otg_remove(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
+static int dwc2_gadget_handle_interrupts(struct udevice *dev)
+{
+	return dwc2_udc_handle_interrupt();
+}
+
+static const struct usb_gadget_generic_ops dwc2_gadget_ops = {
+	.handle_interrupts	= dwc2_gadget_handle_interrupts,
+};
+
 static const struct udevice_id dwc2_udc_otg_ids[] = {
 	{ .compatible = "snps,dwc2" },
 	{ .compatible = "brcm,bcm2835-usb" },
@@ -1185,6 +1189,7 @@ U_BOOT_DRIVER(dwc2_udc_otg) = {
 	.name	= "dwc2-udc-otg",
 	.id	= UCLASS_USB_GADGET_GENERIC,
 	.of_match = dwc2_udc_otg_ids,
+	.ops	= &dwc2_gadget_ops,
 	.of_to_plat = dwc2_udc_otg_of_to_plat,
 	.probe = dwc2_udc_otg_probe,
 	.remove = dwc2_udc_otg_remove,
@@ -1200,4 +1205,9 @@ int dwc2_udc_B_session_valid(struct udevice *dev)
 
 	return readl(&usbotg_reg->gotgctl) & B_SESSION_VALID;
 }
+#else
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	return dwc2_udc_handle_interrupt();
+}
 #endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
-- 
2.43.0

