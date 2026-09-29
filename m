Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD172CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77E8E40402;
	Tue, 29 Sep 2026 19:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qw9YnExNd80F; Tue, 29 Sep 2026 19:37:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C3E3740322
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710641;
	b=Vftg0vmRDwxVzGGdDfRPNQ0uUk0eDvE6bZ+BiW4pTyPO6HkQvMwpNGBOEdxppuRgrJgg
	 HGsQDEniJkVetYN7ClLJHK02yGlkYT+RfSUTHw5+lBFmu1Ewevg6XaHRMZ1YOwGIBK2IJ
	 dd9v4xlRzxMqbumGFVJR1y80w8pp7nf2hqxxkoAfvOB6JkMPd1aqZi3wnSn27PYTuAwEG
	 wGl8zVeM5FUAxJIyXgQFgeT0wdcq/g7jTy6eV+lpp7Jg5tAdT4zJeg4VTifaofT5dz0Z/
	 nQQRWJ3sGWT52L36uzNm19A2yhIUjsK3A466gwry3YjLfXI7n0GD66UWd9L3jcy7P1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dztvNfxaNy091n7yczET1BZ1X6nLUTpO4B22VE61F5A=;
	b=qRnslKPkUZ3dAPaF24/ewtSvPFw5VKN+u8A07K1aP8XE+KrgLt1mF8lQCuTGAXV/tQAT
	 dJ6926zqwDnHIryHTstA49BqK/N3vApeUGrh3iiEIrxhgfmgJFzNv+FUjC/YF9jhXqgAg
	 RMU6MO1473syrZ4jvKKOguhlCmPstSYWkcYSLrv6hOJZMMzfnOs/LJM54pbkvHZ7QlO6o
	 oU3/y/7sg2HtH7TOMmL5wlnzw0gGUvI/WvTCiV2Zb2rN2P+M23LHYtKPyqI1JcMdxldqz
	 qlnqkOmu9Hkrj7UZUqa5WG0LfxfLiqT1XCOSJE+wlwcMRjc3jB8EcD53cGMI94k/8Pw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710641;
	bh=dztvNfxaNy091n7yczET1BZ1X6nLUTpO4B22VE61F5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nM+LdGOIE9ozXLfcL9+AzoqsJbsNGa05t1/d4yIUJvw4sov6mm2SLShN6dpBKBsZv
	 TBE/0fBXiiz9YEvvm+9sWXoJBvnzLTAD3/qVeJrFJ7g8GNEtp4MZ33wATUeEFSHyZ4
	 hR3kLhrCbze0oX1cGLaGyod7Gwb7+OiTgfLwFcU4KZIuBz9ILjMOwTd3lSRC/xUuWq
	 ZVycsBEr91ua30sZFPySBxqbza25Gk8C0FpCYWEjUQbEn7T5xkGedFwn3E0cLdVHC/
	 ffNdGvNvfu8DIXzM3s7yMAz5b4/dYuohEU/533l8yqpIgzGyTfK5welUd0kMhiV3T+
	 saX7WmThZuVCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3E3740322;
	Tue, 29 Sep 2026 19:37:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EFC432A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54A52808A0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2aMnK5TYWIl for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A552580880
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710639;
 b=Xh3lG/tBrgKfqF8ImSPhT3H4qj49rGyy/gQLe+doNqf7d7fZ/nZvDCb/KO/WTFKcZ3DQ
 ml92zH8GvvFZ6qrJ7JCQaNpP7ZGIJog9zWXT5AmZ8djlXoea5Oc34nnno4iHnwOI0Eady
 nsW3PB1SIp942/7eMzPeqlq7kj79kfk2U6cBia7dXLRbJq432AE/++oHibu3avHeCQ6ht
 SzO3mabrvrsogwP0XqUYgtu2nashfu1ixQ5pxk2QiuqeSkrjrvaZ7Jz4DpS/Ek7xZ9ToZ
 kUAzPWLaIW5gS/51XjWxxwg0Ut9PiSU2Ml7dOyiicpZiJ+UBS3KjjAsUsJO3gmyYTDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710639;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=dztvNfxaNy091n7yczET1BZ1X6nLUTpO4B22VE61F5A=;
 b=mfCvOq1HA6DelRWrhQiLMePB9JA0IaA7qzYDqcFIgDTi16YDFYnEEzNZUYjTKXbs5Z09
 kI2HXHgxTrn0EBrZIlaaVM31W1SaZZL1fPVWaEfG8zDCl+HsNZwpVFL0e1f22bzV7f69e
 PooDf6rnsTVxHo+9fyrAbg9r+O/qa0W+mZLlU81X+2g7Es4nsGcUK2SwxImsrZPqt2/wA
 r/3CM8dYrw1H+k9vjxALkJ+y8zKJLGTbO03pnC5bHc4DI7xzmOTXeoyV4h8f1wlX8Tc1Q
 WxE5kVcDNKchlM8Tg96/Y1tyY5esEpcr5HMOb5/NG4SkDtZwYDTYqbWT8Z6AVUwMVaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=kUnxlBrz; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=kUnxlBrz
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A552580880
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 02355B00539;
 Tue, 29 Sep 2026 21:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710637;
 bh=1pkxII+OfiX4qfx+9JFNQX6khtOWOFDXXV6qsMLcaEc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kUnxlBrzExVTgkUyt/yrcimws8+hzsXA6vEycxO1yZ3D5Av00LVAk4S2VyeApXkLX
 PNcBsbzQbmbmmxBQXa2PT9fb+Czr1Y1ChrBd2A1HQiOLWG5RVqU3ZdsrMyfzQg3Ws6
 HNgpDIYGIqkoLx3AaBvY4bJT/jXVsSmN2fxfPjhqh6hDCXdM2gG5EktXqnGTTETG9h
 UMass/HYKxa07k8+e/CXAFfGtHADzi00Slqx0fEa9Wls06P7iR17VpAFLD0nbq/dNK
 RpRaNedPvROnOjTRdMae4qmTuRp6XZYuCC7A5Q+l5780rY2vZXXeGQWCdhQmmvg0WC
 /dCch54iPo2Rg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 09/13] board: lx2160a: serdes: enter a SD1 mode through the
 mode it starts from
