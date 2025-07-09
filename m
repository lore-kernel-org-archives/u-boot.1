Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E837C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 15:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DFE283390;
	Wed,  9 Jul 2025 17:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F6B834A3; Wed,  9 Jul 2025 17:23:03 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53853832BC
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 17:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uZWdN-008coq-P5;
 Wed, 09 Jul 2025 15:22:57 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Alice Guo <alice.guo@oss.nxp.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, peng.fan@nxp.com,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [RESEND PATCH] usb: ehci-mx6: Add i.MX95 OTG support
Date: Wed,  9 Jul 2025 08:22:55 -0700
Message-Id: <20250709152255.3037615-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

When the usb node is defined dr_mode="otg" ehci_usb_phy_mode() is called
to determine the mode from status registers.

The IMX95RM does not currently define the USBNC STATUS register but it is
assumed to be an omission as the first three registers are defined.
It has been expirimentally verified that the USBNC_PHY_STATUS register
at offset 0x23C bit4 (USBNC_PHYSTATUS_ID_DIG) reads 0 when USB_ID is GND
and 1 when floating.

Add imx95 to the list of SoC's that determine role based on the
USBNC_PHY_STATUS register.

Fixes: 801b5fafd35d "(usb: ehci-mx6: Add i.MX95 support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/usb/host/ehci-mx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index a8748cef7ad2..f979ff8dde1e 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -537,7 +537,7 @@ static int ehci_usb_phy_mode(struct udevice *dev)
 			plat->init_type = USB_INIT_DEVICE;
 		else
 			plat->init_type = USB_INIT_HOST;
-	} else if (is_mx7() || is_imx8mm() || is_imx8mn() || is_imx93()) {
+	} else if (is_mx7() || is_imx8mm() || is_imx8mn() || is_imx93() || is_imx95()) {
 		phy_status = (void __iomem *)(addr +
 					      USBNC_PHY_STATUS_OFFSET);
 		val = readl(phy_status);
-- 
2.25.1

