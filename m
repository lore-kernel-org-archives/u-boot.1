Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1D6C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 18:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC9580F68;
	Thu, 13 Feb 2025 19:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b93DwT4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725D280EBD; Thu, 13 Feb 2025 19:04:00 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1312580ECB
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 19:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e4419a47887so929351276.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 10:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739469836; x=1740074636; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o4lfHpRkJkrn6eJLkoYOjfy8PUQp0zF8W2jgkggLA9U=;
 b=b93DwT4nXAR2XzA07ODu8hYowhVd+8OCYuIBIgywfdFEqZYfSWiG4+12b/x56J+kE0
 hzx6Ziyky9Gn8lQaQOC5Hc1YiBTn+aeOdgjqz9MY8dfKGkcN2/Qp2WhMXaH9X6MBikZp
 r7XXoZafI4S7d53KO6yEzbhQDMjHa4e5Nv7/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739469836; x=1740074636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4lfHpRkJkrn6eJLkoYOjfy8PUQp0zF8W2jgkggLA9U=;
 b=pzKZgaFD1LmijGfQ9x3nm/+Kg4UdPYd3vmSpWxZgDLeeXwMyEd7YWrBbVEaRc/nB7y
 MJ+QjVKSt7p6I5Zk778v5GkOeVaeci8tEsG+8IoLv9zWVct7bq2yE1CEF3NYmv6vl13k
 29b7k6D74fYTz9YIhlGBnjv1nDzCr+lXPSY0urhRupC7OkQ62dTxBST8h2EAhz5fSl8a
 inH2M+AH7kYWT4B223XqVEUsw3Cawkw2pz1j4x/ZudyvArRSiosJ9lJW8gVIMnReqxeP
 kXLrm/O6ihkuQg0DeFAcAey4tGCGweqg52h8uOibNWHX+9aen/GQ8Z9p7Di0rwsnYQd+
 tsAQ==
X-Gm-Message-State: AOJu0Yzpgm6jiNrsJwBM4VjW7PT5RaNKdeNLbKu6myHBo5kMlxwtntd2
 16RLNbu2PRVx8pHLoAlP/I35G1o7f3sCqREV2QWDuynqQE76Z65fLyBJvDzmBO0=
X-Gm-Gg: ASbGncsf8yReq5aExbUfJG5fx5L1/XmvwHEZ3peD5dVbC4ZnIpcqlnMMHu4t2MtGZTT
 FMQfChL5R/bHhsei3eP1MpyTSn+6D2ItCKKGmESjBZ9N2KkjlZ/8n8wqBey3Lp7caQFJ6D5wucC
 xrZTYRAalAFP8uaIDGSJ+3pZSE/qDKPPIgM7ciMx/KLIEixjHa10VPEuCdRi0+/9GSaizoUgm71
 4hWzwOsIysXaMKvUnqB8xsVEH+4mekdYcpbgif3eaOv48eVTEX68hWfv+5tBdhmI+thyFRyys95
 ur8VUNkbpr8QE0Y=
X-Google-Smtp-Source: AGHT+IEBYrPmUXb+xafHc+xoVN//SSa0qgzQOK6TrTp/GFXTL3JG3GmthiGB0yHxB5oKB2dhIefsdw==
X-Received: by 2002:a05:690c:4903:b0:6f9:9891:7a7f with SMTP id
 00721157ae682-6fb1f269235mr83868667b3.25.1739469835563; 
 Thu, 13 Feb 2025 10:03:55 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb35d586ffsm4035387b3.9.2025.02.13.10.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 10:03:54 -0800 (PST)
Date: Thu, 13 Feb 2025 12:03:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250213180352.GY1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <20250212183537.GQ1233568@bill-the-cat>
 <CAFLszTh5HS49DY1iqqcm_mT3tm2maUVAxyTXoP=5QxL1obw+jw@mail.gmail.com>
 <20250212225829.GS1233568@bill-the-cat>
 <CAFLszThNpm9_GRVPALTc+r_b2sFa1h=ih_JuNB9BZv+t7Qj5cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lzBbEz/l64q7BkXs"
Content-Disposition: inline
In-Reply-To: <CAFLszThNpm9_GRVPALTc+r_b2sFa1h=ih_JuNB9BZv+t7Qj5cQ@mail.gmail.com>
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


