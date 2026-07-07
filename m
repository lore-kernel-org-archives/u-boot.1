Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48B6C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E194A84AE2;
	Tue,  7 Jul 2026 17:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AGl9P1VO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B8684AF7; Tue,  7 Jul 2026 17:33:08 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D7784AFF
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9f6e7846bso1938880a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438384; x=1784043184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+XguByM1sd2w/MDNKH31ewO5PtL05j2AeF4JSN9/FyI=;
 b=AGl9P1VO5zzdOj2yyGhgc7O9dbuljsI7OrexSsLzHOa7Zt/mgv/NjBnoHNWInRBfOJ
 YEmbi+FtnKVdPq2CjIWK/XUV5XFFviODViFUNU88EzAYzpO4SsU8V8Lu5MpokEMUR6o0
 8CLpQQrFLLlwx3ctCZbAQ1W7jAZUMMhpAyWuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438384; x=1784043184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+XguByM1sd2w/MDNKH31ewO5PtL05j2AeF4JSN9/FyI=;
 b=I9EG3/Y7Jf5Ek1RmFHavh4PVR1VEO0Z3HhvAPrqUaMZGAW2tk9ivLkfJVwSwaSyz7H
 pl5La5TgZs/0096sGM652UWcgf32xNl4KaLUq8Q72KFnq/e1L/wgQILY7+y2VoMPVlLc
 IWUKcM0MYEtWPrAbdO2SHQ8IyVyyW62yUB0x01rx6Gr7sx3z72/DvnB+nNkQkJWKM5y/
 2ltCNZjwV3OJmOz2bPyUZ8dHQgHo7P95aCwbbukeoZS2r5g9AshNO1lRDKpdX64+vpyA
 z+NZuOMMrpA3zo5RedlCyZdrMXfZOODVzmv5QeVqauFEFIlZGduz42JSsvN4jdAIoTjg
 yJNw==
X-Gm-Message-State: AOJu0YyKU2e3kRWiNhkjoWm/pM9Nemfwnu0u/cBf5X4Hej5LWhmEKa+k
 JHFHN8IXcHSd809fEopyy7JZ19h9I4cTgK3UhGc3YoKd6twTNISA273YyFmEnuu2IOsp8Qhusb5
 JK+NgyA==
X-Gm-Gg: AfdE7cnFF3xTcpgJlI5PV553dYvC1gLVhhMifUOOl13/AT/uKK1MET/7+JMkwjtPEhx
 hCT2xlMpkBamwnKwliacK8FkSsTTcOaQhPiCU4W4wY0dm5d5CuAA2ygsb37YIMXfhNkbPwIZNu+
 eBua7KCWXOfx0o/9M6TfFkx/Kih7tixRZt+QiXopOPALJJDjin1n/eGJ5fKU6Ai/HNZHZcYGsXW
 GBycBe2r2cxZEcBTsHrFrc+iB7/U5flH7BkxNKsQIsvXMkqajWMU769v1wPLvngtsM8igW4VgRX
 G/bJEw4ixjhM9rige5EXS4ms1Izex+BYjbwlDCoQA1o9nrb+KR4sga1okZJmKD71RNEZLTEGOBY
 q9aXwr5Hew7CXhH9TZKa5P/3iRoiXIvWe9rMmCGZdoOj+7iYsN9mJjdieVYDU0g/92k818q/+T1
 mdHip3KP0=
X-Received: by 2002:a05:6808:1455:b0:493:b20:d7cb with SMTP id
 5614622812f47-49fdbe40292mr3396434b6e.1.1783438384064; 
 Tue, 07 Jul 2026 08:33:04 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:33:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 13/15] rockchip: rv1106: Add SoC support
Date: Tue,  7 Jul 2026 09:31:11 -0600
Message-ID: <20260707153135.2048115-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

The RV1106 is an ARM-based SoC with a single Cortex-A7 32-bit core
which integrates NEON and FPU. It contains a built-in NPU for AI
related applications. The RV1103 is a package variant of the RV1106
with fewer pins.

