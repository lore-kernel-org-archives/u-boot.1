Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D86C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 23:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4064580B98;
	Sat, 15 Feb 2025 00:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EZUhGW28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98FF580B98; Sat, 15 Feb 2025 00:44:14 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F47C80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 00:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5dcc3b0c77so26574276.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739576638; x=1740181438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JYjcbQzX/GySif09cLEMRddp3ip7z6dEyMYQSCc9shU=;
 b=EZUhGW28IZ9LP4OBAXKRABljFO0TDIwsbR3vaFGxfvvypb0lz6gFX+Sr77bo0SC3zj
 2oEnwRRq5UerDMe6QBXhUfo/d+Ihig1e9nXea8zkNJ0VrDvnFf5Yk5MQJRxgMmlTT1LU
 KBU/1ThtFVBFZy5uuM7iFFmWYG3cnzLRwPKYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739576638; x=1740181438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYjcbQzX/GySif09cLEMRddp3ip7z6dEyMYQSCc9shU=;
 b=ZBmPOKHr2wzaMWXhIMyujR8MK3Qw0pjUfytYUx1Elv5qFZFtR0xicBj1/Bl8lNwNtN
 h4y+AtqEeGWjl8/n7p7o96zWWqdeX8GaF+gkX4lgWQiuQ3nt/obBKYnelITSlhW6z8vT
 w/5uKNdWr1Ogy7dHGnNnUrJ4ppS80SBKuhOjMSffsKXmbHz4pfciGYngckUGUwoh0O0T
 Wjxq+2GHNJL1JOAxjHMPdGimeVB+DJWkQW7M2pb/29r8VjHa5jFcpm09NOPcRQMimO8d
 fbQd+IJSmGNoY7ZJwikKIUwhVpqjhdQpYXNswgQQaKiCJrCVfqypwd9W68LSzirBbypZ
 yNfQ==
X-Gm-Message-State: AOJu0YwJWpskdFLnbkyb354P/kEEtTOrY3atDVsOAKE2qwVXmUs4o/rg
 20rlkwHH9fECLt3ZiqcknUs4gemDZm4Bkq3YOQ5SnHkJcyhfYyfTwWLHRen8gu8HUya2LlL5Jf+
 YSJw=
X-Gm-Gg: ASbGncvif59AHRdjGJmyy1qhD8kW9XNXi+LTCe8y5/p2jCT8bwKqhkS2+bXD939u2R4
 WVZ+wx1oxZJtDhQQi0KStmoFED8zaGPpi3kZY6I16P+PHV+nbSrseGIBPdDsowuy22AX4ge6Une
 VHJv7llay49pLMusOwOKb+mLAm1YTMWr0u2DJshJqFzbq6Lspi4o5CuhW/t54uG8srw4tKA7jS4
 PrhRepqXgOtuQJLWqN1k5QmYbWEhw+tLwxigetUs5LWKWMzxuCagErjbPHB4beYsRXfCu1Mp8h9
 Xokabmqr9tp/3+Y=
X-Google-Smtp-Source: AGHT+IEhNX+NRKmqiyL4ndaW5EFDWDbKq0jHY/OyC4qOrEtBqawki9CKKGPU62zktMEzh67b5Egfuw==
X-Received: by 2002:a05:690c:3607:b0:6f5:4304:fb8 with SMTP id
 00721157ae682-6fb582b8988mr17449417b3.18.1739576638055; 
 Fri, 14 Feb 2025 15:43:58 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb3dab46a2sm8075487b3.94.2025.02.14.15.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 15:43:57 -0800 (PST)
Date: Fri, 14 Feb 2025 17:43:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250214234354.GJ1233568@bill-the-cat>
References: <20250212225829.GS1233568@bill-the-cat>
 <CAFLszThNpm9_GRVPALTc+r_b2sFa1h=ih_JuNB9BZv+t7Qj5cQ@mail.gmail.com>
 <20250213180352.GY1233568@bill-the-cat>
 <CAFLszTj5z9TF_a0Y6zEABmUvjVjEYgw31gGRMX3Y1anVJgEvnA@mail.gmail.com>
 <20250213225932.GC1233568@bill-the-cat>
 <CAFLszTia0RZXgVRMq=jfBc75bNFSO6N8m5MtuPLcs33DHbE3FQ@mail.gmail.com>
 <20250214143928.GG1233568@bill-the-cat>
 <CAFLszTg0yeOu13h1bxq2KiqVqwUQ-DdiJc+nhhknf5_JGygXgw@mail.gmail.com>
 <20250214211652.GI1233568@bill-the-cat>
 <CAFLszTi=abpaGi0CnnNoKYsT9M0H-9xrGaQtdLORvM8J7usX1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="94LcxDT73RN+2MLT"
Content-Disposition: inline
In-Reply-To: <CAFLszTi=abpaGi0CnnNoKYsT9M0H-9xrGaQtdLORvM8J7usX1Q@mail.gmail.com>
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


--94LcxDT73RN+2MLT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 03:46:30PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 14 Feb 2025 at 14:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 12:48:33PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, Feb 14, 2025, 07:39 Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 13, 2025 at 05:09:47PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 13 Feb 2025 at 15:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 13, 2025 at 02:57:59PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, Feb 13, 2025, 11:03 Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > > >
> > > > > > > > On Thu, Feb 13, 2025 at 05:50:13AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Wed, 12 Feb 2025 at 15:58, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Feb 12, 2025 at 01:05:11PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I just wanted to send a note to (re-)intr=
oduce my ideas[1] for the
> > > > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > A recent series introduced 'xPL' as the n=
ame for the various
> > > > > > > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUIL=
D means that this is any xPL
> > > > > > > > > > > > > > > > > phase and CONFIG_SPL means this really is=
 the SPL phase, not TPL. We
