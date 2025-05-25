Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148CEC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 17:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E420982B37;
	Sun, 25 May 2025 19:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NmYqTfoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2D182B48; Sun, 25 May 2025 19:36:08 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78D982B34
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 19:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2c2504fa876so504972fac.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748194564; x=1748799364; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxQyLtFvoz0rdNz2tRV+ZXriFAxkVtsoqkivJhDUUt8=;
 b=NmYqTfoegBKKtT54p+GxEvGIHYzQ9HqUosBjtmgAnoK2abYlUXplZKzopM8rZoXxmN
 fn0QwMxoqga01wVyInkpLHgc6Eui8I4REtfh2zythTJKFg3hePMXVT6uNb1As86bzP9u
 28NDY+h7EDeP0E3wicCq3dUYbbg6ezrrU52iEeb1EJFUllFlTpfTEBgXrSFCkkuthvvX
 p91TGutUw4p8Equnvhs3tvQCjII096Gu9iJvhlMqm4QgmXIaT+HyWZJxsuBQKmB1Szzg
 yx9tv0xWzHQXVlsNtO0Qa0E5+M1iZbHZTqj+vd1JDKUvnQ/MUtNcDTXUDl7w/8eYssSs
 Fcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748194564; x=1748799364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxQyLtFvoz0rdNz2tRV+ZXriFAxkVtsoqkivJhDUUt8=;
 b=WTmjS58zEdKgdV9EFHt2vAiVpPhJ1WDy6H1adt+YYVNyiIBk0JXT88f46j5ik0Z30V
 qTScKxfv2x7uyIv3YbUrKwUOBBretRLhiS1gHxGGYn1YC+DZJ8wMbpx2E30U16ujGW/W
 0ZhBKF0DXBrkAxXFvUQEGTaJMTThg46PO/IMK6mV+7RCGpsR+e5MYF+XqlrzSop4l5Vl
 hUeeFVafbgPO0kuVBIzofDDR6TBOW4uYwVkFGOx2gzNi4ImXP5jObGrrlvrZgVSwlw/D
 ZT8dgReLIhz59IwQlW//nY5aZpHjzKcvjHumXHUnKsa2F/nslSlKsz7OlfGUnB88iEDX
 riMQ==
X-Gm-Message-State: AOJu0YwqzXD0dPIVAMmRJ8Y+rIhAYXQY7AUw2Kn+9DH47+WiCMk0rn1F
 zxFUpE3bJy39xxRcFmFK0u2Gi5BgLCtkqWPjviRnbZzYRMDYmmL1vCFc62wFxobyPEIqCDG6eDs
 CYvNnwoFVR2zJiHuW3yjhD/OEsznEAF4=
X-Gm-Gg: ASbGncs+3lHQTgr06G0eCBcTSP31AaFztEaCZ9qKjP6E+XPjj4gh87Q4bFyh3JvMVqj
 p29Tc1G73HbWI1IiC+5nRU+8sLlWXiepqtWQfIhiYxBgRYLeHF1muKkjOnU7AE86uvGKMW0cigs
 Lrmefbo6XM68fQhjz1iUDUbNZGNZIiZqc=
X-Google-Smtp-Source: AGHT+IHjQH4xm3upl5cUYIezEbcG7pyBZsVwbSnnungElaukF0RlMf/+1Qvx2KvfLAphCCxnq3nYzTN7fN6hzXulxTA=
X-Received: by 2002:a05:6870:7812:b0:2d8:957a:5176 with SMTP id
 586e51a60fabf-2e861d43e6bmr3855094fac.5.1748194564043; Sun, 25 May 2025
 10:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250524142258.297397-1-alexthreed@gmail.com>
 <65b2368d-fed5-4633-b9e6-25ab9d151d1e@kwiboo.se>
 <5aecf685-07fd-4cc5-88f4-9624c78aac03@kwiboo.se>
In-Reply-To: <5aecf685-07fd-4cc5-88f4-9624c78aac03@kwiboo.se>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Sun, 25 May 2025 20:35:52 +0300
X-Gm-Features: AX0GCFsRccjBlmHDJ-dCnuA_GOvr7IoKjJ2YZ4irtINl_JVlGxDdbeHP_-4cEm8
Message-ID: <CAF4oh-O2WnVt-U6M=vo8O=ms1WN7iUHFca8gc9nYpLYPSs6XQA@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3328: Fix Synchronous Abort on usb start
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Oops, I forgot Reply-All and some messages missed list. Sorry about that.

Jonas and I have found NULL pointer dereference in rockchip_usb2phy_clkout_=
ctl:
https://github.com/u-boot/u-boot/blob/df2ed552f0b05591090369a7fe7ddc92439de=
a5c/drivers/phy/rockchip/phy-rockchip-inno-usb2.c#L177

