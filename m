Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C0606A331
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e7AkaODm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9813D81468;
	Wed, 11 Nov 2026 16:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RuiB3YCSWPrm; Wed, 11 Nov 2026 16:51:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0FED81422
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415918;
	b=qf0slK+spH+E7ZTVx0koqCP8y5TSi6nfkFArLWfDekdgt+QrXtEhZQoOqYQiW62gvWrW
	 7H0/NIqzXo9t6BGk4nXv82XyF1ocKtCtZoXwihifKloi5qOP7CoKQbwHE6T+Pi2O83oan
	 UoId/Vw85sUr0QVL0OoSTd1WhAIlJrjVXqcfDJxgoayIryt/3hgohWwCxKtKEYqwCb+Gf
	 SHiwxWwX1ffMZuTVGRgUJu6dxT2GFSeRklMTlKUEfzF5raU8IRbBHMSvleSFsQ7iqL/FR
	 2na1646nzbbDZlhuzhNafdJ3l0F4zbxkI8+6rTNLWfTkL7GbF3s+DSS0eqnCmetZExQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yH+TgnvYz9/bAKpycOOrT4586cP8OecP4e9qtndGo9s=;
	b=BoBkeaNwyJ9hJ7aD/hjP7wEGOjVZsXLCSk0PubypL3Rix+vt/ych0sOaazK6k2hhkbS3
	 GguXeooB6rF8jO1EVorsEnUm/XK+YbYD5eSpTJedqGEodLKdX/Fq8GmVG7KmC/JIFmMK2
	 xTJFJiOsX1qePxexOvdHmqXBrb6ooOiuabykVDdIUMWUeOB0dtiI09oyYbezT/0bfnYtE
	 bRVd+tunpnHZia01JmCBnQ/9MwJa/xSY1AWO+8bXwav95S9NKMR029PFAlpa0zD8KT4sY
	 v1p+6mkynDcd4Kmo599VbCEg6UXnQS804KtmG8Qwf/IR4waYiJSu1kWXCH41appGXDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794415918;
	bh=yH+TgnvYz9/bAKpycOOrT4586cP8OecP4e9qtndGo9s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e7AkaODmUBNLdJC3CCeOh4Yf82YkU6MRshTg0wwBfSM21vRqjspxQXZnsD4G8rkZn
	 s31yJZ4YdwXdcm+ku3VfycY7TyEhcnXfSjy/Q0yKVELQ0pdahs0x2fnxcNkh9rZ+7z
	 w2ysZDILM8vUIOBqd/xGP5uk0w9wJpP1LCia1mvqC0zELCVIdSp3gQhN61y9kjl7KH
	 cckX2PlCRsfVmVL61KAJFRVITqHjtyK+wWwM5bSoFrNfAaGHm4xOCgOqJUegSotBPe
	 4+2AtdAqwBcqfAC3T1jJFKDFt3IDEvnksMAPIbXUK4F3E6jpqFWEjAGhz8jV3iuuXd
	 GCZDPgh1KtvAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0FED81422;
	Wed, 11 Nov 2026 16:51:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A806731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B71740873
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 14GYkRZ0j3-P for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D90C40869
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=202.118.224.62
Received: from mail.hit.edu.cn (mail.hit.edu.cn [202.118.224.62])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D90C40869
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=alu.hit.edu.cn
Authentication-Results: smtp4.osuosl.org; spf=pass smtp.mailfrom=alu.hit.edu.cn
Received: from BRN-HXXB.. (unknown [219.223.232.79])
 by mail-appserver03 (Coremail) with UTF8SMTPSA id
 P0WgCgAHxocXnfRqL+UaAA--.48889S4; 
 Thu, 12 Nov 2026 00:51:36 +0800 (CST)
From: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
Subject: [PATCH v2] board: rockchip: Add LCKFB TaishanPi 3M
Date: Thu, 12 Nov 2026 00:51:34 +0800
Message-ID: <20261111165135.245826-1-220110626hanxuechao@alu.hit.edu.cn>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: P0WgCgAHxocXnfRqL_UaAA--.48889S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4kJw1kXrW3Zw18uw4kZwb_yoWxCFyDpw
 n2yFWftrs7Wr17XrZxZFyDGr9YvF4kurWUGr47Xw1UJr95Gw43Grn0krnrC3srXF1DJF48
 ZF93CFy3Ars8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUva14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
 4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
 6r1DMxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
 uYvjfUUBTYUUUUU
