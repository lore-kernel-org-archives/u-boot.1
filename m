Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0B2F506CF
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 13:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C328405A;
	Mon, 16 Mar 2026 14:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="qNeHkhaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8748405F; Mon, 16 Mar 2026 14:23:50 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612008403D
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=s/InsEFhcaWRZqIw7ecIIT26FLCPBfIINMolAUBgoiw=;
 b=qNeHkhaF4XexpQLffHIcjbZZg2miumILJSV70EIxbLYOPSxewzDvu46wTo+zmKNj4dh4fYGboTYjMnC81nmGCUJO2i/Cd3ozw/TBnQQ3hm04dAk6zxhihAgdBt3pLPDsAikkXxMfm+vB/nWrLTUPmu22x5bTGWTVTV+HQJfNu2m0/qVPAnfnjZZEQ7XAbG4ZjFiCzLtbik6HSQ6cDRZaz9OXwOLzfcw1sIDqlBOgEbZonpb+O0Lmy75FQh
 9D8SQm5GJR/UN3L5npwErWFgTlouQj6Et2Q0j8GS+moNqtA5LEyWMWut+svzVB7Y9JHbstP7FLAYXVqzOVPYg+R557VA==
Received: from TkB (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 16 Mar 2026 13:23:41 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH] usb: dwc2_udc_otg_phy: fix compilation on non-Exynos patforms
Date: Mon, 16 Mar 2026 15:29:11 +0200
Message-ID: <20260316132911.4039-1-m95d+git@psihoexpert.ro>
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

s5p_cpu_id used in drivers/usb/gadget/dwc2_udc_otg_phy.c is undefined on
platforms other than Exynos.

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
---
 drivers/usb/gadget/dwc2_udc_otg_phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/dwc2_udc_otg_phy.c b/drivers/usb/gadget/dwc2_udc_otg_phy.c
index e0ac5d142b0..3730bd70bb2 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_phy.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_phy.c
@@ -56,10 +56,12 @@ void otg_phy_init(struct dwc2_udc *dev)
 	else /* C110 GONI */
 		clrbits_le32(&phy->phypwr, OTG_DISABLE_0 | ANALOG_PWRDOWN | FORCE_SUSPEND_0);
 
+#ifdef CONFIG_ARCH_EXYNOS
 	if (s5p_cpu_id == 0x4412)
 		clrsetbits_le32(&phy->phyclk, EXYNOS4X12_ID_PULLUP0 | EXYNOS4X12_COMMON_ON_N0,
 				EXYNOS4X12_CLK_SEL_24MHZ); /* PLL 24Mhz */
 	else
+#endif
 		clrsetbits_le32(&phy->phyclk, ID_PULLUP0 | COMMON_ON_N0,
 				CLK_SEL_24MHZ); /* PLL 24Mhz */
 
-- 
2.52.0


