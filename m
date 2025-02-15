Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4569C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 01:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE44F80756;
	Sat, 15 Feb 2025 02:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G/qJ9MBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA9980C77; Sat, 15 Feb 2025 02:14:13 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2EE6806FE
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 02:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6f768e9be1aso31433087b3.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 17:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739582048; x=1740186848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4gOb+/pYFGFwJ+gvNz2GMiqlcOT67FwHqM3sbT02ZdU=;
 b=G/qJ9MBTTVQ/Ip74tJSgXEm0Xjm1eE3f8SxqrGO4hIkIBqhQXfRXMz6wNSDCIMbTnq
 1unQMkyuYKgiVLCc5Rg3lQ1skbtwd2vOdmJUzhHuDAz2I+M0Wq/e+3H/N2hjbVgpLcUg
 iYJnJf40/gnW0qoyZRixzorfZEVUsSie6w14Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739582048; x=1740186848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gOb+/pYFGFwJ+gvNz2GMiqlcOT67FwHqM3sbT02ZdU=;
 b=cyqupfJPi4VOWuvXAJ+lpoSiAcKRllqmuUNHcpBD8EQluVgS8yZvQrtq3l2wQRQETW
 7xZnF6xxHBCvxakCbNcOQoK4djH8v77cH5zaMKnZDsSjMG/ML549C7RYkUYLU6E8Pb8V
 JkAWYsAk9HcIdf3b55KWdvYGDjQzqo7Eu0qrc1+wfFh//9xyBpyKIUsdf0mqQ2sYKBHu
 NRvT/p0R8PJHF0wS//Pt3pLkarxFQgO//MWJuiKPkqATFzxnT2OdMxK8svzw1UKrOlYy
 /fMQYsFtgxja0eWCuCf29mn8W2x41cdkbtI2pnCA966JEHWVBhyle3sUY5H+yrbH6gLq
 HjQQ==
X-Gm-Message-State: AOJu0YxqmCtMVm1H00OXOCSFihrVx5jPE/uvQhaVEZF5Ntua5dOVsexX
 PuIyOC6qmRKkubysrbn/DE1x8twxhi+J2LK6xmBqIgoi1L3vY5bVhvmNoHw/cm6DGKTaQlf2DCc
 63yc=
X-Gm-Gg: ASbGncvtJy6ppQzow3GUzwPiZqUK955RGrQWK245NJ3fORvOOMtbMP/J81OHWIeGUpQ
 5ea2uPc+X2phdMWCB1+AWLU6Xhdg4atrCAioEMzxOA6p3uCYzN2etiRtIdBf3Ez7ka5KxiK6nvK
 27PPBMOv5YveyLlF3v8F8Vx14eT4gN9rZyBwfc2OuNvHL1zcv8MDCOto1JO/JHaiw9/qmIXurJA
 mZZznCXZdKXxDOdy4KujTy3LngT65mVXmMjt+N1dcpiXgWNacnIWGUp2yZfFpeoiw3KK4nbgl2v
 mbRmW4UITpKNuk8=
X-Google-Smtp-Source: AGHT+IFu4KRz4FoY7QqAVVg/AA/sQN5YS++H6wIgBVECsIAsROrSYPDXpFiA1VFrbcmKNgEZK8CFrg==
X-Received: by 2002:a05:6902:3408:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e5dc98b2a49mr1054525276.16.1739582047915; 
 Fri, 14 Feb 2025 17:14:07 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5dadfc0919sm1300322276.34.2025.02.14.17.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 17:14:06 -0800 (PST)
Date: Fri, 14 Feb 2025 19:14:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250215011403.GK1233568@bill-the-cat>
References: <20250213180352.GY1233568@bill-the-cat>
 <CAFLszTj5z9TF_a0Y6zEABmUvjVjEYgw31gGRMX3Y1anVJgEvnA@mail.gmail.com>
 <20250213225932.GC1233568@bill-the-cat>
 <CAFLszTia0RZXgVRMq=jfBc75bNFSO6N8m5MtuPLcs33DHbE3FQ@mail.gmail.com>
 <20250214143928.GG1233568@bill-the-cat>
 <CAFLszTg0yeOu13h1bxq2KiqVqwUQ-DdiJc+nhhknf5_JGygXgw@mail.gmail.com>
 <20250214211652.GI1233568@bill-the-cat>
 <CAFLszTi=abpaGi0CnnNoKYsT9M0H-9xrGaQtdLORvM8J7usX1Q@mail.gmail.com>
 <20250214234354.GJ1233568@bill-the-cat>
 <CAFLszTghcMz1mnu_jZOi9=TQpTgjyOQV-4sT=p=Q=dUBo3pQ_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EyFOklre93JQj1Gm"
Content-Disposition: inline
In-Reply-To: <CAFLszTghcMz1mnu_jZOi9=TQpTgjyOQV-4sT=p=Q=dUBo3pQ_Q@mail.gmail.com>
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


--EyFOklre93JQj1Gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 04:52:04PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 14 Feb 2025 at 16:43, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 03:46:30PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 14 Feb 2025 at 14:16, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 14, 2025 at 12:48:33PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, Feb 14, 2025, 07:39 Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 13, 2025 at 05:09:47PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 13 Feb 2025 at 15:59, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Feb 13, 2025 at 02:57:59PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, Feb 13, 2025, 11:03 Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 13, 2025 at 05:50:13AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 12 Feb 2025 at 15:58, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Feb 12, 2025 at 01:05:11PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I just wanted to send a note to (re-)=
introduce my ideas[1] for the
> > > > > > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > A recent series introduced 'xPL' as t=
he name for the various
> > > > > > > > > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_=
BUILD means that this is any xPL
> > > > > > > > > > > > > > > > > > > phase and CONFIG_SPL means this reall=
y is the SPL phase, not TPL. We
> > > > > > > > > > > > > > > > > > > still use filenames and function nami=
ng which uses 'spl', but could
> > > > > > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > The major remaining problem IMO is th=
at it is quite tricky and
> > > > > > > > > > > > > > > > > > > expensive (in terms of time) to add a=
 new phase. We also have some
> > > > > > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in th=
e Makefile are visually ugly and
> > > > > > > > > > > > > > > > > > > can be confusing, particularly when c=
ombined with ifdef and ifneq
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() a=
nd IS_ENABLED() and they mean
> > > > > > > > > > > > > > > > > > > different things. For any given optio=
n, some code uses one and some
> > > > > > > > > > > > > > > > > > > the other, depending on what problems=
 people have met along the way.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > c. An option like CONFIG_FOO is ambig=
uous, in that it could mean that
> > > > > > > > > > > > > > > > > > > the option is enabled in one or more =
xPL phases, or just in U-Boot
> > > > > > > > > > > > > > > > > > > proper. The only way to know is to lo=
ok for $(PHASE_) etc. in the
> > > > > > > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in =
the code. This is very confusing
> > > > > > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > d. We need to retain an important fea=
ture: options from different
> > > > > > > > > > > > > > > > > > > phases can depend on each other. As a=
n example, we might want to
> > > > > > > > > > > > > > > > > > > enable MMC in SPL by default, if MMC =
is enabled in U-Boot proper. We
> > > > > > > > > > > > > > > > > > > may also want to share values between=
 phases, such as TEXT_BASE. We
> > > > > > > > > > > > > > > > > > > can do this easily today, just by add=
ing Kconfig rules.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I agree with a through c and for d ther=
e are likely some cases even if
> > > > > > > > > > > > > > > > > > I'm not sure TEXT_BASE is a good exampl=
e. But I'm not sure it's as
> > > > > > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > OK. No, TEXT_BASE is not a great example =
in my book either. But it is
> > > > > > > > > > > > > > > > > true that SPL needs to know U-Boot's text=
 base.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Here's another:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > >    default y if SPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > >    default SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Alternatively:
> > > > > > > > > > > > > > > > config SYS_MALLOC_LEN
> > > > > > > > > > > > > > > >    ... current default X if Y
> > > > > > > > > > > > > > > >    default 0x2800 if RCAR_GEN3 && !PPL
> > > > > > > > > > > > > > > >    default 0x2000 if IMX8MQ && !PPL
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > PPL means (in my book) that we have a PPL, i.=
e. it is always true. It
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And in my proposal you're choosing between PPL,=
 SPL, TPL, VPL.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > is the same today, with SPL. We have CONFIG_S=
PL_BUILD which indicates
> > > > > > > > > > > > > > > which build it is. If you are suggesting that=
 SPL means that this is
> > > > > > > > > > > > > > > the SPL build, then which thing tells us whet=
her or not we have an SPL
> > > > > > > > > > > > > > > build? I'm just a bit confused by this.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And we wouldn't have CONFIG_SPL_BUILD because w=
e would either be
> > > > > > > > > > > > > > configuring for SPL=3Dy or SPL=3Dn, there's no =
confusion anymore.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But how can I make the TPL value of SYS_MALLO=
C_F_LEN the same as the
> > > > > > > > > > > > > > > SPL one, with your scheme?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If your question is "how do I set an arbitrary =
but consistent value in
> > > > > > > > > > > > > > SPL and SPL" that's not enforced. But they also=
 shouldn't be arbitrary
> > > > > > > > > > > > > > and we should have sane defaults set in Kconfig=
, regardless of either
> > > > > > > > > > > > > > proposal. While I'm trying to not get lost in t=
he details today we have
> > > > > > > > > > > > > > 80 matches on "git grep SPL_.*_LEN=3D configs/"=
 and 2 for TPL and I would
> > > > > > > > > > > > > > encourage someone to verify those are needed. M=
y initial recollection is
> > > > > > > > > > > > > > that most of these are from when we bumped SYS_=
MALLOC_F_LEN or so up to
> > > > > > > > > > > > > > the commonly used default and had the few platf=
orms that didn't use the
> > > > > > > > > > > > > > new default previously switch to the old one.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > In other words, I don't think there's a problem=
 here that isn't solved
> > > > > > > > > > > > > > today, outside of either proposal.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So I'm still not understanding how you handle=
 Kconfig dependencies
> > > > > > > > > > > > > > > between phases with your scheme. Are you sayi=
ng you don't and they are
> > > > > > > > > > > > > > > not important?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Basically. The majority of the cases of:
> > > > > > > > > > > > > > config SPL_FOO
> > > > > > > > > > > > > >    default y if FOO
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > config TPL_FOO
> > > > > > > > > > > > > >    default y if SPL_FOO
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Just go away because FOO is already default y o=
r select/imply'd by
> > > > > > > > > > > > > > TARGET_BAR or ARCH_BAZ.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Also, is there a single Kconfig tree for U-Bo=
ot, or are you saying you
> > > > > > > > > > > > > > > want a different set of Kconfig files for eac=
h phase?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Just the Kconfig files we have today. Likely wi=
th less overall lines
> > > > > > > > > > > > > > since for example we could drop:
> > > > > > > > > > > > > > config SPL_FS_EXT4
> > > > > > > > > > > > > >         bool "Support EXT filesystems"
> > > > > > > > > > > > > >         select SPL_CRC16 if EXT4_WRITE
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Since we already have fs/ext4/Kconfig.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 1. Adjust kconf to generate separate =
autoconf.h files for each phase.
> > > > > > > > > > > > > > > > > > > These contain the values for each Kco=
nfig option for that phase. For
> > > > > > > > > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_=
spl.h is SPL's text base.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 2. Add a file to resolve the ambiguit=
y in (c) above, listing the
> > > > > > > > > > > > > > > > > > > Kconfig options which should not be e=
nabled/valid in any xPL build.
> > > > > > > > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new pref=
ix, meaning U-Boot proper (only),
> > > > > > > > > > > > > > > > > > > useful in rare cases. This indicates =
that the option applies only to
> > > > > > > > > > > > > > > > > > > U-Boot proper and is not defined in a=
ny xPL build. It is analogous to
> > > > > > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TP=
L'. Only a dozen of these are
> > > > > > > > > > > > > > > > > > > needed at present, basically to allow=
 access to the value for another
