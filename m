Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAADF9B5E2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF8A83936;
	Wed, 22 Apr 2026 10:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="KN6YQuau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A2483E76; Wed, 22 Apr 2026 10:34:45 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7468352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=Ii8a8jpNooDXHWnpYZRKWgpgD3ylXhffNwjKNQq3UE0=;
 b=KN6YQuauLSjNIQpRGAAv2BldJneNul5tqkEDXwGgpNf5ZP6maFrI/vmloTshCN2o1ICtYjEmQe8H/MN6mW/u9MQg585s27Do2wBYgOlnjTLh1QVYEKPEN5bQPOAU4v99Ut1krrvnyOX4XKxki+2/NcPf+4WpM32IAkrl5ZEuL4VTAr17F82vhkXXDnL0QIinmoXCsyXg7uL+iXEEopAU6t6r/ie3y+9G+TWnkVU2qcdP4kis8y3ijvHfk+
 9iLnTjuHniXG1fZWJMJc0x5mKPU7ep6YGCyE0gfPr1qxw/8PYxYQQHvk/D7rs5I91RLgMMAUAdxCqHN8qJXdyR58UoXg==
Received: from TkB (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Wed, 22 Apr 2026 08:34:01 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Marius Dinu <m95d+git@psihoexpert.ro>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3] usb: dwc2_udc_otg_phy: fix compilation on non-Exynos
 patforms
Date: Wed, 22 Apr 2026 11:32:56 +0300
Message-ID: <20260422083430.20345-1-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ab44395a-dc24-4141-8211-16a16281d349@cherry.de>
References: <ab44395a-dc24-4141-8211-16a16281d349@cherry.de>
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
Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/usb/gadget/dwc2_udc_otg_phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/dwc2_udc_otg_phy.c b/drivers/usb/gadget/dwc2_udc_otg_phy.c
index e0ac5d142b0..c56ff1125bd 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_phy.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_phy.c
@@ -56,10 +56,12 @@ void otg_phy_init(struct dwc2_udc *dev)
 	else /* C110 GONI */
 		clrbits_le32(&phy->phypwr, OTG_DISABLE_0 | ANALOG_PWRDOWN | FORCE_SUSPEND_0);
 
+#if defined(CONFIG_ARCH_EXYNOS) || defined(CONFIG_ARCH_S5PC1XX)
 	if (s5p_cpu_id == 0x4412)
 		clrsetbits_le32(&phy->phyclk, EXYNOS4X12_ID_PULLUP0 | EXYNOS4X12_COMMON_ON_N0,
 				EXYNOS4X12_CLK_SEL_24MHZ); /* PLL 24Mhz */
 	else
+#endif
 		clrsetbits_le32(&phy->phyclk, ID_PULLUP0 | COMMON_ON_N0,
 				CLK_SEL_24MHZ); /* PLL 24Mhz */
 
-- 
2.52.0


