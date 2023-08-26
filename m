Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B51C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 10:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A538386B2C;
	Sat, 26 Aug 2023 12:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF3286B31; Sat, 26 Aug 2023 12:42:21 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 49A1B86ACC
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 12:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.02,203,1688396400"; 
 d="asc'?scan'208";a="177740529"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 26 Aug 2023 19:42:13 +0900
Received: from [10.226.92.28] (unknown [10.226.92.28])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id F31C8400264B;
 Sat, 26 Aug 2023 19:42:09 +0900 (JST)
Message-ID: <636aa801-4f32-c2f3-db6f-cd6072a128ae@bp.renesas.com>
Date: Sat, 26 Aug 2023 11:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20230826091335.26459-1-heinrich.schuchardt@canonical.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PATCH v3 1/1] doc: describe TPL/VPL/SPL boot
In-Reply-To: <20230826091335.26459-1-heinrich.schuchardt@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lP8S0t2bnpenm7SYhQcDxLyo"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lP8S0t2bnpenm7SYhQcDxLyo
Content-Type: multipart/mixed; boundary="------------VgNJGZ2Idup8fryS17aviExD";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Message-ID: <636aa801-4f32-c2f3-db6f-cd6072a128ae@bp.renesas.com>
Subject: Re: [PATCH v3 1/1] doc: describe TPL/VPL/SPL boot
References: <20230826091335.26459-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230826091335.26459-1-heinrich.schuchardt@canonical.com>

--------------VgNJGZ2Idup8fryS17aviExD
Content-Type: multipart/mixed; boundary="------------EdACpg5XB0YZX0Ydz85tRYzv"

--------------EdACpg5XB0YZX0Ydz85tRYzv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26/08/2023 10:13, Heinrich Schuchardt wrote:
> This is a stub describing how TPL, VPL, and SPL load the next boot stag=
es
> on a detail level for users.
>=20
> For sure we will need a few patches on top to catch the whole complexit=
y.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	Call TPL Tertiary Program Loader, VPL Verifying Program Loader
> 	Put Power PC flow into an info box to stick out
> 	Add link to Falcon Mode
> 	Fix typos
> v2:
> 	Mention that PowerPC uses a different naming convention.
> 	Group boot devices by type
> 	Correct reference to UBI
> 	Fix typos
> ---
>  doc/usage/index.rst    |   1 +
>  doc/usage/spl_boot.rst | 323 +++++++++++++++++++++++++++++++++++++++++=

>  2 files changed, 324 insertions(+)
>  create mode 100644 doc/usage/spl_boot.rst
>=20
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 3326ec82ff..f45a7f5502 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -4,6 +4,7 @@ Use U-Boot
>  .. toctree::
>     :maxdepth: 1
> =20
> +   spl_boot
>     blkmap
>     dfu
>     environment
> diff --git a/doc/usage/spl_boot.rst b/doc/usage/spl_boot.rst
> new file mode 100644
> index 0000000000..ad6bf0ab69
> --- /dev/null
> +++ b/doc/usage/spl_boot.rst
> @@ -0,0 +1,323 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Booting from TPL/SPL
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The main U-Boot binary may be too large to be loaded directly by the B=
oot ROM.
> +This was the original driver for splitting up U-Boot into multiple boo=
t stages.
> +
> +U-Boot typically goes through the following boot phases where TPL, VPL=
, and SPL
> +are optional. While many boards use SPL only few use TPL.
> +
> +TPL
> +   Tertiary Program Loader. Very early init, as tiny as possible. This=
 loads SPL
> +   (or VPL if enabled).
> +
> +VPL
> +   Verifying Program Loader. Optional verification step, which can sel=
ect one of
> +   several SPL binaries, if A/B verified boot is enabled. Implementati=
on of the
> +   VPL logic is work-in-progress. For now it just boots into SPL.
> +
> +SPL
> +   Secondary Program Loader. Sets up SDRAM and loads U-Boot proper. It=
 may also
