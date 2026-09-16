Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBE9C982C1
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 21:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C81B64072F;
	Wed, 16 Sep 2026 21:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGvuHVU8gVuD; Wed, 16 Sep 2026 21:16:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9854A40723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789593389;
	b=H4GQwLhMzmsMT7xTJD3zJ9t5bVFuZEtnZ0wjgRBjnsLSSp8E9wBy6hZcnXu2SxAdJjGh
	 5LhuertBHWJhBYkkkWija7GK2JaFAQ64B4sAJfn07SAKlJFtl8I8v1gC0fLrTCKXnk/a/
	 JAYXhb9c2ExTmt7iLZm5boKMwucipOZHiPhPeohVwkGNeBWD3UXGOlx7PWZmEZCxCPqEJ
	 5iSFoqB6kwDMdE3k5nTBDMCvuKht+bC9o9+AV2fuCQMjhUpH5GNFr1OgEt4MYni5tk3Kf
	 fR3TA6lXsKh58NfGdzO1wczJYNyJoWNMG6OAdprj6rUWysu8F7GOJvpFnzKDICCISnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789593389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+AF807rWNIPolxcPNKh8oTGYgUvYw2jGDNjaDq4ECJU=;
	b=HXK3DuyhEJOwl1pfX5LrQbusjFi+eAHDbAc2bnUYeI3kscHBqxcUTgxGPhIvq2mR2u9y
	 Bs4CsSFG4NSxQpuP0K7Jxnx/RjMau5PC5qnv9xImZ1ulkD8K7VZXaYnwoXYR31DConVPm
	 SAK5zBPbT3DV5VGDoTmdrdTvqrf7fSkkS9InDNmDOccFhoLKWAC4KMPvqCVByyFSYoW3d
	 zVG6vkD08w2t2Bfte3pJaKbAqm1yu3Lk6H6MiS/6sPAlu9RReNV83xKrKQw4mAypsmgRL
	 MxXSRxorrGrGujbi/x4lRYDYMiYqwvpEzcJ+deg/C7svC14D6KXkxp7K2wCI2ZFIMFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789593389;
	bh=+AF807rWNIPolxcPNKh8oTGYgUvYw2jGDNjaDq4ECJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aGHk5znKEgHGkFfGEYUm3Da9twCEWpW5b7kwMdADqh3WqhmGBDgBq97HG95EaZTgB
	 2qK5IdbwCAoh9bceo2TJceAprnkA4rm3SC3GGJSWs10ciqcRm/UI5JXmTR91GCmJ0o
	 Xr4ovc1c1xZc9+t0ef0p3u87nF5qjjSN64dQHwtKx8mNBIR/xw1wg2BObmxDpGXcCP
	 trMiB1OBg+nbOm7llkCslwM9BIN4sWUvoM/hQ0YKMRs8eUC2qR88LtRrTDCVI6sptI
	 4ckrM9wgvzLbaIdRD+OqfRPw4VxkR2xkfhz27FV0RdwBg+rq3o5zmXtCYrrm0/I3Ln
	 COy184SVjCTqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9854A40723;
	Wed, 16 Sep 2026 21:16:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB8012E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C993D6062D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GoCVU_eEk0W1 for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 21:16:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AE4D16061D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789593387;
 b=UhC384H4a3jhbz6ccCiXJwbJAJb7KK3n4FBVA2yKtbh2hC7u+GtX6vCnYmj4TqKKlSf0
 zNQtSm0QhR5hvWpW+p+qTMPRIHACPv8S97dsyZsDSEKEOXLVusnwgESM03vSfVOhyL9d/
 sZ1ittK7LAXDZ7zGmX14qxuwmWgEOwB17ayJAa5Ha0VPQB71XG6Z+3LPKJGL0uc23ctWu
 qPTP5M7ztRyNavjfKQEOzFfKC4puvI889Qeos/Kjh6v8xrm7VggonC8YfQ1VihyFCyy/+
 QtHsARfixokeaobbsOxxc8k7d8eXJhrteZSKO3lhD2Xltq2E8uYgapMrLXCwzM3+wbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789593387;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+AF807rWNIPolxcPNKh8oTGYgUvYw2jGDNjaDq4ECJU=;
 b=VVcYNMgynkeB+U5jYoHpfYxm75SAwfG83eMdPZVWEDcdXqYR1M9wHTQLkGhC2pPXpue8
 W7kEBZk6XQY0s8iGze2T9kFjP8G9NWutweS3QFL4+83e3oEpsocMHLo5q+giERMVk3U9j
 9+SWTqkZExWTAo+v3OBbY/Gu7zsslXDXJXKRIXlaCnYcjmGQMnWpAIJMW6kELZf4cvwjE
 zk4ygC0nF99FNdYvUEMe9S64hGEQGLupxoTekNqo/gyhyQ7kKZ6EqUsfpg7uYb5mVFGRd
 8SITc2h5dOnl0Wx1BKkyOXnTXSJaD0FXmey3V83hC4cJLusljy1Dvv3OVVX3U1GWelQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=DOQzItMm; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=DOQzItMm
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE4D16061D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2E42CB0053D;
 Wed, 16 Sep 2026 23:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789593385;
 bh=H6CJ4xrzYZlNfj7epG3uJDLcDIfBxQCFPGZpvqTJ/Vc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DOQzItMm2NeZt11WcEsxNf5Sl1HcDgD8PYzkFDw0rnGWmVHbBqZFVkjpjXnNa/vx4
 NJ6JBVOEzM0v7fNUdjnokoDAXRhBSqlgYfamx6C6phYhRZtjaRIoBFWyMVsi10Md6Q
 D4eE4/Q/oIgeju47nZQv1fd3X7VuiWlmQPID2UvoK5s3lUF9uu2JmOFh1KPkQy3LRs
 ebbxWH7TFNq/HVJV64NM+toyc6CTqWQG2l8dqDUWosIiftnPPEbFQ0VPNcf8oSIpTz
 siPbwpisvhgJ40qmJgjdZilKYCEIrAEz+nS6pqtnWMfdRjwMzw1VEW2M1j6xERiH2y
 KDtx6KOIvOHVw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 1/5] board: lx2160a: lx2160_serdes to lx2160_sd1 and
 lx2160_serdes