> > > > > > > > > > > > > > > > > still use filenames and function naming w=
hich uses 'spl', but could
> > > > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The major remaining problem IMO is that i=
t is quite tricky and
> > > > > > > > > > > > > > > > > expensive (in terms of time) to add a new=
 phase. We also have some
> > > > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Ma=
kefile are visually ugly and
> > > > > > > > > > > > > > > > > can be confusing, particularly when combi=
ned with ifdef and ifneq
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and I=
S_ENABLED() and they mean
> > > > > > > > > > > > > > > > > different things. For any given option, s=
ome code uses one and some
> > > > > > > > > > > > > > > > > the other, depending on what problems peo=
ple have met along the way.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous=
, in that it could mean that
> > > > > > > > > > > > > > > > > the option is enabled in one or more xPL =
phases, or just in U-Boot
> > > > > > > > > > > > > > > > > proper. The only way to know is to look f=
or $(PHASE_) etc. in the
> > > > > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the =
code. This is very confusing
> > > > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > d. We need to retain an important feature=
: options from different
> > > > > > > > > > > > > > > > > phases can depend on each other. As an ex=
ample, we might want to
> > > > > > > > > > > > > > > > > enable MMC in SPL by default, if MMC is e=
nabled in U-Boot proper. We
> > > > > > > > > > > > > > > > > may also want to share values between pha=
ses, such as TEXT_BASE. We
> > > > > > > > > > > > > > > > > can do this easily today, just by adding =
Kconfig rules.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I agree with a through c and for d there ar=
e likely some cases even if
> > > > > > > > > > > > > > > > I'm not sure TEXT_BASE is a good example. B=
ut I'm not sure it's as
> > > > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > OK. No, TEXT_BASE is not a great example in m=
y book either. But it is
> > > > > > > > > > > > > > > true that SPL needs to know U-Boot's text bas=
e.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Here's another:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > >    default y if SPL_SYS_MALLOC_F
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > >    default SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Alternatively:
> > > > > > > > > > > > > > config SYS_MALLOC_LEN
> > > > > > > > > > > > > >    ... current default X if Y
> > > > > > > > > > > > > >    default 0x2800 if RCAR_GEN3 && !PPL
> > > > > > > > > > > > > >    default 0x2000 if IMX8MQ && !PPL
> > > > > > > > > > > > >
> > > > > > > > > > > > > PPL means (in my book) that we have a PPL, i.e. i=
t is always true. It
> > > > > > > > > > > >
> > > > > > > > > > > > And in my proposal you're choosing between PPL, SPL=
, TPL, VPL.
> > > > > > > > > > > >
> > > > > > > > > > > > > is the same today, with SPL. We have CONFIG_SPL_B=
UILD which indicates
> > > > > > > > > > > > > which build it is. If you are suggesting that SPL=
 means that this is
> > > > > > > > > > > > > the SPL build, then which thing tells us whether =
or not we have an SPL
> > > > > > > > > > > > > build? I'm just a bit confused by this.
> > > > > > > > > > > >
> > > > > > > > > > > > And we wouldn't have CONFIG_SPL_BUILD because we wo=
uld either be
> > > > > > > > > > > > configuring for SPL=3Dy or SPL=3Dn, there's no conf=
usion anymore.
> > > > > > > > > > > >
> > > > > > > > > > > > > But how can I make the TPL value of SYS_MALLOC_F_=
LEN the same as the
> > > > > > > > > > > > > SPL one, with your scheme?
> > > > > > > > > > > >
> > > > > > > > > > > > If your question is "how do I set an arbitrary but =
consistent value in
> > > > > > > > > > > > SPL and SPL" that's not enforced. But they also sho=
uldn't be arbitrary
> > > > > > > > > > > > and we should have sane defaults set in Kconfig, re=
gardless of either
> > > > > > > > > > > > proposal. While I'm trying to not get lost in the d=
etails today we have
> > > > > > > > > > > > 80 matches on "git grep SPL_.*_LEN=3D configs/" and=
 2 for TPL and I would
> > > > > > > > > > > > encourage someone to verify those are needed. My in=
itial recollection is
> > > > > > > > > > > > that most of these are from when we bumped SYS_MALL=
OC_F_LEN or so up to
> > > > > > > > > > > > the commonly used default and had the few platforms=
 that didn't use the
> > > > > > > > > > > > new default previously switch to the old one.
> > > > > > > > > > > >
> > > > > > > > > > > > In other words, I don't think there's a problem her=
e that isn't solved
> > > > > > > > > > > > today, outside of either proposal.
> > > > > > > > > > > >
> > > > > > > > > > > > > So I'm still not understanding how you handle Kco=
nfig dependencies
> > > > > > > > > > > > > between phases with your scheme. Are you saying y=
ou don't and they are
> > > > > > > > > > > > > not important?
> > > > > > > > > > > >
> > > > > > > > > > > > Basically. The majority of the cases of:
> > > > > > > > > > > > config SPL_FOO
> > > > > > > > > > > >    default y if FOO
> > > > > > > > > > > >
> > > > > > > > > > > > config TPL_FOO
> > > > > > > > > > > >    default y if SPL_FOO
> > > > > > > > > > > >
> > > > > > > > > > > > Just go away because FOO is already default y or se=
lect/imply'd by
> > > > > > > > > > > > TARGET_BAR or ARCH_BAZ.
> > > > > > > > > > > >
> > > > > > > > > > > > > Also, is there a single Kconfig tree for U-Boot, =
or are you saying you
> > > > > > > > > > > > > want a different set of Kconfig files for each ph=
ase?
> > > > > > > > > > > >
> > > > > > > > > > > > Just the Kconfig files we have today. Likely with l=
ess overall lines
> > > > > > > > > > > > since for example we could drop:
> > > > > > > > > > > > config SPL_FS_EXT4
> > > > > > > > > > > >         bool "Support EXT filesystems"
> > > > > > > > > > > >         select SPL_CRC16 if EXT4_WRITE
> > > > > > > > > > > >
> > > > > > > > > > > > Since we already have fs/ext4/Kconfig.
> > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 1. Adjust kconf to generate separate auto=
conf.h files for each phase.
> > > > > > > > > > > > > > > > > These contain the values for each Kconfig=
 option for that phase. For
> > > > > > > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.=
h is SPL's text base.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 2. Add a file to resolve the ambiguity in=
 (c) above, listing the
> > > > > > > > > > > > > > > > > Kconfig options which should not be enabl=
ed/valid in any xPL build.
> > > > > > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, =
meaning U-Boot proper (only),
> > > > > > > > > > > > > > > > > useful in rare cases. This indicates that=
 the option applies only to
> > > > > > > > > > > > > > > > > U-Boot proper and is not defined in any x=
PL build. It is analogous to
> > > > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. =
Only a dozen of these are
> > > > > > > > > > > > > > > > > needed at present, basically to allow acc=
ess to the value for another
> > > > > > > > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PP=
L_TEXT_BASE so that it knows
> > > > > > > > > > > > > > > > > the address to which U-Boot should be loa=
ded.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 4. There is no change to the existing def=
config files, or 'make
> > > > > > > > > > > > > > > > > menuconfig', which works just as today, i=
ncluding dependencies between
> > > > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 5. (next) Expand the Kconfig language[2] =
to support declaring phases
> > > > > > > > > > > > > > > > > (SPL, TPL, etc.) and remove the need for =
duplicating options (DM_MMC,
> > > > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so a=
llowing an option to be
> > > > > > > > > > > > > > > > > declared once for any/all phases. We can =
then drop the file in 2
> > > > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > With this, maintaining Kconfig options, M=
akefiles and adding a new
> > > > > > > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I think this will not make our life easier,=
 it will make things harder.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I think what we've reached now shows that Y=
amada-san was correct at the
> > > > > > > > > > > > > > > > time in saying that we were going down the =
wrong path with how we
> > > > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > You've mentioned this quite a few times over =
the years. Is there a
> > > > > > > > > > > > > > > reference to what he suggested we should do? =
Or perhaps it is what you
> > > > > > > > > > > > > > > have below.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't recall what he proposed instead, just t=
hat when it became clear
> > > > > > > > > > > > > > that I wanted to move from the "S:CONFIG_FOO.."=
 syntax for how SPL was
> > > > > > > > > > > > > > handled to how we're doing it today, he thought=
 that was the wrong
> > > > > > > > > > > > > > direction.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, IMO he was right about that.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC an=
d SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > - Likely need to introduce a PPL symbol as =
you suggest.
> > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statemen=
t when building a defconfig.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Good idea.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > - Split something like rockpro64-rk3399_def=
config in to
> > > > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-=
rk3399_tpl_defconfig
> > > > > > > > > > > > > > > >   and add Makefile logic such that for X_de=
fconfig as a build target but
> > > > > > > > > > > > > > > >   not configs/X_defconfig not existing, we =
see if any of
> > > > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exi=
st and we run a builds in
> > > > > > > > > > > > > > > >   subdirectories of our object directory, a=
nd then using binman combine
> > > > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This means splitting the existing file into a=
 separate one for each
> > > > > > > > > > > > > > > phase. I believe that will be hard to manage.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Do you mean initially, or long term? Initially,=
 it should be a bit of
> > > > > > > > > > > > > > shell scripting. The consolidation (ie most/all=
 rk3399 having an
> > > > > > > > > > > > > > identical _spl_defconfig) can't be automated. L=
ong term I'm not sure it
> > > > > > > > > > > > > > would be any different. Most of the maintenance=
 is on resync'ing which
> > > > > > > > > > > > > > is automated.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Long term. How does 'make menuconfig' work in thi=
s case? Won't you
> > > > > > > > > > > > > have to run it three times for SPL, TPL and PPL?
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, you would run configure for what you're buildi=
ng. This is a good
> > > > > > > > > > > > thing as it will no longer be so confusing to hunt =
down where SPL or TPL
> > > > > > > > > > > > or VPL options for a specific thing reside.
> > > > > > > > > > > >
> > > > > > > > > > > > > > > >   - Maybe instead the Makefile logic above =
we would parse X_defconfig
> > > > > > > > > > > > > > > >     and see if it's a different format of s=
ay PHASE:file to make it
> > > > > > > > > > > > > > > >     easier to say share a single TPL config=
 with all rk3399, have a few
> > > > > > > > > > > > > > > >     common SPL configs and then just a boar=
d specific PPL.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This solves (a) by removing them entirely. =
This solves (b) by removing
> > > > > > > > > > > > > > > > the ambiguity entirely (it will be enabled =
or not). As a bonus for (b)
> > > > > > > > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG=
_FOO) and match up with the
> > > > > > > > > > > > > > > > Linux Kernel again. This solves (c) again b=
y removing it entirely.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The scheme I propose removes a-c also. I shou=
ld have made that clear.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Er, ok. That's not how it looked before, but I =
guess I'm just mistaken.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes I think so...it was a major goal to remove th=
is stuff. [1] [2]
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks.
> > > > > > > > > > > >
> > > > > > > > > > > > > > > There is not a huge difference between your s=
cheme and mine. My
> > > > > > > > > > > > > > > question is, how do you handle (d)?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Well, either (d) isn't important as for example=
 MMC wasn't a good choice
