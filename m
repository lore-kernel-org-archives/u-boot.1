Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEF8CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 16:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC68838E7;
	Sun, 19 Oct 2025 18:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WaQBj60K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C54A838E7; Sun, 19 Oct 2025 18:51:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125B6838D2
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 18:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760892674; bh=BZ0ePn2oXBlglJo0zBn/ru2qAuLliABVNqU0fE8viFM=;
 b=WaQBj60K+0Wjt83dSx/ki/ppuIjEo+4wOh2CxE36A0ZOM+RSKM0drr+xnumYSS3Qvj0oSoNgP
 c6KoasldtXSVeR8CTFL2QGTEHC6ExpoNGaSRW6LhO6RCS8Qw88u3D3bG998VZqcZcYa8Z5NeW9Y
 xeGFyRqOE8FLEGNj2EgxxX4YhR7es6gOeelCV6HoDDfySp3UcpNtb4ky5lkZtE/D1cZMdFQKp83
 PjoKqAZjFcxDHcDwUDM6GcnbwJMNSDB8lBCdwxGug7x1lDWIwSyezt3KwlKjKtT6XiuioYwhUI3
 Y06NybjooVe6pfz7eMwf5kyPXXkgFI1/PcFngTi4PLVQ==
X-Forward-Email-ID: 68f516fe5ea0c6742724423e
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
Cc: John Clark <inindev@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/2] board: rockchip: Add FriendlyElec NanoPi M5
Date: Sun, 19 Oct 2025 16:50:51 +0000
Message-ID: <20251019165056.885394-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165056.885394-1-jonas@kwiboo.se>
References: <20251019165056.885394-1-jonas@kwiboo.se>
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

FriendlyElec NanoPi M5 with Rockchip RK3576 SoC (4x Cortex-A72,
4x Cortex-A53, Mali-G52 MC3 GPU, 6 TOPS NPU).

Features tested on a NanoPi M5 2411:
- SD-card boot
- SPI flash boot
- Ethernet
- LEDs
- PCIe/NVMe
- USB HOST/OTG
- USER button

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi | 22 +++++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
 configs/nanopi-m5-rk3576_defconfig        | 78 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 4 files changed, 107 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
 create mode 100644 configs/nanopi-m5-rk3576_defconfig

diff --git a/arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi b/arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
new file mode 100644
index 000000000000..0767fbb8168f
--- /dev/null
+++ b/arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
+
+&led1 {
+	default-state = "off";
+};
+
+&led2 {
+	default-state = "off";
+};
+
+&led_sys {
+	default-state = "on";
+};
+
+&sfc1 {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index e236163992d7..393edd3984ce 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -4,6 +4,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3576-generic*
 F:	configs/generic-rk3576_defconfig
 
+NANOPI-M5-RK3576
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3576-nanopi-m5*
+F:	configs/nanopi-m5-rk3576_defconfig
+
 OMNI3576-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
new file mode 100644
index 000000000000..28427390a62b
--- /dev/null
+++ b/configs/nanopi-m5-rk3576_defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-m5"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SF_DEFAULT_BUS=6
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-m5.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 426c38b7189f..542cbc88f57e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -136,6 +136,7 @@ List of mainline supported Rockchip boards:
 * rk3576
      - ArmSoM Sige5 (sige5-rk3576)
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
+     - FriendlyElec NanoPi M5 (nanopi-m5-rk3576)
      - Generic RK3576 (generic-rk3576)
      - Luckfox Omni3576 (omni3576-rk3576)
      - Radxa ROCK 4D (rock-4d-rk3576)
-- 
2.51.0

