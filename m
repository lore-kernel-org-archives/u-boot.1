Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD2DC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB7581F0D;
	Sat,  7 Jun 2025 14:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQBAKIq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EB64826AA; Sat,  7 Jun 2025 14:19:23 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F2280E9A
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 14:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3db6ddcef4eso26516415ab.2
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749298759; x=1749903559; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyUwk4OZKt5Soi+7k3U8DpeEIX414y4hhw52ZbpuxqQ=;
 b=kQBAKIq6u7pCmmP/lAigFeSFs12Yh5fqY4B5ba7IQyUMQzS+VhGw+euPL+JX7jog4Y
 WGZ/TFGOj/6MOXfTYsYMavMPVnfwi9YHkjhd/t5xJjDWFluGL88bySbKUlewKVP3VLMq
 qvogn5lTUtHvyLqxaIbA7ujrp8EYq49OcNfrGyTKS872/ZtfV1ePympXHOa0+DzMAK6b
 CuBl4gefo7sx9DCT59Rf25TDL4rq8ZekcJsH/xN/YRVpTGGyeNYFaYalOs5dw3quGLMX
 oW5sssPIqFTttpXRWO+h1ar/WQkpkCCWsznlweckmfEXqBQHxgxL2OtMFNUrtWqni1Lk
 Tamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749298759; x=1749903559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyUwk4OZKt5Soi+7k3U8DpeEIX414y4hhw52ZbpuxqQ=;
 b=byl+JGldJDwgvN2IVjljNfY6TjIo1AE08uIONBdq9IAJX0DJqShzgWscFf6FqifS6E
 ytmfC3tz9VNeCzMeMRrcRe+QfDtNq0LFS/YbwGTwhbh3IY+e0zq3BY2zVqCShHdlElHr
 8wZEFq2DvsfNn1FyKHPGIKfPmYVeehbOMSSNUqsJwNtgftjU2feBaJxhrfKuwAY+QLa1
 I2d4LM/nGDSvcylU+EJfkgShRwb8sn5EbFuJti8ZL6WsgW/80/E8qD4QzQpmCqq57c8c
 +RDjYLSKYT24tH4jYuFRCnKqpuXACsiqg0SHnmNIlycPVAuz5/HDglD86dHCwghCBt9I
 Y94w==
X-Gm-Message-State: AOJu0YxcQwDgwm3uZlwtdlWFT+uxcKEC0HXk3vEtPHyv5vijtohbHN75
 voe7Db6yozVBaXCyCb9NCVydW1kuSjRvzDEeu4NibLeaIBobdbFTvxMU3lfM7eMqKZv8qIZpg5d
 JXieHwM+mIgWr0xyUPAGEjxwTFOWXv2V+lcFpFac=
X-Gm-Gg: ASbGncuPzTs973kUM+MCpQE4GaMGqr6wUpfOwxJ3DU7pLrXN+1x72uKN71/ZAEGGv9K
 OhkIE90T3JdN7k+7tzJnekLniDywi+BQVuwsAOtyNoIE2ctRIw9ta9tRJgQCOsBVGAr/0EThYBf
 OW1GS4gxxa8BK3G2g6BA4Hio9WacpGtxw=
X-Google-Smtp-Source: AGHT+IFlIjejp2Q4U/HgR9+ZW8x82QiMHencOkmGaBaARI68M8yEg3LwkKrkHqUTwvAuIZX2Vrs8YNxsjMPmWUZogCA=
X-Received: by 2002:a05:6871:d409:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2ea01565c0cmr4191685fac.36.1749298749267; Sat, 07 Jun 2025
 05:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250524142258.297397-1-alexthreed@gmail.com>
 <65b2368d-fed5-4633-b9e6-25ab9d151d1e@kwiboo.se>
 <5aecf685-07fd-4cc5-88f4-9624c78aac03@kwiboo.se>
 <CAF4oh-O2WnVt-U6M=vo8O=ms1WN7iUHFca8gc9nYpLYPSs6XQA@mail.gmail.com>
In-Reply-To: <CAF4oh-O2WnVt-U6M=vo8O=ms1WN7iUHFca8gc9nYpLYPSs6XQA@mail.gmail.com>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Sat, 7 Jun 2025 15:18:57 +0300
X-Gm-Features: AX0GCFvV6FCaqdAUj_jLKpQh-BFKOvrczsfeZkeI2tn08WT0KClDQrKKpbkZVaQ
Message-ID: <CAF4oh-M7AgDoy-=cuxwQEPh8F+iKmTkoh47tu0eXkzpcfWpepw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3328: Fix Synchronous Abort on usb start
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Sun, May 25, 2025 at 8:35=E2=80=AFPM Alex Shumsky <alexthreed@gmail.com>=
 wrote:
