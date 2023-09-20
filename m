Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634D0CE79CE
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700C286C10;
	Wed, 20 Sep 2023 14:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B601486C08; Wed, 20 Sep 2023 14:43:16 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 6A77086BEC
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; d="scan'208";a="176658379"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Sep 2023 21:43:13 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.83])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9DC14433CFB5;
 Wed, 20 Sep 2023 21:43:10 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 13/16] arm: rmobile: Add CPU detection for RZ/G2L
Date: Wed, 20 Sep 2023 13:42:09 +0100
Message-Id: <20230920124212.63535-14-paul.barker.ct@bp.renesas.com>
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

The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
devicetree blob to the bootloader as an argument in the same was
previous R-Car gen3/gen4 SoCs. This blob contains a compatible string
which can be used to identify the particular SoC we are running on.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-rmobile/Makefile               |  5 +-
 arch/arm/mach-rmobile/cpu_info-rzg2l.c       | 63 ++++++++++++++++++++
 arch/arm/mach-rmobile/include/mach/rmobile.h |  1 +
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-rmobile/cpu_info-rzg2l.c

diff --git a/arch/arm/mach-rmobile/Makefile b/arch/arm/mach-rmobile/Makefile
index 4eddba53ed2a..45d6a0e2a28a 100644
--- a/arch/arm/mach-rmobile/Makefile
+++ b/arch/arm/mach-rmobile/Makefile
@@ -10,8 +10,11 @@ obj-$(CONFIG_DISPLAY_BOARDINFO) += board.o
 obj-$(CONFIG_TMU_TIMER) += ../../sh/lib/time.o
 obj-$(CONFIG_R8A7740) += lowlevel_init.o cpu_info-r8a7740.o pfc-r8a7740.o
 obj-$(CONFIG_RCAR_GEN2) += lowlevel_init_ca15.o cpu_info-rcar.o
-obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o cpu_info-rcar.o memmap-gen3.o
+obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o memmap-gen3.o
+obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o
+obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o
 obj-$(CONFIG_RZ_G2) += cpu_info-rzg.o
+obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o
 
 ifneq ($(CONFIG_R8A779A0),)
 obj-$(CONFIG_ARMV8_PSCI) += psci-r8a779a0.o
diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
new file mode 100644
index 000000000000..de4892ee901e
--- /dev/null
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021,2023 Renesas Electronics Corporation
+ *
+ */
+
+#include <common.h>
+#include <asm/io.h>
+#include <linux/libfdt.h>
+
+#define SYSC_LSI_DEVID		0x11020A04
+
+/* If the firmware passed a device tree, use it for soc identification. */
+extern u64 rcar_atf_boot_args[];
+
+/* CPU information table */
+struct tfa_info {
+	const char *soc_name;
+	const char *cpu_name;
+	u32 cpu_type;
+};
+
+static const struct tfa_info tfa_info[] = {
+	{ "renesas,r9a07g044l2", "R9A07G044L", RMOBILE_CPU_TYPE_R9A07G044L },
+};
+
+static const struct tfa_info invalid_tfa_info = { NULL, "(invalid)", 0 };
+
+static const struct tfa_info *get_tfa_info(void)
+{
+	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
+
+	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC) {
+		unsigned int i;
+		for (i = 0; i < ARRAY_SIZE(tfa_info); i++) {
+			if (!fdt_node_check_compatible(atf_fdt_blob, 0,
+						       tfa_info[i].soc_name))
+				return &tfa_info[i];
+		}
+	}
+
+	return &invalid_tfa_info;
+}
+
+const u8 *rzg_get_cpu_name(void)
+{
+	return get_tfa_info()->cpu_name;
+}
+
+u32 rmobile_get_cpu_type(void)
+{
+	return get_tfa_info()->cpu_type;
+}
+
+u32 rmobile_get_cpu_rev_integer(void)
+{
+	return (readl(SYSC_LSI_DEVID) >> 28) + 1;
+}
+
+u32 rmobile_get_cpu_rev_fraction(void)
+{
+	return 0;
+}
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index 053ad08add00..88b8b78671b2 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -43,6 +43,7 @@
 #define RMOBILE_CPU_TYPE_R8A779A0	0x59
 #define RMOBILE_CPU_TYPE_R8A779F0	0x5A
 #define RMOBILE_CPU_TYPE_R8A779G0	0x5C
+#define RMOBILE_CPU_TYPE_R9A07G044L	0x9A070440
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
-- 
2.34.1

