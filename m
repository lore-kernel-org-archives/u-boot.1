Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD3FCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 04:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDE8881D2;
	Wed,  3 Apr 2024 06:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXWOixjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34355881DC; Wed,  3 Apr 2024 06:53:55 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26EDB881BD
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 06:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56df87057bbso1218701a12.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 21:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712120032; x=1712724832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=10y7W63uLlbSKteOjbCl9WrcvVyvtM4DfYBlp7QJpk8=;
 b=iXWOixjdGpSwl+7A1qonaWXopDRIKno32tzzcJvEdZ0aC3rfTr1QDKcOJ8Jz2l86Bg
 uh7AK7zAfk3O/AwHtcP4ovGMFZFN4EBOT2iQ/5sakIjB2KDKFuii3rZc96KeBUMUL2uv
 G4pXNYx/fIQPfD/O62EoA3toW9E9uABa4JG8NfARLBzgQzBWU6/6t5926MhClpeie5A5
 yDA/9WrF6lP02Pb6LzxX3K0IwmdJad/nbgUUlQiop57Xx25w5/RVb1E9huiOSPMCgFwI
 BxY7kEspj9zThJOx83TkyY+H/R30yOaCu9yGko4aDjPG5SvW0z8bUNFA/ZXyDZQYPk3A
 EDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712120032; x=1712724832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10y7W63uLlbSKteOjbCl9WrcvVyvtM4DfYBlp7QJpk8=;
 b=a2KscLDCm+oaM48DwT3yD0GoG4VTvuuax5oDnP41NeJK7W6PQ3xoR+DudCgfghp3va
 qf3M5Kpeqh8U/E9ThenH+c1JYOb5XAvM5txVBh8IV+NRsEYDhPl8ATHwa9UO590bMgf1
 R0ii1aiPyeS6g8Y+Svb7GQrfj/ihqIrkMqJ4/U+yiibqK+4uh6Rtq4BIB4KN2j1GguM3
 oD6kYF6EwIOH5k+9Hl8WgbDJJUvH/0aNO1Rw7ufIRFOJnN4JhJjTGY7ZE2TDsxYkbDMu
 mV0T5HiI+ETXUTGa82Qc43hijWnTJBQHUM0/NmGs5la6cO76DHOYBlhLb1qXVDVNwiSZ
 v1mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVImjsgZvfgkDiCEWOAxLPbTN9TOx7O90yrUT8LN3yaHFs3m8tQ4SO7CbiON36FcbqH7645nG+eZkw7mDMOOyWDxRCoEw==
X-Gm-Message-State: AOJu0Yz3IfcjysfCxYifSVVcf9FSrdmaI6stJhHA4R9dyZat+31WKJGk
 creBL8mDwN9VEF7NnUeYDh5wwDo9rHKZYdUWibsEOU5vDhCnQMJ5OMbdjr7uQipy27kHiTVHkEe
 za8eF3zMVpKnO4iRkRTNyXQUUTRY=
X-Google-Smtp-Source: AGHT+IGYBeuP/URqud8gEZA6NWdDk6Sf2acMcfD2VIJcsXhkykaL8lIsJr43DmCJMOOxs2JhWUGOv/QNG0m6RATBmlc=
X-Received: by 2002:a50:a6dc:0:b0:56c:59d4:6c5e with SMTP id
 f28-20020a50a6dc000000b0056c59d46c5emr9517347edc.7.1712120032477; Tue, 02 Apr
 2024 21:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-27-jonas@kwiboo.se>
In-Reply-To: <20240331202921.262323-27-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 3 Apr 2024 04:53:41 +0000
Message-ID: <CALeDE9NoNE5AocQvuKuvzbWM6y+wYqdOiT7=1SpBzaN7-VV8Cg@mail.gmail.com>
Subject: Re: [PATCH 26/31] rockchip: rk3399-rock960: Sync device tree from
 linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, u-boot@lists.denx.de
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

On Sun, 31 Mar 2024 at 21:34, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Sync rk3399-rock960 related device tree from linux v6.8.

TBH I wouldn't class this as "Sync device tree from linux v6.8", it
does a dozen other things as well!

> Add DM_RESET=y to support reset signals.
>
> Add PCI=y, CMD_PCI=y and NVME_PCI=y to support PCIe and NVMe boot.
>
> Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA boot.
>
> Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.
>
> Remove CONFIG_NET_RANDOM_ETHADDR=y, ethaddr and eth1addr is set based on
> cpuid read from eFUSE.
>
> Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.
>
> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>
> Add PHY_ROCKCHIP_INNO_USB2=y and PHY_ROCKCHIP_TYPEC=y to support USB PHY.
>
> Remove REGULATOR_PWM=y and DM_REGULATOR_GPIO=y, boards does not use
> pwm-regulator or regulator-gpio compatible.
>
> Add USB_XHCI_HCD=y, USB_DWC3=y and USB_DWC3_GENERIC=y to support USB3.
>
> Remove USE_PREBOOT=y to speed up booting, standard boot will init USB
> after faster boot media has been evaluated.

