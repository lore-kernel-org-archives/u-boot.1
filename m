Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675AEC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5327787C92;
	Fri, 23 Feb 2024 21:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BaLQnW+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDCD986EEC; Fri, 23 Feb 2024 19:53:08 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F92287BF0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 19:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NIqg57099136;
 Fri, 23 Feb 2024 12:52:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708714362;
 bh=nLeIZSnolMBvm8iX+8oJYJvRBsdy6ClLEukJf4YnJmI=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=BaLQnW+qyPltdG1yIy5H2MaJHlWqY9Zeguy9w4rMfjopqrF41T+uQeVfN0nnZXyup
 3YWFw9jcXp0U99oYNTG+deF4eHsuUq90ZWIOjXptCAfWWyJNN6tVOUWAhFg0YdgThQ
 Ze5CGAG39csF0SE8XXruhnM8efa4BTtl1Bh6FzEA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NIqgHE077402
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 12:52:42 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 12:52:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 12:52:42 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NIpvhk051632; 
 Fri, 23 Feb 2024 12:52:31 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Lukasz
 Majewski" <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek
 <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tianling Shen
 <cnsztl@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Roger Quadros <rogerq@kernel.org>,
 "Aradhya Bhatia" <a-bhatia1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Bhavya Kapoor <b-kapoor@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>, Udit
 Kumar <u-kumar1@ti.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Jason
 Kacines <j-kacines@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, Andre
 Przywara <andre.przywara@arm.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v9 03/15] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Date: Sat, 24 Feb 2024 00:21:44 +0530
Message-ID: <20240223185156.3065032-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223185156.3065032-1-a-nandan@ti.com>
References: <20240223185156.3065032-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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

Add J784S4 initialization files for initial SPL boot.

config SYS_K3_MCU_SCRATCHPAD_BASE default value is same
for J721E, J721S2, J784S4. So combined them into a single
default.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
[ add firewall configurations and change the R5 MCU scratchpad ]
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/Kconfig                      |  16 +-
 arch/arm/mach-k3/Makefile                     |   2 +
 arch/arm/mach-k3/include/mach/hardware.h      |   4 +
 .../mach-k3/include/mach/j784s4_hardware.h    |  59 ++++
 arch/arm/mach-k3/include/mach/j784s4_spl.h    |  47 +++
 arch/arm/mach-k3/include/mach/spl.h           |   4 +
 arch/arm/mach-k3/j784s4_fdt.c                 |  15 +
 arch/arm/mach-k3/j784s4_init.c                | 310 ++++++++++++++++++
 arch/arm/mach-k3/r5/Makefile                  |   1 +
 drivers/ram/Kconfig                           |   2 +-
 10 files changed, 452 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
 create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
 create mode 100644 arch/arm/mach-k3/j784s4_init.c

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index f0ed5c61282..217def3bb46 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -22,6 +22,9 @@ config SOC_K3_J721E
 config SOC_K3_J721S2
 	bool "TI's K3 based J721S2 SoC Family Support"
 
+config SOC_K3_J784S4
+	bool "TI's K3 based J784S4 SoC Family Support"
+
 endchoice
 
 if SOC_K3_J721E
@@ -35,7 +38,7 @@ config SYS_SOC
 config SYS_K3_NON_SECURE_MSRAM_SIZE
 	hex
 	default 0x80000 if SOC_K3_AM654
-	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2
+	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x1c0000 if SOC_K3_AM642
 	default 0x3c000 if SOC_K3_AM625 || SOC_K3_AM62A7
 	help
@@ -47,7 +50,7 @@ config SYS_K3_NON_SECURE_MSRAM_SIZE
 config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
 	hex
 	default 0x58000 if SOC_K3_AM654
-	default 0xc0000 if SOC_K3_J721E || SOC_K3_J721S2
+	default 0xc0000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x180000 if SOC_K3_AM642
 	default 0x38000 if SOC_K3_AM625 || SOC_K3_AM62A7
 	help
@@ -57,15 +60,14 @@ config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
 config SYS_K3_MCU_SCRATCHPAD_BASE
 	hex
 	default 0x40280000 if SOC_K3_AM654
-	default 0x41cff9fc if SOC_K3_J721S2
-	default 0x41cff9fc if SOC_K3_J721E
+	default 0x41cff9fc if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	help
 	  Describes the base address of MCU Scratchpad RAM.
 
 config SYS_K3_MCU_SCRATCHPAD_SIZE
 	hex
 	default 0x200 if SOC_K3_AM654
