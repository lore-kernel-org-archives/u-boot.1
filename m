Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A03FC3DA6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 01:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02DC876FF;
	Thu,  4 Jan 2024 02:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="moE+PYFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4E3876F6; Thu,  4 Jan 2024 02:41:04 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492C1876F6
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 02:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-680d4584a81so171686d6.1
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 17:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704332460; x=1704937260; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WEzbsnGce+aMru0gJZvwhsQOVaaH/4xCVorMel7D44=;
 b=moE+PYFxkn5kaxEZ6J7OprNgO3+3M4uenZS+gYZenrzFLEDthnWXPbTIX3sKZEsC/7
 dNFIf5SUG7BnhNaxHgAcApTGBAz9uwVnQ2xczw00QKsB2pLFtBG1/dQuqGpTg9BiUAuq
 IvzAJvyfjFmPynBCPOAVfjyWpPl0YktO2HVtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704332460; x=1704937260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3WEzbsnGce+aMru0gJZvwhsQOVaaH/4xCVorMel7D44=;
 b=nFgpGqVbzCJAURn5336lEf/TSMfHLpXY8xcExrs5mnfy0OxjxY5xYVCPB8kecUdT9/
 lgMNePAvTBnzbK94mppvaO9jEYZpOyqeBYAvzIqcKxgGFN1V7Y8es5mMcmxlcmmoIjSJ
 kXlA4+qMp2rCbmw1KLCWxoFir6iry3fyuSdX4uDbzFOo6D5cLAwFPsr7VZJihZ/Qoqz9
 POMoFPcCXUdgb274aKCTCBj22c5ZxhZK20rIpq/HYAd7w1v3gcZyvgxSQuNSv+IlkM0E
 6TIQIW/ayVSSCVQ4gLNh7bWUWuI332M79F0s0E0nEf0ZJHV13DNnPjgoLwvVnmowhDuW
 26vg==
X-Gm-Message-State: AOJu0YzD5ghWSZM0HbfKbzhItoembLu3+oLzlrDqh/12ytMnojbGE4Ih
 qqjSD6Jtrq7oygw4JcTUkd89xYpZjB4Qf6ARGxDoWirOZylU
X-Google-Smtp-Source: AGHT+IGxqUOtR3NIjlSKtZbDmcYLcvgj/R9RV+HSC9HPkHL7E0Wzob4owdL5HA29oThIhO3Hbg2EErrISlQln8+jkAQ=
X-Received: by 2002:a0c:e78b:0:b0:680:d21b:19d4 with SMTP id
 x11-20020a0ce78b000000b00680d21b19d4mr1931924qvn.38.1704332459962; Wed, 03
 Jan 2024 17:40:59 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
 <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
 <20231228204425.GQ2652760@bill-the-cat>
 <CALeDE9MfEd=xjwekR+oVPuWNR7TBPCMU6mc+Z7ig7tc1nhKu_Q@mail.gmail.com>
 <CAFLszTj0MQGUBcNqVTLZuOL=1YBD2pqL2+P8oLKqc5PnLq3GdA@mail.gmail.com>
 <20231231140127.GA2652760@bill-the-cat>
 <CAFLszTj0vdkZ+ch5-crygw7i3Mj8DO5=4naOWAwYMFNqGe0WWA@mail.gmail.com>
 <20240102145536.GK2652760@bill-the-cat>
 <CAFLszTgC6utx_hSOvO7VYubgbUS3CaWaPMnOnTXsvTD41mEVVA@mail.gmail.com>
 <20240103010340.GD1610741@bill-the-cat>
In-Reply-To: <20240103010340.GD1610741@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jan 2024 18:40:49 -0700
Message-ID: <CAFLszTiOSPyi9q1RatRyYZ1-7v7qKrwJommTFRh_o5z5kkbmRA@mail.gmail.com>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?Q?Andreas_Bie=C3=9Fmann?= <andreas@biessmann.org>, 
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>, 
 Minkyu Kang <mk7.kang@samsung.com>, Thomas Chou <thomas@wytron.com.tw>
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

