Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644FBC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEAFE80EC0;
	Thu, 20 Feb 2025 18:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BtYlTQtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF9480F56; Thu, 20 Feb 2025 18:40:15 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D3080077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-221206dbd7eso24464705ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740073210; x=1740678010; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EHRxfMqHlywH8g7Vkvur14SEKPsabDNWUJMSnpdtwcY=;
 b=BtYlTQtxYHAL7oveX5BlhGg5vs6PoFVXS1X891kbiUSKdPy+ToEeaLPrPIR/DUsNQ0
 O1Hk0vDQJ4bMVKMD+2eOmzFB3xyhMkNvC1VvcuLVH7ocZOVCUNAthJ82k+0KzF3Z1eXA
 IMwbigFU3N2chcuB9H4+pj+JlBf3yx/JNajWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740073210; x=1740678010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHRxfMqHlywH8g7Vkvur14SEKPsabDNWUJMSnpdtwcY=;
 b=C50W3ngqjN4cM3Xor+r9O/GlVPLCR4mnRr3cD2ovNl+gCKMX7fH2kKoZkv4TEmN5kr
 bQk1BTWdAXoVb8jfdijViXXtR7H44LSktcZro08L/GYcIInXXzc8hVsOh7n25eaAcJ6N
 gEdeq3TcKIS0RmWwBdQgGmTD5papiQCG7vKwCwlW9dChS+pYcK4UN7I+g4IGI7EDDs/q
 oERTv5eMR8M+jugkGVdgoXg4+S1fmBs9p8JcDsLTpW8hs0Qo8LpFAcGfkul/bW4f4fBR
 /ELAJY/5rbJaXvLFG1tflrQ9V0VstYJGpFCi8McZRDM0qkL9dbNUm5lSNscR772gJ8F8
 CLWw==
X-Gm-Message-State: AOJu0Yw9nA+RqB1PQHXaL3lmPPbAnY+kVq81+Bhb+BTNordV+qtQ3EG1
 zBqY8ywWpYwMxMap/SVfwGUk2nPBl7h1V21BRrwsLJOaE+1LqdBLp9nv5USnGGA=
X-Gm-Gg: ASbGncttx1N2OvYamjU09Di7ArMN7gMvpClhvLdNwJ2+iffUnj9oeHreY7fqJ3Ls/mY
 ZmQ+e5hEAKbW8LIIIjj23oShMSV6RvmSQ15LHowiUiSXwbBPsVEDzmHTd66yxq8rGeEK202/OrB
 cNhbOI+sfF3CfNEej+mKSBa3FNjrJfnxNJ9Zx1btIfikvVGNXDV9/DT4hlvqrHaMkDe2eHGFWYZ
 NeuJnVbEsR3Yj9d19cMyrVKwNn7dsUw7yv8dGSUgSW7LiLvDpAxkx9mQmT9QJoll8Qp+y4gRIpE
 4/kjBOfLScpQ6A==
X-Google-Smtp-Source: AGHT+IFSsCxmMrJS96mfqGEaoU84CCzM3oIkGVV9Gcgzw9GCRyTGwKjxHDdLxT9M4mmfUum70Jf0qQ==
X-Received: by 2002:a05:6a20:d74d:b0:1ee:62e4:78cc with SMTP id
 adf61e73a8af0-1eed4fd3c50mr20022881637.36.1740073209280; 
 Thu, 20 Feb 2025 09:40:09 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73287ed12e8sm6814889b3a.180.2025.02.20.09.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:40:08 -0800 (PST)
Date: Thu, 20 Feb 2025 11:40:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250220174005.GA1233568@bill-the-cat>
References: <20250218004025.GA1233568@bill-the-cat>
 <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
 <20250218144627.GC1233568@bill-the-cat>
 <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
 <20250219010708.GS1233568@bill-the-cat>
 <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
 <20250219203406.GV1233568@bill-the-cat>
 <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ypffpNPF1NTZUe0j"
Content-Disposition: inline
In-Reply-To: <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
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


--ypffpNPF1NTZUe0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 09:43:10AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Feb 2025 at 08:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 06:19:05AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 19 Feb 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 07:48:17AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 18 Feb 2025 at 18:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini =
wrote:
> > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon G=
lass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Sim=
on Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <tri=
ni@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600,=
 Tom Rini wrote:
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
> > > > > > > > > > > > > > > > > >
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
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MM=
C and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > > - Likely need to introduce a PPL symbol=
 as you suggest.
> > > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice stat=
ement when building a defconfig.
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
> > > > > > > > > > > > > > > > > Lets come back up here, to my proposal, s=
ince parts of it seem to have
> > > > > > > > > > > > > > > > > not been clear enough. While what I'm pro=
posing should work for any
> > > > > > > > > > > > > > > > > platform and xPL -> xPL -> ... -> PPL, fo=
r this example let us assume
> > > > > > > > > > > > > > > > > rockpro64-rk3399 supports the flow of TPL=
 -> SPL -> PPL. Also, to
> > > > > > > > > > > > > > > > > compare with today, it will be helpful to=
 run "make
> > > > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_current rockpro=
64-rk3399_config" and have the
> > > > > > > > > > > > > > > > > resulting .config file available.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > There shall be configs/rockpro64-rk3399_t=
pl_defconfig. This will contain
> > > > > > > > > > > > > > > > > lines such as:
> > > > > > > > > > > > > > > > > CONFIG_ARM=3Dy
> > > > > > > > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > When you run "make O=3D/tmp/rockpro64-rk3=
399_tpl rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > > > > > > > > the resulting .config file will contain l=
ines such as:
> > > > > > > > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > > > > > > > > > as this only makes sense in the context o=
f building something that will
> > > > > > > > > > > > > > > > > be TPL.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > A more complex example is that it will al=
so contain:
> > > > > > > > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Because looking at arch/arm/mach-rockchip=
/Makefile a bunch of that will
> > > > > > > > > > > > > > > > > be able to be simplified (and spl_common.=
c should be renamed to
> > > > > > > > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=
=3D spl.o spl-boot-order.o xpl_common.o
> > > > > > > > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=
=3D tpl.o xpl_common.o
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The .config file here will also contain:
> > > > > > > > > > > > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > This is because there is no 'config TPL_D=
M_SERIAL' option in
> > > > > > > > > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > When you next run "make O=3D/tmp/rockpro6=
4-rk3399_tpl all" the results in
> > > > > > > > > > > > > > > > > /tmp/rockpro64-rk3399_tpl would be simila=
r to the results as under
> > > > > > > > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when buildin=
g today.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The contents of configs/rockpro64-rk3399_=
spl_defconfig would be similar
> > > > > > > > > > > > > > > > > to the tpl one, except with SPL-only-ever=
-valid options such as
> > > > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but =
otherwise have CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=3Dy, and when=
 building the "all" target, you
> > > > > > > > > > > > > > > > > would only get similar results to what is=
 under the spl/ directory
> > > > > > > > > > > > > > > > > today.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Next we have configs/rockpro64-rk3399_ppl=
_defconfig.  When you run "make
> > > > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-r=
k3399_ppl_defconfig" the
> > > > > > > > > > > > > > > > > important difference is what you do not h=
ave. You do not have:
> > > > > > > > > > > > > > > > > CONFIG_SPL=3Dy
> > > > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Because we are not building SPL nor TPL. =
We're just making full U-Boot
> > > > > > > > > > > > > > > > > itself. This is where in more full exampl=
es and with additional
> > > > > > > > > > > > > > > > > restructure a "generic-arm64_ppl_defconfi=
g" makes sense and be used
> > > > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > This brings up what to do with "ockpro64-=
rk3399_defconfig". And I'm a
> > > > > > > > > > > > > > > > > little unsure which of the things I menti=
oned above is best. It's
> > > > > > > > > > > > > > > > > either:
> > > > > > > > > > > > > > > > > a) Does not exist, top-level Makefile say=
s roughly:
> > > > > > > > > > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defcon=
fig %_ppl_defconfig
> > > > > > > > > > > > > > > > >   make O=3D$(objdir)/tpl %_tpl_defconfig =
all
> > > > > > > > > > > > > > > > >   make O=3D$(objdir)/spl %_spl_defconfig =
all
> > > > > > > > > > > > > > > > >   make O=3D$(objdir)/ppl %_ppl_defconfig =
all
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > > > > > > > b) It contains:
> > > > > > > > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > > > > > > > > > %_defconfig:
> > > > > > > > > > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid def=
config file, please see..."
> > > > > > > > > > > > > > > > >   foreach line in $@
> > > > > > > > > > > > > > > > >     make O=3D$(objdir)/$PHASE $CONFIGFILE=
 all
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > It could also be some other suggestion.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Thanks for writing that up. It is somewhat =
clearer.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > What happens to the Makefiles? Do they stil=
l have $(PHASE_) in them?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > No. Because CONFIG_SPL_FIT would never exist,=
 $(CONFIG_$(PHASE_)FIT)
