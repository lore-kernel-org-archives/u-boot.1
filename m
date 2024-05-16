Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E60DC25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B2688485;
	Thu, 16 May 2024 23:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iMTTFsIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921B388481; Thu, 16 May 2024 23:12:42 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605DB88483
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5231efd80f2so1390889e87.2
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715893959; x=1716498759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMLf5bzg1N4Kj7IW38T7Dw42nwEJ/O5BQjE5lMoLsZA=;
 b=iMTTFsIXA3ZqTsjlI/e/qo3NICgR2fobAyravUR+MCdn5joza3KHO2vunIG4uMw9GH
 f1f8m6tyUfiwTnxoERugUmX/T7N0eFVGWIUktxyw4r+Kx2WlySp7mIV9wkiwzVDy3zWx
 FFjGo2N8lO+xTqZZAoELs5vRQ0KkVqzuFAq02Tl9SdD5X1kaLTqxUfi3lN/xtl2y45CT
 EXcaowcmyLympi37ljLFdlx9gbr+S7cfdxyZyR/K5Zp2MEcnuoDBwpZf8RhxKhbk/Hdo
 bPT7p7T0Zhf9kdf/vfiIxFNY29VL1gOGDebUXs6y4XfxJQ5AQTfBDQAhImwESxLXvddv
 CbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715893959; x=1716498759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMLf5bzg1N4Kj7IW38T7Dw42nwEJ/O5BQjE5lMoLsZA=;
 b=buk46PgVWbcEEiXP8/0xMBKrezc0XnpZtsRFH80fnJDOiUBV/kPKpTILLDDeuYRFRs
 fRMdABvDZnALF/4vevKSiIyzLuxfuXWzq2hW4XtcDwoezSv2eYIsY9uHJ0UxhFymV08X
 lvFBr8Ct8LB75O4BVEVxMdDTs5DbnD2R7frdPOn+4RhYrBPfP5DHH54OAD/IRQfFQM+e
 f1SkD5VLMzlTUiLEiOPvK1uYyuxICniRWv7vab0SoojRNxeApce1hezK2vKYnJ3g1i4X
 o8oFdc0P1iXiHrJsKATRTv5I4aMOYaKN3v6KWsYEyhf6shAIOQLVGwndzPyzDJL2df3d
 HL3A==
X-Gm-Message-State: AOJu0YyxwljKd2r7CCFiLTGf6h5g+ulD1j+ClAu3gBeAmrEZTW4U0avY
 ejyb7wyHvZuuuifS0msyw6kqueqb9DsSQL4nR6DcSTkcMSLD7M8iehKj5tYGp+JqIAazQp+pR/J
 U
X-Google-Smtp-Source: AGHT+IGkFGCjYIdTiPKVv/kVQJOvMuRk3aGra7JDR1cZe0CQppmLZGi0612V7xcAe5D5fqFPpnmTjg==
X-Received: by 2002:a05:6512:3605:b0:51f:b781:729d with SMTP id
 2adb3069b0e04-5220fd7acf5mr10817034e87.38.1715893959254; 
 Thu, 16 May 2024 14:12:39 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d09sm1021582266b.107.2024.05.16.14.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 14:12:38 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Phil Sutter <phil@nwl.cc>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Tony Dinh <mibodhi@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 4/4] include: Move snprintf to stdio.h
Date: Thu, 16 May 2024 14:11:52 -0700
Message-Id: <20240516211156.1819939-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516211156.1819939-1-raymond.mao@linaro.org>
References: <20240516211156.1819939-1-raymond.mao@linaro.org>
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

Move snprintf to stdio.h since it is needed by exteranl libraries.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch.
Changes in v3
- Move comments and attributes of snprintf.

 arch/arc/lib/cpu.c             |  2 +-
 board/Synology/common/legacy.c |  1 +
 board/ti/common/fdt_ops.c      |  2 +-
 cmd/part.c                     |  1 +
 common/button_cmd.c            |  2 +-
 drivers/cpu/mpc83xx_cpu.c      |  2 +-
 include/stdio.h                | 17 +++++++++++++++++
 include/vsprintf.h             | 17 -----------------
 lib/display_options.c          |  1 +
 lib/fwu_updates/fwu_mtd.c      |  2 +-
 lib/hexdump.c                  |  2 +-
 lib/vsprintf.c                 |  1 +
 test/dm/scmi.c                 |  2 +-
 test/print_ut.c                |  1 +
 14 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/arc/lib/cpu.c b/arch/arc/lib/cpu.c
index 593950449f2..269b4dbdd15 100644
--- a/arch/arc/lib/cpu.c
+++ b/arch/arc/lib/cpu.c
@@ -7,7 +7,7 @@
 #include <clock_legacy.h>
 #include <init.h>
 #include <malloc.h>
-#include <vsprintf.h>
+#include <stdio.h>
 #include <asm/arcregs.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
diff --git a/board/Synology/common/legacy.c b/board/Synology/common/legacy.c
index a0bace7b46c..2e3aa660eaa 100644
--- a/board/Synology/common/legacy.c
+++ b/board/Synology/common/legacy.c
@@ -6,6 +6,7 @@
  */
 
 #include <config.h>
+#include <stdio.h>
 #include <vsprintf.h>
 #include <env.h>
 #include <net.h>