Date: Wed, 16 Sep 2026 23:15:45 +0200
Message-ID: <20260916211549.3432913-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916211549.3432913-1-vjardin@free.fr>
References: <20260916211549.3432913-1-vjardin@free.fr>
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

Fix the commit
  035d68fc36b5 ("lx2160: add lx2160_serdes split and management")
which is in next.

It leads to the following commands which are more explicit:

  lx2160_sd1 100g4x25g
        CHANGES the SerDes 1 Ethernet mode: it re-groups SD1's
        eight lanes and re-points its protocol converters.

  lx2160_serdes status [1|2|3]
        only READS, any of the three SerDes, unchanged syntax.

In order to prepare the next commits, this mode should be:
  100g4x25g (1x 100G + 4x 25G),
instead of "split", same for its hwconfig key:

  setenv hwconfig serdes1:100g4x25g && saveenv

The follow-up patches will add more SerDes 1 modes under the lx2160_sd1.

The SerDes 3 and LX2160A-only branches use IS_ENABLED() instead of
preprocessor conditionals, and the header no longer wraps its
declarations in CONFIG_ARCH_LX2160A: the definitions stay guarded in
serdes_split.c.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v3:
- Incremental on top of next, where v1 is merged as 035d68fc36b5:
  v2 mistakenly re-sent the whole file as its patch 1 (reported by
  Vladimir Oltean). Patch 1 is now only the delta: the lx2160_sd1 /
  lx2160_serdes command split and the 100g4x25g naming.
- Patches 2-5 unchanged, rebased onto next

Changes in v2:
- The mode-changing command is lx2160_sd1, lx2160_serdes only reads
  (v1 had both behind one lx2160_serdes command)
- New patches 2-4: the runtime SD1 conversions for many cases of
  split (2x 100GE -> 2x 40GE, second 40GE port -> 4x 10G,
  1x 100GE + 4x 10G)
- New patch 5: hwconfig and README.soc documentation
- Mode names say what they produce: 100g4x25g (v1: split), 2x40g
  (was 40g), 40g4x10g (was 4x10g); 100g4x10g unchanged; same for the
  hwconfig serdes1: keys
- Rebased onto main

 board/nxp/lx2160a/eth_lx2160aqds.c |   2 +-
 board/nxp/lx2160a/serdes_split.c   | 119 ++++++++++++++++-------------
 board/nxp/lx2160a/serdes_split.h   |  11 +--
 3 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/board/nxp/lx2160a/eth_lx2160aqds.c b/board/nxp/lx2160a/eth_lx2160aqds.c
