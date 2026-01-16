Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EC2C982C7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 14:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9EA83923;
	Fri, 16 Jan 2026 15:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXL1f6P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E844D83623; Fri, 16 Jan 2026 15:29:56 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5273082BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 15:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-501c6665144so21346841cf.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768573793; x=1769178593; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5Z46llbAWEq1nVfbOtRkp2hDpe8NBwM/rJZoLYInrU=;
 b=gXL1f6P3gHHvzcNfw/yLf+dYm345T7vKuXKtTw/JnOTKAryJOdpH2vehYyN14SK1UI
 gNro46FqYFbG2f3RXe5XWnzSChKaYiLi3WgInPnqUAZnbEX7uZBOzQFWS7aLFyxDaNjt
 m5iPJ8aHFbDn8i2Jtuwh23QserO3MuqARfCuUJF78CfUSr4+SbQ3d1mJ7XhVzz6PsygK
 /tQmYngGVO43IFrMLXG/GyC/QyZVhMfEmOzk8YG2PKNZjuKQSgS5mUNku6iKuhkTnBxM
 3+yl8Dm5LL8RwJpo2Acu5ZSteb+/mFaaiP3k3HvBJjRxqttTXk4DymcwgmrLGHYIaEwB
 Wjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768573793; x=1769178593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5Z46llbAWEq1nVfbOtRkp2hDpe8NBwM/rJZoLYInrU=;
 b=HD4AquKdygrde5WMRr6jCIzbIHOakP8G50jQmJk3Fkzn+d/JVSr6zOgpRxE39cPYvL
 NqetRFpo25oXG6CEFrw17Gk8zSA8/3yJo6RuUgA8Hrrm646OBuaDrzgeG9kDh9d4EFIN
 kXUv5YzFmNHnJog5MV2+WFygfQaT1BeZYSo3X//DeASUAs4xp6jAhCxfrIIo04w5Wm7j
 Nt7oU2UajaUGTlDcn0ukXkKZMdUkskhO3qnisnObICCzhjfLm9tnKrVzJiV0rb3+X7H8
 3Q02HtF54OhOOg8ZlKEk+gawDpA6R9Mw263maW91t9NguLSqhtFCwKOCxPcolZOzLAsD
 yldA==
X-Gm-Message-State: AOJu0YwkIYQW5m59CGQPhMNmQ2XGqxL4807QCIKpkwRbmMnCL1k9LbCV
 KilYwZ+gpsnkxcbEaRaSUIdpq9if+xUvIbDb8R+j3yQxghuN1N+/hktVMYoiNRTqpxLBrUJu8lD
 mzlcUPHVLbOE2BJae9Ot1QUbgg9tunZ4=
X-Gm-Gg: AY/fxX5k/+AFhZcOsiamsNLF0EPWpyx0Q1/YIaw/+BqiNuOKL/ny1WVo4Q2kww8Ac7g
 prPs4zDQilxreTJ+JZNkSt1wSte+ULc99lAKx+mAMq09v4ailDqauL6rurYkrjdk701OEX5of+2
 10zQsYmMtKVWGCkjv20zaJcAHp1bmkLCyTmqRrh6k39CqtDmliSlONZZdprSKK4rcYm/xQ44k0V
 chm+DgUdY/MXd4r2pCfAhPL/nF9QAf2coVwZPoXXPUVKfjALlk5Aq3pXMqzA82WqKXOQPFcKSpU
 uP1kLXxiXnvldTsV9xvw/xnUuz0=
X-Received: by 2002:ac8:57d2:0:b0:4f1:e988:d786 with SMTP id
 d75a77b69052e-502a1fac726mr37533941cf.80.1768573792904; Fri, 16 Jan 2026
 06:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-3-e8e67649f3f8@gmail.com>
 <f6e97d23-4f92-43d1-a3b9-beeef3211145@cherry.de>
 <CABjd4Yzf-y05Qp3+5LVFrHeN_MMZu9TOXozrkjnXVU2MJU_WoQ@mail.gmail.com>
 <3b1184ab-f995-4b86-a2f0-65a5163be9c1@cherry.de>