diff --git a/board/ti/common/fdt_ops.c b/board/ti/common/fdt_ops.c
index eb917be9e0d..8a3300993ed 100644
--- a/board/ti/common/fdt_ops.c
+++ b/board/ti/common/fdt_ops.c
@@ -6,7 +6,7 @@
  */
 
 #include <env.h>
-#include <vsprintf.h>
+#include <stdio.h>
 #include "fdt_ops.h"
 
 void ti_set_fdt_env(const char *board_name, struct ti_fdt_map *fdt_map)
diff --git a/cmd/part.c b/cmd/part.c
index d140a1eddb9..db7bc5819c0 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -19,6 +19,7 @@
 #include <command.h>
 #include <env.h>
 #include <part.h>
+#include <stdio.h>
 #include <vsprintf.h>
 
 enum cmd_part_info {
diff --git a/common/button_cmd.c b/common/button_cmd.c
index 8642c26735c..72dac1f9ef6 100644
--- a/common/button_cmd.c
+++ b/common/button_cmd.c
@@ -8,7 +8,7 @@
 #include <command.h>
 #include <env.h>
 #include <log.h>
-#include <vsprintf.h>
+#include <stdio.h>
 
 /* Some sane limit "just in case" */
 #define MAX_BTN_CMDS 32
diff --git a/drivers/cpu/mpc83xx_cpu.c b/drivers/cpu/mpc83xx_cpu.c
index 9a7b5fd7c42..127d3c3af08 100644
--- a/drivers/cpu/mpc83xx_cpu.c
+++ b/drivers/cpu/mpc83xx_cpu.c
@@ -9,7 +9,7 @@
 #include <cpu.h>
 #include <dm.h>
 #include <log.h>
-#include <vsprintf.h>
+#include <stdio.h>
 #include <linux/bitops.h>
 
 #include "mpc83xx_cpu.h"
diff --git a/include/stdio.h b/include/stdio.h
index 3241e2d493f..7b999a519ba 100644
--- a/include/stdio.h
+++ b/include/stdio.h
@@ -46,6 +46,23 @@ static inline int vprintf(const char *fmt, va_list args)
 }
 #endif
 
+/**
+ * Format a string and place it in a buffer
+ *
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ * Return: the number of characters which would be
+ * generated for the given input, excluding the trailing null,
+ * as per ISO C99.  If the return is greater than or equal to
+ * @size, the resulting string is truncated.
+ *
+ * See the vsprintf() documentation for format string extensions over C99.
+ */
+int snprintf(char *buf, size_t size, const char *fmt, ...)
+	     __attribute__ ((format (__printf__, 3, 4)));
+
 /*
  * FILE based functions (can only be used AFTER relocation!)
  */
diff --git a/include/vsprintf.h b/include/vsprintf.h
index ed8a060ee17..fe951471426 100644
--- a/include/vsprintf.h
+++ b/include/vsprintf.h
@@ -218,23 +218,6 @@ char *simple_itoa(ulong val);
  */
 char *simple_xtoa(ulong num);
 
-/**
- * Format a string and place it in a buffer
- *
- * @buf: The buffer to place the result into
- * @size: The size of the buffer, including the trailing null space
- * @fmt: The format string to use
- * @...: Arguments for the format string
- * Return: the number of characters which would be
- * generated for the given input, excluding the trailing null,
- * as per ISO C99.  If the return is greater than or equal to
- * @size, the resulting string is truncated.
- *
- * See the vsprintf() documentation for format string extensions over C99.
- */
-int snprintf(char *buf, size_t size, const char *fmt, ...)
-		__attribute__ ((format (__printf__, 3, 4)));
-
 /**
  * Format a string and place it in a buffer
  *
diff --git a/lib/display_options.c b/lib/display_options.c
index d6b93553dcb..d5df53ab15f 100644
--- a/lib/display_options.c
+++ b/lib/display_options.c
@@ -12,6 +12,7 @@
 #include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
+#include <stdio.h>
 #include <vsprintf.h>
 
 char *display_options_get_banner_priv(bool newlines, const char *build_tag,
diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index 69cd3d7001f..4a52834b61a 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -11,7 +11,7 @@
 #include <malloc.h>
 #include <mtd.h>
 #include <uuid.h>
-#include <vsprintf.h>
+#include <stdio.h>
 
 #include <dm/ofnode.h>
 
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 33e3e6e5182..2bc508ff504 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -10,7 +10,7 @@
 
 #include <hexdump.h>
 #include <mapmem.h>
-#include <vsprintf.h>
+#include <stdio.h>
 #include <linux/ctype.h>
 #include <linux/compat.h>
 #include <linux/log2.h>
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 27ea9c907a3..cfd1f1914ed 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -19,6 +19,7 @@
 #include <hexdump.h>
 #include <stdarg.h>
 #include <uuid.h>
+#include <stdio.h>
 #include <vsprintf.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 69fc900e342..c9a03523184 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -18,7 +18,7 @@
 #include <scmi_agent.h>
 #include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
-#include <vsprintf.h>
+#include <stdio.h>
 #include <asm/scmi_test.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
diff --git a/test/print_ut.c b/test/print_ut.c
index bded2b6ebe5..53d3354ea69 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <version_string.h>
+#include <stdio.h>
 #include <vsprintf.h>
 #include <test/suites.h>
 #include <test/test.h>
-- 
2.25.1

