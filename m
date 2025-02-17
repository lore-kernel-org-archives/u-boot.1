Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8EAC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 19:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E53A80BAE;
	Mon, 17 Feb 2025 20:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I7HrfTrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F54807F1; Mon, 17 Feb 2025 20:18:38 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932378083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 20:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-221050f3f00so40979355ad.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739819912; x=1740424712; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5fgIcxPAfLLI8J7ErHn/rAEAP23MOcf9qSY7R8ZJKw8=;
 b=I7HrfTrXDZ0oItrkUGbTm5vTANyRTW/TBGl5QYL6oA+6ekx3oOTfuPENrht878i/dN
 5q+EXFZev3DBIM1Z0pSdDJH4BWCBeVFXvFRwfSqS8ioV4SLKJUnsCxHqeTwYN4ZpLxQK
 WXtMxHkyVStU37lC4WRdhEcVmal4J1eCd3eOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739819912; x=1740424712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fgIcxPAfLLI8J7ErHn/rAEAP23MOcf9qSY7R8ZJKw8=;
 b=CntHwpHbxbjsHTw4iX8kkIq1AFSdKcCLVy2kJmgxSa8aqCtTCtAgY6CTMHXlJDAAsZ
 KwDagom2oq5jpQqM/S/HgMW7Zo+uCu/kB/8Bd78vWidsL+8gw5H3NrCrjL+GnX5x9OXg
 FPPkBFlvT/tPhOx75jjMGCdIVwSFhnmF8AVkFsOcwEJAzAwoE8uSkbQW34wETDvvfg0A
 uE1+uuILNzXCtx0AGKthxAFTG7vsfBAIhaQjaB8XWSPjWsT2u1+XW0Rt/gIqrsUhh5Em
 pGJWK7FNj3tBurVT+D9filPyZoHa/TSzveWgRt9EwnqcnPqMsamK8qWOGAZrkxoWILnG
 YdRA==
X-Gm-Message-State: AOJu0Ywxf1usw9VxulFFTrap+bvKlHf1LHQv+WOU5kMfdYTfI53pkCgF
 6G2qD/3ImiarcLs6A9/Pnx9SEQoXKzaVYAYmSPMl/nbdAP2+2hfbvYuVLYxeeLtu5Or/wRokiHX
 E
X-Gm-Gg: ASbGnctA1epr3wYGGH9abJ9+HwT4k6l8PJVDbH6nJfPDVYftl93qZ62D0cz6dDKxpAc
 5uwZsjeh0NFlMhDROlavrc7O/Y8H7WpnChIRAR6zBa5/LcigTHl36Jl7EYS+sBeY5DPY5upB8Te
 fjs8zjbPSgXxDzLOVh3UeAc5D57zGjgre/IWVMU8GcSzT7kMSShbhoTgmJEa2eKzBtxaaLsF2ZZ
 B2pVmn6yGclneX9QlmpDCL8XLLDvAHau07jrr2zbu1BHpnRfZzctCg6glqfWJUSt00aNGE3mCSv
 4kD4NfNabNppnw==
X-Google-Smtp-Source: AGHT+IG5XJyFCzktj4+X/3KoOD0XDUHl9P7lvcEUELDbK2HIiHC80DxK3OhXKOrcyout62diW8pCng==
X-Received: by 2002:a05:6a00:3c88:b0:730:9752:d034 with SMTP id
 d2e1a72fcca58-73261778d10mr15679386b3a.1.1739819910039; 
 Mon, 17 Feb 2025 11:18:30 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73279a33c62sm2790523b3a.59.2025.02.17.11.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:18:29 -0800 (PST)
Date: Mon, 17 Feb 2025 13:18:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250217191826.GU1233568@bill-the-cat>
References: <20250214211652.GI1233568@bill-the-cat>
 <CAFLszTi=abpaGi0CnnNoKYsT9M0H-9xrGaQtdLORvM8J7usX1Q@mail.gmail.com>
 <20250214234354.GJ1233568@bill-the-cat>
 <CAFLszTghcMz1mnu_jZOi9=TQpTgjyOQV-4sT=p=Q=dUBo3pQ_Q@mail.gmail.com>
 <20250215011403.GK1233568@bill-the-cat>
 <CAFLszTiNMr085kpwrtWrhJv6pMRd2_ODX0wmUNvW+D7EY8ighw@mail.gmail.com>
 <20250217141957.GK1233568@bill-the-cat>
 <CAFLszThS3DyApKjuNHWE=7Xwh_DZEHPeBDOwutuziSzsZFdjXw@mail.gmail.com>
 <20250217155911.GN1233568@bill-the-cat>
 <CAFLszTjD70VpjO4UXFEAPU7ooCe0P3Q8B1XRvkatbRRJtqVZSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lsMGGKIo6ssuUXl1"
Content-Disposition: inline
In-Reply-To: <CAFLszTjD70VpjO4UXFEAPU7ooCe0P3Q8B1XRvkatbRRJtqVZSg@mail.gmail.com>
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


--lsMGGKIo6ssuUXl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 11:03:28AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 08:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 08:08:58AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Feb 2025 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 14, 2025 at 06:43:30PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 14 Feb 2025 at 18:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 14, 2025 at 04:52:04PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 14 Feb 2025 at 16:43, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 14, 2025 at 03:46:30PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 14 Feb 2025 at 14:16, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Feb 14, 2025 at 12:48:33PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Feb 14, 2025, 07:39 Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Feb 13, 2025 at 05:09:47PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, 13 Feb 2025 at 15:59, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Feb 13, 2025 at 02:57:59PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, Feb 13, 2025, 11:03 Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Feb 13, 2025 at 05:50:13AM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 15:58, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Wed, Feb 12, 2025 at 01:05:11PM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 11:35, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Wed, Feb 12, 2025 at 10:41:45AM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 09:40, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:54:2=
1PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Tue, 11 Feb 2025 at 14:22,=
 Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:=
03:20AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > I just wanted to send a n=
ote to (re-)introduce my ideas[1] for the
> > > > > > > > > > > > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > A recent series introduce=
d 'xPL' as the name for the various
> > > > > > > > > > > > > > > > > > > > > > > > > pre-U-Boot phases, so now=
 CONFIG_XPL_BUILD means that this is any xPL
> > > > > > > > > > > > > > > > > > > > > > > > > phase and CONFIG_SPL mean=
s this really is the SPL phase, not TPL. We
> > > > > > > > > > > > > > > > > > > > > > > > > still use filenames and f=
unction naming which uses 'spl', but could
> > > > > > > > > > > > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > The major remaining probl=
em IMO is that it is quite tricky and
> > > > > > > > > > > > > > > > > > > > > > > > > expensive (in terms of ti=
me) to add a new phase. We also have some
> > > > > > > > > > > > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_)=
 rules in the Makefile are visually ugly and
> > > > > > > > > > > > > > > > > > > > > > > > > can be confusing, particu=
larly when combined with ifdef and ifneq
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > b. We have both CONFIG_IS=
_ENABLED() and IS_ENABLED() and they mean
> > > > > > > > > > > > > > > > > > > > > > > > > different things. For any=
 given option, some code uses one and some
