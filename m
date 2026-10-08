Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA95CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C360C6069F;
	Thu,  8 Oct 2026 22:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCLjDE9DNL73; Thu,  8 Oct 2026 22:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D4A960872
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499607;
	b=d29bqmsa7iLyQSp2ULCycCohUSpvlA3srSUHBo3pAvCRZU5wONNfqGl12h8tSd2/oTl3
	 RT/499sd/sY+CXHm7AIYdPiifSAj0TgtjCx3/2CN768ufZmbhxEw6/FR9PYTaG+ViJvRZ
	 Z8ZaGoP2ukqiVSI7aOJkZUsl4nyQeKMN18iOitNQ3FZNjv+EAwa2uEtTj6gyGEhFol2fR
	 mBJXkxk2QGz7YWwCJ07hzMLS3gEUXGv8sbWNLBbUby3kFvLKAV610dIMxUEMGwPFLt+TS
	 YH1jKNOXwAn/s2Y3RUGiVT66j5HCXRwgVhxTmFCm2c2gB7oRPFUf/L8txYwoWqA8/5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R2BiLrUxTUJ4t8egAr1hn+IPlP3rMJFRZIjxVEX7Mck=;
	b=P4b2iFl+GKW/EhxZfpSCSNXXYkmZ9D5QneTk3PIjB05izC/QO7FO0XYhTAwmG9zdvXY1
	 r3P9+eKRLdS0QUMZS9LzLB2TkzDZGrpFks4cCjzkzNZ5b+MDeL6S1u17G2PxXKYotKoxg
	 RUfxiZYeqLQPL0KfOCRHV9wqLKOwoe+k12yFlqzJCDZayr4K2QBEX6+urJJwJC5Ac9VXW
	 8vvz3rrrqF1aOb7nzO4AGaxfxlEYRq/AqQ81wIaNYkGxAxyCA8QOudQgHO0YmA1VBK/4s
	 cjyqW7I5skMxdEku3w5FCg0PtLcef+KFynDJCd7S743EWPyf9VOa9bONqgdmZTTETzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=bFnAe4+i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499607;
	bh=R2BiLrUxTUJ4t8egAr1hn+IPlP3rMJFRZIjxVEX7Mck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KV+QDQxsVD2cwQQdrmgD3o7m59RTHMQXRdutKFPCYgVPZBAd8hrsYT/TK3ae8bfPh
	 W/201S1l6hmAgMYeYv6Ba2hhRx9hVkRTO29BoAiyQa3O45MdwkyRWwYsLv2ugvs8Ds
	 wID0r8TGqu9o6y9PSA+1QhUBw/w8VKzwvnv/P3Stwv+mkQoKacYJnCGh6xpPOZOl0x
	 djKcexuPXiDFVwxXR+F9yF1Gnz4+8AtztyoQnaUoHrCTcERGlLUF0fkvlbkGsGt/sV
	 PIO8BupayyNShz9dmoBD2UnhJZF4mlnBvP+OMxA6rEVPWp13TpSTWv0yYOLHuySg1K
	 H+FEZ5/Y89zXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D4A960872;
	Thu,  8 Oct 2026 22:46:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B00981A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9602B60872
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lWWS6E3O2QKG for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB8556069F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499605;
 b=M7K0mBf5CjGfPQnzmMuthUZnUpew2CnzdDLjsyFKek4IsyPNK1gUMixwmz6bTQKqzfa1
 6TmdbXrZqNq++r8USDGPQzdzzB+yo/CJq9OdzdKHohCNQ6MJyBnZV2+yvesuyqbxkoqVP
 cj7hyvTyQcWGlM8XRXz4QX3C8rQ2y8Bu+vuvcRFJunLdPf/lOHsXNYdWJMDyu74Ugxb6p
 s1BFiqNhkIq/J1dYYqgfKrL7grN/Sy/1dB+mB6E/8wEc7GZJ8GJyS8a689rFCmuVlUFlJ
 QiQ09EKeoe5HU2c3XhZHrdRgSuOmX4JjP3fkfhqdwc10q1ohforC6vkntGo/P/ivhRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499605;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=R2BiLrUxTUJ4t8egAr1hn+IPlP3rMJFRZIjxVEX7Mck=;
 b=frOTmb1FLnkbywiLugX1TW3HWFj/QSSSmkO2OQaNUDL+SrKbwuNdQ41vEdPru/dK8TPn
 t1LphG9WbVh1IimT2+tU7nMeRq4JvvR4w9krUwivvcKi0enlMW9YcQxMVd2qOg7nw5tn3
 3g1lxiGUdhshZB3ORdpL7KPoomPdTIPYpRPZdq9dZjyxjfkAayi0iHujg0wWIT9Jf6Mtn
 4z5mQLIKGKx+BNSZZ/KbSikIkR9pbviKEO2wlLTkehfWo2xU6WdCyksggJK47BFrNyyqM
 0MXTgfNxM3wZxejwOFzoLbV3FdPsKlbAEA51/wYlt/xMhGQX96WhiptbanodBHvPV2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=bFnAe4+i; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=bFnAe4+i
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB8556069F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 55AA0B00539;
 Fri,  9 Oct 2026 00:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499603;
 bh=+KsIIBcD8PqQ4M32e6HhUEVTcIjuL42GQgWJkHFVkiM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bFnAe4+iuUyzK1RGmYR4UZ7gcMrCGEeMqgn2F0PVqmi7lOhcUnTQNmsFDm3Raytj/
 hYVJBkxeHkhyWAhd9vas5Z9DlkSkdzlvQVOi5+XmRwW+e9qbiSNkIeELZGKdMqDx8k
 2IDj1/RpCPW000T/ZjWcCahvTLzaCmFQGOg43gEu3o44ClW+Rwgw+98OVguM7ugCLn
 zJoULeG/jZ8qX9RPmERfwfgUbncQryrfEIGYp3b7xKPK6dVf6h1KyF46TZsA+ExOYB
 nQHrAKxGUw5UrtWHLyvdDf2uql2eIIoT0mWGKULI9UEZ2fA+yKZUdbC8OtTMFsZSEW
 0JuN2+yrOsSAg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 11/13] board: lx2160a: serdes: add serdes1:100g4x10g
Date: Fri,  9 Oct 2026 00:42:24 +0200
Message-ID: <20261008224228.512353-12-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008224228.512353-1-vjardin@free.fr>
References: <20261008224228.512353-1-vjardin@free.fr>
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

Changes in v7:
- Reset only LNE-LNH, as 40g4x10g does now
- Reviewed-by dropped, since the reset changed

Changes in v4:
- Was on v3 with 4/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 316d500292a..d6daf4aa638 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -616,6 +616,53 @@ static int sd1_enter_40g4x10g(unsigned long base)
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
+	int m, ret, err;
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
+	/* As in 40g4x10g, only the lanes that moved are reset. */
+	sd1_reset_req(base, lanes);
+	err = sd1_reset_wait(base, lanes);
+
+	return err ? err : ret;
+}
+
 static const struct sd1_mode sd1_modes[] = {
 	{
 		.name = "2x100g",
@@ -643,6 +690,13 @@ static const struct sd1_mode sd1_modes[] = {
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

