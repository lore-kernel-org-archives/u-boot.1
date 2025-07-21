Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45AAC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 18:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B4FA83164;
	Mon, 21 Jul 2025 20:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="ibdcvoxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5550F831B5; Mon, 21 Jul 2025 20:02:14 +0200 (CEST)
Received: from mace.gateworks.com (mace.gateworks.com [174.136.5.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67BEB830EA
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 20:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=gateworks.com; s=gwtrack; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I2DUguPFoLJWftlsHm1nw5oduJ/JfutrLyhRrwKRKEY=; b=ibdcvoxG625P6E0RvdVHMnA6to
 jo2A/RdMmtuBMtl1hc37e2dx4rYJZf//6SnnFrAPUoDXJBtY32hbMIaA8NPmkiZssbmI52yZPOoy8
 lUu6XybmQWKaz0HEywGsGKIDtz/0inwf11ypYKeFPebo8OO+sUPmbFkgY87ZdUTAgbc6iBnZepUES
 amnKyBfNym3U8DWccI7JmwljNSwZGOWLBOwKcsxyNMhAOdRRjUS/PIgIzTwagJkZkSdc/zFJBZn17
 IKvJQZu7vsMlgGranZuyJPiLIX5vVXhD7Ng5WgEz1+4npyle9dbYCBTSNbDN+gapDUgcmR9pbI/Bb
 1Xn8wzkg==;
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=chewbacca.pdc.gateworks.com)
 by mace.gateworks.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uduq0-005e54-78;
 Mon, 21 Jul 2025 18:02:08 +0000
Received: by chewbacca.pdc.gateworks.com (Postfix, from userid 1154)
 id 1EB3E3083719; Mon, 21 Jul 2025 11:02:08 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Alice Guo <alice.guo@oss.nxp.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, peng.fan@nxp.com,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] usb: ehci-mx6: Add i.MX95 OTG support
Date: Mon, 21 Jul 2025 11:02:05 -0700
Message-Id: <20250721180205.2696763-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.34.1
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

Use is_imx9() as this driver works for i.MX91, i.MX93 and i.MX95 and all
of these determine the role based on the USBNC_PHY_STATUS register.

Fixes: 801b5fafd35d "(usb: ehci-mx6: Add i.MX95 support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: use is_imx9 as suggested by Alice and update commit log
---
 drivers/usb/host/ehci-mx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index a8748cef7ad..25907f22612 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -537,7 +537,7 @@ static int ehci_usb_phy_mode(struct udevice *dev)
 			plat->init_type = USB_INIT_DEVICE;
 		else
 			plat->init_type = USB_INIT_HOST;
-	} else if (is_mx7() || is_imx8mm() || is_imx8mn() || is_imx93()) {
+	} else if (is_mx7() || is_imx8mm() || is_imx8mn() || is_imx9()) {
 		phy_status = (void __iomem *)(addr +
 					      USBNC_PHY_STATUS_OFFSET);
 		val = readl(phy_status);
-- 
2.34.1

