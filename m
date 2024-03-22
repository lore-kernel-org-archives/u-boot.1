Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACFDC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 07:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD02D88028;
	Fri, 22 Mar 2024 08:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tDP+D8LX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED4F088183; Fri, 22 Mar 2024 08:47:26 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2F28819A
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2D8E161380;
 Fri, 22 Mar 2024 07:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F486C433A6;
 Fri, 22 Mar 2024 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711093638;
 bh=b1nV4KqjkdbIBzCFDkoPAQsZDZ7Po7AdwOpq+516qzc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tDP+D8LX73JxKvd37z5yFJaU1rNBa75DD8TfjlEPccuuAezZLLjTs4Nf968SxPzC7
 AU1caEK6bkIl+2sufsYDRgVh/WvTdE6k+I71A1309wLg2FbAAcL+FKXTh2I1m1he9E
 mhv+gp7TDNiND7UL1qJW0BrtkBbQSFzoIyBwQMtg42H0afkIMcJVCFULQcHE1AbEbB
 riMA8h58fwBZlYx51M9lnKl5CQVXfPK4NzoFPKFHjMNo1+W7mlzG1DnTX72kwZFJTt
 /g/6WGbGOpEGNTf1nO9GMdV1LihPz4LJyLBhf0+RtsNuVgP0WN8Ik/tliEOt72lSEe
 OYBlsiHemfL1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9631CCD11BF;
 Fri, 22 Mar 2024 07:47:18 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Fri, 22 Mar 2024 08:47:08 +0100
Subject: [PATCH v3 5/6] usb: kbd: support Apple Magic Keyboards (2021)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-asahi-keyboards-v3-5-3106dd4c4e19@jannau.net>
References: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
In-Reply-To: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7097; i=j@jannau.net;
 h=from:subject:message-id;
 bh=P+aywpOW3f5+9ZY1LlcprP3UqLhWTiCGQg2stJjsQPw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtS/5i2h+a/tl/TM6XELWZvKxKeykvfhF/4n0kvmNRzjy
 bR7Fd7RUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCISnxkZjqpnNLdKbzvuOGnZ
 3rxpL68fk2GT1TW0XPrPTMny+fqkSYwMP2ZuPeJcLPBcu/jMZ4Vbq5Y1Xk/aa/K5aNb5H+e3anW
 zcAEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Apple USB keyboards (Magic Keyboard from 2021 (product id 0x029c)) carry
the HID keyboard boot protocol on the second interface descriptor.
Probe via vendor and product IDs since the class/subclass/protocol match
uses the first interface descriptor.
Probe the two first interface descriptors for the HID keyboard boot
protocol.

USB configuration descriptor for reference:

| Bus 003 Device 002: ID 05ac:029c Apple, Inc. Magic Keyboard
| Device Descriptor:
|   bLength                18
|   bDescriptorType         1
|   bcdUSB               2.00
|   bDeviceClass            0 [unknown]
|   bDeviceSubClass         0 [unknown]
|   bDeviceProtocol         0
|   bMaxPacketSize0        64
|   idVendor           0x05ac Apple, Inc.
|   idProduct          0x029c Magic Keyboard
|   bcdDevice            3.90
|   iManufacturer           1 Apple Inc.
|   iProduct                2 Magic Keyboard
|   iSerial                 3 ...
|   bNumConfigurations      1
|   Configuration Descriptor:
|     bLength                 9
|     bDescriptorType         2
|     wTotalLength       0x003b
|     bNumInterfaces          2
|     bConfigurationValue     1
|     iConfiguration          4 Keyboard
|     bmAttributes         0xa0
|       (Bus Powered)
|       Remote Wakeup
|     MaxPower              500mA
|     Interface Descriptor:
|       bLength                 9
|       bDescriptorType         4
|       bInterfaceNumber        0
|       bAlternateSetting       0
|       bNumEndpoints           1
|       bInterfaceClass         3 Human Interface Device
|       bInterfaceSubClass      0 [unknown]
|       bInterfaceProtocol      0
|       iInterface              5 Device Management
|         HID Device Descriptor:
|           bLength                 9
|           bDescriptorType        33
|           bcdHID               1.10
|           bCountryCode            0 Not supported
|           bNumDescriptors         1
|           bDescriptorType        34 Report
|           wDescriptorLength      83
|           Report Descriptors:
|             ** UNAVAILABLE **
|       Endpoint Descriptor:
|         bLength                 7
|         bDescriptorType         5
|         bEndpointAddress     0x81  EP 1 IN
|         bmAttributes            3
|           Transfer Type            Interrupt
|           Synch Type               None
|           Usage Type               Data
|         wMaxPacketSize     0x0010  1x 16 bytes
|         bInterval               8
|     Interface Descriptor:
|       bLength                 9
|       bDescriptorType         4
|       bInterfaceNumber        1
|       bAlternateSetting       0
|       bNumEndpoints           1
|       bInterfaceClass         3 Human Interface Device
|       bInterfaceSubClass      1 Boot Interface Subclass
|       bInterfaceProtocol      1 Keyboard
|       iInterface              6 Keyboard / Boot
|         HID Device Descriptor:
|           bLength                 9
|           bDescriptorType        33
|           bcdHID               1.10
|           bCountryCode           13 International (ISO)
|           bNumDescriptors         1
|           bDescriptorType        34 Report
|           wDescriptorLength     207
|           Report Descriptors:
|             ** UNAVAILABLE **
|       Endpoint Descriptor:
|         bLength                 7
|         bDescriptorType         5
|         bEndpointAddress     0x82  EP 2 IN
|         bmAttributes            3
|           Transfer Type            Interrupt
|           Synch Type               None
|           Usage Type               Data
|         wMaxPacketSize     0x0010  1x 16 bytes
|         bInterval               8

Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 common/usb_kbd.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 4cbc9acb73..b2361bbf18 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -23,6 +23,14 @@
 
 #include <usb.h>
 