--lzBbEz/l64q7BkXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 05:50:13AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 12 Feb 2025 at 15:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 01:05:11PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > I just wanted to send a note to (re-)introduce my ideas[1=
] for the
> > > > > > > > > next iteration of xPL.
> > > > > > > > >
> > > > > > > > > A recent series introduced 'xPL' as the name for the vari=
ous
> > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that thi=
s is any xPL
> > > > > > > > > phase and CONFIG_SPL means this really is the SPL phase, =
not TPL. We
> > > > > > > > > still use filenames and function naming which uses 'spl',=
 but could
> > > > > > > > > potentially adjust that.
> > > > > > > > >
> > > > > > > > > The major remaining problem IMO is that it is quite trick=
y and
> > > > > > > > > expensive (in terms of time) to add a new phase. We also =
have some
> > > > > > > > > medium-sized problems:
> > > > > > > > >
> > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visua=
lly ugly and
> > > > > > > > > can be confusing, particularly when combined with ifdef a=
nd ifneq
> > > > > > > > >
> > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and =
they mean
> > > > > > > > > different things. For any given option, some code uses on=
e and some
> > > > > > > > > the other, depending on what problems people have met alo=
ng the way.
> > > > > > > > >
> > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it cou=
ld mean that
> > > > > > > > > the option is enabled in one or more xPL phases, or just =
in U-Boot
> > > > > > > > > proper. The only way to know is to look for $(PHASE_) etc=
=2E in the
> > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is ve=
ry confusing
> > > > > > > > > and has not scaled well.
> > > > > > > > >
> > > > > > > > > d. We need to retain an important feature: options from d=
ifferent
> > > > > > > > > phases can depend on each other. As an example, we might =
want to
> > > > > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot=
 proper. We
> > > > > > > > > may also want to share values between phases, such as TEX=
T_BASE. We
> > > > > > > > > can do this easily today, just by adding Kconfig rules.
> > > > > > > >
> > > > > > > > I agree with a through c and for d there are likely some ca=
ses even if
> > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure =
it's as
> > > > > > > > important as the other ones.
> > > > > > >
> > > > > > > OK. No, TEXT_BASE is not a great example in my book either. B=
ut it is
> > > > > > > true that SPL needs to know U-Boot's text base.
> > > > > > >
> > > > > > > Here's another:
> > > > > > >
> > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > >
> > > > > > > config TPL_SYS_MALLOC_F
> > > > > > >    default y if SPL_SYS_MALLOC_F
> > > > > > >
> > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > >    default SPL_SYS_MALLOC_F_LEN
> > > > > >
> > > > > > Alternatively:
> > > > > > config SYS_MALLOC_LEN
> > > > > >    ... current default X if Y
> > > > > >    default 0x2800 if RCAR_GEN3 && !PPL
> > > > > >    default 0x2000 if IMX8MQ && !PPL
> > > > >
> > > > > PPL means (in my book) that we have a PPL, i.e. it is always true=
=2E It
> > > >
> > > > And in my proposal you're choosing between PPL, SPL, TPL, VPL.
> > > >
> > > > > is the same today, with SPL. We have CONFIG_SPL_BUILD which indic=
ates
> > > > > which build it is. If you are suggesting that SPL means that this=
 is
> > > > > the SPL build, then which thing tells us whether or not we have a=
n SPL
> > > > > build? I'm just a bit confused by this.
> > > >
> > > > And we wouldn't have CONFIG_SPL_BUILD because we would either be
> > > > configuring for SPL=3Dy or SPL=3Dn, there's no confusion anymore.
> > > >
> > > > > But how can I make the TPL value of SYS_MALLOC_F_LEN the same as =
the
> > > > > SPL one, with your scheme?
> > > >
> > > > If your question is "how do I set an arbitrary but consistent value=
 in
> > > > SPL and SPL" that's not enforced. But they also shouldn't be arbitr=
ary
> > > > and we should have sane defaults set in Kconfig, regardless of eith=
er
> > > > proposal. While I'm trying to not get lost in the details today we =
have
> > > > 80 matches on "git grep SPL_.*_LEN=3D configs/" and 2 for TPL and I=
 would
> > > > encourage someone to verify those are needed. My initial recollecti=
on is
> > > > that most of these are from when we bumped SYS_MALLOC_F_LEN or so u=
p to
> > > > the commonly used default and had the few platforms that didn't use=
 the
