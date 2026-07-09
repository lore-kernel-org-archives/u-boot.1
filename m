Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886A1C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C628284A5D;
	Fri, 10 Jul 2026 14:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="nVPvGkZu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMK+7NAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 374E084A3E; Thu,  9 Jul 2026 16:35:07 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37AB784B51
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ingo.rah@linutronix.de
From: INgo Rah <ingo.rah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783607703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIVVd9GHK6JBceNhObGutFI3AkM46lIVHjTmTTk41qQ=;
 b=nVPvGkZuNe8ZevSPE8xjtcqkr6g/nD1n/AqxmoBtF16ZWc7rC9dlybEo1PML971Sjg+lGL
 /7iWkNZ8f36ItF7v0fWA6GYd6n/qrwJB06l0hjjNcZIvNxoEB8PP+qnP4biP6rhxVXuGw5
 KcX5sLHu5iU50MFTvLT8Rnmr9heXcIVhHbgRh4/p9AhG7PpBVbFfp4MgI+VXn3Oja3zqrW
 gKKtDOgmOeZm0vFBSw7oBKZr5C9dqAnmuiGx7xPO1Fw7mVbvdsVB9DFXO2+My/mIvg/H3o
 HkZWkJ/Q7B51x6SOQoV6bwEJOvm0GdlYXzS4ubennMEwi2IMY37Ao+IO747Jvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783607703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIVVd9GHK6JBceNhObGutFI3AkM46lIVHjTmTTk41qQ=;
 b=OMK+7NAGSl5gBCPnk14Vv6O88TAqWrssWrO13t8hY3NCbpUG+iaMsirai2zO2ScDNSXx1+
 tN4Jt0IbgLHYc5Dg==
Date: Thu, 09 Jul 2026 16:34:27 +0200
Subject: [PATCH v2 2/2] board: phycore_imx8mm: add 1 and 4GB RAM timings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ram_phygate-v2-2-36f8a2f44de2@linutronix.de>
References: <20260709-ram_phygate-v2-0-36f8a2f44de2@linutronix.de>
In-Reply-To: <20260709-ram_phygate-v2-0-36f8a2f44de2@linutronix.de>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de
Cc: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Gregor Herburger <gregor.herburger@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 INgo Rah <ingo.rah@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9102;
 i=ingo.rah@linutronix.de; h=from:subject:message-id;
 bh=GpbLzIPHc5AU6LbxJ7Sx+u57CdXN28/ygD/IrKbA7TY=;
 b=owGbwMvMwCX2MS76xElR9+eMp9WSGLL8N0650e0qmzzRbOKEklTfV8dCc/SCWfZO6/JjNnR58
 O+DKmdjRykLgxgXg6yYIsuZCUJ7TepDD277vOMQzBxWJpAhDFycAjCRWzEM/7QlpsfcOJ2f+v10
 SFK308G++XtCLu1Nc9T6IMwdJP7vzV5GhoNOZ61LpPrFjk/V+zPpxvrfbTOzZgYU/Y/KfnDkt6d
 VPicA
X-Developer-Key: i=ingo.rah@linutronix.de; a=openpgp;
 fpr=CC9012BD347F55C1B6F3B8C2F15E5BC8C91547E7
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

The Phytec Tauri L is sold with multiple memory configurations beyond the
base 2 GB variant. To support these alternative capacities seamlessly,
read the physical memory size directly from the EEPROM of the underlying
phyCORE module and apply the appropriate DDR timing parameters at runtime.

Alternatively, a fixed memory configuration can still be enforced via a
dedicated Kconfig option if dynamic detection is not desired.

Note that while U-Boot correctly discovers the full physical memory bank,
the device tree excludes the memory beyond 3 GB  (below the 4 GB boundary).
This ensures that U-Boot allocations and early EFI staging buffers remain
safe from 32-bit interconnect DMA limitations inherent to some i.MX8MM
IP blocks.

Signed-off-by: INgo Rah <ingo.rah@linutronix.de>
Reviewed-by: Gregor Herburger <gregor.herburger@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
---
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi | 23 +++++++++
 board/phytec/phycore_imx8mm/Kconfig             | 65 +++++++++++++++++++++++++
 board/phytec/phycore_imx8mm/phycore-imx8mm.c    | 18 +++++++
 board/phytec/phycore_imx8mm/spl.c               | 56 ++++++++++++++++++++-
 configs/imx8mm-phygate-tauri-l_defconfig        |  1 +
 include/configs/phycore_imx8mm.h                |  5 +-
 6 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