> > > > > > > > > > > > > > > > > > > phase, e.g. SPL wanting to find CONFI=
G_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > > > > > > > > the address to which U-Boot should be=
 loaded.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 4. There is no change to the existing=
 defconfig files, or 'make
> > > > > > > > > > > > > > > > > > > menuconfig', which works just as toda=
y, including dependencies between
> > > > > > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 5. (next) Expand the Kconfig language=
[2] to support declaring phases
> > > > > > > > > > > > > > > > > > > (SPL, TPL, etc.) and remove the need =
for duplicating options (DM_MMC,
> > > > > > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), =
so allowing an option to be
> > > > > > > > > > > > > > > > > > > declared once for any/all phases. We =
can then drop the file in 2
> > > > > > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > With this, maintaining Kconfig option=
s, Makefiles and adding a new
> > > > > > > > > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I think this will not make our life eas=
ier, it will make things harder.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I think what we've reached now shows th=
at Yamada-san was correct at the
> > > > > > > > > > > > > > > > > > time in saying that we were going down =
the wrong path with how we
> > > > > > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > You've mentioned this quite a few times o=
ver the years. Is there a
> > > > > > > > > > > > > > > > > reference to what he suggested we should =
do? Or perhaps it is what you
> > > > > > > > > > > > > > > > > have below.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I don't recall what he proposed instead, ju=
st that when it became clear
> > > > > > > > > > > > > > > > that I wanted to move from the "S:CONFIG_FO=
O.." syntax for how SPL was
> > > > > > > > > > > > > > > > handled to how we're doing it today, he tho=
ught that was the wrong
> > > > > > > > > > > > > > > > direction.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, IMO he was right about that.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MM=
C and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > > - Likely need to introduce a PPL symbol=
 as you suggest.
> > > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice stat=
ement when building a defconfig.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Good idea.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > - Split something like rockpro64-rk3399=
_defconfig in to
> > > > > > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpr=
o64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > > >   and add Makefile logic such that for =
X_defconfig as a build target but
> > > > > > > > > > > > > > > > > >   not configs/X_defconfig not existing,=
 we see if any of
> > > > > > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig=
 exist and we run a builds in
> > > > > > > > > > > > > > > > > >   subdirectories of our object director=
y, and then using binman combine
> > > > > > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > This means splitting the existing file in=
to a separate one for each
> > > > > > > > > > > > > > > > > phase. I believe that will be hard to man=
age.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Do you mean initially, or long term? Initia=
lly, it should be a bit of
> > > > > > > > > > > > > > > > shell scripting. The consolidation (ie most=
/all rk3399 having an
> > > > > > > > > > > > > > > > identical _spl_defconfig) can't be automate=
d. Long term I'm not sure it
> > > > > > > > > > > > > > > > would be any different. Most of the mainten=
ance is on resync'ing which
> > > > > > > > > > > > > > > > is automated.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Long term. How does 'make menuconfig' work in=
 this case? Won't you
> > > > > > > > > > > > > > > have to run it three times for SPL, TPL and P=
PL?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, you would run configure for what you're bu=
ilding. This is a good
> > > > > > > > > > > > > > thing as it will no longer be so confusing to h=
unt down where SPL or TPL
> > > > > > > > > > > > > > or VPL options for a specific thing reside.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >   - Maybe instead the Makefile logic ab=
ove we would parse X_defconfig
> > > > > > > > > > > > > > > > > >     and see if it's a different format =
of say PHASE:file to make it
> > > > > > > > > > > > > > > > > >     easier to say share a single TPL co=
nfig with all rk3399, have a few
> > > > > > > > > > > > > > > > > >     common SPL configs and then just a =
board specific PPL.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > This solves (a) by removing them entire=
ly. This solves (b) by removing
> > > > > > > > > > > > > > > > > > the ambiguity entirely (it will be enab=
led or not). As a bonus for (b)
> > > > > > > > > > > > > > > > > > we can switch everyone to IS_ENABLED(CO=
NFIG_FOO) and match up with the
> > > > > > > > > > > > > > > > > > Linux Kernel again. This solves (c) aga=
in by removing it entirely.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The scheme I propose removes a-c also. I =
should have made that clear.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Er, ok. That's not how it looked before, bu=
t I guess I'm just mistaken.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes I think so...it was a major goal to remov=
e this stuff. [1] [2]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > There is not a huge difference between yo=
ur scheme and mine. My
> > > > > > > > > > > > > > > > > question is, how do you handle (d)?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Well, either (d) isn't important as for exa=
mple MMC wasn't a good choice
> > > > > > > > > > > > > > > > in your proposal as virtually everyone "sel=
ect MMC" today or it's
> > > > > > > > > > > > > > > > handled more easily as my example above in =
SYS_MALLOC_LEN.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The way I see it, both schemes remove the=
 ambiguity. Mine retains a
> > > > > > > > > > > > > > > > > single deconfig file and a single 'make m=
enuconfig' for each board.
> > > > > > > > > > > > > > > > > Yours feels more like building independen=
t U-Boot images.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > It is explicitly building independent U-Boo=
t images, yes. With a wrapper
> > > > > > > > > > > > > > > > around "make all of the images for a given =
platform". So much of our
> > > > > > > > > > > > > > > > confusing and messy code is because we aren=
't doing that. And since most
> > > > > > > > > > > > > > > > modern SoCs can work as (mostly )generic SP=
L selects correct DTB for PPL
> > > > > > > > > > > > > > > > we really could have fewer overall build co=
nfigurations.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'd really like to see a generic aarch64 U-Bo=
ot for PPL, although it
> > > > > > > > > > > > > > > would be quite large with all the drivers. Pe=
rhaps we could start by
> > > > > > > > > > > > > > > having a generic Rockchip one, for example.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Still I don't see this being strongly related=
 to the discussion about
