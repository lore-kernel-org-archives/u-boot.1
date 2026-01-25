Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E81AE63C8E
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 13:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A2E83C61;
	Sun, 25 Jan 2026 14:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Vdt6ye+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AB983C6C; Sun, 25 Jan 2026 14:13:04 +0100 (CET)
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA15D83C19
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 14:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout3.routing.net (Postfix) with ESMTP id 47140604B7;
 Sun, 25 Jan 2026 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1769346779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aySCsLarhuNFe9WNUFK+1kg/AA8mxSePNsY98GUPBk=;
 b=Vdt6ye+V3t2gkTVnLsW07t2cdEevdcw7RId8p4OUH31P5wGJgwGCv/WJ5xcIpsbJI2aYTm
 cTU0ucX7Xr+cjUCWwzi6+mqiwtmKSjwnGFYFgeNYvWfMGr+pjxPfQ3DaVmsTESkpeyBbVM
 s1b3fIUuk4RTLwd6EJ8ygIB7BXzV46s=
Received: from frank-u24.. (fttx-pool-194.15.85.69.bambit.de [194.15.85.69])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 2D6F8122702;
 Sun, 25 Jan 2026 13:12:59 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v6 1/3] cmd: mem: add command for getting ram size for use in
 scripts
Date: Sun, 25 Jan 2026 14:12:51 +0100
Message-ID: <20260125131254.23210-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125131254.23210-1-linux@fw-web.de>
References: <20260125131254.23210-1-linux@fw-web.de>
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

Add a command for getting detected ram size with possibility to
assign it to an environment variable.

example usage:

BPI-R4> memsize
4096 MiB
BPI-R4> memsize memsz
BPI-R4> printenv memsz
memsz=4096
BPI-R4>

board with 8GB ram:

BPI-R4> memsize
8192 MiB
BPI-R4> memsize memsz
BPI-R4> printenv memsz
memsz=8192
BPI-R4>

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v6: add missing return for error in env_set_ulong
v5: move msize to meminfo and drop first param (always display as MiB)
    rename msize to memsize
v4: drop rounding to full MB/GB as it leads to wrong display
v3: add missing ifdefs
v2: add Kconfig entry
---
 cmd/Kconfig   |  6 ++++++
 cmd/meminfo.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5c611fb3016e..be79bf0747df 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -925,6 +925,12 @@ config CMD_MEMINFO_MAP
 
 	  See doc/usage/cmd/meminfo.rst for more information.
 
+config CMD_MEMSIZE
+	bool "memsize"
+	depends on CMD_MEMINFO
+	help
+	  Get RAM via command for use in scripts.
+
 config CMD_MEMORY
 	bool "md, mm, nm, mw, cp, cmp, base, loop"
 	default y
diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index aa3b5bafe176..e7db9d065f5a 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -8,10 +8,12 @@
 #include <bootstage.h>
 #include <command.h>
 #include <display_options.h>
+#include <env.h>
 #include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -98,8 +100,31 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+#ifdef CONFIG_CMD_MEMSIZE
+static int do_mem_size(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	u64 memsize = gd->ram_size / SZ_1M;
+
+	if (argc > 1)
+		return env_set_ulong(argv[1], memsize);
+	else
+		printf("%lld MiB\n", memsize);
+
+	return 0;
+}
+#endif /* CONFIG_CMD_MEMSIZE */
+
 U_BOOT_CMD(
 	meminfo,	1,	1,	do_meminfo,
 	"display memory information",
 	""
 );
+
+#ifdef CONFIG_CMD_MEMSIZE
+U_BOOT_CMD(
+	memsize,	2,	1,	do_mem_size,
+	"get detected ram size in MiB, optional set env variable with value",
+	"[envvar]"
+);
+#endif /* CONFIG_CMD_MEMSIZE */
-- 
2.43.0

