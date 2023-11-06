Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80562C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2B986EB5;
	Mon,  6 Nov 2023 03:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F31486E7E; Mon,  6 Nov 2023 03:00:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CF1DB86ADC
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96222C15;
 Sun,  5 Nov 2023 18:01:25 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C7C3F703;
 Sun,  5 Nov 2023 18:00:40 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: h616: (really) lower SPL stack address to avoid BROM
 data
Date: Mon,  6 Nov 2023 01:59:30 +0000
Message-Id: <20231106015930.30439-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

When using the USB OTG FEL mode on the Allwinner H616, the BootROM
stores some data at the end of SRAM C. This is also the location where
we place the initial SPL stack, so it will overwrite this data.
We still need the BROM code after running the SPL, so should leave that
area alone.
Interestingly this does not seem to have an adverse effect, I guess on
the "way out" (when we return to FEL after the SPL has run), this data
is not needed by the BROM, for just the trailing end of the USB operation.
However this is still wrong, and we should not clobber BROM data.

Lower the SPL stack address to be situated right below the swap buffers
we use in sunxi-fel: that should be out of the way of everyone else.

This obsoletes a previous commit (eb53e7743c8f) with the same name:
that one was changing the address in an *unused* macro in sunxi_common.h,
so the previous patch didn't have any effect at all.

Fixes: eb53e7743c8f ("sunxi: h616: lower SPL stack address to avoid BROM data")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

sorry for the blunder with that previous patch!
This issue came up when cleaning up some SPL code: LOW_LEVEL_SRAM_STACK,
as changed in the previous patch, is not used anywhere. I have a patch to
remove that whole section from sunxi-common.h, and will send that as part
of some bigger SPL clean-up series later.

Cheers,
Andre

 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 25cd18afda7..c521b02f4a3 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -370,7 +370,7 @@ config SPL_STACK
 	default 0x93ffb8 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x91ffb8 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x118000 if MACH_SUN50I_H6
-	default 0x58000 if MACH_SUN50I_H616
+	default 0x52a00 if MACH_SUN50I_H616
 	default 0x40000 if MACH_SUN8I_R528
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
-- 
2.35.8

