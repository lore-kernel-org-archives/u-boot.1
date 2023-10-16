Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD45BCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F8686F5A;
	Mon, 16 Oct 2023 11:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4610786F37; Mon, 16 Oct 2023 11:26:23 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id D77C286DD5
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,229,1694703600"; d="scan'208";a="179418351"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 18:26:11 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.82])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id DB04841F9DEF;
 Mon, 16 Oct 2023 18:26:08 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 05/21] arm: rmobile: Add basic RZ/G2L family support
Date: Mon, 16 Oct 2023 10:25:27 +0100
Message-Id: <20231016092543.3833-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
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
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v2->v3: No changes.
v1->v2:
  * Sorted select/imply statements under config RZG2L.
  * Expanded help message for config RZG2L.
  * Added Marek's Reviewed-by.

 arch/arm/mach-rmobile/Kconfig                | 15 +++++++++++++++
 arch/arm/mach-rmobile/Kconfig.rzg2l          | 12 ++++++++++++
 arch/arm/mach-rmobile/include/mach/rmobile.h |  2 ++
 arch/arm/mach-rmobile/include/mach/rzg2l.h   | 13 +++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 arch/arm/mach-rmobile/Kconfig.rzg2l
 create mode 100644 arch/arm/mach-rmobile/include/mach/rzg2l.h

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index 3061ccd34c8b..1d8d26d8367f 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -66,6 +66,20 @@ config RZN1
 	select SYSRESET_SYSCON
 	imply CMD_DM
 
+config RZG2L
+	prompt "Renesas RZ/G2L Family ARM SoCs"
+	select GICV3
+	select RCAR_64
+	imply MULTI_DTB_FIT
+	imply MULTI_DTB_FIT_USER_DEFINED_AREA
+	imply RENESAS_SDHI
+	imply SYS_MALLOC_F
+	help
+	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
+	  support is only included for the RZ/G2L itself (based on the R9A07G044
+	  SoC). Support for additional SoCs in this family (RZ/G2LC, RZ/G2UL,
+	  RZ/V2L & RZ/Five) is not yet available.
+
 endchoice
 
 config SYS_SOC
@@ -75,5 +89,6 @@ source "arch/arm/mach-rmobile/Kconfig.32"
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
2.39.2

