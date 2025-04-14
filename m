Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D5AC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F5B82163;
	Mon, 14 Apr 2025 22:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="CX/CHcvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0A58215B; Mon, 14 Apr 2025 22:01:51 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1DB82102
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oVY2aukjKd9KJosNuQogWo+wpNXk0PPMdx/3NuzpZrs=; b=CX/CHcvz7P9gOQhFd2ezbcuz0T
 kRapAotSkZpEJGjZyIZ4xnOSnQ5nz9vqvZNPzZZVLrg59STOAO23tEI1vAEzMRMgD2GwHYd7j3S7d
 o7hgz8WfS0tdeZrdevx+fi2iAWFbnrA/wbMy2kWcV4ce+2jD0JK0B/QKZpIxRyPm+AxM2rZtnUfv0
 L6Z3raEHijgk81gKQzWmDjBZHISxli5BmEoCxI8YkmiaC5w+iCNLEQD4kf0xTFb01x0YMJu5MlYuP
 pENNUTCjHRRLt4bgvBhea6Kw7voukt10Y3fCas6bhHVeFbJx+UYI+EwTXbFb0Lp/7YDPDAPcdMVLb
 N4O2Fe6w==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Pzt-0001rf-Ou; Mon, 14 Apr 2025 22:01:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Xuhui Lin <xuhui.lin@rock-chips.com>
Subject: [PATCH v2 04/16] arm: rockchip: Add RK3576 arch core support
Date: Mon, 14 Apr 2025 22:00:59 +0200
Message-ID: <20250414200111.1357867-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414200111.1357867-1-heiko@sntech.de>
References: <20250414200111.1357867-1-heiko@sntech.de>
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

From: Xuhui Lin <xuhui.lin@rock-chips.com>

The Rockchip RK3576 is a ARM-based SoC with quad-core Cortex-A72
and quad-core Cortex-A53 including 6TOPS NPU, Mali-G52 MC3, HDMI Out,
DP, eDP, MIPI DSI, MIPI CSI2, LPDDR4/4X/5, eMMC5.1, SD3.0/MMC4.5, UFS,
USB OTG 3.0, Type-C, USB 2.0, PCIe 2.1, SATA 3, Ethernet, SDIO3.0, I2C,
UART, SPI, GPIO and PWM.