> +   load other firmware components.

I'd fold the bullet points below (BL31, EDK II, Falcon mode & OpenSBI
loading) into this description to improve the flow of the document.

> +
> +U-Boot
> +   U-Boot proper, containing the command line and the logic to load an=

> +   operating system, e.g. via UEFI.

Change after the first comma to "this is the only stage containing the
command line...", then the extra line below the following note saying
this can be dropped.

> +
> +.. note::
> +
> +   The naming convention on the PowerPC architecture deviates from the=
 other
> +   archtitectures. Here the boot sequence is SPL->TPL->U-Boot.
> +
> +Only main U-Boot has a command line interface.
> +
> +Further usages for U-Boot SPL comprise:
> +
> +* launching BL31 of ARM Trusted Firmware which invokes U-Boot as BL33
> +* launching EDK II
> +* launching Linux, e.g. :doc:`Falcon Mode' <../develop/falcon>`
> +* launching RISC-V OpenSBI which invokes main U-Boot> +
> +Target binaries
> +---------------
> +
> +Binaries loaded by SPL/TPL can be:
> +
> +* raw binaries where the entry address equals the start address. This =
is the
> +  only binary format supported by TPL.
> +* :doc:`FIT <fit/index>` images
> +* legacy U-Boot images
> +
> +Configuration
> +~~~~~~~~~~~~~
> +
> +Raw images are only supported in SPL if CONFIG_SPL_RAW_IMAGE_SUPPORT=3D=
y.
> +
> +CONFIG_SPL_FIT=3Dy and CONFIG_SPL_LOAD_FIT=3Dy are needed to load FIT =
images.
> +
> +CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy is needed to load legacy U-Boot ima=
ges.
> +CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=3Dy enables checking the CRC32 of le=
gacy U-Boot
> +images.
> +
> +Image load methods
> +------------------
> +
> +The image boot methods available for a board must be defined in two pl=
aces:
> +
> +The board code implements a function board_boot_order() enumerating up=
 to
> +five boot methods and the sequence in which they are tried. (The maxim=
um
> +number of boot methods is currently hard coded as variable spl_boot_li=
st[]).
> +If there is only one boot method function, spl_boot_device() may be im=
plemented
> +instead.
> +
> +The configuration controls which of these boot methods are actually av=
ailable.
> +
> +Loading from block devices
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +MMC1, MMC2, MMC2_2
> +    These methods read an image from SD card or eMMC. The first digit =
after
> +    'MMC' indicates the device number. Required configuration settings=
 include:
> +
> +    * CONFIG_SPL_MMC=3Dy or CONFIG_TPL_MMC=3Dy
> +
> +    To use a PCI connected MMC controller you need to additionally spe=
cify:
> +
> +    * CONFIG_SPL_PCI=3Dy
> +
> +    * CONFIG_SPL_PCI_PNP=3Dy
> +
> +    * CONFIG_MMC=3Dy
> +
> +    * CONFIG_MMC_PCI=3Dy
> +
> +    * CONFIG_MMC_SDHCI=3Dy
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=3Dy or CONFIG_SPL_FS_EXT=3Dy
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
> +
> +NVMe
> +    This methods load the image from an NVMe drive.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_PCI=3Dy
> +
> +    * CONFIG_SPL_PCI_PNP=3Dy
> +
> +    * CONFIG_SPL_NVME=3Dy
> +
> +    * CONFIG_SPL_NVME_PCI=3Dy
> +
> +    * CONFIG_SPL_NVME_BOOT_DEVICE (number of the NVMe device)
> +
> +    * CONFIG_SYS_NVME_BOOT_PARTITION (partition to read from)
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=3Dy or CONFIG_SPL_FS_EXT=3Dy
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
> +
> +SATA
> +    This method reads an image from a SATA drive.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_SATA=3Dy or CONFIG_TPL_SATA=3Dy
> +
> +    To use a PCIe connecte SATA controller you additionally need:
> +
> +    * CONFIG_SPL_PCI=3Dy
> +
> +    * CONFIG_SPL_SATA=3Dy
> +
> +    * CONFIG_SPL_AHCI_PCI=3Dy
> +
> +    * CONFIG_SPL_PCI_PNP=3Dy
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=3Dy
> +
> +    * CONFIG_SYS_SATA_FAT_BOOT_PARTITION=3D<partition number>
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
> +
> +USB
> +    The USB method loads an image from a USB block device.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_USB_HOST=3Dy
> +
> +    * CONFIG_SPL_USB_STORAGE=3Dy
> +
> +    To use a PCI connected USB 3.0 controller you additionally need:
> +
> +    * CONFIG_SPL_FS_FAT=3Dy
> +
> +    * CONFIG_SPL_PCI=3Dy
> +
> +    * CONFIG_SPL_PCI_PNP=3Dy
> +
> +    * CONFIG_USB=3Dy
> +
> +    * CONFIG_USB_XHCI_HCD=3Dy
> +
> +    * CONFIG_USB_XHCI_PCI=3Dy
> +
> +    To load from a file system use:
> +
> +    * CONFIG_SPL_FS_FAT=3Dy or CONFIG_SPL_FS_EXT=3Dy
> +
> +    * CONFIG_SYS_USB_FAT_BOOT_PARTITION=3D<partition number>
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"<filepath>"
> +
> +Loading from flash devices
> +~~~~~~~~~~~~~~~~~~~~~~~~~~

I'd say "raw flash devices" to make the distinction from flash block
devices (e.g. SSD/NVMe) clear.

> +
> +NAND
> +    This method loads the image from NAND flash. To read from raw NAND=
 the
> +    following configuration settings are required:
> +
> +    * CONFIG_SPL_NAND_SUPPORT=3Dy or CONFIG_TPL_NAND_SUPPORT=3Dy
> +
> +    If CONFIG_SPL_NAND_RAW_ONLY=3Dy only raw images can be loaded.
> +
> +    For using UBI (Unsorted Block Images) volumes to read from NAND th=
e
> +    following configuration settings are required:
> +
> +    * CONFIG_SPL_UBI=3Dy or CONFIG_TPL_UBI=3Dy
> +
> +    The UBI volume to read can either be specified
> +
> +    * by name using CONFIG_SPL_UBI_LOAD_BY_VOLNAME or
> +
> +    * by number using CONFIG_SPL_UBI_LOAD_MONITOR_ID.
> +
> +NOR
> +    This method loads the image from NOR flash.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_NOR_SUPPORT=3Dy or CONFIG_TPL_NOR_SUPPORT=3Dy
> +
> +OneNAND
> +    This methods loads the image from a OneNAND device. To read from r=
aw OneNAND
> +    the following configuration settings are required:
> +
> +    * CONFIG_SPL_ONENAND_SUPPORT=3Dy or CONFIG_TPL_ONENAND_SUPPORT=3Dy=

> +
> +    For using the Ubi file system to read from NAND the following conf=
iguration
> +    settings are required:
> +
> +    * CONFIG_SPL_UBI=3Dy or CONFIG_TPL_UBI=3Dy
> +
> +SPI
> +    This method loads an image form SPI NOR flash.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_DM_SPI=3Dy
> +
> +    * CONFIG_SPL_SPI_FLASH=3Dy
> +
> +    * CONFIG_SPI_LOAD=3Dy or CONFIG_TPL_SPI_LOAD=3Dy
> +
> +
> +Sunxi SPI
> +    This method which is specific to Allwinner SoCs loads an image for=
m SPI NOR
> +    flash. Required configuration settings include:
> +
> +    * CONFIG_SPL_SPI_SUNXI=3Dy
> +
> +Loading from other devices
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +BOOTROM
> +    The binary is loaded by the boot ROM.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_BOOTROM_SUPPORT=3Dy or CONFIG_TPL_BOOTROM_SUPPORT=3Dy=

