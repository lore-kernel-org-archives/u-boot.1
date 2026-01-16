Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9D9D47CC3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CADA82BF2;
	Fri, 16 Jan 2026 11:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NG32psri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49CC083966; Fri, 16 Jan 2026 11:08:29 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DC5839B1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5014e1312c6so9500991cf.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:08:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768558104; cv=none;
 d=google.com; s=arc-20240605;
 b=QMJe/AWQX+qc3on4AWlPkElGk/HwPU7AyHb4XHMEE+XbOQoCzgoVlhr+Np9oG1tI7e
 9DgJpB7lZPiHSqIisxatW89wrBXRj+BwYsIYWhVFxUZ6hRb4HtT94ooRYk4FmtjusTHn
 jOF64wgLvq2L0Bj/deUexNNBLeF46n/RU+S+5raof9dN1jmWjXyXMzkllo2idXDwi9h/
 Pnc/LDUu6uj+kKHBOsmfm7pTT1bDkiPEVK+f1KXfBCqzpTf+FNChSdNVodhWR3ZLlV5h
 fCs76s1Z4/vJL4bDzpjREyEpbYZ+X9omOTaYJgxeGozPP4GyHEl5qh8E9IGtFAOh7A8G
 gN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TOcjygW55UKU035rYqyUn245D7sEv3knJ72ZKZR5ees=;
 fh=8VqwTZ7piYjPWQEFUarO0F8pZOq/0cPbU4RFz6Q+04g=;
 b=PPYKcOimHR/yvZvuDYNo5pNYyLtOxwMWCC7GArAt+sl0udcNUGeUmBMsZcjZY08E5p
 TS70jyghr8E5Ny0lBDIyotgHHbibi8/F2LHFZMuebH4EPQG3oLsO43M/Y0NVm/2Pk/WF
 9zSh4aNUqgIf2Q7yOul5hOBw9r/ACbnNYbhMsZnfkoitWkPLsas5i1Qs3wYbryxi1L5Z
 +unfcLsMDhhWJ7P+pTvSdKiPn6LEPeLPlwuhbaV3mLpP9VT4N8JHWLsxmeSZtSHuJhwA
 sj9KqBwu4kaJSVhUA8RAibzP8O+SfBggioxTYaVXOKBQsw5cVBnoPhJRI3Iy+idjrgZ7
 +Gyw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768558104; x=1769162904; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOcjygW55UKU035rYqyUn245D7sEv3knJ72ZKZR5ees=;
 b=NG32psriwC8QN21SXHKjHD+erljXF4u5SDtWDZioUMfYoUXez/yN9skTJdes4oNPtK
 uBqHyHbWDZKkMiDzbIJJXngMfoW4ZSZdQg8eBMXLJK5zxymN34/HmLWHxECBSCxa2ASu
 /iXTmPCH5r6bLcpk0CAjOCnV2WE7qX3t78TwAe06sKKnZoPvwgWS9glY8FJogcyfF6I1
 +x8ZviLMDL/CB/0XSr5HSe3CRnBnDfjnBeHrEj5y+NgBFu5e7Hn5sbh3+CqfTZNm38Lh
 hCAzyQeUO6UGxYZTpcHneLRH/mlH6aneQhIoJueF3LwyZAvjZHkhIsY5+ymixipDuMjO
 zeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768558104; x=1769162904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TOcjygW55UKU035rYqyUn245D7sEv3knJ72ZKZR5ees=;
 b=v15X53wEyagqBDP+wF6SoP5JV0zT4mAFUU3ZQIu03shGT9459B7nbmQL7BH53oGmnX
 Lfl4bYEevApIMAgFfAWHs0PSO7x5XYRM6C+GGhnGizn3sRSED6kp8GCGHvhP8MOkMm+a
 ih+jhRYNqWbqxK/2jiMEqwT3r3sBvh5hpjLv7lw6aA71CGq/NBA6VQ+iLfBhAil47S/Q
 96vb2BTwvERV43DK8BuPffcVeVcwWKUvk4c1I8okbYDUIxRzsDAzL8ro1+Ae8HWVUeEc
 xVgXiN47KVREIieTo1tOrhv45fG+nFRdD2cPMLoEd7zIoRXJN6f+agdez2Gw3vfFh/d9
 E3QA==
X-Gm-Message-State: AOJu0YwYG6tKC3VfwsV244SHFTgYO6Avmj7MZVuY4mNXmBVZK5Pzo2qJ
 p7kjLlJ28a9QCi+W8P3wdq65ctuBznlQ7VshP8TBLpGGRsQbp1DLLJKfRTR8xNnzssVfd+TcWO5
 pakG+5lZlhwCspPYRHH1FTNs0GBtgK7g=
X-Gm-Gg: AY/fxX4cT/8zQoDHgUUIi8DDAa+hMLqhrg25J6TzsNlXKJaoNQj2a/KyVwgsdX015F3
 j/RmaruWXTKsi+Ll6pwWZImzSNFltrAa4YpRADibJo3z562VJ9IbQHwHNWfXrEuQsOzF+z4Gd6P
 P+9MohAfR07xuPhsxcjc/ItxYfnsUZzBERzrdDl6MR1uvx+8phUBOO5gMDD6wpzLOeMSu4JkLN0
 9rRtp4nJbJCLiwx7fFBoPRIWX2sBi4IDGMhTNc+hH63LEKleT2NM7+pNti7btnhnFAGJsy9tOoA
 /3m4iwD2bXrO61E81u2r0Pu8aL/zmpgzCC157Gc=
