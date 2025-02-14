Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540F6C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A5F80B98;
	Fri, 14 Feb 2025 15:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bo7Znd7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD6D80CB0; Fri, 14 Feb 2025 15:39:36 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C4E480B98
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so1621299276.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739543972; x=1740148772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+j9p75HIegZy2md2m1DZyeOlYWa+9FyX/J7JKchwtW4=;
 b=bo7Znd7PCrSikevJvRaXGrm4NfT0v7m5bm/h205kqmAYh2GJZGibvdV6hGSE/UwwF8
 cfFiFgW2lLcMn8Bhl0lQOAwp9Xm1DLbp/rU3dgY7J0SS/nqhJ+t2ceV2mSpeYb2RbZpo
 C7oYuHCAk2Isg7xIigGVPH8K32ZUVuqI+pKXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739543972; x=1740148772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j9p75HIegZy2md2m1DZyeOlYWa+9FyX/J7JKchwtW4=;
 b=bZgWvxIgoJRmDdzKYVb/lnxPzTGRbR+1x/H1KgUaQUi3RJxGjXhcr03/o7U8jBQDhW
 bSKKoc1ftS6/wH+x5NJ9MnSXjPb/z8IjvTOA4rLIg7eSr27Vqef82xebo18llyGDMQlY
 yDllqhhLZOXN4EQocS4tbAIOx+yg5zlsct5x/DJ6IYaL5wKQZGVAwKEshEfNWVQ9r+bk
 MRfPCj6JZFxjj8GsEF7UxSGqA5cMV1BaI1GLpvsjwx9uI8jGeT+AvgacTAXRrxCYcBYS
 2KByKLeSezrFTS9j85uNHiomUpRorcmQI6unWUjv23VapsP0Sn+4c+mO32wfAq7opYQs
 w2Lg==
X-Gm-Message-State: AOJu0Yxk/F82wn8nKLN8F0LaULXRoWY7et/29V2WcMLYdBRQgSFqSalu
 eA/aI0gnjEX4TdEWv/qNKrHKc1pWIUqaoYnEJYphB16s5Px//8WHxjvICz78gfY=
X-Gm-Gg: ASbGncsKyYuHhBbZO+D+BgBFKBw/4mLdO2jctIxap7dYXMVrrdOo6aJe66SNvqxrTaZ
 IUoDcxPaAITSavc64YG6M4jj/Dp0t2HcBAQ+gX4sCDu1cTWdExODdm9e6EhJ7LXQnM92V5hnWYm
 utr33CQ4c6KWjjkWJCCCb7m5bF3q/YCY6KRuaC35OcvHan7/eWknT+pHeSA+2uEmS5Ul9tOgoBR
 /LPnYu8MNRvX9XdYfj8yXcrI4/4Ml4IC7PzsUv8Gg1u04wXkFgCbNFmf2kIikndCUes/v566XgZ
 9796jAb+4OzNfL8=
X-Google-Smtp-Source: AGHT+IH16/bZczEHkIe2EFLMwte/2G3fr4OWkqWB6HYPjyDaX3IGbvmEJriuDJOQDHaJNqbCf9++cQ==
X-Received: by 2002:a05:690c:6a07:b0:6e3:37a7:8a98 with SMTP id
 00721157ae682-6fb32c7fe33mr70393687b3.14.1739543971506; 
 Fri, 14 Feb 2025 06:39:31 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb361cabfbsm7756957b3.113.2025.02.14.06.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:39:30 -0800 (PST)
Date: Fri, 14 Feb 2025 08:39:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250214143928.GG1233568@bill-the-cat>
References: <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <20250212183537.GQ1233568@bill-the-cat>
 <CAFLszTh5HS49DY1iqqcm_mT3tm2maUVAxyTXoP=5QxL1obw+jw@mail.gmail.com>
 <20250212225829.GS1233568@bill-the-cat>
 <CAFLszThNpm9_GRVPALTc+r_b2sFa1h=ih_JuNB9BZv+t7Qj5cQ@mail.gmail.com>
 <20250213180352.GY1233568@bill-the-cat>
 <CAFLszTj5z9TF_a0Y6zEABmUvjVjEYgw31gGRMX3Y1anVJgEvnA@mail.gmail.com>
 <20250213225932.GC1233568@bill-the-cat>
 <CAFLszTia0RZXgVRMq=jfBc75bNFSO6N8m5MtuPLcs33DHbE3FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="azjf1jzDrDprNr+A"
Content-Disposition: inline
In-Reply-To: <CAFLszTia0RZXgVRMq=jfBc75bNFSO6N8m5MtuPLcs33DHbE3FQ@mail.gmail.com>
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