> > > > > > > > > > > > > > in your proposal as virtually everyone "select =
MMC" today or it's
> > > > > > > > > > > > > > handled more easily as my example above in SYS_=
MALLOC_LEN.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The way I see it, both schemes remove the amb=
iguity. Mine retains a
> > > > > > > > > > > > > > > single deconfig file and a single 'make menuc=
onfig' for each board.
> > > > > > > > > > > > > > > Yours feels more like building independent U-=
Boot images.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > It is explicitly building independent U-Boot im=
ages, yes. With a wrapper
> > > > > > > > > > > > > > around "make all of the images for a given plat=
form". So much of our
> > > > > > > > > > > > > > confusing and messy code is because we aren't d=
oing that. And since most
> > > > > > > > > > > > > > modern SoCs can work as (mostly )generic SPL se=
lects correct DTB for PPL
> > > > > > > > > > > > > > we really could have fewer overall build config=
urations.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'd really like to see a generic aarch64 U-Boot f=
or PPL, although it
> > > > > > > > > > > > > would be quite large with all the drivers. Perhap=
s we could start by
> > > > > > > > > > > > > having a generic Rockchip one, for example.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Still I don't see this being strongly related to =
the discussion about
> > > > > > > > > > > > > these two different schemes.
> > > > > > > > > > > >
> > > > > > > > > > > > Well, in your scheme how do we have say generic-aar=
ch64_defconfig
> > > > > > > > > > > > function on either chromebook_bob or am62x_beaglepl=
ay_a53 ? In mine,
> > > > > > > > > > > > since everything is a separate build, generic-aarch=
64_defconfig has
> > > > > > > > > > > > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_RK3399=3Dy. And t=
hen
> > > > > > > > > > > > chromebook_bob_defconfig would say to use chromeboo=
k_bob_tpl_defconfig,
> > > > > > > > > > > > generic-rk3399_spl_defconfig and generic-aarch64_de=
fconfig. As a bonus
> > > > > > > > > > > > instead of am62x_beagleplay_a53_defconfig and
> > > > > > > > > > > > am62x_beagleplay_r5_defconfig we would have am62x_b=
eagleplay_defconfig
> > > > > > > > > > > > that would say to use the appropriate SPL/PPL for R=
5, and appropriate
> > > > > > > > > > > > SPL/PPL for A53.
> > > > > > > > > > > >
> > > > > > > > > > > > But the one big huge caveat I want to make here is =
that "generic" images
> > > > > > > > > > > > are useful in some use cases (I'm sure all of the r=
egular F/OSS
> > > > > > > > > > > > distributions would love a single actually common P=
PL if they can fit
> > > > > > > > > > > > it) will strip things down. Whatever the IoT edge d=
evice closest to you
> > > > > > > > > > > > now really won't want to ship with all the platform=
s enabled. Image size
> > > > > > > > > > > > still matters.
> > > > > > > > > > >
> > > > > > > > > > > OK thanks for the details. I think I have a reasonabl=
e idea of what
> > > > > > > > > > > you are proposing, now. It would work, but is quite r=
adical, IMO.
> > > > > > > > > > > That's not necessarily a bad thing, but in my mind I =
see a sequencing
> > > > > > > > > > > possibility.
> > > > > > > > > > >
> > > > > > > > > > > A few points from my side:
> > > > > > > > > > >
> > > > > > > > > > > 1. I would love to see the defconfig files reduce in =
size, with more
> > > > > > > > > > > and better defaults. One way to do this would be to e=
nforce a maximum
> > > > > > > > > > > length. I added a feature to qconfig to allow finding=
 common options
> > > > > > > > > > > among boards (the -i flag), but I'm not sure if many =
people use it.
> > > > > > > > > >
> > > > > > > > > > I don't see reducing defconfig size as important honest=
ly. Should we
> > > > > > > > > > have more and better defaults? Yes. But almost everythi=
ng is under 200
> > > > > > > > > > lines with the biggest (non-sandbox) ones being the gen=
eric zynqmp
> > > > > > > > > > platform(s?).
> > > > > > > > >
> > > > > > > > > Agreed.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > 2. Generic boards is something I have been pushing fo=
r years (in fact
> > > > > > > > > > > it is why I originally introduced devicetree), but I'=
m not seeing a
> > > > > > > > > > > lot of traction.
> > > > > > > > > >
> > > > > > > > > > I don't think generic boards are universally helpful. E=
ven if what I'm
> > > > > > > > > > proposing would allow for more of it, below the PPL sta=
ge I'm not sure
> > > > > > > > > > it's both feasible enough and useful enough for product=
ion. At the PPL
> > > > > > > > > > stage it still has to be small enough and not overly bu=
rdensome. What we
> > > > > > > > > > talked about on the call yesterday about using more mul=
ti-dtb images is
> > > > > > > > > > a step in the right direction, yes.
> > > > > > > > >
> > > > > > > > > Agreed. Anway, we can create separate targets for generic=
 boards if we want to.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > 3. Iit seems that you want to remove all the 'if SPL'=
 pieces and just
