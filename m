Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6F0E6ADE7
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 08:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE079893F2;
	Sat, 23 Nov 2024 09:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qsNXEYAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB8388E00; Sat, 23 Nov 2024 09:48:21 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14467891B4
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 09:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1ED6A3F785; 
 Sat, 23 Nov 2024 08:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732351697;
 bh=vw8aWai+WUVbBD9IhU/c5fGQml9BAlOb9l0lB4pss0g=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qsNXEYAxPYEhU2DdEVcn64UE/nuTWVrje2tIenVLngafHz443eTnjXv9/ZH+aLNuJ
 fFT/KyIXp2A1c+aOMs2bbGj/HXq9hHZIOAkgyE2963d1hJmKWM5A8I2uCJ1sbff952
 6waVBC1hviAhRhnUg8ozKfB6fQz+oVRHYtJsHnuae+02e4QnbfPP/6lq/SVhrNC05R
 GqUi48qCOIwyhwGcFd0kKgZX+ZmBZUHmzay17etxJCei1UlqLkIl5ylue4h2tq02P1
 1VGdJ3SUbKKfkQsUwpJdZLZHWTcIrS3igNuAic+yaqoaly3EuISmaoed/R/LfgCYLv
 K5FHbGhc36zSQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] API: unify platform_sys_info() implementations
Date: Sat, 23 Nov 2024 09:47:51 +0100
Message-ID: <20241123084754.59182-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
References: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
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

ARM, MIPS, and RISCV can use the same implementation of
platform_sys_info(). PPC provides some extra information.
So keep it separate.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 api/Makefile            |  9 ++++++---
 api/api_platform-arm.c  | 35 -----------------------------------
 api/api_platform-mips.c | 29 -----------------------------
 api/api_platform.c      | 25 +++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 67 deletions(-)
 delete mode 100644 api/api_platform-arm.c
 delete mode 100644 api/api_platform-mips.c
 create mode 100644 api/api_platform.c

diff --git a/api/Makefile b/api/Makefile
index bd2d035fcdb..ce3de6b6a1c 100644
--- a/api/Makefile
+++ b/api/Makefile
@@ -1,8 +1,11 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # (C) Copyright 2007 Semihalf
 
 obj-y += api.o api_display.o api_net.o api_storage.o
-obj-$(CONFIG_ARM) += api_platform-arm.o
+
+ifeq (CONFIG_PPC,y)
 obj-$(CONFIG_PPC) += api_platform-powerpc.o
-obj-$(CONFIG_MIPS) += api_platform-mips.o
+else
+obj-y += api_platform.o
+endif
diff --git a/api/api_platform-arm.c b/api/api_platform-arm.c
deleted file mode 100644
index 9afba66c244..00000000000
--- a/api/api_platform-arm.c
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2007 Semihalf
- *
- * Written by: Rafal Jaworowski <raj@semihalf.com>
- *
- * This file contains routines that fetch data from ARM-dependent sources
- * (bd_info etc.)
- */
-
-#include <config.h>
-#include <linux/types.h>
-#include <api_public.h>
-
-#include <asm/global_data.h>
-
-#include "api_private.h"
-
-DECLARE_GLOBAL_DATA_PTR;
-
-/*
- * Important notice: handling of individual fields MUST be kept in sync with
- * include/asm-arm/u-boot.h and include/asm-arm/global_data.h, so any changes
- * need to reflect their current state and layout of structures involved!
- */
-int platform_sys_info(struct sys_info *si)
-{
-	int i;
-
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
-		platform_set_mr(si, gd->bd->bi_dram[i].start,
-				gd->bd->bi_dram[i].size, MR_ATTR_DRAM);
-
-	return 1;
-}
diff --git a/api/api_platform-mips.c b/api/api_platform-mips.c
deleted file mode 100644
index 262b35a2777..00000000000
--- a/api/api_platform-mips.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2007 Stanislav Galabov <sgalabov@gmail.com>
- *
- * This file contains routines that fetch data from bd_info sources
- */
-
-#include <config.h>
-#include <linux/types.h>
-#include <api_public.h>
-
-#include <asm/global_data.h>
-
-#include "api_private.h"
-
-DECLARE_GLOBAL_DATA_PTR;
-
-/*
- * Important notice: handling of individual fields MUST be kept in sync with
- * include/asm-generic/u-boot.h, so any changes
- * need to reflect their current state and layout of structures involved!
- */
-int platform_sys_info(struct sys_info *si)
-{
-
-	platform_set_mr(si, gd->ram_base, gd->ram_size, MR_ATTR_DRAM);
-
-	return 1;
-}
diff --git a/api/api_platform.c b/api/api_platform.c
new file mode 100644
index 00000000000..7a789bd2016
--- /dev/null
+++ b/api/api_platform.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2007 Semihalf
+ *
+ * Written by: Rafal Jaworowski <raj@semihalf.com>
+ *
+ * This file contains a routine to fetch data from the global_data structure.
+ */
+
+#include <api_public.h>
+#include <asm/global_data.h>
+#include "api_private.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int platform_sys_info(struct sys_info *si)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
+		platform_set_mr(si, gd->bd->bi_dram[i].start,
+				gd->bd->bi_dram[i].size, MR_ATTR_DRAM);
+
+	return 1;
+}
-- 
2.45.2

