Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F72CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD991607E0;
	Tue, 29 Sep 2026 19:38:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjSPl_-WQa0i; Tue, 29 Sep 2026 19:38:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1B363607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710685;
	b=E2cCkFLZmFM/pw7Omi9vrPd1uunaROgP+AKVLYf3vXYDYFD4qVEgONCzLh6fYXr/FYaz
	 RkxuZgRXuQlGWnxCN/RdvIrgf7Z1y7AGPmZMcu+TuVcsQnYFxyi6mGeqCXuK7qJPHnYhi
	 9CWYidBg6tqHUO5RgjCL2hxVIktV7G4SWk0C76UWhgCo13x/odt2zoUyBVlAAH68jGnUc
	 a9awpUstrE1hvdv16gitY8lwbvjJ9aZUzWaKsJJEKBqLAeTmSis8erZr6Pid5u3p6hYLL
	 BsebwmQOHtc1726XPAYcaUnI8DlUowgUAg6GbGfd8JdiovTsIC/Vbos+EX7Qm/APKUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1nHTOvHVGEJ9j/k9y+JS0u3x4oCxTAVYWGyjMge8LAA=;
	b=QPq+ZJVdpCPdPimAtnZjDbej+iHCA2l+mEmab2jnbxG4zluzuHOggdHy7bW6YWpiMR7n
	 TdPuOWe9VXIk/j03Cc72jqdCywZR7r0FVOf9P3EGg3j/FOIw6X+4WDEfkBKfjxVeJpTY8
	 1q4I4JsIusaCJGVaDaPSp3P/JWmH6Zq0C4BjDBbEN5i2mBjRzwoNdUqlh1hIGDJAbBIVa
	 FkGtr0ZW2ez/wS6oblL8MSCs8KPpdqwTG96UBrVDtx2KGG51lW5sEqtf4Nu/E7YUuXA88
	 m4Mu451gMxyvm5jzvbTDXWkRiP6o+RbE1OfuIi1tP58L8htqC3rzjhImSFNkrjqgY6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710685;
	bh=1nHTOvHVGEJ9j/k9y+JS0u3x4oCxTAVYWGyjMge8LAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=APVuCMB++w0OTRzLf5E1jYHK5SKkFvJPON0XRGwo/z+fLsdjkeQMEF5Ytqj+WneJQ
	 uf88+MLpPWvwVfMQnoqtaqwIHsuQYjw1xdyux59vRxicKPIuBEIMPSzReqe4zcvUkj
	 xTWzL8hz8pCJ3+rNpRuMwrT0uMt7D+/mw6mxqyBDxv0b8qU4zQ06IT+OTxqzHuZ+N/
	 n1Bs7YH+wEDt9gJWDKD5Cka4oOx0o7f/CAUi1L5GYcpsYMupYVvDiTx6yYxfoviBsz
	 ar0mgPdEDypNC1HiIkENw7IFq5kg2H+M5UVHHLLhWwDoNzO47beOpkHVy7EBfUGxrO
	 eAMh2hDEg8/zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B363607FF;
	Tue, 29 Sep 2026 19:38:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F83824E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2529E80BBD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kcQcyCIlKqx for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:38:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 703C5809E7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710682;
 b=QFoZsAp0Ly6NtSyp4gUEI69sgDqeCKJiCxAuMr2LrwrkRcguZD1GD/xfCbHOYYTIj3TH
 haKvEgLFGBQl68qBUqZS3oQsRlSFUbn8Ru62YFhBeyfEmgNArH0uifnEPvkVF/9g0ywm4
 OPXZ5+iAqLBWPCEaJnUEEtlV1jpOSEJYMNiTToMnVq94x4942SAN4QienxpuM8ZCwr9Z9
 Cqp2uzloqkGboU7cfLSZldpJauE7c5w3eP6qZ6Dxlfe9pmMnkOi/QxSQcPGBEyzBEQwJh
 +aeSH31FgZSpfrqlc0ztoYe33FPTR67+VaCtUgw8yLmGKXgBrtLOqy8QpqX1GX7w1Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710682;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=1nHTOvHVGEJ9j/k9y+JS0u3x4oCxTAVYWGyjMge8LAA=;
 b=Z7Hw0DVdcUWXUw4Ct+w2QBO9xuutm3lEtfsaqpJh71a45SIv7p9vFZFb9RT5eFbCQcza
 Gaut0dwQtY6zFrhpAQFwq9y9QWMu9h9mVDByUntlf878p3h1x/vMlprc4kZh4dMSNfonX
 SMlZBUO000dOI/OmGFoBHHkRLDxOZYofgNHfLU2CVvedjbsCnPqgnQu+OthsA1azVaVKD
 jIsZ16P8zrnDyPC/KkA1ETG9o1emLDl/ulfMBJ1cq4UbLOnJTxu9Mu2ZXyOpasOS88V77
 QhVQElcOnSWrdcDZB67Vbex0EriD/PlGsbT/2aGEKJN4BgZIHnwiwMm3bcoIWSYQMHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=fzw3qobv; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=fzw3qobv
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 703C5809E7
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id BB650B00563;
 Tue, 29 Sep 2026 21:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710680;
 bh=yzJYo1J4iRYdWzz5qmMQRx74WF+sQbjwV+NgfZT7MhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fzw3qobv6sB4uTxJe2t08LJ7ncPn6j3lxiT6m4Pf0YhYzZ+wdcM0vEs56KlSz3uWm
 GXyRZtgTVEG1Sl9c1eU9eZHD57dTtG1LxCgGc1LaYWhYlNK0YaxjK9xDirjKcFxOWX
 fnLICP80cH/2RKW2d/E3Y2iq3bR0YTZK4VxoLK5G8B6zYmSUFbaAOG8Wz0pQ6wEXB1
 ak3maVQq02eYtBjZ3OVRhjRgy9ad+wCJXl5rs82P62DfdvOTfl2RbQQ4CmWKnePzxU
 ESoRfOYWce3cCQDzlcKvhrIWOtjoCA61/IgMUhNaHj4fU0o4JuIkCSlqj6BmQBSi2+
 5LvxNFNC2q+Og==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 11/13] board: lx2160a: serdes: add serdes1:100g4x10g
