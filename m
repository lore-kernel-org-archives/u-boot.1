Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E47E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3800C8961E;
	Sun,  8 Dec 2024 23:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m6qVdUmB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IlsM6gw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DACE895DD; Sun,  8 Dec 2024 23:06:32 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F23A1895DA
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y5zbm5QxVz9sp9;
 Sun,  8 Dec 2024 23:06:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHjBJwyvVaTLOjkBH3u6ZNFhANFU5NXIcu0MMcPWG60=;
 b=m6qVdUmBzwk7eRmfkuVi0kdCcD0nMjZR/63eCqY/dSbQzZ6/ZrRjkGcbEHMlrA0xAy4xmn
 60JRDL+X7hbBkjoaYRW+3BJz+Avjd3Zi5haHvA9qF7b2X6HRXpjiuvWcSBRdS0QHMnLRQD
 EE4ZHyWmbMYOnD2dsiPC+og3ZMALz6xtKi6AjZSmEeOIxus1Z0IQ2h7THCppBRla7EClFW
 W741QwhtQuBIcfrVn/1wxsc1RPyEhGYlzX68CPnojR19l4FiWBvhiTtkXjXYQdJiwzutO0
 4GvrJ/JKtqiCW1tCMPSTSSS9qXFDePGQBRKbvFhIFk6l3JmHw52K0AVQgWH0Ww==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHjBJwyvVaTLOjkBH3u6ZNFhANFU5NXIcu0MMcPWG60=;
 b=IlsM6gw/sCj8xWeqhQODKwI/+04PZ6TkNsK83ooUSWghQpnuLUzGY535K/heGBkzVgSOk3
 c0a+Bt6uNz9SzEPI/kGj8y/QBrHauddaUckbs6j3zfXhunPmcJ3jPVycGeEEL/c27w3wGL
 YpggrneEZyXorsSpRmVEM0AHAacPcQrA/2/CjvyEfMANgcKxenvtiqvUIXNERbgWsy+Pfs
 RJdNPXMvRhgLI58mnJ8OM7GukTq/u/sFLefRTlCwwbJ7tT0uJcdr0p65/pAD1nV+SWyu87
 szCprX4TdHmJHI8Qo87d0kDc7tH3HibIdr1lex65lPu2b9qRE5EPwe6KjNOIfg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/13] usb: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:04:06 +0100
Message-ID: <20241208220551.204743-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b57wxemq7inj9ecoiuu64cieizkkgs57
X-MBO-RS-ID: 87bd0f15025e86d565b
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/gadget/Kconfig                   | 4 ++--
 drivers/usb/host/Kconfig                     | 4 ++--
 drivers/usb/host/xhci-rcar-r8a779x_usb3_v3.h | 2 +-
 drivers/usb/host/xhci-rcar.c                 | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 010084ef7f3..c815764c2bc 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -115,10 +115,10 @@ config USB_GADGET_DWC2_OTG
 	  USB_GADGET to be enabled.
 
 config USB_RENESAS_USBHS
-	bool "Renesas RCar USB2.0 HS controller (gadget mode)"
+	bool "Renesas R-Car USB2.0 HS controller (gadget mode)"
 	select USB_GADGET_DUALSPEED
 	help
-	  The Renesas Rcar USB 2.0 high-speed gadget controller
+	  The Renesas R-Car USB 2.0 high-speed gadget controller
 	  integrated into Salvator and Kingfisher boards. Select this
 	  option if you want the driver to operate in Peripheral mode.
 	  This option requires USB_GADGET to be enabled.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index bb5893d56db..24786a2bc91 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -103,12 +103,12 @@ config USB_XHCI_PCI
 	  Enables support for the PCI-based xHCI controller.
 
 config USB_XHCI_RCAR
-	bool "Renesas RCar USB 3.0 support"
+	bool "Renesas R-Car USB 3.0 support"
 	default y
 	depends on ARCH_RENESAS
 	help
 	  Choose this option to add support for USB 3.0 driver on Renesas
-	  RCar Gen3 SoCs.
+	  R-Car Gen3 SoCs.
 
 config USB_XHCI_STI
 	bool "Support for STMicroelectronics STiH407 family on-chip xHCI USB controller"
diff --git a/drivers/usb/host/xhci-rcar-r8a779x_usb3_v3.h b/drivers/usb/host/xhci-rcar-r8a779x_usb3_v3.h
index 8db88f0dcfa..7c909b4697a 100644
--- a/drivers/usb/host/xhci-rcar-r8a779x_usb3_v3.h
+++ b/drivers/usb/host/xhci-rcar-r8a779x_usb3_v3.h
@@ -1,5 +1,5 @@
 /*
- * Renesas RCar xHCI controller firmware version 3
+ * Renesas R-Car xHCI controller firmware version 3
  *
  * Copyright (c) 2014, Renesas Electronics Corporation
  * All rights reserved.
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 38c5928faed..b72807053c4 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  *
- * Renesas RCar USB HOST xHCI Controller
+ * Renesas R-Car USB HOST xHCI Controller
  */
 
 #include <clk.h>
-- 
2.45.2

