Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F30CCD98C5
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 811A784704;
	Tue,  9 Jun 2026 18:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kN8rX4bL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA255848A2; Tue,  9 Jun 2026 18:18:26 +0200 (CEST)
Received: from mail-m25474.xmail.ntesmail.com (mail-m25474.xmail.ntesmail.com
 [103.129.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD44B8466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from smtpclient.apple (unknown [59.56.83.5])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41b4ba60a;
 Wed, 10 Jun 2026 00:18:18 +0800 (GMT+08:00)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH V3] board: rockchip: add Anbernic RG-DS
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260510211713.68312-1-macroalpha82@gmail.com>
Date: Wed, 10 Jun 2026 00:18:07 +0800
Cc: u-boot@lists.denx.de, jonas@kwiboo.se, quentin.schulz@cherry.de,
 trini@konsulko.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C0B9EB8-A40C-4EFF-9057-F4216ACE5665@rock-chips.com>
References: <20260510211713.68312-1-macroalpha82@gmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-HM-Tid: 0a9ead2d756609cckunm371e1b3f43f64f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ09IVk5KTkIdSktOGhoeHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVOWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
 9IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=kN8rX4bLVkUIA8v10tyfM6hqVya1pOv0pIyGV9dWtWf6catDmr8JaXFUuTLE5ap9Jjs/+jFo3j7I62z8mQq0uloGKM6L34sV4CDjLhon4l2LT94nFb3t0J+1mVgyUnBx409XUjgsCJ/i4k2+16yJy8ElfULDHr1skP9xzrtSt6I=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=T/PQKOZRBz2RUBb8nScQGmiaeJN8GkgpHZU8nGjIK/8=;
 h=date:mime-version:subject:message-id:from;
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

Hi Chris,


> 2026=E5=B9=B45=E6=9C=8811=E6=97=A5 05:17=EF=BC=8CChris Morgan =
<macroalpha82@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add support for the Anbernic RG-DS dual-screen handheld gaming device.
>=20
> Link: https://anbernic.com/products/rgds
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
> Changes since V1:
> - Added entry to doc/board/rockchip/rockchip.rst.
> - Removed &sdhci and added &vccio_sd to u-boot device tree.
> - Added rk3568 to board path.
> - Corrected defconfig and include files in MAINTAINERS.
> - Removed CONFIG_EFI_LOADER, CONFIG_LEGACY_IMAGE_FORMAT, and
>   CONFIG_DISABLE_CONSOLE from defconfig.
> Changes since V2:
> - Removed "clock-names" from CONFIG_OF_SPL_REMOVE_PROPS as after
>   testing it appears it's no longer needed.
> - Changed include to use rk3568-u-boot.dtsi instead of
>   rk356x-u-boot.dtsi.
> - Changed from CONFIG_NO_NET=3Dy to "#CONFIG_NET is not set".
> ---
> .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 +++++++++++
> arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
> board/anbernic/rg-ds_rk3568/Kconfig           | 12 +++
> board/anbernic/rg-ds_rk3568/MAINTAINERS       |  7 ++
> configs/anbernic-rg-ds-rk3568_defconfig       | 73 +++++++++++++++++++
> doc/board/rockchip/rockchip.rst               |  1 +
> include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
> 7 files changed, 153 insertions(+)
> create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> create mode 100644 board/anbernic/rg-ds_rk3568/Kconfig
> create mode 100644 board/anbernic/rg-ds_rk3568/MAINTAINERS
> create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
> create mode 100644 include/configs/anbernic-rg-ds-rk3568.h
>=20
> diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi =
b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> new file mode 100644
> index 00000000000..7944610827f
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3568-u-boot.dtsi"
> +
> +&gpio0 {
> + bootph-pre-ram;
> +};
> +
> +&i2c0 {
> + bootph-pre-ram;
> +};
> +
> +&i2c0_xfer {
> + bootph-pre-ram;
> +};
> +
> +&i2s1m0_mclk {
> + bootph-pre-ram;
> +};
> +
> +&pmic_int_l {
> + bootph-pre-ram;
> +};
> +
> +&rk817 {
> + regulators {
> + bootph-pre-ram;
> + };
> +};
> +
> +&sdmmc_pwren_l {
> + bootph-pre-ram;
> +};
> +
> +&vcc3v3_sd {
> + bootph-pre-ram;
> +};
> +
> +&vccio_sd {
> + bootph-pre-ram;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig =
b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 2730220a18e..ec22898137e 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -8,6 +8,12 @@ config TARGET_EVB_RK3568
> help
>  RK3568 EVB is a evaluation board for Rockchp RK3568.
>=20
> +config TARGET_ANBERNIC_RG_DS_RK3568
> + bool "Anbernic RG DS"
> + help
> +  Anbernic RG DS gaming device with Rockchip RK3568 and dual
> +  displays.
> +
> config TARGET_ANBERNIC_RGXX3_RK3566
> bool "Anbernic RGXX3"
> help
> @@ -71,6 +77,7 @@ config SYS_SOC
> default "rk3568"
>=20
> source "board/rockchip/evb_rk3568/Kconfig"
> +source "board/anbernic/rg-ds_rk3568/Kconfig"
> source "board/anbernic/rgxx3_rk3566/Kconfig"
> source "board/hardkernel/odroid_m1/Kconfig"
> source "board/hardkernel/odroid_m1s/Kconfig"
> diff --git a/board/anbernic/rg-ds_rk3568/Kconfig =
b/board/anbernic/rg-ds_rk3568/Kconfig
> new file mode 100644
> index 00000000000..8676940651a
> --- /dev/null
> +++ b/board/anbernic/rg-ds_rk3568/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_RG_DS_RK3568

This should be TARGET_ANBERNIC_RGXX3_RK3566 ?

Thanks,
- Kever
> +
> +config SYS_BOARD
> + default "rg-ds_rk3568"
> +
> +config SYS_VENDOR
> + default "anbernic"
> +
> +config SYS_CONFIG_NAME
> + default "anbernic-rg-ds-rk3568"
> +
> +endif
> diff --git a/board/anbernic/rg-ds_rk3568/MAINTAINERS =
b/board/anbernic/rg-ds_rk3568/MAINTAINERS
> new file mode 100644
> index 00000000000..7b9b546f7bc
> --- /dev/null
> +++ b/board/anbernic/rg-ds_rk3568/MAINTAINERS
> @@ -0,0 +1,7 @@
> +ANBERNIC-RG-DS-RK3568
> +M: Chris Morgan <macromorgan@hotmail.com>
> +S: Maintained
> +F: arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> +F: board/anbernic/rg-ds_rk3568
> +F: configs/anbernic-rg-ds-rk3568_defconfig
> +F: include/configs/anbernic-rg-ds-rk3568.h
> diff --git a/configs/anbernic-rg-ds-rk3568_defconfig =
b/configs/anbernic-rg-ds-rk3568_defconfig
> new file mode 100644
> index 00000000000..399a216a7c9
> --- /dev/null
> +++ b/configs/anbernic-rg-ds-rk3568_defconfig
> @@ -0,0 +1,73 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> +CONFIG_COUNTER_FREQUENCY=3D24000000
> +CONFIG_ARCH_ROCKCHIP=3Dy
> +CONFIG_SPL_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3568-anbernic-rg-ds"
> +CONFIG_ROCKCHIP_RK3568=3Dy
> +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=3Dy
> +CONFIG_SPL_SERIAL=3Dy
> +CONFIG_TARGET_ANBERNIC_RG_DS_RK3568=3Dy
> +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> +CONFIG_DEBUG_UART_BASE=3D0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_FIT_VERBOSE=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
> +CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
> +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3568-anbernic-rg-ds.dtb"
> +# CONFIG_CONSOLE_MUX is not set
> +CONFIG_BOARD_TYPES=3Dy
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> +CONFIG_BOARD_RNG_SEED=3Dy
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_POWER=3Dy
> +CONFIG_SPL_ATF=3Dy
> +CONFIG_CMD_PWM=3Dy
> +CONFIG_CMD_GPT=3Dy
> +CONFIG_CMD_MMC=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_CMD_CLS is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=3Dy
> +CONFIG_OF_LIVE=3Dy
> +CONFIG_OF_LIST=3D"rockchip/rk3568-anbernic-rg-ds"
> +CONFIG_OF_SPL_REMOVE_PROPS=3D"interrupt-parent assigned-clocks =
assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
> +# CONFIG_NET is not set
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> +CONFIG_SPL_REGMAP=3Dy
> +CONFIG_SPL_SYSCON=3Dy
> +CONFIG_SPL_ADC=3Dy
> +CONFIG_SPL_CLK=3Dy
> +CONFIG_ROCKCHIP_GPIO=3Dy
> +CONFIG_SYS_I2C_ROCKCHIP=3Dy
> +CONFIG_MISC=3Dy
> +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_DW=3Dy
> +CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_SDMA=3Dy
> +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> +CONFIG_SPL_PINCTRL=3Dy
> +CONFIG_DM_PMIC=3Dy
> +CONFIG_DM_PMIC_FAN53555=3Dy
> +CONFIG_PMIC_RK8XX=3Dy
> +CONFIG_SPL_DM_REGULATOR=3Dy
> +CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> +CONFIG_REGULATOR_RK8XX=3Dy
> +CONFIG_PWM_ROCKCHIP=3Dy
> +CONFIG_SPL_RAM=3Dy
> +# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +CONFIG_BAUDRATE=3D1500000
> +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> +CONFIG_DEBUG_UART_SHIFT=3D2
> +CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_SYSRESET=3Dy
> +CONFIG_REGEX=3Dy
> +# CONFIG_RSA is not set
> +CONFIG_ERRNO_STR=3Dy
> diff --git a/doc/board/rockchip/rockchip.rst =
b/doc/board/rockchip/rockchip.rst
> index 141071f528a..faccba4289b 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -126,6 +126,7 @@ List of mainline supported Rockchip boards:
>      - Xunlong Orange Pi 3B (orangepi-3b-rk3566)
>=20
> * rk3568
> +     - Anbernic RG-DS (anbernic-rg-ds-rk3568)
>      - Rockchip Evb-RK3568 (evb-rk3568)
>      - Banana Pi BPI-R2 Pro (bpi-r2-pro-rk3568)
>      - EmbedFire LubanCat 2 (lubancat-2-rk3568)
> diff --git a/include/configs/anbernic-rg-ds-rk3568.h =
b/include/configs/anbernic-rg-ds-rk3568.h
> new file mode 100644
> index 00000000000..3c5bed952ef
> --- /dev/null
> +++ b/include/configs/anbernic-rg-ds-rk3568.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ANBERNIC_RG_DS_RK3568_H
> +#define __ANBERNIC_RG_DS_RK3568_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> + "stdout=3Dserial,vidconsole\0" \
> + "stderr=3Dserial,vidconsole\0"
> +
> +#include <configs/rk3568_common.h>
> +
> +#endif
> --=20
> 2.43.0
>=20
>=20
>=20

