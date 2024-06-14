Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DBEC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C63188982;
	Fri, 14 Jun 2024 02:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fnAXuCX8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fnAXuCX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0107E88958; Fri, 14 Jun 2024 02:53:44 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16722831A1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W0gkr27pTz9sr8;
 Fri, 14 Jun 2024 02:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fe5FZMVw0FOFhqIhIQdSxyxwjOAzBJEqO9AQRt88NMY=;
 b=fnAXuCX8NmLh8nqL96Jj4njuu5TP/hbnSOUMVx7tBaxZMWMwR62iAKm9JQ0Ry8vzc86bSZ
 ah09en7ks/pJZCqDr+x0mKiBG97J6F19qbZVbi6FfhW0cVnnup9/hkdFVBmGRKxS5c2FCk
 V5Tag0Mddz995Px4yBtL/31fbgjS5GNGJ/zfDYVeI1/ixeWazGHvPQn9DYuZPEobTFsSkY
 BYoLQLgEUBoBJSKoGS9nh6HQEIyAkubD6sxz/BRQFBUO4nlTQyAZGYiHa8isarcXP7pft0
 ndC/uqDDPfRmCQipqzQFBdwH/T29ZMa0c82W4+sBrz4HkHv0TkgqcqI1FCSIZA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fe5FZMVw0FOFhqIhIQdSxyxwjOAzBJEqO9AQRt88NMY=;
 b=fnAXuCX8NmLh8nqL96Jj4njuu5TP/hbnSOUMVx7tBaxZMWMwR62iAKm9JQ0Ry8vzc86bSZ
 ah09en7ks/pJZCqDr+x0mKiBG97J6F19qbZVbi6FfhW0cVnnup9/hkdFVBmGRKxS5c2FCk
 V5Tag0Mddz995Px4yBtL/31fbgjS5GNGJ/zfDYVeI1/ixeWazGHvPQn9DYuZPEobTFsSkY
 BYoLQLgEUBoBJSKoGS9nh6HQEIyAkubD6sxz/BRQFBUO4nlTQyAZGYiHa8isarcXP7pft0
 ndC/uqDDPfRmCQipqzQFBdwH/T29ZMa0c82W4+sBrz4HkHv0TkgqcqI1FCSIZA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/11] usb: gadget: max3420: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:20 +0200
Message-ID: <20240614005309.34433-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kwqa7ij4y36jg6oybrwccgfcq64dabae
X-MBO-RS-ID: 57e9b2ae945bee7c531
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
 drivers/usb/gadget/max3420_udc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/max3420_udc.c b/drivers/usb/gadget/max3420_udc.c
index 5a227c0ffd9..557a1f0644e 100644
--- a/drivers/usb/gadget/max3420_udc.c
+++ b/drivers/usb/gadget/max3420_udc.c
@@ -808,13 +808,6 @@ static void max3420_setup_spi(struct max3420_udc *udc)
 	spi_wr8(udc, MAX3420_REG_PINCTL, bFDUPSPI);
 }
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct max3420_udc *udc = dev_get_priv(dev);
-
-	return max3420_irq(udc);
-}
-
 static int max3420_udc_probe(struct udevice *dev)
 {
 	struct max3420_udc *udc = dev_get_priv(dev);
@@ -859,6 +852,17 @@ static int max3420_udc_remove(struct udevice *dev)
 	return 0;
 }
 
+static int max3420_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct max3420_udc *udc = dev_get_priv(dev);
+
+	return max3420_irq(udc);
+}
+
+static const struct usb_gadget_generic_ops max3420_gadget_ops = {
+	.handle_interrupts	= max3420_gadget_handle_interrupts,
+};
+
 static const struct udevice_id max3420_ids[] = {
 	{ .compatible = "maxim,max3421-udc" },
 	{ }
@@ -868,6 +872,7 @@ U_BOOT_DRIVER(max3420_generic_udc) = {
 	.name = "max3420-udc",
 	.id = UCLASS_USB_GADGET_GENERIC,
 	.of_match = max3420_ids,
+	.ops = &max3420_gadget_ops,
 	.probe = max3420_udc_probe,
 	.remove = max3420_udc_remove,
 	.priv_auto	= sizeof(struct max3420_udc),
-- 
2.43.0

