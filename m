Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA1FC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 21:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866FE88197;
	Tue,  2 Apr 2024 23:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kjWJNiKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0402588188; Tue,  2 Apr 2024 23:42:16 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC30488167
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 23:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1712094133;
 bh=sV5Qa4y+CtDOETzbNceHcynZ5EtWWtX11YLwJLxVIzo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=kjWJNiKvpsnkBRUr4IbBXpu6Hsa9Hfc7Wx3dSq7Q2w21g/G+0E6AmgtnD1djEEIba
 ZkqlS4K83BpjXjovDvH6EI01p/yfrMfu5PDJ1iMZWmAs2ErJqPzP9Yxr8qoMXobl7V
 DKOWcXneQvEbQbDsL0tcAf+Ai6XAOangLQFHbIOHGxBXd+6HpS7p2tMqBGXxtYCfE3
 jK564EsS3rBI845jdcpsvzq0gBAuQmyQKWio0HIR3eWAGdUUQ24mQmb1RVGd/b8coN
 fx+Ay+fb6C5YhCILQlC5dMLveDtLMTZUCKCEBqq8/GKwK407CbcJl71wMtTuDdOaU2
 n+EZYB/g9fwmQ==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AFF4937813D7;
 Tue,  2 Apr 2024 21:42:12 +0000 (UTC)
Message-ID: <0422e83904c8d95d2923ea083deb4be188f5015e.camel@collabora.com>
Subject: Re: [PATCH 28/31] rockchip: rk3399-rock-pi-4: Sync device tree from
 linux v6.8
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,  FUKAUMI Naoki
 <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Date: Tue, 02 Apr 2024 22:41:56 +0100
In-Reply-To: <20240331202921.262323-29-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-29-jonas@kwiboo.se>
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

On Sun, 2024-03-31 at 20:28 +0000, Jonas Karlman wrote:
> Sync rk3399-rock-pi-4 related device tree from linux v6.8.
>=20
> Add SPI flash related options to support booting from SPI flash.
>=20
> Add AHCI=3Dy, SCSI_AHCI=3Dy, AHCI_PCI=3Dy and SCSI=3Dy to support PCIe SA=
TA boot.
>=20
> Change to SPL_MAX_SIZE=3D0x40000, SPL can be up to 256 KiB.
>=20
> Add ROCKCHIP_IODOMAIN=3Dy to configure io-domain voltage.
>=20
> Add PHY_REALTEK=3Dy and DM_ETH_PHY=3Dy to support ethernet PHY.
>=20
> Remove SPL_TINY_MEMSET=3Dy to use full memset in SPL.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Thank you for taking care of this.

Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>

