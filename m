Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47094C27C55
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 21:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F8C883D9;
	Sun,  9 Jun 2024 23:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K0Mopu/A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f6xiEO7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9A7883BA; Sun,  9 Jun 2024 23:35:19 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72632883BD
 for <u-boot@lists.denx.de>; Sun,  9 Jun 2024 23:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vy7Wn1Ft3z9sdZ;
 Sun,  9 Jun 2024 23:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0jB1DlKs9qOqSwNfj/RCkeqAW5bajljZySVzMZ8B7k=;
 b=K0Mopu/Ax6T+14+HMIwambSq7cJVMmlEdv5lSBvnEWOKVzx1L09EqKwFvE7DLPbcWSNhvX
 xAZGcOSAvt7Gut0uHJbcYxJaCmsoa2Vi2F/Kxke0OC7pSwAJ4a83hRLeYNWTb2MmRE837A
 aiouiHFIbhr1Iv9HVLRkiK2S1ouSPO4ztJFc51cAOi8S3cfIZwSHFuQ3EZumRswZ1iRk0Z
 6EuQMaQ0T5k247jdBFVfVhqi8SfF6OhQ6/8Kjfs4eXvnJl5YShxVf3lSkS6VjkGs0ZbSJF
 uis1LpsUnoTJw76vF7TQF57JIOnLuqv2dmdDL9YL39Mi6NtVqJZxGA/HbcDIaQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0jB1DlKs9qOqSwNfj/RCkeqAW5bajljZySVzMZ8B7k=;
 b=f6xiEO7VDbBr7HMfz8wFEguaZvKvXH8Uzyn1Clatu35swx0STsq6fdudqaTZ3p498AKIuD
 ZUAJMolL3AQF66vnpPbG/iviw4p4fnbQixHwq/wTHmhS1HHzIYq1a+3XYAdnlaL7OTP9mx
 0I3aojWPg56nc1LR21BtHowYjcX7agGqva7jWlpg6NUbhYokb4bVdViAQqj2tndCggaPPq
 bmZ/8gtmIe6jjCnUoTWq+EQeKikCgvPQWvFpmErFEJKyYn7XQL9a4MF0ESwEe4au1vyP/C
 KqOGGJTTY3OuiM+I41CAtyUFa0TxRsNzDCtdpWNtzM8PVcPF6PbpBSqxwVVaFQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] usb: gadget: Drop usb_gadget_controller_number()
Date: Sun,  9 Jun 2024 23:32:16 +0200
Message-ID: <20240609213449.194762-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 753e2f7f29ff179b245
X-MBO-RS-META: 4ch9q3bochwtcjxbj7bcrbwasjxgh9pz
X-Rspamd-Queue-Id: 4Vy7Wn1Ft3z9sdZ
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

The bcdDevice field is defined as
|Device release number in binary-coded decimal
in the USB 2.0 specification. We use this field to distinguish the UDCs
from each other. In theory this could be used on the host side to apply
certain quirks if the "special" UDC in combination with this gadget is
used. This hasn't been done as far as I am aware. In practice it would
be better to fix the UDC driver before shipping since a later release
might not need this quirk anymore.

This patch removes the newly unused function. Linux stopped using this
functionality in 2012, remove it from U-Boot as well.

Matching Linux kernel commit:
ed9cbda63d45 ("usb: gadget: remove usb_gadget_controller_number()")

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
 drivers/usb/gadget/gadget_chips.h | 62 -------------------------------
 1 file changed, 62 deletions(-)

diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index 98156c312d2..316051686c4 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -146,65 +146,3 @@
 #else
 #define gadget_is_dwc2(g)        0
 #endif
-
-/**
- * usb_gadget_controller_number - support bcdDevice id convention
- * @gadget: the controller being driven
- *
- * Return a 2-digit BCD value associated with the peripheral controller,
- * suitable for use as part of a bcdDevice value, or a negative error code.
- *
- * NOTE:  this convention is purely optional, and has no meaning in terms of
- * any USB specification.  If you want to use a different convention in your
- * gadget driver firmware -- maybe a more formal revision ID -- feel free.
- *
- * Hosts see these bcdDevice numbers, and are allowed (but not encouraged!)
- * to change their behavior accordingly.  For example it might help avoiding
- * some chip bug.
- */
-static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
-{
-	if (gadget_is_net2280(gadget))
-		return 0x01;
-	else if (gadget_is_dummy(gadget))
-		return 0x02;
-	else if (gadget_is_sh(gadget))
-		return 0x04;
-	else if (gadget_is_goku(gadget))
-		return 0x06;
-	else if (gadget_is_mq11xx(gadget))
-		return 0x07;
-	else if (gadget_is_omap(gadget))
-		return 0x08;
-	else if (gadget_is_n9604(gadget))
-		return 0x09;
-	else if (gadget_is_at91(gadget))
-		return 0x12;
-	else if (gadget_is_imx(gadget))
-		return 0x13;
-	else if (gadget_is_musbhsfc(gadget))
-		return 0x14;
-	else if (gadget_is_musbhdrc(gadget))
-		return 0x15;
-	else if (gadget_is_atmel_usba(gadget))
-		return 0x17;
-	else if (gadget_is_fsl_usb2(gadget))
-		return 0x18;
-	else if (gadget_is_amd5536udc(gadget))
-		return 0x19;
-	else if (gadget_is_m66592(gadget))
-		return 0x20;
-	else if (gadget_is_ci(gadget))
-		return 0x21;
-	else if (gadget_is_dwc3(gadget))
-		return 0x23;
-	else if (gadget_is_cdns3(gadget))
-		return 0x24;
-	else if (gadget_is_max3420(gadget))
-		return 0x25;
-	else if (gadget_is_mtu3(gadget))
-		return 0x26;
-	else if (gadget_is_dwc2(gadget))
-		return 0x27;
-	return -ENOENT;
-}
-- 
2.43.0

