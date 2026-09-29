Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0FDCA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9A03407C1;
	Tue, 29 Sep 2026 19:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxK-4YeaoXjq; Tue, 29 Sep 2026 19:34:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F461407B2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710472;
	b=bJ08iSVYs3St2I+W43jiKDgo6Vglhq097T0Vmx8zjdinqBurZvzLijwes6T38P/q0Hm/
	 DKdylsnoPMwB/VkJFo48+JaUwMXC85E1mHe700TnLyogUkkhuB4SLDXrgSCVYiwsQ/DkR
	 Bp+EnMa4+OREPF9HJgrDt+YmGfrMXoqv9yTktIsxBF/GM42CgQwgZlFPhE+0yiIYUdsES
	 hnxMJz2U87ue2NqHSY8LITV01r5w2jbN/DtJvBe29P4i7aVc6ThbKtekTWGR6imbCVCdU
	 W5CqxVGGiq57NlYlappWD2kdBqVA60xn6pikuxF1adEYi/TiZH2sl2ftaU9TZI8v1og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
	b=dWUQTjK9VDpYlADNV3bLWZ0hHC18DwGMTaeiQaOeC4uoiJz+d55NUUr7zVSmCUSZkP47
	 5wcNeSn2P5J23brbiJikJpFjz77F8+ATVNOvPq5P8PJUUcGQZkvJFXHF0Fr9t6O7OtXhO
	 mTM0LsJPdbhbSPEqBLGE2qK83cbZvSz25RudVI7WfTJTZIVRox+FP84B0zlKUop8Mwphe
	 aaw9+ERhwbU+WcJMfy53LI5+5XmHFkk0HcP69uaTtKLQgrt1DnwBfQTCGTBRStcq/v9dD
	 2qj/kGa+Lchx5zMBxxrYw7/ilh1VXH72xm0iB87jMSsTRvLPkFkNpVgGtjlXiSlXhJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710472;
	bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YihcqLXu4G5l5RjQlBi+SQNeqf3vp+YeVB8wJE3jW+SG8azRb0c4DG7BOYrZ8tW0z
	 L2jEQyK2YFRdZ72u+5olIA12jzCYHCItGkvCLR/Y10hJWGkOzqawMgZBnZOREKw8vY
	 GpLr8PBCchN0x0vCD+zGipfr5JW+n7BnK4NcQ85+7Jy0FqoU0LPtE23iB8ww7bJv3h
	 ZIJ0v0RKABkryRt8qj7V55rb2Z45OtcSwMYuib8SS1Pd9qf+GmdENK5lm7uASFh+1Y
	 o/B6b7/V4DylVY0My6p1YH7fQECCUMx3TUD2W6iKAmx5DLsfM+YMvB0j+PgRfDn1zv
	 SKk2JCm2oy+GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F461407B2;
	Tue, 29 Sep 2026 19:34:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C21AF32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF27B607EF
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NaTtMHcB6VsL for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0CC25607AA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710469;
 b=G/RUtW3jriQay5khJEtUSW/fgrthnv9kTDJgq0/Y6dbjSWWkkRON1Jb8+py63dsl/XHG
 S6SxzcF82fhu14ozo/kTdXLdODhYk3BD4D7JQq9E/RXpyssn8K1uU3M+aBS/wvepdq7Lu
 HjDpp/aBGJohXDXW8CSQLbJEXFr8JRr+pvQfiHRogaquncqmaadV8iMiqBsWU8031/26p
 Py/ImvV6qO0P7urXQRdPjWhNlqG9vhXq+YYJXJOhv61K1Z8EKV2GPnrlmMcLqilQsyGuo
 fYYGP6wuPUGXP7qR/7RZI3/GJm/1MADSHzm5Zz5Ade1CdxAAltRpQ9Qzj4nUqgtwKuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710469;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=dIdnYhER7I7asF7Ehiqktb7hdGwXBwlsXjJqjS23UJY=;
 b=MbHNp2kRi0vcYrNizzB5OHvajGSGXmNPalMVb9bpc3t3H97YLfgL5pP2wSzgtjQKeuWS
 F3U854xwclsNuGaoMCSnPdfv/gnW/mR45bpXXXUOPU4l+lLNNz0EgLjnmxBBhkEQ81pqQ
 fi4Hg2fSahAu1atKafuSZxdhXeGYlHTgwagblv5FRVvMWw4/4S3PBgX3JoyHW5Yo8W/rj
 ToxsW96hRHc9zab8rlOsNIHzrzXopoEf4oSYWoMjFg9PvGucplSXdccBgGTIK7okbY5V8
 OSIljrEhxeCbYRTd1Jup7fE/zK5YfaIEzQgwnRZmkxTP79obIx0gmoLkrq/5CGKmDTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=i5JZk8xF; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=i5JZk8xF
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CC25607AA
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 04E46B00579;
 Tue, 29 Sep 2026 21:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710466;
 bh=2G2Pd5HL5z4JlHmX/LFx2fA1Z+5ulNgTDAS1axvM/qM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i5JZk8xF1J0V7vZM9Wic67pQQTiIC+2El+5WHSsd5boYWOq+uEOGh/NlKbvDCQRfb
 a+FleH7FNTBA3HviD6gDEASmabGg/5bVuMdTBQB9sCp1M7KWwsi16FCEy3H+B64I4S
 K8SeeCII8OCrx2OEavSxv9HHhD3N9oINWIm8zOfqenl7ZSLNUEUkOS+fPkUSd7qniM
 DnkwzyRU3tDxDW2udNCv6BXc7OWxScuPYVeZh6/MgdtyoLYjm4grJ6tblSNk/ZK/E/
 f1Di6eA5W6Vmn/fcP0TGRbjnd0JmTjoP6Qk6UyYiJVIw8AILk4lcTaocfP4TjO1xvo
 b8K4SmDMlFF5w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 01/13] board: lx2160a: serdes: drop the split subcommand
Date: Tue, 29 Sep 2026 19:59:33 +0200
Message-ID: <20260929175947.1379710-2-vjardin@free.fr>
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