In-Reply-To: <3b1184ab-f995-4b86-a2f0-65a5163be9c1@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 16 Jan 2026 18:29:38 +0400
X-Gm-Features: AZwV_QhP3Ss8xarBhXXbpc3nL_AJklQWj-28ACKBMbMC_bOwQuSwtwo2YdDzrxE
Message-ID: <CABjd4YxGYd6TVJEE3Nh9Qd6DQ+aKN09BP2u5+OBPcc8tNwpTJA@mail.gmail.com>
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
X-Mailman-Approved-At: Fri, 16 Jan 2026 15:56:25 +0100
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

On Fri, Jan 16, 2026 at 2:50=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 1/16/26 11:08 AM, Alexey Charkov wrote:
> > Hi Quentin,
> >
> > On Wed, Jan 14, 2026 at 10:05=E2=80=AFPM Quentin Schulz
> > <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 1/8/26 6:50 PM, Alexey Charkov wrote:
> >>> Add the required architecture-specific lookups to enable U-boot SPL t=
o
> >>> load images from UFS storage devices on Rockchip RK3576, which has a
> >>> boot ROM capable of loading the SPL image from UFS.
> >>>
> >>> This also requires the DM_RESET framework to be available in SPL, as
> >>> the UFS driver uses it.
> >>
> >> If it is a hard dependency, why is it not specified as such in the
> >> symbol directly instead of relying on imply's at the ARCH level? This
> >> will also be "painful" once a new Rockchip SoC has UFS support as we'l=
l
> >> need to forget not to add those imply.
> >
> > Fair enough, will convert it into a "select" under Rockchip UFS,
> > thanks for pointing it out!
> >
>
> Watch out for select, it may not be doing what you want, see
> https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html#menu-=
attributes
> at the notes in the select bullet item.

Ouch. Alright, thank you for pointing it out.

> >>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >>> ---
> >>>    arch/arm/dts/rk3576-u-boot.dtsi              | 13 ++++++++++++-
> >>>    arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
> >>>    arch/arm/mach-rockchip/Kconfig               |  3 +++
> >>>    arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
> >>>    arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++++
> >>>    drivers/reset/Kconfig                        |  9 +++++++++
> >>>    drivers/reset/Makefile                       |  2 +-
> >>>    7 files changed, 41 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-=
boot.dtsi
> >>> index dc3771b556a3..84d9f39fd407 100644
> >>> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> >>> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> >>> @@ -12,7 +12,7 @@
> >>>        };
> >>>
> >>>        chosen {
> >>> -             u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &sdhci=
;
> >>> +             u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &sdhci=
, &ufshc;
> >>>        };
> >>>
> >>>        dmc {
> >>> @@ -81,6 +81,12 @@
> >>>        bootph-some-ram;
> >>>    };
> >>>
> >>> +&gpio4 {
> >>> +     /* Used for resetting the UFS device during initialization */
> >>> +     bootph-pre-ram;
> >>> +     bootph-some-ram;
> >>> +};
> >>> +
> >>
> >> Is it always GPIO4 for the reset GPIO for UFS? Seems like something th=
at
> >> should probably be put in a board -u-boot.dtsi instead?
> >
> > It is in fact always GPIO4 pin D0. It's multiplexed to a
>
> This is probably the typical Rockchip BS :) It is the "same" for SD CD
> or WP pins. They have a hardware-controlled mode for pin A which is
> usually a black box for SW (nothing to do, it "works"). But nothing
> prevents you from using another GPIO for that (just have to be careful
> about the voltage level I guess, here it seems to be 1.2V for the
> domain, which isn't that usual I guess.

I bet that the boot ROM might get picky there, and only work with
GPIO4_D0. But if the UFS chip is not meant to be used as the primary
boot device - sure, can't see why not. On the other hand, there's not
much direct gain for board designers from using a different pin, and
people tend to just stick with Rockchip reference schematics unless
something different is explicitly required for their design, so my
money is on "it will be GPIO4 for all RK3576 boards".

Extra consideration in the same stream: the pin itself is defined in
rk3576.dtsi upstream, not in board-specific .dts files.

> > somehow-hardware-controlled pin inconspicuously called UFS_RSTn within
> > VCCIO7_IOC_GPIOD_IOMUX_SEL_L, but I couldn't find how it's supposed to
> > operate in a hardware-controlled mode (it's not described in the TRM).
>
> I guess it automagically does stuff in the silicon when initializing (or
> doing a controller reset for example, don't know). Your guess is as good
> as mine :)
>
> > Mainline Linux does the same thing as I do here (GPIO mode [1]), while
> > Rockchip's own U-boot code switches the pin to the hardware-controlled
> > mode [2] and never touches anything about device resets from then on -
> > which feels like a potentially fragile black box to me. Hardware
>
> Yes, we've had our share of SD CD signal issues with the
> hardware-controlled one. I actually switched one of our devices to use
> GPIO instead (see
> https://elixir.bootlin.com/linux/v6.18.5/source/arch/arm64/boot/dts/rockc=
hip/rk3588-tiger-haikou.dts#L272),
> so I understand not wanting to rely on that ;)

Indeed. Also Shawn's recent series for RK3576 to a similar effect [1]

[1] https://lore.kernel.org/linux-rockchip/1768524932-163929-1-git-send-ema=
il-shawn.lin@rock-chips.com/

> > controlled mode would also deviate from the upstream DT binding, as it
> > stipulates a GPIO for device resets [3].
> >
>
> Not asking for this, rather wondering if we should really have this at
> the SoC level rather than the board level. If it can be any GPIO why
> forcing all boards to have GPIO4 bank "enabled" in SPL + U-Boot proper
> before reloc. It isn't the first SoC to have that (also see all SoC
> u-boot.dtsi having the UART controller from the reference design
> "enabled"), and I don't think it's planned for us to have a product on
> it, so... not a blocker from my side :)