> > > > > > > > > > > rely on the current PPL configuration. But how will t=
hat work? There
> > > > > > > > > > > are tons of features which don't work in SPL, or are =
not relevant, or
> > > > > > > > > > > have special 'small' versions. That is a *lot* of Kco=
nfig refactoring
> > > > > > > > > > > just to get something working, isn't it? With my sche=
me there is no
> > > > > > > > > > > Kconfig change needed initially - it can be done late=
r as needed /
> > > > > > > > > > > desirable.
> > > > > > > > > >
> > > > > > > > > > I don't think we would remove most "if SPL" cases. Taki=
ng part of the
> > > > > > > > > > current stanza for ROCKCHIP_RK3399 as an example:
> > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > >         select ARM64
> > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > >         select SPL
> > > > > > > > > >         select SPL_ATF
> > > > > > > > > >         select SPL_BOARD_INIT if SPL
> > > > > > > > > >         ...
> > > > > > > > > >         select SPL_CLK if SPL
> > > > > > > > > >         ...
> > > > > > > > > >         select CLK
> > > > > > > > > >         ...
> > > > > > > > > >         imply TPL_CLK
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > This would become:
> > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > >         select ARM64
> > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > >         select SPL_ATF if SPL # TBD: Does 'ATF' make se=
nse outside of SPL?
> > > > > > > > > >         select BOARD_INIT if SPL # Not TPL_BOARD_INIT h=
ere
> > > > > > > > > >         select CLK # imply was likely wrong before? Wou=
ld need to check
> > > > > > > > > >         ...
> > > > > > > > >
> > > > > > > > > I was more talking about the large blocks of 'if SPL' - e=
=2Eg. we have
> > > > > > > > > common/spl/Kconfig and common/spl/Kconfig.tpl
> > > > > > > >
> > > > > > > > I would vastly reduce the contents within those 'if' blocks=
, but there
> > > > > > > > are still options that are xPL-centric without a PPL counte=
rpart, such
> > > > > > > > as SPL_ATF (I suspect, but if not I'm sure others).
> > > > > > > >
> > > > > > > > > But just the level of thought required in your small exam=
ple above
> > > > > > > > > suggests it is a large effort.
> > > > > > > >
> > > > > > > > Yes, restructuring our Kconfig logic and then removing our =
xPL logic is
> > > > > > > > some work. So was, I suspect, all of what you did already.
> > > > > > > >
> > > > > > > > > > > 4. My scheme splits the config into separate files. Y=
ours makes the
> > > > > > > > > >
> > > > > > > > > > I don't see yours as splitting the configs in to separa=
te files, I see
> > > > > > > > > > it as generating some intermediate objects. The configs=
 don't change and
> > > > > > > > > > that's one of our problem areas.
> > > > > > > > >
> > > > > > > > > So you mean a big problem area is the current Kconfig?
> > > > > > > >
> > > > > > > > I mean it's a problem for users a board developers to make =
valid
> > > > > > > > configurations and update them as needed. Filesystems are i=
n the
> > > > > > > > filesystem menu, unless they're SPL and then it's all under=
 the big SPL
> > > > > > > > menu.
> > > > > > > >
> > > > > > > > > Mind generates
> > > > > > > > > out to an include/generated/autoconf_xxx for each phase. =
Yes they are
> > > > > > > > > intermediate files and auto-generated, but each 100% cont=
rols its
> > > > > > > > > phase, so there is no confusion and CONFIG_IS_ENABLED() /=
 odd Makefile
> > > > > > > > > rules anymore.
> > > > > > > >
> > > > > > > > Yes, removing CONFIG_IS_ENABLED and $(PHASE_)/$(XPL_) from =
Makefiles is
> > > > > > > > good. But the intermediate files aren't going to help (nor =
hurt) any of
> > > > > > > > the problems themselves. If you're reading those to figure =
out a
> > > > > > > > problem, it's like when you're reading a .i file to figure =
out a
> > > > > > > > problem, it means you're already in a complex troublesome s=
pot.
> > > > > > > >
> > > > > > > > But I don't know that CONFIG_SPL_FS_FAT=3Dy means that CONF=
IG_FS_FAT=3Dy for
> > > > > > > > SPL builds leads to "no confusion". But I do think that CON=
FIG_SPL=3Dy and
> > > > > > > > CONFIG_FS_FAT=3Dy does.
> > > > > > > >
> > > > > > > > > > > split earlier, at the Kconfig level. So it seems that=
 we could go with
> > > > > > > > > > > my scheme to get us to a split config, then, after th=
at, decide
> > > > > > > > > > > whether to move that split earlier to Kconfig itself.=
 The choices
> > > > > > > > > >
> > > > > > > > > > I don't think so. Yours makes things complicated by mak=
ing the build do
> > > > > > > > > > even more (and from the RFC, the implementation tooling=
 diverges from
> > > > > > > > > > upstream).
> > > > > > > > >
> > > > > > > > > Yes it makes the kconf tool generate those separate files=
 for each phase [3]
> > > > > > > > >
> > > > > > > > > > Mine makes things differently complicated by doing less=
 for
> > > > > > > > > > most things, but needing some thought on how to know th=
at say
> > > > > > > > > > chromebook_bob needs chromebook_bob_tpl_defconfig,
> > > > > > > > > > chromebook_bob_spl_defconfig and chromebook_bob_ppl_def=
config to be
> > > > > > > > > > built, before asking binman to go put things together.
> > > > > > > > >
> > > > > > > > > Yours seems feasible in a fully Binman world, but given t=
he difficulty
> > > > > > > > > we (or I) have completing a migration, I honestly don't b=
elieve this
> > > > > > > > > is feasible in today's U-Boot. The other problem is that =
it all has to
> > > > > > > >
> > > > > > > > I'm not 100% sure it's everything needs binman actually. Or=
 even if we
> > > > > > > > do take this as a reason to push for more binman, it's just=
 some trivial
> > > > > > > > types already handled in the Makefile that's missing.
> > > > > > > >
> > > > > > > > > be done at once. We need to rewrite the Kconfig and flip =
over the
> > > > > > > > > board. Will we carry people with us? That is a huge risk =
to the
> > > > > > > > > project IMO.
> > > > > > > >
> > > > > > > > I'm not sure, actually, that it couldn't be done in stages.=
 We might
> > > > > > > > need a little bit of fakery around being able to just build=
 SPL without
> > > > > > > > PPL in the interim.
> > > > > > > >
> > > > > > > > > Anyway, yes my schema makes the build do even more (with =
400 lines of
> > > > > > > > > kconf additions and a patch that can likely be upstreamed=
). But
> > > > > > > > > otherwise, it is a one-off improvement, without any chang=
es to the
> > > > > > > > > existing Kconfig.
> > > > > > > >
> > > > > > > > I thought Yamada-san rejected changes going in this directi=
on before?
> > > > > > > > But either way, no it's not likely the final overburden in =
terms of
> > > > > > > > divergence.
> > > > > > >
> > > > > > >
> > > > > > > Yes. Masahiro will make his own decisions and I am confident =
he will
> > > > > > > reject any future changes I send
> > > > > > >
> > > > > > > >
> > > > > > > > > So my point is that we could go with the first part of my=
 scheme to