> > > > > > > > > > > > > > > > > > > > > > > > > the other, depending on w=
hat problems people have met along the way.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > c. An option like CONFIG_=
FOO is ambiguous, in that it could mean that
> > > > > > > > > > > > > > > > > > > > > > > > > the option is enabled in =
one or more xPL phases, or just in U-Boot
> > > > > > > > > > > > > > > > > > > > > > > > > proper. The only way to k=
now is to look for $(PHASE_) etc. in the
> > > > > > > > > > > > > > > > > > > > > > > > > Makefiles and CONFIG_IS_E=
NABLED() in the code. This is very confusing
> > > > > > > > > > > > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > d. We need to retain an i=
mportant feature: options from different
> > > > > > > > > > > > > > > > > > > > > > > > > phases can depend on each=
 other. As an example, we might want to
> > > > > > > > > > > > > > > > > > > > > > > > > enable MMC in SPL by defa=
ult, if MMC is enabled in U-Boot proper. We
> > > > > > > > > > > > > > > > > > > > > > > > > may also want to share va=
lues between phases, such as TEXT_BASE. We
> > > > > > > > > > > > > > > > > > > > > > > > > can do this easily today,=
 just by adding Kconfig rules.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > I agree with a through c an=
d for d there are likely some cases even if
> > > > > > > > > > > > > > > > > > > > > > > > I'm not sure TEXT_BASE is a=
 good example. But I'm not sure it's as
> > > > > > > > > > > > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > OK. No, TEXT_BASE is not a gr=
eat example in my book either. But it is
> > > > > > > > > > > > > > > > > > > > > > > true that SPL needs to know U=
-Boot's text base.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Here's another:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > > > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > > > > > > > >    default y if SPL_SYS_MALLO=
C_F
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > > > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > > > > > > > >    default SPL_SYS_MALLOC_F_L=
EN
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Alternatively:
> > > > > > > > > > > > > > > > > > > > > > config SYS_MALLOC_LEN
> > > > > > > > > > > > > > > > > > > > > >    ... current default X if Y
> > > > > > > > > > > > > > > > > > > > > >    default 0x2800 if RCAR_GEN3 =
&& !PPL
> > > > > > > > > > > > > > > > > > > > > >    default 0x2000 if IMX8MQ && =
!PPL
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > PPL means (in my book) that we ha=
ve a PPL, i.e. it is always true. It
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > And in my proposal you're choosing =
between PPL, SPL, TPL, VPL.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > is the same today, with SPL. We h=
ave CONFIG_SPL_BUILD which indicates
> > > > > > > > > > > > > > > > > > > > > which build it is. If you are sug=
gesting that SPL means that this is
> > > > > > > > > > > > > > > > > > > > > the SPL build, then which thing t=
ells us whether or not we have an SPL
> > > > > > > > > > > > > > > > > > > > > build? I'm just a bit confused by=
 this.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > And we wouldn't have CONFIG_SPL_BUI=
LD because we would either be
> > > > > > > > > > > > > > > > > > > > configuring for SPL=3Dy or SPL=3Dn,=
 there's no confusion anymore.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > But how can I make the TPL value =
of SYS_MALLOC_F_LEN the same as the
> > > > > > > > > > > > > > > > > > > > > SPL one, with your scheme?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > If your question is "how do I set a=
n arbitrary but consistent value in
> > > > > > > > > > > > > > > > > > > > SPL and SPL" that's not enforced. B=
ut they also shouldn't be arbitrary
> > > > > > > > > > > > > > > > > > > > and we should have sane defaults se=
t in Kconfig, regardless of either
> > > > > > > > > > > > > > > > > > > > proposal. While I'm trying to not g=
et lost in the details today we have
> > > > > > > > > > > > > > > > > > > > 80 matches on "git grep SPL_.*_LEN=
=3D configs/" and 2 for TPL and I would
> > > > > > > > > > > > > > > > > > > > encourage someone to verify those a=
re needed. My initial recollection is
> > > > > > > > > > > > > > > > > > > > that most of these are from when we=
 bumped SYS_MALLOC_F_LEN or so up to
> > > > > > > > > > > > > > > > > > > > the commonly used default and had t=
he few platforms that didn't use the
> > > > > > > > > > > > > > > > > > > > new default previously switch to th=
e old one.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > In other words, I don't think there=
's a problem here that isn't solved
> > > > > > > > > > > > > > > > > > > > today, outside of either proposal.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > So I'm still not understanding ho=
w you handle Kconfig dependencies
> > > > > > > > > > > > > > > > > > > > > between phases with your scheme. =
Are you saying you don't and they are
> > > > > > > > > > > > > > > > > > > > > not important?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Basically. The majority of the case=
s of:
> > > > > > > > > > > > > > > > > > > > config SPL_FOO
> > > > > > > > > > > > > > > > > > > >    default y if FOO
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > config TPL_FOO
> > > > > > > > > > > > > > > > > > > >    default y if SPL_FOO
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Just go away because FOO is already=
 default y or select/imply'd by
> > > > > > > > > > > > > > > > > > > > TARGET_BAR or ARCH_BAZ.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Also, is there a single Kconfig t=
ree for U-Boot, or are you saying you
> > > > > > > > > > > > > > > > > > > > > want a different set of Kconfig f=
iles for each phase?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Just the Kconfig files we have toda=
y. Likely with less overall lines
> > > > > > > > > > > > > > > > > > > > since for example we could drop:
> > > > > > > > > > > > > > > > > > > > config SPL_FS_EXT4
> > > > > > > > > > > > > > > > > > > >         bool "Support EXT filesyste=
ms"
> > > > > > > > > > > > > > > > > > > >         select SPL_CRC16 if EXT4_WR=
ITE
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Since we already have fs/ext4/Kconf=
ig.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > 1. Adjust kconf to genera=
te separate autoconf.h files for each phase.
> > > > > > > > > > > > > > > > > > > > > > > > > These contain the values =
for each Kconfig option for that phase. For
> > > > > > > > > > > > > > > > > > > > > > > > > example CONFIG_TEXT_BASE =
in autoconf_spl.h is SPL's text base.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > 2. Add a file to resolve =
the ambiguity in (c) above, listing the
> > > > > > > > > > > > > > > > > > > > > > > > > Kconfig options which sho=
uld not be enabled/valid in any xPL build.
> > > > > > > > > > > > > > > > > > > > > > > > > There are around 200 of t=
hese.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL a=
s a new prefix, meaning U-Boot proper (only),
> > > > > > > > > > > > > > > > > > > > > > > > > useful in rare cases. Thi=
s indicates that the option applies only to
> > > > > > > > > > > > > > > > > > > > > > > > > U-Boot proper and is not =
defined in any xPL build. It is analogous to
> > > > > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'e=
nabled in TPL'. Only a dozen of these are
> > > > > > > > > > > > > > > > > > > > > > > > > needed at present, basica=
lly to allow access to the value for another
> > > > > > > > > > > > > > > > > > > > > > > > > phase, e.g. SPL wanting t=
o find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > > > > > > > > > > > > > > the address to which U-Bo=
ot should be loaded.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > 4. There is no change to =
the existing defconfig files, or 'make
> > > > > > > > > > > > > > > > > > > > > > > > > menuconfig', which works =
just as today, including dependencies between
> > > > > > > > > > > > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > 5. (next) Expand the Kcon=
fig language[2] to support declaring phases
> > > > > > > > > > > > > > > > > > > > > > > > > (SPL, TPL, etc.) and remo=
ve the need for duplicating options (DM_MMC,
> > > > > > > > > > > > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, V=
PL_DM_MMC), so allowing an option to be
> > > > > > > > > > > > > > > > > > > > > > > > > declared once for any/all=
 phases. We can then drop the file in 2
> > > > > > > > > > > > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > With this, maintaining Kc=
onfig options, Makefiles and adding a new
> > > > > > > > > > > > > > > > > > > > > > > > > phase should be considera=
bly easier.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > I think this will not make =
our life easier, it will make things harder.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > I think what we've reached =
now shows that Yamada-san was correct at the
> > > > > > > > > > > > > > > > > > > > > > > > time in saying that we were=
 going down the wrong path with how we
> > > > > > > > > > > > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > You've mentioned this quite a=
 few times over the years. Is there a
> > > > > > > > > > > > > > > > > > > > > > > reference to what he suggeste=
d we should do? Or perhaps it is what you
> > > > > > > > > > > > > > > > > > > > > > > have below.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I don't recall what he proposed=
 instead, just that when it became clear
> > > > > > > > > > > > > > > > > > > > > > that I wanted to move from the =
"S:CONFIG_FOO.." syntax for how SPL was
> > > > > > > > > > > > > > > > > > > > > > handled to how we're doing it t=
oday, he thought that was the wrong
> > > > > > > > > > > > > > > > > > > > > > direction.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Yes, IMO he was right about that.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL =
(so no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > > > > > > > > - Likely need to introduce =
a PPL symbol as you suggest.
> > > > > > > > > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a=
 choice statement when building a defconfig.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Good idea.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > - Split something like rock=
pro64-rk3399_defconfig in to
> > > > > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defc=
onfig
> > > > > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_spl_defc=
onfig rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > > > > > > > > >   and add Makefile logic su=
ch that for X_defconfig as a build target but
> > > > > > > > > > > > > > > > > > > > > > > >   not configs/X_defconfig n=
ot existing, we see if any of
> > > > > > > > > > > > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vp=
l}_defconfig exist and we run a builds in
> > > > > > > > > > > > > > > > > > > > > > > >   subdirectories of our obj=
ect directory, and then using binman combine
> > > > > > > > > > > > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > This means splitting the exis=
ting file into a separate one for each
> > > > > > > > > > > > > > > > > > > > > > > phase. I believe that will be=
 hard to manage.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Do you mean initially, or long =
term? Initially, it should be a bit of
> > > > > > > > > > > > > > > > > > > > > > shell scripting. The consolidat=
ion (ie most/all rk3399 having an
> > > > > > > > > > > > > > > > > > > > > > identical _spl_defconfig) can't=
 be automated. Long term I'm not sure it
> > > > > > > > > > > > > > > > > > > > > > would be any different. Most of=
 the maintenance is on resync'ing which
> > > > > > > > > > > > > > > > > > > > > > is automated.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Long term. How does 'make menucon=
fig' work in this case? Won't you
> > > > > > > > > > > > > > > > > > > > > have to run it three times for SP=
L, TPL and PPL?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Yes, you would run configure for wh=
at you're building. This is a good
> > > > > > > > > > > > > > > > > > > > thing as it will no longer be so co=
nfusing to hunt down where SPL or TPL
> > > > > > > > > > > > > > > > > > > > or VPL options for a specific thing=
 reside.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > >   - Maybe instead the Makef=
ile logic above we would parse X_defconfig
> > > > > > > > > > > > > > > > > > > > > > > >     and see if it's a diffe=
rent format of say PHASE:file to make it
> > > > > > > > > > > > > > > > > > > > > > > >     easier to say share a s=
ingle TPL config with all rk3399, have a few
> > > > > > > > > > > > > > > > > > > > > > > >     common SPL configs and =
then just a board specific PPL.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > This solves (a) by removing=
 them entirely. This solves (b) by removing
> > > > > > > > > > > > > > > > > > > > > > > > the ambiguity entirely (it =
will be enabled or not). As a bonus for (b)
> > > > > > > > > > > > > > > > > > > > > > > > we can switch everyone to I=
S_ENABLED(CONFIG_FOO) and match up with the
> > > > > > > > > > > > > > > > > > > > > > > > Linux Kernel again. This so=
lves (c) again by removing it entirely.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The scheme I propose removes =
a-c also. I should have made that clear.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Er, ok. That's not how it looke=
d before, but I guess I'm just mistaken.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Yes I think so...it was a major g=
oal to remove this stuff. [1] [2]
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > There is not a huge differenc=
e between your scheme and mine. My
> > > > > > > > > > > > > > > > > > > > > > > question is, how do you handl=
e (d)?
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Well, either (d) isn't importan=
t as for example MMC wasn't a good choice
> > > > > > > > > > > > > > > > > > > > > > in your proposal as virtually e=
veryone "select MMC" today or it's
> > > > > > > > > > > > > > > > > > > > > > handled more easily as my examp=
le above in SYS_MALLOC_LEN.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The way I see it, both scheme=
s remove the ambiguity. Mine retains a
> > > > > > > > > > > > > > > > > > > > > > > single deconfig file and a si=
ngle 'make menuconfig' for each board.
> > > > > > > > > > > > > > > > > > > > > > > Yours feels more like buildin=
g independent U-Boot images.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > It is explicitly building indep=
endent U-Boot images, yes. With a wrapper
> > > > > > > > > > > > > > > > > > > > > > around "make all of the images =
for a given platform". So much of our
> > > > > > > > > > > > > > > > > > > > > > confusing and messy code is bec=
ause we aren't doing that. And since most
> > > > > > > > > > > > > > > > > > > > > > modern SoCs can work as (mostly=
 )generic SPL selects correct DTB for PPL
> > > > > > > > > > > > > > > > > > > > > > we really could have fewer over=
all build configurations.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I'd really like to see a generic =
aarch64 U-Boot for PPL, although it
> > > > > > > > > > > > > > > > > > > > > would be quite large with all the=
 drivers. Perhaps we could start by
> > > > > > > > > > > > > > > > > > > > > having a generic Rockchip one, fo=
r example.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Still I don't see this being stro=
ngly related to the discussion about
> > > > > > > > > > > > > > > > > > > > > these two different schemes.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Well, in your scheme how do we have=
 say generic-aarch64_defconfig
