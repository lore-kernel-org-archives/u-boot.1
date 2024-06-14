Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC352C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E00EB88967;
	Fri, 14 Jun 2024 02:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="A4xcA79g";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OYTCXMY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF94488977; Fri, 14 Jun 2024 02:53:43 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29EC88168
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W0gkr4TvYz9stm;
 Fri, 14 Jun 2024 02:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIlrjZs7WBvdlw7Cizp33FPnFYrkONUuodJnQYQE/8c=;
 b=A4xcA79gQtx2PKddowe9srQJQ8RADpKAUVAG6Qi4XLhP6YD7IjdQHk55ix2dLVhZ0HcRhi
 Ou7dU/McuPCfPI3CeSFe+zDkf7u5eKobShyjeaKcR9jmFrS7bviZ+quyzCj3hoVx7tYlxQ
 o10yD0QCHyVp+2pAaNIio2g5eEbifRLiYxw3E14Em+v7GgDdwCWr/lV11XhcMQz5J5tTPW
 VdUxq2ilR07Gw79t0OtWnHCayT101eVB+VriFDe7mbA5zAZB4it6oNXXHzZsGbl0p9Mjyn
 3AdKVnNLxIi8sKT0F+mDVvqV++4a9C+NQg6bJ2dNvP7UIdxM2s7ekWyEE+nWYw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIlrjZs7WBvdlw7Cizp33FPnFYrkONUuodJnQYQE/8c=;
 b=OYTCXMY+ccc05JLfU4R9tLQusuHn8HkhtcmIylWG/YdhIOGpomQG+wwNEfMpkf4X3inijN
 pZexf7kZewxOTTS14Tuy+rsOPo07EHmYLB58dGVXY5ewAs0CfKxviJmDDeZgxWHFmlNF4r
 HyueviT2o5JCwT1EOg4pjOt/NKGb++eq5IOqyGVqt6rm52r8y09vSZz6XMr4bk1ZzYj/Yf
 oYPzXxnuPmTxeRnhiYBxqpABBB9WJKrQi1YOpkupHrD27NYMpcKWPTf7JgC/awvF0dHxBc
 IljShtKv+wr2faltyG/Yw5qLxTfpzoW0gihSbTBrhwHl20t6j9lc3U8XkjJ73A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] usb: gadget: dwc3: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:19 +0200
Message-ID: <20240614005309.34433-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hxxiejbcsiq79313kpi8qqcombaqbhg7
X-MBO-RS-ID: 43d23ffd8030c6e2692
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
 drivers/usb/dwc3/dwc3-generic.c    | 23 ++++++++++++++---------
 drivers/usb/dwc3/dwc3-layerscape.c | 21 +++++++++++++--------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 8db678eb85d..731ede2fead 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -194,34 +194,39 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 }
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+static int dwc3_generic_peripheral_probe(struct udevice *dev)
 {
 	struct dwc3_generic_priv *priv = dev_get_priv(dev);
-	struct dwc3 *dwc3 = &priv->dwc3;
 
-	dwc3_gadget_uboot_handle_interrupt(dwc3);
-
-	return 0;
+	return dwc3_generic_probe(dev, priv);
 }
 
-static int dwc3_generic_peripheral_probe(struct udevice *dev)
+static int dwc3_generic_peripheral_remove(struct udevice *dev)
 {
 	struct dwc3_generic_priv *priv = dev_get_priv(dev);
 
-	return dwc3_generic_probe(dev, priv);
+	return dwc3_generic_remove(dev, priv);
 }
 
-static int dwc3_generic_peripheral_remove(struct udevice *dev)
+static int dwc3_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct dwc3_generic_priv *priv = dev_get_priv(dev);
+	struct dwc3 *dwc3 = &priv->dwc3;
 
-	return dwc3_generic_remove(dev, priv);
+	dwc3_gadget_uboot_handle_interrupt(dwc3);
+
+	return 0;
 }
 
+static const struct usb_gadget_generic_ops dwc3_gadget_ops = {
+	.handle_interrupts	= dwc3_gadget_handle_interrupts,
+};
+
 U_BOOT_DRIVER(dwc3_generic_peripheral) = {
 	.name	= "dwc3-generic-peripheral",
 	.id	= UCLASS_USB_GADGET_GENERIC,
 	.of_to_plat = dwc3_generic_of_to_plat,
+	.ops	= &dwc3_gadget_ops,
 	.probe = dwc3_generic_peripheral_probe,
 	.remove = dwc3_generic_peripheral_remove,
 	.priv_auto	= sizeof(struct dwc3_generic_priv),
diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index ff83bf71e89..108b44c67eb 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -99,33 +99,38 @@ static int dwc3_layerscape_of_to_plat(struct udevice *dev)
 }
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+static int dwc3_layerscape_peripheral_probe(struct udevice *dev)
 {
 	struct dwc3_layerscape_priv *priv = dev_get_priv(dev);
 
-	dwc3_gadget_uboot_handle_interrupt(&priv->dwc3);
-
-	return 0;
+	return dwc3_layerscape_probe(dev, priv);
 }
 
-static int dwc3_layerscape_peripheral_probe(struct udevice *dev)
+static int dwc3_layerscape_peripheral_remove(struct udevice *dev)
 {
 	struct dwc3_layerscape_priv *priv = dev_get_priv(dev);
 
-	return dwc3_layerscape_probe(dev, priv);
+	return dwc3_layerscape_remove(dev, priv);
 }
 
-static int dwc3_layerscape_peripheral_remove(struct udevice *dev)
+static int dwc3_layerscape_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct dwc3_layerscape_priv *priv = dev_get_priv(dev);
 
-	return dwc3_layerscape_remove(dev, priv);
+	dwc3_gadget_uboot_handle_interrupt(&priv->dwc3);
+
+	return 0;
 }
 
+static const struct usb_gadget_generic_ops dwc3_layerscape_gadget_ops = {
+	.handle_interrupts	= dwc3_layerscape_gadget_handle_interrupts,
+};
+
 U_BOOT_DRIVER(dwc3_layerscape_peripheral) = {
 	.name	= "dwc3-layerscape-peripheral",
 	.id	= UCLASS_USB_GADGET_GENERIC,
 	.of_to_plat = dwc3_layerscape_of_to_plat,
+	.ops	= &dwc3_layerscape_gadget_ops,
 	.probe = dwc3_layerscape_peripheral_probe,
 	.remove = dwc3_layerscape_peripheral_remove,
 	.priv_auto	= sizeof(struct dwc3_layerscape_priv),
-- 
2.43.0

