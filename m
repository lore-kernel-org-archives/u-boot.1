Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF1DE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 13:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7391C8059C;
	Sat,  4 Jan 2025 14:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="jFuct0S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07358034E; Sat,  4 Jan 2025 04:38:27 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1A280079
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1735961901; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Kj9WjRjc0rVreEPnOj1rFmkSwUk8+v5nLkI3ZiVQws5QFmiKwCdN0r0wHKacr1R4FIu2VNJ8H10UimkCFfqLjmJ8jKuAxvqWYLE41JvsAl+Th9EBJN7jn/C80qPN/K2eMW3hw9DRUjy0EQoIKrK82kSQUmj+ZdaEKyOP/ApQLfw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1735961901;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zn65bY774IN8yz3rSWRUgdYKfQRl17QCH7JqbntqVtw=; 
 b=BVPMI8j9xcMzzCYiXbPx4EfE+kQMhp5b5hRUAOgsps+qTlFZudAVl13s5Izst2Oo9HDMw1hJy0KgcFfqjhxp6p+cISLadD9Fpon6kEcIAhlMCnuYDJqGwSaK/D5E0asjC0rcBF37+44BDV0dvRh4+NC3dappU3sp0EW4cn9dxHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735961901; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=zn65bY774IN8yz3rSWRUgdYKfQRl17QCH7JqbntqVtw=;
 b=jFuct0S6+UoIIClI1k7bXJXtXkspooUk4JUZBzHzlnYRNGdJY8HhIqagDazn+QN0
 fsZz8DhParkhW2NoOoWvcHJdqOAeNqhhjcbVnJD1Ei3+L0WG/7A9pL//t99TeAFjNUi
 9w6oiek4pTBLZ2khheD5LONzFeMIFyA/qjbTN/0g=
Received: by mx.zohomail.com with SMTPS id 1735961899480143.21309730943074;
 Fri, 3 Jan 2025 19:38:19 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 04 Jan 2025 11:37:16 +0800
Subject: [PATCH v3 2/8] usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-dwc2-dev-v3-2-d4b2bc1996e4@pigmoral.tech>
References: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
In-Reply-To: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com, 
 junhui.liu@pigmoral.tech
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735961880; l=2184;
 i=junhui.liu@pigmoral.tech; s=20250103; h=from:subject:message-id;
 bh=ygkZw4WdoytZvn3WcXQVJsp0wqb0zX0Yx2atdkXrN2c=;
 b=dGynFz7WLM9XosgkMYzHAqrBH2vpzcX67NVzrhw8D85FXW1F/qHjVofB6q+9n3v4JJugb1l8J
 HWPdSfFXeycDqeYXtxfWTLt082ozVk0FfAsGRdVUlQZopMU5jeBSRYg
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=wBBo5nYsVNm/3oBEpRGTEbyW0tknGZANOEVccmcXtOw=
X-ZohoMailClient: External
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:18:05 +0100
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

The ULPI_UTMI_SEL bit in the DWC2 driver was set incorrectly. According
to the datasheet [1], this bit should be set to 0 for UTMI interface and 1
for ULPI interface. The existing code had this logic reversed,
causing the interface selection to be incorrect.

This commit corrects the ULPI_UTMI_SEL bit setting to match the
datasheet's description. Referencing the kernel's code [2] also confirms
this fix.

[1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=30
[2] https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/usb/dwc2/core.c#L1106

Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/usb/host/dwc2.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index b6c8b3d5a6bdf375f1adeb106d4832d92307f0db..609de18faa3abc5f4ecb0c23cf3590966bad7992 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -402,20 +402,22 @@ static void dwc_otg_core_init(struct udevice *dev)
 	 * soft reset so only program the first time. Do a soft reset
 	 * immediately after setting phyif.
 	 */
-	usbcfg &= ~(DWC2_GUSBCFG_ULPI_UTMI_SEL | DWC2_GUSBCFG_PHYIF);
-	usbcfg |= DWC2_PHY_TYPE << DWC2_GUSBCFG_ULPI_UTMI_SEL_OFFSET;
-
-	if (usbcfg & DWC2_GUSBCFG_ULPI_UTMI_SEL) {	/* ULPI interface */
+#if (DWC2_PHY_TYPE == DWC2_PHY_TYPE_ULPI)
+	usbcfg |= DWC2_GUSBCFG_ULPI_UTMI_SEL;
+	usbcfg &= ~DWC2_GUSBCFG_PHYIF;
 #ifdef DWC2_PHY_ULPI_DDR
-		usbcfg |= DWC2_GUSBCFG_DDRSEL;
+	usbcfg |= DWC2_GUSBCFG_DDRSEL;
 #else
-		usbcfg &= ~DWC2_GUSBCFG_DDRSEL;
-#endif
-	} else {	/* UTMI+ interface */
+	usbcfg &= ~DWC2_GUSBCFG_DDRSEL;
+#endif /* DWC2_PHY_ULPI_DDR */
+#elif (DWC2_PHY_TYPE == DWC2_PHY_TYPE_UTMI)
+	usbcfg &= ~DWC2_GUSBCFG_ULPI_UTMI_SEL;
 #if (DWC2_UTMI_WIDTH == 16)
-		usbcfg |= DWC2_GUSBCFG_PHYIF;
-#endif
-	}
+	usbcfg |= DWC2_GUSBCFG_PHYIF;
+#else
+	usbcfg &= ~DWC2_GUSBCFG_PHYIF;
+#endif /* DWC2_UTMI_WIDTH */
+#endif /* DWC2_PHY_TYPE */
 
 	writel(usbcfg, &regs->global_regs.gusbcfg);
 

-- 
2.47.1