Add the core SoC support for it: the Kconfig and Makefile entries, the
boot0 hook, the SoC init code (firewall setup, watchdog release and
the pvtpll reboot workaround from the vendor tree), the syscon driver
and the SoC u-boot.dtsi

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rv1106-u-boot.dtsi               |   4 +
 arch/arm/include/asm/arch-rv1106/boot0.h      |  11 ++
 arch/arm/mach-rockchip/Kconfig                |  15 +++
 arch/arm/mach-rockchip/Makefile               |   1 +
 arch/arm/mach-rockchip/rv1106/Kconfig         |  28 +++++
 arch/arm/mach-rockchip/rv1106/Makefile        |  12 ++
 arch/arm/mach-rockchip/rv1106/clk_rv1106.c    |  31 +++++
 arch/arm/mach-rockchip/rv1106/rv1106.c        | 118 ++++++++++++++++++
 arch/arm/mach-rockchip/rv1106/syscon_rv1106.c |  19 +++
 board/luckfox/pico/Kconfig                    |  12 ++
 include/configs/rv1106_common.h               |  13 ++
 11 files changed, 264 insertions(+)
 create mode 100644 arch/arm/dts/rv1106-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-rv1106/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1106/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1106/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1106/clk_rv1106.c
 create mode 100644 arch/arm/mach-rockchip/rv1106/rv1106.c
 create mode 100644 arch/arm/mach-rockchip/rv1106/syscon_rv1106.c
 create mode 100644 board/luckfox/pico/Kconfig
 create mode 100644 include/configs/rv1106_common.h

diff --git a/arch/arm/dts/rv1106-u-boot.dtsi b/arch/arm/dts/rv1106-u-boot.dtsi
new file mode 100644
index 00000000000..fa062c8ee84
--- /dev/null
+++ b/arch/arm/dts/rv1106-u-boot.dtsi
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) Copyright 2022 Rockchip Electronics Co., Ltd
+
+#include "rockchip-u-boot.dtsi"
diff --git a/arch/arm/include/asm/arch-rv1106/boot0.h b/arch/arm/include/asm/arch-rv1106/boot0.h
new file mode 100644
index 00000000000..e132eb98116
--- /dev/null
+++ b/arch/arm/include/asm/arch-rv1106/boot0.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2022 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __ASM_ARCH_BOOT0_H__
+#define __ASM_ARCH_BOOT0_H__
+
+#include <asm/arch-rockchip/boot0.h>
+
+#endif
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1969c313f47..5b1032f258b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -544,6 +544,20 @@ config ROCKCHIP_RV1103B
 	  32-bit core which integrates NEON and FPU.
 	  It contains a built-in NPU for AI related applications.
 
+config ROCKCHIP_RV1106
+	bool "Support Rockchip RV1106"
+	select CPU_V7A
+	select SPL_ARMV7_SET_CORTEX_SMPEN
+	select SUPPORT_SPL
+	select SPL
+	imply ROCKCHIP_COMMON_BOARD
+	help
+	  The Rockchip RV1106 is an ARM-based SoC with a single Cortex-A7
+	  32-bit core which integrates NEON and FPU. It contains a built-in
+	  NPU for AI related applications. The RV1103 is a package variant
+	  of the RV1106 with fewer pins and is also supported by this
+	  option.
+
 config ROCKCHIP_RV1108
 	bool "Support Rockchip RV1108"
 	select CPU_V7A
@@ -808,6 +822,7 @@ source "arch/arm/mach-rockchip/rk3568/Kconfig"
 source "arch/arm/mach-rockchip/rk3576/Kconfig"
 source "arch/arm/mach-rockchip/rk3588/Kconfig"
 source "arch/arm/mach-rockchip/rv1103b/Kconfig"
+source "arch/arm/mach-rockchip/rv1106/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
 
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index e09dc44a7ad..0d42ddbe678 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
 obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
 obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
 obj-$(CONFIG_ROCKCHIP_RV1103B) += rv1103b/
+obj-$(CONFIG_ROCKCHIP_RV1106) += rv1106/
 obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
 obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
 
