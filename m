Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F351C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 15:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F65140514;
	Wed, 26 Aug 2026 15:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5SISSEXJAVkD; Wed, 26 Aug 2026 15:55:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787759756;
	bh=PP7uLYBAAyHlrE493AZxaxnCvQ8Jax+6YTaTlvHOwWY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mmpt0xzQ58MtBbS2Z6PrYBTkD4RZ+1YEyy+2QfXYsKnYkZQC3brHj/4hBAX/IxN71
	 yr/KIyWy7gfYqr+3NUMLYndKtkLPYLaAElXISfu5FllEzIyozSKbMnEQbVXcs1ovwj
	 pDGqPNE2kgrkyD+Bh6bbIWNz7FSxVD1nBpkyS4fyY438cNDbcNF7JtlyvOWxWct8Yp
	 hNWV9zACwmSVyr0McPDzzSqmOn2y4sTFRV2nud97Vsvd50XY4QRTjZe6BkQdrznc5H
	 hVUvDXFMMaX4zIg13m0WVIjzVHuI7tF2pu1oq82TjH4KQ07GAr4Zs2sZPrlrBEtBOd
	 5n/sB1CnAazIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C967F40536;
	Wed, 26 Aug 2026 15:55:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12BE73C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0478240536
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GE0viWNZjklY for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 15:55:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Ye4qDWo3
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BE2D40514
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1AEDFB00585;
 Wed, 26 Aug 2026 17:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1787759750;
 bh=heOGs+LzM+DbzVce+/4EUTetYtUGr/VkPDlc+1umC5w=;
 h=From:To:Cc:Subject:Date:From;
 b=Ye4qDWo3u23nUiNjY8oxekkjaoCl9UF8ifZ3Ib9gjVnO2p5QpYQb2KvMrXbbiQQ9n
 +z5HPHNLQ+BOXGWa+omX/6NEI9SrklSOwCr6cJY6DWy7c+1YkNKQ/r7jfoCUR2VOwK
 Solx5WPhPLLiXdLP0M0v3Z/NIQvEEMf1y0jb6QTE6mgGVBhH86W/6yyqqZ+T3tBsot
 9+oZJFyAmgRuXNoWUKY8re1ipHVNdHpyIrHFCp2RFTuCgr+5DMD/wFbIYTBtdIX/pJ
 qi7s35BbykQQoq3pj1bOpxO+1uRmLpIKXXBLbXvfePAzjBWRweOLVjcMhMuJ1/PK/u
 qYrejyAF2968w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] lx2160: add lx2160_serdes split and management
Date: Wed, 26 Aug 2026 17:55:28 +0200
Message-ID: <20260826155529.3094598-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add Serdes information and status for boards that support SerDes 1
split as 1x 100G + 4x 25G
RCWSR shall be 13, MC needs follow_hw_pssr to read the hardware
rather than a table, and now U-Boot side dumps the real configuration.

Example:
  RCWSR29  raw=0x000d -> protocol 13
  port grouping (PORT_LN0_B)  [LNA-LND] [LNE] [LNF] [LNG] [LNH]
      PCCD    11110000  (E25G)  E25Ga=1 E25Gb=1 E25Gc=1 E25Gd=1
      PCCE    00000100  (E40G/E50G/E100G)  E100Ga=0 E100Gb=1

It can be enforced using:
  setenv hwconfig serdes1:split && saveenv

then lx2160a_serdes_apply_hwconfig() reads that and applies the split.
hwconfig is the established Layerscape mean for this kind of per-board
runtime choice.

Currently, only QDS boards have daughter boards for this feature.

It requires LX2160A CPU that has Lynx 28G Serdes.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 board/nxp/lx2160a/Makefile         |   1 +
 board/nxp/lx2160a/eth_lx2160aqds.c |   9 +
 board/nxp/lx2160a/serdes_split.c   | 509 +++++++++++++++++++++++++++++
 board/nxp/lx2160a/serdes_split.h   |  35 ++
 4 files changed, 554 insertions(+)
 create mode 100644 board/nxp/lx2160a/serdes_split.c
 create mode 100644 board/nxp/lx2160a/serdes_split.h