Add arch core support for it.

Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
[adapted for mainline u-boot]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/dts/rk3576-u-boot.dtsi               | 131 +++++++++++++++
 arch/arm/include/asm/arch-rk3576/boot0.h      |  11 ++
 arch/arm/include/asm/arch-rk3576/gpio.h       |  11 ++
 arch/arm/mach-rockchip/Kconfig                |  51 ++++++
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rk3576/Kconfig         |  15 ++
 arch/arm/mach-rockchip/rk3576/Makefile        |   9 +
 arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  18 ++
 arch/arm/mach-rockchip/rk3576/rk3576.c        | 155 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |  22 +++
 arch/arm/mach-rockchip/sdram.c                |   1 +
 doc/board/rockchip/rockchip.rst               |   9 +
 include/configs/rk3576_common.h               |  45 +++++
 13 files changed, 479 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
 create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
 create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
 create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
 create mode 100644 include/configs/rk3576_common.h

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
new file mode 100644
index 00000000000..be99a48a630
--- /dev/null
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * (C) Copyright 2025 Rockchip Electronics Co., Ltd
+ */
+
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
+	};
+
+	dmc {
+		compatible = "rockchip,rk3576-dmc";
+		bootph-all;
+	};
+};
+
+&cru {
+	bootph-all;
+};
+
+&emmc_bus8 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_cmd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_rstnout {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_strb {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&ioc_grf {
+	bootph-all;
+};
+
+&pcfg_pull_none {
+	bootph-all;
+};
+
+&pcfg_pull_up {
+	bootph-all;
+};
+
+&pcfg_pull_up_drv_level_2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pcfg_pull_up_drv_level_3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl {
+	bootph-all;
+};
+
+&pmu1_grf {
+	bootph-all;
+};
+
+&sdhci {
+	bootph-pre-ram;
+	bootph-some-ram;
+	u-boot,spl-fifo-mode;
+};
+
+&sdmmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+	u-boot,spl-fifo-mode;
+};
+
+&sdmmc0_bus4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc0_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc0_cmd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc0_det {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc0_pwren {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sys_grf {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&uart0m0_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
+
+&xin24m {
+	bootph-all;
+};
diff --git a/arch/arm/include/asm/arch-rk3576/boot0.h b/arch/arm/include/asm/arch-rk3576/boot0.h
new file mode 100644
index 00000000000..dea2b20252d
--- /dev/null
+++ b/arch/arm/include/asm/arch-rk3576/boot0.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2021 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __ASM_ARCH_BOOT0_H__
+#define __ASM_ARCH_BOOT0_H__
+
+#include <asm/arch-rockchip/boot0.h>
+
+#endif
diff --git a/arch/arm/include/asm/arch-rk3576/gpio.h b/arch/arm/include/asm/arch-rk3576/gpio.h
new file mode 100644
index 00000000000..b48c0a5cf84
--- /dev/null
+++ b/arch/arm/include/asm/arch-rk3576/gpio.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2021 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __ASM_ARCH_GPIO_H__
+#define __ASM_ARCH_GPIO_H__
+
+#include <asm/arch-rockchip/gpio.h>
+
+#endif
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 4d5e587cc88..67edae71b4a 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -403,6 +403,56 @@ config ROCKCHIP_RK3568
 	  and video codec support. Peripherals include Gigabit Ethernet,
 	  USB2 host and OTG, SDIO, I2S, UARTs, SPI, I2C and PWMs.
 
+config ROCKCHIP_RK3576
+	bool "Support Rockchip RK3576"
+	select ARM64
+	select SUPPORT_SPL
+	select SPL
+	select CLK
+	select PINCTRL
+	select RAM
+	select REGMAP
+	select SYSCON
+	select BOARD_LATE_INIT
+	select DM_REGULATOR_FIXED
+	select DM_RESET
+	imply ARMV8_CRYPTO
+	imply ARMV8_SET_SMPEN
+	imply BOOTSTD_FULL
+	imply DM_RNG
+	imply FIT
+	imply LEGACY_IMAGE_FORMAT
+	imply MISC
+	imply MISC_INIT_R
+	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
+	imply OF_LIBFDT_OVERLAY
+	imply OF_LIVE
+	imply OF_UPSTREAM
+	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
+	imply RNG_ROCKCHIP
+	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_OTP
+	imply SPL_ATF
+	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
+	imply SPL_CLK
+	imply SPL_DM_SEQ_ALIAS
+	imply SPL_FIT_SIGNATURE
+	imply SPL_LOAD_FIT
+	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
+	imply SPL_OF_CONTROL
+	imply SPL_PINCTRL
+	imply SPL_RAM
+	imply SPL_REGMAP
+	imply SPL_SERIAL
+	imply SPL_SYSCON
+	imply SYS_RELOC_GD_ENV_ADDR
+	imply SYSRESET
+	help
+	  The Rockchip RK3576 is a ARM-based SoC with quad-core Cortex-A72 and
+	  and quad-core Cortex-A53.
+
 config ROCKCHIP_RK3588
 	bool "Support Rockchip RK3588"
 	select ARM64
@@ -691,6 +741,7 @@ source "arch/arm/mach-rockchip/rk3368/Kconfig"
 source "arch/arm/mach-rockchip/rk3399/Kconfig"
 source "arch/arm/mach-rockchip/rk3528/Kconfig"
 source "arch/arm/mach-rockchip/rk3568/Kconfig"
+source "arch/arm/mach-rockchip/rk3576/Kconfig"
 source "arch/arm/mach-rockchip/rk3588/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 5a7dd5b5940..ae15a9f8a2d 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
 obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
 obj-$(CONFIG_ROCKCHIP_RK3528) += rk3528/
 obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
+obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
 obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
 obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
 obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip/rk3576/Kconfig
new file mode 100644
index 00000000000..a94dc6706f0
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/Kconfig
@@ -0,0 +1,15 @@
+if ROCKCHIP_RK3576
+
+config ROCKCHIP_BOOT_MODE_REG
+	default 0x26024040
+
+config ROCKCHIP_STIMER_BASE
+	default 0x27400000
+
+config SYS_SOC
+	default "rk3576"
+
+config SYS_CONFIG_NAME
+	default "rk3576_common"
+
+endif
diff --git a/arch/arm/mach-rockchip/rk3576/Makefile b/arch/arm/mach-rockchip/rk3576/Makefile
new file mode 100644
index 00000000000..cbc58257deb
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/Makefile
@@ -0,0 +1,9 @@
+#
+# (C) Copyright 2023 Rockchip Electronics Co., Ltd
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y += rk3576.o
+obj-y += clk_rk3576.o
+obj-y += syscon_rk3576.o
diff --git a/arch/arm/mach-rockchip/rk3576/clk_rk3576.c b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
new file mode 100644
index 00000000000..edda1afd0bd
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dm.h>
+#include <asm/arch-rockchip/cru_rk3576.h>
+
+int rockchip_get_clk(struct udevice **devp)
+{
+	return uclass_get_device_by_driver(UCLASS_CLK,
+				DM_DRIVER_GET(rockchip_rk3576_cru), devp);
+}
+
+void *rockchip_get_cru(void)
+{
+	return (void *)RK3576_CRU_BASE;
+}
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
new file mode 100644
index 00000000000..ba5c94b4b3d
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd
+ */
+
+#include <asm/armv8/mmu.h>
+#include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/hardware.h>
+
+#define SYS_GRF_BASE		0x2600A000
+#define SYS_GRF_SOC_CON2	0x0008
+#define SYS_GRF_SOC_CON7	0x001c
+#define SYS_GRF_SOC_CON11	0x002c
+#define SYS_GRF_SOC_CON12	0x0030
+
+#define GPIO0_IOC_BASE		0x26040000
+#define GPIO0B_PULL_L		0x0024
+#define GPIO0B_IE_L		0x002C
+
+#define SYS_SGRF_BASE		0x26004000
+#define SYS_SGRF_SOC_CON14	0x0058
+#define SYS_SGRF_SOC_CON15	0x005C
+#define SYS_SGRF_SOC_CON20	0x0070
+
+#define FW_SYS_SGRF_BASE	0x26005000
+#define SGRF_DOMAIN_CON1	0x4
+#define SGRF_DOMAIN_CON2	0x8
+#define SGRF_DOMAIN_CON3	0xc
+#define SGRF_DOMAIN_CON4	0x10
+#define SGRF_DOMAIN_CON5	0x14
+
+const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
+	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
+	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
+};
+
+static struct mm_region rk3576_mem_map[] = {
+	{
+		/* I/O area */
+		.virt = 0x20000000UL,
+		.phys = 0x20000000UL,
+		.size = 0xb080000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PMU_SRAM, CBUF, SYSTEM_SRAM */
+		.virt = 0x3fe70000UL,
+		.phys = 0x3fe70000UL,
+		.size = 0x190000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* MSCH_DDR_PORT */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x400000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* PCIe 0+1 */
+		.virt = 0x900000000UL,
+		.phys = 0x900000000UL,
+		.size = 0x100800000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = rk3576_mem_map;
+
+void board_debug_uart_init(void)
+{
+}
+
+#define HP_TIMER_BASE			CONFIG_ROCKCHIP_STIMER_BASE
+#define HP_CTRL_REG			0x04
+#define TIMER_EN			BIT(0)
+#define HP_LOAD_COUNT0_REG		0x14
+#define HP_LOAD_COUNT1_REG		0x18
+
+void rockchip_stimer_init(void)
+{
+	u32 reg;
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
+		return;
+
+	reg = readl(HP_TIMER_BASE + HP_CTRL_REG);
+	if (reg & TIMER_EN)
+		return;
+
+	asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
+	writel((TIMER_EN << 16) | TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
+}
+
+int arch_cpu_init(void)
+{
+	u32 val;
+
+	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+		return 0;
+
+	/* Set the emmc to access ddr memory */
+	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
+	writel(val | 0x7, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
+
+	/* Set the sdmmc0 to access ddr memory */
+	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON5);
+	writel(val | 0x700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON5);
+
+	/* Set the UFS to access ddr memory */
+	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON3);
+	writel(val | 0x70000, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON3);
+
+	/* Set the fspi0 and fspi1 to access ddr memory */
+	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON4);
+	writel(val | 0x7700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON4);
+
+	/* Set the decom to access ddr memory */
+	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON1);
+	writel(val | 0x700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON1);
+
+	/*
+	 * Set the GPIO0B0~B3 pull up and input enable.
+	 * Keep consistent with other IO.
+	 */
+	writel(0x00ff00ff, GPIO0_IOC_BASE + GPIO0B_PULL_L);
+	writel(0x000f000f, GPIO0_IOC_BASE + GPIO0B_IE_L);
+
+	/*
+	 * Set SYS_GRF_SOC_CON2[12](input of pwm2_ch0) as 0,
+	 * keep consistent with other pwm.
+	 */
+	writel(0x10000000, SYS_GRF_BASE + SYS_GRF_SOC_CON2);
+
+	/* Enable noc slave response timeout */
+	writel(0x80008000, SYS_GRF_BASE + SYS_GRF_SOC_CON11);
+	writel(0xffffffe0, SYS_GRF_BASE + SYS_GRF_SOC_CON12);
+
+	/*
+	 * Enable cci channels for below module AXI R/W
+	 * Module: GMAC0/1, MMU0/1(PCIe, SATA, USB3)
+	 */
+	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
+
+	return 0;
+}
diff --git a/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
new file mode 100644
index 00000000000..0dbf8f8d9c0
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2023 Rockchip Electronics Co., Ltd
+ */
+
+#include <dm.h>
+#include <asm/arch-rockchip/clock.h>
+
+static const struct udevice_id rk3576_syscon_ids[] = {
+	{ .compatible = "rockchip,rk3576-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ .compatible = "rockchip,rk3576-pmu1-grf",  .data = ROCKCHIP_SYSCON_PMUGRF },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3576_syscon) = {
+	.name = "rockchip_rk3576_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = rk3576_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
+};
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index f6d9c503bfd..1330ff14a29 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -110,6 +110,7 @@ static int rockchip_dram_init_banksize(void)
 	u8 i, j;
 
 	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
+	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3576) &&
 	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568) &&
 	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3528))
 		return -ENOTSUPP;
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b992e6c8b6c..1058a1ce990 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -281,6 +281,15 @@ To build rk3568 boards:
         make evb-rk3568_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+To build rk3576 boards:
