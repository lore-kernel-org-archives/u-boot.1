Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3702ACA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1F0B6088B;
	Thu,  8 Oct 2026 22:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiJXNhpqO4Yz; Thu,  8 Oct 2026 22:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1FFB6084F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499481;
	b=gn/G01MDfRdeoRSElglniimiBc/yD6ziGFNI1IwDPHk9YD3Rb2LiVzIFgmoWdI6KAFMa
	 cX7eWiCaLimAaGLAzm9R6PEuj4EJ9gXCVRNHaqhs+gl9M0LM0DbzR8OL2kMwoPTtiosMH
	 KSkC0E4qPW2Qy0QbORjPhZDS+JL5t6OkB/jpFpUKRQxQRmb63O+SSPh/Uu0ysO3UnUtdm
	 BGxvXvEXEW8RRv9DK/m4Za89CJu5uMOyvPdcQwNQAelS60FWEiMhlfYF7XM4eqtWH86W4
	 TSmXGf00yqtNgGuPJ0d6VvsMS6OrMMepOCJjmqBUQsGp0RMuyno37ycqyPRsTOberxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/xFKNmolcCSEvO1n+w7Rw3hCGu244b+ObxUb7OFmV+8=;
	b=EqdGVKaTShJvC307D6tkAnqtr8SFH8MY4Cg9fNeVUu8xQzj1qBwoHcmDg4JtaB46vJYd
	 JHdG+sxO8PkfEV8mvX3ruVGz6HqGoh4mj5Rfcr+M9Ftq73FsDPF3Cg5fvXoD79ukEj2Uw
	 BvRjtwiEfM4NNuPBmAs5yXpX43T3TJ5OriYnlWf2Kj1T9Xn3XZoMb5UBLOzqTEE77v4D5
	 GCabazdbE2aIzF/X9xVwRpu12spiWVTWTOqn9T2TPI/EIa5MderLo4FZDQHSxQ2n0HS+v
	 HqgiLtsn1XAw+yF70iko4VTzRaL9yFKhWCu8bFzvkVg0mY2V0NEfimek2ngCY+Bnr3A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499480;
	bh=/xFKNmolcCSEvO1n+w7Rw3hCGu244b+ObxUb7OFmV+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMsGfNc4xhmf81uAx4ijQNRPs2reTvYxHaJpub2brtRa3BFnWfjR5rYgGMvOqOr/T
	 XStjeEn7NToe+lqKGFe3S+KLcCQ+xsN8emH2s7zIwPQPQpMhvoqur3MVtTo8e2Gmb6
	 tONM/FtLOX6Y6YrH52ebg9GsWtPvN4mZH9jVakMpqswCpz7AuifRDcciPPJPgJtWxb
	 tGag7H5raHU4+97L0IAfpj3jM2C2eiAf8UO4IEDYqGsXSa2WGuJ/34A09IqYVhvrjQ
	 T4sbGyRvlon+Y+hIgQaHpIaPjtyYctkL8kDp/jooaTWbKA4/jJvhGPaVwSr3BVInkD
	 nHXg4PEo4SRkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1FFB6084F;
	Thu,  8 Oct 2026 22:44:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9573156
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB1F240098
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3ml7mZeqmOr for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:44:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 946EC4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499479;
 b=rdRtpbysqBskvQP06ixF0cPkgGnVI98x1x/TnmjHbaphus9y4GYT4XFoXd3kzln8nhwi
 cTo7Tal80Iu5t9v+LkOk5m+YuwqXhthafJATz12iHK0w3QwX/tpFlf6pq8BqYG736T+yl
 I+bkPaqzLrPlwa4Q5I+b2TVMdGCl3Kr5VtmP1P8UhGEfa2DZa3JdGikn5Qo2eRHkSpOsL
 rSHehFPDYNi7YbzCPQfrW0hs/Fl4Y4D8/WQGeNmYCkeOUzKYBa3uybnpLBjgDgSRWwIVD
 xzwb3ZITQCo6fMKtfYgamSfmQvHrI2yt5jrxt05QEqnwQkdQUg372y5bNVdAfvBda6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499479;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/xFKNmolcCSEvO1n+w7Rw3hCGu244b+ObxUb7OFmV+8=;
 b=Ft2Q5Gcd9y9kfeov/mXPt87Pz/G4VsOIRQyv9oAp5E2Heu7L346Co73v/dseWH5HjqNe
 DZBiA+cdElBvKs0oFQJkrR9z07UeSJ1FVvtd1NVTk+kTQU+4YiOJsaGMCHxUTe9xYheAL
 pbZek0CoXGRkAW0LDiu4XfHseHht6jxgD8rFeFZib4dejpg6euQ8J8CNN1SXr0PQFgVwc
 GP28NatFE4LZE0qgvgom6og4H27zH7qayPRaKaQB8EQvJUsdD5ytf2GkUXRqH/cfJfFSu
 S378dd0d4lY38nInaZ0sGhpnkw60R12TtVxAdRnYtX2ncVKzKAYvFdWm6rpVSV3KAkQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=tOEaBIpR; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=tOEaBIpR
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 946EC4006F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id ABE6CB00539;
 Fri,  9 Oct 2026 00:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499476;
 bh=j6K+qeKT4/ip0bC8OlcZAUozid772pxjYIdjDXl2Az4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tOEaBIpRzF+jY5egaoNJZCsYmc4Z9bkdoCiJB6z8jC3uArdE+2aZkqOyGArhINzAg
 UWfWyJGHpMr27FNSB6Pr/H2xcr7wCK3BM3noHsv4JbkVl0mKIefQm8ZudhUdpVuxn0
 HikFGGGeyqS5arFV7KJodccYCh0zQ3sJget+FX080yyDBkFfypaeC13JijW34hY2TG
 EulCdcTWNH6I+cKVzKS9ycmMDzDt74PUbmMWMuGGL/e8nbC308vxqXfRkvvxDTpQKW
 e5WwW1k7WPmnBhIOBPC/7bsCrRprp4zwpR/hQb13/jSXHfLN+8toqrhxGiPGD42OBV
 2itG3eAbMgCDg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 05/13] board: lx2160a: serdes: set SD1 with a table
