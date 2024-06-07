Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E754C27C65
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 20:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C085B881AF;
	Fri,  7 Jun 2024 22:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="d85k4+Af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C45884B0; Fri,  7 Jun 2024 22:24:18 +0200 (CEST)
Received: from shout12.mail.de (shout12.mail.de [IPv6:2001:868:100:600::f154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA50884A4
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 22:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
 by shout12.mail.de (Postfix) with ESMTPS id 7052F241964;
 Fri,  7 Jun 2024 22:24:16 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
 by shout02.mail.de (Postfix) with ESMTP id 5988F240AF7;
 Fri,  7 Jun 2024 22:24:16 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
 by postfix02.mail.de (Postfix) with ESMTP id 3D0D5A03C3;
 Fri,  7 Jun 2024 22:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1717791856;
 bh=KttYdhh0evFi0EsDuhKw0S2bHbVh/6/hNbs5wfiA8wE=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=d85k4+Afp0Vxw+e6yQYHQ8bU//G1+Sa8P12U4VP+7+g1eneS2htVDAKWgHCWif6Zk
 oBtNQWkjFMQXyYZQvYJEW7yPha0Oli4lyLOrPc+YK1KvdAcHeNTnfqTYhqy8oo9dg5
 1NtslR9DtEaN7vsETSy2kSX7XSCMizWBmjkg+0gu9GVB3YyT/WeP//Ji8AGYW37oof
 gBeUiKOrqfNpQbdQawGdIKs0h6Od4kJf2Bfmi9SrVSFmFsFQm7TKXEiaVaIlw34RNM
 LwiCbttsECNuviR1ghEzgVmt1tbsvy+jYBUZzhu7J7fXYTDC7KHvZ1x/pqb6U4HiWi
 BSlxc7V6MVgRg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id E2C3D240A50;
 Fri,  7 Jun 2024 22:24:15 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/2] board: rockchip: Add FriendlyElec NanoPi R6S
Date: Fri,  7 Jun 2024 22:17:42 +0200
Message-ID: <20240607202111.453943-2-seb-dev@mail.de>
In-Reply-To: <20240607202111.453943-1-seb-dev@mail.de>
References: <20240607202111.453943-1-seb-dev@mail.de>
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
X-purgate-size: 8217
X-purgate-ID: 154282::1717791856-DB52A878-83BAE176/0/0
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

The NanoPi R6S is a SBC by FriendlyElec based on the Rockchip RK3588s.
It comes with 4GB or 8GB of RAM, a microSD card slot, 32GB eMMC storage,
one RTL8211F 1GbE and two RTL8125 2.5GbE Ethernet ports, one USB 2.0
Type-A and one USB 3.0 Type-A port, a HDMI port, a 12-pin GPIO FPC
connector, a fan connector, IR receiver as well as some buttons and LEDs.

Add initial support for this board using the upstream devicetree sources.

Kernel commit:
f1b11f43b3e9 ("arm64: dts: rockchip: Add support for NanoPi R6S")

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---

The R6S is very similar to the R6C, the major difference being that
instead of the M.2 NVMe socket on the R6C, the R6S has a second RTL8125BG
Ethernet chip, which uses the same PCIe lanes that the R6C uses for its
M.2 socket. Other minor differences include:
- 12-pin GPIO FPC instead of 30-pin header
- IR receiver (pwm-based)
- 5V fan connector
Other than that, they are the same, which is why the difference in
U-Boot is only the missing NVME config option in the R6S defconfig.

Please note that I was not able to test this device. I only chose to
add it due to it being a very similar implementation to the R6C, like the
NanoPi R5C and R5S are similar. It should however boot just fine and even
both RTL8125 Ethernet ports should work in U-Boot since RTL8125 is the
same chip used in the R6C, using the rtl8169 driver.

If this is not how things should be done in U-Boot, please disregard
and drop this patch :) Thanks!

