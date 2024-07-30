Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BF8C49EA1
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2648890A;
	Tue, 30 Jul 2024 21:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Dmhot/wA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655BF8890F; Tue, 30 Jul 2024 21:49:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B7178890D
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722368935; bh=xXGdn4CSMlqgrXg2LQFwvLt3Y9I50dcePkDkdBhcbMY=;
 b=Dmhot/wAbjtlpk8hsjYknoXh0mID6u/sZseu8NdahvQucsqBIfyH9g6xH1mhI2JD9Hxr4Z/gd
 tUYp+92LZUprZUL3WmCN1QnBBi3yCZq9OK73GrIFburSZvyyWh5aP9lRP5K6S2FV4WCfdJfuU/N
 GuNPv0bLAq4QcvaixDEBJ1f/0dVy2v53SniyYuovPSXNgbaq9gc1C/LN9MlO613nmU55phgm1tT
 sGPCIBiG1pDhVIqKfjQC4/dRjfvHVy0BUtpzAVhAavCV2K8hU9gZrMNHzPaaDFycYrbxKnSDr1/
 szh9kyLj8hzvnyhzqq2yLDsF5oBakPTNzzibXpHRPTQQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Andy Yan <andy.yan@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/2] board: rockchip: Add Radxa ROCK S0
Date: Tue, 30 Jul 2024 19:48:37 +0000
Message-ID: <20240730194842.916502-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730194842.916502-1-jonas@kwiboo.se>
References: <20240730194842.916502-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66a943a52c52d9ba4458b1b3
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

Radxa ROCK S0 is a single-board computer based on the Rockchip RK3308B
SoC in an ultra-compact form factor. Add a board target for the board.

Features tested on a ROCK S0 v1.2 with 512 MiB RAM and 8 GiB eMMC:
- SD-card boot
- eMMC boot
- Ethernet
- USB gadget
- USB host

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi | 21 ++++++++
 board/rockchip/evb_rk3308/MAINTAINERS   |  6 +++
 configs/rock-s0-rk3308_defconfig        | 72 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  1 +
 4 files changed, 100 insertions(+)
 create mode 100644 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
 create mode 100644 configs/rock-s0-rk3308_defconfig

diff --git a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
new file mode 100644
index 000000000000..84ca2ee0d5fb
--- /dev/null
+++ b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3308-u-boot.dtsi"
+
+&emmc_pwren {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&uart0 {
+	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&uart0_xfer {
+	bootph-all;
+};
+
+&vdd_core {
+	regulator-init-microvolt = <1015000>;
+};
diff --git a/board/rockchip/evb_rk3308/MAINTAINERS b/board/rockchip/evb_rk3308/MAINTAINERS
index abffbb1eb0ab..cd219c65f278 100644
--- a/board/rockchip/evb_rk3308/MAINTAINERS
+++ b/board/rockchip/evb_rk3308/MAINTAINERS
@@ -12,3 +12,9 @@ R:      Jonas Karlman <jonas@kwiboo.se>
 S:      Maintained
 F:      configs/rock-pi-s-rk3308_defconfig
 F:      arch/arm/dts/rk3308-rock-pi-s*
+
+ROCK-S0
+M:      Jonas Karlman <jonas@kwiboo.se>
+S:      Maintained
+F:      configs/rock-s0-rk3308_defconfig
+F:      arch/arm/dts/rk3308-rock-s0*
diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
new file mode 100644
index 000000000000..074ec4cd66ba
--- /dev/null
+++ b/configs/rock-s0-rk3308_defconfig
@@ -0,0 +1,72 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-s0"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3308=y
+CONFIG_TARGET_EVB_RK3308=y
+CONFIG_DEBUG_UART_BASE=0xFF0A0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+# CONFIG_DEBUG_UART_BOARD_INIT is not set
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_ANDROID_BOOT_IMAGE=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-s0.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PINCTRL=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSINFO=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_LZO=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index bedc52e03e20..82cbc6e3e0db 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -54,6 +54,7 @@ List of mainline supported Rockchip boards:
      - Amarula Vyasa-RK3288 (vyasa-rk3288)
 * rk3308
      - Radxa ROCK Pi S (rock-pi-s-rk3308)
+     - Radxa ROCK S0 (rock-s0-rk3308)
      - Rockchip Evb-RK3308 (evb-rk3308)
      - Roc-cc-RK3308 (roc-cc-rk3308)
 * rk3326
-- 
2.45.2

