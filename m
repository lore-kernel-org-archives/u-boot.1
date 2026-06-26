Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B20C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C228460E;
	Fri, 26 Jun 2026 16:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="FgU8bF7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AAE184704; Fri, 26 Jun 2026 16:28:45 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14868404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1F07E11619A; Fri, 26 Jun 2026 16:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782484122; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Ylvg2+s1pYQZ7Jq0Hl+kaIkPYKHEjibX3WVBkePPRic=;
 b=FgU8bF7SJrcY8Rz4dU9OZ+aexRGffe0Bk4bMt1oI90uCUyr3vfk94a0qG/yFaaO221Hd1W
 kr6bHJZ1kdCtq7tt/+k8LgNwbK3SQZ8U0o+OI2KAu/fRT4cxq31GlULPoUQiBLg/cly8vs
 DhI+6IEYkxN+2ZpVfKvpqmynNUI3taYvuUGraVp7gL7Wc2opoASprbwwwFsJ4X3quCBFzf
 MyYs5gGTHQE/UhdXiQXKLJgnwWyxvjSDRgZCPipiPjDeRbsmaGVRQfUoXNo0dKvs0rOWPb
 QsrOPQe5S1uSaU93XkX08Z50EJgBCYE2fyngxiguIHC+jKK4Go0/MWJ7OuNlcw==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] cmd: ums: Set Device Descriptor iSerial based on serial#
 env variable
Date: Fri, 26 Jun 2026 16:28:17 +0200
Message-ID: <20260626142840.305478-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The DFU code currently sets the content of "serial#" environment
variable into Device Descriptor iSerial field. This is useful when
there are multiple devices connected to the same host PC and they
have to be told apart. Replicate the same behavior in the UMS code.

Example without serial# set, which is the original behavior:
"
u-boot=> ums 0 mmc 1
UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000

$ dmesg -w
...
usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-2.3.7: Product: USB download gadget
usb 5-2.3.7: Manufacturer: Vendor
                            <------------------------------- NOT HERE
usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
...

$ lsusb -vd 0525:a4a5

Bus 005 Device 051: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0525 Netchip Technology, Inc.
  idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
  bcdDevice           7e.a7
  iManufacturer           1 Vendor
  iProduct                2 USB download gadget
  iSerial                 0 <------------------------------- NOT HERE
...
"

Example with serial# set to 1234abcd, which is the optional new behavior:
"
u-boot=> setenv serial# 1234abcd <------------------------------ HERE
u-boot=> ums 0 mmc 1
UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000

$ dmesg -w
...
usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 5-2.3.7: Product: USB download gadget
usb 5-2.3.7: Manufacturer: Vendor
usb 5-2.3.7: SerialNumber: 1234abcd <--------------------------- HERE
usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
...

$ lsusb -vd 0525:a4a5

Bus 005 Device 052: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0525 Netchip Technology, Inc.
  idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
  bcdDevice           7e.a7
  iManufacturer           1 Vendor
  iProduct                2 USB download gadget
  iSerial                 3 1234abcd <-------------------------- HERE
...
"

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Move to fsg_bind()
---
 drivers/usb/gadget/f_mass_storage.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 71dc58da3f0..f82acd10b45 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -241,6 +241,7 @@
 
 #include <config.h>
 #include <div64.h>
+#include <env.h>
 #include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
@@ -2651,8 +2652,15 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_gadget	*gadget = c->cdev->gadget;
 	int			i;
 	struct usb_ep		*ep;
+	char __maybe_unused	*sn;
 	fsg->gadget = gadget;
 
+	if (CONFIG_IS_ENABLED(ENV_SUPPORT)) {
+		sn = env_get("serial#");
+		if (sn)
+			g_dnl_set_serialnumber(sn);
+	}
+
 	/* New interface */
 	i = usb_interface_id(c, f);
 	if (i < 0)
-- 
2.53.0

