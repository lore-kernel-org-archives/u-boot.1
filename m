Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE19D277C9
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 02:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F1384390;
	Sat, 10 Jan 2026 03:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dA7XGbfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14475843AD; Sat, 10 Jan 2026 03:07:15 +0100 (CET)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FE58436C
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 03:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-122008d3936so2468678c88.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 18:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768010829; x=1768615629; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JdhDK4GKZ757TZXEyA8j2gX6jJpIzkFLAKhgtrwObBQ=;
 b=dA7XGbful7+JKlNLGahqjGx94OXE2dXcdfELHDo7pmE5nfZRsxmp+WmcEDa2cVLw31
 gS9Jd7Ybj8USSem2/B2Itihn8krY9C5YutRDqkzhpEt3hd9FyR+wELjnV3j7dTkndIUN
 dCd0T77DyZSdO3DFiyZv/7zWpo8rso1AV4PQzK7XIiMlare58HlcIWlzWCoXdgxcM7sS
 SCs32ZMoH8l/GW8t0T4hwRMj7b5jaVhEc8ZQgNz7WIXJAmFxiLJEhu2EQqZnVJbzQhrI
 N7VJiTrJ6V4GHUL23VVLnea7DYE31Dry24kyqajnCtln4vRqkREzLx7mPxakOcE0KgrW
 E5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768010829; x=1768615629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdhDK4GKZ757TZXEyA8j2gX6jJpIzkFLAKhgtrwObBQ=;
 b=A2Og0GBv5UtP9ozW6gBSIAiYTvpiH+Rd6lsYkqgMB7dBcl117DdhBX+PXS1gyu8KAx
 z3FHUAjR+2nsWotfg1dQv3FuM22DZ3ZBcQlmWz0G4GeT+cwYEVpNre2HwprJAE+BrJgF
 knF7tq8I/ed8/dQuG3wzqmjothfAKbzoSMKGxrM+lxQSUTy9y5s25JUNuGE6P/vlG1vn
 xohpTDzSe34FoNhYP/aO1THY7L23/HD9bg1I1p19sB/X4HbG8TV4yZeXA/zVicLCWeUG
 99eRmCf2SUJHzaRF2eMJCWoIpd/hEpl2cDN7fEluImWfNSOuhQud1ow5pImgjYpn9LSD
 5u5w==
X-Gm-Message-State: AOJu0Yw0eIrRv5iPDoBxz+Yf25cSG1oMyDawq4vH7iBP2XiqrPV/ev7G
 Vp6Wq+g9rH5X8zyYByIEubk9tI1ZKHpGch0m9kJj1h3QzaXvdqJosvWHSvzRq5onD9td8njJJgs
 HUjMh6cZZDC3wwd+8OMy9VW2JgHscex2ZvtDgYo5mgw==
X-Gm-Gg: AY/fxX4J+o2W8wmxkD2Og/j3uwA8XJ6A4rZLcDr1XsCXcGrg/CvVFHo9NvvWdSJZJ9D
 EOwy1QsTUlx7SOT1ZLjPUtkbo/iURkh/5tkxftWVT7RvggUF5zB13bLTyT8EEjxyWSrNjWG98O7
 7x1pk4pydpYF34cOl/iY/ydWtrRibP+eMgk8P2DWtPoh9tdJGDkBzomo4gqEN4JdnjOiLdsFZC8
 EbWtUmo1+wxUrh42BMl8o92bDWmrFJS25uSrml3WTyk6rvCZV1u3921PPkf/TEASo52swA=
X-Google-Smtp-Source: AGHT+IERwsBiMUXLZhD4Q+6GBVCgX26OreX40wSC6OI4UNYdwk1N0RNS+3k7drv5SbUEhlxTW/75e+Ujj8bubD9yGIw=
X-Received: by 2002:a05:7022:4582:b0:119:e55a:9beb with SMTP id
 a92af1059eb24-121f8afee53mr9830932c88.7.1768010829038; Fri, 09 Jan 2026
 18:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20260110011505.36915-1-naoki@radxa.com>
In-Reply-To: <20260110011505.36915-1-naoki@radxa.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sat, 10 Jan 2026 02:06:56 +0000
X-Gm-Features: AQt7F2pC_Ep40cNRynt4-g8odsPsyX_u2L_2OeLv8Fzdvvb_xBXufxDCFCsUTWQ
Message-ID: <CACr-zFDU5rXh+kWJwOwSck_koy0kNrE+5SDgCOB9muR3AWz4Lg@mail.gmail.com>
Subject: Re: [PATCH] rockchip: Add support for Radxa E52C
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, trini@konsulko.com, jonas@kwiboo.se, 
 heiko@sntech.de, cnsztl@gmail.com, xuhui.lin@rock-chips.com
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

Hi Naoki,

On Sat, 10 Jan 2026 at 01:15, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> The Radxa E52C is a compact network computer developed by Radxa, based
> on the Rockchip RK3582 SoC. [1]
>
> Specification:
> - Dual Cortex-A76 and Quad Cortex-A55 cores
> - 5TOPS NPU
> - Up to 8GB LPDDR4x RAM
> - Up to 64GB eMMC
> - microSD card slot
> - USB 3.0 Type-A OTG port
> - USB Type-C debug port (USB-UART)
> - USB Type-C power port (5V)
> - 2x Gigabit Ethernet ports
> - Maskrom and User buttons
> - Aluminum alloy case
>
> [1] https://dl.radxa.com/e/e52c/radxa_e52c_product_brief.pdf
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
> This patch depends on
>  https://patchwork.ozlabs.org/project/uboot/patch/20260107230747.3552391-2-jonas@kwiboo.se/
> ---
>  arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi | 24 +++++++
>  configs/radxa-e52c-rk3582_defconfig        | 77 ++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst            |  1 +
>  3 files changed, 102 insertions(+)
>  create mode 100644 arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
>  create mode 100644 configs/radxa-e52c-rk3582_defconfig
>
> diff --git a/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> new file mode 100644
> index 00000000000..dd65cdd250f
> --- /dev/null
> +++ b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2026 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +/ {
> +       leds-0 {
> +               led-1 {
> +                       default-state = "on";
> +                       gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               led-2 {
> +                       default-state = "on";
> +                       gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +};
> +
> +&sdhci {
> +       mmc-hs200-1_8v;
> +};
> diff --git a/configs/radxa-e52c-rk3582_defconfig b/configs/radxa-e52c-rk3582_defconfig
> new file mode 100644
> index 00000000000..5c1056867f2
> --- /dev/null
> +++ b/configs/radxa-e52c-rk3582_defconfig
> @@ -0,0 +1,77 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3582-radxa-e52c"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3582-radxa-e52c.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +# CONFIG_ADC is not set
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHYLIB=y
> +CONFIG_RTL8169=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 7a8532b49fc..2fd7d687d2e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -160,6 +160,7 @@ List of mainline supported Rockchip boards:
>       - Khadas Edge2 (khadas-edge2-rk3588s)
>       - MNT Reform2 (mnt-reform2-rk3588)
>       - Pine64 QuartzPro64 (quartzpro64-rk3588)
> +     - Radxa E52C (radxa-e52c-rk3582)
>       - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>       - Radxa ROCK 5A (rock5a-rk3588s)
>       - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)
> --
> 2.43.0
>
