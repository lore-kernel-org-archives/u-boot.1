Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D08CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 18:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FF5848DC;
	Wed, 10 Jun 2026 20:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ce+I16/g";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D+YZAacU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22388494B; Wed, 10 Jun 2026 20:21:55 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB10D8489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 20:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gbDdF4DSvz9vPJ;
 Wed, 10 Jun 2026 20:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781115713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c45mndVNznKryfr3XISUAkDJqMAFntNpwZke7yJKWk=;
 b=ce+I16/gbwl0A1GmNBa4irKIwBU+QQv1/sdRw0xTru/lUZfomCkHg5fCv/c96c3JUKfDhI
 lB/8O9ftNZNwGieR60CXFIdFeRZglVHeTP3Lvn4/BI8VM+TfEg7lJpvezqOfj9KQHKwo3U
 mg11wIB0OcD1l6BFfZE4Ictob8ps9OKCxURMv391ssyNpE8dcnONGYE19fmWGyBt3DPQq2
 qNr+trLR9+Iylo3SfjtalehQOXgNwbEFm9dLr/yPI/r/H+IfQzzFw57GRGVVeN/iT5+Cvg
 EzhsV/XFQBdR5prsJt04XJwwWZslvSa7eJx9DKaOGbhvNxT9a32xIDKwQr6w1w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781115711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c45mndVNznKryfr3XISUAkDJqMAFntNpwZke7yJKWk=;
 b=D+YZAacURixynEMq+RsRB6ORIqO1hs4qbCAF40FXA2Uc4Yd5QoSQjyI0OyIMv+Xz8jm4iD
 /Pmx8BdFaijcINyRB4QMCe7o244B1MwzESP4zUhux8Yi0RRkF+iXNvW0Im0DK7EygJnntE
 3HoSIrPeVGYXovo+mximqMFL31Bum1LLg4oev6kbHkU+jFuAOlRGob6luRg9wDGYTlBe1E
 L2cI+/+to/vGCSoxL4zwP0EpXvPeIjd4LGUHQYn5jXxCidWmG4u4OQt6HXFT5Op2ZNO+lN
 6UrMSSCyxuOSIEA/mW5hHO1bgyuSWOE5MDqgnn6Kf6co8sYLEPZU2u24svMfnw==
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 3/3] arm: dts: renesas: Enable DBSC5 on R-Car R8A78000 X5H
 Cortex-M33 RSIP port
Date: Wed, 10 Jun 2026 20:20:59 +0200
Message-ID: <20260610182140.56393-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260610182140.56393-1-marek.vasut+renesas@mailbox.org>
References: <20260610182140.56393-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 643b08f62e57746734f
X-MBO-RS-META: i4pwswa6n3kwmo7kj1jyff969z14ybei
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

Bind the DBSC5 DRAM controller driver on boot in board_early_init_r(),
which brings up the DBSC5 DRAM controller and its PHY and which enables
access to DRAM present on this system.

Add default boot command which loads additional bootloader components
from HF and UFS storage into SRAM and DRAM, and starts those components
on SCP and AP core 0. The system is then capable of reaching U-Boot on
the AP core 0. Specifically, the following components are loaded:
- SCP firmware, 384 kiB from HF offset 0x4c0000 to SCP STCM
- TFA BL31, 256 kiB from UFS0 offset 0x5000 * 4 kiB sectors to DRAM 0x8c200000
- TEE, 2 MiB from UFS0 offset 0x5200 * 4 kiB sectors to DRAM 0x8c400000
- U-Boot, 1 MiB from UFS0 offset 0x7200 * 4 kiB sectors to DRAM 0x8c300000
- IPL parameters table is generated at DRAM address 0x8c100000

Enable pstore command support to allow dumping kernel console from
pstore/ramoops, which is convenient for debugging. Use as follows:
=> pstore set 0x80000000 0x10000 0x400 0x8000 0 0 0
=> pstore display console

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 .../dts/r8a78000-ironhide-cm33-u-boot.dtsi    | 10 ++++
 arch/arm/mach-renesas/Kconfig.rcar5           |  1 +
 board/renesas/common/gen5-cm33.c              | 49 +++++++++++++++++++
 configs/r8a78000_ironhide_cm33_defconfig      |  8 ++-
 include/configs/rcar-gen5-common.h            | 42 +++++++++++++++-
 5 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
