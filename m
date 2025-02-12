Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B05C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0954F807C0;
	Wed, 12 Feb 2025 23:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jji6qxz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B937280C72; Wed, 12 Feb 2025 23:58:37 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3CF8043C
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c07b15ad6bso6522485a.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739401114; x=1740005914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AWP03qX4VSXgVKlBC9YuCpOCuFn57Nch9TUbTnoT2jg=;
 b=Jji6qxz0VCvEFlOFYVJAd+bB49nAh0iTuw/AiDGE5X1k/7+7nDueLTtMIBBXHgiYig
 xHapGjiZIQ7IXH3Ue0kssW0XLyyK30XQZ9axVw35JL7mW9ztDlbgZQfcMjx0jrsyrG6s
 Ecpj5zoaeMKN/S0+YntBb/a7+14P3E6ceyfMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739401114; x=1740005914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWP03qX4VSXgVKlBC9YuCpOCuFn57Nch9TUbTnoT2jg=;
 b=w8beXz9l8TC11v7pdx8atAJz8IbhOdCIJ3jTsEBxDT0q+OsOtgQ7LS+Y0eW/3bUi9K
 RcU39VCD6ydz0EfhIivzeo2iYu6m6tnb9ETKvOOFg0wqXHSg7fv9kw7U9IZhFdZuq63r
 XHSVHVXX40FzfF9Ivuhd+IZ6XkVMY3fbKBb3wxAB20KO6sWygXizRqm9umfayp9/Res8
 sEAI0ZqL466PAVtBNM4c8Prs93FW0HVPDqv0reAqDpfbDjJX8rx7E5OMuA5VZjekAOwf
 W4iL2VJrXk2RHiRgm0A3QAcw/Id8WHtRqogxdjo9MrKTozoBMi7xz+BuEB7HlU5Y+jmq
 Vc/w==
X-Gm-Message-State: AOJu0YwQ0CUv/5VbQlVx3nrXuQK4whqaEuuXdkuA4uiGDpidWbves8Sl
 2YtsRufCkzBsEQtUbS/vWE4dj7E8GZ+VU/MnxiJF6RI7fd/F/7EcBx8wilr4vLk=
X-Gm-Gg: ASbGncvlMKDgw+uiXgfTc5AQUZ+8WhChp+GMcAIBtqZSjp4I1iYzegWH1nJDOXg1Dgy
 QX+nga1Dy/lic12/+Ugar2H2EWa3l9w/FoXnQg8PUtoqsndres2mmZakD3j9VJiiqCH/6x4H02o
 fGXpVWNNI1U26HvRRUBR7rJWbZcEEWrI2KniM6rZuEZc0Cd6lAZe0109Xf0bSsOsiEaB2FLny2U
 GL5iYuaDn+BTzxqxSp/9xtwxRc60Jt8TS0/Ge5cirggXmHorN0khH89X4BgKTij4W+iOkgOXErJ
 kkxILjHCDYc63DU=
X-Google-Smtp-Source: AGHT+IGmyJrE0j8UuWLS2fqKx1uTTtRHB5HTlZ2EPaWUhG+Pf/1KJUDeWLDS1akcitURKkhceYZKuw==
X-Received: by 2002:a05:620a:29c7:b0:7b6:cedf:1b4e with SMTP id
 af79cd13be357-7c06fccec4emr650516085a.41.1739401113327; 
 Wed, 12 Feb 2025 14:58:33 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c0523b09basm639601285a.98.2025.02.12.14.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:58:32 -0800 (PST)
Date: Wed, 12 Feb 2025 16:58:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250212225829.GS1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <20250212183537.GQ1233568@bill-the-cat>
 <CAFLszTh5HS49DY1iqqcm_mT3tm2maUVAxyTXoP=5QxL1obw+jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eMdcWeu7u6F4v/7U"
Content-Disposition: inline
In-Reply-To: <CAFLszTh5HS49DY1iqqcm_mT3tm2maUVAxyTXoP=5QxL1obw+jw@mail.gmail.com>
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


--eMdcWeu7u6F4v/7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 01:05:11PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > I just wanted to send a note to (re-)introduce my ideas[1] fo=
r the
> > > > > > > next iteration of xPL.
> > > > > > >
> > > > > > > A recent series introduced 'xPL' as the name for the various
> > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is=
 any xPL
