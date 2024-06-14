Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44969C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABBE888964;
	Fri, 14 Jun 2024 02:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ubxN/t/Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="giGmZZul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B9B88168; Fri, 14 Jun 2024 02:53:40 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848B48896B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W0gkn1pLrz9slr;
 Fri, 14 Jun 2024 02:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnYAuWIIfVjR1XBqCGye9JfSSWJI4zrnNHm+komhuBY=;
 b=ubxN/t/QyQBrTHQZSDREa2CY3OLly78P+Y2vlWYb3QjtirLFSTB11sXWb5FUbXynt2m+3A
 eAz5FDZkxPBChdL+dUs9ScUyPqK2K2GEX86u9GY0kVN9JXMfb7XbB/xuz5Oh1Glarz5Tac
 t/H0UJqbVtn5oE9vInN9U+UZtVFzqP+XIyAvhGMRB/xXSls6odUxtBDeLRuueruX9QdF/+
 YLgLC/q7gYqZ1vHIL015evMb2u4paUlzr5dSR1KLp2/HjH7mzFO437Hb+ZmEbTgUb3ISlk
 cQBZwBKwH5mJWIov5TCKeF4QtOW+wCsb0D/v8Mc25nMD3CL8j5z279BRBaqxZw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnYAuWIIfVjR1XBqCGye9JfSSWJI4zrnNHm+komhuBY=;
 b=giGmZZulfg+/bCPUct1Uh4OqBZ5mW68GOZ47gar7Nj6CZTSc6s671VnYdReDhqxJiWcbW4
 OvhrZs1YBM8Egg3GaeTR4jsifYOu6otdOREAfBvnyNdqBe1kQx6agYAnGWTgzo0hIhD/Nl
 giJZz5F3E70mqHvT3dapnvJJdLvulkgkPOeb8A+LwftUL/I39XnSSJ3CUDUlac7TyeMnLC
 JV4v247SvJLSA+cY+PRvukSVnTVjnnyoDDbgzk8si1dculqxn5h/j+TIsZBAQnuKZLtHT2
 Xcaz7WxU+aWbhzOU8Kvzq36uuz5iCjTiuKSI6HFnSK9opvqqtSj/Dn23HFJDJw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/11] usb: gadget: cdns3: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:17 +0200
Message-ID: <20240614005309.34433-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bx5wu7hkifxohpmpkkh8g43ozit7tscm
X-MBO-RS-ID: ca5e5e2d0361735e83f
X-Rspamd-Queue-Id: 4W0gkn1pLrz9slr
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

Implement .handle_interrupts callback as a replacement for deprecated
dm_usb_gadget_handle_interrupts() function. The new callback allows
for each DM capable USB gadget controller driver to define its own
IRQ handling implementation without colliding with other controller
drivers.

Keep the dm_usb_gadget_handle_interrupts() in this driver for non-DM
case for now, until this driver gets fully converted to DM USB gadget.

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
 drivers/usb/cdns3/core.c          | 24 ++++++++++++++++++++++++
 drivers/usb/cdns3/gadget-export.h |  2 ++
 drivers/usb/cdns3/gadget.c        | 11 +----------
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index b4e931646b8..cbe06a9e7b6 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -20,6 +20,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/usb/gadget.h>
 #include <usb.h>
 #include <usb/xhci.h>
 
@@ -462,15 +463,38 @@ static int cdns3_gadget_remove(struct udevice *dev)
 	return cdns3_remove(cdns);
 }
 
+static int cdns3_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct cdns3 *cdns = dev_get_priv(dev);
+
+	cdns3_gadget_uboot_handle_interrupt(cdns);
+
+	return 0;
+}
+
+static const struct usb_gadget_generic_ops cdns3_gadget_ops = {
+	.handle_interrupts	= cdns3_gadget_handle_interrupts,
+};
+
 U_BOOT_DRIVER(cdns_usb3_peripheral) = {
 	.name	= "cdns-usb3-peripheral",
 	.id	= UCLASS_USB_GADGET_GENERIC,
 	.of_match = cdns3_ids,
+	.ops	= &cdns3_gadget_ops,
 	.probe = cdns3_gadget_probe,
 	.remove = cdns3_gadget_remove,
 	.priv_auto	= sizeof(struct cdns3_gadget_priv),
 	.flags = DM_FLAG_ALLOC_PRIV_DMA,
 };
+#else
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct cdns3 *cdns = dev_get_priv(dev);
+
+	cdns3_gadget_uboot_handle_interrupt(cdns);
+
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
index 577469eee96..b3fd7c53039 100644
--- a/drivers/usb/cdns3/gadget-export.h
+++ b/drivers/usb/cdns3/gadget-export.h
@@ -25,4 +25,6 @@ static inline void cdns3_gadget_exit(struct cdns3 *cdns) { }
 
 #endif
 
+void cdns3_gadget_uboot_handle_interrupt(struct cdns3 *cdns);
+
 #endif /* __LINUX_CDNS3_GADGET_EXPORT */
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index d11175dc5b6..32b2c412068 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2755,19 +2755,10 @@ int cdns3_gadget_init(struct cdns3 *cdns)
  *
  * Handles ep0 and gadget interrupt
  */
-static void cdns3_gadget_uboot_handle_interrupt(struct cdns3 *cdns)
+void cdns3_gadget_uboot_handle_interrupt(struct cdns3 *cdns)
 {
 	int ret = cdns3_device_irq_handler(0, cdns);
 
 	if (ret == IRQ_WAKE_THREAD)
 		cdns3_device_thread_irq_handler(0, cdns);
 }
-
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct cdns3 *cdns = dev_get_priv(dev);
-
-	cdns3_gadget_uboot_handle_interrupt(cdns);
-
-	return 0;
-}
-- 
2.43.0

