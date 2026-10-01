Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A29CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7961B60811;
	Thu,  1 Oct 2026 20:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqpF1jfHUOBA; Thu,  1 Oct 2026 20:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6EAA5607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887845;
	b=ZYUvQgDtxZT55e6zYNLtp+Y2Q33JZOFlQk2FxuAFtKWmOCUFRGuozGW2xfIozF85BASz
	 5IETL/Gjv2NLMhAQYpgTyoMQhzNvWIvcDgsUQuCp/jGzAz/N0u9Be2W1JHT6nF138sfgv
	 Bk1BK+KtQAofX2lEeq5c74ChQ0ZAvg8TQgkGDMIKRiqmbY0w3cTp50OI+wtBlNbSnKGIs
	 19sq3c6zjmC30BP4V8y1GG+2TN7of8t6p72GqOKc6ytd7Ya8K8/9EIQ9ADjf6Kr6iL7eV
	 anQmbYYtLHyDgzSSmD88tBtR7PIZTx0kwT5pIalsHx8BT7auXJtU0Hs/bbL3fmubWkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Hnt7/zu4II0J2OhtZpnQ9FUBk9m7/V4Q0LYc+i19hyM=;
	b=Web7T8vIOfRLfkypcMN9mkhSduyQETOcGWRXtdbLRrEjBJyf+t2CHifBAEPInuj87eCE
	 iuEU8+c/2q9NRYqHQiusMBuYwAyoNFqrT1lgWQesKl9HmIrZpiVcEorsghuLOngSOJeEO
	 QVZOz20/+jrXEuytWThXnyeAdU1YPX4NAHSDv5q2mv3fbt3/ztxB0riMGqN2apjkfEkw6
	 fg6Fni2Uz8fgPLtLExTDERgFuPaVecYddCzA+lbWsZJ1nCSJTUcn5YFDgTNPvUUnAY+DV
	 dyBZX2l/S/Q8ZrmXnqhcPv5a7c/GoiOWpNTRTT/Yg0A0XrcAD98RfAAaI+Qg03yvHEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887845;
	bh=Hnt7/zu4II0J2OhtZpnQ9FUBk9m7/V4Q0LYc+i19hyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pjEoTEn4rwQZoSzHcSqHdh88qfmvqiec0++6F8HTlkJh8ZpUmLCUVgA22IXqrtiem
	 WImvMYkfdCHTyAcMHRCZhQ1GHd/whKRWiWyK4zSbhX21q2aFavuUnJGU5i9LlHCqqS
	 O1rhckkVtiNqetekc6dLhdP7OU2Cy+7+COmJ4F4d10WlrKwEnlV5UB8FmXIi4aIvOq
	 jYkQ9KYx/GMVSGypxsNsJw0R0DEj2EIjrRKCCXhCQUIZA4rfhbdiQQW4DYCCTorhH0
	 4uMD3wXs1Z4XMmYC9zWQ5OGsGetgpauwz9MDYFXMFjcXtCkOFeZ5/ymgmQRCnNluP7
	 EuNE9RrMi15fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EAA5607E7;
	Thu,  1 Oct 2026 20:50:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F21333B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 110FF8121E
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bj-7e28uB65y for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A93781205
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887843;
 b=p0JFMLkozBWcvDzKA01+gn3L7fNLV6bx3ZdKhxf6BfyXFBLQrPA98dK5BsBs6zO2EmGP
 0WeyD/o0DBGvhyfSBnqTrfPQ6AhA8+iP21eOPRYv6qjlwyLIUo8qc0DsYWoBkWiOYh+0Y
 4k5kFNYdvp32a2Bi5rbW7FIiybhAC2onFyB9iFAKZpP+f33qfZVP9iJRMdeTno+l3P3M1
 XqkreSphQGrhzTYdcwybueq8lx3CRe8vhorqj++adMnVtGDPL101oBnrormnL3RT8qrRS
 BL58npp9ndzOe2c3G6Bore1E48wwfv7SbDsGyFeB0aT3i63qHuSUAg+AUPfiTz+9/Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887843;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Hnt7/zu4II0J2OhtZpnQ9FUBk9m7/V4Q0LYc+i19hyM=;
 b=HcXsuNlE4zHPd3gWwdRPbPDYZ4dS0adYOXTXfPNHOBPSYX0xFiiNvnb01vtyMgVMh0Br
 O9vPU8c8j82Y4eybsUv7wuXCs0k21YHUzEcZlrLFcmaoSe2E4r6xy95ARa1DA4V2I45Bs
 koDj2WCrj6qJK4bibwJtgDTKQ3ZlyDwn0whH92bII3CJBi0L49bbiNL/2GkC7fYNuLMwe
 R3lM3r5OrmFev0PW08P3AsgZQNQreOdTNRwakL0PLwkEBQlDbaj0uzJVNlIGw63S1Yi70
 VGsrX4P1IM9anVXajE7b+gqTCF5NKfNegc3UKW13ECMyk8OCYnJNEgQuQORxnbMijKQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Sg85fesd; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Sg85fesd
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A93781205
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D9D86B00539;
 Thu,  1 Oct 2026 22:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887841;
 bh=FkNJyO6IwCT4uKPq8wvgVToNeoc7TVjPShobVVB/uu4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sg85fesdC7RhWZ/bLoMQz5GpQEbb5dF8VJFU+06JoDsE4u7yK9c5GA0PSLODzsLxL
 SjQEVok9qfHvP5hoxY2isE3SHl9XlKK+ZeFVl8RW3SkgWds3q8mEJ3/VVuKJNd9hHz
 j0bpAVhomkOaq6A/9+UIHOi0/9HBT3+GAi1zER5bEZ2PgP3Q1ML5xseeKDFXMwXa9U
 YQMKUgJAUF0Z1eTfhCPpS6gmGAnkmm0kMPvbbUbzw4ob1Sv3aaVLkr0gSSxAr5dXk6
 mmF9CGv966CrooiNvVMXdJMdw0TSaxrppQEkss+ifIAVcc8TKZLZ09+B7lgIpoQdnb
 TAzWv0gG3m9oQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 08/13] board: lx2160a: serdes: add serdes1:2x40g