diff --git a/arch/arm/mach-rockchip/rv1106/Kconfig b/arch/arm/mach-rockchip/rv1106/Kconfig
new file mode 100644
index 00000000000..05eafd96833
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1106/Kconfig
@@ -0,0 +1,28 @@
+if ROCKCHIP_RV1106
+
+config TARGET_LUCKFOX_PICO_RV1103
+	bool "LUCKFOX_PICO_RV1103"
+	help
+	  Support Luckfox's Pico series of RV1103 boards, such as the Pico
+	  Mini B. These are small, low-cost boards with 64MB of in-package
+	  DDR2, a microSD slot and a USB-C port used for both power and
+	  maskrom-mode USB download; most I/O is on castellated edge pins.
+	  The Mini B adds a 128MB Winbond SPI NAND, from which it boots.
+	  U-Boot can also run entirely from RAM over USB, with nothing
+	  written to the flash.
+
+config ROCKCHIP_BOOT_MODE_REG
+	default 0xff020200
+
+config ROCKCHIP_STIMER_BASE
+	default 0xff590020
+
+config SYS_SOC
+	default "rv1106"
+
+config SYS_MALLOC_F_LEN
+	default 0x400
+
+source "board/luckfox/pico/Kconfig"
+
+endif
diff --git a/arch/arm/mach-rockchip/rv1106/Makefile b/arch/arm/mach-rockchip/rv1106/Makefile
new file mode 100644
index 00000000000..66aba9fbfe2
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1106/Makefile
@@ -0,0 +1,12 @@
+#
+# (C) Copyright 2022 Rockchip Electronics Co., Ltd
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y += rv1106.o
+obj-y += clk_rv1106.o
+
+ifndef CONFIG_XPL_BUILD
+obj-y += syscon_rv1106.o
+endif
diff --git a/arch/arm/mach-rockchip/rv1106/clk_rv1106.c b/arch/arm/mach-rockchip/rv1106/clk_rv1106.c
new file mode 100644
index 00000000000..86020c45c22
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1106/clk_rv1106.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2022 Rockchip Electronics Co., Ltd
+ */
+
+#include <dm.h>
+#include <syscon.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/cru_rv1106.h>
+#include <linux/err.h>
+
+int rockchip_get_clk(struct udevice **devp)
+{
+	return uclass_get_device_by_driver(UCLASS_CLK,
+			DM_DRIVER_GET(rockchip_rv1106_cru), devp);
+}
+
+void *rockchip_get_cru(void)
+{
+	struct rv1106_clk_priv *priv;
+	struct udevice *dev;
+	int ret;
+
+	ret = rockchip_get_clk(&dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	priv = dev_get_priv(dev);
+
+	return priv->cru;
+}
diff --git a/arch/arm/mach-rockchip/rv1106/rv1106.c b/arch/arm/mach-rockchip/rv1106/rv1106.c
new file mode 100644
index 00000000000..a93c3e5f2fe
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1106/rv1106.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2022 Rockchip Electronics Co., Ltd
+ */
+
+#include <dm.h>
+#include <spl.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define PERI_GRF_BASE			0xff000000
+#define PERI_GRF_PERI_CON1		0x0004
+
+#define PERI_SGRF_BASE			0xff070000
+#define PERI_SGRF_FIREWALL_CON0		0x0020
+#define PERI_SGRF_FIREWALL_CON1		0x0024
+#define PERI_SGRF_FIREWALL_CON2		0x0028
+#define PERI_SGRF_FIREWALL_CON3		0x002c
+#define PERI_SGRF_FIREWALL_CON4		0x0030
+#define PERI_SGRF_SOC_CON3		0x00bc
+
+#define CORE_SGRF_BASE			0xff076000
+#define CORE_SGRF_FIREWALL_CON0		0x0020
+#define CORE_SGRF_FIREWALL_CON1		0x0024
+#define CORE_SGRF_FIREWALL_CON2		0x0028
+#define CORE_SGRF_FIREWALL_CON3		0x002c
+#define CORE_SGRF_FIREWALL_CON4		0x0030
+#define CORE_SGRF_CPU_CTRL_CON		0x0040
+
+#define PMU_SGRF_BASE			0xff080000
+
+#define FW_DDR_BASE			0xff900000
+#define FW_DDR_MST3_REG			0x4c
+#define FW_SHRM_BASE			0xff910000
+#define FW_SHRM_MST1_REG		0x44
+
+#define CRU_BASE			0xff3b0000
+#define CRU_GLB_RST_CON			0x0c10
+#define CRU_PVTPLL0_CON0_L		0x1000
+#define CRU_PVTPLL0_CON1_L		0x1008
+#define CRU_PVTPLL1_CON0_L		0x1030
+#define CRU_PVTPLL1_CON1_L		0x1038
+
+#define VICRU_BASE			0xff3b4000
+#define VICRU_VISOFTRST_CON01		0x0a04
+
+#define CHIP_VER_REG			0xff020204
+#define CHIP_VER_MSK			0x7
+#define V(x)				((x) - 1)
+#define ROM_VER_REG			0xffff4ffc
+#define ROM_V2				0x30303256
+
+void board_debug_uart_init(void)
+{
+	/* The BootROM leaves the debug UART configured */
+}
+
+static void rv1106_xpl_init(void)
+{
+	/* Save the chip version to OS_REG1[2:0] */
+	if (readl(ROM_VER_REG) == ROM_V2)
+		writel((readl(CHIP_VER_REG) & ~CHIP_VER_MSK) | V(2),
+		       CHIP_VER_REG);
+	else
+		writel((readl(CHIP_VER_REG) & ~CHIP_VER_MSK) | V(1),
+		       CHIP_VER_REG);
+
+	/* Set all devices to non-secure */
+	writel(0xffff0000, PERI_SGRF_BASE + PERI_SGRF_FIREWALL_CON0);
+	writel(0xffff0000, PERI_SGRF_BASE + PERI_SGRF_FIREWALL_CON1);
+	writel(0xffff0000, PERI_SGRF_BASE + PERI_SGRF_FIREWALL_CON2);
+	writel(0xffff0000, PERI_SGRF_BASE + PERI_SGRF_FIREWALL_CON3);
+	writel(0xffff0000, PERI_SGRF_BASE + PERI_SGRF_FIREWALL_CON4);
+	writel(0x000f0000, PERI_SGRF_BASE + PERI_SGRF_SOC_CON3);
+	writel(0xffff0000, CORE_SGRF_BASE + CORE_SGRF_FIREWALL_CON0);
+	writel(0xffff0000, CORE_SGRF_BASE + CORE_SGRF_FIREWALL_CON1);
+	writel(0xffff0000, CORE_SGRF_BASE + CORE_SGRF_FIREWALL_CON2);
+	writel(0xffff0000, CORE_SGRF_BASE + CORE_SGRF_FIREWALL_CON3);
+	writel(0xffff0000, CORE_SGRF_BASE + CORE_SGRF_FIREWALL_CON4);
+	writel(0x00030002, CORE_SGRF_BASE + CORE_SGRF_CPU_CTRL_CON);
+	writel(0x20000000, PMU_SGRF_BASE);
+
+	/* Allow the eMMC and FSPI to access the secure area */
+	writel(0x00000000, FW_DDR_BASE + FW_DDR_MST3_REG);
+	writel(0xff00ffff, FW_SHRM_BASE + FW_SHRM_MST1_REG);
+
+	/* Release the watchdog */
+	writel(0x2000200, PERI_GRF_BASE + PERI_GRF_PERI_CON1);
+	writel(0x400040, CRU_BASE + CRU_GLB_RST_CON);
+
+	/*
+	 * When the venc/npu use the pvtpll, a reboot fails because the
+	 * pvtpll is reset before the venc/npu reset, so the venc/npu is
+	 * not completely reset and the system blocks when accessing the
+	 * NoC in SPL. Enable the pvtpll so that the venc/npu reset can
+	 * complete.
+	 */
+	writel(0xffff0018, CRU_BASE + CRU_PVTPLL0_CON1_L);
+	writel(0x00030003, CRU_BASE + CRU_PVTPLL0_CON0_L);
+	writel(0xffff0018, CRU_BASE + CRU_PVTPLL1_CON1_L);
+	writel(0x00030003, CRU_BASE + CRU_PVTPLL1_CON0_L);
+	udelay(2);
+}
+
+int arch_cpu_init(void)
+{
+	if (is_xpl())
+		rv1106_xpl_init();
+
+	/* Reset the sdmmc0 to prevent a power leak */
+	writel(0x30003000, VICRU_BASE + VICRU_VISOFTRST_CON01);
+	udelay(1);
+	writel(0x30000000, VICRU_BASE + VICRU_VISOFTRST_CON01);
+
+	return 0;
+}
diff --git a/arch/arm/mach-rockchip/rv1106/syscon_rv1106.c b/arch/arm/mach-rockchip/rv1106/syscon_rv1106.c
new file mode 100644
index 00000000000..d669991fbc5
--- /dev/null
+++ b/arch/arm/mach-rockchip/rv1106/syscon_rv1106.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2022 Rockchip Electronics Co., Ltd
+ */
+
+#include <dm.h>
+#include <syscon.h>
+#include <asm/arch-rockchip/clock.h>
+
+static const struct udevice_id rv1106_syscon_ids[] = {
+	{ .compatible = "rockchip,rv1106-grf", .data = ROCKCHIP_SYSCON_GRF },
+	{ }
+};
+
+U_BOOT_DRIVER(syscon_rv1106) = {
+	.name = "rv1106_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = rv1106_syscon_ids,
+};
diff --git a/board/luckfox/pico/Kconfig b/board/luckfox/pico/Kconfig
new file mode 100644
index 00000000000..62176b3779f
--- /dev/null
+++ b/board/luckfox/pico/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_LUCKFOX_PICO_RV1103
+
+config SYS_BOARD
+	default "pico"
+
+config SYS_VENDOR
+	default "luckfox"
+
+config SYS_CONFIG_NAME
+	default "luckfox_pico"
+
+endif
diff --git a/include/configs/rv1106_common.h b/include/configs/rv1106_common.h
new file mode 100644
index 00000000000..1678fe54676
--- /dev/null
+++ b/include/configs/rv1106_common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2022 Rockchip Electronics Co., Ltd
+ */
+#ifndef __CONFIG_RV1106_COMMON_H
+#define __CONFIG_RV1106_COMMON_H
+
+#include "rockchip-common.h"
+
+#define CFG_IRAM_BASE			0xff6c0000
+#define CFG_SYS_SDRAM_BASE		0x00000000
+
+#endif
-- 
2.43.0