> ---
> =C2=A0arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 12 ++++++++++
> =C2=A0arch/arm/dts/rk3399-rock-4c-plus.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0arch/arm/dts/rk3399-rock-4se-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0 | =
12 ++++++++++
> =C2=A0arch/arm/dts/rk3399-rock-pi-4.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
> =C2=A0arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi=C2=A0=C2=A0 |=C2=A0 7 ++=
++++
> =C2=A0arch/arm/dts/rk3399-rock-pi-4c.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++
> =C2=A0configs/rock-4c-plus-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 24 +++++++++++++++-----
> =C2=A0configs/rock-4se-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 23 +++++++++++++++++--
> =C2=A0configs/rock-pi-4-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++++
> =C2=A0configs/rock-pi-4c-rk3399_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++++++++++++--
> =C2=A010 files changed, 114 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> index 9785b97b9eea..b5ee644a83dd 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> @@ -11,3 +11,15 @@
> =C2=A0&pcfg_pull_up_8ma {
> =C2=A0	bootph-pre-ram;
> =C2=A0};
> +
> +&spi1 {
> +	status =3D "okay";
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus.dts b/arch/arm/dts/rk3399-
> rock-4c-plus.dts
> index 8bfd5f88d1ef..7baf9d1b22fd 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus.dts
> +++ b/arch/arm/dts/rk3399-rock-4c-plus.dts
> @@ -15,6 +15,7 @@
> =C2=A0	compatible =3D "radxa,rock-4c-plus", "rockchip,rk3399";
> =C2=A0
> =C2=A0	aliases {
> +		ethernet0 =3D &gmac;
> =C2=A0		mmc0 =3D &sdhci;
> =C2=A0		mmc1 =3D &sdmmc;
> =C2=A0	};
> diff --git a/arch/arm/dts/rk3399-rock-4se-u-boot.dtsi b/arch/arm/dts/rk33=
99-
> rock-4se-u-boot.dtsi
> index 85ee5770add0..2213d0093052 100644
> --- a/arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
> @@ -4,3 +4,15 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include "rk3399-rock-pi-4-u-boot.dtsi"
> +
> +&spi1 {
> +	status =3D "okay";
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4.dtsi b/arch/arm/dts/rk3399-roc=
k-
> pi-4.dtsi
> index b1b7f4ffb1d4..281a12180703 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4.dtsi
> @@ -12,6 +12,7 @@
> =C2=A0
> =C2=A0/ {
> =C2=A0	aliases {
> +		ethernet0 =3D &gmac;
> =C2=A0		mmc0 =3D &sdhci;
> =C2=A0		mmc1 =3D &sdmmc;
> =C2=A0	};
> @@ -44,7 +45,7 @@
> =C2=A0	sdio_pwrseq: sdio-pwrseq {
> =C2=A0		compatible =3D "mmc-pwrseq-simple";
> =C2=A0		clocks =3D <&rk808 1>;
> -		clock-names =3D "ext_clock";
> +		clock-names =3D "lpo";
> =C2=A0		pinctrl-names =3D "default";
> =C2=A0		pinctrl-0 =3D <&wifi_enable_h>;
> =C2=A0		reset-gpios =3D <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> @@ -492,6 +493,7 @@
> =C2=A0
> =C2=A0&i2s0 {
> =C2=A0	pinctrl-0 =3D <&i2s0_2ch_bus>;
> +	pinctrl-1 =3D <&i2s0_2ch_bus_bclk_off>;
> =C2=A0	rockchip,capture-channels =3D <2>;
> =C2=A0	rockchip,playback-channels =3D <2>;
> =C2=A0	status =3D "okay";
> diff --git a/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> b/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> index 85ee5770add0..38385621deb1 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> @@ -4,3 +4,10 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include "rk3399-rock-pi-4-u-boot.dtsi"
> +
> +&spi1 {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4c.dts b/arch/arm/dts/rk3399-roc=
k-
> pi-4c.dts
> index d32efab74e94..de2ebe4cb4f3 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4c.dts
> +++ b/arch/arm/dts/rk3399-rock-pi-4c.dts
> @@ -43,6 +43,16 @@
> =C2=A0	hp-det-gpio =3D <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> =C2=A0};
> =C2=A0
> +&spi1 {
> +	status =3D "okay";
> +
> +	flash@0 {
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +};
> +
> =C2=A0&uart0 {
> =C2=A0	status =3D "okay";
> =C2=A0
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus=
-
> rk3399_defconfig
> index 2024defb2bf0..e97fde17acc2 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -3,22 +3,27 @@ CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> =C2=A0CONFIG_COUNTER_FREQUENCY=3D24000000
> =C2=A0CONFIG_ARCH_ROCKCHIP=3Dy
> =C2=A0CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_SF_DEFAULT_SPEED=3D10000000
> =C2=A0CONFIG_ENV_OFFSET=3D0x3F8000
> =C2=A0CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-4c-plus"
> =C2=A0CONFIG_DM_RESET=3Dy
> =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
> =C2=A0CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> +CONFIG_SPL_SPI=3Dy
> =C2=A0CONFIG_SYS_LOAD_ADDR=3D0x800800
> -CONFIG_PCI=3Dy
> =C2=A0CONFIG_DEBUG_UART=3Dy
> =C2=A0# CONFIG_ANDROID_BOOT_IMAGE is not set
> =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rock-4c-plus.dtb"
> =C2=A0CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_SPL_MAX_SIZE=3D0x2e000
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> =C2=A0CONFIG_SPL_PAD_TO=3D0x7f8000
> =C2=A0# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0xE0000
> =C2=A0CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> =C2=A0CONFIG_TPL=3Dy
> =C2=A0CONFIG_CMD_BOOTZ=3Dy
> @@ -26,7 +31,6 @@ CONFIG_CMD_NVEDIT_EFI=3Dy
> =C2=A0CONFIG_CMD_DFU=3Dy
> =C2=A0CONFIG_CMD_GPT=3Dy
> =C2=A0CONFIG_CMD_MMC=3Dy
> -CONFIG_CMD_PCI=3Dy
> =C2=A0CONFIG_CMD_USB=3Dy
> =C2=A0CONFIG_CMD_ROCKUSB=3Dy
> =C2=A0CONFIG_CMD_USB_MASS_STORAGE=3Dy
> @@ -40,23 +44,32 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> =C2=A0CONFIG_DFU_MMC=3Dy
> =C2=A0CONFIG_ROCKCHIP_GPIO=3Dy
> =C2=A0CONFIG_SYS_I2C_ROCKCHIP=3Dy
> +CONFIG_ROCKCHIP_IODOMAIN=3Dy
> =C2=A0CONFIG_MMC_DW=3Dy
> =C2=A0CONFIG_MMC_DW_ROCKCHIP=3Dy
> =C2=A0CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_SDMA=3Dy
> =C2=A0CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> +CONFIG_SF_DEFAULT_BUS=3D1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> +CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_SPI_FLASH_MACRONIX=3Dy
> +CONFIG_SPI_FLASH_WINBOND=3Dy
> +CONFIG_SPI_FLASH_XTX=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> =C2=A0CONFIG_ETH_DESIGNWARE=3Dy
> =C2=A0CONFIG_GMAC_ROCKCHIP=3Dy
> -CONFIG_NVME_PCI=3Dy
> =C2=A0CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> =C2=A0CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
> =C2=A0CONFIG_PMIC_RK8XX=3Dy
> -CONFIG_REGULATOR_PWM=3Dy
> =C2=A0CONFIG_REGULATOR_RK8XX=3Dy
> =C2=A0CONFIG_PWM_ROCKCHIP=3Dy
> =C2=A0CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> =C2=A0CONFIG_BAUDRATE=3D1500000
> =C2=A0CONFIG_DEBUG_UART_SHIFT=3D2
> =C2=A0CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_ROCKCHIP_SPI=3Dy
> =C2=A0CONFIG_SYSRESET=3Dy
> =C2=A0CONFIG_USB=3Dy
> =C2=A0CONFIG_USB_XHCI_HCD=3Dy
> @@ -77,7 +90,6 @@ CONFIG_VIDEO=3Dy
> =C2=A0CONFIG_DISPLAY=3Dy
> =C2=A0CONFIG_VIDEO_ROCKCHIP=3Dy
> =C2=A0CONFIG_DISPLAY_ROCKCHIP_HDMI=3Dy
> -CONFIG_SPL_TINY_MEMSET=3Dy
> =C2=A0CONFIG_ERRNO_STR=3Dy
> =C2=A0CONFIG_EFI_CAPSULE_ON_DISK=3Dy
> =C2=A0CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-
> rk3399_defconfig
> index 9b2303fdf792..13f5f84b9836 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -3,22 +3,29 @@ CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> =C2=A0CONFIG_COUNTER_FREQUENCY=3D24000000
> =C2=A0CONFIG_ARCH_ROCKCHIP=3Dy
> =C2=A0CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_SF_DEFAULT_SPEED=3D10000000
> =C2=A0CONFIG_ENV_OFFSET=3D0x3F8000
> =C2=A0CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-4se"
> =C2=A0CONFIG_DM_RESET=3Dy
> =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
> =C2=A0CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> +CONFIG_SPL_SPI=3Dy
> =C2=A0CONFIG_SYS_LOAD_ADDR=3D0x800800
> =C2=A0CONFIG_PCI=3Dy
> =C2=A0CONFIG_DEBUG_UART=3Dy
> +CONFIG_AHCI=3Dy
> =C2=A0# CONFIG_ANDROID_BOOT_IMAGE is not set
> =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rock-4se.dtb"
> =C2=A0CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_SPL_MAX_SIZE=3D0x2e000
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> =C2=A0CONFIG_SPL_PAD_TO=3D0x7f8000
> =C2=A0# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0xE0000
> =C2=A0CONFIG_TPL=3Dy
> =C2=A0CONFIG_CMD_BOOTZ=3Dy
> =C2=A0CONFIG_CMD_NVEDIT_EFI=3Dy
> @@ -36,14 +43,25 @@ CONFIG_SPL_OF_CONTROL=3Dy
> =C2=A0CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned=
-clocks
> assigned-clock-rates assigned-clock-parents"
> =C2=A0CONFIG_ENV_IS_IN_MMC=3Dy
> =C2=A0CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_SCSI_AHCI=3Dy
> +CONFIG_AHCI_PCI=3Dy
> =C2=A0CONFIG_DFU_MMC=3Dy
> =C2=A0CONFIG_ROCKCHIP_GPIO=3Dy
> =C2=A0CONFIG_SYS_I2C_ROCKCHIP=3Dy
> +CONFIG_ROCKCHIP_IODOMAIN=3Dy
> =C2=A0CONFIG_MMC_DW=3Dy
> =C2=A0CONFIG_MMC_DW_ROCKCHIP=3Dy
> =C2=A0CONFIG_MMC_SDHCI=3Dy
> =C2=A0CONFIG_MMC_SDHCI_SDMA=3Dy
> =C2=A0CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> +CONFIG_SF_DEFAULT_BUS=3D1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> +CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_SPI_FLASH_MACRONIX=3Dy
> +CONFIG_SPI_FLASH_WINBOND=3Dy
> +CONFIG_SPI_FLASH_XTX=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> =C2=A0CONFIG_ETH_DESIGNWARE=3Dy
> =C2=A0CONFIG_GMAC_ROCKCHIP=3Dy
> =C2=A0CONFIG_NVME_PCI=3Dy
> @@ -54,9 +72,11 @@ CONFIG_REGULATOR_PWM=3Dy
> =C2=A0CONFIG_REGULATOR_RK8XX=3Dy
> =C2=A0CONFIG_PWM_ROCKCHIP=3Dy
> =C2=A0CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> +CONFIG_SCSI=3Dy
> =C2=A0CONFIG_BAUDRATE=3D1500000
> =C2=A0CONFIG_DEBUG_UART_SHIFT=3D2
> =C2=A0CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_ROCKCHIP_SPI=3Dy
> =C2=A0CONFIG_SYSRESET=3Dy
> =C2=A0CONFIG_USB=3Dy
> =C2=A0CONFIG_USB_XHCI_HCD=3Dy
> @@ -77,7 +97,6 @@ CONFIG_VIDEO=3Dy
> =C2=A0CONFIG_DISPLAY=3Dy
> =C2=A0CONFIG_VIDEO_ROCKCHIP=3Dy
> =C2=A0CONFIG_DISPLAY_ROCKCHIP_HDMI=3Dy
> -CONFIG_SPL_TINY_MEMSET=3Dy
> =C2=A0CONFIG_ERRNO_STR=3Dy
> =C2=A0CONFIG_EFI_CAPSULE_ON_DISK=3Dy
> =C2=A0CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-
> rk3399_defconfig
> index e5a2bba8e7ff..d474d91053c1 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -17,6 +17,7 @@ CONFIG_SPL_SPI=3Dy
> =C2=A0CONFIG_SYS_LOAD_ADDR=3D0x800800
> =C2=A0CONFIG_PCI=3Dy
> =C2=A0CONFIG_DEBUG_UART=3Dy
> +CONFIG_AHCI=3Dy
> =C2=A0# CONFIG_ANDROID_BOOT_IMAGE is not set
> =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rock-pi-4a.dtb"
> =C2=A0CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -43,6 +44,8 @@ CONFIG_SPL_OF_CONTROL=3Dy
> =C2=A0CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned=
-clocks
> assigned-clock-rates assigned-clock-parents"
> =C2=A0CONFIG_ENV_IS_IN_MMC=3Dy
> =C2=A0CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_SCSI_AHCI=3Dy
> +CONFIG_AHCI_PCI=3Dy
> =C2=A0CONFIG_DFU_MMC=3Dy
> =C2=A0CONFIG_ROCKCHIP_GPIO=3Dy
> =C2=A0CONFIG_SYS_I2C_ROCKCHIP=3Dy
> @@ -54,8 +57,12 @@ CONFIG_MMC_SDHCI_SDMA=3Dy
> =C2=A0CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> =C2=A0CONFIG_SF_DEFAULT_BUS=3D1
> =C2=A0CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> +CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_SPI_FLASH_MACRONIX=3Dy
> =C2=A0CONFIG_SPI_FLASH_WINBOND=3Dy
> =C2=A0CONFIG_SPI_FLASH_XTX=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> =C2=A0CONFIG_ETH_DESIGNWARE=3Dy
> =C2=A0CONFIG_GMAC_ROCKCHIP=3Dy
> =C2=A0CONFIG_NVME_PCI=3Dy
> @@ -66,6 +73,7 @@ CONFIG_REGULATOR_PWM=3Dy
> =C2=A0CONFIG_REGULATOR_RK8XX=3Dy
> =C2=A0CONFIG_PWM_ROCKCHIP=3Dy
> =C2=A0CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> +CONFIG_SCSI=3Dy
> =C2=A0CONFIG_BAUDRATE=3D1500000
> =C2=A0CONFIG_DEBUG_UART_SHIFT=3D2
> =C2=A0CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-
> rk3399_defconfig
> index 4a9d1c531c10..50c6755246f2 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -3,22 +3,29 @@ CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> =C2=A0CONFIG_COUNTER_FREQUENCY=3D24000000
> =C2=A0CONFIG_ARCH_ROCKCHIP=3Dy
> =C2=A0CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_SF_DEFAULT_SPEED=3D10000000
> =C2=A0CONFIG_ENV_OFFSET=3D0x3F8000
> =C2=A0CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-pi-4c"
> =C2=A0CONFIG_DM_RESET=3Dy
> =C2=A0CONFIG_ROCKCHIP_RK3399=3Dy
> +CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
> =C2=A0CONFIG_TARGET_ROCKPI4_RK3399=3Dy
> =C2=A0CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
> =C2=A0CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
> +CONFIG_SPL_SPI=3Dy
> =C2=A0CONFIG_SYS_LOAD_ADDR=3D0x800800
> =C2=A0CONFIG_PCI=3Dy
> =C2=A0CONFIG_DEBUG_UART=3Dy
> +CONFIG_AHCI=3Dy
> =C2=A0# CONFIG_ANDROID_BOOT_IMAGE is not set
> =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rock-pi-4c.dtb"
> =C2=A0CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_SPL_MAX_SIZE=3D0x2e000
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> =C2=A0CONFIG_SPL_PAD_TO=3D0x7f8000
> =C2=A0# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0xE0000
> =C2=A0CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> =C2=A0CONFIG_TPL=3Dy
> =C2=A0CONFIG_CMD_BOOTZ=3Dy
> @@ -37,13 +44,25 @@ CONFIG_SPL_OF_CONTROL=3Dy
> =C2=A0CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned=
-clocks
> assigned-clock-rates assigned-clock-parents"
> =C2=A0CONFIG_ENV_IS_IN_MMC=3Dy
> =C2=A0CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_SCSI_AHCI=3Dy
> +CONFIG_AHCI_PCI=3Dy
> =C2=A0CONFIG_DFU_MMC=3Dy
> =C2=A0CONFIG_ROCKCHIP_GPIO=3Dy
> =C2=A0CONFIG_SYS_I2C_ROCKCHIP=3Dy
> +CONFIG_ROCKCHIP_IODOMAIN=3Dy
> =C2=A0CONFIG_MMC_DW=3Dy
> =C2=A0CONFIG_MMC_DW_ROCKCHIP=3Dy
> =C2=A0CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_SDMA=3Dy
> =C2=A0CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> +CONFIG_SF_DEFAULT_BUS=3D1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> +CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_SPI_FLASH_MACRONIX=3Dy
> +CONFIG_SPI_FLASH_WINBOND=3Dy
> +CONFIG_SPI_FLASH_XTX=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> =C2=A0CONFIG_ETH_DESIGNWARE=3Dy
> =C2=A0CONFIG_GMAC_ROCKCHIP=3Dy
> =C2=A0CONFIG_NVME_PCI=3Dy
> @@ -54,9 +73,11 @@ CONFIG_REGULATOR_PWM=3Dy
> =C2=A0CONFIG_REGULATOR_RK8XX=3Dy
> =C2=A0CONFIG_PWM_ROCKCHIP=3Dy
> =C2=A0CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
> +CONFIG_SCSI=3Dy
> =C2=A0CONFIG_BAUDRATE=3D1500000
> =C2=A0CONFIG_DEBUG_UART_SHIFT=3D2
> =C2=A0CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_ROCKCHIP_SPI=3Dy
> =C2=A0CONFIG_SYSRESET=3Dy
> =C2=A0CONFIG_USB=3Dy
> =C2=A0CONFIG_USB_XHCI_HCD=3Dy
> @@ -77,7 +98,6 @@ CONFIG_VIDEO=3Dy
> =C2=A0CONFIG_DISPLAY=3Dy
> =C2=A0CONFIG_VIDEO_ROCKCHIP=3Dy
> =C2=A0CONFIG_DISPLAY_ROCKCHIP_HDMI=3Dy
> -CONFIG_SPL_TINY_MEMSET=3Dy
> =C2=A0CONFIG_ERRNO_STR=3Dy
> =C2=A0CONFIG_EFI_CAPSULE_ON_DISK=3Dy
> =C2=A0CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy
