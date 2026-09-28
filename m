Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF60C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11D0680C35;
	Mon, 28 Sep 2026 10:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lXYmDfLe3QV3; Mon, 28 Sep 2026 10:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4BF5780D7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590475;
	b=lHtiPYz/m6X1cqeAjVn5bjDwaf8BUkWkq1irSRf1u0XTIHXrBsNdH4aeam+T0Y0jBF/O
	 v/6Y+cyerX0s9fWuUeDuTpPrfJN9k1RuIDwyvrv7mtk49ws7m9AllpcBG30vbIjlp2Guo
	 8jGgTtksBPpO9amgLtFRhUNdtTHkU94s90FmqfsVwID66+lZ2J5agLwOZAJcz/amoHhwo
	 uoSoVUDqOrPB/AATfvbIv4VY/KJ0sLx5i+B3imDaxqr5Ubz8phqSE8ZY3gZO9EWOqG7H4
	 dkVaD/5qgkOzdQmO3ZkSj2X53JV2JRt5SEbIWi2oTOe9Gn7GvfS7t/7+6O9o6BKSWvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VDVBSjkDGN+y1dWn6NHcmbYbgBxaNp5zmb96QzpKt08=;
	b=mVIEYkFMg7qZcIBR7gkJ7CHmbvfuJ44uX6pYonzl0lscNuiU9VX0YwcsxD3QBiL01jk+
	 jVcpAVa1E1qBpxnqpQlSc9fAC2d5wOnsGPOvvw4e7N24I6c0pxJ0WzMAMkOwjBixtRT62
	 L6JFcypvAWqsnPWzYcpFHAFAnPgBxd3brUY1rGzaeOPXt/EvjTDA86/8zYWTetnMVDcUd
	 uSmVoFxI7bX/vXR3DuC4WGFcvn2tqfFPG78bJTY/sTsmQv/smx9mJj5P5hkWSVTPAPFlv
	 gwg0XLShZZpduhBsYCYrAa8E5qQIi7zw5T3TxuEuQBRr0zw4GGZFB4Rp1xaCzwI5H5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590475;
	bh=VDVBSjkDGN+y1dWn6NHcmbYbgBxaNp5zmb96QzpKt08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hfTCdY9/hF3NOAeFJWpaOhgJXrnhDHD36cmrgDktx9TMrylkYxqzJuFpcOppKVGrc
	 Xz7gOHh3NueYPm0ENpGk8/BTlXl6GHR5PdRLdExgeLaetfabcD9+pyul3xC57k1e1S
	 kdy6a1/Zj1jU4Zwc+NpXXaIsA2BZO7E7O+bN3zz1v5QgMjs/OvRsIC4xSkokePXsPG
	 OQ9GjFGbhwM/zw8xAdJfgq3egB3prhNBEaBoZ9+eeM5yCty+knWTgpNsNOA4COq9ev
	 DYJTj0yy7JkxsHfLNkD0pEmePYlbmUgFBD41azY0SYr/VDIA3A7nlrfeyX/UfEVFnX
	 6Pw4WAc8i9U0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BF5780D7A;
	Mon, 28 Sep 2026 10:14:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D15D3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EDFB4019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nN-GmtbJQO7i for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3EA78401AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590473;
 b=TQKovgsgNhHgJv0l4vd3+JIevCdql661Zf6TVqSCDUGs/nk4o8SPTN8BR4+kL5+HtX74
 tusUKBxgkyPD8MMzEsYFd34IgT2rPk9NgSnqr5km938HM8gOv5VzCkR/t/8dH23VITAs0
 p08ey6xwTPTB2hvvCCRdY+mFgQXbiB6GOZaTJeGZB7x6EBS+l13JKdnhw+p66m/veK3D6
 XJDtZLxItD8hpgWVVJbo4G4J6KljP94yvS2ATZdJjIuZ4687yEU6PAVVzIDYEiEsjyyzM
 slSkyy9iqNH4oZYzRYNfLR6wfJp/3jrAx90O4K9rA2ML5I7NTpM7w62ssrOgHUxd79g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590473;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VDVBSjkDGN+y1dWn6NHcmbYbgBxaNp5zmb96QzpKt08=;
 b=OF2++rwJSYOz8gYNrKhkF15/Dy2XGzOTq+liVRWWv9Koakw1wHcmEMiH6jrmSc5+H5D7
 GlYyDcIJHwvmEAxhtViqmr8WtuPMNQoNymKcivjL1tiBKP3wgdMSJvXYJfxgmhtn86cWS
 mZPbeA9DAFRcPkKwfpiqiVrGFVTwL6xSX4OJqvmrLSes1D/Zq83vsQdDAuU8KqyzeT35V
 tH631DlIeU3JWswZgem6NFse69TbrFrT0WpgTR9bFrSe3v9LpIrmZBV1PbcOPlBkNwcAk
 sGhzK4BHyAeYTyViE8MyYwdxLJdloP1UBqCJQDewg3stCgiAqNN2Qxx+GyyaQgNo0eQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=ckT5x4mW; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=ckT5x4mW
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EA78401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D1EC0B00583;
 Mon, 28 Sep 2026 12:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590471;
 bh=F1bi0g+iuQukpmbGI6lRe6UbrtzlKWyiY+ETh6IsunA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ckT5x4mWLHuY3h8S0kEAa17QlUtZBIDrBbf+AX53zmILKbxNcq9/ooua6sHON4FyL
 Zc+XqgXzGJF/iLAkbBSWoowTM2P+DSRA+QP8+q95rxt9GX7CBSVL2Dex8jqBrgy/53
 PERmzyiLug082kqywEiztRnQ1+B6VcRSEcqpoQ01CfHvWXI2a0KRvI3hz+Lp2w+s4r
 QHobx5A7eWPaaKbMhM6IsJQ4jTWi+iUk7agLQXeam8506iZgvw2jDqu828LXYAaq9q
 bD9oyM/izyNziBueMXYCjgmCqdQvKHTOdX6sKL7Yb+tDFP2wTHtLDPXKW+TX3DlvhP
 Y+k7OkBk62/HQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 02/10] board: lx2160a: serdes: rename serdes1:split to
 serdes1:100g4x25g
