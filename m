Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBC7C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EEED881C2;
	Fri, 12 Apr 2024 22:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="J3TIs7lT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA8A8800D; Fri, 12 Apr 2024 22:26:25 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1298802D
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20240412202620ad3fb8d703e17cf33d for <u-boot@lists.denx.de>;
 Fri, 12 Apr 2024 22:26:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TptvjDK6304vfY4bTji66U8hdyZ/wkCaFvaW3jpxQAg=;
 b=J3TIs7lTqVfczidbCgKkxvoJmeas+hhPsvdkN8Du3T/Qv02IowQQDrpXTlz+yYrqnL/lJI
 ghsgFHVNeDc5QWuj3/f4hBeEnihw6jzdBvBX2Z1cjg+ey+DvDIcLFQb4tQZUAX6NiQNPx+GP
 JFKzqKGBRNfgwPLDDbxbSt3pYXQGM=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Marek Vasut <marex@denx.de>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 1/6] usb: dwc3: gadget: combine return points into a single one
Date: Fri, 12 Apr 2024 22:26:01 +0200
Message-ID: <20240412202611.3565052-2-alexander.sverdlin@siemens.com>
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

Upstream Linux commit c0ca324d09a0.

dwc3_send_gadget_ep_cmd() had three return
points. That becomes a pain to track when we need to
debug something or if we need to add more code
before returning.

Let's combine all three return points into a single
one just by introducing a local 'ret' variable.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/usb/dwc3/gadget.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 69d9fe40e2f87..17c19285f1c24 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -302,6 +302,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 {
 	u32			timeout = 500;
 	u32			reg;
+	int			ret = -EINVAL;
 
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1);
@@ -313,7 +314,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
 			dev_vdbg(dwc->dev, "Command Complete --> %d\n",
 					DWC3_DEPCMD_STATUS(reg));
-			return 0;
+			ret = 0;
+			break;
 		}
 
 		/*
@@ -321,11 +323,15 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		 * interrupt context.
 		 */
 		timeout--;
-		if (!timeout)
-			return -ETIMEDOUT;
+		if (!timeout) {
+			ret = -ETIMEDOUT;
+			break;
+		}
 
 		udelay(1);
 	} while (1);
+
+	return ret;
 }
 
 static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
-- 
2.44.0

