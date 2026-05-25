Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BE9CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7D0846D1;
	Mon, 25 May 2026 04:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="GEETXQdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B7B8404D; Mon, 25 May 2026 03:29:51 +0200 (CEST)
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99DA8039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672584; x=1779931784;
 bh=HlJ4nnsYuqU6D6f53XgxclA0/WI0HAeI53v2Awmx5mg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GEETXQdXEtoex1j0/T8RyKC/kD/e81JlbwnQK5YSvB7Tio1juMt+F9GcsUEM3xQP2
 TUj159yktcgvIEAgL3mwxtJS8+XEB0J4QZs96H69jlDSokiRyymUurdk8P+Hn0IOtd
 gH8OYpCH3sMMZr1RzxiRIh3seY++JdL5rh03Lyd9EB5ZNMvR4C8vuXxvvYchpW5heA
 9PNWXPk0VGcidagrhz735T3aOjdKck0cqUIeWF0VWa0TWhkbke36sYmGgMyU8e0Epd
 WJNxy5FEC0pKMsuziwWwT92MztBNVRkjCEeX1SPu8CiifXJaFEuEsDOV5THk0xUOe+
 hJ/Qr8R0fRwrQ==
Date: Mon, 25 May 2026 01:29:41 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 11/14] ram: rockchip: rk3576: add LPDDR5 timing table
 placeholder (2133 MHz)
Message-ID: <20260525012824.121-12-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 79bc9cac50c86e97fadb97757cc203aea8c306f7
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

Add sdram-rk3576-lpddr5-detect-2133.inc: a compileable timing table
for LPDDR5 at PHY 2x clock =3D 2133 MHz (CK =3D 1067 MHz, WCK =3D 4267 MHz,
data rate =E2=89=88 LPDDR5-8533).

All timing register values are TRM reset defaults and are NOT correct
for 1067 MHz LPDDR5 operation.  The file exists so the driver compiles
with CONFIG_RAM_ROCKCHIP_LPDDR5=3Dy.  Hardware bring-up will fail until
the timing values are replaced with values derived from:
  - JEDEC JESD209-5B LPDDR5 timing for the target speed grade
  - Synopsys uMCTL2 SRS field encoding rules
  - The actual DRAM part number and its timing datasheet

Correctly set:
  - mstr0 =3D 0x01080040 (BIT(6)=3Dlpddr5 | 1 rank | BL16 | full BW)
  - cap_info: 8 GB LPDDR5, 2 channels =C3=97 4 GB, 2^17 rows

This is the primary timing table target for the Flipper One board
(8 GB LPDDR5).  "2133" in the filename is the PHY 2x clock in MHz,
not the data rate.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 .../sdram-rk3576-lpddr5-detect-2133.inc       | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 drivers/ram/rockchip/sdram-rk3576-lpddr5-detect-2133.in=
c

