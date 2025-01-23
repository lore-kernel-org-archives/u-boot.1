Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2B0C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E5C8076E;
	Thu, 23 Jan 2025 23:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RfY6kBtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724F48076E; Thu, 23 Jan 2025 23:49:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B224A8076E
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737672540; bh=7SEbl33K0/0XyFxRDhk18mI6X9tlm3Vvuy2/GUMgsUE=;
 b=RfY6kBtBEn5KK9PpYWoVXhtxHX/pTmjBloAYRjTUejmrbDmS8Oggn9gX6HEjkgTEXTlPJIJRB
 hum1g5jnZ+IElrfuStjMDweffh2qiI/BTVW/qY3UKvt16ZGyIsvtxS+7fXUvnRlkEDkOulyX+/w
 LrV37tNp7cvUQoDOgwcc9MXlAkVD6zOA5JYJprPaY+fxKou0s428SKjQiJpYchicKlhA+rvqKfZ
 sY2QQya/PIxbXdBQCt2/w5brdvt3nJW9Ww26gXAJN5MgI1pUnZPLNFWHYohjHp2RLa4Il3+J1nS
 VoTCXWoL0i5Hv4/A2+BVSLpZkYlt6nfSlIlQLOvB0+Uw==
X-Forward-Email-ID: 6792c758f07771e5c89e0124
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/13] arch: arm: rockchip: Add initial support for RK3528
Date: Thu, 23 Jan 2025 22:48:14 +0000
Message-ID: <20250123224844.3104592-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123224844.3104592-1-jonas@kwiboo.se>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
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

Rockchip RK3528 is a ARM-based SoC with quad-core Cortex-A53.

Add initial arch support for the RK3528 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rk3528/boot0.h      |   9 ++
 arch/arm/include/asm/arch-rk3528/gpio.h       |   9 ++
 arch/arm/mach-rockchip/Kconfig                |  50 +++++++++
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rk3528/Kconfig         |  15 +++
 arch/arm/mach-rockchip/rk3528/Makefile        |   4 +
 arch/arm/mach-rockchip/rk3528/rk3528.c        | 104 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c |  19 ++++
 include/configs/rk3528_common.h               |  42 +++++++
 9 files changed, 253 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rk3528/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3528/gpio.h
 create mode 100644 arch/arm/mach-rockchip/rk3528/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3528/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3528/rk3528.c
 create mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
 create mode 100644 include/configs/rk3528_common.h

diff --git a/arch/arm/include/asm/arch-rk3528/boot0.h b/arch/arm/include/asm/arch-rk3528/boot0.h
new file mode 100644
index 000000000000..8ae46f25a87a
--- /dev/null
+++ b/arch/arm/include/asm/arch-rk3528/boot0.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright Contributors to the U-Boot project. */
+
+#ifndef __ASM_ARCH_BOOT0_H__
+#define __ASM_ARCH_BOOT0_H__
+
+#include <asm/arch-rockchip/boot0.h>
+
+#endif
diff --git a/arch/arm/include/asm/arch-rk3528/gpio.h b/arch/arm/include/asm/arch-rk3528/gpio.h
new file mode 100644
index 000000000000..5516e649b80b
--- /dev/null
+++ b/arch/arm/include/asm/arch-rk3528/gpio.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright Contributors to the U-Boot project. */
+
+#ifndef __ASM_ARCH_GPIO_H__
+#define __ASM_ARCH_GPIO_H__
+
+#include <asm/arch-rockchip/gpio.h>
+
+#endif
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 4d3157b2edd3..e4cf86107720 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -311,6 +311,55 @@ config ROCKCHIP_RK3399
 	  and video codec support. Peripherals include Gigabit Ethernet,
 	  USB2 host and OTG, SDIO, I2S, UARTs, SPI, I2C and PWMs.
 
+config ROCKCHIP_RK3528
+	bool "Support Rockchip RK3528"
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
+	  The Rockchip RK3528 is a ARM-based SoC with quad-core Cortex-A53.
+
 config ROCKCHIP_RK3568
 	bool "Support Rockchip RK3568"
 	select ARM64
@@ -628,6 +677,7 @@ source "arch/arm/mach-rockchip/rk3308/Kconfig"
 source "arch/arm/mach-rockchip/rk3328/Kconfig"
 source "arch/arm/mach-rockchip/rk3368/Kconfig"
 source "arch/arm/mach-rockchip/rk3399/Kconfig"
+source "arch/arm/mach-rockchip/rk3528/Kconfig"
 source "arch/arm/mach-rockchip/rk3568/Kconfig"
 source "arch/arm/mach-rockchip/rk3588/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 5e7edc99cdc4..5a7dd5b59400 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += rk3308/
 obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328/
 obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
 obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
+obj-$(CONFIG_ROCKCHIP_RK3528) += rk3528/
 obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
 obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
 obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
