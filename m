Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0A5C98327
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 17:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489A483015;
	Sat, 17 Jan 2026 18:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HaaFxrCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EDA82BF2; Sat, 17 Jan 2026 18:09:09 +0100 (CET)
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB708367F
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 18:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout3.routing.net (Postfix) with ESMTP id AADDF605EE;
 Sat, 17 Jan 2026 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1768669744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nacLJGcrbnOp1lx9ABMtmIbf3/gCgF4UPYQFkInd4nk=;
 b=HaaFxrCURH+8Ap56MeLE3Lu/c8zUZ6r8zYE4zC12Z4x1rOTXLBiYN3CLYhNGgVya6WmuPT
 NARNd3O3IVjxM6OJPx8QM1iPIrve+o29rB5RZqAl8zfa9e49XMAEwn3KNiEcwbb7u4myv6
 mIwnt658WOD6NtzVDBSDbptVu670jVA=
Received: from frank-u24.. (fttx-pool-80.245.76.1.bambit.de [80.245.76.1])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 8EE921226CD;
 Sat, 17 Jan 2026 17:09:04 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] cmd: mem: add function for getting ram size for use in scripts
Date: Sat, 17 Jan 2026 18:08:54 +0100
Message-ID: <20260117170855.533952-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frank Wunderlich <frank-w@public-files.de>

Add a command for getting detected ram size with possibility to write
to environment variable.

example usage:

BPI-R4> msize
4294967296
BPI-R4> msize m
4096m
BPI-R4> msize g
4g
BPI-R4> msize g ramsize
BPI-R4> printenv ramsize
ramsize=4
BPI-R4>

board with 8GB ram:

BPI-R4> msize
8589934592
BPI-R4> msize m
8192m
BPI-R4> msize g
8g
BPI-R4> msize g ramsize
BPI-R4> printenv ramsize
ramsize=8
BPI-R4>

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 cmd/mem.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/cmd/mem.c b/cmd/mem.c
index d5d7ca2790bd..a1cf4eef0701 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -33,6 +33,7 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -711,6 +712,27 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 #endif /* CONFIG_LOOPW */
 
+static int do_mem_size(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	u64 memsize = gd->ram_size;
+
+	if (argc > 1) {
+		if (!strcmp(argv[1], "m"))
+			memsize = (memsize + SZ_1M - 1) / SZ_1M;
+		else if (!strcmp(argv[1], "g"))
+			memsize = (memsize + SZ_1G - 1) / SZ_1G;
+		if (argc > 2)
+			env_set_ulong(argv[2], memsize);
+		else
+			printf("%lld%s\n", memsize, argv[1]);
+	} else {
+		printf("%lld\n", memsize);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_CMD_MEMTEST
 static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulong end_addr,
 			  volatile ulong *dummy)
@@ -1404,6 +1426,12 @@ U_BOOT_CMD(
 );
 #endif /* CONFIG_LOOPW */
 
+U_BOOT_CMD(
+	msize,	3,	1,	do_mem_size,
+	"get detected ram size, optional set env variable with value",
+	"[m, g] [envvar]"
+);
+
 #ifdef CONFIG_CMD_MEMTEST
 U_BOOT_CMD(
 	mtest,	5,	1,	do_mem_mtest,
-- 
2.43.0

