Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B1EE7C6FA
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 23:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB3A83E62;
	Sun,  1 Feb 2026 00:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ColYgOXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CFD83E62; Sun,  1 Feb 2026 00:40:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4025183E3A
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 00:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769902801; bh=hBcwWEsKVweNZ4uV4wY9N2AXZPCkz6hBUXYB8Yjk0rQ=;
 b=ColYgOXLB6YHY+T0+fgsGtoEsO0SUpNj9xdY/+8PMRjBQE501pOJ7EVPHZAw8yO/RFrbvAuwV
 RVF9cFeqOCbq/8JX0WDkYwgAaDb82hY7ED4DGWP39EHc5SLcggVoZ3lUq/AwDONTfVI6qD0ZUM2
 hHwcVDIjWdRZaPDeTh4O9c5HsGE/RdWkOpsmGLpM10gO3nT2qH/D1rKDREXF/uuV8HVo8JUkdSP
 SqxGFbp6ZK7XlMuN7quAy3BUisYj3WrOXy8wrToROWLtcaoszPrYc3+d1rH9Rzv+I+8FTtDToh6
 D3KDs/0yLd16Sry526JaBTmIcuHnZWPNjMiRmtYUO+Zg==
X-Forward-Email-ID: 697e92c6de426c19931e066c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 12/12] arch: arm: rockchip: Add initial support for RK3506
Date: Sat, 31 Jan 2026 23:38:23 +0000
Message-ID: <20260131233843.3419737-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233843.3419737-1-jonas@kwiboo.se>
References: <20260131233843.3419737-1-jonas@kwiboo.se>
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

Rockchip RK3506 is a ARM-based SoC with tri-core Cortex-A7.

Add initial arch support for the RK3506 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # drivers/usb/gadget
---
Changes in v2:
- Enable SPL_ARMV7_SET_CORTEX_SMPEN
- Drop read_brom_bootsource_id() now that default impl support 0x81
- Fix mac1 and otg1 access to ddr memory
- Collect a-b tag
---
 arch/arm/include/asm/arch-rk3506/boot0.h      |   9 ++
 arch/arm/include/asm/arch-rk3506/gpio.h       |   9 ++
 arch/arm/mach-rockchip/Kconfig                |  44 ++++++
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rk3506/Kconfig         |  15 +++
 arch/arm/mach-rockchip/rk3506/Makefile        |   5 +
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |  16 +++
 arch/arm/mach-rockchip/rk3506/rk3506.c        | 125 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c |  19 +++
 drivers/usb/gadget/Kconfig                    |   1 +
 include/configs/rk3506_common.h               |  38 ++++++
 11 files changed, 282 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rk3506/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3506/gpio.h
 create mode 100644 arch/arm/mach-rockchip/rk3506/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3506/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3506/clk_rk3506.c
 create mode 100644 arch/arm/mach-rockchip/rk3506/rk3506.c
 create mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
 create mode 100644 include/configs/rk3506_common.h

diff --git a/arch/arm/include/asm/arch-rk3506/boot0.h b/arch/arm/include/asm/arch-rk3506/boot0.h
new file mode 100644
index 000000000000..8ae46f25a87a
--- /dev/null
+++ b/arch/arm/include/asm/arch-rk3506/boot0.h
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
diff --git a/arch/arm/include/asm/arch-rk3506/gpio.h b/arch/arm/include/asm/arch-rk3506/gpio.h
new file mode 100644
index 000000000000..5516e649b80b
--- /dev/null
+++ b/arch/arm/include/asm/arch-rk3506/gpio.h
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
index 92bb4aa62f11..dcaf15a3161e 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -317,6 +317,49 @@ config ROCKCHIP_RK3399
 	  and video codec support. Peripherals include Gigabit Ethernet,
 	  USB2 host and OTG, SDIO, I2S, UARTs, SPI, I2C and PWMs.
 
