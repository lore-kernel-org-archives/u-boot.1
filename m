Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985E4C021A4
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 22:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BA180FB6;
	Thu, 13 Feb 2025 23:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nr730qSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E589F80F86; Thu, 13 Feb 2025 23:59:41 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E8880F77
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 23:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6f7440444efso12802537b3.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739487576; x=1740092376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HlUmg4yhMdqSPFSUiXkJRnehYhQ6k9cLEyCOBoIy+eI=;
 b=Nr730qSUWkhfFaz2NAy8EWuPKbZhQWs9wswaZqZSI0EiTnvZ83lY0MvzuI8Nqm1fxV
 sJkBxsjbI5z8iBhOuiIVx5EBlzhhy189ZR8zE9VWzTtbREqn3sDFjrEItZ/0+LtUvKTj
 DcKoqa37kjm96Z1YyzN0TXMNdKOXdDBqIQroM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739487576; x=1740092376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlUmg4yhMdqSPFSUiXkJRnehYhQ6k9cLEyCOBoIy+eI=;
 b=Vg6J+as2hyG6g+hDegvkrWY+rWJVihxWEZTSb2m8kuEv/Irw2SCqD/v2ru9p3eG4y4
 wTYBvxHcrjNbNWy4Y8hnmx0V8Jv4sqcTaet+I9gpDLenabxvrXpJEQGPOtvm/TCdgUVg
 m2MS8u6oWHCB0kPYMKunfzZk7k/C7iOU2DPo6VB6qm+HGPcXSrYK118Gn3ZWuqXcimMV
 UF0aYr75cQLaBKOIDvAl+oDUSwM5hdGcGyZrZlB869G3onwS+yCMsbaqTFzrjNEbAzMh
 nJWDf9whbiGlpipyxHAYV+1UsjhGSigFuQDpBrFlk7Tx/XGMghPiStAUKPH6YSTZlqEX
 LrmA==
X-Gm-Message-State: AOJu0Yx4vawIX8puCorgUIXyPdIuczQFyU03IAl6ah446Lua58+YcQIu
 WTPUDjzUE+jshLVyvIrpo7vVUzMCVGmi2il7F95rt90fgHsDwHhyptVkH9QPSj0=
X-Gm-Gg: ASbGncvMax3MwkqS6V88gslhcjLDFKKhQVoeWEWA0RtochOw0MKVQVa7b1GlAGaibs7
 te7P2Q6sCrNvSd7M18DiTacnHo4fPznm2fvl4fhcZXywlrjkhnEuxI2STnLnp7DAgkLXWNKlR//
 vRaD84ZGIGyn5lpVG7+ww9xM+5uL1H6zxD+ocmqO9S/YABksaZihmmOBBlv44aqn+o8r2KN6RkU
 tsaNo66/F3sUkomrmdFS/XwIP+dQSC2C/vuxwKe4oMaVvtTfdRibi7PGfKSnScInZZZ0h/2wum3
 bJHYxUbDjlkwJ7I=
X-Google-Smtp-Source: AGHT+IEAD3AIxhr2SW6epOZbcMzZq3lSvpBN1rIJYM6+7tCxrN6ZvLQkHK5CT6GIdUf2E4gSzSJx1Q==
X-Received: by 2002:a05:690c:f06:b0:6f6:ca9a:e9da with SMTP id
 00721157ae682-6fb32c56b7emr44874667b3.4.1739487575422; 
 Thu, 13 Feb 2025 14:59:35 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb3619caa3sm5118797b3.77.2025.02.13.14.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:59:34 -0800 (PST)
Date: Thu, 13 Feb 2025 16:59:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250213225932.GC1233568@bill-the-cat>
References: <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <20250212183537.GQ1233568@bill-the-cat>
 <CAFLszTh5HS49DY1iqqcm_mT3tm2maUVAxyTXoP=5QxL1obw+jw@mail.gmail.com>
 <20250212225829.GS1233568@bill-the-cat>
 <CAFLszThNpm9_GRVPALTc+r_b2sFa1h=ih_JuNB9BZv+t7Qj5cQ@mail.gmail.com>
 <20250213180352.GY1233568@bill-the-cat>
 <CAFLszTj5z9TF_a0Y6zEABmUvjVjEYgw31gGRMX3Y1anVJgEvnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ISpri79emJgKCkvz"
Content-Disposition: inline
In-Reply-To: <CAFLszTj5z9TF_a0Y6zEABmUvjVjEYgw31gGRMX3Y1anVJgEvnA@mail.gmail.com>
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