index 26361780c01..452bf3d41f1 100644
--- a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
@@ -6,6 +6,21 @@
 #include "imx8mm-u-boot.dtsi"
 
 / {
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * Limit memory usage below the 4 GB (32-bit) boundary.
+		 * The i.MX8MM DMA and peripherals cannot access >32-bit
+		 * addresses. This prevents allocation failures in UEFI mode.
+		 */
+		u_boot_sdma_shield: sdma-shield@100000000 {
+			reg = <0x1 0x00000000 0x0 0x40000000>;
+		};
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		wdt = <&wdog1>;
@@ -29,6 +44,10 @@
 	};
 };
 
+&pinctrl_i2c1 {
+	bootph-pre-ram;
+};
+
 &pinctrl_uart3 {
 	bootph-pre-ram;
 };
@@ -73,6 +92,10 @@
 	bootph-pre-ram;
 };
 
+&i2c1 {
+	bootph-pre-ram;
+};
+
 &usdhc2 {
 	bootph-pre-ram;
 };
diff --git a/board/phytec/phycore_imx8mm/Kconfig b/board/phytec/phycore_imx8mm/Kconfig
index 06449128ba8..609c11580ce 100644
--- a/board/phytec/phycore_imx8mm/Kconfig
+++ b/board/phytec/phycore_imx8mm/Kconfig
@@ -12,5 +12,70 @@ config SYS_CONFIG_NAME
 config IMX_CONFIG
 	default "board/phytec/phycore_imx8mm/imximage-8mm-sd.cfg"
 
+config PHYCORE_IMX8MM_RAM_SIZE_FIX
+	bool "Set phyCORE-i.MX8MM RAM size fix instead of detecting"
+	default false
+	help
+	  RAM size is automatic being detected with the help of
+	  the EEPROM introspection data. Set RAM size to a fix value
+	  instead.
+
+choice
+	prompt "phyCORE-i.MX8MM RAM size"
+	depends on PHYCORE_IMX8MM_RAM_SIZE_FIX
+	default PHYCORE_IMX8MM_RAM_SIZE_2GB
+	help
+	  Select a fixed RAM size instead of EEPROM introspection
+	  data.
+
+config PHYCORE_IMX8MM_RAM_SIZE_1GB
+	bool "1GB RAM"
+	help
+	  Set RAM size fix to 1GB for phyCORE-i.MX8MM
+	  instead of runtime detection from EEPROM.
+
+config PHYCORE_IMX8MM_RAM_SIZE_2GB
+	bool "2GB RAM"
+	help
+	  Set RAM size fix to 2GB for phyCORE-i.MX8MM
+	  instead of runtime detection from EEPROM.
+
+config PHYCORE_IMX8MM_RAM_SIZE_4GB
+	bool "4GB RAM"
+	help
+	  Set RAM size fix to 4GB for phyCORE-i.MX8MM
+	  instead of runtime detection from EEPROM.
+
+endchoice
+
+config PHYCORE_IMX8MM_RAM_STATIC_SOM_REV
+	bool "Set static phyCORE-i.MX8MM SoM revision for RAM timing setup"
+	default false
+	help
+	  phyCORE-i.MX8MM SoM revision 7 uses a updated set of optimized
+	  RAM timings compared to revision 6 and older. Set the SoM
+	  revision during compile time instead of being detected.
+
+choice
+	prompt "phyCORE-i.MX8MM RAM timing SoM revision static config"
+	depends on PHYCORE_IMX8MM_RAM_STATIC_SOM_REV
+	default PHYCORE_IMX8MM_USE_SOM_REV_7
+	help
+	  Use a fixed revision setting instead of runtime
+	  auto detection.
+
+config PHYCORE_IMX8MM_USE_SOM_REV_6
+	bool "RAM Timings for SoM Revisions 6 and older"
+	help
+	  Use optimized RAM Timings for phyCORE-i.MX8MM SoM Revisions 6
+	  and older instead of autodetecting.
+
+config PHYCORE_IMX8MM_USE_SOM_REV_7
+	bool "RAM Timings for SoM Revision 7"
+	help
+	  Use optimized RAM Timings for phyCORE-i.MX8MM SoM Revision 7
+	  instead of autodetecting.
+endchoice
+
 source "board/phytec/common/Kconfig"
 endif
diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
index 9f6a4ec704d..25e51dce739 100644
--- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
+++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
@@ -9,6 +9,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
 #include <miiphy.h>