Hi Tom,

On Tue, Jan 2, 2024 at 6:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 02, 2024 at 04:51:34PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, Jan 2, 2024 at 7:55=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Tue, Jan 02, 2024 at 07:06:36AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, Dec 31, 2023 at 7:01=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Sun, Dec 31, 2023 at 05:45:00AM -0700, Simon Glass wrote:
> > > > > > -Scott as it is bouncing
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Fri, Dec 29, 2023 at 9:46=E2=80=AFAM Peter Robinson <pbrobin=
son@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote=
:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <tri=
ni@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini =
<trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon=
 Glass wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > U-Boot builds devicetree binaries from its so=
urce tree. As part of the
> > > > > > > > > > > > > > > Kconfig conversion, the Makefiles were update=
d to align with how this
> > > > > > > > > > > > > > > is done in Linux: a single target for each So=
C is used to build all the
> > > > > > > > > > > > > > > .dtb files for that SoC.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Since then, the Makefiles have devolved in so=
me cases, resulting in
> > > > > > > > > > > > > > > lots of target-specific build rules. Also Lin=
ux has moved to using
> > > > > > > > > > > > > > > subdirectories for each vendor.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Recent work aims to allow U-Boot to directly =
use devicetree files from
> > > > > > > > > > > > > > > Linux. This would be easier if the directory =
structure were the same.
> > > > > > > > > > > > > > > Another recent discussion involved dropping t=
he build rules altogether.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This series makes a start at cleaning up some=
 of the build rules, to
> > > > > > > > > > > > > > > reduce the amount of code and make it easier =
to add new boards for the
> > > > > > > > > > > > > > > same SoC.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > One issue is that the ARCH_xxx Kconfig option=
s between U-Boot and Linux
> > > > > > > > > > > > > > > are not always the same. Given the large numb=
er of SoCs and boards
> > > > > > > > > > > > > > > supported by U-Boot, it would be useful to al=
ign these where possible.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't know why we should start with this now,=
 and further not being on
> > > > > > > > > > > > > > top of Sumit's series to remove our duplicate d=
ts files. And that's
> > > > > > > > > > > > > > where we can have the conversation about for wh=
ich cases it even makes
> > > > > > > > > > > > > > sense to build all of the dts files for a given=
 SoC.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is a completely different series - there are=
 no conflicts with
> > > > > > > > > > > > > Sumit's series so it can be applied before or aft=
er it.
> > > > > > > > > > > > >
> > > > > > > > > > > > > My goal here is to clean up our build rules, rath=
er than just throwing
> > > > > > > > > > > > > them all away, for reasons we have discussed prev=
iously. I filed [1]
> > > > > > > > > > > > > to track that.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, I'm saying we shouldn't be doing anything this=
 series does until
> > > > > > > > > > > > after Sumit's series has landed. Along with the fac=
t that I don't like
> > > > > > > > > > > > what's going on in this series.
> > > > > > > > > > >
> > > > > > > > > > > This seems to again be the disagreement over whether =
a single DT
> > > > > > > > > > > should be build for each board, or all the DTs for an=
 SoC?
