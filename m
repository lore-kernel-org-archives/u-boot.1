Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58629CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D7384832;
	Mon, 25 May 2026 04:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="FJJdAKoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3552E83EF9; Mon, 25 May 2026 03:29:30 +0200 (CEST)
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399788039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672566; x=1779931766;
 bh=OTCBV16Pw8lfnH2aAMlkBwValzVmXdOAgt8Muwue74Q=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FJJdAKoqWk+yhkvRoLHLsd+cYp5xLfUbBc23sSSw1UUy5a+wU4fzTf3ouLdTTT9uN
 OpIIUd+pyfQhBc2vZoPZEyY7YWma2Es4UE5SMhHHKMkCdxR2qYvi44G52TnzKmxzXf
 AGPkkankB4CjAknufMoJh3VbJ1UUmqvzy4qQ8nctauni/pWVrmnnSSrheHYN84bS3/
 sknkcnKSMDde6civDWNo9IsZc9DQ5tpiyLnTABDjtR7b//xzoCYMEdlHGDF1kRqnf/
 JbsjPayUlljWbrxOON5D4xbDf86WMLs1JaR2jd95yCOkORVbvwDyaud6MSfrz3vCxW
 dXctukjVsaleA==
Date: Mon, 25 May 2026 01:29:22 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 07/14] ram: rockchip: add RK3576 DRAM platform header
Message-ID: <20260525012824.121-8-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 57cbcc5764ad22fbe00bff2a6c131aa3b4be03d6
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

Add sdram_rk3576.h with top-level data structures and platform defines
for the RK3576 DDR subsystem:

  - Physical base addresses for DDRCTL0/1, DDRPHY0/1, DDR_GRF,
    PMU1GRF, CRU, DDR0/1CRU (TRM Part 1, Table 1-1)
  - DDR sub-CRU clock-select register offsets and mux bits
  - PMU1GRF OS_REG2/3 offsets for trained geometry storage
  - DDR_GRF register offsets (PHY clock gate, LPDDR5 CS toggle,
    dfi_init_complete mux) with write-mask convention notes
  - SR_IDLE / PD_IDLE conservative defaults
  - struct rk3576_ddrctl_freq_params  =E2=80=94 43-field per-frequency bloc=
k
  - struct rk3576_ddrctl_global_params =E2=80=94 16-field static DDRCTL blo=
ck
  - struct rk3576_sdram_channel       =E2=80=94 per-channel cap_info wrappe=
r
  - struct rk3576_sdram_params        =E2=80=94 top-level timing-table type

DRAM type codes (LPDDR4=3D7, LPDDR4X=3D8, LPDDR5=3D9) are inherited from
sdram.h via the new #include; no conflicting local defines.

TRM Part 2 =C2=A77.3.1 / =C2=A77.6.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 .../include/asm/arch-rockchip/sdram_rk3576.h  | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_rk3576.h

