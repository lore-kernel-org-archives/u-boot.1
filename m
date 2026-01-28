Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC46CD46C0F
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 00:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B044283CDF;
	Thu, 29 Jan 2026 01:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B9E83C29; Thu, 29 Jan 2026 00:59:57 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C272083BC7
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 00:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 135461F80051
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 23:59:54 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 832C7B1D48B; Wed, 28 Jan 2026 23:59:53 +0000 (UTC)
Received: from shepard (unknown [192.168.1.65])
 by laika.paulk.fr (Postfix) with ESMTP id 51853B1D482;
 Wed, 28 Jan 2026 23:58:42 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH v2 2/3] sunxi: a133: dram: Fix PHY dx delays offsets and add
 dmb
Date: Thu, 29 Jan 2026 00:57:16 +0100
Message-ID: <20260128235727.1322861-2-contact@paulk.fr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128235727.1322861-1-contact@paulk.fr>
References: <20260128235727.1322861-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Jan 2026 01:07:58 +0100
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

From: Paul Kocialkowski <paulk@sys-base.io>

Some of the offsets for the DRAM PHY dx delays are wrong (as compared
to the H616 code and the reference binary) since the
mctl_phy_dx_delay0_inner function does not perform the correct
calculation for some of them.

Introduce a mctl_phy_dx_delay0_inner0 to fix the incorrect offsets and
rename the existing function to mctl_phy_dx_delay0_inner1 for the
offsets it correctly handles.

Also add memory barriers that are also present in the H616 code while
at it.

This fixes detection of 4 GiB DRAM on some boards using LPDDR4.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>
---
 arch/arm/mach-sunxi/dram_sun50i_a133.c | 61 +++++++++++++++++---------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi/dram_sun50i_a133.c
index 204810aecf2a..568dc1eea2ea 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
@@ -931,7 +931,24 @@ static inline void mctl_phy_dx_delay1_inner(u32 *base, u32 val1, u32 val2)
 	writel_relaxed(val2, ptr + 48);
 }
 
-static inline void mctl_phy_dx_delay0_inner(u32 *base1, u32 *base2, u32 val1,
+static inline void mctl_phy_dx_delay0_inner0(u32 *base1, u32 *base2, u32 val1,
+					    u32 val2)
+{
+	u32 *ptr = base1;
+
+	for (int i = 0; i < 9; i++) {
+		writel_relaxed(val1, ptr);
+		writel_relaxed(val1, ptr + 0x30);
+		ptr += 2;
+	}
+
+	writel_relaxed(val2, base2);
+	writel_relaxed(val2, base2 + 48);
+	writel_relaxed(val2, ptr);
+	writel_relaxed(val2, base2 + 24);
+}
+
+static inline void mctl_phy_dx_delay0_inner1(u32 *base1, u32 *base2, u32 val1,
 					    u32 val2)
 {
 	u32 *ptr = base1;
@@ -975,6 +992,8 @@ static void mctl_phy_dx_delay_compensation(const struct dram_para *para)
 					 (para->tpr11 >> 24) & 0x3f,
 					 (para->para0 >> 24) & 0x3f);
 
+		dmb();
+
 		setbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 1);
 	}
 
@@ -982,25 +1001,27 @@ static void mctl_phy_dx_delay_compensation(const struct dram_para *para)
 		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, BIT(7));
 		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x190, BIT(2));
 
-		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x480),
-					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x528),
-					 para->tpr12 & 0x3f,
-					 para->tpr14 & 0x3f);
-
-		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x4d4),
-					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x52c),
-					 (para->tpr12 >> 8) & 0x3f,
-					 (para->tpr14 >> 8) & 0x3f);
-
-		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x600),
-					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6a8),
-					 (para->tpr12 >> 16) & 0x3f,
-					 (para->tpr14 >> 16) & 0x3f);
-
-		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6ac),
-					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x528),
-					 (para->tpr12 >> 24) & 0x3f,
-					 (para->tpr14 >> 24) & 0x3f);
+		mctl_phy_dx_delay0_inner0((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x480),
+					  (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x528),
+					  para->tpr12 & 0x3f,
+					  para->tpr14 & 0x3f);
+
+		mctl_phy_dx_delay0_inner1((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x4d4),
+					  (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x52c),
+					  (para->tpr12 >> 8) & 0x3f,
+					  (para->tpr14 >> 8) & 0x3f);
+
+		mctl_phy_dx_delay0_inner0((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x600),
+					  (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6a8),
+					  (para->tpr12 >> 16) & 0x3f,
+					  (para->tpr14 >> 16) & 0x3f);
+
+		mctl_phy_dx_delay0_inner1((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x654),
+					  (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6ac),
+					  (para->tpr12 >> 24) & 0x3f,
+					  (para->tpr14 >> 24) & 0x3f);
+
+		dmb();
 
 		setbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, BIT(7));
 	}
-- 
2.52.0

