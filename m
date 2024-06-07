Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F280C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 12:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BD587DEA;
	Fri,  7 Jun 2024 14:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="d0fZgBzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED0E87FCD; Fri,  7 Jun 2024 11:20:07 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8DA8841D
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 11:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4VwbJL6QtDz9vjP;
 Fri,  7 Jun 2024 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1717752003; bh=Fb/2iX9PE/1zFzi49Cb3VtBDrksIyIGKYEfQ0nhsozY=;
 h=From:Date:Subject:To:Cc:From;
 b=d0fZgBzjrIvngGhocGqsqoQUkpw+InhxB5EPyl7tP22p3bn5D0jlWIEQYhzBATvz+
 pq8XU38/Kv3L5HvRk1keXeXVVKUC01U7zwNWBbqVAz7EuJXsEU7GyelrGJQOmDfvzt
 +1cS4JlfFQ4fPSXgItchCoViCzgg0RsCer5fT8+Y=
X-Riseup-User-ID: 8719894D8055D66ADEE187F15C251CC1B0D0910F0B26D9EEC2D4800BA9C1D1AD
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4VwbJK5wHczJsjt;
 Fri,  7 Jun 2024 09:20:01 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Fri, 07 Jun 2024 16:19:48 +0700
Subject: [PATCH] usb: kbd: Add probe quirk for some generic USB mini keyboard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-generic-minikbd-probe-v1-1-6a0e2646adfb@riseup.net>
X-B4-Tracking: v=1; b=H4sIALPQYmYC/x3MTQqAIBBA4avIrBuwjP6uEi1SRxsiE4UIorsnL
 d/iew9kSkwZJvFAooszn6FEXQkw2xo8IdvS0MimlZ3s0VMowuDBgXdtMaZTExpF2oyddoNVUGx
 M5Pj+v/Pyvh8PgGqAZwAAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
X-Mailman-Approved-At: Fri, 07 Jun 2024 14:54:18 +0200
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

This adds a probe quirk to some generic USB mini keyboard, those uses
Elan's USB vendor ID and 0x1213 as product ID.

Those keyboards does not report current device state and would fail to
initialize under U-Boot with the following error:

"Failed to get keyboard state from device 04f3:1213"

It's not known if those generic USB mini keyboard has the same VID/PID.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 common/usb_kbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 820f591fc5..d6451ba7c2 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -31,6 +31,8 @@
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021	0x029a
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021		0x029f
 
+#define USB_VENDOR_ID_ELAN	0x04f3
+
 #define USB_VENDOR_ID_KEYCHRON	0x3434
 
 #define USB_HID_QUIRK_POLL_NO_REPORT_IDLE	BIT(0)
@@ -513,6 +515,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
 
 	switch (dev->descriptor.idVendor) {
 	case USB_VENDOR_ID_APPLE:
+	case USB_VENDOR_ID_ELAN:
 	case USB_VENDOR_ID_KEYCHRON:
 		quirks |= USB_HID_QUIRK_POLL_NO_REPORT_IDLE;
 		break;

---
base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
change-id: 20240607-generic-minikbd-probe-c3ebc96bf8d3

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

