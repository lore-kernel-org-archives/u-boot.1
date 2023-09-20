Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CC0CE79CE
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A6A86B7A;
	Wed, 20 Sep 2023 14:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52CC86BC4; Wed, 20 Sep 2023 14:42:49 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9BF4C86A2F
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; d="scan'208";a="180389769"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Sep 2023 21:42:47 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.83])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8DC85433CFB5;
 Wed, 20 Sep 2023 21:42:44 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 05/16] arm: rmobile: Add basic RZ/G2L family support
Date: Wed, 20 Sep 2023 13:42:01 +0100
Message-Id: <20230920124212.63535-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
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

The Renesas RZ/G2L family includes the following ARM SoCs:

* RZ/G2L  (r9a07g044l)
* RZ/G2LC (r9a07g044c)
* RZ/G2UL (r9a07g043u)
* RZ/V2L  (r9a07g054l)

Support for individual SoCs and evaluation boards will be added in
separate patches.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-rmobile/Kconfig                | 13 +++++++++++++
 arch/arm/mach-rmobile/Kconfig.rzg2l          | 12 ++++++++++++
 arch/arm/mach-rmobile/include/mach/rmobile.h |  2 ++
 arch/arm/mach-rmobile/include/mach/rzg2l.h   | 13 +++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 arch/arm/mach-rmobile/Kconfig.rzg2l
 create mode 100644 arch/arm/mach-rmobile/include/mach/rzg2l.h

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index 3061ccd34c8b..fd240832d83d 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -66,6 +66,18 @@ config RZN1
 	select SYSRESET_SYSCON
 	imply CMD_DM
 
+config RZG2L
+	prompt "Renesas RZ/G2L Family ARM SoCs"
+	select RCAR_64
+	select GICV3
+	imply MULTI_DTB_FIT
+	imply MULTI_DTB_FIT_USER_DEFINED_AREA
+	imply SYS_MALLOC_F
+	imply RENESAS_SDHI
+	help
+	  Enable support for the Renesas RZ/G2L family of SoCs, including the
+	  the RZ/G2L itself (based on the R9A07G044 SoC).
+
 endchoice
 
 config SYS_SOC
@@ -75,5 +87,6 @@ source "arch/arm/mach-rmobile/Kconfig.32"
 source "arch/arm/mach-rmobile/Kconfig.64"
 source "arch/arm/mach-rmobile/Kconfig.rza1"
 source "arch/arm/mach-rmobile/Kconfig.rzn1"
+source "arch/arm/mach-rmobile/Kconfig.rzg2l"
 
 endif
diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
new file mode 100644
index 000000000000..37ff6cd34160
--- /dev/null
+++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
@@ -0,0 +1,12 @@
+# Copyright (C) 2023 Renesas Electronics Corporation
+# SPDX-License-Identifier: GPL-2.0+
+
+if RZG2L
+
+config MULTI_DTB_FIT_UNCOMPRESS_SZ
+	default 0x80000 if TARGET_RZG2L_SMARC_EVK
+
+config MULTI_DTB_FIT_USER_DEF_ADDR
+	default 0x49000000 if TARGET_RZG2L_SMARC_EVK
+
+endif
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index a14c2aad0a68..d326d5545a6f 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -19,6 +19,8 @@
 #elif defined(CONFIG_RCAR_GEN4)
 #include <asm/arch/rcar-gen4-base.h>
 #elif defined(CONFIG_R7S72100)
+#elif defined(CONFIG_RZG2L)
+#include <asm/arch/rzg2l.h>
 #else
 #error "SOC Name not defined"
 #endif
diff --git a/arch/arm/mach-rmobile/include/mach/rzg2l.h b/arch/arm/mach-rmobile/include/mach/rzg2l.h
new file mode 100644
index 000000000000..057df5cb9d46
--- /dev/null
+++ b/arch/arm/mach-rmobile/include/mach/rzg2l.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RZ/G2L SoC Family support.
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+
+#ifndef __ASM_ARCH_RZG2L_H
+#define __ASM_ARCH_RZG2L_H
+
+#define GICD_BASE	0x11900000
+#define GICR_BASE	0x11960000
+
+#endif /* __ASM_ARCH_RZG2L_H */
-- 
2.34.1