> +
> +DFU
> +    :doc:`Device Firmware Upgrade <dfu>` is used to load the binary in=
to RAM.
> +    Required configuration settings include:
> +
> +    * CONFIG_DFU=3Dy
> +
> +    * CONFIG_SPL_RAM_SUPPORT=3Dy or CONFIG TPL_RAM_SUPPORT=3Dy
> +
> +Ethernet
> +    This method loads an image over Ethernet. The BOOTP protocol is us=
ed to find
> +    a TFTP server and binary name. The binary is downloaded via the TF=
TP
> +    protocol. Required configuration settings include:
> +
> +    * CONFIG_SPL_NET=3Dy or CONFIG_TPL_NET=3Dy
> +
> +    * CONFIG_SPL_ETH_DEVICE=3Dy or CONFIG_DM_USB_GADGET=3Dy
> +
> +FEL
> +    This method does not actually load an image for U-Boot.
> +    FEL is a routine contained in the boot ROM of Allwinner SoCs which=
 serves
> +    for the initial programming or recovery via USB
> +
> +RAM
> +    This method uses an image preloaded into RAM.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_RAM_SUPPORT=3Dy or CONFIG_TPL_RAM_SUPPORT=3Dy
> +
> +    * CONFIG_RAM_DEVICE=3Dy
> +
> +Sandbox file
> +    On the sandbox this method loads an image from the host file syste=
m.
> +
> +Sandbox image
> +    On the sandbox this method loads an image from the host file syste=
m.
> +
> +Semihosting
> +    When running in an ARM or RISC-V virtual machine the semihosting m=
ethod can
> +    be used to load an image from the host file system.
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_SEMIHOSTING=3Dy
> +
> +    * CONFIG_SPL_SEMIHOSTING_FALLBACK=3Dy
> +
> +    * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D<path to file>
> +
> +UART
> +    This method loads an image via the Y-Modem protocol from the UART.=

> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_YMODEM_SUPPORT=3Dy or CONFIG_TPL_YMODEM_SUPPORT=3Dy
> +
> +USB SDP
> +    This method loads the image using the Serial Download Protocol as
> +    implemented by the boot ROM of the i.MX family of SoCs.
> +
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_SERIAL=3Dy
> +
> +    * CONFIG_SPL_USB_SDP_SUPPORT=3Dy or CONFIG_TPL_USB_SDP_SUPPORT
> +
> +VBE Simple
> +    This method is used by the VPL stage to extract the next stage ima=
ge from
> +    the loaded image.
> +
> +    Required configuration settings include:
> +
> +    * CONFIG_VPL=3Dy
> +
> +    * CONFIG_SPL_BOOTMETH_VBE_SIMPLE_FW=3Dy or CONFIG_TPL_BOOTMETH_VBE=
_SIMPLE_FW=3Dy
> +
> +XIP
> +    This method executes an image in place.
> +
> +    Required configuration settings include:
> +
> +    * CONFIG_SPL_XIP_SUPPORT

My comments above are minor style suggestions so whether or not they're
changed:

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Thanks,
Paul
--------------EdACpg5XB0YZX0Ydz85tRYzv
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------EdACpg5XB0YZX0Ydz85tRYzv--

--------------VgNJGZ2Idup8fryS17aviExD--

--------------lP8S0t2bnpenm7SYhQcDxLyo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZOnXAAUDAAAAAAAKCRDbaV4Vf/JGvdWy
AP9eefQ6pmzMCsUIak+pTfzIZS9DeXb1efP2iQt/WHeKKgD+IQdrznNWQjqWdRkUsGy+divGONhD
sAXtz2mMhRkZugM=
=2fbj
-----END PGP SIGNATURE-----

--------------lP8S0t2bnpenm7SYhQcDxLyo--
