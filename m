Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0831BC46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 01:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4D18796F;
	Wed,  3 Jan 2024 02:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RFIAMUBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6D687980; Wed,  3 Jan 2024 02:03:48 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7A68796B
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 02:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78102c516a7so957975985a.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 17:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704243824; x=1704848624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UOvgqRGd/vMsN2LamcAiw8YVAPOTDqh99WlYYQkMNxM=;
 b=RFIAMUBXN4cE596zjxoWC5MLrjC9dgY24NTkdzfXkfV2XLO3c1Kp9Cx5bLAC6Ht3vZ
 LUXlZfmE6OiqqDloL1t0Vdx6U3PhyjUPOAo9xMPkVvdnjjh+wdTFb7hSly+I88HpoOEA
 rYsILaYjXlsxnARXpRhLC08w9++ZLsn3jwCHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704243824; x=1704848624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOvgqRGd/vMsN2LamcAiw8YVAPOTDqh99WlYYQkMNxM=;
 b=IroigUfUX4AGBvjNZWv2gyBy+ZaxriYRos9B712CuNjWj00l44Q5W++4aaUopHum/s
 89REg09kJAblOK6CNP7PiHqJY5t/bXB4sDJB3kK3bTzL3V7GLoLTtRZ1dxKhxoPSy5Vh
 +7HT69CcsUS12iSYg1xMKgBXGTiOhEV+7o8BM4LcyFpiGjQEk2IcMLTT7FCnqX+8qJcd
 XTYpB403LikD17ogzurq9Jk2g18o7+WHa9lzkmw2eDWwcpNCSCpIHx6AYx5nz3dKXbvW
 7BAHjdBrA29BAHmbUPTbavyrwgHekoNW20yXdpz+2uMCmauR9j600XVTJth+J4H7tPUp
 4Vug==
X-Gm-Message-State: AOJu0Yx6TpICVrESnvDh68Oq4f7CC77lrBNOIJ3kd5Cv9Bfh//NyORFK
 jLaOGZzaGv+1dQAK121eERkIAtEM7nfbYg==
X-Google-Smtp-Source: AGHT+IFItdMfRtX/CwdeqTajq/Qo2AJRBWbSFmIUhDaQSyrJFLvZ9XPqvRAPTSXMDl47yiAQxwMyAg==
X-Received: by 2002:a05:6214:ca5:b0:67f:1117:560 with SMTP id
 s5-20020a0562140ca500b0067f11170560mr32733465qvs.6.1704243824446; 
 Tue, 02 Jan 2024 17:03:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 s24-20020a05621412d800b006805bd3058asm5533773qvv.75.2024.01.02.17.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 17:03:43 -0800 (PST)
Date: Tue, 2 Jan 2024 20:03:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>, Minkyu Kang <mk7.kang@samsung.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
Message-ID: <20240103010340.GD1610741@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rj5Y+Hp7NjNQc/bj"
Content-Disposition: inline
In-Reply-To: <CAFLszTgC6utx_hSOvO7VYubgbUS3CaWaPMnOnTXsvTD41mEVVA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Rj5Y+Hp7NjNQc/bj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 04:51:34PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, Jan 2, 2024 at 7:55=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Tue, Jan 02, 2024 at 07:06:36AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, Dec 31, 2023 at 7:01=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Sun, Dec 31, 2023 at 05:45:00AM -0700, Simon Glass wrote:
> > > > > -Scott as it is bouncing
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Fri, Dec 29, 2023 at 9:46=E2=80=AFAM Peter Robinson <pbrobinso=
n@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon G=
lass wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > > U-Boot builds devicetree binaries from its sour=
ce tree. As part of the
> > > > > > > > > > > > > > Kconfig conversion, the Makefiles were updated =
to align with how this
> > > > > > > > > > > > > > is done in Linux: a single target for each SoC =
is used to build all the
> > > > > > > > > > > > > > .dtb files for that SoC.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Since then, the Makefiles have devolved in some=
 cases, resulting in
> > > > > > > > > > > > > > lots of target-specific build rules. Also Linux=
 has moved to using
> > > > > > > > > > > > > > subdirectories for each vendor.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Recent work aims to allow U-Boot to directly us=
e devicetree files from
> > > > > > > > > > > > > > Linux. This would be easier if the directory st=
ructure were the same.
> > > > > > > > > > > > > > Another recent discussion involved dropping the=
 build rules altogether.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This series makes a start at cleaning up some o=
f the build rules, to
> > > > > > > > > > > > > > reduce the amount of code and make it easier to=
 add new boards for the
