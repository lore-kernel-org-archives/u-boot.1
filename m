Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD6AC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC28A8320C;
	Tue,  8 Apr 2025 00:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SGLy3qpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8D2831F5; Tue,  8 Apr 2025 00:49:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09E1B82E77
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066144; bh=XLUE8CuOcF8p05tmEipnpRL7Cjk1BJswaSgMRaeESCI=;
 b=SGLy3qpF0hAPBvx8llZ9eiaQGH3v/j+fDneZIYZJd90TWzPqbqK9Ua4Ed8uujfDrwnYion59P
 h7yui56auEzKI06A1Z6NDukch3XO35qzX2zkdbNY8tDw1+zC2lfGoo/NfjWChyqUHSQ/BKr1gw0
 JrFHXpyMD1+AUZx7yMYttPqXe52htMQm3cKWk/mqoXLbshwjJpZehhNozQS5zXlvirH1yAnIPOt
 vKmYDjL1UelKEOWsu2LF3yRJ5t/B3GTwYZNao/Af2W5OtkHlcYhzkYMdDn7RBhWfTFQYRO/MX9j
 f+N0NY5+wqrOsG9XEjUZjt90rXfifOqjLNNBVk1ajjcA==
X-Forward-Email-ID: 67f4565c9fd75b9b96512907
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 19/30] arch: arm: rockchip: Add initial support for RK3528
Date: Mon,  7 Apr 2025 22:46:52 +0000
Message-ID: <20250407224743.2423921-20-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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
Changes in v2:
- Add FIREWALL_DDR handling to fix emmc/fspi/sdmmc/usb dma
- Add imply SYSRESET_PSCI if SPL_ATF
- Add USB_GADGET_PRODUCT_NUM for RK3528
- Drop ifndef CONFIG_XPL_BUILD in rk3528_common.h
---
 arch/arm/include/asm/arch-rk3528/boot0.h      |   9 ++
 arch/arm/include/asm/arch-rk3528/gpio.h       |   9 ++
 arch/arm/mach-rockchip/Kconfig                |  51 +++++++
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rk3528/Kconfig         |  15 ++
 arch/arm/mach-rockchip/rk3528/Makefile        |   5 +
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c    |  16 ++
 arch/arm/mach-rockchip/rk3528/rk3528.c        | 137 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c |  19 +++
 drivers/usb/gadget/Kconfig                    |   1 +
 include/configs/rk3528_common.h               |  38 +++++
 11 files changed, 301 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rk3528/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3528/gpio.h
 create mode 100644 arch/arm/mach-rockchip/rk3528/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3528/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3528/clk_rk3528.c
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
index f349431bb43c..be1525848411 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -322,6 +322,56 @@ config ROCKCHIP_RK3399
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
+	imply SYSRESET_PSCI if SPL_ATF
+	help
+	  The Rockchip RK3528 is a ARM-based SoC with a quad-core Cortex-A53.
+
 config ROCKCHIP_RK3568
 	bool "Support Rockchip RK3568"
 	select ARM64
@@ -652,6 +702,7 @@ source "arch/arm/mach-rockchip/rk3308/Kconfig"
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
index 000000000000..f0c18cd39d29
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-y += rk3528.o
+obj-y += clk_rk3528.o
+obj-y += syscon_rk3528.o
diff --git a/arch/arm/mach-rockchip/rk3528/clk_rk3528.c b/arch/arm/mach-rockchip/rk3528/clk_rk3528.c
new file mode 100644
index 000000000000..6e77f11cbec0
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/clk_rk3528.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#include <dm.h>
+#include <asm/arch-rockchip/cru_rk3528.h>
+
+int rockchip_get_clk(struct udevice **devp)
+{
+	return uclass_get_device_by_driver(UCLASS_CLK,
+				DM_DRIVER_GET(rockchip_rk3528_cru), devp);
+}
+
+void *rockchip_get_cru(void)
+{
+	return RK3528_CRU_BASE;
+}
diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
new file mode 100644
index 000000000000..4892ff6ba9d2
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
@@ -0,0 +1,137 @@
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
+#define FIREWALL_DDR_BASE		0xff2e0000
+#define FW_DDR_MST6_REG			0x58
+#define FW_DDR_MST7_REG			0x5c
+#define FW_DDR_MST14_REG		0x78
+#define FW_DDR_MST16_REG		0x80
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
+int arch_cpu_init(void)
+{
+	u32 val;
+
+	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+		return 0;
+
+	/* Set the emmc to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST6_REG);
+	writel(val & 0x0000ffff, FIREWALL_DDR_BASE + FW_DDR_MST6_REG);
+
+	/* Set the fspi to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST7_REG);
+	writel(val & 0xffff0000, FIREWALL_DDR_BASE + FW_DDR_MST7_REG);
+
+	/* Set the sdmmc to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST14_REG);
+	writel(val & 0x0000ffff, FIREWALL_DDR_BASE + FW_DDR_MST14_REG);
+
+	/* Set the usb to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST16_REG);
+	writel(val & 0xffff0000, FIREWALL_DDR_BASE + FW_DDR_MST16_REG);
+
+	return 0;
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
+	writel(TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
+}
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
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index c815764c2bc4..46a83141481f 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -85,6 +85,7 @@ config USB_GADGET_PRODUCT_NUM
 	default 0x330e if ROCKCHIP_RK3308
 	default 0x350a if ROCKCHIP_RK3568
 	default 0x350b if ROCKCHIP_RK3588
+	default 0x350c if ROCKCHIP_RK3528
 	default 0x0
 	help
 	  Product ID of the USB device emulated, reported to the host device.
diff --git a/include/configs/rk3528_common.h b/include/configs/rk3528_common.h
new file mode 100644
index 000000000000..f7dc6ecd5944
--- /dev/null
+++ b/include/configs/rk3528_common.h
@@ -0,0 +1,38 @@
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
+#endif /* __CONFIG_RK3528_COMMON_H */
-- 
2.49.0