> > > > > > > > > > > > > > > > > > > > function on either chromebook_bob o=
r am62x_beagleplay_a53 ? In mine,
> > > > > > > > > > > > > > > > > > > > since everything is a separate buil=
d, generic-aarch64_defconfig has
> > > > > > > > > > > > > > > > > > > > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_R=
K3399=3Dy. And then
> > > > > > > > > > > > > > > > > > > > chromebook_bob_defconfig would say =
to use chromebook_bob_tpl_defconfig,
> > > > > > > > > > > > > > > > > > > > generic-rk3399_spl_defconfig and ge=
neric-aarch64_defconfig. As a bonus
> > > > > > > > > > > > > > > > > > > > instead of am62x_beagleplay_a53_def=
config and
> > > > > > > > > > > > > > > > > > > > am62x_beagleplay_r5_defconfig we wo=
uld have am62x_beagleplay_defconfig
> > > > > > > > > > > > > > > > > > > > that would say to use the appropria=
te SPL/PPL for R5, and appropriate
> > > > > > > > > > > > > > > > > > > > SPL/PPL for A53.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > But the one big huge caveat I want =
to make here is that "generic" images
> > > > > > > > > > > > > > > > > > > > are useful in some use cases (I'm s=
ure all of the regular F/OSS
> > > > > > > > > > > > > > > > > > > > distributions would love a single a=
ctually common PPL if they can fit
> > > > > > > > > > > > > > > > > > > > it) will strip things down. Whateve=
r the IoT edge device closest to you
> > > > > > > > > > > > > > > > > > > > now really won't want to ship with =
all the platforms enabled. Image size
> > > > > > > > > > > > > > > > > > > > still matters.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > OK thanks for the details. I think I =
have a reasonable idea of what
> > > > > > > > > > > > > > > > > > > you are proposing, now. It would work=
, but is quite radical, IMO.
> > > > > > > > > > > > > > > > > > > That's not necessarily a bad thing, b=
ut in my mind I see a sequencing
> > > > > > > > > > > > > > > > > > > possibility.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > A few points from my side:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 1. I would love to see the defconfig =
files reduce in size, with more
> > > > > > > > > > > > > > > > > > > and better defaults. One way to do th=
is would be to enforce a maximum
> > > > > > > > > > > > > > > > > > > length. I added a feature to qconfig =
to allow finding common options
> > > > > > > > > > > > > > > > > > > among boards (the -i flag), but I'm n=
ot sure if many people use it.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I don't see reducing defconfig size as =
important honestly. Should we
> > > > > > > > > > > > > > > > > > have more and better defaults? Yes. But=
 almost everything is under 200
> > > > > > > > > > > > > > > > > > lines with the biggest (non-sandbox) on=
es being the generic zynqmp
> > > > > > > > > > > > > > > > > > platform(s?).
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Agreed.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 2. Generic boards is something I have=
 been pushing for years (in fact
> > > > > > > > > > > > > > > > > > > it is why I originally introduced dev=
icetree), but I'm not seeing a
> > > > > > > > > > > > > > > > > > > lot of traction.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I don't think generic boards are univer=
sally helpful. Even if what I'm
> > > > > > > > > > > > > > > > > > proposing would allow for more of it, b=
elow the PPL stage I'm not sure
> > > > > > > > > > > > > > > > > > it's both feasible enough and useful en=
ough for production. At the PPL
> > > > > > > > > > > > > > > > > > stage it still has to be small enough a=
nd not overly burdensome. What we
> > > > > > > > > > > > > > > > > > talked about on the call yesterday abou=
t using more multi-dtb images is
> > > > > > > > > > > > > > > > > > a step in the right direction, yes.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Agreed. Anway, we can create separate tar=
gets for generic boards if we want to.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 3. Iit seems that you want to remove =
all the 'if SPL' pieces and just
> > > > > > > > > > > > > > > > > > > rely on the current PPL configuration=
=2E But how will that work? There
> > > > > > > > > > > > > > > > > > > are tons of features which don't work=
 in SPL, or are not relevant, or
> > > > > > > > > > > > > > > > > > > have special 'small' versions. That i=
s a *lot* of Kconfig refactoring
> > > > > > > > > > > > > > > > > > > just to get something working, isn't =
it? With my scheme there is no
> > > > > > > > > > > > > > > > > > > Kconfig change needed initially - it =
can be done later as needed /
> > > > > > > > > > > > > > > > > > > desirable.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I don't think we would remove most "if =
SPL" cases. Taking part of the
> > > > > > > > > > > > > > > > > > current stanza for ROCKCHIP_RK3399 as a=
n example:
> > > > > > > > > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > > > > > > > > >         select ARM64
> > > > > > > > > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > > > > > > > > >         select SPL
> > > > > > > > > > > > > > > > > >         select SPL_ATF
> > > > > > > > > > > > > > > > > >         select SPL_BOARD_INIT if SPL
> > > > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > > > > >         select SPL_CLK if SPL
> > > > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > > > > >         select CLK
> > > > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > > > > >         imply TPL_CLK
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > This would become:
> > > > > > > > > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > > > > > > > > >         select ARM64
> > > > > > > > > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > > > > > > > > >         select SPL_ATF if SPL # TBD: Do=
es 'ATF' make sense outside of SPL?
> > > > > > > > > > > > > > > > > >         select BOARD_INIT if SPL # Not =
TPL_BOARD_INIT here
> > > > > > > > > > > > > > > > > >         select CLK # imply was likely w=
rong before? Would need to check
> > > > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I was more talking about the large blocks=
 of 'if SPL' - e.g. we have
> > > > > > > > > > > > > > > > > common/spl/Kconfig and common/spl/Kconfig=
=2Etpl
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I would vastly reduce the contents within t=
hose 'if' blocks, but there
> > > > > > > > > > > > > > > > are still options that are xPL-centric with=
out a PPL counterpart, such
> > > > > > > > > > > > > > > > as SPL_ATF (I suspect, but if not I'm sure =
others).
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > But just the level of thought required in=
 your small example above
> > > > > > > > > > > > > > > > > suggests it is a large effort.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, restructuring our Kconfig logic and th=
en removing our xPL logic is
> > > > > > > > > > > > > > > > some work. So was, I suspect, all of what y=
ou did already.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > 4. My scheme splits the config into s=
eparate files. Yours makes the
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I don't see yours as splitting the conf=
igs in to separate files, I see
> > > > > > > > > > > > > > > > > > it as generating some intermediate obje=
cts. The configs don't change and
> > > > > > > > > > > > > > > > > > that's one of our problem areas.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So you mean a big problem area is the cur=
rent Kconfig?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I mean it's a problem for users a board dev=
elopers to make valid
> > > > > > > > > > > > > > > > configurations and update them as needed. F=
ilesystems are in the
> > > > > > > > > > > > > > > > filesystem menu, unless they're SPL and the=
n it's all under the big SPL
> > > > > > > > > > > > > > > > menu.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Mind generates
> > > > > > > > > > > > > > > > > out to an include/generated/autoconf_xxx =
for each phase. Yes they are
> > > > > > > > > > > > > > > > > intermediate files and auto-generated, bu=
t each 100% controls its
> > > > > > > > > > > > > > > > > phase, so there is no confusion and CONFI=
G_IS_ENABLED() / odd Makefile
> > > > > > > > > > > > > > > > > rules anymore.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, removing CONFIG_IS_ENABLED and $(PHASE=
_)/$(XPL_) from Makefiles is
> > > > > > > > > > > > > > > > good. But the intermediate files aren't goi=
ng to help (nor hurt) any of
> > > > > > > > > > > > > > > > the problems themselves. If you're reading =
those to figure out a
> > > > > > > > > > > > > > > > problem, it's like when you're reading a .i=
 file to figure out a