diff --git a/arch/arm/mach-rockchip/rk3528/Kconfig b/arch/arm/mach-rockchip/rk3528/Kconfig
new file mode 100644
index 000000000000..993b2dd274ea
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/Kconfig
@@ -0,0 +1,15 @@
+if ROCKCHIP_RK3528
+
+config ROCKCHIP_BOOT_MODE_REG
+	default 0xff370200
+
+config ROCKCHIP_STIMER_BASE
+	default 0xff620000
+
+config SYS_SOC
+	default "rk3528"
+
+config SYS_CONFIG_NAME
+	default "rk3528_common"
+
+endif
diff --git a/arch/arm/mach-rockchip/rk3528/Makefile b/arch/arm/mach-rockchip/rk3528/Makefile
new file mode 100644
index 000000000000..1ca1656f06e6
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-y += rk3528.o
+obj-y += syscon_rk3528.o
diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
new file mode 100644
index 000000000000..04e26dcbe16b
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#define LOG_CATEGORY LOGC_ARCH
+
+#include <dm.h>
+#include <misc.h>
+#include <asm/armv8/mmu.h>
+#include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/hardware.h>
+
+const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
+	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@ffbf0000",
+	[BROM_BOOTSOURCE_SD] = "/soc/mmc@ffc30000",
+};
+
+static struct mm_region rk3528_mem_map[] = {
+	{
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 0xfc000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0xfc000000UL,
+		.phys = 0xfc000000UL,
+		.size = 0x04000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = rk3528_mem_map;
+
+void board_debug_uart_init(void)
+{
+}
+
+#ifdef CONFIG_XPL_BUILD
+
+#define HP_TIMER_BASE			CONFIG_ROCKCHIP_STIMER_BASE
+#define HP_CTRL_REG			0x04
+#define TIMER_EN			BIT(0)
+#define HP_LOAD_COUNT0_REG		0x14
+#define HP_LOAD_COUNT1_REG		0x18
+
+void rockchip_stimer_init(void)
+{
+	u32 reg = readl(HP_TIMER_BASE + HP_CTRL_REG);
+
+	if (reg & TIMER_EN)
+		return;
+
+	asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
+	writel(TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
+}
+#endif
+
+#define RK3528_OTP_CPU_CODE_OFFSET		0x02
+#define RK3528_OTP_CPU_CHIP_TYPE_OFFSET		0x28
+
+int checkboard(void)
+{
+	u8 cpu_code[2], chip_type;
+	struct udevice *dev;
+	char suffix[2];
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
+		return 0;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_otp), &dev);
+	if (ret) {
+		log_debug("Could not find otp device, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* cpu-code: SoC model, e.g. 0x35 0x28 */
+	ret = misc_read(dev, RK3528_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		log_debug("Could not read cpu-code, ret=%d\n", ret);
+		return 0;
+	}
+
+	ret = misc_read(dev, RK3528_OTP_CPU_CHIP_TYPE_OFFSET, &chip_type, 1);
+	if (ret < 0) {
+		log_debug("Could not read chip type, ret=%d\n", ret);
+		return 0;
+	}
+
+	suffix[0] = chip_type != 0x1 ? 'A' : '\0';
+	suffix[1] = '\0';
+
+	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
+
+	return 0;
+}
diff --git a/arch/arm/mach-rockchip/rk3528/syscon_rk3528.c b/arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
new file mode 100644
index 000000000000..4a32a5f732e9
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#include <dm.h>
+#include <asm/arch-rockchip/clock.h>
+
+static const struct udevice_id rk3528_syscon_ids[] = {
+	{ .compatible = "rockchip,rk3528-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3528_syscon) = {
+	.name = "rockchip_rk3528_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = rk3528_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
+};
diff --git a/include/configs/rk3528_common.h b/include/configs/rk3528_common.h
new file mode 100644
index 000000000000..5c50a980e0ec
--- /dev/null
+++ b/include/configs/rk3528_common.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright Contributors to the U-Boot project. */
+
+#ifndef __CONFIG_RK3528_COMMON_H
+#define __CONFIG_RK3528_COMMON_H
+
+#define CFG_CPUID_OFFSET		0xa
+
+#include "rockchip-common.h"
+
+#define CFG_IRAM_BASE			0xfe480000
+
+#define CFG_SYS_SDRAM_BASE		0
+#define SDRAM_MAX_SIZE			0xfc000000
+
+#ifndef CONFIG_XPL_BUILD
+
+#ifndef ROCKCHIP_DEVICE_SETTINGS
+#define ROCKCHIP_DEVICE_SETTINGS
+#endif
+
+#define ENV_MEM_LAYOUT_SETTINGS			\
+	"scriptaddr=0x00c00000\0"		\
+	"script_offset_f=0xffe000\0"		\
+	"script_size_f=0x2000\0"		\
+	"pxefile_addr_r=0x00e00000\0"		\
+	"kernel_addr_r=0x02000000\0"		\
+	"kernel_comp_addr_r=0x0a000000\0"	\
+	"fdt_addr_r=0x12000000\0"		\
+	"fdtoverlay_addr_r=0x12100000\0"	\
+	"ramdisk_addr_r=0x12180000\0"		\
+	"kernel_comp_size=0x8000000\0"
+
+#define CFG_EXTRA_ENV_SETTINGS			\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	ENV_MEM_LAYOUT_SETTINGS			\
+	ROCKCHIP_DEVICE_SETTINGS		\
+	"boot_targets=" BOOT_TARGETS "\0"
+
+#endif /* CONFIG_XPL_BUILD */
+
+#endif /* __CONFIG_RK3528_COMMON_H */
-- 
2.48.1

