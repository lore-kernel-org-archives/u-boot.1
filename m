Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD291D73E84
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 19:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E24B83FED;
	Thu, 29 Jan 2026 20:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G2zEnlFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3FA840C3; Thu, 29 Jan 2026 20:52:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9030283B72
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 20:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1769716340;
 bh=uw5anGR24j/NOGMPIMWGNnZ4/kcXdxHmh/P76TYTUzo=;
 b=G2zEnlFg5CEOYF1bUGW3muPEuENk8dK+/puydi1XvFmZJDHez7oyBmhmJ9ApDVyKC4M9F79rw
 cBMDaBtg9uk1ud2uu3r4fuol9uSIbRpxdNgk4QcowQmttm3jCNW5FS3N2iRXUAJ51LYgcTaVTRX
 DXQCNHxMn3eadXgM+8gWbQK+/5c90Hh5sNR5dnNuKsUeLNVO22TZeorfVnu1LQPV+/cg/ZcyF/q
 cZHe2/9Jf4jtubbMliPXAs14Tk5HUbOisS+yCg0RIin+G1pkQETqFuRwtOV63iy6CZxJ6amOabv
 INIEE72PLD1++uCoBYthVWx/rpf5OtwOfCvCJKIitzkQ==
X-Forward-Email-ID: 697bba6c97bba00c75b9b84d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH v2] usb: gadget: dwc2: Move dr_mode check from of_to_plat() to
 bind()
Date: Thu, 29 Jan 2026 19:52:05 +0000
Message-ID: <20260129195207.2260264-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

Rockchip RK3288 and RK3506 contain two DWC2 USB controllers, typically
one controller use dr_mode=otg and the other one use dr_mode=host.

With USB_GADGET_DWC2_OTG, DM_USB_GADGET and USB_DWC2 enabled this result
in the dwc2-udc-otg driver binding to both controllers, however only one
will probe due to use of dr_mode=host on the other one.

After the commit 6668b8e7cc68 ("dm: core: Support multiple drivers with
same compatibles") it is possible to bind one controller to the
dwc2-udc-otg driver and the other one to the dwc2_usb driver.

Move the dr_mode check from of_to_plat() to bind() to allow dm core to
bind the dwc2 host driver to dr_mode=host controllers.

Before this:

  => dm tree
   ...
   usb_gadget    0  [   ]   dwc2-udc-otg          |   |-- usb@ff740000
   usb_gadget    1  [   ]   dwc2-udc-otg          |   |-- usb@ff780000

  => usb start
  starting USB...
  No USB controllers found

After this:

  dwc2-udc-otg usb@ff780000: Invalid dr_mode 1

  => dm tree
   ...
   usb_gadget    0  [   ]   dwc2-udc-otg          |   |-- usb@ff740000
   usb           0  [   ]   dwc2_usb              |   |-- usb@ff780000

  => usb start
  starting USB...
  USB DWC2
  Bus usb@ff780000: 1 USB Device(s) found

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Update dev_dbg message to include current dr_mode
---
 drivers/usb/gadget/dwc2_udc_otg.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 40393141ca95..e475b14b9ac3 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -975,12 +975,6 @@ static int dwc2_udc_otg_of_to_plat(struct udevice *dev)
 	void (*set_params)(struct dwc2_plat_otg_data *data);
 	int ret;
 
-	if (usb_get_dr_mode(dev_ofnode(dev)) != USB_DR_MODE_PERIPHERAL &&
-	    usb_get_dr_mode(dev_ofnode(dev)) != USB_DR_MODE_OTG) {
-		dev_dbg(dev, "Invalid mode\n");
-		return -ENODEV;
-	}
-
 	plat->regs_otg = dev_read_addr(dev);
 
 	plat->rx_fifo_sz = dev_read_u32_default(dev, "g-rx-fifo-size", 0);
@@ -1163,6 +1157,18 @@ static int dwc2_udc_otg_remove(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
+static int dwc2_udc_otg_bind(struct udevice *dev)
+{
+	enum usb_dr_mode dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+
+	if (dr_mode != USB_DR_MODE_PERIPHERAL && dr_mode != USB_DR_MODE_OTG) {
+		dev_dbg(dev, "Invalid dr_mode %d\n", dr_mode);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int dwc2_gadget_handle_interrupts(struct udevice *dev)
 {
 	return dwc2_udc_handle_interrupt();
@@ -1186,6 +1192,7 @@ U_BOOT_DRIVER(dwc2_udc_otg) = {
 	.of_match = dwc2_udc_otg_ids,
 	.ops	= &dwc2_gadget_ops,
 	.of_to_plat = dwc2_udc_otg_of_to_plat,
+	.bind = dwc2_udc_otg_bind,
 	.probe = dwc2_udc_otg_probe,
 	.remove = dwc2_udc_otg_remove,
 	.plat_auto	= sizeof(struct dwc2_plat_otg_data),
-- 
2.52.0

