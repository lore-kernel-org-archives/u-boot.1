Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9F0C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D35B388998;
	Wed, 31 Jul 2024 09:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="P2AnyeZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2077F889AA; Wed, 31 Jul 2024 09:29:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86B188886
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722410953; bh=pHEL+fLWg4wTMCldln8jK+nza0wx2j8hlvZmR9h4tT0=;
 b=P2AnyeZ9/KrvvYdLl9CvCnTVO5q0QJC9xDQtEoa29PV4tiFMXcZMEVPDGHLuDB72zZ7LltNfp
 nycmfLMOlgzWHneVVrHSA8NaYWqwIAZdTcOS/m+jvV/lAxiz2hnFXRT4lDhQv09Zum7KazfCCxA
 rNqs8IBHyWqg37TZ5bztTnlQILziQLtVCQC/QZw2heXGARuThbk6X5j7IvMMjpa2dzqe1860j8o
 qENkyUoAszWMAa0M1Na8V2w6GgqZa44M/5aQN1OGThkFSwAw0GfN4bDEy+iEX1v+fcjMDZsV9x0
 7khbZMC8wRcCmzkUYkZYcmOrAoJ8uVKKY8Us/hQZyRoQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] board: rockchip: Add Radxa ROCK 3B
Date: Wed, 31 Jul 2024 07:28:54 +0000
Message-ID: <20240731072858.1216627-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731072858.1216627-1-jonas@kwiboo.se>
References: <20240731072858.1216627-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a9e7c773d983cd09238541
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

The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
version based on the RK3568 SoC and an industrial version based on the
RK3568J SoC.

Features tested on ROCK 3B 8GB v1.51 (both variants):
- SD-card boot
- eMMC boot
- SPI Flash boot
- Ethernet
- PCIe/NVMe
- USB gadget
- USB host

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3568-rock-3b-u-boot.dtsi |  15 ++++
 board/rockchip/evb_rk3568/MAINTAINERS   |   6 ++
 configs/rock-3b-rk3568_defconfig        | 100 ++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |   3 +-
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3568-rock-3b-u-boot.dtsi
 create mode 100644 configs/rock-3b-rk3568_defconfig

diff --git a/arch/arm/dts/rk3568-rock-3b-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3b-u-boot.dtsi
new file mode 100644
index 000000000000..b1f324282bac
--- /dev/null
+++ b/arch/arm/dts/rk3568-rock-3b-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk356x-u-boot.dtsi"
+
+&sdhci {
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+};
+
+&sfc {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index ba4884db8e12..588134ecb27a 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -70,6 +70,12 @@ F:	configs/rock-3a-rk3568_defconfig
 F:	arch/arm/dts/rk3568-rock-3a.dts
 F:	arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
 
+ROCK-3B
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/rock-3b-rk3568_defconfig
+F:	arch/arm/dts/rk3568-rock-3b*
+
 ROCK-3C
 M:	Jonas Karlman <jonas@kwiboo.se>
 M:	Maxim Moskalets <maximmosk4@gmail.com>
diff --git a/configs/rock-3b-rk3568_defconfig b/configs/rock-3b-rk3568_defconfig
new file mode 100644
index 000000000000..937796811a97
--- /dev/null
+++ b/configs/rock-3b-rk3568_defconfig
@@ -0,0 +1,100 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-rock-3b"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3b.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=4
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_FAN53555=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
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
index eadca0ceb2a5..3febebd0b830 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -118,7 +118,8 @@ List of mainline supported Rockchip boards:
      - Generic RK3566/RK3568 (generic-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
      - Radxa E25 Carrier Board (radxa-e25-rk3568)
-     - Radxa ROCK 3 Model A (rock-3a-rk3568)
+     - Radxa ROCK 3A (rock-3a-rk3568)
+     - Radxa ROCK 3B (rock-3b-rk3568)
 
 * rk3588
      - ArmSoM Sige7 (sige7-rk3588)
-- 
2.45.2