>
> Oops, I forgot Reply-All and some messages missed list. Sorry about that.
>
> Jonas and I have found NULL pointer dereference in rockchip_usb2phy_clkou=
t_ctl:
> https://github.com/u-boot/u-boot/blob/df2ed552f0b05591090369a7fe7ddc92439=
dea5c/drivers/phy/rockchip/phy-rockchip-inno-usb2.c#L177
>
> Here rockchip_usb2phy_clkout_ctl tries to read from
> `dev_get_priv(parent)->phy_cfg`
> but it is NULL because rockchip_usb2phy_probe is not yet called.
>
> Johnas, I have dug the problem a little further and found something inter=
esting.
> We have circular dependency between rockchip-inno-usb2 clock/phy initiali=
sation
> here. The rockchip-inno-usb2 phy node also acts as a parent clock for its=
elf.
> Parent clocks now are enabled as part of the probe process before dev->pr=
obe
> call, but this particular clock depends on phy. Here is relevant code:
> https://github.com/u-boot/u-boot/blob/df2ed552f0b05591090369a7fe7ddc92439=
dea5c/drivers/core/device.c#L572
>
> Quick and dirty solution would be to just ignore rockchip_usb2phy_clk_ena=
ble
> when the phy node is not yet probed. USB works fine with this check added=
,
> exactly as before the recent parent clock enablement commit that introduc=
ed
> this issue:
> ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparentin=
g").
>
> Clean solution would probably be to break dependency cycle, but I'm not
> proficient enough with uboot codebase to propose such solution.
> I've tried to move some of rockchip_usb2phy_probe initialisation code to
> rockchip_usb2phy_of_to_plat to make it run before clock initialisation.
> But I have failed on `priv->reg_base =3D syscon_get_regmap(dev_get_parent=
(dev))`
> which needs a parent node to be probed (I unsure is it OK to probe parent=
 from
> of_to_plat).
>
> If we settle on a quick fix, I propose to add to rockchip_usb2phy_clk_ena=
ble
> something like (Johnas, please let me know if it have some flaw over your
> patch):
>   struct rockchip_usb2phy *parent_priv =3D dev_get_priv(dev_get_parent(cl=
k->dev));
>   if (!parent_priv->phy_cfg) {
>       return 0;
>   }
>
>

Kindly ping Jonas and Kever.
How can we proceed with this issue to apply fix before the 2025.07 release?
Do some of my ideas from the previous message make sense to you?


>
> On Sat, May 24, 2025 at 8:43=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> w=
rote:
> >
> > On 2025-05-24 18:02, Jonas Karlman wrote:
> > > Hi Alex,
> > >
> > > On 2025-05-24 16:20, Alex Shumsky wrote:
> > >> Remove incorrect assigned-clock-parents in rk3328-u-boot.dtsi.
> > >> This incorrect parent has become a problem since recent commit with =
parent
> > >> clock enablement.
> > >>
> > >> Currently assigned-clock-parents is not a CLK node, but rk3328-usb2p=
hy.
> > >> It looks like a mistake in dts made a long time ago (~8 years ago).
> > >
> > > No, this is very much correct, u2phy is a clk provider as can be seen
> > > by the use of the '#clock-cells' prop so being able to use it as a
> > > parent clk is allowed and the device tree is correct.
> > >
> > >>
> > >>   =3D> usb start
> > >>   starting USB...
> > >>   Bus usb@ff580000: "Synchronous Abort" handler, esr 0x96000210, far=
 0x4
> >
> > I have now tried to re-create this issue using latest master branch on =
a
> > rk3328 board, however I was only able to re-create a different issue.
> >
> > On what board and U-Boot version/commit are you seeing this issue?
> >
> > The issue I faced was due to only enable usb20_otg and not u2phy_otg,
> > something that could be fixed with following diff:
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/ph=
y/rockchip/phy-rockchip-inno-usb2.c
> > index 88b33de1b2a0..d6ce12b5e83d 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > @@ -538,7 +538,7 @@ U_BOOT_DRIVER(rockchip_usb2phy_clock) =3D {
> >
> >  U_BOOT_DRIVER(rockchip_usb2phy) =3D {
> >         .name   =3D "rockchip_usb2phy",
> > -       .id     =3D UCLASS_PHY,
> > +       .id     =3D UCLASS_NOP,
> >         .of_match =3D rockchip_usb2phy_ids,
> >         .probe =3D rockchip_usb2phy_probe,
> >         .bind =3D rockchip_usb2phy_bind,
> >
> > Regards,
> > Jonas
> >
> > >>
> > >> Linux dts source reference:
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dc60c0373a5e85d8bd0bb026cd5440576249d2299
> > >>
> > >> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled whil=
e reparenting")
> > >> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> > >> ---
> > >>
> > >>  arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u=
-boot.dtsi
> > >> index b0e50a973a..39dcc2313b 100644
> > >> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> > >> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> > >> @@ -150,6 +150,10 @@
> > >>      bootph-all;
> > >>  };
> > >>
> > >> +&u2phy {
> > >> +    /delete-property/ assigned-clock-parents;
> > >> +};
> > >
> > > We should fix the driver code and not modify the device tree to fit t=
he
> > > code.
> > >
> > > The u2phy ofnode is tied to multiple uclass drivers so is it possible
> > > that the parent clock lookup from commit ac30d90f3367 ("clk: Ensure t=
he
> > > parent clocks are enabled while reparenting") is not getting the
> > > UCLASS_CLK driver?
> > >
> > > Regards,
> > > Jonas
> > >
> > >> +
> > >>  #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> > >>  &binman {
> > >>      simple-bin-spi {
> > >
> >
