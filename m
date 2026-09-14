Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03080C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 17:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B339B80E3E;
	Mon, 14 Sep 2026 17:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rP_H9psKbN9p; Mon, 14 Sep 2026 17:05:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6962780E32
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789405527;
	b=hWX8TKhHoc9BDg4n234tXs97j3BTjZdflfTFPb9kxr9S04qCY/J5+JQcdhv5K45MSakw
	 IyLOnAK672PBcbYEr0oAt575tQBgsPjxqFNngMyOmI5Yk9utZsvnGIbcWMdAIeTyR3Q7h
	 F6nWkS9rOYYhZkZTDG8cZl/2NIqs9Obet8+OW/zuL6p2kToZBL0R1oO4uPwU/ZtOHYHop
	 28YBXqlb7yKo26/2uOob8hejgJPeeK8punLUTwMo3DgJagdQ5YjM776JWeTX8qBdf+6dW
	 wysNmb5tmgiX4nw4hKlXUE9tveXld2yk2hRxfOs04BKOM42XK8SHCrdFcaLTtKMMk+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789405527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lEbOEEHiievNUW2CJV7O0FLKitBFbDc+BaZ43DzLynM=;
	b=IWGsTCQn59zB+4FbNPUxRypKa4FFGlcllJ4JZ0/BFr4V0s686AlNgW7lMOxqKYaTpXPq
	 oqi7FAYGdlkDoIeZdsm1HQgIHSs6UObOOdrGXvqKvlhKZwTYuhDfWnGBbmTtNPoLYFoET
	 ZwpmhIEf4pRebGIJNbRUUyaS1fMN6lPyCUvFYvnZJoVKi+GW75BH/HzIoZfFlCSahh0zY
	 xNVRPW9a7ReHI88oqbrxglgfDeJ2YPM9HpOf9dtRZ9pq9V+MhI5TTn7cXBpslous12C91
	 64QPRvLjdmtBXQtS8HSz5F3j1PBETdG0HmRRBBzjWE3YPbOvsF9Wx+Da8HBDuJUVfeA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789405527;
	bh=lEbOEEHiievNUW2CJV7O0FLKitBFbDc+BaZ43DzLynM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CTAYrpvTijwQY5xzKIDn7e/GzNIRwtWTVehQVFkdKdCy5wfGH//cffheZX6NuwEsQ
	 LWDkr63lmTAG5laiBJaHFV55U6IO+YJAhduigIB6AmXET6U0HuJgE1FTrVnM/iNHuL
	 MjGOEym4DTPbpyjSOumVimbhY/x3QkxOqbtD4AUi4Q57nPZHAAIgDhyjP+yd4zKxSw
	 rGMapw7bNNPqztDbjec1jSGO4vwpaHVxeNKkXYUua44W0Br94zjHuHvUXWDJGW2Hdg
	 UUAaIUfFXboYNMg7sz6JeQP27eElB9lSFZRsJHFPAgfWyedWh71TCO4m9WwVYIJVAI
	 Gzvd00GIwR6Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6962780E32;
	Mon, 14 Sep 2026 17:05:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0E31224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A618460708
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZjZqHYFbRBlz for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 17:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 92C7C6062A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789405524;
 b=FxkSP7KamiBO5qYprpjc0ZAnjo/lfQ9xb4n/x7KPKnmFMDeT4xSuLv1SGCQ3XuHsfjSk
 4XK4CKdk/rUHT/eAXx5XmjBe8oZyxM09sdJpvZKhgUrdGQ3e9lSBGHZXWj7HmmkVYOPBi
 OiGn+xzsQelwuLEgYINUa/WWlRIKFAgQbQskS0ioTNhaiJSTdYDEjsqwFh7DFaG/wihbV
 mg2qqOzoE0EOWnsK97fFJAFHQ8Q5E+igFZ6SevZqHLTTN6z6ImT73GFDDTEsbKpMJdYku
 VF+hfW7cxt0tVF+v/I48u/ZCO+uRF9xzlrEhLkxHFptvFavaWaS9pkm1Dr6e3zg/y7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789405524;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lEbOEEHiievNUW2CJV7O0FLKitBFbDc+BaZ43DzLynM=;
 b=MFSNkku/lO/z+eDcqqr114XeePAlKabVRwICzP3i2O8/ifxLbMCjqfVRBwpm5EW3EglQ
 PUiyaK9bkT5A0nWgyqpBxC4OzQhZ4bwg2gFxFbMWDnLTu/S90v93Zj0yMFMkCxBZfxJDZ
 wcwNGAnxPKidyisloG25x2V3ia2qh9RnIGUrWty5vO2wxvF05qC4L5H5Ep0Y2SN9mT6cb
 r3yqLg+3+6VavhuzvSmoZRDTnN5uypP4qCFT7SDO9EbxKzJ/HeprampHkBNeG7CdM22vO
 DjdLrwet7vxHva85ywU+1OCseZwnLqCVWwJiFSqCd5YtFzx8/1gXK7ynLU0tv+zIfcQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=BARVJGbm; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=BARVJGbm
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92C7C6062A
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 084B2B0051B;
 Mon, 14 Sep 2026 19:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789405521;
 bh=wDsce+buGs+WymWuJwyd1is3rhVDLab5z7sbUbbNf4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BARVJGbm1QJMzu12tuD1sC+V2cKAGKsOqvATNROvBAFyIJqAQ0AdBDq5g95AUVpFZ
 zn8axpoFT3MztFyA1kekI5WBtPfsevagPvqA4W/CB4ybx1CFAc7OYUVdamv7kKSREw
 SDhIFrzqgCAtKCBi72c7MwFL5sTNzkFZn5OUnn1pySmTfVbx5fG06XnYDq+GPQpU7O
 7ZsrD1KdwUQ+pdAIDsyMEJmv22I1+NAbYq0JJbyTNbMO/HtTX5QUdx4imSAX6O6UPo
 3jjt5c2eLNJ/sfa+3yxdLCsSZ9jXNEbF4USsdRaV0jD0Tsl7uspro42RZWtcZcJb6N
 B3tYarQTUfGoA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Tom Rini <trini@konsulko.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 2/5] board: lx2160a: convert SD1 2x100GE to 2x40GE at
 runtime
