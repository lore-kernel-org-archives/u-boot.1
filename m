Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16014C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 13:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBC98071F;
	Sat, 26 Aug 2023 15:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TNutf4NP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783F18611C; Sat, 26 Aug 2023 15:28:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB50805C8
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 15:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693056472; x=1693661272; i=xypron.glpk@gmx.de;
 bh=DUsxdT/l6txKXquLI9Og2qKWYxzch9IZKV1LH5OoHjw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TNutf4NPGPyBgwW6GRpLDLe4LtD8hrEGMvJLVYOX4eCAd1ibQDBXbAic/L01cwV8f77ao4S
 +r1Dtqoi5e5u6idVq1i73DcitAF+Rdb8KU5WXFpLLgTCxvOORCou11CyFzC7reGReiIKW7Aaa
 V8g/QcGSt376yns32bSO9aggGiETEetcKsNLixc9V4sf7Y7fOIypftsKUunG3egnUw2E2ZSZo
 fPVSv9mg8Br3TLpHVMlUcQwKrDFhPrJI0HY5fguPDA/ikpzMxtdYWxGK/xg/iNe5qdTuYHEI0
 xNKFVbIbzKUdB+4MWlhiLbbrVzBwSQpTRPgmGtgLHrfcfo1HAKNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1poMkG1jXg-00wShv; Sat, 26
 Aug 2023 15:27:52 +0200
Message-ID: <d3969273-7365-481a-a6cb-834a8526937d@gmx.de>
Date: Sat, 26 Aug 2023 15:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] doc: describe TPL/VPL/SPL boot
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20230826091335.26459-1-heinrich.schuchardt@canonical.com>
 <636aa801-4f32-c2f3-db6f-cd6072a128ae@bp.renesas.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <636aa801-4f32-c2f3-db6f-cd6072a128ae@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ss7G3FOqTFH1eP/b2uDwXPab4+gnvtq1+k7Eg3uWvgvT6aJBcsO
 TzTTMXw5eTj4QtV/JuCp/cuztTe/a5BTH9bZ84AbJv6xGZf+jDlotYA8B38LHhLOCI68Xx6
 5P1Fy+pME2qUpbVRSYyDcEKTDHXWXow75iBq5nh7+nzmNiW8YaK8KVRrPcum/tqMB65h8W+
 6LVdEToVJFLGFAp5xhEyQ==
UI-OutboundReport: notjunk:1;M01:P0:gfwOn1GEaS0=;md6kAu6FSarO9Q2X8lSXwXWCc7N
 HjcD+ia5QtrWurIOoUEEElrko/S3I7rLH3kXfWftwNWCfivSGI1eTAkVZrG1dTxf/6qC+r/bM
 IW795jx9bOy3wcomWU5zZHcXMkO1SPCDFCa9sJlElzccUO6Nh7bJhhAtmiGo/R0m/fJMtk6kl
 LIC+RjjQk8ZYnd6kQ8BH6Y6clFSje3lWxQhH34EHMX+LXI69FBK7wlwY/OEG3V+UMtpaCLMoW
 ++ean8qRqtCSXUiJaovRQCA3TG7OBaYvvyTFaAoBtfuHFdkaczHELLJD6hKGuFpteVUofZQxX
 r8ZxYkWjs7Kl7n4oJ8UPDCJromq74QcH5KR81U1IBPPs8PHYcBs8sVQaXREvcgD0sHNxXAM7o
 kTQgTkzi0VXmTb6qQrCtdePHyRNPZ8BdQhcfDtjnoj2l1s8P1fiSIVm6d0aA1l2DAEhF/CTJG
 QjWVhzE4x3lMM1iM7s35bBESXD+ZHPcAjT4G02GXWYL9WpNXIoUGK7krZbvD/3/fM2cz10mWT
 CneYqDyMZWWILMf2VjvPqIJNfP9ZMOExYFQZfEZhdrYVCajDezzkQ/QGWuKysy7gBaRgW1vr9
 7KsS+4Lore+cDn0Yjdpzmkfdw7Ou7w3WjAo+NpNk/6VXu4SZtFZqvu3qrGPysf2O59ZQb/euU
 oebdmbGiFSUzJg+eJFRizaVlqm1kQiRtDUzVNXyKRS4K2HuYc3T5rwlNUyIVF+UCqVEImM0Yy
 MkypS/FMEbN22/ua6UMic6qQHJ6m+XcPAgdTrnj5a02T2rXUga5WAf4+4Xpm8w+TbC+VnXqT5
 0t0PPXMGHvYiYKH3A4UclRfUCGxVzP+EpzsJo2CW1OqPqNjWzp/Bfe/HMQRdBY/DuC7k6VSx2
 4BNsHgqiLY369fgy4U3hWV8gBqWT2+SEd/4GCX5Xr6EKHA9KJyupleg8tVpTd0xIH0t38z6wt
 I0prY47uVoBZd9SUkPx5VJBsVtw=
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