+
+.. code-block:: bash
+
+        export BL31=../rkbin/bin/rk35/rk3576_bl31_v1.04.elf
+        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.03.bin
+        make roc-pc-rk3576_defconfig
+        make CROSS_COMPILE=aarch64-linux-gnu-
+
 To build rk3588 boards:
 
 .. code-block:: bash
diff --git a/include/configs/rk3576_common.h b/include/configs/rk3576_common.h
new file mode 100644
index 00000000000..90ea62cb9ca
--- /dev/null
+++ b/include/configs/rk3576_common.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2024 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __CONFIG_RK3576_COMMON_H
+#define __CONFIG_RK3576_COMMON_H
+
+#define CFG_CPUID_OFFSET	0xa
+
+#include "rockchip-common.h"
+
+#define CFG_IRAM_BASE			0x3ff80000
+
+#define CFG_SYS_SDRAM_BASE		0x40000000
+/* Used by board_get_usable_ram_top(), space below the 4G address boundary */
+#define SDRAM_MAX_SIZE			(SZ_4G - CFG_SYS_SDRAM_BASE)
+
+#ifndef CONFIG_XPL_BUILD
+
+#ifndef ROCKCHIP_DEVICE_SETTINGS
+#define ROCKCHIP_DEVICE_SETTINGS
+#endif
+
+#define ENV_MEM_LAYOUT_SETTINGS		\
+	"scriptaddr=0x40c00000\0" \
+	"script_offset_f=0xffe000\0"	\
+	"script_size_f=0x2000\0"	\
+	"pxefile_addr_r=0x40e00000\0" \
+	"kernel_addr_r=0x42000000\0" \
+	"kernel_comp_addr_r=0x4a000000\0"	\
+	"fdt_addr_r=0x52000000\0"	\
+	"fdtoverlay_addr_r=0x52100000\0"	\
+	"ramdisk_addr_r=0x52180000\0"	\
+	"kernel_comp_size=0x8000000\0"
+
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	ENV_MEM_LAYOUT_SETTINGS		\
+	ROCKCHIP_DEVICE_SETTINGS	\
+	"boot_targets=" BOOT_TARGETS "\0"
+
+#endif /* CONFIG_XPL_BUILD */
+
+#endif /* __CONFIG_RK3576_COMMON_H */
-- 
2.47.2

