Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDA5C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 17:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D803087DA8;
	Fri, 19 Jan 2024 18:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="daa+o1JG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3DF687DAB; Fri, 19 Jan 2024 18:52:02 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4048E87DA7
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 18:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JHpqa1061155;
 Fri, 19 Jan 2024 11:51:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705686712;
 bh=fUUH1EiUzva1TWigrs1TY90N2d8emZbzqRiHdrktfPs=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=daa+o1JGX/sZMn9w/QCTqm14eXNFgCaS1WJMIaT/UyaHply0SGwCPYwua0Cqczt3a
 Wa8LObmJ5sg3Qz0LlrogvO97Pc3vhDoAb1HF3ypNyI6xLuwKWLlc+NoMhxJmWbQX9T
 9zVUzQ+1ePehkTGqfqqHi0xtlbRcwAvIOL+9Bi+c=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JHpqmm100134
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jan 2024 11:51:52 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 11:51:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 11:51:51 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JHoiDV054787; 
 Fri, 19 Jan 2024 11:51:45 -0600
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
Subject: [PATCH v8 09/16] board: ti: j784s4: Add board support for J784S4 EVM
Date: Fri, 19 Jan 2024 23:20:36 +0530
Message-ID: <20240119175043.3904751-10-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119175043.3904751-1-a-nandan@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
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

SYS_DISABLE_DCACHE_OPS is selected in the Kconfig because
J784S4/AM69 are a coherent architecture at A72 level by
MSMC support.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
[ add env and board specific yaml files for binman ]
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
[ cleaned up the env files ]
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-k3/Kconfig        |  1 +
 arch/arm/mach-k3/j784s4/Kconfig | 34 ++++++++++++++++++++++++++
 board/ti/j784s4/Kconfig         | 37 ++++++++++++++++++++++++++++
 board/ti/j784s4/MAINTAINERS     | 14 +++++++++++
 board/ti/j784s4/Makefile        |  7 ++++++
 board/ti/j784s4/evm.c           | 43 +++++++++++++++++++++++++++++++++
 include/configs/j784s4_evm.h    | 15 ++++++++++++
 7 files changed, 151 insertions(+)
 create mode 100644 arch/arm/mach-k3/j784s4/Kconfig
 create mode 100644 board/ti/j784s4/Kconfig
 create mode 100644 board/ti/j784s4/MAINTAINERS
 create mode 100644 board/ti/j784s4/Makefile
 create mode 100644 board/ti/j784s4/evm.c
 create mode 100644 include/configs/j784s4_evm.h

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 217def3bb4..fdde67c2d3 100644
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
index 0000000000..1eadfb346a
--- /dev/null
+++ b/arch/arm/mach-k3/j784s4/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
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
diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
new file mode 100644
index 0000000000..490c7be66b
--- /dev/null
+++ b/board/ti/j784s4/Kconfig
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
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
diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
new file mode 100644
index 0000000000..9e0df11503
--- /dev/null
+++ b/board/ti/j784s4/MAINTAINERS
@@ -0,0 +1,14 @@
+J784S4 EVM BOARD
+M:	Apurva Nandan <a-nandan@ti.com>
+S:	Maintained
+F:	board/ti/j784s4
+F:	arch/arm/mach-k3/j784s4
+F:	include/configs/j784s4_evm.h
+F:	arch/arm/dts/k3-j784s4.dtsi
+F:	arch/arm/dts/k3-j784s4-main.dtsi
+F:	arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
+F:	arch/arm/dts/k3-j784s4-thermal.dtsi
+F:	arch/arm/dts/k3-j784s4-evm.dts
+
+AM69 SK BOARD
+F:	arch/arm/dts/k3-am69-sk.dts
diff --git a/board/ti/j784s4/Makefile b/board/ti/j784s4/Makefile
new file mode 100644
index 0000000000..60161a8b5c
--- /dev/null
+++ b/board/ti/j784s4/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Hari Nagalla <hnagalla@ti.com>
+#
+
+obj-y += evm.o
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
new file mode 100644
index 0000000000..5af3e21ff0
--- /dev/null
+++ b/board/ti/j784s4/evm.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Board specific initialization for J784S4 EVM
+ *
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
+ *
+ */
+
+#include <image.h>
+#include <init.h>
+#include <spl.h>
+#include <stdlib.h>
+#include "../common/fdt_ops.h"
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
+#ifdef CONFIG_BOARD_LATE_INIT
+int board_late_init(void)
+{
+	ti_set_fdt_env(NULL, NULL);
+	return 0;
+}
+#endif
+
+void spl_board_init(void)
+{
+}
diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
new file mode 100644
index 0000000000..4a2ccdce14
--- /dev/null
+++ b/include/configs/j784s4_evm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Configuration header file for K3 J784S4 EVM
+ *
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
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

