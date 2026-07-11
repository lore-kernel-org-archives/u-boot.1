Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBDDC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC11F84994;
	Sat, 11 Jul 2026 18:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="t8NCoJjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6156084A29; Sat, 11 Jul 2026 18:08:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259448497A
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783786105; bh=xxCATSlcDRrRjriy7hyG6UCc9S8WoZUUFxbk5SgqKWI=;
 b=t8NCoJjsB5dj+gAmqsxmKbvjYpBJRK5rCig8GoBWg9AqYutdB3gF7oREs7U8JF1NgO/Isk+mr
 0PYPcaZCvAj/stjQ/VPDsaXSrjvjALnITG5Vk0ztBCTBjbKihTzmbm61VK8D7i0itxGKl/3oLEh
 RRwrkzb9Yd8to5YGSkFtBvHlfGldpj+6TO1gamQ3wUPqFuiEugmhw3AHBDvWbNEeVn2mN/Zn3pm
 /roNMwBnVHOjlzxCDXaXc8NkV/2YNABi6Z9motkGI+c+A9XSkvLeIY2sm6mot4rMPXyoe0X5JlK
 LL1ea2/yue1rQDg9ubLRbdmB+kw2PiCFjErK03nCqB/g==
X-Forward-Email-ID: 6a526a791b09fea89cb124b0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH 2/8] usb: Import USB_INTERFACE_INFO() macro from Linux
Date: Sat, 11 Jul 2026 16:08:00 +0000
Message-ID: <20260711160808.2022242-3-jonas@kwiboo.se>
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

Import the USB_INTERFACE_INFO() macro from Linux to make it less verbose
to describe a class of USB interfaces.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This macro existed in the initial Linux v2.6.12-rc2 git build.
---
 include/usb.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/usb.h b/include/usb.h
index 3a509d535e45..44c5d1cc5999 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -513,6 +513,10 @@ struct usb_driver_entry {
 		(USB_DEVICE_ID_MATCH_DEV_LO | USB_DEVICE_ID_MATCH_DEV_HI)
 #define USB_DEVICE_ID_MATCH_DEVICE_AND_VERSION \
 		(USB_DEVICE_ID_MATCH_DEVICE | USB_DEVICE_ID_MATCH_DEV_RANGE)
+#define USB_DEVICE_ID_MATCH_INT_INFO \
+		(USB_DEVICE_ID_MATCH_INT_CLASS | \
+		USB_DEVICE_ID_MATCH_INT_SUBCLASS | \
+		USB_DEVICE_ID_MATCH_INT_PROTOCOL)
 
 /**
  * USB_DEVICE - macro used to describe a specific usb device
@@ -542,6 +546,20 @@ struct usb_driver_entry {
 	.idProduct = (prod), \
 	.bcdDevice_lo = (lo), \
 	.bcdDevice_hi = (hi)
+/**
+ * USB_INTERFACE_INFO - macro used to describe a class of usb interfaces
+ * @cl: bInterfaceClass value
+ * @sc: bInterfaceSubClass value
+ * @pr: bInterfaceProtocol value
+ *
+ * This macro is used to create a struct usb_device_id that matches a
+ * specific class of interfaces.
+ */
+#define USB_INTERFACE_INFO(cl, sc, pr) \
+	.match_flags = USB_DEVICE_ID_MATCH_INT_INFO, \
+	.bInterfaceClass = (cl), \
+	.bInterfaceSubClass = (sc), \
+	.bInterfaceProtocol = (pr)
 
 #define U_BOOT_USB_DEVICE(__name, __match) \
 	ll_entry_declare(struct usb_driver_entry, __name, usb_driver_entry) = {\
-- 
2.54.0