> > > > new default previously switch to the old one.
> > > >
> > > > In other words, I don't think there's a problem here that isn't sol=
ved
> > > > today, outside of either proposal.
> > > >
> > > > > So I'm still not understanding how you handle Kconfig dependencies
> > > > > between phases with your scheme. Are you saying you don't and the=
y are
> > > > > not important?
> > > >
> > > > Basically. The majority of the cases of:
> > > > config SPL_FOO
> > > >    default y if FOO
> > > >
> > > > config TPL_FOO
> > > >    default y if SPL_FOO
> > > >
> > > > Just go away because FOO is already default y or select/imply'd by
> > > > TARGET_BAR or ARCH_BAZ.
> > > >
> > > > > Also, is there a single Kconfig tree for U-Boot, or are you sayin=
g you
> > > > > want a different set of Kconfig files for each phase?
> > > >
> > > > Just the Kconfig files we have today. Likely with less overall lines
> > > > since for example we could drop:
> > > > config SPL_FS_EXT4
> > > >         bool "Support EXT filesystems"
> > > >         select SPL_CRC16 if EXT4_WRITE
> > > >
> > > > Since we already have fs/ext4/Kconfig.
> > > >
> > > > > > > > > Proposal
> > > > > > > > >
> > > > > > > > > 1. Adjust kconf to generate separate autoconf.h files for=
 each phase.
> > > > > > > > > These contain the values for each Kconfig option for that=
 phase. For
> > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text =
base.
> > > > > > > > >
> > > > > > > > > 2. Add a file to resolve the ambiguity in (c) above, list=
ing the
> > > > > > > > > Kconfig options which should not be enabled/valid in any =
xPL build.
> > > > > > > > > There are around 200 of these.
> > > > > > > > >
> > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot p=
roper (only),
> > > > > > > > > useful in rare cases. This indicates that the option appl=
ies only to
> > > > > > > > > U-Boot proper and is not defined in any xPL build. It is =
analogous to
> > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of =
these are
> > > > > > > > > needed at present, basically to allow access to the value=
 for another
> > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so t=
hat it knows
> > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > >
> > > > > > > > > 4. There is no change to the existing defconfig files, or=
 'make
