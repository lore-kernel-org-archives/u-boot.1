Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D3AC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA4686456;
	Wed, 23 Aug 2023 22:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692822340;
	bh=SwZXPNIINPKUn6rqXiqtnS8BX1EfrcAI0mQdFa2MDwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6p3PJmaBCu7xvv8oHOEEJym7jCoEp1u656Ne/tmIuoW6nkpReqL84MeFUNT9SppB
	 +i6H0pAOjxeOTV/lJwm2I1CWX1YgwjOz/cU+nJE4R3nU6SWKpCgFKez9VC3Hr/9Q15
	 WbYc8YPoFHnpihcFqLZCXUDkt9ttRSOwDarVIKN3/gTsG0Kaa0+fcM1kJCveHroM7s
	 /z/A9FYPLXhr1tedHQgE6xsHjbPNAq8rXO/uTqun/wtj09qHrBn15JZkGNnS8FhJQD
	 CVuLhUoFoKTxOaxT/Ckn5YVKLNVcIyknOFTURFqbPyFHiR2Gnyz29cxAikS0zNaFIt
	 ZWy/XRtCe8gfw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 616A68640E;
 Wed, 23 Aug 2023 22:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692822340;
 bh=SwZXPNIINPKUn6rqXiqtnS8BX1EfrcAI0mQdFa2MDwA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e602x1XCPgCLD88+7nrEIJHWT83JP1+nvjzIoeglrNrHqF8DXWttkMPKX0o8MN2Rc
 cwbtIHr6QtVW1vgCJDZfRztFbgTcYNik71K6tyXZBAzytt4O3InTu4gQJy1JZBE8K+
 2PAj9XHZuagklwi4H2oQLxjLDwPHBcTbF0szGbTPtjzhZ7JUc+mtR7MQxYmC5bQn95
 v2h1eHT1Q+Xi31xJKRIJ4anxnrhCVcUz0sU3zu2SRw4It0kDIxFsPYxzvx/oIjJlrh
 o/QdR09/u7PNUeMrEEWFgvovs7LURJ633oG0FGZQ6xnUocnSKmZe0s2m3h6renjCby
 PTXKOnP704e5g==
Message-ID: <993cc97e-9887-68d1-fc65-2cb3aa7adf12@denx.de>
Date: Wed, 23 Aug 2023 22:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/23/23 21:57, Heinrich Schuchardt wrote:
> This is a stub describing how TPL, VPL, and SPL load the next boot stages
> on a detail level for users.
> 
> For sure we will need a few patches on top to catch the whole complexity.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   doc/usage/index.rst    |   1 +
>   doc/usage/spl_boot.rst | 309 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 310 insertions(+)
>   create mode 100644 doc/usage/spl_boot.rst
> 
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 072db53614..7f0b26cc5a 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -4,6 +4,7 @@ Use U-Boot
>   .. toctree::
>      :maxdepth: 1
>   
> +   spl_boot
>      blkmap
>      dfu
>      environment
> diff --git a/doc/usage/spl_boot.rst b/doc/usage/spl_boot.rst
> new file mode 100644
> index 0000000000..05a3bf390d
> --- /dev/null
> +++ b/doc/usage/spl_boot.rst
> @@ -0,0 +1,309 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Booting from TPL/SPL
> +====================
> +
> +The main U-Boot binary may be to 

too

> large to be loaded directly by the Boot ROM.
> +This was the main driver for splitting up U-Boot into multiple boot stages with
> +successively larger binaries.

Maybe not binaries, but something like "code working set" or so, since 
e.g. ATF BL31 may be smaller than SPL, but it is still loaded and 
started by SPL as PSCI provided e.g. on NXP MX8M.

> +U-Boot typically goes through the following boot phases where TPL, VPL, and SPL
> +are optional. While many boards use SPL only few use TPL.
> +
> +TPL
> +   Very early init, as tiny as possible. This loads SPL (or VPL if enabled).

Tiny Program Loader ?

> +VPL
> +   Optional verification step, which can select one of several SPL binaries,
> +   if A/B verified boot is enabled. Implementation of the VPL logic is
> +   work-in-progress. For now it just boots into SPL.
> +
> +SPL
> +   Secondary program loader. Sets up SDRAM and loads U-Boot proper. It may also
> +   load other firmware components.
> +
> +U-Boot
> +   U-Boot proper, containing the command line and boot logic.

boot logic can also be in SPL btw

> +Only main U-Boot has a command line interface.
> +
> +Further usages for U-Boot SPL comprise:
> +
> +* Launching BL31 of ARM Trusted Firmware which invokes U-Boot as BL33
> +* launching EDK II
> +* launching Linux
> +* launching RISC-V OpenSBI which invokes main U-Boot

