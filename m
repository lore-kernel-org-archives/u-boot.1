Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD9BC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D817487AA3;
	Wed, 25 Oct 2023 14:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lEZ9ALMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A7A87056; Wed, 25 Oct 2023 10:55:49 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6305A86FE7
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32dbbf3c782so341773f8f.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698224144; x=1698828944; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahCdvaEVZOJ+eBYogd2JCqfSE01EVQodpRg3men/xkU=;
 b=lEZ9ALMJ5Y8okdTGu/B82Eb1CikXWk1YOMh8JH41PCu1sBvcSAMvjNiR77l5a3II/8
 KuprG1UZaboIlHTBvlKwGBG1nGyz6AX3Uia73h1pHeWGSnEnCDLcFKy3FjwSCO++MCBf
 9xZJ44OlnCWjddSBwtkKdwnEOEAJShvczQGs/6mCO7u/KgIHN5gg5/5diGWgBsoQiX12
 fBKoZBvKs1NOzt3VkTel/tmb4kLOBc6Ve3+o8fOWI8piO/O6O/O8cLLlTp+qsZoGy510
 wVtbpnDakbL802guI5S11yNHWkiIulPF5m3JGi1M4HFmVtRRMJMYrx0uu78r8h0L6q3k
 Ik/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698224144; x=1698828944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahCdvaEVZOJ+eBYogd2JCqfSE01EVQodpRg3men/xkU=;
 b=qcFgJp67iTrizhTOVsaPoa2hjmSprRkAALtQujYUhVcCqlv8wehxTPTB+mGKQ6lbzp
 zDMQG4TXhKbSAtVWnW25HPcEYxue6Vrqndl5YyZLLsYE5UdR57Tn5OukxqMCt1sBUO1V
 QzAwuLEbN5UaXwg9bfbENMvB4QZzw0nGrBfBJlSND/+nPPuvveBmbPknb9mzMJ9Eal4s
 nE9h/9RHgzfMeSFMXtpeqHOI8zpT0zgUzbvuz+cx4cdLN7IOYJfDY7hRSJpo1sq+RUra
 3E0Sn+9mBYsaejPoqawzGEhOIlM1M2n5C7EW7YrmKcJhu8cUh5qkRzWxx+6uM26LMwc4
 vXHA==
X-Gm-Message-State: AOJu0YyV9O/ZfGJHcawxERQnY8ZDV/QrQSGTU1n1xNUfLZus9dawz6Re
 CVRUOFTlXbBmkOSVaH0/jJlsx21M760ZPFlPwEA=
X-Google-Smtp-Source: AGHT+IFnLwvRXUGYHH6JQWRZsEgj1hmmxgf+EfJlGpKvLkRsQHJY/nstkfQoKfMDbT229QpL8+wnPmr+MaxTtd6UZKU=
X-Received: by 2002:a05:6000:716:b0:32d:92fc:a625 with SMTP id
 bs22-20020a056000071600b0032d92fca625mr19071026wrb.24.1698224144022; Wed, 25
 Oct 2023 01:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
In-Reply-To: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 25 Oct 2023 11:55:32 +0300
Message-ID: <CAPVz0n1R+MF2s-d9z9P5h9xZ_ehunhDU2PvtkvHfF22HjOYt-A@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Remove all default n/no options
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, takahiro.akashi@linaro.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>, 
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chris Packham <judge.packham@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Gaurav Jain <gaurav.jain@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Huan Wang <alison.wang@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Qu Wenruo <wqu@suse.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Roger Knecht <rknecht@pm.me>, 
 Roger Quadros <rogerq@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Stefano Babic <sbabic@denx.de>, Tobias Waldekranz <tobias@waldekranz.com>,
 Tom Warren <twarren@nvidia.com>, 
 Vignesh R <vigneshr@ti.com>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 25 Oct 2023 14:27:29 +0200
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

