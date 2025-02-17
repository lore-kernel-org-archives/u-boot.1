Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD76C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 20:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 977C480BAE;
	Mon, 17 Feb 2025 21:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kgVu3mbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E2880F0B; Mon, 17 Feb 2025 21:17:59 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC22807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 21:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22113560c57so36711705ad.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 12:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739823475; x=1740428275; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pQbUieErbh0F0x8vbikohV89ojr5ISY/dbJrQoE8lb0=;
 b=kgVu3mbJGJMH+agmNMrEJ/8OuHdb2qs1Y/QTk5a1V0Umk0GtowiCyM7dj00x7DYkPz
 hV6JSgXHI/jmBWVUJ3GVYDSiUsbUa1ucAKjNMTfszBzZAP+apvjRd45kRjXH+kCHB98P
 df5VFJFJ6E0NIk4ZVWifNB4T2R19qj/7tzvFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739823475; x=1740428275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQbUieErbh0F0x8vbikohV89ojr5ISY/dbJrQoE8lb0=;
 b=ME8BrCfRuzjStH9dfbhV+KgUXrdLaWSJHQY4ab86sa82T4W3+8gsPSH+7zXro/l+Sp
 mJRA9fWlqka7mletW8RCnKGSmdJBFFNADwkMtFgjP5pJu3jpFIZzXZNCMdyNoGwtXBNw
 q6vmB9mMx2VtHn5QJDCZkzpRowfdsr17ZBBmSsrVxdNXL1Uat4UbpPXcsyMtCVR+2m99
 hODaRMvm+w02OxrYOKQzonIfvHK6Sa5a4LtmkK+I9WXIuGkhLYVh/nK7yUQ121sWBjeZ
 AspeEgZXbBe4SmBHozmY6Q1DDwJxItsSvlpg3xKsvJ0DNGeyPAS4lhWZI66UkZ5S/CRO
 XRbQ==
X-Gm-Message-State: AOJu0Yx4oJ0BFemRg8vYrCF4JlMfQb2PPKsJf3NQTCSnWA0znPn32753
 DHuj1xdwS3TRf2w5Dh8UGI3h2MhEHdqCYYJxWy8/+VUvgH2tkvPVDAnYnekFn7k=
X-Gm-Gg: ASbGncscAB+GPI8YO1W80NXGcb+62RE4kWBDFRcaYhC1CQ0po965jeTagQALfuQy25P
 KayO3gtxAo0XbA8hbjmQa13G2apGyXujnrVc0fCIIGJrbJq5q0ixMP5PUmdULxyA4BAPRWsGamc
 Si6ajE2Foeu0Ef9NtBdD7BeCq7AdP+Lp4UVmeMy4HoBdK6L5hfytXTAbGkYidhI4GMXxJHLquOK
 Smxs1Ty8xqsu5ty3MCWkhOzUVR43V2bSGInmmwcTjDQ7wcsPi8ns7kNztxjhxgQ++euuFJ6fBf2
 bCZm/0HIuV4CDw==
X-Google-Smtp-Source: AGHT+IFBUKNvS6Yb1kSFml2P5SI5WnxO+1xILkgj9Byb9a65ugaWlfYDHzUTUhqOdhNl8I5gmyaSpQ==
X-Received: by 2002:a17:902:d502:b0:21d:dfae:300b with SMTP id
 d9443c01a7336-22103ef5265mr198511875ad.10.1739823475383; 
 Mon, 17 Feb 2025 12:17:55 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d43dsm76102215ad.158.2025.02.17.12.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 12:17:54 -0800 (PST)
Date: Mon, 17 Feb 2025 14:17:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250217201751.GZ1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <20250217185035.GT1233568@bill-the-cat>
 <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
 <20250217192156.GV1233568@bill-the-cat>
 <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
 <20250217194732.GY1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PtmaCOIF1yvRJN38"
Content-Disposition: inline
In-Reply-To: <20250217194732.GY1233568@bill-the-cat>
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