Date: Mon, 14 Sep 2026 19:04:14 +0200
Message-ID: <20260914170417.3052423-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170417.3052423-1-vjardin@free.fr>
References: <20260914170417.3052423-1-vjardin@free.fr>
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

add lx2160_sd1 2x40g, and parsing hwconfig=serdes1:2x40g for
the boot path, alongside the existing SD1 100G+25G split.

SRDS_PRTCL_S1 is POR-latched read-only, so this changes the hardware
the protocol number describes, not the number. That much is the same
trick as the split. What is not the same is the lane rate, and it is
the whole reason this is more than a converter code:

LNmTGCR0[BY_N_RATE_SEL] is the bit rate as a fraction of the PLL clock,
and the RM requires 011b (double) for 25G/100G and 000b (full) for
40G. The split stays on PLLF because 25G and 100G are the same
25.78125 Gbaud. 40GE is 10.3125 Gbaud, so it needs the other PLL.

The protocol 13 "powers down" PLLS only by setting PLLnRSTCTL[DIS],
software can clear it. Both SD1 refclk inputs are fed with a
161.1328125 MHz, so PLLS has what it needs.

The trick: the register values were read from the CPU from a
protocol-13 vs a protocol-20 build and diffed.

100g4x25g and 2x40g are mutually exclusive: 100g4x25g wins.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/serdes_split.c | 221 ++++++++++++++++++++++++++++++-
 board/nxp/lx2160a/serdes_split.h |  11 ++
 2 files changed, 228 insertions(+), 4 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 04339a71350..0f30019e20a 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -25,9 +25,17 @@
 #define SRDS_BLOCK_STRIDE	0x10000
 #define SRDS_LANE_STRIDE	0x100
 
+#define SRDS_PLL_STRIDE		0x100
 #define SRDS_LNmGCR0(b, m)	((b) + 0x800 + (m) * SRDS_LANE_STRIDE)
 #define SRDS_LNmTRSTCTL(b, m)	((b) + 0x820 + (m) * SRDS_LANE_STRIDE)