> > > > > > > > > resolve the 'medium' problems then decide which way to co=
ntinue after
> > > > > > > > > that. From your side you won't have lost anything towards=
 where you
> > > > > > > > > want to head. The two options would then be:
> > > > > > > > >
> > > > > > > > > - exhance kconfig language to build in the notion of phas=
es
> > > > > > > > > - split the defconfigs for each board, redo the Kconfig r=
ules and
> > > > > > > > > teach the build to combine images
> > > > > > > >
> > > > > > > > If things go down your proposed path instead, no, I don't s=
ee that as
> > > > > > > > making it meaningfully easier to go the way I proposed late=
r. The only
> > > > > > > > commonality is dropping $(PHASE_)/$(XPL_)/etc and CONFIG_IS=
_ENABLED ->
> > > > > > > > IS_ENABLED. And (almost) all of that is a script'able chang=
e.
> > > > > > >
> > > > > > > To be frank, the difference is that I have actually put in th=
e work to
> > > > > > > try this. It is more than 50 and perhaps as many as 100 patch=
es. Quite
> > > > > > > difficult work. Honestly, compared to that, the logic changes=
 are not
> > > > > > > that large.
> > > > > > >
> > > > > > > That is why I believe this work is a prerequisite for both sc=
hemes
> > > > > > >
> > > > > > > >
> > > > > > > > > > > would then be to use your scheme (Kconfig refactoring=
, splitting
> > > > > > > > > > > defconfigs and some rework), or to do my scheme (whic=
h would require
> > > > > > > > > > > enhancing the Kconfig language a bit just for U-Boot =
and some optional
> > > > > > > > > > > rework over time). Both schemes would need a small am=
ount of
> > > > > > > > > > > build-logic changes, but I'm not sure yet what that w=
ould look like.
> > > > > > > > > > >
> > > > > > > > > > > Does that sound right?
> > > > > > > > > >
> > > > > > > > > > With what I said above, yes I think we're closer at lea=
st to
> > > > > > > > > > understanding each other.
> > > > > > > > >
> > > > > > > > > Yes.
> > > > > > > >
> > > > > > > > Well, with that, what now?
> > > > > > > >
> > > > > > > > What makes the current situation untenable is VPL. And I ga=
ther I
> > > > > > > > haven't convinced you to put that on hold long enough to in=
stead rework
> > > > > > > > how we build things, have I?
> > > > > > >
> > > > > > > Which VPL thing?
> > > > > >
> > > > > > That it exists. When it was just SPL, it's manageable. With TPL=
, well,
> > > > > > it was supposed to be tiny and so just a few more things. And w=
ith VPL,
> > > > > > that makes 4. It's too much. Something needs to be done. Four t=
imes is
> > > > > > too many. If solving Marek's desire for PSCI-from-U-Boot means =
we need
> > > > > > number 5 that becomes even worse (and I also suspect that's a c=
ase of
> > > > > > one build covers the SoC or family of SoCs depending on hardware
> > > > > > changes).
> > > > >
> > > > > Yes, that's why I took on this effort a few years back.
> > > > >
> > > > > >
> > > > > > > You have convinced me that you have a solution. It makes a lo=
t more
> > > > > > > sense to me than previously and it may be that it is better i=
n the
> > > > > > > end. For example, with VBE it I would make a lot of sense to =
build 20
> > > > > > > boards as just TPL and use a generic rock chip board for ever=
ything
> > > > > > > else. That would be a lot tidier with your scheme. It is very=
 hard to
> > > > > > > predict the future and VBE is still not finished, some two ye=
ars in.
> > > > > > >
> > > > > > > I don't want to be tied to your scheme today though.
> > > > > > >
> > > > > > > So if you can accept my going ahead with 1-4 and helping me w=
ith that,
> > > > > > > then we can stop and discuss which way to go, perhaps by prot=
otyping
> > > > > > > the two options?
> > > > > >
> > > > > > I want to start by saying I do appreciate you put in a lot of w=
ork in
> > > > > > this direction already, and I do see some of the end goals it a=
chieves
> > > > > > as being important, and I'm glad you see my idea has some good =
parts
> > > > > > too.
> > > > > >
> > > > > > I want to figure out how to move forward on this problem. My ot=
her part
> > > > > > of this thread, this morning, was also part of me looking harde=
r, again,
> > > > > > at the RFC series you posted before. And that's where I still h=
ave large
> > > > > > reservations. There are *so* *many* symbols we need to now have=
 4
> > > > > > variants of, instead of 1 variant of. Take:
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20230212231638=
=2E1134219-58-sjg@chromium.org/
> > > > > > for example. It adds SPL_PARTITION_TYPE_GUID but we include <pa=
rt.h> in
> > > > > > files built in TPL (and likely VPL) so aren't we going to need =
that
> > > > > > every time? And with a quick size-check on pinebook-pro-rk3399 =
it looks
> > > > > > like it's not working as intended either? I checked and part_ge=
t_info
> > > > > > shrinks because CONFIG_PARTITION_TYPE_GUID is not set, or rathe=
r:
> > > > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > > >                 info->type_guid[0] =3D 0;
> > > > > > #endif
> > > >
> > > > Oh, I get it now. Previously CONFIG_PARTITION_TYPE_GUID=3Dy but now
> > > > CONFIG_SPL_PARTITION_TYPE_GUID=3Dn and while I'm not sure that's a =
good
> > > > thing I see what happened. And now I see my problem from yesterday
> > > > morning was similar but different.
> > > >
> > > > > > is not true and checked. And I can't see why. And there's other=
 size
> > > > > > reductions (this time in tpl) on pinebook-pro-rk3399 that I did=
n't dig
> > > > > > in to more, but wasn't that symbol:
> > > > > >                tpl-u-boot-tpl: add: 0/-4, grow: 0/0 bytes: 0/-3=
44 (-344)
> > > > > >                  function                                   old=
     new   delta
