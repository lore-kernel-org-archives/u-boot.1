Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8847C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A8682AF6;
	Tue, 29 Apr 2025 19:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZSwbkv7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBC982A64; Tue, 29 Apr 2025 19:34:41 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2AE7829A1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C0D594A9A8
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 17:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A9BC4CEF1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745948076;
 bh=Hcf1Wp+3MQrpt3jzyY6Kks/Ep7P+hWs89XO0tIIm2vI=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=ZSwbkv7tEpHhPCISfVSmSYe3yjAeshlwPV2MXM+9HK3j1kOqqMATjVty+WWFfIo/B
 vmBxxXhjNvc3ON8fHYCtEJy+iSR1Ozg2JHRwQF/joNQkyNsPBBv6AItxO6vSZ0Z8TF
 zfIg3YZqoq0YUg9R97u/sI/wxZxQdsUu+wrp5e9+7py/M93rKX1EphGcUE/fGXkaIo
 CcCmfJCmHDioQlS9vKOodo6a6VKBYi/DEl4TF73JaXLkOWKlW7QQOdor5aRNXtfSNl
 5puIQ8h1IR0dgc4h6RQ3CL/1LUCDe0cEZT2GOL1tZ6f0E7Tn3gKvRSA/BqlaHINsQs
 LngFBz1YBYcwQ==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3104ddb8051so70950611fa.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:34:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YxvsnDGvashHCZs95kD2OvazGHrnuUkZSpCgM1TcBnkIBRPulea
 kp5t5vnlZNtagwzKitWZmbnfzCsS5++7G2IV5svosIaUByuZRRi0ZYPbs5IIw8rjtla2vPhTn0i
 QF/n/f3usYQe6CS2JbAMguifiir0=
X-Google-Smtp-Source: AGHT+IGkOUbWqMhmAZrWM1GKT1omov+5W0zHHZG1k8TBPI+T649+7rbSrIiITIXbowNK9Sq5SBdVCS/2h4j0NAbOcZA=
X-Received: by 2002:a05:651c:199e:b0:30c:f60:6c6 with SMTP id
 38308e7fff4ca-31e69a2cb99mr202371fa.6.1745948074605; Tue, 29 Apr 2025
 10:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250429154453.2155923-1-wens@kernel.org>
 <e4607f73-2d94-41c7-af35-bb94dcc5c336@cherry.de>