--azjf1jzDrDprNr+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 05:09:47PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 13 Feb 2025 at 15:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 02:57:59PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, Feb 13, 2025, 11:03 Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 13, 2025 at 05:50:13AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 12 Feb 2025 at 15:58, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 01:05:11PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > >
> > > > > > > > > > > > > I just wanted to send a note to (re-)introduce my=
 ideas[1] for the
> > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > >
> > > > > > > > > > > > > A recent series introduced 'xPL' as the name for =
the various
> > > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means =
that this is any xPL
> > > > > > > > > > > > > phase and CONFIG_SPL means this really is the SPL=
 phase, not TPL. We
> > > > > > > > > > > > > still use filenames and function naming which use=
s 'spl', but could
> > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The major remaining problem IMO is that it is qui=
te tricky and
> > > > > > > > > > > > > expensive (in terms of time) to add a new phase. =
We also have some
> > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > >
> > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile a=
re visually ugly and
> > > > > > > > > > > > > can be confusing, particularly when combined with=
 ifdef and ifneq
> > > > > > > > > > > > >
> > > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLE=
D() and they mean
> > > > > > > > > > > > > different things. For any given option, some code=
 uses one and some
> > > > > > > > > > > > > the other, depending on what problems people have=
 met along the way.
> > > > > > > > > > > > >
> > > > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in tha=
t it could mean that
> > > > > > > > > > > > > the option is enabled in one or more xPL phases, =
or just in U-Boot
> > > > > > > > > > > > > proper. The only way to know is to look for $(PHA=
SE_) etc. in the
> > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. Th=
is is very confusing
> > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > >
> > > > > > > > > > > > > d. We need to retain an important feature: option=
s from different
> > > > > > > > > > > > > phases can depend on each other. As an example, w=
e might want to
> > > > > > > > > > > > > enable MMC in SPL by default, if MMC is enabled i=
n U-Boot proper. We
> > > > > > > > > > > > > may also want to share values between phases, suc=
h as TEXT_BASE. We
> > > > > > > > > > > > > can do this easily today, just by adding Kconfig =
rules.
> > > > > > > > > > > >
> > > > > > > > > > > > I agree with a through c and for d there are likely=
 some cases even if
> > > > > > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm n=
ot sure it's as
> > > > > > > > > > > > important as the other ones.
> > > > > > > > > > >
> > > > > > > > > > > OK. No, TEXT_BASE is not a great example in my book e=
ither. But it is
> > > > > > > > > > > true that SPL needs to know U-Boot's text base.
> > > > > > > > > > >
> > > > > > > > > > > Here's another:
> > > > > > > > > > >
> > > > > > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > > > > > >
> > > > > > > > > > > config TPL_SYS_MALLOC_F
> > > > > > > > > > >    default y if SPL_SYS_MALLOC_F
> > > > > > > > > > >
> > > > > > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > > > > > >    default SPL_SYS_MALLOC_F_LEN
> > > > > > > > > >
> > > > > > > > > > Alternatively:
> > > > > > > > > > config SYS_MALLOC_LEN
> > > > > > > > > >    ... current default X if Y
> > > > > > > > > >    default 0x2800 if RCAR_GEN3 && !PPL
> > > > > > > > > >    default 0x2000 if IMX8MQ && !PPL
> > > > > > > > >
> > > > > > > > > PPL means (in my book) that we have a PPL, i.e. it is alw=
ays true. It
> > > > > > > >
> > > > > > > > And in my proposal you're choosing between PPL, SPL, TPL, V=
PL.
> > > > > > > >
> > > > > > > > > is the same today, with SPL. We have CONFIG_SPL_BUILD whi=
ch indicates
> > > > > > > > > which build it is. If you are suggesting that SPL means t=
hat this is
> > > > > > > > > the SPL build, then which thing tells us whether or not w=
e have an SPL
> > > > > > > > > build? I'm just a bit confused by this.
> > > > > > > >
> > > > > > > > And we wouldn't have CONFIG_SPL_BUILD because we would eith=
er be
> > > > > > > > configuring for SPL=3Dy or SPL=3Dn, there's no confusion an=
ymore.
> > > > > > > >
> > > > > > > > > But how can I make the TPL value of SYS_MALLOC_F_LEN the =
same as the
> > > > > > > > > SPL one, with your scheme?
> > > > > > > >
> > > > > > > > If your question is "how do I set an arbitrary but consiste=
nt value in
> > > > > > > > SPL and SPL" that's not enforced. But they also shouldn't b=
e arbitrary
> > > > > > > > and we should have sane defaults set in Kconfig, regardless=
 of either