Date: Thu,  1 Oct 2026 22:47:25 +0200
Message-ID: <20261001204731.1774613-9-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
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

Changes in v6:
- Better explain the move to PLLS by the clock net, not BY_N_RATE_SEL (Vladimir)
- Only 161.1328125 MHz PLLS reference clock is supported,
  from the PLLS input or through SRDS_INTRA_REF_CLK_S1

Changes in v4:
- was on v3 2/5, now it is an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 148 +++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index ba3be4bc0d7..0107e8636a6 100644
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
@@ -431,6 +447,131 @@ static int sd1_enter_100g4x25g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 2x40GE (XLAUI-4), dpmac.2 on LNA-LND and dpmac.1 on LNE-LNH,
+ * protocol 20 builds the same.
+ *
+ * A PLL makes one clock net, and each lane takes its rate from the
+ * clock net of one PLL, through its own BY_N_RATE_SEL. 25GE and 100GE
+ * lanes run at 25.78125 Gbaud, twice the 12.890625 GHz clock net of
+ * PLLF. 40GE lanes run at 10.3125 Gbaud, which no ratio of 12.890625
+ * GHz gives: they need the 10.3125 GHz clock net, which only PLLS
+ * makes (PLLnCR1[FRATE_SEL]=00110b). So the lanes move to PLLS.
+ *
+ * Protocol 13 does not use PLLS, and NXP's RCWs for it power it down
+ * (SRDS_PLL_PD_PLL2=1), which leaves PLLSRSTCTL[DIS] set: software can
+ * clear it. PLLS then gets the PLLSCR0/CR1/CR5 values the SoC loads
+ * for protocol 20 when SRDS_PLL_REF_CLK_SEL_S1 selects 161.1328125 MHz
+ * for PLLS.
+ *
+ * Only a 161.1328125 MHz PLLS reference clock is supported. It comes
+ * from the SD1 PLLS reference clock input, or from the PLLF one when
+ * the RCW sets SRDS_INTRA_REF_CLK_S1=1, as 25GE and 100GE already need
+ * 161.1328125 MHz on PLLF. 156.25 MHz, also valid for a 10.3125 GHz
+ * clock net, would need PLLSCR0[REFCLK_SEL]=00010b and is not handled.
+ * Nothing here can check the reference clock: PLLSRSTCTL[LOCK] does
+ * not tell its frequency.
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
@@ -444,6 +585,13 @@ static const struct sd1_mode sd1_modes[] = {
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

