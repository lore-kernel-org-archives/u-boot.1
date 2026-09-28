Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E2EC9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1445C60697;
	Mon, 28 Sep 2026 10:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lxEXWxWToA0p; Mon, 28 Sep 2026 10:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 207C96067F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590567;
	b=JAacMM+1cQZYQGVK8XeGZmbLMMjK9rVhYhRsIqbYNoI2Mioss8x8l6Obt3elRlXcqUMf
	 wobIZ7takrF5k4FSvOa4JfUsjeq8gDpbnKzvSmJhnngIt7BPb3aa2McsIzrLGLcMKTQFO
	 HKrYSq2/xg2QltHFgXLhEBA0yKhFtOZdvZsUXdB4iSoeBBIUzqGJhJMhANxkIK1IBVysX
	 S0Tg4mhlgmtyw1HZodtjEPxf+khP1diiv1xvuB0l9+oW0QS+fqaUc3KCbhrhfZI9oVre6
	 pQFR8366sRtwVIq9zWdl/xaXybNTXeT7kmHt6DZzLB2znibTshPJvLS2ZA3eD5W4ZFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4v9F9+UN9/oEvlNIU37CzupRlwhrN5iglxPi3iHrI+k=;
	b=h/zbkPntYkgo1Un18je74cfs7hMaOOJEwGgIeRXE8BEPr8WPlU83fw7smP4flrNPQ5R+
	 2VImBgB1fLPGadYBJZO20zGyqUkWwp++QOi+DYO9xRxoj1dayaj6xz62okV9HRbzvEDg1
	 pM79PjvEyXzLNJL6noMRF+B+IOQ162Zm0iEZgCaA2QbL3xUm8vxpR5+E7gu9GQ/az3ITu
	 N+5FU5B+MkxtqjIkj9cnPb4n8cuIFAXNXhkWyDKv7ts+7SwhnLsz0LwyMQJjD5veykCnT
	 Q8J2CyoNAzmHOoSIKLpjafJnAT2Q/8XFFIAcB/oPvlgwYydZ9Znjg46Cdtv2fCNG9KQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590567;
	bh=4v9F9+UN9/oEvlNIU37CzupRlwhrN5iglxPi3iHrI+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ovD4Hiej6MCGCpUOSNzbXZU/KaR2+9m59TDVIWrnBI2pb4dQSXkWi3h13qDQq5pSa
	 pwre7xb2iaMpdomHp1qwxjV8L4gKddERxd0ie39fs3pdkDoVjg/iW2w/ofV+4BPU7K
	 u8vyKUFPc1rYEFfFgt4Opuhk9Z4mhx/udEz6XeJOjuv7AoOn0IQkg81m26c//7eChe
	 11783Cta4Y5/JCYgvi4cI5whKLmEXpMgM0p0PK7O7xCXds/BvKE7AU2RPL2zi9Mrww
	 zahMiN2OODAfMOfY2W1lQs5xNdSOm8YaTg0up3hp0eZ7yYEvY9683AgIFIShvAkSon
	 pAEDkIGs43LrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 207C96067F;
	Mon, 28 Sep 2026 10:16:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1E2F24E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9785340664
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcNXeGJwM0aR for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B1E7C402D3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590564;
 b=ZeL8vFvUmCLXPFYP0Vnybn4CrzPg1KUxuHCGe+Vc0LK/hQqgf0d3WL6O/pWQ3eZPsNta
 G3osU+6sBTgqYWYZFFrrHnSJzqZb78dvGbuiR+cPNnwb/Y7/2rurp2Fuj7uA2/J4Ooxd8
 PaiDrkio4jLXE5S5jXZb/oLwtuZDH2sGQPZMjD/+xByTadB579iW6YMb0KNy2dTebsrS/
 4vb9Mb4ci3dMhoFecuOdlp846VsiO/egVbS0AxFmyHwCsRcN9z4CWHVS9gV29jvPuidTu
 ed+jjyC8EofiTelGm8cUdUpXCwKl6ysP6OqS4u/5q+OtsYbhPGZJ238W/8awpbWpNgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590564;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4v9F9+UN9/oEvlNIU37CzupRlwhrN5iglxPi3iHrI+k=;
 b=NIc3X/fasLksacpbC3k3MHHak+z+BE5lyliVH1RGYellcFNcUXEoK1x10/Fs2sYsURQH
 8vGxe6J/DO3bP3ZIJW+f8qsLmC4zVWHfllygaVXC0VmxnRzdVP8zwsOCpsQ6g50c15vsJ
 mqW18dmFjlhJqKAKqAzq9TusGcsBd7lPb4OPT0xgA9/rXZxgAYPdv1TiO64EkCXhbAmP1
 4oEQKgIvA6GQHuNYMdICw5RVZ5bpQ4FDe8reG9KQnU4KzaahChlMC5xSZZA79rzlb9wQW
 s+cFbI+3hwDQx/ckqTQ2wc3Lh6k6FG6AG5QJjtDHuU2S9UifzOLQaiaHI6g927HFbCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=GC7VJXGQ; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=GC7VJXGQ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1E7C402D3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 93DBEB0054E;
 Mon, 28 Sep 2026 12:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590562;
 bh=EkiTzolUGC4j9csvONe1oe64kmW2Ztri0lChI76fodo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GC7VJXGQXbvPJJAn+hCUGyekzi9etvXNy1Cs0ZTB7Ugz+t3nasOjXnehT7innF7qH
 cK/JNSdSh/kzkUijZymLpI7hkr+8rLGBwei6MDAVb7OA+uz5/uGPCcQ9f8POPhEWwA
 L20M1xF4qP4ZT6yR5uF4gqWHvfzniV6ZJk/BBs1L9BvDlImDrigzNEDqb3UsTEEm3H
 tNxXlvrAw6VvITKNo8VIZVuwdW0e3cbge+4J5CTkX1b9pFwzSJ0Jf05zKJk8+wf7IW
 ssj016x2E6Wx7Y06FtMSmmKxL+ONoDU4s/XoblfH5NKe0P33ZREbvV9Dmy1XbUmCpV
 G95qFVICX1qgQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 06/10] board: lx2160a: serdes: add serdes1:2x40g
