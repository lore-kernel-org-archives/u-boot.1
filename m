Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D15EC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 23:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F662878E1;
	Wed,  3 Jan 2024 00:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UXD2qawt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF1268793C; Wed,  3 Jan 2024 00:51:49 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D280A878B0
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 00:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67fa018c116so59081766d6.3
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 15:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704239505; x=1704844305; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uy/xiqgzWxZ+2T37kObO1sJ02a7xmAhGwqk3YRPmeFQ=;
 b=UXD2qawtllcIrdSq9iiCAD4mQdFs+L0AaVSSaVInXjBUWWe6smQ6Si/JRbSrWO0Kq6
 ffLI1c5slwPMEYZ0G2E2+z1yJfGCvFVVwB/8n5Q1Gdqj/c0h21Uq1F0HDNes/I7WBVlo
 6GcOPCVN3yvR/ndQI1n0x5ePX1hwbaUXcpqZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704239505; x=1704844305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uy/xiqgzWxZ+2T37kObO1sJ02a7xmAhGwqk3YRPmeFQ=;
 b=Io6ze7nnthtsg85VEKe/AywBAMKHc6RfPDYFin/IwGdWskQCMDjk3pGO0DZ58JK4Xs
 fTYU/M150oldefuavrlqfDTpavTAF5jSqJJG6LHSI3fpSsGvVYXjhUKEGBqdKpoMEvos
 vJ2EydBU/C8fCgv5jRd2XxGqC6yXusW3RPNU8peaOs2ijTPX/uT1n2UNhDWX8gndctYW
 4bi1nbo2HyWPJr941ucEsNV6l/qnQKTGQtrjf/TsnYaz12h4ugFPRqq7o3hl8lBo0fh4
 WZh8jMiyKaFcfyg3WmXWIG3J4Ml8Yz0ol6i6UayRX/rZwrCH4AM7EoQQuwXNruxli0MP
 GhNg==
X-Gm-Message-State: AOJu0YxKoQVF/RG57ZfhUFvIqvYTy+NhVGEC8rwQwxQvLn9lhjaazFBh
 iizykX5cfywuR4yn0ySCbEaASvTzl49O0V/+YlzGcSafHiaC
X-Google-Smtp-Source: AGHT+IGkx2dok5tTEIAkxsiW6yvztkv2E949RL+wFJdD2/D5osli61PzT//j417v+cBNCMx4daP80DBehBQJSdk8z9I=
X-Received: by 2002:ad4:5de1:0:b0:680:c80b:7acc with SMTP id
 jn1-20020ad45de1000000b00680c80b7accmr858441qvb.35.1704239505557; Tue, 02 Jan
 2024 15:51:45 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
 <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
 <20231228204425.GQ2652760@bill-the-cat>
 <CALeDE9MfEd=xjwekR+oVPuWNR7TBPCMU6mc+Z7ig7tc1nhKu_Q@mail.gmail.com>
 <CAFLszTj0MQGUBcNqVTLZuOL=1YBD2pqL2+P8oLKqc5PnLq3GdA@mail.gmail.com>
 <20231231140127.GA2652760@bill-the-cat>
 <CAFLszTj0vdkZ+ch5-crygw7i3Mj8DO5=4naOWAwYMFNqGe0WWA@mail.gmail.com>
 <20240102145536.GK2652760@bill-the-cat>
In-Reply-To: <20240102145536.GK2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 16:51:34 -0700
Message-ID: <CAFLszTgC6utx_hSOvO7VYubgbUS3CaWaPMnOnTXsvTD41mEVVA@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 7:55=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 02, 2024 at 07:06:36AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, Dec 31, 2023 at 7:01=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Sun, Dec 31, 2023 at 05:45:00AM -0700, Simon Glass wrote:
> > > > -Scott as it is bouncing
> > > >
> > > > Hi,
> > > >
> > > > On Fri, Dec 29, 2023 at 9:46=E2=80=AFAM Peter Robinson <pbrobinson@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsulko=
.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote=
:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <tri=
ni@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Gla=
ss wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > U-Boot builds devicetree binaries from its source=
 tree. As part of the
> > > > > > > > > > > > > Kconfig conversion, the Makefiles were updated to=
 align with how this
> > > > > > > > > > > > > is done in Linux: a single target for each SoC is=
 used to build all the
> > > > > > > > > > > > > .dtb files for that SoC.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Since then, the Makefiles have devolved in some c=
ases, resulting in
> > > > > > > > > > > > > lots of target-specific build rules. Also Linux h=
as moved to using
> > > > > > > > > > > > > subdirectories for each vendor.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Recent work aims to allow U-Boot to directly use =
devicetree files from
> > > > > > > > > > > > > Linux. This would be easier if the directory stru=
cture were the same.
> > > > > > > > > > > > > Another recent discussion involved dropping the b=
uild rules altogether.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This series makes a start at cleaning up some of =
the build rules, to
> > > > > > > > > > > > > reduce the amount of code and make it easier to a=
dd new boards for the
> > > > > > > > > > > > > same SoC.
> > > > > > > > > > > > >
> > > > > > > > > > > > > One issue is that the ARCH_xxx Kconfig options be=
tween U-Boot and Linux
> > > > > > > > > > > > > are not always the same. Given the large number o=
f SoCs and boards
> > > > > > > > > > > > > supported by U-Boot, it would be useful to align =
these where possible.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't know why we should start with this now, and=
 further not being on