On 8/26/23 12:42, Paul Barker wrote:
> On 26/08/2023 10:13, Heinrich Schuchardt wrote:
>> This is a stub describing how TPL, VPL, and SPL load the next boot stag=
es
>> on a detail level for users.
>>
>> For sure we will need a few patches on top to catch the whole complexit=
y.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v3:
>> 	Call TPL Tertiary Program Loader, VPL Verifying Program Loader
>> 	Put Power PC flow into an info box to stick out
>> 	Add link to Falcon Mode
>> 	Fix typos
>> v2:
>> 	Mention that PowerPC uses a different naming convention.
>> 	Group boot devices by type
>> 	Correct reference to UBI
>> 	Fix typos
>> ---
>>   doc/usage/index.rst    |   1 +
>>   doc/usage/spl_boot.rst | 323 ++++++++++++++++++++++++++++++++++++++++=
+
>>   2 files changed, 324 insertions(+)
>>   create mode 100644 doc/usage/spl_boot.rst
>>
>> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
>> index 3326ec82ff..f45a7f5502 100644
>> --- a/doc/usage/index.rst
>> +++ b/doc/usage/index.rst
>> @@ -4,6 +4,7 @@ Use U-Boot
>>   .. toctree::
>>      :maxdepth: 1
>>
>> +   spl_boot
>>      blkmap
>>      dfu
>>      environment
>> diff --git a/doc/usage/spl_boot.rst b/doc/usage/spl_boot.rst
>> new file mode 100644
>> index 0000000000..ad6bf0ab69
>> --- /dev/null
>> +++ b/doc/usage/spl_boot.rst
>> @@ -0,0 +1,323 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +Booting from TPL/SPL
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The main U-Boot binary may be too large to be loaded directly by the B=
oot ROM.
>> +This was the original driver for splitting up U-Boot into multiple boo=
t stages.
>> +
>> +U-Boot typically goes through the following boot phases where TPL, VPL=
, and SPL
>> +are optional. While many boards use SPL only few use TPL.
>> +
>> +TPL
>> +   Tertiary Program Loader. Very early init, as tiny as possible. This=
 loads SPL
>> +   (or VPL if enabled).
>> +
>> +VPL
>> +   Verifying Program Loader. Optional verification step, which can sel=
ect one of
>> +   several SPL binaries, if A/B verified boot is enabled. Implementati=
on of the
>> +   VPL logic is work-in-progress. For now it just boots into SPL.
>> +
>> +SPL
>> +   Secondary Program Loader. Sets up SDRAM and loads U-Boot proper. It=
 may also
>> +   load other firmware components.
>
> I'd fold the bullet points below (BL31, EDK II, Falcon mode & OpenSBI
> loading) into this description to improve the flow of the document.

Thank you for reviewing.