Does it init nvme and friends?

> Add CMD_ROCKUSB=y, CMD_USB_MASS_STORAGE=y and USB_GADGET=y to support
> RockUSB and UMS gadget.

Does this have effect on boot speed?

> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/dts/rk3399-ficus.dts    |  4 ++++
>  arch/arm/dts/rk3399-rock960.dtsi |  5 ++++-
>  configs/ficus-rk3399_defconfig   | 22 +++++++++++++++++-----
>  configs/rock960-rk3399_defconfig | 14 +++++++++++---
>  4 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-ficus.dts b/arch/arm/dts/rk3399-ficus.dts
> index 1ce85a5816e4..30e4879f322c 100644
> --- a/arch/arm/dts/rk3399-ficus.dts
> +++ b/arch/arm/dts/rk3399-ficus.dts
> @@ -13,6 +13,10 @@
>         model = "96boards RK3399 Ficus";
>         compatible = "vamrs,ficus", "rockchip,rk3399";
>
> +       aliases {
> +               ethernet0 = &gmac;
> +       };
> +
>         chosen {
>                 stdout-path = "serial2:1500000n8";
>         };
> diff --git a/arch/arm/dts/rk3399-rock960.dtsi b/arch/arm/dts/rk3399-rock960.dtsi
> index 25dc61c26a94..c920ddf44baf 100644
> --- a/arch/arm/dts/rk3399-rock960.dtsi
> +++ b/arch/arm/dts/rk3399-rock960.dtsi
> @@ -7,6 +7,7 @@
>
>  #include "rk3399.dtsi"
>  #include "rk3399-opp.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
>         aliases {
> @@ -127,6 +128,8 @@
>  };
>
>  &hdmi {
> +       avdd-0v9-supply = <&vcca0v9_hdmi>;
> +       avdd-1v8-supply = <&vcca1v8_hdmi>;
>         ddc-i2c-bus = <&i2c3>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&hdmi_cec>;
> @@ -528,7 +531,7 @@
>                 compatible = "brcm,bcm4329-fmac";
>                 reg = <1>;
>                 interrupt-parent = <&gpio0>;
> -               interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> +               interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
>                 interrupt-names = "host-wake";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&wifi_host_wake_l>;
> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
> index f4e3ebba8f46..0d97b7ecb3c7 100644
> --- a/configs/ficus-rk3399_defconfig
> +++ b/configs/ficus-rk3399_defconfig
> @@ -5,15 +5,18 @@ CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_SF_DEFAULT_SPEED=20000000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
> +CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_TARGET_ROCK960_RK3399=y
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-ficus.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> @@ -21,6 +24,7 @@ CONFIG_TPL=y
>  CONFIG_CMD_BOOTZ=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>  CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=y
> @@ -29,27 +33,35 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SYS_MMC_ENV_DEV=1
> -CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_ROCKCHIP_IODOMAIN=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>  CONFIG_ETH_DESIGNWARE=y
> -CONFIG_RGMII=y
>  CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PMIC_RK8XX=y
> -CONFIG_REGULATOR_PWM=y
> -CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SCSI=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_SYSRESET=y
>  CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_ERRNO_STR=y
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
> index 3b5ab7dc5781..e19b28753156 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -12,11 +12,11 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
> -CONFIG_USE_PREBOOT=y
> +CONFIG_AHCI=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock960.dtb"
>  CONFIG_SYS_PBSIZE=1052
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> @@ -28,6 +28,8 @@ CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
>  # CONFIG_CMD_SF is not set
>  CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=y
>  CONFIG_CMD_PMIC=y
> @@ -37,6 +39,9 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_ROCKCHIP_IODOMAIN=y
> @@ -52,6 +57,7 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SCSI=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> @@ -71,9 +77,11 @@ CONFIG_USB_ETHER_ASIX88179=y
>  CONFIG_USB_ETHER_MCS7830=y
>  CONFIG_USB_ETHER_RTL8152=y
>  CONFIG_USB_ETHER_SMSC95XX=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_VIDEO=y
>  CONFIG_DISPLAY=y
>  CONFIG_VIDEO_ROCKCHIP=y
>  CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>  CONFIG_ERRNO_STR=y
> --
> 2.43.2
>
