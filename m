Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D02C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 13:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0997607D9;
	Wed, 22 Jul 2026 13:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ud6-E3gPUUsM; Wed, 22 Jul 2026 13:27:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2793607C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784726867;
	bh=oauELqhA6IU0x2XqmeZ/jEIhgb2TwDu2bX2rcpbWTX0=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=dNIXoj2Hic1A66gS/UDTBLILtCqpaBG2H3codPrzOKLA4q0UDjGKaTzZYF1Wpgbqz
	 D5LDob7pQapjAdRtz4MhtUVYQoVWeM7RSgwynMItolsmYFKJFAt2fwN/yxNT62Vz2I
	 Gvjoaq5bGPyEaPyj0XCeJO1Ke4aqrPL4oX2AKWPGhOm2vHH347lAK7DJQ+LulDDWny
	 Cmw431YlhjOkBJStRZ3va9qZpRUWrR+A1psVXyZ2WVtZvJAmGnbXNGjGWeBS3hGsoj
	 c+aedxlEYh9toVrJ9HY4N/Tgk/9scfN3a658XRZ8sI6qwZ2YY1oqgzZQtZoLwwj60r
	 WxIsuTVxBiFAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2793607C1;
	Wed, 22 Jul 2026 13:27:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A6E32E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F055B401B0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqqaaWRliM9H for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 13:27:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C83EB40100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C83EB40100
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C83EB40100
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:27:45 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4a416619cb2so5949725b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784726865; x=1785331665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oauELqhA6IU0x2XqmeZ/jEIhgb2TwDu2bX2rcpbWTX0=;
 b=PayGWIBtW37uckIAxOqRTz/viv850CuJIMSWEgYAWs9KMj2MBChUw+WtHnEMkgf9Kw
 plaEIh8gaEn5wcEPmuq4J8VJi7pUUbW3RzfEUxRuCaCBiAH4jDPA+HOFRKOPoY7h0Zuc
 /HWaBUnAMTC7CoNFSGUafWmTSXPUELnDBSA60p9EvQ+xKlwJxptx0zdVtMB9PGspY2oi
 YcoZfyFVa1yBlm1TNTE1LQj5iGkZDC0UpLoMLxBN5m0HO6Aw/e7f6mz74tpyvWt2RhRm
 jE4x29Y2HbhFk+8gK9Rgyj20xmZvYH9ucIShOhAt4UwKaJoNNq1tgDbMuLJD1HXUUE6D
 J8TA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHAIWXBk52HAwyiM8qsM/xknE7vlOjFBtw/tDmacrz56cifRHGyUTxB6u0xy5xU3EqJRJUp5M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyG8KQMjIIMe4CSz7E70wzQH/qYvb94jhrmYj4dEFphQhLWX3F2
 hqZesc5M0zfT5gdxS1tQWJk93ARMks0peqnUEXpqYBR239ZX8js7c7Xz2un8NQ==
X-Gm-Gg: AR+sD11hqd1hRQSKmhSKs3yQ0g//1jkMaec4Q/eNoBOnkWhMWkPdJF5/0md2JYIy7rn
 FyvaJCslxIFlWmwEOhbuDMSLnU95MuvGUlRH3NBP00VjcAtuV4slWGndxQaMFnrmoB88J980bQE
 UwSqr01+2Wm+JxoCXB4fcu8K2BhLA9d5Ya8vQyEGjiaJyG1CxHwnusOfkQVMf5qEFhNdzZx1EuZ
 TPQ71vBUtlKCdiXdaLgBG7lKSDYIZdnLoHLFZgwomGjX0ZINDOb0AuFqEKvrbAsQrlw1XmuYsjp
 9CZDjc8y9GT1TUMpUOxeRQ+X3JzNLGggZYRGroWyNzoW5AwjbUT9t6aF5JYox3J3TyX6kbnkN6d
 UDfCTWADpGsVATL6CqKvn/ul6yd0nUjOFIEGl7dqhEyk+cGFVH6+A1kyRHdgYYTkhcZX2N7c8Gx
 N0kDc2GkKxNJRA36T2/KoE1IS8pqSnOhmcqmqqaSMqGJ6Bows=
X-Received: by 2002:a05:6808:5244:b0:495:effa:f06e with SMTP id
 5614622812f47-4a4d049cf64mr13065657b6e.42.1784726864499; 
 Wed, 22 Jul 2026 06:27:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:3a9b:51ad:2c34:1075])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a1756sm1094710b6e.3.2026.07.22.06.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:27:43 -0700 (PDT)
To: u-boot@0leil.net
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2] rockchip: rk3588s: Add support for ROC-PC-RK3588S
Date: Wed, 22 Jul 2026 10:27:28 -0300
Message-ID: <20260722132728.1093856-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784726865; x=1785331665;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oauELqhA6IU0x2XqmeZ/jEIhgb2TwDu2bX2rcpbWTX0=;
 b=MDMtS3W0lNAPdcgp5S3L7muipOV+SNtkG0NlA+WYpc2hpcR7cjRSjEXbC434GVKLEa
 hXxzWgmozva4gbXhklIst17WRZkZOsCLNIeYjckJzkJp11BSgyss9W1XKzKeopMIWb+2
 mtgYJhVyXvd9SoBFbCaJHex5ZtZGPW7byQSOqza+VzgaDLQZq02YQOmlrrrb7QiZ4R8l
 gEsSmjXyXdq6woqiFFMsIVvbbOHAAZHSedEszd7WOtwFT76E4qrnnEiUHKrxEZG9Ha9j
 eadpL1cNQHcSeXT+XLiatDrSJyIR5Txo6Hacd9NEa2RKM9tpf3FSoY4TLPMd9H3CQR3Y
 DvFA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MDMtS3W0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

