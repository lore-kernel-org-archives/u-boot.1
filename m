Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FF7C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE5E88961;
	Fri, 14 Jun 2024 02:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g3C42h3F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nOlcC4WH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B328188967; Fri, 14 Jun 2024 02:53:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B1188982
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W0gkv33Bwz9sRt;
 Fri, 14 Jun 2024 02:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5MdjXllItYAEo6OByzz2Z3CNmKJ72FEUbp2WZnM/9Q=;
 b=g3C42h3FvIhng1nu1b6cFFIii9lUnslE9oSdZuNE/WiGNBsBkaLmYXDU9WD7o9rLq3mqXe
 mpFQhm2QPe5ZDf2bfc55Q/hU9jm+NTKy00ZR+wtfMM/f3hKYs84teUMwDWFxdWZ3egLqCU
 MDzcZjCdc90XDGP9zo9ouztH8DRFjW3jkGFasU83FxsrB3yUzrAIjSR3fbwaNs3nDIP+nF
 hVmtyQ1LaGOtBmmfL+NNF6Pc0VfE6up18f3omI2Vp2s2YsVTFBSNbdV68n/vmOxTbOCd3C
 RJL86UEkRAVSGZwgWryIKColnVj/2ADGSZ0YOFsAUnKwiQ9ruYbqhnAn01kBiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5MdjXllItYAEo6OByzz2Z3CNmKJ72FEUbp2WZnM/9Q=;
 b=nOlcC4WH5TPgzVlkB7SyISaPc3XRkYOSscpvSloEVjTs8zWQRuhu3nrIzo4aiXbeqqJ1uC
 8HeLZVe3KVfC2rZ5ocfnhYTAPItsMBkKOogplvZPXe+SFaHrdsqnV7fRCjAnI9FIslb7pH
 BENU3DlwwiIoXkAgfLCPy/98tdJAFebBkuRHb5kvsJhavtf67XJ6uD4bVULy4qOeg40sAC
 drPj3xuk0Bgt8Eo9CjX8utEAz6qAsj7U1Ob1Cc9GGGz56WsjWJmJjXSk76dX5ytQT6+A5r
 2c1wHsgJHAvE5wr16tirXtlVp7k8lc1hi85eWCxJoMq4g2HE24LPWd4+hU1RNQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] usb: gadget: mtu3: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:21 +0200
Message-ID: <20240614005309.34433-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fjjwqawzkwr33o5u6gw4xkm4j7kakj1x
X-MBO-RS-ID: 6213b8e2d74ccab6052
X-Rspamd-Queue-Id: 4W0gkv33Bwz9sRt
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
 drivers/usb/mtu3/mtu3_plat.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index ca86b58dfcd..f8e14eabfb2 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -223,15 +223,6 @@ static const struct udevice_id ssusb_of_match[] = {
 };
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct mtu3 *mtu = dev_get_priv(dev);
-
-	mtu3_irq(0, mtu);
-
-	return 0;
-}
-
 static int mtu3_gadget_probe(struct udevice *dev)
 {
 	struct ssusb_mtk *ssusb = dev_to_ssusb(dev->parent);
@@ -250,10 +241,24 @@ static int mtu3_gadget_remove(struct udevice *dev)
 	return 0;
 }
 
+static int mtu3_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct mtu3 *mtu = dev_get_priv(dev);
+
+	mtu3_irq(0, mtu);
+
+	return 0;
+}
+
+static const struct usb_gadget_generic_ops mtu3_gadget_ops = {
+	.handle_interrupts	= mtu3_gadget_handle_interrupts,
+};
+
 U_BOOT_DRIVER(mtu3_peripheral) = {
 	.name = "mtu3-peripheral",
 	.id = UCLASS_USB_GADGET_GENERIC,
 	.of_match = ssusb_of_match,
+	.ops = &mtu3_gadget_ops,
 	.probe = mtu3_gadget_probe,
 	.remove = mtu3_gadget_remove,
 	.priv_auto	= sizeof(struct mtu3),
-- 
2.43.0

