Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D4AC369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 12:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EB482D17;
	Sat, 12 Apr 2025 14:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=0upti.me header.i=@0upti.me header.b="kdqw3k/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FEF484229; Sat, 12 Apr 2025 07:59:52 +0200 (CEST)
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net
 [178.154.239.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D183C82C79
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 07:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=0upti.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@0upti.me
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4d95:0:640:af03:0])
 by forward100a.mail.yandex.net (Yandex) with ESMTPS id 2345646D11
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 08:59:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id ex6RBiBLha60-Wq6BiGah; 
 Sat, 12 Apr 2025 08:59:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
 t=1744437588; bh=RPzH7EzE7cQnWVtnV0xZEp4DeFFeCNAaj6DLegDzQV0=;
 h=Cc:Message-Id:To:From:Date:Subject;
 b=kdqw3k/C4zXQgKxLwm+RzvXWs34pGZaHD30G8fhhAIruwT8je1llOfN7pBRNqZtkr
 xA9F19lXEx4SUZa3f7x5R0zXCg9LGYfNnwPShOhLrjjW8yAuo6pCLS5STAEJ9utNSQ
 G85gYpvicDbXWPVgyZ3qh2ba3rd15M470jkEJzVw=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@0upti.me
From: Ilya Katsnelson <me@0upti.me>
Date: Sat, 12 Apr 2025 08:59:32 +0300
Subject: [PATCH v2] board: rockchip: add Xunlong Orange Pi 5 Max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-add-opi5-max-v2-1-585197588511@0upti.me>
X-B4-Tracking: v=1; b=H4sIAEMB+mcC/3XMQQ6CMBCF4auQWTumLbYqK+9hWBQ6yCygpMUGQ
 3p3K3uX/0vet0OkwBShqXYIlDiyn0uoUwX9aOcXIbvSoITS4iI0WufQL6xxshtqc+8kXa2uOwn
 lsgQaeDu4Z1t65Lj68Dn0JH/rHyhJlEhCmZsZelF35iHey8rniaDNOX8B/4L6VacAAAA=
X-Change-ID: 20250405-add-opi5-max-569b1e7a53b1
To: u-boot@lists.denx.de
Cc: Ilya Katsnelson <me@0upti.me>, K900 <me@0upti.me>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Sat, 12 Apr 2025 14:42:07 +0200
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

The 5 Max is another board in the Orange Pi 5 family.

It's overall similar to the 5 Plus, but in a smaller form factor,
which leads to some I/O being reshuffled, but nothing relevant
to u-boot.

So, just reuse the config for the 5 Plus and adjust the DT names.

Signed-off-by: Ilya Katsnelson <me@0upti.me>
---
The 5 Max is another board in the Orange Pi 5 family.

It's overall similar to the 5 Plus, but in a smaller form factor,
which leads to some I/O being reshuffled, but nothing relevant
to u-boot.

So, just reuse the config for the 5 Plus and adjust the DT names.

Signed-off-by: K900 <me@0upti.me>
---
Changes in v2:
- fixed pinctrl definition for the flash
- added docs and MAINTAINERS entries
- fixed signoff line to use my real name
- Link to v1: https://lore.kernel.org/r/20250405-add-opi5-max-v1-1-e02686fc03b6@0upti.me
---
 arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi | 20 ++++++
 board/rockchip/evb_rk3588/MAINTAINERS          |  7 ++
 configs/orangepi-5-max-rk3588_defconfig        | 89 ++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst                |  1 +
 4 files changed, 117 insertions(+)

diff --git a/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..afd33dd3248a92a721c2f5a6789f395a5b577ae5
--- /dev/null
+++ b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
+
+&fspim2_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
+
+&sfc {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index a858ab163f362f4fc0dd578830fe84b20d9ca429..3011c0a852e7e022dec4e07f7c16843862cd5527 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -42,3 +42,10 @@ S:	Maintained
 F:	configs/orangepi-5-plus-rk3588_defconfig
 F:	arch/arm/dts/rk3588-orangepi-5-plus.dts
 F:	arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
+
+ORANGEPI-5-MAX-RK3588
+M:	Ilya Katsnelson <me@0upti.me>
+S:	Maintained
+F:	configs/orangepi-5-max-rk3588_defconfig
+F:	arch/arm/dts/rk3588-orangepi-5-plus.dts
+F:	arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
diff --git a/configs/orangepi-5-max-rk3588_defconfig b/configs/orangepi-5-max-rk3588_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..a655dfe2d64168b2d6a3b400abd4c03d9d4bc402
--- /dev/null
+++ b/configs/orangepi-5-max-rk3588_defconfig
@@ -0,0 +1,89 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-orangepi-5-max"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-max.dtb"
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
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_PHYLIB=y
+CONFIG_RTL8169=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
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
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1407080f1f4fd226b80e34689a34c88f3c37150a..00d9587e9880937125f7ace229740f10f2c959c4 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -149,6 +149,7 @@ List of mainline supported Rockchip boards:
      - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
      - Turing Machines RK1 (turing-rk1-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
+     - Xunlong Orange Pi 5 Max (orangepi-5-max-rk3588)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
      - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
      - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)

---
base-commit: e458e103d4f5fb7aaf13e744c65916ab3ba4a18d
change-id: 20250405-add-opi5-max-569b1e7a53b1

Best regards,
-- 
Ilya Katsnelson <me@0upti.me>