> > > > > > > > > > > > > > same SoC.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > One issue is that the ARCH_xxx Kconfig options =
between U-Boot and Linux
> > > > > > > > > > > > > > are not always the same. Given the large number=
 of SoCs and boards
> > > > > > > > > > > > > > supported by U-Boot, it would be useful to alig=
n these where possible.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I don't know why we should start with this now, a=
nd further not being on
> > > > > > > > > > > > > top of Sumit's series to remove our duplicate dts=
 files. And that's
> > > > > > > > > > > > > where we can have the conversation about for whic=
h cases it even makes
> > > > > > > > > > > > > sense to build all of the dts files for a given S=
oC.
> > > > > > > > > > > >
> > > > > > > > > > > > This is a completely different series - there are n=
o conflicts with
> > > > > > > > > > > > Sumit's series so it can be applied before or after=
 it.
> > > > > > > > > > > >
> > > > > > > > > > > > My goal here is to clean up our build rules, rather=
 than just throwing
> > > > > > > > > > > > them all away, for reasons we have discussed previo=
usly. I filed [1]
> > > > > > > > > > > > to track that.
> > > > > > > > > > >
> > > > > > > > > > > Yes, I'm saying we shouldn't be doing anything this s=
eries does until
> > > > > > > > > > > after Sumit's series has landed. Along with the fact =
that I don't like
> > > > > > > > > > > what's going on in this series.
> > > > > > > > > >
> > > > > > > > > > This seems to again be the disagreement over whether a =
single DT
> > > > > > > > > > should be build for each board, or all the DTs for an S=
oC?
> > > > > > > > >
> > > > > > > > > It's about the disagreement on what we should be building=
, and what that
> > > > > > > > > infrastructure looks like. I do not like adding extra rul=
es for
> > > > > > > > > "clarity" because they don't make things clearer, they le=
ad to the
> > > > > > > > > unclear mess we have today getting worse. Most instructio=
ns are _not_
> > > > > > > > > "now take this dtb and this binary and .." but just "take=
 this binary",
> > > > > > > > > because we already have the rules and logic to ensure we =
build the
> > > > > > > > > required dtbs. I also don't like the parts of this series=
 that amount
> > > > > > > > > to deck shuffling when we should just be taking the chair=
s away. There's
> > > > > > > > > just not nor will there be a case for omap3/4/5 platforms=
 of "change the
> > > > > > > > > dtb", so building more is pointless. For other SoCs, ther=
e may be some
> > > > > > > > > cases of "this could have been just a DT change", like
> > > > > > > > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could =
share a board
> > > > > > > > > dir, but the configs are different and the dts are differ=
ent, so I don't
> > > > > > > > > know that you could really just swap the dtbs.
> > > > > > > >
> > > > > > > > It is true that we have a different defconfig for each boar=
d, but IMO
> > > > > > > > that is not good. It is an artifact of the way the build sy=
stem works.
> > > > > > > > IMO Kconfig should be used to define sensible defaults so t=
hat the
> > > > > > > > defconfigs are nearly empty. Perhaps config fragments can b=
e part of
> > > > > > > > the mix, if we can agree on [1].
> > > > > > > >
> > > > > > > > But if we let this genie out of the bottle, it will be impo=
ssible to
> > > > > > > > put back in. The devicetree should control the hardware in =
U-Boot and
> > > > > > > > it should be possible to use the same U-Boot proper on all =
boards
> > > > > > > > which use the same SoC.
> > > > > > >
> > > > > > > We've never been past the point where a few examples of close=
ly related
> > > > > > > boards can re-use the same U-Boot build and just change the d=
evice tree.
> > > > > > >
> > > > > > > It's going to be very SoC specific if we can ever do things l=
ike that,
> > > > > > > and it will also likely in turn become a question of where di=
d the
> > > > > > > tricky bits that U-Boot used to do get shoved instead. You're=
 not going
> > > > > > > to combine board/beagle/beagle/beagle.c and board/ti/omap3evm=
/evm.c (and
> > > > > > > ignoring all of the other omap3 boards) and get one binary th=
at works on
> > > > > > > both, and just uses DT. Let alone that no one wants to do tha=
t work.
> > > > > > >
> > > > > > > You've mentioned Rockchip before as maybe a better example, b=
ut
> > > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D383=
579&state=3D* was
> > > > > > > leading me to think that no, there's too much "this is what T=
HIS
> > > > > > > hardware does" that means that no, there's going to be hardwa=
re
> > > > > > > variation that one must just handle in C. Or get more and new=
 bindings
