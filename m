Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68330CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584E184841;
	Mon, 25 May 2026 04:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="GhNXpH8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9D98404D; Mon, 25 May 2026 03:29:37 +0200 (CEST)
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch
 [109.224.244.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D131A8039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672573; x=1779931773;
 bh=VHzWB9b16QS8G1KDEjrDR3g5iRek7gj5cqTfDwqUM8M=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GhNXpH8k/bKQG3SKzSZmNMMMz2ZMivuOwGlXTfsAekqCZ0JhYKLICwBFLtW2cQEHG
 NLhbnE0bozLimTHuZoAkR4BOCRRgKTLHfODeAT3mVCyyupTL+EcOUONrqqPAh4cpLr
 y2sw2B0o8pUcySHjKV0uHPXOHgQkySJdGNBPTW/9Avts7SFQHJ54mg/3YLseZXZT9t
 YwoyC1XBVUaKo5YNGCgrf4qRPyC0kQ4dtGn3hhgSX8gieGp1h8FT6jdq7fD4dTu9FO
 lf2VQyDkYGoOpPsXaQRXUI8kBisPjlk5d8OXkmXlW5KQxO9hj1wQugIYfWr2dTnNsn
 +/cQx+h+UUzog==
Date: Mon, 25 May 2026 01:29:28 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 08/14] ram: rockchip: add RK3576 DDRPHY register
 definitions
Message-ID: <20260525012824.121-9-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: d9a39dbcf52db3a858527ba3147ce5b1c24c3bfc
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

Add sdram_phy_rk3576.h with the full register layout for the Synopsys
LPDDR4/4X/5 combo PHY on RK3576.  This is a different PHY generation
from RK3568 and cannot share sdram_phy_px30.h.

Covers ~123 defines across:
  - GNR (general): ctrl_ddr_mode, WDQS OEN mode
  - CAL: offset-R/W/D/C/O, gate training, WR-levelling, CA deskew
  - LP: scheduler enable, WCK enable, DQS drive-off (LPDDR5)
  - MDLL: dll_on, start, force, clkm_cg_en_sw, locked status
  - ZQ: zq_clk_div_en, zq_manual_str, zq_done (TRM pp.860-862)
  - DVFS / CBT / SCHD_TRAIN FSM and command registers
  - WCK2CKSYNC: wck_mode_mask for LPDDR5 WCK policy
  - CLKMODE: phy_mode (LP4 1:2:2 / LP5 1:1:4), phy_clk_2x

All bit positions verified against TRM Part 2 =C2=A77.4.6 (pp.808-980).
No firmware required: training uses the built-in hardware engine
(SCHD_TRAIN_CON0[0]=3Dphy_train_en, [1]=3Dphy_train_done).

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 .../asm/arch-rockchip/sdram_phy_rk3576.h      | 363 ++++++++++++++++++
 1 file changed, 363 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_phy_rk3576.h