> > > > > > > > > > > > top of Sumit's series to remove our duplicate dts f=
iles. And that's
> > > > > > > > > > > > where we can have the conversation about for which =
cases it even makes
> > > > > > > > > > > > sense to build all of the dts files for a given SoC=
.
> > > > > > > > > > >
> > > > > > > > > > > This is a completely different series - there are no =
conflicts with
> > > > > > > > > > > Sumit's series so it can be applied before or after i=
t.
> > > > > > > > > > >
> > > > > > > > > > > My goal here is to clean up our build rules, rather t=
han just throwing
> > > > > > > > > > > them all away, for reasons we have discussed previous=
ly. I filed [1]
> > > > > > > > > > > to track that.
> > > > > > > > > >
> > > > > > > > > > Yes, I'm saying we shouldn't be doing anything this ser=
ies does until
> > > > > > > > > > after Sumit's series has landed. Along with the fact th=
at I don't like
> > > > > > > > > > what's going on in this series.
> > > > > > > > >
> > > > > > > > > This seems to again be the disagreement over whether a si=
ngle DT
> > > > > > > > > should be build for each board, or all the DTs for an SoC=
?
> > > > > > > >
> > > > > > > > It's about the disagreement on what we should be building, =
and what that
> > > > > > > > infrastructure looks like. I do not like adding extra rules=
 for
> > > > > > > > "clarity" because they don't make things clearer, they lead=
 to the
> > > > > > > > unclear mess we have today getting worse. Most instructions=
 are _not_
> > > > > > > > "now take this dtb and this binary and .." but just "take t=
his binary",
> > > > > > > > because we already have the rules and logic to ensure we bu=
ild the
> > > > > > > > required dtbs. I also don't like the parts of this series t=
hat amount
> > > > > > > > to deck shuffling when we should just be taking the chairs =
away. There's
> > > > > > > > just not nor will there be a case for omap3/4/5 platforms o=
f "change the
> > > > > > > > dtb", so building more is pointless. For other SoCs, there =
may be some
> > > > > > > > cases of "this could have been just a DT change", like
> > > > > > > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could sh=
are a board
> > > > > > > > dir, but the configs are different and the dts are differen=
t, so I don't
> > > > > > > > know that you could really just swap the dtbs.
> > > > > > >
> > > > > > > It is true that we have a different defconfig for each board,=
 but IMO
> > > > > > > that is not good. It is an artifact of the way the build syst=
em works.
> > > > > > > IMO Kconfig should be used to define sensible defaults so tha=
t the
> > > > > > > defconfigs are nearly empty. Perhaps config fragments can be =
part of
> > > > > > > the mix, if we can agree on [1].
> > > > > > >
> > > > > > > But if we let this genie out of the bottle, it will be imposs=
ible to
> > > > > > > put back in. The devicetree should control the hardware in U-=
Boot and
> > > > > > > it should be possible to use the same U-Boot proper on all bo=
ards
> > > > > > > which use the same SoC.
> > > > > >
> > > > > > We've never been past the point where a few examples of closely=
 related
> > > > > > boards can re-use the same U-Boot build and just change the dev=
ice tree.
> > > > > >
> > > > > > It's going to be very SoC specific if we can ever do things lik=
e that,
> > > > > > and it will also likely in turn become a question of where did =
the
> > > > > > tricky bits that U-Boot used to do get shoved instead. You're n=
ot going
> > > > > > to combine board/beagle/beagle/beagle.c and board/ti/omap3evm/e=
vm.c (and
> > > > > > ignoring all of the other omap3 boards) and get one binary that=
 works on
> > > > > > both, and just uses DT. Let alone that no one wants to do that =
work.
> > > > > >
> > > > > > You've mentioned Rockchip before as maybe a better example, but
> > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D38357=
9&state=3D* was
> > > > > > leading me to think that no, there's too much "this is what THI=
S
> > > > > > hardware does" that means that no, there's going to be hardware
> > > > > > variation that one must just handle in C. Or get more and new b=
indings
> > > > > > accepted upstream to try and make that be data driven, and also=
 possibly
