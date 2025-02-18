Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4AEC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 14:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE4F80C8F;
	Tue, 18 Feb 2025 15:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SCgQF/nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF41180C72; Tue, 18 Feb 2025 15:46:35 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AAF80646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 15:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so112265615ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739889991; x=1740494791; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hk550yHcqoz3svcoKS42gUJwj6/qQG4/H/JoRGCR//Y=;
 b=SCgQF/nWZggE5NVbthzPA8I3sXJhl03X9JMIt1IG8BytwK29AECb5+Y9kEBu9epq/4
 Bir8oEKTifvNGeiCTrdZwdbwgRZk/uYlQ8fXSVjaNQAsYxp8X2mram0xufeNZ0WgJA8I
 0K+ir2Wj3f8qI/KQrhenpDw4Ba4YkN1h6K3fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739889991; x=1740494791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hk550yHcqoz3svcoKS42gUJwj6/qQG4/H/JoRGCR//Y=;
 b=I7SITYnEFj2jyk0kUzyNFnZHnwpv7pSm8GTVtAiTtk5gzUi7pFj5lF/7kpNK6e39TY
 TytdKfV2FLO+hnetNb357BKQupIejsS8DJs2Qht/+z58gfG80nGh6tV69T4rFWxPvxWi
 CgVTNBh3og0iNbigTt/YC0zOBXLNnMTNJTE7dkwuFRLy2w0aIkhO3nEEpg1vBkA5Q3tJ
 Q2LPuQNwM0t8v475IMXLlX42x7qiwksm+xmFXPkf2mTkGzOUjhfMweDy00pKlueQ8gOD
 llf6eVl9ih4JAqXcqSus3HaBXGkUeKF0IHUXzR3SgwX7+USU+SKCirBu7Da3SiXhhnzO
 sdVw==
X-Gm-Message-State: AOJu0YwsASiOHFxlH7fvjdShq9mGPP4SMsxqwP4REp22ubYcawhYZE4Z
 tEFje338r1kzJYWLWZv0rRpZdSwFDQUWm9+t+6bo9PCVFt1633syx9PZl1PqYOM=
X-Gm-Gg: ASbGncuYvqu/f8UShg44jjPbmd8O9d09hd/nGLTeBRZeuz5uahcQyPKPfdWP2EzxJDs
 v113cwc94vfULM+q+s9qI1+x0phmqdKY1tNqngoOC5bhLbeS3wW+KFczAF9lJwkYhekYDxT56ff
 qKx0WbGURw4sRfOcxrZ4IIO8pTjArc54YTBvNxuhrYr/iwy8la5g5fGiM6/wVukXhJOq6SacogK
 5B/aFal0b8BTvKbjp1favDmlVrjI+5OObe474WSQZtH2nrWlIDfKvUdTCmcpCzDjmMr+kxkh12A
 wozdEOCtKkvlrw==
X-Google-Smtp-Source: AGHT+IGkoAMAOXBJwXNGUM3csoL3OwwKatYV2tzpOsd8TWT5qw87Z+j3S2rJGOAVAHvOeMW2a9CRcQ==
X-Received: by 2002:a17:902:d58b:b0:21f:dbb:20a6 with SMTP id
 d9443c01a7336-221040ab935mr257328855ad.33.1739889990782; 
 Tue, 18 Feb 2025 06:46:30 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348f7asm90375825ad.23.2025.02.18.06.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 06:46:30 -0800 (PST)
Date: Tue, 18 Feb 2025 08:46:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250218144627.GC1233568@bill-the-cat>
References: <20250211212222.GH1233568@bill-the-cat>
 <20250217185035.GT1233568@bill-the-cat>
 <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
 <20250217192156.GV1233568@bill-the-cat>
 <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
 <20250217194732.GY1233568@bill-the-cat>
 <20250217201751.GZ1233568@bill-the-cat>
 <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
 <20250218004025.GA1233568@bill-the-cat>
 <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mcx/SlNiMCzy8cXi"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
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


