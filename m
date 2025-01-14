Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC43C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380F580702;
	Tue, 14 Jan 2025 18:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="H965dZ3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7EC18022E; Tue, 14 Jan 2025 17:47:25 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F1A806D4
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736873240; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bKFTD9DywbIkHJtDzY3RqcIAZ/48ZhqJNN2JIrzAnNLMV3dCOK4XYNG2tJooo5KsOaoD5cnc65mF7st9xtSl6jPOKA4OW5x0o+2ubbF/eDbXXDFaDjNrLAIQWpBDnd0lmbnIswlY4KQ72bMHcaDf96iaPIlVu/T2CgU/I0gdwVY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736873240;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w0eLilH1o15EIC6Md4coNE+MOVIdB6rPveJDerf4k8o=; 
 b=F+SqJK9zXnfnouXnEKiIN8fSjLAxu4GC/pvd/j8Pu/GUIn7IQowk0zTLkXnCoHmZxbrIgrPHiYlt9eMEk1bUzVPYAGubmV+nxyKV0lUlUv3QAmfuKqROob5YrcGc/NrRnm5LXntLTq0pZm0HrKd48PuSsckIbeaTkqwcL675Zac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736873240; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=w0eLilH1o15EIC6Md4coNE+MOVIdB6rPveJDerf4k8o=;
 b=H965dZ3i2MMzJxDGj7mJpuu0JmrFixkPR1o31geuX9wF1VNemd6KzEDdr9oJcBAT
 R2w0Xoyei/G+uOfCaN2OFRSs0mhvhNq5mHTBGgyUz7449/isKaBT78i8sL6BIMbL24N
 Jc+u6H9IZR19UevG4vHqLsMv4BqAj2pVJOcoqHMc=
Received: by mx.zohomail.com with SMTPS id 1736873238132883.2298651182327;
 Tue, 14 Jan 2025 08:47:18 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 15 Jan 2025 00:46:39 +0800
Subject: [PATCH 3/5] riscv: cpu: k230: Add support for Canaan Kendryte K230 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-k230-dev-1-v1-3-f4b77259e34a@pigmoral.tech>
References: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
In-Reply-To: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736873211; l=3496;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=5+KIIxHAs4UxYpVGgiEqOPpxeBLnhf42/P0djQVEI1E=;
 b=2myBBsPxT6QykCCJu7ZP2XuyzOYzh/pxfoQMEnDa5gweR1kUt96eyxVpEnATaNTIyW41GzvfF
 5KgV8m4QOdmCBlWIh9Q4iTV3Rl0Sh3/dFqKhM2nAdHX8LHskeyE/mdx
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 14 Jan 2025 18:26:11 +0100
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

Add Canaan K230 SoC with sysreset support, running without cache
enabled.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/Kconfig           |  5 +++++
 arch/riscv/cpu/k230/Kconfig  | 14 ++++++++++++++
 arch/riscv/cpu/k230/Makefile |  6 ++++++
 arch/riscv/cpu/k230/cpu.c    |  9 +++++++++
 arch/riscv/cpu/k230/dram.c   | 21 +++++++++++++++++++++
 5 files changed, 55 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a160d24fb033eafeee70971a1bff12b545d23a2e..faf70cb5d4c7987b40f46234a26276bc10d270bb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,9 @@ config TARGET_ANDES_AE350
 config TARGET_BANANAPI_F3
 	bool "Support BananaPi F3 Board"
 
+config TARGET_K230_CANMV
+	bool "Support K230 CanMV Board"
+
 config TARGET_LICHEERV_NANO
 	bool "Support LicheeRV Nano Board"
 
@@ -91,6 +94,7 @@ config SPL_ZERO_MEM_BEFORE_USE
 # board-specific options below
 source "board/andestech/ae350/Kconfig"
 source "board/aspeed/ibex_ast2700/Kconfig"
+source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
 source "board/microchip/mpfs_icicle/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
@@ -113,6 +117,7 @@ source "arch/riscv/cpu/ast2700/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
 source "arch/riscv/cpu/k1/Kconfig"
+source "arch/riscv/cpu/k230/Kconfig"
 
 # architecture-specific options below
 
diff --git a/arch/riscv/cpu/k230/Kconfig b/arch/riscv/cpu/k230/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..d76ad92a04908f1be3002ce95f13637ce9e96722
--- /dev/null
+++ b/arch/riscv/cpu/k230/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
+
+config CANAAN_K230
+	bool
+	select ARCH_EARLY_INIT_R
+	select BINMAN
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER
+	imply CMD_CPU
+	imply SYSRESET
+	imply SYSRESET_SYSCON
diff --git a/arch/riscv/cpu/k230/Makefile b/arch/riscv/cpu/k230/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..6e321cf3ed19525656efa2c58270e7a9800c9002
--- /dev/null
+++ b/arch/riscv/cpu/k230/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
+
+obj-y += dram.o
+obj-y += cpu.o
diff --git a/arch/riscv/cpu/k230/cpu.c b/arch/riscv/cpu/k230/cpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..417a25f0a8ba33e3ed288860a27c64a4a584cc6b
--- /dev/null
+++ b/arch/riscv/cpu/k230/cpu.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+int cleanup_before_linux(void)
+{
+	return 0;
+}
diff --git a/arch/riscv/cpu/k230/dram.c b/arch/riscv/cpu/k230/dram.c
new file mode 100644
index 0000000000000000000000000000000000000000..b2d3e4fd6a96d7fc6ca8b8507f4eba85f7e9c9b5
--- /dev/null
+++ b/arch/riscv/cpu/k230/dram.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <asm/global_data.h>
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}

-- 
2.47.1