X-Received: by 2002:ac8:5702:0:b0:501:47d3:2176 with SMTP id
 d75a77b69052e-502a168e4e3mr30877091cf.26.1768558104095; Fri, 16 Jan 2026
 02:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-3-e8e67649f3f8@gmail.com>
 <f6e97d23-4f92-43d1-a3b9-beeef3211145@cherry.de>
In-Reply-To: <f6e97d23-4f92-43d1-a3b9-beeef3211145@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 16 Jan 2026 14:08:08 +0400
X-Gm-Features: AZwV_Qj1nwyrH23T8uaf7kJVI3HdKW3AFxEPBbqCyKbYJWDTVKtcQn6MD8ZuUA0
Message-ID: <CABjd4Yzf-y05Qp3+5LVFrHeN_MMZu9TOXozrkjnXVU2MJU_WoQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rockchip: spl: Add support for booting from UFS
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 16 Jan 2026 11:18:17 +0100
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

On Wed, Jan 14, 2026 at 10:05=E2=80=AFPM Quentin Schulz
<quentin.schulz@cherry.de> wrote:
>
> Hi Alexey,
>
> On 1/8/26 6:50 PM, Alexey Charkov wrote:
> > Add the required architecture-specific lookups to enable U-boot SPL to
> > load images from UFS storage devices on Rockchip RK3576, which has a
> > boot ROM capable of loading the SPL image from UFS.
> >
> > This also requires the DM_RESET framework to be available in SPL, as
> > the UFS driver uses it.
>
> If it is a hard dependency, why is it not specified as such in the
> symbol directly instead of relying on imply's at the ARCH level? This
> will also be "painful" once a new Rockchip SoC has UFS support as we'll
> need to forget not to add those imply.

Fair enough, will convert it into a "select" under Rockchip UFS,
thanks for pointing it out!

> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   arch/arm/dts/rk3576-u-boot.dtsi              | 13 ++++++++++++-
> >   arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
> >   arch/arm/mach-rockchip/Kconfig               |  3 +++
> >   arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
> >   arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++++
> >   drivers/reset/Kconfig                        |  9 +++++++++
> >   drivers/reset/Makefile                       |  2 +-
> >   7 files changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-bo=
ot.dtsi
> > index dc3771b556a3..84d9f39fd407 100644
> > --- a/arch/arm/dts/rk3576-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> > @@ -12,7 +12,7 @@
> >       };
> >
> >       chosen {
> > -             u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &sdhci;
> > +             u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &sdhci, =
&ufshc;
> >       };
> >
> >       dmc {
> > @@ -81,6 +81,12 @@
> >       bootph-some-ram;
> >   };
> >
> > +&gpio4 {
> > +     /* Used for resetting the UFS device during initialization */
> > +     bootph-pre-ram;
> > +     bootph-some-ram;
> > +};
> > +
>
> Is it always GPIO4 for the reset GPIO for UFS? Seems like something that
> should probably be put in a board -u-boot.dtsi instead?

It is in fact always GPIO4 pin D0. It's multiplexed to a
somehow-hardware-controlled pin inconspicuously called UFS_RSTn within
VCCIO7_IOC_GPIOD_IOMUX_SEL_L, but I couldn't find how it's supposed to
operate in a hardware-controlled mode (it's not described in the TRM).
Mainline Linux does the same thing as I do here (GPIO mode [1]), while
Rockchip's own U-boot code switches the pin to the hardware-controlled
mode [2] and never touches anything about device resets from then on -
which feels like a potentially fragile black box to me. Hardware
controlled mode would also deviate from the upstream DT binding, as it
stipulates a GPIO for device resets [3].

[1] https://github.com/torvalds/linux/blob/master/drivers/ufs/host/ufs-rock=
chip.c#L220-L231
[2] https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/ufs/ufs-=
rockchip.c#L222
[3] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/ufs/rockchip%2Crk3576-ufshc.yaml#L53-L58

> >   &ioc_grf {
> >       bootph-all;
> >   };
> > @@ -176,6 +182,11 @@
> >       bootph-pre-ram;
> >   };
> >
> > +&ufshc {
> > +     bootph-pre-ram;
> > +     bootph-some-ram;
> > +};
> > +
> >   &xin24m {
> >       bootph-all;
> >   };
> > diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/in=
clude/asm/arch-rockchip/bootrom.h
> > index b15938c021d6..f9ecb6858f04 100644
> > --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> > +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> > @@ -51,6 +51,7 @@ enum {
> >       BROM_BOOTSOURCE_SPINOR =3D 3,
> >       BROM_BOOTSOURCE_SPINAND =3D 4,
> >       BROM_BOOTSOURCE_SD =3D 5,
> > +     BROM_BOOTSOURCE_UFS =3D 7,
>
> Hopefully this will be the same value for all upcoming SoCs with UFS
> (and not used for something else :) ).

