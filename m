Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030A7C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1688A88979;
	Fri, 14 Jun 2024 02:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fTumAICh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cx930CKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404D488961; Fri, 14 Jun 2024 02:53:41 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF32882DA
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W0gkl6zVpz9sdD;
 Fri, 14 Jun 2024 02:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpn1KOP487n4hympBF8cE7jr4+DcAIvU7YZs5ns1/UU=;
 b=fTumAIChOxNAmn/u6yajHigwbFok96ghUu0yf/3aAjC3lvRKon86UhRspbwjrjZas0Llh5
 XYktzjbbGBSq7ND90WNlw1+0lpAiGw+mBSa3kbIaaxlFoPtu7vR1aCAc94uGvJzn0fmQga
 R3H7qpLrgDAQ8a4ao2Qa6ymsrt7L1sTVHUITyyyoCopbHcam9LsDe/dLVRuHa2Xd9lVfXO
 e+FU4lgMEQBItoBmQPpxQupODSIMGDKBHnZAorwp6ArPgRY/lOOe8kgVRmesB8MlTX4EbW
 zd9Kvs34zaNJcz+Mpyu2cZEruY2xq2YZbQeoT0V23jjXfCnXwfQKqes8F2+EpA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpn1KOP487n4hympBF8cE7jr4+DcAIvU7YZs5ns1/UU=;
 b=cx930CKNk1+oswRyXMTdGrgjTRPydFS3jEVNZ0ww5v5s9+IsXxJ31+47OgeH74iMwKS89F
 EjxFJfZ95BZCH/CQ+JYCts/+9GRqTG+oTfnPR15PDEpS7W2iTRubeU5e8PDhP/jvbLF6uz
 9aIWs6SUHusR78hGzF13zM5y840xTwDgaNbvpo6a5DBjX5XGMqFA/id993Mh5sBu4D5QZ5
 EPc47QeZx1z/IWMzhkSkcCyVYovpzXRh9y7Qq4Km7bOR5ps9G/DIq12Z0Y1PKAIYDtdwPG
 W0rTUafTAIBPNu1v9Y0PLiM4szDFZ1kw0jPumZRODxS/BmHF+UhsKmrUKnxtmg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
Date: Fri, 14 Jun 2024 02:51:16 +0200
Message-ID: <20240614005309.34433-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bgo3p61h4mph91firpes3pos1t81yd8o
X-MBO-RS-ID: 0d677c963f4301266e1
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

Introduce .ops for USB_GADGET_GENERIC uclass. The first new ops is
.handle_interrupts which must be implemented by DM capable USB gadget
controller drivers and must implement interrupt handling similar to
dm_usb_gadget_handle_interrupts(). This patch currently provides weak
dm_usb_gadget_handle_interrupts() implementation which is overriden by
the drivers, but this will be removed once conversion to handle_interrupts
callback is complete.

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
 drivers/usb/gadget/udc/udc-uclass.c | 24 ++++++++++++++++++++++++
 include/linux/usb/gadget.h          |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index 5dc23a55bb5..2320039fe3b 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -12,6 +12,25 @@
 #include <linux/usb/gadget.h>
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
+static inline const struct usb_gadget_generic_ops *
+usb_gadget_generic_dev_ops(struct udevice *dev)
+{
+	return (const struct usb_gadget_generic_ops *)dev->driver->ops;
+}
+
+__weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	const struct usb_gadget_generic_ops *ops;
+
+	ops = usb_gadget_generic_dev_ops(dev);
+	if (!ops)
+		return -EFAULT;
+	if (!ops->handle_interrupts)
+		return -ENOSYS;
+
+	return ops->handle_interrupts(dev);
+}
+
 int udc_device_get_by_index(int index, struct udevice **udev)
 {
 	struct udevice *dev = NULL;
@@ -54,6 +73,11 @@ int udc_device_put(struct udevice *udev)
 {
 	return board_usb_cleanup(legacy_index, USB_INIT_DEVICE);
 }
+
+__weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	return 0;
+}
 #endif
 
 #if CONFIG_IS_ENABLED(DM)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 36572be89e6..cf2161603d6 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -970,6 +970,14 @@ extern void usb_ep_autoconfig_reset(struct usb_gadget *);
 
 extern int dm_usb_gadget_handle_interrupts(struct udevice *);
 
+/**
+ * struct usb_gadget_generic_ops - The functions that a gadget driver must implement.
+ * @handle_interrupts: Handle UDC interrupts.
+ */
+struct usb_gadget_generic_ops {
+	int (*handle_interrupts)(struct udevice *udevice);
+};
+
 /**
  * udc_device_get_by_index() - Get UDC udevice by index
  * @index: UDC device index
-- 
2.43.0

