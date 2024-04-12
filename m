Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6B8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BDB88220;
	Fri, 12 Apr 2024 22:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="XwMcIu8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418158820A; Fri, 12 Apr 2024 22:26:29 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F3887E75
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 2024041220262455509666d2aa1ab9c6 for <u-boot@lists.denx.de>;
 Fri, 12 Apr 2024 22:26:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PK3Y0uFP1xO+ERAFgySetzNq4KeqNoNnVThZRdCptVo=;
 b=XwMcIu8wMWTRP6cpMb8oZMOcWlxIDIQI37Zz+uXnJ8/GsyPatuMaLsLgcROk9uqb64dm81
 WwrTqX3KVPrDhnE2W5Wnr23TC22CpX2K2SExwYYN4jnqnlxbUoOXxJVcB0V0yR7nAl9O1T1I
 7khHx1cl05p2sgKOlo91ZxitwznYQ=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Marek Vasut <marex@denx.de>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 6/6] usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End
 Transfer
Date: Fri, 12 Apr 2024 22:26:06 +0200
Message-ID: <20240412202611.3565052-7-alexander.sverdlin@siemens.com>
In-Reply-To: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Upstream Linux commit 3aa07f72894d.

If there's a disconnection while operating in eSS, there may be a delay
in VBUS drop response from the connector. In that case, the internal
link state may drop to operate in usb2 speed while the controller thinks
the VBUS is still high. The driver must make sure to disable
GUSB2PHYCFG.SUSPHY when sending endpoint command while in usb2 speed.
The End Transfer command may be called, and only that command needs to
go through at this point. Let's keep it simple and unconditionally
disable GUSB2PHYCFG.SUSPHY whenever we issue the command.

This scenario is not seen in real hardware. In a rare case, our
prototype type-c controller/interface may have a slow response
triggerring this issue.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/5651117207803c26e2f22ddf4e5ce9e865dcf7c7.1668045468.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c14d7870b9461..debfd4d6781db 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -316,7 +316,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	 *
 	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
-	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
+	if (dwc->gadget.speed <= USB_SPEED_HIGH ||
+	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
 			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
-- 
2.44.0

