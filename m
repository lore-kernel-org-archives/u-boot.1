Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2E8CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E04260802;
	Thu,  1 Oct 2026 20:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_b2jfhJfCyP; Thu,  1 Oct 2026 20:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 72B7660660
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887698;
	b=ArnwzpgaVYhyvU962eIHoSDbpLIcpCPplMvvhz9IHMx3niCxfN3zBR4nq1t77EfT6ymN
	 JiDHLTt00ORVHqhywiAj4HCiC01IyEb3MpntGMRPbfAViO4tBLKo0Y7nUnXIQY3xMR8cW
	 Ihv8K/KWziGxi8uGI319jpXq7ycPg4vVJY05QpLQW4LPtkdt2rV2//yMKKNndfcgUf5vT
	 nfQy9qSgkXCDMpiqbRZ+ISx6id+C6lGohGTHFOAfUXjD5KHK/k7f9qbZFNPcX3Rz+6IVH
	 WYo1zAJCuIKYpdu7Czg4l8Z/OORdMRnUpL5mSsIZJIRI9dV83MTIyG9FaCz11te9O9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
	b=VBHiC5pIhr89hQqmTxxalNrh5mxIUQUn0l6YOkJV/CHdq+Zxz77FguTXTnyC8LsTzGBF
	 qRCpPyvwCJqn04Sm9gGIU4Byd0NM2joSFFk8NpdUg5BA7tSqG1Pfood0vJNcwVnhkmz9Z
	 AfLE+Lr865SKdSBnOR+N3Y+A8K/OIjkksZtMlpss5TD1wgNqOdV8ZYWY7DQ+YOvCptccl
	 69fds15waowMqfBJgg79CjM3tNWR9gZ3EQKIkJ4rjC3Q98/cWKajGS8ORJOxCdLIwwmUX
	 VJWFJbq8UPKBRyllKNNNlqQ7/+gcCSHFF++s6PqTf1wcis0Z0i8IN+dTfHJfzskTsKw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887698;
	bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i7EAM4kx9bWGo9YKB43GWiEpEcMdNDnK1t8jFhq7UxwnwAZN3AbINKd4/+hxnaRyy
	 5PA+HOZzQfzlKOC67tAE90JX6k2WtnSt+iqflXORKKJUQZMmYsFMLEB6slgSdZPjTP
	 4oWaZx+c/jC1PK4Rg40ELs0QV3yDDYV6aCuEJ0vvYKbUAP0ew6SkxIdDaI8qAm/p6I
	 FJXAtfwIQJsC8ngnr1lCOKexODFEjaEsaODddSVAfOhcgpaOxAgvjlrCmECawSBNbk
	 72AXBMRMZekFmdXHAgipjPUCl/AJXtORMSx6CL2dTZFSFP0msskCst5mwq+U0zLcLP
	 GQki6DK3opACg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72B7660660;
	Thu,  1 Oct 2026 20:48:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E60A22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 005E181161
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_TdiKTz1a3q for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0E779810BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887696;
 b=nQnPo27Ph/le4cBK1d761SS02Zp2wew6x3YwoXtEBlvldcumgUk4jkgjUCdq7cXPXOWS
 VfKa6GuG/TyuMvLJOATqFUIqj1LgKZSfEWdRsvHferGI+0Ccz8zu9urFgzVb4VQgxPU+K
 jKAFPAXdBxkIb+LHNJafPLU5t9G0SNpqh/K34bDKdqKyvIEwWi/Jy7nZuNkB4Fbgt5OKW
 u4F8bqIyI7zhcZ9XZXp2NVTimAQHFF4gYCse6tXbnAVfhLJil8yC+HzpVao5wdKV0zJ/K
 X+GzuQsZOxhnZ0L5F4P75L2yTnpahGZUMD7ZS0nWAzFHESUHKXBNFRqaUdOEO+s1/pA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887696;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
 b=HCALbSiWZfI8zUCEEd1LHk3bTiEpIhBReuLQayv7j4fWwwZlkirfl27vLfKWfycPLw3v
 DNIOzGOWK2ZrTd8s1vAvWZOoPTJZ+6MbB5WIgxDtTSYvfPlRT7pYgAtHLQ4C9XicaKk98
 tQ+UuWfRkNgSyiXOJ2ZsM+XNAhRR5IXC9AFJk3j3pFT3zcIeVpo9mnyF/awXnwf6nRrm4
 O2UuLjQxhv0mDdXWntKorRLqOTy2KivP9i22yznVvxCQHAg3i9BNB0uSITxCo5wNmAtYz
 prA/18NIAAGe4ARsl5nKpSuEVBYMAIf8BmM0xxurg6Wd9mq6TWTxNARcS6Ik3vgesHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=ot2GFbxe; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=ot2GFbxe
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E779810BF
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 708A7B0053E;
 Thu,  1 Oct 2026 22:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887693;
 bh=2G2Pd5HL5z4JlHmX/LFx2fA1Z+5ulNgTDAS1axvM/qM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ot2GFbxetLJ6xmf1jNdfFlx+Lv/XMMd9UmbsFDXngVxkpFlrM2NfCpbtmZ3iVx2tI
 Xaj7r0lw4wc7QB7DurzQEjEX7Me22UT10XTvwyiQABu8arDU/m/7fSx74QX1qOy00U
 HjPyTy1AJcb3hWO+prt9v7eWk46RQtWquFTJEuf6IKejTmh16tt5ztD9cI5Gfr4Bum
 2d3bLltA1bWPleKR/PNOqmbGnHDVgF4vOaKY+Tl2kkhGBaXO6pfEifds3u5Fy5vPZ8
 HvmZNdBuSUKCRChsVklU+9O+7a+XtARck1eiQPJjGd7iWPc9kDNxz4NuPNeNclRO/P
 fLnasAY2mxc7w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 01/13] board: lx2160a: serdes: drop the split subcommand
Date: Thu,  1 Oct 2026 22:47:18 +0200
Message-ID: <20261001204731.1774613-2-vjardin@free.fr>
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