> > > > > > have to deal with "that's policy, not hardware" type arguments =
and so
> > > > > > forth.
> > > >
> > > > Oh wow yes that is crazy! But you can always check the compatible
> > > > string if really necessary. It would be nice to use a sysinfo drive=
r
> > > > for this sort of thing. I should just be a full-time code reviewer.=
..
> > > >
> > > > >
> > > > > Related I've seen issues with nearly identical rockchips devices =
that
> > > > > use different memory chips that as a result need different U-Boot
> > > > > builds because the early boot part needs to initialise a complete=
ly
> > > > > different set of memory and the two different sets of rules aren'=
t
> > > > > detectable at run-time nor are they even small enough to fit into
> > > > > smem.
> > > >
> > > > Some of the differences are real/important, like memory settings, s=
ome
> > > > are not. For boards with enough SRAM that SPL can use DM/DT, we can
> > > > deal with these.
> > > >
> > > > But even if SPL does need to be custom, that is better than having =
a
> > > > full, separate U-Boot for every single board.
> > >
> > > I'm not sure that's a use case anyone else has or wants, and I disagr=
ee
> > > that building a unique SPL and then more generic U-Boot is a win, in
> > > practical and effort terms.
> >
> > Think about firmware update where you could have an update that
> > supports all rk3399 boards, rather than 110 separate (and duplicate)
> > firmware updates.
>
> I don't know who wants that actually is the problem I keep trying to
> bring up. In other words, you're saying that the differences between
> rock-pi-4c-rk3399_defconfig and khadas-edge-v-rk3399_defconfig are
> unintentional and it's just due to different device trees and I say
> they're intentional and the desire is not for a "kitchen sink" type
> rk3399 primary U-Boot build. My evidence for this goes back to the SoCs
> where we do have both "kitchen sink" and then board specific builds.
> This would be things like how there's the am65x_evm configs, which
> support all of the TI reference platforms (and others which follow the
> EEPROM spec TI uses) and then also iot2050_defconfig, which also uses
> the am65x SoC, but does not (would not) support the TI EEPROM layout and
> instead does what it needs to do for their custom hardware revisions and
> support all of those, instead.

OK, but this code should be in drivers which we can enable or disable,
wouldn't it? We are trying to move away from board.c files.

I am not saying that all the defconfig differences are unintentional,
just that we should really rationalise them, so it is clear what needs
to be enabled for each board, and what is just by accident. Part of
that is using Kconfig more than defconfig. Another part might be
fragments if we can agree a way to describe a defconfig made up of
fragments ([2] is still hanging about).

>
> What I think you keep wanting to aim for is fine and good and something
> platforms can opt in to, and we have some doing it today. But it's still
> at the end of the day a choice for the designers.

Indeed. I just want to make it easier to be generic than to be specific.

>
> You say "110 separate (and duplicate)" and I disagree with the "(and
> duplicate)" part of that. Could some platforms be condensed? Yes,
> likely. But figuring out how to do that starts with figuring out why
> they're separate to start with.

I mean there are 110 rk3399 devicetree files in Linux. I count only 29
in U-Boot.

If we were to support Mediatek 8195, for example, we would ideally
like to support the Chromebooks and use a single Kconfig for all of
them. In general, if we make it easy, newer platforms will need to
follow the path of least resistance. The reason rk3399 is mostly
generic is that it was based on rk3288, which was written that way
from the start.

>
> > > The only win I see there is it would be part
> > > of what I've said before about how I do not want the "XPL" series you=
've
> > > talked about before, but instead think Yamada-san was right in hindsi=
ght
> > > and in short we should have "fooboard_defconfig",
> > > "fooboard_spl_defconfig" and "fooboard_tpl_defconfig" and you make ea=
ch
> > > config and build each config by itself. In that context, yes, you cou=
ld
> > > have barvend-fooboard_rev1_spl_defconfig,
> > > barvend-fooboard_rev2_spl_defconfig and barvend-fooboard_defconfig to
> > > get a more generic U-Boot build.  But nothing so much like an OS kern=
el
> > > because we care about binary size and rarely does the OS vendor (but
> > > some production cases in turn do), so outside of SoC-vendor where
> > > showing off features is more important than size, most of the time, w=
ill
> > > you see an actual use for SoC-generic U-Boot build.
> >
> > We'll see. The size cost for making things generic across an SoC is
> > likely very small, particularly if the settings are in the DT where
> > they belong. But I do accept we are not seeing the pressure yet.
>
> Yes, I think we're well past the point where it's a case of needing to
> see the implementation rather than talking about it over and over.

Yes, that is [1]. If you'd like to set a timeline I can take a look.
But we already have lots of examples, e.g. chromebook_bob/kevin, 4
chromebook/bits for rk3299. Quite a few of the sunxi boards are very
common, from what I can tell.

>
> > For XPL, there are pros and cons, but I thought we talked about that
> > at the time and agreed that the need for Kconfig dependencies between
> > phases makes having separate defconfigs too painful?
>
> I recall there being a large number of issues.

My memory is pretty dim about those, but I am sure there are issues to
resolve, as with anything new. I still believe it is the best way
forward. We should be able to add a new phase with a few build
changes, not the large effort needed today. Most of the prereqs were
applied, so perhaps it would not be a large series these days?

Regards,
Simon

>
> --
> Tom

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/15
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D380278