> > > > > > > > > > > > > > > would be meaningless. Only rockpro64-rk3399_s=
pl_defconfig would say
> > > > > > > > > > > > > > > CONFIG_FIT=3Dy (or more likely, only the resu=
lting .config would say
> > > > > > > > > > > > > > > CONFIG_FIT=3Dy just like how configs/rockpro6=
4-rk3399_defconfig doesn't
> > > > > > > > > > > > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But just above you said:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I believe this proposal will lead to the code=
 and Makefiles being less
> > > > > > > > > > > > > > > clear than they are today. The line:
> > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=
=3D block/
> > > > > > > > > > > > > > > will become:
> > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
> > > > > > > > > > > > > > > without being clear that it could reference e=
ither full U-Boot (PPL) or
> > > > > > > > > > > > > > > some xPL phase. While the same Makefile will =
continue to have (comments
> > > > > > > > > > > > > > > my own):
> > > > > > > > > > > > > > > obj-y +=3D mtd/ # Subdirectory Makefiles cont=
rol build contents
> > > > > > > > > > > > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only va=
lid for PPL.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And so the situation for humans will be worse=
 off than today because
> > > > > > > > > > > > > > > while $(PHASE_) and $(XPL_) are confusing at =
times, they make it clear
> > > > > > > > > > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Doing "something" is not better than doing no=
thing in this case.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So why is OK for your proposal to drop the $(PH=
ASE_) stuff, but not mine?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Because your proposal keeps CONFIG_SPL_BLK (and c=
onfig SPL_BLK) and has
> > > > > > > > > > > > > a .config file which says "CONFIG_SPL_BLK=3Dy" bu=
t mine doesn't.
> > > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > With my
> > > > > > > > > > > > proposal "I have a problem, and I want to see what =
my SPL build has with
> > > > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree f=
or CONFIG_BLK, the
> > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > >
> > > > > > > > > > > There will be at least some matches, e.g. CONFIG_SPL_=
BLK in the
> > > > > > > > > > > defconfig files and 'config SPL_BLK' in the source tr=
ee.
> > > > > > > > > >
> > > > > > > > > > Yes, and that's confusing. I am arguing that your state=
ment is more
> > > > > > > > > > confusing than $(PHASE_)BLK is.
> > > > > > > > >
> > > > > > > > > OK
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > > Or to try and explain differently, with your prop=
osal "I have a problem,
> > > > > > > > > > > > > and I want to see what builds with CONFIG_SPL_BLK=
=3Dy. Why is there no
> > > > > > > > > > > > > match in the source tree for CONFIG_SPL_BLK or ev=
en SPL_BLK". With my
> > > > > > > > > > > > > proposal "I have a problem, and I want to see wha=
t my SPL build has with
> > > > > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree=
 for CONFIG_BLK, the
> > > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > >
> > > > > > > > > > > Well, CONFIG_BLK will be in the source tree; it just =
means different
> > > > > > > > > > > things for different phases.
> > > > > > > > > >
> > > > > > > > > > And it will be, with your proposal, controlled by BLK o=
r SPL_BLK or
> > > > > > > > > > TPL_BLK or VPL_BLK in the .config file but only CONFIG_=
BLK in Makefile
> > > > > > > > > > and code.
> > > > > > > > > >
> > > > > > > > > > > It sounds like you want to get rid of the xPL prefixe=
s for Kconfig
> > > > > > > > > > > options, and that overrides all other considerations?
> > > > > > > > > >
> > > > > > > > > > It's one of the big problems we have today, and splc-wo=
rking shows how
> > > > > > > > > > much further the duplication must go. It's why I sugges=
ted the language
> > > > > > > > > > modification before.
> > > > > > > > > >
> > > > > > > > > > > > My other try here was a bit unclear actually becaus=
e of the confusion
> > > > > > > > > > > > state your proposal gives us. Try try again directl=
y, the problem is
> > > > > > > > > > > > that CONFIG_SPL_BLK will be set (or unset) but not =
referenced in code.
> > > > > > > > > > > > This will be true for many but not all SPL symbols =
as
> > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will s=
till exist and need
> > > > > > > > > > > > to be referenced. This is a more confusing state th=
an $(PHASE_). $(XPL_)
> > > > > > > > > > > > I think can just be replaced with $(PHASE_) but I h=
aven't confirmed (I
> > > > > > > > > > > > think it does show that the old way was confusing h=
owever).
> > > > > > > > > > >
> > > > > > > > > > > OK, I think I see. You don't want people to have to '=
know' that
> > > > > > > > > > > CONFIG_xPL_xxx is used to control feature xxx in each=
 xPL build?