--ISpri79emJgKCkvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 02:57:59PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Feb 13, 2025, 11:03 Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 05:50:13AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 12 Feb 2025 at 15:58, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 01:05:11PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
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
> > > > > > > > >
> > > > > > > > > OK. No, TEXT_BASE is not a great example in my book eithe=
r. But it is
> > > > > > > > > true that SPL needs to know U-Boot's text base.
> > > > > > > > >
> > > > > > > > > Here's another:
> > > > > > > > >
> > > > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > > > >
> > > > > > > > > config TPL_SYS_MALLOC_F
> > > > > > > > >    default y if SPL_SYS_MALLOC_F
> > > > > > > > >
> > > > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > > > >    default SPL_SYS_MALLOC_F_LEN
> > > > > > > >
> > > > > > > > Alternatively:
> > > > > > > > config SYS_MALLOC_LEN
> > > > > > > >    ... current default X if Y
> > > > > > > >    default 0x2800 if RCAR_GEN3 && !PPL
> > > > > > > >    default 0x2000 if IMX8MQ && !PPL
> > > > > > >
> > > > > > > PPL means (in my book) that we have a PPL, i.e. it is always =
true. It
> > > > > >
> > > > > > And in my proposal you're choosing between PPL, SPL, TPL, VPL.
> > > > > >
> > > > > > > is the same today, with SPL. We have CONFIG_SPL_BUILD which i=
ndicates
> > > > > > > which build it is. If you are suggesting that SPL means that =
this is
> > > > > > > the SPL build, then which thing tells us whether or not we ha=
ve an SPL
> > > > > > > build? I'm just a bit confused by this.
> > > > > >
> > > > > > And we wouldn't have CONFIG_SPL_BUILD because we would either be
> > > > > > configuring for SPL=3Dy or SPL=3Dn, there's no confusion anymor=
e.
> > > > > >
> > > > > > > But how can I make the TPL value of SYS_MALLOC_F_LEN the same=
 as the
> > > > > > > SPL one, with your scheme?
> > > > > >
> > > > > > If your question is "how do I set an arbitrary but consistent v=
alue in
> > > > > > SPL and SPL" that's not enforced. But they also shouldn't be ar=
bitrary
> > > > > > and we should have sane defaults set in Kconfig, regardless of =
either
> > > > > > proposal. While I'm trying to not get lost in the details today=
 we have
> > > > > > 80 matches on "git grep SPL_.*_LEN=3D configs/" and 2 for TPL a=
nd I would
> > > > > > encourage someone to verify those are needed. My initial recoll=
ection is
> > > > > > that most of these are from when we bumped SYS_MALLOC_F_LEN or =
so up to
> > > > > > the commonly used default and had the few platforms that didn't=
 use the
> > > > > > new default previously switch to the old one.
> > > > > >
> > > > > > In other words, I don't think there's a problem here that isn't=
 solved
> > > > > > today, outside of either proposal.
> > > > > >
> > > > > > > So I'm still not understanding how you handle Kconfig depende=
ncies
> > > > > > > between phases with your scheme. Are you saying you don't and=
 they are
> > > > > > > not important?
> > > > > >
> > > > > > Basically. The majority of the cases of:
> > > > > > config SPL_FOO
> > > > > >    default y if FOO
> > > > > >
> > > > > > config TPL_FOO
> > > > > >    default y if SPL_FOO
> > > > > >
> > > > > > Just go away because FOO is already default y or select/imply'd=
 by
> > > > > > TARGET_BAR or ARCH_BAZ.
> > > > > >
> > > > > > > Also, is there a single Kconfig tree for U-Boot, or are you s=
aying you
> > > > > > > want a different set of Kconfig files for each phase?
> > > > > >
> > > > > > Just the Kconfig files we have today. Likely with less overall =
lines
> > > > > > since for example we could drop:
> > > > > > config SPL_FS_EXT4
> > > > > >         bool "Support EXT filesystems"
> > > > > >         select SPL_CRC16 if EXT4_WRITE
> > > > > >
> > > > > > Since we already have fs/ext4/Kconfig.
> > > > > >
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
> > > > > > > > >
> > > > > > > > > You've mentioned this quite a few times over the years. I=
s there a
> > > > > > > > > reference to what he suggested we should do? Or perhaps i=
t is what you
> > > > > > > > > have below.
> > > > > > > >
> > > > > > > > I don't recall what he proposed instead, just that when it =
became clear
> > > > > > > > that I wanted to move from the "S:CONFIG_FOO.." syntax for =
how SPL was
> > > > > > > > handled to how we're doing it today, he thought that was th=
e wrong
> > > > > > > > direction.
> > > > > > >
> > > > > > > Yes, IMO he was right about that.
> > > > > > >
> > > > > > > >
> > > > > > > > > > My request instead is:
> > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC=
 and so on, just
> > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when build=
ing a defconfig.
> > > > > > > > >
> > > > > > > > > Good idea.
> > > > > > > > >
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
> > > > > > > > >
> > > > > > > > > This means splitting the existing file into a separate on=
e for each
> > > > > > > > > phase. I believe that will be hard to manage.
> > > > > > > >
> > > > > > > > Do you mean initially, or long term? Initially, it should b=
e a bit of
> > > > > > > > shell scripting. The consolidation (ie most/all rk3399 havi=
ng an
> > > > > > > > identical _spl_defconfig) can't be automated. Long term I'm=
 not sure it
> > > > > > > > would be any different. Most of the maintenance is on resyn=
c'ing which
> > > > > > > > is automated.
> > > > > > >
> > > > > > > Long term. How does 'make menuconfig' work in this case? Won'=
t you
> > > > > > > have to run it three times for SPL, TPL and PPL?
> > > > > >
> > > > > > Yes, you would run configure for what you're building. This is =
a good
> > > > > > thing as it will no longer be so confusing to hunt down where S=
PL or TPL
> > > > > > or VPL options for a specific thing reside.
> > > > > >
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
> > > > > > > > > The scheme I propose removes a-c also. I should have made=
 that clear.
> > > > > > > >
> > > > > > > > Er, ok. That's not how it looked before, but I guess I'm ju=
st mistaken.
> > > > > > >
> > > > > > > Yes I think so...it was a major goal to remove this stuff. [1=
] [2]
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > > > > There is not a huge difference between your scheme and mi=
ne. My
> > > > > > > > > question is, how do you handle (d)?
> > > > > > > >
> > > > > > > > Well, either (d) isn't important as for example MMC wasn't =
a good choice
> > > > > > > > in your proposal as virtually everyone "select MMC" today o=
r it's
> > > > > > > > handled more easily as my example above in SYS_MALLOC_LEN.
> > > > > > > >
> > > > > > > > > The way I see it, both schemes remove the ambiguity. Mine=
 retains a
> > > > > > > > > single deconfig file and a single 'make menuconfig' for e=
ach board.
> > > > > > > > > Yours feels more like building independent U-Boot images.
> > > > > > > >
> > > > > > > > It is explicitly building independent U-Boot images, yes. W=
ith a wrapper
> > > > > > > > around "make all of the images for a given platform". So mu=
ch of our
> > > > > > > > confusing and messy code is because we aren't doing that. A=
nd since most
> > > > > > > > modern SoCs can work as (mostly )generic SPL selects correc=
t DTB for PPL
> > > > > > > > we really could have fewer overall build configurations.
> > > > > > >
> > > > > > > I'd really like to see a generic aarch64 U-Boot for PPL, alth=
ough it
> > > > > > > would be quite large with all the drivers. Perhaps we could s=
tart by
> > > > > > > having a generic Rockchip one, for example.
> > > > > > >
> > > > > > > Still I don't see this being strongly related to the discussi=
on about
> > > > > > > these two different schemes.
> > > > > >
> > > > > > Well, in your scheme how do we have say generic-aarch64_defconf=
ig
> > > > > > function on either chromebook_bob or am62x_beagleplay_a53 ? In =
mine,
> > > > > > since everything is a separate build, generic-aarch64_defconfig=
 has
> > > > > > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_RK3399=3Dy. And then
> > > > > > chromebook_bob_defconfig would say to use chromebook_bob_tpl_de=
fconfig,
> > > > > > generic-rk3399_spl_defconfig and generic-aarch64_defconfig. As =
a bonus
> > > > > > instead of am62x_beagleplay_a53_defconfig and
> > > > > > am62x_beagleplay_r5_defconfig we would have am62x_beagleplay_de=
fconfig
> > > > > > that would say to use the appropriate SPL/PPL for R5, and appro=
priate
> > > > > > SPL/PPL for A53.
> > > > > >
> > > > > > But the one big huge caveat I want to make here is that "generi=
c" images
> > > > > > are useful in some use cases (I'm sure all of the regular F/OSS
> > > > > > distributions would love a single actually common PPL if they c=
an fit
> > > > > > it) will strip things down. Whatever the IoT edge device closes=
t to you
> > > > > > now really won't want to ship with all the platforms enabled. I=
mage size
> > > > > > still matters.
> > > > >
> > > > > OK thanks for the details. I think I have a reasonable idea of wh=
at
> > > > > you are proposing, now. It would work, but is quite radical, IMO.
> > > > > That's not necessarily a bad thing, but in my mind I see a sequen=
cing
> > > > > possibility.
> > > > >
> > > > > A few points from my side:
> > > > >
> > > > > 1. I would love to see the defconfig files reduce in size, with m=
ore
> > > > > and better defaults. One way to do this would be to enforce a max=
imum
> > > > > length. I added a feature to qconfig to allow finding common opti=
ons
> > > > > among boards (the -i flag), but I'm not sure if many people use i=
t.
> > > >
> > > > I don't see reducing defconfig size as important honestly. Should we
> > > > have more and better defaults? Yes. But almost everything is under =
200
> > > > lines with the biggest (non-sandbox) ones being the generic zynqmp
> > > > platform(s?).
> > >
> > > Agreed.
> > >
> > > >
> > > > > 2. Generic boards is something I have been pushing for years (in =
fact
> > > > > it is why I originally introduced devicetree), but I'm not seeing=
 a
