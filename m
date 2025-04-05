Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3033CC36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992ED82B12;
	Sun,  6 Apr 2025 02:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=0upti.me header.i=@0upti.me header.b="hTjQtai3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8546882B31; Sat,  5 Apr 2025 22:46:47 +0200 (CEST)
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 342DF82B2F
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 22:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=0upti.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@0upti.me
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3bcd:0:640:dc38:0])
 by forward103d.mail.yandex.net (Yandex) with ESMTPS id 3242A60038
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 23:46:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id fkh57fILa4Y0-H3CzB9Zg; 
 Sat, 05 Apr 2025 23:46:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
 t=1743886002; bh=Adta7BwrBtq1crIOoWh56vHBANAuuw5wN4SGbbh4IpI=;
 h=Cc:Message-Id:To:From:Date:Subject;
 b=hTjQtai3pKClvANpVbc3r9+lTLyInp/j3iJTPLHaCwbkSSzXsUD5KzALxbxCqWWkh
 bt52f9khz6gWAzp7XnQxULnDwElWOkZvugM2DCU9kPYPBv6Zwh+wma3JCTznPIiJ8q
 jdlW0P161dcmSDFtRwnGHSxvKgvi2HfcoJLP/DWQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net;
 dkim=pass header.i=@0upti.me
From: K900 <me@0upti.me>
Date: Sat, 05 Apr 2025 23:46:42 +0300
Subject: [PATCH] board: rockchip: add Xunlong Orange Pi 5 Max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250405-add-opi5-max-v1-1-e02686fc03b6@0upti.me>
X-B4-Tracking: v=1; b=H4sIALGW8WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNT3cSUFN38gkxT3dzECl1TM8skw1TzRFPjJEMloJaCotS0zAqwcdG
 xtbUA4PtDI14AAAA=
X-Change-ID: 20250405-add-opi5-max-569b1e7a53b1
To: u-boot@lists.denx.de
Cc: K900 <me@0upti.me>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Sun, 06 Apr 2025 02:35:48 +0200
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

Signed-off-by: K900 <me@0upti.me>
---
The 5 Max is another board in the Orange Pi 5 family.

It's overall similar to the 5 Plus, but in a smaller form factor,
which leads to some I/O being reshuffled, but nothing relevant
to u-boot.

So, just reuse the config for the 5 Plus and adjust the DT names.
---
 arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi | 20 ++++++
 configs/orangepi-5-max-rk3588_defconfig        | 89 ++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..1ab31a4ec5ab31810039e480189d373a3bb50061
--- /dev/null
+++ b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
+
+&fspim1_pins {
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

---
base-commit: e458e103d4f5fb7aaf13e744c65916ab3ba4a18d
change-id: 20250405-add-opi5-max-569b1e7a53b1

Best regards,
-- 
K900 <me@0upti.me>