> > > > > > > > > >
> > > > > > > > > > It's about the disagreement on what we should be buildi=
ng, and what that
> > > > > > > > > > infrastructure looks like. I do not like adding extra r=
ules for
> > > > > > > > > > "clarity" because they don't make things clearer, they =
lead to the
> > > > > > > > > > unclear mess we have today getting worse. Most instruct=
ions are _not_
> > > > > > > > > > "now take this dtb and this binary and .." but just "ta=
ke this binary",
> > > > > > > > > > because we already have the rules and logic to ensure w=
e build the
> > > > > > > > > > required dtbs. I also don't like the parts of this seri=
es that amount
> > > > > > > > > > to deck shuffling when we should just be taking the cha=
irs away. There's
> > > > > > > > > > just not nor will there be a case for omap3/4/5 platfor=
ms of "change the
> > > > > > > > > > dtb", so building more is pointless. For other SoCs, th=
ere may be some
> > > > > > > > > > cases of "this could have been just a DT change", like
> > > > > > > > > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig coul=
d share a board
> > > > > > > > > > dir, but the configs are different and the dts are diff=
erent, so I don't
> > > > > > > > > > know that you could really just swap the dtbs.
> > > > > > > > >
> > > > > > > > > It is true that we have a different defconfig for each bo=
ard, but IMO
> > > > > > > > > that is not good. It is an artifact of the way the build =
system works.
> > > > > > > > > IMO Kconfig should be used to define sensible defaults so=
 that the
> > > > > > > > > defconfigs are nearly empty. Perhaps config fragments can=
 be part of
> > > > > > > > > the mix, if we can agree on [1].
> > > > > > > > >
> > > > > > > > > But if we let this genie out of the bottle, it will be im=
possible to
> > > > > > > > > put back in. The devicetree should control the hardware i=
n U-Boot and
> > > > > > > > > it should be possible to use the same U-Boot proper on al=
l boards
> > > > > > > > > which use the same SoC.
> > > > > > > >
> > > > > > > > We've never been past the point where a few examples of clo=
sely related
> > > > > > > > boards can re-use the same U-Boot build and just change the=
 device tree.
> > > > > > > >
> > > > > > > > It's going to be very SoC specific if we can ever do things=
 like that,
> > > > > > > > and it will also likely in turn become a question of where =
did the
> > > > > > > > tricky bits that U-Boot used to do get shoved instead. You'=
re not going
> > > > > > > > to combine board/beagle/beagle/beagle.c and board/ti/omap3e=
vm/evm.c (and
> > > > > > > > ignoring all of the other omap3 boards) and get one binary =
that works on
> > > > > > > > both, and just uses DT. Let alone that no one wants to do t=
hat work.
> > > > > > > >
> > > > > > > > You've mentioned Rockchip before as maybe a better example,=
 but
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D3=
83579&state=3D* was
> > > > > > > > leading me to think that no, there's too much "this is what=
 THIS
> > > > > > > > hardware does" that means that no, there's going to be hard=
ware
> > > > > > > > variation that one must just handle in C. Or get more and n=
ew bindings
> > > > > > > > accepted upstream to try and make that be data driven, and =
also possibly
> > > > > > > > have to deal with "that's policy, not hardware" type argume=
nts and so
> > > > > > > > forth.
> > > > > >
> > > > > > Oh wow yes that is crazy! But you can always check the compatib=
le
> > > > > > string if really necessary. It would be nice to use a sysinfo d=
river
> > > > > > for this sort of thing. I should just be a full-time code revie=
wer...
> > > > > >
> > > > > > >
> > > > > > > Related I've seen issues with nearly identical rockchips devi=
ces that
> > > > > > > use different memory chips that as a result need different U-=
Boot
> > > > > > > builds because the early boot part needs to initialise a comp=
letely
> > > > > > > different set of memory and the two different sets of rules a=
ren't
> > > > > > > detectable at run-time nor are they even small enough to fit =
into
> > > > > > > smem.
> > > > > >
> > > > > > Some of the differences are real/important, like memory setting=
s, some
> > > > > > are not. For boards with enough SRAM that SPL can use DM/DT, we=
 can
> > > > > > deal with these.
> > > > > >
> > > > > > But even if SPL does need to be custom, that is better than hav=
ing a
> > > > > > full, separate U-Boot for every single board.
> > > > >
> > > > > I'm not sure that's a use case anyone else has or wants, and I di=
sagree
> > > > > that building a unique SPL and then more generic U-Boot is a win,=
 in