Here rockchip_usb2phy_clkout_ctl tries to read from
`dev_get_priv(parent)->phy_cfg`
but it is NULL because rockchip_usb2phy_probe is not yet called.

Johnas, I have dug the problem a little further and found something interes=
ting.
We have circular dependency between rockchip-inno-usb2 clock/phy initialisa=
tion
here. The rockchip-inno-usb2 phy node also acts as a parent clock for itsel=
f.
Parent clocks now are enabled as part of the probe process before dev->prob=
e
call, but this particular clock depends on phy. Here is relevant code:
https://github.com/u-boot/u-boot/blob/df2ed552f0b05591090369a7fe7ddc92439de=
a5c/drivers/core/device.c#L572

Quick and dirty solution would be to just ignore rockchip_usb2phy_clk_enabl=
e
when the phy node is not yet probed. USB works fine with this check added,
exactly as before the recent parent clock enablement commit that introduced
this issue:
ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting"=
).

Clean solution would probably be to break dependency cycle, but I'm not
proficient enough with uboot codebase to propose such solution.
I've tried to move some of rockchip_usb2phy_probe initialisation code to
rockchip_usb2phy_of_to_plat to make it run before clock initialisation.
But I have failed on `priv->reg_base =3D syscon_get_regmap(dev_get_parent(d=
ev))`
which needs a parent node to be probed (I unsure is it OK to probe parent f=
rom
of_to_plat).

If we settle on a quick fix, I propose to add to rockchip_usb2phy_clk_enabl=
e
something like (Johnas, please let me know if it have some flaw over your
patch):
  struct rockchip_usb2phy *parent_priv =3D dev_get_priv(dev_get_parent(clk-=
>dev));
  if (!parent_priv->phy_cfg) {
      return 0;
  }



On Sat, May 24, 2025 at 8:43=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> On 2025-05-24 18:02, Jonas Karlman wrote:
> > Hi Alex,
> >
> > On 2025-05-24 16:20, Alex Shumsky wrote:
> >> Remove incorrect assigned-clock-parents in rk3328-u-boot.dtsi.
> >> This incorrect parent has become a problem since recent commit with pa=
rent
> >> clock enablement.
> >>
> >> Currently assigned-clock-parents is not a CLK node, but rk3328-usb2phy=
.
> >> It looks like a mistake in dts made a long time ago (~8 years ago).
> >
> > No, this is very much correct, u2phy is a clk provider as can be seen
> > by the use of the '#clock-cells' prop so being able to use it as a
> > parent clk is allowed and the device tree is correct.
> >
> >>
> >>   =3D> usb start
> >>   starting USB...
> >>   Bus usb@ff580000: "Synchronous Abort" handler, esr 0x96000210, far 0=
x4
>
> I have now tried to re-create this issue using latest master branch on a
> rk3328 board, however I was only able to re-create a different issue.
>
> On what board and U-Boot version/commit are you seeing this issue?
>
> The issue I faced was due to only enable usb20_otg and not u2phy_otg,
> something that could be fixed with following diff:
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/=
rockchip/phy-rockchip-inno-usb2.c
> index 88b33de1b2a0..d6ce12b5e83d 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -538,7 +538,7 @@ U_BOOT_DRIVER(rockchip_usb2phy_clock) =3D {
>
>  U_BOOT_DRIVER(rockchip_usb2phy) =3D {
>         .name   =3D "rockchip_usb2phy",
> -       .id     =3D UCLASS_PHY,
> +       .id     =3D UCLASS_NOP,
>         .of_match =3D rockchip_usb2phy_ids,
>         .probe =3D rockchip_usb2phy_probe,
>         .bind =3D rockchip_usb2phy_bind,
>
> Regards,
> Jonas
>
> >>
> >> Linux dts source reference:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dc60c0373a5e85d8bd0bb026cd5440576249d2299
> >>
> >> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while =
reparenting")
> >> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> >> ---
> >>
> >>  arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-b=
oot.dtsi
> >> index b0e50a973a..39dcc2313b 100644
> >> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> >> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> >> @@ -150,6 +150,10 @@
> >>      bootph-all;
> >>  };
> >>
> >> +&u2phy {
> >> +    /delete-property/ assigned-clock-parents;
> >> +};
> >
> > We should fix the driver code and not modify the device tree to fit the
> > code.
> >
> > The u2phy ofnode is tied to multiple uclass drivers so is it possible
> > that the parent clock lookup from commit ac30d90f3367 ("clk: Ensure the
> > parent clocks are enabled while reparenting") is not getting the
> > UCLASS_CLK driver?
> >
> > Regards,
> > Jonas
> >
> >> +
> >>  #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> >>  &binman {
> >>      simple-bin-spi {
> >
>