> > > > > > > > > > > > > > > these two different schemes.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Well, in your scheme how do we have say generic=
-aarch64_defconfig
> > > > > > > > > > > > > > function on either chromebook_bob or am62x_beag=
leplay_a53 ? In mine,
> > > > > > > > > > > > > > since everything is a separate build, generic-a=
arch64_defconfig has
> > > > > > > > > > > > > > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_RK3399=3Dy. A=
nd then
> > > > > > > > > > > > > > chromebook_bob_defconfig would say to use chrom=
ebook_bob_tpl_defconfig,
> > > > > > > > > > > > > > generic-rk3399_spl_defconfig and generic-aarch6=
4_defconfig. As a bonus
> > > > > > > > > > > > > > instead of am62x_beagleplay_a53_defconfig and
> > > > > > > > > > > > > > am62x_beagleplay_r5_defconfig we would have am6=
2x_beagleplay_defconfig
> > > > > > > > > > > > > > that would say to use the appropriate SPL/PPL f=
or R5, and appropriate
> > > > > > > > > > > > > > SPL/PPL for A53.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But the one big huge caveat I want to make here=
 is that "generic" images
> > > > > > > > > > > > > > are useful in some use cases (I'm sure all of t=
he regular F/OSS
> > > > > > > > > > > > > > distributions would love a single actually comm=
on PPL if they can fit
> > > > > > > > > > > > > > it) will strip things down. Whatever the IoT ed=
ge device closest to you
> > > > > > > > > > > > > > now really won't want to ship with all the plat=
forms enabled. Image size
> > > > > > > > > > > > > > still matters.
> > > > > > > > > > > > >
> > > > > > > > > > > > > OK thanks for the details. I think I have a reaso=
nable idea of what
> > > > > > > > > > > > > you are proposing, now. It would work, but is qui=
te radical, IMO.
> > > > > > > > > > > > > That's not necessarily a bad thing, but in my min=
d I see a sequencing
> > > > > > > > > > > > > possibility.
> > > > > > > > > > > > >
> > > > > > > > > > > > > A few points from my side:
> > > > > > > > > > > > >
> > > > > > > > > > > > > 1. I would love to see the defconfig files reduce=
 in size, with more
> > > > > > > > > > > > > and better defaults. One way to do this would be =
to enforce a maximum
> > > > > > > > > > > > > length. I added a feature to qconfig to allow fin=
ding common options
> > > > > > > > > > > > > among boards (the -i flag), but I'm not sure if m=
any people use it.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't see reducing defconfig size as important ho=
nestly. Should we
> > > > > > > > > > > > have more and better defaults? Yes. But almost ever=
ything is under 200
> > > > > > > > > > > > lines with the biggest (non-sandbox) ones being the=
 generic zynqmp
> > > > > > > > > > > > platform(s?).
> > > > > > > > > > >
> > > > > > > > > > > Agreed.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > 2. Generic boards is something I have been pushin=
g for years (in fact
> > > > > > > > > > > > > it is why I originally introduced devicetree), bu=
t I'm not seeing a
> > > > > > > > > > > > > lot of traction.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't think generic boards are universally helpfu=
l. Even if what I'm
> > > > > > > > > > > > proposing would allow for more of it, below the PPL=
 stage I'm not sure
> > > > > > > > > > > > it's both feasible enough and useful enough for pro=
duction. At the PPL
> > > > > > > > > > > > stage it still has to be small enough and not overl=
y burdensome. What we
> > > > > > > > > > > > talked about on the call yesterday about using more=
 multi-dtb images is
> > > > > > > > > > > > a step in the right direction, yes.
> > > > > > > > > > >
> > > > > > > > > > > Agreed. Anway, we can create separate targets for gen=
eric boards if we want to.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > 3. Iit seems that you want to remove all the 'if =
SPL' pieces and just
> > > > > > > > > > > > > rely on the current PPL configuration. But how wi=
ll that work? There
> > > > > > > > > > > > > are tons of features which don't work in SPL, or =
are not relevant, or
> > > > > > > > > > > > > have special 'small' versions. That is a *lot* of=
 Kconfig refactoring
> > > > > > > > > > > > > just to get something working, isn't it? With my =
scheme there is no
> > > > > > > > > > > > > Kconfig change needed initially - it can be done =
later as needed /
> > > > > > > > > > > > > desirable.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't think we would remove most "if SPL" cases. =
Taking part of the
> > > > > > > > > > > > current stanza for ROCKCHIP_RK3399 as an example:
> > > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > > >         select ARM64
> > > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > > >         select SPL
> > > > > > > > > > > >         select SPL_ATF
> > > > > > > > > > > >         select SPL_BOARD_INIT if SPL
> > > > > > > > > > > >         ...
> > > > > > > > > > > >         select SPL_CLK if SPL
> > > > > > > > > > > >         ...
> > > > > > > > > > > >         select CLK
> > > > > > > > > > > >         ...
> > > > > > > > > > > >         imply TPL_CLK
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > This would become:
> > > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > > >         select ARM64
> > > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > > >         select SPL_ATF if SPL # TBD: Does 'ATF' mak=
e sense outside of SPL?
> > > > > > > > > > > >         select BOARD_INIT if SPL # Not TPL_BOARD_IN=
IT here
> > > > > > > > > > > >         select CLK # imply was likely wrong before?=
 Would need to check
> > > > > > > > > > > >         ...
> > > > > > > > > > >
> > > > > > > > > > > I was more talking about the large blocks of 'if SPL'=
 - e.g. we have
