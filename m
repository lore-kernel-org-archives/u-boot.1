Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20727CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B89983887;
	Fri, 26 Sep 2025 18:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVyRIjph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B568388B; Fri, 26 Sep 2025 18:27:10 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A428D83868
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 18:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-62fa0653cd1so3525149a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758904028; x=1759508828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zF+adX+qpdpqUN9cwkf6LKBhd8K27VipqF1ls6gbWuA=;
 b=IVyRIjphNC65DjZxpQ5kCck26guve1tBWK3wccr86UVCvwZJrGdKqUH60uSI/J2Y6p
 Xi+s/wchDRcuvIUoyBdJqguT6XXSrSR+VpvFNSAulJkR2dOh9IuJtxhekIAsVzDKXf1+
 ZRALhrcHPaGntyigpe+Zxr8c7G34KlFmH8ZP/PYs/f40lpRNUis3GrgO5OjXgB4x3Rt3
 RGtQsvbss0q12NztBstMkMDytoBuzL4Qy2qzuNqV3K0H4Vlw15AW81izJp7Xa/iRnEHQ
 o/gYnCRvmJ0I1SY8T2Sf8S7r6QFh580yzSLcGVkPn7bcd+nSNs9efQ7ROB2o3knspR6C
 Ntxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758904028; x=1759508828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zF+adX+qpdpqUN9cwkf6LKBhd8K27VipqF1ls6gbWuA=;
 b=dXEhb+TCVT38/lqwZjewViaKIPpnJCnMgb3X1nU4db8ys1/VZbE2M3SvMOI2tlzluR
 qxl9hTIfptPHd7rSnPhRc+2IGj3eKRCZ2kE/inAdovPbmy+0bDRNLBb0onbG/8GCQd2U
 4qcUe2M9lrTPXj7U8rwV/C5XaESipAMc0YyMXmGfBB4Djj6l/spC8fseKwzTcBlCwuqx
 UrkNm7akoeOnTwEdMjGIgwjRn/4uHKQoPt6XK7gWcKVXWptMcEWhCLIYy2mejPeXAoS0
 QuIXXXtMAqCMFORakD3oQV+PjXjlWE0Kt7aHp/Ngvn7Ae+xxhxIaOzGClwt6kT1jwuOT
 MXeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOSE02DqFYmU9bDEq8F2jTAthLLJsHT68+Wqwto/TG/v4jEjNc0FPWNYhEGwtCAgO+A15akrQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzhJ+P0Ioda4VXOU0q+DF09VK+mD6Z3UvMZ6bY43IxIXzRnbjC+
 voeN8wG5EK8d5tdxMf6tulTxM0lO2vyr/q3AYxOtxSD/pLIt7/lFhSYkLtm/X3npAH1o5vtRdmx
 7aLFrQIkDKkO2XOHE/Jqj+AG6cIcttjfL7goZ
X-Gm-Gg: ASbGnctprgmrPcEr8iNNzbd9bxpBt5HFDyn/t88sNDXa0373Da5FzzLnv+uf86b1Sr4
 XsB4fwHxG3jxtMaE6efsHP9ys8NMTt1pgjyEAjt0VvLck6W9fvfRNDC7LB4JVV9AT73MJ1K9MD8
 zVoY615stbxzBsyjZRYE8DH07TgctT1g/mrQFwuAHCAcKk3Vgro1WVVV4RVZUdt5Nm+ozgoZGNf
 lrxmuy0pN0tfoeDLjZZdLn61qR4CVXwo/Byf9Jx464aSpU2qyJ3Sf0NrEtjDWz73waBxnRHCpnu
 jx4ltMKy4d6IvtDiMwNEguqNiA==
X-Google-Smtp-Source: AGHT+IHB+IjoD59159200sYx+8kpIUixqshZ0kuIKkufkoN+ympyecoiRzrlXm+KhviZW3Xu4mwtF3osw52FxV6UmuU=
X-Received: by 2002:a05:6402:543:b0:62f:4b68:bfae with SMTP id
 4fb4d7f45d1cf-6349fa8fcf7mr5286942a12.31.1758904027720; Fri, 26 Sep 2025
 09:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250630102524.127970-1-pbrobinson@gmail.com>
 <a9587b7f-95fa-472c-af5a-8f45d606666d@cherry.de>
