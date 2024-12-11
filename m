Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51807E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C528D8031F;
	Wed, 11 Dec 2024 08:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TNS5T6xj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i4dNVU7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F7F280209; Wed, 11 Dec 2024 08:32:43 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B718027E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y7S483NCsz9sqZ;
 Wed, 11 Dec 2024 08:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FstkYTwQxZoKVdlvVhkQGhRd1yDoYj+7ZGAFWCopTiI=;
 b=TNS5T6xjVOPVwv2T7Al63C3KmR7sYKi2UI3V0luHcDvqkhgN9dXhVAd1sIOJHsI83or2AL
 hyODlmfXxdWZd6SS4vF0Bp7LFG8efpaOHqOKOl03Tq4n0ZT3iiosx4rGeZFjnnlFCHwG4E
 Be2PEPtfoV9nCm+btisHYPxHnXM3kazmPOXCW0TIao9yNNVnhQzj8siAY7zFx52P5BZFAW
 +S8CbQbMNB90/a3vCUbhl1NjzPrkO0mBExMOiwVN+zXi/N/ZMH8ghFCSHYGzzl8qsIJalY
 tSY74kh1KkWMmm5bZXVdYdalMyJnuiz1wAC92D06/ckOO2Tt7/T0kmh1P+lZQw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FstkYTwQxZoKVdlvVhkQGhRd1yDoYj+7ZGAFWCopTiI=;
 b=i4dNVU7j4HOXQsU4z/C6YrIragEFZDI1CzxyLkDec6MJl4QXuH+wbH28lJbcigJCB7w08U
 ZjvA0FjUQJ722Qcb1CfHGnvCd0E/GNikDhGXVLV23GpMbAwUu63jTlfGcX37zOIF6q0K14
 7OCxtAcIDvaPxo3IRggbVTUiEUt6tJYfb6YXuh0mKRF3WvReE6zGlgt4A5SipzO3m1Y/hg
 kNvCqqB5jatRcCanPGSU3qZr1yRxBEPRMcwUpBgNRRSpPPqXVzp2VSR/GN5V8/juxgvLny
 o3uYNfvRpVq98784nK/ymZqA154VAAbLxVaGvIUAAeujmYqtsbby1Naoewj/yw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/13] usb: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:37 +0100
Message-ID: <20241211073210.8087-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jgn7aoqabtrc98oydyyc8kxmt4dmobft
X-MBO-RS-ID: 7547a34fb9ff4cb6a6d
X-Rspamd-Queue-Id: 4Y7S483NCsz9sqZ
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
V2: No change
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

