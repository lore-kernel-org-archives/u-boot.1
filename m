Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE09FC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 19:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64328644A;
	Wed, 23 Aug 2023 21:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uZpstE3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55E18645F; Wed, 23 Aug 2023 21:56:48 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918318644A
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 21:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 63B173F038; 
 Wed, 23 Aug 2023 19:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692820605;
 bh=AEVsw4iF72kGrClPw1hgsWV0zUHtZwcRnFjt3xqQ2jM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=uZpstE3f2A4dO4+Ayv8rVUFq2a2mg+BqSICD6Hznm2xZtTWYID1akdZHRKMeHux5X
 NzcTHzgLqbCLLIPMidln1HesGoyJOLDLzH9o3iSDTQnwB8ob+QYeM2l0jMUj95jMKH
 4t/4SMR9uY7Vxji2sEfTEHfK9G5C0qM55ZAYIdWWRbt7qRG4rbwzxWmLKgosPaPLFt
 1vRKz9ycCATYQtruWUOIvMsy7EK2x/gSHnF6QI0dGvwx/V6IgFHd07qZeaxwxWT0q6
 wWb8fmfKOV2hAOk42CP9h5IsUNFqB3FOXzgKXmpAquMwlfAm+A1jD/jW0FKA/0Y/M1
 Ou23yN3aZ3T7Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Date: Wed, 23 Aug 2023 21:57:28 +0200
Message-Id: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

This is a stub describing how TPL, VPL, and SPL load the next boot stages
on a detail level for users.

For sure we will need a few patches on top to catch the whole complexity.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/index.rst    |   1 +
 doc/usage/spl_boot.rst | 309 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 310 insertions(+)
 create mode 100644 doc/usage/spl_boot.rst

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 072db53614..7f0b26cc5a 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -4,6 +4,7 @@ Use U-Boot
 .. toctree::
    :maxdepth: 1
 
+   spl_boot
    blkmap
    dfu
    environment