+#define SRDS_LNmTGCR0(b, m)	((b) + 0x824 + (m) * SRDS_LANE_STRIDE)
 #define SRDS_LNmRRSTCTL(b, m)	((b) + 0x840 + (m) * SRDS_LANE_STRIDE)
+#define SRDS_LNmRGCR0(b, m)	((b) + 0x844 + (m) * SRDS_LANE_STRIDE)
+/* n = 0 is PLLF (the fast PLL), n = 1 is PLLS (the slow one) */
+#define SRDS_PLLnRSTCTL(b, n)	((b) + 0x400 + (n) * SRDS_PLL_STRIDE)
+#define SRDS_PLLnCR0(b, n)	((b) + 0x404 + (n) * SRDS_PLL_STRIDE)
+#define SRDS_PLLnCR1(b, n)	((b) + 0x408 + (n) * SRDS_PLL_STRIDE)
+#define SRDS_PLLnCR5(b, n)	((b) + 0x414 + (n) * SRDS_PLL_STRIDE)
 #define SRDS_PCCC(b)		((b) + 0x10B0)
 #define SRDS_PCCD(b)		((b) + 0x10B4)
 #define SRDS_PCCE(b)		((b) + 0x10B8)
@@ -46,6 +54,14 @@
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
@@ -408,20 +424,196 @@ int lx2160a_serdes1_split(void)
 	return ret;
 }
 