> > > > > lot of traction.
> > > >
> > > > I don't think generic boards are universally helpful. Even if what =
I'm
> > > > proposing would allow for more of it, below the PPL stage I'm not s=
ure
> > > > it's both feasible enough and useful enough for production. At the =
PPL
> > > > stage it still has to be small enough and not overly burdensome. Wh=
at we
> > > > talked about on the call yesterday about using more multi-dtb image=
s is
> > > > a step in the right direction, yes.
> > >
> > > Agreed. Anway, we can create separate targets for generic boards if w=
e want to.
> > >
> > > >
> > > > > 3. Iit seems that you want to remove all the 'if SPL' pieces and =
just
> > > > > rely on the current PPL configuration. But how will that work? Th=
ere
> > > > > are tons of features which don't work in SPL, or are not relevant=
, or
> > > > > have special 'small' versions. That is a *lot* of Kconfig refacto=
ring
> > > > > just to get something working, isn't it? With my scheme there is =
no
> > > > > Kconfig change needed initially - it can be done later as needed /
> > > > > desirable.
> > > >
> > > > I don't think we would remove most "if SPL" cases. Taking part of t=
he
> > > > current stanza for ROCKCHIP_RK3399 as an example:
> > > > config ROCKCHIP_RK3399
> > > >         bool "Support Rockchip RK3399"
> > > >         select ARM64
> > > >         select SUPPORT_SPL
> > > >         select SUPPORT_TPL
> > > >         select SPL
> > > >         select SPL_ATF
> > > >         select SPL_BOARD_INIT if SPL
> > > >         ...
> > > >         select SPL_CLK if SPL
> > > >         ...
> > > >         select CLK
> > > >         ...
> > > >         imply TPL_CLK
> > > >
> > > >
> > > > This would become:
> > > > config ROCKCHIP_RK3399
> > > >         bool "Support Rockchip RK3399"
> > > >         select ARM64
> > > >         select SUPPORT_SPL
> > > >         select SUPPORT_TPL
> > > >         select SPL_ATF if SPL # TBD: Does 'ATF' make sense outside =
of SPL?
> > > >         select BOARD_INIT if SPL # Not TPL_BOARD_INIT here
> > > >         select CLK # imply was likely wrong before? Would need to c=
heck
> > > >         ...
> > >
> > > I was more talking about the large blocks of 'if SPL' - e.g. we have
> > > common/spl/Kconfig and common/spl/Kconfig.tpl
> >
> > I would vastly reduce the contents within those 'if' blocks, but there
> > are still options that are xPL-centric without a PPL counterpart, such
> > as SPL_ATF (I suspect, but if not I'm sure others).
> >
> > > But just the level of thought required in your small example above
> > > suggests it is a large effort.
> >
> > Yes, restructuring our Kconfig logic and then removing our xPL logic is
> > some work. So was, I suspect, all of what you did already.
> >
> > > > > 4. My scheme splits the config into separate files. Yours makes t=
he
> > > >
> > > > I don't see yours as splitting the configs in to separate files, I =
see
> > > > it as generating some intermediate objects. The configs don't chang=
e and
> > > > that's one of our problem areas.
> > >
> > > So you mean a big problem area is the current Kconfig?
> >
> > I mean it's a problem for users a board developers to make valid
> > configurations and update them as needed. Filesystems are in the
> > filesystem menu, unless they're SPL and then it's all under the big SPL
> > menu.
> >
> > > Mind generates
> > > out to an include/generated/autoconf_xxx for each phase. Yes they are
> > > intermediate files and auto-generated, but each 100% controls its
> > > phase, so there is no confusion and CONFIG_IS_ENABLED() / odd Makefile
> > > rules anymore.
> >
> > Yes, removing CONFIG_IS_ENABLED and $(PHASE_)/$(XPL_) from Makefiles is
> > good. But the intermediate files aren't going to help (nor hurt) any of
> > the problems themselves. If you're reading those to figure out a
> > problem, it's like when you're reading a .i file to figure out a
> > problem, it means you're already in a complex troublesome spot.
> >
> > But I don't know that CONFIG_SPL_FS_FAT=3Dy means that CONFIG_FS_FAT=3D=
y for
> > SPL builds leads to "no confusion". But I do think that CONFIG_SPL=3Dy =
and
> > CONFIG_FS_FAT=3Dy does.
> >
> > > > > split earlier, at the Kconfig level. So it seems that we could go=
 with
> > > > > my scheme to get us to a split config, then, after that, decide
> > > > > whether to move that split earlier to Kconfig itself. The choices
> > > >
> > > > I don't think so. Yours makes things complicated by making the buil=
d do
> > > > even more (and from the RFC, the implementation tooling diverges fr=
om
> > > > upstream).
> > >
> > > Yes it makes the kconf tool generate those separate files for each ph=
ase [3]
> > >
> > > > Mine makes things differently complicated by doing less for
> > > > most things, but needing some thought on how to know that say
> > > > chromebook_bob needs chromebook_bob_tpl_defconfig,
> > > > chromebook_bob_spl_defconfig and chromebook_bob_ppl_defconfig to be
> > > > built, before asking binman to go put things together.
> > >
> > > Yours seems feasible in a fully Binman world, but given the difficulty
> > > we (or I) have completing a migration, I honestly don't believe this
> > > is feasible in today's U-Boot. The other problem is that it all has to
> >
> > I'm not 100% sure it's everything needs binman actually. Or even if we
> > do take this as a reason to push for more binman, it's just some trivial
> > types already handled in the Makefile that's missing.
> >
> > > be done at once. We need to rewrite the Kconfig and flip over the
> > > board. Will we carry people with us? That is a huge risk to the
> > > project IMO.
> >
> > I'm not sure, actually, that it couldn't be done in stages. We might
> > need a little bit of fakery around being able to just build SPL without
> > PPL in the interim.
> >
> > > Anyway, yes my schema makes the build do even more (with 400 lines of
> > > kconf additions and a patch that can likely be upstreamed). But
> > > otherwise, it is a one-off improvement, without any changes to the
> > > existing Kconfig.
> >
> > I thought Yamada-san rejected changes going in this direction before?
> > But either way, no it's not likely the final overburden in terms of
> > divergence.
>=20
>=20
> Yes. Masahiro will make his own decisions and I am confident he will
> reject any future changes I send
>=20
> >
> > > So my point is that we could go with the first part of my scheme to
> > > resolve the 'medium' problems then decide which way to continue after
> > > that. From your side you won't have lost anything towards where you
> > > want to head. The two options would then be:
> > >
> > > - exhance kconfig language to build in the notion of phases
> > > - split the defconfigs for each board, redo the Kconfig rules and
> > > teach the build to combine images
> >
> > If things go down your proposed path instead, no, I don't see that as
> > making it meaningfully easier to go the way I proposed later. The only
> > commonality is dropping $(PHASE_)/$(XPL_)/etc and CONFIG_IS_ENABLED ->
> > IS_ENABLED. And (almost) all of that is a script'able change.
>=20
> To be frank, the difference is that I have actually put in the work to
> try this. It is more than 50 and perhaps as many as 100 patches. Quite
> difficult work. Honestly, compared to that, the logic changes are not
> that large.
>=20
> That is why I believe this work is a prerequisite for both schemes
>=20
> >
> > > > > would then be to use your scheme (Kconfig refactoring, splitting
> > > > > defconfigs and some rework), or to do my scheme (which would requ=
ire
> > > > > enhancing the Kconfig language a bit just for U-Boot and some opt=
ional
> > > > > rework over time). Both schemes would need a small amount of
> > > > > build-logic changes, but I'm not sure yet what that would look li=
ke.
> > > > >
> > > > > Does that sound right?
> > > >
> > > > With what I said above, yes I think we're closer at least to
> > > > understanding each other.
> > >
> > > Yes.
> >
> > Well, with that, what now?
> >
> > What makes the current situation untenable is VPL. And I gather I
> > haven't convinced you to put that on hold long enough to instead rework
> > how we build things, have I?
>=20
> Which VPL thing?

That it exists. When it was just SPL, it's manageable. With TPL, well,
it was supposed to be tiny and so just a few more things. And with VPL,
that makes 4. It's too much. Something needs to be done. Four times is
too many. If solving Marek's desire for PSCI-from-U-Boot means we need
number 5 that becomes even worse (and I also suspect that's a case of
one build covers the SoC or family of SoCs depending on hardware
changes).

> You have convinced me that you have a solution. It makes a lot more
> sense to me than previously and it may be that it is better in the
> end. For example, with VBE it I would make a lot of sense to build 20
> boards as just TPL and use a generic rock chip board for everything
> else. That would be a lot tidier with your scheme. It is very hard to
> predict the future and VBE is still not finished, some two years in.
>=20
> I don't want to be tied to your scheme today though.
>=20
> So if you can accept my going ahead with 1-4 and helping me with that,
> then we can stop and discuss which way to go, perhaps by prototyping
> the two options?

I want to start by saying I do appreciate you put in a lot of work in
this direction already, and I do see some of the end goals it achieves
as being important, and I'm glad you see my idea has some good parts
too.

I want to figure out how to move forward on this problem. My other part
of this thread, this morning, was also part of me looking harder, again,
at the RFC series you posted before. And that's where I still have large
reservations. There are *so* *many* symbols we need to now have 4
variants of, instead of 1 variant of. Take:
https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.1134219-58-=
sjg@chromium.org/
for example. It adds SPL_PARTITION_TYPE_GUID but we include <part.h> in
files built in TPL (and likely VPL) so aren't we going to need that
every time? And with a quick size-check on pinebook-pro-rk3399 it looks
like it's not working as intended either? I checked and part_get_info
shrinks because CONFIG_PARTITION_TYPE_GUID is not set, or rather:
#ifdef CONFIG_PARTITION_TYPE_GUID
                info->type_guid[0] =3D 0;
#endif
is not true and checked. And I can't see why. And there's other size
reductions (this time in tpl) on pinebook-pro-rk3399 that I didn't dig
in to more, but wasn't that symbol:
               tpl-u-boot-tpl: add: 0/-4, grow: 0/0 bytes: 0/-344 (-344)
                 function                                   old     new   d=
elta
                 dev_get_uclass_plat                         12       -    =
 -12
                 simple_bus_post_bind                        92       -    =
 -92
                 _u_boot_list_2_uclass_driver_2_simple_bus     120       - =
   -120
                 _u_boot_list_2_driver_2_simple_bus         120       -    =
-120

And I'm not bringing this up to badger you about bugs in an RFC series
(it's RFC, there's bugs) but rather because I think it highlights some
core issues with the approach as implemented.

--=20
Tom

--ISpri79emJgKCkvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeueVQACgkQFHw5/5Y0
tyx4Cgv8C/kzy1A0TAjqGqXntR6dy+R7I3G1YrnluXV2f3fihj9SolW/jSAQdxAo
jsdRCcn8M/EDmhpsZQldFbgyDDn5OQvkIEfyCWFFIa3meKiaH4VPV8DkheT1wZ2N
8UBWe5CZhPCJRwVOgDLijnM3Pt7o4GaClfWzqpzAFw2qGc2GYX0IVsYFEKZeDZ6I
+iXWm3hVbXYsQahlFBiZAUY1APhxjAgu5QgS6bLsVaMQgBD7acPW8x+i7N+Dh68H
eHDm+O30PBUh7to5G0Wx78H05Je+MgSoVUewOAsknfN+muplyWg56lfADJ4ttYGW
TjObv7O+FM5I0AQoIR2//ow2JAof+7ZWrAfk/Izi17Kk+cJYeAzYiyDp5/kAjkiO
pTlXpS6U8UuDpJjRkZWu/njB+MMZuph9o4r7kWesPyaVSAAywxmwwaZXRnCVpZdk
LqM91OATaY9zCu4beH3llrlS9OzDOUKzdImHXh2J11T9jyyNS+B8RxgOaYDAkHfY
ksfIOhd6
=ChIb
-----END PGP SIGNATURE-----

--ISpri79emJgKCkvz--