Date: Mon, 28 Sep 2026 12:13:21 +0200
Message-ID: <20260928101330.881662-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
References: <20260928101330.881662-1-vjardin@free.fr>
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

The following patches will be adding other cases for SD1 lanes:
  2x 40GE, 1x 40GE + 4x 10G and 1x 100GE + 4x 10G.

So "split" is not longer meaningfull.

Let's name each hwconfig value based on the SD1's lanes settings:
  1x 100GE + 4x 25G.

note: serdes1:split has only been in next, never in a release, so
we should not need a compatibility alias.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- New patch

 board/nxp/lx2160a/eth_lx2160aqds.c | 4 ++--
 board/nxp/lx2160a/serdes_split.c   | 4 ++--
 board/nxp/lx2160a/serdes_split.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/nxp/lx2160a/eth_lx2160aqds.c b/board/nxp/lx2160a/eth_lx2160aqds.c
index c1a060877cd..8f48b14c0e3 100644
--- a/board/nxp/lx2160a/eth_lx2160aqds.c
+++ b/board/nxp/lx2160a/eth_lx2160aqds.c
@@ -18,8 +18,8 @@ void reset_phy(void)
 {
 	/*
 	 * Before the MC boots: it latches the live protocol-converter
-	 * configuration when it starts, so `hwconfig=serdes1:split` has to
-	 * be applied here and not later.
+	 * configuration when it starts, so `hwconfig=serdes1:<mode>` has
+	 * to be applied here and not later.
 	 */
 	lx2160a_serdes_apply_hwconfig();
 
diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 6d9743a28dc..1a5c44e7740 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
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
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 67e8c4873a7..8dce9ddf97a 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -25,7 +25,7 @@ bool lx2160a_serdes1_is_split(void);
 int lx2160a_serdes1_split(void);
 
 /*
- * Apply `hwconfig=serdes1:split` if the board's environment asks for it.
+ * Apply `hwconfig=serdes1:100g4x25g` if the board's environment asks for it.
  * Boards call this from reset_phy(), before mc_env_boot().
  */
 void lx2160a_serdes_apply_hwconfig(void);
-- 
2.43.0

