Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49593C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 13:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F80081BC5;
	Fri, 14 Mar 2025 14:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jUJOyJQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6EEC81CF0; Fri, 14 Mar 2025 14:57:26 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7134181D65
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvJHw1653677
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 08:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741960639;
 bh=r2B+V35vd7FQQUhwOr83M2HCFgsjGKw6qod6QwnZnWc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jUJOyJQ7nSL4lM3Y9TlKlD0IXPOYU04tVgs0xTdYAI1djaXkuFzTXfOQYdMc88EwY
 Ll0qUfj6BrE7JlXtdflTw8QKTmyye3WKM4pFkY0yZ9DFmRgltEnCLiHqRVPtMscaYM
 nsxJo7tz1ZMBCEnAUmGt8QJEc40zbg3uZvNWSyM8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvJd8072015
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 08:57:19 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 08:57:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 08:57:18 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDvIAi128845;
 Fri, 14 Mar 2025 08:57:18 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [RFC PATCH v2 1/5] cmd: fuse: Remove custom string functions
Date: Fri, 14 Mar 2025 19:27:02 +0530
Message-ID: <20250314135706.184807-2-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314135706.184807-1-h-vm@ti.com>
References: <20250314135706.184807-1-h-vm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Remove custom string functions and replace them with normal string
functions. Remove the custom strtou32 and replace it with str2long.

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
---
 cmd/fuse.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/cmd/fuse.c b/cmd/fuse.c
index 598ef496a43..9f489570634 100644
--- a/cmd/fuse.c
+++ b/cmd/fuse.c
@@ -15,17 +15,6 @@
 #include <vsprintf.h>
 #include <linux/errno.h>
 
-static int strtou32(const char *str, unsigned int base, u32 *result)
-{
-	char *ep;
-
-	*result = simple_strtoul(str, &ep, base);
-	if (ep == str || *ep != '\0')
-		return -EINVAL;
-
-	return 0;
-}
-
 static int confirm_prog(void)
 {
 	puts("Warning: Programming fuses is an irreversible operation!\n"
@@ -54,14 +43,14 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	argc -= 2 + confirmed;
 	argv += 2 + confirmed;
 
-	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
-			strtou32(argv[1], 0, &word))
+	if (argc < 2 || !(str2long(argv[0], (ulong *)&bank)) ||
+			!(str2long(argv[1], (ulong *)&word)))
 		return CMD_RET_USAGE;
 
 	if (!strcmp(op, "read")) {
 		if (argc == 2)
 			cnt = 1;
-		else if (argc != 3 || strtou32(argv[2], 0, &cnt))
+		else if (argc != 3 || !(str2long(argv[2], (ulong *)&cnt)))
 			return CMD_RET_USAGE;
 
 		printf("Reading bank %u:\n", bank);
@@ -79,7 +68,7 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	} else if (!strcmp(op, "readm")) {
 		if (argc == 3)
 			cnt = 1;
-		else if (argc != 4 || strtou32(argv[3], 0, &cnt))
+		else if (argc != 4 || !(str2long(argv[3], (ulong *)&cnt)))
 			return CMD_RET_USAGE;
 
 		addr = simple_strtoul(argv[2], NULL, 16);
@@ -99,7 +88,7 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		unmap_sysmem(start);
 	} else if (!strcmp(op, "cmp")) {
-		if (argc != 3 || strtou32(argv[2], 0, &cmp))
+		if (argc != 3 || !(str2long(argv[2], (ulong *)&cmp)))
 			return CMD_RET_USAGE;
 
 		printf("Comparing bank %u:\n", bank);
@@ -119,7 +108,7 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	} else if (!strcmp(op, "sense")) {
 		if (argc == 2)
 			cnt = 1;
-		else if (argc != 3 || strtou32(argv[2], 0, &cnt))
+		else if (argc != 3 || !(str2long(argv[2], (ulong *)&cnt)))
 			return CMD_RET_USAGE;
 
 		printf("Sensing bank %u:\n", bank);
@@ -139,7 +128,7 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_USAGE;
 
 		for (i = 2; i < argc; i++, word++) {
-			if (strtou32(argv[i], 16, &val))
+			if (!(str2long(argv[i], (ulong *)&val)))
 				return CMD_RET_USAGE;
 
 			printf("Programming bank %u word 0x%.8x to 0x%.8x...\n",
@@ -155,7 +144,7 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_USAGE;
 
 		for (i = 2; i < argc; i++, word++) {
-			if (strtou32(argv[i], 16, &val))
+			if (!(str2long(argv[i], (ulong *)&val)))
 				return CMD_RET_USAGE;
 
 			printf("Overriding bank %u word 0x%.8x with "
-- 
2.34.1