In-Reply-To: <e4607f73-2d94-41c7-af35-bb94dcc5c336@cherry.de>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 30 Apr 2025 01:34:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v65WWPSD2Z12uxUCrgPu5C4e9uBfHouB4JDaFw5AB1ed-A@mail.gmail.com>
X-Gm-Features: ATxdqUFLnOBQmPgbQGhec7ZpwwEmg9-afaE0jherQBsToGnodw-1VUWTdZT_svY
Message-ID: <CAGb2v65WWPSD2Z12uxUCrgPu5C4e9uBfHouB4JDaFw5AB1ed-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: rockchip_dw_mmc: Enable by default for all
 supported SoCs
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Akash Gajjar <gajjar04akash@gmail.com>, 
 Alexandre Vicenzi <linux@alxd.me>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Andy Yan <andyshrk@163.com>, Banglang Huang <banglang.huang@foxmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>,
 David Bauer <mail@david-bauer.net>, 
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Elon Zhang <zhangzj@rock-chips.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevam <festevam@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jacobe Zang <jacobe.zang@wesion.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>, 
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>, 
 Loic Devulder <ldevulder@suse.com>, Maksim Kiselev <bigunclemax@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nick Xie <nick@khadas.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Otavio Salvador <otavio@ossystems.com.br>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Ricardo Pardini <ricardo@pardini.net>, Sam Edwards <cfsworks@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Tianling Shen <cnsztl@gmail.com>, Tim Lunn <tim@feathertop.org>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Xiaobo Tian <peterwillcn@gmail.com>, 
 huang lin <hl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:44:08 +0200
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Apr 30, 2025 at 12:30=E2=80=AFAM Quentin Schulz
<quentin.schulz@cherry.de> wrote:
>
> Hi Chen-Yu,
>
> On 4/29/25 5:44 PM, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The rockchip_dw_mmc driver supports the MMC controller found in Rockchi=
p
> > SoCs. This controller is used for the SD card on all SoCs and eMMC on
> > older SoCs. Almost all defconfigs for Rockchip platforms have this
> > enabled.
> >
> > Enable it by default for all supported Rockchip SoCs. Disable it
> > explicitly in defconfigs that previously didn't have it enabled.
> >
>
> I'll let Tom confirm (or not), but I think it'd make sense to make this
> patch lighter by not including the defconfig changes that would be
> simply done automatically when doing a defconfig sync, e.g. like
> bdf41fb7b386bdf60303b7a92431467c12779c86 did? This would be nice because
> it would make your patch much easier to apply if they take long to be
> applied (e.g. someone else changes the defconfig and now we have
> conflicts all over the place). This also would remove unrelated changes
> from the diff, specifically the ones for the PX30 boards which are just
> noise at this point.
>
> [...]
>
> > diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/cool=
pi-cm5-genbook-rk3588_defconfig
> > index 3eb5dc968af6..92676ebb984a 100644
> > --- a/configs/coolpi-cm5-genbook-rk3588_defconfig
> > +++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
> > @@ -65,6 +65,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=3Dy
> >   CONFIG_SPL_MMC_HS400_ES_SUPPORT=3Dy
> >   CONFIG_MMC_HS400_SUPPORT=3Dy
> >   CONFIG_SPL_MMC_HS400_SUPPORT=3Dy
> > +# CONFIG_MMC_DW is not set
> >   CONFIG_MMC_SDHCI=3Dy
> >   CONFIG_MMC_SDHCI_SDMA=3Dy
> >   CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
>
> Checked that and sdmmc and sio both seems to be disabled in the DTS, so
> makes sense to have the driver disabled too.
>
> [...]
>
> > diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfi=
g
> > index 46b949531017..d23f90a6a606 100644
> > --- a/configs/evb-rv1108_defconfig
> > +++ b/configs/evb-rv1108_defconfig
> > @@ -31,6 +31,7 @@ CONFIG_FASTBOOT_BUF_SIZE=3D0x08000000
> >   CONFIG_FASTBOOT_FLASH_MMC_DEV=3D1
> >   CONFIG_ROCKCHIP_GPIO=3Dy
> >   CONFIG_SYS_I2C_ROCKCHIP=3Dy
> > +# CONFIG_MMC_DW is not set
> >   CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> >   CONFIG_SPI_FLASH_WINBOND=3Dy
> >   CONFIG_SPI_FLASH_MTD=3Dy
>
> This one seems to be a mistake, sdmmc is enabled and is supported by
> this driver as far as I know. A separate patch to enable it
> (before/after this one, would be nice).

After the patch it would be enabled by default, so nothing actually
has to be done? I can mention in the commit message that this one
and the Geekbox are intentionally enabled by default after the
patch since the DTS have them enabled.

> [...]
>
> > diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
> > index 80f91de7a11d..9dc642dc4ad9 100644
> > --- a/configs/geekbox_defconfig
> > +++ b/configs/geekbox_defconfig
> > @@ -22,6 +22,7 @@ CONFIG_REGMAP=3Dy
> >   CONFIG_SYSCON=3Dy
> >   CONFIG_BOUNCE_BUFFER=3Dy
> >   CONFIG_CLK=3Dy
> > +# CONFIG_MMC_DW is not set
> >   CONFIG_PINCTRL=3Dy
> >   CONFIG_RAM=3Dy
> >   CONFIG_DEBUG_UART_SHIFT=3D2
>
> This one seems to be a mistake, emmc is enabled and is supported by this
> driver as far as I know. A separate patch to enable it (before/after
> this one, would be nice).

Same here.

> [...]
>
> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > index 6740591a6533..f2f0e7dbe601 100644
> > --- a/drivers/mmc/Kconfig
> > +++ b/drivers/mmc/Kconfig
> > @@ -251,6 +251,7 @@ config MMC_DAVINCI
> >   config MMC_DW
> >       bool "Synopsys DesignWare Memory Card Interface"
> >       select BOUNCE_BUFFER
> > +     default y if ARCH_ROCKCHIP
> >       help
> >         This selects support for the Synopsys DesignWare Mobile Storage=
 IP
> >         block, this provides host support for SD and MMC interfaces, in=
 both
> > @@ -286,6 +287,7 @@ config MMC_DW_ROCKCHIP
> >       bool "Rockchip SD/MMC controller support"
> >       depends on OF_CONTROL
> >       depends on MMC_DW
> > +     default y
>
> default y if ARCH_ROCKCHIP
>
> maybe? To avoid boards from other vendors to have to disable it?

Oops, I missed this.

I think

    depends on ARCH_ROCKCHIP
    default y

would make more sense, and also match the platform-specific options
for the other platforms.

What do you think?

Thank you and Tom for the quick responses.


ChenYu
