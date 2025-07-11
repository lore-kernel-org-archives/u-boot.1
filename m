Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9E7C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 23:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92EA482C7F;
	Sat, 12 Jul 2025 01:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bREhL95r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E7882F8E; Sat, 12 Jul 2025 01:06:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF3E80FA8
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 01:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752275197; bh=pJUqoMWBmKUzlFKiLR1yZYhqdzVWEMUjooZFp7qYCKM=;
 b=bREhL95rZpy4tM8q7xorH+hUPJhLXyoO2nc3Y4DtHxwTl2dDa3Ud09z7ioQOd8eMFy1XBM4Pz
 JOmyuYKibZCvzmkWfBfTfGxJx4oD4VaApPMyMBj99Aa7TSMyvhnS+cizveQrunA7N0rYvsVxmvQ
 mGHKHha/pSKrY5CaH5TTdOQnLwxfY98FYZ1/lP/EfYmz9w9TrHdqyuapUIek6QnZFT2oGkNcId2
 RSBsYP4ZqS8+yT+hDt2fb0Uuc0Ycs+9c/Xzi9Mwax7u4TbxYe4qgOPXznsK76ondy+fh5MUmq3e
 PVu9sPWH1Xc1+loC2ZvkyQJQu2xjZ+79GcVgTq1RX2dg==
X-Forward-Email-ID: 687198f926dc7c4d25562316
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 4/4] board: rockchip: Add Radxa ROCK 4D
Date: Fri, 11 Jul 2025 23:06:06 +0000
Message-ID: <20250711230613.217996-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711230613.217996-1-jonas@kwiboo.se>
References: <20250711230613.217996-1-jonas@kwiboo.se>
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

The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
numerous top-tier functions, features, and expansion options.

Equipped with the Rockchip RK3576 or RK3576J SoC, the ROCK 4D boasts an
octa-core CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 GPU, and a
powerful 6 TOPS NPU, making it ideal for AI and multimedia tasks.

Features tested on a Radxa ROCK 4D v1.112:
- SPI Flash boot
- Ethernet

ROCK 4D boards with SPI Flash is configured to boot from FSPI0->UFS->USB,
or directly from USB when the MASKROM button is pressed, booting
directly from SD-card is not possible on these boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi   | 15 +++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
 configs/rock-4d-rk3576_defconfig          | 68 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
 create mode 100644 configs/rock-4d-rk3576_defconfig

diff --git a/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
new file mode 100644
index 000000000000..5056a1cecb83
--- /dev/null
+++ b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
+
+&rgmii_phy0 {
+	/delete-property/ reset-gpio;
+	reset-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
+};
+
+&sfc0 {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index 94ef74d429f9..54c75f451f0f 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -4,6 +4,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3576-generic*
 F:	configs/generic-rk3576_defconfig
 
+ROCK-4D-RK3576
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3576-rock-4d*
+F:	configs/rock-4d-rk3576_defconfig
+
 SIGE5-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
new file mode 100644
index 000000000000..140a3e0ccd84
--- /dev/null
+++ b/configs/rock-4d-rk3576_defconfig
@@ -0,0 +1,68 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-rock-4d"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-rock-4d.dtb"
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
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 05731f70f92c..733939445b9c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
      - ArmSoM Sige5 (sige5-rk3576)
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
      - Generic RK3576 (generic-rk3576)
+     - Radxa ROCK 4D (rock-4d-rk3576)
 
 * rk3588
      - ArmSoM Sige7 (sige7-rk3588)
-- 
2.49.0

