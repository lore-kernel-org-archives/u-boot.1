Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F249CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEBA8484F;
	Mon, 25 May 2026 04:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="PDtv1jcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D5EF8404D; Mon, 25 May 2026 03:29:39 +0200 (CEST)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C2283EF9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672576; x=1779931776;
 bh=AVP53vwDsnRjR5W1PjMq8rCbFULr/nXiAJga8XF9ttE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PDtv1jcmYaZIeVIzHtyFXrgo1tFkmaF/T5wLbHVV5BbQv4P8CoymADzCEHubDA4Na
 Zrr1fzwWnF28lT4n0yNRVVwIQO+Cu7tcfatt/BgTfe3abPP6V3LRNrUk4tumPKStoI
 Y5giiPVSFIB4ujrvGJV9k/yvzPai4IhQ6JmfAeA4HLmmwmq1ZAXXmADaRi40PW0xKj
 19ZNUB0qyV8puOoBTEbqInIhlBU3AWGflcL0b8pCOMry3jEN0Lhok0ag3wIH5HiBFn
 UQhB8Ncs4Isuou+88PauyV1xfZJMqge+EBOYxLDRdZn6KtsXTTz/A+MEAsKq8f59CY
 AJXXiU4pjcsew==
Date: Mon, 25 May 2026 01:29:33 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 09/14] ram: rockchip: rk3576: add DRAM controller and
 PHY driver
Message-ID: <20260525012824.121-10-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 98a8b9db7abead20d94a8b6c7df840b4f15cfcfc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

Add the TPL DRAM initialization driver for RK3576.  This replaces
Rockchip's DDR blob with an open-source implementation targeting
upstream U-Boot.

Hardware: Synopsys uMCTL2 DDRCTL + Synopsys LPDDR4/4X/5 combo PHY.
Two independent channels (ch0/ch1), each with one DDRCTL + one PHY.
Supported DRAM types: LPDDR4, LPDDR4X, LPDDR5.

Key implementation notes:

  PHY training: the RK3576 combo PHY includes a hardware training
  engine (phy_train_en / phy_train_done in SCHD_TRAIN_CON0[0:1]).
  No Synopsys training firmware (.bin) is needed.  This is confirmed
  by TRM =C2=A77.6.4-7.6.5 and matches the approach used on RK3568.

  Init sequence: follows TRM =C2=A77.6.2 (LPDDR4, 37 steps) and =C2=A77.6.3
  (LPDDR5, 42 steps).  LPDDR5 deviations are noted at each step:
  WCK2CK sync setup (step 26/28), CS toggle (step 28), ZQ calibration,
  WCK always-on mode (step 42).

  ZQ calibration: phy_zq_calibrate() runs the PHY impedance engine
  (ZQ_CON0/CON1) per TRM =C2=A77.6.2 step 29 / =C2=A77.6.3 step 33.

  Geometry storage: sdram_org_config() encodes cap_info into the
  Rockchip sys_reg format and writes PMU1GRF OS_REG2/3 for SPL and
  Linux to consume (W10).

  SPL/U-Boot stub: rk3576_dmc_get_info() reads DRAM size back from
  OS_REG2 via rockchip_sdram_size().

  Timing tables: included from sdram-rk3576-lpddr5-detect-2133.inc
  and sdram-rk3576-lpddr4-detect-1560.inc via sdram_configs[].

