Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F3CC001DF
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 01:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8B087562;
	Sat, 21 Oct 2023 03:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B791C874CA; Sat, 21 Oct 2023 03:11:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1AC5687537
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 03:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 774D91595;
 Fri, 20 Oct 2023 18:12:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97DF53F64C;
 Fri, 20 Oct 2023 18:11:33 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 2/4] sunxi: DRAM: H6: const-ify DRAM function parameters
Date: Sat, 21 Oct 2023 02:10:23 +0100
Message-Id: <20231021011025.568-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231021011025.568-1-andre.przywara@arm.com>
References: <20231021011025.568-1-andre.przywara@arm.com>
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

There are quite some functions in the Allwinner H6 DRAM "driver", some
of them actually change the parameters in the structure passed to them,
but many are actually not.

To increase the optimisation potential for the code, mark those functions
that just read members of the passed dram_para struct as "const".
Use the opportunity to avoid the forward declarations by moving the
mctl_core_init() function.

This in itself does not decrease the code size, but lays the groundwork
for future changes doing so.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h6.h   |  6 +--
 arch/arm/mach-sunxi/dram_sun50i_h6.c          | 48 +++++++++----------
 .../mach-sunxi/dram_timings/h6_ddr3_1333.c    |  2 +-
 arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c  |  2 +-
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
index be02655cdd5..a7c6435220f 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
@@ -313,8 +313,8 @@ check_member(sunxi_mctl_phy_reg, dx[3].reserved_0xf0, 0xaf0);
  */
 #define RD_LINES_PER_BYTE_LANE	(BITS_PER_BYTE + 6)
 struct dram_para {
-	u32 clk;
-	enum sunxi_dram_type type;
+	const u32 clk;
+	const enum sunxi_dram_type type;
 	u8 cols;
 	u8 rows;
 	u8 ranks;
@@ -331,6 +331,6 @@ static inline int ns_to_t(int nanoseconds)
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
-void mctl_set_timing_params(struct dram_para *para);
+void mctl_set_timing_params(const struct dram_para *para);
 
 #endif /* _SUNXI_DRAM_SUN50I_H6_H */
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index 43a2d19f084..1187f1960a0 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -36,25 +36,6 @@
  * similar PHY is ZynqMP.
  */
 
-static void mctl_sys_init(struct dram_para *para);
-static void mctl_com_init(struct dram_para *para);
-static bool mctl_channel_init(struct dram_para *para);
-
-static bool mctl_core_init(struct dram_para *para)
-{
-	mctl_sys_init(para);
-	mctl_com_init(para);
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_LPDDR3:
-	case SUNXI_DRAM_TYPE_DDR3:
-		mctl_set_timing_params(para);
-		break;
-	default:
-		panic("Unsupported DRAM type!");
-	};
-	return mctl_channel_init(para);
-}
-
 /* PHY initialisation */
 static void mctl_phy_pir_init(u32 val)
 {
@@ -152,7 +133,7 @@ static void mctl_set_master_priority(void)
 	MBUS_CONF(HDCP2,  true,    HIGH, 2,  100,   64,   32);
 }
 
-static void mctl_sys_init(struct dram_para *para)
+static void mctl_sys_init(u32 clk_rate)
 {
 	struct sunxi_ccm_reg * const ccm =
 			(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
@@ -173,7 +154,7 @@ static void mctl_sys_init(struct dram_para *para)
 
 	/* Set PLL5 rate to doubled DRAM clock rate */
 	writel(CCM_PLL5_CTRL_EN | CCM_PLL5_LOCK_EN |
-	       CCM_PLL5_CTRL_N(para->clk * 2 / 24), &ccm->pll5_cfg);
+	       CCM_PLL5_CTRL_N(clk_rate * 2 / 24), &ccm->pll5_cfg);
 	mctl_await_completion(&ccm->pll5_cfg, CCM_PLL5_LOCK, CCM_PLL5_LOCK);
 
 	/* Configure DRAM mod clock */
@@ -198,7 +179,7 @@ static void mctl_sys_init(struct dram_para *para)
 	writel(0x8000, &mctl_ctl->unk_0x00c);
 }
 
-static void mctl_set_addrmap(struct dram_para *para)
+static void mctl_set_addrmap(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
@@ -284,7 +265,7 @@ static void mctl_set_addrmap(struct dram_para *para)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
-static void mctl_com_init(struct dram_para *para)
+static void mctl_com_init(const struct dram_para *para)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
@@ -354,7 +335,7 @@ static void mctl_com_init(struct dram_para *para)
 	}
 }
 
-static void mctl_bit_delay_set(struct dram_para *para)
+static void mctl_bit_delay_set(const struct dram_para *para)
 {
 	struct sunxi_mctl_phy_reg * const mctl_phy =
 			(struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BASE;
@@ -413,7 +394,7 @@ static void mctl_bit_delay_set(struct dram_para *para)
 	}
 }
 
-static bool mctl_channel_init(struct dram_para *para)
+static bool mctl_channel_init(const struct dram_para *para)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
@@ -563,6 +544,21 @@ static bool mctl_channel_init(struct dram_para *para)
 	return true;
 }
 
+static bool mctl_core_init(const struct dram_para *para)
+{
+	mctl_sys_init(para->clk);
+	mctl_com_init(para);
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_LPDDR3:
+	case SUNXI_DRAM_TYPE_DDR3:
+		mctl_set_timing_params(para);
+		break;
+	default:
+		panic("Unsupported DRAM type!");
+	};
+	return mctl_channel_init(para);
+}
+
 static void mctl_auto_detect_rank_width(struct dram_para *para)
 {
 	/* this is minimum size that it's supported */
@@ -637,7 +633,7 @@ static void mctl_auto_detect_dram_size(struct dram_para *para)
 	}
 }
 
-unsigned long mctl_calc_size(struct dram_para *para)
+unsigned long mctl_calc_size(const struct dram_para *para)
 {
 	u8 width = para->bus_full_width ? 4 : 2;
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
index 2136ca3a4cb..6dde6e78717 100644
--- a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
@@ -38,7 +38,7 @@ static u32 mr_ddr3[7] = {
 };
 
 /* TODO: flexible timing */
-void mctl_set_timing_params(struct dram_para *para)
+void mctl_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
diff --git a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
index 10008601134..2a95484322c 100644
--- a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
@@ -17,7 +17,7 @@ static u32 mr_lpddr3[12] = {
 };
 
 /* TODO: flexible timing */
-void mctl_set_timing_params(struct dram_para *para)
+void mctl_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
-- 
2.35.8

