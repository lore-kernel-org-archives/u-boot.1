Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD46C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287B287775;
	Wed,  6 Dec 2023 13:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xZvxL42q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B1BD876F7; Wed,  6 Dec 2023 13:39:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B344878A2
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6CcsVN088138;
 Wed, 6 Dec 2023 06:38:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701866334;
 bh=j7Au/W+0p47jH8nrWP9mzg9QcNtCsShapTIv2TNvRe8=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=xZvxL42qOVPrSaLhAqGhy0pXivqIhEoQsTZFnHmWKOK18SOUQovE3fAb8KnwfN4r3
 TjAsZNlqjpXZHbAHt2hOvZ2HzkQC8Q97LZYm1e4tm8DZqedIrK0vap+nTDaw9RU0sB
 yga0LPtrAbxig0hbQCIZHUNeacOk12Ip/X/7Rrus=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6CcsTf041717
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 06:38:54 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 06:38:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 06:38:53 -0600
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Cbrqj096939;
 Wed, 6 Dec 2023 06:38:47 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v6 08/17] board: ti: j784s4: Add board support for J784S4 EVM
Date: Wed, 6 Dec 2023 18:07:44 +0530
Message-ID: <20231206123753.1486031-9-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add board files for J784S4 EVM.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
[ add env and board specific yaml files for binman ]
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
[ cleaned up the env files ]
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/mach-k3/Kconfig        |  1 +
 arch/arm/mach-k3/j784s4/Kconfig | 35 ++++++++++++++++++++++++++++++
 board/ti/j784s4/Kconfig         | 37 ++++++++++++++++++++++++++++++++
 board/ti/j784s4/Makefile        |  7 ++++++
 board/ti/j784s4/evm.c           | 38 +++++++++++++++++++++++++++++++++
 include/configs/j784s4_evm.h    | 15 +++++++++++++
 6 files changed, 133 insertions(+)
 create mode 100644 arch/arm/mach-k3/j784s4/Kconfig
 create mode 100644 board/ti/j784s4/Kconfig
 create mode 100644 board/ti/j784s4/Makefile
 create mode 100644 board/ti/j784s4/evm.c
 create mode 100644 include/configs/j784s4_evm.h

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 150d0bfa14..445b49e245 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -157,5 +157,6 @@ source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "arch/arm/mach-k3/j721s2/Kconfig"
+source "arch/arm/mach-k3/j784s4/Kconfig"
 
 endif
diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
new file mode 100644
index 0000000000..03d3f91371
--- /dev/null
+++ b/arch/arm/mach-k3/j784s4/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Hari Nagalla <hnagalla@ti.com>
+
+if SOC_K3_J784S4
+
+choice
+	prompt "K3 J784S4 board"
+	optional
+
+config TARGET_J784S4_A72_EVM
+	bool "TI K3 based J784S4 EVM running on A72"
+	select ARM64
+	select BOARD_LATE_INIT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J784S4_R5_EVM
+	bool "TI K3 based J784S4 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
+endchoice
+
+source "board/ti/j784s4/Kconfig"
+
+endif
+
diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
new file mode 100644
index 0000000000..33d4770b2d
--- /dev/null
+++ b/board/ti/j784s4/Kconfig
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Hari Nagalla <hnagalla@ti.com>
+
+if TARGET_J784S4_A72_EVM
+
+config SYS_BOARD
+       default "j784s4"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j784s4_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_J784S4_R5_EVM
+
+config SYS_BOARD
+       default "j784s4"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j784s4_evm"
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/j784s4/Makefile b/board/ti/j784s4/Makefile
new file mode 100644
index 0000000000..3fc70eb8fb
--- /dev/null
+++ b/board/ti/j784s4/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Hari Nagalla <hnagalla@ti.com>
+#
+
+obj-y += evm.o
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
new file mode 100644
index 0000000000..4857c9d2f6
--- /dev/null
+++ b/board/ti/j784s4/evm.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Board specific initialization for J784S4 EVM
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
+ *
+ */
+
+#include <image.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	return 0;
+}
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
+
+int board_late_init(void)
+{
+	return 0;
+}
+
+void spl_board_init(void)
+{
+}
diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
new file mode 100644
index 0000000000..a4e0521198
--- /dev/null
+++ b/include/configs/j784s4_evm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Configuration header file for K3 J784S4 EVM
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
+ */
+
+#ifndef __CONFIG_J784S4_EVM_H
+#define __CONFIG_J784S4_EVM_H
+
+/* Now for the remaining common defines */
+#include <configs/ti_armv7_common.h>
+
+#endif /* __CONFIG_J784S4_EVM_H */
-- 
2.34.1