Well it's hard to guarantee (otherwise Jonas wouldn't have had to add
a translation function [4] for the IDs that changed in RK3576). Maybe
at some point we'll have to switch to a lookup table per each SoC
variant if these keep changing, but thankfully that point is not today
:)

[4] https://source.denx.de/u-boot/u-boot/-/commit/99a9b6ba6cf1c2f376e6f0ac3=
e6a2ced6c6addd4

> >       BROM_BOOTSOURCE_I2C =3D 8,
> >       BROM_BOOTSOURCE_SPI =3D 9,
> >       BROM_BOOTSOURCE_USB =3D 10,
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kc=
onfig
> > index 92bb4aa62f11..483a2f7c4ab2 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -436,6 +436,9 @@ config ROCKCHIP_RK3576
> >       imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> >       imply SPL_CLK
> >       imply SPL_DM_SEQ_ALIAS
> > +     imply SPL_DM_GPIO if UFS_ROCKCHIP && SPL_UFS_SUPPORT
> > +     imply SPL_DM_RESET if UFS_ROCKCHIP && SPL_UFS_SUPPORT
> > +     imply SPL_GPIO if UFS_ROCKCHIP && SPL_UFS_SUPPORT
> >       imply SPL_FIT_SIGNATURE
> >       imply SPL_LOAD_FIT
> >       imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> > diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-roc=
kchip/rk3576/rk3576.c
> > index a1e8a7572fa4..46cf60dc77c7 100644
> > --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> > +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> > @@ -46,6 +46,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE =
+ 1] =3D {
> >       [BROM_BOOTSOURCE_FSPI0] =3D "/soc/spi@2a340000/flash@0",
> >       [BROM_BOOTSOURCE_FSPI1_M1] =3D "/soc/spi@2a300000/flash@0",
> >       [BROM_BOOTSOURCE_SD] =3D "/soc/mmc@2a310000",
> > +     [BROM_BOOTSOURCE_UFS] =3D "/soc/ufshc@2a2d0000",
> >   };
> >
> >   static struct mm_region rk3576_mem_map[] =3D {
> > diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-ro=
ckchip/spl-boot-order.c
> > index 6572dde29f65..d2dd5e10935f 100644
> > --- a/arch/arm/mach-rockchip/spl-boot-order.c
> > +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> > @@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
> >       if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &par=
ent))
> >               return BOOT_DEVICE_SPI;
> >
> > +     if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
> > +             return BOOT_DEVICE_UFS;
> > +
> >       return -1;
> >   }
> >
> > @@ -231,6 +234,17 @@ int spl_decode_boot_device(u32 boot_device, char *=
buf, size_t buflen)
> >               return -ENODEV;
> >       }
> >
> > +     if (boot_device =3D=3D BOOT_DEVICE_UFS) {
> > +             ret =3D uclass_find_device(UCLASS_UFS, 0, &dev);
> > +             if (ret) {
> > +                     debug("%s: could not find device for UFS: %d\n",
> > +                           __func__, ret);
> > +                     return ret;
> > +             }
> > +
> > +             return ofnode_get_path(dev_ofnode(dev), buf, buflen);
> > +     }
> > +
> >   #if CONFIG_IS_ENABLED(BLK)
> >       dev_num =3D (boot_device =3D=3D BOOT_DEVICE_MMC1) ? 0 : 1;
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 74c267dfc4e5..d35f3904e404 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -99,6 +99,15 @@ config RESET_ROCKCHIP
> >         though is that some reset signals, like I2C or MISC reset multi=
ple
> >         devices.
> >
> > +config SPL_RESET_ROCKCHIP
> > +     bool "SPL reset controller driver for Rockchip SoCs"
> > +     depends on SPL_DM_RESET && ARCH_ROCKCHIP && CLK
> > +     default y
> > +     help
> > +       Support for the reset controller on Rockchip SoCs in SPL. Selec=
t this
> > +       if you observe any reset-related warnings or errors when bootin=
g SPL,
> > +       such as when using UFS storage
> > +
>
> Separate patch for this please.

Ack

> >   config RESET_HSDK
> >       bool "Synopsys HSDK Reset Driver"
> >       depends on DM_RESET && TARGET_HSDK
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index ee5b009d1341..dc7d3b610e6e 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -16,7 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) +=3D reset-bcm6345.o
> >   obj-$(CONFIG_RESET_UNIPHIER) +=3D reset-uniphier.o
> >   obj-$(CONFIG_RESET_AST2500) +=3D reset-ast2500.o
> >   obj-$(CONFIG_RESET_AST2600) +=3D reset-ast2600.o
> > -obj-$(CONFIG_RESET_ROCKCHIP) +=3D reset-rockchip.o rst-rk3528.o rst-rk=
3576.o rst-rk3588.o
> > +obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) +=3D reset-rockchip.o rst-rk3528=
.o rst-rk3576.o rst-rk3588.o
>
> Separate patch for this please.

Ack

Thanks a lot,
Alexey
