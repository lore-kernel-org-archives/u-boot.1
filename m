Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A311F013E6
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 09:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB9583A1B;
	Mon, 16 Mar 2026 10:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="olYuH+lQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4634A83F8A; Mon, 16 Mar 2026 10:21:18 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2358C83015
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 10:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=EUMAn9HA1y3GUyfs+LD9aW/3xQ0s7OaqbuYllx26TK8=;
 b=olYuH+lQPUS+qDZQooO4UG3MGWMGuf1BwXgAYrXItKPwGIl6gsaNEd1m5biN8uv2kzzFDZHCK+4xmsQhB+VdzBjomaimrM4Gyp8mhRyQ4PZNCAi0z1G2E0eVKRITWPicBPLbP+gwAJwbW6aAB7mUq8JFJ5ZPSog6cfUO96WB6SSYX3CyRmiP8/tBO2KbCQD8S4yR3fSP4jQgye1Ot2foBYuGbwHhB7V42EyaYbipegRos6ftD8WHGzfkZy
 gDclqpmUeOOGXmLN2N6npB7b+2JKNvE0gfWtJl70wl9MKU8QUmuJWjn6DfqDcHB+ujpchiliW8fQ00nVCBp/P45L4/TA==
Received: from TkB (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 16 Mar 2026 09:21:08 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH] USB: dwc2: allow usb start even if usbphy is not found
Date: Mon, 16 Mar 2026 11:26:39 +0200
Message-ID: <20260316092639.2377-1-m95d+git@psihoexpert.ro>
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

RK3288 uses rockchip_usb2_phy, but that driver doesn't register iself
as a usbphy driver and "usb start" fails with this error:

  drivers/usb/host/dwc2.c:1254- dwc2_setup_phy() dwc2_usb usb@ff580000:
  Failed to get USB PHY: -19.

Until a proper fix is made for rockchip_usb2_phy, this patch allows
usb start to continue even if usbphy is not found.

Tested on Asus TinkerBoard.

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
---
 drivers/usb/host/dwc2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 16f21fa9083..74d71f23d88 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -1329,7 +1329,7 @@ static int dwc2_usb_probe(struct udevice *dev)
 
 	ret = dwc2_setup_phy(dev);
 	if (ret)
-		return ret;
+		dev_dbg(dev, "Failed to setup PHY: %d. Continuing anyway...\n", ret);
 
 	return dwc2_init_common(dev, priv);
 }
@@ -1345,8 +1345,7 @@ static int dwc2_usb_remove(struct udevice *dev)
 
 	ret = dwc2_shutdown_phy(dev);
 	if (ret) {
-		dev_dbg(dev, "Failed to shutdown USB PHY: %d.\n", ret);
-		return ret;
+		dev_dbg(dev, "Failed to shutdown USB PHY: %d. Continuing anyway...\n", ret);
 	}
 
 	dwc2_uninit_common(priv->regs);
-- 
2.52.0