+#include <init.h>
 
 static int setup_fec(void)
 {
@@ -50,3 +51,20 @@ int board_late_init(void)
 
 	return 0;
 }
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	if (!size)
+		return -EINVAL;
+
+	/*
+	 * check various RAM sizes (1, 2 and 4 GB) otherwise
+	 * return the default of 2GB
+	 */
+	*size = get_ram_size((void *)PHYS_SDRAM,
+			     (long)PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE);
+	if (*size == 0)
+		*size = SZ_2G;
+
+	return 0;
+}
diff --git a/board/phytec/phycore_imx8mm/spl.c b/board/phytec/phycore_imx8mm/spl.c
index e688793bc74..a3879881eb7 100644
--- a/board/phytec/phycore_imx8mm/spl.c
+++ b/board/phytec/phycore_imx8mm/spl.c
@@ -16,11 +16,19 @@
 #include <log.h>
 #include <spl.h>
 
+#include "lpddr4_timing.h"
 #include "../common/imx8m_som_detection.h"
 
 #define EEPROM_ADDR		0x51
 #define EEPROM_ADDR_FALLBACK	0x59
 
+enum phytec_imx8mm_ddr_eeprom_code {
+	INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX8MM_DDR_1GB = 1,
+	PHYTEC_IMX8MM_DDR_2GB = 3,
+	PHYTEC_IMX8MM_DDR_4GB = 5,
+};
+
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	switch (boot_dev_spl) {
@@ -42,17 +50,63 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 static void spl_dram_init(void)
 {
 	int ret;
+	enum phytec_imx8mm_ddr_eeprom_code size = PHYTEC_EEPROM_INVAL;
+	u8 rev = PHYTEC_EEPROM_INVAL;
 
 	ret = phytec_eeprom_data_setup_fallback(NULL, 0, EEPROM_ADDR,
 			EEPROM_ADDR_FALLBACK);
-	if (ret)
+	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX8MM_RAM_SIZE_FIX))
 		goto out;
 
 	ret = phytec_imx8m_detect(NULL);
 	if (!ret)
 		phytec_print_som_info(NULL);
 
+	if (IS_ENABLED(CONFIG_PHYCORE_IMX8MM_RAM_SIZE_FIX)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_IMX8MM_RAM_SIZE_1GB))
+			size = PHYTEC_IMX8MM_DDR_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MM_RAM_SIZE_2GB))
+			size = PHYTEC_IMX8MM_DDR_2GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MM_RAM_SIZE_4GB))
+			size = PHYTEC_IMX8MM_DDR_4GB;
+	} else {
+		size = phytec_get_imx8m_ddr_size(NULL);
+	}
+
+	if (IS_ENABLED(CONFIG_PHYCORE_IMX8MM_RAM_STATIC_SOM_REV)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_IMX8MM_USE_SOM_REV_6))
+			rev = 6;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MM_USE_SOM_REV_7))
+			rev = 7;
+	} else {
+		rev = phytec_get_rev(NULL);
+	}
+
+	if (rev >= 7 || rev == PHYTEC_EEPROM_INVAL) {
+		debug("%s: Using rev7 RAM timings.\n", __func__);
+		set_dram_timings_rev7();
+	} else {
+		debug("%s: Using rev6 RAM timings.\n", __func__);
+	}
+
+	switch (size) {
+	case PHYTEC_IMX8MM_DDR_1GB:
+		set_dram_timings_1gb();
+		break;
+	case PHYTEC_IMX8MM_DDR_2GB:
+		break;
+	case PHYTEC_IMX8MM_DDR_4GB:
+		set_dram_timings_4gb();
+		break;
+	default:
+		goto out;
+	}
+	ddr_init(&dram_timing);
+
+	return;
 out:
+	puts("Could not detect correct RAM size. Fall back to default.\n");
+	set_dram_timings_rev7();
 	ddr_init(&dram_timing);
 }
 
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 9dc7fe21820..3ae92ff09f6 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -4,6 +4,7 @@ CONFIG_TEXT_BASE=0x40200000
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y
diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index 20e2ab832ee..d4571cc6f39 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -28,6 +28,7 @@
 #define CFG_SYS_SDRAM_BASE		0x40000000
 
 #define PHYS_SDRAM			0x40000000
-#define PHYS_SDRAM_SIZE                 SZ_2G /* 2GB DDR */
-
+#define PHYS_SDRAM_SIZE                 (SZ_2G + SZ_1G) /* 3GB */
+#define PHYS_SDRAM_2                    0x100000000
+#define PHYS_SDRAM_2_SIZE                SZ_1G /* 4GB DDR */
 #endif /* __PHYCORE_IMX8MM_H */

-- 
2.47.3