--Mcx/SlNiMCzy8cXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > I just wanted to send a note to (re-)introduce my ide=
as[1] for the
> > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > >
> > > > > > > > > > > A recent series introduced 'xPL' as the name for the =
various
> > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that=
 this is any xPL
> > > > > > > > > > > phase and CONFIG_SPL means this really is the SPL pha=
se, not TPL. We
> > > > > > > > > > > still use filenames and function naming which uses 's=
pl', but could
> > > > > > > > > > > potentially adjust that.
> > > > > > > > > > >
> > > > > > > > > > > The major remaining problem IMO is that it is quite t=
ricky and
> > > > > > > > > > > expensive (in terms of time) to add a new phase. We a=
lso have some
> > > > > > > > > > > medium-sized problems:
> > > > > > > > > > >
> > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are v=
isually ugly and
> > > > > > > > > > > can be confusing, particularly when combined with ifd=
ef and ifneq
> > > > > > > > > > >
> > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() =
and they mean
> > > > > > > > > > > different things. For any given option, some code use=
s one and some
> > > > > > > > > > > the other, depending on what problems people have met=
 along the way.
> > > > > > > > > > >
> > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it=
 could mean that
> > > > > > > > > > > the option is enabled in one or more xPL phases, or j=
ust in U-Boot
> > > > > > > > > > > proper. The only way to know is to look for $(PHASE_)=
 etc. in the
> > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This i=
s very confusing
> > > > > > > > > > > and has not scaled well.
> > > > > > > > > > >
> > > > > > > > > > > d. We need to retain an important feature: options fr=
om different
> > > > > > > > > > > phases can depend on each other. As an example, we mi=
ght want to
> > > > > > > > > > > enable MMC in SPL by default, if MMC is enabled in U-=
Boot proper. We
> > > > > > > > > > > may also want to share values between phases, such as=
 TEXT_BASE. We
> > > > > > > > > > > can do this easily today, just by adding Kconfig rule=
s.
> > > > > > > > > >
> > > > > > > > > > I agree with a through c and for d there are likely som=
e cases even if
> > > > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm not s=
ure it's as
> > > > > > > > > > important as the other ones.
> > > > > > > > > >
> > > > > > > > > > > Proposal
> > > > > > > > > > >
> > > > > > > > > > > 1. Adjust kconf to generate separate autoconf.h files=
 for each phase.
> > > > > > > > > > > These contain the values for each Kconfig option for =
that phase. For
> > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's t=
ext base.
> > > > > > > > > > >
> > > > > > > > > > > 2. Add a file to resolve the ambiguity in (c) above, =
listing the
> > > > > > > > > > > Kconfig options which should not be enabled/valid in =
any xPL build.
> > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > >
> > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Bo=
ot proper (only),
> > > > > > > > > > > useful in rare cases. This indicates that the option =
applies only to
> > > > > > > > > > > U-Boot proper and is not defined in any xPL build. It=
 is analogous to
> > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen=
 of these are