> > > > > > > > > >
> > > > > > > > > > I'm saying they have to know that, and also know which =
symbols that's
> > > > > > > > > > not true for. And that is more confusing than today. I'=
m saying that
> > > > > > > > > > compared with today's arch/arm/mach-rockchip/Makefile t=
he following is
> > > > > > > > > > worse:
> > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm=
/mach-rockchip/Makefile
> > > > > > > > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > >  endif
> > > > > > > > > >
> > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > >
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > >
> > > > > > > > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> > > > > > > > > >
> > > > > > > > > > And this is better:
> > > > > > > > > >
> > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm=
/mach-rockchip/Makefile
> > > > > > > > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > @@ -7,15 +7,13 @@
> > > > > > > > > >  # this may have entered from ATF with the stack-pointe=
r pointing to
> > > > > > > > > >  # inaccessible/protected memory (and the bootrom-helpe=
r assumes that
> > > > > > > > > >  # the stack-pointer is valid before switching to the U=
-Boot stack).
> > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o=
 spl-boot-order.o spl_common.o
> > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o=
 spl_common.o
> > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl=
-boot-order.o spl_common.o
> > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl=
_common.o
> > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > > > >
> > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-sp=
l.o
> > > > > > > > > > -
> > > > > > > > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > > > > >
> > > > > > > > > >  # Always include boot_mode.o, as we bypass it (i.e. tu=
rn it off)
> > > > > > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE=
_REG is 0.  This way,
> > > > > > > > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_T=
PL_BUILD),)
> > > > > > > > > >  # meaning "turn it off".
> > > > > > > > > >  obj-y +=3D boot_mode.o
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > > > -endif
> > > > > > > > > >
> > > > > > > > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > > -endif
> > > > > > > > > >
> > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > >
> > > > > > > > > > +ifdef CONFIG_PPL
> > > > > > > > > > +# TODO: Audit these Makefiles see if they really must =
be PPL only
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D r=
k3568/
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > > > -
> > > > > > > > > > -# Clear out SPL objects, in case this is a TPL build
> > > > > > > > > > -obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > > > > > > > -
> > > > > > > > > > -# Now add SPL/TPL objects back into the main build
> > > > > > > > > > -obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > > > > > > -obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > > > > > > +endif
> > > > > > > > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as o=
ptions).
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > This Makefile is a very strange example. I've thought abo=
ut cleaning
> > > > > > > > > it up a few times, but then I know someone will say it ne=
eds to be in
> > > > > > > > > its own series, etc. so I've never got around to it. Even=
 with the
> > > > > > > > > current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just=
 SPL) it is
> > > > > > > > > needlessly complex.
> > > > > > > >
> > > > > > > > There's some complexity that can be removed here today, may=
be. But not a
> > > > > > > > lot of it, because it's complex to build three different th=
ings when
> > > > > > > > configuring once.
> > > > > > > >
> > > > > > > > > Anyway, with my scheme, you can still use
> > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds =
SPL_ versions
> > > > > > > >
> > > > > > > > No. You have to use it still, with yours. Because
> > > > > > > > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
> > > > > > > > "TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use co=
mmon board
> > > > > > > > code" but different files at TPL, SPL and PPL. And you stil=
l have to
> > > > > > > > with mine, because for the same reason. With mine, the Kcon=
fig is:
> > > > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > > > >   bool "SPL rockchip common board file"
> > > > > > > >   depends on SPL
> > > > > > > >
> > > > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > > > >   bool "TPL rockchip common board file"
> > > > > > > >   depends on TPL
> > > > > > > >
> > > > > > > > And since you are only ever configuring for TPL or SPL or P=
PL (or VPL or
> > > > > > > > ...) the resulting config only ever asks for the appropriat=
e one.
> > > > > > > >
> > > > > > > > > of symbols to autoconf_spl.h for this reason. There are a=
lso places in
> > > > > > > > > the code where people directly check CONFIG_SPL_xxx and t=
hese need to
> > > > > > > > > work.
> > > > > > > >
> > > > > > > > Yes, this is part of the confusion I keep noting with your =
proposal as
> > > > > > > > it will be inconsistent for which symbols CONFIG_SPL_xxx is=
 referred to
> > > > > > > > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
> > > > > > >
> > > > > > > If it is confusing, we can change all of them to CONFIG_xxx i=
n a
> > > > > > > follow-up. There is no need to mention SPL_, it just allows t=
he
> > > > > > > existing code to work without a wholesale change.
> > > > > >
> > > > > > No, that's not correct. Please look again at what I've written
> > > > > > explaining why.
> > > > >
> > > > > See below.
> > > > >
> > > > > >
> > > > > > > > > This surprised me:
> > > > > > > > >
> > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > >
> > > > > > > > > Are you saying you are OK with this one, instead of, for =
example:
> > > > > > > > >
> > > > > > > > > obj-$(CONFIG_TPL_RAM) +=3D sdram.o
> > > > > > > > > obj-$(CONFIG_SPL_RAM) +=3D sdram.o
> > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > >
> > > > > > > > > If so, why are you OK with that and not the others?
> > > > > > > >
> > > > > > > > Because there is no:
> > > > > > > > config TPL_RAM
> > > > > > > >   bool "RAM driver in TPL"
> > > > > > > >
> > > > > > > > in what I am proposing. That's why. There's one symbol beca=
use there's
> > > > > > > > the same files being built.
> > > > > > >
> > > > > > > OK, well that works the same for my scheme too. Either will d=
o.
> > > > > >
> > > > > > I don't see how that can work in your scheme.
> > > > >
> > > > > Here is the full Kconfig for that file, with my scheme:
> > > > >
> > > > > >>>>
> > > > > # SPDX-License-Identifier: GPL-2.0+
> > > > > #
> > > > > # Copyright (c) 2014 Google, Inc
> > > > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > > > >
> > > > > # We don't want the bootrom-helper present in a full U-Boot build=
, as
> > > > > # this may have entered from ATF with the stack-pointer pointing =
to
> > > > > # inaccessible/protected memory (and the bootrom-helper assumes t=
hat
> > > > > # the stack-pointer is valid before switching to the U-Boot stack=
).
> > > > > obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-o=
rder.o
> > > > > spl_common.o
> > > > > obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common=
=2Eo
> > > > > obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > >
> > > > > obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > >
> > > > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > >
> > > > > # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0. =
 This way,
> > > > > # we can have the preprocessor correctly recognise both 0x0 and 0
> > > > > # meaning "turn it off".
> > > > > obj-y +=3D boot_mode.o
> > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > endif
> > > > >
> > > > > ifeq ($(CONFIG_TPL_BUILD),)
> > > > > obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > endif
> > > > >
> > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > >
> > > > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3128) +=3D rk3128/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3188) +=3D rk3188/
> > > > > obj-$(CONFIG_ROCKCHIP_RK322X) +=3D rk322x/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3308) +=3D rk3308/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3368) +=3D rk3368/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > > > obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > >
> > > > > # Clear out SPL objects, in case this is a TPL build
> > > > > obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > >
> > > > > # Now add SPL/TPL objects back into the main build
> > > > > obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > <<<<
> > > > >
> > > > > The only change is the line that was:
> > > > > obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > >
> > > > Yes, that's also what I showed via unified diff format earlier, and=
 so I
> > > > agree.
> > >
> > > OK good.
> > >
> > > >
> > > > > > > > > For this one:
> > > > > > > > >
> > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl=
-boot-order.o spl_common.o
> > > > > > > > >
> > > > > > > > > I don't understand how it can work with your scheme, sinc=
e you don't
> > > > > > > > > want to have any CONFIG_SPL_ things?
> > > > > > > >
> > > > > > > > No, that's not what I've been saying and trying to make cle=
ar with my
> > > > > > > > examples. I keep saying that there are explicitly SPL (or T=
PL or VPL)
> > > > > > > > only options. And these need to be named as such. And so th=
at's the
> > > > > > > > confusion your proposal introduces (inconsistency about ref=
erring to a
> > > > > > > > symbol that has been enabled) and mine removes entirely (we=
 only ever
> > > > > > > > refer to symbols based on their name).
> > > > > > >
> > > > > > > Right, but you still have 'config SPL_RAM', right? Would you =
keep
> > > > > >
> > > > > > No, again, I do not. Please re-read my proposal as you seem to =
keep
> > > > > > making the same incorrect assumptions about it, and then saying=
 that