I believe that the boards which don't use UFS for early boot will just
compile it out, together with the respective GPIO code. Then the only
downside for them is a marginally larger SPL DTB - but not on a scale
that matters for RK3576. And those that use UFS for early boot will
likely want it to be on the pin expected by the boot ROM, then having
the prerequisites already defined makes life easier for them (and it's
not much different from having e.g. FSPI0/1 and eMMC enabled by
default even for boards that don't use them).

> > [1] https://github.com/torvalds/linux/blob/master/drivers/ufs/host/ufs-=
rockchip.c#L220-L231
> > [2] https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/ufs/=
ufs-rockchip.c#L222
> > [3] https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/ufs/rockchip%2Crk3576-ufshc.yaml#L53-L58
> >
> >>>    &ioc_grf {
> >>>        bootph-all;
> >>>    };
> >>> @@ -176,6 +182,11 @@
> >>>        bootph-pre-ram;
> >>>    };
> >>>
> >>> +&ufshc {
> >>> +     bootph-pre-ram;
> >>> +     bootph-some-ram;
> >>> +};
> >>> +
> >>>    &xin24m {
> >>>        bootph-all;
> >>>    };
> >>> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/=
include/asm/arch-rockchip/bootrom.h
> >>> index b15938c021d6..f9ecb6858f04 100644
> >>> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> >>> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> >>> @@ -51,6 +51,7 @@ enum {
> >>>        BROM_BOOTSOURCE_SPINOR =3D 3,
> >>>        BROM_BOOTSOURCE_SPINAND =3D 4,
> >>>        BROM_BOOTSOURCE_SD =3D 5,
> >>> +     BROM_BOOTSOURCE_UFS =3D 7,
> >>
> >> Hopefully this will be the same value for all upcoming SoCs with UFS
> >> (and not used for something else :) ).
> >
> > Well it's hard to guarantee (otherwise Jonas wouldn't have had to add
> > a translation function [4] for the IDs that changed in RK3576). Maybe
> > at some point we'll have to switch to a lookup table per each SoC
> > variant if these keep changing, but thankfully that point is not today
> > :)
> >
>
> See
> https://lore.kernel.org/devicetree-spec/ebc08400-c16d-4ed0-b487-9aabe13bb=
f0f@pengutronix.de/

Ooooh that sounds like a discussion that can potentially stretch out
for a long time. I'd much rather use a value that works for the only
chip where it matters now (RK3576), then solve the problem whenever it
arises (if it does). After all, bootrom.h is not ABI, and DT is, so it
is much easier to fix up bootrom.h without stepping on too many toes.

Furthermore, I'm not even sure that /chosen/bootsource can address the
issue here, because boot ROM's won't magically start passing DT
phandles to the bootloader, so there will still be an ID->node lookup
table somewhere in early code (with potentially per-SoC overrides).
Which is exactly what we have here.

Thanks a lot,
Alexey
