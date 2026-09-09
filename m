Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01DAC79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 808768113C;
	Wed,  9 Sep 2026 20:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHRwJ6LNg8DJ; Wed,  9 Sep 2026 20:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6C9B681118
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986702;
	b=mWSIV/7Q5CCZo+nhfumwwwj/CEWJQZp9kjaRu1HSzTGp24ztT+fDiUPi1vXzrcRTYqzq
	 xzVyPDNSzQQ5iJVhiNyxY1JOFj45qe6NpxRJwsykBXe94fLboeAMBwhjF5VhjXtW6n++S
	 Z+m7LeZpGpJ0IjWziU6iS2QFcYc3DMRbZk5pIb1wcrziy4XNUv4VAF+KGgzx88V5ivm1S
	 T+DcFCqLsnBJHRwsP6zmjQtTtGOwqZSDBU7LISm0SpO9mgoKtu4l8lh/17AFRxMNgHiT1
	 xWuZZa8MszJijoIgG1BuMW2bceomGkBPdOqoGQFBf551/nD6mF65O6Lu1b8ExU2i5CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RQhtvZTTahRP7fT5EdQo9iuhAFc7zkhQuh/QGKP24CY=;
	b=pvOt3nd7WkeM608evbfEgUbM5pziTx7HPs9rxIQU2ISyg7LDg2Ytlah2uo6D9K2m1by8
	 b5y2FHJLrdEgDIBtBNtNF3D4SMW5guKUbwj3duJ9jKeSFyya+eUV+lnYinKXHb8D0Y7+x
	 WKLZUXvZX+9l+bFP8ZhO+oUL1jCJcEKcYtur405ZzYD4Fm0PslBLzxj5bjwWmZjR/M4Ww
	 yo+BGuyYeeg+CNL9F50n3TYr1b3f7oGPLrjPKy25+E+/vGCILaKgXwtwsodkc4vtKokT1
	 zi+sjZPYWYi7s4PIJRS5eoryOO7X4QNyUOWApvPG7pezhltPwA5bTggG4JKY+8dqd4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986702;
	bh=RQhtvZTTahRP7fT5EdQo9iuhAFc7zkhQuh/QGKP24CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9yjtY8EVDnOeZOPaiemzoV8zNyv9R3FPBkSIpQrcjOUU8MpmK0SmkW31wuf/F+n7
	 1mhoZWNt0WO5DyyxoNnPhpFTHKEMvDoIGwNVaSEQu1MfnQNEudAInvJZMBlVF4OXKl
	 1iy/5su43/AlJaBfr38BZRpCl96HcHHMouClvUIAmIXPS5xnnZGS021vsUv/gLvHeO
	 jHiFJF8Gv0Pc+FI8M0fkZeroaUElX3AreqkX+BFXhszhGTEtsT39FR7eYQp+tt//1/
	 NTQjk+fC2FfuKdGB+vAeylikJHXTNq5C9FG+RljTaqMziOI46T3vLcL9FcjtkxuQGB
	 vP9sv4SDAL9sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C9B681118;
	Wed,  9 Sep 2026 20:45:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1FBF432
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87DE960A4C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fjm__UCctc5c for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D8FA960847
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981653;
 b=UWhPlbmwO8ALfrYQI9onCm30y4oqDJoAutiQP2CqtK2l7eaT9MQHtLtI44yZyUAbM72F
 S2XQAKx4+5U5nKLKbScHI/x1Hvs1PgpBbiQ5g+2GOqtmGTf8wbFEsPtB+cteepBzyzpEq
 qwaJWqLzbs28dgKFxDgBDJu7G1Bkcwed/9GvquzeF9a2eMAiL4iqnh1S406ikLR0SBfxP
 oRCRP1PPMz1Dp6afCZICTBLCqnJT26+m3yELGH9PzUj2WCkj0ws/CigXDeOOBGHsXEpuM
 1SOsfvndkOkzFT/IXKTSas4EC2stvDtaIFYIz2Ok1i8QdYME4jkNnOjZH9KYjZphuzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981653;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=RQhtvZTTahRP7fT5EdQo9iuhAFc7zkhQuh/QGKP24CY=;
 b=nB0et4g2+VD2rWUZ/VzVEuy70BRjoQwj82RcRR6IcX6J0qMJ5GanAHieqUHrfWKYlv3W
 PpxtnHkdfHe30LDFaKETrngWJuGL2cOIuKvr+vgTgPPbGnyhdnLQVAgopCzkpOAilIoby
 zRYAqeAG+PTK1fjIg1Kt1YXkGwOEDT+yyARoZf2S4DZNeH2ciQ/jjKE6D1v6Aj91ijAYb
 Hd9oMlUugx3c3CNfxFU2eHYfZ1lgCNWYyLPC2A0Q8GJE2phXyXQMsKUyskDaywAclijl/
 FfuWiS9IaOqmlp9tXFac11uuzbyP9KIh7go739tX2fOgasXd0pYdGcX0WaWWxecWiuA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=pDDMXeN8; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
 header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default
 header.b=pDDMXeN8
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8FA960847
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:52 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9888920B7169;
 Wed,  9 Sep 2026 12:20:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9888920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981611;
 bh=RQhtvZTTahRP7fT5EdQo9iuhAFc7zkhQuh/QGKP24CY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pDDMXeN8CfsXWkuK94wnA7GUEF5b5WqBh9Tc++tFK4bmBChEPQ9dSqkh2+D/WHC8p
 xf++ZfTm6J3yAe8XCPadmKZqCDKtVP52i9uHkV/PpBsRuBXcjME4t98SyH+Ma/7pBk
 NE3YurlmBZ2/3dVMP+6NufCKEY2tDmPL1BjszJwA=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