> > > > > > > > proposal. While I'm trying to not get lost in the details t=
oday we have
> > > > > > > > 80 matches on "git grep SPL_.*_LEN=3D configs/" and 2 for T=
PL and I would
> > > > > > > > encourage someone to verify those are needed. My initial re=
collection is
> > > > > > > > that most of these are from when we bumped SYS_MALLOC_F_LEN=
 or so up to
> > > > > > > > the commonly used default and had the few platforms that di=
dn't use the
> > > > > > > > new default previously switch to the old one.
> > > > > > > >
> > > > > > > > In other words, I don't think there's a problem here that i=
sn't solved
> > > > > > > > today, outside of either proposal.
> > > > > > > >
> > > > > > > > > So I'm still not understanding how you handle Kconfig dep=
endencies
> > > > > > > > > between phases with your scheme. Are you saying you don't=
 and they are
> > > > > > > > > not important?
> > > > > > > >
> > > > > > > > Basically. The majority of the cases of:
> > > > > > > > config SPL_FOO
> > > > > > > >    default y if FOO
> > > > > > > >
> > > > > > > > config TPL_FOO
> > > > > > > >    default y if SPL_FOO
> > > > > > > >
> > > > > > > > Just go away because FOO is already default y or select/imp=
ly'd by
> > > > > > > > TARGET_BAR or ARCH_BAZ.
> > > > > > > >
> > > > > > > > > Also, is there a single Kconfig tree for U-Boot, or are y=
ou saying you
> > > > > > > > > want a different set of Kconfig files for each phase?
> > > > > > > >
> > > > > > > > Just the Kconfig files we have today. Likely with less over=
all lines
> > > > > > > > since for example we could drop:
> > > > > > > > config SPL_FS_EXT4
> > > > > > > >         bool "Support EXT filesystems"
> > > > > > > >         select SPL_CRC16 if EXT4_WRITE
> > > > > > > >
> > > > > > > > Since we already have fs/ext4/Kconfig.
> > > > > > > >
> > > > > > > > > > > > > Proposal
> > > > > > > > > > > > >
> > > > > > > > > > > > > 1. Adjust kconf to generate separate autoconf.h f=
iles for each phase.
> > > > > > > > > > > > > These contain the values for each Kconfig option =
for that phase. For
> > > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL=
's text base.
> > > > > > > > > > > > >
> > > > > > > > > > > > > 2. Add a file to resolve the ambiguity in (c) abo=
ve, listing the
> > > > > > > > > > > > > Kconfig options which should not be enabled/valid=
 in any xPL build.
> > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > >
> > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning =
U-Boot proper (only),
> > > > > > > > > > > > > useful in rare cases. This indicates that the opt=
ion applies only to
> > > > > > > > > > > > > U-Boot proper and is not defined in any xPL build=
=2E It is analogous to
> > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a d=
ozen of these are
> > > > > > > > > > > > > needed at present, basically to allow access to t=
he value for another
> > > > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_B=
ASE so that it knows
> > > > > > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > > > > > >
> > > > > > > > > > > > > 4. There is no change to the existing defconfig f=
iles, or 'make
> > > > > > > > > > > > > menuconfig', which works just as today, including=
 dependencies between
> > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > >
> > > > > > > > > > > > > 5. (next) Expand the Kconfig language[2] to suppo=
rt declaring phases
> > > > > > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicat=
ing options (DM_MMC,
> > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing =
an option to be
> > > > > > > > > > > > > declared once for any/all phases. We can then dro=
p the file in 2
> > > > > > > > > > > > > above.
> > > > > > > > > > > > >
> > > > > > > > > > > > > With this, maintaining Kconfig options, Makefiles=
 and adding a new
> > > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > > >
> > > > > > > > > > > > I think this will not make our life easier, it will=
 make things harder.
> > > > > > > > > > > >
> > > > > > > > > > > > I think what we've reached now shows that Yamada-sa=
n was correct at the
> > > > > > > > > > > > time in saying that we were going down the wrong pa=
th with how we
> > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > >
> > > > > > > > > > > You've mentioned this quite a few times over the year=
s. Is there a
> > > > > > > > > > > reference to what he suggested we should do? Or perha=
ps it is what you
> > > > > > > > > > > have below.
> > > > > > > > > >
> > > > > > > > > > I don't recall what he proposed instead, just that when=
 it became clear
> > > > > > > > > > that I wanted to move from the "S:CONFIG_FOO.." syntax =
for how SPL was
> > > > > > > > > > handled to how we're doing it today, he thought that wa=
s the wrong
> > > > > > > > > > direction.
> > > > > > > > >
> > > > > > > > > Yes, IMO he was right about that.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM=
_MMC and so on, just
> > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > - Likely need to introduce a PPL symbol as you sugg=
est.
> > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when b=
uilding a defconfig.
> > > > > > > > > > >
> > > > > > > > > > > Good idea.
> > > > > > > > > > >
> > > > > > > > > > > > - Split something like rockpro64-rk3399_defconfig i=
n to
> > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_t=
pl_defconfig
> > > > > > > > > > > >   and add Makefile logic such that for X_defconfig =
as a build target but
> > > > > > > > > > > >   not configs/X_defconfig not existing, we see if a=
ny of
> > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and w=
e run a builds in
> > > > > > > > > > > >   subdirectories of our object directory, and then =
using binman combine
> > > > > > > > > > > >   as needed.
> > > > > > > > > > >
> > > > > > > > > > > This means splitting the existing file into a separat=
e one for each
> > > > > > > > > > > phase. I believe that will be hard to manage.
> > > > > > > > > >
> > > > > > > > > > Do you mean initially, or long term? Initially, it shou=
ld be a bit of
> > > > > > > > > > shell scripting. The consolidation (ie most/all rk3399 =
having an
> > > > > > > > > > identical _spl_defconfig) can't be automated. Long term=
 I'm not sure it
> > > > > > > > > > would be any different. Most of the maintenance is on r=
esync'ing which
> > > > > > > > > > is automated.
> > > > > > > > >
> > > > > > > > > Long term. How does 'make menuconfig' work in this case? =
Won't you
> > > > > > > > > have to run it three times for SPL, TPL and PPL?
> > > > > > > >
> > > > > > > > Yes, you would run configure for what you're building. This=
 is a good
> > > > > > > > thing as it will no longer be so confusing to hunt down whe=
re SPL or TPL
> > > > > > > > or VPL options for a specific thing reside.
> > > > > > > >
> > > > > > > > > > > >   - Maybe instead the Makefile logic above we would=
 parse X_defconfig
> > > > > > > > > > > >     and see if it's a different format of say PHASE=
:file to make it
> > > > > > > > > > > >     easier to say share a single TPL config with al=
l rk3399, have a few
> > > > > > > > > > > >     common SPL configs and then just a board specif=
ic PPL.
> > > > > > > > > > > >
> > > > > > > > > > > > This solves (a) by removing them entirely. This sol=
ves (b) by removing
> > > > > > > > > > > > the ambiguity entirely (it will be enabled or not).=
 As a bonus for (b)
> > > > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) an=
d match up with the
> > > > > > > > > > > > Linux Kernel again. This solves (c) again by removi=
ng it entirely.
> > > > > > > > > > >
> > > > > > > > > > > The scheme I propose removes a-c also. I should have =
made that clear.
> > > > > > > > > >
> > > > > > > > > > Er, ok. That's not how it looked before, but I guess I'=
m just mistaken.
> > > > > > > > >
> > > > > > > > > Yes I think so...it was a major goal to remove this stuff=
=2E [1] [2]
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > > > > There is not a huge difference between your scheme an=
d mine. My
> > > > > > > > > > > question is, how do you handle (d)?
> > > > > > > > > >
> > > > > > > > > > Well, either (d) isn't important as for example MMC was=
n't a good choice
> > > > > > > > > > in your proposal as virtually everyone "select MMC" tod=
ay or it's
> > > > > > > > > > handled more easily as my example above in SYS_MALLOC_L=
EN.
> > > > > > > > > >
> > > > > > > > > > > The way I see it, both schemes remove the ambiguity. =
Mine retains a
> > > > > > > > > > > single deconfig file and a single 'make menuconfig' f=
or each board.
> > > > > > > > > > > Yours feels more like building independent U-Boot ima=
ges.
> > > > > > > > > >
> > > > > > > > > > It is explicitly building independent U-Boot images, ye=
s. With a wrapper
> > > > > > > > > > around "make all of the images for a given platform". S=
o much of our
> > > > > > > > > > confusing and messy code is because we aren't doing tha=
t. And since most
> > > > > > > > > > modern SoCs can work as (mostly )generic SPL selects co=
rrect DTB for PPL
> > > > > > > > > > we really could have fewer overall build configurations.
> > > > > > > > >
> > > > > > > > > I'd really like to see a generic aarch64 U-Boot for PPL, =
although it
> > > > > > > > > would be quite large with all the drivers. Perhaps we cou=
ld start by
> > > > > > > > > having a generic Rockchip one, for example.
> > > > > > > > >
> > > > > > > > > Still I don't see this being strongly related to the disc=
ussion about
> > > > > > > > > these two different schemes.
> > > > > > > >
> > > > > > > > Well, in your scheme how do we have say generic-aarch64_def=
config
> > > > > > > > function on either chromebook_bob or am62x_beagleplay_a53 ?=
 In mine,
