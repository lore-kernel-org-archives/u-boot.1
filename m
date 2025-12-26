Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE414E8FDA7
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 18:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D241983A24;
	Fri, 26 Dec 2025 19:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RAlsre8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAB883A24; Fri, 26 Dec 2025 19:28:59 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AD6838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 19:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so5927407a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 10:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766773735; x=1767378535;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVLGlV7cR/XL5LMCKf6pk77FcIkEJmXqdvbnQ1M9Nug=;
 b=RAlsre8GYDHeCye/qjsGhyasQBvqXrQUZGGX2rGyc6oRzietwuO+Goqd5b0gc+c8uw
 Aa9AXRlCbKGqu/BSbPuLQ4KbMmNzYm8pCUws3oJroJWixeldJpsSbPkPy/++hHMB/P1E
 XwXFk55DEFUY/LcjAWlmEfI+8QuEC4Cmev8Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766773735; x=1767378535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zVLGlV7cR/XL5LMCKf6pk77FcIkEJmXqdvbnQ1M9Nug=;
 b=YRJSIENNkQbECZLQ30w2ZnwBq/7RZ9TnOkFl5fghE9dxkUG0HlMe0ejisbwaMdY2+E
 eIx7jOAzZEnev3iuC6Ef64VernbcV1tWVKG0EV2aJ1uMe5Bvse1oL6gv+GCBIjdsvYM7
 WOMbbSzZYtzpXRlWN3HWcQZ1fgnfraN3M7iVaKXzLAqaAjHU1kjOKyrDaEzenEadPAQG
 PrGrKnfgRD6KYyL74WOJ4ow9mKSpV5CEhX3HxBurxeVqiAXd9ZJZUgbDgjTotjokB1Wb
 P6Dx9R3iWspduDN2NsZXU/JYakoMK3wuDMdPdH/aY/XkwLra2P3Ovn6meZ4fcbjYcZRn
 iAvg==
X-Gm-Message-State: AOJu0YwjgDVDCZkwaH/pAjmzGMIDhghQBXXOkFEDCtyiCGuSjaUymu0e
 kzxhbPYCZS76orQe9SL6YjzIzNyjFpaQjcw8p9jFyqu7QuwMioWzOiVCh1lgCzc4CrQpCeFZOR7
 SRUMlmt2l7tJoYE4Do3cmLwb6wLKQtlYoaKyzxgZBaQ==
X-Gm-Gg: AY/fxX7mIGpiZ0Vp78vl/QrgEVAFMJ6yKjdWpgp/vbfCL5FBUa1+4Nx37TeXcmUt31O
 luKOf/z0Qp9TW2uSy42qDjl7RbneTy0p0Ov12g0C3IW+rsbRiIbLa4nR1BTQZpGSVQ7GMr/Ax5C
 HRGidtoajOm1uhJcvaU8rjZcbQua81xltnZOwJK09xQXzF7ffhAfhp+i8tqBve/BYKJO+XpKV0k
 y5gmnQUFo/7pCLONR2cWSc46dCkcfxSoYSqDTzk7MZSBcQlXbV5d6mNTFfMQzTuNIsESh1gXDtC
 BmKR3Rttr7YbzvfGEC7CUMA=
X-Google-Smtp-Source: AGHT+IFmyqnmLOHr6zm1cKKimP9/JADPVT99YSxEbvJuo04UBfipwKy1ArStI4X63+ElpKImz2e5GVmyFIxi06djXGA=
X-Received: by 2002:a05:7301:90c:b0:2ab:ca55:b763 with SMTP id
 5a478bee46e88-2b05ecd8d70mr19703646eec.42.1766773734737; Fri, 26 Dec 2025
 10:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
In-Reply-To: <20251219202121.4180810-4-trini@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 26 Dec 2025 19:28:43 +0100
X-Gm-Features: AQt7F2oLlo442Qop7OdVKsIYg-xg38gERMfsOmd_cqew1AgUc-RKkxFaVeX3xus
Message-ID: <CAOf5uw=86_NwDM=96Jpz+5o4HDh628KTfhqjJJEmdLNEv55JOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom

