Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E207C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C38088970;
	Fri, 14 Jun 2024 02:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HKKOMymo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vwoB60OD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304F0831A1; Fri, 14 Jun 2024 02:53:38 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A3A88958
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W0gkk4YXYz9snL;
 Fri, 14 Jun 2024 02:53:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7CnAYJR+a+le3HHqvpUwUBO7d+RLu8dY39vw03Jnmt4=;
 b=HKKOMymobSLYC9FLioLis2mr/VaXTcbPJEIoKnBMOGsEP7haL55j9kn7jqY/dxul7yvmMc
 N13NjxFouVnaxILy2hwemyIikoneYIheWBBmhcWELa/tXTkXzfsgOibLcE6LzMSUe0F1ls
 xQ3i2EsINlTTncOwaNvkd5aqjluxUrXYF3PPBT/G1IYiBxrTRwLp4U8lbNcvdmxaorX1ZI
 YCZJbPrzMXuDRoTHAT9uggnxyjt1GdrSJE3iBYIN42LrDWTxZSzK4b3MXe9oHeBpPUBGgV
 aTv7qTXjMSjBqe41EXArt8RgvZHK8O3WOSe0udEKjZ69thVvss6uyQxpQJNd7A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7CnAYJR+a+le3HHqvpUwUBO7d+RLu8dY39vw03Jnmt4=;
 b=vwoB60ODSV0CDYo0f8fq/2HwlcPFbOhlmzWyvjM6XkYeDRyPfwHrYyXQPeYQ2HHPHkNKMF
 aL5RuljUg/8p8lGgkKPIc93pFVEEnFe/gdpGVhJEWQGWRy/gtgqDoSTaEykSySTCXf2PPY
 lWBgjt9yGoP8Vn4WjUal8FEhN48glbKkPuDP4qLVp7hCKPzNbpvd7Eb05S2plg8ZgmFGDK
 cHMs+oOU3J653bMyf0ocCmkm0urWoDhzM3x5SWPtV4TyC1EvBDfix0KfN++k1J7VqvcG5E
 E95v9qBuy9yUptK6pZK7dRiFBpGbp4twE2HJMsz4CAoBsYJ7GPxj9efFAa8xSQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
Date: Fri, 14 Jun 2024 02:51:15 +0200
Message-ID: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qormw43pr9z687b5t9qknidnpbb6wcox
X-MBO-RS-ID: 7b45b59c41c5bd753e0
X-Rspamd-Queue-Id: 4W0gkk4YXYz9snL
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

Introduce .ops for USB_GADGET_GENERIC uclass. The first new ops is
.handle_interrupts which must be implemented by DM capable USB gadget
controller drivers and must implement interrupt handling similar to
dm_usb_gadget_handle_interrupts(). For DM USB gadget drivers this is
a replacement for dm_usb_gadget_handle_interrupts(). Convert the DM
USB gadget drivers to this new ops instead.

DEPENDS: https://patchwork.ozlabs.org/project/uboot/list/?series=410150

Marek Vasut (11):
  usb: gadget: Introduce handle_interrupts ops to USB_GADGET_GENERIC
    uclass
  usb: gadget: cdns3: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: dwc2: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: dwc3: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: max3420: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: mtu3: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: omap2430: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: musb: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: ux500: Convert interrupt handling to
    usb_gadget_generic_ops
  usb: gadget: sandbox: Drop dm_usb_gadget_handle_interrupts()
  usb: gadget: Mark dm_usb_gadget_handle_interrupts as non-weak for
    DM_USB_GADGET

 drivers/usb/cdns3/core.c            | 24 ++++++++++++++++++++++++
 drivers/usb/cdns3/gadget-export.h   |  2 ++
 drivers/usb/cdns3/gadget.c          | 11 +----------
 drivers/usb/dwc3/dwc3-generic.c     | 23 ++++++++++++++---------
 drivers/usb/dwc3/dwc3-layerscape.c  | 21 +++++++++++++--------
 drivers/usb/gadget/dwc2_udc_otg.c   | 20 +++++++++++++++-----
 drivers/usb/gadget/max3420_udc.c    | 19 ++++++++++++-------
 drivers/usb/gadget/udc/udc-uclass.c | 24 ++++++++++++++++++++++++
 drivers/usb/host/usb-sandbox.c      |  7 +------
 drivers/usb/mtu3/mtu3_plat.c        | 23 ++++++++++++++---------
 drivers/usb/musb-new/omap2430.c     | 26 ++++++++++++++++----------
 drivers/usb/musb-new/ti-musb.c      | 23 ++++++++++++++---------
 drivers/usb/musb-new/ux500.c        | 22 ++++++++++++++--------
 include/linux/usb/gadget.h          |  8 ++++++++
 14 files changed, 172 insertions(+), 81 deletions(-)

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

-- 
2.43.0

