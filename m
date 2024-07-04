Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35220C2BD09
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 01:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6FF882B6;
	Thu,  4 Jul 2024 03:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="khtU3ZjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8428888D; Thu,  4 Jul 2024 03:36:00 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80CB882B6
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 03:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4641ZpEh006487;
 Wed, 3 Jul 2024 20:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720056951;
 bh=mRETY53o+dfsbG3Y6DX7MYsGY7JCwM1tCAYXDNjFgSk=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=khtU3ZjMknnHPDbEy/Y9U/V2wwpc+2uKu7icUbNWDX485zW5GM281FWDkpcpYiVvR
 /45Wu/dsOr72Q6bCDltIAcMJBa7/A/fJNlFhjpCHGQBfHZPjDuUfVy9a7Z/SO6bQzP
 3kecvzIORQfR0qwpi2lacsij9UrLVeIJcQJ4AjWY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4641ZpoV065802
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jul 2024 20:35:51 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jul 2024 20:35:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jul 2024 20:35:51 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4641ZpUe057343;
 Wed, 3 Jul 2024 20:35:51 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Martyn Welch <martyn.welch@collabora.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
CC: Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 4/6] configs: am62x_evm_*: Enable USB and DFU support
In-Reply-To: <960ce74500b53f9bdd7e608afecc9c1bb8b790e4.camel@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-5-martyn.welch@collabora.com>
 <86h6eocmvo.fsf@udb0321960.dhcp.ti.com>
 <960ce74500b53f9bdd7e608afecc9c1bb8b790e4.camel@collabora.com>
Date: Wed, 3 Jul 2024 20:35:51 -0500
Message-ID: <86wmm2szuw.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Martyn Welch <martyn.welch@collabora.com> writes:

