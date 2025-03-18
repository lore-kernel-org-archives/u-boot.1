Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAF7C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F9481C64;
	Tue, 18 Mar 2025 11:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f7hsLyWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4697E81B5C; Tue, 18 Mar 2025 11:51:04 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B98800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52IAp0lk2589402
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Mar 2025 05:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742295060;
 bh=Vp31EV7WPXoBdZ9mk0ZsqJ0cplg++2yzB5gfXsKvbKU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=f7hsLyWxYqk3JuVo4rNG1GC7iK+/jRLkiUcUr8s4yg/2ymaZCh+zU+nwyL25pNJ7x
 wJDlDbH0jt005EfGDwHGCT1m5CMi0NP3U34GAiSAWNLpes0Ggxe2aw4DwPs1Vzk2gl
 gKZ6LZ75BTezzpkAkAy7yEd18oYHFb+kG9kIq0h8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IAp0Y2015051;
 Tue, 18 Mar 2025 05:51:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 05:51:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 05:51:00 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IAoxRL094613;
 Tue, 18 Mar 2025 05:50:59 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [RFC PATCH v3 1/5] cmd: fuse: Remove custom string functions
Date: Tue, 18 Mar 2025 16:20:43 +0530
Message-ID: <20250318105047.256022-2-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318105047.256022-1-h-vm@ti.com>
References: <20250318105047.256022-1-h-vm@ti.com>
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
functions. Remove the custom strtou32 and replace it with
simple_strtoul.

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
---
 cmd/fuse.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/cmd/fuse.c b/cmd/fuse.c
index 598ef496a43..9825477c8da 100644
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
@@ -54,14 +43,18 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	argc -= 2 + confirmed;
 	argv += 2 + confirmed;
 
-	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
-			strtou32(argv[1], 0, &word))
+	if (argc < 2)
 		return CMD_RET_USAGE;
 
+	bank = (u32)simple_strtoul(argv[0], NULL, 0);
+	word = (u32)simple_strtoul(argv[1], NULL, 0);
+
 	if (!strcmp(op, "read")) {
 		if (argc == 2)
 			cnt = 1;
-		else if (argc != 3 || strtou32(argv[2], 0, &cnt))
+		else if (argc == 3)
+			cnt = (u32)simple_strtoul(argv[2], NULL, 0);
+		else
 			return CMD_RET_USAGE;
 
 		printf("Reading bank %u:\n", bank);
@@ -79,7 +72,9 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	} else if (!strcmp(op, "readm")) {
 		if (argc == 3)
 			cnt = 1;
-		else if (argc != 4 || strtou32(argv[3], 0, &cnt))
+		else if (argc == 4)
+			cnt = (u32)simple_strtoul(argv[3], NULL, 0);
+		else
 			return CMD_RET_USAGE;
 
 		addr = simple_strtoul(argv[2], NULL, 16);
@@ -99,7 +94,9 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		unmap_sysmem(start);
 	} else if (!strcmp(op, "cmp")) {
-		if (argc != 3 || strtou32(argv[2], 0, &cmp))
+		if (argc == 3)
+			cmp = (u32)simple_strtoul(argv[2], NULL, 0);
+		else
 			return CMD_RET_USAGE;
 
 		printf("Comparing bank %u:\n", bank);
@@ -119,7 +116,9 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 	} else if (!strcmp(op, "sense")) {
 		if (argc == 2)
 			cnt = 1;
-		else if (argc != 3 || strtou32(argv[2], 0, &cnt))
+		else if (argc == 3)
+			cnt = (u32)simple_strtoul(argv[2], NULL, 0);
+		else
 			return CMD_RET_USAGE;
 
 		printf("Sensing bank %u:\n", bank);
@@ -139,8 +138,7 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_USAGE;
 
 		for (i = 2; i < argc; i++, word++) {
-			if (strtou32(argv[i], 16, &val))
-				return CMD_RET_USAGE;
+			val = (u32)simple_strtoul(argv[i], NULL, 16);
 
 			printf("Programming bank %u word 0x%.8x to 0x%.8x...\n",
 					bank, word, val);
@@ -155,8 +153,7 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_USAGE;
 
 		for (i = 2; i < argc; i++, word++) {
-			if (strtou32(argv[i], 16, &val))
-				return CMD_RET_USAGE;
+			val = (u32)simple_strtoul(argv[i], NULL, 16);
 
 			printf("Overriding bank %u word 0x%.8x with "
 					"0x%.8x...\n", bank, word, val);
-- 
2.34.1