> > > > > > > > > > > needed at present, basically to allow access to the v=
alue for another
> > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE =
so that it knows
> > > > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > > > >
> > > > > > > > > > > 4. There is no change to the existing defconfig files=
, or 'make
> > > > > > > > > > > menuconfig', which works just as today, including dep=
endencies between
> > > > > > > > > > > options across all phases.
> > > > > > > > > > >
> > > > > > > > > > > 5. (next) Expand the Kconfig language[2] to support d=
eclaring phases
> > > > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicating =
options (DM_MMC,
> > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an o=
ption to be
> > > > > > > > > > > declared once for any/all phases. We can then drop th=
e file in 2
> > > > > > > > > > > above.
> > > > > > > > > > >
> > > > > > > > > > > With this, maintaining Kconfig options, Makefiles and=
 adding a new
> > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > >
> > > > > > > > > > I think this will not make our life easier, it will mak=
e things harder.
> > > > > > > > > >
> > > > > > > > > > I think what we've reached now shows that Yamada-san wa=
s correct at the
> > > > > > > > > > time in saying that we were going down the wrong path w=
ith how we
> > > > > > > > > > handled SPL/TPL.
> > > > > > > > > >
> > > > > > > > > > My request instead is:
> > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC=
 and so on, just
> > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when build=
ing a defconfig.
> > > > > > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_d=
efconfig
> > > > > > > > > >   and add Makefile logic such that for X_defconfig as a=
 build target but
> > > > > > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we ru=
n a builds in
> > > > > > > > > >   subdirectories of our object directory, and then usin=
g binman combine
> > > > > > > > > >   as needed.
> > > > > > > > > >   - Maybe instead the Makefile logic above we would par=
se X_defconfig
> > > > > > > > > >     and see if it's a different format of say PHASE:fil=
e to make it
> > > > > > > > > >     easier to say share a single TPL config with all rk=
3399, have a few
> > > > > > > > > >     common SPL configs and then just a board specific P=
PL.
> > > > > > > > > >
> > > > > > > > > > This solves (a) by removing them entirely. This solves =
(b) by removing
> > > > > > > > > > the ambiguity entirely (it will be enabled or not). As =
a bonus for (b)
> > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and ma=
tch up with the
> > > > > > > > > > Linux Kernel again. This solves (c) again by removing i=
t entirely.
> > > > > > > > >
> > > > > > > > > Lets come back up here, to my proposal, since parts of it=
 seem to have
> > > > > > > > > not been clear enough. While what I'm proposing should wo=
rk for any
> > > > > > > > > platform and xPL -> xPL -> ... -> PPL, for this example l=
et us assume
> > > > > > > > > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. =
Also, to
> > > > > > > > > compare with today, it will be helpful to run "make
> > > > > > > > > O=3D/tmp/rockpro64-rk3399_current rockpro64-rk3399_config=
" and have the
> > > > > > > > > resulting .config file available.
> > > > > > > > >
> > > > > > > > > There shall be configs/rockpro64-rk3399_tpl_defconfig. Th=
is will contain
> > > > > > > > > lines such as:
> > > > > > > > > CONFIG_ARM=3Dy
> > > > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > >
> > > > > > > > > When you run "make O=3D/tmp/rockpro64-rk3399_tpl rockpro6=
4-rk3399_tpl_defconfig"
> > > > > > > > > the resulting .config file will contain lines such as:
> > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > as this only makes sense in the context of building somet=
hing that will
> > > > > > > > > be TPL.
> > > > > > > > >
> > > > > > > > > A more complex example is that it will also contain:
> > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > > > > > > > >
> > > > > > > > > Because looking at arch/arm/mach-rockchip/Makefile a bunc=
h of that will
> > > > > > > > > be able to be simplified (and spl_common.c should be rena=
med to
> > > > > > > > > xpl_common.c) to:
> > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-bo=
ot-order.o xpl_common.o
> > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o xpl_co=
mmon.o
> > > > > > > > >
> > > > > > > > > The .config file here will also contain:
> > > > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > > > >
> > > > > > > > > What it will not contain is:
> > > > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > > > >
> > > > > > > > > This is because there is no 'config TPL_DM_SERIAL' option=
 in
> > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > >
> > > > > > > > > When you next run "make O=3D/tmp/rockpro64-rk3399_tpl all=
" the results in
> > > > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to the results=
 as under
> > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > > > > > >
> > > > > > > > > The contents of configs/rockpro64-rk3399_spl_defconfig wo=
uld be similar
> > > > > > > > > to the tpl one, except with SPL-only-ever-valid options s=
uch as
> > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but otherwise have C=
ONFIG_DM_SERIAL=3Dy
> > > > > > > > > and no CONFIG_SPL_DM_SERIAL=3Dy, and when building the "a=
ll" target, you
> > > > > > > > > would only get similar results to what is under the spl/ =
directory
> > > > > > > > > today.
> > > > > > > > >
> > > > > > > > > Next we have configs/rockpro64-rk3399_ppl_defconfig.  Whe=
n you run "make
> > > > > > > > > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defcon=
fig" the
> > > > > > > > > important difference is what you do not have. You do not =
have:
> > > > > > > > > CONFIG_SPL=3Dy
> > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > >
> > > > > > > > > Because we are not building SPL nor TPL. We're just makin=
g full U-Boot
> > > > > > > > > itself. This is where in more full examples and with addi=
tional
> > > > > > > > > restructure a "generic-arm64_ppl_defconfig" makes sense a=
nd be used
> > > > > > > > > instead.
> > > > > > > > >
> > > > > > > > > This brings up what to do with "ockpro64-rk3399_defconfig=
". And I'm a
> > > > > > > > > little unsure which of the things I mentioned above is be=
st. It's
> > > > > > > > > either:
> > > > > > > > > a) Does not exist, top-level Makefile says roughly:
> > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defcon=
fig
> > > > > > > > >   make O=3D$(objdir)/tpl %_tpl_defconfig all
> > > > > > > > >   make O=3D$(objdir)/spl %_spl_defconfig all
> > > > > > > > >   make O=3D$(objdir)/ppl %_ppl_defconfig all
> > > > > > > > >
> > > > > > > > > But this might be too rigid.
> > > > > > > > > b) It contains:
> > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > %_defconfig:
> > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, ple=
ase see..."
> > > > > > > > >   foreach line in $@
> > > > > > > > >     make O=3D$(objdir)/$PHASE $CONFIGFILE all
> > > > > > > > >
> > > > > > > > > It could also be some other suggestion.
> > > > > > > >
> > > > > > > > Thanks for writing that up. It is somewhat clearer.
> > > > > > > >
> > > > > > > > What happens to the Makefiles? Do they still have $(PHASE_)=
 in them?
