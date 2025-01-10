Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F18E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 16:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D618067D;
	Fri, 10 Jan 2025 17:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="GKfXU8Ko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20392800D0; Fri, 10 Jan 2025 14:56:46 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1B5801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736517398; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Gf27Z1lrdbHR9ZLxfXnwGs+q8LFp5eHzvGwmcKJByZYEa2iEiWlytI8T/3yacg7Grm6PpvlDv200X7/YUqQHKH8ILSLq4tl3OROQ431ALtyiDRs9lrJNmwDmySJYl57MZiIUzkhhSVXsDUmW+YvIHy5mZQqDNA3Qs0ZGmxZd79k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736517398;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uYKee8SkSTQyBqNtqSmryg4pXLygJH5SbDMCHow9dBo=; 
 b=eqPHVTDc4wmC1Gno5kmCwlSYKXQlq3WpAoCdSfxXXw++mDdBloUQQIdQbmhegMm86ON52m+ynqIUQniSUeIIJQeYebPpgqiDflZS2HlKRZadDILrmJdr22WJ0RLnhMrCDzRJsa+be8LDpUQbXo0VUyJblMVW+jBXHjWdvsaLXGw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736517398; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=uYKee8SkSTQyBqNtqSmryg4pXLygJH5SbDMCHow9dBo=;
 b=GKfXU8KoDCoFzQo/16brXpQrzK1kJsiaGw7cj68j9dlcPCC6Ua3St/Lqg//fU16/
 S8ZS81jGBeckWFUT3Z1/6iKQhs3c2mIiP+7p7bAoLBkCVheAQt67Rb43G1FTlf5CQxa
 jX4KEBJ9XmPgAc+R0GD/HJEkGtWePyT7gbO3iaxw=
Received: by mx.zohomail.com with SMTPS id 1736517396339599.7887157381703;
 Fri, 10 Jan 2025 05:56:36 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 10 Jan 2025 21:55:21 +0800
Subject: [PATCH v4 2/8] usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-dwc2-dev-v4-2-987f4fd6f8b2@pigmoral.tech>
References: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
In-Reply-To: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com, 
 junhui.liu@pigmoral.tech
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736517373; l=2246;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=PML9HqSDdYQfcc6LkckpVaLMVPsalmztTcSpuEdGdiI=;
 b=S4Nc2wjBXZbE07wPtTOErF51xnsjh4eKRcB6SyhAPcVYq7pMedLKJdw8z8tC6NnUApyoM/dS8
 w0XevXqkLkGCTweqR/7b7HIvGcV9kiQAd7YSWNicqL4taRtjcBryXfw
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 10 Jan 2025 17:13:21 +0100
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