index c1a060877cd..b13606354e0 100644
--- a/board/nxp/lx2160a/eth_lx2160aqds.c
+++ b/board/nxp/lx2160a/eth_lx2160aqds.c
@@ -18,7 +18,7 @@ void reset_phy(void)
 {
 	/*
 	 * Before the MC boots: it latches the live protocol-converter
-	 * configuration when it starts, so `hwconfig=serdes1:split` has to
+	 * configuration when it starts, so `hwconfig=serdes1:100g4x25g` has to
 	 * be applied here and not later.
 	 */
 	lx2160a_serdes_apply_hwconfig();
diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index ca3d7228977..04339a71350 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -2,7 +2,7 @@
 /*
  * Copyright 2026 Free Mobile - Vincent Jardin
  *
- * LX2160A 28G-Lynx SerDes inspection (`lx2160_serdes`).
+ * LX2160A 28G-Lynx SerDes customization.
  */
 
 #include <command.h>
@@ -19,11 +19,8 @@
 
 #include "serdes_split.h"
 
-#if defined(CONFIG_SYS_NXP_SRDS_3)
-#define SRDS_COUNT		3
-#else
-#define SRDS_COUNT		2	/* LX2162A has no SerDes 3 */
-#endif
+/* LX2162A has no SerDes 3 */
+#define SRDS_COUNT		(IS_ENABLED(CONFIG_SYS_NXP_SRDS_3) ? 3 : 2)
 #define SRDS_LANES		8
 #define SRDS_BLOCK_STRIDE	0x10000
 #define SRDS_LANE_STRIDE	0x100
@@ -102,8 +99,9 @@ static void print_rstctl(const char *what, u32 v)
  * must be 0 only on the port's master lane, and 0 on every single-lane
  * port. So a run of lanes where exactly one has PORT_LN0_B=0 is one
  * multi-lane port, and a run where all of them are 0 is that many
- * one-lane ports. That is precisely what the 100G -> 4x 25G split
- * changes, and it is invisible in RCWSR.
+ * one-lane ports.
+ * That is precisely what the 100G -> 4x 25G split changes, and it is
+ * invisible in RCWSR.
  */
 static void print_lane(unsigned long base, int m)
 {
@@ -126,15 +124,14 @@ static void print_lane(unsigned long base, int m)
 
 /*
  * Summarise the port grouping, which is the one line that says whether a
- * split happened. With PORT_RST_LEFT=0 the port's master is
- * its right-most lane (towards LNH), with PORT_RST_LEFT=1 it is the
- * left-most: PORT_LN0_B=0 marks that master, and is also 0 on every
- * single-lane port. So a group is a run of PORT_LN0_B=1 lanes terminated
- * (or led) by a PORT_LN0_B=0 lane.
+ * split happened.
+ * With PORT_RST_LEFT=0 the port's master is its right-most lane (towards LNH)
+ * With PORT_RST_LEFT=1 it is the left-most: PORT_LN0_B=0 marks that master
+ * and is also 0 on every single-lane port. So a group is a run of PORT_LN0_B=1
+ * lanes terminated (or led) by a PORT_LN0_B=0 lane.
  *
- * Checked on board with the PBI split applied:
- *   [LNA-LND] [LNE] [LNF] [LNG] [LNH]   -- 1x 100G + 4x 25G
- * and without it lanes E-H would read as a second [LNE-LNH] group.
+ * Examples:
+ *   [LNA-LND] [LNE] [LNF] [LNG] [LNH]  1x 100G + 4x 25G
  */
 static void print_grouping(unsigned long base)
 {
@@ -152,7 +149,7 @@ static void print_grouping(unsigned long base)
 		int s, e;
 
 		if (gcr0[m] & GCR0_PORT_LN0_B)
-			continue;               /* a follower, not a master */
+			continue; /* a follower, not a master */
 
 		s = m;
 		e = m;
@@ -225,13 +222,13 @@ static void print_rcw_view(int sd)
 		mask  = FSL_CHASSIS3_SRDS2_PRTCL_MASK;
 		shift = FSL_CHASSIS3_SRDS2_PRTCL_SHIFT;
 		break;
-#if defined(CONFIG_SYS_NXP_SRDS_3)
 	case NXP_SRDS_3:
+		if (!IS_ENABLED(CONFIG_SYS_NXP_SRDS_3))
+			return;
 		regsr = FSL_CHASSIS3_SRDS3_REGSR;
 		mask  = FSL_CHASSIS3_SRDS3_PRTCL_MASK;
 		shift = FSL_CHASSIS3_SRDS3_PRTCL_SHIFT;
 		break;
-#endif
 	default:
 		return;
 	}
@@ -248,8 +245,7 @@ static void print_rcw_view(int sd)
 /*
  * The split itself.
  *
- * This is NXP's e100g1_split.rcw sequence, moved from the PBI into
- * U-Boot.
+ * This is NXP's e100g1_split.rcw sequence, adapted from the PBI into U-Boot
  */
 #define SPLIT_FIRST_LANE	4	/* LNE */
 #define SPLIT_LAST_LANE		7	/* LNH */
@@ -272,8 +268,10 @@ static bool srds1_split_state(unsigned long base)
 	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
 
 	return PCCE_E100GA_CFG(pcce) == 0 &&
-	       PCCD_E25G_CFG(pccd, 0) && PCCD_E25G_CFG(pccd, 1) &&
-	       PCCD_E25G_CFG(pccd, 2) && PCCD_E25G_CFG(pccd, 3);
+	       PCCD_E25G_CFG(pccd, 0) &&
+	       PCCD_E25G_CFG(pccd, 1) &&
+	       PCCD_E25G_CFG(pccd, 2) &&
+	       PCCD_E25G_CFG(pccd, 3);
 }
 
 bool lx2160a_serdes1_is_split(void)
@@ -286,15 +284,17 @@ static bool srds1_is_unsplit(unsigned long base)
 	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
 	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
 
-	return PCCE_E100GA_CFG(pcce) != 0 && PCCE_E100GB_CFG(pcce) != 0 &&
-	       PCCD_E25G_CFG(pccd, 0) == 0 && PCCD_E25G_CFG(pccd, 1) == 0 &&
-	       PCCD_E25G_CFG(pccd, 2) == 0 && PCCD_E25G_CFG(pccd, 3) == 0;
+	return PCCE_E100GA_CFG(pcce) != 0 &&
+	       PCCE_E100GB_CFG(pcce) != 0 &&
+	       PCCD_E25G_CFG(pccd, 0) == 0 &&
+	       PCCD_E25G_CFG(pccd, 1) == 0 &&
+	       PCCD_E25G_CFG(pccd, 2) == 0 &&
+	       PCCD_E25G_CFG(pccd, 3) == 0;
 }
 
 /*
- * Wait for a self-clearing request bit. Per the doc, hardware
- * clears HLT_REQ when the halt completes and RST_REQ when the reset
- * completes.
+ * Wait for a self-clearing request bit. The CPU clears HLT_REQ
+ * when the halt completes and RST_REQ when the reset completes.
  */
 static int poll_clear(unsigned long reg, u32 bit)
 {
@@ -328,11 +328,11 @@ int lx2160a_serdes1_split(void)
 
 	/*
 	 * Halt. "Halt only has meaning on the master source
-	 * clock lane of a port (LNmGCR0[PORT_LN0_B]=0)". Lanes E-H are one
-	 * 100G port at this point, so exactly one of them is the master and
-	 * the other three requests are ignored. Issue all four anyway
-	 * (that is what NXP's sequence does) but only wait on the lane
-	 * where the bit can actually clear.
+	 * clock lane of a port (LNmGCR0[PORT_LN0_B]=0)".
+	 * Lanes E-H are one 100G port at this point, so exactly one of
+	 * them is the master and the other three requests are ignored.
+	 * Issue all four anyway but only wait on the lane where the bit
+	 * can actually clear.
 	 */
 	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
 		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
@@ -409,13 +409,13 @@ int lx2160a_serdes1_split(void)
 }
 
 /*
- *   setenv hwconfig serdes1:split
+ *   setenv hwconfig serdes1:100g4x25g
  *
  * Idempotent: a board whose PBI already split SD1 skip it too.
  */
 void lx2160a_serdes_apply_hwconfig(void)
 {
-	if (!hwconfig_sub("serdes1", "split"))
+	if (!hwconfig_sub("serdes1", "100g4x25g"))
 		return;
 
 	if (lx2160a_serdes1_is_split())
@@ -441,19 +441,17 @@ static int do_serdes_status(int sd)
 	return CMD_RET_SUCCESS;
 }
 
