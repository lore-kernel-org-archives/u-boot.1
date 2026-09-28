Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9167C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A39A606A3;
	Mon, 28 Sep 2026 10:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKrz5gBcxz2M; Mon, 28 Sep 2026 10:14:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0B6316069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590454;
	b=RsXFQl5BfRXGzFoZdMwRHmqRuinkvtZFxqlQ7afYq63Vlo8Mw/aLVHCZUyOCcO7vsk73
	 EjgsnCzUvoinkP35YHArEAmhs/eApbQeEeuZrOUBrO+/5Frnq3dKoDn6ly/yuAawkQoLC
	 kkYzIjXwxS9GOXsCwa1Adfwz/v+sXUM95iygo/+PqDVM/kBim7EkDDaixfIinMiy+Imet
	 gN1uibfNswE1r7+xjD4fMPUNttBQofpBO5UqM2cCXFavnlH2Vpvlb1s7iIsnte+ZMFzXc
	 QbssKNHevkOcNbvH01MIhTQwQdZD0y7Ysertx71sTAMIccVpiPyGpc24Hn8D6P6/ciQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Zf7DMCCg4s5tuSPEnQJ9jxtrF9HBEckbdd096VUxH4=;
	b=i9qKleubSXJjRHmtn6iDtKq8Zf6XwNiO/TlLyLi8UiljCalYYddvEg7cV5QPReshrJ2H
	 vqK4X8LrGGQHD8W+FlOfCFkzcVn+90ykiYpb7PC18EBJeYVy0QDnYlG38Cq/VDKAPTyt6
	 m7IpCsSSA9K90sjgD4eDpRlwnWbPdmfpSO8n947cKusMD7CLCG4ju8NByVX1RzFK69OGf
	 /qpCPG55cfSx8sRMdWizHc223qorQp6k2i6q+rNY/sCKny8CpBGZFc4W+LcALfscFA5xz
	 Q4nRrhUbWSgU/fqESlCWPoA+ANI76VuHKeSvwovwRWnAB0xGZR8yHJsrow6hCQgBurA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590454;
	bh=7Zf7DMCCg4s5tuSPEnQJ9jxtrF9HBEckbdd096VUxH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fn8WmGonC05VJxoyGahy8H9t6SSpvCJlHdTLmm8R54sAWrHudacmj8q8oAE98DPJm
	 fP9KnBWHZLGRFxdRPU0aE5md82l5qKukY8PyAwCaYDJR5rr6Ig3mLMr5WCLsU2fv4o
	 O2e3dFW16YarGXBjCoVpNm1G/IqNwNn1TCZ/YOmsET7PNctWR9OMw6CdiJDxj5dq3r
	 LkZj+Kno1rr2J6u9XCFcEGPivxTryHx2Qa2Vqy7KtFg8WEmFDfzCn1GxEO0M9lYw6n
	 lIyq/8DpKHAQyCEL6QjzgytKDlDx/HPPEm0JGdeqALUewZz664O4Nh/p0e5lfFyo4k
	 vQPiGpHQYPjIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B6316069B;
	Mon, 28 Sep 2026 10:14:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3637C2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BD1A80D64
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5WcVLYx__DY for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D5CB380D7A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590451;
 b=bW/BlmWOJkkjchBhk6hd/xWSRNpdjvdjWaI5LpClcwI8xBcLuk0lAqm6G1sxgbYLT6nR
 uxx9NCQBtTjMwY9DntVxpeQ9tM08VQ3MCNcEJ1L9yd9n6z1AW2j13nt+OXGBlwGuNfDzX
 3b6jCQIdG85t+W/YkyMNyjLRNz958xsa5+u1f2giiygAZPLrTVOZiqRmicIAEwl5gXYQE
 vifYwr/P2Fm8vrVFJ07h+l4zCkFNqhGftCnTgdt2ibi3906Hewwf8ynhujW2Yb3/9UNrj
 wcLpW4r9PcQtTm4zFreitBL02UIZU9Zoo/enIB3Q/7HLAX28hyUs4MFybtyEkPLNKQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590451;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7Zf7DMCCg4s5tuSPEnQJ9jxtrF9HBEckbdd096VUxH4=;
 b=UTNWcpx33T254AOhm7bx8i4ER76DSUIC5CNx99IRUczMBpYBCkoMNVCVzoILR24wQEOT
 JtTl+VZx6865QiwrieztdMZTFFIGE30qaJFBwLcPsVupIVJJS67wqbXdyNQyh3pehlnlH
 42gmQeN+qe5WsmnFHQz3ZdHGTWNA2Rn2hbRaNSLo5hDBmZNL/VW3rxhKSjwTxtN+PIqqs
 2dKaheqcDUtz85vgPGlfSlV5mEgNpWz+QAqeOgTlQ6tsicsNm2pxKwF5t8lq1c00sxJRV
 yvTtvcAe4lqE7TPh9rynC/cG1sgdzAW1gikx0QdJNLQQl/YCsTMsqJkUx9lsiMB1MIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Je5V0feI; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Je5V0feI
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5CB380D7A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id DB3D1B0054E;
 Mon, 28 Sep 2026 12:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590448;
 bh=E4qSt1reZfnZOXWJz0cujq9CKQWRy/XqpnDlLB4tSPs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Je5V0feILdxpqv6eFAvIRw8jOaWY4v8lMD7Xoig2AifSTpw8cE/ZZNOykjV4KRbA9
 KhmGeKzpB1oLqoysiOemD77vHKLTgOn8x0gsPY+9RqiSMlnBsf8abtukYFFw8vsR8g
 xf2XhkEfnbSkBI3PA8ObvWWbqkI7wtkfNbNPtuffhX1vPDV9nsmSYmi3txgYAfbiSo
 Ch80GUXI123/gLoiNc0EffwZaKgU1/hm0a1M83VRGQmqyLXzv/32FbC4Ewly3XDZmi
 p9BS0yJdt9rWQqbF0fdpJaYT0afz9t1UGmAtd2v6gjxhy7+8vxMnl2mkcAiB/CVhGm
 CkhTeqZwgICdA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 01/10] board: lx2160a: serdes: drop the split subcommand
Date: Mon, 28 Sep 2026 12:13:20 +0200
Message-ID: <20260928101330.881662-2-vjardin@free.fr>
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

lx2160_serdes split command configure SD1 lanes from the U-Boot prompt.

But the MC firmware has very likely normally been started already.

The split must be before the MC starts. That is the purpose of
  hwconfig=serdes1:split

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

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