+config ROCKCHIP_RK3506
+	bool "Support Rockchip RK3506"
+	select CPU_V7A
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
+	imply BOOTSTD_FULL
+	imply DM_RNG
+	imply ENV_RELOC_GD_ENV_ADDR
+	imply FIT
+	imply LEGACY_IMAGE_FORMAT
+	imply MISC
+	imply MISC_INIT_R
+	imply OF_LIBFDT_OVERLAY
+	imply OF_LIVE
+	imply RNG_ROCKCHIP
+	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
+	imply ROCKCHIP_OTP
+	imply SPL_ARMV7_SET_CORTEX_SMPEN
+	imply SPL_CLK
+	imply SPL_DM_SEQ_ALIAS
+	imply SPL_FIT_SIGNATURE
+	imply SPL_LOAD_FIT
+	imply SPL_OF_CONTROL
+	imply SPL_PINCTRL
+	imply SPL_RAM
+	imply SPL_REGMAP
+	imply SPL_SERIAL
+	imply SPL_SYSCON
+	imply SYS_ARCH_TIMER
+	imply SYSRESET
+	help
+	  The Rockchip RK3506 is a ARM-based SoC with a tri-core Cortex-A7.
+
 config ROCKCHIP_RK3528
 	bool "Support Rockchip RK3528"
 	select ARM64
@@ -745,6 +788,7 @@ source "arch/arm/mach-rockchip/rk3308/Kconfig"
 source "arch/arm/mach-rockchip/rk3328/Kconfig"
 source "arch/arm/mach-rockchip/rk3368/Kconfig"
 source "arch/arm/mach-rockchip/rk3399/Kconfig"
+source "arch/arm/mach-rockchip/rk3506/Kconfig"
 source "arch/arm/mach-rockchip/rk3528/Kconfig"
 source "arch/arm/mach-rockchip/rk3568/Kconfig"
 source "arch/arm/mach-rockchip/rk3576/Kconfig"
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 06fb527b21a0..d3bc0689f893 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += rk3308/
 obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328/
 obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
 obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
+obj-$(CONFIG_ROCKCHIP_RK3506) += rk3506/
 obj-$(CONFIG_ROCKCHIP_RK3528) += rk3528/
 obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
 obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