In-Reply-To: <a9587b7f-95fa-472c-af5a-8f45d606666d@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 26 Sep 2025 17:26:56 +0100
X-Gm-Features: AS18NWBF-uDCuyaKMDcqOalMVZd45SvPEG-rK3ja6hOQtSV6b-hQVxzQjUJUCs4
Message-ID: <CALeDE9NhX9yKEJEXbEW=JdpBdQXE529SNAJTWeU98E9QA4o=Fg@mail.gmail.com>
Subject: Re: [PATCH] board: rockchip: Add support for rk3588 MNT Reform2
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
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

Hi Quentin,

> On 6/30/25 12:25 PM, Peter Robinson wrote:
> > Add support for MNT Reform2, it works as a carrier board
> > with a Firefly iCore-3588Q SoM.
> >
> > Specification:
> > - Rockchip RK3588
> > - LPDDR5X 16/32 GB
> > - eMMC 128/256 GB
> > - HDMI Type A out x 1
> > - USB 3.0 Host x 1
> > - USB-C 3.0 with DisplayPort AltMode
> > - PCIE M.2 E Key for Wireless connection
> > - PCIE M.2 M Key for NVME connection
> > - DSI to eDP panel
> > - 1Gb Ethernet w/ Microchip KSZ9310 PHY
> >
> > Tested using Fedora boot on USB stick and eMMC.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >   arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi | 14 ++++
> >   board/rockchip/evb_rk3588/MAINTAINERS       |  6 ++
> >   configs/mnt-reform2-rk3588_defconfig        | 87 +++++++++++++++++++++
> >   doc/board/rockchip/rockchip.rst             |  1 +
> >   4 files changed, 108 insertions(+)
> >   create mode 100644 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> >   create mode 100644 configs/mnt-reform2-rk3588_defconfig
> >
> > diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..d54220a3271
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +#include "rk3588-u-boot.dtsi"
> > +
> > +/ {
> > +     chosen {
> > +             u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>
> This is the same as the one in rk3588s-u-boot.dtsi so I think it can be
> omitted?

Yes, I had been working with someone remotely and they had been
testing a few things to get it working so there were a few leftovers I
missed in the commit.

> > +     };
> > +};
> > +
> > +&fspim2_pins {
> > +     bootph-pre-ram;
> > +     bootph-some-ram;
> > +};
>
> I couldn't see where fspim2_pins is used for this board, are you sure
> this is correct? I don't see sfc node being enabled.

Initially the user had reported it did have SPI flash, it doesn't, I
forgot to clean that up.

> > diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> > index 1232f05a387..24cf13c3c48 100644
> > --- a/board/rockchip/evb_rk3588/MAINTAINERS
> > +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> > @@ -29,6 +29,12 @@ F: configs/generic-rk3588_defconfig
> >   F:  arch/arm/dts/rk3588-generic.dts
> >   F:  arch/arm/dts/rk3588-generic-u-boot.dtsi
> >
> > +MNT-REFORM2-RK3588
> > +M:   Peter Robinson <pbrobinson@gmail.com>
> > +S:   Maintained
> > +F:   configs/mnt-reform2-rk3588_defconfig
> > +F:   arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> > +
> >   ORANGEPI-5-RK3588
> >   M:  Jonas Karlman <jonas@kwiboo.se>
> >   S:  Maintained
> > diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
> > new file mode 100644
> > index 00000000000..e76c714b03d
> > --- /dev/null
> > +++ b/configs/mnt-reform2-rk3588_defconfig
> > @@ -0,0 +1,87 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_COUNTER_FREQUENCY=24000000
> > +CONFIG_ARCH_ROCKCHIP=y
> > +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
> > +CONFIG_ROCKCHIP_RK3588=y
> > +CONFIG_SPL_SERIAL=y
> > +CONFIG_TARGET_EVB_RK3588=y
> > +CONFIG_SYS_LOAD_ADDR=0xc00800
> > +CONFIG_DEBUG_UART_BASE=0xFEB50000
> > +CONFIG_DEBUG_UART_CLOCK=24000000
> > +CONFIG_PCI=y
> > +CONFIG_DEBUG_UART=y
> > +CONFIG_USE_PREBOOT=y
> > +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
> > +CONFIG_FIT=y
> > +CONFIG_FIT_VERBOSE=y
> > +CONFIG_SPL_FIT_SIGNATURE=y
> > +CONFIG_SPL_LOAD_FIT=y
> > +CONFIG_LEGACY_IMAGE_FORMAT=y
> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"
>
> Shouldn't that end with .dtb?

