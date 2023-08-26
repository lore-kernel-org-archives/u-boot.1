Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECA0C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 09:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DBC86A69;
	Sat, 26 Aug 2023 11:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="byskxAA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB8D86B35; Sat, 26 Aug 2023 11:12:53 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3598286A69
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 11:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6D4673F6C1; 
 Sat, 26 Aug 2023 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693041169;
 bh=ahfpdEIjlIsEn7s2PUWlrGGF4S0rjIVg2AkG4oPBkY0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=byskxAA1EZ15d/vZaZBEs6m6g9rl2taOxkafQWoOFYpKYxWtWAxq9MfAK/9JsUEgR
 3GRkrvS/3qZe/wSn8pJg+TMiLDjlkSfawfcxwDIkdy8hbFGADM1VKUOE7Q9s/qVQmG
 kFEeCmvzp8AgdM9/aGTCD4zJhIZH3H0o0Xzuo2QIbpJdG/Bvm0bncuX+cxGSjhgnP1
 o+cx9JRsdXj3aXZN5heye2zxCFrH7Gz5jsG51/0tu3L5kcipOensYZEbONQvh4eUwg
 0HSG/8QNZOZoNdE7FWZzX/pJqwRvqAr9hah+snlqSQ9vKPbvU2dYyAvR+THNjlkWDT
 WX2Jfi6U47jjw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/1] doc: describe TPL/VPL/SPL boot
Date: Sat, 26 Aug 2023 11:13:35 +0200
Message-Id: <20230826091335.26459-1-heinrich.schuchardt@canonical.com>
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
v3:
	Call TPL Tertiary Program Loader, VPL Verifying Program Loader
	Put Power PC flow into an info box to stick out
	Add link to Falcon Mode
	Fix typos
v2:
	Mention that PowerPC uses a different naming convention.
	Group boot devices by type
	Correct reference to UBI
	Fix typos
---
 doc/usage/index.rst    |   1 +
 doc/usage/spl_boot.rst | 323 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 324 insertions(+)
 create mode 100644 doc/usage/spl_boot.rst

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 3326ec82ff..f45a7f5502 100644
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
index 0000000000..ad6bf0ab69
--- /dev/null
+++ b/doc/usage/spl_boot.rst
@@ -0,0 +1,323 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Booting from TPL/SPL
+====================
+
+The main U-Boot binary may be too large to be loaded directly by the Boot ROM.
+This was the original driver for splitting up U-Boot into multiple boot stages.
+
+U-Boot typically goes through the following boot phases where TPL, VPL, and SPL
+are optional. While many boards use SPL only few use TPL.
+
+TPL
+   Tertiary Program Loader. Very early init, as tiny as possible. This loads SPL
+   (or VPL if enabled).
+
+VPL
+   Verifying Program Loader. Optional verification step, which can select one of
+   several SPL binaries, if A/B verified boot is enabled. Implementation of the
+   VPL logic is work-in-progress. For now it just boots into SPL.
+
+SPL
+   Secondary Program Loader. Sets up SDRAM and loads U-Boot proper. It may also
+   load other firmware components.
+
+U-Boot
+   U-Boot proper, containing the command line and the logic to load an
+   operating system, e.g. via UEFI.
+
+.. note::
+
+   The naming convention on the PowerPC architecture deviates from the other
+   archtitectures. Here the boot sequence is SPL->TPL->U-Boot.
+
+Only main U-Boot has a command line interface.
+
+Further usages for U-Boot SPL comprise:
+
+* launching BL31 of ARM Trusted Firmware which invokes U-Boot as BL33
+* launching EDK II
+* launching Linux, e.g. :doc:`Falcon Mode' <../develop/falcon>`
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
+five boot methods and the sequence in which they are tried. (The maximum
+number of boot methods is currently hard coded as variable spl_boot_list[]).
+If there is only one boot method function, spl_boot_device() may be implemented
+instead.
+
+The configuration controls which of these boot methods are actually available.
+
+Loading from block devices
+~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+Loading from flash devices
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+NAND
+    This method loads the image from NAND flash. To read from raw NAND the
+    following configuration settings are required:
+
+    * CONFIG_SPL_NAND_SUPPORT=y or CONFIG_TPL_NAND_SUPPORT=y
+
+    If CONFIG_SPL_NAND_RAW_ONLY=y only raw images can be loaded.
+
+    For using UBI (Unsorted Block Images) volumes to read from NAND the
+    following configuration settings are required:
+
+    * CONFIG_SPL_UBI=y or CONFIG_TPL_UBI=y
+
+    The UBI volume to read can either be specified
+
+    * by name using CONFIG_SPL_UBI_LOAD_BY_VOLNAME or
+
+    * by number using CONFIG_SPL_UBI_LOAD_MONITOR_ID.
+
+NOR
+    This method loads the image from NOR flash.
+    Required configuration settings include:
+
+    * CONFIG_SPL_NOR_SUPPORT=y or CONFIG_TPL_NOR_SUPPORT=y
+
+OneNAND
+    This methods loads the image from a OneNAND device. To read from raw OneNAND
+    the following configuration settings are required:
+
+    * CONFIG_SPL_ONENAND_SUPPORT=y or CONFIG_TPL_ONENAND_SUPPORT=y
+
+    For using the Ubi file system to read from NAND the following configuration
+    settings are required:
+
+    * CONFIG_SPL_UBI=y or CONFIG_TPL_UBI=y
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
+Sunxi SPI
+    This method which is specific to Allwinner SoCs loads an image form SPI NOR
+    flash. Required configuration settings include:
+
+    * CONFIG_SPL_SPI_SUNXI=y
+
+Loading from other devices
+~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+Ethernet
+    This method loads an image over Ethernet. The BOOTP protocol is used to find
+    a TFTP server and binary name. The binary is downloaded via the TFTP
+    protocol. Required configuration settings include:
+
+    * CONFIG_SPL_NET=y or CONFIG_TPL_NET=y
+
+    * CONFIG_SPL_ETH_DEVICE=y or CONFIG_DM_USB_GADGET=y
+
+FEL
+    This method does not actually load an image for U-Boot.
+    FEL is a routine contained in the boot ROM of Allwinner SoCs which serves
+    for the initial programming or recovery via USB
+
+RAM
+    This method uses an image preloaded into RAM.
+    Required configuration settings include:
+
+    * CONFIG_SPL_RAM_SUPPORT=y or CONFIG_TPL_RAM_SUPPORT=y
+
+    * CONFIG_RAM_DEVICE=y
+
+Sandbox file
+    On the sandbox this method loads an image from the host file system.
+
+Sandbox image
+    On the sandbox this method loads an image from the host file system.
+
+Semihosting
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
+UART
+    This method loads an image via the Y-Modem protocol from the UART.
+    Required configuration settings include:
+
+    * CONFIG_SPL_YMODEM_SUPPORT=y or CONFIG_TPL_YMODEM_SUPPORT=y
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
+VBE Simple
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