> > > > > > your scheme would also do that. They are very much not at all t=
he same.
> > > > >
> > > > > Maybe we have reached the limits of email on this one, but I am q=
uite
> > > > > confused about your scheme. I suggested that you don't have
> > > > > CONFIG_SPL_ things and you said tht was wrong. Then I asked if you
> > > > > still have SPL_RAM and you said you don't. Let me try this:
> > > > >
> > > > > Q: In your scheme, do you have 'config SPL_RAM' and CONFIG_SPL_RA=
M, or
> > > > > do you not?
> > > >
> > > > In my scheme we do not have 'config SPL_RAM' nor CONFIG_SPL_RAM as =
there
> > > > is no case where 'config RAM' and 'CONFIG_RAM' is incorrect. Becaus=
e we
> > > > are never configuring and building for more than one phase.
> > > >
> > > > In my scheme we do have 'config SPL_ROCKCHIP_COMMON_BOARD and
> > > > 'CONFIG_SPL_ROCKCHIP_COMMON_BOARD' because they are NOT the same th=
ing
> > > > as 'config ROCKCHIP_COMMON_BOARD' and 'CONFIG_ROCKCHIP_COMMON_BOARD'
> > > > (and again for TPL_...). They control different code. While technic=
ally
> > > > possible, I am arguing against overloading ROCKCHIP_COMMON_BOARD and
> > > > having the Makefile have to do some two part check like we have tod=
ay,
> > > > as those are one of the pain points of adding new code.
> > >
> > > OK I think I have some sort of understanding now.
> > >
> > > Here is the patch that works for me (on top of your patch above). Note
> > > that we don't have to make those changes, but they show how my scheme
> > > is different in what it expects:
> > >
> > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip=
/Makefile
> > > index 23c30f68f87..0593e028de4 100644
> > > --- a/arch/arm/mach-rockchip/Makefile
> > > +++ b/arch/arm/mach-rockchip/Makefile
> > > @@ -7,27 +7,35 @@
> > >  # this may have entered from ATF with the stack-pointer pointing to
> > >  # inaccessible/protected memory (and the bootrom-helper assumes that
> > >  # the stack-pointer is valid before switching to the U-Boot stack).
> > > +ifdef CONFIG_XPL_BUILD
> > >  obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > +endif
> > > +ifdef CONFIG_SPL_BUILD
> > >  obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o =
spl_common.o
> > > -obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > +endif
> > > +ifdef CONFIG_TPL_BUILD
> > >  obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > +endif
> > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > >
> > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > >
> > > +ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > +
> > >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  Th=
is way,
> > >  # we can have the preprocessor correctly recognise both 0x0 and 0
> > >  # meaning "turn it off".
> > >  obj-y +=3D boot_mode.o
> > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > +endif
> > >
> > > +ifeq ($(CONFIG_TPL_BUILD),)
> > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > +endif
> > >
> > >  obj-$(CONFIG_RAM) +=3D sdram.o
> > >
> > > -ifdef CONFIG_PPL
> > > -# TODO: Audit these Makefiles see if they really must be PPL only
> > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > @@ -43,4 +51,3 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > -endif
> > > --
> > > 2.43.0
> > >
> > >
> > > Here's the full file:
> > >
> > > # SPDX-License-Identifier: GPL-2.0+
> > > #
> > > # Copyright (c) 2014 Google, Inc
> > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > >
> > > # We don't want the bootrom-helper present in a full U-Boot build, as
> > > # this may have entered from ATF with the stack-pointer pointing to
> > > # inaccessible/protected memory (and the bootrom-helper assumes that
> > > # the stack-pointer is valid before switching to the U-Boot stack).
> > > ifdef CONFIG_XPL_BUILD
> > > obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > endif
> > > ifdef CONFIG_SPL_BUILD
> > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o spl_c=
ommon.o
> > > endif
> > > ifdef CONFIG_TPL_BUILD
> > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > endif
> > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > >
> > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > >
> > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > >
> > > # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  Thi=
s way,
> > > # we can have the preprocessor correctly recognise both 0x0 and 0
> > > # meaning "turn it off".
> > > obj-y +=3D boot_mode.o
> > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > endif
> > >
> > > ifeq ($(CONFIG_TPL_BUILD),)
> > > obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > endif
> > >
> > > obj-$(CONFIG_RAM) +=3D sdram.o
> > >
> > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > obj-$(CONFIG_ROCKCHIP_RK3128) +=3D rk3128/
> > > obj-$(CONFIG_ROCKCHIP_RK3188) +=3D rk3188/
> > > obj-$(CONFIG_ROCKCHIP_RK322X) +=3D rk322x/
> > > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288/
> > > obj-$(CONFIG_ROCKCHIP_RK3308) +=3D rk3308/
> > > obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328/
> > > obj-$(CONFIG_ROCKCHIP_RK3368) +=3D rk3368/
> > > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399/
> > > obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > >
> > > So we need CONFIG_SPL_BUILD when using a
> > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD option which I agree looks strange.
> > >
> > > We can't do this with my scheme:
> > >
> > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o spl_c=
ommon.o
> > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> >
> > You can't do that with any scheme, to be clear. I don't know why you're
> > mentioning it.
>=20
> Just so we have a baseline.
>=20
> >
> > > since that will compile both targets into whatever phases are enabled.
> > >
> > > To me, the ifdef I have above is less confusing than that, but I would
> > > actually prefer this:
> > >
> > > ifdef CONFIG_ROCKCHIP_COMMON_BOARD
> > > obj-$(CONFIG_SPL_BUILD) +=3D spl.o spl-boot-order.o spl_common.o
> > > obj-$(CONFIG_TPL_BUILD) +=3D tpl.o spl_common.o
> > > endif
> >
> > That would be less bad than what you've had earlier, yes. But I think
> > mine is still clearer.
>=20
> Sure.
>=20
> >
> > > Anyway, this is a strange case and I don't think it is a huge deal. In
> >
> > Yes, but it's not the only case like this, it's just the first one that
> > came to mind.
>=20
> I've not seen that sort of construct (spl-xxx +=3D ...) in U-Boot
> before, so I don't think it is common. I am sure there are others, but
> my scheme does work with existing Makefiles.