> On Thu, 2024-05-23 at 15:08 -0500, Jon Humphreys wrote:
>> Martyn Welch <martyn.welch@collabora.com> writes:
>>=20
>> > From: Sjoerd Simons <sjoerd@collabora.com>
>> >=20
>> > Provide config fragments to enable USB host as well as USB gadget
>> > and DFU
>> > support for a53 and r5. This relevant fragment is included into the
>> > am62x EVM a53 defconfig. For the r5, due to the smaller available
>> > size,
>> > the config fragment also disables support for persistent storage to
>> > free
>> > up space for USB support. This fragment needs to be included is DFU
>> > booting is desired.
>> >=20
>> > The CONFIG_DFU_SF option is placed in the defconfig rather than the
>> > fragment as this is known not to be supported on all boards that
>> > can
>> > support DFU.
>> >=20
>> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>> > ---
>> > Changes in v5:
>> > - Switch to config fragment for a53 most DFU configuration
>> >=20
>> > Changes in v4:
>> > - Move R5 dfu config to a config fragment rather then a full
>> > defconfig
>> > - Don't enable XHCI for the R5 SPL, unneeded
>> >=20
>> > Changes in v3:
>> > - Run savedefconfig to adjust to more recent u-boot
>> >=20
>> > Changes in v2:
>> > - Create a seperate defconfig for R5
>> >=20
>> >=20
>> >=20
>> > =C2=A0configs/am62x_a53_usbdfu.config | 30
>> > ++++++++++++++++++++++++++++++
>> > =C2=A0configs/am62x_evm_a53_defconfig |=C2=A0 2 ++
>> > =C2=A0configs/am62x_r5_usbdfu.config=C2=A0 | 28 ++++++++++++++++++++++=
++++++
>> > =C2=A03 files changed, 60 insertions(+)
>> > =C2=A0create mode 100644 configs/am62x_a53_usbdfu.config
>> > =C2=A0create mode 100644 configs/am62x_r5_usbdfu.config
>> >=20
>> > diff --git a/configs/am62x_a53_usbdfu.config
>> > b/configs/am62x_a53_usbdfu.config
>> > new file mode 100644
>> > index 0000000000..3a19cf2328
>> > --- /dev/null
>> > +++ b/configs/am62x_a53_usbdfu.config
>> > @@ -0,0 +1,29 @@
>> > +CONFIG_SYS_MALLOC_LEN=3D0x2000000
>> > +CONFIG_SPL_ENV_SUPPORT=3Dy
>> > +CONFIG_SPL_RAM_SUPPORT=3Dy
>> > +CONFIG_SPL_RAM_DEVICE=3Dy
>> > +CONFIG_SPL_USB_GADGET=3Dy
>> > +CONFIG_SPL_DFU=3Dy
>> > +CONFIG_CMD_DFU=3Dy
>> > +CONFIG_CMD_USB=3Dy
>> > +CONFIG_SYSCON=3Dy
>> > +CONFIG_SPL_SYSCON=3Dy
>> > +CONFIG_DFU_MMC=3Dy
>> > +CONFIG_DFU_RAM=3Dy
>> > +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
>> > +CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x800000
>> > +CONFIG_USB=3Dy
>> > +CONFIG_DM_USB_GADGET=3Dy
>> > +CONFIG_SPL_DM_USB_GADGET=3Dy
>> > +CONFIG_USB_XHCI_HCD=3Dy
>> > +CONFIG_USB_XHCI_DWC3=3Dy
>> > +CONFIG_USB_DWC3=3Dy
>> > +CONFIG_USB_DWC3_GENERIC=3Dy
>> > +CONFIG_SPL_USB_DWC3_GENERIC=3Dy
>> > +CONFIG_SPL_USB_DWC3_AM62=3Dy
>> > +CONFIG_USB_DWC3_AM62=3Dy
>> > +CONFIG_USB_GADGET=3Dy
>> > +CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
>> > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
>> > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
>> > +CONFIG_USB_GADGET_DOWNLOAD=3Dy
>> > diff --git a/configs/am62x_evm_a53_defconfig
>> > b/configs/am62x_evm_a53_defconfig
>> > index 6c708dcb05..16294a6a79 100644
>> > --- a/configs/am62x_evm_a53_defconfig
>> > +++ b/configs/am62x_evm_a53_defconfig
>> > @@ -68,6 +68,7 @@ CONFIG_SPL_OF_TRANSLATE=3Dy
>> > =C2=A0CONFIG_CLK=3Dy
>> > =C2=A0CONFIG_SPL_CLK=3Dy
>> > =C2=A0CONFIG_CLK_TI_SCI=3Dy
>> > +CONFIG_DFU_SF=3Dy
>> > =C2=A0CONFIG_DMA_CHANNELS=3Dy
>> > =C2=A0CONFIG_TI_K3_NAVSS_UDMA=3Dy
>> > =C2=A0CONFIG_TI_SCI_PROTOCOL=3Dy
>> > @@ -111,3 +112,5 @@ CONFIG_SPL_SYSRESET=3Dy
>> > =C2=A0CONFIG_SYSRESET_TI_SCI=3Dy
>> > =C2=A0CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>> > =C2=A0CONFIG_EFI_SET_TIME=3Dy
>> > +
>> > +#include <configs/am62x_a53_usbdfu.config>
>> > diff --git a/configs/am62x_r5_usbdfu.config
>> > b/configs/am62x_r5_usbdfu.config
>> > new file mode 100644
>> > index 0000000000..772bb2ab93
>> > --- /dev/null
>> > +++ b/configs/am62x_r5_usbdfu.config
>> > @@ -0,0 +1,28 @@
>> > +CONFIG_SPL_ENV_SUPPORT=3Dy
>> > +CONFIG_SYSCON=3Dy
>> > +CONFIG_SPL_SYSCON=3Dy
>> > +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
>> > +CONFIG_MISC=3Dy
>> > +CONFIG_USB=3Dy
>> > +CONFIG_DM_USB_GADGET=3Dy
>> > +CONFIG_SPL_DM_USB_GADGET=3Dy
>> > +CONFIG_USB_DWC3=3Dy
>> > +CONFIG_USB_DWC3_GENERIC=3Dy
>> > +CONFIG_SPL_USB_DWC3_GENERIC=3Dy
>> > +CONFIG_SPL_USB_DWC3_AM62=3Dy
>> > +CONFIG_USB_GADGET=3Dy
>> > +CONFIG_SPL_USB_GADGET=3Dy
>> > +CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
>> > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
>> > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
>> > +CONFIG_USB_GADGET_DOWNLOAD=3Dy
>> > +CONFIG_SPL_DFU=3Dy
>> > +# CONFIG_SPL_MMC is not set
>> > +# CONFIG_SPL_FS_FAT is not set
>> > +# CONFIG_SPL_LIBDISK_SUPPORT is not set
>> > +# CONFIG_SPL_SPI is not set
>> > +# CONFIG_SPL_SYS_MALLOC is not set
>> > +# CONFIG_CMD_GPT is not set
>> > +# CONFIG_CMD_MMC is not set
>> > +# CONFIG_CMD_FAT is not set
>> > +# CONFIG_MMC_SDHCI is not set
>> > --=20
>> > 2.43.0
>>=20
>> Hi all, it appears that this patch breaks OSPI DFU on the board.=C2=A0 In
>> particular, changing the CONFIG_SYS_DFU_DATA_BUF_SIZE seems to be the
>> culprit.
>>=20
>> I see the error as a DFU timeout when applying capsules.
>>=20
>> =C2=A0 SF: Detected s28hs512t with page size 256 Bytes, erase size 256
>> KiB, total 64 MiB
>> =C2=A0 ############jedec_spi_nor flash@0: flash operation timed out
>> =C2=A0 #DFU write failed
>>=20
>
> I'm not seeing this failure using the `-next` branch from yesterday
> (2f96033923).
>
> I've attempted to use both the `uboot-capsule.bin` produced with and
> without the DFU config enabled whilst booting the SK-AM62 via DFU and
> from an SD card. I seem to be consistently getting the following:
>
> =3D> ext2ls mmc 1:1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
> <DIR>       4096 .=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
> <DIR>       4096 ..=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
> <DIR>      16384 lost+found=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>          1132791 uboot-capsule.bin=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> =3D> load mmc 1:1 ${loadaddr} /uboot-capsule.bin=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> 1132791 bytes read in 57 ms (19 MiB/s)=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> =3D> efidebug capsule update ${loadaddr}=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> ** File not found ubootefi.var **=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> Failed to load EFI variables=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
> ** Unable to write file ubootefi.var **=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> Failed to persist EFI variables=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> ** Unable to write file ubootefi.var **=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> Failed to persist EFI variables=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> ** Unable to write file ubootefi.var **=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> Failed to persist EFI variables=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> ** Unable to write file ubootefi.var **=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> Failed to persist EFI variables=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> ** Unable to write file ubootefi.var **=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> Failed to persist EFI variables=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB,
> total 64 Mi
> B=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> ########################################################=20=20=20=20=20=
=20=20=20=20=20=20=20=20
> ** Unable to write file ubootefi.var **=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> Failed to persist EFI variables=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> =3D>
>
> TBH, I'm not sure if this is good or bad at this point, but I'm not
> seeing the error that you reported. As can be seen above, I don't have
> a `ubootefi.var` file, but then I don't boot using EFI mechanisms, so I
> guess that's expected?
>
> But then, the commands I've used above aren't applying the capsule
> either right?
>
> Martyn
>
>> Jon

Hi Martyn, you are not seeing the error. I am on vacation until the 10th so
I cannot follow up. When I return, I'll see if I can reproduce from the
exact sha you listed and we can go from there.

Thanks=20
Jon=20