On Fri, Dec 19, 2025 at 9:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> The devm alloc functions that we have may follow the Linux kernel model
> where allocations are (almost always) automatically free()'d. However,
> quite often we don't enable, in full U-Boot, the corresponding automatic
> free. This in turn leads to memory leaks. Rather than manually tracking
> allocations and implementing frees, rework things so that we follow
> expectations now and enable the DEVRES functionality to manage frees.
>
> This turns DEVRES from a prompted symbol to a symbol that must be
> select'd, and we now remove our non-managed alloc/free functions from
> outside of xPL builds.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-stm32mp/Kconfig    | 1 +
>  drivers/block/Kconfig            | 1 +
>  drivers/clk/Kconfig              | 1 +
>  drivers/core/Kconfig             | 7 ++++---
>  drivers/dma/ti/Kconfig           | 1 +
>  drivers/firmware/Kconfig         | 1 +
>  drivers/firmware/arm-ffa/Kconfig | 1 +
>  drivers/gpio/Kconfig             | 3 +++
>  drivers/i2c/muxes/Kconfig        | 1 +
>  drivers/i3c/Kconfig              | 1 +
>  drivers/mailbox/Kconfig          | 1 +
>  drivers/mtd/nand/raw/Kconfig     | 5 +++++
>  drivers/mtd/nand/spi/Kconfig     | 1 +
>  drivers/mtd/spi/Kconfig          | 1 +
>  drivers/mux/Kconfig              | 1 +
>  drivers/net/Kconfig              | 3 +++
>  drivers/net/phy/Kconfig          | 2 ++
>  drivers/pci/Kconfig              | 3 +++
>  drivers/phy/Kconfig              | 1 +
>  drivers/pinctrl/Kconfig          | 1 +
>  drivers/pinctrl/mscc/Kconfig     | 1 +
>  drivers/pinctrl/mvebu/Kconfig    | 1 +
>  drivers/pinctrl/renesas/Kconfig  | 1 +
>  drivers/power/regulator/Kconfig  | 1 +
>  drivers/reboot-mode/Kconfig      | 1 +
>  drivers/reset/Kconfig            | 1 +
>  drivers/smem/Kconfig             | 1 +
>  drivers/soc/ti/Kconfig           | 1 +
>  drivers/spi/Kconfig              | 2 ++
>  drivers/usb/cdns3/Kconfig        | 1 +
>  drivers/usb/dwc3/Kconfig         | 1 +
>  drivers/usb/host/Kconfig         | 1 +
>  drivers/video/Kconfig            | 1 +
>  include/dm/devres.h              | 3 ++-
>  34 files changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfi=
g
> index ba4694f29644..2716844b2599 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -170,6 +170,7 @@ config STM32_ECDSA_VERIFY
>
>  config STM32MP_TAMP_NVMEM
>         bool "STM32 TAMP backup registers via NVMEM API"
> +       select DEVRES
>         select NVMEM
>         default y
>         help
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 185da2b5cfc2..461b5a9fc838 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -265,6 +265,7 @@ config SYS_64BIT_LBA
>
>  config RKMTD
>         bool "Rockchip rkmtd virtual block device"
> +       select DEVRES
>         select RANDOM_UUID
>         help
>           Enable "rkmtd" class and driver to create a virtual block devic=
e
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 85cc472b4cb9..ae783254008c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -3,6 +3,7 @@ menu "Clock"
>  config CLK
>         bool "Enable clock driver support"
>         depends on DM
> +       select DEVRES
>         help
>           This allows drivers to be provided for clock generators, includ=
ing
>           oscillators and PLLs. Devices can use a common clock API to req=
uest
> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> index 6b4330fe4ea3..53eaa2da25b9 100644
> --- a/drivers/core/Kconfig
> +++ b/drivers/core/Kconfig
> @@ -197,6 +197,7 @@ config DM_DMA
>  config REGMAP
>         bool "Support register maps"
>         depends on DM
> +       select DEVRES
>         help
>           Hardware peripherals tend to have one or more sets of registers
>           which can be accessed to control the hardware. A register map
> @@ -271,7 +272,7 @@ config VPL_SYSCON
>           assigning a unique number to each.
>
>  config DEVRES
> -       bool "Managed device resources"
> +       bool
>         depends on DM
>         help
>           This option enables the Managed device resources core support.
> @@ -279,8 +280,8 @@ config DEVRES
>           released whether initialization fails half-way or the device ge=
ts
>           detached.
>
> -         If this option is disabled, devres functions fall back to
> -         non-managed variants.  For example, devres_alloc() to kzalloc()=
,
> +         This option is disabled in xPL phases anddevres functions fall =
back

