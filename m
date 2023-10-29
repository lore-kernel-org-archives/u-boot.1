Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B71C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE8F8746C;
	Sun, 29 Oct 2023 08:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="fM3plRC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719018708B; Sun, 29 Oct 2023 08:36:34 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6878708B
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 95CE54265F;
 Sun, 29 Oct 2023 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698564991; bh=He2Hk/C20rLk7tHhtTLvVpiI1nwT5EgHHSHgcO7ZYts=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fM3plRC0kFqwR0juj78eX9Th2ukzd8t4LxjvJk5stN55QPQ+wCZ1MfcUXJ89wFw+x
 yNkXR6NsqHanCaRqJ4c/4jYOTzujVcG6nG4qWoVzqcq7DP4lols03g4ObcoiVIwPBy
 UWLjakuPwLOlffkGn3MlYabkGOBx2CklFFYDBfa94OMFd9oJ4+vI4F7vOu39lmwXsT
 nKS2YSVtMW8ogW3okl0EUoNCYDnTfPObv5GGOf6PAXxlldVT9NkkLR3xgkpGhmExeS
 6OIA6L5bcG3o++/+waWU9X5FhMmcg0A+MsB84YJrPQ+0qqnhLUU2bF7YPPnbsZGUOU
 SFdeaRqHQClQg==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 16:36:16 +0900
Subject: [PATCH 1/2] usb: Pass through timeout to drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-5-v1-1-54bb13001f54@marcan.st>
References: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
In-Reply-To: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10169; i=marcan@marcan.st;
 h=from:subject:message-id; bh=He2Hk/C20rLk7tHhtTLvVpiI1nwT5EgHHSHgcO7ZYts=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlQ77sqoq5u9dlueNfuoZzf16m8BntQfv/zSy7f6lvDc/
 aKtdXhCRykLgxgHg6yYIkvjid5T3Z7Tz6mrpkyHmcPKBDKEgYtTACbSlMHwT/eGS+r0Xen+ym/z
 W3d57Q4yE+x6ebZy0/Z1ARcz+2esUWP4zfLh8Zw2/pfPsw4XWspxftrD2qn3JOHJlle5evmieT9
 CWQA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

The old USB code was interrupt-driven and just polled at the top level.
This has been obsolete since interrupts were removed, which means the
timeout support has been completely broken.

Rip out the top-level polling and just pass through the timeout
parameter to host controller drivers. Right now this is ignored in the
individual drivers.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 common/usb.c                    | 21 ++-------------------
 drivers/usb/host/ehci-hcd.c     |  5 +++--
 drivers/usb/host/ohci-hcd.c     |  5 +++--
 drivers/usb/host/r8a66597-hcd.c |  5 +++--
 drivers/usb/host/usb-sandbox.c  |  6 ++++--
 drivers/usb/host/usb-uclass.c   |  9 +++++----
 drivers/usb/host/xhci.c         |  5 +++--
 include/usb.h                   | 10 ++++++----
 8 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 836506dcd9e9..8d13c5899027 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -241,22 +241,10 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
 	      request, requesttype, value, index, size);
 	dev->status = USB_ST_NOT_PROC; /*not yet processed */
 
-	err = submit_control_msg(dev, pipe, data, size, setup_packet);
+	err = submit_control_msg(dev, pipe, data, size, setup_packet, timeout);
 	if (err < 0)
 		return err;
-	if (timeout == 0)
-		return (int)size;
 
-	/*
-	 * Wait for status to update until timeout expires, USB driver
-	 * interrupt handler may set the status when the USB operation has
-	 * been completed.
-	 */
-	while (timeout--) {
-		if (!((volatile unsigned long)dev->status & USB_ST_NOT_PROC))
-			break;
-		mdelay(1);
-	}
 	if (dev->status)
 		return -1;
 
