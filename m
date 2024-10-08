Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762E1CF0423
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 21:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C431988F2F;
	Tue,  8 Oct 2024 23:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NoUC0Q+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A203288F57; Tue,  8 Oct 2024 23:34:40 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E8B88EE8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 23:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406e29so7991194a12.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728423278; x=1729028078; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ukuNYGxdICJhYsk+fEfzXc1unQzmAEhiMcwsY0oqt3g=;
 b=NoUC0Q+Absoz5/bhWnEInDIi82WwiugxZWdwB1PhjJwpWSQQlFNuA0PqKRfYUTw0MH
 ZXCQiHFt/RiYK6New7ejBXdihQleGu67MDSK8D5j4/7rKmZaiZq5WK2j7qtEwBvpG8sp
 IcmsWjY6E3Acf/evZ8zOiqBKHd1WHB4n2V2wuvsOmTAwBA0KfD9EA0kBZ7oxvx9kf3Tk
 1vrMsZcUCjPW6vuFxvfkDa7fp0VYr3TYPTxxz8cLmWrcED1bhYlVwqnd9jCir9I8N/p7
 izoC0XlrL1RcZjY9S8wxcG2l2/XVK+unfKDyf89lwyQZVuco4IgcpUiQeumiGqpVqgLn
 d80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728423278; x=1729028078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukuNYGxdICJhYsk+fEfzXc1unQzmAEhiMcwsY0oqt3g=;
 b=j+ywVW+e/cFf/j98lrBu/Fr8wmi8alMn+Skp0t5ijEP641uD1EnNaLjStMkrc1Feev
 mrffpmJjLPKg90ap4e9WqFOiFQmsNKabgwnn9VAaJrMDUAATTETqiDbFQWINknhDqMuh
 bsHlQ1yUpXrvuQnZDwiqs6HUKDvM4WRaK8RQok8zUGwUpIebnljNJdTUP4PdV8y5Suku
 q/oqwBLycdgeFgUBqP7A7DlL1pD5uCm8KwQoDWmOBt8KwoBLLP+5hz2jGhEnpKmZXkZA
 77pMuunKzulOFLWaIaAnTZAMrEjQr0SyJvMIYsfAIL1JPU8VglryrPP3fg5mZRIED6/E
 2aHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMhxNJPn1XrRBUM87eCOlBH1dlPeXPdPvaQm6oUUXfaNSvYzy1u85yVwBjdA5V619xh67Egjc=@lists.denx.de
X-Gm-Message-State: AOJu0YyoLnoI+5tPOyzmWBOAljhQW89YLIeT323+6FA+euMrMaoX2XGq
 ytxUCvAOPZx2YRbxcBmmeblDXbrfgcRygmd1vFMT+HIMEvQddJaxzcoojzNCgffVFI7XoszBFoY
 OTy+inxCvL3dlx+qgL4OcMasDKxc=
X-Google-Smtp-Source: AGHT+IEe/WQ8eik5C27bm+7iMOBt26cmWjH7SFHk4+Ju9ebY3r57j4AA8/SIpD6paZPG7lvHfa4SLjyjbfI0TUj59ME=
X-Received: by 2002:a05:6402:51ca:b0:5c8:95ce:8cc2 with SMTP id
 4fb4d7f45d1cf-5c91d5abbffmr273793a12.16.1728423277646; Tue, 08 Oct 2024
 14:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241008200641.2203023-1-jonas@kwiboo.se>
 <20241008200641.2203023-4-jonas@kwiboo.se>
In-Reply-To: <20241008200641.2203023-4-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 8 Oct 2024 22:34:26 +0100
Message-ID: <CALeDE9OOYvr47s4FxWfS1C-9U+MqMFyHY8mFzw18EoUdWOB5Ww@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] board: rockchip: Add Hardkernel ODROID-M1S
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 8 Oct 2024 at 21:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
>
> Features tested on a ODROID-M1S 8GB rev1.0 20230906:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - PCIe/NVMe
> - USB gadget
> - USB host
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