Fix this typo

> +         to non-managed variants.  For example, devres_alloc() to kzallo=
c(),
>           devm_kmalloc() to kmalloc(), etc.
>
>  config DEBUG_DEVRES
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index 87c026e04903..5cec6ddd3e30 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -5,6 +5,7 @@ if ARCH_K3
>  config TI_K3_NAVSS_UDMA
>          bool "Texas Instruments UDMA"
>          depends on ARCH_K3
> +        select DEVRES
>          select DMA
>          select TI_K3_NAVSS_RINGACC
>          select TI_K3_NAVSS_PSILCFG
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index a094e6c3afef..220de7319506 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -16,6 +16,7 @@ config ARM_PSCI_FW
>  config TI_SCI_PROTOCOL
>         tristate "TI System Control Interface (TISCI) Message Protocol"
>         depends on K3_SEC_PROXY
> +       select DEVRES
>         select FIRMWARE
>         select SPL_FIRMWARE if SPL
>         help
> diff --git a/drivers/firmware/arm-ffa/Kconfig b/drivers/firmware/arm-ffa/=
Kconfig
> index d75f8b53fd85..3706a8893059 100644
> --- a/drivers/firmware/arm-ffa/Kconfig
> +++ b/drivers/firmware/arm-ffa/Kconfig
> @@ -6,6 +6,7 @@ config ARM_FFA_TRANSPORT
>         select ARM_SMCCC if !SANDBOX
>         select ARM_SMCCC_FEATURES if !SANDBOX
>         imply CMD_ARMFFA
> +       select DEVRES
>         select LIB_UUID
>         select DEVRES
>         help
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 18ca8ad4caca..60c5c54688e6 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -19,6 +19,7 @@ if GPIO
>  config DM_GPIO
>         bool "Enable Driver Model for GPIO drivers"
>         depends on DM
> +       select DEVRES
>         help
>           Enable driver model for GPIO access. The standard GPIO
>           interface (gpio_get_value(), etc.) is then implemented by
> @@ -151,6 +152,7 @@ config CORTINA_GPIO
>  config DWAPB_GPIO
>         bool "DWAPB GPIO driver"
>         depends on DM && DM_GPIO
> +       select DEVRES
>         help
>           Support for the Designware APB GPIO driver.
>
> @@ -253,6 +255,7 @@ config IMX_RGPIO2P
>
>  config IPROC_GPIO
>         bool "Broadcom iProc GPIO driver(without pinconf)"
> +       select DEVRES
>         help
>           The Broadcom iProc based SoCs- Cygnus, NS2, NS3, NSP and Stingr=
ay,
>           use the same GPIO Controller IP hence this driver could be used
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 65319bb6fd83..3b1220b21056 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -51,6 +51,7 @@ config I2C_MUX_PCA954x
>  config I2C_MUX_GPIO
>          tristate "GPIO-based I2C multiplexer"
>         depends on I2C_MUX && DM_GPIO
> +       select DEVRES
>         help
>           If you say yes to this option, support will be included for
>           a GPIO based I2C multiplexer. This driver provides access to
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index d877a7443538..48341f9b8737 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -1,6 +1,7 @@
>  menuconfig I3C
>         tristate "I3C support"
>         select I2C
> +       select DEVRES
>         help
>           I3C is a serial protocol standardized by the MIPI alliance.
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index cfd2a3be3fd0..f45e611c9662 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -31,6 +31,7 @@ config IMX_MU_MBOX
>  config MPFS_MBOX
>         bool "Enable MPFS system controller support"
>         depends on DM_MAILBOX && ARCH_RV64I
> +       select DEVRES
>         help
>           Enable support for the mailboxes that provide a communication
>           channel with the system controller integrated on PolarFire SoC.
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 5e4d1c0a9378..e0ff28cb21bd 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -51,6 +51,7 @@ config DM_NAND_ATMEL
>         bool "Support Atmel NAND controller with DM support"
>         depends on ARCH_AT91
>         select ATMEL_EBI
> +       select DEVRES
>         select SYS_NAND_SELF_INIT
>         imply SYS_NAND_USE_FLASH_BBT
>         help
> @@ -74,6 +75,7 @@ config ATMEL_NAND_HWECC
>  config ATMEL_NAND_HW_PMECC
>         bool "Atmel Programmable Multibit ECC (PMECC)"
>         select ATMEL_NAND_HWECC
> +       select DEVRES
>         help
>           The Programmable Multibit ECC (PMECC) controller is a programma=
ble
>           binary BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder=
.
> @@ -118,6 +120,7 @@ config NAND_BRCMNAND
>         bool "Support Broadcom NAND controller"
>         depends on OF_CONTROL && DM && DM_MTD
>         depends on ARCH_BCMBCA || ARCH_BMIPS || TARGET_BCMNS || TARGET_BC=
MNS3
> +       select DEVRES
>         select SYS_NAND_SELF_INIT
>         help
>           Enable the driver for NAND flash on platforms using a Broadcom =
NAND
> @@ -197,6 +200,7 @@ config SPL_NAND_LOAD
>  config NAND_CADENCE
>         bool "Support Cadence NAND controller as a DT device"
>         depends on OF_CONTROL && DM_MTD && ARCH_SOCFPGA
> +       select DEVRES
>         select SYS_NAND_SELF_INIT
>         select SPL_SYS_NAND_SELF_INIT
>         select SPL_NAND_BASE
> @@ -211,6 +215,7 @@ config NAND_CADENCE
>
>  config NAND_DENALI
>         bool
> +       select DEVRES
>         select SYS_NAND_SELF_INIT
>         select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64
>         imply CMD_NAND
> diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
> index 0777dfdf0a70..1124dada9506 100644
> --- a/drivers/mtd/nand/spi/Kconfig
> +++ b/drivers/mtd/nand/spi/Kconfig
> @@ -1,6 +1,7 @@
>  menuconfig MTD_SPI_NAND
>         bool "SPI NAND device Support"
>         depends on DM_MTD && DM_SPI
> +       select DEVRES
>         select MTD_NAND_CORE
>         select SPI_MEM
>         help
> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> index ca60a425ba34..a13c7fc60e68 100644
> --- a/drivers/mtd/spi/Kconfig
> +++ b/drivers/mtd/spi/Kconfig
> @@ -3,6 +3,7 @@ menu "SPI Flash Support"
>  config DM_SPI_FLASH
>         bool "Enable Driver Model for SPI flash"
>         depends on DM_SPI
> +       select DEVRES
>         imply SPI_FLASH
>         help
>           Enable driver model for SPI flash. This SPI flash interface
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 2b95eb02177c..de74e5d5e4ed 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -3,6 +3,7 @@ menu "Multiplexer drivers"
>  config MULTIPLEXER
>         bool "Multiplexer Support"
>         depends on DM
> +       select DEVRES
>         help
>          The mux framework is a minimalistic subsystem that handles multi=
plexer
>          controllers. It provides the same API as Linux and mux drivers s=
hould
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index f382a7752d53..13e631c55dc2 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -125,6 +125,7 @@ config AIROHA_ETH
>         bool "Airoha Ethernet QDMA Driver"
>         depends on ARCH_AIROHA
>         select PHYLIB
> +       select DEVRES
>         select DM_RESET
>         select MDIO_MT7531
>         help
> @@ -359,6 +360,7 @@ config ETH_SANDBOX_RAW
>
>  config ETH_DESIGNWARE
>         bool "Synopsys Designware Ethernet MAC"
> +       select DEVRES
>         select PHYLIB
>         imply ETH_DESIGNWARE_SOCFPGA if ARCH_SOCFPGA
>         help
> @@ -555,6 +557,7 @@ config MVNETA
>  config MVPP2
>         bool "Marvell Armada 375/7K/8K network interface support"
>         depends on ARMADA_375 || ARMADA_8K
> +       select DEVRES
>         select PHYLIB
>         select MVMDIO
>         select DM_MDIO
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index d0aab0b8fe87..709f1c91eb2d 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -182,6 +182,7 @@ config PHY_MARVELL
>
>  config PHY_MARVELL_10G
>         bool "Marvell Alaska 10Gbit PHYs"
> +       select DEVRES
>         help
>           Support for the Marvell Alaska MV88X3310 and compatible PHYs.
>
> @@ -245,6 +246,7 @@ config PHY_NATSEMI
>
>  config PHY_NXP_C45_TJA11XX
>         tristate "NXP C45 TJA11XX PHYs"
> +       select DEVRES
>         help
>           Enable support for NXP C45 TJA11XX PHYs.
>           Currently supports only the TJA1103 PHY.
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index ea9868425d04..8fc57895a786 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -131,6 +131,7 @@ config PCIE_APPLE
>         bool "Enable Apple PCIe driver"
>         depends on ARCH_APPLE
>         imply PCI_INIT_R
> +       select DEVRES
>         select SYS_PCI_64BIT
>         default y
>         help
> @@ -264,6 +265,7 @@ config PCI_XILINX
>
>  config PCIE_LAYERSCAPE
>         bool
> +       select DEVRES
>
>  config PCIE_LAYERSCAPE_RC
>         bool "Layerscape PCIe Root Complex mode support"
> @@ -361,6 +363,7 @@ config PCI_KEYSTONE
>  config PCIE_MEDIATEK
>         bool "MediaTek PCIe Gen2 controller"
>         depends on ARCH_MEDIATEK
> +       select DEVRES
>         help
>           Say Y here if you want to enable Gen2 PCIe controller,
>           which could be found on MT7623 SoC family.
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 420d7c7a44dd..87729b479bd9 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -4,6 +4,7 @@ menu "PHY Subsystem"
>  config PHY
>         bool "PHY Core"
>         depends on DM
> +       select DEVRES
>         help
>           PHY support.
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 48119694031d..ea90713ec6ca 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -294,6 +294,7 @@ config PINCTRL_SANDBOX
>  config PINCTRL_SINGLE
>         bool "Single register pin-control and pin-multiplex driver"
>         depends on DM
> +       select DEVRES
>         help
>           This enables pinctrl driver for systems using a single register=
 for
