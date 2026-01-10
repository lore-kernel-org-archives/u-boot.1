Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE95D25023
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 22:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D76883A5A;
	Sat, 10 Jan 2026 23:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lkVIfl9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30A983B0D; Sat, 10 Jan 2026 23:13:39 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5DE839DF
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 23:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so59146755e9.1
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768083217; x=1768688017; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DGsHTu2nqFZ1vQM0WFQYRahz1UWwbT+uJrYbVDVnkFE=;
 b=lkVIfl9wAZoC58IIpgz2o5L5s4dK1MxCd+1xJ8V6Bx+WoVLkpebrUn9aby9NGfjY5V
 Nd1PnUANdSDt69Z5LnYZvIXwBD16fGzGM/5iF2nL5tdjcY5LC5U68jjVaQmmV5HsinTH
 EGbWb8CoPTBWpvn2aPqpJIekWZql2wc8iONoOvRlQbAf4kBEp0EOqWt+0kl5hK3nqXqe
 QZr206RL6HzshkYuD4N1CvdOzc8d6CdNIQgyu1ExMLR5Cd0Pvkc6nRZHWmR7q4Xg/caD
 WQNV9jXFSCKpi46OKbRyJxOc0Ski+EzGNT0U8CLXk8WsSip9zSCrVWT1eeTNI47/WDCK
 P/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768083217; x=1768688017;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DGsHTu2nqFZ1vQM0WFQYRahz1UWwbT+uJrYbVDVnkFE=;
 b=GVwjfmByr+vFLS+XV8xO+kXEf9d2jKy5V8cvog/Jl/XuCQv7gznwTwybJuFAIwOj/K
 ZxZj4RDXiErDxCGcOQ5J28NZPdu5Mi2pltBIoTtjdutvmPENjquu7e6t7oy1LyzI7MV0
 zi47p1sREROUqBatMzTuDKXeKjlLTaAJNj1iD8LAf2F1D8XBrCgExuQNiAkyirSsqtju
 FMIzUoAsdoQGLl9zkKIxS1A28FdokJmEMdr0xq8w5IzsUlbOY3QeMGwlZzY6o/xFhZRB
 EfsIRO7vUnRI0LZdxf6XHxuxv3PXCryX6Me8XFreGIpx+uGN82P/GdJpX9bD3LzGuxd5
 Up6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlF8LGDZqcnzv6oFKvK+Y2adL/NlW/pyS2DhRKyjEwOB38LYDv1CEXkWLU6RAs/CLanCFEquM=@lists.denx.de
X-Gm-Message-State: AOJu0YyDIeAXCsw24TBBpjXhE/sxBLJ2N1fiKteJ5EvA55ZsT1lhZz4D
 CsiuCtKsajUmLvSUwoHl6bZp2kTaQWyPUGClCoP3eAfVuwI9XC2xOZppmz933NxvdAU=
X-Gm-Gg: AY/fxX40DQ9TS7KJk/ZHtHVP8ZkDUS0cNavXKtFzYyegtFV9Tjk9ICGOqs2EYzlfISM
 oYvvOnEh64KNALAs1qH9CByVTy9JvfoUZ7OjGL+y37LTrOlVU9dCk14H5cwpNFcvXBwn2iU489d
 IIhI+SoZUaB9YvcYmnKq6u7O6D7voLXFm2kQ/jKMG0YgDj1wIqSD2HfNmHAUpuiJ7Vv3SZ40ulq
 quOi00jtcX/QSBUhdNIHh8HXsZCmbNp1hsUWECxLBnJ5c7umgWBG1zFzrypSYlZ9Ao2apJqNCwu
 3E7zcTVGxaTqpH8ScqnyfrzB/P34cZNddsP35VfwHblzsiJUnexqRr5dRcVkE2RcBRZ1yOceC9x
 IATE4UxMEM5O/qkmaAL45ZDOTFapBvbHKwcEPu/L82JJdmnwQCMwUO54X38moLpFK2A4Q0OBtP3
 gb26mcJ/0PIROA5Fp3oH7HWXhGujgW5vjOJnqj34gmCEIjqAqjxBkpBZE7t0V3GPBdyrS2/Jyt3
 kQ5wUzLWz3IFA==
X-Google-Smtp-Source: AGHT+IEvFlnvQMCxI+hgkCyoSIT0qZpHz+R0epssXeL3Drwirh25ziM0RlOuN2JIg5NW8tKALcsNqw==
X-Received: by 2002:a05:600c:1394:b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-47d84b3467emr163672275e9.21.1768083217261; 
 Sat, 10 Jan 2026 14:13:37 -0800 (PST)