> > > > > > > > > > > > > > > > problem, it means you're already in a compl=
ex troublesome spot.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > But I don't know that CONFIG_SPL_FS_FAT=3Dy=
 means that CONFIG_FS_FAT=3Dy for
> > > > > > > > > > > > > > > > SPL builds leads to "no confusion". But I d=
o think that CONFIG_SPL=3Dy and
> > > > > > > > > > > > > > > > CONFIG_FS_FAT=3Dy does.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > split earlier, at the Kconfig level. =
So it seems that we could go with
> > > > > > > > > > > > > > > > > > > my scheme to get us to a split config=
, then, after that, decide
> > > > > > > > > > > > > > > > > > > whether to move that split earlier to=
 Kconfig itself. The choices
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I don't think so. Yours makes things co=
mplicated by making the build do
> > > > > > > > > > > > > > > > > > even more (and from the RFC, the implem=
entation tooling diverges from
> > > > > > > > > > > > > > > > > > upstream).
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes it makes the kconf tool generate thos=
e separate files for each phase [3]
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Mine makes things differently complicat=
ed by doing less for
> > > > > > > > > > > > > > > > > > most things, but needing some thought o=
n how to know that say
> > > > > > > > > > > > > > > > > > chromebook_bob needs chromebook_bob_tpl=
_defconfig,
> > > > > > > > > > > > > > > > > > chromebook_bob_spl_defconfig and chrome=
book_bob_ppl_defconfig to be
> > > > > > > > > > > > > > > > > > built, before asking binman to go put t=
hings together.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yours seems feasible in a fully Binman wo=
rld, but given the difficulty
> > > > > > > > > > > > > > > > > we (or I) have completing a migration, I =
honestly don't believe this
> > > > > > > > > > > > > > > > > is feasible in today's U-Boot. The other =
problem is that it all has to
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm not 100% sure it's everything needs bin=
man actually. Or even if we
> > > > > > > > > > > > > > > > do take this as a reason to push for more b=
inman, it's just some trivial
> > > > > > > > > > > > > > > > types already handled in the Makefile that'=
s missing.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > be done at once. We need to rewrite the K=
config and flip over the
> > > > > > > > > > > > > > > > > board. Will we carry people with us? That=
 is a huge risk to the
> > > > > > > > > > > > > > > > > project IMO.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm not sure, actually, that it couldn't be=
 done in stages. We might
> > > > > > > > > > > > > > > > need a little bit of fakery around being ab=
le to just build SPL without
> > > > > > > > > > > > > > > > PPL in the interim.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Anyway, yes my schema makes the build do =
even more (with 400 lines of
> > > > > > > > > > > > > > > > > kconf additions and a patch that can like=
ly be upstreamed). But
> > > > > > > > > > > > > > > > > otherwise, it is a one-off improvement, w=
ithout any changes to the
> > > > > > > > > > > > > > > > > existing Kconfig.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I thought Yamada-san rejected changes going=
 in this direction before?
> > > > > > > > > > > > > > > > But either way, no it's not likely the fina=
l overburden in terms of
> > > > > > > > > > > > > > > > divergence.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes. Masahiro will make his own decisions and=
 I am confident he will
> > > > > > > > > > > > > > > reject any future changes I send
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So my point is that we could go with the =
first part of my scheme to
> > > > > > > > > > > > > > > > > resolve the 'medium' problems then decide=
 which way to continue after
> > > > > > > > > > > > > > > > > that. From your side you won't have lost =
anything towards where you
> > > > > > > > > > > > > > > > > want to head. The two options would then =
be:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > - exhance kconfig language to build in th=
e notion of phases
> > > > > > > > > > > > > > > > > - split the defconfigs for each board, re=
do the Kconfig rules and
> > > > > > > > > > > > > > > > > teach the build to combine images
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > If things go down your proposed path instea=
d, no, I don't see that as
> > > > > > > > > > > > > > > > making it meaningfully easier to go the way=
 I proposed later. The only
> > > > > > > > > > > > > > > > commonality is dropping $(PHASE_)/$(XPL_)/e=
tc and CONFIG_IS_ENABLED ->
> > > > > > > > > > > > > > > > IS_ENABLED. And (almost) all of that is a s=
cript'able change.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > To be frank, the difference is that I have ac=
tually put in the work to
> > > > > > > > > > > > > > > try this. It is more than 50 and perhaps as m=
any as 100 patches. Quite
> > > > > > > > > > > > > > > difficult work. Honestly, compared to that, t=
he logic changes are not
> > > > > > > > > > > > > > > that large.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > That is why I believe this work is a prerequi=
site for both schemes
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > would then be to use your scheme (Kco=
nfig refactoring, splitting
> > > > > > > > > > > > > > > > > > > defconfigs and some rework), or to do=
 my scheme (which would require
> > > > > > > > > > > > > > > > > > > enhancing the Kconfig language a bit =
just for U-Boot and some optional
> > > > > > > > > > > > > > > > > > > rework over time). Both schemes would=
 need a small amount of
> > > > > > > > > > > > > > > > > > > build-logic changes, but I'm not sure=
 yet what that would look like.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Does that sound right?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > With what I said above, yes I think we'=
re closer at least to
> > > > > > > > > > > > > > > > > > understanding each other.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Well, with that, what now?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > What makes the current situation untenable =
is VPL. And I gather I
> > > > > > > > > > > > > > > > haven't convinced you to put that on hold l=
ong enough to instead rework
> > > > > > > > > > > > > > > > how we build things, have I?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Which VPL thing?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > That it exists. When it was just SPL, it's mana=
geable. With TPL, well,
> > > > > > > > > > > > > > it was supposed to be tiny and so just a few mo=
re things. And with VPL,
> > > > > > > > > > > > > > that makes 4. It's too much. Something needs to=
 be done. Four times is
> > > > > > > > > > > > > > too many. If solving Marek's desire for PSCI-fr=
om-U-Boot means we need
> > > > > > > > > > > > > > number 5 that becomes even worse (and I also su=
spect that's a case of
> > > > > > > > > > > > > > one build covers the SoC or family of SoCs depe=
nding on hardware
> > > > > > > > > > > > > > changes).
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, that's why I took on this effort a few years=
 back.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > You have convinced me that you have a solutio=
n. It makes a lot more
> > > > > > > > > > > > > > > sense to me than previously and it may be tha=
t it is better in the
> > > > > > > > > > > > > > > end. For example, with VBE it I would make a =
lot of sense to build 20
> > > > > > > > > > > > > > > boards as just TPL and use a generic rock chi=
p board for everything
> > > > > > > > > > > > > > > else. That would be a lot tidier with your sc=
heme. It is very hard to
> > > > > > > > > > > > > > > predict the future and VBE is still not finis=
hed, some two years in.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I don't want to be tied to your scheme today =
though.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So if you can accept my going ahead with 1-4 =
and helping me with that,
> > > > > > > > > > > > > > > then we can stop and discuss which way to go,=
 perhaps by prototyping