-	default 0x200 if SOC_K3_J721E || SOC_K3_J721S2
+	default 0x200 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	help
 	  Describes the size of MCU Scratchpad RAM.
 
@@ -73,7 +75,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	hex
 	default 0x41c7fbfc if SOC_K3_AM654
 	default 0x41cffbfc if SOC_K3_J721E
-	default 0x41cfdbfc if SOC_K3_J721S2
+	default 0x41cfdbfc if SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x701bebfc if SOC_K3_AM642
 	default 0x43c3f290 if SOC_K3_AM625
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
@@ -130,7 +132,7 @@ config K3_ATF_LOAD_ADDR
 
 config K3_DM_FW
 	bool "Separate DM firmware image"
-	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
+	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_J784S4) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
 	default y
 	help
 	  Enabling this will indicate that the system has separate DM
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 42161376469..945698e6e86 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SOC_K3_AM654) += am654_fdt.o
 obj-$(CONFIG_SOC_K3_J721E) += j721e_fdt.o
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2_fdt.o
 obj-$(CONFIG_SOC_K3_AM625) += am625_fdt.o
+obj-$(CONFIG_SOC_K3_J784S4) += j784s4_fdt.o
 endif
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_SOC_K3_AM654) += am654_init.o
@@ -20,5 +21,6 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
 obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
 obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
+obj-$(CONFIG_SOC_K3_J784S4) += j784s4_init.o
 endif
 obj-y += common.o security.o
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index a1a9dfbde66..0cf1e12aaac 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -33,6 +33,10 @@
 #include "am62a_qos.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_J784S4
+#include "j784s4_hardware.h"
+#endif
+
 /* Assuming these addresses and definitions stay common across K3 devices */
 #define CTRLMMR_WKUP_JTAG_ID	(WKUP_CTRL_MMR0_BASE + 0x14)
 #define JTAG_ID_VARIANT_SHIFT	28
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
new file mode 100644
index 00000000000..0ffe238cdae
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * K3: J784S4 SoC definitions, structures etc.
+ *
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+#ifndef __ASM_ARCH_J784S4_HARDWARE_H
+#define __ASM_ARCH_J784S4_HARDWARE_H
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+#define WKUP_CTRL_MMR0_BASE				0x43000000
+#define MCU_CTRL_MMR0_BASE				0x40f00000
+#define CTRL_MMR0_BASE					0x00100000
+
+#define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
+#define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
+#define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
+#define MAIN_DEVSTAT_BKUP_BOOTMODE_MASK			GENMASK(3, 1)
+#define MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT		1
+#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK	BIT(6)
+#define MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT		6
+#define MAIN_DEVSTAT_BKUP_MMC_PORT_MASK			BIT(7)
+#define MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT		7
+
+#define CTRLMMR_WKUP_DEVSTAT				(WKUP_CTRL_MMR0_BASE + 0x30)
+#define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK		GENMASK(5, 3)
+#define WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT		3
+#define WKUP_DEVSTAT_MCU_ONLY_MASK			BIT(6)
+#define WKUP_DEVSTAT_MCU_ONLY_SHIFT			6
+
+/* ROM HANDOFF Structure location */
+#define ROM_EXTENDED_BOOT_DATA_INFO			0x41cfdb00
+
+/* MCU SCRATCHPAD usage */
+#define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
+
+#if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
+
+#define J784S4_DEV_MCU_RTI0			367
+#define J784S4_DEV_MCU_RTI1			368
+#define J784S4_DEV_MCU_ARMSS0_CPU0		346
+#define J784S4_DEV_MCU_ARMSS0_CPU1		347
+
+static const u32 put_device_ids[] = {
+	J784S4_DEV_MCU_RTI0,
+	J784S4_DEV_MCU_RTI1,
+};
+
+static const u32 put_core_ids[] = {
+	J784S4_DEV_MCU_ARMSS0_CPU1,
+	J784S4_DEV_MCU_ARMSS0_CPU0,     /* Handle CPU0 after CPU1 */
+};
+
+#endif
+
+#endif /* __ASM_ARCH_J784S4_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/j784s4_spl.h b/arch/arm/mach-k3/include/mach/j784s4_spl.h
new file mode 100644
index 00000000000..d481a46c675
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/j784s4_spl.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef _ASM_ARCH_J784S4_SPL_H_
+#define _ASM_ARCH_J784S4_SPL_H_
+
+/* With BootMode B = 0 */
+#include <linux/bitops.h>
+
+#define BOOT_DEVICE_HYPERFLASH		0x00
+#define BOOT_DEVICE_OSPI		0x01
+#define BOOT_DEVICE_QSPI		0x02
+#define BOOT_DEVICE_SPI			0x03
+#define BOOT_DEVICE_ETHERNET		0x04
+#define BOOT_DEVICE_I2C			0x06
+#define BOOT_DEVICE_UART		0x07
+#define BOOT_DEVICE_NOR			BOOT_DEVICE_HYPERFLASH
+
+/* With BootMode B = 1 */
+#define BOOT_DEVICE_MMC2		0x10
+#define BOOT_DEVICE_MMC1		0x11
+#define BOOT_DEVICE_DFU			0x12
+#define BOOT_DEVICE_UFS			0x13
+#define BOOT_DEVIE_GPMC			0x14
+#define BOOT_DEVICE_PCIE		0x15
+#define BOOT_DEVICE_XSPI		0x16
+#define BOOT_DEVICE_RAM			0x17
+#define BOOT_DEVICE_MMC2_2		0xFF /* Invalid value */
+
+/* Backup boot modes with MCU Only = 0 */
+#define BACKUP_BOOT_DEVICE_RAM		0x0
+#define BACKUP_BOOT_DEVICE_USB		0x1
+#define BACKUP_BOOT_DEVICE_UART		0x3
+#define BACKUP_BOOT_DEVICE_ETHERNET	0x4
+#define BACKUP_BOOT_DEVICE_MMC2		0x5
+#define BACKUP_BOOT_DEVICE_SPI		0x6
+#define BACKUP_BOOT_DEVICE_I2C		0x7
+
+#define BOOT_MODE_B_SHIFT		4
+#define BOOT_MODE_B_MASK		BIT(4)
+
+#define K3_PRIMARY_BOOTMODE		0x0
+#define K3_BACKUP_BOOTMODE		0x1
+
+#endif
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index 3ddc7eb6b63..6f01ab58e27 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -30,4 +30,8 @@
 #include "am62a_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_J784S4