> > > > > > > phase and CONFIG_SPL means this really is the SPL phase, not =
TPL. We
> > > > > > > still use filenames and function naming which uses 'spl', but=
 could
> > > > > > > potentially adjust that.
> > > > > > >
> > > > > > > The major remaining problem IMO is that it is quite tricky and
> > > > > > > expensive (in terms of time) to add a new phase. We also have=
 some
> > > > > > > medium-sized problems:
> > > > > > >
> > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually =
ugly and
> > > > > > > can be confusing, particularly when combined with ifdef and i=
fneq
> > > > > > >
> > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they=
 mean
> > > > > > > different things. For any given option, some code uses one an=
d some
> > > > > > > the other, depending on what problems people have met along t=
he way.
> > > > > > >
> > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it could m=
ean that
> > > > > > > the option is enabled in one or more xPL phases, or just in U=
-Boot
> > > > > > > proper. The only way to know is to look for $(PHASE_) etc. in=
 the
> > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very c=
onfusing
> > > > > > > and has not scaled well.
> > > > > > >
> > > > > > > d. We need to retain an important feature: options from diffe=
rent
> > > > > > > phases can depend on each other. As an example, we might want=
 to
> > > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot pro=
per. We
> > > > > > > may also want to share values between phases, such as TEXT_BA=
SE. We
> > > > > > > can do this easily today, just by adding Kconfig rules.
> > > > > >
> > > > > > I agree with a through c and for d there are likely some cases =
even if
> > > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's=
 as
> > > > > > important as the other ones.
> > > > >
> > > > > OK. No, TEXT_BASE is not a great example in my book either. But i=
t is
> > > > > true that SPL needs to know U-Boot's text base.
> > > > >
> > > > > Here's another:
> > > > >
> > > > > config SPL_SYS_MALLOC_F_LEN
> > > > >    default SYS_MALLOC_F_LEN
> > > > >
> > > > > config TPL_SYS_MALLOC_F
> > > > >    default y if SPL_SYS_MALLOC_F
> > > > >
> > > > > config TPL_SYS_MALLOC_F_LEN
> > > > >    depends on TPL_SYS_MALLOC_F
> > > > >    default SPL_SYS_MALLOC_F_LEN
> > > >
> > > > Alternatively:
> > > > config SYS_MALLOC_LEN
> > > >    ... current default X if Y
> > > >    default 0x2800 if RCAR_GEN3 && !PPL
> > > >    default 0x2000 if IMX8MQ && !PPL
> > >
> > > PPL means (in my book) that we have a PPL, i.e. it is always true. It
> >
> > And in my proposal you're choosing between PPL, SPL, TPL, VPL.
> >
> > > is the same today, with SPL. We have CONFIG_SPL_BUILD which indicates
> > > which build it is. If you are suggesting that SPL means that this is
> > > the SPL build, then which thing tells us whether or not we have an SPL
> > > build? I'm just a bit confused by this.
> >
> > And we wouldn't have CONFIG_SPL_BUILD because we would either be
> > configuring for SPL=3Dy or SPL=3Dn, there's no confusion anymore.
> >
> > > But how can I make the TPL value of SYS_MALLOC_F_LEN the same as the
> > > SPL one, with your scheme?
> >
> > If your question is "how do I set an arbitrary but consistent value in
> > SPL and SPL" that's not enforced. But they also shouldn't be arbitrary
> > and we should have sane defaults set in Kconfig, regardless of either
> > proposal. While I'm trying to not get lost in the details today we have
> > 80 matches on "git grep SPL_.*_LEN=3D configs/" and 2 for TPL and I wou=
ld
> > encourage someone to verify those are needed. My initial recollection is
> > that most of these are from when we bumped SYS_MALLOC_F_LEN or so up to
> > the commonly used default and had the few platforms that didn't use the
> > new default previously switch to the old one.
> >
> > In other words, I don't think there's a problem here that isn't solved
> > today, outside of either proposal.
> >
> > > So I'm still not understanding how you handle Kconfig dependencies
> > > between phases with your scheme. Are you saying you don't and they are
> > > not important?
> >
> > Basically. The majority of the cases of:
> > config SPL_FOO
> >    default y if FOO
> >
> > config TPL_FOO
> >    default y if SPL_FOO
> >
> > Just go away because FOO is already default y or select/imply'd by
> > TARGET_BAR or ARCH_BAZ.
> >
> > > Also, is there a single Kconfig tree for U-Boot, or are you saying you
> > > want a different set of Kconfig files for each phase?
> >
> > Just the Kconfig files we have today. Likely with less overall lines
> > since for example we could drop:
> > config SPL_FS_EXT4
> >         bool "Support EXT filesystems"
> >         select SPL_CRC16 if EXT4_WRITE
> >
> > Since we already have fs/ext4/Kconfig.
> >
> > > > > > > Proposal
> > > > > > >
> > > > > > > 1. Adjust kconf to generate separate autoconf.h files for eac=
h phase.
> > > > > > > These contain the values for each Kconfig option for that pha=
se. For
> > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > > > > >
> > > > > > > 2. Add a file to resolve the ambiguity in (c) above, listing =
the
> > > > > > > Kconfig options which should not be enabled/valid in any xPL =
build.
> > > > > > > There are around 200 of these.
> > > > > > >
> > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot prope=
r (only),
> > > > > > > useful in rare cases. This indicates that the option applies =
only to
> > > > > > > U-Boot proper and is not defined in any xPL build. It is anal=
ogous to
> > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of thes=
e are
> > > > > > > needed at present, basically to allow access to the value for=
 another
> > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that =
it knows
> > > > > > > the address to which U-Boot should be loaded.
> > > > > > >
> > > > > > > 4. There is no change to the existing defconfig files, or 'ma=
ke
> > > > > > > menuconfig', which works just as today, including dependencie=
s between
> > > > > > > options across all phases.
> > > > > > >
> > > > > > > 5. (next) Expand the Kconfig language[2] to support declaring=
 phases
> > > > > > > (SPL, TPL, etc.) and remove the need for duplicating options =
(DM_MMC,
> > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to=
 be
> > > > > > > declared once for any/all phases. We can then drop the file i=
n 2
> > > > > > > above.
> > > > > > >
> > > > > > > With this, maintaining Kconfig options, Makefiles and adding =
a new
> > > > > > > phase should be considerably easier.
> > > > > >
> > > > > > I think this will not make our life easier, it will make things=
 harder.
> > > > > >
> > > > > > I think what we've reached now shows that Yamada-san was correc=
t at the
> > > > > > time in saying that we were going down the wrong path with how =
we
> > > > > > handled SPL/TPL.
> > > > >
> > > > > You've mentioned this quite a few times over the years. Is there a
> > > > > reference to what he suggested we should do? Or perhaps it is wha=
t you
> > > > > have below.
> > > >
> > > > I don't recall what he proposed instead, just that when it became c=
lear
> > > > that I wanted to move from the "S:CONFIG_FOO.." syntax for how SPL =
was
> > > > handled to how we're doing it today, he thought that was the wrong
> > > > direction.
> > >
> > > Yes, IMO he was right about that.
> > >
> > > >
> > > > > > My request instead is:
> > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so =
on, just
> > > > > >   DM_MMC) as a prefix.
> > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a de=
fconfig.
> > > > >
> > > > > Good idea.
> > > > >
> > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > > > > >   and add Makefile logic such that for X_defconfig as a build t=
arget but
> > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a buil=
ds in
> > > > > >   subdirectories of our object directory, and then using binman=
 combine