Date: Mon, 28 Sep 2026 12:13:25 +0200
Message-ID: <20260928101330.881662-7-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
References: <20260928101330.881662-1-vjardin@free.fr>
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

Add a SD1 mode that makes the two 100GE ports of protocol 13
two 40GE (XLAUI-4) ports, dpmac.2 on LNA-LND and dpmac.1 on LNE-LNH,
as protocol 20 would have built them.

Sequence:
  - bring PLLS up and wait for its lock
  - halt PLLF, which puts all eight lanes in reset
  - make them 2x 4-lane ports on PLLS with their master lanes kept
  - switch PCCE from E100G to E40G
  - reset PLLS which restarts every lane

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- was on v3 2/5, now it is an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 138 +++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 057d3c97739..104baa6b181 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -29,10 +29,17 @@
 #define SRDS_LANES		8
 #define SRDS_BLOCK_STRIDE	0x10000
 #define SRDS_LANE_STRIDE	0x100
+#define SRDS_PLL_STRIDE		0x100
 
+#define SRDS_PLLnRSTCTL(b, n)	((b) + 0x400 + (n) * SRDS_PLL_STRIDE)
+#define SRDS_PLLnCR0(b, n)	((b) + 0x404 + (n) * SRDS_PLL_STRIDE)
+#define SRDS_PLLnCR1(b, n)	((b) + 0x408 + (n) * SRDS_PLL_STRIDE)
+#define SRDS_PLLnCR5(b, n)	((b) + 0x414 + (n) * SRDS_PLL_STRIDE)
 #define SRDS_LNmGCR0(b, m)	((b) + 0x800 + (m) * SRDS_LANE_STRIDE)
 #define SRDS_LNmTRSTCTL(b, m)	((b) + 0x820 + (m) * SRDS_LANE_STRIDE)
+#define SRDS_LNmTGCR0(b, m)	((b) + 0x824 + (m) * SRDS_LANE_STRIDE)
 #define SRDS_LNmRRSTCTL(b, m)	((b) + 0x840 + (m) * SRDS_LANE_STRIDE)