> > > > > > > accepted upstream to try and make that be data driven, and al=
so possibly
> > > > > > > have to deal with "that's policy, not hardware" type argument=
s and so
> > > > > > > forth.
> > > > >
> > > > > Oh wow yes that is crazy! But you can always check the compatible
> > > > > string if really necessary. It would be nice to use a sysinfo dri=
ver
> > > > > for this sort of thing. I should just be a full-time code reviewe=
r...
> > > > >
> > > > > >
> > > > > > Related I've seen issues with nearly identical rockchips device=
s that
> > > > > > use different memory chips that as a result need different U-Bo=
ot
> > > > > > builds because the early boot part needs to initialise a comple=
tely
> > > > > > different set of memory and the two different sets of rules are=
n't
> > > > > > detectable at run-time nor are they even small enough to fit in=
to
> > > > > > smem.
> > > > >
> > > > > Some of the differences are real/important, like memory settings,=
 some
> > > > > are not. For boards with enough SRAM that SPL can use DM/DT, we c=
an
> > > > > deal with these.
> > > > >
> > > > > But even if SPL does need to be custom, that is better than havin=
g a
> > > > > full, separate U-Boot for every single board.
> > > >
> > > > I'm not sure that's a use case anyone else has or wants, and I disa=
gree
> > > > that building a unique SPL and then more generic U-Boot is a win, in
> > > > practical and effort terms.
> > >
> > > Think about firmware update where you could have an update that
> > > supports all rk3399 boards, rather than 110 separate (and duplicate)
> > > firmware updates.
> >
> > I don't know who wants that actually is the problem I keep trying to
> > bring up. In other words, you're saying that the differences between
> > rock-pi-4c-rk3399_defconfig and khadas-edge-v-rk3399_defconfig are
> > unintentional and it's just due to different device trees and I say
> > they're intentional and the desire is not for a "kitchen sink" type
> > rk3399 primary U-Boot build. My evidence for this goes back to the SoCs
> > where we do have both "kitchen sink" and then board specific builds.
> > This would be things like how there's the am65x_evm configs, which
> > support all of the TI reference platforms (and others which follow the
> > EEPROM spec TI uses) and then also iot2050_defconfig, which also uses
> > the am65x SoC, but does not (would not) support the TI EEPROM layout and
> > instead does what it needs to do for their custom hardware revisions and
> > support all of those, instead.
>=20
> OK, but this code should be in drivers which we can enable or disable,
> wouldn't it?

No, it's the board specific code. I mean I guess a few of the things
like "read EEPROM and see if it follows $my layout spec" could be
counted as a driver rather than board/$vendor/common/ code.  But the
rest of it isn't. Please look at the board examples I've listed above.

> We are trying to move away from board.c files.

We are? I didn't know that. We're trying to get rid of board.h, yes. And
some platforms where the rest of the firmware stack does everything else
needed, yes, we can avoid having dummy board.c files. That's the kind of
case where _maybe_ we could even have a generic-aarch64_defconfig (and
other platforms too? I _think_ the most recent example that maybe you're
thinking of was a MIPS-based router).

> I am not saying that all the defconfig differences are unintentional,
> just that we should really rationalise them, so it is clear what needs
> to be enabled for each board, and what is just by accident. Part of
> that is using Kconfig more than defconfig.

Yes, there might be some cases where the differences don't need to be
there, and maybe rk3399 is an example where more vendor boards could be
supported by a single config. But maybe not, there's a lot of annoying
board specific things that we need to care about that the OS then just
gets to inherit as having been handled.

> Another part might be
> fragments if we can agree a way to describe a defconfig made up of
> fragments ([2] is still hanging about).

Yes, I'm confused by what you're saying now here since the series here
is doing the opposite of what I thought you keep saying. This is making
"am62x_beagleplay_a53" be a specific thing to build for instead of just
making it be part of "am62x_evm_a53" as the only thing it changes is the
default device tree. And we're already always building the beagleplay
dtbs under the SoC name. That said, I'm not sure where functionally that
series ended up since beagleplay wants a different environment for LED
flashing and so forth.

> > What I think you keep wanting to aim for is fine and good and something
> > platforms can opt in to, and we have some doing it today. But it's still
> > at the end of the day a choice for the designers.
>=20
> Indeed. I just want to make it easier to be generic than to be specific.

And in turn I don't know why we're hung up on "build more device trees"
when the first problem I see is "make some generic faux-boards and prove
them out".

> > You say "110 separate (and duplicate)" and I disagree with the "(and
> > duplicate)" part of that. Could some platforms be condensed? Yes,
> > likely. But figuring out how to do that starts with figuring out why
> > they're separate to start with.
>=20
> I mean there are 110 rk3399 devicetree files in Linux. I count only 29
> in U-Boot.

