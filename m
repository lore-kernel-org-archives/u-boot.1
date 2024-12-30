Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C88E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 14:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1828066C;
	Mon, 30 Dec 2024 15:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ceW0uLIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA618805ED; Mon, 30 Dec 2024 04:30:55 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6316E805C1
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 04:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+liujh2818.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8D8985C4CC8;
 Mon, 30 Dec 2024 03:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2418C4CEDC;
 Mon, 30 Dec 2024 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735529449;
 bh=U1YBT162/AdI8Hj9OH/q1J8rkj22PoKbcxvY7jdMFcQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ceW0uLIjpx063vHL9gHrFFGQppTMRT+dcFTSCTGcW0PvnpKjmbCDRyFVXyOZese5n
 VZUiJZzXcqpvX+axDEF6x8JF1a8o8nLaRG5OgizJo9uN3IFYMoaAHChKCA3e/odUID
 OdoRyzH0gSHXy9kvi7qSpVVg782/4AJVGwurAkT4oH44f9OpEbbo8aidb3y8WIFkbK
 y8/9nm1hv2jBGD+JJTY8PE1WtHctKUylg6wvouGqv08TYvZP7nmvj63r0bHzlYMNbC
 nHL3kropEkFB9qNOc5ZnwAyrfT8azb/o0VBV5Qap5ry4hM/ZG18i4jF58tfhH8okaB
 D/aN+H1Ip8Z/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B2DD6E77194;
 Mon, 30 Dec 2024 03:30:49 +0000 (UTC)
From: Junhui Liu via B4 Relay <devnull+liujh2818.outlook.com@kernel.org>
Date: Mon, 30 Dec 2024 11:30:17 +0800
Subject: [PATCH v2 2/8] usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-dwc2-dev-v2-2-12cd9b8a2358@outlook.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
In-Reply-To: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Junhui Liu <liujh2818@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735529447; l=2089;
 i=liujh2818@outlook.com; s=20241030; h=from:subject:message-id;
 bh=pqswinryaJy2ie7uN2T0/IbhADb0q8MTVMTB7VwmJqc=;
 b=F23W/kJR3CtCW1wzTFnnZmX8y5CS5SK5SIFr77ZgYBvNj7PI7eTH6shCpJVOUl36DGBhGkAdN
 dMmvkT4gfkPD83NB+qfu8iEDCKeem1nIn2uLJ8Bf2tUY68wTZBYmKG8
X-Developer-Key: i=liujh2818@outlook.com; a=ed25519;
 pk=ApYwI6KD3EjynMw61RqGa6c5BGbStQnKSrbNN+aQqT4=
X-Endpoint-Received: by B4 Relay for liujh2818@outlook.com/20241030 with
 auth_id=259
X-Original-From: Junhui Liu <liujh2818@outlook.com>
X-Mailman-Approved-At: Mon, 30 Dec 2024 15:35:32 +0100
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
Reply-To: liujh2818@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Junhui Liu <liujh2818@outlook.com>

The ULPI_UTMI_SEL bit in the DWC2 driver was set incorrectly. According
to the datasheet [1], this bit should be set to 0 for UTMI interface and 1
for ULPI interface. The existing code had this logic reversed,
causing the interface selection to be incorrect.

This commit corrects the ULPI_UTMI_SEL bit setting to match the
datasheet's description. Referencing the kernel's code [2] also confirms
this fix.

[1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=30
[2] https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/usb/dwc2/core.c#L1106

Signed-off-by: Junhui Liu <liujh2818@outlook.com>
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
2.39.2