+#define SRDS_LNmRGCR0(b, m)	((b) + 0x844 + (m) * SRDS_LANE_STRIDE)
 #define SRDS_PCCC(b)		((b) + 0x10B0)
 #define SRDS_PCCD(b)		((b) + 0x10B4)
 #define SRDS_PCCE(b)		((b) + 0x10B8)
@@ -51,6 +58,14 @@
 #define RSTCTL_STP_REQ		BIT(26)
 #define RSTCTL_DIS		BIT(24)
 
+/* PLLnRSTCTL adds two status bits the lane RSTCTLs do not have */
+#define PLLRSTCTL_RST_ERR	BIT(29)		/* no lock before time-out  */
+#define PLLRSTCTL_LOCK		BIT(23)		/* PLL calibrated + locked  */
+
+/* PCCE: E40Ga at 30-28 (LRV 31), E40Gb at 26-24 (LRV 27) */
+#define PCCE_E40GA_CFG(v)	(((v) >> 28) & 0x7)
+#define PCCE_E40GB_CFG(v)	(((v) >> 24) & 0x7)
+
 /* PCCE: E100Ga at 14-12 (LRV 15), E100Gb at 10-8 (LRV 11) */
 #define PCCE_E100GA_CFG(v)	(((v) >> 12) & 0x7)
 #define PCCE_E100GA_LRV(v)	(((v) >> 15) & 0x1)
@@ -255,6 +270,7 @@ struct sd1_mode {
 	int (*enter)(unsigned long base);
 };
 
+#define SD1_LNA_LND		GENMASK(3, 0)
 #define SD1_LNE_LNH		GENMASK(7, 4)
 
 #define SRDS_POLL_US		10000		/* NXP waits ~100 cycles   */