> > > > > practical and effort terms.
> > > >
> > > > Think about firmware update where you could have an update that
> > > > supports all rk3399 boards, rather than 110 separate (and duplicate=
)
> > > > firmware updates.
> > >
> > > I don't know who wants that actually is the problem I keep trying to
> > > bring up. In other words, you're saying that the differences between
> > > rock-pi-4c-rk3399_defconfig and khadas-edge-v-rk3399_defconfig are
> > > unintentional and it's just due to different device trees and I say
> > > they're intentional and the desire is not for a "kitchen sink" type
> > > rk3399 primary U-Boot build. My evidence for this goes back to the So=
Cs
> > > where we do have both "kitchen sink" and then board specific builds.
> > > This would be things like how there's the am65x_evm configs, which
> > > support all of the TI reference platforms (and others which follow th=
e
> > > EEPROM spec TI uses) and then also iot2050_defconfig, which also uses
> > > the am65x SoC, but does not (would not) support the TI EEPROM layout =
and
> > > instead does what it needs to do for their custom hardware revisions =
and
> > > support all of those, instead.
> >
> > OK, but this code should be in drivers which we can enable or disable,
> > wouldn't it?
>
> No, it's the board specific code. I mean I guess a few of the things
> like "read EEPROM and see if it follows $my layout spec" could be
> counted as a driver rather than board/$vendor/common/ code.  But the
> rest of it isn't. Please look at the board examples I've listed above.

Yes I agree those are unpleasant...but that is not the way it should
be done. We should have proper APIs and drivers for board-specific
things. If we can't do that, at least depend on a compatible string.
That sort of code would never be allowed in Linux, right?

>
> > We are trying to move away from board.c files.
>
> We are? I didn't know that. We're trying to get rid of board.h, yes. And
> some platforms where the rest of the firmware stack does everything else
> needed, yes, we can avoid having dummy board.c files. That's the kind of
> case where _maybe_ we could even have a generic-aarch64_defconfig (and
> other platforms too? I _think_ the most recent example that maybe you're
> thinking of was a MIPS-based router).

Maybe we could for U-Boot proper, yes. But think of all the drivers
you would have to enable...

>
> > I am not saying that all the defconfig differences are unintentional,
> > just that we should really rationalise them, so it is clear what needs
> > to be enabled for each board, and what is just by accident. Part of
> > that is using Kconfig more than defconfig.
>
> Yes, there might be some cases where the differences don't need to be
> there, and maybe rk3399 is an example where more vendor boards could be
> supported by a single config. But maybe not, there's a lot of annoying
> board specific things that we need to care about that the OS then just
> gets to inherit as having been handled.

Sure.

>
> > Another part might be
> > fragments if we can agree a way to describe a defconfig made up of
> > fragments ([2] is still hanging about).
>
> Yes, I'm confused by what you're saying now here since the series here
> is doing the opposite of what I thought you keep saying. This is making
> "am62x_beagleplay_a53" be a specific thing to build for instead of just
> making it be part of "am62x_evm_a53" as the only thing it changes is the
> default device tree. And we're already always building the beagleplay
> dtbs under the SoC name. That said, I'm not sure where functionally that
> series ended up since beagleplay wants a different environment for LED
> flashing and so forth.

I just think we are a bit lost here. To my reading that series creates
a fairly generic defconfig and then uses it on a few boards, with
minor variations. My point was that many of the differences are
unintentional or unnecessary. Yours is that many are intentional or
necessary. So I suspect we are in agreement, actually?

Any design decision involves tradeoffs and people have their own
weights on the things they care about, so will reach different
decisions or have different preferences. It is when one path is
completely closed off that things get difficult.

>
> > > What I think you keep wanting to aim for is fine and good and somethi=
ng
> > > platforms can opt in to, and we have some doing it today. But it's st=
ill
> > > at the end of the day a choice for the designers.
> >
> > Indeed. I just want to make it easier to be generic than to be specific=
.
>
> And in turn I don't know why we're hung up on "build more device trees"
> when the first problem I see is "make some generic faux-boards and prove
> them out".

OK