+/*
+ * 2x 100GE -> 2x 40GE, without changing the RCW.
+ *
+ * LNmTGCR0[BY_N_RATE_SEL] is the transmitter bit rate as a fraction of
+ * the PLL clock.
+ *
+ * Protocol 13 powers PLLS down, but only by setting
+ *   PLLnRSTCTL[DIS] ("default value set by RCW configuration"),
+ * which software can clear.
+ * Both SD1 reference-clock inputs are fed 161.1328125 MHz.
+ *
+ * The register values below were analyzed from the CPU for both cases:
+ * protocol-13 vs protocol-20 run.
+ */
+#define F40G_PLLS		1		/* PLLS index in PLLnxxx()  */
+#define F40G_PLLF		0
+#define F40G_PLLS_CR0		0x00040000	/* REFCLK_SEL=4, 161.1328125 MHz */
+#define F40G_PLLS_CR1		0x86100008	/* 10.3125 GHz clock net    */
+#define F40G_PLLS_CR5		0x00001000
+/* PROTO_SEL=01010b (XFI/10GBase-R/40GBase-R) + IF_WIDTH=010b (20-bit) */
+#define F40G_GCR0_MASTER	0x00000052
+#define F40G_GCR0_SLAVE		0x00010052
+/* LNmTGCR0/LNmRGCR0: USE_SLOW_PLL=1 (bit 28), BY_N_RATE_SEL=000 full */
+#define F40G_LANE_GCR		0x10000000
+#define F40G_PCCE		0x11000000	/* E40Ga+E40Gb on, E100G off */
+
+static bool srds1_is_40g(unsigned long base)
+{
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E40GA_CFG(pcce) != 0 &&
+	       PCCE_E40GB_CFG(pcce) != 0 &&
+	       PCCE_E100GA_CFG(pcce) == 0 &&
+	       PCCE_E100GB_CFG(pcce) == 0;
+}
+
+bool lx2160a_serdes1_is_40g(void)
+{
+	return srds1_is_40g(srds_base(FSL_SRDS_1));
+}
+
+/*
+ * Bring PLLS up at the 40GE clock net. Nothing uses it yet, so this
+ * cannot disturb the running 100GE lanes on PLLF.
+ */
+static int srds1_plls_up_40g(unsigned long base)
+{
+	unsigned long rstctl = SRDS_PLLnRSTCTL(base, F40G_PLLS);
+	u32 v;
+
+	out_le32((void __iomem *)SRDS_PLLnCR0(base, F40G_PLLS), F40G_PLLS_CR0);
+	out_le32((void __iomem *)SRDS_PLLnCR1(base, F40G_PLLS), F40G_PLLS_CR1);
+	out_le32((void __iomem *)SRDS_PLLnCR5(base, F40G_PLLS), F40G_PLLS_CR5);
+
+	out_le32((void __iomem *)rstctl, 0);
+	out_le32((void __iomem *)rstctl, RSTCTL_RST_REQ);
+
+	if (poll_clear(rstctl, RSTCTL_RST_REQ)) {
+		printf("lx2160a serdes: SD1 PLLS reset did not complete within %d us\n",
+		       SPLIT_POLL_US);
+		return -ETIMEDOUT;
+	}
+
+	v = in_le32((void __iomem *)rstctl);
+	if (v & PLLRSTCTL_RST_ERR) {
+		printf("lx2160a serdes: SD1 PLLS did not lock (PLLSRSTCTL=%08x, RST_ERR)\n", v);
+		return -EIO;
+	}
+	if (!(v & PLLRSTCTL_LOCK) || !(v & RSTCTL_RST_DONE)) {
+		printf("lx2160a serdes: SD1 PLLS came up without LOCK/RST_DONE (PLLSRSTCTL=%08x)\n",
+		       v);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int lx2160a_serdes1_to_40g(void)
+{
+	unsigned long base = srds_base(FSL_SRDS_1);
+	unsigned long pllf = SRDS_PLLnRSTCTL(base, F40G_PLLF);
+	bool master[SRDS_LANES];
+	int m, ret = 0;
+
+	if (srds1_is_40g(base)) {
+		debug("lx2160a serdes: SD1 already 2x 40GE, nothing to do\n");
+		return 0;
+	}
+
+	if (!srds1_is_unsplit(base)) {
+		printf("lx2160a serdes: SD1 is not in the 2x 100GE state (PCCD=%08x PCCE=%08x), refusing\n",
+		       in_le32((void __iomem *)SRDS_PCCD(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EINVAL;
+	}
+
+	/*
+	 * Remember the port masters so the 2x4 grouping is preserved
+	 * rather than assumed to be LND and LNH.
+	 */
+	for (m = 0; m < SRDS_LANES; m++)
+		master[m] = !(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
+			      GCR0_PORT_LN0_B);
+
+	ret = srds1_plls_up_40g(base);
+	if (ret)
+		return ret;
+
+	/*
+	 * Halt PLLF, which puts every lane using it into reset "to allow
+	 * reconfiguration"
+	 */
+	out_le32((void __iomem *)pllf, RSTCTL_HLT_REQ);
+	if (poll_clear(pllf, RSTCTL_HLT_REQ)) {
+		printf("lx2160a serdes: SD1 PLLF did not halt within %d us, continuing\n",
+		       SPLIT_POLL_US);
+		ret = -ETIMEDOUT;
+	}
+
+	for (m = 0; m < SRDS_LANES; m++) {
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m),
+			 master[m] ? F40G_GCR0_MASTER : F40G_GCR0_SLAVE);
+		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), F40G_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), F40G_LANE_GCR);
+	}
+
+	out_le32((void __iomem *)SRDS_PCCE(base), F40G_PCCE);
+
+	/* Every lane now selects PLLS, so one PLL reset restarts them all. */
+	out_le32((void __iomem *)SRDS_PLLnRSTCTL(base, F40G_PLLS),
+		 RSTCTL_RST_REQ);
+	if (poll_clear(SRDS_PLLnRSTCTL(base, F40G_PLLS), RSTCTL_RST_REQ)) {
+		printf("lx2160a serdes: SD1 PLLS re-reset did not complete within %d us\n",
+		       SPLIT_POLL_US);
+		ret = -ETIMEDOUT;
+	}
+
+	for (m = 0; m < SRDS_LANES; m++) {
+		u32 t = in_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m));
+		u32 r = in_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m));
+
+		if (!(t & RSTCTL_RST_DONE) || !(r & RSTCTL_RST_DONE)) {
+			printf("lx2160a serdes: LN%c has no RST_DONE (TRSTCTL=%08x RRSTCTL=%08x)\n",
+			       'A' + m, t, r);
+			ret = -EIO;
+		}
+	}
+
+	if (!srds1_is_40g(base)) {
+		printf("lx2160a serdes: 40GE conversion did not take (PCCE=%08x)\n",
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EIO;
+	}
+
+	printf("lx2160a serdes: SD1 2x 100GE converted to 2x 40GE%s\n",
+	       ret ? " (with warnings above)" : "");
+	printf("lx2160a serdes: RCWSR still reads protocol 13 -- the DPC needs follow_hw_pssr\n");
+
+	return ret;
+}
+
 /*
  *   setenv hwconfig serdes1:100g4x25g
+ *   setenv hwconfig serdes1:2x40g
  *
  * Idempotent: a board whose PBI already split SD1 skip it too.
+ *
+ * The two are mutually exclusive -- one re-points lanes 4-7 to 25G on
+ * PLLF, the other moves all eight to 40GE on PLLS -- so `split` wins
+ * and `40g` is refused alongside it rather than layered on top.
  */
 void lx2160a_serdes_apply_hwconfig(void)
 {
-	if (!hwconfig_sub("serdes1", "100g4x25g"))
+	if (hwconfig_sub("serdes1", "100g4x25g")) {
+		if (hwconfig_sub("serdes1", "2x40g"))
+			printf("lx2160a serdes: hwconfig asks for both serdes1:100g4x25g and serdes1:2x40g, doing the split only\n");
+		if (lx2160a_serdes1_is_split())
+			return;
+
+		lx2160a_serdes1_split();
+		return;
+	}
+
+	if (!hwconfig_sub("serdes1", "2x40g"))
 		return;
 
-	if (lx2160a_serdes1_is_split())
+	if (lx2160a_serdes1_is_40g())
 		return;
 
-	lx2160a_serdes1_split();
+	lx2160a_serdes1_to_40g();
 }
 
 #endif /* CONFIG_ARCH_LX2160A */
