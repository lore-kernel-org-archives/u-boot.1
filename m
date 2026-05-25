Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425CACD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF618485F;
	Mon, 25 May 2026 04:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="TOAvmiCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727B583DA6; Mon, 25 May 2026 03:29:43 +0200 (CEST)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D128039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672580; x=1779931780;
 bh=RrR2GiGExMD0xuKTsCumCwtzczaM6P8p9707GP8OXWg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=TOAvmiCAGy/ofbl6DDGkk0p0I6/Zg4hE41C/YLKiQGz1U7iYeZUKVreCqq2aGq5cT
 WlZ6qWGJEhjOlM6BJpqzPT3+8nzLyKskDRBFisiGXYUSX0aj/Vrqy43mFhu53E1nVa
 BULL+YBWANV8kJ5iOfcka9rEYLoJi7/5Gonv1oEnGUmScH9WiUmHrDeATcjqfKymGO
 dIpNTyGlxi4joEerc9vU/jCIvNFeq67iqlQs+ZBq7uXpJYi0W28NiEZMGHO0lJMTZr
 3KUoccnjzdseeAbwl3Y+q4NrdD3uLLN8uflNILzNBycdmkVQNGOt8PV6l3r5D6UDVZ
 z5HooCL1dumpg==
Date: Mon, 25 May 2026 01:29:36 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 10/14] ram: rockchip: rk3576: add LPDDR4 timing table
 placeholder (1560 MHz)
Message-ID: <20260525012824.121-11-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 9bc36ffe15f13188b1811df5b121e0059e2b3483
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

Add sdram-rk3576-lpddr4-detect-1560.inc: a compileable timing table
for LPDDR4 at CK =3D 1560 MHz (data rate =E2=89=88 LPDDR4X-3120).

All timing register values are TRM reset defaults and are NOT correct
for 1560 MHz operation.  The file exists so the driver compiles with
CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy.  Hardware bring-up will fail until the
timing values are replaced with values derived from:
  - JEDEC JESD209-4D LPDDR4/4X timing for the target speed grade
  - Synopsys uMCTL2 SRS field encoding rules
  - The actual DRAM part number and its timing datasheet

Correctly set:
  - mstr0 =3D 0x01080020 (BIT(5)=3Dlpddr4 | 1 rank | BL16 | full BW)
  - cap_info: 4 GB LPDDR4, 2 channels =C3=97 2 GB, 2^16 rows

LPDDR4 is a secondary target; primary is LPDDR5 (W9).

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 .../sdram-rk3576-lpddr4-detect-1560.inc       | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 drivers/ram/rockchip/sdram-rk3576-lpddr4-detect-1560.in=
c