I think when expanding this documenting with future patches we should
have a subsection for each of these boot flows with a diagram and
description. The list above I would prefer to restrict to the U-Boot
components.

>
>> +
>> +U-Boot
>> +   U-Boot proper, containing the command line and the logic to load an
>> +   operating system, e.g. via UEFI.
>
> Change after the first comma to "this is the only stage containing the
> command line...", then the extra line below the following note saying
> this can be dropped.

ok

>
>> +
>> +.. note::
>> +
>> +   The naming convention on the PowerPC architecture deviates from the=
 other
>> +   archtitectures. Here the boot sequence is SPL->TPL->U-Boot.
>> +
>> +Only main U-Boot has a command line interface.
>> +
>> +Further usages for U-Boot SPL comprise:
>> +
>> +* launching BL31 of ARM Trusted Firmware which invokes U-Boot as BL33
>> +* launching EDK II
>> +* launching Linux, e.g. :doc:`Falcon Mode' <../develop/falcon>`
>> +* launching RISC-V OpenSBI which invokes main U-Boot> +
>> +Target binaries
>> +---------------
>> +
>> +Binaries loaded by SPL/TPL can be:
>> +
>> +* raw binaries where the entry address equals the start address. This =
is the
>> +  only binary format supported by TPL.
>> +* :doc:`FIT <fit/index>` images
>> +* legacy U-Boot images
>> +
>> +Configuration
>> +~~~~~~~~~~~~~
>> +
>> +Raw images are only supported in SPL if CONFIG_SPL_RAW_IMAGE_SUPPORT=
=3Dy.
>> +
>> +CONFIG_SPL_FIT=3Dy and CONFIG_SPL_LOAD_FIT=3Dy are needed to load FIT =
images.
>> +
>> +CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy is needed to load legacy U-Boot ima=
ges.
>> +CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=3Dy enables checking the CRC32 of le=
gacy U-Boot
>> +images.
>> +
>> +Image load methods
>> +------------------
>> +
>> +The image boot methods available for a board must be defined in two pl=
aces:
>> +
>> +The board code implements a function board_boot_order() enumerating up=
 to
>> +five boot methods and the sequence in which they are tried. (The maxim=
um
>> +number of boot methods is currently hard coded as variable spl_boot_li=
st[]).
>> +If there is only one boot method function, spl_boot_device() may be im=
plemented
>> +instead.
>> +
>> +The configuration controls which of these boot methods are actually av=
ailable.
>> +
>> +Loading from block devices
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +MMC1, MMC2, MMC2_2
>> +    These methods read an image from SD card or eMMC. The first digit =
after
>> +    'MMC' indicates the device number. Required configuration settings=
 include:
>> +
>> +    * CONFIG_SPL_MMC=3Dy or CONFIG_TPL_MMC=3Dy
>> +
>> +    To use a PCI connected MMC controller you need to additionally spe=
cify:
>> +
>> +    * CONFIG_SPL_PCI=3Dy
>> +
>> +    * CONFIG_SPL_PCI_PNP=3Dy
>> +
>> +    * CONFIG_MMC=3Dy
>> +
>> +    * CONFIG_MMC_PCI=3Dy
>> +
>> +    * CONFIG_MMC_SDHCI=3Dy
>> +
>> +    To load from a file system use:
>> +
>> +    * CONFIG_SPL_FS_FAT=3Dy or CONFIG_SPL_FS_EXT=3Dy
>> +
>> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
>> +
>> +NVMe
>> +    This methods load the image from an NVMe drive.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_PCI=3Dy
>> +
>> +    * CONFIG_SPL_PCI_PNP=3Dy
>> +
>> +    * CONFIG_SPL_NVME=3Dy
>> +
>> +    * CONFIG_SPL_NVME_PCI=3Dy
>> +
>> +    * CONFIG_SPL_NVME_BOOT_DEVICE (number of the NVMe device)
>> +
>> +    * CONFIG_SYS_NVME_BOOT_PARTITION (partition to read from)
>> +
>> +    To load from a file system use:
>> +
>> +    * CONFIG_SPL_FS_FAT=3Dy or CONFIG_SPL_FS_EXT=3Dy
>> +
>> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
>> +
>> +SATA
>> +    This method reads an image from a SATA drive.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_SATA=3Dy or CONFIG_TPL_SATA=3Dy
>> +
>> +    To use a PCIe connecte SATA controller you additionally need:
>> +
>> +    * CONFIG_SPL_PCI=3Dy
>> +
>> +    * CONFIG_SPL_SATA=3Dy
>> +
>> +    * CONFIG_SPL_AHCI_PCI=3Dy
>> +
>> +    * CONFIG_SPL_PCI_PNP=3Dy
>> +
>> +    To load from a file system use:
>> +
>> +    * CONFIG_SPL_FS_FAT=3Dy
>> +
>> +    * CONFIG_SYS_SATA_FAT_BOOT_PARTITION=3D<partition number>
>> +
>> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
>> +
>> +USB
>> +    The USB method loads an image from a USB block device.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_USB_HOST=3Dy
>> +
>> +    * CONFIG_SPL_USB_STORAGE=3Dy
>> +
>> +    To use a PCI connected USB 3.0 controller you additionally need:
>> +
>> +    * CONFIG_SPL_FS_FAT=3Dy
>> +
>> +    * CONFIG_SPL_PCI=3Dy
>> +
>> +    * CONFIG_SPL_PCI_PNP=3Dy
>> +
>> +    * CONFIG_USB=3Dy
>> +
>> +    * CONFIG_USB_XHCI_HCD=3Dy
>> +
>> +    * CONFIG_USB_XHCI_PCI=3Dy
>> +
>> +    To load from a file system use:
>> +
>> +    * CONFIG_SPL_FS_FAT=3Dy or CONFIG_SPL_FS_EXT=3Dy
>> +
>> +    * CONFIG_SYS_USB_FAT_BOOT_PARTITION=3D<partition number>
>> +
>> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
>> +
>> +Loading from flash devices
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I'd say "raw flash devices" to make the distinction from flash block
> devices (e.g. SSD/NVMe) clear.

ok

Best regards

Heinrich

>
>> +
>> +NAND
>> +    This method loads the image from NAND flash. To read from raw NAND=
 the
