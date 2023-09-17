Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A838CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 07:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D985863E5;
	Sun, 17 Sep 2023 09:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="tKpDmFcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386E68642D; Sun, 17 Sep 2023 09:19:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BFD86308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 09:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694935155; x=1695539955; i=frank-w@public-files.de;
 bh=Fe0daxLL8jDIYbrhYxIEvOsUo2nz7Ea7Xs1/myb0LlU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tKpDmFcNdTm9uNq61X5Mp9BGz5Qbn6FOb+dD/GvPB0WtPdsCfO9519sOsyhlL4g9IsJFnZv4cvB
 GLS2N7wgExWntzfvaC4Em8dNTTR9hywN3aP4l8j72TUi2B4XdXXHyHM78+DaDtQH9933x1IHH9FpZ
 Bfy6fH7Yu/TkpF+vUo1NLIAjQZDxwJDK7Sd+SurjC7XB8X3DMIBnWi/TQplHbXgyR5jCobIon2T2B
 WVti+aSOdbq1YTspagy0Nd4Pn4HnOyzNCU6wItTuy20h65r3JJKz1MIxPWS58iVk8wnNB5TR45Z79
 Ssk5aBBQX7LaSGzwYFv46ajbzy96ts/LQLIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.245] ([217.61.153.245]) by web-mail.gmx.net
 (3c-app-gmx-bs18.server.lan [172.19.170.70]) (via HTTP); Sun, 17 Sep 2023
 09:19:15 +0200
MIME-Version: 1.0
Message-ID: <trinity-ae369208-8f2d-4d3c-a512-f730d74504f5-1694935155520@3c-app-gmx-bs18>
From: Frank Wunderlich <frank-w@public-files.de>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Frank Wunderlich <linux@fw-web.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Aw: Re: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 Sep 2023 09:19:15 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <dfcd6379-0efe-d335-d971-40302b291901@kwiboo.se>
References: <20230820160004.44880-1-linux@fw-web.de>
 <dfcd6379-0efe-d335-d971-40302b291901@kwiboo.se>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:RdBWFQSzWh0FVRoi9j/tGE/AtllmLp8FIFD8ZLF5ajIGyVVFJfz/7+CExfoPP7gw+BQ2X
 x+Mlc4PAhWIYek0HWit0MbQgct/WUl8RpSmQlFLU44kOPQ9zpSExswtIx4pk14U/2sJxDnx/DRA9
 7yHiaeoWDcB3KVF0UJPggzUw0DcHQlyAmEXsU7EE1JuLboRj4wvTJwtC5R5OzMELFNCXniCfcarl
 fKuEyU42mtdh5nVyO6zZtaJRT8qqq9Iom5RxlgaDsz6/k+CCfPLDJJ/yxOFrMpbSCFkiRKCXq3V8
 fg=
UI-OutboundReport: notjunk:1;M01:P0:ocE2YIq/Cwc=;9g8ctivaLYM0kWf41MyUn4fgi8r
 +Qw++0IeaUNfBhsbpKDQfnslm5m0huuq2jL5tvc6nD9lZJ6iyjASJhKB9zcHiwXqXthATMPiE
 RcIp88L+GxrZ93Vnnj8nKr4HeqJYNVrskFgQ9V5K3jd0yxgDiLKLUPY3pAUwj47a7/tDgiXzU
 q8RjP1ut0D2lv2K59O+pnOsbyejXOnv1CjvZeZ7lq98fmTX/Z0/AYrvlGr6JHhtuavQ17/W7N
 tIZBZ4GtnjbOVAE4luE6I839Wjelrb/Q/Y1u6p7dDQPtF87Sn6sHXZxCpxInjB/NGkcxOxPss
 zq2PBsug6aepymcdL1AZFtnd8OtYhpPzSQqhqM7hDMROlwIi+PV/daZojmQqjar6XUJ7GCmaP
 rVQQxz9LKKKV9tYgIsn+EgVhRMGIRAq8Dv34e+rfaaIuFpMxJogk4nm2YZdGpY1XKmWbqVVB7
 a2GCU8EcMnS0hLrrQWiEtQjlRp9/5xSNbhxd2mC32Hv5FWgkgYnkfjpA+Gnm7e/nQRXJ673tB
 H8x9Vg9saPAriqt4lHf90jiN1JLLsakinsKRyhb0MkxcAwuIQCkHbwpJ/HJeDgw+MtTLfl3YL
 dDpj7ZXkPAG8q7CjhBqHwSfwgjh34I1VhbfEtS3CjmAXMcuYZGbE0YjevHfOgS24lO46GW4wo
 /+fntQHWciigLPJxXKk0IjJaa6svs6URMlR4SyZShi1eXPVxFpmLWxINNEVhuJqaL2NWejHEX
 Zm2K8OYYjpE3BYf8WtV7hWoaeMcDZXO2rTjpxX3oaKIA/Cc4SxTSyiPMLTzJeXw3miapYYT4K
 fvvxUFDhjkPvqoryDlJBi1UQ==
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

