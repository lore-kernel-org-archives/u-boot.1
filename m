Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB22CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 20:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5FD83837;
	Sun, 19 Oct 2025 22:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TUpdVgBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68028807C0; Sun, 19 Oct 2025 22:59:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0656B83768
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 22:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760907548; bh=7fDQiThg/Q2dj/wxQCTUT5BqF7/n49o+XRZC4pee/Ug=;
 b=TUpdVgBlr/Tfisz9h5ymP8AxWr6uVcrElKOBcGuKQooDgG9bbLdheJVDxANCaHz2g37nnyxh4
 RSCtbC7wfcpiLKNwxqz8KsR4r1w1VusEtxjLHkaQ8HNuinuCJyV3Uj8HpBTFNQuwtXPTWbErEfp
 T6cVr5XqZ5Xut6s5E8rO1koOmE8/tgDTAJ/OpssKKZG+XTy/1XZB7L04BHMYz7p0UY50S9ja+tt
 ZPWqorATyOYypzbAtex/0lZGA3K586G63qtvZdI/KGAnbhIKLCTyht81q6+RCDnpKp3hlovfKSR
 QhX6IQP+kZiq3Rhhi1vhOgLJFDzbxPADadMais91IxwA==
X-Forward-Email-ID: 68f55117762a7c0ff99ef055
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
Subject: [PATCH 2/4] board: rockchip: Add Radxa ROCK 2A/2F
Date: Sun, 19 Oct 2025 20:58:37 +0000
Message-ID: <20251019205849.954736-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019205849.954736-1-jonas@kwiboo.se>
References: <20251019205849.954736-1-jonas@kwiboo.se>
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

The ROCK 2 Family is a high-performance SBC (Single Board Computer)
developed by Radxa, based on the Rockchip RK3528A.

The Radxa E20C shares some board characteristics with the ROCK 2 family
boards.

Add support for the ROCK 2A and 2F boards. The radxa-e20c-rk3528 target
is also extended to support booting ROCK 2 boards.

Features tested on a ROCK 2A v1.202:
- SD-card boot
- Ethernet
- USB host (with pending DT changes)

Features tested on a ROCK 2F v1.016:
- SD-card boot
- eMMC boot
- USB host (with pending DT changes)

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi |  5 ++
 arch/arm/dts/rk3528-rock-2-u-boot.dtsi     | 16 +++++
 arch/arm/dts/rk3528-rock-2a-u-boot.dtsi    |  3 +
 arch/arm/dts/rk3528-rock-2f-u-boot.dtsi    |  3 +
 arch/arm/mach-rockchip/rk3528/Kconfig      |  7 +++
 board/radxa/rock-2-rk3528/Kconfig          | 14 +++++
 board/radxa/rock-2-rk3528/MAINTAINERS      |  6 ++
 board/radxa/rock-2-rk3528/Makefile         |  3 +
 board/radxa/rock-2-rk3528/rock-2-rk3528.c  | 60 +++++++++++++++++++
 configs/radxa-e20c-rk3528_defconfig        |  3 +
 configs/rock-2-rk3528_defconfig            | 68 ++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst            |  1 +
 12 files changed, 189 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-rock-2-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2a-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2f-u-boot.dtsi
 create mode 100644 board/radxa/rock-2-rk3528/Kconfig
 create mode 100644 board/radxa/rock-2-rk3528/MAINTAINERS
 create mode 100644 board/radxa/rock-2-rk3528/Makefile
 create mode 100644 board/radxa/rock-2-rk3528/rock-2-rk3528.c
 create mode 100644 configs/rock-2-rk3528_defconfig

diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
index 3e2fbd81da17..e8c8dc2f0324 100644
--- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -2,6 +2,11 @@
 
 #include "rk3528-u-boot.dtsi"
 
+&saradc {
+	bootph-pre-ram;
+	vdd-microvolts = <1800000>;
+};
+
 &vdd_arm {
 	regulator-init-microvolt = <953000>;
 };
diff --git a/arch/arm/dts/rk3528-rock-2-u-boot.dtsi b/arch/arm/dts/rk3528-rock-2-u-boot.dtsi
new file mode 100644
index 000000000000..e8c8dc2f0324
--- /dev/null
+++ b/arch/arm/dts/rk3528-rock-2-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&saradc {
+	bootph-pre-ram;
+	vdd-microvolts = <1800000>;
+};
+
+&vdd_arm {
+	regulator-init-microvolt = <953000>;
+};
+
+&vdd_logic {
+	regulator-init-microvolt = <900000>;
+};
diff --git a/arch/arm/dts/rk3528-rock-2a-u-boot.dtsi b/arch/arm/dts/rk3528-rock-2a-u-boot.dtsi
new file mode 100644
index 000000000000..bd35ef882983
--- /dev/null
+++ b/arch/arm/dts/rk3528-rock-2a-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-rock-2-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3528-rock-2f-u-boot.dtsi b/arch/arm/dts/rk3528-rock-2f-u-boot.dtsi
new file mode 100644
index 000000000000..bd35ef882983
--- /dev/null
+++ b/arch/arm/dts/rk3528-rock-2f-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-rock-2-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3528/Kconfig b/arch/arm/mach-rockchip/rk3528/Kconfig
index 993b2dd274ea..480ac2942ff7 100644
--- a/arch/arm/mach-rockchip/rk3528/Kconfig
+++ b/arch/arm/mach-rockchip/rk3528/Kconfig
@@ -1,5 +1,10 @@
 if ROCKCHIP_RK3528
 