> > > > > >                  dev_get_uclass_plat                         12=
       -     -12
> > > > > >                  simple_bus_post_bind                        92=
       -     -92
> > > > > >                  _u_boot_list_2_uclass_driver_2_simple_bus     =
120       -    -120
> > > > > >                  _u_boot_list_2_driver_2_simple_bus         120=
       -    -120
> > > > > >
> > > > > > And I'm not bringing this up to badger you about bugs in an RFC=
 series
> > > > > > (it's RFC, there's bugs) but rather because I think it highligh=
ts some
> > > > > > core issues with the approach as implemented.
> > > > >
> > > > > But surely you can see that both schemes have exactly the same is=
sues?
> > > > >
> > > > > My point is that the work to tidy up things and then get to a 'cl=
ean'
> > > > > source tree and Makefiles is the hard bit here and has to be done=
 with
> > > > > both schemes.
> > > > >
> > > > > Just let me know which way you want to go. I don't have anything =
ready
> > > > > to send, but I could probably drag it over the line before too lo=
ng,
> > > > > if you are keen.
> > > >
> > > > Once I figured out what was the cause of the problems I saw in the =
RFC,
> > > > I had to rewrite this a few times. Your approach needs even more sy=
mbols
> > > > added than were in the RFC, and the newly added symbols need further
> > > > auditing to make sure we have the same behavior as today at least by
> > > > default.
> > >
> > > This is the idea that we need to clean up a, b and c. Your scheme is
> > > the same in this respect. If we have CONFIG_FOO today, then your
> > > scheme may need that duplicated to each defconfig file. Either you
> > > resolve the ambiguity or don't. But if you do, then you have to add
> > > symbols, with both schemes.
> >
> > There is minimal pain in saying a defconfig needs to list CONFIG_FOO
> > there is pain in saying that we need to list
> > config PARTITION_TYPE_GUID
> > ...
> > config SPL_PARTITION_TYPE_GUID
> > ...
> > config TPL_PARTITION_TYPE_GUID
> > ...
> > config VPL_PARTITION_TYPE_GUID
> > ...
> >
> > In what I'm saying it's not generally an issue because:
> > $ git grep -l PARTITION_TYPE_GUID configs | wc -l
> > 21
> >
> > And we don't have to do additional upkeep on having N symbols.
>=20
> Well we only need to add those extra symbols if 1) we want that
> feature in a particular xPL, *and* 2) we don't want it everywhere.

Yes, and the problem is adding more of them. Again, we would need to
duplicate drivers/usb/gadget/Kconfig with your scheme.

> There is nothing in my scheme which requires us to add options that
> don't currently exist...but there is a problem if some code uses
> CONFIG_IS_ENABLED(FOO) today and some code uses IS_ENABLED(FOO). My

That's good because that wasn't (how it seemed?) previously.

> conf_nospl file helps with that and avoids changing Kconfig. But
> again, if we are using both, then who knows what it means today, and
> I'd like to clean it up.

What we have today, with respect to CONFIG_IS_ENABLED(...) /
IS_ENABLED(...) is clearer than IS_ENABLED(CONFIG_FOO) that is really
checking for CONFIG_SPL_FOO or CONFIG_VPL_FOO if it's in SPL or VPL.
It's easy to get *wrong* yes, but it's also clear. You're checking for
what it says.

> > > > On the one hand, this is at least a well defined technical
> > > > problem and if you do the language extension *first* the code chang=
es
> > > > aren't so bad.
> > >
> > > There are no significant Kconfig changes in my scheme, other than the
> > > conf_nospl file. The language extension is quite separate.
> >
> > $ git diff pre-RFC-migrate-to-split-config..RFC-migrate-to-split-config
> > \
> >         | filterdiff -i "a/*/Kconfig" | diffstat -p1 | tail -n 1
> >  25 files changed, 316 insertions(+), 3 deletions(-)
> >
> > And that is largely duplication of existing symbols. And again, it
> > wasn't enough duplication.
>=20
> I wonder if that is stuff that was already applied? Here is what I have t=
oday.
>=20
> $ glo ci/master..splg4  | filterdiff -i "a/*/Kconfig" | diffstat -p1 | ta=
il -n 1
>  0 files changed
>=20
> You can use the u-boot-dm/splg-working tree to see the original
> version. From memory, the splc tree is very old and was mostly applied
> or dropped.

The splc-working tree is the RFC you pointed at earlier and so yes, what
I was comparing with. If you were able to drop some of the problems,
that's good.

> > > > But for the user running menuconfig / etc? That's not
> > > > going to be pretty. And we still won't have fixed the problems like=
 "why
> > > > is TPL even trying to build DWC3?" without reworking more symbols.
> > > >
> > > > So I don't think this is the right approach as it doesn't reduce
> > > > confusion and may increase it (why do I need to set
> > > > CONFIG_SPL_PARTITION_TYPE_GUID when the code checks for
> > > > CONFIG_PARTITION_TYPE_GUID?
> > >
> > > Because it is an SPL build...I actually think that makes a lot of
> > > sense. You just need to understand that CONFIG_SPL_ means the SPL
> > > build, which in fact is what we have been using for years.
> >
> > And it's no longer clear in the code, is the problem.
> >
> > >
> > > > But why is CONFIG_SPL_FRAMEWORK still there?
> > >
> > > Not relevant to the discussion, IMO.
> >
> > It's an example symbol. Why does the code have:
> >
> > #ifdef CONFIG_PARTITION_TYPE_GUID
> > ...
> > #endif
> >
> > And that's true for SPL builds. But the code also still has:
> > #ifdef CONFIG_SPL_FRAMEWORK
> > ...
> > #endif
> >
> > Which is only true for CONFIG_SPL_FRAMEWORK being set.
>=20
> OK I think I understand your question. The tools work by identifying
> options which are in PPL and may or not be in other builds. There is
> no CONFIG_FRAMEWORK so all of this migration doesn't apply.

No, you entirely misunderstand me. I am not talking about the tool. I am
talking about the developer.

> If there were a CONFIG_IS_ENABLED(FRAMEWORK) or a CONFIG_FRAMEWORK
> then the discussion would be different.
>=20
> BTW, I wonder if we could drop that symbol, or switch it around so
> that boards which don't use it have to set CONFIG_SPL_STRANGE or
> similar.

Touching the PowerPC TPL/SPL stuff is very low on the priority list. If
you want to file an issue for it, please do. But that (roughly) is why
there's SPL_FRAMEWORK.

> > > > Oh..). The main thing it does is drop $(PHASE_) and I honestly think
> > > > that's more confusing. We still have one build where we need to do =
or
> > > > not do different things for FOO && PPL, FOO && SPL, etc but the code
> > > > just references CONFIG_FOO but doesn't always mean CONFIG_FOO=3Dy/n=
 in the
