Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4DEC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 20:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4FA487687;
	Sun, 31 Dec 2023 21:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=peacevolution.org header.i=@peacevolution.org header.b="gnFUkSO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2473875A0; Sun, 31 Dec 2023 21:40:14 +0100 (CET)
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7FC87849
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 21:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=peacevolution.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aren@peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
 by a.peacevolution.org (Postfix) with ESMTPA id 0DCB84638E;
 Sun, 31 Dec 2023 20:40:09 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: u-boot@lists.denx.de
Cc: Sam Edwards <cfsworks@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aren Moynihan <aren@peacevolution.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH] usb: musb-new: sunxi: support usage with DM_USB_GADGET
Date: Sun, 31 Dec 2023 15:38:37 -0500
Message-ID: <20231231203930.1955090-1-aren@peacevolution.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org
 smtp.mailfrom=aren@peacevolution.org
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
 s=dkim; t=1704055210;
 h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
 bh=2ETjeEl/MTpYd4mCMsC7wM0xiD3VCTNCYkTp8U4ISvs=;
 b=gnFUkSO2swyuADMHI33X2MwwrcOGZp2TTY78euvYV2IaNlx03Z2NYNiZsnFjJXUKrNb+tE
 rWWEGEy1fsCrGT/50WcnLNqsNNOB1asiqwqrx9BtL6K9kdmL97+ubdNXPPWZ0G47702bU0
 hfYRFDQLYtfsETczHQGsiX9Psf1fAxE=
X-Mailman-Approved-At: Sun, 31 Dec 2023 21:40:26 +0100
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

Add support for building the sunxi-musb driver with DM_USB_GADGET
including adding a separate IRQ handling function and registering the
driver with the musb system differently.

The implementation of usb_gadget_register_driver from
musb-new/musb_uboot.c only works when the gadget driver for the device
has already been probed and has called musb_register. On the pinephone
(using a allwinner a64 processor) this causes issues when trying to use
usb gadget mode (such as from the ums command) and CONFIG_USB_ETHER is
disabled.

The implementation of usb_gadget_register_driver provided when
DM_USB_GADGET is enabled will probe the necessary drivers when it's
called.

Without the patch, this is what the error condition looks like:
=> ums 0 mmc 1
UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3a3e000
Controller uninitialized
g_dnl_register: failed!, error: -6
g_dnl_register failed

based on:
commit 2e4865bc6486 ("musb-new: omap2430: fix compiling in DM_USB_GADGET config")

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
I don't fully understand what's going on here. Some gadget mode drivers,
such as usb ether (in usb_ether_init) will initialize the usb gadget
driver, but others (ums, fastboot) don't seem to do this, or don't do it
early enough, so they don't work.

 drivers/usb/musb-new/sunxi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
index 91f082fe05e..9b06f49ce47 100644
--- a/drivers/usb/musb-new/sunxi.c
+++ b/drivers/usb/musb-new/sunxi.c
@@ -429,6 +429,17 @@ static struct musb_hdrc_config musb_config_h3 = {
 	.ram_bits	= SUNXI_MUSB_RAM_BITS,
 };
 
+#ifdef CONFIG_DM_USB_GADGET
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	int n = 0;
+	struct musb_host_data *host = dev_get_priv(dev);
+
+	host->host->isr(0, host->host);
+	return 0;
+}
+#endif
+
 static int musb_usb_probe(struct udevice *dev)
 {
 	struct sunxi_glue *glue = dev_get_priv(dev);
@@ -482,6 +493,15 @@ static int musb_usb_probe(struct udevice *dev)
 	ret = musb_lowlevel_init(host);
 	if (!ret)
 		printf("Allwinner mUSB OTG (Host)\n");
+#elifdef CONFIG_DM_USB_GADGET
+	pdata.mode = MUSB_PERIPHERAL;
+	host->host = musb_init_controller(&pdata, &glue->dev, base);
+	if (!host->host)
+		return -EIO;
+
+	ret = usb_add_gadget_udc(&glue->dev, &host->host->g);
+	if (!ret)
+		printf("Allwinner mUSB OTG (Peripheral)\n");
 #else
 	pdata.mode = MUSB_PERIPHERAL;
 	host->host = musb_register(&pdata, &glue->dev, base);
-- 
2.43.0

