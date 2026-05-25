Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95C2CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C3584815;
	Mon, 25 May 2026 04:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Q6RpDtBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B510783EF9; Mon, 25 May 2026 03:29:25 +0200 (CEST)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739248039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672562; x=1779931762;
 bh=7amRZDt8/GXYhtIWA7xiydrbHNvjRWsGnD3oEFpt9S0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Q6RpDtBGmtf8KIHzW3JWGCZ5t/BsHJgh8+DtSi2yw+7gCaoFYc1uzt7QZImeV5Iyp
 9yARGdl3j9JgJkiWNpPNhAfaCP1Qk7a8Q1nnJXltwxN6XC4uc/2y0s+u1db+f95Yjn
 9uby8WBypF7plGhTVFW0xom9oANacHt5hJQ/cklNn1KMuzvAKx3bnkD7oAJQNJ+ZXp
 Wwei8ARWLUDoXXWVppD4gaMfOecSB5svHBgHCGhrCEPc3PN/EosbJ2f7hx3pu2WpOo
 p/k0ODA5XN2UMaOXZzzESQtvjMuMpJZNtBFpyuD2VIcVeY2s2zvPPibhNKsYQ/HULf
 /Ph3F5lYjoEEQ==
Date: Mon, 25 May 2026 01:29:15 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 06/14] ram: rockchip: add RK3576 DDRCTL register
 definitions
Message-ID: <20260525012824.121-7-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 7297e258f0819c33db8acbf353123ea9a7beb289
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

Add sdram_pctl_rk3576.h with the full uMCTL2 register layout for the
RK3576 DDR subsystem.  The RK3576 uMCTL2 is a newer generation than
the PX30/RK3568 variant and cannot share sdram_pctl_px30.h:

  - Frequency-banked timing registers at 0x0/0x100000/0x200000/0x300000
  - Global control/status at 0x10000+
  - Multi-port registers at 0x20000+
  - Address-map registers at 0x30000+

Covers ~130 register offset defines (FREQ, global, port, addrmap
sections) with TRM reset values in comments.  Field macros for
MSTR0 (LPDDR4/5 mode, ranks, burst length, bus width), MRCTRL0
(MR write protocol), DFIMISC, RFSHCTL0, and DFISTAT.

TRM Part 2 =C2=A77.4.3 (pp.585-800).

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 .../asm/arch-rockchip/sdram_pctl_rk3576.h     | 303 ++++++++++++++++++
 1 file changed, 303 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_pctl_rk3576.h

