Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F55C47077
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 03:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16578764D;
	Sun,  7 Jan 2024 04:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7ow1gPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46CC87987; Sun,  7 Jan 2024 04:27:15 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63734870AB
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 04:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a28ab7ae504so68233966b.3
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 19:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704598033; x=1705202833; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDzNmgV2DB/79GS6rGKg13x6aGlGfdJM918qhU96pYY=;
 b=g7ow1gPjvIKTHz2zDWh5RjC7kLLEM3g6r9Sgb7zKKfbtVZgXSlu5dDtIg5R5GdkNx5
 obpRFBdCWQHrY3sT3sHcrhWcMm//zSu4lfUKqUefFFYE/CA2Beh5X7N9MSVLULfno1Fq
 7UeP+nXLMCKbfxikQnpQFPLAjHJ532RMJkUYuymd3zijNtciUxgwlUfqQa+D3AyRKovB
 esPiuqWQ/+wVL2jeUtgwP9yu1VgYik+vidRexvfNVAz6N01kFA7Ft32rGYhmgKF1CsGV
 JkzswmYj0b+O1izdcmSaqepTz4yAuSI1PNxpMRRCcA2+UuxnQROQ2HO9cAQNy8JPrz9R
 237w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704598033; x=1705202833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDzNmgV2DB/79GS6rGKg13x6aGlGfdJM918qhU96pYY=;
 b=YRhelbvC+1fFUkR7ZbjbdfqNJTV/wG4jyoGqqs88Kf8Cmx5iDlwD4L3yo493UF7KWB
 BOOmbeQGVuh+XCkMN5LiNDoOoBTtnBjtUIjNDLH12mBBJjJTTfziBq0mvN9ECzkudgl3
 jLmt8bdQ1Lc2W4oXNLWFchhsAP12C0OyQmGbkq9Il63oWCVAwaTOxeJxJV8P2UK6e5Yo
 RZhjWh1F2zgC5ovLT2yCQ0nplVv88uFJlvicADVlMv6R4Vg5oNKGjUXL9B67NM3I3200
 F/iX0uj2znB4diqO8SXlSmKDMR5X5yyq3EXglWEvHRlnxqzemgR3qHWpMGuSCJBpxGiS
 071Q==
X-Gm-Message-State: AOJu0Yz1rQZ63OK74q9z35kOxgjbGfTdmhNBquSZ6r/LB1tw9TxDBCIo
 AZQEP7YxwzKgHpDOfDNqwmFRpirCAt8a7BKCoTM=
X-Google-Smtp-Source: AGHT+IGFTP5eeYUz4LMoVBv4omF43igxTE1ozkL41SJdILNkZ55f7x7DAqBzUjMkW0xmQUGbJISIeIHzAqy4uLUa4B0=
X-Received: by 2002:a17:906:1995:b0:a28:aab9:656 with SMTP id
 g21-20020a170906199500b00a28aab90656mr640696ejd.94.1704598032450; Sat, 06 Jan
 2024 19:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20231223040007.72997-1-cnsztl@gmail.com>
 <a4fc159c-7119-4656-a820-7e1e216b3564@rock-chips.com>
In-Reply-To: <a4fc159c-7119-4656-a820-7e1e216b3564@rock-chips.com>
From: Tianling Shen <cnsztl@gmail.com>
Date: Sun, 7 Jan 2024 11:27:00 +0800
Message-ID: <CAOP2_TgpuqsiF=v_YD8iw7GXtZt+DJ4ofanZzuA_Z-tk12WwZQ@mail.gmail.com>
Subject: Re: [PATCH] board: rockchip: Add support for FriendlyARM NanoPi R2C
 Plus
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
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

Hi Kever,