diff --git a/arch/arm/include/asm/arch-rockchip/sdram_phy_rk3576.h b/arch/a=
rm/include/asm/arch-rockchip/sdram_phy_rk3576.h
new file mode 100644
index 00000000000..f6221a5434f
--- /dev/null
+++ b/arch/arm/include/asm/arch-rockchip/sdram_phy_rk3576.h
@@ -0,0 +1,363 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RK3576 LPDDR4/4X/5 combo PHY register definitions.
+ *
+ * The RK3576 uses a Synopsys DesignWare LPDDR4/4X/5 combo PHY.
+ * This PHY is a different generation from the px30/rk3568 PHY and
+ * has a hardware training engine =E2=80=94 no Synopsys training firmware =
needed.
+ * (TRM Part 2 =C2=A77.6.x confirmed firmware-free training via phy_train_=
en.)
+ *
+ * Operational bases (TRM Part 2 =C2=A77.4.4):
+ *   DDRPHY0  0x2A020000
+ *   DDRPHY1  0x2A030000
+ *
+ * All offsets are relative to the DDRPHY operational base.
+ * TRM Part 2 =C2=A77.4.5 "Registers Summary For DDRPHY" (pp.790-810).
+ */
+
+#ifndef _ASM_ARCH_SDRAM_PHY_RK3576_H
+#define _ASM_ARCH_SDRAM_PHY_RK3576_H
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+/* -----------------------------------------------------------------------
+ * Core calibration and control registers (TRM p.790)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_GNR_CON0=09=09=090x0000=09/* reset: 0x44005011 */
+#define DDRPHY_CAL_CON0=09=09=090x0004=09/* reset: 0x789606C0 */
+#define DDRPHY_CAL_CON1=09=09=090x0008=09/* reset: 0x20142001 */
+#define DDRPHY_CAL_CON2=09=09=090x000C=09/* reset: 0x42001300 */
+#define DDRPHY_CAL_CON3=09=09=090x0010=09/* reset: 0xFC7F9000 */
+#define DDRPHY_CAL_CON4=09=09=090x0014=09/* reset: 0x0083806F */
+#define DDRPHY_LP_CON0=09=09=090x0018=09/* reset: 0x000C4403 */
+#define DDRPHY_GATE_CON0=09=090x001C=09/* reset: 0x03003003 */
+
+/* -----------------------------------------------------------------------
+ * Read/write DQ and gate offset/shift registers (TRM p.790)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_OFFSETR_CON0=09=090x0020=09/* reset: 0x00000000 */
+#define DDRPHY_OFFSETW_CON0=09=090x0030=09/* reset: 0x00000000 */
+#define DDRPHY_OFFSET_DQ_CON0=09=090x003C=09/* reset: 0x00000000 */
+#define DDRPHY_OFFSETC_CON0=09=090x0040=09/* reset: 0x00000000 */
+#define DDRPHY_SHIFTC_CON0=09=090x004C=09/* reset: 0x00000000 */
+#define DDRPHY_OFFSETD_CON0=09=090x0050=09/* reset: 0x00000000 */
+#define DDRPHY_OFFSETO_CON0=09=090x0058=09/* reset: 0x00000000 */
+
+/* -----------------------------------------------------------------------
+ * Write levelling (TRM p.790)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_WR_LVL_CON0=09=090x006C=09/* reset: 0x00000000 */
+#define DDRPHY_WR_LVL_CON1=09=090x0070=09/* reset: 0x01E80473 */
+#define DDRPHY_WR_LVL_CON2=09=090x0074=09/* reset: 0x40465580 */
+#define DDRPHY_WR_LVL_CON3=09=090x0078=09/* reset: 0x00000B00 */
+
+/* -----------------------------------------------------------------------
+ * CA de-skew (TRM p.790)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_CA_DESKEW_CON0=09=090x007C=09/* reset: 0x00000000 */
+#define DDRPHY_CA_DESKEW_CON1=09=090x0080=09/* reset: 0x00000000 */
+#define DDRPHY_CA_DESKEW_CON2=09=090x0084=09/* reset: 0x00000000 */
+#define DDRPHY_CA_DESKEW_CON3=09=090x0088=09/* reset: 0x00000000 */
+#define DDRPHY_CA_DESKEW_CON4=09=090x008C=09/* reset: 0x00000000 */
+#define DDRPHY_CA_DESKEW_CON5=09=090x0090=09/* reset: 0x00000000 */
+#define DDRPHY_CA_DESKEW_CON6=09=090x0094=09/* reset: 0x00000000 */
+
+/* -----------------------------------------------------------------------
+ * Write/read calibration pattern registers (TRM p.790-791)
+ * CAL_WR_PATTERN_CON0-4:  BL1-BL8 / DM pattern (BL16 burst)
+ * CAL_WR_PATTERN_CON5-19: BL9-BL16 / DM pattern continuation
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_CAL_WR_PATTERN_CON0=090x0098=09/* reset: 0x00FF00FF */
+#define DDRPHY_CAL_WR_PATTERN_CON1=090x009C=09/* reset: 0x00FF00FF */
+#define DDRPHY_CAL_WR_PATTERN_CON2=090x00A0=09/* reset: 0x00FF00FF */
+#define DDRPHY_CAL_WR_PATTERN_CON3=090x00A4=09/* reset: 0x00FF00FF */
+#define DDRPHY_CAL_WR_PATTERN_CON4=090x00A8=09/* reset: 0x00005555 */
+#define DDRPHY_CAL_RD_PATTERN_CON0=090x00AC=09/* reset: 0x55555A3C */
+
+/* Extended write pattern: BL9-BL16 (starting offset extracted from TRM p.=
800) */
+#define DDRPHY_CAL_WR_PATTERN_CON5=090x093C
+#define DDRPHY_CAL_WR_PATTERN_CON6=090x0940
+#define DDRPHY_CAL_WR_PATTERN_CON7=090x0944
+#define DDRPHY_CAL_WR_PATTERN_CON8=090x0948
+#define DDRPHY_CAL_WR_PATTERN_CON9=090x094C
+#define DDRPHY_CAL_WR_PATTERN_CON10=090x0950
+#define DDRPHY_CAL_WR_PATTERN_CON11=090x0954
+#define DDRPHY_CAL_WR_PATTERN_CON12=090x0958
+#define DDRPHY_CAL_WR_PATTERN_CON13=090x095C
+#define DDRPHY_CAL_WR_PATTERN_CON14=090x0960
+#define DDRPHY_CAL_WR_PATTERN_CON15=090x0964
+#define DDRPHY_CAL_WR_PATTERN_CON16=090x0968
+#define DDRPHY_CAL_WR_PATTERN_CON17=090x096C
+#define DDRPHY_CAL_WR_PATTERN_CON18=090x0970
+#define DDRPHY_CAL_WR_PATTERN_CON19=090x0974
+
+/* -----------------------------------------------------------------------
+ * MDLL control (TRM p.791)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_MDLL_CON0=09=090x00B0=09/* reset: 0x2000017E */
+#define DDRPHY_MDLL_CON1=09=090x00B4=09/* reset: 0x00200100 */
+#define DDRPHY_MDLL_CON2=09=090x0AFC=09/* reset: (see TRM) */
+
+/* -----------------------------------------------------------------------
+ * DVFS control registers (TRM p.791)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_DVFS_CON=09=09=090x00B8=09/* reset: 0x00002640 */
+#define DDRPHY_DVFS0_CON0=09=090x00BC=09/* reset: 0x64080C06 */
+#define DDRPHY_DVFS1_CON0=09=090x00C0=09/* reset: 0x64080C06 */
+#define DDRPHY_DVFS0_CON1=09=090x00C4=09/* reset: 0x30800000 */
+#define DDRPHY_DVFS1_CON1=09=090x00C8=09/* reset: 0x30800000 */
+#define DDRPHY_DVFS0_CON2=09=090x00CC=09/* reset: 0x60062001 */
+#define DDRPHY_DVFS1_CON2=09=090x00D0=09/* reset: 0x60062001 */
+#define DDRPHY_DVFS0_CON3=09=090x00D4=09/* reset: 0x0003FFFF */
+#define DDRPHY_DVFS1_CON3=09=090x00D8=09/* reset: 0x0003FFFF */
+#define DDRPHY_DVFS0_CON4=09=090x00DC=09/* reset: 0x00243F3F */
+#define DDRPHY_DVFS1_CON4=09=090x00E0=09/* reset: 0x00243F3F */
+#define DDRPHY_DVFS0_CON5=09=090x0934
+#define DDRPHY_DVFS1_CON5=09=090x0938
+#define DDRPHY_DVFS_UPD_CON0=09=090x0164=09/* reset: 0x003F3F3F */
+#define DDRPHY_DVFS_UPD_CON1=09=090x0168=09/* reset: 0x003F3F3F */
+
+/* -----------------------------------------------------------------------
+ * Training status/result registers (TRM p.791)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_CAL_WRLVL_STAT=09=090x00E4=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_FAIL_STAT0=09=090x00E8=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_FAIL_STAT1=09=090x00EC=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_GT_CS0_VWMC0=09=090x00F0=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_GT_CS0_CYC=09=090x00FC=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_RD_VWMC0=09=090x0100=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_RD_VWML0=09=090x0110=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_RD_VWMR0=09=090x0120=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_WR_VWMC0=09=090x0130=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_WR_VWML0=09=090x0140=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_WR_VWMR0=09=090x0150=09/* reset: 0x00000000 */
+#define DDRPHY_CAL_CON5=09=09=090x0160=09/* reset: 0x00000000 */
+
+/* -----------------------------------------------------------------------
+ * ZQ calibration (TRM p.792-793)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_ZQ_CON0=09=09=090x03C8=09/* reset: 0xFF807404 */
+#define DDRPHY_ZQ_CON1=09=09=090x03CC=09/* reset: 0x00140000 */
+#define DDRPHY_ZQ_CON2=09=09=090x03D0=09/* reset: 0x001E0002 */
+#define DDRPHY_ZQ_CON3=09=09=090x03D4=09/* reset: 0x003F3F3F */
+#define DDRPHY_ZQ_CON5=09=09=090x03DC=09/* reset: 0x073F0000 */
+#define DDRPHY_ZQ_CON6=09=09=090x03E0=09/* reset: 0x00002121 */
+#define DDRPHY_ZQ_CON9=09=09=090x03EC=09/* reset: 0x00001414 */
+#define DDRPHY_ZQ_CON12=09=09=090x03F8=09/* reset: 0x00000707 */
+#define DDRPHY_TESTIRCV_CON0=09=090x0400=09/* reset: 0x00080000 */
+
+/* -----------------------------------------------------------------------
+ * CBT (Command-Bus Training) registers (TRM p.793)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_CBT_CON0=09=09=090x0600
+#define DDRPHY_CBT_CON2=09=09=090x0608
+#define DDRPHY_CBT_CON3=09=09=090x060C
+#define DDRPHY_CBT_CON5=09=09=090x05F4
+#define DDRPHY_CBT_CMD=09=09=090x05FC
+#define DDRPHY_CBT_CAL_STAT0=09=090x0BC4
+
+/* -----------------------------------------------------------------------
+ * Training scheduler =E2=80=94 core init and training control (TRM p.802)
+ * These are the primary registers for TPL hardware-assisted training.
+ * TRM =C2=A77.6.x: set phy_train_en=3D1, poll phy_train_done=3D1.
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRPHY_SCHD_CON0=09=090x0A20
+#define DDRPHY_SCHD_TRAIN_CON0=09=090x0A24
+#define DDRPHY_SCHD_TRAIN_CON1=09=090x0A28
+#define DDRPHY_SCHD_TIME_CON0=09=090x0A2C
+#define DDRPHY_SCHD_TIME_CON1=09=090x0A30
+#define DDRPHY_SCHD_TIME_CON2=09=090x0A34
+#define DDRPHY_SCHD_TIME_CON3=09=090x0A38
+
+/* DVFS scheduler timing (runtime DVFS, not needed for TPL init) */
+#define DDRPHY_DVFS0_SCHD_TIME_CON0=090x0A3C
+#define DDRPHY_DVFS0_SCHD_TIME_CON1=090x0A40
+#define DDRPHY_DVFS0_SCHD_TIME_CON2=090x0A44
+#define DDRPHY_DVFS0_SCHD_TIME_CON3=090x0A48
+#define DDRPHY_DVFS1_SCHD_TIME_CON0=090x0A4C
+#define DDRPHY_DVFS1_SCHD_TIME_CON1=090x0A50
+#define DDRPHY_DVFS1_SCHD_TIME_CON2=090x0A54
+#define DDRPHY_DVFS1_SCHD_TIME_CON3=090x0A58
+
+/* Direct command injection */
+#define DDRPHY_SCHD_DIRECT_CMD0=09=090x0A5C
+#define DDRPHY_SCHD_DIRECT_CMD1=09=090x0A60
+#define DDRPHY_SCHD_DIRECT_CMD2=09=090x0A64
+#define DDRPHY_SCHD_DIRECT_CMD3=09=090x0A68
+#define DDRPHY_SCHD_DIRECT_CMD4=09=090x0A6C
+#define DDRPHY_SCHD_CMD_CON0=09=090x0A70
+#define DDRPHY_SCHD_CMD_CON1=09=090x0A74
+#define DDRPHY_SCHD_CMD_CON2=09=090x0A78
+#define DDRPHY_OP_CODE_RDC=09=090x0A7C
+
+/* LPDDR4/5 MR operation buffers */
+#define DDRPHY_LP4_MR_OP0=09=090x0A80
+#define DDRPHY_LP4_MR_OP1=09=090x0A84
+#define DDRPHY_LP5_MR_OP0=09=090x0A88
+#define DDRPHY_LP5_MR_OP1=09=090x0A8C
+
+/* Training scheduler FSM and clock mode */
+#define DDRPHY_SCHD_FSM=09=09=090x0A90
+#define DDRPHY_CLKMODE_CON=09=090x0A94
+#define DDRPHY_CASWIZZLE_CON=09=090x0A98
+
+/* WCK2CK sync control =E2=80=94 LPDDR5 only (TRM p.985) */
+#define DDRPHY_WCK2CKSYNC_CON0=09=090x0ADC=09/* reset: 0x00000000 */
+#define DDRPHY_WCK2CKSYNC_CON1=09=090x0AE0=09/* reset: 0x23340758 */
+
+/* -----------------------------------------------------------------------
+ * Register field macros =E2=80=94 verified against TRM Part 2 =C2=A77.4.6=
 pp.808-980
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * DDRPHY_GNR_CON0 (reset 0x44005011)
+ * ctrl_ddr_mode [25:24]: 0=3DLPDDR4, 2=3DLPDDR5  (TRM p.808)
+ * wdqs_oen_mode   [19]: LPDDR5 must set; DQS driven only during writes
+ */
+#define GNR_CON0_CTRL_DDR_MODE_MASK=09GENMASK(25, 24)
+#define GNR_CON0_DDR_MODE_LPDDR4=09(0x0 << 24)
+#define GNR_CON0_DDR_MODE_LPDDR5=09(0x2 << 24)
+#define GNR_CON0_WDQS_OEN_MODE=09=09BIT(19)
+
+/*
+ * DDRPHY_LP_CON0 (reset 0x000C4403)
+ * ctrl_scheduler_en [6]: enable PHY scheduler clock (set for LP4 and LP5)
+ * ctrl_dqs_drv_off  [8]: DQS driver off =E2=80=94 set for LPDDR5 when no =
ECC
+ * wck_enable        [9]: WCK enable =E2=80=94 LPDDR5 only
+ * (TRM p.821)
+ */
+#define LP_CON0_CTRL_SCHEDULER_EN=09BIT(6)
+#define LP_CON0_CTRL_DQS_DRV_OFF=09BIT(8)
+#define LP_CON0_WCK_ENABLE=09=09BIT(9)
+
+/*
+ * DDRPHY_MDLL_CON0 (reset 0x2000017E)
+ * ctrl_dll_on   [5]:     high =3D DLL on (keep high for normal op)
+ * ctrl_start    [6]:     0=E2=86=921 pulse starts DLL locking
+ * ctrl_force  [18:8]:    force lock value when DLL is off (11-bit)
+ * clkm_cg_en_sw [23]:   freeze DLL lock value during freq change
+ * (TRM p.835)
+ */
+#define MDLL_CON0_CTRL_DLL_ON=09=09BIT(5)
+#define MDLL_CON0_CTRL_START=09=09BIT(6)
+#define MDLL_CON0_CTRL_FORCE_MASK=09GENMASK(18, 8)
+#define MDLL_CON0_CTRL_FORCE(x)=09((x) << 8)
+#define MDLL_CON0_CLKM_CG_EN_SW=09BIT(23)
+/* ctrl_force value for low-frequency (<100 MHz) LPDDR5 init (TRM =C2=
=A77.6.3 step 24) */
+#define MDLL_CON0_CTRL_FORCE_LOW_FREQ=09MDLL_CON0_CTRL_FORCE(0x2ef)
+
+/*
+ * DDRPHY_MDLL_CON1 (reset 0x00200100)
+ * ctrl_locked [18]: RO, DLL stable lock =E2=80=94 poll until set after ct=
rl_start
+ * (TRM p.835)
+ */
+#define MDLL_CON1_CTRL_LOCKED=09=09BIT(18)
+
+/*
+ * DDRPHY_CLKMODE_CON (reset 0x00000009)
+ * ctrl_phy_clk_2x [3]:   1=3DPHY 2x clock (always 1 in LP4/5)
+ * ctrl_phy_mode [2:0]:   clock ratio MC:CK:DQS/WCK (TRM p.980)
+ *   1 =3D LPDDR4 1:2:2
+ *   2 =3D LPDDR5 1:1:2 (CLK_DFI:CK:WCK)
+ *   4 =3D LPDDR5 1:1:4 (Flipper One operating mode)
+ */
+#define CLKMODE_CON_PHY_CLK_2X=09=09BIT(3)
+#define CLKMODE_CON_PHY_MODE_MASK=09GENMASK(2, 0)
+#define CLKMODE_CON_PHY_MODE_LPDDR4=091
+#define CLKMODE_CON_PHY_MODE_LP5_1_2=092
+#define CLKMODE_CON_PHY_MODE_LP5_1_4=094
+
+/*
+ * DDRPHY_CAL_CON0 (reset 0x789606C0)
+ * cal_vtc_en       [22]: VT compensation =E2=80=94 enable after training
+ * dvfs_wr_train_en [26]: after initial training, re-interprets write trai=
ning
+ * (TRM p.810)
+ */
+#define CAL_CON0_CAL_VTC_EN=09=09BIT(22)
+#define CAL_CON0_DVFS_WR_TRAIN_EN=09BIT(26)
+
+/*
+ * DDRPHY_CAL_CON5 (reset 0x00000000, offset 0x0160)
+ * wrtrn_cyc_mode [0]: 0=3Dmatched edge codes (>=3D 1 GHz), 1=3Dunmatched
+ * wrtrn_cyc_en   [1]: cycle-based write training (enable for LPDDR4)
+ * (TRM p.850)
+ */
+#define CAL_CON5_WRTRN_CYC_MODE=09BIT(0)
+#define CAL_CON5_WRTRN_CYC_EN=09=09BIT(1)
+
+/*
+ * DDRPHY_OFFSETD_CON0 (reset 0x00000000, offset 0x0050)
+ * ctrl_resync [24]: toggle 0=E2=86=921=E2=86=920 to push DLL updates to s=
lave DLLs
+ * upd_mode    [28]: 0=3DPHY-initiated update (dfi_phyupd_req)
+ * (TRM p.809 and =C2=A77.6.x DLL update procedure)
+ */
+#define OFFSETD_CON0_CTRL_RESYNC=09BIT(24)
+#define OFFSETD_CON0_UPD_MODE=09=09BIT(28)
+
+/*
+ * DDRPHY_SCHD_TRAIN_CON0 (reset 0x00000000, offset 0x0A24)
+ * phy_train_en   [0]:  RW =E2=80=94 set to start hardware training engine
+ * phy_train_done [1]:  RO =E2=80=94 poll until set, then clear phy_train_=
en
+ * phy_wrtrn_en   [5]:  enable write training
+ * phy_gttrn_en   [3]:  enable gate training
+ * (TRM p.965)
+ */
+#define TRAIN_CON0_PHY_TRAIN_EN=09=09BIT(0)
+#define TRAIN_CON0_PHY_TRAIN_DONE=09BIT(1)
+#define TRAIN_CON0_PHY_GTTRN_EN=09BIT(3)
+#define TRAIN_CON0_PHY_WRTRN_EN=09BIT(5)
+#define TRAIN_CON0_DVFS_WRTRN_EN_MASK=09GENMASK(19, 18)
+#define TRAIN_CON0_PERIODIC_WRTRN_EN_MASK=09GENMASK(23, 22)
+
+/*
+ * DDRPHY_ZQ_CON0 (reset 0xFF807404, offset 0x03C8)
+ * zq_clk_div_en [18]: enable ZQ clock divider before calibration (TRM p.8=
60)
+ * zq_manual_str  [1]: 0=E2=86=921 pulse starts manual ZQ calibration (TRM=
 p.861)
+ * DDRPHY_ZQ_CON1 (reset 0x00140000, offset 0x03CC)
+ * zq_done        [0]: RO =E2=80=94 high when calibration complete (TRM p.=
862)
+ */
+#define ZQ_CON0_ZQ_CLK_DIV_EN=09=09BIT(18)
+#define ZQ_CON0_ZQ_MANUAL_STR=09=09BIT(1)
+#define ZQ_CON1_ZQ_DONE=09=09=09BIT(0)
+
+/*
+ * DDRPHY_WCK2CKSYNC_CON0 (reset 0x00000000, offset 0x0ADC)
+ * ctrl_WCK_MODE_APB [1:0]: WCK driving policy (TRM p.985)
+ *   0b00: PHY/MC normal (WCK always-on disabled), CAS_EN must be 1
+ *   0b01: MC WCK always-on mode, CAS_EN must be 0
+ * DDRPHY_SCHD_CMD_CON0 (reset ~0x1 at bit 0)
+ * CAS_EN_APB [0]: enable WCK2CK SYNC by scheduler (TRM p.976)
+ */
+#define WCK2CKSYNC_CON0_WCK_MODE_MASK=09GENMASK(1, 0)
+#define WCK2CKSYNC_CON0_WCK_MODE_ALWAYS_ON=09(0x1)
+#define SCHD_CMD_CON0_CAS_EN_APB=09BIT(0)
+
+/* DDRPHY_CAL_FAIL_STAT0 =E2=80=94 non-zero means training failed */
+#define CAL_FAIL_STAT0_ANY_FAIL=09=09GENMASK(31, 0)
+
+#endif /* _ASM_ARCH_SDRAM_PHY_RK3576_H */
--=20
2.45.1.windows.1


