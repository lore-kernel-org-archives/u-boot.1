Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA45C3DA47
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 10:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A81E88680;
	Thu, 11 Jul 2024 12:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="rxeBllnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F690886DA; Thu, 11 Jul 2024 12:22:14 +0200 (CEST)
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0658C88665
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 12:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
 by shout01.mail.de (Postfix) with ESMTP id 9A33D240F8E;
 Thu, 11 Jul 2024 12:22:11 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
 by postfix01.mail.de (Postfix) with ESMTP id 70D75801EC;
 Thu, 11 Jul 2024 12:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1720693331;
 bh=FKZfqapncJKtvC99xnuXeQE29G80vz4RWbeOMa4hUMU=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=rxeBllnLNtKw5HKNerl1mmM+dxw66l9BrUX6Ddh5LJM+1huV1YHQKnoTS00tlWQQE
 ukT/eHViSXp9IFBBINWudw1ymLHr/QrsihsY8bjsEvKNmYSFjyvDIUOwU2B36wyeed
 2dWa9qvFVatI4IqFUw5T1xo5ySRSsj0GO9OFeHZ5oHwYGim80o8JuplPvN3KiREtB2
 dTdpn7Ngp6iELkyBzUPSWg5tQk+DuoqkhNOJ9w5ADc03z4ocgSn77utl6yvKy3IcOn
 BYaOgJBlE1d9ZXYm967G9eOUy85yKENrxkPdLc4d4MSwJXQS/hrAnaVzxTD1kI/LPL
 uMfKNDEFCIgxA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id C0662240CB7;
 Thu, 11 Jul 2024 12:22:07 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Ulli Kehrle <ulli@vegan.im.it>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 1/2] board: rockchip: Add FriendlyElec NanoPi R6C
Date: Thu, 11 Jul 2024 12:15:17 +0200
Message-ID: <20240711101836.6721-1-seb-dev@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 9705
X-purgate-ID: 154282::1720693331-BFD29878-90056AEE/0/0
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

The NanoPi R6C is a SBC by FriendlyElec based on the Rockchip RK3588s.
It comes with 4GB or 8GB of RAM, a microSD card slot, optional 32GB eMMC
storage, one M.2 M-Key connector, one RTL8211F 1GbE and one RTL8125
2.5GbE Ethernet port, one USB 2.0 Type-A and one USB 3.0 Type-A port, a
HDMI port, a 30-pin GPIO header as well as multiple buttons and LEDs.

Add initial support for this board using the upstream devicetree sources.

Tested in U-Boot proper:
- Booting from eMMC works
- 1GbE Ethernet works using the eth_eqos driver (tested by ping)
- 2.5GbE Ethernet works using the eth_rtl8169 driver (tested by ping),
  but the status LEDs on this specific port currently aren't working
- NVMe SSD in M.2 socket does get recognized (tested with `nvme scan`
  followed by `nvme details`)

Kernel commit:
d5f1d7437451 ("arm64: dts: rockchip: Add support for NanoPi R6C")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---

Changes v2 -> v3:
- Patch 2/2: Add missing board source to 'rk3588/Kconfig'
- Both patches: Collect r-b tag from Kever Yang
- Link to v2: https://lore.kernel.org/u-boot/20240607202111.453943-1-seb-dev@mail.de/

Changes v1 -> v2:

- Patch 1/2: Add missing 'S' to 'RK3588S' symbols
- Patch 1/2: Collect r-b tag from Quentin Schulz
- Add similar board NanoPi R6S (new patch)
- Link to v1: https://lore.kernel.org/u-boot/20240605155413.226629-1-seb-dev@mail.de/

Hello!

The Ethernet status LEDs for the RTL8169 ports don't light up when
connected (confirmed by Ulli Kehrle [1]). The other port with a RTL8211F
has no problems with the LEDs.
Have there been occurrences like this in combination with the RTL8125?
Could this possibly solved in the devicetree or is this a potential
driver bug?

Secondly, the default active network device in U-Boot is the 1GbE one.
I believe it would make sense to make the 2.5GbE device the default
active one since this one is labeled "LAN", whereas the 1GbE is labeled
"WAN". However, since the 2.5GbE device is PCIe-based, it only shows up
in U-Boot proper after using the `pci enum` command (shows up as in gets
listed in `net list` and `dm tree`).
Do you have any tips on the preferred approach to handle this switch of
the default active net device? Is this even a sensible thing to include
in U-Boot in your opinion?

Thanks for your feedback!

Cheers,
Sebastian