I only see 41 dts files in v6.7-rc8 for "rk3399" and 27 defconfigs. So
yes, there's probably some level already of one U-Boot defconfig handles
N board revs. I agree there likely could be more.

> If we were to support Mediatek 8195, for example, we would ideally
> like to support the Chromebooks and use a single Kconfig for all of
> them. In general, if we make it easy, newer platforms will need to
> follow the path of least resistance. The reason rk3399 is mostly
> generic is that it was based on rk3288, which was written that way
> from the start.

Okay? A lot of the newer SoCs are done more generic than before,
especially on aarch64 compared with arm32 as some of the very board
specific stuff has been shoved to other parts of the stack already. I
keep bringing up TI K3 stuff because it too is done generically but also
we have in tree examples of intentionally NOT copying the reference
hardware platform and having true unique changes that need to be
handled.

> > > > The only win I see there is it would be part
> > > > of what I've said before about how I do not want the "XPL" series y=
ou've
> > > > talked about before, but instead think Yamada-san was right in hind=
sight
> > > > and in short we should have "fooboard_defconfig",
> > > > "fooboard_spl_defconfig" and "fooboard_tpl_defconfig" and you make =
each
> > > > config and build each config by itself. In that context, yes, you c=
ould
> > > > have barvend-fooboard_rev1_spl_defconfig,
> > > > barvend-fooboard_rev2_spl_defconfig and barvend-fooboard_defconfig =
to
> > > > get a more generic U-Boot build.  But nothing so much like an OS ke=
rnel
> > > > because we care about binary size and rarely does the OS vendor (but
> > > > some production cases in turn do), so outside of SoC-vendor where
> > > > showing off features is more important than size, most of the time,=
 will
> > > > you see an actual use for SoC-generic U-Boot build.
> > >
> > > We'll see. The size cost for making things generic across an SoC is
> > > likely very small, particularly if the settings are in the DT where
> > > they belong. But I do accept we are not seeing the pressure yet.
> >
> > Yes, I think we're well past the point where it's a case of needing to
> > see the implementation rather than talking about it over and over.
>=20
> Yes, that is [1]. If you'd like to set a timeline I can take a look.
> But we already have lots of examples, e.g. chromebook_bob/kevin, 4
> chromebook/bits for rk3299. Quite a few of the sunxi boards are very
> common, from what I can tell.

As soon as you're able, yes, please test and show multi platform builds
that extend beyond the multi platform builds we have today that
specify the N platforms they're able to function on.

> > > For XPL, there are pros and cons, but I thought we talked about that
> > > at the time and agreed that the need for Kconfig dependencies between
> > > phases makes having separate defconfigs too painful?
> >
> > I recall there being a large number of issues.
>=20
> My memory is pretty dim about those, but I am sure there are issues to
> resolve, as with anything new. I still believe it is the best way
> forward. We should be able to add a new phase with a few build
> changes, not the large effort needed today. Most of the prereqs were
> applied, so perhaps it would not be a large series these days?

I believe the first few patches were adding some very large number of
"bool SPL_FOO" entries and that was a hard NAK from me as showing why
this makes life worse, not better.

--=20
Tom

--Rj5Y+Hp7NjNQc/bj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWUsmkACgkQFHw5/5Y0
tywMoQv/RKr2A3kkEWbF0BRcGAp6YLmjVOw+jf+LF7qC9rZh2H1GprGcw0V4i2dh
rDK3f9xzlTv6u3M32K5BRMU6mxN7+LWxhfRbdhaXP9VXO7tPAMdC25NobxJNFeQn
NGTuCDPhzOuI3PKLgeDNg2VVM1Gts+53XEp4q57Qtl7QyaQi67wFYSy8p67eS/ts
Y2A5M153Nxn7AxACzW3Hedjo1Pxz1ZS1KGBT3gdQIgnTosuGIVkwmnxEvVc6cYSM
xd03yrHOWd7CQpY1HvbnVDXkaLyaYtMv+79W5rVmDqV8JgR348xBlJ0YeQi97ghR
1KDLS9YERAlUYG33bM5nplcr83w+El5CtG3gmUeZgXm5ZOgZSFAdu4XtFjGSw7HP
4ZiLlV5wzrfBWf8lyAGvbeD+9Nu2yXnrt/JTQ4gKEImf8OpE0pL5ZzCeM576d5To
e4cwTOz6+eqSFt3WRa4Hr/ixpJ9qZoYi+hIK/owruiQ4APW7ighsEEALcyO0MiFk
MrAJsDdT
=+AJ9
-----END PGP SIGNATURE-----

--Rj5Y+Hp7NjNQc/bj--