On Tue, Jan 2, 2024 at 9:00=E2=80=AFAM Kever Yang <kever.yang@rock-chips.co=
m> wrote:
>
> Hi Tianling,
>
> On 2023/12/23 12:00, Tianling Shen wrote:
> > The NanoPi R2C Plus is a small variant of NanoPi R2C with a on-board
> > eMMC flash (8G) included.
> >
> > The device tree is taken from the kernel v6.5.
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >   arch/arm/dts/Makefile                         |   1 +
> >   .../dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |   9 ++
> >   arch/arm/dts/rk3328-nanopi-r2c-plus.dts       |  33 +++++
> >   board/rockchip/evb_rk3328/MAINTAINERS         |   6 +
> >   configs/nanopi-r2c-plus-rk3328_defconfig      | 114 +++++++++++++++++=
+
> >   5 files changed, 163 insertions(+)
> >   create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> >   create mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus.dts
> >   create mode 100644 configs/nanopi-r2c-plus-rk3328_defconfig
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 9d28a485bec..6909f95e084 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -126,6 +126,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3308) +=3D \
> >   dtb-$(CONFIG_ROCKCHIP_RK3328) +=3D \
> >       rk3328-evb.dtb \
> >       rk3328-nanopi-r2c.dtb \
> > +     rk3328-nanopi-r2c-plus.dtb \
> >       rk3328-nanopi-r2s.dtb \
> >       rk3328-orangepi-r1-plus.dtb \
> >       rk3328-orangepi-r1-plus-lts.dtb \
> > diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi b/arch/arm=
/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..f8adb9e5e1f
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include "rk3328-nanopi-r2c-u-boot.dtsi"
> > +
> > +/ {
> > +     chosen {
> > +             u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &emmc;
> > +     };
> > +};
> > diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus.dts b/arch/arm/dts/rk3=
328-nanopi-r2c-plus.dts
> > new file mode 100644
> > index 00000000000..16a1958e457
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3328-nanopi-r2c-plus.dts
> > @@ -0,0 +1,33 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (c) 2021 FriendlyElec Computer Tech. Co., Ltd.
> > + * (http://www.friendlyarm.com)
> > + *
> > + * Copyright (c) 2023 Tianling Shen <cnsztl@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3328-nanopi-r2c.dts"
> > +
> > +/ {
> > +     model =3D "FriendlyElec NanoPi R2C Plus";
> > +     compatible =3D "friendlyarm,nanopi-r2c-plus", "rockchip,rk3328";
> > +
> > +     aliases {
> > +             mmc1 =3D &emmc;
> > +     };
> > +};
> > +
> > +&emmc {
> > +     bus-width =3D <8>;
> > +     cap-mmc-highspeed;
> > +     max-frequency =3D <150000000>;
> > +     mmc-ddr-1_8v;
> > +     mmc-hs200-1_8v;
> > +     non-removable;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&emmc_clk &emmc_cmd &emmc_bus8>;
> > +     vmmc-supply =3D <&vcc_io_33>;
> > +     vqmmc-supply =3D <&vcc18_emmc>;
> > +     status =3D "okay";
> > +};
> > diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb=
_rk3328/MAINTAINERS
> > index 8a19eb373d0..5fc114a63f6 100644
> > --- a/board/rockchip/evb_rk3328/MAINTAINERS
> > +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> > @@ -11,6 +11,12 @@ S:      Maintained
> >   F:      configs/nanopi-r2c-rk3328_defconfig
> >   F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
> >
> > +NANOPI-R2C-PLUS-RK3328
> > +M:      Tianling Shen <cnsztl@gmail.com>
> > +S:      Maintained
> > +F:      configs/nanopi-r2c-plus-rk3328_defconfig
> > +F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> > +
> >   NANOPI-R2S-RK3328
> >   M:      David Bauer <mail@david-bauer.net>
> >   S:      Maintained
> > diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-=
r2c-plus-rk3328_defconfig
> > new file mode 100644
> > index 00000000000..320ed8b434a
> > --- /dev/null
> > +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
> > @@ -0,0 +1,114 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> > +CONFIG_COUNTER_FREQUENCY=3D24000000
> > +CONFIG_ARCH_ROCKCHIP=3Dy
> > +CONFIG_TEXT_BASE=3D0x00200000
> > +CONFIG_SPL_GPIO=3Dy
> > +CONFIG_NR_DRAM_BANKS=3D1
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> > +CONFIG_SF_DEFAULT_SPEED=3D20000000
> > +CONFIG_ENV_OFFSET=3D0x3F8000
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"rk3328-nanopi-r2c-plus"
> > +CONFIG_DM_RESET=3Dy
> > +CONFIG_ROCKCHIP_RK3328=3Dy
> > +CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > +CONFIG_TPL_LIBCOMMON_SUPPORT=3Dy
> > +CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
> > +CONFIG_SPL_DRIVERS_MISC=3Dy
> > +CONFIG_SPL_STACK_R_ADDR=3D0x600000
> > +CONFIG_SPL_STACK=3D0x400000
> > +CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x800
>
>      Did you test both TPL and SPL?

Yes, I have confirmed both TPL and SPL are working fine.

Thanks,
Tianling.

>
>
> Thanks,
>
> - Kever
>
> > +CONFIG_DEBUG_UART_BASE=3D0xFF130000
> > +CONFIG_DEBUG_UART_CLOCK=3D24000000
> > +CONFIG_SYS_LOAD_ADDR=3D0x800800
> > +CONFIG_DEBUG_UART=3Dy
> > +# CONFIG_ANDROID_BOOT_IMAGE is not set
> > +CONFIG_FIT=3Dy
> > +CONFIG_FIT_VERBOSE=3Dy
> > +CONFIG_SPL_LOAD_FIT=3Dy
> > +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-nanopi-r2c-plus.dtb"
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > +CONFIG_MISC_INIT_R=3Dy
> > +CONFIG_SPL_MAX_SIZE=3D0x40000
> > +CONFIG_SPL_PAD_TO=3D0x7f8000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > +CONFIG_SPL_BSS_START_ADDR=3D0x2000000
> > +CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_STACK_R=3Dy
> > +CONFIG_SPL_I2C=3Dy
> > +CONFIG_SPL_POWER=3Dy
> > +CONFIG_SPL_ATF=3Dy
> > +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> > +CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> > +CONFIG_CMD_BOOTZ=3Dy
> > +CONFIG_CMD_GPT=3Dy
> > +CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_USB=3Dy
> > +# CONFIG_CMD_SETEXPR is not set
> > +CONFIG_CMD_TIME=3Dy
> > +CONFIG_SPL_OF_CONTROL=3Dy
> > +CONFIG_TPL_OF_CONTROL=3Dy
> > +CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cl=
ocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_TPL_OF_PLATDATA=3Dy
> > +CONFIG_ENV_IS_IN_MMC=3Dy
> > +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> > +CONFIG_SYS_MMC_ENV_DEV=3D1
> > +CONFIG_NET_RANDOM_ETHADDR=3Dy
> > +CONFIG_TPL_DM=3Dy
> > +CONFIG_REGMAP=3Dy
> > +CONFIG_SPL_REGMAP=3Dy
> > +CONFIG_TPL_REGMAP=3Dy
> > +CONFIG_SYSCON=3Dy
> > +CONFIG_SPL_SYSCON=3Dy
> > +CONFIG_TPL_SYSCON=3Dy
> > +CONFIG_CLK=3Dy
> > +CONFIG_SPL_CLK=3Dy
> > +CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
> > +CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
> > +CONFIG_ROCKCHIP_GPIO=3Dy
> > +CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > +CONFIG_MISC=3Dy
> > +CONFIG_MMC_DW=3Dy
> > +CONFIG_MMC_DW_ROCKCHIP=3Dy
> > +CONFIG_ETH_DESIGNWARE=3Dy
> > +CONFIG_GMAC_ROCKCHIP=3Dy
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> > +CONFIG_PINCTRL=3Dy
> > +CONFIG_SPL_PINCTRL=3Dy
> > +CONFIG_DM_PMIC=3Dy
> > +CONFIG_PMIC_RK8XX=3Dy
> > +CONFIG_SPL_PMIC_RK8XX=3Dy
> > +CONFIG_SPL_DM_REGULATOR=3Dy
> > +CONFIG_REGULATOR_PWM=3Dy
> > +CONFIG_DM_REGULATOR_FIXED=3Dy
> > +CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> > +CONFIG_REGULATOR_RK8XX=3Dy
> > +CONFIG_PWM_ROCKCHIP=3Dy
> > +CONFIG_RAM=3Dy
> > +CONFIG_SPL_RAM=3Dy
> > +CONFIG_TPL_RAM=3Dy
> > +CONFIG_BAUDRATE=3D1500000
> > +CONFIG_DEBUG_UART_SHIFT=3D2
> > +CONFIG_SYS_NS16550_MEM32=3Dy
> > +CONFIG_SYSINFO=3Dy
> > +CONFIG_SYSRESET=3Dy
> > +# CONFIG_TPL_SYSRESET is not set
> > +CONFIG_USB=3Dy
> > +CONFIG_USB_XHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_HCD=3Dy
> > +CONFIG_USB_EHCI_GENERIC=3Dy
> > +CONFIG_USB_OHCI_HCD=3Dy
> > +CONFIG_USB_OHCI_GENERIC=3Dy
> > +CONFIG_USB_DWC2=3Dy
> > +CONFIG_USB_DWC3=3Dy
> > +# CONFIG_USB_DWC3_GADGET is not set
> > +CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_USB_GADGET=3Dy
> > +CONFIG_USB_GADGET_DWC2_OTG=3Dy
> > +CONFIG_SPL_TINY_MEMSET=3Dy
> > +CONFIG_TPL_TINY_MEMSET=3Dy
> > +CONFIG_ERRNO_STR=3Dy
