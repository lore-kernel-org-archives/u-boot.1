Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C25CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C940E408D3;
	Thu,  8 Oct 2026 22:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Via5-wvJv0r; Thu,  8 Oct 2026 22:43:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11FDE408C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499395;
	b=IwYOOS/GuheYqitPBYxT5qPel0BeD+zIOExGW3HaXe/JKNur2JZ+qbLkvj+z8yJY6lNL
	 eRXeSBSDISoSCS5P53TarzqPMwT8iE7Jo8i1Zr2GpvDd61XmLDDvlB2OOaTkDusnQJPAD
	 1jmPuLK32F+usR+vRbm9hnN+fDJkLLvIl8dPMagw4D/71ZIUbU/uldAxFuw4ZjwR4p6W8
	 t0zi0q1fGvF+eJF9duRYprDM5KyYlc7Qh0+1C7XDIrk0S3yqQOKmBhLxCYXbKpB6FOopO
	 9d2Q7fP3rTdnp7xwZk2WBvaL/4FCx1dmRtlQz0d85B2/4Gf0sX34T+ketownPPV5x6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
	b=JcCISNdsZxtnLx23diWPrEHwRzBh+oBEfL1s7qZANvF/XbRe48ZU+OyB0kP31dIkT+uc
	 SC8745Jrkg1i3usYa0cA2fwPaD8idQS1lP3wWdo3QW0Db60mtw47KNLzDVThN9j3b8gDP
	 Q3kXoqJXjtvJn5JrzNVWXJRj8x3YJfTmNv7loZpcszqyFzt5xYhK2z14gdlbdvwUwMGAs
	 2qFMzLuoif+XSqyG5ILmxfvP0f+z5xJ4k/s4t0gAraq4c9coPCSad5BK5nYXGKS4AXGdf
	 xPJG3mk6eNef4lpxopPM1YMt5U2d1LkP0GVyVY7I57LTjEiaKIgdztPFCAPTie/yfag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499395;
	bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FRrLaaenn1LOipAhqz+vDD/Sy8DTlG9RSUZEZf66nAvhNV0Hjs2CeLroLnG3btFt0
	 FrABpLVnNe2ph4G3CPjfigNbOVDc7JA22qrED6lX8dfRnZD+4lx0wmXLcxzIvDuBW3
	 qbMjlS5Hls6PIdOoIkemxKrUJDwmAh+rOflYqiUMr5/xHwAd86qXg/V/enZo1ONcPW
	 hj7aDInpBfXKHlK1ZNCy6B+r7ygcsKG/PHkNwq/+PwS8geKmMQQICO8/jWO/KQL0zZ
	 VH9+laF+6zDexkbrMH2W6BFAAWuJ9wZCNlgX0MsgKH0hoxRWng/cR6rAh5nMoO9ra4
	 lZyjGyH1bTwDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11FDE408C4;
	Thu,  8 Oct 2026 22:43:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F351F1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D991181235
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RYYEdSazK0G for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27558811F6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499393;
 b=VN9AoZIZ08ungWcT0X5wVvKcjq8l4eo6PRkGZJfGMu+E574IyV8I7Zc+4B1WUP5l6YLo
 8UyYhJUmHsTmD6SSAzbBRwX/GjQuzu26eh1EuXuxyrorCAymORHnvipKeHnnVAsCZgyxr
 mPkcIGmN6kFsseBz6JFc4FM4cv5Z6fZ9rMgXjnypUFxE73fKhoSDCAEVD2QmPdKhKOjeE
 20ULCFU1CTu8vFqSaDb8efoj91Xq/aIu0n5D0kDIIt/nhECmqrPuxU1W+hKq9taoPLS0P
 kipwRkd3Zxe7vW3MEs2Urd0TdWUOEfHQZZAF1L3t7aDbBJp1Li0aksnJOx05G3tHPKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499393;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
 b=FwHYKejBKnR8/7/Smc1UBNOImlih2z0kCO+ZXTNIvU+992AT2VHCAlmWug4rrpRf/nNp
 XsLukb/vSuGz73Cph4yNCNHm6JCzkNA3SIkYr/4yc84K24MRyV6rB8vRsSDuU60jZ0ea5
 qSp4BVINcYxry8kNEMCjTS9fK7WHmS3aA/hEYvsiDj1v5BxeF4HRZSkfphwCjUCoY34wL
 6sAnLDJbmoOqWc+5sdO1c3SsTxyhEmFqn0idw4ShadlIuVL/Fl3RSncI5GswypxteVFcO
 vIo80sUC5/Ms751Q1bVQvqCU0Y2konF4pM+jFkzECKSlXkEEfLCxgHNpVZiMvahHB5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="pkseA/pb"; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=pkseA/pb
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27558811F6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D8FEBB0051B;
 Fri,  9 Oct 2026 00:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499391;
 bh=2G2Pd5HL5z4JlHmX/LFx2fA1Z+5ulNgTDAS1axvM/qM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pkseA/pbWgv3C7tdJIadkF36QJUPqeUOUg3kr1oLLkiOg60O0d1miGHRWg3o7ovSP
 a0OVM06CxowxciRhSX/PdBWasOQANKdpOzJ7P1X+dYVE5oavMswCbLHYxNz1o6ho97
 L7fvxKwhUm4V+GWvDc0sOYwvZVDJSp/IaVNlvZt9mpQqwfGbqfiQQ7kFM45SZ73H0D
 lVWu/WMdY35ASBpkPiJ8XJu+abWYrgJ3tunXoegSTYQStTalNxoyGeYsPVHvCEJeEM
 MVtr0XXarUqy9ex2uyK44C+x1xgFNuU1YIF4WURigMWxSlWl02zvqkz8zG0s4yyAB/
 r1n4tjTpsr30A==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 01/13] board: lx2160a: serdes: drop the split subcommand