> > > > > >   as needed.
> > > > >
> > > > > This means splitting the existing file into a separate one for ea=
ch
> > > > > phase. I believe that will be hard to manage.
> > > >
> > > > Do you mean initially, or long term? Initially, it should be a bit =
of
> > > > shell scripting. The consolidation (ie most/all rk3399 having an
> > > > identical _spl_defconfig) can't be automated. Long term I'm not sur=
e it
> > > > would be any different. Most of the maintenance is on resync'ing wh=
ich
> > > > is automated.
> > >
> > > Long term. How does 'make menuconfig' work in this case? Won't you
> > > have to run it three times for SPL, TPL and PPL?
> >
> > Yes, you would run configure for what you're building. This is a good
> > thing as it will no longer be so confusing to hunt down where SPL or TPL
> > or VPL options for a specific thing reside.
> >
> > > > > >   - Maybe instead the Makefile logic above we would parse X_def=
config
> > > > > >     and see if it's a different format of say PHASE:file to mak=
e it
> > > > > >     easier to say share a single TPL config with all rk3399, ha=
ve a few
> > > > > >     common SPL configs and then just a board specific PPL.
> > > > > >
> > > > > > This solves (a) by removing them entirely. This solves (b) by r=
emoving
> > > > > > the ambiguity entirely (it will be enabled or not). As a bonus =
for (b)
> > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up w=
ith the
> > > > > > Linux Kernel again. This solves (c) again by removing it entire=
ly.
> > > > >
> > > > > The scheme I propose removes a-c also. I should have made that cl=
ear.
> > > >
> > > > Er, ok. That's not how it looked before, but I guess I'm just mista=
ken.
> > >
> > > Yes I think so...it was a major goal to remove this stuff. [1] [2]
> >
> > Thanks.
> >
> > > > > There is not a huge difference between your scheme and mine. My
> > > > > question is, how do you handle (d)?
> > > >
> > > > Well, either (d) isn't important as for example MMC wasn't a good c=
hoice
> > > > in your proposal as virtually everyone "select MMC" today or it's
> > > > handled more easily as my example above in SYS_MALLOC_LEN.
> > > >
> > > > > The way I see it, both schemes remove the ambiguity. Mine retains=
 a
> > > > > single deconfig file and a single 'make menuconfig' for each boar=
d.
> > > > > Yours feels more like building independent U-Boot images.
> > > >
> > > > It is explicitly building independent U-Boot images, yes. With a wr=
apper
> > > > around "make all of the images for a given platform". So much of our
> > > > confusing and messy code is because we aren't doing that. And since=
 most
> > > > modern SoCs can work as (mostly )generic SPL selects correct DTB fo=
r PPL
> > > > we really could have fewer overall build configurations.
> > >
> > > I'd really like to see a generic aarch64 U-Boot for PPL, although it
> > > would be quite large with all the drivers. Perhaps we could start by
> > > having a generic Rockchip one, for example.
> > >
> > > Still I don't see this being strongly related to the discussion about
> > > these two different schemes.
> >
> > Well, in your scheme how do we have say generic-aarch64_defconfig
> > function on either chromebook_bob or am62x_beagleplay_a53 ? In mine,
> > since everything is a separate build, generic-aarch64_defconfig has
> > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_RK3399=3Dy. And then
> > chromebook_bob_defconfig would say to use chromebook_bob_tpl_defconfig,
> > generic-rk3399_spl_defconfig and generic-aarch64_defconfig. As a bonus
> > instead of am62x_beagleplay_a53_defconfig and
> > am62x_beagleplay_r5_defconfig we would have am62x_beagleplay_defconfig
> > that would say to use the appropriate SPL/PPL for R5, and appropriate
> > SPL/PPL for A53.
> >
> > But the one big huge caveat I want to make here is that "generic" images
> > are useful in some use cases (I'm sure all of the regular F/OSS
> > distributions would love a single actually common PPL if they can fit
> > it) will strip things down. Whatever the IoT edge device closest to you
> > now really won't want to ship with all the platforms enabled. Image size
> > still matters.
>=20
> OK thanks for the details. I think I have a reasonable idea of what
> you are proposing, now. It would work, but is quite radical, IMO.
> That's not necessarily a bad thing, but in my mind I see a sequencing
> possibility.
>=20
> A few points from my side:
>=20
> 1. I would love to see the defconfig files reduce in size, with more
> and better defaults. One way to do this would be to enforce a maximum
> length. I added a feature to qconfig to allow finding common options
> among boards (the -i flag), but I'm not sure if many people use it.

I don't see reducing defconfig size as important honestly. Should we
have more and better defaults? Yes. But almost everything is under 200
lines with the biggest (non-sandbox) ones being the generic zynqmp
platform(s?).

> 2. Generic boards is something I have been pushing for years (in fact
> it is why I originally introduced devicetree), but I'm not seeing a
> lot of traction.