It's one of many examples of the workarounds needed for "do we want this
object in all phases or just some phases".

> > > general, when you enable an option for some phases you get that code
> > > in those phases. When you actually *don't* want the code in a
> > > particular phase, either don't set the option, or add another
> > > condition.
> >
> > And your proposal doesn't solve that problem, still. Go back up in the
> > thread and see the DWC3 example I wanted to see if was still broken, and
> > is still broken.
>=20
> What is broken about it? Are you using the old series? I don't see any
> changes to the Makefile there in my new series.

I summarized things in the email there. And yes, your series does not
address and seemingly makes even worse, the problem of
including/excluding DWC3 from different phases.

> > > After all, the current Makefile code is actually a bit of a
> > > workaround. Any scheme is going to have drawbacks.
> >
> > Yes, there's lots of workarounds. My scheme removes all of those
> > workarounds once complete. What phase is being configured and built is a
> > strict "pick 1 from N" and so we do not have CONFIG_SPL_BUILD,
> > CONFIG_TPL_BUILD, CONFIG_XPL_BUILD, etc.
>=20
> Yes, I think that's right. For the most part my scheme will do the
> same, but there will be exceptions, like the rockchip one.

If you're referring to arch/arm/mach-rockchip/Makefile that could be
rewritten, today, to be a little less cumbersome. It is still an example
of the tricky workarounds that are needed for including/excluding
objects based on phases, and is another example of how your series would
not make adding a new phase easier.

> > > With my scheme, I want to have the options for all phases in each
> > > autoconf_xpl.h so that you can check an option for one phase in
> > > another. That is part of my intent to (as now) have a single Kconfig
> > > which covers every option in every phase. The down-side of that is
> > > that you have to be aware of it.
> >
> > Yes, and we're going to violate a whole lot of  "least surprise" rules
> > by changing how something we've borrowed from a much larger and more
> > popular project works (and also how other projects which borrow it
> > work).
>=20
> I don't agree with that. Linux only builds a single build. We are
> always going to have to do more here than Linux. Also Linux has no
> interest in taking our Kbuild patches and incidentally, held out
> against FIT for 10 years! Linux will do what it wants to do. This is
> U-Boot.

