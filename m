Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C74C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB5D8804A;
	Wed, 21 Feb 2024 08:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYNR6xHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2CD88032; Wed, 21 Feb 2024 08:25:40 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CB98801D
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7BD4DCE1C63;
 Wed, 21 Feb 2024 07:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4E8DC433B1;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708500316;
 bh=k2TtkX+pdzAy2Y6EqTPgl2Lc45ZfW3qYeR+/pgHaXpo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=eYNR6xHqykY6JIXz2l1tzJHPzwMjg0R2Fbxp2uqENCascW8uW2OO81KwpFNjF5IXN
 xAgMl68W7sTJPMOaVRVBz+BzTZUF+vQzjzgnYCsObcA0wkSUkauHLTjMjqcvZV79Jk
 o2nJdukkWO5g7DOg6BiWNbihORwdX0mRdZVQOX0AfIQV2jW7gKedGd6KJj8drZEchB
 FAO17YZxSq71cW+kxPBneFNXrw0GTqEoAruaqfP6scNv4p4JeLEymWdpgVo1tvTJEd
 IuixQJX7ifFeoQQVcpdlqFYAdcMKNIdGsLDcfOyPZNq0GSU8Zu/3bKdAvuObjMmJXx
 WqRS/EOndgkAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9437AC48BF6;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 21 Feb 2024 08:25:06 +0100
Subject: [PATCH 6/6] usb: kbd: Add probe quirk for Apple and Keychron keyboards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-asahi-keyboards-v1-6-814b2e741790@jannau.net>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
In-Reply-To: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=j@jannau.net;
 h=from:subject:message-id; bh=3y8349yV2wtUe41ovy+jezKbAFHoTDxLrAQuuV9nDGw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtSrS6OmyH2veiK4vNPh20Fu129K4cwBK/dJ705mOyIf/
 3VxeaB1RykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIlMcWNkeN23YHuGxfecadMk
 r0znjHyfqvIg/+O61rKKGQ/nNLNzWTMynPr5Tnn9Mu0Dhw/typpU8bi05NOKrVd65/anMHJJ+nk
 m8gEA
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

Those keyboards do not return the current device state. Polling will
timeout unless there are key presses. This is not a problem during
operation but the inital device state query during probing will fail.
Skip this step in usb_kbd_probe_dev() to make these devices useable.
Not all Apple keyboards behave like this. A keyboard with USB
vendor/product ID 05ac:0221 is reported to work with the current code.
Unfortunately some Keychron keyboards "re-use" Apple's vendor ID and
show the same behavior (Keychron C2, 05ac:024f for example).

Signed-off-by: Janne Grunau <j@jannau.net>
---
 common/usb_kbd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 7aa803eb4e..b0012ce7ad 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -31,6 +31,10 @@
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021	0x029a
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021		0x029f
 
+#define USB_VENDOR_ID_KEYCHRON	0x3434
+
+#define USB_HID_QUIRK_POLL_NO_REPORT_IDLE	(1 << 0)
+
 /*
  * If overwrite_console returns 1, the stdin, stderr and stdout
  * are switched to the serial port, else the settings in the
@@ -483,6 +487,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
 	struct usb_interface *iface;
 	struct usb_endpoint_descriptor *ep;
 	struct usb_kbd_pdata *data;
+	unsigned int quirks = 0;
 	int epNum;
 	int i;
 
@@ -525,6 +530,15 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
 
 	debug("USB KBD: found interrupt EP: 0x%x\n", ep->bEndpointAddress);
 
+	switch (dev->descriptor.idVendor) {
+	case USB_VENDOR_ID_APPLE:
+	case USB_VENDOR_ID_KEYCHRON:
+		quirks |= USB_HID_QUIRK_POLL_NO_REPORT_IDLE;
+		break;
+	default:
+		break;
+	}
+
 	data = malloc(sizeof(struct usb_kbd_pdata));
 	if (!data) {
 		printf("USB KBD: Error allocating private data\n");
@@ -565,6 +579,14 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
 	usb_set_idle(dev, iface->desc.bInterfaceNumber, 0, 0);
 #endif
 
+	/*
+	 * Apple and Keychron keyboards do not report the device state. Reports
+	 * are only returned during key presses.
+	 */
+	if (quirks & USB_HID_QUIRK_POLL_NO_REPORT_IDLE) {
+		debug("USB KBD: quirk: skip testing device state\n");
+		return 1;
+	}
 	debug("USB KBD: enable interrupt pipe...\n");
 #ifdef CONFIG_SYS_USB_EVENT_POLL_VIA_INT_QUEUE
 	data->intq = create_int_queue(dev, data->intpipe, 1,

-- 
2.43.2

