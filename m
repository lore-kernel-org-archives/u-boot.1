Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD88DC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 16:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD55F87DCD;
	Sat,  2 Mar 2024 17:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IBvsazd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E71D87DDE; Sat,  2 Mar 2024 17:12:48 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B22A87DCA
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 17:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709395965;
 bh=N9zG+jnY9GALVWit8YavThCL0VP3tM0J6U42Rb3rs0Y=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=IBvsazd7zkhrHj1EGit8Ls51xl1gOtBq0EoZSsEe3kNYcTwiXFoWRfPezmkf8PnLI
 FZ9SzZDiVRABYhsCjkBLoffnBHIKNmRqS7FInpYlBJPsMC8fG6gVzgNo0A6koVxk1y
 MKU39hFrUkrHVvkN4pvYKF+c5S72WC+uB8ZPm6g6xyR8f5Wgs59W0ZZwfcEuUYntol
 G3XvS0fsQrNLZGIhU72SzO1YuRKJydBVP+0SczXrOS1vdLsWPqq0HXr+7I0OcOMIQY
 ffsNkn3N+J0QlqXtbFkwM2cT4cGMDjhNVn/XlglCbmi/rBjn30OQx1SppnkXkbeZ+t
 8F63tuu7izV+w==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5B247378208D;
 Sat,  2 Mar 2024 16:12:44 +0000 (UTC)
Message-ID: <5e9f1b5f008193eea447b7506080af855189b3e1.camel@collabora.com>
Subject: Re: [PATCH v1 2/2] rockchip: rock-pi-4-rk3399: Enable booting from
 SPI flash
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: kernel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>, u-boot@lists.denx.de
Date: Sat, 02 Mar 2024 16:12:27 +0000
In-Reply-To: <abdd421f-49d3-4442-ab0a-0c2c143aa199@kwiboo.se>
References: <20240302143417.164560-1-chris.obbard@collabora.com>
 <20240302143417.164560-3-chris.obbard@collabora.com>
 <abdd421f-49d3-4442-ab0a-0c2c143aa199@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
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

On Sat, 2024-03-02 at 16:28 +0100, Jonas Karlman wrote:
> Hi Christopher,
>=20
> On 2024-03-02 15:34, Christopher Obbard wrote:
> > Some variants of the ROCK Pi 4 series contain an SPI flash chip, which =
can
> > be booted from. This patch enables support in U-Boot for building the
> > image for the SPI flash, support for booting U-Boot from the SPI flash
> > chip and support in U-Boot for accessing the SPI flash using `sf`
> > commands.
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
> > I have also enabled GigaDevice SPI flash chip support, since without it
> > U-Boot (unexplainably) fails to load with an error:
> >=20
> > =C2=A0=C2=A0=C2=A0 U-Boot SPL 2024.04-rc3-00002-g06b486900e2 (Mar 02 20=
24 - 13:20:45
> > +0000)
> > =C2=A0=C2=A0=C2=A0 Trying to boot from SPI
> > =C2=A0=C2=A0=C2=A0 load_simple_fit: Skip load 'atf-5': image size is 0!
> > =C2=A0=C2=A0=C2=A0 initcall failed at call 000000000029beec (err=3D-11:=
 Try again)
> > =C2=A0=C2=A0=C2=A0 ### ERROR ### Please RESET the board ###
>=20
> This is possibly because of pinctrl no being configured in SPL. I have a
> big incoming rk3399 series that tries to fix this for most rk3399 boards.
> It will be a variant of what I did in [1] for rk3328.

Sounds good! Let me know if you want to take these patches in that series, =
or
how you wish to work together to not duplicate work. I am open to suggestio=
ns
if it makes things easier for Kever to merge ;-).


>=20
> BROM will only configure pinctrl for each device it tries to locate IDB
> from, so if it locates IDB in SPL it will not have configured emmc or
> sd-card. So for SPL to be able to fall back on other storage it will
> need to do proper pinctrl.
>=20
> [1] https://patchwork.ozlabs.org/cover/1900345/
>=20
> >=20
> > Building with `CONFIG_SPL_FIT_SIGNATURE=3Dy` causes an error when booti=
ng
> > from SPI flash, so I disabled it:
> >=20
> > =C2=A0=C2=A0=C2=A0 U-Boot 2024.04-rc3-00010-g2e7974a13b9 (Mar 02 2024 -=
 14:00:17 +0000)
> > =C2=A0=C2=A0=C2=A0 SoC: Rockchip rk3399
> > =C2=A0=C2=A0=C2=A0 Reset cause: unknown reset
> > =C2=A0=C2=A0=C2=A0 Model: Radxa ROCK Pi 4A
> > =C2=A0=C2=A0=C2=A0 DRAM:=C2=A0 initcall failed at call 0000000000228efc=
 (err=3D-19: No such
> > device)
> > =C2=A0=C2=A0=C2=A0 ### ERROR ### Please RESET the board ###
>=20
> This is unexpected but if your u-boot.bin is close to or larger then 1
> MiB the stack and pre-alloc heap may be overlapping with U-Boot proper
> or the FDT. That can cause all sort of strange and unexpected issues :-)
>=20
> Have another incoming series to address this for RK3328, RK3399 and
> ROCK 5A [2]. Should hit list later today, it will be a rework of [3].

Great, please keep me in CC of those series and I will test & rebase my wor=
k
on top.


Thanks!
Chris