Date: Fri,  9 Oct 2026 00:42:18 +0200
Message-ID: <20261008224228.512353-6-vjardin@free.fr>
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

The SD1 lanes can be set in more cases than the 1x100GE + 4x25G
split. Describe each case as a mode, an entry of a table:
  - its hwconfig name
  - how to tell SD1 is in it
  - the mode it is entered from
  - the sequence that enters it

The two existing states become the first two modes, under their
serdes1 names:
  - the "split" state, 1x100GE + 4x25G, is 100g4x25g
  - the "unsplit" state, 2x100GE, is 2x100g

A mode is entered only when SD1 is in the mode it starts from, as
the split required the unsplit state. The serdes1 value is a single
mode name, read with hwconfig_arg().

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v5)

Changes in v5:
- SPLIT_POLL_US and the halt and reset helpers are separate patches
- Keep the order of the state checks, tell old state is which mode
- sd1_mode_find(): use a name and its length from the start
- The serdes1 value is one mode name, read with hwconfig_arg()
- No skip logic yet, entering a mode through another one is another
  topic

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 127 ++++++++++++++++++++++---------
 board/nxp/lx2160a/serdes_split.h |  16 +---
 2 files changed, 92 insertions(+), 51 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 5dcdeff5898..1cc9c7e5509 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -246,8 +246,16 @@ static void print_rcw_view(int sd)
 
 #if defined(CONFIG_ARCH_LX2160A)
 
+struct sd1_mode {
+	const char *name;			/* hwconfig serdes1:<name> */
+	const char *desc;
+	const char *from;
+	bool (*is_active)(unsigned long base);
+	int (*enter)(unsigned long base);
+};
+
 /*
- * The split itself.
+ * 1x100GE + 4x25G
  *
  * This is NXP's e100g1_split.rcw sequence, moved from the PBI into
  * U-Boot.
@@ -266,7 +274,7 @@ static void print_rcw_view(int sd)
 
 #define SRDS_POLL_US		10000		/* NXP waits ~100 cycles   */
 
-static bool srds1_split_state(unsigned long base)
+static bool sd1_is_100g4x25g(unsigned long base)
 {
 	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
 	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
@@ -276,12 +284,7 @@ static bool srds1_split_state(unsigned long base)
 	       PCCD_E25G_CFG(pccd, 2) && PCCD_E25G_CFG(pccd, 3);
 }
 
-bool lx2160a_serdes1_is_split(void)
-{
-	return srds1_split_state(srds_base(FSL_SRDS_1));
-}
-
-static bool srds1_is_unsplit(unsigned long base)
+static bool sd1_is_2x100g(unsigned long base)
 {
 	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
 	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
@@ -399,24 +402,11 @@ static int sd1_reset_wait(unsigned long base, unsigned long lanes)
 	return ret;
 }
 