> > > > > > > > since everything is a separate build, generic-aarch64_defco=
nfig has
> > > > > > > > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_RK3399=3Dy. And then
> > > > > > > > chromebook_bob_defconfig would say to use chromebook_bob_tp=
l_defconfig,
> > > > > > > > generic-rk3399_spl_defconfig and generic-aarch64_defconfig.=
 As a bonus
> > > > > > > > instead of am62x_beagleplay_a53_defconfig and
> > > > > > > > am62x_beagleplay_r5_defconfig we would have am62x_beaglepla=
y_defconfig
> > > > > > > > that would say to use the appropriate SPL/PPL for R5, and a=
ppropriate
> > > > > > > > SPL/PPL for A53.
> > > > > > > >
> > > > > > > > But the one big huge caveat I want to make here is that "ge=
neric" images
> > > > > > > > are useful in some use cases (I'm sure all of the regular F=
/OSS
> > > > > > > > distributions would love a single actually common PPL if th=
ey can fit
> > > > > > > > it) will strip things down. Whatever the IoT edge device cl=
osest to you
> > > > > > > > now really won't want to ship with all the platforms enable=
d. Image size
> > > > > > > > still matters.
> > > > > > >
> > > > > > > OK thanks for the details. I think I have a reasonable idea o=
f what
> > > > > > > you are proposing, now. It would work, but is quite radical, =
IMO.
> > > > > > > That's not necessarily a bad thing, but in my mind I see a se=
quencing
> > > > > > > possibility.
> > > > > > >
> > > > > > > A few points from my side:
> > > > > > >
> > > > > > > 1. I would love to see the defconfig files reduce in size, wi=
th more
> > > > > > > and better defaults. One way to do this would be to enforce a=
 maximum
> > > > > > > length. I added a feature to qconfig to allow finding common =
options
> > > > > > > among boards (the -i flag), but I'm not sure if many people u=
se it.
> > > > > >
> > > > > > I don't see reducing defconfig size as important honestly. Shou=
ld we
> > > > > > have more and better defaults? Yes. But almost everything is un=
der 200
> > > > > > lines with the biggest (non-sandbox) ones being the generic zyn=
qmp
> > > > > > platform(s?).
> > > > >
> > > > > Agreed.
> > > > >
> > > > > >
> > > > > > > 2. Generic boards is something I have been pushing for years =
(in fact
> > > > > > > it is why I originally introduced devicetree), but I'm not se=
eing a
> > > > > > > lot of traction.
> > > > > >
> > > > > > I don't think generic boards are universally helpful. Even if w=
hat I'm
> > > > > > proposing would allow for more of it, below the PPL stage I'm n=
ot sure
> > > > > > it's both feasible enough and useful enough for production. At =
the PPL
> > > > > > stage it still has to be small enough and not overly burdensome=
=2E What we
> > > > > > talked about on the call yesterday about using more multi-dtb i=
mages is
> > > > > > a step in the right direction, yes.
> > > > >
> > > > > Agreed. Anway, we can create separate targets for generic boards =
if we want to.
> > > > >
> > > > > >
> > > > > > > 3. Iit seems that you want to remove all the 'if SPL' pieces =
and just
> > > > > > > rely on the current PPL configuration. But how will that work=
? There
> > > > > > > are tons of features which don't work in SPL, or are not rele=
vant, or
> > > > > > > have special 'small' versions. That is a *lot* of Kconfig ref=
actoring
> > > > > > > just to get something working, isn't it? With my scheme there=
 is no