> > > > > > >
> > > > > > > No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHAS=
E_)FIT)
> > > > > > > would be meaningless. Only rockpro64-rk3399_spl_defconfig wou=
ld say
> > > > > > > CONFIG_FIT=3Dy (or more likely, only the resulting .config wo=
uld say
> > > > > > > CONFIG_FIT=3Dy just like how configs/rockpro64-rk3399_defconf=
ig doesn't
> > > > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).
> > > > > >
> > > > > > But just above you said:
> > > > > >
> > > > > > > I believe this proposal will lead to the code and Makefiles b=
eing less
> > > > > > > clear than they are today. The line:
> > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=3D block/
> > > > > > > will become:
> > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
> > > > > > > without being clear that it could reference either full U-Boo=
t (PPL) or
> > > > > > > some xPL phase. While the same Makefile will continue to have=
 (comments
> > > > > > > my own):
> > > > > > > obj-y +=3D mtd/ # Subdirectory Makefiles control build conten=
ts
> > > > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only valid for PPL.
> > > > > > >
> > > > > > > And so the situation for humans will be worse off than today =
because
> > > > > > > while $(PHASE_) and $(XPL_) are confusing at times, they make=
 it clear
> > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > >
> > > > > > > Doing "something" is not better than doing nothing in this ca=
se.
> > > > > >
> > > > > > So why is OK for your proposal to drop the $(PHASE_) stuff, but=
 not mine?
> > > > >
> > > > > Because your proposal keeps CONFIG_SPL_BLK (and config SPL_BLK) a=
nd has
> > > > > a .config file which says "CONFIG_SPL_BLK=3Dy" but mine doesn't.
> > > > >
> > >
> > > > With my
> > > > proposal "I have a problem, and I want to see what my SPL build has=
 with
> > > > CONFIG_BLK=3Dy. I can see hits in the source tree for CONFIG_BLK, t=
he
> > > > symbol I set, I can solve my problem."
> > >
> > > There will be at least some matches, e.g. CONFIG_SPL_BLK in the
> > > defconfig files and 'config SPL_BLK' in the source tree.
> >
> > Yes, and that's confusing. I am arguing that your statement is more
> > confusing than $(PHASE_)BLK is.
>=20
> OK
>=20
> >
> > > > > Or to try and explain differently, with your proposal "I have a p=
roblem,
> > > > > and I want to see what builds with CONFIG_SPL_BLK=3Dy. Why is the=
re no
> > > > > match in the source tree for CONFIG_SPL_BLK or even SPL_BLK". Wit=
h my
> > > > > proposal "I have a problem, and I want to see what my SPL build h=
as with
> > > > > CONFIG_BLK=3Dy. I can see hits in the source tree for CONFIG_BLK,=
 the
