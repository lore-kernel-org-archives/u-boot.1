Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5ABC7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9627E8206E;
	Mon, 30 Jun 2025 12:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SwAi7cnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD1882E27; Mon, 30 Jun 2025 12:27:06 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4967881FEE
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0e0271d82so719685566b.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751279224; x=1751884024; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bE5igrjJ2JdIS9InIHt5nub1rRlE9s1MxXwJE6FbNY0=;
 b=SwAi7cnq4w27KihrevEYqw+SxvZjrzWSIQJVvg0N5e43T0pIxpDD5np7AdssrJ3skv
 4yZLV7MpDgdFkqkWUWdSqA19XkgjtIBBxrnCAtd/xdFEYANf1TjvvmyDdNjx8kHlwpjk
 BUf2bPzqNlQdMsMeWvhFm8fGSDluh0KuwUkAxgkDGYdDpsp+/QFrPA2gnWhl+2UhUtsN
 VBx9BzQ8ipnOkK0rmHqoDAJx5qsenYfELwCCR4gdWPoOzkmHhyP3mVh0pnlf4lAW922n
 M6RVsH/YxKl+GHwhIRozqSvS2YzUdM7CQ8ZbYT6+vyyf3GjoV4BxqR9ZUH7lSip0dv7m
 TwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751279224; x=1751884024;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bE5igrjJ2JdIS9InIHt5nub1rRlE9s1MxXwJE6FbNY0=;
 b=mYf/OHMx4aFs7bDjsVgdHvBKVKODO+nZHLUDQDXdHyyzn9ezAF+IGHJ70fMPTMPw/+
 +Cj74C6nvAA5AKGrGOnmhOe93/UDHZTTdtzTwPJKe2rhjnW97+zdUYQDsJsdt7I0q/bc
 EQJh5frPYy61XxfpqY0MzhRY0x4zZwFOtgPPXvv4fhf96uUqL0KVETAGgVUFOieaye3d
 X+VeDIu3nutVtC91CQHNfGdJSU33D9WlGUUr0u95sS/r9nyUiEMytLXR7c3tWC9jR7x9
 aHlWQryMeQsed8qR+XBBfiqzyuRC9YpEo7+/hX3MdkYzPZeHIjbKwIEmvbvk3Z+lh9wE
 EYiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX4OcPVTRLXFgnJEYhXXVMWIzZgQ4+GMpYez0y8oH66ndHSOCd2sgxfNc4ik7Hv57sf0xSMbk=@lists.denx.de
X-Gm-Message-State: AOJu0YzEtm3PWxXmWvQIu2OaIu/5w3j+E4Dfxvo3wAXzJez69fmHoL1E
 k3D1Bk4RibG6LRTB8O39qWr3YkmKV1eQ6XvAO8Q0co5mOhfnXd1p6YvL6R1yyKIEdZf+bznpnSH
 SQH+BlY2P2Z+4on5rpIrk0davFXfxyuI=
X-Gm-Gg: ASbGncuXh89dH2ubfMJ36axvvwp68jMC+b5dEFzKCebpSIO10Mbw1RvMKk4my0ppZ81
 6dInrLmvjFWOFfnyLBUMsD5CFHXkjqe0lI3cLZWg90ZA2bK70h0XpT1/qebPHofjtX7QKz4jtHE
 b8yFh2W4svOT1TTsjCzLO0oPudCNu55bV8SxNkzUW6/zfdRfqVAztte8V8dfWBhi28yBs9XXu1C
 A2l
X-Google-Smtp-Source: AGHT+IFgAP3dnMKZc9uMpj4rDNoX/AXJr51aUz2yKEdsMlFZ/Jq1ZNA/I3fZ+9MjPNAMhsnCYx0AsTAw+hhvd5uwC88=
X-Received: by 2002:a17:907:a908:b0:ae3:6654:c0b2 with SMTP id
 a640c23a62f3a-ae36654c1c4mr933256466b.28.1751279223362; Mon, 30 Jun 2025
 03:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250630102524.127970-1-pbrobinson@gmail.com>
In-Reply-To: <20250630102524.127970-1-pbrobinson@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 30 Jun 2025 11:26:51 +0100
X-Gm-Features: Ac12FXxuLRmMn0Qz5QD3Yq7CcOloI17py0pZTeaOD4HXkCiL9ZtAyjNwEE2P-so
Message-ID: <CALeDE9OfDKLoHmbwOdUnB=GKph2vzZDAFqpcgtX5rbcH_qXg_Q@mail.gmail.com>
Subject: Re: [PATCH] board: rockchip: Add support for rk3588 MNT Reform2
To: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
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

On Mon, 30 Jun 2025 at 11:25, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Add support for MNT Reform2, it works as a carrier board
> with a Firefly iCore-3588Q SoM.
>
> Specification:
> - Rockchip RK3588
> - LPDDR5X 16/32 GB
> - eMMC 128/256 GB
> - HDMI Type A out x 1
> - USB 3.0 Host x 1
> - USB-C 3.0 with DisplayPort AltMode
> - PCIE M.2 E Key for Wireless connection
> - PCIE M.2 M Key for NVME connection
> - DSI to eDP panel
> - 1Gb Ethernet w/ Microchip KSZ9310 PHY
>
> Tested using Fedora boot on USB stick and eMMC.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---

I forgot to add a note with this that the initial SoM and mainboard
dts went upstream in the 6.16 merge window so should come with that
rebase.

>  arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi | 14 ++++
>  board/rockchip/evb_rk3588/MAINTAINERS       |  6 ++
>  configs/mnt-reform2-rk3588_defconfig        | 87 +++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst             |  1 +
>  4 files changed, 108 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>  create mode 100644 configs/mnt-reform2-rk3588_defconfig
>
> diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> new file mode 100644
> index 00000000000..d54220a3271
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +/ {
> +       chosen {
> +               u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +       };
> +};
> +
> +&fspim2_pins {
> +       bootph-pre-ram;
> +       bootph-some-ram;
> +};
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index 1232f05a387..24cf13c3c48 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -29,6 +29,12 @@ F:   configs/generic-rk3588_defconfig
>  F:     arch/arm/dts/rk3588-generic.dts
>  F:     arch/arm/dts/rk3588-generic-u-boot.dtsi
>
> +MNT-REFORM2-RK3588
> +M:     Peter Robinson <pbrobinson@gmail.com>
> +S:     Maintained
> +F:     configs/mnt-reform2-rk3588_defconfig
> +F:     arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> +
>  ORANGEPI-5-RK3588
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
> diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
> new file mode 100644
> index 00000000000..e76c714b03d
> --- /dev/null
> +++ b/configs/mnt-reform2-rk3588_defconfig
> @@ -0,0 +1,87 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHYLIB=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index b88299cbba2..0c2c294e6cb 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -149,6 +149,7 @@ List of mainline supported Rockchip boards:
>       - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
>       - Indiedroid Nova (nova-rk3588s)
>       - Khadas Edge2 (khadas-edge2-rk3588s)
> +     - MNT Reform2 (mnt-reform2-rk3588)
>       - Pine64 QuartzPro64 (quartzpro64-rk3588)
>       - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>       - Radxa ROCK 5A (rock5a-rk3588s)
> --
> 2.50.0
>