Date: Wed,  9 Sep 2026 12:20:46 -0700
Message-ID: <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
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

From: Drew Kluemke <ankluemk@microsoft.com>

board_name_decode() assembles the board name into a calloc'd buffer of
MAX_NAME_LENGTH (50) bytes using strcat(). It appends CONFIG_SYS_BOARD
and then, for every detected EEPROM descriptor, "-", desc->name (up to
16 characters), "-rev" and desc->revision (up to 8 characters).

The length check runs only after the loop, so it cannot prevent the
overflow it documents. Each descriptor contributes up to 29 characters,
so a base board plus a carrier card already exceeds the buffer, and the
data being concatenated comes from the EEPROM.

Use strlcat() bounded to MAX_NAME_LENGTH so the writes are truncated
rather than overflowing the allocation. Truncation leaves a string of
MAX_NAME_LENGTH - 1 characters, so relax the check accordingly;
as written it could never fire once strlcat() is used.

Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---
 board/xilinx/common/board.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index f45b879736e..690991bb435 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -590,38 +590,42 @@ char * __maybe_unused __weak board_name_decode(void)
 
 		/* The first string should be soc name */
 		if (!id)
-			strcat(board_local_name, CONFIG_SYS_BOARD);
+			strlcat(board_local_name, CONFIG_SYS_BOARD,
+				MAX_NAME_LENGTH);
 
 		/*
 		 * For two purpose here:
 		 * soc_name- eg: zynqmp-
 		 * and between base board and CC eg: ..revA-sck...
 		 */
-		strcat(board_local_name, "-");
+		strlcat(board_local_name, "-", MAX_NAME_LENGTH);
 
 		if (desc->name[0]) {
 			/* For DT composition name needs to be lowercase */
 			for (i = 0; i < sizeof(desc->name); i++)
 				desc->name[i] = tolower(desc->name[i]);
 
-			strcat(board_local_name, desc->name);
+			strlcat(board_local_name, desc->name,
+				MAX_NAME_LENGTH);
 		}
 		if (desc->revision[0]) {
-			strcat(board_local_name, "-rev");
+			strlcat(board_local_name, "-rev",
+				MAX_NAME_LENGTH);
 
 			/* And revision needs to be uppercase */
 			for (i = 0; i < sizeof(desc->revision); i++)
 				desc->revision[i] = toupper(desc->revision[i]);
 
-			strcat(board_local_name, desc->revision);
+			strlcat(board_local_name, desc->revision,
+				MAX_NAME_LENGTH);
 		}
 	}
 
 	/*
-	 * Longer strings will end up with buffer overflow and potential
-	 * attacks that's why check it
+	 * Longer strings will be truncated by strlcat, check and
+	 * panic if the source data was too long for the buffer.
 	 */
-	if (strlen(board_local_name) >= MAX_NAME_LENGTH)
+	if (strlen(board_local_name) >= MAX_NAME_LENGTH - 1)
 		panic("Board name can't be determined\n");
 
 	if (strlen(board_local_name))
-- 
2.49.0