diff --git a/drivers/ram/rockchip/sdram-rk3576-lpddr5-detect-2133.inc b/dri=
vers/ram/rockchip/sdram-rk3576-lpddr5-detect-2133.inc
new file mode 100644
index 00000000000..324eb3c6b09
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3576-lpddr5-detect-2133.inc
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RK3576 LPDDR5 timing table =E2=80=94 PHY 2x clock 2133 MHz (CK =3D 1067=
 MHz,
+ * WCK =3D 4267 MHz, data rate =E2=89=88 LPDDR5-8533).
+ *
+ * PLACEHOLDER =E2=80=94 timing register values below are TRM reset defaul=
ts
+ * and are NOT correct for 1067 MHz LPDDR5 operation.  Hardware bring-up
+ * will fail until these are replaced with values calculated from:
+ *
+ *   1. JEDEC JESD209-5B LPDDR5 timing parameters for the target speed gra=
de
+ *   2. Synopsys uMCTL2 Software Requirements Specification (SRS) field
+ *      encoding rules (wr2pre, t_ras_min, RL/WL, tRFC, tDFI*, =E2=80=
=A6)
+ *   3. The actual DRAM part number fitted on the target board and its
+ *      timing datasheet (Flipper One: 8 GB, 2 channels, x32 per channel)
+ *
+ * Specifically wrong at 1067 MHz:
+ *   dramset1tmg0.t_ras_min  TRM reset =3D 15 cyc (14 ns); JEDEC min =3D 4=
2 ns
+ *   dramset1tmg0.wr2pre     needs WL + BL/2 + tWR calculation
+ *   dfitmg0/1               need tDFI_WRDATA, tDFI_RDDATA_EN for LP5 PHY
+ *   initmr0=E2=80=933               LP5 MR1/MR2/MR3/MR11 for 1067 MHz RL/=
WL/CK-ratio
+ *   rfshset1tmg0.t_rfc_min  needs LP5 die density (8 Gbit =E2=89=88 210 n=
s)
+ *
+ * W9 work item.  This file exists so the driver compiles with
+ * CONFIG_RAM_ROCKCHIP_LPDDR5=3Dy.
+ */
+
+/*
+ * Shared per-frequency timing block (all four FREQ banks use the same
+ * placeholder values for now; a real table would differentiate them).
+ */
+#define LP5_2133_FREQ_TMG=09=09=09=09=09=09\
+{=09=09=09=09=09=09=09=09=09\
+=09/*=09=09=09=09=09=09=09=09\
+=09 * SDRAM timing =E2=80=94 TRM reset values (sdram_pctl_rk3576.h).=09\
+=09 * Replace every field before hardware testing (see header).=09\
+=09 */=09=09=09=09=09=09=09=09\
+=09.dramset1tmg0  =3D 0x0F101B0F, /* t_ras_min/max, t_faw, wr2pre */\
+=09.dramset1tmg1  =3D 0x00080414, /* t_rc, rd2pre, t_xp */=09=09\
+=09.dramset1tmg2  =3D 0x0305060D, /* wr2rd, rd2wr, read_lat, wr_lat */\
+=09.dramset1tmg3  =3D 0x00040404, /* t_mr{d,mod,w} */=09=09\
+=09.dramset1tmg4  =3D 0x05040405, /* t_rp, t_rrd, t_ccd, t_rcd */=09\
+=09.dramset1tmg5  =3D 0x05050403, /* t_cke, t_ckesr, t_cksre, t_cksrx */\
+=09.dramset1tmg6  =3D 0x00000005, /* t_ckcsx */=09=09=09\
+=09.dramset1tmg7  =3D 0x00000000,=09=09=09=09=09\
+=09.dramset1tmg8  =3D 0x00004405, /* t_xs_{abort,fast}_x32 */=09\
+=09.dramset1tmg9  =3D 0x0004040D, /* t_dqsck_max, t_crd2wr */=09\
+=09.dramset1tmg12 =3D 0x00020000, /* t_cmdcke, t_mrd_pda */=09=09\
+=09.dramset1tmg13 =3D 0x1C200004, /* t_ppd, t_ccd_mw, t_odth{8,4} */\
+=09.dramset1tmg14 =3D 0x000800A0, /* t_xsr, t_osco */=09=09\
+=09.dramset1tmg23 =3D 0x00000000,=09=09=09=09=09\
+=09.dramset1tmg24 =3D 0x000F0F0F,=09=09=09=09=09\
+=09.dramset1tmg25 =3D 0x00000000,=09=09=09=09=09\
+=09.dramset1tmg30 =3D 0x00000000,=09=09=09=09=09\
+=09/*=09=09=09=09=09=09=09=09\
+=09 * SDRAM initialization MR values =E2=80=94 LPDDR5 mode registers.=09\
+=09 * TODO: encode MR1/MR2/MR11/MR13 for 1067 MHz RL/WL.=09=09\
+=09 */=09=09=09=09=09=09=09=09\
+=09.initmr0 =3D 0x00000000,=09=09=09=09=09=09\
+=09.initmr1 =3D 0x00000000,=09=09=09=09=09=09\
+=09.initmr2 =3D 0x00000000,=09=09=09=09=09=09\
+=09.initmr3 =3D 0x00000000,=09=09=09=09=09=09\
+=09/*=09=09=09=09=09=09=09=09\
+=09 * DFI timing =E2=80=94 TRM reset values; tDFI_WRDATA and=09=09\
+=09 * tDFI_RDDATA_EN must be set per PHY latency for 1067 MHz.=09\
+=09 */=09=09=09=09=09=09=09=09\
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
+=09 * Refresh timing =E2=80=94 TODO: t_rfc_min for LP5 8 Gbit die=09=09\
+=09 * (tRFCab =E2=89=88 380 ns at 1067 MHz =E2=89=88 406 cycles).=09=09=09=
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
+=09=09=09=09 * Typical 8 GB LPDDR5: 2 channels =C3=97 4 GB,
+=09=09=09=09 * each channel two x16 LP5 dies =3D x32 bus.
+=09=09=09=09 * 4 GB / 8 banks / 1024 cols / 4 B =3D 2^17 rows.
+=09=09=09=09 * Verify rank, row, col from actual chip datasheet.
+=09=09=09=09 */
+=09=09=09=09.rank              =3D 1,
+=09=09=09=09.col               =3D 10,
+=09=09=09=09.bk                =3D 3,
+=09=09=09=09.bw                =3D 2,
+=09=09=09=09.dbw               =3D 1,
+=09=09=09=09.row_3_4           =3D 0,
+=09=09=09=09.cs0_row           =3D 17,
+=09=09=09=09.cs1_row           =3D 17,
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
+=09=09=09=09.cs0_row           =3D 17,
+=09=09=09=09.cs1_row           =3D 17,
+=09=09=09=09.cs0_high16bit_row =3D 0,
+=09=09=09=09.cs1_high16bit_row =3D 0,
+=09=09=09=09.ddrconfig         =3D 0,
+=09=09=09},
+=09=09},
+=09},
+=09.base =3D {
+=09=09.ddr_freq     =3D 2133,=09/* PHY 2x clock MHz; CK =3D 1067 MHz */
+=09=09.dramtype     =3D LPDDR5,
+=09=09.num_channels =3D 2,
+=09=09.stride       =3D 0,
+=09=09.odt          =3D 1,
+=09},
+=09.freq =3D {
+=09=09[0] =3D LP5_2133_FREQ_TMG,
+=09=09[1] =3D LP5_2133_FREQ_TMG,
+=09=09[2] =3D LP5_2133_FREQ_TMG,
+=09=09[3] =3D LP5_2133_FREQ_TMG,
+=09},
+=09.ctl =3D {
+=09=09/*
+=09=09 * MSTR0: LPDDR5 (BIT(6)), 1 rank (bits[25:24]=3D0x1),
+=09=09 * BL16 (bits[19:16]=3D0x8), full bus width (bits[13:12]=3D0x0).
+=09=09 * TRM Part 2 p.632 field descriptions.
+=09=09 */
+=09=09.mstr0      =3D 0x01080040,
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
+#undef LP5_2133_FREQ_TMG
--=20
2.45.1.windows.1