> > > > > > > > > > > common/spl/Kconfig and common/spl/Kconfig.tpl
> > > > > > > > > >
> > > > > > > > > > I would vastly reduce the contents within those 'if' bl=
ocks, but there
> > > > > > > > > > are still options that are xPL-centric without a PPL co=
unterpart, such
> > > > > > > > > > as SPL_ATF (I suspect, but if not I'm sure others).
> > > > > > > > > >
> > > > > > > > > > > But just the level of thought required in your small =
example above
> > > > > > > > > > > suggests it is a large effort.
> > > > > > > > > >
> > > > > > > > > > Yes, restructuring our Kconfig logic and then removing =
our xPL logic is
> > > > > > > > > > some work. So was, I suspect, all of what you did alrea=
dy.
> > > > > > > > > >
> > > > > > > > > > > > > 4. My scheme splits the config into separate file=
s. Yours makes the
> > > > > > > > > > > >
> > > > > > > > > > > > I don't see yours as splitting the configs in to se=
parate files, I see
> > > > > > > > > > > > it as generating some intermediate objects. The con=
figs don't change and
> > > > > > > > > > > > that's one of our problem areas.
> > > > > > > > > > >
> > > > > > > > > > > So you mean a big problem area is the current Kconfig?
> > > > > > > > > >
> > > > > > > > > > I mean it's a problem for users a board developers to m=
ake valid
> > > > > > > > > > configurations and update them as needed. Filesystems a=
re in the
> > > > > > > > > > filesystem menu, unless they're SPL and then it's all u=
nder the big SPL
> > > > > > > > > > menu.
> > > > > > > > > >
> > > > > > > > > > > Mind generates
> > > > > > > > > > > out to an include/generated/autoconf_xxx for each pha=
se. Yes they are
> > > > > > > > > > > intermediate files and auto-generated, but each 100% =
controls its
> > > > > > > > > > > phase, so there is no confusion and CONFIG_IS_ENABLED=
() / odd Makefile
> > > > > > > > > > > rules anymore.
> > > > > > > > > >
> > > > > > > > > > Yes, removing CONFIG_IS_ENABLED and $(PHASE_)/$(XPL_) f=
rom Makefiles is
> > > > > > > > > > good. But the intermediate files aren't going to help (=
nor hurt) any of
> > > > > > > > > > the problems themselves. If you're reading those to fig=
ure out a
> > > > > > > > > > problem, it's like when you're reading a .i file to fig=
ure out a
> > > > > > > > > > problem, it means you're already in a complex troubleso=
me spot.
> > > > > > > > > >
> > > > > > > > > > But I don't know that CONFIG_SPL_FS_FAT=3Dy means that =
CONFIG_FS_FAT=3Dy for
> > > > > > > > > > SPL builds leads to "no confusion". But I do think that=
 CONFIG_SPL=3Dy and
> > > > > > > > > > CONFIG_FS_FAT=3Dy does.
> > > > > > > > > >
> > > > > > > > > > > > > split earlier, at the Kconfig level. So it seems =
that we could go with
> > > > > > > > > > > > > my scheme to get us to a split config, then, afte=
r that, decide
> > > > > > > > > > > > > whether to move that split earlier to Kconfig its=
elf. The choices
> > > > > > > > > > > >
> > > > > > > > > > > > I don't think so. Yours makes things complicated by=
 making the build do
> > > > > > > > > > > > even more (and from the RFC, the implementation too=
ling diverges from
> > > > > > > > > > > > upstream).
> > > > > > > > > > >
> > > > > > > > > > > Yes it makes the kconf tool generate those separate f=
iles for each phase [3]
> > > > > > > > > > >
> > > > > > > > > > > > Mine makes things differently complicated by doing =
less for
> > > > > > > > > > > > most things, but needing some thought on how to kno=
w that say
> > > > > > > > > > > > chromebook_bob needs chromebook_bob_tpl_defconfig,
> > > > > > > > > > > > chromebook_bob_spl_defconfig and chromebook_bob_ppl=
_defconfig to be
> > > > > > > > > > > > built, before asking binman to go put things togeth=
er.
> > > > > > > > > > >
> > > > > > > > > > > Yours seems feasible in a fully Binman world, but giv=
en the difficulty
> > > > > > > > > > > we (or I) have completing a migration, I honestly don=
't believe this
> > > > > > > > > > > is feasible in today's U-Boot. The other problem is t=
hat it all has to
> > > > > > > > > >
> > > > > > > > > > I'm not 100% sure it's everything needs binman actually=
=2E Or even if we
> > > > > > > > > > do take this as a reason to push for more binman, it's =
just some trivial
> > > > > > > > > > types already handled in the Makefile that's missing.
> > > > > > > > > >
> > > > > > > > > > > be done at once. We need to rewrite the Kconfig and f=
lip over the
> > > > > > > > > > > board. Will we carry people with us? That is a huge r=
isk to the
> > > > > > > > > > > project IMO.
> > > > > > > > > >
> > > > > > > > > > I'm not sure, actually, that it couldn't be done in sta=
ges. We might
> > > > > > > > > > need a little bit of fakery around being able to just b=
uild SPL without
> > > > > > > > > > PPL in the interim.
> > > > > > > > > >
> > > > > > > > > > > Anyway, yes my schema makes the build do even more (w=
ith 400 lines of
> > > > > > > > > > > kconf additions and a patch that can likely be upstre=
amed). But
> > > > > > > > > > > otherwise, it is a one-off improvement, without any c=
hanges to the
> > > > > > > > > > > existing Kconfig.
> > > > > > > > > >
> > > > > > > > > > I thought Yamada-san rejected changes going in this dir=
ection before?
> > > > > > > > > > But either way, no it's not likely the final overburden=
 in terms of
