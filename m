Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE62CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80FE381259;
	Thu,  1 Oct 2026 20:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoddgNUap9dt; Thu,  1 Oct 2026 20:51:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C05918121D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887888;
	b=ML/6oFmNA9PI45EHoWPcI9Q7QG2oQ2mN/ve8i2yn17DgnzvIMP/g5MYXGTotO3b+qiMI
	 7E2kEyHWfhVwv8ro0LSpDai0XhzSB1XUlMmGDJ1vE3g32rJEqHFbJbhpob4HQ2RUY2HLw
	 zpCoPbxb04lPYVw+zrKjjo1b+ecJatCI/P9gaC/+M8dn3VeMpl+W6JRBiMNHsX7Tztbxi
	 8YKfwEAWx5ax9Y9oDB0Ah3TmEBuA6hHV7smIQot9qstDO5S72vF8W3ODHS5TcsRPD1B/k
	 YM+DWHu7/rVPpA5UtAfL4PIUvQVBX2vVIYEoNax4o9Bl2DUnKHlPIl3b2c6BPK5zDUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GeLLri7M5MXI+CfkrAfwh+Qe9GOS6iuRkkuvq6/YgQQ=;
	b=eU9scB/qEtqC3LGo1jyR2551iRSyUUP8X9YTdg2QthkFJjDsdVIITBiIR8szQpeasMr7
	 j6cxIwt1DCN2RpNuz+CW5CuXIuR5xFhXN2pU4srukNy1WzxEtJmfHhKOi/mQ/y2+N31wh
	 v+Vja/SDbsJD5b8Kkq4q5BsF/PMCo0CkiF5kVkmK6qhldnjy8TXSyCAeC6FKxm0wolfbP
	 3CbF5SIJXBGw8AAxgSmVID1VUzNGfElbam5r7drpdxSBzIzllhvsrJhpKyheboWRdgavA
	 Cc1MfLHr9VJLetv5GxXkOJ2CoUrgDAHIXn15D3Mnk+IM1rZXKkTOUXmBmiugKil6YPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887888;
	bh=GeLLri7M5MXI+CfkrAfwh+Qe9GOS6iuRkkuvq6/YgQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHtWnAjltr9QOx/0J00WRgHF9peBEe3168hV8kq8CRItMH6CWyvNiIT/jb5+dkml7
	 XQSbfAYS0PHPVT91U0qFaobvcroN9SRURGvaRyJG/kBNUewii6LwQR7XMmRQsq2vXT
	 vPR2xN7Wy4hjhc3WbhdYSydJxwAFKEDxzoGLZeKW1ptVQmAvaDmG/DT5L56D7zNKyy
	 Gr72WVT+Ir1Aa2iLEZalakdsjg7fOxTmNy2h6bXB8RPy9PJHjwmeIjQXbVrC3QVkkm
	 LKmr+u6TdIkgsYo28YE6UNs32X6Md7Qq8lDQVPQiahOIxLFIVTgKJm03t99OJRFm/d
	 DknHm1DOmapZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C05918121D;
	Thu,  1 Oct 2026 20:51:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ABAEA282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D7D240062
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJOoP8WGvnct for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:51:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D69AB40022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887886;
 b=mb2NwleNEkiL8WYbPgSheXpbOFuB6UhQjZcK0rARKMrOdmCyfH5LsnVgkHNvPkyk7mOT
 0YxqpSG6SsZUF43Zx+Vi/lXJCamNN3txWoEkD3/jjp57B3fMQvjZLE7omUgZgJo88WwLc
 kicrTmmM6d5Qk1y0tpRT2k+xCBI5Vl3L2B8R9MaH1vDRpSkniiZz9pNMFculYtwKulrgl
 2iGx0347txw6uksgHKQSw9p4UER4foLTWF/2lGlVBgCalF8ILtB1J4WGARRpt2uxiV7rk
 7MWEr7aUGOhHWDXNfgXNbWeyyz9nrnSuMq1uKvdf0WATLOb9zRqWvFOKlBNWqEqqrxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887886;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=GeLLri7M5MXI+CfkrAfwh+Qe9GOS6iuRkkuvq6/YgQQ=;
 b=UT+VnJG/DQ1PzAhmN6LtL0/Eo8UjJ3qBjwlIGq8esKnzuG2sHWL2XauSeHHpqs9Yo8Pd
 wA2GIS+vja3WxwtmYxS/bXBhyETGo6rwvNc+goMLO+kEnSCoBu0V5YvccdEU8ym10kLY8
 RzznaovqYmj8fRg5K86YQ73EtbrSFcyCNooVpbXxbn0QABJQofX5YRoURGLFktm8qm30f
 jQLIIrM8Ucmtk85PKXUwH4LwGMQWoPHj+KdvkakfQ+CQgHwmEJeHHiOJCMVYdYyxfcGne
 dZ6MLfvyTBtqY/OziP4RMGz34R0QrlP4nSkO648CKGDLTRP10DZNUB6353l74mgwB/Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=V0sRiPQL; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=V0sRiPQL
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D69AB40022
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 5AFB6B0054C;
 Thu,  1 Oct 2026 22:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887884;
 bh=Vv+1BlaBvXxekD3+k/ckT5Re3dJ/4SbX9xouTHK6ros=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V0sRiPQL4YLdibOb/1aQ48Zg9MkKciqQlDy1AbMifOtPGg6a0OWRGdnvJ/QxynQlm
 QGzSPYnyDkzITipJovaUihC4102txn068leo206WxXuUM0q0lXKKN+cJ4plocA3JWZ
 8Wp/LFwN52kI5ZfqtGA3OxxWcwokMrgbdoDCiIruSVdsWbQwPc4FdyNkiKjgeTyphI
 EQexB6rDAdP0M8ATBTH+c2afKlO13zMTQrKGDakRA/JmPkbAR8hOlTyvQO9Ev+Cxh9
 qMp9VL4x/RZpKlsm8Fh4ALuJbNm3R5j6jbG2jEZ9NuKrpzAfP8DhtxFEKma+mPJuKT
 gaJTNdQ2fS+1A==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 10/13] board: lx2160a: serdes: add serdes1:40g4x10g