The ROC-PC-RK3588S board is an SBC made by Firefly, based on the RK3588S
SoC.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Use the traditional environment offsets of 0x3f8000 and 0x400000.
- Keep clock-names in the SPL device tree.
- Drop CONFIG_RTL8169 as the onboard RTL8211F uses CONFIG_PHY_REALTEK.
- Add the accepted upstream USB device-mode changes to
  rk3588s-roc-pc-u-boot.dtsi pending the next devicetree-rebasing sync:
  https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=9d1e32bfdda1aef3291e47c2949b3b9978162a5c

 arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi  | 13 ++++
 arch/arm/mach-rockchip/rk3588/Kconfig    |  7 ++
 board/firefly/roc-pc-rk3588s/Kconfig     | 12 ++++
 board/firefly/roc-pc-rk3588s/MAINTAINERS |  7 ++
 configs/roc-pc-rk3588s_defconfig         | 90 ++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst          |  1 +
 include/configs/roc-pc-rk3588s.h         |  8 +++
 7 files changed, 138 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
 create mode 100644 board/firefly/roc-pc-rk3588s/Kconfig
 create mode 100644 board/firefly/roc-pc-rk3588s/MAINTAINERS
 create mode 100644 configs/roc-pc-rk3588s_defconfig
 create mode 100644 include/configs/roc-pc-rk3588s.h

diff --git a/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
new file mode 100644
index 000000000000..7d97f64ec7a9
--- /dev/null
+++ b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
+
+&usb_host0_xhci {
+	role-switch-default-mode = "peripheral";
+	usb-role-switch;
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 675f13ab66d7..841ae490e85a 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -208,6 +208,12 @@ config TARGET_RK3588_NEU6
 	  IO board and Neu6a needs to mount on top of this IO board in order to
 	  create complete Edgeble Neural Compute Module 6B(Neu6B) IO platform.
 
+config TARGET_ROC_PC_RK3588S
+	bool "Firefly ROC PC RK3588S"
+	help
+	  ROC-PC-RK3588S is a single board computer from Firefly
+	  using the Rockchip RK3588S.
+
 config TARGET_ROCK5A_RK3588
 	bool "Radxa ROCK5A RK3588 board"
 	help
@@ -421,6 +427,7 @@ config SYS_SOC
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/coolpi/genbook_cm5_rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
+source "board/firefly/roc-pc-rk3588s/Kconfig"
 source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
diff --git a/board/firefly/roc-pc-rk3588s/Kconfig b/board/firefly/roc-pc-rk3588s/Kconfig
new file mode 100644
index 000000000000..bded7a2fcba1
--- /dev/null
+++ b/board/firefly/roc-pc-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ROC_PC_RK3588S
+
+config SYS_BOARD
+	default "roc-pc-rk3588s"
+
+config SYS_VENDOR
+	default "firefly"
+
+config SYS_CONFIG_NAME
+	default "roc-pc-rk3588s"
+
+endif
diff --git a/board/firefly/roc-pc-rk3588s/MAINTAINERS b/board/firefly/roc-pc-rk3588s/MAINTAINERS
new file mode 100644
index 000000000000..9a2bb4e69e89
--- /dev/null
+++ b/board/firefly/roc-pc-rk3588s/MAINTAINERS
@@ -0,0 +1,7 @@
+ROC-PC-RK3588S
+M:	Fabio Estevam <festevam@nabladev.com>
+S:	Maintained
+F:	arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
+F:	board/firefly/roc-pc-rk3588s/
+F:	configs/roc-pc-rk3588s_defconfig
+F:	include/configs/roc-pc-rk3588s.h
diff --git a/configs/roc-pc-rk3588s_defconfig b/configs/roc-pc-rk3588s_defconfig
new file mode 100644
index 000000000000..0941c3c08236
--- /dev/null
+++ b/configs/roc-pc-rk3588s_defconfig
@@ -0,0 +1,90 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-roc-pc"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_ROC_PC_RK3588S=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x400000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-roc-pc.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b565aea311e9..d56d245dc114 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -155,6 +155,7 @@ List of mainline supported Rockchip boards:
      - Rockchip EVB (evb-rk3588)
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
+     - Firefly ROC-PC-RK3588S (roc-pc-rk3588s)
      - FriendlyElec CM3588 NAS (cm3588-nas-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
diff --git a/include/configs/roc-pc-rk3588s.h b/include/configs/roc-pc-rk3588s.h
new file mode 100644
index 000000000000..c9316687c38f
--- /dev/null
+++ b/include/configs/roc-pc-rk3588s.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ROC_PC_RK3588S_H
+#define __ROC_PC_RK3588S_H
+
+#include <configs/rk3588_common.h>
+
+#endif /* __ROC_PC_RK3588S_H */
-- 
2.43.0