Date: Fri,  9 Oct 2026 00:42:14 +0200
Message-ID: <20261008224228.512353-2-vjardin@free.fr>
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

lx2160_serdes split command configure SD1 lanes from the U-Boot prompt.

But the MC firmware has very likely normally been started already.

The split must be before the MC starts. That is the purpose of
  hwconfig=serdes1:split

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v4)

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index ca3d7228977..6d9743a28dc 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -449,23 +449,6 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	if (!strcmp(argv[1], "split")) {
-#if !defined(CONFIG_ARCH_LX2160A)
-		printf("no 100GE on SerDes 1 to split on this SoC\n");
-		return CMD_RET_FAILURE;
-#else
-		if (argc != 2)
-			return CMD_RET_USAGE;
-		if (lx2160a_serdes1_is_split()) {
-			printf("SD1 is already split, nothing to do\n");
-			return CMD_RET_SUCCESS;
-		}
-		if (lx2160a_serdes1_split())
-			return CMD_RET_FAILURE;
-		return CMD_RET_SUCCESS;
-#endif
-	}
-
 	if (strcmp(argv[1], "status"))
 		return CMD_RET_USAGE;
 
@@ -487,16 +470,6 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
 	return do_serdes_status(sd);
 }
 
-#if defined(CONFIG_ARCH_LX2160A)
-#define SPLIT_CMD_HELP							\
-	"lx2160_serdes split\n"						\
-	"    - split Lynx 28G SD1 100GE.1 (lanes LNE-LNH) into 4x 25G.\n"	\
-	"      Runs before the MC starts. To make it permanent on a board\n"	\
-	"      that needs it: setenv hwconfig serdes1:split && saveenv"
-#else
-#define SPLIT_CMD_HELP ""
-#endif
-
 U_BOOT_CMD(
 	lx2160_serdes, 3, 0, do_lx2160_serdes,
 	"inspect the LX2160A 28G-Lynx SerDes protocol configuration",
@@ -505,5 +478,4 @@ U_BOOT_CMD(
 	"      per-lane port grouping and protocol (LNmGCR0), next to the\n"
 	"      protocol number the RCW latched.\n"
 	"      No argument prints all three SerDes."
-	SPLIT_CMD_HELP
 );
-- 
2.43.0

