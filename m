Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B4CE6F060
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE0588C05;
	Fri,  1 Nov 2024 15:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F29888C4D; Fri,  1 Nov 2024 15:20:28 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 34832889A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,250,1725289200"; d="scan'208";a="227647565"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 01 Nov 2024 23:20:24 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.230])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4FAEB4006193;
 Fri,  1 Nov 2024 23:20:22 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH] arm: renesas: Fix RZ/G2L GICR base address
Date: Fri,  1 Nov 2024 14:20:16 +0000
Message-Id: <20241101142016.77-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
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

When support for the Renesas RZ/G2L SoC was added, the GICR base address
for CPU1 was accidentally used. We should instead supply the GICR base
address for CPU0 so that interrupts are correctly configured for the
CPU core that U-Boot is actually using.

Fixes: 387d4275ab0e ("arm: rmobile: Add basic RZ/G2L family support")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/mach-renesas/include/mach/rzg2l.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-renesas/include/mach/rzg2l.h b/arch/arm/mach-renesas/include/mach/rzg2l.h
index 057df5cb9d46..c49a71a6dd41 100644
--- a/arch/arm/mach-renesas/include/mach/rzg2l.h
+++ b/arch/arm/mach-renesas/include/mach/rzg2l.h
@@ -8,6 +8,6 @@
 #define __ASM_ARCH_RZG2L_H
 
 #define GICD_BASE	0x11900000
-#define GICR_BASE	0x11960000
+#define GICR_BASE	0x11940000
 
 #endif /* __ASM_ARCH_RZG2L_H */
-- 
2.43.0