> > > > > > > > > > divergence.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Yes. Masahiro will make his own decisions and I am confid=
ent he will
> > > > > > > > > reject any future changes I send
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > So my point is that we could go with the first part o=
f my scheme to
> > > > > > > > > > > resolve the 'medium' problems then decide which way t=
o continue after
> > > > > > > > > > > that. From your side you won't have lost anything tow=
ards where you
> > > > > > > > > > > want to head. The two options would then be:
> > > > > > > > > > >
> > > > > > > > > > > - exhance kconfig language to build in the notion of =
phases
> > > > > > > > > > > - split the defconfigs for each board, redo the Kconf=
ig rules and
> > > > > > > > > > > teach the build to combine images
> > > > > > > > > >
> > > > > > > > > > If things go down your proposed path instead, no, I don=
't see that as
> > > > > > > > > > making it meaningfully easier to go the way I proposed =
later. The only
> > > > > > > > > > commonality is dropping $(PHASE_)/$(XPL_)/etc and CONFI=
G_IS_ENABLED ->
> > > > > > > > > > IS_ENABLED. And (almost) all of that is a script'able c=
hange.
> > > > > > > > >
> > > > > > > > > To be frank, the difference is that I have actually put i=
n the work to
> > > > > > > > > try this. It is more than 50 and perhaps as many as 100 p=
atches. Quite
> > > > > > > > > difficult work. Honestly, compared to that, the logic cha=
nges are not
> > > > > > > > > that large.
> > > > > > > > >
> > > > > > > > > That is why I believe this work is a prerequisite for bot=
h schemes
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > > would then be to use your scheme (Kconfig refacto=
ring, splitting
> > > > > > > > > > > > > defconfigs and some rework), or to do my scheme (=
which would require
> > > > > > > > > > > > > enhancing the Kconfig language a bit just for U-B=
oot and some optional
> > > > > > > > > > > > > rework over time). Both schemes would need a smal=
l amount of
> > > > > > > > > > > > > build-logic changes, but I'm not sure yet what th=
at would look like.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Does that sound right?
> > > > > > > > > > > >
> > > > > > > > > > > > With what I said above, yes I think we're closer at=
 least to
> > > > > > > > > > > > understanding each other.
> > > > > > > > > > >
> > > > > > > > > > > Yes.
> > > > > > > > > >
> > > > > > > > > > Well, with that, what now?
> > > > > > > > > >
> > > > > > > > > > What makes the current situation untenable is VPL. And =
I gather I
> > > > > > > > > > haven't convinced you to put that on hold long enough t=
o instead rework
> > > > > > > > > > how we build things, have I?
> > > > > > > > >
> > > > > > > > > Which VPL thing?
> > > > > > > >
> > > > > > > > That it exists. When it was just SPL, it's manageable. With=
 TPL, well,
> > > > > > > > it was supposed to be tiny and so just a few more things. A=
nd with VPL,
> > > > > > > > that makes 4. It's too much. Something needs to be done. Fo=
ur times is
> > > > > > > > too many. If solving Marek's desire for PSCI-from-U-Boot me=
ans we need
> > > > > > > > number 5 that becomes even worse (and I also suspect that's=
 a case of
> > > > > > > > one build covers the SoC or family of SoCs depending on har=
dware
> > > > > > > > changes).
> > > > > > >
> > > > > > > Yes, that's why I took on this effort a few years back.
> > > > > > >
> > > > > > > >
> > > > > > > > > You have convinced me that you have a solution. It makes =
a lot more
> > > > > > > > > sense to me than previously and it may be that it is bett=
er in the
> > > > > > > > > end. For example, with VBE it I would make a lot of sense=
 to build 20
> > > > > > > > > boards as just TPL and use a generic rock chip board for =
everything
> > > > > > > > > else. That would be a lot tidier with your scheme. It is =
very hard to
> > > > > > > > > predict the future and VBE is still not finished, some tw=
o years in.
> > > > > > > > >
> > > > > > > > > I don't want to be tied to your scheme today though.
> > > > > > > > >
> > > > > > > > > So if you can accept my going ahead with 1-4 and helping =
me with that,
> > > > > > > > > then we can stop and discuss which way to go, perhaps by =
prototyping
> > > > > > > > > the two options?
> > > > > > > >
> > > > > > > > I want to start by saying I do appreciate you put in a lot =
of work in
> > > > > > > > this direction already, and I do see some of the end goals =
it achieves
> > > > > > > > as being important, and I'm glad you see my idea has some g=
ood parts
> > > > > > > > too.
> > > > > > > >
> > > > > > > > I want to figure out how to move forward on this problem. M=
y other part
> > > > > > > > of this thread, this morning, was also part of me looking h=
arder, again,
> > > > > > > > at the RFC series you posted before. And that's where I sti=
ll have large
> > > > > > > > reservations. There are *so* *many* symbols we need to now =
have 4
> > > > > > > > variants of, instead of 1 variant of. Take:
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2023021223=
1638.1134219-58-sjg@chromium.org/
> > > > > > > > for example. It adds SPL_PARTITION_TYPE_GUID but we include=
 <part.h> in
> > > > > > > > files built in TPL (and likely VPL) so aren't we going to n=
eed that
> > > > > > > > every time? And with a quick size-check on pinebook-pro-rk3=
399 it looks
> > > > > > > > like it's not working as intended either? I checked and par=
t_get_info
> > > > > > > > shrinks because CONFIG_PARTITION_TYPE_GUID is not set, or r=
ather:
> > > > > > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > > > > >                 info->type_guid[0] =3D 0;
> > > > > > > > #endif
> > > > > >
> > > > > > Oh, I get it now. Previously CONFIG_PARTITION_TYPE_GUID=3Dy but=
 now
> > > > > > CONFIG_SPL_PARTITION_TYPE_GUID=3Dn and while I'm not sure that'=
s a good
> > > > > > thing I see what happened. And now I see my problem from yester=
day
> > > > > > morning was similar but different.
> > > > > >
> > > > > > > > is not true and checked. And I can't see why. And there's o=
ther size
> > > > > > > > reductions (this time in tpl) on pinebook-pro-rk3399 that I=
 didn't dig
