Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716D1CA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 368F581204;
	Thu,  1 Oct 2026 20:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhArfoGZhhES; Thu,  1 Oct 2026 20:49:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2F49C811F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887782;
	b=Lvs4Y3/SzeAL1yDyp1IX1loVEEgSe9mt31p0L0m7js1F7iG8y7/Pu3jjHFYhL03frVHb
	 3gb/6Kb7LOBu1v3O51l02yw04V7mvdnys9Jl87D6+jytHDWGDUtRRZ9f+vsfii+uQ3Ic7
	 1PZYcW1LB9mJ42L47bw4zqyE1xCigIURpNHvrRUt6rFoD5Ch+n/xWg37f8K8EOPUsCqhi
	 LQCy+6ClKvcNTNtRje4iT5hFDirqPkKyk2rPmR0kOcZGIdAJzJhQmUNlYBT3kfjXEUi03
	 kuLM82kYU5PKU54d72dYUjqjmCHE8Sgrn3aBcfv0+IB6D2Adpl4MFkS5Uqo0H0i1ZOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/xFKNmolcCSEvO1n+w7Rw3hCGu244b+ObxUb7OFmV+8=;
	b=fRzZgkzALeMpwxTIVvEkfV76mMYBSDIo9K4MQRo9qcMMPbVIV0zDOTUtdGx9hTMwMTtW
	 ASbrw2NekZ9+LI7asvHGut4MFAL98gFfetd/2XEVNYbCuz7eRpzRH/pTQc+kGJyWRuUy5
	 VtjXRl719/W+3TA/ftasQV09dgBNqDjAv3nOny9DgwyFsHRzg3U5qGYRQGqTsTmnmXouY
	 m7e2o8lhRuzHggq5v+6n1/UKLAK3JohngLYK7MRv8cdJ8X7m+KplO3NspnU4fbp2YOGJ7
	 IXz6RsPNQkyKlWjOrXa+o9NtxwQqWhH8bWJnU0Md53PnMcjT/nbC0HaVbrYFp2l43pQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oKXGX1FW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887782;
	bh=/xFKNmolcCSEvO1n+w7Rw3hCGu244b+ObxUb7OFmV+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EC3cAFgcdTvihMaHLv84CARm4OfNmkp1260oEwPHBhJrR1w4PPCEkBJ1m9KhaWCvN
	 Qk/B8b3lauj+cbMuzcyi2aSKa+Lila3Em+Ga/V4GRKId2R7GAfGR51KihD7DrFbUjx
	 42xTJxFeZptcuD4mjFaPXCNt60IB1vliL4TqWeai55/+Dqlnu7QXkx4iH9yxb5JVy3
	 q0ohq7vZyzycq+zwBZ6aaBO1nAWhoAgPcUjZMOGe+lPvaVPfrClWzLW/btsMUtYXZv
	 wBkBymTakj7akI6Ny8LtOWqdRo56mWYJeD9otExJRy+fLmuK/cUuvopkXumKhgThEN
	 Vfz/PD1eYBhtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F49C811F7;
	Thu,  1 Oct 2026 20:49:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7EEE33B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DAFE811F7
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8Yw2Emf5duA for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:49:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8AE7B81198
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887779;
 b=PUiwWoJoQ+c6lYfY6xIHm2zspTd+NGU6bKxXrZiUE1p9KbMM5jdWRt00o5SR4orUkn8u
 x454ovEbBYwhG8XVJPiu3JVG5epVbaVY77sSsXc51Jxx6yWeqeKwIoPyOc58C/DznMgJ0
 1SarVQrh2evN6H3MshJNLJOxNOAfyO595yI/UjuQX6XHlp8y1ytOE467aU83EuS1DsYfN
 u83e3J4kR6UnLVkg0H9aCyYMmyGI66qi6XEhbZhp2PMKE7Zh7OxoSCooJNSrPC+NKvweL
 H3A2aXrX9afMiCyLsxkyHO3Y+H3RbfkMG+vV7wcs5P4LZGqcsT4B0kbRHDVKrQDPNfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887779;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/xFKNmolcCSEvO1n+w7Rw3hCGu244b+ObxUb7OFmV+8=;
 b=Lvu9RYbaNdp0a2Km4/h1a4tzGvmm8qThAJY8KzroDPTVHhKZTVONYJbQCfJw0j6jmC5S
 oKRuha/TaAdq0rCIJpZEYOipgofx8ElYJc4WTSMx6ckZYnKeoYdXx9jLhzxfqrQuxQznq
 laj4kw1aifn9KG3l80l1uiwyHVCznH41zPxOzOlkjzZYN2CzDZk0wvHeUL8syi1ZAhPlv
 DHK/3Mhr+sDW7EMgC6gJvHmm8KSeRs3dW+oaPtMby74W0dOA3BKiuGlNla2u286AiSvbl
 ZuNrJhOKN2fCI7KiO7QFaf1/RyhhG9DWjHgMFPIuqD4DIJK1PkTL9VSqrM+jcw8jhZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=oKXGX1FW; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=oKXGX1FW
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AE7B81198
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:49:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 37D0BB0054E;
 Thu,  1 Oct 2026 22:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887777;
 bh=j6K+qeKT4/ip0bC8OlcZAUozid772pxjYIdjDXl2Az4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oKXGX1FWaJQSlcjQwkbrLmQ0ov1YR3JJR1kdW77yU7vIjT8E83vEuJO9Iub2CrYfC
 WP93AskbdinUDjNCAyrow9gL2XCBcyGhQ90UguqEdhTBS9beufv/bhTKdEQEo5OYJA
 Mhy9tPWf/th3cxF+SzHiTFbzIoA8P4+59uplLoEH1f1DTLitsS/yAUHMzZSOkg/y1I
 klZK6wkBIGjzhYWpMe3G+ellKbUuqe7APhpOu9PEwU4BxKUKP2V53fRYMX+/70qrMD
 bbo+QMHkQd/evYFYSvv5xm0LDGukZqTmzLRp7NUkP1RRn8ZHBmg+FdabLlzNfHF/Pr
 hvowPALuZ0i6A==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 05/13] board: lx2160a: serdes: set SD1 with a table
Date: Thu,  1 Oct 2026 22:47:22 +0200
Message-ID: <20261001204731.1774613-6-vjardin@free.fr>
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