+/*
+ * USB vendor and product IDs used for quirks.
+ */
+#define USB_VENDOR_ID_APPLE	0x05ac
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021			0x029c
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021	0x029a
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021		0x029f
+
 /*
  * If overwrite_console returns 1, the stdin, stderr and stdout
  * are switched to the serial port, else the settings in the
@@ -106,6 +114,8 @@ struct usb_kbd_pdata {
 	unsigned long	last_report;
 	struct int_queue *intq;
 
+	uint32_t	ifnum;
+
 	uint32_t	repeat_delay;
 
 	uint32_t	usb_in_pointer;
@@ -150,8 +160,8 @@ static void usb_kbd_put_queue(struct usb_kbd_pdata *data, u8 c)
  */
 static void usb_kbd_setled(struct usb_device *dev)
 {
-	struct usb_interface *iface = &dev->config.if_desc[0];
 	struct usb_kbd_pdata *data = dev->privptr;
+	struct usb_interface *iface = &dev->config.if_desc[data->ifnum];
 	ALLOC_ALIGN_BUFFER(uint32_t, leds, 1, USB_DMA_MINALIGN);
 
 	*leds = data->flags & USB_KBD_LEDMASK;
@@ -365,7 +375,7 @@ static inline void usb_kbd_poll_for_event(struct usb_device *dev)
 #if defined(CONFIG_SYS_USB_EVENT_POLL_VIA_CONTROL_EP)
 	struct usb_interface *iface;
 	struct usb_kbd_pdata *data = dev->privptr;
-	iface = &dev->config.if_desc[0];
+	iface = &dev->config.if_desc[data->ifnum];
 	usb_get_report(dev, iface->desc.bInterfaceNumber,
 		       1, 0, data->new, USB_KBD_BOOT_REPORT_SIZE);
 	if (memcmp(data->old, data->new, USB_KBD_BOOT_REPORT_SIZE)) {
@@ -509,6 +519,8 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
 	data->new = memalign(USB_DMA_MINALIGN,
 		roundup(USB_KBD_BOOT_REPORT_SIZE, USB_DMA_MINALIGN));
 
+	data->ifnum = ifnum;
+
 	/* Insert private data into USB device structure */
 	dev->privptr = data;
 
@@ -561,10 +573,17 @@ static int probe_usb_keyboard(struct usb_device *dev)
 {
 	char *stdinname;
 	struct stdio_dev usb_kbd_dev;
+	unsigned int ifnum;
+	unsigned int max_ifnum = min((unsigned int)USB_MAX_ACTIVE_INTERFACES,
+				     (unsigned int)dev->config.no_of_if);
 	int error;
 
 	/* Try probing the keyboard */
-	if (usb_kbd_probe_dev(dev, 0) != 1)
+	for (ifnum = 0; ifnum < max_ifnum; ifnum++) {
+		if (usb_kbd_probe_dev(dev, ifnum) == 1)
+			break;
+	}
+	if (ifnum >= max_ifnum)
 		return -ENOENT;
 
 	/* Register the keyboard */
@@ -731,6 +750,18 @@ static const struct usb_device_id kbd_id_table[] = {
 		.bInterfaceSubClass = USB_SUB_HID_BOOT,
 		.bInterfaceProtocol = USB_PROT_HID_KEYBOARD,
 	},
+	{
+		USB_DEVICE(USB_VENDOR_ID_APPLE,
+			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+	},
+	{
+		USB_DEVICE(USB_VENDOR_ID_APPLE,
+			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
+	},
+	{
+		USB_DEVICE(USB_VENDOR_ID_APPLE,
+			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021),
+	},
 	{ }		/* Terminating entry */
 };
 

-- 
2.44.0


