Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CFBD715EF
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 17:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA4C83C4B;
	Sat, 24 Jan 2026 18:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="QlBR5KN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06B983BE1; Sat, 24 Jan 2026 18:23:55 +0100 (CET)
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44F883AEE
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 18:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout4.routing.net (Postfix) with ESMTP id 57A961002E6;
 Sat, 24 Jan 2026 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1769275431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynQf/QJwrSl6AdIU/qAbjX7mOV4ByVfPBRUJr/aPGOE=;
 b=QlBR5KN4XEsGcG8fVXVCdd2D6X7qeFjhmBdWuFiWeQyvj7Y/bWBRi/gANfeW+J1knJT9Kc
 uQCZwmqMZctkwXWHtgP/FvkhFc93CRaquNSv4ouHl5ht7YNR3vSwkpio6DzE1l0wAfCXDB
 q/2a4RBToEvzA8g4uSNtLIXmp+8mjY0=
Received: from frank-u24.. (fttx-pool-80.245.78.113.bambit.de [80.245.78.113])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 3F92B122702;
 Sat, 24 Jan 2026 17:23:51 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v5 1/3] cmd: mem: add command for getting ram size for use in
 scripts
Date: Sat, 24 Jan 2026 18:23:40 +0100
Message-ID: <20260124172344.926755-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260124172344.926755-1-linux@fw-web.de>
References: <20260124172344.926755-1-linux@fw-web.de>
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
index aa3b5bafe176..a4e951881ba0 100644
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
+		env_set_ulong(argv[1], memsize);
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