diff --git a/arch/arm/include/asm/arch-rockchip/sdram_pctl_rk3576.h b/arch/=
arm/include/asm/arch-rockchip/sdram_pctl_rk3576.h
new file mode 100644
index 00000000000..cf4e9053bc1
--- /dev/null
+++ b/arch/arm/include/asm/arch-rockchip/sdram_pctl_rk3576.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RK3576 uMCTL2 DDRCTL register definitions.
+ *
+ * The RK3576 DDRCTL uses a non-standard address layout (TRM Part 2 =C2=
=A77.4.1):
+ *   0x000000=E2=80=930x0FFFFF  FREQ0 per-frequency timing registers
+ *   0x100000=E2=80=930x1FFFFF  FREQ1 per-frequency timing registers
+ *   0x200000=E2=80=930x2FFFFF  FREQ2 per-frequency timing registers
+ *   0x300000=E2=80=930x3FFFFF  FREQ3 per-frequency timing registers
+ *   0x010000=E2=80=930x01FFFF  global/static controller registers
+ *   0x020000=E2=80=930x024FFF  AXI port configuration (5 ports)
+ *   0x030000=E2=80=930x037FFF  SDRAM address map registers
+ *
+ * Operational bases (TRM Part 2 Table 7-1):
+ *   DDRCTL0  0x28000000
+ *   DDRCTL1  0x29000000
+ *
+ * This layout is incompatible with sdram_pctl_px30.h; do not mix them.
+ */
+
+#ifndef _ASM_ARCH_SDRAM_PCTL_RK3576_H
+#define _ASM_ARCH_SDRAM_PCTL_RK3576_H
+
+#include <asm/arch-rockchip/sdram_common.h>
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+/* Per-frequency bank base (TRM Part 2 =C2=A77.4.1) */
+#define DDRCTL_FREQ_BASE(n)=09=09((u32)(n) * 0x100000)
+
+/* -----------------------------------------------------------------------
+ * FREQ-banked timing registers (offsets relative to DDRCTL_FREQ_BASE(n))
+ * TRM Part 2 =C2=A77.4.2 "Registers Summary For DDRCTL"
+ * -----------------------------------------------------------------------
+ */
+
+/* SDRAM timing set 1 (TRM p.591) */
+#define DDRCTL_DRAMSET1TMG0=09=090x0000=09/* reset: 0x0F101B0F */
+#define DDRCTL_DRAMSET1TMG1=09=090x0004=09/* reset: 0x00080414 */
+#define DDRCTL_DRAMSET1TMG2=09=090x0008=09/* reset: 0x0305060D */
+#define DDRCTL_DRAMSET1TMG3=09=090x000C=09/* reset: 0x00040404 */
+#define DDRCTL_DRAMSET1TMG4=09=090x0010=09/* reset: 0x05040405 */
+#define DDRCTL_DRAMSET1TMG5=09=090x0014=09/* reset: 0x05050403 */
+#define DDRCTL_DRAMSET1TMG6=09=090x0018=09/* reset: 0x00000005 */
+#define DDRCTL_DRAMSET1TMG7=09=090x001C=09/* reset: 0x00000000 */
+#define DDRCTL_DRAMSET1TMG8=09=090x0020=09/* reset: 0x00004405 */
+#define DDRCTL_DRAMSET1TMG9=09=090x0024=09/* reset: 0x0004040D */
+#define DDRCTL_DRAMSET1TMG12=09=090x0030=09/* reset: 0x00020000 */
+#define DDRCTL_DRAMSET1TMG13=09=090x0034=09/* reset: 0x1C200004 */
+#define DDRCTL_DRAMSET1TMG14=09=090x0038=09/* reset: 0x000800A0 */
+#define DDRCTL_DRAMSET1TMG23=09=090x005C=09/* reset: 0x00000000 */
+#define DDRCTL_DRAMSET1TMG24=09=090x0060=09/* reset: 0x000F0F0F */
+#define DDRCTL_DRAMSET1TMG25=09=090x0064=09/* reset: 0x00000000 */
+#define DDRCTL_DRAMSET1TMG30=09=090x0078=09/* reset: 0x00000000 */
+
+/* SDRAM initialization MR values for this frequency set (TRM p.592) */
+#define DDRCTL_INITMR0=09=09=090x0500=09/* reset: 0x00000510 */
+#define DDRCTL_INITMR1=09=09=090x0504=09/* reset: 0x00000000 */
+#define DDRCTL_INITMR2=09=09=090x0508=09/* reset: 0x00000000 */
+#define DDRCTL_INITMR3=09=09=090x050C=09/* reset: 0x00000000 */
+
+/* DFI timing for this frequency set (TRM p.592) */
+#define DDRCTL_DFITMG0=09=09=090x0580=09/* reset: 0x07020002 */
+#define DDRCTL_DFITMG1=09=09=090x0584=09/* reset: 0x00000404 */
+#define DDRCTL_DFITMG2=09=09=090x0588=09/* reset: 0x00000202 */
+#define DDRCTL_DFITMG4=09=09=090x0590=09/* reset: 0x00000000 */
+#define DDRCTL_DFITMG5=09=09=090x0594=09/* reset: 0x00000000 */
+#define DDRCTL_DFILPTMG0=09=090x05A0=09/* reset: 0x00000000 */
+#define DDRCTL_DFILPTMG1=09=090x05A4=09/* reset: 0x00000700 */
+#define DDRCTL_DFIUPDTMG0=09=090x05A8=09/* reset: 0x00400003 */
+#define DDRCTL_DFIUPDTMG1=09=090x05AC=09/* reset: 0x00010001 */
+#define DDRCTL_DFIMSGTMG0=09=090x05B0=09/* reset: 0x00000004 */
+
+/* Refresh timing for this frequency set (TRM p.592) */
+#define DDRCTL_RFSHSET1TMG0=09=090x0600=09/* reset: 0x02100062 */
+#define DDRCTL_RFSHSET1TMG1=09=090x0604=09/* reset: 0x0000008C */
+#define DDRCTL_RFSHSET1TMG2=09=090x0608=09/* reset: 0x8C8C0000 */
+#define DDRCTL_RFSHSET1TMG4=09=090x0610=09/* reset: 0x00000000 */
+
+/* ZQ timing for this frequency set (TRM p.592) */
+#define DDRCTL_ZQSET1TMG0=09=090x0800=09/* reset: 0x00400200 */
+#define DDRCTL_ZQSET1TMG1=09=090x0804=09/* reset: 0x02000100 */
+
+/* DQS/WCK oscillator control (per-freq) (TRM p.592) */
+#define DDRCTL_DQSOSCCTL0=09=090x0A80=09/* reset: 0x00000070 */
+
+/* Temperature derate timing (per-freq) (TRM p.592) */
+#define DDRCTL_DERATEINT=09=090x0B00=09/* reset: 0x00800000 */
+#define DDRCTL_DERATEVAL0=09=090x0B04=09/* reset: 0x050F0504 */
+#define DDRCTL_DERATEVAL1=09=090x0B08=09/* reset: 0x00000014 */
+
+/* Hardware low-power timing (per-freq) (TRM p.592) */
+#define DDRCTL_HWLPTMG0=09=09=090x0B80=09/* reset: 0x00000000 */
+
+/* Scheduler timing (per-freq) (TRM p.592) */
+#define DDRCTL_SCHEDTMG0=09=090x0C00=09/* reset: 0x00000000 */
+#define DDRCTL_PERFHPR1=09=09=090x0C80=09/* reset: 0x0F000001 */
+#define DDRCTL_PERFLPR1=09=09=090x0C84=09/* reset: 0x0F00007F */
+#define DDRCTL_PERFWR1=09=09=090x0C88=09/* reset: 0x0F00007F */
+#define DDRCTL_TMGCFG=09=09=090x0D00=09/* reset: 0x00000000 */
+#define DDRCTL_RANKTMG0=09=09=090x0D04=09/* reset: 0x00000606 */
+#define DDRCTL_RANKTMG1=09=09=090x0D08=09/* reset: 0x00000F0F */
+#define DDRCTL_PWRTMG=09=09=090x0D0C=09/* reset: 0x00400010 */
+
+/* -----------------------------------------------------------------------
+ * Global/static registers (offsets within DDRCTL address space)
+ * These registers are outside the FREQ banks.  Access via:
+ *   readl(base + DDRCTL_MSTR0), etc.
+ * TRM Part 2 =C2=A77.4.2 p.593-594
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRCTL_MSTR0=09=09=090x10000=09/* reset: 0x03040000 */
+#define DDRCTL_MSTR2=09=09=090x10008=09/* reset: 0x00000000 */
+#define DDRCTL_MSTR4=09=09=090x10010=09/* reset: 0x00000000 */
+#define DDRCTL_STAT=09=09=090x10014=09/* reset: 0x00000000 */
+#define DDRCTL_MRCTRL0=09=09=090x10080=09/* reset: 0x00000030 */
+#define DDRCTL_MRCTRL1=09=09=090x10084=09/* reset: 0x00000000 */
+#define DDRCTL_MRSTAT=09=09=090x10090=09/* reset: 0x00000000 */
+#define DDRCTL_MRRDATA0=09=09=090x10094=09/* reset: 0x00000000 */
+#define DDRCTL_MRRDATA1=09=09=090x10098=09/* reset: 0x00000000 */
+#define DDRCTL_DERATECTL0=09=090x10100=09/* reset: 0x00000018 */
+#define DDRCTL_DERATECTL1=09=090x10104=09/* reset: 0x00000000 */
+#define DDRCTL_DERATECTL2=09=090x10108=09/* reset: 0x00000000 */
+#define DDRCTL_DERATECTL5=09=090x10114=09/* reset: 0x00000001 */
+#define DDRCTL_DERATECTL6=09=090x10118=09/* reset: 0x00000000 */
+#define DDRCTL_DERATESTAT0=09=090x1011C=09/* reset: 0x00000000 */
+#define DDRCTL_DERATEDBGCTL=09=090x10124=09/* reset: 0x00000000 */
+#define DDRCTL_DERATEDBGSTAT=09=090x10128=09/* reset: 0x00000000 */
+#define DDRCTL_PWRCTL=09=09=090x10180=09/* reset: 0x00000000 */
+#define DDRCTL_HWLPCTL=09=09=090x10184=09/* reset: 0x00000003 */
+#define DDRCTL_CLKGATECTL=09=090x1018C=09/* reset: 0x0000003F */
+#define DDRCTL_RFSHMOD0=09=09=090x10200=09/* reset: 0x00000000 */
+#define DDRCTL_RFSHCTL0=09=09=090x10208=09/* reset: 0x00000000 */
+#define DDRCTL_ZQCTL0=09=09=090x10280=09/* reset: 0x00000000 */
+#define DDRCTL_ZQCTL1=09=09=090x10284=09/* reset: 0x00000000 */
+#define DDRCTL_ZQCTL2=09=09=090x10288=09/* reset: 0x00000000 */
+#define DDRCTL_ZQSTAT=09=09=090x1028C=09/* reset: 0x00000000 */
+#define DDRCTL_DQSOSCRUNTIME=09=090x10300=09/* reset: 0x00400040 */
+#define DDRCTL_DQSOSCSTAT0=09=090x10304=09/* reset: 0x00000000 */
+#define DDRCTL_DQSOSCCFG0=09=090x10308=09/* reset: 0x00000000 */
+#define DDRCTL_SCHED0=09=09=090x10380=09/* reset: 0x8001201C */
+#define DDRCTL_SCHED1=09=09=090x10384=09/* reset: 0x00002000 */
+#define DDRCTL_SCHED3=09=09=090x1038C=09/* reset: 0x04040208 */
+#define DDRCTL_SCHED4=09=09=090x10390=09/* reset: 0x08400810 */
+#define DDRCTL_DFILPCFG0=09=090x10500=09/* reset: 0x00100000 */
+#define DDRCTL_DFIUPD0=09=09=090x10508=09/* reset: 0x00008000 */
+#define DDRCTL_DFIMISC=09=09=090x10510=09/* reset: 0x00000001 */
+#define DDRCTL_DFISTAT=09=09=090x10514=09/* reset: 0x00000000 */
+#define DDRCTL_DFIPHYMSTR=09=090x10518=09/* reset: 0x80000001 */
+#define DDRCTL_DFI0MSGCTL0=09=090x10520=09/* reset: 0x00000000 */
+#define DDRCTL_DFI0MSGSTAT0=09=090x10524=09/* reset: 0x00000000 */
+#define DDRCTL_POISONCFG=09=090x10580=09/* reset: 0x00110011 */
+#define DDRCTL_POISONSTAT=09=090x10584=09/* reset: 0x00000000 */
+#define DDRCTL_OPCTRL0=09=09=090x10B80=09/* reset: 0x00000000 */
+#define DDRCTL_OPCTRL1=09=09=090x10B84=09/* reset: 0x00000000 */
+#define DDRCTL_OPCTRLCAM=09=090x10B88=09/* reset: 0x00000000 */
+#define DDRCTL_OPCTRLCMD=09=090x10B8C=09/* reset: 0x00000000 */
+#define DDRCTL_OPCTRLSTAT=09=090x10B90=09/* reset: 0x00000000 */
+#define DDRCTL_OPREFCTRL0=09=090x10B98=09/* reset: 0x00000000 */
+#define DDRCTL_OPREFSTAT0=09=090x10BA0=09/* reset: 0x00000000 */
+#define DDRCTL_SWCTL=09=09=090x10C80=09/* reset: 0x00000001 */
+#define DDRCTL_SWSTAT=09=09=090x10C84=09/* reset: 0x00000001 */
+#define DDRCTL_RANKCTL=09=09=090x10C90=09/* reset: 0x0000000F */
+#define DDRCTL_DBICTL=09=09=090x10C94=09/* reset: 0x00000001 */
+#define DDRCTL_ODTMAP=09=09=090x10C9C=09/* reset: 0x00002211 */
+#define DDRCTL_DATACTL0=09=09=090x10CA0=09/* reset: 0x00000000 */
+#define DDRCTL_SWCTLSTATIC=09=090x10CA4=09/* reset: 0x00000000 */
+#define DDRCTL_INITTMG0=09=09=090x10D00=09/* reset: 0x0002004E */
+#define DDRCTL_INITTMG1=09=09=090x10D04=09/* reset: 0x00000000 */
+
+/* -----------------------------------------------------------------------
+ * AXI port configuration (5 ports, stride 0x1000) (TRM p.594-595)
+ * Port n base =3D DDRCTL_PORT_BASE(n)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRCTL_PORT_BASE(n)=09=09(0x20000 + (u32)(n) * 0x1000)
+#define DDRCTL_PCCFG_PORT0=09=090x20000=09/* reset: 0x00000000 (port 0 onl=
y) */
+#define DDRCTL_PCFGR(n)=09=09(DDRCTL_PORT_BASE(n) + 0x004)=09/* reset: 0x0=
000501F */
+#define DDRCTL_PCFGW(n)=09=09(DDRCTL_PORT_BASE(n) + 0x008)=09/* reset: 0x0=
000501F */
+#define DDRCTL_PCTRL(n)=09=09(DDRCTL_PORT_BASE(n) + 0x090)=09/* reset: 0x0=
0000000 */
+#define DDRCTL_PCFGQOS0(n)=09=09(DDRCTL_PORT_BASE(n) + 0x094)=09/* reset: =
0x00000000 */
+#define DDRCTL_PCFGQOS1(n)=09=09(DDRCTL_PORT_BASE(n) + 0x098)=09/* reset: =
0x00000000 */
+#define DDRCTL_PCFGWQOS0(n)=09=09(DDRCTL_PORT_BASE(n) + 0x09C)=09/* reset:=
 0x00000E00 */
