Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1AED46C15
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 00:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0778883D7A;
	Thu, 29 Jan 2026 01:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2F483C29; Thu, 29 Jan 2026 01:00:25 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AF783BC7
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 01:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id CA4711F80057
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 00:00:22 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 5609AB1D48B; Thu, 29 Jan 2026 00:00:22 +0000 (UTC)
Received: from shepard (unknown [192.168.1.65])
 by laika.paulk.fr (Postfix) with ESMTP id 3821AB1D484;
 Wed, 28 Jan 2026 23:58:43 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 3/3] sunxi: a133: dram: Align parameters terminology with
 Allwinner
Date: Thu, 29 Jan 2026 00:57:17 +0100
Message-ID: <20260128235727.1322861-3-contact@paulk.fr>
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

There is a mistmatch between Allwinner's dram_para BSP definitions and the
parameters names in mainline u-boot for TPR1-3. What we call TPR1 is actually
MR22 while TPR2 is TPR0 and TPR3 is TPR1. MR22 does get written to the
corresponding register. This only concerns LPDDR4 support.

Introduce a new Kconfig entry for MR22 and proceed with the rename.
Update the only config currently using it.

See the list of parameters from the Allwinner BSP at the end of:
https://linux-sunxi.org/A133/DRAMC

Note that the H616/H6 code is coherent with this new TPR0 definition
(and does not use TPR1 and MR22).

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>
---
 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h |  2 ++
 arch/arm/mach-sunxi/Kconfig                        |  7 +++++++
 arch/arm/mach-sunxi/dram_sun50i_a133.c             | 12 ++++++------
 configs/liontron-h-a133l_defconfig                 |  6 +++---
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
index eadec74cc2b6..da3ee5fa0161 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
@@ -241,6 +241,8 @@ struct dram_para {
 	uint32_t mr12;
 	uint32_t mr13;
 	uint32_t mr14;
+	uint32_t mr22;
+	uint32_t tpr0;
 	uint32_t tpr1;
 	uint32_t tpr2;
 	uint32_t tpr3;
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2ccb..70885c1c78bc 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -118,6 +118,13 @@ config DRAM_SUNXI_MR14
 	help
 	  MR14 value from vendor DRAM settings.
 
+config DRAM_SUNXI_MR22
+	hex "DRAM MR22 parameter"
+	depends on DRAM_SUN50I_A133
+	default 0x0
+	help
+	  MR22 value from vendor DRAM settings.
+
 config DRAM_SUNXI_TPR0
 	hex "DRAM TPR0 parameter"
 	default 0x0
diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi/dram_sun50i_a133.c
index 568dc1eea2ea..c4022b76fcb4 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
@@ -486,8 +486,8 @@ static void mctl_drive_odt_config(const struct dram_para *para)
 
 		writel_relaxed(val, base);
 		if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
-			if (para->tpr3 & 0x1f1f1f1f)
-				val = (para->tpr3 >> (i * 8)) & 0x1f;
+			if (para->tpr1 & 0x1f1f1f1f)
+				val = (para->tpr1 >> (i * 8)) & 0x1f;
 			else
 				val = 4;
 		}
@@ -528,7 +528,7 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para)
 	u32 *ptr;
 
 	if (para->tpr10 & BIT(31)) {
-		val = para->tpr2;
+		val = para->tpr0;
 	} else {
 		val = ((para->tpr10 << 1) & 0x1e) |
 		      ((para->tpr10 << 5) & 0x1e00) |
@@ -841,7 +841,7 @@ static void mctl_dfi_init(const struct dram_para *para)
 		mctl_mr_write_lpddr4(12, para->mr12);
 		mctl_mr_write_lpddr4(13, para->mr13);
 		mctl_mr_write_lpddr4(14, para->mr14);
-		mctl_mr_write_lpddr4(22, para->tpr1);
+		mctl_mr_write_lpddr4(22, para->mr22);
 		break;
 	}
 
@@ -1242,7 +1242,6 @@ static const struct dram_para para = {
 #elif defined(CONFIG_SUNXI_DRAM_LPDDR4)
 	.type = SUNXI_DRAM_TYPE_LPDDR4,
 #endif
-	/* TODO: Populate from config */
 	.dx_odt = CONFIG_DRAM_SUNXI_DX_ODT,
 	.dx_dri = CONFIG_DRAM_SUNXI_DX_DRI,
 	.ca_dri = CONFIG_DRAM_SUNXI_CA_DRI,
@@ -1251,9 +1250,10 @@ static const struct dram_para para = {
 	.mr12 = CONFIG_DRAM_SUNXI_MR12,
 	.mr13 = CONFIG_DRAM_SUNXI_MR13,
 	.mr14 = CONFIG_DRAM_SUNXI_MR14,
+	.mr22 = CONFIG_DRAM_SUNXI_MR22,
+	.tpr0 = CONFIG_DRAM_SUNXI_TPR0,
 	.tpr1 = CONFIG_DRAM_SUNXI_TPR1,
 	.tpr2 = CONFIG_DRAM_SUNXI_TPR2,
-	.tpr3 = CONFIG_DRAM_SUNXI_TPR3,
 	.tpr6 = CONFIG_DRAM_SUNXI_TPR6,
 	.tpr10 = CONFIG_DRAM_SUNXI_TPR10,
 	.tpr11 = CONFIG_DRAM_SUNXI_TPR11,
diff --git a/configs/liontron-h-a133l_defconfig b/configs/liontron-h-a133l_defconfig
index 56c5262f2678..831d5b56e3a7 100644
--- a/configs/liontron-h-a133l_defconfig
+++ b/configs/liontron-h-a133l_defconfig
@@ -10,9 +10,9 @@ CONFIG_DRAM_SUNXI_PARA0=0xd0a050c
 CONFIG_DRAM_SUNXI_MR11=0x4
 CONFIG_DRAM_SUNXI_MR12=0x72
 CONFIG_DRAM_SUNXI_MR14=0x7
-CONFIG_DRAM_SUNXI_TPR1=0x26
-CONFIG_DRAM_SUNXI_TPR2=0x6060606
-CONFIG_DRAM_SUNXI_TPR3=0x84040404
+CONFIG_DRAM_SUNXI_MR22=0x26
+CONFIG_DRAM_SUNXI_TPR0=0x6060606
+CONFIG_DRAM_SUNXI_TPR1=0x84040404
 CONFIG_DRAM_SUNXI_TPR6=0x48000000
 CONFIG_DRAM_SUNXI_TPR10=0x273333
 CONFIG_DRAM_SUNXI_TPR11=0x231d151c
-- 
2.52.0