index 2d4cdbac62a..356f633135d 100644
--- a/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
@@ -65,10 +65,20 @@
 		syscon = <&ctl>;
 	};
 
+	ram@b8940000 {	/* RT-VRAM */
+		compatible = "renesas,r8a78000-rtvram";
+		reg = <0 0xb8940000 0 0xf000>;
+	};
+
 	scp@c1340000 {
 		compatible = "renesas,r8a78000-rproc";
 		reg = <0 0xc1340000 0 0x80000>;
 	};
+
+	ram@e9800000 {	/* DBSC5 */
+		compatible = "renesas,r8a78000-dbsc";
+		reg = <0 0xe9800000 0 0x1000000>;
+	};
 };
 
 &cpg {
diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
index fcca3811241..33ad8522f07 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar5
+++ b/arch/arm/mach-renesas/Kconfig.rcar5
@@ -2,6 +2,7 @@ if RCAR_GEN5
 
 config RCAR_64_RSIP
 	bool "Renesas ARM SoCs R-Car Gen5 (use Cortex-M33 RSIP)"
+	select LMB_ARCH_MEM_MAP
 	select SKIP_RELOCATE_CODE
 	select TMU_TIMER
 	help
diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index e07db9817f2..f06df824019 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -904,6 +904,24 @@ static void mfis_unprotect(void)
 	writel(MFIS_CODEVALUE, MFIS_WPCNTR);
 }
 
+/**
+ * rsip_write_reg() - Write RSIP control register
+ * @reg: Register to write
+ * @val: Value to set in the register
+ */
+static void rsip_write_reg(const u32 reg, const int val)
+{
+	for (;;) {
+		writel(RSIP_CTL_PROT0PCMD_WREN, RSIP_CTL_PROT0PCMD);
+		writel(val, reg);
+		writel(~val, reg);
+		writel(val, reg);
+
+		if (readl(RSIP_CTL_PROT0PS) != RSIP_CTL_PROT0PS_ERR)
+			break;
+	}
+}
+
 /**
  * rsip_irq_setup() - Configure RSIP interrupts
  */
@@ -1353,6 +1371,26 @@ int mach_cpu_init(void)
 	return 0;
 }
 
+int board_early_init_r(void)
+{
+	u32 remaptmp = readl(RSIP_CTL_ESICREMAP0);
+	struct udevice *dev;
+	int ret;
+
+	/* Remap DDR PHY during DRAM init. */
+	rsip_write_reg(RSIP_CTL_ESICREMAP0, 0xe0000000);
+
+	/* Start DBSC5 */
+	ret = uclass_get_device_by_name(UCLASS_NOP, "ram@e9800000", &dev);
+	if (ret)
+		printf("DBSC5 init failed: %d\n", ret);
+
+	/* Restore remapping. */
+	rsip_write_reg(RSIP_CTL_ESICREMAP0, remaptmp);
+
+	return 0;
+}
+
 /**
  * board_debug_uart_init() - Initialize all HSCIF
  */
@@ -1407,3 +1445,14 @@ void __weak reset_cpu(void)
 	writel(RST_KCPROT_DIS, RST_RESKCPROT0);
 	writel(0x1, RST_SWSRES1A);
 }
+
+/**
+ * lmb_arch_add_memory() - Add memory to LMB
+ *
+ * Add the window to a subset of 32bit DRAM are into LMB,
+ * to make it possible to TFTP into it.
+ */
+void lmb_arch_add_memory(void)
+{
+	lmb_add(0x60000000, 0x40000000);
+}
diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index dda096634b5..7ea3ae993ba 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -17,9 +17,14 @@ CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET=0xa0000000
 
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_BAUDRATE=1843200
-CONFIG_BOOTCOMMAND=""
+CONFIG_BOARD_EARLY_INIT_R=y
+CONFIG_BOOTCOMMAND="run rsip_ipl_boot_ca0"
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_CMD_IMI=y
+CONFIG_CMD_PSTORE=y
+CONFIG_CMD_PSTORE_MEM_ADDR=0x80000000
+CONFIG_CMD_PSTORE_RECORD_SIZE=0x400
+CONFIG_CMD_PSTORE_CONSOLE_SIZE=0x8000
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_DM_DMA=y
@@ -37,6 +42,7 @@ CONFIG_PHY_R8A78000_MP_PHY=y
 CONFIG_PHY_TI_DP83869=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_RAM=y