diff --git a/drivers/ram/rockchip/sdram-rk3576-lpddr4-detect-1560.inc b/dri=
vers/ram/rockchip/sdram-rk3576-lpddr4-detect-1560.inc
new file mode 100644
index 00000000000..3f01a49edf0
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3576-lpddr4-detect-1560.inc
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RK3576 LPDDR4 timing table =E2=80=94 CK =3D 1560 MHz (data rate =
=E2=89=88 LPDDR4X-3120).
+ *
+ * PLACEHOLDER =E2=80=94 timing register values below are TRM reset defaul=
ts
+ * and are NOT correct for 1560 MHz LPDDR4 operation.  Hardware bring-up
+ * will fail until these are replaced with values calculated from:
+ *
+ *   1. JEDEC JESD209-4D LPDDR4/4X timing parameters for the target speed
+ *   2. Synopsys uMCTL2 Software Requirements Specification (SRS) field
+ *      encoding rules
+ *   3. The actual DRAM part number and its timing datasheet
+ *
+ * Specifically wrong at 1560 MHz:
+ *   dramset1tmg0.t_ras_min  TRM reset =3D 15 cyc (9.6 ns); JEDEC min =3D =
42 ns
+ *   dramset1tmg0.wr2pre     needs WL + BL/2 + tWR calculation for LP4
+ *   dfitmg0/1               need tDFI_WRDATA, tDFI_RDDATA_EN for this PHY
+ *   initmr0                 LP4 MR1/MR2 for 1560 MHz RL/WL
+ *   rfshset1tmg0.t_rfc_min  needs LP4 die density (8 Gbit =E2=89=88 210 n=
s)
+ *
+ * W8 work item.  LPDDR4 is a secondary target; primary is LPDDR5 (W9).
+ * This file exists so the driver compiles with CONFIG_RAM_ROCKCHIP_LPDDR4=
=3Dy.
+ */
+
+/*
+ * Shared per-frequency timing block (all four FREQ banks identical
+ * placeholder values; real table would differentiate by operating point).
+ */
+#define LP4_1560_FREQ_TMG=09=09=09=09=09=09\
+{=09=09=09=09=09=09=09=09=09\
+=09/*=09=09=09=09=09=09=09=09\
+=09 * SDRAM timing =E2=80=94 TRM reset values (sdram_pctl_rk3576.h).=09\
+=09 * Replace every field before hardware testing (see header).=09\
+=09 */=09=09=09=09=09=09=09=09\
+=09.dramset1tmg0  =3D 0x0F101B0F, /* t_ras_min/max, t_faw, wr2pre */\
+=09.dramset1tmg1  =3D 0x00080414,=09=09=09=09=09\
+=09.dramset1tmg2  =3D 0x0305060D,=09=09=09=09=09\
+=09.dramset1tmg3  =3D 0x00040404,=09=09=09=09=09\
+=09.dramset1tmg4  =3D 0x05040405,=09=09=09=09=09\
+=09.dramset1tmg5  =3D 0x05050403,=09=09=09=09=09\
+=09.dramset1tmg6  =3D 0x00000005,=09=09=09=09=09\
+=09.dramset1tmg7  =3D 0x00000000,=09=09=09=09=09\
+=09.dramset1tmg8  =3D 0x00004405,=09=09=09=09=09\
+=09.dramset1tmg9  =3D 0x0004040D,=09=09=09=09=09\
+=09.dramset1tmg12 =3D 0x00020000,=09=09=09=09=09\
+=09.dramset1tmg13 =3D 0x1C200004,=09=09=09=09=09\
+=09.dramset1tmg14 =3D 0x000800A0,=09=09=09=09=09\
+=09.dramset1tmg23 =3D 0x00000000,=09=09=09=09=09\
+=09.dramset1tmg24 =3D 0x000F0F0F,=09=09=09=09=09\
+=09.dramset1tmg25 =3D 0x00000000,=09=09=09=09=09\
+=09.dramset1tmg30 =3D 0x00000000,=09=09=09=09=09\
+=09/*=09=09=09=09=09=09=09=09\
+=09 * SDRAM initialization MR values =E2=80=94 LP4 MR1/MR2/MR3/MR11.=09\
+=09 * TODO: encode correct RL/WL/DQ-VREF for 1560 MHz.=09=09\
+=09 * INITMR0[7:0]=3DMR2, INITMR0[23:16]=3DMR1 (uMCTL2 SRS).=09=09\
+=09 */=09=09=09=09=09=09=09=09\
+=09.initmr0 =3D 0x00000510, /* TRM reset */=09=09=09=09\
+=09.initmr1 =3D 0x00000000,=09=09=09=09=09=09\
+=09.initmr2 =3D 0x00000000,=09=09=09=09=09=09\
+=09.initmr3 =3D 0x00000000,=09=09=09=09=09=09\
+=09/* DFI timing =E2=80=94 TRM reset values */=09=09=09=09\
+=09.dfitmg0    =3D 0x07020002,=09=09=09=09=09\
+=09.dfitmg1    =3D 0x00000404,=09=09=09=09=09\
+=09.dfitmg2    =3D 0x00000202,=09=09=09=09=09\
+=09.dfitmg4    =3D 0x00000000,=09=09=09=09=09\
+=09.dfitmg5    =3D 0x00000000,=09=09=09=09=09\
+=09.dfilptmg0  =3D 0x00000000,=09=09=09=09=09\
+=09.dfilptmg1  =3D 0x00000700,=09=09=09=09=09\
+=09.dfiupdtmg0 =3D 0x00400003,=09=09=09=09=09\
+=09.dfiupdtmg1 =3D 0x00010001,=09=09=09=09=09\
+=09.dfimsgtmg0 =3D 0x00000004,=09=09=09=09=09\
+=09/*=09=09=09=09=09=09=09=09\
+=09 * Refresh timing =E2=80=94 TODO: t_rfc_min for LP4 8 Gbit die=09=09\
+=09 * (tRFCab =E2=89=88 380 ns at 1560 MHz =E2=89=88 594 cycles).=09=09=09=
\
+=09 */=09=09=09=09=09=09=09=09\
+=09.rfshset1tmg0 =3D 0x02100062,=09=09=09=09=09\
+=09.rfshset1tmg1 =3D 0x0000008C,=09=09=09=09=09\
+=09.rfshset1tmg2 =3D 0x8C8C0000,=09=09=09=09=09\
+=09.rfshset1tmg4 =3D 0x00000000,=09=09=09=09=09\
+=09/* ZQ timing =E2=80=94 TRM reset values */=09=09=09=09\
+=09.zqset1tmg0 =3D 0x00400200,=09=09=09=09=09\
+=09.zqset1tmg1 =3D 0x02000100,=09=09=09=09=09\
+=09/* Scheduler / power =E2=80=94 TRM reset values */=09=09=09\
+=09.perfhpr1 =3D 0x0F000001,=09=09=09=09=09=09\
+=09.perflpr1 =3D 0x0F00007F,=09=09=09=09=09=09\
+=09.perfwr1  =3D 0x0F00007F,=09=09=09=09=09=09\
+=09.ranktmg0 =3D 0x00000606,=09=09=09=09=09=09\
+=09.ranktmg1 =3D 0x00000F0F,=09=09=09=09=09=09\
+=09.pwrtmg   =3D 0x00400010,=09=09=09=09=09=09\
+}
+
+{
+=09.ch =3D {
+=09=09[0] =3D {
+=09=09=09.cap_info =3D {
+=09=09=09=09/*
+=09=09=09=09 * Typical 4 GB LPDDR4: 2 channels =C3=97 2 GB,
+=09=09=09=09 * each channel two x16 LP4 dies =3D x32 bus.
+=09=09=09=09 * 2 GB / 8 banks / 1024 cols / 4 B =3D 2^16 rows.
+=09=09=09=09 * Verify rank, row, col from actual chip datasheet.
+=09=09=09=09 */
+=09=09=09=09.rank              =3D 1,
+=09=09=09=09.col               =3D 10,
+=09=09=09=09.bk                =3D 3,
+=09=09=09=09.bw                =3D 2,
+=09=09=09=09.dbw               =3D 1,
+=09=09=09=09.row_3_4           =3D 0,
+=09=09=09=09.cs0_row           =3D 16,
+=09=09=09=09.cs1_row           =3D 16,
+=09=09=09=09.cs0_high16bit_row =3D 0,
+=09=09=09=09.cs1_high16bit_row =3D 0,
+=09=09=09=09.ddrconfig         =3D 0,
+=09=09=09},
+=09=09},
+=09=09[1] =3D {
+=09=09=09.cap_info =3D {
+=09=09=09=09.rank              =3D 1,
+=09=09=09=09.col               =3D 10,
+=09=09=09=09.bk                =3D 3,
+=09=09=09=09.bw                =3D 2,
+=09=09=09=09.dbw               =3D 1,
+=09=09=09=09.row_3_4           =3D 0,
+=09=09=09=09.cs0_row           =3D 16,
+=09=09=09=09.cs1_row           =3D 16,
+=09=09=09=09.cs0_high16bit_row =3D 0,
+=09=09=09=09.cs1_high16bit_row =3D 0,
+=09=09=09=09.ddrconfig         =3D 0,
+=09=09=09},
+=09=09},
+=09},
+=09.base =3D {
+=09=09.ddr_freq     =3D 1560,=09/* CK MHz; data rate =3D 2 =C3=97 1560 =3D=
 3120 MT/s */
+=09=09.dramtype     =3D LPDDR4,
+=09=09.num_channels =3D 2,
+=09=09.stride       =3D 0,
+=09=09.odt          =3D 1,
+=09},
+=09.freq =3D {
+=09=09[0] =3D LP4_1560_FREQ_TMG,
+=09=09[1] =3D LP4_1560_FREQ_TMG,
+=09=09[2] =3D LP4_1560_FREQ_TMG,
+=09=09[3] =3D LP4_1560_FREQ_TMG,
+=09},
+=09.ctl =3D {
+=09=09/*
+=09=09 * MSTR0: LPDDR4 (BIT(5)), 1 rank (bits[25:24]=3D0x1),
+=09=09 * BL16 (bits[19:16]=3D0x8), full bus width (bits[13:12]=3D0x0).
+=09=09 * TRM Part 2 p.632 field descriptions.
+=09=09 */
+=09=09.mstr0      =3D 0x01080020,
+=09=09/* Remaining fields: TRM reset values (sdram_pctl_rk3576.h) */
+=09=09.rankctl    =3D 0x0000000F,
+=09=09.dbictl     =3D 0x00000001,
+=09=09.odtmap     =3D 0x00002211,
+=09=09.inittmg0   =3D 0x0002004E,
+=09=09.inittmg1   =3D 0x00000000,
+=09=09.rfshmod0   =3D 0x00000000,
+=09=09.sched0     =3D 0x8001201C,
+=09=09.sched1     =3D 0x00002000,
+=09=09.sched3     =3D 0x04040208,
+=09=09.sched4     =3D 0x08400810,
+=09=09.dfilpcfg0  =3D 0x00100000,
+=09=09.dfiupd0    =3D 0x00008000,
+=09=09.dfiphymstr =3D 0x80000001,
+=09=09.zqctl0     =3D 0x00000000,
+=09=09.zqctl1     =3D 0x00000000,
+=09},
+},
+
+#undef LP4_1560_FREQ_TMG
--=20
2.45.1.windows.1