> > > > > > > > > > > > > > > the two options?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I want to start by saying I do appreciate you p=
ut in a lot of work in
> > > > > > > > > > > > > > this direction already, and I do see some of th=
e end goals it achieves
> > > > > > > > > > > > > > as being important, and I'm glad you see my ide=
a has some good parts
> > > > > > > > > > > > > > too.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I want to figure out how to move forward on thi=
s problem. My other part
> > > > > > > > > > > > > > of this thread, this morning, was also part of =
me looking harder, again,
> > > > > > > > > > > > > > at the RFC series you posted before. And that's=
 where I still have large
> > > > > > > > > > > > > > reservations. There are *so* *many* symbols we =
need to now have 4
> > > > > > > > > > > > > > variants of, instead of 1 variant of. Take:
> > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patc=
h/20230212231638.1134219-58-sjg@chromium.org/
> > > > > > > > > > > > > > for example. It adds SPL_PARTITION_TYPE_GUID bu=
t we include <part.h> in
> > > > > > > > > > > > > > files built in TPL (and likely VPL) so aren't w=
e going to need that
> > > > > > > > > > > > > > every time? And with a quick size-check on pine=
book-pro-rk3399 it looks
> > > > > > > > > > > > > > like it's not working as intended either? I che=
cked and part_get_info
> > > > > > > > > > > > > > shrinks because CONFIG_PARTITION_TYPE_GUID is n=
ot set, or rather:
> > > > > > > > > > > > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > > > > > > > > > > >                 info->type_guid[0] =3D 0;
> > > > > > > > > > > > > > #endif
> > > > > > > > > > > >
> > > > > > > > > > > > Oh, I get it now. Previously CONFIG_PARTITION_TYPE_=
GUID=3Dy but now
> > > > > > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID=3Dn and while I'm no=
t sure that's a good
> > > > > > > > > > > > thing I see what happened. And now I see my problem=
 from yesterday
> > > > > > > > > > > > morning was similar but different.
> > > > > > > > > > > >
> > > > > > > > > > > > > > is not true and checked. And I can't see why. A=
nd there's other size
> > > > > > > > > > > > > > reductions (this time in tpl) on pinebook-pro-r=
k3399 that I didn't dig
> > > > > > > > > > > > > > in to more, but wasn't that symbol:
> > > > > > > > > > > > > >                tpl-u-boot-tpl: add: 0/-4, grow:=
 0/0 bytes: 0/-344 (-344)
> > > > > > > > > > > > > >                  function                      =
             old     new   delta
> > > > > > > > > > > > > >                  dev_get_uclass_plat           =
              12       -     -12
> > > > > > > > > > > > > >                  simple_bus_post_bind          =
              92       -     -92
> > > > > > > > > > > > > >                  _u_boot_list_2_uclass_driver_2=
_simple_bus     120       -    -120
> > > > > > > > > > > > > >                  _u_boot_list_2_driver_2_simple=
_bus         120       -    -120
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And I'm not bringing this up to badger you abou=
t bugs in an RFC series
> > > > > > > > > > > > > > (it's RFC, there's bugs) but rather because I t=
hink it highlights some
> > > > > > > > > > > > > > core issues with the approach as implemented.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But surely you can see that both schemes have exa=
ctly the same issues?
> > > > > > > > > > > > >
> > > > > > > > > > > > > My point is that the work to tidy up things and t=
hen get to a 'clean'
> > > > > > > > > > > > > source tree and Makefiles is the hard bit here an=
d has to be done with
> > > > > > > > > > > > > both schemes.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Just let me know which way you want to go. I don'=
t have anything ready
> > > > > > > > > > > > > to send, but I could probably drag it over the li=
ne before too long,
> > > > > > > > > > > > > if you are keen.
> > > > > > > > > > > >
> > > > > > > > > > > > Once I figured out what was the cause of the proble=
ms I saw in the RFC,
> > > > > > > > > > > > I had to rewrite this a few times. Your approach ne=
eds even more symbols
> > > > > > > > > > > > added than were in the RFC, and the newly added sym=
bols need further
> > > > > > > > > > > > auditing to make sure we have the same behavior as =
today at least by
> > > > > > > > > > > > default.
> > > > > > > > > > >
> > > > > > > > > > > This is the idea that we need to clean up a, b and c.=
 Your scheme is
> > > > > > > > > > > the same in this respect. If we have CONFIG_FOO today=
, then your
> > > > > > > > > > > scheme may need that duplicated to each defconfig fil=
e. Either you
> > > > > > > > > > > resolve the ambiguity or don't. But if you do, then y=
ou have to add
> > > > > > > > > > > symbols, with both schemes.
> > > > > > > > > >
> > > > > > > > > > There is minimal pain in saying a defconfig needs to li=
st CONFIG_FOO
> > > > > > > > > > there is pain in saying that we need to list
> > > > > > > > > > config PARTITION_TYPE_GUID
> > > > > > > > > > ...
> > > > > > > > > > config SPL_PARTITION_TYPE_GUID
> > > > > > > > > > ...
> > > > > > > > > > config TPL_PARTITION_TYPE_GUID
> > > > > > > > > > ...
> > > > > > > > > > config VPL_PARTITION_TYPE_GUID
> > > > > > > > > > ...
> > > > > > > > > >
> > > > > > > > > > In what I'm saying it's not generally an issue because:
> > > > > > > > > > $ git grep -l PARTITION_TYPE_GUID configs | wc -l
> > > > > > > > > > 21
> > > > > > > > > >
> > > > > > > > > > And we don't have to do additional upkeep on having N s=
ymbols.
> > > > > > > > >
> > > > > > > > > Well we only need to add those extra symbols if 1) we wan=
t that
> > > > > > > > > feature in a particular xPL, *and* 2) we don't want it ev=
erywhere.
> > > > > > > >
> > > > > > > > Yes, and the problem is adding more of them. Again, we woul=
d need to
> > > > > > > > duplicate drivers/usb/gadget/Kconfig with your scheme.
> > > > > > > >
> > > > > > > > > There is nothing in my scheme which requires us to add op=
tions that
> > > > > > > > > don't currently exist...but there is a problem if some co=
de uses
> > > > > > > > > CONFIG_IS_ENABLED(FOO) today and some code uses IS_ENABLE=
D(FOO). My
> > > > > > > >
> > > > > > > > That's good because that wasn't (how it seemed?) previously.
> > > > > > > >
> > > > > > > > > conf_nospl file helps with that and avoids changing Kconf=
ig. But
> > > > > > > > > again, if we are using both, then who knows what it means=
 today, and
> > > > > > > > > I'd like to clean it up.
> > > > > > > >
> > > > > > > > What we have today, with respect to CONFIG_IS_ENABLED(...) /
> > > > > > > > IS_ENABLED(...) is clearer than IS_ENABLED(CONFIG_FOO) that=
 is really