+#include "j784s4_spl.h"
+#endif
+
 #endif /* _ASM_ARCH_SPL_H_ */
diff --git a/arch/arm/mach-k3/j784s4_fdt.c b/arch/arm/mach-k3/j784s4_fdt.c
new file mode 100644
index 00000000000..d05ed8b9911
--- /dev/null
+++ b/arch/arm/mach-k3/j784s4_fdt.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * J784S4: SoC specific initialization
+ *
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *	Apurva Nandan <a-nandan@ti.com>
+ */
+
+#include "common_fdt.h"
+#include <fdt_support.h>
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return fdt_fixup_msmc_ram_k3(blob);
+}
diff --git a/arch/arm/mach-k3/j784s4_init.c b/arch/arm/mach-k3/j784s4_init.c
new file mode 100644
index 00000000000..ae4420362d0
--- /dev/null
+++ b/arch/arm/mach-k3/j784s4_init.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * J784S4: SoC specific initialization
+ *
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
+ */
+
+#include <init.h>
+#include <spl.h>
+#include <asm/io.h>
+#include <asm/armv7_mpu.h>
+#include <asm/arch/hardware.h>
+#include "sysfw-loader.h"
+#include "common.h"
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <dm/pinctrl.h>
+#include <mmc.h>
+#include <remoteproc.h>
+
+#define J784S4_MAX_DDR_CONTROLLERS	4
+
+struct fwl_data infra_cbass0_fwls[] = {
+	{ "PSC0", 5, 1 },
+	{ "PLL_CTRL0", 6, 1 },
+	{ "PLL_MMR0", 8, 26 },
+	{ "CTRL_MMR0", 9, 16 },
+	{ "GPIO0", 16, 1 },
+}, wkup_cbass0_fwls[] = {
+	{ "WKUP_PSC0", 129, 1 },
+	{ "WKUP_PLL_CTRL0", 130, 1 },
+	{ "WKUP_CTRL_MMR0", 131, 16 },
+	{ "WKUP_GPIO0", 132, 1 },
+	{ "WKUP_I2C0", 144, 1 },
+	{ "WKUP_USART0", 160, 1 },
+}, mcu_cbass0_fwls[] = {
+	{ "MCU_R5FSS0_CORE0", 1024, 4 },
+	{ "MCU_R5FSS0_CORE0_CFG", 1025, 3 },
+	{ "MCU_R5FSS0_CORE1", 1028, 4 },
+	{ "MCU_R5FSS0_CORE1_CFG", 1029, 1 },
+	{ "MCU_FSS0_CFG", 1032, 12 },
+	{ "MCU_FSS0_S1", 1033, 8 },
+	{ "MCU_FSS0_S0", 1036, 8 },
+	{ "MCU_PSROM49152X32", 1048, 1 },
+	{ "MCU_MSRAM128KX64", 1050, 8 },
+	{ "MCU_MSRAM128KX64_CFG", 1051, 1 },
+	{ "MCU_TIMER0", 1056, 1 },
+	{ "MCU_TIMER9", 1065, 1 },
+	{ "MCU_USART0", 1120, 1 },
+	{ "MCU_I2C0", 1152, 1 },
+	{ "MCU_CTRL_MMR0", 1200, 8 },
+	{ "MCU_PLL_MMR0", 1201, 3 },
+	{ "MCU_CPSW0", 1220, 2 },
+}, cbass_rc_cfg0_fwls[] = {
+	{ "EMMCSD4SS0_CFG", 2400, 4 },
+}, cbass_hc2_fwls[] = {
+	{ "PCIE0", 2547, 24 },
+}, cbass_hc_cfg0_fwls[] = {
+	{ "PCIE0_CFG", 2577, 7 },
+	{ "EMMC8SS0_CFG", 2579, 4 },
+	{ "USB3SS0_CORE", 2580, 4 },
+	{ "USB3SS1_CORE", 2581, 1 },
+}, navss_cbass0_fwls[] = {
+	{ "NACSS_VIRT0", 6253, 1 },
+};
+
+static void ctrl_mmr_unlock(void)
+{
+	/* Unlock all WKUP_CTRL_MMR0 module registers */
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 0);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 1);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 2);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 3);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 4);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 6);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 7);
+
+	/* Unlock all MCU_CTRL_MMR0 module registers */
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 0);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 1);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 2);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 3);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 4);
+
+	/* Unlock all CTRL_MMR0 module registers */
+	mmr_unlock(CTRL_MMR0_BASE, 0);
+	mmr_unlock(CTRL_MMR0_BASE, 1);
+	mmr_unlock(CTRL_MMR0_BASE, 2);
+	mmr_unlock(CTRL_MMR0_BASE, 3);
+	mmr_unlock(CTRL_MMR0_BASE, 5);
+	mmr_unlock(CTRL_MMR0_BASE, 7);
+}
+
+/*
+ * This uninitialized global variable would normal end up in the .bss section,
+ * but the .bss is cleared between writing and reading this variable, so move
+ * it to the .data section.
+ */
+u32 bootindex __section(".data");
+static struct rom_extended_boot_data bootdata __section(".data");
+
+static void store_boot_info_from_rom(void)
+{
+	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
+	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
+	       sizeof(struct rom_extended_boot_data));
+}
+
+void k3_spl_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * Cannot delay this further as there is a chance that
+	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
+	 */
+	store_boot_info_from_rom();
+
+	/* Make all control module registers accessible */
+	ctrl_mmr_unlock();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		disable_linefill_optimization();
+		setup_k3_mpu_regions();
+	}
+
+	/* Init DM early */
+	ret = spl_early_init();
+
+	/* Prepare console output */
+	preloader_console_init();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/*
+		 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
+		 * regardless of the result of pinctrl. Do this without probing the
+		 * device, but instead by searching the device that would request the
+		 * given sequence number if probed. The UART will be used by the system
+		 * firmware (TIFS) image for various purposes and TIFS depends on us
+		 * to initialize its pin settings.
+		 */
+		ret = uclass_find_device_by_seq(UCLASS_SERIAL, 0, &dev);
+		if (!ret)
+			pinctrl_select_state(dev, "default");
+
+		/*
+		 * Load, start up, and configure system controller firmware. Provide
+		 * the U-Boot console init function to the TIFS post-PM configuration
+		 * callback hook, effectively switching on (or over) the console
+		 * output.
+		 */
+		k3_sysfw_loader(is_rom_loaded_sysfw(&bootdata), NULL, NULL);
+
+		if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
+			/*
+			 * Force probe of clk_k3 driver here to ensure basic default clock
+			 * configuration is always done for enabling PM services.
+			 */
+			ret = uclass_get_device_by_driver(UCLASS_CLK,
+							  DM_DRIVER_GET(ti_clk),
+							  &dev);
+			if (ret)
+				panic("Failed to initialize clk-k3!\n");
+		}
+
+		remove_fwl_configs(cbass_hc_cfg0_fwls, ARRAY_SIZE(cbass_hc_cfg0_fwls));
+		remove_fwl_configs(cbass_hc2_fwls, ARRAY_SIZE(cbass_hc2_fwls));
+		remove_fwl_configs(cbass_rc_cfg0_fwls, ARRAY_SIZE(cbass_rc_cfg0_fwls));
+		remove_fwl_configs(infra_cbass0_fwls, ARRAY_SIZE(infra_cbass0_fwls));
+		remove_fwl_configs(mcu_cbass0_fwls, ARRAY_SIZE(mcu_cbass0_fwls));
+		remove_fwl_configs(wkup_cbass0_fwls, ARRAY_SIZE(wkup_cbass0_fwls));
+		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
+	}
+
+	/* Output System Firmware version info */
+	k3_sysfw_print_ver();
+}
+
+void k3_mem_init(void)
+{
+	struct udevice *dev;
+	int ret, ctrl = 0;
+
+	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret)
+			panic("DRAM 0 init failed: %d\n", ret);
+		ctrl++;
+
+		while (ctrl < J784S4_MAX_DDR_CONTROLLERS) {
+			ret = uclass_next_device_err(&dev);
+			if (ret == -ENODEV)
+				break;
+
+			if (ret)
+				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			ctrl++;
+		}
+		printf("Initialized %d DRAM controllers\n", ctrl);
+	}
+
+	spl_enable_cache();
+}
+
+void board_init_f(ulong dummy)
+{
+	k3_spl_init();
+	k3_mem_init();
+}
+
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+			return MMCSD_MODE_EMMCBOOT;
+		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+			return MMCSD_MODE_FS;
+		return MMCSD_MODE_EMMCBOOT;
+	case BOOT_DEVICE_MMC2:
+		return MMCSD_MODE_FS;
+	default:
+		return MMCSD_MODE_RAW;
+	}
+}
+
+static u32 __get_backup_bootmedia(u32 main_devstat)
+{
+	u32 bkup_boot = (main_devstat & MAIN_DEVSTAT_BKUP_BOOTMODE_MASK) >>
+			MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT;
+
+	switch (bkup_boot) {
+	case BACKUP_BOOT_DEVICE_USB:
+		return BOOT_DEVICE_DFU;
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+	case BACKUP_BOOT_DEVICE_ETHERNET:
+		return BOOT_DEVICE_ETHERNET;
+	case BACKUP_BOOT_DEVICE_MMC2:
+	{
+		u32 port = (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
+			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
+		if (port == 0x0)
+			return BOOT_DEVICE_MMC1;
+		return BOOT_DEVICE_MMC2;
+	}
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+	case BACKUP_BOOT_DEVICE_I2C:
+		return BOOT_DEVICE_I2C;
+	}
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
+{
+	u32 bootmode = (wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+			WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+
+	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
+			BOOT_MODE_B_SHIFT;
+
+	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI ||
+	    bootmode == BOOT_DEVICE_XSPI)
+		bootmode = BOOT_DEVICE_SPI;
+
+	if (bootmode == BOOT_DEVICE_MMC2) {
+		u32 port = (main_devstat &
+			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
+			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
+		if (port == 0x0)
+			bootmode = BOOT_DEVICE_MMC1;
+	}
+
+	return bootmode;
+}
+
+u32 spl_spi_boot_bus(void)
+{
+	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
+	u32 main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = ((wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT) |
+			((main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) << BOOT_MODE_B_SHIFT);
+
+	return (bootmode == BOOT_DEVICE_QSPI) ? 1 : 0;
+}
+
+u32 spl_boot_device(void)
+{
+	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
+	u32 main_devstat;
+
+	if (wkup_devstat & WKUP_DEVSTAT_MCU_ONLY_MASK) {
+		printf("ERROR: MCU only boot is not yet supported\n");
+		return BOOT_DEVICE_RAM;
+	}
+
+	/* MAIN CTRL MMR can only be read if MCU ONLY is 0 */
+	main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+
+	if (bootindex == K3_PRIMARY_BOOTMODE)
+		return __get_primary_bootmedia(main_devstat, wkup_devstat);
+	else
+		return __get_backup_bootmedia(main_devstat);
+}
diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index b99199d3374..b666ed34d10 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SOC_K3_J721E) += j7200/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
+obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
 
 obj-y += lowlevel_init.o
 obj-y += r5_mpu.o
diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 5b07e920301..8e9e53cbb0e 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -62,7 +62,7 @@ choice
 	depends on K3_DDRSS
 	prompt "K3 DDRSS Arch Support"
 
-	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2
+	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
 	default K3_AM62A_DDRSS if SOC_K3_AM62A7
-- 
2.34.1