Links:
[1] https://lore.kernel.org/u-boot/87sex75kub.fsf@kehrle.me/

---
 arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi   |  3 +
 arch/arm/mach-rockchip/rk3588/Kconfig         | 13 +++
 board/friendlyelec/nanopi-r6c-rk3588s/Kconfig | 12 +++
 .../nanopi-r6c-rk3588s/MAINTAINERS            |  7 ++
 configs/nanopi-r6c-rk3588s_defconfig          | 83 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 include/configs/nanopi-r6c-rk3588s.h          | 12 +++
 7 files changed, 131 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
 create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/Kconfig
 create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS
 create mode 100644 configs/nanopi-r6c-rk3588s_defconfig
 create mode 100644 include/configs/nanopi-r6c-rk3588s.h

diff --git a/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
new file mode 100644
index 0000000000..853ed58cfe
--- /dev/null
+++ b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 9a35c7d9cc..26e45f43ff 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -78,6 +78,18 @@ config TARGET_NANOPCT6_RK3588
 	  Power: 5.5*2.1mm DC Jack, 12VDC input
 	  Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm (with case)
 
+config TARGET_NANOPI_R6C_RK3588S
+	bool "FriendlyElec NanoPi R6C"
+	select BOARD_LATE_INIT
+	help
+	  The NanoPi R6C is a SBC by FriendlyElec based on the Rockchip
+	  RK3588s.
+	  It comes with 4GB or 8GB of RAM, a microSD card slot, optional 32GB
+	  eMMC storage, one M.2 M-Key connector, one RTL8211F 1GbE and one
+	  RTL8125 2.5GbE Ethernet port, one USB 2.0 Type-A and one USB 3.0
+	  Type-A port, a HDMI port, a 30-pin GPIO header as well as some
+	  buttons and LEDs.
+
 config TARGET_NOVA_RK3588
 	bool "Indiedroid Nova RK3588"
 	select BOARD_LATE_INIT
@@ -288,6 +300,7 @@ config TEXT_BASE
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
+source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
 source "board/indiedroid/nova/Kconfig"
 source "board/pine64/quartzpro64-rk3588/Kconfig"
 source "board/turing/turing-rk1-rk3588/Kconfig"
diff --git a/board/friendlyelec/nanopi-r6c-rk3588s/Kconfig b/board/friendlyelec/nanopi-r6c-rk3588s/Kconfig
new file mode 100644
index 0000000000..2d8acbf62f
--- /dev/null
+++ b/board/friendlyelec/nanopi-r6c-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_NANOPI_R6C_RK3588S
+
+config SYS_BOARD
+	default "nanopi-r6c-rk3588s"
+
+config SYS_VENDOR
+	default "friendlyelec"
+
+config SYS_CONFIG_NAME
+	default "nanopi-r6c-rk3588s"
+
+endif
diff --git a/board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS b/board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS
new file mode 100644
index 0000000000..18d0bd1287
--- /dev/null
+++ b/board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS
@@ -0,0 +1,7 @@
+NANOPI-R6C
+M:	Sebastian Kropatsch <seb-dev@mail.de>
+S:	Maintained
+F:	arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
+F:	board/friendlyelec/nanopi-r6c-rk3588s
+F:	configs/nanopi-r6c-rk3588s_defconfig
+F:	include/configs/nanopi-r6c-rk3588s.h
diff --git a/configs/nanopi-r6c-rk3588s_defconfig b/configs/nanopi-r6c-rk3588s_defconfig
new file mode 100644
index 0000000000..f8d2d67bd3
--- /dev/null
+++ b/configs/nanopi-r6c-rk3588s_defconfig
@@ -0,0 +1,83 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-nanopi-r6c"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_NANOPI_R6C_RK3588S=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-nanopi-r6c.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+# CONFIG_SPI_FLASH is not set
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_RTL8169=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index eaf71673b7..d04fc6d3c6 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -124,6 +124,7 @@ List of mainline supported Rockchip boards:
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
+     - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
      - Generic RK3588S/RK3588 (generic-rk3588)
      - Indiedroid Nova (nova-rk3588s)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
diff --git a/include/configs/nanopi-r6c-rk3588s.h b/include/configs/nanopi-r6c-rk3588s.h
new file mode 100644
index 0000000000..2b57d60eb5
--- /dev/null
+++ b/include/configs/nanopi-r6c-rk3588s.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __NANOPI_R6C_RK3588S_H
+#define __NANOPI_R6C_RK3588S_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __NANOPI_R6C_RK3588S_H */
-- 
2.43.0

