Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CD7CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090A78657B;
	Sun, 15 Oct 2023 08:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EE486529; Sun, 15 Oct 2023 08:04:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4777586E22
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E39D2F4;
 Sat, 14 Oct 2023 10:04:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AA83F5A1;
 Sat, 14 Oct 2023 10:03:44 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH] sunxi: H616: DRAM: refactor mctl_phy_configure_odt()
Date: Sat, 14 Oct 2023 18:02:36 +0100
Message-Id: <20231014170236.16211-1-andre.przywara@arm.com>
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

The original H616 DDR3 ODT configuration code wrote board specific values
into a sequence of paired registers.
For LPDDR3 support we needed to special-case one group of registers,
because for that DRAM type we need to write 0 into the lower register of
each pair. That already made the code less readable.

LPDDR4 support will make things even messier, so let's refactor that
code now: We allow to write different values into the lower and upper
half of each pair. The masking is moved into a macro, and used in each
write statement.

The effect is not as obvious yet, as we don't need the full flexibility at
the moment, but the motivation will become clearer with LPDDR4 support.

The generated binary is identical with and without the patch.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 84 ++++++++++----------------
 1 file changed, 31 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 7e580b62dca..ba5659d4094 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -241,61 +241,39 @@ static const u8 phy_init[] = {
 #endif
 };
 
+#define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
 static void mctl_phy_configure_odt(const struct dram_para *para)
 {
-	unsigned int val;
-
-	val = para->dx_dri & 0x1f;
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x388);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x38c);
-
-	val = (para->dx_dri >> 8) & 0x1f;
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3c8);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3cc);
-
-	val = (para->dx_dri >> 16) & 0x1f;
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x408);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x40c);
-
-	val = (para->dx_dri >> 24) & 0x1f;
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x448);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x44c);
-
-	val = para->ca_dri & 0x1f;
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x340);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x344);
-
-	val = (para->ca_dri >> 8) & 0x1f;
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x348);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x34c);
-
-	val = para->dx_odt & 0x1f;
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
-		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x380);
-	else
-		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x380);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x384);
-
-	val = (para->dx_odt >> 8) & 0x1f;
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
-		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x3c0);
-	else
-		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3c0);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3c4);
-
-	val = (para->dx_odt >> 16) & 0x1f;
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
-		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x400);
-	else
-		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x400);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x404);
-
-	val = (para->dx_odt >> 24) & 0x1f;
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
-		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x440);
-	else
-		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x440);
-	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x444);
+	uint32_t val_lo, val_hi;
+
+	val_lo = para->dx_dri;
+	val_hi = para->dx_dri;
+	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x388);
+	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x38c);
+	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c8);
+	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x3cc);
+	writel_relaxed(MASK_BYTE(val_lo, 2), SUNXI_DRAM_PHY0_BASE + 0x408);
+	writel_relaxed(MASK_BYTE(val_hi, 2), SUNXI_DRAM_PHY0_BASE + 0x40c);
+	writel_relaxed(MASK_BYTE(val_lo, 3), SUNXI_DRAM_PHY0_BASE + 0x448);
+	writel_relaxed(MASK_BYTE(val_hi, 3), SUNXI_DRAM_PHY0_BASE + 0x44c);
+
+	val_lo = para->ca_dri;
+	val_hi = para->ca_dri;
+	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x340);
+	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x344);
+	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x348);
+	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x34c);
+
+	val_lo = (para->type == SUNXI_DRAM_TYPE_LPDDR3) ? 0 : para->dx_odt;
+	val_hi = para->dx_odt;
+	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x380);
+	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x384);
+	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c0);
+	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x3c4);
+	writel_relaxed(MASK_BYTE(val_lo, 2), SUNXI_DRAM_PHY0_BASE + 0x400);
+	writel_relaxed(MASK_BYTE(val_hi, 2), SUNXI_DRAM_PHY0_BASE + 0x404);
+	writel_relaxed(MASK_BYTE(val_lo, 3), SUNXI_DRAM_PHY0_BASE + 0x440);
+	writel_relaxed(MASK_BYTE(val_hi, 3), SUNXI_DRAM_PHY0_BASE + 0x444);
 
 	dmb();
 }
-- 
2.35.8

