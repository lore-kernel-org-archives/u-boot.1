Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9FEC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E1087E91;
	Fri, 12 Apr 2024 22:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="YdvBo0GN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3DB881BB; Fri, 12 Apr 2024 22:26:27 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0B0881D6
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20240412202622e2959b05d5fb0db37a for <u-boot@lists.denx.de>;
 Fri, 12 Apr 2024 22:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZooSYHHa5wXYQ9OA3DIlH2lV0qhqkOPO3yhvoJ10AaI=;
 b=YdvBo0GNjDH0yvyZBYMht5ubwRlpPpU7UXzf67wyVImEJVXD/Qp/mtKAmluP+9FyDrBjlH
 oSjaL84n5bi7HDel6iyZB68RGX0HC8FvzVpa9oQJmjCUZQcrWN3IPOffg6NOXuJ4E5PaGyeW
 OVpoG1+Z5ejuhfUbo7BU5FeyEMuq8=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Marek Vasut <marex@denx.de>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Thinh Nguyen <thinhn@synopsys.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 4/6] usb: dwc3: gadget: Check ENBLSLPM before sending ep
 command
Date: Fri, 12 Apr 2024 22:26:04 +0200
Message-ID: <20240412202611.3565052-5-alexander.sverdlin@siemens.com>
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

Upstream Linux commit 87dd96111b0b.

When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
GUSB2PHYCFG.SUSPHY is set, it must be cleared before issuing an endpoint
command.

Current implementation only save and restore GUSB2PHYCFG.SUSPHY
configuration. We must save and clear both GUSB2PHYCFG.ENBLSLPM and
GUSB2PHYCFG.SUSPHY settings. Restore them after the command is
completed.

DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/usb/dwc3/gadget.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 00845dbadd27a..c14d7870b9461 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -301,26 +301,35 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
 {
 	u32			timeout = 500;
+	u32			saved_config = 0;
 	u32			reg;
 
-	int			susphy = false;
 	int			ret = -EINVAL;
 
 	/*
-	 * Synopsys Databook 2.60a states, on section 6.3.2.5.[1-8], that if
-	 * we're issuing an endpoint command, we must check if
-	 * GUSB2PHYCFG.SUSPHY bit is set. If it is, then we need to clear it.
+	 * When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
+	 * GUSB2PHYCFG.SUSPHY is set, it must be cleared before issuing an
+	 * endpoint command.
 	 *
-	 * We will also set SUSPHY bit to what it was before returning as stated
-	 * by the same section on Synopsys databook.
+	 * Save and clear both GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY
+	 * settings. Restore them after the command is completed.
+	 *
+	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
 	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
-			susphy = true;
+			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
 			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 		}
+
+		if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+			saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+		}
+
+		if (saved_config)
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
@@ -350,9 +359,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		udelay(1);
 	} while (1);
 
-	if (unlikely(susphy)) {
+	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg |= saved_config;
 		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
-- 
2.44.0