-static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
-			    int argc, char *const argv[])
+static int do_lx2160_sd1(struct cmd_tbl *cmdtp, int flag,
+			 int argc, char *const argv[])
 {
-	int sd;
-
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	if (!strcmp(argv[1], "split")) {
-#if !defined(CONFIG_ARCH_LX2160A)
-		printf("no 100GE on SerDes 1 to split on this SoC\n");
-		return CMD_RET_FAILURE;
-#else
+	if (!strcmp(argv[1], "100g4x25g")) {
+		if (!IS_ENABLED(CONFIG_ARCH_LX2160A)) {
+			printf("no 100GE on SerDes 1 to split on this SoC\n");
+			return CMD_RET_FAILURE;
+		}
 		if (argc != 2)
 			return CMD_RET_USAGE;
 		if (lx2160a_serdes1_is_split()) {
@@ -463,9 +461,20 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
 		if (lx2160a_serdes1_split())
 			return CMD_RET_FAILURE;
 		return CMD_RET_SUCCESS;
-#endif
 	}
 
+	return CMD_RET_USAGE;
+}
+
+/* reads SD1, SD2 or SD3 */
+static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
+			    int argc, char *const argv[])
+{
+	int sd;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
 	if (strcmp(argv[1], "status"))
 		return CMD_RET_USAGE;
 
@@ -488,15 +497,22 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
 }
 
 #if defined(CONFIG_ARCH_LX2160A)
-#define SPLIT_CMD_HELP							\
-	"lx2160_serdes split\n"						\
+#define SD1_CMD_HELP							\
+	"100g4x25g\n"							\
 	"    - split Lynx 28G SD1 100GE.1 (lanes LNE-LNH) into 4x 25G.\n"	\
 	"      Runs before the MC starts. To make it permanent on a board\n"	\
-	"      that needs it: setenv hwconfig serdes1:split && saveenv"
+	"      that needs it: setenv hwconfig serdes1:100g4x25g && saveenv"
 #else
-#define SPLIT_CMD_HELP ""
+#define SD1_CMD_HELP							\
+	"    - no SerDes 1 Ethernet modes on this SoC"
 #endif
 
+U_BOOT_CMD(
+	lx2160_sd1, 3, 0, do_lx2160_sd1,
+	"select the LX2160A SerDes 1 Ethernet mode",
+	SD1_CMD_HELP
+);
+
 U_BOOT_CMD(
 	lx2160_serdes, 3, 0, do_lx2160_serdes,
 	"inspect the LX2160A 28G-Lynx SerDes protocol configuration",
@@ -504,6 +520,5 @@ U_BOOT_CMD(
 	"    - print the live protocol converters (PCCC/PCCD/PCCE) and the\n"
 	"      per-lane port grouping and protocol (LNmGCR0), next to the\n"
 	"      protocol number the RCW latched.\n"
-	"      No argument prints all three SerDes."
-	SPLIT_CMD_HELP
+	"      No argument prints all CPU SerDes blocks."
 );
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 67e8c4873a7..764eb640029 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -7,10 +7,9 @@
 #define __LX2160A_SERDES_SPLIT_H
 
 /*
- * The split is LX2160A only: LX2162A's SerDes 1 is four lanes with no
- * 100GE in its protocol table.
+ * The SerDes 1 modes are LX2160A only: LX2162A's SerDes 1 is four lanes
+ * without 100GE in its protocol table.
  */
-#if defined(CONFIG_ARCH_LX2160A)
 
 /* Is SerDes 1 already 1x 100G + 4x 25G? */
 bool lx2160a_serdes1_is_split(void);
@@ -24,12 +23,6 @@ bool lx2160a_serdes1_is_split(void);
  */
 int lx2160a_serdes1_split(void);
 
-/*
- * Apply `hwconfig=serdes1:split` if the board's environment asks for it.
- * Boards call this from reset_phy(), before mc_env_boot().
- */
 void lx2160a_serdes_apply_hwconfig(void);
 
-#endif /* CONFIG_ARCH_LX2160A */
-
 #endif /* __LX2160A_SERDES_SPLIT_H */
-- 
2.43.0

