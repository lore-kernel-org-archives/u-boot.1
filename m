Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3612C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 17:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C794686DBD;
	Fri, 22 Mar 2024 18:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="cAXq3Njz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF81283334; Fri, 22 Mar 2024 18:34:40 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A8B88126
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 18:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1711128877;
 bh=CZI4Shu7G0Hpl8HaTjtsfTRToXbNNd5NMF0XbXpHCiA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=cAXq3NjzIb41t5XML7Rs90JuoCbuM98MlyxdR9AAHfoX6ayPWWIKtQ6UOoWHN7xbO
 x2K06OxB//37iMlF40FOy3diTfFN7l1Dm4nSutXM+fBZUa40EOSfDn3RmYkUWKc25P
 QoaRBevMqlAMD6gxDE0aSIEoVrV0iUfraiDStMtmjmNInmsydvfn4frlzcm+n6urmD
 Zm+KHN5N6MyX9f8SfcQ4rQZ3bDn/8/Va4mJ4Ult75D6JZKROhmYRD70bH3XWUkhZzY
 xWYzqHNy6V0eaIuCzy0yM0Jz+4QWtFQl5v4zDV/aq8OXgwPePzvpmwKq0IifYVpo0E
 bOqXQWsktN0Pw==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0812F37820EF;
 Fri, 22 Mar 2024 17:34:36 +0000 (UTC)
Message-ID: <f156c76f57450146ce02ba4c41e9a5f867920426.camel@collabora.com>
Subject: Re: [PATCH v2 2/2] rockchip: rock-pi-4-rk3399: enable booting from
 SPI flash
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, kernel@collabora.com, Chen-Yu Tsai
 <wens@csie.org>,  Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki
 <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>,  Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>,  Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
Date: Fri, 22 Mar 2024 17:34:21 +0000
In-Reply-To: <388ad937-a6e6-43d2-ac4e-fad32d7fbd8f@kwiboo.se>
References: <20240315120126.75424-1-chris.obbard@collabora.com>
 <20240315120126.75424-3-chris.obbard@collabora.com>
 <388ad937-a6e6-43d2-ac4e-fad32d7fbd8f@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b1 
MIME-Version: 1.0
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

Hi Jonas,

On Mon, 2024-03-18 at 11:37 +0100, Jonas Karlman wrote:
> Hi Christopher,
>=20
> On 2024-03-15 13:01, Christopher Obbard wrote:
> > Some variants of the ROCK Pi 4 series have an SPI flash chip populated
> > which can be booted from. This patch enables support in U-Boot for
> > building the image for the SPI flash, support for booting U-Boot from t=
he
> > SPI flash chip and support in U-Boot for accessing the SPI flash using
> > `sf` commands.
> >=20
> > Not all variants (e.g. ROCK Pi 4B, ROCK 4 Model C Plus, ROCK 4SE) come
> > populated with an SPI flash chip, but have the footprint on the board s=
o
> > a user could solder their own to the board. With this patchset applied,
> > these board variants without an SPI flash chip still boot from MMC.
> >=20
> > I have enabled support for both Winbond and XTX SPI flash devices since
> > different hardware variants have different devices populated:
> >=20
> > =C2=A0- `rockpi4_v13_sch_20181112.pdf` contains a Winbond part `W25Q64F=
WZPIG`
> > =C2=A0- `rockpi4_v14_sch_20210114.pdf` contains an XTX part `XT25F32BWO=
IGT`
> >=20
> > The ROCK Pi 4 I have is marked as "ROCK PI 4 v1.48" and contains an SPI
> > flash chip from XTX:
> >=20
> > =C2=A0=C2=A0=C2=A0 =3D> sf probe
> > =C2=A0=C2=A0=C2=A0 SF: Detected xt25f32 with page size 256 Bytes, erase=
 size 4 KiB, total