Nope.

> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=y
> > +CONFIG_SPL_MAX_SIZE=0x40000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_ATF=y
> > +CONFIG_CMD_GPIO=y
> > +CONFIG_CMD_GPT=y
> > +CONFIG_CMD_I2C=y
> > +CONFIG_CMD_MMC=y
> > +CONFIG_CMD_PCI=y
> > +CONFIG_CMD_USB=y
> > +CONFIG_CMD_USB_MASS_STORAGE=y
> > +# CONFIG_CMD_SETEXPR is not set
> > +CONFIG_CMD_REGULATOR=y
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=y
> > +CONFIG_OF_LIVE=y
> > +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_SPL_DM_SEQ_ALIAS=y
> > +CONFIG_SPL_REGMAP=y
> > +CONFIG_SPL_SYSCON=y
> > +CONFIG_SPL_CLK=y
> > +CONFIG_ROCKCHIP_GPIO=y
> > +CONFIG_SYS_I2C_ROCKCHIP=y
> > +CONFIG_LED=y
> > +CONFIG_LED_GPIO=y
> > +CONFIG_SYS_I2C_ROCKCHIP=y
>
> Mmmm CONFIG_SYS_I2C_ROCKCHIP=y appearing twice smells like hand-edited
> defconfig, can you run make savedefconfig on it and use that output in
> the patch?

Yes, done in v2

> > +CONFIG_MISC=y
> > +CONFIG_SUPPORT_EMMC_RPMB=y
> > +CONFIG_MMC_HS400_ES_SUPPORT=y
> > +CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
> > +CONFIG_MMC_HS400_SUPPORT=y
> > +CONFIG_SPL_MMC_HS400_SUPPORT=y
> > +CONFIG_MMC_SDHCI=y
> > +CONFIG_MMC_SDHCI_SDMA=y
> > +CONFIG_MMC_SDHCI_ROCKCHIP=y
> > +CONFIG_PHY_MICREL=y
> > +CONFIG_PHY_MICREL_KSZ90X1=y
> > +CONFIG_DWC_ETH_QOS=y
> > +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> > +CONFIG_PHYLIB=y
> > +CONFIG_NVME_PCI=y
> > +CONFIG_PCIE_DW_ROCKCHIP=y
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> > +CONFIG_PHY_ROCKCHIP_USBDP=y
> > +CONFIG_SPL_PINCTRL=y
> > +CONFIG_DM_PMIC=y
> > +CONFIG_PMIC_RK8XX=y
> > +CONFIG_REGULATOR_RK8XX=y
> > +CONFIG_PWM_ROCKCHIP=y
> > +CONFIG_SPL_RAM=y
> > +CONFIG_BAUDRATE=1500000
> > +CONFIG_DEBUG_UART_SHIFT=2
> > +CONFIG_SYS_NS16550_MEM32=y
> > +CONFIG_ROCKCHIP_SPI=y
>
> I am not sure this setup actually has an SPI flash? At least couldn't
> find it in the device tree in upstream Linux's Rockchip maintainer tree
> for 6.17.

It doesn't, I had been told differently initially, and the upstream
file is also currently not complete.

Peter