---
 arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi   |  3 +
 arch/arm/mach-rockchip/rk3588/Kconfig         | 12 +++
 board/friendlyelec/nanopi-r6s-rk3588s/Kconfig | 12 +++
 .../nanopi-r6s-rk3588s/MAINTAINERS            |  7 ++
 configs/nanopi-r6s-rk3588s_defconfig          | 82 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 include/configs/nanopi-r6s-rk3588s.h          | 12 +++
 7 files changed, 129 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
 create mode 100644 board/friendlyelec/nanopi-r6s-rk3588s/Kconfig
 create mode 100644 board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS
 create mode 100644 configs/nanopi-r6s-rk3588s_defconfig
 create mode 100644 include/configs/nanopi-r6s-rk3588s.h

diff --git a/arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi b/arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
new file mode 100644
index 0000000000..853ed58cfe
--- /dev/null
+++ b/arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 4b7d751c6f..a9e400861a 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -90,6 +90,18 @@ config TARGET_NANOPI_R6C_RK3588S
 	  Type-A port, a HDMI port, a 30-pin GPIO header as well as some
 	  buttons and LEDs.
 
+config TARGET_NANOPI_R6S_RK3588S
+	bool "FriendlyElec NanoPi R6S"
+	select BOARD_LATE_INIT
+	help
+	  The NanoPi R6S is a SBC by FriendlyElec based on the Rockchip
+	  RK3588s.
+	  It comes with 4GB or 8GB of RAM, a microSD card slot, 32GB eMMC
+	  storage, one RTL8211F 1GbE and two RTL8125 2.5GbE Ethernet ports,
+	  one USB 2.0 Type-A and one USB 3.0 Type-A port, a HDMI port, a
+	  12-pin GPIO FPC connector, a fan connector, IR receiver as well
+	  as some buttons and LEDs.
+
 config TARGET_NOVA_RK3588
 	bool "Indiedroid Nova RK3588"
 	select BOARD_LATE_INIT
diff --git a/board/friendlyelec/nanopi-r6s-rk3588s/Kconfig b/board/friendlyelec/nanopi-r6s-rk3588s/Kconfig
new file mode 100644
index 0000000000..4d579816b1
--- /dev/null
+++ b/board/friendlyelec/nanopi-r6s-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_NANOPI_R6S_RK3588S
+
+config SYS_BOARD
+	default "nanopi-r6s-rk3588s"
+
+config SYS_VENDOR
+	default "friendlyelec"
+
+config SYS_CONFIG_NAME
+	default "nanopi-r6s-rk3588s"
+
+endif
diff --git a/board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS b/board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS
new file mode 100644
index 0000000000..76288b4320
--- /dev/null
+++ b/board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS
@@ -0,0 +1,7 @@
+NANOPI-R6S
+M:	Sebastian Kropatsch <seb-dev@mail.de>
+S:	Maintained
+F:	arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
+F:	board/friendlyelec/nanopi-r6s-rk3588s
+F:	configs/nanopi-r6s-rk3588s_defconfig
+F:	include/configs/nanopi-r6s-rk3588s.h
diff --git a/configs/nanopi-r6s-rk3588s_defconfig b/configs/nanopi-r6s-rk3588s_defconfig
new file mode 100644
index 0000000000..f7b364655f
--- /dev/null
+++ b/configs/nanopi-r6s-rk3588s_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-nanopi-r6s"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_NANOPI_R6S_RK3588S=y
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
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-nanopi-r6s.dtb"
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
index a3d9837dda..0b58086f06 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -124,6 +124,7 @@ List of mainline supported Rockchip boards:
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
+     - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
      - Generic RK3588S/RK3588 (generic-rk3588)
      - Indiedroid Nova (nova-rk3588s)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
diff --git a/include/configs/nanopi-r6s-rk3588s.h b/include/configs/nanopi-r6s-rk3588s.h
new file mode 100644
index 0000000000..a1b19783c5
--- /dev/null
+++ b/include/configs/nanopi-r6s-rk3588s.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __NANOPI_R6S_RK3588S_H
+#define __NANOPI_R6S_RK3588S_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __NANOPI_R6S_RK3588S_H */
-- 
2.45.2