I don't think generic boards are universally helpful. Even if what I'm
proposing would allow for more of it, below the PPL stage I'm not sure
it's both feasible enough and useful enough for production. At the PPL
stage it still has to be small enough and not overly burdensome. What we
talked about on the call yesterday about using more multi-dtb images is
a step in the right direction, yes.

> 3. Iit seems that you want to remove all the 'if SPL' pieces and just
> rely on the current PPL configuration. But how will that work? There
> are tons of features which don't work in SPL, or are not relevant, or
> have special 'small' versions. That is a *lot* of Kconfig refactoring
> just to get something working, isn't it? With my scheme there is no
> Kconfig change needed initially - it can be done later as needed /
> desirable.

I don't think we would remove most "if SPL" cases. Taking part of the
current stanza for ROCKCHIP_RK3399 as an example:
config ROCKCHIP_RK3399
        bool "Support Rockchip RK3399"
        select ARM64
        select SUPPORT_SPL
        select SUPPORT_TPL
        select SPL
        select SPL_ATF
        select SPL_BOARD_INIT if SPL
	...
        select SPL_CLK if SPL
	...
        select CLK
	...
	imply TPL_CLK


This would become:
config ROCKCHIP_RK3399
        bool "Support Rockchip RK3399"
        select ARM64
        select SUPPORT_SPL
        select SUPPORT_TPL
        select SPL_ATF if SPL # TBD: Does 'ATF' make sense outside of SPL?
        select BOARD_INIT if SPL # Not TPL_BOARD_INIT here
        select CLK # imply was likely wrong before? Would need to check
	...

> 4. My scheme splits the config into separate files. Yours makes the

I don't see yours as splitting the configs in to separate files, I see
it as generating some intermediate objects. The configs don't change and
that's one of our problem areas.

> split earlier, at the Kconfig level. So it seems that we could go with
> my scheme to get us to a split config, then, after that, decide
> whether to move that split earlier to Kconfig itself. The choices

I don't think so. Yours makes things complicated by making the build do
even more (and from the RFC, the implementation tooling diverges from
upstream). Mine makes things differently complicated by doing less for
most things, but needing some thought on how to know that say
chromebook_bob needs chromebook_bob_tpl_defconfig,
chromebook_bob_spl_defconfig and chromebook_bob_ppl_defconfig to be
built, before asking binman to go put things together.

> would then be to use your scheme (Kconfig refactoring, splitting
> defconfigs and some rework), or to do my scheme (which would require
> enhancing the Kconfig language a bit just for U-Boot and some optional
> rework over time). Both schemes would need a small amount of
> build-logic changes, but I'm not sure yet what that would look like.
>=20
> Does that sound right?

With what I said above, yes I think we're closer at least to
understanding each other.

--=20
Tom

--eMdcWeu7u6F4v/7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmetJ40ACgkQFHw5/5Y0
tyzVfAv/X1Sp4aZOdC09Lkzec47GRTVkf866R4hUFIzM/kgsbidKrsxxPg2bePSI
UTrZY7JszZ31ZokBWqBfsri6ep2tRNWqfUci9N51gj7Lha5OhMfgiY/4MRGuNqg/
tjmIJ/MlQwQtJmtgL4Mw6RDe0kTCGPNQtuXcehiUZ1BeN+83UhPDq0eLuLcwJSN8
1Gwnymbel9xtv/o32FK3zInX5fpz/KFA4/erMdGhAIUZaDlpHfB3U0NM1rQB/q4T
+nvjiYfEbVtffCDJCuaa530pTf2VEsFmUv0E2xWbzh0udDc91aGuu0UHIGMhJrsD
o4lynZirOTFrMXQXB9qYS3/YKis25Gp6J3vW6HTz0rDpqTg2LDFhG8V23Qq061+s
g5gXnyRRtYUMWSh+PGKBtFT6siSWzT6zachaGD4o2ZeC0UDARlyANT3kiX/eOiY7
KEc5gmFFfQELW8x4D8NT3/1vCUwtG/QnRwtnX7G1+xswtv2gAP++DDgP8Pebxxox
12Q7TfVT
=Xpa2
-----END PGP SIGNATURE-----

--eMdcWeu7u6F4v/7U--