> > > > > > > > in to more, but wasn't that symbol:
> > > > > > > >                tpl-u-boot-tpl: add: 0/-4, grow: 0/0 bytes: =
0/-344 (-344)
> > > > > > > >                  function                                  =
 old     new   delta
> > > > > > > >                  dev_get_uclass_plat                       =
  12       -     -12
> > > > > > > >                  simple_bus_post_bind                      =
  92       -     -92
> > > > > > > >                  _u_boot_list_2_uclass_driver_2_simple_bus =
    120       -    -120
> > > > > > > >                  _u_boot_list_2_driver_2_simple_bus        =
 120       -    -120
> > > > > > > >
> > > > > > > > And I'm not bringing this up to badger you about bugs in an=
 RFC series
> > > > > > > > (it's RFC, there's bugs) but rather because I think it high=
lights some
> > > > > > > > core issues with the approach as implemented.
> > > > > > >
> > > > > > > But surely you can see that both schemes have exactly the sam=
e issues?
> > > > > > >
> > > > > > > My point is that the work to tidy up things and then get to a=
 'clean'
> > > > > > > source tree and Makefiles is the hard bit here and has to be =
done with
> > > > > > > both schemes.
> > > > > > >
> > > > > > > Just let me know which way you want to go. I don't have anyth=
ing ready
> > > > > > > to send, but I could probably drag it over the line before to=
o long,
> > > > > > > if you are keen.
> > > > > >
> > > > > > Once I figured out what was the cause of the problems I saw in =
the RFC,
> > > > > > I had to rewrite this a few times. Your approach needs even mor=
e symbols
> > > > > > added than were in the RFC, and the newly added symbols need fu=
rther
> > > > > > auditing to make sure we have the same behavior as today at lea=
st by
> > > > > > default.
> > > > >
> > > > > This is the idea that we need to clean up a, b and c. Your scheme=
 is
> > > > > the same in this respect. If we have CONFIG_FOO today, then your
> > > > > scheme may need that duplicated to each defconfig file. Either you
> > > > > resolve the ambiguity or don't. But if you do, then you have to a=
dd
> > > > > symbols, with both schemes.
> > > >
> > > > There is minimal pain in saying a defconfig needs to list CONFIG_FOO
> > > > there is pain in saying that we need to list
> > > > config PARTITION_TYPE_GUID
> > > > ...
> > > > config SPL_PARTITION_TYPE_GUID
> > > > ...
> > > > config TPL_PARTITION_TYPE_GUID
> > > > ...
> > > > config VPL_PARTITION_TYPE_GUID
> > > > ...
> > > >
> > > > In what I'm saying it's not generally an issue because:
> > > > $ git grep -l PARTITION_TYPE_GUID configs | wc -l
> > > > 21
> > > >
> > > > And we don't have to do additional upkeep on having N symbols.
> > >
> > > Well we only need to add those extra symbols if 1) we want that
> > > feature in a particular xPL, *and* 2) we don't want it everywhere.
> >
> > Yes, and the problem is adding more of them. Again, we would need to
> > duplicate drivers/usb/gadget/Kconfig with your scheme.
> >
> > > There is nothing in my scheme which requires us to add options that
> > > don't currently exist...but there is a problem if some code uses
> > > CONFIG_IS_ENABLED(FOO) today and some code uses IS_ENABLED(FOO). My
> >
> > That's good because that wasn't (how it seemed?) previously.
> >
> > > conf_nospl file helps with that and avoids changing Kconfig. But
> > > again, if we are using both, then who knows what it means today, and
> > > I'd like to clean it up.
> >
> > What we have today, with respect to CONFIG_IS_ENABLED(...) /
> > IS_ENABLED(...) is clearer than IS_ENABLED(CONFIG_FOO) that is really
> > checking for CONFIG_SPL_FOO or CONFIG_VPL_FOO if it's in SPL or VPL.
> > It's easy to get *wrong* yes, but it's also clear. You're checking for
> > what it says.
> >
> > > > > > On the one hand, this is at least a well defined technical
> > > > > > problem and if you do the language extension *first* the code c=
hanges
> > > > > > aren't so bad.
> > > > >
> > > > > There are no significant Kconfig changes in my scheme, other than=
 the