diff --git a/doc/usage/spl_boot.rst b/doc/usage/spl_boot.rst
new file mode 100644
index 0000000000..05a3bf390d
--- /dev/null
+++ b/doc/usage/spl_boot.rst
@@ -0,0 +1,309 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Booting from TPL/SPL
+====================
+
+The main U-Boot binary may be to large to be loaded directly by the Boot ROM.
+This was the main driver for splitting up U-Boot into multiple boot stages with
+successively larger binaries.
+
+U-Boot typically goes through the following boot phases where TPL, VPL, and SPL
+are optional. While many boards use SPL only few use TPL.
+
+TPL
+   Very early init, as tiny as possible. This loads SPL (or VPL if enabled).
+
+VPL
+   Optional verification step, which can select one of several SPL binaries,
+   if A/B verified boot is enabled. Implementation of the VPL logic is
+   work-in-progress. For now it just boots into SPL.
+
+SPL
+   Secondary program loader. Sets up SDRAM and loads U-Boot proper. It may also
+   load other firmware components.
+
+U-Boot
+   U-Boot proper, containing the command line and boot logic.
+
+Only main U-Boot has a command line interface.
+
+Further usages for U-Boot SPL comprise:
+
+* Launching BL31 of ARM Trusted Firmware which invokes U-Boot as BL33
+* launching EDK II
+* launching Linux
+* launching RISC-V OpenSBI which invokes main U-Boot
+
+Target binaries
+---------------
+
+Binaries loaded by SPL/TPL can be:
+
+* raw binaries where the entry address equals the start address. This is the
+  only binary format supported by TPL.
+* :doc:`FIT <fit/index>` images
+* legacy U-Boot images
+
+Configuration
+~~~~~~~~~~~~~
+
+Raw images are only supported in SPL if CONFIG_SPL_RAW_IMAGE_SUPPORT=y.
+
+CONFIG_SPL_FIT=y and CONFIG_SPL_LOAD_FIT=y are needed to load FIT images.
+
+CONFIG_SPL_LEGACY_IMAGE_FORMAT=y is needed to load legacy U-Boot images.
+CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y enables checking the CRC32 of legacy U-Boot
+images.
+
+Image load methods
+------------------
+
+The image boot methods available for a board must be defined in two places:
+
+The board code implements a function board_boot_order() enumerating up to
+six boot methods and the sequence in which they are tried. If there is only one
+boot method function, spl_boot_device() may be implemented instead.
+
+The configuration controls which of these boot methods are actually available.
+
+BOOTROM
+    The binary is loaded by the boot ROM.
+    Required configuration settings include:
+
+    * CONFIG_SPL_BOOTROM_SUPPORT=y or CONFIG_TPL_BOOTROM_SUPPORT=y
+
+DFU
+    :doc:`Device Firmware Upgrade <dfu>` is used to load the binary into RAM.
+    Required configuration settings include:
+
+    * CONFIG_DFU=y 
+
+    * CONFIG_SPL_RAM_SUPPORT=y or CONFIG TPL_RAM_SUPPORT=y
+
+Ethernet (CPGMAC)
+    This method loads an image over Ethernet. The BOOTP protocol is used to find
+    a TFTP server and binary name. The binary is downloaded via the TFTP
+    protocol. Required configuration settings include:
+
+    * CONFIG_SPL_NET=y or CONFIG_TPL_NET=y
+
+    * CONFIG_SPL_ETH_DEVICE
+
+FEL
+    This method does not actually load an image for U-Boot.
+    FEL is a routine contained in the boot ROM of Allwinner SoCs which serves
+    for the initial programming or recovery via USB
+
+MMC1, MMC2, MMC2_2
+    These methods read an image from SD card or eMMC. The first digit after
+    'MMC' indicates the device number. Required configuration settings include:
+
+    * CONFIG_SPL_MMC=y or CONFIG_TPL_MMC=y
+
+    To use a PCI connected MMC controller you need to additionally specify:
+
+    * CONFIG_SPL_PCI=y
+
+    * CONFIG_SPL_PCI_PNP=y
+
+    * CONFIG_MMC=y
+
+    * CONFIG_MMC_PCI=y
+
+    * CONFIG_MMC_SDHCI=y
+
+    To load from a file system use:
+
+    * CONFIG_SPL_FS_FAT=y or CONFIG_SPL_FS_EXT=y
+
+    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
+
+NAND
+    This method loads the image from NAND flash. To read from raw NAND the
+    following configuraton settings are required:
+
+    * CONFIG_SPL_NAND_SUPPORT=y or CONFIG_TPL_NAND_SUPPORT=y
+
+    If CONFIG_SPL_NAND_RAW_ONLY=y only raw images can be loaded.
+
+    For using the Ubi file system to read from NAND the following configuration
+    settings are required:
+
+    * CONFIG_SPL_UBI=y of CONFIG_TPL_UBI=y
+
+NOR
+    This method loads the image from NOR flash.
+    Required configuration settings include:
+
+    * CONFIG_SPL_NOR_SUPPORT=y or CONFIG_TPL_NOR_SUPPORT=y
+
+NVMe
+    This methods load the image from an NVMe drive.
+    Required configuration settings include:
+
+    * CONFIG_SPL_PCI=y
+
+    * CONFIG_SPL_PCI_PNP=y
+
+    * CONFIG_SPL_NVME=y
+
+    * CONFIG_SPL_NVME_PCI=y
+
+    * CONFIG_SPL_NVME_BOOT_DEVICE (number of the NVMe device)
+
+    * CONFIG_SYS_NVME_BOOT_PARTITION (partition to read from)
+
+    To load from a file system use:
+
+    * CONFIG_SPL_FS_FAT=y or CONFIG_SPL_FS_EXT=y
+
+    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
+
+OneNAND
+    This methods loads the image from a OneNAND device. To read from raw OneNAND
+    the following configuraton settings are required:
+
+    * CONFIG_SPL_ONENAND_SUPPORT=y or CONFIG_TPL_ONENAND_SUPPORT=y
+
+    For using the Ubi file system to read from NAND the following configuration
+    settings are required:
+
+    * CONFIG_SPL_UBI=y of CONFIG_TPL_UBI=y
+
+RAM
+    This method uses an image preloaded into RAM.
+    Required configuration settings include:
+
+    * CONFIG_SPL_RAM_SUPPORT=y or CONFIG_TPL_RAM_SUPPORT=y
+
+    * CONFIG_RAM_DEVICE=y
+
+sandbox_file
+    On the sandbox this method loads an image from the host file system.
+
+sandbox_image
+    On the sandbox this method loads an image from the host file system.
+
+SATA
+    This method reads an image from a SATA drive.
+    Required configuration settings include:
+
+    * CONFIG_SPL_SATA=y or CONFIG_TPL_SATA=y
+
+    To use a PCIe connecte SATA controller you additionally need:
+
+    * CONFIG_SPL_PCI=y
+
+    * CONFIG_SPL_SATA=y
+
+    * CONFIG_SPL_AHCI_PCI=y
+
+    * CONFIG_SPL_PCI_PNP=y
+
+    To load from a file system use:
+
+    * CONFIG_SPL_FS_FAT=y
+
+    * CONFIG_SYS_SATA_FAT_BOOT_PARTITION=<partition number>
+
+    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
+
+SEMIHOSTING
+    When running in an ARM or RISC-V virtual machine the semihosting method can
+    be used to load an image from the host file system.
+    Required configuration settings include:
+
+    * CONFIG_SPL_SEMIHOSTING=y
+
+    * CONFIG_SPL_SEMIHOSTING_FALLBACK=y
+
+    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=<path to file>
+
+SPI
+    This method loads an image form SPI NOR flash.
+    Required configuration settings include:
+
+    * CONFIG_SPL_DM_SPI=y
+
+    * CONFIG_SPL_SPI_FLASH=y
+
+    * CONFIG_SPI_LOAD=y or CONFIG_TPL_SPI_LOAD=y
+
+
+sunxi SPI
+    This method which is specific to Allwinner SoCs loads an image form SPI NOR
+    flash. Required configuration settings include:
+
+    * CONFIG_SPL_SPI_SUNXI=y
+
+UART
+    This method loads an image via the Y-Modem protocol from the UART.
+    Required configuration settings include:
+
+    * CONFIG_SPL_YMODEM_SUPPORT=y or CONFIG_TPL_YMODEM_SUPPORT=y
+
+USB
+    The USB method loads an image from a USB block device.
+    Required configuration settings include:
+    
+    * CONFIG_SPL_USB_HOST=y
+
+    * CONFIG_SPL_USB_STORAGE=y
+
+    To use a PCI connected USB 3.0 controller you additionally need:
+
+    * CONFIG_SPL_FS_FAT=y
+
+    * CONFIG_SPL_PCI=y
+
+    * CONFIG_SPL_PCI_PNP=y
+
+    * CONFIG_USB=y
+
+    * CONFIG_USB_XHCI_HCD=y
+
+    * CONFIG_USB_XHCI_PCI=y
+
+    To load from a file system use:
+
+    * CONFIG_SPL_FS_FAT=y or CONFIG_SPL_FS_EXT=y
+
+    * CONFIG_SYS_USB_FAT_BOOT_PARTITION=<partition number>
+
+    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
+
+USB eth
+    This method loads an image over Ethernet. The BOOTP protocol is used to find
+    a TFTP server and binary name. The binary is downloaded via the TFTP
+    protocol. Required configuration settings include:
+
+    * CONFIG_SPL_NET=y or CONFIG_TPL_NET=y
+
+    * CONFIG_DM_USB_GADGET=y.
+
+USB SDP
+    This method loads the image using the Serial Download Protocol as
+    implemented by the boot ROM of the i.MX family of SoCs.
+
+    Required configuration settings include:
+
+    * CONFIG_SPL_SERIAL=y
+
+    * CONFIG_SPL_USB_SDP_SUPPORT=y or CONFIG_TPL_USB_SDP_SUPPORT
+
+vbe_simple
+    This method is used by the VPL stage to extract the next stage image from
+    the loaded image.
+
+    Required configuration settings include:
+
+    * CONFIG_VPL=y
+
+    * CONFIG_SPL_BOOTMETH_VBE_SIMPLE_FW=y or CONFIG_TPL_BOOTMETH_VBE_SIMPLE_FW=y
+
+XIP
+    This method executes an image in place.
+
+    Required configuration settings include:
+
+    * CONFIG_SPL_XIP_SUPPORT
-- 
2.40.1