> > > > > > > > > menuconfig', which works just as today, including depende=
ncies between
> > > > > > > > > options across all phases.
> > > > > > > > >
> > > > > > > > > 5. (next) Expand the Kconfig language[2] to support decla=
ring phases
> > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicating opti=
ons (DM_MMC,
> > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an optio=
n to be
> > > > > > > > > declared once for any/all phases. We can then drop the fi=
le in 2
> > > > > > > > > above.
> > > > > > > > >
> > > > > > > > > With this, maintaining Kconfig options, Makefiles and add=
ing a new
> > > > > > > > > phase should be considerably easier.
> > > > > > > >
> > > > > > > > I think this will not make our life easier, it will make th=
ings harder.
> > > > > > > >
> > > > > > > > I think what we've reached now shows that Yamada-san was co=
rrect at the
> > > > > > > > time in saying that we were going down the wrong path with =
how we
> > > > > > > > handled SPL/TPL.
> > > > > > >
> > > > > > > You've mentioned this quite a few times over the years. Is th=
ere a
> > > > > > > reference to what he suggested we should do? Or perhaps it is=
 what you
> > > > > > > have below.
> > > > > >
> > > > > > I don't recall what he proposed instead, just that when it beca=
me clear
> > > > > > that I wanted to move from the "S:CONFIG_FOO.." syntax for how =
SPL was
> > > > > > handled to how we're doing it today, he thought that was the wr=
ong
> > > > > > direction.
> > > > >
> > > > > Yes, IMO he was right about that.
> > > > >
> > > > > >
> > > > > > > > My request instead is:
> > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and=
 so on, just
> > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building =
a defconfig.
> > > > > > >
> > > > > > > Good idea.
> > > > > > >
> > > > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defco=
nfig
> > > > > > > >   and add Makefile logic such that for X_defconfig as a bui=
ld target but
> > > > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a =
builds in
> > > > > > > >   subdirectories of our object directory, and then using bi=
nman combine
> > > > > > > >   as needed.
> > > > > > >
> > > > > > > This means splitting the existing file into a separate one fo=
r each
> > > > > > > phase. I believe that will be hard to manage.
> > > > > >
> > > > > > Do you mean initially, or long term? Initially, it should be a =
bit of
> > > > > > shell scripting. The consolidation (ie most/all rk3399 having an
> > > > > > identical _spl_defconfig) can't be automated. Long term I'm not=
 sure it
> > > > > > would be any different. Most of the maintenance is on resync'in=
g which
> > > > > > is automated.
> > > > >
> > > > > Long term. How does 'make menuconfig' work in this case? Won't you
> > > > > have to run it three times for SPL, TPL and PPL?
> > > >
> > > > Yes, you would run configure for what you're building. This is a go=
od
> > > > thing as it will no longer be so confusing to hunt down where SPL o=
r TPL
> > > > or VPL options for a specific thing reside.
> > > >
> > > > > > > >   - Maybe instead the Makefile logic above we would parse X=
_defconfig
> > > > > > > >     and see if it's a different format of say PHASE:file to=
 make it
> > > > > > > >     easier to say share a single TPL config with all rk3399=
, have a few
> > > > > > > >     common SPL configs and then just a board specific PPL.
> > > > > > > >
> > > > > > > > This solves (a) by removing them entirely. This solves (b) =
by removing
> > > > > > > > the ambiguity entirely (it will be enabled or not). As a bo=
nus for (b)
> > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match =
up with the
> > > > > > > > Linux Kernel again. This solves (c) again by removing it en=
tirely.
> > > > > > >
> > > > > > > The scheme I propose removes a-c also. I should have made tha=
t clear.
> > > > > >
> > > > > > Er, ok. That's not how it looked before, but I guess I'm just m=
istaken.
> > > > >
> > > > > Yes I think so...it was a major goal to remove this stuff. [1] [2]
> > > >
> > > > Thanks.
> > > >
> > > > > > > There is not a huge difference between your scheme and mine. =
My
> > > > > > > question is, how do you handle (d)?
> > > > > >
> > > > > > Well, either (d) isn't important as for example MMC wasn't a go=
od choice
> > > > > > in your proposal as virtually everyone "select MMC" today or it=
's
> > > > > > handled more easily as my example above in SYS_MALLOC_LEN.
> > > > > >
> > > > > > > The way I see it, both schemes remove the ambiguity. Mine ret=
ains a
> > > > > > > single deconfig file and a single 'make menuconfig' for each =
board.
> > > > > > > Yours feels more like building independent U-Boot images.
> > > > > >
> > > > > > It is explicitly building independent U-Boot images, yes. With =
a wrapper
> > > > > > around "make all of the images for a given platform". So much o=
f our
> > > > > > confusing and messy code is because we aren't doing that. And s=
ince most
> > > > > > modern SoCs can work as (mostly )generic SPL selects correct DT=
B for PPL
> > > > > > we really could have fewer overall build configurations.
> > > > >
> > > > > I'd really like to see a generic aarch64 U-Boot for PPL, although=
 it
> > > > > would be quite large with all the drivers. Perhaps we could start=
 by
> > > > > having a generic Rockchip one, for example.
> > > > >
> > > > > Still I don't see this being strongly related to the discussion a=
bout
> > > > > these two different schemes.
> > > >
> > > > Well, in your scheme how do we have say generic-aarch64_defconfig
> > > > function on either chromebook_bob or am62x_beagleplay_a53 ? In mine,
> > > > since everything is a separate build, generic-aarch64_defconfig has
> > > > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_RK3399=3Dy. And then
> > > > chromebook_bob_defconfig would say to use chromebook_bob_tpl_defcon=
fig,
> > > > generic-rk3399_spl_defconfig and generic-aarch64_defconfig. As a bo=
nus
> > > > instead of am62x_beagleplay_a53_defconfig and
> > > > am62x_beagleplay_r5_defconfig we would have am62x_beagleplay_defcon=
fig
> > > > that would say to use the appropriate SPL/PPL for R5, and appropria=
te
> > > > SPL/PPL for A53.
> > > >
> > > > But the one big huge caveat I want to make here is that "generic" i=
mages
> > > > are useful in some use cases (I'm sure all of the regular F/OSS
> > > > distributions would love a single actually common PPL if they can f=
it
> > > > it) will strip things down. Whatever the IoT edge device closest to=
 you
> > > > now really won't want to ship with all the platforms enabled. Image=
 size
> > > > still matters.
> > >
> > > OK thanks for the details. I think I have a reasonable idea of what
> > > you are proposing, now. It would work, but is quite radical, IMO.
> > > That's not necessarily a bad thing, but in my mind I see a sequencing
> > > possibility.
> > >
> > > A few points from my side:
> > >
> > > 1. I would love to see the defconfig files reduce in size, with more
> > > and better defaults. One way to do this would be to enforce a maximum
> > > length. I added a feature to qconfig to allow finding common options
> > > among boards (the -i flag), but I'm not sure if many people use it.
> >
> > I don't see reducing defconfig size as important honestly. Should we
> > have more and better defaults? Yes. But almost everything is under 200
> > lines with the biggest (non-sandbox) ones being the generic zynqmp
> > platform(s?).
>=20
> Agreed.
>=20
> >
> > > 2. Generic boards is something I have been pushing for years (in fact
> > > it is why I originally introduced devicetree), but I'm not seeing a
> > > lot of traction.
> >
> > I don't think generic boards are universally helpful. Even if what I'm
> > proposing would allow for more of it, below the PPL stage I'm not sure
> > it's both feasible enough and useful enough for production. At the PPL
> > stage it still has to be small enough and not overly burdensome. What we
> > talked about on the call yesterday about using more multi-dtb images is
> > a step in the right direction, yes.
>=20
> Agreed. Anway, we can create separate targets for generic boards if we wa=
nt to.
>=20
> >
> > > 3. Iit seems that you want to remove all the 'if SPL' pieces and just
> > > rely on the current PPL configuration. But how will that work? There
> > > are tons of features which don't work in SPL, or are not relevant, or
> > > have special 'small' versions. That is a *lot* of Kconfig refactoring
> > > just to get something working, isn't it? With my scheme there is no
> > > Kconfig change needed initially - it can be done later as needed /
> > > desirable.
> >
> > I don't think we would remove most "if SPL" cases. Taking part of the
> > current stanza for ROCKCHIP_RK3399 as an example:
> > config ROCKCHIP_RK3399
> >         bool "Support Rockchip RK3399"
> >         select ARM64
> >         select SUPPORT_SPL
> >         select SUPPORT_TPL
> >         select SPL
> >         select SPL_ATF
> >         select SPL_BOARD_INIT if SPL
> >         ...
> >         select SPL_CLK if SPL
> >         ...
> >         select CLK
> >         ...
> >         imply TPL_CLK
> >
> >
> > This would become:
> > config ROCKCHIP_RK3399
> >         bool "Support Rockchip RK3399"
> >         select ARM64
> >         select SUPPORT_SPL
> >         select SUPPORT_TPL
> >         select SPL_ATF if SPL # TBD: Does 'ATF' make sense outside of S=
PL?
> >         select BOARD_INIT if SPL # Not TPL_BOARD_INIT here
> >         select CLK # imply was likely wrong before? Would need to check
> >         ...
>=20
> I was more talking about the large blocks of 'if SPL' - e.g. we have
> common/spl/Kconfig and common/spl/Kconfig.tpl

I would vastly reduce the contents within those 'if' blocks, but there
are still options that are xPL-centric without a PPL counterpart, such
as SPL_ATF (I suspect, but if not I'm sure others).

> But just the level of thought required in your small example above
> suggests it is a large effort.

Yes, restructuring our Kconfig logic and then removing our xPL logic is
some work. So was, I suspect, all of what you did already.

> > > 4. My scheme splits the config into separate files. Yours makes the
> >
> > I don't see yours as splitting the configs in to separate files, I see
> > it as generating some intermediate objects. The configs don't change and
> > that's one of our problem areas.
>=20
> So you mean a big problem area is the current Kconfig?

I mean it's a problem for users a board developers to make valid
configurations and update them as needed. Filesystems are in the
filesystem menu, unless they're SPL and then it's all under the big SPL
menu.

> Mind generates
> out to an include/generated/autoconf_xxx for each phase. Yes they are
> intermediate files and auto-generated, but each 100% controls its
> phase, so there is no confusion and CONFIG_IS_ENABLED() / odd Makefile
> rules anymore.

Yes, removing CONFIG_IS_ENABLED and $(PHASE_)/$(XPL_) from Makefiles is
good. But the intermediate files aren't going to help (nor hurt) any of
the problems themselves. If you're reading those to figure out a
problem, it's like when you're reading a .i file to figure out a
problem, it means you're already in a complex troublesome spot.

But I don't know that CONFIG_SPL_FS_FAT=3Dy means that CONFIG_FS_FAT=3Dy for
SPL builds leads to "no confusion". But I do think that CONFIG_SPL=3Dy and
CONFIG_FS_FAT=3Dy does.

> > > split earlier, at the Kconfig level. So it seems that we could go with
> > > my scheme to get us to a split config, then, after that, decide
> > > whether to move that split earlier to Kconfig itself. The choices
> >
> > I don't think so. Yours makes things complicated by making the build do
> > even more (and from the RFC, the implementation tooling diverges from
> > upstream).
>=20
> Yes it makes the kconf tool generate those separate files for each phase =
[3]
>=20
> > Mine makes things differently complicated by doing less for
> > most things, but needing some thought on how to know that say
> > chromebook_bob needs chromebook_bob_tpl_defconfig,
> > chromebook_bob_spl_defconfig and chromebook_bob_ppl_defconfig to be
> > built, before asking binman to go put things together.
>=20
> Yours seems feasible in a fully Binman world, but given the difficulty
> we (or I) have completing a migration, I honestly don't believe this
> is feasible in today's U-Boot. The other problem is that it all has to

I'm not 100% sure it's everything needs binman actually. Or even if we
do take this as a reason to push for more binman, it's just some trivial
types already handled in the Makefile that's missing.

> be done at once. We need to rewrite the Kconfig and flip over the
> board. Will we carry people with us? That is a huge risk to the
> project IMO.

I'm not sure, actually, that it couldn't be done in stages. We might
need a little bit of fakery around being able to just build SPL without
PPL in the interim.

> Anyway, yes my schema makes the build do even more (with 400 lines of
> kconf additions and a patch that can likely be upstreamed). But
> otherwise, it is a one-off improvement, without any changes to the
> existing Kconfig.

I thought Yamada-san rejected changes going in this direction before?
But either way, no it's not likely the final overburden in terms of
divergence.

> So my point is that we could go with the first part of my scheme to
> resolve the 'medium' problems then decide which way to continue after
> that. From your side you won't have lost anything towards where you
> want to head. The two options would then be:
>=20
> - exhance kconfig language to build in the notion of phases
> - split the defconfigs for each board, redo the Kconfig rules and
> teach the build to combine images

If things go down your proposed path instead, no, I don't see that as
making it meaningfully easier to go the way I proposed later. The only
commonality is dropping $(PHASE_)/$(XPL_)/etc and CONFIG_IS_ENABLED ->
IS_ENABLED. And (almost) all of that is a script'able change.

> > > would then be to use your scheme (Kconfig refactoring, splitting
> > > defconfigs and some rework), or to do my scheme (which would require
> > > enhancing the Kconfig language a bit just for U-Boot and some optional
> > > rework over time). Both schemes would need a small amount of
> > > build-logic changes, but I'm not sure yet what that would look like.
> > >
> > > Does that sound right?
> >
> > With what I said above, yes I think we're closer at least to
> > understanding each other.
>=20
> Yes.

Well, with that, what now?

What makes the current situation untenable is VPL. And I gather I
haven't convinced you to put that on hold long enough to instead rework
how we build things, have I?

--=20
Tom

--lzBbEz/l64q7BkXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeuNAgACgkQFHw5/5Y0
tyzpxwv/ZVBjZaNZzGo9+TMd6LVWmBj+yk9ExaWjfFFv83eUkUNlyAjfIuNQgFKt
GvEJSZ+79V8yD1WpZRwz5xnIwKhumF3BiZtc9acY19cV9WlEYOQGYz/PQmwDAfx3
/4MA3BFrmlkL6l5ETMvgdtc8wNV4yS46D7Q2InCYS31ekaQ3doeE6WLIdUp9IdaT
pMfcHdq9WLybSc8YKTD2xHbfv9r3PFq8MlY82MX0I9qUhudsnrFIdr9R2nFF7J6N
JqZp/xvhXepqgbKXHtev0FFcXHOSsMkcK6XtDyKkfabJWjrzWDXEaAa41SByiivV
KrcmzN9bos75Il5XFkQbGbTJnhI72Dg+0r4O7CATf4R6Cud7Hx74zEtyI8GHPpHg
wE8Q+kQ0Oubu8cNND6K+vlNOpbc3uZj8r+sTErXnulmwhwtzYlWjcoNaDt1UHwD1
d8hss1HNrE0f9OiScVMsMWY6fq3m/zey8KWP3Fmkkv2cYFHQhiZTWhI554axCD1o
8KwF7/rC
=3KR3
-----END PGP SIGNATURE-----

--lzBbEz/l64q7BkXs--