Hi,

thank you for your suggestions

> Gesendet: Sonntag, 17. September 2023 um 00:51 Uhr
> Von: "Jonas Karlman" <jonas@kwiboo.se>
> An: "Frank Wunderlich" <linux@fw-web.de>
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chr=
omium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Kever Yang" <ke=
ver.yang@rock-chips.com>, "Marek Vasut" <marex@denx.de>, u-boot@lists.denx=
.de
> Betreff: Re: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
>
> Hi Frank,
>
> On 2023-08-20 18:00, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add Bananapi R2 Pro board.
> >
> > Till now evb dts could be used, but iodomain is different
> > (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
> > and with iodomain driver this can cause hardware fault.
> >
> > Devicetree in mainline-Linux:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > v3:
> > - disable gmac0 as switch-driver is not yet ready to attach to the mac
> > v2:
> > - drop switch-node for now as u-boot driver works differently to linux
> > ---
> >  arch/arm/dts/Makefile                     |   3 +-
> >  arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi |  23 +
> >  arch/arm/dts/rk3568-bpi-r2pro.dts         | 549 +++++++++++++++++++++=
+
> >  configs/bpi-r2pro-rk3568_defconfig        | 101 ++++
> >  4 files changed, 675 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro.dts
> >  create mode 100644 configs/bpi-r2pro-rk3568_defconfig
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index bd518064f35f..767bf9db39fb 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -182,7 +182,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) +=3D \
> >  	rk3568-nanopi-r5s.dtb \
> >  	rk3568-odroid-m1.dtb \
> >  	rk3568-radxa-e25.dtb \
> > -	rk3568-rock-3a.dtb
> > +	rk3568-rock-3a.dtb \
> > +	rk3568-bpi-r2pro.dtb
> >
> >  dtb-$(CONFIG_ROCKCHIP_RK3588) +=3D \
> >  	rk3588-edgeble-neu6a-io.dtb \
> > diff --git a/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi b/arch/arm/dts/=
rk3568-bpi-r2pro-u-boot.dtsi
> > new file mode 100644
> > index 000000000000..382a52a28b10
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
> > + */
> > +
> > +#include "rk356x-u-boot.dtsi"
> > +
> > +/ {
> > +	chosen {
> > +		stdout-path =3D &uart2;
> > +		u-boot,spl-boot-order =3D "same-as-spl", &sdmmc0, &sdhci;
>
> This is the default order in rk356x-u-boot.dtsi and can be dropped.
>
> > +	};
> > +};
> > +
> > +&sdmmc0 {
> > +	status =3D "okay";
>
> sdmmc0 is already enabled in rk3568-bpi-r2pro.dts
>
> > +};
> > +
> > +&uart2 {
> > +	clock-frequency =3D <24000000>;
> > +	bootph-pre-ram;
> > +	status =3D "okay";
> > +};

then i have only the uart here...right? do you remember i missed the -uboo=
t.dtsi in first try and board does not find mmc in spl.

do i really not need the first 2 nodes here?

> > diff --git a/arch/arm/dts/rk3568-bpi-r2pro.dts b/arch/arm/dts/rk3568-b=
pi-r2pro.dts
> > new file mode 100644
> > index 000000000000..e4fcbb8a1174
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3568-bpi-r2pro.dts
>
> Should be a 1:1 copy from kernel.

i try to do so, but this will result in many nodes not used in uboot like =
the switch i remove in the dtsi and graphics.
thx for pointing to the pcie driver then i can let these nodes in.

