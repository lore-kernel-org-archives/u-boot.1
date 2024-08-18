Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D393C5320E
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 20:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01FE68896C;
	Sun, 18 Aug 2024 22:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W3H84qSV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tjd1osC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3F488975; Sun, 18 Aug 2024 22:04:44 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE7A88440
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 22:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wn6By5c0Vz9slP;
 Sun, 18 Aug 2024 22:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724011482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+KhjtzwFDEhfIW7jWwwuvMSI8b5ySff6uO5FoXVZqFQ=;
 b=W3H84qSV6BL39IJHPiGBr/FgjmruaPXgDSKk1leVFpp6pCwfbfRFSJC2kCo2js1mIdfHQh
 Y3WjodxrNtmV6QWKxECs9UHoir7dB5Tf9Fx4y/oq8gln74FDYjakY1Kbm+01bcCjFtsRMR
 /dShWYClBjbSVQiagpVymUPuI0sN+4KWUQ6dK+4omxrdmZSivx1dCtzc80d8MseiVmlAt0
 yMGzYGVvFyEgcGJR7X0UzCD+/Z19Df+nKneVeWHzmMfxCKq9dzyNISoeXS6+x0EayKj/Lp
 GU98aUfVmR15lw2ovWaTy0Ek0+t1UksjtVYMvF69LAVpamolEpbAUqNLdnmb+w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724011480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+KhjtzwFDEhfIW7jWwwuvMSI8b5ySff6uO5FoXVZqFQ=;
 b=tjd1osC99RKxwumroFrVPvglORuuMmDCdMBURJJgOyD/spVHY/fAwH8kUQBn9we9GtZtdf
 jbLibWtXnSljC4XInK6DK0j035VluZJAU4Vkh+2iK4Fg90Gsia3cANBKXalxAXj8F6cogo
 QGniybHrkNMnXQrH6FNIie6di/CB5PasySFFaENGwByVfKjFQTY7NC/XrZiaxP+PthXcqe
 Kqnwcnpqf93PqHFAPQSGNVDJYepupDrVSBkUuavRlE8J01kzQ0Pd6gVhQUQAew9c+I+fYW
 JA5eYP2V1iwUDg9ZVir+8rT/ErdyrArKKhbXJSnAyOq4oWOZce6+LGaAxNS1Xg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephan Gerhold <stephan@gerhold.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: gadget: ux500: Do not redefine ops if
 CONFIG_USB_MUSB_HOST set
Date: Sun, 18 Aug 2024 22:04:15 +0200
Message-ID: <20240818200425.89045-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y4d5a8dgx3igsoeaheydx5wn5d89wsxx
X-MBO-RS-ID: 1eddb8c714c3202aec8
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

In case CONFIG_USB_MUSB_HOST is set, the ux500_gadget_ops get overridden
to musb_usb_ops . Simply set the ops one way or the other depending on
whether CONFIG_USB_MUSB_HOST is set or not.

Fixes: ac4bf5d48a9e ("usb: gadget: ux500: Convert interrupt handling to usb_gadget_generic_ops")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/musb-new/ux500.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
index 89dd75b7d05..be0085f403d 100644
--- a/drivers/usb/musb-new/ux500.c
+++ b/drivers/usb/musb-new/ux500.c
@@ -169,16 +169,14 @@ U_BOOT_DRIVER(ux500_musb) = {
 	.name		= "ux500-musb",
 #ifdef CONFIG_USB_MUSB_HOST
 	.id		= UCLASS_USB,
+	.ops		= &musb_usb_ops,
 #else
 	.id		= UCLASS_USB_GADGET_GENERIC,
+	.ops		= &ux500_gadget_ops,
 #endif
 	.of_match	= ux500_musb_ids,
-	.ops		= &ux500_gadget_ops,
 	.probe		= ux500_musb_probe,
 	.remove		= ux500_musb_remove,
-#ifdef CONFIG_USB_MUSB_HOST
-	.ops		= &musb_usb_ops,
-#endif
 	.plat_auto	= sizeof(struct usb_plat),
 	.priv_auto	= sizeof(struct ux500_glue),
 };
-- 
2.43.0