--PtmaCOIF1yvRJN38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
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
> > > > > >
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
> > > > > >
> > > > > > My request instead is:
> > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so =
on, just
> > > > > >   DM_MMC) as a prefix.
> > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a de=
fconfig.
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
> > > > > Lets come back up here, to my proposal, since parts of it seem to=
 have
> > > > > not been clear enough. While what I'm proposing should work for a=
ny
> > > > > platform and xPL -> xPL -> ... -> PPL, for this example let us as=
sume
> > > > > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also, to
> > > > > compare with today, it will be helpful to run "make
> > > > > O=3D/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" and ha=
ve the
> > > > > resulting .config file available.
> > > > >
> > > > > There shall be configs/rockpro64-rk3399_tpl_defconfig. This will =
contain
> > > > > lines such as:
> > > > > CONFIG_ARM=3Dy
> > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > CONFIG_TPL=3Dy
> > > > >
> > > > > When you run "make O=3D/tmp/rockpro64-rk3399_tpl rockpro64-rk3399=
_tpl_defconfig"
> > > > > the resulting .config file will contain lines such as:
> > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > as this only makes sense in the context of building something tha=
t will
> > > > > be TPL.
> > > > >
> > > > > A more complex example is that it will also contain:
> > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > > > >
> > > > > Because looking at arch/arm/mach-rockchip/Makefile a bunch of tha=
t will
> > > > > be able to be simplified (and spl_common.c should be renamed to
> > > > > xpl_common.c) to:
> > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order=
=2Eo xpl_common.o
> > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o xpl_common.o
> > > > >
> > > > > The .config file here will also contain:
> > > > > CONFIG_DM_SERIAL=3Dy
> > > > >
> > > > > What it will not contain is:
> > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > >
> > > > > This is because there is no 'config TPL_DM_SERIAL' option in
> > > > > drivers/serial/Kconfig anymore.
> > > > >
> > > > > When you next run "make O=3D/tmp/rockpro64-rk3399_tpl all" the re=
sults in
> > > > > /tmp/rockpro64-rk3399_tpl would be similar to the results as under
> > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > >
> > > > > The contents of configs/rockpro64-rk3399_spl_defconfig would be s=
imilar
> > > > > to the tpl one, except with SPL-only-ever-valid options such as
> > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but otherwise have CONFIG_DM=
_SERIAL=3Dy
> > > > > and no CONFIG_SPL_DM_SERIAL=3Dy, and when building the "all" targ=
et, you
> > > > > would only get similar results to what is under the spl/ directory
> > > > > today.
> > > > >
> > > > > Next we have configs/rockpro64-rk3399_ppl_defconfig.  When you ru=
n "make
> > > > > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig" the
> > > > > important difference is what you do not have. You do not have:
> > > > > CONFIG_SPL=3Dy
> > > > > CONFIG_TPL=3Dy
> > > > >
> > > > > Because we are not building SPL nor TPL. We're just making full U=
-Boot
> > > > > itself. This is where in more full examples and with additional
> > > > > restructure a "generic-arm64_ppl_defconfig" makes sense and be us=
ed
> > > > > instead.
> > > > >
> > > > > This brings up what to do with "ockpro64-rk3399_defconfig". And I=
'm a
> > > > > little unsure which of the things I mentioned above is best. It's
> > > > > either:
> > > > > a) Does not exist, top-level Makefile says roughly:
> > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
> > > > >   make O=3D$(objdir)/tpl %_tpl_defconfig all
> > > > >   make O=3D$(objdir)/spl %_spl_defconfig all
> > > > >   make O=3D$(objdir)/ppl %_ppl_defconfig all
> > > > >
> > > > > But this might be too rigid.
> > > > > b) It contains:
> > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > And the top-level Makefile looks like:
> > > > > %_defconfig:
> > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, please see.=
=2E."
> > > > >   foreach line in $@
> > > > >     make O=3D$(objdir)/$PHASE $CONFIGFILE all
> > > > >
> > > > > It could also be some other suggestion.
> > > >
> > > > Thanks for writing that up. It is somewhat clearer.
> > > >
> > > > What happens to the Makefiles? Do they still have $(PHASE_) in them?
> > >
> > > No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHASE_)FIT)
> > > would be meaningless. Only rockpro64-rk3399_spl_defconfig would say
> > > CONFIG_FIT=3Dy (or more likely, only the resulting .config would say
> > > CONFIG_FIT=3Dy just like how configs/rockpro64-rk3399_defconfig doesn=
't
> > > say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).
> >=20
> > But just above you said:
> >=20
> > > I believe this proposal will lead to the code and Makefiles being less
> > > clear than they are today. The line:
> > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=3D block/
> > > will become:
> > > drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
> > > without being clear that it could reference either full U-Boot (PPL) =
or
> > > some xPL phase. While the same Makefile will continue to have (commen=
ts
> > > my own):
> > > obj-y +=3D mtd/ # Subdirectory Makefiles control build contents
> > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only valid for PPL.
> > >
> > > And so the situation for humans will be worse off than today because
> > > while $(PHASE_) and $(XPL_) are confusing at times, they make it clear
> > > what can and cannot be enabled in PPL vs xPL.
> > >
> > > Doing "something" is not better than doing nothing in this case.
> >=20
> > So why is OK for your proposal to drop the $(PHASE_) stuff, but not min=
e?
>=20
> Because your proposal keeps CONFIG_SPL_BLK (and config SPL_BLK) and has
> a .config file which says "CONFIG_SPL_BLK=3Dy" but mine doesn't.
>=20
> Or to try and explain differently, with your proposal "I have a problem,
> and I want to see what builds with CONFIG_SPL_BLK=3Dy. Why is there no
> match in the source tree for CONFIG_SPL_BLK or even SPL_BLK". With my
> proposal "I have a problem, and I want to see what my SPL build has with
> CONFIG_BLK=3Dy. I can see hits in the source tree for CONFIG_BLK, the
> symbol I set, I can solve my problem."