-int lx2160a_serdes1_split(void)
+static int sd1_enter_100g4x25g(unsigned long base)
 {
-	unsigned long base = srds_base(FSL_SRDS_1);
 	unsigned long lanes = SD1_LNE_LNH;
 	int m, ret, err;
 
-	if (srds1_split_state(base)) {
-		debug("lx2160a serdes: SD1 already split, nothing to do\n");
-		return 0;
-	}
-
-	if (!srds1_is_unsplit(base)) {
-		printf("lx2160a serdes: SD1 is in neither the split nor the unsplit state (PCCD=%08x PCCE=%08x), refusing\n",
-		       in_le32((void __iomem *)SRDS_PCCD(base)),
-		       in_le32((void __iomem *)SRDS_PCCE(base)));
-		return -EINVAL;
-	}
-
 	/* Lanes E-H are one 100G port at this point. */
 	ret = sd1_halt_port(base, lanes);
 	if (ret == -EINVAL)
@@ -436,36 +426,99 @@ int lx2160a_serdes1_split(void)
 	/* Reset. Every lane is its own master now, so all four count. */
 	sd1_reset_req(base, lanes);
 	err = sd1_reset_wait(base, lanes);
-	if (err)
-		ret = err;
-
-	if (!srds1_split_state(base)) {
-		printf("lx2160a serdes: split did not take (PCCD=%08x PCCE=%08x)\n",
-		       in_le32((void __iomem *)SRDS_PCCD(base)),
-		       in_le32((void __iomem *)SRDS_PCCE(base)));
-		return -EIO;
+
+	return err ? err : ret;
+}
+
+static const struct sd1_mode sd1_modes[] = {
+	{
+		.name = "2x100g",
+		.desc = "2x 100GE",
+		.is_active = sd1_is_2x100g,
+	},
+	{
+		.name = "100g4x25g",
+		.desc = "1x 100GE + 4x 25G",
+		.from = "2x100g",
+		.is_active = sd1_is_100g4x25g,
+		.enter = sd1_enter_100g4x25g,
+	},
+};
+
+static const struct sd1_mode *sd1_mode_find(const char *name, size_t len)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++)
+		if (strlen(sd1_modes[i].name) == len &&
+		    !strncmp(sd1_modes[i].name, name, len))
+			return &sd1_modes[i];
+
+	return NULL;
+}
+
+static void sd1_print_pcc(unsigned long base)
+{
+	printf("PCCC=%08x PCCD=%08x PCCE=%08x",
+	       in_le32((void __iomem *)SRDS_PCCC(base)),
+	       in_le32((void __iomem *)SRDS_PCCD(base)),
+	       in_le32((void __iomem *)SRDS_PCCE(base)));
+}
+
+static int sd1_enter(const struct sd1_mode *mode)
+{
+	unsigned long base = srds_base(FSL_SRDS_1);
+	const struct sd1_mode *from = NULL;
+	int ret;
+
+	if (mode->is_active(base))
+		return 0;
+
+	if (mode->from)
+		from = sd1_mode_find(mode->from, strlen(mode->from));
+
+	if (!mode->enter || !from || !from->is_active(base)) {
+		printf("lx2160a serdes: serdes1:%s needs SD1 to be %s, it is not (",
+		       mode->name, from ? from->desc : mode->desc);
+		sd1_print_pcc(base);
+		printf("), refusing\n");
+		return -EINVAL;
+	}
+
+	ret = mode->enter(base);
+	if (!mode->is_active(base)) {
+		printf("lx2160a serdes: SD1 is not %s (", mode->desc);
+		sd1_print_pcc(base);
+		printf("), stopping\n");
+		return ret ? ret : -EIO;
 	}
 
-	printf("lx2160a serdes: SD1 100GE.1 split into 4x 25G%s\n",
+	printf("lx2160a serdes: SD1 now %s%s\n", mode->desc,
 	       ret ? " (with warnings above)" : "");
 
-	return ret;
+	return 0;
 }
 
 /*
- *   setenv hwconfig serdes1:100g4x25g
+ *   setenv hwconfig serdes1:<mode>
  *
- * Idempotent: a board whose PBI already split SD1 skip it too.
+ * Idempotent: a board whose PBI already configured SD1 skips it.
  */
 void lx2160a_serdes_apply_hwconfig(void)
 {
-	if (!hwconfig_sub("serdes1", "100g4x25g"))
+	const struct sd1_mode *mode;
+	const char *arg;
+	size_t len;
+
+	arg = hwconfig_arg("serdes1", &len);
+	if (!arg)
 		return;
 
-	if (lx2160a_serdes1_is_split())
+	mode = sd1_mode_find(arg, len);
+	if (!mode || mode->is_active(srds_base(FSL_SRDS_1)))
 		return;
 
-	lx2160a_serdes1_split();
+	sd1_enter(mode);
 }
 
 #endif /* CONFIG_ARCH_LX2160A */
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 8dce9ddf97a..5a820c8c5d8 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -7,25 +7,13 @@
 #define __LX2160A_SERDES_SPLIT_H
 
 /*
- * The split is LX2160A only: LX2162A's SerDes 1 is four lanes with no
+ * SD1 modes are for LX2160A only: LX2162A's SD 1 is four lanes with no
  * 100GE in its protocol table.
  */
 #if defined(CONFIG_ARCH_LX2160A)
 
-/* Is SerDes 1 already 1x 100G + 4x 25G? */
-bool lx2160a_serdes1_is_split(void);
-
-/*
- * Split SerDes 1's 100GE.1 (lanes LNE-LNH) into 4x 25G.
- *
- * Refuses unless SD1 is in the unsplit state, and must be called before
- * the Management Complex starts: MC latches the live protocol-converter
- * configuration when it boots.
- */
-int lx2160a_serdes1_split(void);
-
 /*
- * Apply `hwconfig=serdes1:100g4x25g` if the board's environment asks for it.
+ * Apply `hwconfig=serdes1:<mode>` if the board's environment asks for it.
  * Boards call this from reset_phy(), before mc_env_boot().
  */
 void lx2160a_serdes_apply_hwconfig(void);
-- 
2.43.0