@@ -429,6 +445,121 @@ static int sd1_enter_100g4x25g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 2x40GE (XLAUI-4), dpmac.2 on LNA-LND and dpmac.1 on LNE-LNH,
+ * protocol 20 builds the same.
+ *
+ * 40GE lanes run at 10.3125 Gbaud. LNmTGCR0/LNmRGCR0[BY_N_RATE_SEL] is
+ * the lane rate as a fraction of the PLL clock: 011b (double) for 25G
+ * and 100GE, 000b (full) for 40GE, so the lanes cannot stay on PLLF (fast)
+ * and move to PLLS (slow).
+ *
+ * Protocol 13 powers PLLS down only through PLLnRSTCTL[DIS], which
+ * software can clear. PLLS then gets the values a board booted with
+ * protocol 20 reads back. They are for a 161.1328125 MHz reference
+ * clock: the board has to feed PLLS that, which the RCW does not
+ * describe for protocol 13 and which cannot be checked from here.
+ */
+#define SRDS_PLLF		0
+#define SRDS_PLLS		1
+#define SLOW_PLLS_CR0		0x00040000	/* REFCLK_SEL=00100b, 161.1328125 MHz */
+#define SLOW_PLLS_CR1		0x86100008	/* 10.3125 GHz clock net */
+#define SLOW_PLLS_CR5		0x00001000
+/* PROTO_SEL=01010b (XFI/10GBase-R/40GBase-R) + IF_WIDTH=010b (20-bit) */
+#define F40G_GCR0_MASTER	0x00000052
+#define F40G_GCR0_SLAVE		0x00010052
+/* LNmTGCR0/LNmRGCR0: USE_SLOW_PLL=1 (bit 28), BY_N_RATE_SEL=000b full */
+#define SLOW_LANE_GCR		0x10000000
+#define F40G_PCCE		0x11000000	/* E40Ga+E40Gb on, E100G off */
+
+static bool sd1_is_2x40g(unsigned long base)
+{
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E40GA_CFG(pcce) != 0 && PCCE_E40GB_CFG(pcce) != 0 &&
+	       PCCE_E100GA_CFG(pcce) == 0 && PCCE_E100GB_CFG(pcce) == 0;
+}
+
+/* Program PLLS (Slow) for 10.3125 GHz, and wait for its lock */
+static int sd1_plls_up(unsigned long base)
+{
+	unsigned long rstctl = SRDS_PLLnRSTCTL(base, SRDS_PLLS);
+	u32 v;
+
+	out_le32((void __iomem *)SRDS_PLLnCR0(base, SRDS_PLLS), SLOW_PLLS_CR0);
+	out_le32((void __iomem *)SRDS_PLLnCR1(base, SRDS_PLLS), SLOW_PLLS_CR1);
+	out_le32((void __iomem *)SRDS_PLLnCR5(base, SRDS_PLLS), SLOW_PLLS_CR5);
+
+	out_le32((void __iomem *)rstctl, 0);		/* clears DIS */
+	out_le32((void __iomem *)rstctl, RSTCTL_RST_REQ);
+
+	if (poll_clear(rstctl, RSTCTL_RST_REQ)) {
+		printf("lx2160a serdes: SD1 PLLS reset did not complete within %d us\n",
+		       SRDS_POLL_US);
+		return -ETIMEDOUT;
+	}
+
+	v = in_le32((void __iomem *)rstctl);
+	if ((v & PLLRSTCTL_RST_ERR) || !(v & PLLRSTCTL_LOCK) ||
+	    !(v & RSTCTL_RST_DONE)) {
+		printf("lx2160a serdes: SD1 PLLS did not lock (PLLSRSTCTL=%08x)\n",
+		       v);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sd1_enter_2x40g(unsigned long base)
+{
+	unsigned long pllf = SRDS_PLLnRSTCTL(base, SRDS_PLLF);
+	unsigned long plls = SRDS_PLLnRSTCTL(base, SRDS_PLLS);
+	unsigned long lanes = SD1_LNA_LND | SD1_LNE_LNH;
+	int m, lo, hi, ret, err;
+
+	/* The two ports keep their master lanes. */
+	lo = sd1_port_master(base, SD1_LNA_LND);
+	hi = sd1_port_master(base, SD1_LNE_LNH);
+	if (lo < 0 || hi < 0)
+		return -EINVAL;
+
+	ret = sd1_plls_up(base);
+	if (ret)
+		return ret;
+
+	/*
+	 * Halt PLLF, which puts every lane using it, all eight, in reset
+	 * "to allow reconfiguration".
+	 */
+	out_le32((void __iomem *)pllf, RSTCTL_HLT_REQ);
+	if (poll_clear(pllf, RSTCTL_HLT_REQ)) {
+		printf("lx2160a serdes: SD1 PLLF did not halt within %d us, continuing\n",
+		       SRDS_POLL_US);
+		ret = -ETIMEDOUT;
+	}
+
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m),
+			 m == lo || m == hi ? F40G_GCR0_MASTER : F40G_GCR0_SLAVE);
+		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), SLOW_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), SLOW_LANE_GCR);
+	}
+
+	out_le32((void __iomem *)SRDS_PCCE(base), F40G_PCCE);
+
+	/* Every lane now selects PLLS, so one PLL reset restarts them all. */
+	out_le32((void __iomem *)plls, RSTCTL_RST_REQ);
+	if (poll_clear(plls, RSTCTL_RST_REQ)) {
+		printf("lx2160a serdes: SD1 PLLS reset did not complete within %d us\n",
+		       SRDS_POLL_US);
+		ret = -ETIMEDOUT;
+	}
+
+	err = sd1_reset_wait(base, lanes);
+
+	return err ? err : ret;
+}
+
 static const struct sd1_mode sd1_modes[] = {
 	{
 		.name = "2x100g",
@@ -442,6 +573,13 @@ static const struct sd1_mode sd1_modes[] = {
 		.is_active = sd1_is_100g4x25g,
 		.enter = sd1_enter_100g4x25g,
 	},
+	{
+		.name = "2x40g",
+		.desc = "2x 40GE",
+		.from = "2x100g",
+		.is_active = sd1_is_2x40g,
+		.enter = sd1_enter_2x40g,
+	},
 };
 
 static const struct sd1_mode *sd1_mode_findn(const char *name, size_t n)
-- 
2.43.0