> > > > > > > Kconfig change needed initially - it can be done later as nee=
ded /
> > > > > > > desirable.
> > > > > >
> > > > > > I don't think we would remove most "if SPL" cases. Taking part =
of the
> > > > > > current stanza for ROCKCHIP_RK3399 as an example:
> > > > > > config ROCKCHIP_RK3399
> > > > > >         bool "Support Rockchip RK3399"
> > > > > >         select ARM64
> > > > > >         select SUPPORT_SPL
> > > > > >         select SUPPORT_TPL
> > > > > >         select SPL
> > > > > >         select SPL_ATF
> > > > > >         select SPL_BOARD_INIT if SPL
> > > > > >         ...
> > > > > >         select SPL_CLK if SPL
> > > > > >         ...
> > > > > >         select CLK
> > > > > >         ...
> > > > > >         imply TPL_CLK
> > > > > >
> > > > > >
> > > > > > This would become:
> > > > > > config ROCKCHIP_RK3399
> > > > > >         bool "Support Rockchip RK3399"
> > > > > >         select ARM64
> > > > > >         select SUPPORT_SPL
> > > > > >         select SUPPORT_TPL
> > > > > >         select SPL_ATF if SPL # TBD: Does 'ATF' make sense outs=
ide of SPL?
> > > > > >         select BOARD_INIT if SPL # Not TPL_BOARD_INIT here
> > > > > >         select CLK # imply was likely wrong before? Would need =
to check
> > > > > >         ...
> > > > >
> > > > > I was more talking about the large blocks of 'if SPL' - e.g. we h=
ave
> > > > > common/spl/Kconfig and common/spl/Kconfig.tpl
> > > >
> > > > I would vastly reduce the contents within those 'if' blocks, but th=
ere
> > > > are still options that are xPL-centric without a PPL counterpart, s=
uch
> > > > as SPL_ATF (I suspect, but if not I'm sure others).
> > > >
> > > > > But just the level of thought required in your small example above
> > > > > suggests it is a large effort.
> > > >
> > > > Yes, restructuring our Kconfig logic and then removing our xPL logi=
c is
> > > > some work. So was, I suspect, all of what you did already.
> > > >
> > > > > > > 4. My scheme splits the config into separate files. Yours mak=
es the
> > > > > >
> > > > > > I don't see yours as splitting the configs in to separate files=
, I see
> > > > > > it as generating some intermediate objects. The configs don't c=
hange and
> > > > > > that's one of our problem areas.
> > > > >
> > > > > So you mean a big problem area is the current Kconfig?
> > > >
> > > > I mean it's a problem for users a board developers to make valid
> > > > configurations and update them as needed. Filesystems are in the
> > > > filesystem menu, unless they're SPL and then it's all under the big=
 SPL
> > > > menu.
> > > >
> > > > > Mind generates
> > > > > out to an include/generated/autoconf_xxx for each phase. Yes they=
 are
> > > > > intermediate files and auto-generated, but each 100% controls its
> > > > > phase, so there is no confusion and CONFIG_IS_ENABLED() / odd Mak=
efile
> > > > > rules anymore.
> > > >
> > > > Yes, removing CONFIG_IS_ENABLED and $(PHASE_)/$(XPL_) from Makefile=
s is
> > > > good. But the intermediate files aren't going to help (nor hurt) an=
y of
> > > > the problems themselves. If you're reading those to figure out a
> > > > problem, it's like when you're reading a .i file to figure out a
> > > > problem, it means you're already in a complex troublesome spot.
> > > >
> > > > But I don't know that CONFIG_SPL_FS_FAT=3Dy means that CONFIG_FS_FA=
T=3Dy for
> > > > SPL builds leads to "no confusion". But I do think that CONFIG_SPL=
=3Dy and
> > > > CONFIG_FS_FAT=3Dy does.
> > > >
> > > > > > > split earlier, at the Kconfig level. So it seems that we coul=
d go with
> > > > > > > my scheme to get us to a split config, then, after that, deci=
de
> > > > > > > whether to move that split earlier to Kconfig itself. The cho=
ices
> > > > > >
> > > > > > I don't think so. Yours makes things complicated by making the =
build do
> > > > > > even more (and from the RFC, the implementation tooling diverge=
s from
> > > > > > upstream).
> > > > >
> > > > > Yes it makes the kconf tool generate those separate files for eac=
h phase [3]
> > > > >
> > > > > > Mine makes things differently complicated by doing less for
> > > > > > most things, but needing some thought on how to know that say
> > > > > > chromebook_bob needs chromebook_bob_tpl_defconfig,
> > > > > > chromebook_bob_spl_defconfig and chromebook_bob_ppl_defconfig t=
o be
> > > > > > built, before asking binman to go put things together.
> > > > >
> > > > > Yours seems feasible in a fully Binman world, but given the diffi=
culty
> > > > > we (or I) have completing a migration, I honestly don't believe t=
his
> > > > > is feasible in today's U-Boot. The other problem is that it all h=
as to
> > > >
> > > > I'm not 100% sure it's everything needs binman actually. Or even if=
 we
> > > > do take this as a reason to push for more binman, it's just some tr=
ivial
> > > > types already handled in the Makefile that's missing.
> > > >
> > > > > be done at once. We need to rewrite the Kconfig and flip over the
> > > > > board. Will we carry people with us? That is a huge risk to the
> > > > > project IMO.
> > > >
> > > > I'm not sure, actually, that it couldn't be done in stages. We might
> > > > need a little bit of fakery around being able to just build SPL wit=
hout
> > > > PPL in the interim.
> > > >
> > > > > Anyway, yes my schema makes the build do even more (with 400 line=
s of
> > > > > kconf additions and a patch that can likely be upstreamed). But
> > > > > otherwise, it is a one-off improvement, without any changes to the
> > > > > existing Kconfig.
> > > >
> > > > I thought Yamada-san rejected changes going in this direction befor=
e?
> > > > But either way, no it's not likely the final overburden in terms of
> > > > divergence.
> > >
> > >
> > > Yes. Masahiro will make his own decisions and I am confident he will
> > > reject any future changes I send
> > >
> > > >
> > > > > So my point is that we could go with the first part of my scheme =
to
> > > > > resolve the 'medium' problems then decide which way to continue a=
fter
> > > > > that. From your side you won't have lost anything towards where y=
ou
> > > > > want to head. The two options would then be:
> > > > >
> > > > > - exhance kconfig language to build in the notion of phases
> > > > > - split the defconfigs for each board, redo the Kconfig rules and
> > > > > teach the build to combine images
> > > >
> > > > If things go down your proposed path instead, no, I don't see that =
as
> > > > making it meaningfully easier to go the way I proposed later. The o=
nly
> > > > commonality is dropping $(PHASE_)/$(XPL_)/etc and CONFIG_IS_ENABLED=
 ->
> > > > IS_ENABLED. And (almost) all of that is a script'able change.
> > >
> > > To be frank, the difference is that I have actually put in the work to
> > > try this. It is more than 50 and perhaps as many as 100 patches. Quite
> > > difficult work. Honestly, compared to that, the logic changes are not
> > > that large.
> > >
> > > That is why I believe this work is a prerequisite for both schemes
> > >
> > > >
> > > > > > > would then be to use your scheme (Kconfig refactoring, splitt=
ing
> > > > > > > defconfigs and some rework), or to do my scheme (which would =
require
> > > > > > > enhancing the Kconfig language a bit just for U-Boot and some=
 optional
> > > > > > > rework over time). Both schemes would need a small amount of
> > > > > > > build-logic changes, but I'm not sure yet what that would loo=
k like.
> > > > > > >
> > > > > > > Does that sound right?
> > > > > >
> > > > > > With what I said above, yes I think we're closer at least to
> > > > > > understanding each other.
> > > > >
> > > > > Yes.
> > > >
> > > > Well, with that, what now?
> > > >
> > > > What makes the current situation untenable is VPL. And I gather I
> > > > haven't convinced you to put that on hold long enough to instead re=
work
> > > > how we build things, have I?
> > >
> > > Which VPL thing?
> >
> > That it exists. When it was just SPL, it's manageable. With TPL, well,
> > it was supposed to be tiny and so just a few more things. And with VPL,
> > that makes 4. It's too much. Something needs to be done. Four times is
> > too many. If solving Marek's desire for PSCI-from-U-Boot means we need
> > number 5 that becomes even worse (and I also suspect that's a case of
> > one build covers the SoC or family of SoCs depending on hardware
> > changes).
>=20
> Yes, that's why I took on this effort a few years back.
>=20
> >
> > > You have convinced me that you have a solution. It makes a lot more
> > > sense to me than previously and it may be that it is better in the
> > > end. For example, with VBE it I would make a lot of sense to build 20
> > > boards as just TPL and use a generic rock chip board for everything
> > > else. That would be a lot tidier with your scheme. It is very hard to
> > > predict the future and VBE is still not finished, some two years in.
> > >
> > > I don't want to be tied to your scheme today though.
> > >
> > > So if you can accept my going ahead with 1-4 and helping me with that,
> > > then we can stop and discuss which way to go, perhaps by prototyping
> > > the two options?
> >
> > I want to start by saying I do appreciate you put in a lot of work in
> > this direction already, and I do see some of the end goals it achieves
> > as being important, and I'm glad you see my idea has some good parts
> > too.
> >
> > I want to figure out how to move forward on this problem. My other part
> > of this thread, this morning, was also part of me looking harder, again,
> > at the RFC series you posted before. And that's where I still have large
> > reservations. There are *so* *many* symbols we need to now have 4
> > variants of, instead of 1 variant of. Take:
> > https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.1134219=
-58-sjg@chromium.org/
> > for example. It adds SPL_PARTITION_TYPE_GUID but we include <part.h> in
> > files built in TPL (and likely VPL) so aren't we going to need that
> > every time? And with a quick size-check on pinebook-pro-rk3399 it looks
> > like it's not working as intended either? I checked and part_get_info
> > shrinks because CONFIG_PARTITION_TYPE_GUID is not set, or rather:
> > #ifdef CONFIG_PARTITION_TYPE_GUID
> >                 info->type_guid[0] =3D 0;
> > #endif

Oh, I get it now. Previously CONFIG_PARTITION_TYPE_GUID=3Dy but now
CONFIG_SPL_PARTITION_TYPE_GUID=3Dn and while I'm not sure that's a good
thing I see what happened. And now I see my problem from yesterday
morning was similar but different.

> > is not true and checked. And I can't see why. And there's other size
> > reductions (this time in tpl) on pinebook-pro-rk3399 that I didn't dig
> > in to more, but wasn't that symbol:
> >                tpl-u-boot-tpl: add: 0/-4, grow: 0/0 bytes: 0/-344 (-344)
> >                  function                                   old     new=
   delta
> >                  dev_get_uclass_plat                         12       -=
     -12
> >                  simple_bus_post_bind                        92       -=
     -92
> >                  _u_boot_list_2_uclass_driver_2_simple_bus     120     =
  -    -120
> >                  _u_boot_list_2_driver_2_simple_bus         120       -=
    -120
> >
> > And I'm not bringing this up to badger you about bugs in an RFC series
> > (it's RFC, there's bugs) but rather because I think it highlights some
> > core issues with the approach as implemented.
>=20
> But surely you can see that both schemes have exactly the same issues?
>
> My point is that the work to tidy up things and then get to a 'clean'
> source tree and Makefiles is the hard bit here and has to be done with
> both schemes.
>
> Just let me know which way you want to go. I don't have anything ready
> to send, but I could probably drag it over the line before too long,
> if you are keen.

Once I figured out what was the cause of the problems I saw in the RFC,
I had to rewrite this a few times. Your approach needs even more symbols
added than were in the RFC, and the newly added symbols need further
auditing to make sure we have the same behavior as today at least by
default. On the one hand, this is at least a well defined technical
problem and if you do the language extension *first* the code changes
aren't so bad. But for the user running menuconfig / etc? That's not
going to be pretty. And we still won't have fixed the problems like "why
is TPL even trying to build DWC3?" without reworking more symbols.

So I don't think this is the right approach as it doesn't reduce
confusion and may increase it (why do I need to set
CONFIG_SPL_PARTITION_TYPE_GUID when the code checks for
CONFIG_PARTITION_TYPE_GUID? But why is CONFIG_SPL_FRAMEWORK still there?
Oh..). The main thing it does is drop $(PHASE_) and I honestly think
that's more confusing. We still have one build where we need to do or
not do different things for FOO && PPL, FOO && SPL, etc but the code
just references CONFIG_FOO but doesn't always mean CONFIG_FOO=3Dy/n in the
=2Econfig / defconfig.

I really think we need to literally split the config files up such that
for the most part we do (in psuedo code):
%_full_config:
  make -C $(srctree) O=3D$(obj)/ppl %_ppl_defconfig
  make -C $(srctree) O=3D$(obj)/spl %_spl_defconfig
  ...

all:
  [ -d $(obj)/ppl ] && make -C $(srctree) O=3D$(obj)/ppl all
  [ -d $(obj)/spl ] && make -C $(srctree) O=3D$(obj)/spl all
  ...

--=20
Tom

--azjf1jzDrDprNr+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmevVaAACgkQFHw5/5Y0
tyyQzgv/cPc7TgBmdWPyhN6k6qENJD7dfQ4hk+Dl8/POqqo+9OgAOMzdWMHmUszj
ivbQWjuzaLpCqfhb7+dP2Am1aZiwqGxrBTDzGVI9uKXg9g50vqe6xYaySnIeuxbO
W/epwTAl8B6Sf1lm7DPty+yIne9eJIWvTxUkiCsShTYsA5BjXTXNYwezPrBIFJhZ
u+oRao0sce1Hq36tPZ9sj393LHPtLQ0CwUvsV2+NiJyOmwbTSLDDCUgBi30ARUpz
YptUbmAYmRAIvgYqFLftG9KYI/u0iBNw25J/kak+wKKlMiCYP9Lp9ZIOpjwYvp3z
X0vSW0/BlDd95QiKAEwHAQKZu9t9lFsN9CuP+sIy2BTzkQL7lHHWnFsfB5SjICRs
Kin/jzDnVBut3bK8aC714G0Sln4nO9GwzVo7mw7MmwEPOteVs+At3ngqPMIH3Kb6
I+vrGao/9mVc5AxGI2SFGtftpkYSPr5Njv0c2Qw/kyvZKNyguW1KGTU7Y54//vJt
ODXApmHx
=iEPk
-----END PGP SIGNATURE-----

--azjf1jzDrDprNr+A--