> > > > > > > > checking for CONFIG_SPL_FOO or CONFIG_VPL_FOO if it's in SP=
L or VPL.
> > > > > > > > It's easy to get *wrong* yes, but it's also clear. You're c=
hecking for
> > > > > > > > what it says.
> > > > > > > >
> > > > > > > > > > > > On the one hand, this is at least a well defined te=
chnical
> > > > > > > > > > > > problem and if you do the language extension *first=
* the code changes
> > > > > > > > > > > > aren't so bad.
> > > > > > > > > > >
> > > > > > > > > > > There are no significant Kconfig changes in my scheme=
, other than the
> > > > > > > > > > > conf_nospl file. The language extension is quite sepa=
rate.
> > > > > > > > > >
> > > > > > > > > > $ git diff pre-RFC-migrate-to-split-config..RFC-migrate=
-to-split-config
> > > > > > > > > > \
> > > > > > > > > >         | filterdiff -i "a/*/Kconfig" | diffstat -p1 | =
tail -n 1
> > > > > > > > > >  25 files changed, 316 insertions(+), 3 deletions(-)
> > > > > > > > > >
> > > > > > > > > > And that is largely duplication of existing symbols. An=
d again, it
> > > > > > > > > > wasn't enough duplication.
> > > > > > > > >
> > > > > > > > > I wonder if that is stuff that was already applied? Here =
is what I have today.
> > > > > > > > >
> > > > > > > > > $ glo ci/master..splg4  | filterdiff -i "a/*/Kconfig" | d=
iffstat -p1 | tail -n 1
> > > > > > > > >  0 files changed
> > > > > > > > >
> > > > > > > > > You can use the u-boot-dm/splg-working tree to see the or=
iginal
> > > > > > > > > version. From memory, the splc tree is very old and was m=
ostly applied
> > > > > > > > > or dropped.
> > > > > > > >
> > > > > > > > The splc-working tree is the RFC you pointed at earlier and=
 so yes, what
> > > > > > > > I was comparing with. If you were able to drop some of the =
problems,
> > > > > > > > that's good.
> > > > > > > >
> > > > > > > > > > > > But for the user running menuconfig / etc? That's n=
ot
> > > > > > > > > > > > going to be pretty. And we still won't have fixed t=
he problems like "why
> > > > > > > > > > > > is TPL even trying to build DWC3?" without reworkin=
g more symbols.
> > > > > > > > > > > >
> > > > > > > > > > > > So I don't think this is the right approach as it d=
oesn't reduce
> > > > > > > > > > > > confusion and may increase it (why do I need to set
> > > > > > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID when the code checks=
 for
> > > > > > > > > > > > CONFIG_PARTITION_TYPE_GUID?
> > > > > > > > > > >
> > > > > > > > > > > Because it is an SPL build...I actually think that ma=
kes a lot of
> > > > > > > > > > > sense. You just need to understand that CONFIG_SPL_ m=
eans the SPL
> > > > > > > > > > > build, which in fact is what we have been using for y=
ears.
> > > > > > > > > >
> > > > > > > > > > And it's no longer clear in the code, is the problem.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > But why is CONFIG_SPL_FRAMEWORK still there?
> > > > > > > > > > >
> > > > > > > > > > > Not relevant to the discussion, IMO.
> > > > > > > > > >
> > > > > > > > > > It's an example symbol. Why does the code have:
> > > > > > > > > >
> > > > > > > > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > > > > > > > ...
> > > > > > > > > > #endif
> > > > > > > > > >
> > > > > > > > > > And that's true for SPL builds. But the code also still=
 has:
> > > > > > > > > > #ifdef CONFIG_SPL_FRAMEWORK
> > > > > > > > > > ...
> > > > > > > > > > #endif
> > > > > > > > > >
> > > > > > > > > > Which is only true for CONFIG_SPL_FRAMEWORK being set.
> > > > > > > > >
> > > > > > > > > OK I think I understand your question. The tools work by =
identifying
> > > > > > > > > options which are in PPL and may or not be in other build=
s. There is
> > > > > > > > > no CONFIG_FRAMEWORK so all of this migration doesn't appl=
y.
> > > > > > > >
> > > > > > > > No, you entirely misunderstand me. I am not talking about t=
he tool. I am
> > > > > > > > talking about the developer.
> > > > > > > >
> > > > > > > > > If there were a CONFIG_IS_ENABLED(FRAMEWORK) or a CONFIG_=
FRAMEWORK
> > > > > > > > > then the discussion would be different.
> > > > > > > > >
> > > > > > > > > BTW, I wonder if we could drop that symbol, or switch it =
around so
> > > > > > > > > that boards which don't use it have to set CONFIG_SPL_STR=
ANGE or
> > > > > > > > > similar.
> > > > > > > >
> > > > > > > > Touching the PowerPC TPL/SPL stuff is very low on the prior=
ity list. If
> > > > > > > > you want to file an issue for it, please do. But that (roug=
hly) is why
> > > > > > > > there's SPL_FRAMEWORK.
> > > > > > > >
> > > > > > > > > > > > Oh..). The main thing it does is drop $(PHASE_) and=
 I honestly think
> > > > > > > > > > > > that's more confusing. We still have one build wher=
e we need to do or
> > > > > > > > > > > > not do different things for FOO && PPL, FOO && SPL,=
 etc but the code
> > > > > > > > > > > > just references CONFIG_FOO but doesn't always mean =
CONFIG_FOO=3Dy/n in the
> > > > > > > > > > > > .config / defconfig.
> > > > > > > > > > >
> > > > > > > > > > > Yes, that's the conf_nospl file which I have dealt wi=
th.
> > > > > > > > > >
> > > > > > > > > > OK? My point is that the code is now more confusing, no=
t less confusing.
> > > > > > > > > > Because the code says CONFIG_PARTITION_TYPE_GUID. Not
> > > > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID. And not IS_ENABLED(PART=
ITION_TYPE_GUID)
> > > > > > > > > > which is at least a hint that one needs to look harder,=
 and oh,
> > > > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID maybe matches somehow.
> > > > > > > > >
> > > > > > > > > If you are saying that it is better to have CONFIG_IS_ENA=
BLED(FOO),
> > > > > > > > > IS_ENABLED(CONFIG_FOO), obj-$(CONFIG_$(PHASE_)FOO) etc., =
then I don't
> > > > > > > > > agree, sorry. That is problems a-c in my original proposa=
l and my
> > > > > > > > > understanding is that both our approaches resolve this pr=
oblem.
> > > > > > > > >
> > > > > > > > > Otherwise, you've just lost me and we should probably giv=
e up on this point.
> > > > > > > >
> > > > > > > > Yes, I am saying that what we have today is less confusing =
than what you
> > > > > > > > are proposing. Because with your proposal:
> > > > > > > >
> > > > > > > > obj-$(CONFIG_FS_FAT) +=3D fat/
> > > > > > > >
> > > > > > > > Can refer to CONFIG_SPL_FS_FAT, CONFIG_FS_FAT or CONFIG_VPL=
_FS_FAT. That
> > > > > > > > is not good for humans.
> > > > > > >
> > > > > > > Let's just stop on this point. We seem to be going backwards.=
 Now you