@@ -463,6 +655,22 @@ static int do_lx2160_sd1(struct cmd_tbl *cmdtp, int flag,
 		return CMD_RET_SUCCESS;
 	}
 
+	if (!strcmp(argv[1], "2x40g")) {
+		if (!IS_ENABLED(CONFIG_ARCH_LX2160A)) {
+			printf("no 100GE on SerDes 1 to convert on this SoC\n");
+			return CMD_RET_FAILURE;
+		}
+		if (argc != 2)
+			return CMD_RET_USAGE;
+		if (lx2160a_serdes1_is_40g()) {
+			printf("SD1 is already 2x 40GE, nothing to do\n");
+			return CMD_RET_SUCCESS;
+		}
+		if (lx2160a_serdes1_to_40g())
+			return CMD_RET_FAILURE;
+		return CMD_RET_SUCCESS;
+	}
+
 	return CMD_RET_USAGE;
 }
 
@@ -501,7 +709,12 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
 	"100g4x25g\n"							\
 	"    - split Lynx 28G SD1 100GE.1 (lanes LNE-LNH) into 4x 25G.\n"	\
 	"      Runs before the MC starts. To make it permanent on a board\n"	\
-	"      that needs it: setenv hwconfig serdes1:100g4x25g && saveenv"
+	"      that needs it: setenv hwconfig serdes1:100g4x25g && saveenv\n"	\
+	"lx2160_sd1 2x40g\n"							\
+	"    - convert SD1 2x 100GE into 2x 40GE without touching the RCW.\n"	\
+	"      Must run before the MC starts, and the DPC must carry\n"		\
+	"      board_info/serdes/follow_hw_pssr: RCWSR still reads 13.\n"	\
+	"      Undo with `reset`. Permanent: setenv hwconfig serdes1:2x40g"
 #else
 #define SD1_CMD_HELP							\
 	"    - no SerDes 1 Ethernet modes on this SoC"
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 764eb640029..36d486d7301 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -23,6 +23,17 @@ bool lx2160a_serdes1_is_split(void);
  */
 int lx2160a_serdes1_split(void);
 
+/* Is SerDes 1 already 2x 40GE? */
+bool lx2160a_serdes1_is_40g(void);
+
+/*
+ * Convert SerDes 1's 2x 100GE into 2x 40GE, do not touch the RCW.
+ *
+ * Refuses unless SD1 is in the 2x 100GE state, and must be called
+ * before the CPU's MC starts.
+ */
+int lx2160a_serdes1_to_40g(void);
+
 void lx2160a_serdes_apply_hwconfig(void);
 
 #endif /* __LX2160A_SERDES_SPLIT_H */
-- 
2.43.0