Received: from [192.168.16.154]
 (host109-150-127-3.range109-150.btcentralplus.com. [109.150.127.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d871a1e11sm90647245e9.19.2026.01.10.14.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 14:13:36 -0800 (PST)
Message-ID: <509f3d6ff686edcf8e93799f36fe63db89035f65.camel@linaro.org>
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi Zero2
From: Christopher Obbard <christopher.obbard@linaro.org>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
Date: Sat, 10 Jan 2026 22:13:36 +0000
In-Reply-To: <20260110205337.1242457-1-jonas@kwiboo.se>
References: <20260110205337.1242457-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
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

On Sat, 2026-01-10 at 20:53 +0000, Jonas Karlman wrote:
> The NanoPi Zero2 is a small single board computer developed by
> FriendlyElec, based on the Rockchip RK3528A SoC.
>=20
> Add support for the FriendlyElec NanoPi Zero2 board.
>=20
> Features tested on a FriendlyElec NanoPi Zero2 2407:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - USB host
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 ++++
>  arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
>  configs/nanopi-zero2-rk3528_defconfig        | 64 ++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst              |  1 +
>  4 files changed, 82 insertions(+)
>  create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>  create mode 100644 configs/nanopi-zero2-rk3528_defconfig
>=20
> diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/=
rk3528-nanopi-zero2-u-boot.dtsi
> new file mode 100644
> index 000000000000..3e2fbd81da17
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3528-u-boot.dtsi"
> +
> +&vdd_arm {
> +	regulator-init-microvolt =3D <953000>;
> +};
> +
> +&vdd_logic {
> +	regulator-init-microvolt =3D <900000>;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-ro=
ckchip/rk3528/MAINTAINERS
> index ee840396e8b0..111fe0270dfd 100644
> --- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> @@ -4,6 +4,12 @@ S:	Maintained
>  F:	arch/arm/dts/rk3528-generic*
>  F:	configs/generic-rk3528_defconfig
> =20
> +NANOPI-ZERO2-RK3528
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3528-nanopi-zero2*
> +F:	configs/nanopi-zero2-rk3528_defconfig
> +
>  RADXA-E20C
>  M:	Jonas Karlman <jonas@kwiboo.se>
>  S:	Maintained
> diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2=
-rk3528_defconfig
> new file mode 100644
> index 000000000000..2e54c0ff20a2
> --- /dev/null
> +++ b/configs/nanopi-zero2-rk3528_defconfig
> @@ -0,0 +1,64 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> +CONFIG_COUNTER_FREQUENCY=3D24000000
> +CONFIG_ARCH_ROCKCHIP=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3528-nanopi-zero2"
> +CONFIG_ROCKCHIP_RK3528=3Dy
> +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> +CONFIG_DEBUG_UART_BASE=3D0xFF9F0000
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3528-nanopi-zero2.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_BOARD_RNG_SEED=3Dy
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_CMD_MEMINFO=3Dy
> +CONFIG_CMD_MEMINFO_MAP=3Dy
> +CONFIG_CMD_ADC=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_GPT=3Dy
> +CONFIG_CMD_MISC=3Dy
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_ROCKUSB=3Dy
> +CONFIG_CMD_USB_MASS_STORAGE=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=3Dy
> +CONFIG_CMD_REGULATOR=3Dy
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cloc=
ks assigned-clock-rates assigned-clock-parents"
> +CONFIG_BUTTON=3Dy
> +CONFIG_BUTTON_ADC=3Dy
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=3Dy
> +CONFIG_LED=3Dy
> +CONFIG_LED_GPIO=3Dy
> +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_DW=3Dy
> +CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_SDMA=3Dy
> +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_DWC_ETH_QOS=3Dy
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=3Dy
> +CONFIG_REGULATOR_PWM=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_PWM_ROCKCHIP=3Dy
> +CONFIG_BAUDRATE=3D1500000
> +CONFIG_DEBUG_UART_SHIFT=3D2
> +CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_EHCI_GENERIC=3Dy
> +CONFIG_USB_DWC3=3Dy
> +CONFIG_USB_DWC3_GENERIC=3Dy
> +CONFIG_USB_GADGET=3Dy
> +CONFIG_USB_GADGET_DOWNLOAD=3Dy
> +CONFIG_USB_FUNCTION_ROCKUSB=3Dy
> +CONFIG_ERRNO_STR=3Dy
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchi=
p.rst
> index c1683bfe4212..01659ecc3cbe 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
> =20
>  * rk3528
>       - ArmSoM Sige1 (sige1-rk3528)
> +     - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
>       - Generic RK3528 (generic-rk3528)
>       - Radxa E20C (radxa-e20c-rk3528)
>       - Radxa ROCK 2A/2F (rock-2-rk3528)
