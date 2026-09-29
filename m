Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674DBCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DB7C607FF;
	Tue, 29 Sep 2026 19:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7oRq27plouYy; Tue, 29 Sep 2026 19:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2E039607E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710621;
	b=h0FDftYaCnvx+w/RPoQgX6SNqZdcvgvhgEBeBD3V/AaTlWgibIUI08rjAKsCnP0eNYEc
	 avrDGiq/Cg5qhSx3ykLBsrM21z4IImUmEwfSXAz5jPgsS1boexwMc+nLxIiLvyJJh5w3X
	 hWdATlOemnQwlgx+ftlZRL0/J/0aVvAOxGjr5yVuLko4ZRp13T4ThQMyVc/7DDvfg9W1/
	 KF02fFIOAK2R6o2fnzI6VuKaZ/uBSAxzfmEiDew8tUWpHHqQjyo4WlBuhyrWA2rMi/YTN
	 5ej6DKYCihA5C4lD+N+FJUoy4r2l0H6DClniyIFPD3yrUgdbxVIvMstF9oCSbrmgBSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710621;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U+11x7pLSCYLqUcYkd5Y6xGlcn6mfty5wWhtFP4BjxI=;
	b=Gt0uxOGDtI9OjvkoYgKX3TBlAgSyk+tozqWy75rhWJMts87MhdA1ogK1qxe3qVzqfXEZ
	 HoZh4YNLEF3Dg1Irx+g/x0QFOrT2635pYgSAh9oq4mtXAq+XoZmEZ/T8L1vRTbK3cG+ii
	 uWfS5O2X6H1ptUkxvfkZEuyruUJM9dLs9OMXwTZZsmqET/EuKksTfwxl3YaYKAjCK15on
	 mOuCbQn2+EIZm5cRZ/tGZUzyAbYD8QeScauF7hBh8Jhv0TmiaUZ8esy4XFK8QX5PWL6Cw
	 nE+JGEyNXGZVv59+IHkUlVvtHYuE0wK7jjwDkTu6AWhrS7R93QAuIHfCjII1YhCTq1w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710621;
	bh=U+11x7pLSCYLqUcYkd5Y6xGlcn6mfty5wWhtFP4BjxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NWzgbmWBTBryXhHj1yRf+/QK5E3gu3BNW/4Co2Dr4jTgjCYjsVOZmAf+jVli4YvU9
	 Nn+XKfo+Abia/5SNjuOUZRosHQwqBJAfumODDq/oJweKjXOnqWYItemdJ63i7k3RxC
	 UirymYNcz+VCO+SJ6Diqe8q+Q0ZgOdQwmKjipBViK5ZXrnBYC5CasiFd/TSqWfiZo2
	 1sl8Hci141SEmpeCKyamIfWVgk1OrnF2waTXZNhFVMMUyHxfpqPYbApU77aNf9EHYh
	 EU3RFiOY/zRQKIWVQ5WkGRTly6wuaOZ5T5pjsU9zeO70Ww+yTkjCJiNwh7zr+QNqls
	 vchsRUe4EjtBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E039607E3;
	Tue, 29 Sep 2026 19:37:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 494D632A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F7D8407BC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEF4UKZ7Pg44 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4A76A407AA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710618;
 b=NTnu0GDKX7+WURyhWdTo41olJyvYgob84wTujDXD8xT0nEb6dSPliie835HneP/0rcpl
 /2WbcB6L+Uh/LgEBQcHKopy6Y9j1p1gEXyOiEHdcMjZSfbXdorotl1T1l05PhZ84lZKxM
 NbicOSFpoqHpkXKqCJYUiTIIzG7IAaHuEgFSEJlxsxpQ1iTWncfsUHM/1KskqKWseRwzh
 69IzwYclxQxvArhAMev6M7JfTnzVv95snhNh/hJXrtLsYzg+F+hqGJb8N91vK0ruvu/Xb
 cMq5n+rEg2PrrXQM9zGFEzxq54mePSHN0jemzDXJCiGz1Bhx8fRdSkHPiZV5uOdutPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710618;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=U+11x7pLSCYLqUcYkd5Y6xGlcn6mfty5wWhtFP4BjxI=;
 b=Wc8v96FIO3aL2YRRvkVM003x9ch8PjmQqNlIhN40/eImjjHVFUjvbFCK6pUSNoaYjXtz
 lGUmwuS9+zaYJB7qDTNU0sUWYu1e57qtgodIuAqCeyKEnt0Hf4tUiElNzBK+PQvdD0744
 XFjjgvUPj7WtVTxgk3OnJj+H1Ap44+sU+21bsJwjpoC8InSv+or9Sj10c1GAnT02LNHSc
 lXDg5J393Pvd2D4jTEoMJYhv/xCcfEhsngaPHv0KN5ciAw2AjScZlUem1LSKi38M8OGqZ
 nnx73pQ/LqDt3XNKykltGmDuqiCSliRDdZeuEDXc88WfrEgWZ3ug+cs1FsPKCRx6GtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=uSSFrjjT; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=uSSFrjjT
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A76A407AA
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8079CB0054E;
 Tue, 29 Sep 2026 21:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710616;
 bh=U6EWLTKqcsDRvy43ow2AgiBYxljcWCzeF9IFiHBvoyo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uSSFrjjTqePGqyzdEr1soTzN6zUeu+DZfAfTn6nq2coWLvHW08L0WdHMXLQT/4Gv5
 nWbhLUthlQxI/m5SzyJI1EmWWYZ6DoH9RJz8bJPcdVub1dHTxXzdAIUj+l4iOi66FC
 OumlI4nssfh3dTLmofN8Spr4uNBBEk1c91oN5Yho85W+eO8hPmxK5Do3oOn+teDU2m
 sQOlsW2ku8cc0siJZvHU8+4CImKRzjetcwYoGdL57LVhsPIzcvsgOL8sni0G+I3CTx
 KutzcZ2Rgatkn+FiOtUloEnI7T6m26VB9rMgtk2yx8oR0bGA54fJ54Zrqt0yGn1llY
 PBJXNJp/D3O0Q==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 08/13] board: lx2160a: serdes: add serdes1:2x40g
Date: Tue, 29 Sep 2026 19:59:40 +0200
Message-ID: <20260929175947.1379710-9-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929175947.1379710-1-vjardin@free.fr>
References: <20260929175947.1379710-1-vjardin@free.fr>
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

(no changes since v4)

Changes in v4:
- was on v3 2/5, now it is an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 138 +++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index ba3be4bc0d7..859cbffb5c0 100644
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
@@ -261,6 +276,7 @@ struct sd1_mode {
  * This is NXP's e100g1_split.rcw sequence, moved from the PBI into
  * U-Boot.
  */
+#define SD1_LNA_LND		GENMASK(3, 0)
 #define SD1_LNE_LNH		GENMASK(7, 4)
 
 /*
@@ -431,6 +447,121 @@ static int sd1_enter_100g4x25g(unsigned long base)
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
@@ -444,6 +575,13 @@ static const struct sd1_mode sd1_modes[] = {
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
 
 static const struct sd1_mode *sd1_mode_find(const char *name, size_t len)
-- 
2.43.0