diff --git a/arch/arm/mach-rockchip/rk3506/Kconfig b/arch/arm/mach-rockchip/rk3506/Kconfig
new file mode 100644
index 000000000000..92f187458c66
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3506/Kconfig
@@ -0,0 +1,15 @@
+if ROCKCHIP_RK3506
+
+config ROCKCHIP_BOOT_MODE_REG
+	default 0xff910200
+
+config ROCKCHIP_STIMER_BASE
+	default 0xff980000
+
+config SYS_SOC
+	default "rk3506"
+
+config SYS_CONFIG_NAME
+	default "rk3506_common"
+
+endif
diff --git a/arch/arm/mach-rockchip/rk3506/Makefile b/arch/arm/mach-rockchip/rk3506/Makefile
new file mode 100644
index 000000000000..a1760bd0f0a3
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3506/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-y += rk3506.o
+obj-y += clk_rk3506.o
+obj-y += syscon_rk3506.o
diff --git a/arch/arm/mach-rockchip/rk3506/clk_rk3506.c b/arch/arm/mach-rockchip/rk3506/clk_rk3506.c
new file mode 100644
index 000000000000..96723f403cfe
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3506/clk_rk3506.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#include <dm.h>
+#include <asm/arch-rockchip/cru_rk3506.h>
+
+int rockchip_get_clk(struct udevice **devp)
+{
+	return uclass_get_device_by_driver(UCLASS_CLK,
+				DM_DRIVER_GET(rockchip_rk3506_cru), devp);
+}
+
+void *rockchip_get_cru(void)
+{
+	return (void *)RK3506_CRU_BASE;
+}
diff --git a/arch/arm/mach-rockchip/rk3506/rk3506.c b/arch/arm/mach-rockchip/rk3506/rk3506.c
new file mode 100644
index 000000000000..2ed1dcc128e0
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3506/rk3506.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#define LOG_CATEGORY LOGC_ARCH
+
+#include <dm.h>
+#include <misc.h>
+#include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/hardware.h>
+
+#define SGRF_BASE			0xff210000
+
+#define FIREWALL_DDR_BASE		0xff5f0000
+#define FW_DDR_MST1_REG			0x24
+#define FW_DDR_MST2_REG			0x28
+#define FW_DDR_MST3_REG			0x2c
+
+const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
+	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@ff480000",
+	[BROM_BOOTSOURCE_SD] = "/soc/mmc@ff480000",
+};
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
+	/* Select non-secure OTPC */
+	rk_clrreg(SGRF_BASE + 0x100, BIT(1));
+
+	/* Set the sdmmc/emmc to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
+	writel(val & 0xffff00ff, FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
+
+	/* Set the fspi to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
+	writel(val & 0xff00ffff, FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
+
+	/* Set the mac0 to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
+	writel(val & 0xf0ffffff, FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
+
+	/* Set the mac1 to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST2_REG);
+	writel(val & 0xfffffff0, FIREWALL_DDR_BASE + FW_DDR_MST2_REG);
+
+	/* Set the otg1 to access ddr memory */
+	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST3_REG);
+	writel(val & 0xfff0ffff, FIREWALL_DDR_BASE + FW_DDR_MST3_REG);
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
+	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (CONFIG_COUNTER_FREQUENCY));
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
+	writel((TIMER_EN << 16) | TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
+}
+
+#define RK3506_OTP_CPU_CODE_OFFSET		0x02
+#define RK3506_OTP_SPECIFICATION_OFFSET		0x08
+
+int checkboard(void)
+{
+	u8 cpu_code[2], specification;
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
+	/* cpu-code: SoC model, e.g. 0x35 0x06 */
+	ret = misc_read(dev, RK3506_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		log_debug("Could not read cpu-code, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, e.g. 0xA for RK3506J */
+	ret = misc_read(dev, RK3506_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		log_debug("Could not read specification, ret=%d\n", ret);
+		return 0;
+	}
+	specification &= 0x1f;
+
+	/* for RK3506J i.e. '@' + 0xA = 'J' */
+	suffix[0] = specification > 1 ? '@' + specification : '\0';
+	suffix[1] = '\0';
+
+	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
+
+	return 0;
+}
diff --git a/arch/arm/mach-rockchip/rk3506/syscon_rk3506.c b/arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
new file mode 100644
index 000000000000..2548b0fa2d3a
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#include <dm.h>
+#include <asm/arch-rockchip/clock.h>
+
+static const struct udevice_id rk3506_syscon_ids[] = {
+	{ .compatible = "rockchip,rk3506-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3506_syscon) = {
+	.name = "rockchip_rk3506_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = rk3506_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
+};
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index ebb306852a65..baa2eb61ea33 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -89,6 +89,7 @@ config USB_GADGET_PRODUCT_NUM
 	default 0x350b if ROCKCHIP_RK3588
 	default 0x350c if ROCKCHIP_RK3528
 	default 0x350e if ROCKCHIP_RK3576
+	default 0x350f if ROCKCHIP_RK3506
 	default 0x4ee0 if ARCH_SNAPDRAGON
 	default 0x0
 	help
diff --git a/include/configs/rk3506_common.h b/include/configs/rk3506_common.h
new file mode 100644
index 000000000000..5e4ef67289f0
--- /dev/null
+++ b/include/configs/rk3506_common.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright Contributors to the U-Boot project. */
+
+#ifndef __CONFIG_RK3506_COMMON_H
+#define __CONFIG_RK3506_COMMON_H
+
+#define CFG_CPUID_OFFSET		0xa
+
+#include "rockchip-common.h"
+
+#define CFG_IRAM_BASE			0xfff80000
+
+#define CFG_SYS_SDRAM_BASE		0
+#define SDRAM_MAX_SIZE			0xc0000000
+
+#ifndef ROCKCHIP_DEVICE_SETTINGS
+#define ROCKCHIP_DEVICE_SETTINGS
+#endif
+
+#define ENV_MEM_LAYOUT_SETTINGS			\
+	"scriptaddr=0x00500000\0"		\
+	"script_offset_f=0xffe000\0"		\
+	"script_size_f=0x2000\0"		\
+	"pxefile_addr_r=0x00600000\0"		\
+	"kernel_addr_r=0x02080000\0"		\
+	"kernel_comp_addr_r=0x08000000\0"	\
+	"fdt_addr_r=0x01e00000\0"		\
+	"fdtoverlay_addr_r=0x01f00000\0"	\
+	"ramdisk_addr_r=0x06000000\0"		\
+	"kernel_comp_size=0x2000000\0"
+
+#define CFG_EXTRA_ENV_SETTINGS			\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	ENV_MEM_LAYOUT_SETTINGS			\
+	ROCKCHIP_DEVICE_SETTINGS		\
+	"boot_targets=" BOOT_TARGETS "\0"
+
+#endif /* __CONFIG_RK3506_COMMON_H */
-- 
2.52.0