Date: Thu,  1 Oct 2026 22:47:27 +0200
Message-ID: <20261001204731.1774613-11-vjardin@free.fr>
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

Add a SD1 mode that keeps dpmac.2 as 40GE on LNA-LND and that changes
the LNE-LNH 40GE port 4xXFI ports, dpmac.3-6.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

(no changes since v5)

Changes in v5:
- sd1_reset_req()

Changes in v4:
- was on v3 3/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 41208ca79ab..479e4789eaf 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -380,11 +380,13 @@ static int sd1_halt_port(unsigned long base, unsigned long lanes)
 	return 0;
 }
 
-static void sd1_reset_req(unsigned long base, unsigned long lanes)
+static void sd1_reset_req(unsigned long base, unsigned long lanes, int skip)
 {
 	int m;
 
 	for_each_set_bit(m, &lanes, SRDS_LANES) {
+		if (m == skip)
+			continue;
 		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
 			 RSTCTL_RST_REQ);
 		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
@@ -441,7 +443,7 @@ static int sd1_enter_100g4x25g(unsigned long base)
 	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
 
 	/* Reset. Every lane is its own master now, so all four count. */
-	sd1_reset_req(base, lanes);
+	sd1_reset_req(base, lanes, -1);
 	err = sd1_reset_wait(base, lanes);
 
 	return err ? err : ret;
@@ -572,6 +574,62 @@ static int sd1_enter_2x40g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 1x40GE + 4x10G: dpmac.2 stays 40GE on LNA-LND, LNE-LNH become
+ * 4xXFI ports, dpmac.3-6.
+ * An XFI lane is a 40GE lane that is its own port master:
+ * same PROTO_SEL and width, same PLLS and rate.
+ *
+ *   XFI   LNmGCR0 = 0x00000052   LNmTGCR0 = 0x10000000
+ *   40GE  LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000  (but its master)
+ *                        ^ PORT_LN0_B
+ */
+#define XFI_GCR0		0x00000052	/* as 40GE, but own port master */
+#define X10G_PCCE		0x01000000	/* E40Gb kept (lanes 0-3) */
+#define XFI_PCCC		0x88889999	/* XFI converters for lanes 4-7 */
+
+static bool sd1_is_40g4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E40GB_CFG(pcce) != 0 && PCCE_E40GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+static int sd1_reset_both(unsigned long base, int keep)
+{
+	sd1_reset_req(base, SD1_LNE_LNH, -1);
+	sd1_reset_req(base, SD1_LNA_LND, keep);
+	sd1_reset_req(base, BIT(keep), -1);
+
+	return sd1_reset_wait(base, SD1_LNA_LND | SD1_LNE_LNH);
+}
+
+static int sd1_enter_40g4x10g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, keep, ret, err;
+
+	keep = sd1_port_master(base, SD1_LNA_LND);
+	if (keep < 0)
+		return -EINVAL;
+
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
+
+	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
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
@@ -592,6 +650,13 @@ static const struct sd1_mode sd1_modes[] = {
 		.is_active = sd1_is_2x40g,
 		.enter = sd1_enter_2x40g,
 	},
+	{
+		.name = "40g4x10g",
+		.desc = "1x 40GE + 4x 10G",
+		.from = "2x40g",
+		.is_active = sd1_is_40g4x10g,
+		.enter = sd1_enter_40g4x10g,
+	},
 };
 
 static const struct sd1_mode *sd1_mode_find(const char *name, size_t len)
-- 
2.43.0