X-CM-SenderInfo: yssqiiaqwslx5dq03vpfkd0qhdoxhxllwovvfxof0/1tbiAgQIAGr0UYYJWAAAsW
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the LCKFB TaishanPi 3M, an RK3576 based board.

The board device tree describes the microSD card detect pin as a plain
GPIO (sdmmc0_det_l) for its cd-gpios property. dw_mmc does not use
cd-gpios, so the pad stays in GPIO mode and switching the bus to 4-bit
high speed fails with:

  CMD_SEND:6
    ARG                      0x80fffff1
    RET                      -110
  unable to select a mode
  mmc_init: -524

Use the sdmmc0_det pinmux in the U-Boot device tree, like other Rockchip
boards do, so the card detect signal reaches the SDMMC controller.

The board has a number of optional peripherals that need device tree
overlays to be described.  The EFI boot manager is a global boot method,
so it runs before any normal boot method and would take over the boot flow
before boot.scr has a chance to apply those overlays.  Disable
CONFIG_BOOTMETH_EFI_BOOTMGR for this board; the 'efi' boot method stays
enabled, so an .efi payload in /EFI/BOOT/ can still be booted as a
fallback after extlinux and script.

Signed-off-by: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>

Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>

---
v2:
- Drop the file header comment, the path already says what the file is.
- Disable CONFIG_BOOTMETH_EFI_BOOTMGR instead of overriding bootcmd and
  boot_targets, so the default boot targets are kept and the other boot
  methods remain available.
- Drop CONFIG_SPL_DM_RESET, the board boots from eMMC and does not need
  the reset subsystem in SPL.
- Keep clock-names in CONFIG_OF_SPL_REMOVE_PROPS, all RK3576 boards do so.
- Do not enable CONFIG_DWC_AHCI: the mini-PCIe style slot is configured
  as SATA in the board device tree (&sata0 is okay, for Linux), the same
  serdes lanes can be re-routed to PCIe or USB by an overlay, and no SATA
  device was available for testing.
---
 arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi | 23 +++++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  6 ++
 configs/lckfb-tspi-3m-rk3576_defconfig        | 64 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 4 files changed, 94 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
 create mode 100644 configs/lckfb-tspi-3m-rk3576_defconfig

diff --git a/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
new file mode 100644
index 00000000000..88165566796
--- /dev/null
+++ b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
+
+/*
+ * Use sdmmc0_det (SDMMC0_DETN) instead of sdmmc0_det_l, which the board device
+ * tree selects as a plain GPIO for its cd-gpios.  dw_mmc does not read
+ * cd-gpios, so the pad stays in GPIO mode and the switch to 4-bit high speed
+ * mode fails; both entries are GPIO0_A7 with the same pull-up and only the mux
+ * value differs:
+ *
+ *	CMD_SEND:6
+ *		ARG                      0x80fffff1
+ *		RET                      -110
+ *	unable to select a mode
+ *	mmc_init: -524
+ *
+ * 1-bit/25 MHz still works, so the slot looks alive until the first wide bus
+ * data transfer.
+ */
+&sdmmc {
+	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_det &sdmmc0_bus4>;
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index baae63fc7b0..158fc1421b4 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -4,6 +4,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3576-generic*
 F:	configs/generic-rk3576_defconfig
 
+LCKFB-TSPI-3M-RK3576
+M:	Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
+S:	Maintained
+N:	rk3576-lckfb-tspi-3m
+F:	configs/lckfb-tspi-3m-rk3576_defconfig
+
 NANOPI-M5-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/lckfb-tspi-3m-rk3576_defconfig b/configs/lckfb-tspi-3m-rk3576_defconfig
new file mode 100644
index 00000000000..368e7168ac3
--- /dev/null
+++ b/configs/lckfb-tspi-3m-rk3576_defconfig
@@ -0,0 +1,64 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-lckfb-tspi-3m"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-lckfb-tspi-3m.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_MAXIO=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
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
index e22c2d6c575..832c9043a14 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -150,6 +150,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi M5 (nanopi-m5-rk3576)
      - FriendlyElec NanoPi R76S (nanopi-r76s-rk3576)
      - Generic RK3576 (generic-rk3576)
+     - LCKFB TaishanPi 3M (lckfb-tspi-3m-rk3576)
      - Luckfox Omni3576 (omni3576-rk3576)
      - Radxa ROCK 4D (rock-4d-rk3576)
 
-- 
2.47.3