> > > > > > > are saying that you *want* to keep:
> > > > > > >
> > > > > > > a. The $(PHASE_) stuff in Makefiles
> > > > > > > b. The CONFIG_xxx / CONFIG_IS_ENABLED(xxx) split
> > > > > > >
> > > > > > > and you believe that
> > > > > > >
> > > > > > > c. the ambiguity I mentioned with CONFIG_FOO
> > > > > > >
> > > > > > > are all actually a good thing?
> > > > > >
> > > > > > No. I'm saying that what we have today is LESS confusing than y=
our
> > > > > > proposal in splc-working. I can't evaluate splg-working because=
 it
> > > > > > doesn't work enough to be clear if it does or doesn't still sol=
ve all
> > > > > > the problems that splc-working does. Various things don't build=
 anymore
> > > > > > in splg-working and T2080RDB_NAND as a first example (as the po=
werpc
> > > > > > part of the world build failed first) has massive size changes.
> > > > > >
> > > > > > I do not like splc-working, but splc-working is a few bugs away=
 from 1:1
> > > > > > functional binaries from before your changes.
> > > > > >
> > > > > > I do not like what we have today because it's tricky to get thi=
ngs
> > > > > > right. But the macros are visible in the code / Makefiles so hu=
mans
> > > > > > still find things.
> > > > >
> > > > > OK, well I am still lost, sorry.
> > > >
> > > > OK, in splc-working what is untenable to me is that the following l=
ine
> > > > in a Makefile:
> > > > obj-$(CONFIG_FS_FAT) +=3D fat/
> > > >
> > > > Is unclear if it refers to PPL or some xPL. This is worse for humans
> > > > than what we have today.
> > >
> > > We're really heading in completely different directions then.
> > >
> > > At the moment, if we have:
> > >
> > > obj-$(CONFIG_FOO) +=3D foo/
> > >
> > > we know this is used in all builds. If we have:
> > >
> > > obj-$(CONFIG_$(PHASE_)FOO) +=3D foo/
> > >
> > > then we have to look at Kconfig to figure that out.
> > >
> > > My change makes it entirely dependent on Kconfig, in both cases.
> > >
> > > For source code, we can have both CONFIG_FOO and
> > > CONFIG_IS_ENABLED(FOO), so again Kconfig does not control things. It
> > > is merely a hint.
> > >
> > > To my mind, $(PHASE_) and CONFIG_IS_ENABLED() are hacks, to work
> > > around the unified config, which I want to split.
> >
> > This is why we need a TSC. I think $(PHASE_) and CONFIG_IS_ENABLED() are
> > better than having to remember that CONFIG_SPL_FOO is no longer a
> > meaningful value (CONFIG_SPL_FS_FAT), except when it is a meaningful
> > value (CONFIG_SPL_TEXT_BASE). You disagree. We've both presented our
> > technical reasoning and neither of us seems swayed to go another
> > direction instead. You are also unwilling to accept my No as the head of
> > the project.
>=20
> But I still don't really understand what you want here. You say that
> you want completly separate defconfig files for each phase, with kconf
> running once for each. So I assumed that the .config files so produced
> would just have CONFIG_FOO in them, not CONFIG_SPL_FOO (for example).
> Is that right?
>=20
> Or are you saying that the .config.spl file will have CONFIG_SPL_FOO,
> i.e. insert an SPL_ into every option?
>=20
> Or, perhaps, are you saying that the $(PHASE_) does nothing
> (programmatically) with your scheme, just indicating to the user that
> this is an option that might have different values for each phase?
>=20
> Before giving up, I should at least try to understand what you are
> actually getting at.

I have replied in detail now earlier in the thread.

> I accepted your No over two years ago and no one has come up with an
> alternative series in the interim, so we have lost that time (and also
> that work, since it took at lot of of effort to avoid behaviour
> changes and much of it will need to be redone). I'd *really* like to
> be able to add a new phase with just a few lines of Kconfig.

I not only said No two years ago, I said we should instead do what I
proposed as an alternate. And I said several times over the prior years
that Yamada-san was right and we should have had one .config builds one
phase.

And then more recently I applied your xPL series may or may not have
made things more confusing to other people (I don't have a good search
engine for looking for examples in the archives, nor the public IRC
logs) as olive branch towards "maybe this will be enough to appease
Simon".

> > > > > We are trying to discuss a change to how CONFIG options are handl=
ed in
> > > > > the source tree. It sounds like you are saying that you cannot re=
view
> > > > > it until it fully works. But you already did that two years ago a=
nd
> > > >
> > > > I cannot comment on what's in splg-working, which is also about two
> > > > years old, because while it has the same problem I object to above =
with
> > > > splc-working, it looks like you just dropped adding Kconfig symbols=
 from
> > > > splc-working and showing that well actually some number of those sy=
mbols
> > > > were needed afterall.
> > >
> > > That could well be true.
> > >
> > > >
> > > > > rejected it. So I don't see any way forward here. Do you?
> > > >
> > > > Well, I'm once again back to wondering if you ever plan to stop hav=
ing
> > > > your own downstream fork and so how much effort I should even put in
> > > > again.
> > >
> > > My plan is to run it for a year and then review it.  The more effort
> > > we put in, the less the delta, which is why I am sending patches out
> > > and responding to feedback.
> >
> > So you want to run a downstream fork for a year, and then what? How can
> > I get you to stop? Or convince you to just hard fork and give the domain
> > to the project? As I do not see how this gets better in a year unless
> > you expect your tree to just become mainline.
>=20
> So far I've been working with you and others on everything I've sent.
> If that continues for this year, I won't need my tree.

So in a year you'll go and start unwinding all of your work, so it can
be rebased and then re-tested and applied? We've already now hit the
point where most things you post can't be applied to mainline. This is
one of the points I've been trying to make for a while now. And it would
be one thing if you were doing that your personal domain or your
personal github/whatever. But you're doing it with u-boot.org. And I
cannot seem to convince you to stop and make that point to the official
tree.

--=20
Tom

--lsMGGKIo6ssuUXl1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezi3gACgkQFHw5/5Y0
tywSsgv7BEq0IKTpJUz+vrUS3nEba2k/4AwF6rUzbQ1d/yjjJVkmqMdfqVqnXSpA
4/m49vs/LPWrRKLfaT8jyrVW8bts5+rJczdBNDjvKCLQ5KCEJL7rrn6M2tSmDxzT
eBHzuXVA1ES8EHDB2nv42DX35fnh5AAgFM7KdMhZXpH990kejjJA3TkVKLXIZbcS
iUxKJbb1CCYdP9GdQWOVDA3hXAln+GL4jdtly8e5/OFvE9/k/BePfo9wGalusMMc
X5CJ9chJGstQ2byfh0DFTpTHg6uEj2m+8SaVQfZz3VSmliyowgLsiqv6Qopo9CkS
C+tUecoNUI1efMaUZy8gpYOi6KXcPujKZB6MxO6ihsh94fRRsxSdaM9cLWIJnx4U
doAGPWZBcEk75WKZTBRtJju1FqKa6Zsdh4UFh0mzKj6Ry5TeWeN8Ea0pA5ZFhrX8
a4yQmEBkwb1fxaZjuFXBaCNuFi/iINTKddyP5VmuMlEAsAeFYdZtzhOgvTUjahBX
s8phITks
=Dcty
-----END PGP SIGNATURE-----

--lsMGGKIo6ssuUXl1--