+CONFIG_RAM_RENESAS_DBSC5=y
 CONFIG_REMOTEPROC_RENESAS_RSIP=y
 CONFIG_RENESAS_ETHER_SWITCH=y
 CONFIG_RENESAS_R8A78000_POWER_DOMAIN=y
diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
index 5ff2a76fc05..a0c05521c85 100644
--- a/include/configs/rcar-gen5-common.h
+++ b/include/configs/rcar-gen5-common.h
@@ -26,10 +26,50 @@
 #if defined(CONFIG_RCAR_64_RSIP)
 #define CFG_SYS_TIMER_COUNTER		(TMU_BASE + 0xc)	/* TCNT0 */
 #define CFG_SYS_TIMER_RATE		(133333333 / 4)
-#endif
 
+/* Environment setting */
+#define CFG_EXTRA_ENV_SETTINGS						\
+	"rsip_ipl_params_base=0x8c100000\0"				\
+	"rsip_ipl_params_optee=0x8c100088\0"				\
+	"rsip_ipl_params_uboot=0x8c100030\0"				\
+	"rsip_ipl_optee_ep=0x8c400000\0"				\
+	"rsip_ipl_tfa_ep=0x8c200000\0"					\
+	"rsip_ipl_uboot_ep=0x8e300000\0"				\
+	"rsip_ipl_params_write="					\
+		"base ${rsip_ipl_params_base} ; "			\
+		"mw 0x00 0 0x9e ; "	/* Clear the area */		\
+		"mw 0x00 0x00300103 ; " /* type, version, size */	\
+		"mw 0x20 0x${rsip_ipl_params_uboot} ; " /* U-Boot descriptor */ \
+		""							\
+		"base ${rsip_ipl_params_uboot} ; "			\
+		"mw 0x00 0x00580101 ; " /* type, version, size */	\
+		"mw 0x04 0x00000001 ; " /* attr */			\
+		"mw 0x08 ${rsip_ipl_uboot_ep} ; " /* U-Boot entry point */ \
+		"mw 0x10 0x000003c5 ; " /* SPSR */			\
+		""							\
+		"base ${rsip_ipl_params_optee} ; "			\
+		"mw 0x00 0x00580201 ; " /* type, version, size */	\
+		"mw 0x04 0x00000008 ; " /* attr */			\
+		"mw 0x08 ${rsip_ipl_optee_ep} ; " /* OPTEE-OS entry point */ \
+		"mw 0x10 0x000003c5 ; " /* SPSR */			\
+		""							\
+		"base 0\0"						\
+	"rsip_ipl_boot_ca0=" /* Start TFA BL31, OPTEE-OS, U-Boot on Cortex-A720AE core 0 */ \
+		"scsi scan && " /* Scan for UFS devices */		\
+		"rproc init && " /* Start remoteproc */			\
+		"rproc load 0 0x344c0000 0x60000 && " /* Load SCP from HF */ \
+		"rproc start 0 && " /* Start SCP */			\
+		"scsi read ${rsip_ipl_uboot_ep} 0x7200 0x100 && " /* Load U-Boot from UFS */ \
+		"scsi read ${rsip_ipl_optee_ep} 0x5200 0x200 && " /* Load OPTEE-OS from UFS */ \
+		"scsi read ${rsip_ipl_tfa_ep} 0x5000 0x40 && " /* Load TFA BL31 from UFS */ \
+		"run rsip_ipl_params_write && " /* Write entry point descriptors */ \
+		"rproc load 13 ${rsip_ipl_tfa_ep} 4 && " /* Set up Cortex-A720AE Core 0 */ \
+		"rproc start 13\0"	/* Start Cortex-A720AE Core 0 */
+
+#else
 /* Environment setting */
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"bootm_size=0x10000000\0"
+#endif
 
 #endif	/* __RCAR_GEN5_COMMON_H */
-- 
2.53.0