> [...]
>
> > diff --git a/configs/bpi-r2pro-rk3568_defconfig b/configs/bpi-r2pro-rk=
3568_defconfig
> > new file mode 100644
> > index 000000000000..e8936261eab3
> > --- /dev/null
> > +++ b/configs/bpi-r2pro-rk3568_defconfig
> > @@ -0,0 +1,101 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > +CONFIG_COUNTER_FREQUENCY=3D24000000
> > +CONFIG_ARCH_ROCKCHIP=3Dy
> > +CONFIG_TEXT_BASE=3D0x00a00000
> > +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> > +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> > +CONFIG_NR_DRAM_BANKS=3D2
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xc00000
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"rk3568-bpi-r2pro"
> > +CONFIG_ROCKCHIP_RK3568=3Dy
> > +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy
> > +CONFIG_SPL_SERIAL=3Dy
> > +CONFIG_SPL_STACK_R_ADDR=3D0x600000
> > +CONFIG_SPL_STACK=3D0x400000
> > +CONFIG_DEBUG_UART_BASE=3D0xFE660000
> > +CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_SYS_LOAD_ADDR=3D0xc00800
> > +CONFIG_DEBUG_UART=3Dy
> > +CONFIG_FIT=3Dy
> > +CONFIG_FIT_VERBOSE=3Dy
> > +CONFIG_SPL_FIT_SIGNATURE=3Dy
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > +#CONFIG_OF_SYSTEM_SETUP=3Dy
> > +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3568-bpi-r2pro"
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > +CONFIG_SPL_PAD_TO=3D0x7f8000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > +CONFIG_SPL_BSS_START_ADDR=3D0x4000000
> > +CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_STACK_R=3Dy
> > +CONFIG_SPL_ATF=3Dy
> > +CONFIG_CMD_GPIO=3Dy
> > +CONFIG_CMD_GPT=3Dy
> > +CONFIG_CMD_I2C=3Dy
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_PMIC=3Dy
> > +CONFIG_CMD_REGULATOR=3Dy
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=3Dy
> > +CONFIG_OF_LIVE=3Dy
> > +CONFIG_NET=3Dn
> > +CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-names int=
errupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_SPL_REGMAP=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > +CONFIG_SPL_CLK=3Dy
> > +CONFIG_ROCKCHIP_GPIO=3Dy
> > +CONFIG_ROCKCHIP_GPIO_V2=3Dy
>
> This Kconfig option does not exits.
>
> > +CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > +CONFIG_MISC=3Dy
> > +CONFIG_SUPPORT_EMMC_RPMB=3Dy
> > +CONFIG_MMC_DW=3Dy
> > +CONFIG_MMC_DW_ROCKCHIP=3Dy
> > +CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_SDMA=3Dy
> > +CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> > +CONFIG_ETH_DESIGNWARE=3Dy
> > +CONFIG_GMAC_ROCKCHIP=3Dy
>
> Please drop CONFIG_ETH_DESIGNWARE and CONFIG_GMAC_ROCKCHIP.
>
> The following series that add GMAC support for RK3568 and RK3588 will
> use DWC_ETH_QOS and DWC_ETH_QOS_ROCKCHIP Kconfig options.
>
> rockchip: Add GMAC support for RK3568 and RK3588
> https://patchwork.ozlabs.org/project/uboot/cover/20230807000817.1701012-=
1-jonas@kwiboo.se/
>
> > +CONFIG_DM_PMIC=3Dy
> > +CONFIG_PMIC_RK8XX=3Dy
> > +CONFIG_REGULATOR_RK8XX=3Dy
> > +CONFIG_REGULATOR_PWM=3Dy
> > +CONFIG_PWM_ROCKCHIP=3Dy
> > +CONFIG_SPL_RAM=3Dy
> > +CONFIG_BAUDRATE=3D1500000
> > +CONFIG_DEBUG_UART_SHIFT=3D2
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_SYSRESET=3Dy
> > +CONFIG_SYSRESET_PSCI=3Dy
> > +CONFIG_ERRNO_STR=3Dy
> > +CONFIG_SYS_PROMPT=3D"BPI-R2PRO> "
> > +CONFIG_CMD_SYSBOOT=3Dy
> > +CONFIG_CMD_BOOTDEV=3Dy
> > +CONFIG_BOOTSTD_FULL=3Dy
> > +CONFIG_CMD_EFICONFIG=3Dn
> > +CONFIG_EFI_LOADER=3Dn
> > +CONFIG_USB=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_XHCI_DWC3=3Dy
>
> This should not be enabled for rk3568, USB_DWC3_GENERIC provide usb
> support.
>
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_GENERIC=3Dy
> > +CONFIG_USB_OHCI_HCD=3Dy
> > +CONFIG_USB_OHCI_GENERIC=3Dy
> > +CONFIG_USB_UHCI_HCD=3Dy
> > +CONFIG_USB_DWC2=3Dy
>
> There should not be any need to enable this driver on rk3568.
>
> > +CONFIG_USB_DWC3=3Dy
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=3Dy
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> > +CONFIG_CMD_USB=3Dy
> > +CONFIG_AHCI=3Dy
> > +CONFIG_DWC_AHCI=3Dy
> > +CONFIG_SCSI=3Dy
> > +CONFIG_DM_SCSI=3Dy
> > +CONFIG_CMD_SCSI=3Dy
>
> Please run moveconfig.py to clean up and re-order the defconfig.

can you give me an example how i can pass my defconfig with the script?

./tools/moveconfig.py configs/bpi-r2pro-rk3568_defconfig
./tools/moveconfig.py -d configs/bpi-r2pro-rk3568_defconfig

do not work here...have not found a way in the --help page...i guess i mis=
understand the script

regards Frank

> Regards,
> Jonas