diff --git a/board/nxp/lx2160a/Makefile b/board/nxp/lx2160a/Makefile
index c9561bfadea..4df6d8a8c72 100644
--- a/board/nxp/lx2160a/Makefile
+++ b/board/nxp/lx2160a/Makefile
@@ -6,6 +6,7 @@
 
 obj-y += lx2160a.o
 obj-y += ddr.o
+obj-y += serdes_split.o
 obj-$(CONFIG_TARGET_LX2160ARDB) += eth_lx2160ardb.o
 obj-$(CONFIG_TARGET_LX2160AQDS) += eth_lx2160aqds.o
 obj-$(CONFIG_TARGET_LX2162AQDS) += eth_lx2162aqds.o
diff --git a/board/nxp/lx2160a/eth_lx2160aqds.c b/board/nxp/lx2160a/eth_lx2160aqds.c
index 4c16f565b69..c1a060877cd 100644
--- a/board/nxp/lx2160a/eth_lx2160aqds.c
+++ b/board/nxp/lx2160a/eth_lx2160aqds.c
@@ -9,11 +9,20 @@
 #include <exports.h>
 #include <fsl-mc/fsl_mc.h>
 
+#include "serdes_split.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
 {
+	/*
+	 * Before the MC boots: it latches the live protocol-converter
+	 * configuration when it starts, so `hwconfig=serdes1:split` has to
+	 * be applied here and not later.
+	 */
+	lx2160a_serdes_apply_hwconfig();
+
 #if defined(CONFIG_FSL_MC_ENET)
 	mc_env_boot();
 #endif
diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
new file mode 100644
index 00000000000..ca3d7228977
--- /dev/null
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * LX2160A 28G-Lynx SerDes inspection (`lx2160_serdes`).
+ */
+
+#include <command.h>
+#include <hwconfig.h>
+#include <vsprintf.h>
+#include <asm/io.h>
+#include <asm/arch/fsl_serdes.h>
+#include <asm/arch/immap_lsch3.h>
+#include <asm/arch/soc.h>		/* gur_in32() picks the GUR endianness */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+
+#include "serdes_split.h"
+
+#if defined(CONFIG_SYS_NXP_SRDS_3)
+#define SRDS_COUNT		3
+#else
+#define SRDS_COUNT		2	/* LX2162A has no SerDes 3 */
+#endif
+#define SRDS_LANES		8
+#define SRDS_BLOCK_STRIDE	0x10000
+#define SRDS_LANE_STRIDE	0x100
+
+#define SRDS_LNmGCR0(b, m)	((b) + 0x800 + (m) * SRDS_LANE_STRIDE)
+#define SRDS_LNmTRSTCTL(b, m)	((b) + 0x820 + (m) * SRDS_LANE_STRIDE)
+#define SRDS_LNmRRSTCTL(b, m)	((b) + 0x840 + (m) * SRDS_LANE_STRIDE)
+#define SRDS_PCCC(b)		((b) + 0x10B0)
+#define SRDS_PCCD(b)		((b) + 0x10B4)
+#define SRDS_PCCE(b)		((b) + 0x10B8)
+
+/* LNmGCR0 */
+#define GCR0_PORT_RST_LEFT	BIT(17)
+#define GCR0_PORT_LN0_B		BIT(16)
+#define GCR0_PROTO_SEL_MASK	0x000000F8
+#define GCR0_PROTO_SEL_SHIFT	3
+#define GCR0_IF_WIDTH_MASK	0x00000007
+
+/* LNmTRSTCTL and LNmRRSTCTL share a layout */
+#define RSTCTL_RST_REQ		BIT(31)
+#define RSTCTL_RST_DONE		BIT(30)
+#define RSTCTL_HLT_REQ		BIT(27)
+#define RSTCTL_STP_REQ		BIT(26)
+#define RSTCTL_DIS		BIT(24)
+
+/* PCCE: E100Ga at 14-12 (LRV 15), E100Gb at 10-8 (LRV 11) */
+#define PCCE_E100GA_CFG(v)	(((v) >> 12) & 0x7)
+#define PCCE_E100GA_LRV(v)	(((v) >> 15) & 0x1)
+#define PCCE_E100GB_CFG(v)	(((v) >>  8) & 0x7)
+#define PCCE_E100GB_LRV(v)	(((v) >> 11) & 0x1)
+
+/* PCCD: E25Ga..E25Gh, 3 bits each, a at 30-28 down to h at 2-0 */
+#define PCCD_E25G_CFG(v, i)	(((v) >> (28 - 4 * (i))) & 0x7)
+
+static unsigned long srds_base(int sd)
+{
+	return CFG_SYS_FSL_LSCH3_SERDES_ADDR + (unsigned long)sd * SRDS_BLOCK_STRIDE;
+}
+
+static const char *proto_sel_name(u32 sel)
+{
+	switch (sel) {
+	case 0x00: return "PCIe";
+	case 0x01: return "SGMII/1000Base-KX";
+	case 0x02: return "SATA";
+	case 0x0A: return "XFI/SFI/10GBase-R/KR, 10G-SXGMII, 40GBase-R/KR";
+	case 0x1A: return "25GBase-R/KR, 50GAUI2, 100G CAUI4";
+	default:   return "reserved";
+	}
+}
+
+static const char *if_width_name(u32 w)
+{
+	switch (w) {
+	case 0: return "10-bit";
+	case 1: return "16-bit";
+	case 2: return "20-bit";
+	case 3: return "32-bit";
+	case 4: return "40-bit";
+	default: return "?";
+	}
+}
+
+static void print_rstctl(const char *what, u32 v)
+{
+	printf("      %s %08x  [%s%s%s%s%s ]\n", what, v,
+	       (v & RSTCTL_RST_REQ)  ? " RST_REQ"  : "",
+	       (v & RSTCTL_RST_DONE) ? " RST_DONE" : "",
+	       (v & RSTCTL_HLT_REQ)  ? " HLT_REQ"  : "",
+	       (v & RSTCTL_STP_REQ)  ? " STP_REQ"  : "",
+	       (v & RSTCTL_DIS)      ? " DIS"      : "");
+}
+
+/*
+ * PORT_LN0_B is the single most informative bit here. It
+ * must be 0 only on the port's master lane, and 0 on every single-lane
+ * port. So a run of lanes where exactly one has PORT_LN0_B=0 is one
+ * multi-lane port, and a run where all of them are 0 is that many
+ * one-lane ports. That is precisely what the 100G -> 4x 25G split
+ * changes, and it is invisible in RCWSR.
+ */
+static void print_lane(unsigned long base, int m)
+{
+	u32 gcr0 = in_le32((void __iomem *)SRDS_LNmGCR0(base, m));
+	u32 sel  = (gcr0 & GCR0_PROTO_SEL_MASK) >> GCR0_PROTO_SEL_SHIFT;
+	u32 wid  = gcr0 & GCR0_IF_WIDTH_MASK;
+
+	printf("  lane %d (LN%c)\n", m, 'A' + m);
+	printf("      GCR0    %08x  PORT_RST_LEFT=%d PORT_LN0_B=%d (%s)\n",
+	       gcr0,
+	       (gcr0 & GCR0_PORT_RST_LEFT) ? 1 : 0,
+	       (gcr0 & GCR0_PORT_LN0_B) ? 1 : 0,
+	       (gcr0 & GCR0_PORT_LN0_B) ? "follows a master lane"
+					: "port master / single-lane port");
+	printf("                        PROTO_SEL=%02x (%s) IF_WIDTH=%d (%s)\n",
+	       sel, proto_sel_name(sel), wid, if_width_name(wid));
+	print_rstctl("TRSTCTL", in_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m)));
+	print_rstctl("RRSTCTL", in_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m)));
+}
+
+/*
+ * Summarise the port grouping, which is the one line that says whether a
+ * split happened. With PORT_RST_LEFT=0 the port's master is
+ * its right-most lane (towards LNH), with PORT_RST_LEFT=1 it is the
+ * left-most: PORT_LN0_B=0 marks that master, and is also 0 on every
+ * single-lane port. So a group is a run of PORT_LN0_B=1 lanes terminated
+ * (or led) by a PORT_LN0_B=0 lane.
+ *
+ * Checked on board with the PBI split applied:
+ *   [LNA-LND] [LNE] [LNF] [LNG] [LNH]   -- 1x 100G + 4x 25G
+ * and without it lanes E-H would read as a second [LNE-LNH] group.
+ */
+static void print_grouping(unsigned long base)
+{
+	u32 gcr0[SRDS_LANES];
+	bool claimed[SRDS_LANES];
+	int m, orphan = 0;
+
+	for (m = 0; m < SRDS_LANES; m++) {
+		gcr0[m] = in_le32((void __iomem *)SRDS_LNmGCR0(base, m));
+		claimed[m] = false;
+	}
+
+	printf("  port grouping (PORT_LN0_B)  ");
+	for (m = 0; m < SRDS_LANES; m++) {
+		int s, e;
+
+		if (gcr0[m] & GCR0_PORT_LN0_B)
+			continue;               /* a follower, not a master */
+
+		s = m;
+		e = m;
+		if (gcr0[m] & GCR0_PORT_RST_LEFT) {
+			while (e + 1 < SRDS_LANES &&
+			       (gcr0[e + 1] & GCR0_PORT_LN0_B))
+				e++;
+		} else {
+			while (s - 1 >= 0 && (gcr0[s - 1] & GCR0_PORT_LN0_B))
+				s--;
+		}
+
+		if (s == e)
+			printf("[LN%c] ", 'A' + s);
+		else
+			printf("[LN%c-LN%c] ", 'A' + s, 'A' + e);
+
+		while (s <= e)
+			claimed[s++] = true;
+	}
+
+	for (m = 0; m < SRDS_LANES; m++)
+		if (!claimed[m])
+			orphan++;
+	if (orphan)
+		printf(" (%d lane%s claimed by no master)", orphan,
+		       orphan == 1 ? "" : "s");
+	printf("\n");
+}
+
+static void print_converters(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+	int i, any = 0;
+
+	printf("  protocol converters\n");
+	printf("      PCCC    %08x  (SXGMII/XFI)\n", pccc);
+	printf("      PCCD    %08x  (E25G)  ", pccd);
+	for (i = 0; i < SRDS_LANES; i++) {
+		u32 cfg = PCCD_E25G_CFG(pccd, i);
+
+		if (cfg)
+			printf("%sE25G%c=%d", any++ ? " " : "", 'a' + i, cfg);
+	}
+	printf("%s\n", any ? "" : "none enabled");
+
+	printf("      PCCE    %08x  (E40G/E50G/E100G)  E100Ga=%d%s E100Gb=%d%s\n",
+	       pcce,
+	       PCCE_E100GA_CFG(pcce), PCCE_E100GA_LRV(pcce) ? " (lane-reversed)" : "",
+	       PCCE_E100GB_CFG(pcce), PCCE_E100GB_LRV(pcce) ? " (lane-reversed)" : "");
+}
+
+static void print_rcw_view(int sd)
+{
+	struct ccsr_gur __iomem *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
+	u32 cfg;
+	int regsr, shift;
+	u32 mask;
+
+	switch (sd) {
+	case FSL_SRDS_1:
+		regsr = FSL_CHASSIS3_SRDS1_REGSR;
+		mask  = FSL_CHASSIS3_SRDS1_PRTCL_MASK;
+		shift = FSL_CHASSIS3_SRDS1_PRTCL_SHIFT;
+		break;
+	case FSL_SRDS_2:
+		regsr = FSL_CHASSIS3_SRDS2_REGSR;
+		mask  = FSL_CHASSIS3_SRDS2_PRTCL_MASK;
+		shift = FSL_CHASSIS3_SRDS2_PRTCL_SHIFT;
+		break;
+#if defined(CONFIG_SYS_NXP_SRDS_3)
+	case NXP_SRDS_3:
+		regsr = FSL_CHASSIS3_SRDS3_REGSR;
+		mask  = FSL_CHASSIS3_SRDS3_PRTCL_MASK;
+		shift = FSL_CHASSIS3_SRDS3_PRTCL_SHIFT;
+		break;
+#endif
+	default:
+		return;
+	}
+
+	cfg = (gur_in32(&gur->rcwsr[regsr - 1]) & mask) >> shift;
+	printf("  RCWSR%-2d  raw=0x%04x -> protocol %d\n",
+	       regsr, cfg, serdes_get_number(sd, cfg));
+	printf("           this is what the Service Processor latched before the PBI ran,\n");
+	printf("           and what fsl_serdes_init() built its DPMAC map from.\n");
+}
+
+#if defined(CONFIG_ARCH_LX2160A)
+
+/*
+ * The split itself.
+ *
+ * This is NXP's e100g1_split.rcw sequence, moved from the PBI into
+ * U-Boot.
+ */
+#define SPLIT_FIRST_LANE	4	/* LNE */
+#define SPLIT_LAST_LANE		7	/* LNH */
+
+/*
+ * PROTO_SEL=11010b (25G/50G/100G, shared) + IF_WIDTH=100b (40-bit),
+ * PORT_RST_LEFT=0 and PORT_LN0_B=0 so every lane becomes its own
+ * single-lane port. Only those last two bits actually change: the
+ * protocol and width are already what CAUI-4 was using.
+ */
+#define SPLIT_GCR0		0x000000D4
+#define SPLIT_PCCE		0x00000100	/* E100Ga off, E100Gb on   */
+#define SPLIT_PCCD		0x11110000	/* E25Ga..E25Gd on         */
+
+#define SPLIT_POLL_US		10000		/* NXP waits ~100 cycles   */
+
+static bool srds1_split_state(unsigned long base)
+{
+	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E100GA_CFG(pcce) == 0 &&
+	       PCCD_E25G_CFG(pccd, 0) && PCCD_E25G_CFG(pccd, 1) &&
+	       PCCD_E25G_CFG(pccd, 2) && PCCD_E25G_CFG(pccd, 3);
+}
+
+bool lx2160a_serdes1_is_split(void)
+{
+	return srds1_split_state(srds_base(FSL_SRDS_1));
+}
+
+static bool srds1_is_unsplit(unsigned long base)
+{
+	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E100GA_CFG(pcce) != 0 && PCCE_E100GB_CFG(pcce) != 0 &&
+	       PCCD_E25G_CFG(pccd, 0) == 0 && PCCD_E25G_CFG(pccd, 1) == 0 &&
+	       PCCD_E25G_CFG(pccd, 2) == 0 && PCCD_E25G_CFG(pccd, 3) == 0;
+}
+
+/*
+ * Wait for a self-clearing request bit. Per the doc, hardware
+ * clears HLT_REQ when the halt completes and RST_REQ when the reset
+ * completes.
+ */
+static int poll_clear(unsigned long reg, u32 bit)
+{
+	int us = SPLIT_POLL_US;
+
+	while (us--) {
+		if (!(in_le32((void __iomem *)reg) & bit))
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int lx2160a_serdes1_split(void)
+{
+	unsigned long base = srds_base(FSL_SRDS_1);
+	int m, master = -1, ret = 0;
+
+	if (srds1_split_state(base)) {
+		debug("lx2160a serdes: SD1 already split, nothing to do\n");
+		return 0;
+	}
+
+	if (!srds1_is_unsplit(base)) {
+		printf("lx2160a serdes: SD1 is in neither the split nor the unsplit state (PCCD=%08x PCCE=%08x), refusing\n",
+		       in_le32((void __iomem *)SRDS_PCCD(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EINVAL;
+	}
+
+	/*
+	 * Halt. "Halt only has meaning on the master source
+	 * clock lane of a port (LNmGCR0[PORT_LN0_B]=0)". Lanes E-H are one
+	 * 100G port at this point, so exactly one of them is the master and
+	 * the other three requests are ignored. Issue all four anyway
+	 * (that is what NXP's sequence does) but only wait on the lane
+	 * where the bit can actually clear.
+	 */
+	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
+		      GCR0_PORT_LN0_B))
+			master = m;
+		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
+			 RSTCTL_HLT_REQ);
+		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
+			 RSTCTL_HLT_REQ);
+	}
+
+	if (master < 0) {
+		printf("lx2160a serdes: no master lane among LNE-LNH, refusing\n");
+		return -EINVAL;
+	}
+
+	if (poll_clear(SRDS_LNmTRSTCTL(base, master), RSTCTL_HLT_REQ) ||
+	    poll_clear(SRDS_LNmRRSTCTL(base, master), RSTCTL_HLT_REQ)) {
+		printf("lx2160a serdes: LN%c did not halt within %d us, continuing\n",
+		       'A' + master, SPLIT_POLL_US);
+		ret = -ETIMEDOUT;
+	}
+
+	/*
+	 * Reconfigure while halted: four one-lane ports instead of one
+	 * four-lane port. Everything else about the lane is unchanged.
+	 */
+	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), SPLIT_GCR0);
+
+	/* Re-point the protocol converters. */
+	out_le32((void __iomem *)SRDS_PCCE(base), SPLIT_PCCE);
+	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
+
+	/* Reset. Every lane is its own master now, so all four count. */
+	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+	}
+
+	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+		u32 t, r;
+
+		if (poll_clear(SRDS_LNmTRSTCTL(base, m), RSTCTL_RST_REQ) ||
+		    poll_clear(SRDS_LNmRRSTCTL(base, m), RSTCTL_RST_REQ)) {
+			printf("lx2160a serdes: LN%c reset did not complete within %d us\n",
+			       'A' + m, SPLIT_POLL_US);
+			ret = -ETIMEDOUT;
+			continue;
+		}
+
+		t = in_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m));
+		r = in_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m));
+		if (!(t & RSTCTL_RST_DONE) || !(r & RSTCTL_RST_DONE)) {
+			printf("lx2160a serdes: LN%c reset finished without RST_DONE (TRSTCTL=%08x RRSTCTL=%08x)\n",
+			       'A' + m, t, r);
+			ret = -EIO;
+		}
+	}
+
+	if (!srds1_split_state(base)) {
+		printf("lx2160a serdes: split did not take (PCCD=%08x PCCE=%08x)\n",
+		       in_le32((void __iomem *)SRDS_PCCD(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EIO;
+	}
+
+	printf("lx2160a serdes: SD1 100GE.1 split into 4x 25G%s\n",
+	       ret ? " (with warnings above)" : "");
+
+	return ret;
+}
+
+/*
+ *   setenv hwconfig serdes1:split
+ *
+ * Idempotent: a board whose PBI already split SD1 skip it too.
+ */
+void lx2160a_serdes_apply_hwconfig(void)
+{
+	if (!hwconfig_sub("serdes1", "split"))
+		return;
+
+	if (lx2160a_serdes1_is_split())
+		return;
+
+	lx2160a_serdes1_split();
+}
+
+#endif /* CONFIG_ARCH_LX2160A */
+
+static int do_serdes_status(int sd)
+{
+	unsigned long base = srds_base(sd);
+	int m;
+
+	printf("SerDes %d @ 0x%08lx\n", sd + 1, base);
+	print_rcw_view(sd);
+	print_grouping(base);
+	print_converters(base);
+	for (m = 0; m < SRDS_LANES; m++)
+		print_lane(base, m);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
+			    int argc, char *const argv[])
+{
+	int sd;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (!strcmp(argv[1], "split")) {
+#if !defined(CONFIG_ARCH_LX2160A)
+		printf("no 100GE on SerDes 1 to split on this SoC\n");
+		return CMD_RET_FAILURE;
+#else
+		if (argc != 2)
+			return CMD_RET_USAGE;
+		if (lx2160a_serdes1_is_split()) {
+			printf("SD1 is already split, nothing to do\n");
+			return CMD_RET_SUCCESS;
+		}
+		if (lx2160a_serdes1_split())
+			return CMD_RET_FAILURE;
+		return CMD_RET_SUCCESS;
+#endif
+	}
+
+	if (strcmp(argv[1], "status"))
+		return CMD_RET_USAGE;
+
+	if (argc == 2) {
+		for (sd = FSL_SRDS_1; sd < SRDS_COUNT; sd++) {
+			do_serdes_status(sd);
+			if (sd != SRDS_COUNT - 1)
+				printf("\n");
+		}
+		return CMD_RET_SUCCESS;
+	}
+
+	sd = (int)dectoul(argv[2], NULL) - 1;
+	if (sd < FSL_SRDS_1 || sd >= SRDS_COUNT) {
+		printf("SerDes must be 1, 2 or 3\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return do_serdes_status(sd);
+}
+
+#if defined(CONFIG_ARCH_LX2160A)
+#define SPLIT_CMD_HELP							\
+	"lx2160_serdes split\n"						\
+	"    - split Lynx 28G SD1 100GE.1 (lanes LNE-LNH) into 4x 25G.\n"	\
+	"      Runs before the MC starts. To make it permanent on a board\n"	\
+	"      that needs it: setenv hwconfig serdes1:split && saveenv"
+#else
+#define SPLIT_CMD_HELP ""
+#endif
+
+U_BOOT_CMD(
+	lx2160_serdes, 3, 0, do_lx2160_serdes,
+	"inspect the LX2160A 28G-Lynx SerDes protocol configuration",
+	"status [1|2|3]\n"
+	"    - print the live protocol converters (PCCC/PCCD/PCCE) and the\n"
+	"      per-lane port grouping and protocol (LNmGCR0), next to the\n"
+	"      protocol number the RCW latched.\n"
+	"      No argument prints all three SerDes."
+	SPLIT_CMD_HELP
+);
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
new file mode 100644
index 00000000000..67e8c4873a7
--- /dev/null
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ */
+
+#ifndef __LX2160A_SERDES_SPLIT_H
+#define __LX2160A_SERDES_SPLIT_H
+
+/*
+ * The split is LX2160A only: LX2162A's SerDes 1 is four lanes with no
+ * 100GE in its protocol table.
+ */
+#if defined(CONFIG_ARCH_LX2160A)
+
+/* Is SerDes 1 already 1x 100G + 4x 25G? */
+bool lx2160a_serdes1_is_split(void);
+
+/*
+ * Split SerDes 1's 100GE.1 (lanes LNE-LNH) into 4x 25G.
+ *
+ * Refuses unless SD1 is in the unsplit state, and must be called before
+ * the Management Complex starts: MC latches the live protocol-converter
+ * configuration when it boots.
+ */
+int lx2160a_serdes1_split(void);
+
+/*
+ * Apply `hwconfig=serdes1:split` if the board's environment asks for it.
+ * Boards call this from reset_phy(), before mc_env_boot().
+ */
+void lx2160a_serdes_apply_hwconfig(void);
+
+#endif /* CONFIG_ARCH_LX2160A */
+
+#endif /* __LX2160A_SERDES_SPLIT_H */
---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
branch: for-upstream/lx2160a-serdes-split-v1

-- 
2.43.0

