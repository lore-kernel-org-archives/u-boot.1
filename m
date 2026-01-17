Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3990EC98338
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 21:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF4283015;
	Sat, 17 Jan 2026 22:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="TQbKHY20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D011833C6; Sat, 17 Jan 2026 22:24:12 +0100 (CET)
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3AB382BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 22:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout3.routing.net (Postfix) with ESMTP id 456C76048C;
 Sat, 17 Jan 2026 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1768685049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XfzqPnfskzKxQ7qFfFsetT7V0o2e9Vf4PcP+cqQbb1g=;
 b=TQbKHY20jWg9zK5V8oSrsYqz82JsVjCsTV5cDM3WI6MyTWIAxS5ICO1e0jEh1GRccK4JT8
 CFAjUstKJpeyTGUlrBuQmKgeM8XQT/DA/tEBPLz6xpHvNOo8Pq8a4WnEOt/IfXX3Mw7zy2
 uSg/9i086Md67qI/1aaQY8RvSuldaA4=
Received: from frank-u24.. (fttx-pool-80.245.76.1.bambit.de [80.245.76.1])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 2A0E21226E3;
 Sat, 17 Jan 2026 21:24:09 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v2] cmd: mem: add function for getting ram size for use in
 scripts
Date: Sat, 17 Jan 2026 22:23:59 +0100
Message-ID: <20260117212401.703588-1-linux@fw-web.de>
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
v2: add Kconfig entry
---
 cmd/Kconfig |  5 +++++
 cmd/mem.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5c611fb3016e..b82b17195b7e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -974,6 +974,11 @@ config CMD_RANDOM
 	help
 	  random - fill memory with random data
 
+config CMD_MEMSIZE
+	bool "memsize"
+	help
+	  Get RAM via command for use in scripts.
+
 config CMD_MEMTEST
 	bool "memtest"
 	help
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

