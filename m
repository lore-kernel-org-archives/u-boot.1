Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA19C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC9088622;
	Mon,  6 May 2024 16:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qBiSqqd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCDEF88629; Mon,  6 May 2024 16:39:06 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C731E885B5
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 16:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715006344;
 bh=RE73Mn6Do3+kjc+AR5sq4tWMvLBmml1dnHQgv88B3U0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qBiSqqd4EeetZB27u6J00jOBZtn33cy234zOFOFw2a9bpqJalarjmWn/r9y5ph0Ir
 oY4Pe4PwdBhPieuFFFXVGgnz192hP7QcFPoyoT0qr+T0TalpovX0I250ItTzoy3Xxm
 AvxEVm64K9Ijsxc9IBH+ImMkJYWhDr39CHsurgW071lJt89GuM0EbTQVDIJqV8ZR3t
 yLpH2WsXsO0jIN/hKE5SCBeUOYDQpQaa8RAaucllJHeY12mT32TYZErSWnUMounJqo
 wLAcYG6jBwUFr3N3yl851GpLdErKmZLaPfMtL8lWnCOF3MQt5FpgSjowSMF224DYv9
 pryFkMiNLES6A==
Received: from pan.lan (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com
 [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id F0142378215D;
 Mon,  6 May 2024 14:39:03 +0000 (UTC)
From: Martyn Welch <martyn.welch@collabora.com>
To: Dave Gerlach <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH v5 4/6] configs: am62x_evm_*: Enable USB and DFU support
Date: Mon,  6 May 2024 15:38:44 +0100
Message-ID: <20240506143846.1252377-5-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506143846.1252377-1-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
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

From: Sjoerd Simons <sjoerd@collabora.com>

Provide config fragments to enable USB host as well as USB gadget and DFU
support for a53 and r5. This relevant fragment is included into the
am62x EVM a53 defconfig. For the r5, due to the smaller available size,
the config fragment also disables support for persistent storage to free
up space for USB support. This fragment needs to be included is DFU
booting is desired.

The CONFIG_DFU_SF option is placed in the defconfig rather than the
fragment as this is known not to be supported on all boards that can
support DFU.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
Changes in v5:
- Switch to config fragment for a53 most DFU configuration

Changes in v4:
- Move R5 dfu config to a config fragment rather then a full defconfig
- Don't enable XHCI for the R5 SPL, unneeded

Changes in v3:
- Run savedefconfig to adjust to more recent u-boot

Changes in v2:
- Create a seperate defconfig for R5



 configs/am62x_a53_usbdfu.config | 30 ++++++++++++++++++++++++++++++
 configs/am62x_evm_a53_defconfig |  2 ++
 configs/am62x_r5_usbdfu.config  | 28 ++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 configs/am62x_a53_usbdfu.config
 create mode 100644 configs/am62x_r5_usbdfu.config

diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
new file mode 100644
index 0000000000..3a19cf2328
--- /dev/null
+++ b/configs/am62x_a53_usbdfu.config
@@ -0,0 +1,29 @@
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_DFU=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_USB=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 6c708dcb05..16294a6a79 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -68,6 +68,7 @@ CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_SF=y
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
@@ -111,3 +112,5 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
+
+#include <configs/am62x_a53_usbdfu.config>
diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
new file mode 100644
index 0000000000..772bb2ab93
--- /dev/null
+++ b/configs/am62x_r5_usbdfu.config
@@ -0,0 +1,28 @@
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_MISC=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_FS_FAT is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
+# CONFIG_SPL_SPI is not set
+# CONFIG_SPL_SYS_MALLOC is not set
+# CONFIG_CMD_GPT is not set
+# CONFIG_CMD_MMC is not set
+# CONFIG_CMD_FAT is not set
+# CONFIG_MMC_SDHCI is not set
-- 
2.43.0