Again, I am proposing we only do a single build.

And yes, this is U-Boot where one of our key attractions is "It's just
like working in the Linux Kernel, which you're likely already familiar
with". So "Ah, but CONFIG_FOO doesn't mean CONFIG_FOO!" will violate
that, badly.

> > > This did get me thinking though, whether with my scheme we could
> > > (later) change Kconfig so that there is an SPL symbol, which is only
> > > true when building SPL. Basically we would change the existing SPL to
> > > HAVE_SPL, and SPL_BUILD to SPL. But we could put the 'new' SPL into
> > > Kconfig, so you can depend on it, etc. Lots of options have 'depends
> > > on SPL' which would mean 'depends on HAVE_SPL', but we could just
> > > leave them as they are.
> > >
> > > So then you could use
> > >
> > > config SPL_ROCKCHIP_COMMON_BOARD
> > >     depends on SPL
> > >
> > > config TPL_ROCKCHIP_COMMON_BOARD
> > >     depends on TPL
> > >
> > > and this would work:
> > >
> > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o s=
pl_common.o
> > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > >
> > > But there is a down-side. Because SPL_ROCKCHIP_COMMON_BOARD is not
> > > enabled in the TPL build, TPL will not have visibility into that
> > > option. We have effectively moved closer to your scheme: still with a
> > > unified Kconfig, but completely split in the source code. Still, we
> > > can control that, by having (for example) SPL_TEXT_BASE depend on the
> > > new HAVE_SPL instead of SPL. That way, CONFIG_SPL_TEXT_BASE it will
> > > appear in all builds.
> >
> > Yes, that sounds like it will make some of the existing complex logic
> > even more complex, and I'm not sure of the benefit.
>=20
> Trying to split the difference between our schemes. I'm going to call
> this 'option A' for my scheme.
>=20
> >
> > > We also have to run the 'conf' tool multiple times.
> >
> > And to be clear, with my scheme that's a requirement since we're only
> > building and configuring a single phase. The files I've described with
> > "PHASE:XPL:file" are a nice-to-have on top bit, and not required
> > especially if it leads to confusion while discussing things.
>=20
> Yes, understood.
>=20
> Basically I think both schemes work. At present I think we should go
> with my scheme now, since it is pretty close to being complete and
> involves minimal change to the existing Kconfig, then either do option
> A, or decide to split the Kconfig completely, i.e. your scheme. It
> seems that you believe my scheme is worse than the status quo, though,
> right?

I think we need to come up with some way to get the community to vote on
your scheme or status quo. I don't think your scheme is "pretty close"
to being complete and I think it will make things worse than doing
nothing. I was hoping to get you to think about implementing what I
proposed instead, but since I still don't think you've understood it,
that's not an option either. But imagine you aren't interested in
hearing No and not doing it, again.

> How much work do you think your scheme would entail?

Not sure.

--=20
Tom

--ypffpNPF1NTZUe0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme3aO0ACgkQFHw5/5Y0
tyz/MQv+NKMHMXATgZWzMfHZJGTYX1ugDq2V2mmsoVLVE0LwWezr9/wuyrqM6Qh/
2f+BVsHiSFlWMRvAZoTznDAyDuaxu0Blnj4CMHMZNHsq5qMzuW2G3UOuApvgeT0z
g9SlyMy0ILATLN+aV51CVMWV4LSXfauUOt9wEpA4WyToUmlLpmTmBdw5xEZv/RD2
Wv3irHw18p6PrvDc+fs0dqFrRu40EiJSlF/B/hhczl4p8X+e//Mog54Y8GdlNJI3
BEnjjq0sF/1l6gOPBHiM2JCor7aseE1r+XvlSRyTITgx6nfG02zYQeRd8d1bwlKY
qcLmrc5gDOE3RTXyyw3w2sGOy4jZYB88ms9lLwdLIfY5uQk49N4mmQmNMDktEASq
I8yqu+lENbrPGEi5zcF8SQWFY3cFG9xMdPkjplacAL8n5z9JIJV6m1t1xG1ueHQg
AAWj3zfJff8+dyUt2lmq8ms4r9wCIWHXXQVKtAwxUGQlJeB6tQ9DJa2/pelu+GYa
PNEOQaO3
=63CR
-----END PGP SIGNATURE-----

--ypffpNPF1NTZUe0j--