Date: Tue, 29 Sep 2026 19:59:41 +0200
Message-ID: <20260929175947.1379710-10-vjardin@free.fr>
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

So far a mode is entered only when SD1 already is in the mode it
starts from.

The next mode, 40g4x10g, splits the second 40GE port into 4x XFI:
it starts from 2x40g.

Protocol 20 boots in 2x40g, but protocol 13 boots in 2x100g, which has
to be made 2x40g first.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v5:
- New patch, split out of "set SD1 with a table"

 board/nxp/lx2160a/serdes_split.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 859cbffb5c0..5c234d4d4bd 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -604,7 +604,8 @@ static void sd1_print_pcc(unsigned long base)
 	       in_le32((void __iomem *)SRDS_PCCE(base)));
 }
 
-static int sd1_enter(const struct sd1_mode *mode)
+static int sd1_enter(const struct sd1_mode *mode,
+		     const struct sd1_mode *target, int depth)
 {
 	unsigned long base = srds_base(FSL_SRDS_1);
 	const struct sd1_mode *from = NULL;
@@ -613,17 +614,23 @@ static int sd1_enter(const struct sd1_mode *mode)
 	if (mode->is_active(base))
 		return 0;
 
-	if (mode->from)
-		from = sd1_mode_find(mode->from, strlen(mode->from));
-
-	if (!mode->enter || !from || !from->is_active(base)) {
+	if (!mode->enter) {
 		printf("lx2160a serdes: serdes1:%s needs SD1 to be %s, it is not (",
-		       mode->name, from ? from->desc : mode->desc);
+		       target->name, mode->desc);
 		sd1_print_pcc(base);
 		printf("), refusing\n");
 		return -EINVAL;
 	}
 
+	if (mode->from)
+		from = sd1_mode_find(mode->from, strlen(mode->from));
+	if (!from || depth >= ARRAY_SIZE(sd1_modes))
+		return -EINVAL;
+
+	ret = sd1_enter(from, target, depth + 1);
+	if (ret)
+		return ret;
+
 	ret = mode->enter(base);
 	if (!mode->is_active(base)) {
 		printf("lx2160a serdes: SD1 is not %s (", mode->desc);
@@ -669,7 +676,7 @@ void lx2160a_serdes_apply_hwconfig(void)
 		return;
 	}
 
-	sd1_enter(mode);
+	sd1_enter(mode, mode, 0);
 }
 
 #endif /* CONFIG_ARCH_LX2160A */
-- 
2.43.0