=D1=81=D1=80, 25 =D0=B6=D0=BE=D0=B2=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 10:2=
5 Michal Simek <michal.simek@amd.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Similar change was done by commit b4c2c151b14b ("Kconfig: Remove all
> default n/no options") and again sync is required.
>
> default n/no doesn't need to be specified. It is default option anyway.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/arm/mach-imx/mxs/Kconfig      | 2 --
>  arch/arm/mach-rockchip/Kconfig     | 1 -
>  arch/arm/mach-snapdragon/Kconfig   | 1 -
>  arch/arm/mach-sunxi/Kconfig        | 1 -
>  arch/arm/mach-tegra/Kconfig        | 1 -
>  arch/m68k/Kconfig                  | 1 -
>  arch/riscv/Kconfig                 | 1 -
>  board/asus/grouper/Kconfig         | 2 --
>  board/asus/transformer-t30/Kconfig | 1 -
>  board/keymile/Kconfig              | 3 ---
>  board/lg/x3-t30/Kconfig            | 2 --
>  cmd/Kconfig                        | 3 ---
>  drivers/crypto/fsl/Kconfig         | 1 -
>  drivers/memory/Kconfig             | 1 -
>  drivers/misc/Kconfig               | 1 -
>  drivers/mtd/nand/raw/Kconfig       | 1 -
>  drivers/mtd/spi/Kconfig            | 1 -
>  drivers/sm/Kconfig                 | 1 -
>  drivers/spi/Kconfig                | 1 -
>  drivers/usb/host/Kconfig           | 2 --
>  fs/ubifs/Kconfig                   | 1 -
>  21 files changed, 29 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mxs/Kconfig b/arch/arm/mach-imx/mxs/Kconfi=
g
> index ccce6a78caa2..d2e4205c5ce5 100644
> --- a/arch/arm/mach-imx/mxs/Kconfig
> +++ b/arch/arm/mach-imx/mxs/Kconfig
> @@ -54,7 +54,6 @@ config SYS_SOC
>
>  config SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT
>         bool "Force minimal current draw from VDD5V by MX28 PMU"
> -       default n
>         help
>           After setting this option, the current drawn from VDD5V
>           by the PMU is reduced to zero - the DCDC_BATT is used as
> @@ -62,7 +61,6 @@ config SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT
>
>  config SPL_MXS_PMU_DISABLE_BATT_CHARGE
>         bool "Disable Battery Charging in MX28 PMU"
> -       default n
>
>  config SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR
>         bool "Enable the 4P2 linear regulator in MX28 PMU"
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kcon=
fig
> index c43c185c17c5..a6c69c300d00 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -450,7 +450,6 @@ config ROCKCHIP_BOOT_MODE_REG
>  config ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
>         bool "Disable device boot on power plug-in"
>         depends on PMIC_RK8XX
> -       default n
>         ---help---
>           Say Y here to prevent the device from booting up because of a p=
lug-in
>           event. When set, the device will boot briefly to determine why =
it was
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index 0e073045be54..2fc1521e2d30 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -14,7 +14,6 @@ config SPL_SYS_MALLOC_F_LEN
>
>  config SDM845
>         bool "Qualcomm Snapdragon 845 SoC"
> -       default n
>         select LINUX_KERNEL_IMAGE_HEADER
>
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 40ca7d7b3a99..a10e4c06b6a3 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -811,7 +811,6 @@ config AXP_GPIO
>  config AXP_DISABLE_BOOT_ON_POWERON
>         bool "Disable device boot on power plug-in"
>         depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818=
_POWER
> -       default n
>         ---help---
>           Say Y here to prevent the device from booting up because of a p=
lug-in
>           event. When set, the device will boot into the SPL briefly to
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 464bd0798f62..0e94b84fe657 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -18,7 +18,6 @@ config TEGRA_CLKRST
>  config TEGRA_CRYPTO
>         bool "Tegra AES128 crypto module"
>         select AES
> -       default n
>
>  config TEGRA_GP_PADCTRL
>         bool
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 587edd50d7e8..b288c65e7fd1 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -200,7 +200,6 @@ source "board/sysam/stmark2/Kconfig"
>
>  config M68K_QEMU
>         bool "Build with workarounds for incomplete QEMU emulation"
> -       default n
>         help
>           QEMU 8.x currently does not implement RAMBAR accesses and
>           DMA timers. Enable this option for U-Boot CI purposes only
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e291456530bd..8fc81fb284cd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,7 +68,6 @@ config SPL_SYS_DCACHE_OFF
>  config SPL_ZERO_MEM_BEFORE_USE
>         bool "Zero memory before use"
>         depends on SPL
> -       default n
>         help
>           Zero stack/GD/malloc area in SPL before using them, this is nee=
ded for
>           Sifive core devices that uses L2 cache to store SPL.
> diff --git a/board/asus/grouper/Kconfig b/board/asus/grouper/Kconfig
> index 912c6c5fbae8..47d9bae94682 100644
> --- a/board/asus/grouper/Kconfig
> +++ b/board/asus/grouper/Kconfig
> @@ -12,11 +12,9 @@ config SYS_CONFIG_NAME
>  config GROUPER_TPS65911
>         bool "Enable support TI TPS65911 PMIC"
>         select CMD_POWEROFF
> -       default n
>
>  config GROUPER_MAX77663
>         bool "Enable support MAXIM MAX77663 PMIC"
>         select CMD_POWEROFF
> -       default n
>
>  endif
> diff --git a/board/asus/transformer-t30/Kconfig b/board/asus/transformer-=
t30/Kconfig
> index 3c36f4ada206..accc999c435c 100644
> --- a/board/asus/transformer-t30/Kconfig
> +++ b/board/asus/transformer-t30/Kconfig
> @@ -14,7 +14,6 @@ config TRANSFORMER_SPI_BOOT
>         select TEGRA20_SLINK
>         select DM_SPI_FLASH
>         select SPI_FLASH_WINBOND
> -       default n
>         help
>           Tegra 3 based Transformers with Windows RT have core
>           boot sequence (BCT and EBT) on separate SPI FLASH
> diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
> index c6576aa6523a..f7e9b74f5782 100644
> --- a/board/keymile/Kconfig
> +++ b/board/keymile/Kconfig
> @@ -125,7 +125,6 @@ config SYS_IVM_EEPROM_PAGE_LEN
>  config PG_WCOM_UBOOT_UPDATE_SUPPORTED
>         bool "Enable U-Boot Field Fail-Safe Update Functionality"
>         select EVENT
> -       default n
>         help
>           Indicates that field fail-safe u-boot update is supported.
>           This functionality works only for designs that are booting
> @@ -133,7 +132,6 @@ config PG_WCOM_UBOOT_UPDATE_SUPPORTED
>
>  config PG_WCOM_UBOOT_BOOTPACKAGE
>         bool "U-Boot Is Part Of Factory Boot-Package Image"
> -       default n
>         help
>           Indicates that u-boot will be a part of the factory programmed
>           boot-package image.
> @@ -149,7 +147,6 @@ config PG_WCOM_UBOOT_UPDATE_TEXT_BASE
>
>  config PG_WCOM_UBOOT_UPDATE
>         bool "U-Boot Is Part Of Factory Boot-Package Image"
> -       default n
>         help
>           Indicates that u-boot will be a part of the embedded software a=
nd
>           programmed at field.
> diff --git a/board/lg/x3-t30/Kconfig b/board/lg/x3-t30/Kconfig
> index 20ea4f5f3243..53d776019d65 100644
> --- a/board/lg/x3-t30/Kconfig
> +++ b/board/lg/x3-t30/Kconfig
> @@ -11,14 +11,12 @@ config SYS_CONFIG_NAME
>
>  config DEVICE_P880
>         bool "Enable support for LG Optimus 4X HD"
> -       default n
>         help
>           LG Optimus 4X HD derives from x3 board but has slight
>           differences.
>
>  config DEVICE_P895
>         bool "Enable support for LG Optimus Vu"
> -       default n
>         help
>           LG Optimus Vu derives from x3 board but has slight
>           differences.
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 205df2f1fb65..60aed2c307ca 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -246,7 +246,6 @@ config CMD_BOOTM_PRE_LOAD
>         bool "enable pre-load on bootm"
>         depends on CMD_BOOTM
>         depends on IMAGE_PRE_LOAD
> -       default n
>         help
>           Enable support of stage pre-load for the bootm command.
>          This stage allow to check or modify the image provided
> @@ -2360,7 +2359,6 @@ config CMD_VIDCONSOLE
>  config CMD_SELECT_FONT
>         bool "select font size"
>         depends on VIDEO
> -       default n
>         help
>           Enabling this will provide 'font' command.
>           Allows font selection at runtime.
> @@ -2880,7 +2878,6 @@ config CMD_UBIFS
>  config MMC_SPEED_MODE_SET
>         bool "set speed mode using mmc command"
>         depends on CMD_MMC
> -       default n
>         help
>           Enable setting speed mode using mmc rescan and mmc dev commands=
.
>           The speed mode is provided as the last argument in these comman=
ds
> diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
> index 91a51cc5fe77..eaad19633f1d 100644
> --- a/drivers/crypto/fsl/Kconfig
> +++ b/drivers/crypto/fsl/Kconfig
> @@ -77,7 +77,6 @@ endif
>  config FSL_DCP_RNG
>         bool "Enable Random Number Generator support"
>         depends on DM_RNG
> -       default n
>         help
>           Enable support for the hardware based random number generator
>           module of the DCP. It uses the True Random Number Generator (TR=
NG)
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 22cb9d637c5e..d10edd277467 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -61,7 +61,6 @@ config TI_GPMC
>  if TI_GPMC
>  config TI_GPMC_DEBUG
>         bool "Debug Texas Instruments GPMC timings"
> -       default n
>         help
>           Enable this to print GPMC timings before and after the GPMC reg=
isters
>           are programmed. This should not be left enabled on production s=
ystems.
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fccd9b89b81b..97057de8bf92 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -375,7 +375,6 @@ config SPL_MXC_OCOTP
>  config NPCM_OTP
>         bool "Nnvoton NPCM BMC On-Chip OTP Memory Support"
>         depends on (ARM && ARCH_NPCM)
> -       default n
>         help
>           Support NPCM BMC OTP memory (fuse).
>           To compile this driver as a module, choose M here: the module
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 72547f00fbec..a13e6f59cbd2 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -614,7 +614,6 @@ config ROCKCHIP_NAND
>  config ROCKCHIP_NAND_SKIP_BBTSCAN
>         bool "Skip the automatic BBT scan with Rockchip NAND controllers"
>         depends on ROCKCHIP_NAND
> -       default n
>         help
>           Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN
>           option when data content is not in MTD format or
> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> index a9617c6c58c1..76c424d75e9e 100644
> --- a/drivers/mtd/spi/Kconfig
> +++ b/drivers/mtd/spi/Kconfig
> @@ -107,7 +107,6 @@ config SPI_FLASH_SMART_HWCAPS
>
>  config SPI_NOR_BOOT_SOFT_RESET_EXT_INVERT
>         bool "Command extension type is INVERT for Software Reset on boot=
"
> -       default n
>         help
>          Because of SFDP information can not be get before boot.
>          So define command extension type is INVERT when Software Reset o=
n boot only.
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> index f0987275d265..926af2863308 100644
> --- a/drivers/sm/Kconfig
> +++ b/drivers/sm/Kconfig
> @@ -4,6 +4,5 @@ config SM
>  config MESON_SM
>         bool "Amlogic Secure Monitor driver"
>         select SM
> -       default n
>         help
>           Say y here to enable the Amlogic secure monitor driver.
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 854b8b88daff..d1867c28758a 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -451,7 +451,6 @@ config SANDBOX_SPI_MAX_CS
>  config SPI_ASPEED_SMC
>         bool "ASPEED SPI flash controller driver"
>         depends on DM_SPI && SPI_MEM
> -       default n
>         help
>           Enable ASPEED SPI flash controller driver for AST2500
>           and AST2600 SoCs.
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 1a883babf4c2..b501ea514bca 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -231,7 +231,6 @@ config USB_EHCI_MXS
>  config USB_EHCI_NPCM
>         bool "Support for Nuvoton NPCM on-chip EHCI USB controller"
>         depends on ARCH_NPCM
> -       default n
>         ---help---
>           Enables support for the on-chip EHCI controller on
>           Nuvoton NPCM chips.
> @@ -368,7 +367,6 @@ config USB_OHCI_DA8XX
>  config USB_OHCI_NPCM
>         bool "Support for Nuvoton NPCM on-chip OHCI USB controller"
>         depends on ARCH_NPCM
> -       default n
>         ---help---
>           Enables support for the on-chip OHCI controller on
>           Nuvoton NPCM chips.
> diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
> index 949b28841194..690e77ef8dcf 100644
> --- a/fs/ubifs/Kconfig
> +++ b/fs/ubifs/Kconfig
> @@ -8,7 +8,6 @@ config UBIFS_SILENCE_MSG
>  config UBIFS_SILENCE_DEBUG_DUMP
>         bool "UBIFS silence debug dumps"
>         default y if UBIFS_SILENCE_MSG
> -       default n
>         help
>           Make the debug dumps from UBIFS stop printing.
>           This decreases size of U-Boot binary.
> --
> 2.36.1
>

Hello Michal!
I ran tests for all Tegra boards and checked specifically grouper,
tf_t30 and lg_x3.
So far no issues. Thanks

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # tegra
