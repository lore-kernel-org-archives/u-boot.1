Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D643AC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 16:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E19B87D59;
	Sun, 25 Feb 2024 17:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="plXC3mW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD9B87DEB; Sun, 25 Feb 2024 17:00:56 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC6587D59
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 17:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=31c0=KD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708876822;
 bh=ARNhsnCYjwni01trKDbL6Y7VRyvVktsEhhCpWyRepek=;
 b=plXC3mW3Xquoq7AYviTPtziC7QosFCLHR1clUFdSxY0/zCuB/BWW6BObyw0wU4JVqd+eU2iFp
 0yV/CICdBIoL9Or2Jb4cRYaPxLwblYCduuqPD5xP+fqhiawMdhK8LU79u7sz77WrF3m6eeKibpA
 yaEI/GOyadzWpRNgpPqv9EMC0BGI9CKziL2w2GjpD8sxQAlskszZNgVuYSs6E3qSzzdfvLehgOo
 SGzWSBkISfPXbalKJ/IJCAaG6BghAQmwhFDXX1a5tT4AubM5kVg0e3fJGyO/j29PDO6W8vo2bjF
 FlELIUQmn5jA2+Z3rolSFFp1eNXS7MxgmrTLJaBzYJxg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET is
 disabled
Date: Sun, 25 Feb 2024 15:27:13 +0000
Message-ID: <20240225152715.1821613-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65db5c58a3b008edc5d443a5
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

Build fail with the following error when DM_USB_GADGET is enabled and
USB_DWC3_GADGET is disabled:

  dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
  dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
    undefined reference to `dwc3_gadget_uboot_handle_interrupt'

Build also fail with the following error when USB_GADGET_DWC2_OTG +
DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:

  gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts':
  gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_handle_interrupts';
    dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here

Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/dwc3/dwc3-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 6fb2de8a5ace..891d01957619 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET)
 int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct dwc3_generic_priv *priv = dev_get_priv(dev);
@@ -435,7 +435,7 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 	if (!dr_mode)
 		dr_mode = usb_get_dr_mode(node);
 
-	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
+	if (IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET) &&
 	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
 		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
 		driver = "dwc3-generic-peripheral";
-- 
2.43.0