+config TARGET_RADXA_ROCK_2_RK3528
+	bool "Radxa ROCK 2A/2F"
+	help
+	  Radxa ROCK 2A/2F single board computers with a RK3528A SoC.
+
 config ROCKCHIP_BOOT_MODE_REG
 	default 0xff370200
 
@@ -9,6 +14,8 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3528"
 
+source "board/radxa/rock-2-rk3528/Kconfig"
+
 config SYS_CONFIG_NAME
 	default "rk3528_common"
 
diff --git a/board/radxa/rock-2-rk3528/Kconfig b/board/radxa/rock-2-rk3528/Kconfig
new file mode 100644
index 000000000000..5f1ad10c0edf
--- /dev/null
+++ b/board/radxa/rock-2-rk3528/Kconfig
@@ -0,0 +1,14 @@
+if TARGET_RADXA_ROCK_2_RK3528
+
+config SYS_BOARD
+	default "rock-2-rk3528"
+
+config SYS_VENDOR
+	default "radxa"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ADC
+	select SPL_ADC
+
+endif
diff --git a/board/radxa/rock-2-rk3528/MAINTAINERS b/board/radxa/rock-2-rk3528/MAINTAINERS
new file mode 100644
index 000000000000..841bd28450f7
--- /dev/null
+++ b/board/radxa/rock-2-rk3528/MAINTAINERS
@@ -0,0 +1,6 @@
+RADXA-ROCK-2-RK3528
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	board/radxa/rock-2-rk3528
+F:	configs/rock-2-rk3528_defconfig
+F:	arch/arm/dts/rk3528-rock-2*
diff --git a/board/radxa/rock-2-rk3528/Makefile b/board/radxa/rock-2-rk3528/Makefile
new file mode 100644
index 000000000000..b3e0ad0b5408
--- /dev/null
+++ b/board/radxa/rock-2-rk3528/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += rock-2-rk3528.o
diff --git a/board/radxa/rock-2-rk3528/rock-2-rk3528.c b/board/radxa/rock-2-rk3528/rock-2-rk3528.c
new file mode 100644
index 000000000000..2d265b67f0df
--- /dev/null
+++ b/board/radxa/rock-2-rk3528/rock-2-rk3528.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <adc.h>
+#include <env.h>
+
+#define HW_ID_CHANNEL	2
+
+struct board_model {
+	unsigned int low;
+	unsigned int high;
+	const char *fdtfile;
+};
+
+static const struct board_model board_models[] = {
+	{ 63, 278, "rockchip/rk3528-rock-2a.dtb" },
+	{ 291, 392, "rockchip/rk3528-radxa-e20c.dtb" },
+	{ 519, 733, "rockchip/rk3528-rock-2f.dtb" },
+};
+
+static const struct board_model *get_board_model(void)
+{
+	unsigned int val;
+	int i, ret;
+
+	ret = adc_channel_single_shot("adc@ffae0000", HW_ID_CHANNEL, &val);
+	if (ret)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
+		unsigned int min = board_models[i].low;
+		unsigned int max = board_models[i].high;
+
+		if (min <= val && val <= max)
+			return &board_models[i];
+	}
+
+	return NULL;
+}
+
+int rk_board_late_init(void)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model)
+		env_set("fdtfile", model->fdtfile);
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model && !strcmp(name, model->fdtfile))
+		return 0;
+
+	return -EINVAL;
+}
diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
index 0941d1b9be81..fa20424ee7b2 100644
--- a/configs/radxa-e20c-rk3528_defconfig
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -4,12 +4,14 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-radxa-e20c"
 CONFIG_ROCKCHIP_RK3528=y
+CONFIG_TARGET_RADXA_ROCK_2_RK3528=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-radxa-e20c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_MEMINFO=y
@@ -26,6 +28,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_LIST="rockchip/rk3528-radxa-e20c rockchip/rk3528-rock-2a rockchip/rk3528-rock-2f"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
diff --git a/configs/rock-2-rk3528_defconfig b/configs/rock-2-rk3528_defconfig
new file mode 100644
index 000000000000..b9261de460b8
--- /dev/null
+++ b/configs/rock-2-rk3528_defconfig
@@ -0,0 +1,68 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-rock-2a"
+CONFIG_ROCKCHIP_RK3528=y
+CONFIG_TARGET_RADXA_ROCK_2_RK3528=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFF9F0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-rock-2a.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_RNG_SEED=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_LIST="rockchip/rk3528-rock-2a rockchip/rk3528-rock-2f rockchip/rk3528-radxa-e20c"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 542cbc88f57e..918ba9d24b52 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -102,6 +102,7 @@ List of mainline supported Rockchip boards:
 * rk3528
      - Generic RK3528 (generic-rk3528)
      - Radxa E20C (radxa-e20c-rk3528)
+     - Radxa ROCK 2A/2F (rock-2-rk3528)
 
 * rk3566
      - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
-- 
2.51.0