>> +    following configuration settings are required:
>> +
>> +    * CONFIG_SPL_NAND_SUPPORT=3Dy or CONFIG_TPL_NAND_SUPPORT=3Dy
>> +
>> +    If CONFIG_SPL_NAND_RAW_ONLY=3Dy only raw images can be loaded.
>> +
>> +    For using UBI (Unsorted Block Images) volumes to read from NAND th=
e
>> +    following configuration settings are required:
>> +
>> +    * CONFIG_SPL_UBI=3Dy or CONFIG_TPL_UBI=3Dy
>> +
>> +    The UBI volume to read can either be specified
>> +
>> +    * by name using CONFIG_SPL_UBI_LOAD_BY_VOLNAME or
>> +
>> +    * by number using CONFIG_SPL_UBI_LOAD_MONITOR_ID.
>> +
>> +NOR
>> +    This method loads the image from NOR flash.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_NOR_SUPPORT=3Dy or CONFIG_TPL_NOR_SUPPORT=3Dy
>> +
>> +OneNAND
>> +    This methods loads the image from a OneNAND device. To read from r=
aw OneNAND
>> +    the following configuration settings are required:
>> +
>> +    * CONFIG_SPL_ONENAND_SUPPORT=3Dy or CONFIG_TPL_ONENAND_SUPPORT=3Dy
>> +
>> +    For using the Ubi file system to read from NAND the following conf=
iguration
>> +    settings are required:
>> +
>> +    * CONFIG_SPL_UBI=3Dy or CONFIG_TPL_UBI=3Dy
>> +
>> +SPI
>> +    This method loads an image form SPI NOR flash.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_DM_SPI=3Dy
>> +
>> +    * CONFIG_SPL_SPI_FLASH=3Dy
>> +
>> +    * CONFIG_SPI_LOAD=3Dy or CONFIG_TPL_SPI_LOAD=3Dy
>> +
>> +
>> +Sunxi SPI
>> +    This method which is specific to Allwinner SoCs loads an image for=
m SPI NOR
>> +    flash. Required configuration settings include:
>> +
>> +    * CONFIG_SPL_SPI_SUNXI=3Dy
>> +
>> +Loading from other devices
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +BOOTROM
>> +    The binary is loaded by the boot ROM.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_BOOTROM_SUPPORT=3Dy or CONFIG_TPL_BOOTROM_SUPPORT=3Dy
>> +
>> +DFU
>> +    :doc:`Device Firmware Upgrade <dfu>` is used to load the binary in=
to RAM.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_DFU=3Dy
>> +
>> +    * CONFIG_SPL_RAM_SUPPORT=3Dy or CONFIG TPL_RAM_SUPPORT=3Dy
>> +
>> +Ethernet
>> +    This method loads an image over Ethernet. The BOOTP protocol is us=
ed to find
>> +    a TFTP server and binary name. The binary is downloaded via the TF=
TP
>> +    protocol. Required configuration settings include:
>> +
>> +    * CONFIG_SPL_NET=3Dy or CONFIG_TPL_NET=3Dy
>> +
>> +    * CONFIG_SPL_ETH_DEVICE=3Dy or CONFIG_DM_USB_GADGET=3Dy
>> +
>> +FEL
>> +    This method does not actually load an image for U-Boot.
>> +    FEL is a routine contained in the boot ROM of Allwinner SoCs which=
 serves
>> +    for the initial programming or recovery via USB
>> +
>> +RAM
>> +    This method uses an image preloaded into RAM.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_RAM_SUPPORT=3Dy or CONFIG_TPL_RAM_SUPPORT=3Dy
>> +
>> +    * CONFIG_RAM_DEVICE=3Dy
>> +
>> +Sandbox file
>> +    On the sandbox this method loads an image from the host file syste=
m.
>> +
>> +Sandbox image
>> +    On the sandbox this method loads an image from the host file syste=
m.
>> +
>> +Semihosting
>> +    When running in an ARM or RISC-V virtual machine the semihosting m=
ethod can
>> +    be used to load an image from the host file system.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_SEMIHOSTING=3Dy
>> +
>> +    * CONFIG_SPL_SEMIHOSTING_FALLBACK=3Dy
>> +
>> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D<path to file>
>> +
>> +UART
>> +    This method loads an image via the Y-Modem protocol from the UART.
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_YMODEM_SUPPORT=3Dy or CONFIG_TPL_YMODEM_SUPPORT=3Dy
>> +
>> +USB SDP
>> +    This method loads the image using the Serial Download Protocol as
>> +    implemented by the boot ROM of the i.MX family of SoCs.
>> +
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_SERIAL=3Dy
>> +
>> +    * CONFIG_SPL_USB_SDP_SUPPORT=3Dy or CONFIG_TPL_USB_SDP_SUPPORT
>> +
>> +VBE Simple
>> +    This method is used by the VPL stage to extract the next stage ima=
ge from
>> +    the loaded image.
>> +
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_VPL=3Dy
>> +
>> +    * CONFIG_SPL_BOOTMETH_VBE_SIMPLE_FW=3Dy or CONFIG_TPL_BOOTMETH_VBE=
_SIMPLE_FW=3Dy
>> +
>> +XIP
>> +    This method executes an image in place.
>> +
>> +    Required configuration settings include:
>> +
>> +    * CONFIG_SPL_XIP_SUPPORT
>
> My comments above are minor style suggestions so whether or not they're
> changed:
>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>
> Thanks,
> Paul

