Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58564C44501
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0873849F3;
	Sat, 11 Jul 2026 18:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hbuu5HFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5FC8498C; Sat, 11 Jul 2026 18:08:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A51D8498C
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783786103; bh=5iq7QwWLSdWNudE2fLW7LWyvZ2Mi3CJ827qDFdexh/4=;
 b=hbuu5HFpnQJ/mGzCaDLqMtxIskpctgI9vadOIN+4jNdJxMEhwPRQd1j2/txunfNr5wymGElpD
 GayIqLd9/KXHTuTV6cIudbGbksdfbEGhyM6WUuvBHVx2d+jCcFtqFYqnr3o+gUQMhTuD+DVXqJy
 RyzzxC9bUzZ27kw5t3oFP5t9xrUx0kRNB9a4gpagTRg84CzlSOQVgUC9kCYQm63h1d/ejlILJ6k
 /8aluYNxXU7Eu0iVHq63L3QhWWHz4cgeAAvAi4ga58Ryz2+hplcLp5GkzVdUOk47LtZartmQ/kq
 iIUmxcwFyEE8BtjbPpLvjnfwYyML7tiTjfAwV13305NQ==
X-Forward-Email-ID: 6a526a751b09fea89cb12495
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/8] usb: Import USB_DEVICE_VER() macro from Linux
Date: Sat, 11 Jul 2026 16:07:59 +0000
Message-ID: <20260711160808.2022242-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711160808.2022242-1-jonas@kwiboo.se>
References: <20260711160808.2022242-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Import the USB_DEVICE_VER() macro from Linux to make it less verbose to
describe a specific USB device with a version range.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This macro existed in the initial Linux v2.6.12-rc2 git build.
---
 include/usb.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/usb.h b/include/usb.h
index dab23753f0c0..3a509d535e45 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -509,6 +509,10 @@ struct usb_driver_entry {
 
 #define USB_DEVICE_ID_MATCH_DEVICE \
 		(USB_DEVICE_ID_MATCH_VENDOR | USB_DEVICE_ID_MATCH_PRODUCT)
+#define USB_DEVICE_ID_MATCH_DEV_RANGE \
+		(USB_DEVICE_ID_MATCH_DEV_LO | USB_DEVICE_ID_MATCH_DEV_HI)
+#define USB_DEVICE_ID_MATCH_DEVICE_AND_VERSION \
+		(USB_DEVICE_ID_MATCH_DEVICE | USB_DEVICE_ID_MATCH_DEV_RANGE)
 
 /**
  * USB_DEVICE - macro used to describe a specific usb device
@@ -522,6 +526,22 @@ struct usb_driver_entry {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE, \
 	.idVendor = (vend), \
 	.idProduct = (prod)
+/**
+ * USB_DEVICE_VER - describe a specific usb device with a version range
+ * @vend: the 16 bit USB Vendor ID
+ * @prod: the 16 bit USB Product ID
+ * @lo: the bcdDevice_lo value
+ * @hi: the bcdDevice_hi value
+ *
+ * This macro is used to create a struct usb_device_id that matches a
+ * specific device, with a version range.
+ */
+#define USB_DEVICE_VER(vend, prod, lo, hi) \
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE_AND_VERSION, \
+	.idVendor = (vend), \
+	.idProduct = (prod), \
+	.bcdDevice_lo = (lo), \
+	.bcdDevice_hi = (hi)
 
 #define U_BOOT_USB_DEVICE(__name, __match) \
 	ll_entry_declare(struct usb_driver_entry, __name, usb_driver_entry) = {\
-- 
2.54.0