> > > > > symbol I set, I can solve my problem."
> > >
> > > Well, CONFIG_BLK will be in the source tree; it just means different
> > > things for different phases.
> >
> > And it will be, with your proposal, controlled by BLK or SPL_BLK or
> > TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK in Makefile
> > and code.
> >
> > > It sounds like you want to get rid of the xPL prefixes for Kconfig
> > > options, and that overrides all other considerations?
> >
> > It's one of the big problems we have today, and splc-working shows how
> > much further the duplication must go. It's why I suggested the language
> > modification before.
> >
> > > > My other try here was a bit unclear actually because of the confusi=
on
> > > > state your proposal gives us. Try try again directly, the problem is
> > > > that CONFIG_SPL_BLK will be set (or unset) but not referenced in co=
de.
> > > > This will be true for many but not all SPL symbols as
> > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exist and n=
eed
> > > > to be referenced. This is a more confusing state than $(PHASE_). $(=
XPL_)
> > > > I think can just be replaced with $(PHASE_) but I haven't confirmed=
 (I
> > > > think it does show that the old way was confusing however).
> > >
> > > OK, I think I see. You don't want people to have to 'know' that
> > > CONFIG_xPL_xxx is used to control feature xxx in each xPL build?
> >
> > I'm saying they have to know that, and also know which symbols that's
> > not true for. And that is more confusing than today. I'm saying that
> > compared with today's arch/arm/mach-rockchip/Makefile the following is
> > worse:
> > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/M=
akefile
> > index 5e7edc99cdc4..3b176966f75b 100644
> > --- a/arch/arm/mach-rockchip/Makefile
> > +++ b/arch/arm/mach-rockchip/Makefile
> > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> >  endif
> >
> > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > +obj-$(CONFIG_RAM) +=3D sdram.o
> >
> >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> >
> > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> >
> > And this is better:
> >
> > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/M=
akefile
> > index 5e7edc99cdc4..23c30f68f878 100644
> > --- a/arch/arm/mach-rockchip/Makefile
> > +++ b/arch/arm/mach-rockchip/Makefile
> > @@ -7,15 +7,13 @@
> >  # this may have entered from ATF with the stack-pointer pointing to
> >  # inaccessible/protected memory (and the bootrom-helper assumes that
> >  # the stack-pointer is valid before switching to the U-Boot stack).
> > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.=
o spl_common.o
> > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o sp=
l_common.o
> > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > +obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> >
> > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > -
> > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > +obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> >
> >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This=
 way,
> > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> >  # meaning "turn it off".
> >  obj-y +=3D boot_mode.o
> >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > -endif
> >
> > -ifeq ($(CONFIG_TPL_BUILD),)
> >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > -endif
> >
> > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > +obj-$(CONFIG_RAM) +=3D sdram.o
> >
> > +ifdef CONFIG_PPL
> > +# TODO: Audit these Makefiles see if they really must be PPL only
> >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > -
> > -# Clear out SPL objects, in case this is a TPL build
> > -obj-spl-$(CONFIG_TPL_BUILD) =3D
> > -
> > -# Now add SPL/TPL objects back into the main build
> > -obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > -obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > +endif
> > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as options).
> >
>=20
> This Makefile is a very strange example. I've thought about cleaning
> it up a few times, but then I know someone will say it needs to be in
> its own series, etc. so I've never got around to it. Even with the
> current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just SPL) it is
> needlessly complex.

There's some complexity that can be removed here today, maybe. But not a
lot of it, because it's complex to build three different things when
configuring once.

> Anyway, with my scheme, you can still use
> CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds SPL_ versions

No. You have to use it still, with yours. Because
"ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
"TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use common board
code" but different files at TPL, SPL and PPL. And you still have to
with mine, because for the same reason. With mine, the Kconfig is:
config SPL_ROCKCHIP_COMMON_BOARD
  bool "SPL rockchip common board file"
  depends on SPL