My other try here was a bit unclear actually because of the confusion
state your proposal gives us. Try try again directly, the problem is
that CONFIG_SPL_BLK will be set (or unset) but not referenced in code.
This will be true for many but not all SPL symbols as
CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exist and need
to be referenced. This is a more confusing state than $(PHASE_). $(XPL_)
I think can just be replaced with $(PHASE_) but I haven't confirmed (I
think it does show that the old way was confusing however).

--=20
Tom

--PtmaCOIF1yvRJN38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezmWcACgkQFHw5/5Y0
tyyLHgv/Y813l1rdaPPkOpGQA6G+YEDr6XgffhfrGzgAb3LS1PY/5U/PaPp66g11
o522e0uWr5zVw3WBeLQoT+iYrNwj8AlqW5DNZsinsxpPrgyhTOSrHC97IQRw3S/T
rYfam51c2x0ZeoUhDbMGrJZMwK6Albgo962v99rHkTVys7bQcYR8ErcbmlGWMCem
0tHnDadV0MTDUsRilxvFdB8xaQBpm3vHMkK2+sq/1JIRxyaXik4qRVsHsAd5vybD
fUfiLJbyQ0UFVzX3gOl+SYZaNonG1hFIMrpdXu4Npzt07Wq6qF2yCGXFJzwFddCz
FMaZffI/OUoVseWbDGYNiE6jYJUY2YxsQWmz+YvNRi43rSVmovxg+6J2EIeJHe+y
WHuMBHqP7o+5MpL2GYWGBY9/Yxw8lGS2Q2oS3ZZljcjpWmnaZvyu45hfSE2WCAUw
O8M3R4cE7IcA+RMZ7wueSIlod+c3ZmTo7UWsldEHxoGQOUi+cCaAaMrOsyf0UHRt
UBuZFGBP
=x2pV
-----END PGP SIGNATURE-----

--PtmaCOIF1yvRJN38--