> > 4 MiB
> >=20
> > In the interest of supporting all board variants and not regressing
> > existing users who boot from MMC, I have enabled support for booting fr=
om
> > both SPI flash chip variants in the defconfig and left the environment
> > storage location as MMC to not break existing users who have the
> > environment stored on MMC.
> >=20
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
>=20
> With a small nit below this is:
>=20
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>=20
> >=20
> > ---
> >=20
> > Changes in v2:
> > - Rebase on top of rockchip/for-next.
> > - Sync configuration changes with savedefconfig.
> > - Remove GigaDevice SPI flash chip support (suggested by Kever Y).
> > - Re-enable CONFIG_SPL_FIT_SIGNATURE=3Dy (fixed in rockchip/for-next, s=
olves
> > =C2=A0 multiple problems mentioned in v1. Thanks Jonas!).
> > - Remove spl-boot-order from rk3399-rock-pi-4a-u-boot.dtsi (suggested b=
y
> > =C2=A0 Jonas K).
> > - Enable CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy (suggested by Jonas K).
> >=20
> > =C2=A0arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi |=C2=A0 7 +++++++
> > =C2=A0configs/rock-pi-4-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 ++++++++++++++---
> > =C2=A02 files changed, 21 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > index 85ee5770add..38385621deb 100644
> > --- a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > @@ -4,3 +4,10 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include "rk3399-rock-pi-4-u-boot.dtsi"
> > +
> > +&spi1 {
> > +	flash@0 {
> > +		bootph-pre-ram;
> > +		bootph-some-ram;
> > +	};
> > +};
> > diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-
> > rk3399_defconfig
> > index bca44beca12..315b8b853fc 100644
> > --- a/configs/rock-pi-4-rk3399_defconfig
> > +++ b/configs/rock-pi-4-rk3399_defconfig
> > @@ -3,25 +3,30 @@ CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > =C2=A0CONFIG_COUNTER_FREQUENCY=3D24000000
> > =C2=A0CONFIG_ARCH_ROCKCHIP=3Dy
> > =C2=A0CONFIG_NR_DRAM_BANKS=3D1
> > +CONFIG_SF_DEFAULT_SPEED=3D10000000
> > =C2=A0CONFIG_ENV_OFFSET=3D0x3F8000
> > =C2=A0CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-pi-4a"
> > =C2=A0CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > =C2=A0CONFIG_DM_RESET=3Dy
> > =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> > +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
> > =C2=A0CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> > =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> > =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> > +CONFIG_SPL_SPI=3Dy
> > =C2=A0CONFIG_SYS_LOAD_ADDR=3D0x800800
> > =C2=A0CONFIG_PCI=3Dy
> > =C2=A0CONFIG_DEBUG_UART=3Dy
> > =C2=A0# CONFIG_ANDROID_BOOT_IMAGE is not set
> > =C2=A0CONFIG_SPL_FIT_SIGNATURE=3Dy
> > -CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>=20
> This may stop scripts from working.
>=20
> I am getting very close to send out a big rk3399 DT sync and update
> series [1] on top of your series. That series will move to imply
> LEGACY_IMAGE_FORMAT in Kconfig file, so this does not matter that much.
>=20
> Please let me know if you will revert this line or if I should send out
> my series on top of this patch as-is :-)

Thanks for the review!

I will spin v3 of this series next week.

>=20
> [1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-2024.07-wip
>=20
> Regards,
> Jonas
>=20
> > =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rock-pi-4a.dtb"
> > =C2=A0CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > -CONFIG_SPL_MAX_SIZE=3D0x2e000
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > =C2=A0CONFIG_SPL_PAD_TO=3D0x7f8000
> > =C2=A0# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_SPI_LOAD=3Dy
> > +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0xE0000
> > =C2=A0CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> > =C2=A0CONFIG_TPL=3Dy
> > =C2=A0CONFIG_CMD_BOOTZ=3Dy
> > @@ -40,14 +45,20 @@ CONFIG_SPL_OF_CONTROL=3Dy
> > =C2=A0CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-names
> > interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-
> > parents"
> > =C2=A0CONFIG_ENV_IS_IN_MMC=3Dy
> > =C2=A0CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> > +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > =C2=A0CONFIG_DFU_MMC=3Dy
> > =C2=A0CONFIG_ROCKCHIP_GPIO=3Dy
> > =C2=A0CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > +CONFIG_ROCKCHIP_IODOMAIN=3Dy
> > =C2=A0CONFIG_MMC_DW=3Dy
> > =C2=A0CONFIG_MMC_DW_ROCKCHIP=3Dy
> > =C2=A0CONFIG_MMC_SDHCI=3Dy
> > =C2=A0CONFIG_MMC_SDHCI_SDMA=3Dy
> > =C2=A0CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_SF_DEFAULT_BUS=3D1
> > +CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> > +CONFIG_SPI_FLASH_WINBOND=3Dy
> > +CONFIG_SPI_FLASH_XTX=3Dy
> > =C2=A0CONFIG_ETH_DESIGNWARE=3Dy
> > =C2=A0CONFIG_GMAC_ROCKCHIP=3Dy
> > =C2=A0CONFIG_NVME_PCI=3Dy
> > @@ -61,6 +72,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> > =C2=A0CONFIG_BAUDRATE=3D1500000
> > =C2=A0CONFIG_DEBUG_UART_SHIFT=3D2
> > =C2=A0CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_ROCKCHIP_SPI=3Dy
> > =C2=A0CONFIG_SYSRESET=3Dy
> > =C2=A0CONFIG_USB=3Dy
> > =C2=A0CONFIG_USB_XHCI_HCD=3Dy
> > @@ -81,7 +93,6 @@ CONFIG_VIDEO=3Dy
> > =C2=A0CONFIG_DISPLAY=3Dy
> > =C2=A0CONFIG_VIDEO_ROCKCHIP=3Dy
> > =C2=A0CONFIG_DISPLAY_ROCKCHIP_HDMI=3Dy
> > -CONFIG_SPL_TINY_MEMSET=3Dy
> > =C2=A0CONFIG_ERRNO_STR=3Dy
> > =C2=A0CONFIG_EFI_CAPSULE_ON_DISK=3Dy
> > =C2=A0CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy
>=20

Thanks !