>=20
> [2]
> https://github.com/Kwiboo/u-boot-rockchip/compare/2011cf069a8b...9767374d=
6a8a
> [3] https://patchwork.ozlabs.org/cover/1900376/
>=20
> >=20
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > ---
> >=20
> > =C2=A0arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi | 12 ++++++++++++
> > =C2=A0configs/rock-pi-4-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 15 +++++++++++++--
> > =C2=A02 files changed, 25 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > index 85ee5770add..04c152a291f 100644
> > --- a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> > @@ -4,3 +4,15 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include "rk3399-rock-pi-4-u-boot.dtsi"
> > +
> > +/ {
> > +	chosen {
> > +		u-boot,spl-boot-order =3D "same-as-spl", &spi_flash,
> > &sdhci, &sdmmc;
>=20
> I would not recommend adding spi_flash here, especially if you have
> SPL_FIT_SIGNATURE disabled, and even more so if someone accidentally
> enable SPL_RAW_IMAGE_SUPPORT.
>=20
> Ideally, we only load TPL/SPL+FIT from same storage, as provided by
> same-as-spl, however, if we cannot load from the same storage that
> TPL/SPL was loaded from, for recovery purposes it is typically easier to
> fall back on sd-card followed by emmc.
>=20
> Normally I would expect that if board does not boot TPL/SPL from SPI,
> there is no real reason to try and load FIT from SPI.
>=20
> If the FIT cannot be loaded from SPI with same-as-spl alone there is
> possible some other issue that we need to resolve.
>=20
> > +	};
> > +};
> > +
> > +&spi1 {
> > +	spi_flash: flash@0 {
> > +		bootph-all;
> > +	};
> > +};
> > diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-
> > rk3399_defconfig
> > index 83fc4ad7dab..3a38b51c46b 100644
> > --- a/configs/rock-pi-4-rk3399_defconfig
> > +++ b/configs/rock-pi-4-rk3399_defconfig
> > @@ -6,25 +6,28 @@ CONFIG_TEXT_BASE=3D0x00200000
> > =C2=A0CONFIG_NR_DRAM_BANKS=3D1
> > =C2=A0CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > =C2=A0CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> > +CONFIG_SF_DEFAULT_SPEED=3D10000000
> > =C2=A0CONFIG_ENV_OFFSET=3D0x3F8000
> > =C2=A0CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-pi-4a"
> > =C2=A0CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > =C2=A0CONFIG_DM_RESET=3Dy
> > =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> > +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
> > =C2=A0CONFIG_TARGET_EVB_RK3399=3Dy
> > =C2=A0CONFIG_SPL_STACK=3D0x400000
> > =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> > =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> > +CONFIG_SPL_SPI=3Dy
> > =C2=A0CONFIG_SYS_LOAD_ADDR=3D0x800800
> > =C2=A0CONFIG_PCI=3Dy
> > =C2=A0CONFIG_DEBUG_UART=3Dy
> > =C2=A0# CONFIG_ANDROID_BOOT_IMAGE is not set
> > -CONFIG_SPL_FIT_SIGNATURE=3Dy
> > =C2=A0CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rock-pi-4a.dtb"
> > =C2=A0CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > =C2=A0CONFIG_MISC_INIT_R=3Dy
> > -CONFIG_SPL_MAX_SIZE=3D0x2e000
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > =C2=A0CONFIG_SPL_PAD_TO=3D0x7f8000
> > =C2=A0CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > =C2=A0CONFIG_SPL_BSS_START_ADDR=3D0x400000
> > @@ -33,6 +36,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> > =C2=A0# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > =C2=A0CONFIG_SPL_STACK_R=3Dy
> > =C2=A0CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
> > +CONFIG_SPL_SPI_LOAD=3Dy
> > +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0xE0000
> > =C2=A0CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> > =C2=A0CONFIG_TPL=3Dy
> > =C2=A0CONFIG_CMD_BOOTZ=3Dy
> > @@ -52,6 +57,7 @@ CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names
> > clock-names interrupt-parent
> > =C2=A0CONFIG_ENV_IS_IN_MMC=3Dy
> > =C2=A0CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> > =C2=A0CONFIG_DFU_MMC=3Dy
> > +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > =C2=A0CONFIG_ROCKCHIP_GPIO=3Dy
> > =C2=A0CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > =C2=A0CONFIG_MISC=3Dy
> > @@ -61,6 +67,10 @@ CONFIG_MMC_DW_ROCKCHIP=3Dy
> > =C2=A0CONFIG_MMC_SDHCI=3Dy
> > =C2=A0CONFIG_MMC_SDHCI_SDMA=3Dy
> > =C2=A0CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_SF_DEFAULT_BUS=3D1
>=20
> Would recommend adding following to allow reading SFDP properties from
> flash, it is what I am doing to all other rk boards with spi flash:
>=20
> CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
>=20
> Regards,
> Jonas
>=20
> > +CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> > +CONFIG_SPI_FLASH_WINBOND=3Dy
> > +CONFIG_SPI_FLASH_XTX=3Dy
> > =C2=A0CONFIG_ETH_DESIGNWARE=3Dy
> > =C2=A0CONFIG_GMAC_ROCKCHIP=3Dy
> > =C2=A0CONFIG_NVME_PCI=3Dy
> > @@ -74,6 +84,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> > =C2=A0CONFIG_BAUDRATE=3D1500000
> > =C2=A0CONFIG_DEBUG_UART_SHIFT=3D2
> > =C2=A0CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_ROCKCHIP_SPI=3Dy
> > =C2=A0CONFIG_SYSRESET=3Dy
> > =C2=A0CONFIG_USB=3Dy
> > =C2=A0CONFIG_USB_XHCI_HCD=3Dy
>=20
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com