@@ -275,13 +263,8 @@ int usb_bulk_msg(struct usb_device *dev, unsigned int pipe,
 	if (len < 0)
 		return -EINVAL;
 	dev->status = USB_ST_NOT_PROC; /*not yet processed */
-	if (submit_bulk_msg(dev, pipe, data, len) < 0)
+	if (submit_bulk_msg(dev, pipe, data, len, timeout) < 0)
 		return -EIO;
-	while (timeout--) {
-		if (!((volatile unsigned long)dev->status & USB_ST_NOT_PROC))
-			break;
-		mdelay(1);
-	}
 	*actual_length = dev->act_len;
 	if (dev->status == 0)
 		return 0;
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 9839aa17492d..ad0a1b9d24b1 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1627,7 +1627,7 @@ int usb_lock_async(struct usb_device *dev, int lock)
 #if CONFIG_IS_ENABLED(DM_USB)
 static int ehci_submit_control_msg(struct udevice *dev, struct usb_device *udev,
 				   unsigned long pipe, void *buffer, int length,
-				   struct devrequest *setup)
+				   struct devrequest *setup, int timeout)
 {
 	debug("%s: dev='%s', udev=%p, udev->dev='%s', portnr=%d\n", __func__,
 	      dev->name, udev, udev->dev->name, udev->portnr);
@@ -1636,7 +1636,8 @@ static int ehci_submit_control_msg(struct udevice *dev, struct usb_device *udev,
 }
 
 static int ehci_submit_bulk_msg(struct udevice *dev, struct usb_device *udev,
-				unsigned long pipe, void *buffer, int length)
+				unsigned long pipe, void *buffer, int length,
+				int timeout)
 {
 	debug("%s: dev='%s', udev=%p\n", __func__, dev->name, udev);
 	return _ehci_submit_bulk_msg(udev, pipe, buffer, length);
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 3f4418198ccd..8dc1f6660077 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -2047,7 +2047,7 @@ int submit_control_msg(struct usb_device *dev, unsigned long pipe,
 #if CONFIG_IS_ENABLED(DM_USB)
 static int ohci_submit_control_msg(struct udevice *dev, struct usb_device *udev,
 				   unsigned long pipe, void *buffer, int length,
-				   struct devrequest *setup)
+				   struct devrequest *setup, int timeout)
 {
 	ohci_t *ohci = dev_get_priv(usb_get_bus(dev));
 
@@ -2056,7 +2056,8 @@ static int ohci_submit_control_msg(struct udevice *dev, struct usb_device *udev,
 }
 
 static int ohci_submit_bulk_msg(struct udevice *dev, struct usb_device *udev,
-				unsigned long pipe, void *buffer, int length)
+				unsigned long pipe, void *buffer, int length,
+				int timeout)
 {
 	ohci_t *ohci = dev_get_priv(usb_get_bus(dev));
 
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 3ccbc16da379..0ac853dc558b 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -705,7 +705,8 @@ static int r8a66597_submit_rh_msg(struct udevice *udev, struct usb_device *dev,
 static int r8a66597_submit_control_msg(struct udevice *udev,
 				       struct usb_device *dev,
 				       unsigned long pipe, void *buffer,
-				       int length, struct devrequest *setup)
+				       int length, struct devrequest *setup,
+				       int timeout)
 {
 	struct r8a66597 *r8a66597 = dev_get_priv(udev);
 	u16 r8a66597_address = setup->request == USB_REQ_SET_ADDRESS ?
@@ -743,7 +744,7 @@ static int r8a66597_submit_control_msg(struct udevice *udev,
 
 static int r8a66597_submit_bulk_msg(struct udevice *udev,
 				    struct usb_device *dev, unsigned long pipe,
-				    void *buffer, int length)
+				    void *buffer, int length, int timeout)
 {
 	struct r8a66597 *r8a66597 = dev_get_priv(udev);
 	int ret = 0;
diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
index 3d4f8d653b5d..8e5fdc44d642 100644
--- a/drivers/usb/host/usb-sandbox.c
+++ b/drivers/usb/host/usb-sandbox.c
@@ -47,7 +47,8 @@ static int sandbox_submit_control(struct udevice *bus,
 				      struct usb_device *udev,
 				      unsigned long pipe,
 				      void *buffer, int length,
-				      struct devrequest *setup)
+				      struct devrequest *setup,
+				      int timeout)
 {
 	struct sandbox_usb_ctrl *ctrl = dev_get_priv(bus);
 	struct udevice *emul;
@@ -81,7 +82,8 @@ static int sandbox_submit_control(struct udevice *bus,
 }
 
 static int sandbox_submit_bulk(struct udevice *bus, struct usb_device *udev,
-			       unsigned long pipe, void *buffer, int length)
+			       unsigned long pipe, void *buffer, int length,
+			       int timeout)
 {
 	struct udevice *emul;
 	int ret;
diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d669..97e0ecad9408 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -58,7 +58,8 @@ int submit_int_msg(struct usb_device *udev, unsigned long pipe, void *buffer,
 }
 
 int submit_control_msg(struct usb_device *udev, unsigned long pipe,
-		       void *buffer, int length, struct devrequest *setup)
+		       void *buffer, int length, struct devrequest *setup,
+		       int timeout)
 {
 	struct udevice *bus = udev->controller_dev;
 	struct dm_usb_ops *ops = usb_get_ops(bus);
@@ -68,7 +69,7 @@ int submit_control_msg(struct usb_device *udev, unsigned long pipe,
 	if (!ops->control)
 		return -ENOSYS;
 
-	err = ops->control(bus, udev, pipe, buffer, length, setup);
+	err = ops->control(bus, udev, pipe, buffer, length, setup, timeout);
 	if (setup->request == USB_REQ_SET_FEATURE &&
 	    setup->requesttype == USB_RT_PORT &&
 	    setup->value == cpu_to_le16(USB_PORT_FEAT_RESET) &&
@@ -81,7 +82,7 @@ int submit_control_msg(struct usb_device *udev, unsigned long pipe,
 }
 
 int submit_bulk_msg(struct usb_device *udev, unsigned long pipe, void *buffer,
-		    int length)
+		    int length, int timeout)
 {
 	struct udevice *bus = udev->controller_dev;
 	struct dm_usb_ops *ops = usb_get_ops(bus);
@@ -89,7 +90,7 @@ int submit_bulk_msg(struct usb_device *udev, unsigned long pipe, void *buffer,
 	if (!ops->bulk)
 		return -ENOSYS;
 
-	return ops->bulk(bus, udev, pipe, buffer, length);
+	return ops->bulk(bus, udev, pipe, buffer, length, timeout);
 }
 
 struct int_queue *create_int_queue(struct usb_device *udev,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d13cbff9b372..a33a2460f74d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1262,7 +1262,7 @@ static int xhci_lowlevel_stop(struct xhci_ctrl *ctrl)
 
 static int xhci_submit_control_msg(struct udevice *dev, struct usb_device *udev,
 				   unsigned long pipe, void *buffer, int length,
-				   struct devrequest *setup)
+				   struct devrequest *setup, int timeout)
 {
 	struct usb_device *uhop;
 	struct udevice *hub;
@@ -1294,7 +1294,8 @@ static int xhci_submit_control_msg(struct udevice *dev, struct usb_device *udev,
 }
 
 static int xhci_submit_bulk_msg(struct udevice *dev, struct usb_device *udev,
-				unsigned long pipe, void *buffer, int length)
+				unsigned long pipe, void *buffer, int length,
+				int timeout)
 {
 	debug("%s: dev='%s', udev=%p\n", __func__, dev->name, udev);
 	return _xhci_submit_bulk_msg(udev, pipe, buffer, length);
diff --git a/include/usb.h b/include/usb.h
index 09e3f0cb309c..431801d18a84 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -184,9 +184,10 @@ int usb_reset_root_port(struct usb_device *dev);
 #endif
 
 int submit_bulk_msg(struct usb_device *dev, unsigned long pipe,
-			void *buffer, int transfer_len);
+			void *buffer, int transfer_len, int timeout);
 int submit_control_msg(struct usb_device *dev, unsigned long pipe, void *buffer,
-			int transfer_len, struct devrequest *setup);
+			int transfer_len, struct devrequest *setup,
+			int timeout);
 int submit_int_msg(struct usb_device *dev, unsigned long pipe, void *buffer,
 			int transfer_len, int interval, bool nonblock);
 
@@ -709,14 +710,15 @@ struct dm_usb_ops {
 	 */
 	int (*control)(struct udevice *bus, struct usb_device *udev,
 		       unsigned long pipe, void *buffer, int length,
-		       struct devrequest *setup);
+		       struct devrequest *setup, int timeout);
 	/**
 	 * bulk() - Send a bulk message
 	 *
 	 * Parameters are as above.
 	 */
 	int (*bulk)(struct udevice *bus, struct usb_device *udev,
-		    unsigned long pipe, void *buffer, int length);
+		    unsigned long pipe, void *buffer, int length,
+		    int timeout);
 	/**
 	 * interrupt() - Send an interrupt message
 	 *

-- 
2.41.0