config TPL_ROCKCHIP_COMMON_BOARD
  bool "TPL rockchip common board file"
  depends on TPL

And since you are only ever configuring for TPL or SPL or PPL (or VPL or
=2E..) the resulting config only ever asks for the appropriate one.

> of symbols to autoconf_spl.h for this reason. There are also places in
> the code where people directly check CONFIG_SPL_xxx and these need to
> work.

Yes, this is part of the confusion I keep noting with your proposal as
it will be inconsistent for which symbols CONFIG_SPL_xxx is referred to
in code as CONFIG_SPL_xxx or as CONFIG_xxx.

> This surprised me:
>=20
> obj-$(CONFIG_RAM) +=3D sdram.o
>=20
> Are you saying you are OK with this one, instead of, for example:
>=20
> obj-$(CONFIG_TPL_RAM) +=3D sdram.o
> obj-$(CONFIG_SPL_RAM) +=3D sdram.o
> obj-$(CONFIG_RAM) +=3D sdram.o
>=20
> If so, why are you OK with that and not the others?

Because there is no:
config TPL_RAM
  bool "RAM driver in TPL"

in what I am proposing. That's why. There's one symbol because there's
the same files being built.

> For this one:
>=20
> > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o sp=
l_common.o
>=20
> I don't understand how it can work with your scheme, since you don't
> want to have any CONFIG_SPL_ things?

No, that's not what I've been saying and trying to make clear with my
examples. I keep saying that there are explicitly SPL (or TPL or VPL)
only options. And these need to be named as such. And so that's the
confusion your proposal introduces (inconsistency about referring to a
symbol that has been enabled) and mine removes entirely (we only ever
refer to symbols based on their name).

> Also, while we are talking about Makefiles, your scheme requires a lot
> of rework to get right. It won't 'just work' with existing Makefiles.

In that we change from "one config, multiple passes through the entire
source tree" to "one config, one pass through the entire source tree",
yes, in the end it would.

> My scheme does, but for a handle of tweaks,
> e.g.drivers/phy/cadence/Makefile . It even allows the $(PHASE_) things
> to be kept.

As part of iterative implementation of it, what I'm proposing could
likely fake defining CONFIG_SPL_BUILD, etc so that Makefiles don't have
to be cleaned up right away. And $(PHASE_) could also be removed over
time (since it would be an empty string) if we wanted to go that route.

> It also works (so far as I can tell) with your changes
> above.

I continue to not see how that's possible. The only commonality is that
we would both remove $(PHASE_) / $(XPL_) from the Makefiles.

--=20
Tom

--Mcx/SlNiMCzy8cXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme0nT8ACgkQFHw5/5Y0
tyy5RwwAiE6lghOjd+TcTSiJ/KbcJCK4mkJj3ahLS6pPINr3eeqfR0dAnheWRLBi
8982SrtxspsczWOLn5fhSC4EFzwNTolN4PQxS/AbhVyxTKRnqkwH4Rhld64pB4e8
VqgEjQsio71vqSqxP9UaeNYFsAhzNlF6nQhKlY13pfUhraTXplvI7pMYpxaJLTMm
LG9jQiXCNketfHBa8rzzNm2l9qGKxG2oZVwSr+Lgk+bsPmkvVfkoRgrkQXy0UlEw
WqC1oYR0heFQfkdKVx1enLkqnbcZPIb5+RDvjpbBeO3KtiZ9igRec0TlWF/G9kxn
qpWp8XMO5AZFEy4y3D6+oxtSwFUTC3ZAMkOrQpL6VtiebY0Rlc103Wbx/7D6qNNe
E5J7h3GNQQLETARAKMCQwAr9VjuNXkKHymRI3z1+4etHfdXQ0x73dBDfvXS9HmsD
6r6mgrJv6nXklcWNmulhM/esDedemhTKSZM3rH7BQ7dhDKR1Iwb0MazFGTXUzGjf
3ElYmune
=9AzU
-----END PGP SIGNATURE-----

--Mcx/SlNiMCzy8cXi--