>
> > > You say "110 separate (and duplicate)" and I disagree with the "(and
> > > duplicate)" part of that. Could some platforms be condensed? Yes,
> > > likely. But figuring out how to do that starts with figuring out why
> > > they're separate to start with.
> >
> > I mean there are 110 rk3399 devicetree files in Linux. I count only 29
> > in U-Boot.
>
> I only see 41 dts files in v6.7-rc8 for "rk3399" and 27 defconfigs. So
> yes, there's probably some level already of one U-Boot defconfig handles
> N board revs. I agree there likely could be more.

Yes.

>
> > If we were to support Mediatek 8195, for example, we would ideally
> > like to support the Chromebooks and use a single Kconfig for all of
> > them. In general, if we make it easy, newer platforms will need to
> > follow the path of least resistance. The reason rk3399 is mostly
> > generic is that it was based on rk3288, which was written that way
> > from the start.
>
> Okay? A lot of the newer SoCs are done more generic than before,
> especially on aarch64 compared with arm32 as some of the very board
> specific stuff has been shoved to other parts of the stack already. I
> keep bringing up TI K3 stuff because it too is done generically but also
> we have in tree examples of intentionally NOT copying the reference
> hardware platform and having true unique changes that need to be
> handled.

OK. I see those as things to address, not fundamental flaws in the idea.

>
> > > > > The only win I see there is it would be part
> > > > > of what I've said before about how I do not want the "XPL" series=
 you've
> > > > > talked about before, but instead think Yamada-san was right in hi=
ndsight
> > > > > and in short we should have "fooboard_defconfig",
> > > > > "fooboard_spl_defconfig" and "fooboard_tpl_defconfig" and you mak=
e each
> > > > > config and build each config by itself. In that context, yes, you=
 could
> > > > > have barvend-fooboard_rev1_spl_defconfig,
> > > > > barvend-fooboard_rev2_spl_defconfig and barvend-fooboard_defconfi=
g to
> > > > > get a more generic U-Boot build.  But nothing so much like an OS =
kernel
> > > > > because we care about binary size and rarely does the OS vendor (=
but
> > > > > some production cases in turn do), so outside of SoC-vendor where
> > > > > showing off features is more important than size, most of the tim=
e, will
> > > > > you see an actual use for SoC-generic U-Boot build.
> > > >
> > > > We'll see. The size cost for making things generic across an SoC is
> > > > likely very small, particularly if the settings are in the DT where
> > > > they belong. But I do accept we are not seeing the pressure yet.
> > >
> > > Yes, I think we're well past the point where it's a case of needing t=
o
> > > see the implementation rather than talking about it over and over.
> >
> > Yes, that is [1]. If you'd like to set a timeline I can take a look.
> > But we already have lots of examples, e.g. chromebook_bob/kevin, 4
> > chromebook/bits for rk3299. Quite a few of the sunxi boards are very
> > common, from what I can tell.
>
> As soon as you're able, yes, please test and show multi platform builds
> that extend beyond the multi platform builds we have today that
> specify the N platforms they're able to function on.

OK

>
> > > > For XPL, there are pros and cons, but I thought we talked about tha=
t
> > > > at the time and agreed that the need for Kconfig dependencies betwe=
en
> > > > phases makes having separate defconfigs too painful?
> > >
> > > I recall there being a large number of issues.
> >
> > My memory is pretty dim about those, but I am sure there are issues to
> > resolve, as with anything new. I still believe it is the best way
> > forward. We should be able to add a new phase with a few build
> > changes, not the large effort needed today. Most of the prereqs were
> > applied, so perhaps it would not be a large series these days?
>
> I believe the first few patches were adding some very large number of
> "bool SPL_FOO" entries and that was a hard NAK from me as showing why
> this makes life worse, not better.

I believe that was an earlier version. The later versions used a
'nospl' file to mark things that were 'global' across all builds. But
another look and a rebase would be needed to check that.

Regards,
Simon