A couple of small queries below.
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
> v2: Fix clean apply on master branch
> ---
>  arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi |  3 +
>  arch/arm/mach-rockchip/rk3568/Kconfig      |  6 ++
>  board/hardkernel/odroid_m1s/Kconfig        | 12 +++
>  board/hardkernel/odroid_m1s/MAINTAINERS    |  6 ++
>  configs/odroid-m1s-rk3566_defconfig        | 93 ++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst            |  1 +
>  6 files changed, 121 insertions(+)
>  create mode 100644 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
>  create mode 100644 board/hardkernel/odroid_m1s/Kconfig
>  create mode 100644 board/hardkernel/odroid_m1s/MAINTAINERS
>  create mode 100644 configs/odroid-m1s-rk3566_defconfig
>
> diff --git a/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi b/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> new file mode 100644
> index 000000000000..6e8307e3bdf6
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 899cf909fbb9..e646f714c929 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -22,6 +22,11 @@ config TARGET_ODROID_M1_RK3568
>         help
>           Hardkernel ODROID-M1 single board computer with a RK3568B2 SoC.
>
> +config TARGET_ODROID_M1S_RK3566
> +       bool "ODROID-M1S"
> +       help
> +         Hardkernel ODROID-M1S single board computer with a RK3566 SoC.
> +
>  config TARGET_POWKIDDY_X55_RK3566
>         bool "Powkiddy X55"
>         help
> @@ -62,6 +67,7 @@ config TEXT_BASE
>  source "board/rockchip/evb_rk3568/Kconfig"
>  source "board/anbernic/rgxx3_rk3566/Kconfig"
>  source "board/hardkernel/odroid_m1/Kconfig"
> +source "board/hardkernel/odroid_m1s/Kconfig"
>  source "board/pine64/quartz64_rk3566/Kconfig"
>  source "board/powkiddy/x55/Kconfig"
>  source "board/radxa/zero3-rk3566/Kconfig"
> diff --git a/board/hardkernel/odroid_m1s/Kconfig b/board/hardkernel/odroid_m1s/Kconfig
> new file mode 100644
> index 000000000000..5e0d2ca6d08b
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ODROID_M1S_RK3566
> +
> +config SYS_BOARD
> +       default "odroid_m1s"
> +
> +config SYS_VENDOR
> +       default "hardkernel"
> +
> +config SYS_CONFIG_NAME
> +       default "odroid_m1"
> +
> +endif
> diff --git a/board/hardkernel/odroid_m1s/MAINTAINERS b/board/hardkernel/odroid_m1s/MAINTAINERS
> new file mode 100644
> index 000000000000..0c8d11249bff
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/MAINTAINERS
> @@ -0,0 +1,6 @@
> +ODROID-M1S
> +M:     Jonas Karlman <jonas@kwiboo.se>
> +S:     Maintained
> +F:     board/hardkernel/odroid_m1s/
> +F:     configs/odroid-m1s-rk3566_defconfig
> +F:     arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
> new file mode 100644
> index 000000000000..21f4fcb9d7be
> --- /dev/null
> +++ b/configs/odroid-m1s-rk3566_defconfig
> @@ -0,0 +1,93 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-odroid-m1s"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ODROID_M1S_RK3566=y
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
I don't see a SATA connector on the board, is there an addon hat or
similar? Same query for the other AHCI/SCSI options further below.

> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-odroid-m1s.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_INI=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_CRAMFS=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_FS_CRAMFS=y

What's cramfs used for?

> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index a50e3d2b8f38..7b11a2e0a358 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -98,6 +98,7 @@ List of mainline supported Rockchip boards:
>
>  * rk3566
>       - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
> +     - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
>       - Pine64 PineTab2 (pinetab2-rk3566)
>       - Pine64 Quartz64-A Board (quartz64-a-rk3566)
>       - Pine64 Quartz64-B Board (quartz64-b-rk3566)
> --
> 2.46.2
>