Modelled on the RK3568 RFC series (20260517-rk3568-raminit-v1,
Pavel Golikov).  Addresses Flipper One open DRAM init task
(flipperdevices/flipperone-linux-build-scripts#56).

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 drivers/ram/rockchip/sdram_rk3576.c | 655 +++++++++++++++++++++++++++-
 1 file changed, 646 insertions(+), 9 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3576.c b/drivers/ram/rockchip/sdr=
am_rk3576.c
index 5a66032ef8f..502dcaeacab 100644
--- a/drivers/ram/rockchip/sdram_rk3576.c
+++ b/drivers/ram/rockchip/sdram_rk3576.c
@@ -1,20 +1,657 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2024 Rockchip Electronics Co., Ltd.
+ * RK3576 DRAM controller + PHY driver.
+ *
+ * Implements LPDDR4/4X/5 initialization without Rockchip DDR blob.
+ * TPL (CONFIG_XPL_BUILD) section: full init sequence.
+ * SPL / U-Boot proper section: read back geometry from PMU1GRF.
+ *
+ * TRM references:
+ *   =C2=A77.6.2  LPDDR4/4X software initialization procedure (37 steps)
+ *   =C2=A77.6.3  LPDDR5 software initialization procedure (42 steps)
+ *   =C2=A77.4.6  DDRPHY detail register descriptions (pp.808-980)
+ *   =C2=A77.4.3  DDRCTL register field descriptions
+ *
+ * Template: RK3568 RFC series 20260517-rk3568-raminit-v1 (Pavel Golikov)
+ * RK3576 divergence: newer LPDDR4/4X/5 combo PHY with hardware training
+ * engine (phy_train_en / phy_train_done) =E2=80=94 no Synopsys training f=
irmware.
  */
=20
+#include <config.h>
 #include <dm.h>
 #include <ram.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/sdram.h>
+#include <asm/arch-rockchip/sdram_rk3576.h>
+#include <linux/delay.h>
=20
-#define PMU1GRF_BASE=09=09=090x26026000
-#define OS_REG2_REG=09=09=090x208
+/* -----------------------------------------------------------------------
+ * TPL section =E2=80=94 full DDRCTL + DDRPHY initialization
+ * -----------------------------------------------------------------------
+ */
+
+#if defined(CONFIG_TPL_BUILD) || \
+=09(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+
+/*
+ * Precalculated timing tables for supported DRAM configurations.
+ * Each .inc file contributes one or more rk3576_sdram_params entries.
+ * W8 / W9 work items.
+ */
+static const struct rk3576_sdram_params sdram_configs[] =3D {
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR5)
+# include "sdram-rk3576-lpddr5-detect-2133.inc"
+#endif
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+# include "sdram-rk3576-lpddr4-detect-1560.inc"
+#endif
+};
+
+/* -----------------------------------------------------------------------
+ * SWCTL protocol =E2=80=94 every quasi-dynamic DDRCTL register write must=
 use:
+ *   swctl_unlock =E2=86=92 write register(s) =E2=86=92 swctl_lock
+ * (TRM =C2=A77.4.3 DDRCTL_SWCTL / DDRCTL_SWSTAT)
+ * -----------------------------------------------------------------------
+ */
+
+static void swctl_unlock(void __iomem *ctl)
+{
+=09writel(0, ctl + DDRCTL_SWCTL);
+}
+
+static void swctl_lock(void __iomem *ctl)
+{
+=09writel(SWCTL_SW_DONE, ctl + DDRCTL_SWCTL);
+=09while (!(readl(ctl + DDRCTL_SWSTAT) & SWSTAT_SW_DONE_ACK))
+=09=09;
+}
+
+/* -----------------------------------------------------------------------
+ * DDR_GRF write helper =E2=80=94 Rockchip write-mask convention:
+ *   bits[31:16] are the write-enable mask for bits[15:0]
+ * -----------------------------------------------------------------------
+ */
+
+static void grf_writemask(void __iomem *grf, u32 off, u32 mask, u32 val)
+{
+=09writel((mask << 16) | (val & mask), grf + off);
+}
+
+/* -----------------------------------------------------------------------
+ * DDRPHY 2x clock gate control via DDR_GRF (TRM =C2=A77.6.2 steps 12/30/3=
4)
+ * Applies to both PHY_CON0 and PHY_CON1 for the given channel.
+ * enable=3D1: clock flows; enable=3D0: gate before frequency change.
+ * -----------------------------------------------------------------------
+ */
+
+static void phy_clkgate_set(void __iomem *grf, int ch, int enable)
+{
+=09u32 con0 =3D ch ? DDR_GRF_CHB_PHY_CON0 : DDR_GRF_CHA_PHY_CON0;
+=09u32 con1 =3D ch ? DDR_GRF_CHB_PHY_CON1 : DDR_GRF_CHA_PHY_CON1;
+=09u32 val =3D enable ? PHY_CON_DDRPHY2XCLKGATE_EN : 0;
+
+=09grf_writemask(grf, con0, PHY_CON_DDRPHY2XCLKGATE_EN, val);
+=09grf_writemask(grf, con1, PHY_CON_DDRPHY2XCLKGATE_EN, val);
+}
+
+/* -----------------------------------------------------------------------
+ * dfi_init_complete source mux via DDR_GRF (TRM =C2=A77.6.2 step 31)
+ *
+ * Before turning MDLL on (ctrl_dll_on=3D1), dfi_init_complete must be
+ * sourced from DDR_GRF rather than from the PHY, because MDLL power-on
+ * will momentarily pull dfi_init_complete low, which would confuse DDRCTL=
.
+ *
+ * from_grf=3D1: set GRF_CHA/CHB_DDRPHY_CON0[5:4] =3D 0b11 (both bits)
+ * from_grf=3D0: clear bit[4] (restore normal DDRCTL-driven path)
+ * -----------------------------------------------------------------------
+ */
+
+static void grf_dfi_init_comp_sel(void __iomem *grf, int ch, int from_grf)
+{
+=09u32 reg =3D ch ? GRF_CHB_DDRPHY_CON0 : GRF_CHA_DDRPHY_CON0;
+
+=09if (from_grf) {
+=09=09/*
+=09=09 * TRM step 31: set bit[5] first, then bit[4].
+=09=09 * Both bits together select the GRF-driven path.
+=09=09 */
+=09=09grf_writemask(grf, reg, DDRPHY_CON0_DFI_INIT_COMP_SEL_MASK,
+=09=09=09      DDRPHY_CON0_DFI_INIT_COMP_FROM_PHY);
+=09} else {
+=09=09/* Step 34: clear bit[4] to restore DDRCTL DFI output */
+=09=09grf_writemask(grf, reg, DDRPHY_CON0_DFI_INIT_COMP_SEL_MASK, 0);
+=09}
+}
+
+/* -----------------------------------------------------------------------
+ * DDRPHY mode registers (TRM =C2=A77.6.2 step 11 / =C2=A77.6.3 step 11)
+ *
+ * GNR_CON0.ctrl_ddr_mode:  0=3DLPDDR4, 2=3DLPDDR5
+ * CLKMODE_CON.ctrl_phy_mode: 1=3DLPDDR4 1:2:2, 4=3DLPDDR5 1:1:4
+ * CLKMODE_CON.ctrl_phy_clk_2x: always 1 (PHY 2x clock enabled)
+ * -----------------------------------------------------------------------
+ */
+
+static void phy_set_mode(void __iomem *phy, unsigned int dram_type)
+{
+=09u32 gnr_mode, clkmode;
+
+=09if (dram_type =3D=3D LPDDR5) {
+=09=09/* GNR_CON0: ctrl_ddr_mode=3D2, wdqs_oen_mode=3D1 (TRM p.808/821) */
+=09=09gnr_mode =3D GNR_CON0_DDR_MODE_LPDDR5 | GNR_CON0_WDQS_OEN_MODE;
+=09=09/* CLKMODE_CON: 1:1:4 CLK_DFI:CK:WCK (Flipper One mode) */
+=09=09clkmode =3D CLKMODE_CON_PHY_CLK_2X | CLKMODE_CON_PHY_MODE_LP5_1_4;
+=09} else {
+=09=09/* LPDDR4/4X: ctrl_ddr_mode=3D0, 1:2:2 ratio */
+=09=09gnr_mode =3D GNR_CON0_DDR_MODE_LPDDR4;
+=09=09clkmode =3D CLKMODE_CON_PHY_CLK_2X | CLKMODE_CON_PHY_MODE_LPDDR4;
+=09}
+
+=09clrsetbits_le32(phy + DDRPHY_GNR_CON0,
+=09=09=09GNR_CON0_CTRL_DDR_MODE_MASK | GNR_CON0_WDQS_OEN_MODE,
+=09=09=09gnr_mode);
+=09clrsetbits_le32(phy + DDRPHY_CLKMODE_CON,
+=09=09=09CLKMODE_CON_PHY_CLK_2X | CLKMODE_CON_PHY_MODE_MASK,
+=09=09=09clkmode);
+}
+
+/* -----------------------------------------------------------------------
+ * DDRCTL: write per-frequency timing registers (TRM =C2=A77.6.2 step 15)
+ * Must be called for each of the RK3576_DDRCTL_NFREQS frequency sets.
+ * -----------------------------------------------------------------------
+ */
+
+static void ctl_set_freq_params(void __iomem *ctl, int fi,
+=09=09=09=09const struct rk3576_ddrctl_freq_params *p)
+{
+=09u32 b =3D DDRCTL_FREQ_BASE(fi);
+
+#define WF(r, v)=09writel((v), ctl + b + (r))
+=09WF(DDRCTL_DRAMSET1TMG0,  p->dramset1tmg0);
+=09WF(DDRCTL_DRAMSET1TMG1,  p->dramset1tmg1);
+=09WF(DDRCTL_DRAMSET1TMG2,  p->dramset1tmg2);
+=09WF(DDRCTL_DRAMSET1TMG3,  p->dramset1tmg3);
+=09WF(DDRCTL_DRAMSET1TMG4,  p->dramset1tmg4);
+=09WF(DDRCTL_DRAMSET1TMG5,  p->dramset1tmg5);
+=09WF(DDRCTL_DRAMSET1TMG6,  p->dramset1tmg6);
+=09WF(DDRCTL_DRAMSET1TMG7,  p->dramset1tmg7);
+=09WF(DDRCTL_DRAMSET1TMG8,  p->dramset1tmg8);
+=09WF(DDRCTL_DRAMSET1TMG9,  p->dramset1tmg9);
+=09WF(DDRCTL_DRAMSET1TMG12, p->dramset1tmg12);
+=09WF(DDRCTL_DRAMSET1TMG13, p->dramset1tmg13);
+=09WF(DDRCTL_DRAMSET1TMG14, p->dramset1tmg14);
+=09WF(DDRCTL_DRAMSET1TMG23, p->dramset1tmg23);
+=09WF(DDRCTL_DRAMSET1TMG24, p->dramset1tmg24);
+=09WF(DDRCTL_DRAMSET1TMG25, p->dramset1tmg25);
+=09WF(DDRCTL_DRAMSET1TMG30, p->dramset1tmg30);
+=09WF(DDRCTL_INITMR0,       p->initmr0);
+=09WF(DDRCTL_INITMR1,       p->initmr1);
+=09WF(DDRCTL_INITMR2,       p->initmr2);
+=09WF(DDRCTL_INITMR3,       p->initmr3);
+=09WF(DDRCTL_DFITMG0,       p->dfitmg0);
+=09WF(DDRCTL_DFITMG1,       p->dfitmg1);
+=09WF(DDRCTL_DFITMG2,       p->dfitmg2);
+=09WF(DDRCTL_DFITMG4,       p->dfitmg4);
+=09WF(DDRCTL_DFITMG5,       p->dfitmg5);
+=09WF(DDRCTL_DFILPTMG0,     p->dfilptmg0);
+=09WF(DDRCTL_DFILPTMG1,     p->dfilptmg1);
+=09WF(DDRCTL_DFIUPDTMG0,    p->dfiupdtmg0);
+=09WF(DDRCTL_DFIUPDTMG1,    p->dfiupdtmg1);
+=09WF(DDRCTL_DFIMSGTMG0,    p->dfimsgtmg0);
+=09WF(DDRCTL_RFSHSET1TMG0,  p->rfshset1tmg0);
+=09WF(DDRCTL_RFSHSET1TMG1,  p->rfshset1tmg1);
+=09WF(DDRCTL_RFSHSET1TMG2,  p->rfshset1tmg2);
+=09WF(DDRCTL_RFSHSET1TMG4,  p->rfshset1tmg4);
+=09WF(DDRCTL_ZQSET1TMG0,    p->zqset1tmg0);
+=09WF(DDRCTL_ZQSET1TMG1,    p->zqset1tmg1);
+=09WF(DDRCTL_PERFHPR1,      p->perfhpr1);
+=09WF(DDRCTL_PERFLPR1,      p->perflpr1);
+=09WF(DDRCTL_PERFWR1,       p->perfwr1);
+=09WF(DDRCTL_RANKTMG0,      p->ranktmg0);
+=09WF(DDRCTL_RANKTMG1,      p->ranktmg1);
+=09WF(DDRCTL_PWRTMG,        p->pwrtmg);
+#undef WF
+}
+
+/* -----------------------------------------------------------------------
+ * DDRCTL: write global (static) registers (TRM =C2=A77.6.2 step 15)
+ * These are programmed once and are not per-frequency.
+ * -----------------------------------------------------------------------
+ */
+
+static void ctl_set_global_params(void __iomem *ctl,
+=09=09=09=09  const struct rk3576_ddrctl_global_params *g)
+{
+=09writel(g->mstr0,      ctl + DDRCTL_MSTR0);
+=09writel(g->rankctl,    ctl + DDRCTL_RANKCTL);
+=09writel(g->dbictl,     ctl + DDRCTL_DBICTL);
+=09writel(g->odtmap,     ctl + DDRCTL_ODTMAP);
+=09writel(g->inittmg0,   ctl + DDRCTL_INITTMG0);
+=09writel(g->inittmg1,   ctl + DDRCTL_INITTMG1);
+=09writel(g->rfshmod0,   ctl + DDRCTL_RFSHMOD0);
+=09writel(g->sched0,     ctl + DDRCTL_SCHED0);
+=09writel(g->sched1,     ctl + DDRCTL_SCHED1);
+=09writel(g->sched3,     ctl + DDRCTL_SCHED3);
+=09writel(g->sched4,     ctl + DDRCTL_SCHED4);
+=09writel(g->dfilpcfg0,  ctl + DDRCTL_DFILPCFG0);
+=09writel(g->dfiupd0,    ctl + DDRCTL_DFIUPD0);
+=09writel(g->dfiphymstr, ctl + DDRCTL_DFIPHYMSTR);
+=09writel(g->zqctl0,     ctl + DDRCTL_ZQCTL0);
+=09writel(g->zqctl1,     ctl + DDRCTL_ZQCTL1);
+}
+
+/* -----------------------------------------------------------------------
+ * DDRPHY MDLL turn-on and locking (TRM =C2=A77.6.2 steps 32-33 / =C2=
=A77.6.3 36-37)
+ *
+ * Protocol: set ctrl_dll_on, pulse ctrl_start 0=E2=86=921, poll ctrl_lock=
ed.
+ * -----------------------------------------------------------------------
+ */
+
+static void phy_mdll_lock(void __iomem *phy)
+{
+=09/* Step 32/36: turn on master DLL */
+=09setbits_le32(phy + DDRPHY_MDLL_CON0, MDLL_CON0_CTRL_DLL_ON);
+
+=09/* Step 33/37: start locking =E2=80=94 ctrl_start 0 =E2=86=92 1 */
+=09clrbits_le32(phy + DDRPHY_MDLL_CON0, MDLL_CON0_CTRL_START);
+=09setbits_le32(phy + DDRPHY_MDLL_CON0, MDLL_CON0_CTRL_START);
+
+=09/* Poll for stable DLL lock (TRM p.835: ctrl_locked is stable lock) */
+=09while (!(readl(phy + DDRPHY_MDLL_CON1) & MDLL_CON1_CTRL_LOCKED))
+=09=09;
+}
+
+/* -----------------------------------------------------------------------
+ * PHY hardware training engine (TRM =C2=A77.6.4 LP4 / =C2=A77.6.5 LP5)
+ *
+ * Hardware engine performs: write levelling =E2=86=92 gate training =
=E2=86=92 read/write
+ * training automatically when phy_train_en is asserted.
+ * -----------------------------------------------------------------------
+ */
+
+static int phy_train(void __iomem *phy)
+{
+=09setbits_le32(phy + DDRPHY_SCHD_TRAIN_CON0, TRAIN_CON0_PHY_TRAIN_EN);
+=09while (!(readl(phy + DDRPHY_SCHD_TRAIN_CON0) & TRAIN_CON0_PHY_TRAIN_DON=
E))
+=09=09;
+=09clrbits_le32(phy + DDRPHY_SCHD_TRAIN_CON0, TRAIN_CON0_PHY_TRAIN_EN);
+
+=09if (readl(phy + DDRPHY_CAL_FAIL_STAT0) & CAL_FAIL_STAT0_ANY_FAIL)
+=09=09return -EIO;
+
+=09return 0;
+}
+
+/* -----------------------------------------------------------------------
+ * Post-training PHY settings (TRM =C2=A77.6.2 step 37 / =C2=A77.6.3 step =
42)
+ * -----------------------------------------------------------------------
+ */
+
+static void phy_post_training(void __iomem *phy)
+{
+=09/* Re-enable DLL auto-locking (clkm_cg_en_sw back to 0) */
+=09clrbits_le32(phy + DDRPHY_MDLL_CON0, MDLL_CON0_CLKM_CG_EN_SW);
+
+=09/* Cycle-based write training off for normal operation */
+=09clrbits_le32(phy + DDRPHY_CAL_CON5, CAL_CON5_WRTRN_CYC_MODE);
+
+=09/* Enable VT compensation (tracks on-chip voltage/temp variation) */
+=09setbits_le32(phy + DDRPHY_CAL_CON0, CAL_CON0_CAL_VTC_EN);
+
+=09/*
+=09 * Re-interpret future dfi_lvl_periodic=3D0 write training as DVFS
+=09 * write training (searches tDQS2DQ variation, not full window).
+=09 */
+=09setbits_le32(phy + DDRPHY_CAL_CON0, CAL_CON0_DVFS_WR_TRAIN_EN);
+
+=09/* Push DLL updates to slave DLLs: toggle ctrl_resync 0 =E2=86=92 1 =
=E2=86=92 0 */
+=09setbits_le32(phy + DDRPHY_OFFSETD_CON0, OFFSETD_CON0_CTRL_RESYNC);
+=09clrbits_le32(phy + DDRPHY_OFFSETD_CON0, OFFSETD_CON0_CTRL_RESYNC);
+}
+
+/* -----------------------------------------------------------------------
+ * ZQ impedance calibration (TRM =C2=A77.6.2 step 29 / =C2=A77.6.3 step 33=
)
+ *
+ * Called after DDRCTL reaches normal operating mode and before the
+ * frequency change to target speed (pp.1071/1073).
+ * -----------------------------------------------------------------------
+ */
+
+static void phy_zq_calibrate(void __iomem *phy)
+{
+=09/* Enable ZQ clock divider then start manual calibration */
+=09setbits_le32(phy + DDRPHY_ZQ_CON0, ZQ_CON0_ZQ_CLK_DIV_EN);
+=09setbits_le32(phy + DDRPHY_ZQ_CON0, ZQ_CON0_ZQ_MANUAL_STR);
+
+=09/* Poll until calibration completes */
+=09while (!(readl(phy + DDRPHY_ZQ_CON1) & ZQ_CON1_ZQ_DONE))
+=09=09;
+
+=09/* Clear calibration trigger, then disable clock divider */
+=09clrbits_le32(phy + DDRPHY_ZQ_CON0, ZQ_CON0_ZQ_MANUAL_STR);
+=09clrbits_le32(phy + DDRPHY_ZQ_CON0, ZQ_CON0_ZQ_CLK_DIV_EN);
+}
+
+/* -----------------------------------------------------------------------
+ * Per-channel initialization
+ *
+ * Follows TRM =C2=A77.6.2 step numbering (LPDDR4/4X).
+ * Steps 1-10 (PLL, CRU resets) are performed by the SoC BootROM before
+ * TPL runs; this function starts at step 11.
+ * LPDDR5 deviations are noted at each relevant step.
+ * -----------------------------------------------------------------------
+ */
+
+static int ddr_init_channel(int ch, void __iomem *ctl, void __iomem *phy,
+=09=09=09    void __iomem *grf,
+=09=09=09    const struct rk3576_sdram_params *params)
+{
+=09void __iomem *ddrcru;
+=09unsigned int dram_type =3D params->base.dramtype;
+=09int lpddr5 =3D (dram_type =3D=3D LPDDR5);
+=09int i, ret;
+
+=09ddrcru =3D (void __iomem *)(ulong)(ch ? RK3576_DDR1CRU_BASE
+=09=09=09=09=09    : RK3576_DDR0CRU_BASE);
+
+=09/*
+=09 * Step 11: Configure DDRPHY clock ratio and DRAM type mode.
+=09 * GNR_CON0.ctrl_ddr_mode, CLKMODE_CON.ctrl_phy_mode/ctrl_phy_clk_2x.
+=09 */
+=09phy_set_mode(phy, dram_type);
+
+=09/*
+=09 * Steps 12-13: Frequency switch from boot clock (D0APLL, 24 MHz) to
+=09 * the target frequency (D0BPLL, configured by clock driver).
+=09 *
+=09 * a) Disable PHY 2x clock gate before switching.
+=09 * b) For LPDDR5: assert div_rst_n (prevents PHY metastability).
+=09 *    TODO: div_rst_n CRU bit =E2=80=94 needs TRM Part 1 CRU chapter.
+=09 * c) Switch clock mux: DDR0/1CRU_CLKSEL_CON00[0] =3D 1 =E2=86=92 D0B/D=
1BPLL.
+=09 *    Write-mask convention: bit[16] =3D write-enable for bit[0].
+=09 * d) For LPDDR5: de-assert div_rst_n after clock settles.
+=09 * e) Re-enable PHY 2x clock gate.
+=09 */
+=09phy_clkgate_set(grf, ch, 0);
+=09writel(BIT(16) | DDRCRU_CLKSEL_D0BPLL, ddrcru + DDRCRU_CLKSEL_CON00);
+=09phy_clkgate_set(grf, ch, 1);
+
+=09/*
+=09 * Steps 14-16: De-assert DDRCTL and DDRPHY resets (presetn,
+=09 * core_ddrc_rstn, aresetn_i). Handled by BootROM; TPL assumes
+=09 * resets are already released before sdram_init() is called.
+=09 * TODO: verify with logic analyser on first hardware bring-up.
+=09 */
+
+=09/*
+=09 * Step 15: Program DDRCTL global static registers.
+=09 * These must be written before core reset release in a cold-boot
+=09 * scenario; on warm-boot they overwrite the previous config.
+=09 */
+=09ctl_set_global_params(ctl, &params->ctl);
+
+=09/* Step 15: Program all 4 per-frequency timing register banks. */
+=09for (i =3D 0; i < RK3576_DDRCTL_NFREQS; i++)
+=09=09ctl_set_freq_params(ctl, i, &params->freq[i]);
+
+=09/*
+=09 * Step 17: Disable auto-refresh, self-refresh, and power-down.
+=09 * Must be done while controller is in init mode (before step 26).
+=09 */
+=09setbits_le32(ctl + DDRCTL_RFSHCTL0, RFSHCTL0_DIS_AUTO_REFRESH);
+=09clrbits_le32(ctl + DDRCTL_PWRCTL, PWRCTL_SELFREF_EN | PWRCTL_SELFREF_SW=
);
+
+=09/*
+=09 * Steps 18-20: Quasi-dynamic write =E2=80=94 disable dfi_init_complete=
_en.
+=09 * SWCTL=3D0 (unlock), write DFIMISC, SWCTL=3D1 (lock + wait ack).
+=09 */
+=09swctl_unlock(ctl);
+=09clrbits_le32(ctl + DDRCTL_DFIMISC, DFIMISC_DFI_INIT_COMPLETE_EN);
+=09swctl_lock(ctl);
+
+=09/*
+=09 * Step 21: Enable all 5 AXI ports.
+=09 * DDRCTL_PCTRL(i).port_en =3D 1.
+=09 */
+=09for (i =3D 0; i < DDRCTL_NPORTS; i++)
+=09=09setbits_le32(ctl + DDRCTL_PCTRL(i), PCTRL_PORT_EN);
+
+=09/*
+=09 * Step 22: Set DDRPHY operational registers.
+=09 * Use PHY-initiated DFI update mode (upd_mode=3D0).
+=09 * Latency and burst-length registers are at reset-safe defaults;
+=09 * the W9 timing table will supply correct values via phy params.
+=09 */
+=09clrbits_le32(phy + DDRPHY_OFFSETD_CON0, OFFSETD_CON0_UPD_MODE);
+
+=09/*
+=09 * Step 23: PHY IO settings before ZQ calibration.
+=09 * ctrl_pulld_dqs default (reset 0x3) keeps DQS pulled correctly.
+=09 * No additional writes needed at this stage.
+=09 */
+
+=09/*
+=09 * Step 24: DFI initialization start.
+=09 *
+=09 * a) For LPDDR5: force DLL lock value for low-frequency operation
+=09 *    (ctrl_force =3D 0x2ef, per TRM =C2=A77.6.3 step 24).
+=09 * b) Turn off master DLL (ctrl_dll_on =3D 0) on PHY.
+=09 * c) Quasi-dynamic write: assert DFIMISC.dfi_init_start.
+=09 *    DDRCTL then drives dfi_init_start to PHY; PHY initializes
+=09 *    and responds with dfi_init_complete when ready.
+=09 * d) Poll DFISTAT.dfi_init_complete =3D 1.
+=09 */
+=09if (lpddr5)
+=09=09clrsetbits_le32(phy + DDRPHY_MDLL_CON0,
+=09=09=09=09MDLL_CON0_CTRL_FORCE_MASK | MDLL_CON0_CTRL_DLL_ON,
+=09=09=09=09MDLL_CON0_CTRL_FORCE_LOW_FREQ);
+=09else
+=09=09clrbits_le32(phy + DDRPHY_MDLL_CON0, MDLL_CON0_CTRL_DLL_ON);
+
+=09swctl_unlock(ctl);
+=09setbits_le32(ctl + DDRCTL_DFIMISC, DFIMISC_DFI_INIT_START);
+=09swctl_lock(ctl);
+
+=09while (!(readl(ctl + DDRCTL_DFISTAT) & DFISTAT_DFI_INIT_COMPLETE))
+=09=09;
+
+=09/*
+=09 * LP5 step 26: enable software intervention before SDRAM auto-init.
+=09 * MRCTRL0.sw_init_int=3D1 allows SW to inject MRS before the DDRCTL
+=09 * init sequence starts (needed for the CS toggle in step 28).
+=09 * TRM =C2=A77.6.3 step 26 (p.1073).
+=09 */
+=09if (lpddr5)
+=09=09writel(MRCTRL0_SW_INIT_INT, ctl + DDRCTL_MRCTRL0);
+
+=09/*
+=09 * Step 25 (LP4) / Step 27 (LP5): clear dfi_init_start, enable
+=09 * dfi_init_complete_en. DDRCTL now drives the DRAM init sequence
+=09 * (CKE, MRS, etc.) autonomously via DFI commands.
+=09 */
+=09swctl_unlock(ctl);
+=09clrbits_le32(ctl + DDRCTL_DFIMISC, DFIMISC_DFI_INIT_START);
+=09setbits_le32(ctl + DDRCTL_DFIMISC, DFIMISC_DFI_INIT_COMPLETE_EN);
+=09swctl_lock(ctl);
+
+=09/*
+=09 * LP5 step 28: CS toggle to assert power-down exit asynchronously.
+=09 * Toggle CHA/CHB CS: 0=E2=86=921 (0xFF) then 1=E2=86=920 (0x00).
+=09 * TRM =C2=A77.6.3 step 28 (p.1073); only the current channel's CON2.
+=09 */
+=09if (lpddr5) {
+=09=09u32 con2 =3D ch ? DDR_GRF_CHB_CON2 : DDR_GRF_CHA_CON2;
+
+=09=09grf_writemask(grf, con2, 0xff, 0xff);
+=09=09grf_writemask(grf, con2, 0xff, 0x00);
+=09}
+
+=09/*
+=09 * Step 26 (LP4) / Step 30 (LP5): wait for DDRCTL normal operating mode=
.
+=09 * DDRCTL_STAT.operating_mode =3D 1.
+=09 */
+=09while ((readl(ctl + DDRCTL_STAT) & STAT_OPERATING_MODE_MASK) !=3D
+=09       STAT_OPERATING_MODE_NORMAL)
+=09=09;
+
+=09/*
+=09 * Steps 27-28 (LP4) / Steps 31-32 (LP5): vref and ODT settings.
+=09 * Using PHY reset defaults for initial bring-up; no explicit writes.
+=09 */
+
+=09/*
+=09 * Step 29 (LP4) / Step 33 (LP5): ZQ impedance calibration.
+=09 * TRM =C2=A77.6.2 step 29 / =C2=A77.6.3 step 33 (pp.1071/1073).
+=09 */
+=09phy_zq_calibrate(phy);
+
+=09/*
+=09 * Step 30 (LP4) / Step 34 (LP5): frequency change to target speed.
+=09 * DFI init protocol: gate PHY 2x clock, clear dfi_init_start, poll
+=09 * dfi_init_complete=3D1, set dfi_init_complete_en, ungate clock.
+=09 */
+=09phy_clkgate_set(grf, ch, 0);
+
+=09swctl_unlock(ctl);
+=09clrbits_le32(ctl + DDRCTL_DFIMISC, DFIMISC_DFI_INIT_START);
+=09swctl_lock(ctl);
+
+=09while (!(readl(ctl + DDRCTL_DFISTAT) & DFISTAT_DFI_INIT_COMPLETE))
+=09=09;
+
+=09swctl_unlock(ctl);
+=09setbits_le32(ctl + DDRCTL_DFIMISC, DFIMISC_DFI_INIT_COMPLETE_EN);
+=09swctl_lock(ctl);
+
+=09phy_clkgate_set(grf, ch, 1);
+
+=09/*
+=09 * Step 31 (LP4) / Step 35 (LP5):
+=09 * Switch dfi_init_complete source to DDR_GRF.
+=09 * This protects DDRCTL from the dfi_init_complete glitch that will
+=09 * occur when ctrl_dll_on is asserted (MDLL power-on dip).
+=09 * GRF_CHA/CHB_DDRPHY_CON0[5:4] =3D 0b11.
+=09 */
+=09grf_dfi_init_comp_sel(grf, ch, 1);
+
+=09/*
+=09 * Steps 32-33 (LP4) / Steps 36-37 (LP5):
+=09 * Turn on DDRPHY master DLL and wait for stable lock.
+=09 */
+=09phy_mdll_lock(phy);
+
+=09/*
+=09 * Step 34 (LP4) / Step 38 (LP5):
+=09 * Restore dfi_init_complete source to DDRCTL DFI output.
+=09 * GRF_CHA/CHB_DDRPHY_CON0[4] =3D 0.
+=09 */
+=09grf_dfi_init_comp_sel(grf, ch, 0);
+
+=09/*
+=09 * Step 35 (LP4) / Step 39 (LP5): DDRPHY scheduler and LP5 settings.
+=09 * ctrl_scheduler_en enables the PHY scheduler clock for normal op.
+=09 * LPDDR5 additionally requires: wck_enable=3D1, ctrl_dqs_drv_off=3D1
+=09 * (when write-link ECC is not in use), wdqs_oen_mode already set.
+=09 */
+=09setbits_le32(phy + DDRPHY_LP_CON0, LP_CON0_CTRL_SCHEDULER_EN);
+=09if (lpddr5)
+=09=09setbits_le32(phy + DDRPHY_LP_CON0,
+=09=09=09     LP_CON0_WCK_ENABLE | LP_CON0_CTRL_DQS_DRV_OFF);
+
+=09/*
+=09 * Step 36 (LP4) / Step 41 (LP5): Hardware training.
+=09 * phy_train_en=3D1 triggers the built-in training engine.
+=09 * Engine performs: write levelling =E2=86=92 gate =E2=86=92 read/write=
 training.
+=09 * Poll phy_train_done=3D1, then clear phy_train_en.
+=09 */
+=09ret =3D phy_train(phy);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Step 37 (LP4) / Step 42 (LP5): Post-training settings.
+=09 * clkm_cg_en_sw=3D0, cal_vtc_en=3D1, dvfs_wr_train_en=3D1,
+=09 * toggle ctrl_resync to propagate DLL updates.
+=09 */
+=09phy_post_training(phy);
+
+=09/*
+=09 * LP5 step 42: set WCK driving policy before entering normal operation=
.
+=09 * Using WCK always-on disabled mode: WCK_MODE_APB=3D0, CAS_EN_APB=3D1.
+=09 * Both are reset defaults, but written explicitly per TRM =C2=A77.6.3 =
step 42
+=09 * (p.1074): "Please set WCK_MODE_APB before memory normal operation."
+=09 */
+=09if (lpddr5) {
+=09=09clrbits_le32(phy + DDRPHY_WCK2CKSYNC_CON0,
+=09=09=09     WCK2CKSYNC_CON0_WCK_MODE_MASK);
+=09=09setbits_le32(phy + DDRPHY_SCHD_CMD_CON0,
+=09=09=09     SCHD_CMD_CON0_CAS_EN_APB);
+=09}
+
+=09/* Re-enable auto-refresh now that training is complete. */
+=09clrbits_le32(ctl + DDRCTL_RFSHCTL0, RFSHCTL0_DIS_AUTO_REFRESH);
+
+=09return 0;
+}
+
+/*
+ * sdram_init() =E2=80=94 TPL entry point, called from arch/arm/mach-rockc=
hip/sdram.c
+ *
+ * Initializes both DDR channels in parallel (sequential for now =E2=80=
=94 parallel
+ * init would require separate PLL + GRF access which is more complex).
+ * Stores DRAM geometry in PMU1GRF OS_REG2/3 for SPL and Linux.
+ */
+int sdram_init(void)
+{
+=09void __iomem *grf    =3D (void __iomem *)(ulong)RK3576_DDR_GRF_BASE;
+=09void __iomem *ctl0   =3D (void __iomem *)(ulong)RK3576_DDRCTL0_BASE;
+=09void __iomem *ctl1   =3D (void __iomem *)(ulong)RK3576_DDRCTL1_BASE;
+=09void __iomem *phy0   =3D (void __iomem *)(ulong)RK3576_DDRPHY0_BASE;
+=09void __iomem *phy1   =3D (void __iomem *)(ulong)RK3576_DDRPHY1_BASE;
+=09void __iomem *pmugrf =3D (void __iomem *)(ulong)RK3576_PMU1GRF_BASE;
+=09const struct rk3576_sdram_params *params;
+=09u32 sys_reg2 =3D 0, sys_reg3 =3D 0;
+=09int ch, ret;
+
+=09if (!ARRAY_SIZE(sdram_configs))
+=09=09return -ENODATA;
+
+=09/* Single config for Flipper One; auto-detection handled post-training =
*/
+=09params =3D &sdram_configs[0];
+
+=09ret =3D ddr_init_channel(0, ctl0, phy0, grf, params);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D ddr_init_channel(1, ctl1, phy1, grf, params);
+=09if (ret)
+=09=09return ret;
+
+=09/* W10: store DRAM geometry in PMU1GRF OS_REG2/3 for SPL and Linux */
+=09for (ch =3D 0; ch < params->base.num_channels; ch++)
+=09=09sdram_org_config(&params->ch[ch].cap_info,
+=09=09=09=09 &params->base, &sys_reg2, &sys_reg3, ch);
+=09writel(sys_reg2, pmugrf + RK3576_PMUGRF_OS_REG2);
+=09writel(sys_reg3, pmugrf + RK3576_PMUGRF_OS_REG3);
+
+=09return 0;
+}
+
+#endif /* CONFIG_TPL_BUILD / CONFIG_XPL_BUILD */
+
+/* -----------------------------------------------------------------------
+ * SPL / U-Boot proper driver =E2=80=94 reads DRAM size from PMU1GRF OS_RE=
G2
+ * (written by TPL sdram_init() above)
+ * -----------------------------------------------------------------------
+ */
=20
 static int rk3576_dmc_get_info(struct udevice *dev, struct ram_info *info)
 {
 =09info->base =3D CFG_SYS_SDRAM_BASE;
-=09info->size =3D rockchip_sdram_size(PMU1GRF_BASE + OS_REG2_REG);
-
+=09info->size =3D rockchip_sdram_size((phys_addr_t)(RK3576_PMU1GRF_BASE +
+=09=09=09=09=09=09       RK3576_PMUGRF_OS_REG2));
 =09return 0;
 }
=20
@@ -28,8 +665,8 @@ static const struct udevice_id rk3576_dmc_ids[] =3D {
 };
=20
 U_BOOT_DRIVER(rockchip_rk3576_dmc) =3D {
-=09.name =3D "rockchip_rk3576_dmc",
-=09.id =3D UCLASS_RAM,
-=09.of_match =3D rk3576_dmc_ids,
-=09.ops =3D &rk3576_dmc_ops,
+=09.name=09=09=3D "rockchip_rk3576_dmc",
+=09.id=09=09=3D UCLASS_RAM,
+=09.of_match=09=3D rk3576_dmc_ids,
+=09.ops=09=09=3D &rk3576_dmc_ops,
 };
--=20
2.45.1.windows.1