> > > > .config / defconfig.
> > >
> > > Yes, that's the conf_nospl file which I have dealt with.
> >
> > OK? My point is that the code is now more confusing, not less confusing.
> > Because the code says CONFIG_PARTITION_TYPE_GUID. Not
> > CONFIG_SPL_PARTITION_TYPE_GUID. And not IS_ENABLED(PARTITION_TYPE_GUID)
> > which is at least a hint that one needs to look harder, and oh,
> > CONFIG_SPL_PARTITION_TYPE_GUID maybe matches somehow.
>=20
> If you are saying that it is better to have CONFIG_IS_ENABLED(FOO),
> IS_ENABLED(CONFIG_FOO), obj-$(CONFIG_$(PHASE_)FOO) etc., then I don't
> agree, sorry. That is problems a-c in my original proposal and my
> understanding is that both our approaches resolve this problem.
>=20
> Otherwise, you've just lost me and we should probably give up on this poi=
nt.

Yes, I am saying that what we have today is less confusing than what you
are proposing. Because with your proposal:

obj-$(CONFIG_FS_FAT) +=3D fat/

Can refer to CONFIG_SPL_FS_FAT, CONFIG_FS_FAT or CONFIG_VPL_FS_FAT. That
is not good for humans.

> > > > I really think we need to literally split the config files up such =
that
> > > > for the most part we do (in psuedo code):
> > > > %_full_config:
> > > >   make -C $(srctree) O=3D$(obj)/ppl %_ppl_defconfig
> > > >   make -C $(srctree) O=3D$(obj)/spl %_spl_defconfig
> > > >   ...
> > > >
> > > > all:
> > > >   [ -d $(obj)/ppl ] && make -C $(srctree) O=3D$(obj)/ppl all
> > > >   [ -d $(obj)/spl ] && make -C $(srctree) O=3D$(obj)/spl all
> > > >   ...
> > > >
> > >
> > > Perhaps you should take a look at this and come up with an RFC series
> > > for your scheme? I think that would help us gain a better shared
> > > understanding of the problem.
> > >
> > > Failing that, I am willing and able to do another version of my
> > > scheme, if it suits.
> >
> > And how about instead you come up with an RFC of what I suggested, in
> > order to further your VPL proposal?
>=20
> That's unlikely, for two reasons:
>=20
> i. We can start with my scheme, get that applied and then still
> continue on to your scheme, so we haven't lost anything by doing mine
> first
>=20
> ii. I still believe my scheme could be the right one, although I have
> to admit I would rather look at it again when we get to that point, as
> I do have quite a few concerns about the Kconfig complexity of 4),
> with my scheme, particularly after this discussion
>=20
> >
> > Or, have we finally come to it. I can either merge your proposal, which
> > I have grave reservations about, or you'll just do this all in your
> > downstream fork? Because no, I don't have time to work on reworking this
> > for VPL. I don't have the interest in reworking this for VPL.  Or should
> > we come up with some method for the community to vote on what to do
> > here?
>=20
> Or, if you don't want to make time to work on it, why get in the way
> of those who are willing to do so?

Because I'm reviewing your code and see grave problems? Problems that
could be worse than doing nothing? That's why. I will take a look at
"splg-working". However, I disagree with your point (i) above in that
the reusable work is the script'able work. For example, we've already
had feedback that when using $(PHASE_) vs $(XPL_) is confusing. Now
we're going to replace that confusion with "why does CONFIG_SPL_FOO
sometimes also mean CONFIG_FOO but not others?".

--=20
Tom

--94LcxDT73RN+2MLT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmev1S8ACgkQFHw5/5Y0
tywJygwAhHtxNkMiqGPcldShjPIsZkqfaTkpyLabqp/U4lP3/d2tFpwP6s4cEcAd
XOhcv95EQAT5o4KcmPVsiuPwu6w/cd6q9DcBoGO9yHi1uGPgTjwmSOxZEp2Yed/n
Fz2dmL3marjIKE6Hg6SDuVhM6xHWwE09zcd21O6eYvSN2bCr8E9WN2xPLI7G+/s5
ht+HErw0oUsuMksbcHbP4d5BDJViTqnXZOxurYClxmvFdvJjVy3vkPmUZiAa9Vtj
A6ro9AkDYEuxgbbGRREYWO+YuoKkL0YeXOEY+JTeju4IYsWgU3ZP2f5uXgIkALiR
NZoGE+dKs97IMMQHBEG7nom0sMiSEc4eII97oUtX+qFti/YPi3YAdJGMD0HYi+5M
pB8spJyZeEBzlkjwMWzRds8kECT8jlajAu7dc8pZEdhy/kBALfEoBT4moXk01piZ
iEjLxCLksXFpY4XrHNG+3GTtRer32FCXV5tMa+9NgnLWfjHaBFj8w6PAqFDec8yv
BQeAx9gb
=RbPD
-----END PGP SIGNATURE-----

--94LcxDT73RN+2MLT--