> > > > > conf_nospl file. The language extension is quite separate.
> > > >
> > > > $ git diff pre-RFC-migrate-to-split-config..RFC-migrate-to-split-co=
nfig
> > > > \
> > > >         | filterdiff -i "a/*/Kconfig" | diffstat -p1 | tail -n 1
> > > >  25 files changed, 316 insertions(+), 3 deletions(-)
> > > >
> > > > And that is largely duplication of existing symbols. And again, it
> > > > wasn't enough duplication.
> > >
> > > I wonder if that is stuff that was already applied? Here is what I ha=
ve today.
> > >
> > > $ glo ci/master..splg4  | filterdiff -i "a/*/Kconfig" | diffstat -p1 =
| tail -n 1
> > >  0 files changed
> > >
> > > You can use the u-boot-dm/splg-working tree to see the original
> > > version. From memory, the splc tree is very old and was mostly applied
> > > or dropped.
> >
> > The splc-working tree is the RFC you pointed at earlier and so yes, what
> > I was comparing with. If you were able to drop some of the problems,
> > that's good.
> >
> > > > > > But for the user running menuconfig / etc? That's not
> > > > > > going to be pretty. And we still won't have fixed the problems =
like "why
> > > > > > is TPL even trying to build DWC3?" without reworking more symbo=
ls.
> > > > > >
> > > > > > So I don't think this is the right approach as it doesn't reduce
> > > > > > confusion and may increase it (why do I need to set
> > > > > > CONFIG_SPL_PARTITION_TYPE_GUID when the code checks for
> > > > > > CONFIG_PARTITION_TYPE_GUID?
> > > > >
> > > > > Because it is an SPL build...I actually think that makes a lot of
> > > > > sense. You just need to understand that CONFIG_SPL_ means the SPL
> > > > > build, which in fact is what we have been using for years.
> > > >
> > > > And it's no longer clear in the code, is the problem.
> > > >
> > > > >
> > > > > > But why is CONFIG_SPL_FRAMEWORK still there?
> > > > >
> > > > > Not relevant to the discussion, IMO.
> > > >
> > > > It's an example symbol. Why does the code have:
> > > >
> > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > ...
> > > > #endif
> > > >
> > > > And that's true for SPL builds. But the code also still has:
> > > > #ifdef CONFIG_SPL_FRAMEWORK
> > > > ...
> > > > #endif
> > > >
> > > > Which is only true for CONFIG_SPL_FRAMEWORK being set.
> > >
> > > OK I think I understand your question. The tools work by identifying
> > > options which are in PPL and may or not be in other builds. There is
> > > no CONFIG_FRAMEWORK so all of this migration doesn't apply.
> >
> > No, you entirely misunderstand me. I am not talking about the tool. I am
> > talking about the developer.
> >
> > > If there were a CONFIG_IS_ENABLED(FRAMEWORK) or a CONFIG_FRAMEWORK
> > > then the discussion would be different.
> > >
> > > BTW, I wonder if we could drop that symbol, or switch it around so
> > > that boards which don't use it have to set CONFIG_SPL_STRANGE or
> > > similar.
> >
> > Touching the PowerPC TPL/SPL stuff is very low on the priority list. If
> > you want to file an issue for it, please do. But that (roughly) is why
> > there's SPL_FRAMEWORK.
> >
> > > > > > Oh..). The main thing it does is drop $(PHASE_) and I honestly =
think
> > > > > > that's more confusing. We still have one build where we need to=
 do or
> > > > > > not do different things for FOO && PPL, FOO && SPL, etc but the=
 code
> > > > > > just references CONFIG_FOO but doesn't always mean CONFIG_FOO=
=3Dy/n in the
> > > > > > .config / defconfig.
> > > > >
> > > > > Yes, that's the conf_nospl file which I have dealt with.
> > > >
> > > > OK? My point is that the code is now more confusing, not less confu=
sing.
> > > > Because the code says CONFIG_PARTITION_TYPE_GUID. Not
> > > > CONFIG_SPL_PARTITION_TYPE_GUID. And not IS_ENABLED(PARTITION_TYPE_G=
UID)
> > > > which is at least a hint that one needs to look harder, and oh,
> > > > CONFIG_SPL_PARTITION_TYPE_GUID maybe matches somehow.
> > >
> > > If you are saying that it is better to have CONFIG_IS_ENABLED(FOO),
> > > IS_ENABLED(CONFIG_FOO), obj-$(CONFIG_$(PHASE_)FOO) etc., then I don't
> > > agree, sorry. That is problems a-c in my original proposal and my
> > > understanding is that both our approaches resolve this problem.
> > >
> > > Otherwise, you've just lost me and we should probably give up on this=
 point.
> >
> > Yes, I am saying that what we have today is less confusing than what you
> > are proposing. Because with your proposal:
> >
> > obj-$(CONFIG_FS_FAT) +=3D fat/
> >
> > Can refer to CONFIG_SPL_FS_FAT, CONFIG_FS_FAT or CONFIG_VPL_FS_FAT. That
> > is not good for humans.
>=20
> Let's just stop on this point. We seem to be going backwards. Now you
> are saying that you *want* to keep:
>=20
> a. The $(PHASE_) stuff in Makefiles
> b. The CONFIG_xxx / CONFIG_IS_ENABLED(xxx) split
>=20
> and you believe that
>=20
> c. the ambiguity I mentioned with CONFIG_FOO
>=20
> are all actually a good thing?

No. I'm saying that what we have today is LESS confusing than your
proposal in splc-working. I can't evaluate splg-working because it
doesn't work enough to be clear if it does or doesn't still solve all
the problems that splc-working does. Various things don't build anymore
in splg-working and T2080RDB_NAND as a first example (as the powerpc
part of the world build failed first) has massive size changes.

I do not like splc-working, but splc-working is a few bugs away from 1:1
functional binaries from before your changes.

I do not like what we have today because it's tricky to get things
right. But the macros are visible in the code / Makefiles so humans
still find things.

--=20
Tom

--EyFOklre93JQj1Gm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmev6lcACgkQFHw5/5Y0
tywViAv/RcY267ZsEYOS61RLaWluOd22dQkdPNVoA01cnfML1nxj/THV5asr2enC
XvDJHu+7CpI0Bc7NiwgH8vpzRx7jHwfocrqIadM/ErtAQXOfL1T9HRIjPqVWaU8e
ozWOnMoG/mFG+uZhaaoSjjmldqtEw50u70Ke8LZep+aFA6uEW4s5Wtg22EG+vahH
cEV24kJvmY+cr6/4pUEGSYJeALCG1lkVuiGoB+Cno48YI9g7qSvkw4NocAGksl6j
aCECqNGUX+SHgmuZFiitFqZr0RmRO/Sqpfh5P+pmMVkWuNteoA6zO4LsEyk2tTvz
zvRvcNAGNL8gKGWw3k0VREyBpl5DOoGya/c6cORfAP9eJ5v3EQqMbG3n7BnnSt20
gYdGwWR5ykxguB8AW4fzi5x0NEgazmpE5fyxEpSNalb4tjLsHS5AH+aadfC1f8u2
YQoZVEDVlJqEFAri/Yvx68u0L8UZPvJJWKh/3Ok4MChCSRHYv5bflzjfsk2fe7RX
i10StsKo
=j47k
-----END PGP SIGNATURE-----

--EyFOklre93JQj1Gm--