+#define DDRCTL_PCFGWQOS1(n)=09=09(DDRCTL_PORT_BASE(n) + 0x0A0)=09/* reset:=
 0x00000000 */
+#define DDRCTL_NPORTS=09=09=095
+
+/* -----------------------------------------------------------------------
+ * Address map registers (TRM p.595)
+ * -----------------------------------------------------------------------
+ */
+
+#define DDRCTL_ADDRMAP1=09=09=090x30004=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP3=09=09=090x3000C=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP4=09=09=090x30010=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP5=09=09=090x30014=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP6=09=09=090x30018=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP7=09=09=090x3001C=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP8=09=09=090x30020=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP9=09=09=090x30024=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP10=09=090x30028=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP11=09=090x3002C=09/* reset: 0x00000000 */
+#define DDRCTL_ADDRMAP12=09=090x30030=09/* reset: 0x00000000 */
+
+/* -----------------------------------------------------------------------
+ * Register field macros =E2=80=94 only bits needed for TPL init
+ * TRM Part 2 =C2=A77.4.3
+ * -----------------------------------------------------------------------
+ */
+
+/* DDRCTL_MSTR0 */
+#define MSTR0_ACTIVE_RANKS_MASK=09=09GENMASK(27, 24)
+#define MSTR0_ACTIVE_RANKS_1=09=09(0x1 << 24)
+#define MSTR0_ACTIVE_RANKS_2=09=09(0x3 << 24)
+#define MSTR0_BURST_RDWR_MASK=09=09GENMASK(19, 16)
+#define MSTR0_BURST_RDWR_BL16=09=09(0x8 << 16)
+#define MSTR0_LPDDR5=09=09=09BIT(6)
+#define MSTR0_LPDDR4=09=09=09BIT(5)
+#define MSTR0_DATA_BUS_WIDTH_MASK=09GENMASK(13, 12)
+#define MSTR0_DATA_BUS_WIDTH_FULL=09(0x0 << 12)
+#define MSTR0_DATA_BUS_WIDTH_HALF=09(0x1 << 12)
+
+/* DDRCTL_STAT */
+#define STAT_OPERATING_MODE_MASK=09GENMASK(2, 0)
+#define STAT_OPERATING_MODE_INIT=090
+#define STAT_OPERATING_MODE_NORMAL=091
+#define STAT_OPERATING_MODE_PD=09=092
+#define STAT_OPERATING_MODE_SR=09=093
+#define STAT_SELFREF_TYPE_MASK=09=09GENMASK(5, 4)
+#define STAT_SELFREF_TYPE_SR_NOT_AUTO=09(2 << 4)
+
+/* DDRCTL_MRCTRL0 (TRM p.635) */
+#define MRCTRL0_MR_WR=09=09=09BIT(31)
+#define MRCTRL0_MR_ADDR_SHIFT=09=0912
+#define MRCTRL0_MR_RANK_SHIFT=09=094
+/* sw_init_int [3]: allow SW MRS before auto-init (LPDDR5 step 26) */
+#define MRCTRL0_SW_INIT_INT=09=09BIT(3)
+#define MRCTRL0_MR_TYPE_WR=09=090
+#define MRCTRL0_MR_TYPE_RD=09=091
+
+/* DDRCTL_MRSTAT */
+#define MRSTAT_MR_WR_BUSY=09=09BIT(0)
+
+/* DDRCTL_PWRCTL */
+#define PWRCTL_SELFREF_SW=09=09BIT(5)
+#define PWRCTL_SELFREF_EN=09=09BIT(0)
+
+/* DDRCTL_RFSHCTL0 */
+#define RFSHCTL0_DIS_AUTO_REFRESH=09BIT(0)
+
+/* DDRCTL_ZQCTL0 */
+#define ZQCTL0_DIS_AUTO_ZQ=09=09BIT(31)
+#define ZQCTL0_DIS_SRX_ZQCL=09=09BIT(30)
+
+/* DDRCTL_DFILPCFG0 */
+#define DFILPCFG0_DFI_LP_EN_SR=09=09BIT(8)
+
+/* DDRCTL_DFIMISC */
+#define DFIMISC_DFI_INIT_COMPLETE_EN=09BIT(0)
+#define DFIMISC_DFI_INIT_START=09=09BIT(5)
+
+/* DDRCTL_DFISTAT */
+#define DFISTAT_DFI_INIT_COMPLETE=09BIT(0)
+
+/* DDRCTL_DFIPHYMSTR */
+#define DFIPHYMSTR_DFI_PHYMSTR_EN=09BIT(0)
+
+/* DDRCTL_OPCTRLCAM */
+#define OPCTRLCAM_DBG_WR_Q_EMPTY=09BIT(26)
+#define OPCTRLCAM_DBG_RD_Q_EMPTY=09BIT(25)
+
+/* DDRCTL_OPCTRL0 */
+#define OPCTRL0_DIS_HIF=09=09=09BIT(1)
+
+/* DDRCTL_SWCTL */
+#define SWCTL_SW_DONE=09=09=09BIT(0)
+
+/* DDRCTL_SWSTAT */
+#define SWSTAT_SW_DONE_ACK=09=09BIT(0)
+
+/* DDRCTL_RANKCTL */
+#define RANKCTL_DIFF_RANK_WR_GAP_MSB=09BIT(26)
+#define RANKCTL_DIFF_RANK_RD_GAP_MSB=09BIT(24)
+#define RANKCTL_DIFF_RANK_WR_GAP_MASK=09GENMASK(11, 8)
+#define RANKCTL_DIFF_RANK_RD_GAP_MASK=09GENMASK(7, 4)
+#define RANKCTL_MAX_RANK_RD_MASK=09GENMASK(3, 0)
+
+/* DDRCTL_DBICTL */
+#define DBICTL_DM_EN=09=09=09BIT(2)
+#define DBICTL_WR_DBI_EN=09=09BIT(1)
+#define DBICTL_RD_DBI_EN=09=09BIT(0)
+
+/* DDRCTL_PCTRL */
+#define PCTRL_PORT_EN=09=09=09BIT(0)
+
+/* DDRCTL_INITTMG0 */
+#define INITTMG0_PRE_CKE_X1024_MASK=09GENMASK(19, 0)
+#define INITTMG0_POST_CKE_X1024_MASK=09GENMASK(29, 20)
+
+#endif /* _ASM_ARCH_SDRAM_PCTL_RK3576_H */
--=20
2.45.1.windows.1