>           pin configuration and multiplexing. TI's AM335X SoCs are exampl=
es of
> diff --git a/drivers/pinctrl/mscc/Kconfig b/drivers/pinctrl/mscc/Kconfig
> index aab67fabd2cd..567c93f404cc 100644
> --- a/drivers/pinctrl/mscc/Kconfig
> +++ b/drivers/pinctrl/mscc/Kconfig
> @@ -2,6 +2,7 @@
>
>  config PINCTRL_MSCC
>         bool
> +       select DEVRES
>
>  config PINCTRL_MSCC_OCELOT
>         depends on SOC_OCELOT && PINCTRL_FULL && OF_CONTROL
> diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfi=
g
> index 7c51d138c8bd..10ba440f246e 100644
> --- a/drivers/pinctrl/mvebu/Kconfig
> +++ b/drivers/pinctrl/mvebu/Kconfig
> @@ -9,6 +9,7 @@ config PINCTRL_ARMADA_38X
>
>  config PINCTRL_ARMADA_37XX
>         depends on ARMADA_3700 && PINCTRL_FULL
> +       select DEVRES
>         bool "Armada 37xx pin control driver"
>         help
>            Support pin multiplexing and pin configuration control on
> diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kc=
onfig
> index ac40b31dbfaa..171da88cfcf4 100644
> --- a/drivers/pinctrl/renesas/Kconfig
> +++ b/drivers/pinctrl/renesas/Kconfig
> @@ -166,6 +166,7 @@ config PINCTRL_RZG2L
>         depends on PINCTRL
>         depends on PINCTRL_GENERIC
>         depends on PINCONF
> +       select DEVRES
>         help
>           Support the pinctrl functionality of the pin function controlle=
r (PFC)
>           on the Renesas RZ/G2L SoC family.
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kc=
onfig
> index 1875e61967c0..a9c82d6d24c2 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -235,6 +235,7 @@ config DM_REGULATOR_GPIO
>  config DM_REGULATOR_QCOM_RPMH
>         bool "Enable driver model for Qualcomm RPMh regulator"
>         depends on DM_REGULATOR && QCOM_RPMH
> +       select DEVRES
>         ---help---
>           Enable support for the Qualcomm RPMh regulator. The driver
>           implements get/set api for a limited set of regulators used
> diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
> index bb5189351881..72b33d712235 100644
> --- a/drivers/reboot-mode/Kconfig
> +++ b/drivers/reboot-mode/Kconfig
> @@ -9,6 +9,7 @@ menu "Reboot Mode Support"
>  config DM_REBOOT_MODE
>         bool "Enable reboot mode using Driver Model"
>         depends on DM
> +       select DEVRES
>         help
>                 Enable support for reboot mode control. This will allow u=
sers to
>                 adjust the boot process based on reboot mode parameter
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 74c267dfc4e5..2fd91d6299cc 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -3,6 +3,7 @@ menu "Reset Controller Support"
>  config DM_RESET
>         bool "Enable reset controllers using Driver Model"
>         depends on DM && OF_CONTROL
> +       select DEVRES
>         help
>           Enable support for the reset controller driver class. Many hard=
ware
>           modules are equipped with a reset signal, typically driven by s=
ome
> diff --git a/drivers/smem/Kconfig b/drivers/smem/Kconfig
> index 73d51b3a7a48..e5d7dcc81b17 100644
> --- a/drivers/smem/Kconfig
> +++ b/drivers/smem/Kconfig
> @@ -16,6 +16,7 @@ config MSM_SMEM
>      bool "Qualcomm Shared Memory Manager (SMEM)"
>      depends on DM
>      depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
> +    select DEVRES
>      help
>        Enable support for the Qualcomm Shared Memory Manager.
>        The driver provides an interface to items in a heap shared among a=
ll
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 0ee21f990488..36129cb72f68 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -8,6 +8,7 @@ if SOC_TI
>  config TI_K3_NAVSS_RINGACC
>         bool "K3 Ring accelerator Sub System"
>         depends on ARCH_K3
> +       select DEVRES
>         select MISC
>         help
>           Say y here to support the K3 AM65x Ring accelerator module.
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index e31db9d4e31b..50d22bf3fc4c 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -35,6 +35,7 @@ config DM_SPI
>
>  config SPI_MEM
>         bool "SPI memory extension"
> +       select DEVRES
>         help
>           Enable this option if you want to enable the SPI memory extensi=
on.
>           This extension is meant to simplify interaction with SPI memori=
es
> @@ -343,6 +344,7 @@ config MT7621_SPI
>  config MTK_SNOR
>         bool "Mediatek SPI-NOR controller driver"
>         depends on SPI_MEM
> +       select DEVRES
>         help
>           Enable the Mediatek SPINOR controller driver. This driver has
>            better read/write performance with NOR.
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index 1d5e4afac6cd..7964f3f41d5e 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -1,6 +1,7 @@
>  config USB_CDNS3
>         tristate "Cadence USB3 Dual-Role Controller"
>         depends on USB_XHCI_HCD || USB_GADGET
> +       select DEVRES
>         help
>           Say Y here if your system has a Cadence USB3 dual-role controll=
er.
>           It supports: Host-only, and Peripheral-only.
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 744dfa90463c..27fcae54b227 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -1,6 +1,7 @@
>  config USB_DWC3
>         bool "DesignWare USB3 DRD Core Support"
>         depends on USB_XHCI_HCD || USB_GADGET
> +       select DEVRES
>         help
>           Say Y here if your system has a Dual Role SuperSpeed
>           USB controller based on the DesignWare USB3 IP Core.
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 99f381db9f9b..54df4264a441 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -367,6 +367,7 @@ config USB_OHCI_GENERIC
>  config USB_OHCI_DA8XX
>         bool "Support for da850 OHCI USB controller"
>         depends on ARCH_DAVINCI
> +       select DEVRES
>         help
>           Enable support for the da850 USB controller.
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index b5777da5218a..2c67d089492c 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -831,6 +831,7 @@ config BACKLIGHT_LM3533
>  config BACKLIGHT_LP855x
>         bool "Backlight Driver for LP855x"
>         depends on BACKLIGHT
> +       select DEVRES
>         select DM_I2C
>         help
>           Say Y to enable the backlight driver for National Semiconductor=
 / TI
> diff --git a/include/dm/devres.h b/include/dm/devres.h
> index 27761deb6d1f..406d18686f4d 100644
> --- a/include/dm/devres.h
> +++ b/include/dm/devres.h
> @@ -207,7 +207,8 @@ void devm_kfree(struct udevice *dev, void *ptr);
>  /* Get basic stats on allocations */
>  void devres_get_stats(const struct udevice *dev, struct devres_stats *st=
ats);
>
> -#else /* ! DEVRES */
> +#elif IS_ENABLED(CONFIG_DEVRES) && defined(CONFIG_XPL_BUILD)
> +/* Allow these to be dummy functions in xPL builds. */
>
>  static inline void *devres_alloc(dr_release_t release, size_t size, gfp_=
t gfp)
>  {

Can you please in the commit message a concrete example on what this
commit takes care of?
In short expand here:
" in full U-Boot, the corresponding automatic free. This in turn leads
to memory leaks."

Michael


> --
> 2.43.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
