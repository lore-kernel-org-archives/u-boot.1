Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8AAC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E34288168;
	Fri, 14 Jun 2024 02:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="psurOBGY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NqFfBsqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA92788962; Fri, 14 Jun 2024 02:53:47 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1654488988
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W0gkw5jT2z9scY;
 Fri, 14 Jun 2024 02:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URuoNA3UjfN6JZBGuiaptXKazj6T/+kajdbxLmHCeG8=;
 b=psurOBGYG6vTdKV9mTplqyzJgKqzvJyMP1Qdz3yP+joWdBw3jfeSsRxjQmO7COBL4xqsXj
 K58gWnVktmZ99GDETq6+eeVZXKd0lFVJA0o10O0K9wfmrl87o018R/mz///Fo4rWmCg4mg
 E5Ff32ey1WiAl7WQrJ6o66DCr2g07qokicV+9SuNRzkw8vr59I0oE9fM4yrKBugd4XDeQl
 pz8pGZznoLDr+yP5jzRRsyOzj2njBRqhfxPJ8mcyB9hZVsZVwei3VlJZR6vrE5w9+r56Dw
 ycrX+hoChyoUKbHTXT3vvw6QGuZ3s4jwmJLwQ94C6okzyIby9inpOcDpCRmSKQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URuoNA3UjfN6JZBGuiaptXKazj6T/+kajdbxLmHCeG8=;
 b=NqFfBsqhnq8rbastbG5z5lXHn2YwIJmCo8HoA+M3BArHq5iGXtVJ7rTLkieNFUCPIfrg+6
 4vBhlVY5KciU/Ke0f+XGBDiDOzgV4gh+4e//l3TqjwvNVCwAGcqzYIphRgzj+4CNk4HpAp
 roq074wbhiyh5EekvaFU0WPYVwvXSvDHQOSelA+vgrrrM2IgFkiKOa+IEickHTliftOj+r
 x6QSIwQPaCEO+Ze439xkigf57MC/Mt2F6fn0fVzCMzQBkR1b7/eq5sUeo6//Zvt7KNTyug
 OY2X1tnSIshAgEAPyC093xvOYXhRHCyZy7kZIomcx9Kw07IT+ka1fS9iJPTs+A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] usb: gadget: omap2430: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:22 +0200
Message-ID: <20240614005309.34433-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qz56guft5rpjjjkpg17jj194gjjayphj
X-MBO-RS-ID: 36c5cca6728ad7365ca
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
 drivers/usb/musb-new/omap2430.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index c8dd73050b2..96771c28cef 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -46,16 +46,6 @@ static inline void omap2430_low_level_init(struct musb *musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
-#ifdef CONFIG_DM_USB_GADGET
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct musb_host_data *host = dev_get_priv(dev);
-
-	host->host->isr(0, host->host);
-	return 0;
-}
-#endif
-
 static int omap2430_musb_init(struct musb *musb)
 {
 	u32 l;
@@ -273,6 +263,21 @@ static int omap2430_musb_remove(struct udevice *dev)
 	return 0;
 }
 
+#ifndef CONFIG_USB_MUSB_HOST
+static int omap2340_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct musb_host_data *host = dev_get_priv(dev);
+
+	host->host->isr(0, host->host);
+
+	return 0;
+}
+
+static const struct usb_gadget_generic_ops omap2340_gadget_ops = {
+	.handle_interrupts	= omap2340_gadget_handle_interrupts,
+};
+#endif
+
 static const struct udevice_id omap2430_musb_ids[] = {
 	{ .compatible = "ti,omap3-musb" },
 	{ .compatible = "ti,omap4-musb" },
@@ -285,6 +290,7 @@ U_BOOT_DRIVER(omap2430_musb) = {
 	.id		= UCLASS_USB,
 #else
 	.id		= UCLASS_USB_GADGET_GENERIC,
+	.ops		= &omap2340_gadget_ops,
 #endif
 	.of_match = omap2430_musb_ids,
 	.of_to_plat = omap2430_musb_of_to_plat,
-- 
2.43.0

