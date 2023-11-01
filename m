Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3971C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 14:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC83587A6A;
	Wed,  1 Nov 2023 15:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C29887730; Wed,  1 Nov 2023 15:20:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 10C9587D2B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 15:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379C02F4;
 Wed,  1 Nov 2023 07:20:58 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDE6D3F64C;
 Wed,  1 Nov 2023 07:20:15 -0700 (PDT)
Date: Wed, 1 Nov 2023 14:20:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Ludwig Kormann <ludwig.kormann@ict42.de>
Cc: hdegoede@redhat.com, jagan@amarulasolutions.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/1] arm: dts: icnova-a20-adb4006: Add board support
Message-ID: <20231101142012.62ad6b7e@donnerap.manchester.arm.com>
In-Reply-To: <20231101072832.2748412-1-ludwig.kormann@ict42.de>
References: <20231101072832.2748412-1-ludwig.kormann@ict42.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed,  1 Nov 2023 08:28:32 +0100
Ludwig Kormann <ludwig.kormann@ict42.de> wrote:

Hi Ludwig,

thanks for the respin!

> Add board support for ICnova A20 SomPi compute module on
> ICnova ADB4006 development board.
>=20
> Specification:
> SoM
> - Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
> - 512MB DDR3 RAM
> - Fast Ethernet (Phy: Realtek RTL8201CP)
> ADB4006
> - I2C
> - 2x USB 2.0
> - 1x Fast Ethernet port
> - 1x SATA
> - 2x buttons (PWRON, Boot)
> - 2x LEDS
> - serial console
> - HDMI
> - =C2=B5SD-Card slot
> - Audio Line-In / Line-Out
> - GPIO pinheaders
>=20
> https://wiki.in-circuit.de/index.php5?title=3DICnova_ADB4006
> https://wiki.in-circuit.de/index.php5?title=3DICnova_A20_SODIMM
>=20
> devicetree upstreamed with linux 6.5

Looks good now, the defconfig is fine, and it compiles. I will take it in
the current cycle still.

> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> changes in v4:
> - rebase on master
> - add CONFIG_SYS_64BIT_LBA
> - drop dts from patch, already upstreamed
>=20
> changes in v3:
> - rebase on v2023.10
>=20
> changes in v2:
> - rebase on v2023.07-rc2
> - remove pin defines from defconfig
> - get dts reviewed on the linux mailing list and
>   scheduled for kernel 6.5 [1]
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> commit de2bdfb7f79d5c655eb056d459e02be2c7f13c8b
>=20
> ---
>  arch/arm/dts/Makefile                |  1 +
>  board/sunxi/MAINTAINERS              |  5 +++++
>  configs/icnova-a20-adb4006_defconfig | 21 +++++++++++++++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 configs/icnova-a20-adb4006_defconfig
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 55aceb51cd..d947b8de56 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -693,6 +693,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
>  	sun7i-a20-haoyu-marsboard.dtb \
>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
> +	sun7i-a20-icnova-a20-adb4006.dtb \
>  	sun7i-a20-icnova-swac.dtb \
>  	sun7i-a20-itead-ibox.dtb \
>  	sun7i-a20-lamobo-r1.dtb \
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index 4bbe3f62fa..0061437211 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -236,6 +236,11 @@ M:	Stefan Roese <sr@denx.de>
>  S:	Maintained
>  F:	configs/icnova-a20-swac_defconfig
> =20
> +ICnova-A20-ADB4006 BOARD
> +M:	Ludwig Kormann <ludwig.kormann@ict42.de>
> +S:	Maintained
> +F:	configs/icnova-a20-adb4006_defconfig
> +
>  ITEAD IBOX BOARD
>  M:	Marcus Cooper <codekipper@gmail.com>
>  S:	Maintained
> diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-ad=
b4006_defconfig
> new file mode 100644
> index 0000000000..22cbb612e3
> --- /dev/null
> +++ b/configs/icnova-a20-adb4006_defconfig
> @@ -0,0 +1,21 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_SUNXI=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"sun7i-a20-icnova-a20-adb4006"
> +CONFIG_SPL=3Dy
> +CONFIG_MACH_SUN7I=3Dy
> +CONFIG_DRAM_CLK=3D384
> +CONFIG_AHCI=3Dy
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_I2C=3Dy
> +CONFIG_SCSI_AHCI=3Dy
> +CONFIG_SYS_64BIT_LBA=3Dy
> +CONFIG_SYS_I2C_MVTWSI=3Dy
> +CONFIG_SYS_I2C_SLAVE=3D0x7f
> +CONFIG_SYS_I2C_SPEED=3D400000
> +CONFIG_ETH_DESIGNWARE=3Dy
> +CONFIG_MII=3Dy
> +CONFIG_SUN7I_GMAC=3Dy
> +CONFIG_AXP_ALDO4_VOLT=3D2800
> +CONFIG_SCSI=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_OHCI_HCD=3Dy

