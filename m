Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EBBC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 07:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4018294C;
	Tue, 15 Apr 2025 09:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="Xv8ANUwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4262F829A1; Tue, 15 Apr 2025 09:42:06 +0200 (CEST)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC9281F0D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 09:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiehui.he@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1744702613;
 bh=TgAqpShaLdOb9Ih5lAplhGW7a0qPc7EwDcl+kkh+RlE=;
 h=From:To:Cc:Subject:Date;
 b=Xv8ANUwOFqfnhyzTSxeDtlVMtHEaQWltt+5SaRNRkc0hPHaiyQmJngZySbzjkKR0U
 L7aX8GTjZlIzJvcg+Bq+Wwee574qG1cumLdUY8+uGpKPc/oq6Da+ifFayEMHP3+FJW
 r4wkLa/l4LlFXyinnlfYCrY6QTFJ4EcxzJQCtEdg=
Received: from localhost.localdomain ([119.131.137.145])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 9338C669; Tue, 15 Apr 2025 15:36:51 +0800
X-QQ-mid: xmsmtpt1744702611t02kjf8ej
Message-ID: <tencent_93CD49DECE6851B4BCA7C46427864CB0340A@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2j4L6QhztrmPPzgQT2yLvJd42KOLnUG90waYjkKfCG3vIh0ek6j
 +fm4kabIZ4mjJK9aYtWEGD8cy+YvaSKnB1avMHU65WSyVF4GGoIM8kpeJl3e/U9GwrR4+nkwgk2f
 O1ovOx/FisvdpDw8lRqKhBm806UBeN4c063VkcZnL8gATP8372qZI6z0zwZUhpbbpQe4r/hois16
 rcE5ZxnqTxqHCga3NN5g2eMmBP6sB665MpeS+qdsjOOaxvWZKv2cwpKYHrroCLnv/irdggh+oR8d
 WF0yx3Qb3USOXJeNBHECOeEgBMHOGm0t6KfvqyXlFziRhJEkgCzJg9FBPzTNieyO/KLGmQRSeDdw
 YpuMpdFhTv4Nq/kIKVNWXRi4W8LRhHWiPdfQJ3tT1Vi0/8T6d0jZNtU9MoKV995zQD/FgUwvsoQm
 Je7B9PQ9CMIXzcGcvqfbhgrHbmbbKTEZHrMwMmBswBTk9LMFc/p+N6rhuQgktmHVcvuVMFb4u0TS
 XDsxAg7sVZkF2hNHbs0KaPoFE7NzvXJclxv7VB3/MPNRRQa77Mu02cDmiTvBrgCIG9zaFaQus7MZ
 Opus5DIc+027rNMmygF/vWEsrhVunW90B6n0eVvsnFvrRjqA/iD7rWJ3tp4oM/K5qTa6r4YRjgFi
 i6JIrqVK7f+ioEy2dg32Xtqd7dU3HTULXqvr22aLB6CHROLJz1fmuRnXBzS0aBn94FeAhjj/yPYz
 UiSeaaZre1QHtZQgbvKMORhRVGBOVYFSMazyeC7EFw7/Tnk501MGIstRoa9UduDu2lz9Dm+StYUB
 nHgR8uaKLmkg7oCjqlQyCctAl2m+xUIZwUZQvBwBLnqSNictwSNgfypV18nFv8UUq20jJuBnZGl+
 pQaNQLb5p4noZoxaWHoB4USeZL4iNSs5pcuPPPkRknqztTTgQIkiHDcY44JI4g1oF+yjGqGN9CfM
 JjFsnZZJaSTuT5+fDZKKFchPIW5i7lX3khF6r9o5l6W9zdCN80Ep/WxCUmfbYi8Rv7bf0x3cVZzw
 05K75DTOgNSo+cLmDgRzIsNGWC7IkaHGrQSLUS9AiRwEG4REFlvy4EdayDP8h86UPCUmIkQVjt2O
 /j9g4dZJE26strMQc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jiehui He <jiehui.he@foxmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, kever.yang@rock-chips.com, trini@konsulko.com,
 chenjh@rock-chips.com, jonas@kwiboo.se, Jiehui He <jiehui.he@foxmail.com>
Subject: [PATCH v2] board: rockchip: Add LCKFB TaishanPi RK3566 Board
Date: Tue, 15 Apr 2025 03:36:50 -0400
X-OQ-MSGID: <20250415073650.18407-1-jiehui.he@foxmail.com>
X-Mailer: git-send-email 2.39.5
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

The LCKFB TaishanPi is a single-board computer based on the RK3566 SoC.

Specification:
- 1/2 Gib RAM
- Optinal EMMC
- SD-Card
- HDMI / MIPI CSI / MIPI DSI
- USB 2.0 Host (Type-A)
- USB 2.0 Host / OTG (Type-C)
- No Ethernet

This patch adds U-Boot support for the LCKFB TaishanPi RK3566 board, including:
- U-Boot device tree
- Default defconfig
- Board documentation
- MAINTAINERS entry

Changes in v2:
- Removed unused configs from `lckfb-tspi-rk3566_defconfig`
- Reordered TaishanPi entry in `doc/board/rockchip/rockchip.rst` alphabetically

Link to v1:
https://lore.kernel.org/u-boot/tencent_95ED0C0545D87B6A8C4B62EC045D53AD2406@qq.com/

Signed-off-by: Jiehui He <jiehui.he@foxmail.com>
---
 arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi | 11 +++
 board/rockchip/evb_rk3568/MAINTAINERS      |  6 ++
 configs/lckfb-tspi-rk3566_defconfig        | 78 ++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst            |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
 create mode 100644 configs/lckfb-tspi-rk3566_defconfig

diff --git a/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi b/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
new file mode 100644
index 00000000000..0c8e7018f13
--- /dev/null
+++ b/arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk356x-u-boot.dtsi"
+
+&rgb_led_r {
+	default-state = "off";
+};
+
+&rgb_led_b {
+	default-state = "off";
+};
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index b2780401a39..6cf568ad150 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -89,3 +89,9 @@ M:	Maxim Moskalets <maximmosk4@gmail.com>
 S:	Maintained
 F:	arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
 F:	configs/rock-3c-rk3566_defconfig
+
+LCKFB-TaishanPi
+M:	Jiehui He <jiehui.he@foxmail.com>
+S:	Maintained
+F:	configs/lckfb-tspi-rk3566_defconfig
+F:	arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
diff --git a/configs/lckfb-tspi-rk3566_defconfig b/configs/lckfb-tspi-rk3566_defconfig
new file mode 100644
index 00000000000..bc54be5ca53
--- /dev/null
+++ b/configs/lckfb-tspi-rk3566_defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-lckfb-tspi"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-lckfb-tspi.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
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
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_FAN53555=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_GENERIC=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1407080f1f4..abffbf36f40 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
      - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
      - FriendlyElec NanoPi R3S (nanopi-r3s-rk3566)
      - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
+     - LCKFB TaishanPi (lckfb-tspi-rk3566)
      - Pine64 PineTab2 (pinetab2-rk3566)
      - Pine64 Quartz64-A Board (quartz64-a-rk3566)
      - Pine64 Quartz64-B Board (quartz64-b-rk3566)
-- 
2.39.5