Date: Tue, 29 Sep 2026 19:59:43 +0200
Message-ID: <20260929175947.1379710-12-vjardin@free.fr>
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

Add the SD1 mode that keeps dpmac.2 as 100GE on LNA-LND and makes
LNE-LNH four XFI ports, dpmac.3-6.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

(no changes since v4)

Changes in v4:
- Was on v3 with 4/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 9c3e5f9561f..5dd5114afb9 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -620,6 +620,55 @@ static int sd1_enter_40g4x10g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 1x100GE + 4x10G: dpmac.2 stays 100GE on LNA-LND at 25.78125 Gbaud on PLLF,
+ * and LNE-LNH become four XFI ports, dpmac.3-6, at 10.3125 Gbaud on PLLS.
+ *
+ * Note: it is the only mode that runs SD1 on both PLLs Slow and Fast !
+ */
+#define M100G_PCCE		SPLIT_PCCE	/* E100Gb kept (lanes 0-3) */
+
+static bool sd1_is_100g4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E100GB_CFG(pcce) != 0 && PCCE_E100GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+static int sd1_enter_100g4x10g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, keep, ret, err;
+
+	keep = sd1_port_master(base, SD1_LNA_LND);
+	if (keep < 0)
+		return -EINVAL;
+
+	ret = sd1_plls_up(base);
+	if (ret)
+		return ret;
+
+	/* Halt only the port that moves. */
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
+		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), SLOW_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), SLOW_LANE_GCR);
+	}
+
+	out_le32((void __iomem *)SRDS_PCCE(base), M100G_PCCE);
+	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
+
+	err = sd1_reset_both(base, keep);
+
+	return err ? err : ret;
+}
+
 static const struct sd1_mode sd1_modes[] = {
 	{
 		.name = "2x100g",
@@ -647,6 +696,13 @@ static const struct sd1_mode sd1_modes[] = {
 		.is_active = sd1_is_40g4x10g,
 		.enter = sd1_enter_40g4x10g,
 	},
+	{
+		.name = "100g4x10g",
+		.desc = "1x 100GE + 4x 10G",
+		.from = "2x100g",
+		.is_active = sd1_is_100g4x10g,
+		.enter = sd1_enter_100g4x10g,
+	},
 };
 
 static const struct sd1_mode *sd1_mode_find(const char *name, size_t len)
-- 
2.43.0