diff --git a/arch/arm/include/asm/arch-rockchip/sdram_rk3576.h b/arch/arm/i=
nclude/asm/arch-rockchip/sdram_rk3576.h
new file mode 100644
index 00000000000..bdeaf9b3c38
--- /dev/null
+++ b/arch/arm/include/asm/arch-rockchip/sdram_rk3576.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RK3576 DRAM init =E2=80=94 top-level data structures and platform defin=
es.
+ *
+ * The RK3576 DDR subsystem consists of two independent channels, each
+ * containing one uMCTL2 DDRCTL and one LPDDR4/4X/5 combo PHY (DDRPHY).
+ * Supported types: LPDDR4, LPDDR4X, LPDDR5 (TRM Part 2 =C2=A77.1).
+ * This file defines:
+ *   - DDRPLL and DDR_CRU registers (clock setup)
+ *   - PMU1GRF OS_REG layout (trained parameter storage)
+ *   - DDR_GRF register offsets (clock gate, CS toggle, DFI mux)
+ *   - DRAM type codes
+ *   - Per-frequency timing parameter struct (for .inc timing tables)
+ *   - OF_PLATDATA struct for the DMC device tree node
+ *   - Per-channel capacity info and top-level sdram_params
+ */
+
+#ifndef _ASM_ARCH_SDRAM_RK3576_H
+#define _ASM_ARCH_SDRAM_RK3576_H
+
+#include <asm/arch-rockchip/sdram.h>
+#include <asm/arch-rockchip/sdram_common.h>
+#include <asm/arch-rockchip/sdram_pctl_rk3576.h>
+#include <asm/arch-rockchip/sdram_phy_rk3576.h>
+
+/* -----------------------------------------------------------------------
+ * Physical base addresses (TRM Part 1, Table 1-1)
+ * -----------------------------------------------------------------------
+ */
+
+#define RK3576_DDRCTL0_BASE=09=090x28000000
+#define RK3576_DDRCTL1_BASE=09=090x29000000
+#define RK3576_DDRPHY0_BASE=09=090x2A020000
+#define RK3576_DDRPHY1_BASE=09=090x2A030000
+#define RK3576_DDR_GRF_BASE=09=090x26012000
+#define RK3576_PMU1GRF_BASE=09=090x26026000
+#define RK3576_CRU_BASE=09=09=090x27200000
+/* DDR sub-CRUs (TRM Part 1) */
+#define RK3576_DDR0CRU_BASE=09=090x27210000
+#define RK3576_DDR1CRU_BASE=09=090x27220000
+
+/* -----------------------------------------------------------------------
+ * DDR clock mux registers (TRM Part 1 CRU chapter)
+ * DDR0CRU_CLKSEL_CON00[0]: 0=3DD0APLL (default 24 MHz), 1=3DD0BPLL (targe=
t freq)
+ * DDR1CRU_CLKSEL_CON00[0]: same for channel 1
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRCRU_CLKSEL_CON00=09=090x0100
+#define DDRCRU_CLKSEL_D0BPLL=09=09BIT(0)
+#define DDRCRU_CLKSEL_D0APLL=09=090
+
+/* -----------------------------------------------------------------------
+ * PMU1GRF OS_REG =E2=80=94 stores trained DRAM geometry for SPL + Linux
+ * PMU1GRF base 0x26026000; OS_REG2 at +0x208 (TRM Part 1)
+ * Layout matches the common Rockchip sys_reg format (sdram_common.h).
+ * -----------------------------------------------------------------------
+ */
+
+#define RK3576_PMUGRF_OS_REG2=09=090x208
+#define RK3576_PMUGRF_OS_REG3=09=090x20C
+
+/* -----------------------------------------------------------------------
+ * DDR_GRF registers (base 0x26012000, TRM Part 2 =C2=A77.3.1 / app notes =
=C2=A77.6)
+ *
+ * DDR_GRF is distinct from SYS_GRF; it controls:
+ *   - PHY 2x clock gate enable
+ *   - LPDDR5 CS toggle
+ *   - dfi_init_complete mux source
+ * Registers use the Rockchip write-mask convention: bits[31:16] are the
+ * write-enable masks for bits[15:0].
+ * -----------------------------------------------------------------------
+ */
+
+/* Channel A (ch0) PHY clock gate */
+#define DDR_GRF_CHA_PHY_CON0=09=090x0000
+#define DDR_GRF_CHA_PHY_CON1=09=090x0004
+/* Channel B (ch1) PHY clock gate */
+#define DDR_GRF_CHB_PHY_CON0=09=090x0100
+#define DDR_GRF_CHB_PHY_CON1=09=090x0104
+
+/* PHY 2x clock gate enable bit within CHA/CHB_PHY_CON0 and CON1 */
+#define PHY_CON_DDRPHY2XCLKGATE_EN=09BIT(3)
+
+/* LPDDR5 CS toggle control (DDR_GRF_CHA/CHB_CON2[7:0]) */
+#define DDR_GRF_CHA_CON2=09=090x0008
+#define DDR_GRF_CHB_CON2=09=090x0108
+#define CON2_LP5_CS_TOGGLE_MASK=09=09GENMASK(7, 0)
+
+/* dfi_init_complete source mux (GRF_CHA/CHB_DDRPHY_CON0[5:4]) */
+#define GRF_CHA_DDRPHY_CON0=09=090x0020
+#define GRF_CHB_DDRPHY_CON0=09=090x0120
+#define DDRPHY_CON0_DFI_INIT_COMP_SEL_MASK=09GENMASK(5, 4)
+#define DDRPHY_CON0_DFI_INIT_COMP_FROM_PHY=09(0x1 << 4)
+
+/* Number of FREQ sets supported by DDRCTL */
+#define RK3576_DDRCTL_NFREQS=09=094
+
+/* -----------------------------------------------------------------------
+ * Per-frequency timing parameter block.
+ * One instance per FREQ set per channel.  The .inc timing table files
+ * initialise arrays of this struct.
+ *
+ * Register names match the DDRCTL_* defines in sdram_pctl_rk3576.h.
+ * The FREQ bank base address is DDRCTL_FREQ_BASE(freq_idx).
+ * -----------------------------------------------------------------------
+ */
+
+struct rk3576_ddrctl_freq_params {
+=09/* Timing set 1 (TRM p.591) */
+=09u32 dramset1tmg0;
+=09u32 dramset1tmg1;
+=09u32 dramset1tmg2;
+=09u32 dramset1tmg3;
+=09u32 dramset1tmg4;
+=09u32 dramset1tmg5;
+=09u32 dramset1tmg6;
+=09u32 dramset1tmg7;
+=09u32 dramset1tmg8;
+=09u32 dramset1tmg9;
+=09u32 dramset1tmg12;
+=09u32 dramset1tmg13;
+=09u32 dramset1tmg14;
+=09u32 dramset1tmg23;
+=09u32 dramset1tmg24;
+=09u32 dramset1tmg25;
+=09u32 dramset1tmg30;
+
+=09/* MR initialization values */
+=09u32 initmr0;
+=09u32 initmr1;
+=09u32 initmr2;
+=09u32 initmr3;
+
+=09/* DFI timing */
+=09u32 dfitmg0;
+=09u32 dfitmg1;
+=09u32 dfitmg2;
+=09u32 dfitmg4;
+=09u32 dfitmg5;
+=09u32 dfilptmg0;
+=09u32 dfilptmg1;
+=09u32 dfiupdtmg0;
+=09u32 dfiupdtmg1;
+=09u32 dfimsgtmg0;
+
+=09/* Refresh timing */
+=09u32 rfshset1tmg0;
+=09u32 rfshset1tmg1;
+=09u32 rfshset1tmg2;
+=09u32 rfshset1tmg4;
+
+=09/* ZQ timing */
+=09u32 zqset1tmg0;
+=09u32 zqset1tmg1;
+
+=09/* Scheduler */
+=09u32 perfhpr1;
+=09u32 perflpr1;
+=09u32 perfwr1;
+=09u32 ranktmg0;
+=09u32 ranktmg1;
+=09u32 pwrtmg;
+};
+
+/* -----------------------------------------------------------------------
+ * Global DDRCTL static parameters (programmed once during init).
+ * These values go into the global register section (0x10000+) of DDRCTL.
+ * -----------------------------------------------------------------------
+ */
+
+struct rk3576_ddrctl_global_params {
+=09u32 mstr0;
+=09u32 rankctl;
+=09u32 dbictl;
+=09u32 odtmap;
+=09u32 inittmg0;
+=09u32 inittmg1;
+=09u32 rfshmod0;
+=09u32 sched0;
+=09u32 sched1;
+=09u32 sched3;
+=09u32 sched4;
+=09u32 dfilpcfg0;
+=09u32 dfiupd0;
+=09u32 dfiphymstr;
+=09u32 zqctl0;
+=09u32 zqctl1;
+};
+
+/* -----------------------------------------------------------------------
+ * Per-channel DRAM geometry detected at run-time.
+ * Stored in PMU1GRF OS_REG2/3 for SPL and Linux to consume.
+ * -----------------------------------------------------------------------
+ */
+
+struct rk3576_sdram_channel {
+=09struct sdram_cap_info cap_info;
+};
+
+/* -----------------------------------------------------------------------
+ * Top-level sdram_params struct =E2=80=94 one per supported board configu=
ration.
+ * Timing table .inc files declare const arrays of this type.
+ * -----------------------------------------------------------------------
+ */
+
+struct rk3576_sdram_params {
+=09struct rk3576_sdram_channel ch[2];  /* channel 0 and 1 */
+=09struct sdram_base_params base;
+=09/* Per-frequency timing for each FREQ set */
+=09struct rk3576_ddrctl_freq_params freq[RK3576_DDRCTL_NFREQS];
+=09/* Global static DDRCTL parameters */
+=09struct rk3576_ddrctl_global_params ctl;
+};
+
+/*
+ * OF_PLATDATA note: dtoc auto-generates struct dtd_rockchip_rk3576_dmc
+ * into dt-plat.h from the DMC DT node (compatible "rockchip,rk3576-dmc").
+ * The driver includes dt-plat.h and accesses:
+ *   dtplat->reg[0..3]  =E2=80=94 ddrctl0, ddrctl1, ddrphy0, ddrphy1 base =
addresses
+ * Do not define dtd_rockchip_rk3576_dmc here; dtoc owns that struct.
+ */
+
+/* -----------------------------------------------------------------------
+ * Self-refresh idle and power-down idle (ticks of 32-cycle counter).
+ * These are conservative defaults; runtime PM can tune them.
+ * -----------------------------------------------------------------------
+ */
+
+#define SR_IDLE=09=09=09=0993
+#define PD_IDLE=09=09=09=0913
+
+int sdram_init(void);
+
+#endif /* _ASM_ARCH_SDRAM_RK3576_H */
--=20
2.45.1.windows.1


