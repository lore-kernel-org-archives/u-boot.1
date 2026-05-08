Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FB3CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7946684ACF;
	Fri,  8 May 2026 14:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ccIPxV1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041E384B92; Fri,  8 May 2026 09:11:55 +0200 (CEST)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C63C84AF6
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 09:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=codeconstruct.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jk@codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1778224305;
 bh=flS/OpZCBBRU4M36RU+nGsIWRI71FzAurPuk6bbR5gw=;
 h=From:Date:Subject:To:Cc;
 b=ccIPxV1K6PdF1vSb2pxw37qk8Kr0EN8xY2i5ReOb8Xpo/PYU3+Np5Pm2QQGu0CH25
 h2EardhEKUiWJqxQvUt9UUF97jFSLZiBk7bkEU6OTe46uZEjbv4920ls84hpa2CfAd
 x3jisYFnHwxK4xdBJaWi+ZthgkDCp7IdiUTFi/lVZbN97HLbyJUI4nSqAYTMC3tVAv
 cb+Sg4wxQmTAT8uqLCV3KKq1LvJItuDTTfj0T1b5dBQVMPYuofrA4LHns0t08K6oXY
 5j4TEpaBiFml+FxIUmCEiYpoGlWrcKAeS1NYvOMeYkobftcaFTjrRi4sb8VfDgRUFM
 WGLJx0QCcwyHw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
 id F339A60417; Fri,  8 May 2026 15:11:45 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 08 May 2026 15:11:32 +0800
Subject: [PATCH] am33xx: don't assume we have a UCLASS_MISC device present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-dev-am33xx-v1-1-7ec76860021c@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAKOM/WkC/yXMywqAIBBA0V+JWSdMDyP6lWhhOdYEPdAKIfz3r
 JZnce8NjiyTgya5wdLFjrc1IksTGCa1jiRYR0OOeYUSa6HpEmopCu9FRdJgiVqhrCEGuyXD/pu
 13W939jMNx3uAEB4PsGaHbgAAAA==
X-Change-ID: 20260508-dev-am33xx-6e5f040da058
To: Mugunthan V N <mugunthanvnm@ti.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.16-dev
X-Mailman-Approved-At: Fri, 08 May 2026 14:28:05 +0200
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

Boot on am33xx without CONFIG_USB will currently fail, as we error-out
of arch_misc_init() if no UCLASS_MISC device is found. This requirement
was introduced in commit 3aec2648698d ("am33xx: board: probe misc
drivers to register musb devices").

Instead, only attempt the UCLASS_MISC init if we would expect the MUSB
TI device to be present. Add a comment to explain why we're doing the
device lookup (which we immediately discard).

Fixes: 3aec2648698d ("am33xx: board: probe misc drivers to register musb devices")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
I'm not sure whether the CONFIG_ conditional is appropriate here, or
whether there's a better way to handle the UCLASS_MISC probe for the
MUSB init; we could potentially just ignore errors from the probe, but I
assume that's intentional as-is.

The new comment is mostly from the original commit; I am definitely open
to any better wording if needed.
---
 arch/arm/mach-omap2/am33xx/board.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3..0261606089e 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,9 +266,15 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_MISC, &dev);
-	if (ret)
-		return ret;
+	/*
+	 * The MUSB wrapper driver is bound as a MISC device, so probe here
+	 * to register the musb device early.
+	 */
+	if (IS_ENABLED(CONFIG_USB_MUSB_TI)) {
+		ret = uclass_first_device_err(UCLASS_MISC, &dev);
+		if (ret)
+			return ret;
+	}
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
 	usb_ether_init();

---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
change-id: 20260508-dev-am33xx-6e5f040da058

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>

