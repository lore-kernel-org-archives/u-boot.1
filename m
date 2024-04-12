Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F193AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3146881D6;
	Fri, 12 Apr 2024 22:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Oeinttqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA57E8802D; Fri, 12 Apr 2024 22:26:25 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CAFC881C8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202404122026223f09714a84f1b3a406 for <u-boot@lists.denx.de>;
 Fri, 12 Apr 2024 22:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7q2MyjGsGqSOpwQumP9kCnlzP7C12KYfTUJ7FyIyEY0=;
 b=OeinttqeXAQs5R2QcVJHq0ycuvJCW2lGWY8TXiSMowsDtQfOCqXZ2WBi0ZfSuAGZtye/hi
 5B7DVv887Ertxp7U/hfViuJpHJVEaajpqeUYpcwAPJV3iaGvYg3Xyt5Q8i0iRca1PbCuriKj
 z9LHqgNMfJXrtIlQ2KGlKztOIqT34=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Marek Vasut <marex@denx.de>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 3/6] usb: dwc3: gadget: only resume USB2 PHY in <=HIGHSPEED
Date: Fri, 12 Apr 2024 22:26:03 +0200
Message-ID: <20240412202611.3565052-4-alexander.sverdlin@siemens.com>
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

From: Felipe Balbi <felipe.balbi@linux.intel.com>

Upstream Linux commit ab2a92e7a608.

As a micro-power optimization, let's only resume the
USB2 PHY if we're working on <=HIGHSPEED. If we're
gonna work on SUPERSPEED or SUPERSPEED+, there's no
point in resuming the USB2 PHY.

Fixes: 2b0f11df84bb ("usb: dwc3: gadget: clear SUSPHY bit before ep cmds")
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/usb/dwc3/gadget.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8f6513752f085..00845dbadd27a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -314,11 +314,13 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	 * We will also set SUSPHY bit to what it was before returning as stated
 	 * by the same section on Synopsys databook.
 	 */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
-		susphy = true;
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
+			susphy = true;
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
 	}
 
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
-- 
2.44.0