Launching in caps or lowercase , consistency please.

> +Target binaries
> +---------------
> +
> +Binaries loaded by SPL/TPL can be:
> +
> +* raw binaries where the entry address equals the start address. This is the
> +  only binary format supported by TPL.
> +* :doc:`FIT <fit/index>` images
> +* legacy U-Boot images

fitImages too .

Also mention authentication of next stage.

> +Configuration
> +~~~~~~~~~~~~~
> +
> +Raw images are only supported in SPL if CONFIG_SPL_RAW_IMAGE_SUPPORT=y.

Shouldn't raw (non-fitImage) images be discouraged , as there is no 
protection from bitrot in those ?

> +CONFIG_SPL_FIT=y and CONFIG_SPL_LOAD_FIT=y are needed to load FIT images.
> +
> +CONFIG_SPL_LEGACY_IMAGE_FORMAT=y is needed to load legacy U-Boot images.
> +CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y enables checking the CRC32 of legacy U-Boot
> +images.
> +
> +Image load methods
> +------------------
> +
> +The image boot methods available for a board must be defined in two places:
> +
> +The board code implements a function board_boot_order() enumerating up to
> +six boot methods

Why six ?

I have an idea why, but this should be documented.

> and the sequence in which they are tried. If there is only one
> +boot method function, spl_boot_device() may be implemented instead.
> +
> +The configuration controls which of these boot methods are actually available.
> +
> +BOOTROM
> +    The binary is loaded by the boot ROM.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_BOOTROM_SUPPORT=y or CONFIG_TPL_BOOTROM_SUPPORT=y
> +
> +DFU
> +    :doc:`Device Firmware Upgrade <dfu>` is used to load the binary into RAM.
> +    Required configuration settings include:
> +
> +    * CONFIG_DFU=y
> +
> +    * CONFIG_SPL_RAM_SUPPORT=y or CONFIG TPL_RAM_SUPPORT=y
> +
> +Ethernet (CPGMAC)

Wat's CPGMAC ?

> +    This method loads an image over Ethernet. The BOOTP protocol is used to find
> +    a TFTP server and binary name. The binary is downloaded via the TFTP
> +    protocol. Required configuration settings include:
> +
> +    * CONFIG_SPL_NET=y or CONFIG_TPL_NET=y
> +
> +    * CONFIG_SPL_ETH_DEVICE
> +
> +FEL
> +    This method does not actually load an image for U-Boot.
> +    FEL is a routine contained in the boot ROM of Allwinner SoCs which serves
> +    for the initial programming or recovery via USB
> +
> +MMC1, MMC2, MMC2_2
> +    These methods read an image from SD card or eMMC. The first digit after
> +    'MMC' indicates the device number. Required configuration settings include:
> +
> +    * CONFIG_SPL_MMC=y or CONFIG_TPL_MMC=y
> +
> +    To use a PCI connected MMC controller you need to additionally specify:
> +
> +    * CONFIG_SPL_PCI=y
> +
> +    * CONFIG_SPL_PCI_PNP=y
> +
> +    * CONFIG_MMC=y

Why CONFIG_MMC for PCI connected SDMMC controller in SPL ?

> +    * CONFIG_MMC_PCI=y
> +
> +    * CONFIG_MMC_SDHCI=y
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=y or CONFIG_SPL_FS_EXT=y
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
> +
> +NAND
> +    This method loads the image from NAND flash. To read from raw NAND the
> +    following configuraton settings are required:

configuration (typo, missing i)

> +    * CONFIG_SPL_NAND_SUPPORT=y or CONFIG_TPL_NAND_SUPPORT=y
> +
> +    If CONFIG_SPL_NAND_RAW_ONLY=y only raw images can be loaded.
> +
> +    For using the Ubi file system

UBI, abbreviation of Unsorted Block Images (iirc)

You also need to discern UBI (as in the FTL) and UBIFS (as in the 
filesystem on top of UBI)


> to read from NAND the following configuration
> +    settings are required:
> +
> +    * CONFIG_SPL_UBI=y of CONFIG_TPL_UBI=y
> +
> +NOR
> +    This method loads the image from NOR flash.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_NOR_SUPPORT=y or CONFIG_TPL_NOR_SUPPORT=y
> +
> +NVMe
> +    This methods load the image from an NVMe drive.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_PCI=y
> +
> +    * CONFIG_SPL_PCI_PNP=y
> +
> +    * CONFIG_SPL_NVME=y
> +
> +    * CONFIG_SPL_NVME_PCI=y
> +
> +    * CONFIG_SPL_NVME_BOOT_DEVICE (number of the NVMe device)
> +
> +    * CONFIG_SYS_NVME_BOOT_PARTITION (partition to read from)
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=y or CONFIG_SPL_FS_EXT=y
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
> +
> +OneNAND
> +    This methods loads the image from a OneNAND device. To read from raw OneNAND
> +    the following configuraton settings are required:

configuration, typo

> +    * CONFIG_SPL_ONENAND_SUPPORT=y or CONFIG_TPL_ONENAND_SUPPORT=y
> +
> +    For using the Ubi file system to read from NAND the following configuration
> +    settings are required:
> +
> +    * CONFIG_SPL_UBI=y of CONFIG_TPL_UBI=y

Maybe you should group the boot media in some logical manner, like, 
flash based (NOR, NAND, OneNAND) and block based (SDMMC, SCSI, NVMe...).

> +RAM
> +    This method uses an image preloaded into RAM.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_RAM_SUPPORT=y or CONFIG_TPL_RAM_SUPPORT=y
> +
> +    * CONFIG_RAM_DEVICE=y
> +
> +sandbox_file
> +    On the sandbox this method loads an image from the host file system.
> +
> +sandbox_image
> +    On the sandbox this method loads an image from the host file system.
> +
> +SATA
> +    This method reads an image from a SATA drive.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_SATA=y or CONFIG_TPL_SATA=y
> +
> +    To use a PCIe connecte SATA controller you additionally need:
> +
> +    * CONFIG_SPL_PCI=y
> +
> +    * CONFIG_SPL_SATA=y
> +
> +    * CONFIG_SPL_AHCI_PCI=y
> +
> +    * CONFIG_SPL_PCI_PNP=y
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=y
> +
> +    * CONFIG_SYS_SATA_FAT_BOOT_PARTITION=<partition number>
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
> +
> +SEMIHOSTING
> +    When running in an ARM or RISC-V virtual machine the semihosting method can
> +    be used to load an image from the host file system.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_SEMIHOSTING=y
> +
> +    * CONFIG_SPL_SEMIHOSTING_FALLBACK=y
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=<path to file>
> +
> +SPI
> +    This method loads an image form SPI NOR flash.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_DM_SPI=y
> +
> +    * CONFIG_SPL_SPI_FLASH=y
> +
> +    * CONFIG_SPI_LOAD=y or CONFIG_TPL_SPI_LOAD=y
> +
> +
> +sunxi SPI
> +    This method which is specific to Allwinner SoCs loads an image form SPI NOR
> +    flash. Required configuration settings include:
> +
> +    * CONFIG_SPL_SPI_SUNXI=y
> +
> +UART
> +    This method loads an image via the Y-Modem protocol from the UART.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_YMODEM_SUPPORT=y or CONFIG_TPL_YMODEM_SUPPORT=y
> +
> +USB
> +    The USB method loads an image from a USB block device.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_USB_HOST=y
> +
> +    * CONFIG_SPL_USB_STORAGE=y
> +
> +    To use a PCI connected USB 3.0 controller you additionally need:
> +
> +    * CONFIG_SPL_FS_FAT=y
> +
> +    * CONFIG_SPL_PCI=y
> +
> +    * CONFIG_SPL_PCI_PNP=y
> +
> +    * CONFIG_USB=y
> +
> +    * CONFIG_USB_XHCI_HCD=y
> +
> +    * CONFIG_USB_XHCI_PCI=y
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=y or CONFIG_SPL_FS_EXT=y
> +
> +    * CONFIG_SYS_USB_FAT_BOOT_PARTITION=<partition number>
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
> +
> +USB eth
> +    This method loads an image over Ethernet. The BOOTP protocol is used to find
> +    a TFTP server and binary name. The binary is downloaded via the TFTP
> +    protocol. Required configuration settings include:
> +
> +    * CONFIG_SPL_NET=y or CONFIG_TPL_NET=y
> +
> +    * CONFIG_DM_USB_GADGET=y.
> +
> +USB SDP
> +    This method loads the image using the Serial Download Protocol as
> +    implemented by the boot ROM of the i.MX family of SoCs.
> +
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_SERIAL=y
> +
> +    * CONFIG_SPL_USB_SDP_SUPPORT=y or CONFIG_TPL_USB_SDP_SUPPORT
> +
> +vbe_simple
> +    This method is used by the VPL stage to extract the next stage image from
> +    the loaded image.
> +
> +    Required configuration settings include:
> +
> +    * CONFIG_VPL=y
> +
> +    * CONFIG_SPL_BOOTMETH_VBE_SIMPLE_FW=y or CONFIG_TPL_BOOTMETH_VBE_SIMPLE_FW=y
> +
> +XIP
> +    This method executes an image in place.
> +
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_XIP_SUPPORT
[...]
