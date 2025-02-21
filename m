Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D5DC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 14:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAEB80FAC;
	Fri, 21 Feb 2025 15:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nwNCmbOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7144880F96; Fri, 21 Feb 2025 15:19:58 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9306780F67
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 15:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220bff984a0so41813325ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 06:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740147592; x=1740752392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jCo4SLksfISxkHK7EVmjTijh+5W18WCCpCnvxkf/MTg=;
 b=nwNCmbOtRMkiiyJMXffzTCouGeqDlEKwjLUHF4MJbi0GbOvNIMSQPm+hdy1OO60m/f
 QEr2deRYwrvlBM5SD63SvAY3fFz0AX+dB9Y+I6Gv8D2Q2T6IiNZYbuzxpD3XInT1c6or
 e7dFsqT54DKaLwMpb0D6Ep34fufAY51ws0R8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740147592; x=1740752392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCo4SLksfISxkHK7EVmjTijh+5W18WCCpCnvxkf/MTg=;
 b=Ql5gV3sKo+Ml6G1rnJTOq1q3XvrEn8V4+lOFv6j90skkYB8ZORiZay6LXR0Fm00taf
 glwnyXnSZpzlVqk+7/zajq7Os8in4OJ1dIlAIZxSs46D2hEIuOd8DjwlQgUj78v7sQGj
 KpAKKEreFGx/lwrmip/3h+3tKR4Aqs4ggWxuRqdaCoA0hS7Ef9OgaR+z0DS/ZbrjfTdA
 Jea8hn4cTyhq66RQsZTlO6TZ6F3VePPKz+17VpGCMmqlG53gzqsk6MoO8i4lGuOdLhDL
 9e4tZSLbx+2OJdTZh4gQBVn0n3zh467W9/WHkxfanmE9g2pRoCLazS0Hv3qF3lDmlMoF
 kfhA==
X-Gm-Message-State: AOJu0YycCMosBXvAjSlpzovL9jTWPoTjXEVJbH8GQIlp2Ph+zVjE1TkF
 7exoh/OPYYT/YJJywEM/1xRAyJVqK0Gmp/63+GdrRkmgjhNUOXrOywTDg21aMAs=
X-Gm-Gg: ASbGncuO7zZ+z3d4LDc75qe1C+nH/bNjKtblwHb0U8lSj2H4F56rrBhqzHpJkXrPRtY
 MR0TA72oFSGjbU3D4lqeXlG8ecwTdswomCCJ3Ndja+UkXIfEE/NvwQMR0IHsfB11oOSsFn9CAFC
 oVfTpON1Bg2Pa6CpK46fLydeRLUF0BKYvuzx8TY3jcln6998K6r5kQsLGHPPMVIK85+g2IBwcXD
 DE81m8CgSUTMEbIsLA9FaJO7QDnvQJ+FSe9Y/0QnilQq42cNBfQkYESU/g4ahuW0rhQnysoEHxs
 TC8Dv8Mn6NZX/Ri/A2Y7noZj
X-Google-Smtp-Source: AGHT+IGrdR2NBBu+QUlS40wbaRij9lpWQfPxpTmqPG4/4sTHJuqyjF40jjz1M4oFv6GBlPO3EFbLxA==
X-Received: by 2002:a17:902:f686:b0:21d:3bd7:afdd with SMTP id
 d9443c01a7336-2219fdcca34mr52232935ad.0.1740147591043; 
 Fri, 21 Feb 2025 06:19:51 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349061sm138419715ad.5.2025.02.21.06.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 06:19:50 -0800 (PST)
Date: Fri, 21 Feb 2025 08:19:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250221141947.GH1233568@bill-the-cat>
References: <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
 <20250219203406.GV1233568@bill-the-cat>
 <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <CAFLszThs6zxKM11uSYvX4=Ky9e9e=f=gg73e7g6nuyuNO4auBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fyv6IaS2E8LvFFc2"
Content-Disposition: inline
In-Reply-To: <CAFLszThs6zxKM11uSYvX4=Ky9e9e=f=gg73e7g6nuyuNO4auBA@mail.gmail.com>
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


--fyv6IaS2E8LvFFc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 06:56:26AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Feb 2025 at 18:30, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 20 Feb 2025 at 10:40, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 09:43:10AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 20 Feb 2025 at 08:16, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Feb 20, 2025 at 06:19:05AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 19 Feb 2025 at 13:34, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Feb 19, 2025 at 07:48:17AM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Tue, 18 Feb 2025 at 18:07, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon G=
lass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Sim=
on Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <tri=
ni@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600,=
 Tom Rini wrote:
> > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:2=
2PM -0600, Tom Rini wrote:
> > > > > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03=
:20AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > I just wanted to send a not=
e to (re-)introduce my ideas[1] for the
> > > > > > > > > > > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > A recent series introduced =
'xPL' as the name for the various
> > > > > > > > > > > > > > > > > > > > > > > > pre-U-Boot phases, so now C=
ONFIG_XPL_BUILD means that this is any xPL
> > > > > > > > > > > > > > > > > > > > > > > > phase and CONFIG_SPL means =
this really is the SPL phase, not TPL. We
> > > > > > > > > > > > > > > > > > > > > > > > still use filenames and fun=
ction naming which uses 'spl', but could
> > > > > > > > > > > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > The major remaining problem=
 IMO is that it is quite tricky and
> > > > > > > > > > > > > > > > > > > > > > > > expensive (in terms of time=
) to add a new phase. We also have some
> > > > > > > > > > > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) r=
ules in the Makefile are visually ugly and
> > > > > > > > > > > > > > > > > > > > > > > > can be confusing, particula=
rly when combined with ifdef and ifneq
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > b. We have both CONFIG_IS_E=
NABLED() and IS_ENABLED() and they mean
> > > > > > > > > > > > > > > > > > > > > > > > different things. For any g=
iven option, some code uses one and some
> > > > > > > > > > > > > > > > > > > > > > > > the other, depending on wha=
t problems people have met along the way.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > c. An option like CONFIG_FO=
O is ambiguous, in that it could mean that
> > > > > > > > > > > > > > > > > > > > > > > > the option is enabled in on=
e or more xPL phases, or just in U-Boot
> > > > > > > > > > > > > > > > > > > > > > > > proper. The only way to kno=
w is to look for $(PHASE_) etc. in the
> > > > > > > > > > > > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENA=
BLED() in the code. This is very confusing
> > > > > > > > > > > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > d. We need to retain an imp=
ortant feature: options from different
> > > > > > > > > > > > > > > > > > > > > > > > phases can depend on each o=
ther. As an example, we might want to
> > > > > > > > > > > > > > > > > > > > > > > > enable MMC in SPL by defaul=
t, if MMC is enabled in U-Boot proper. We
> > > > > > > > > > > > > > > > > > > > > > > > may also want to share valu=
es between phases, such as TEXT_BASE. We
> > > > > > > > > > > > > > > > > > > > > > > > can do this easily today, j=
ust by adding Kconfig rules.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > I agree with a through c and =
for d there are likely some cases even if
> > > > > > > > > > > > > > > > > > > > > > > I'm not sure TEXT_BASE is a g=
ood example. But I'm not sure it's as
> > > > > > > > > > > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > 1. Adjust kconf to generate=
 separate autoconf.h files for each phase.
> > > > > > > > > > > > > > > > > > > > > > > > These contain the values fo=
r each Kconfig option for that phase. For
> > > > > > > > > > > > > > > > > > > > > > > > example CONFIG_TEXT_BASE in=
 autoconf_spl.h is SPL's text base.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > 2. Add a file to resolve th=
e ambiguity in (c) above, listing the
> > > > > > > > > > > > > > > > > > > > > > > > Kconfig options which shoul=
d not be enabled/valid in any xPL build.
> > > > > > > > > > > > > > > > > > > > > > > > There are around 200 of the=
se.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as =
a new prefix, meaning U-Boot proper (only),
> > > > > > > > > > > > > > > > > > > > > > > > useful in rare cases. This =
indicates that the option applies only to
> > > > > > > > > > > > > > > > > > > > > > > > U-Boot proper and is not de=
fined in any xPL build. It is analogous to
> > > > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'ena=
bled in TPL'. Only a dozen of these are
> > > > > > > > > > > > > > > > > > > > > > > > needed at present, basicall=
y to allow access to the value for another
> > > > > > > > > > > > > > > > > > > > > > > > phase, e.g. SPL wanting to =
find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > > > > > > > > > > > > > the address to which U-Boot=
 should be loaded.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > 4. There is no change to th=
e existing defconfig files, or 'make
> > > > > > > > > > > > > > > > > > > > > > > > menuconfig', which works ju=
st as today, including dependencies between
> > > > > > > > > > > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > 5. (next) Expand the Kconfi=
g language[2] to support declaring phases
> > > > > > > > > > > > > > > > > > > > > > > > (SPL, TPL, etc.) and remove=
 the need for duplicating options (DM_MMC,
> > > > > > > > > > > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL=
_DM_MMC), so allowing an option to be
> > > > > > > > > > > > > > > > > > > > > > > > declared once for any/all p=
hases. We can then drop the file in 2
> > > > > > > > > > > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > With this, maintaining Kcon=
fig options, Makefiles and adding a new
> > > > > > > > > > > > > > > > > > > > > > > > phase should be considerabl=
y easier.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > I think this will not make ou=
r life easier, it will make things harder.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > I think what we've reached no=
w shows that Yamada-san was correct at the
> > > > > > > > > > > > > > > > > > > > > > > time in saying that we were g=
oing down the wrong path with how we
> > > > > > > > > > > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (s=
o no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > > > > > > > - Likely need to introduce a =
PPL symbol as you suggest.
> > > > > > > > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a c=
hoice statement when building a defconfig.
> > > > > > > > > > > > > > > > > > > > > > > - Split something like rockpr=
o64-rk3399_defconfig in to
> > > > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defcon=
fig
> > > > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_spl_defcon=
fig rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > > > > > > > >   and add Makefile logic such=
 that for X_defconfig as a build target but
> > > > > > > > > > > > > > > > > > > > > > >   not configs/X_defconfig not=
 existing, we see if any of
> > > > > > > > > > > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}=
_defconfig exist and we run a builds in
> > > > > > > > > > > > > > > > > > > > > > >   subdirectories of our objec=
t directory, and then using binman combine
> > > > > > > > > > > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > > > > > > > > > > >   - Maybe instead the Makefil=
e logic above we would parse X_defconfig
> > > > > > > > > > > > > > > > > > > > > > >     and see if it's a differe=
nt format of say PHASE:file to make it
> > > > > > > > > > > > > > > > > > > > > > >     easier to say share a sin=
gle TPL config with all rk3399, have a few
> > > > > > > > > > > > > > > > > > > > > > >     common SPL configs and th=
en just a board specific PPL.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > This solves (a) by removing t=
hem entirely. This solves (b) by removing
> > > > > > > > > > > > > > > > > > > > > > > the ambiguity entirely (it wi=
ll be enabled or not). As a bonus for (b)
> > > > > > > > > > > > > > > > > > > > > > > we can switch everyone to IS_=
ENABLED(CONFIG_FOO) and match up with the
> > > > > > > > > > > > > > > > > > > > > > > Linux Kernel again. This solv=
es (c) again by removing it entirely.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Lets come back up here, to my p=
roposal, since parts of it seem to have
> > > > > > > > > > > > > > > > > > > > > > not been clear enough. While wh=
at I'm proposing should work for any
> > > > > > > > > > > > > > > > > > > > > > platform and xPL -> xPL -> ... =
-> PPL, for this example let us assume
> > > > > > > > > > > > > > > > > > > > > > rockpro64-rk3399 supports the f=
low of TPL -> SPL -> PPL. Also, to
> > > > > > > > > > > > > > > > > > > > > > compare with today, it will be =
helpful to run "make
> > > > > > > > > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_curre=
nt rockpro64-rk3399_config" and have the
> > > > > > > > > > > > > > > > > > > > > > resulting .config file availabl=
e.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > There shall be configs/rockpro6=
4-rk3399_tpl_defconfig. This will contain
> > > > > > > > > > > > > > > > > > > > > > lines such as:
> > > > > > > > > > > > > > > > > > > > > > CONFIG_ARM=3Dy
> > > > > > > > > > > > > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > > > > > > > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > When you run "make O=3D/tmp/roc=
kpro64-rk3399_tpl rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > > > > > > > > > > > > > the resulting .config file will=
 contain lines such as:
> > > > > > > > > > > > > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL =
is not set
> > > > > > > > > > > > > > > > > > > > > > as this only makes sense in the=
 context of building something that will
> > > > > > > > > > > > > > > > > > > > > > be TPL.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > A more complex example is that =
it will also contain:
> > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOAR=
D=3Dy
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Because looking at arch/arm/mac=
h-rockchip/Makefile a bunch of that will
> > > > > > > > > > > > > > > > > > > > > > be able to be simplified (and s=
pl_common.c should be renamed to
> > > > > > > > > > > > > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMO=
N_BOARD) +=3D spl.o spl-boot-order.o xpl_common.o
> > > > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMO=
N_BOARD) +=3D tpl.o xpl_common.o
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > The .config file here will also=
 contain:
> > > > > > > > > > > > > > > > > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > This is because there is no 'co=
nfig TPL_DM_SERIAL' option in
> > > > > > > > > > > > > > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > When you next run "make O=3D/tm=
p/rockpro64-rk3399_tpl all" the results in
> > > > > > > > > > > > > > > > > > > > > > /tmp/rockpro64-rk3399_tpl would=
 be similar to the results as under
> > > > > > > > > > > > > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" wh=
en building today.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > The contents of configs/rockpro=
64-rk3399_spl_defconfig would be similar
> > > > > > > > > > > > > > > > > > > > > > to the tpl one, except with SPL=
-only-ever-valid options such as
> > > > > > > > > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOAR=
D=3Dy but otherwise have CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=3Dy=
, and when building the "all" target, you
> > > > > > > > > > > > > > > > > > > > > > would only get similar results =
to what is under the spl/ directory
> > > > > > > > > > > > > > > > > > > > > > today.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Next we have configs/rockpro64-=
rk3399_ppl_defconfig.  When you run "make
> > > > > > > > > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_ppl r=
ockpro64-rk3399_ppl_defconfig" the
> > > > > > > > > > > > > > > > > > > > > > important difference is what yo=
u do not have. You do not have:
> > > > > > > > > > > > > > > > > > > > > > CONFIG_SPL=3Dy
> > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Because we are not building SPL=
 nor TPL. We're just making full U-Boot
> > > > > > > > > > > > > > > > > > > > > > itself. This is where in more f=
ull examples and with additional
> > > > > > > > > > > > > > > > > > > > > > restructure a "generic-arm64_pp=
l_defconfig" makes sense and be used
> > > > > > > > > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > This brings up what to do with =
"ockpro64-rk3399_defconfig". And I'm a
> > > > > > > > > > > > > > > > > > > > > > little unsure which of the thin=
gs I mentioned above is best. It's
> > > > > > > > > > > > > > > > > > > > > > either:
> > > > > > > > > > > > > > > > > > > > > > a) Does not exist, top-level Ma=
kefile says roughly:
> > > > > > > > > > > > > > > > > > > > > > %_defconfig: %_tpl_defconfig %_=
spl_defconfig %_ppl_defconfig
> > > > > > > > > > > > > > > > > > > > > >   make O=3D$(objdir)/tpl %_tpl_=
defconfig all
> > > > > > > > > > > > > > > > > > > > > >   make O=3D$(objdir)/spl %_spl_=
defconfig all
> > > > > > > > > > > > > > > > > > > > > >   make O=3D$(objdir)/ppl %_ppl_=
defconfig all
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > > > > > > > > > > > > b) It contains:
> > > > > > > > > > > > > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_=
defconfig
> > > > > > > > > > > > > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_=
defconfig
> > > > > > > > > > > > > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_=
defconfig
> > > > > > > > > > > > > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_=
defconfig
> > > > > > > > > > > > > > > > > > > > > > And the top-level Makefile look=
s like:
> > > > > > > > > > > > > > > > > > > > > > %_defconfig:
> > > > > > > > > > > > > > > > > > > > > >   grep -q ^PHASE $@ || fatal "I=
nvalid defconfig file, please see..."
> > > > > > > > > > > > > > > > > > > > > >   foreach line in $@
> > > > > > > > > > > > > > > > > > > > > >     make O=3D$(objdir)/$PHASE $=
CONFIGFILE all
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > It could also be some other sug=
gestion.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Thanks for writing that up. It is=
 somewhat clearer.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > What happens to the Makefiles? Do=
 they still have $(PHASE_) in them?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > No. Because CONFIG_SPL_FIT would ne=
ver exist, $(CONFIG_$(PHASE_)FIT)
> > > > > > > > > > > > > > > > > > > > would be meaningless. Only rockpro6=
4-rk3399_spl_defconfig would say
> > > > > > > > > > > > > > > > > > > > CONFIG_FIT=3Dy (or more likely, onl=
y the resulting .config would say
> > > > > > > > > > > > > > > > > > > > CONFIG_FIT=3Dy just like how config=
s/rockpro64-rk3399_defconfig doesn't
> > > > > > > > > > > > > > > > > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL_F=
IT=3Dy).
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > But just above you said:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I believe this proposal will lead t=
o the code and Makefiles being less
> > > > > > > > > > > > > > > > > > > > clear than they are today. The line:
> > > > > > > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHA=
SE_)BLK) +=3D block/
> > > > > > > > > > > > > > > > > > > > will become:
> > > > > > > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) =
+=3D block/
> > > > > > > > > > > > > > > > > > > > without being clear that it could r=
eference either full U-Boot (PPL) or
> > > > > > > > > > > > > > > > > > > > some xPL phase. While the same Make=
file will continue to have (comments
> > > > > > > > > > > > > > > > > > > > my own):
> > > > > > > > > > > > > > > > > > > > obj-y +=3D mtd/ # Subdirectory Make=
files control build contents
> > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/=
 # Only valid for PPL.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > And so the situation for humans wil=
l be worse off than today because
> > > > > > > > > > > > > > > > > > > > while $(PHASE_) and $(XPL_) are con=
fusing at times, they make it clear
> > > > > > > > > > > > > > > > > > > > what can and cannot be enabled in P=
PL vs xPL.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Doing "something" is not better tha=
n doing nothing in this case.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > So why is OK for your proposal to dro=
p the $(PHASE_) stuff, but not mine?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Because your proposal keeps CONFIG_SPL_=
BLK (and config SPL_BLK) and has
> > > > > > > > > > > > > > > > > > a .config file which says "CONFIG_SPL_B=
LK=3Dy" but mine doesn't.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > With my
> > > > > > > > > > > > > > > > > proposal "I have a problem, and I want to=
 see what my SPL build has with
> > > > > > > > > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the sou=
rce tree for CONFIG_BLK, the
> > > > > > > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > There will be at least some matches, e.g. C=
ONFIG_SPL_BLK in the
> > > > > > > > > > > > > > > > defconfig files and 'config SPL_BLK' in the=
 source tree.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, and that's confusing. I am arguing that =
your statement is more
> > > > > > > > > > > > > > > confusing than $(PHASE_)BLK is.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > OK
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Or to try and explain differently, with=
 your proposal "I have a problem,
> > > > > > > > > > > > > > > > > > and I want to see what builds with CONF=
IG_SPL_BLK=3Dy. Why is there no
> > > > > > > > > > > > > > > > > > match in the source tree for CONFIG_SPL=
_BLK or even SPL_BLK". With my
> > > > > > > > > > > > > > > > > > proposal "I have a problem, and I want =
to see what my SPL build has with
> > > > > > > > > > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the s=
ource tree for CONFIG_BLK, the
> > > > > > > > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Well, CONFIG_BLK will be in the source tree=
; it just means different
> > > > > > > > > > > > > > > > things for different phases.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And it will be, with your proposal, controlle=
d by BLK or SPL_BLK or
> > > > > > > > > > > > > > > TPL_BLK or VPL_BLK in the .config file but on=
ly CONFIG_BLK in Makefile
> > > > > > > > > > > > > > > and code.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > It sounds like you want to get rid of the x=
PL prefixes for Kconfig
> > > > > > > > > > > > > > > > options, and that overrides all other consi=
derations?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > It's one of the big problems we have today, a=
nd splc-working shows how
> > > > > > > > > > > > > > > much further the duplication must go. It's wh=
y I suggested the language
> > > > > > > > > > > > > > > modification before.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > My other try here was a bit unclear actua=
lly because of the confusion
> > > > > > > > > > > > > > > > > state your proposal gives us. Try try aga=
in directly, the problem is
> > > > > > > > > > > > > > > > > that CONFIG_SPL_BLK will be set (or unset=
) but not referenced in code.
> > > > > > > > > > > > > > > > > This will be true for many but not all SP=
L symbols as
> > > > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for exam=
ple will still exist and need
> > > > > > > > > > > > > > > > > to be referenced. This is a more confusin=
g state than $(PHASE_). $(XPL_)
> > > > > > > > > > > > > > > > > I think can just be replaced with $(PHASE=
_) but I haven't confirmed (I
> > > > > > > > > > > > > > > > > think it does show that the old way was c=
onfusing however).
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > OK, I think I see. You don't want people to=
 have to 'know' that
> > > > > > > > > > > > > > > > CONFIG_xPL_xxx is used to control feature x=
xx in each xPL build?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'm saying they have to know that, and also k=
now which symbols that's
> > > > > > > > > > > > > > > not true for. And that is more confusing than=
 today. I'm saying that
> > > > > > > > > > > > > > > compared with today's arch/arm/mach-rockchip/=
Makefile the following is
> > > > > > > > > > > > > > > worse:
> > > > > > > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile =
b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > > > > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > > > > > > >  endif
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still =
exist).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And this is better:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile =
b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > > > > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > @@ -7,15 +7,13 @@
> > > > > > > > > > > > > > >  # this may have entered from ATF with the st=
ack-pointer pointing to
> > > > > > > > > > > > > > >  # inaccessible/protected memory (and the boo=
trom-helper assumes that
> > > > > > > > > > > > > > >  # the stack-pointer is valid before switchin=
g to the U-Boot stack).
> > > > > > > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D =
bootrom.o
> > > > > > > > > > > > > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) =
+=3D spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D =
bootrom.o
> > > > > > > > > > > > > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) =
+=3D tpl.o spl_common.o
> > > > > > > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-bo=
ard-tpl.o
> > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D boot=
rom.o
> > > > > > > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D=
 spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D boot=
rom.o
> > > > > > > > > > > > > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D=
 tpl.o spl_common.o
> > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-=
tpl.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk303=
6-board-spl.o
> > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD)=
,)
> > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-bo=
ard-spl.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  # Always include boot_mode.o, as we bypass i=
t (i.e. turn it off)
> > > > > > > > > > > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP=
_BOOT_MODE_REG is 0.  This way,
> > > > > > > > > > > > > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)=
$(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > > > >  # meaning "turn it off".
> > > > > > > > > > > > > > >  obj-y +=3D boot_mode.o
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D boa=
rd.o
> > > > > > > > > > > > > > > -endif
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > > > > > > > -endif
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +ifdef CONFIG_PPL
> > > > > > > > > > > > > > > +# TODO: Audit these Makefiles see if they re=
ally must be PPL only
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > > > > > > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK35=
68) +=3D rk3568/
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > -# Clear out SPL objects, in case this is a T=
PL build
> > > > > > > > > > > > > > > -obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > -# Now add SPL/TPL objects back into the main=
 build
> > > > > > > > > > > > > > > -obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > > > > > > > > > > > -obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > > > > > > > > > > > +endif
> > > > > > > > > > > > > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer =
exist as options).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This Makefile is a very strange example. I've t=
hought about cleaning
> > > > > > > > > > > > > > it up a few times, but then I know someone will=
 say it needs to be in
> > > > > > > > > > > > > > its own series, etc. so I've never got around t=
o it. Even with the
> > > > > > > > > > > > > > current xPL stuff (i.e. making CONFIG_SPL_BUILD=
 mean just SPL) it is
> > > > > > > > > > > > > > needlessly complex.
> > > > > > > > > > > > >
> > > > > > > > > > > > > There's some complexity that can be removed here =
today, maybe. But not a
> > > > > > > > > > > > > lot of it, because it's complex to build three di=
fferent things when
> > > > > > > > > > > > > configuring once.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Anyway, with my scheme, you can still use
> > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to=
=2E It adds SPL_ versions
> > > > > > > > > > > > >
> > > > > > > > > > > > > No. You have to use it still, with yours. Because
> > > > > > > > > > > > > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOA=
RD" and
> > > > > > > > > > > > > "TPL_ROCKCHIP_COMMON_BOARD" are the same concept =
of "use common board
> > > > > > > > > > > > > code" but different files at TPL, SPL and PPL. An=
d you still have to
> > > > > > > > > > > > > with mine, because for the same reason. With mine=
, the Kconfig is:
> > > > > > > > > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > > > > > >   bool "SPL rockchip common board file"
> > > > > > > > > > > > >   depends on SPL
> > > > > > > > > > > > >
> > > > > > > > > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > > > > > >   bool "TPL rockchip common board file"
> > > > > > > > > > > > >   depends on TPL
> > > > > > > > > > > > >
> > > > > > > > > > > > > And since you are only ever configuring for TPL o=
r SPL or PPL (or VPL or
> > > > > > > > > > > > > ...) the resulting config only ever asks for the =
appropriate one.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > of symbols to autoconf_spl.h for this reason. T=
here are also places in
> > > > > > > > > > > > > > the code where people directly check CONFIG_SPL=
_xxx and these need to
> > > > > > > > > > > > > > work.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, this is part of the confusion I keep noting =
with your proposal as
> > > > > > > > > > > > > it will be inconsistent for which symbols CONFIG_=
SPL_xxx is referred to
> > > > > > > > > > > > > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
> > > > > > > > > > > >
> > > > > > > > > > > > If it is confusing, we can change all of them to CO=
NFIG_xxx in a
> > > > > > > > > > > > follow-up. There is no need to mention SPL_, it jus=
t allows the
> > > > > > > > > > > > existing code to work without a wholesale change.
> > > > > > > > > > >
> > > > > > > > > > > No, that's not correct. Please look again at what I'v=
e written
> > > > > > > > > > > explaining why.
> > > > > > > > > >
> > > > > > > > > > See below.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > > > This surprised me:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Are you saying you are OK with this one, instea=
d of, for example:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > obj-$(CONFIG_TPL_RAM) +=3D sdram.o
> > > > > > > > > > > > > > obj-$(CONFIG_SPL_RAM) +=3D sdram.o
> > > > > > > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If so, why are you OK with that and not the oth=
ers?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Because there is no:
> > > > > > > > > > > > > config TPL_RAM
> > > > > > > > > > > > >   bool "RAM driver in TPL"
> > > > > > > > > > > > >
> > > > > > > > > > > > > in what I am proposing. That's why. There's one s=
ymbol because there's
> > > > > > > > > > > > > the same files being built.
> > > > > > > > > > > >
> > > > > > > > > > > > OK, well that works the same for my scheme too. Eit=
her will do.
> > > > > > > > > > >
> > > > > > > > > > > I don't see how that can work in your scheme.
> > > > > > > > > >
> > > > > > > > > > Here is the full Kconfig for that file, with my scheme:
> > > > > > > > > >
> > > > > > > > > > >>>>
> > > > > > > > > > # SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > > #
> > > > > > > > > > # Copyright (c) 2014 Google, Inc
> > > > > > > > > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > > > > > > > > >
> > > > > > > > > > # We don't want the bootrom-helper present in a full U-=
Boot build, as
> > > > > > > > > > # this may have entered from ATF with the stack-pointer=
 pointing to
> > > > > > > > > > # inaccessible/protected memory (and the bootrom-helper=
 assumes that
> > > > > > > > > > # the stack-pointer is valid before switching to the U-=
Boot stack).
> > > > > > > > > > obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o =
spl-boot-order.o
> > > > > > > > > > spl_common.o
> > > > > > > > > > obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o =
spl_common.o
> > > > > > > > > > obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > > > >
> > > > > > > > > > obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl=
=2Eo
> > > > > > > > > >
> > > > > > > > > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > > >
> > > > > > > > > > # Always include boot_mode.o, as we bypass it (i.e. tur=
n it off)
> > > > > > > > > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_=
REG is 0.  This way,
> > > > > > > > > > # we can have the preprocessor correctly recognise both=
 0x0 and 0
> > > > > > > > > > # meaning "turn it off".
> > > > > > > > > > obj-y +=3D boot_mode.o
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > > > endif
> > > > > > > > > >
> > > > > > > > > > ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > > obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > > endif
> > > > > > > > > >
> > > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > >
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3128) +=3D rk3128/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3188) +=3D rk3188/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK322X) +=3D rk322x/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3308) +=3D rk3308/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3368) +=3D rk3368/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > > >
> > > > > > > > > > # Clear out SPL objects, in case this is a TPL build
> > > > > > > > > > obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > > > > > > >
> > > > > > > > > > # Now add SPL/TPL objects back into the main build
> > > > > > > > > > obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > > > > > > obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > > > > > > <<<<
> > > > > > > > > >
> > > > > > > > > > The only change is the line that was:
> > > > > > > > > > obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > >
> > > > > > > > > Yes, that's also what I showed via unified diff format ea=
rlier, and so I
> > > > > > > > > agree.
> > > > > > > >
> > > > > > > > OK good.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > > > > > For this one:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D=
 spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't understand how it can work with your sc=
heme, since you don't
> > > > > > > > > > > > > > want to have any CONFIG_SPL_ things?
> > > > > > > > > > > > >
> > > > > > > > > > > > > No, that's not what I've been saying and trying t=
o make clear with my
> > > > > > > > > > > > > examples. I keep saying that there are explicitly=
 SPL (or TPL or VPL)
> > > > > > > > > > > > > only options. And these need to be named as such.=
 And so that's the
> > > > > > > > > > > > > confusion your proposal introduces (inconsistency=
 about referring to a
> > > > > > > > > > > > > symbol that has been enabled) and mine removes en=
tirely (we only ever
> > > > > > > > > > > > > refer to symbols based on their name).
> > > > > > > > > > > >
> > > > > > > > > > > > Right, but you still have 'config SPL_RAM', right? =
Would you keep
> > > > > > > > > > >
> > > > > > > > > > > No, again, I do not. Please re-read my proposal as yo=
u seem to keep
> > > > > > > > > > > making the same incorrect assumptions about it, and t=
hen saying that
> > > > > > > > > > > your scheme would also do that. They are very much no=
t at all the same.
> > > > > > > > > >
> > > > > > > > > > Maybe we have reached the limits of email on this one, =
but I am quite
> > > > > > > > > > confused about your scheme. I suggested that you don't =
have
> > > > > > > > > > CONFIG_SPL_ things and you said tht was wrong. Then I a=
sked if you
> > > > > > > > > > still have SPL_RAM and you said you don't. Let me try t=
his:
> > > > > > > > > >
> > > > > > > > > > Q: In your scheme, do you have 'config SPL_RAM' and CON=
FIG_SPL_RAM, or
> > > > > > > > > > do you not?
> > > > > > > > >
> > > > > > > > > In my scheme we do not have 'config SPL_RAM' nor CONFIG_S=
PL_RAM as there
> > > > > > > > > is no case where 'config RAM' and 'CONFIG_RAM' is incorre=
ct. Because we
> > > > > > > > > are never configuring and building for more than one phas=
e.
> > > > > > > > >
> > > > > > > > > In my scheme we do have 'config SPL_ROCKCHIP_COMMON_BOARD=
 and
> > > > > > > > > 'CONFIG_SPL_ROCKCHIP_COMMON_BOARD' because they are NOT t=
he same thing
> > > > > > > > > as 'config ROCKCHIP_COMMON_BOARD' and 'CONFIG_ROCKCHIP_CO=
MMON_BOARD'
> > > > > > > > > (and again for TPL_...). They control different code. Whi=
le technically
> > > > > > > > > possible, I am arguing against overloading ROCKCHIP_COMMO=
N_BOARD and
> > > > > > > > > having the Makefile have to do some two part check like w=
e have today,
> > > > > > > > > as those are one of the pain points of adding new code.
> > > > > > > >
> > > > > > > > OK I think I have some sort of understanding now.
> > > > > > > >
> > > > > > > > Here is the patch that works for me (on top of your patch a=
bove). Note
> > > > > > > > that we don't have to make those changes, but they show how=
 my scheme
> > > > > > > > is different in what it expects:
> > > > > > > >
> > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mac=
h-rockchip/Makefile
> > > > > > > > index 23c30f68f87..0593e028de4 100644
> > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > @@ -7,27 +7,35 @@
> > > > > > > >  # this may have entered from ATF with the stack-pointer po=
inting to
> > > > > > > >  # inaccessible/protected memory (and the bootrom-helper as=
sumes that
> > > > > > > >  # the stack-pointer is valid before switching to the U-Boo=
t stack).
> > > > > > > > +ifdef CONFIG_XPL_BUILD
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > +endif
> > > > > > > > +ifdef CONFIG_SPL_BUILD
> > > > > > > >  obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boo=
t-order.o spl_common.o
> > > > > > > > -obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > +endif
> > > > > > > > +ifdef CONFIG_TPL_BUILD
> > > > > > > >  obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_com=
mon.o
> > > > > > > > +endif
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > >
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > > >
> > > > > > > > +ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > +
> > > > > > > >  # Always include boot_mode.o, as we bypass it (i.e. turn i=
t off)
> > > > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG=
 is 0.  This way,
> > > > > > > >  # we can have the preprocessor correctly recognise both 0x=
0 and 0
> > > > > > > >  # meaning "turn it off".
> > > > > > > >  obj-y +=3D boot_mode.o
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > +endif
> > > > > > > >
> > > > > > > > +ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > +endif
> > > > > > > >
> > > > > > > >  obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > >
> > > > > > > > -ifdef CONFIG_PPL
> > > > > > > > -# TODO: Audit these Makefiles see if they really must be P=
PL only
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > @@ -43,4 +51,3 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > -endif
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > > >
> > > > > > > >
> > > > > > > > Here's the full file:
> > > > > > > >
> > > > > > > > # SPDX-License-Identifier: GPL-2.0+
> > > > > > > > #
> > > > > > > > # Copyright (c) 2014 Google, Inc
> > > > > > > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > > > > > > >
> > > > > > > > # We don't want the bootrom-helper present in a full U-Boot=
 build, as
> > > > > > > > # this may have entered from ATF with the stack-pointer poi=
nting to
> > > > > > > > # inaccessible/protected memory (and the bootrom-helper ass=
umes that
> > > > > > > > # the stack-pointer is valid before switching to the U-Boot=
 stack).
> > > > > > > > ifdef CONFIG_XPL_BUILD
> > > > > > > > obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > endif
> > > > > > > > ifdef CONFIG_SPL_BUILD
> > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-ord=
er.o spl_common.o
> > > > > > > > endif
> > > > > > > > ifdef CONFIG_TPL_BUILD
> > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > > > > > > endif
> > > > > > > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > >
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > > >
> > > > > > > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > >
> > > > > > > > # Always include boot_mode.o, as we bypass it (i.e. turn it=
 off)
> > > > > > > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG =
is 0.  This way,
> > > > > > > > # we can have the preprocessor correctly recognise both 0x0=
 and 0
> > > > > > > > # meaning "turn it off".
> > > > > > > > obj-y +=3D boot_mode.o
> > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > endif
> > > > > > > >
> > > > > > > > ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > endif
> > > > > > > >
> > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > >
> > > > > > > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3128) +=3D rk3128/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3188) +=3D rk3188/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK322X) +=3D rk322x/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3308) +=3D rk3308/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3368) +=3D rk3368/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > >
> > > > > > > > So we need CONFIG_SPL_BUILD when using a
> > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD option which I agree looks=
 strange.
> > > > > > > >
> > > > > > > > We can't do this with my scheme:
> > > > > > > >
> > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-ord=
er.o spl_common.o
> > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > > > > >
> > > > > > > You can't do that with any scheme, to be clear. I don't know =
why you're
> > > > > > > mentioning it.
> > > > > >
> > > > > > Just so we have a baseline.
> > > > > >
> > > > > > >
> > > > > > > > since that will compile both targets into whatever phases a=
re enabled.
> > > > > > > >
> > > > > > > > To me, the ifdef I have above is less confusing than that, =
but I would
> > > > > > > > actually prefer this:
> > > > > > > >
> > > > > > > > ifdef CONFIG_ROCKCHIP_COMMON_BOARD
> > > > > > > > obj-$(CONFIG_SPL_BUILD) +=3D spl.o spl-boot-order.o spl_com=
mon.o
> > > > > > > > obj-$(CONFIG_TPL_BUILD) +=3D tpl.o spl_common.o
> > > > > > > > endif
> > > > > > >
> > > > > > > That would be less bad than what you've had earlier, yes. But=
 I think
> > > > > > > mine is still clearer.
> > > > > >
> > > > > > Sure.
> > > > > >
> > > > > > >
> > > > > > > > Anyway, this is a strange case and I don't think it is a hu=
ge deal. In
> > > > > > >
> > > > > > > Yes, but it's not the only case like this, it's just the firs=
t one that
> > > > > > > came to mind.
> > > > > >
> > > > > > I've not seen that sort of construct (spl-xxx +=3D ...) in U-Bo=
ot
> > > > > > before, so I don't think it is common. I am sure there are othe=
rs, but
> > > > > > my scheme does work with existing Makefiles.
> > > > >
> > > > > It's one of many examples of the workarounds needed for "do we wa=
nt this
> > > > > object in all phases or just some phases".
> > > >
> > > > You're being too negative IMO. Most of the time the right thing
> > > > happens. Yes there are corner cases but I believe you are
> > > > mischaracterising my scheme.
> > >
> > > It's the problem with the way things work today, not just your scheme.
> > > It's also one of the not infrequent pain points for what we have today
> > > for including / excluding something from a given phase.
> > >
> > > > > > > > general, when you enable an option for some phases you get =
that code
> > > > > > > > in those phases. When you actually *don't* want the code in=
 a
> > > > > > > > particular phase, either don't set the option, or add anoth=
er
> > > > > > > > condition.
> > > > > > >
> > > > > > > And your proposal doesn't solve that problem, still. Go back =
up in the
> > > > > > > thread and see the DWC3 example I wanted to see if was still =
broken, and
> > > > > > > is still broken.
> > > > > >
> > > > > > What is broken about it? Are you using the old series? I don't =
see any
> > > > > > changes to the Makefile there in my new series.
> > > > >
> > > > > I summarized things in the email there. And yes, your series does=
 not
> > > > > address and seemingly makes even worse, the problem of
> > > > > including/excluding DWC3 from different phases.
> > > >
> > > > But I really don't know what is wrong with DWC3, honest! When I bui=
ld
> > > > pinebook-pro-rk3399 I don't actually see any drivers/usb in SPL,
> > > > neither before or after my series. So can you please explain in a b=
it
> > > > more detail what you are getting at? The latest version is at splg4=
 in
> > > > my tree, although it's not finished.
> > >
> > > One of the first steps described in the problem statement is enabling
> > > USB gadget for SPL only. This then blows up due to how we have / have=
n't
> > > done workarounds for *USB_DWC3* symbols in Kconfig and also Makefile
> > > logic.
> > >
> > > > > > > > After all, the current Makefile code is actually a bit of a
> > > > > > > > workaround. Any scheme is going to have drawbacks.
> > > > > > >
> > > > > > > Yes, there's lots of workarounds. My scheme removes all of th=
ose
> > > > > > > workarounds once complete. What phase is being configured and=
 built is a
> > > > > > > strict "pick 1 from N" and so we do not have CONFIG_SPL_BUILD,
> > > > > > > CONFIG_TPL_BUILD, CONFIG_XPL_BUILD, etc.
> > > > > >
> > > > > > Yes, I think that's right. For the most part my scheme will do =
the
> > > > > > same, but there will be exceptions, like the rockchip one.
> > > > >
> > > > > If you're referring to arch/arm/mach-rockchip/Makefile that could=
 be
> > > > > rewritten, today, to be a little less cumbersome. It is still an =
example
> > > > > of the tricky workarounds that are needed for including/excluding
> > > > > objects based on phases, and is another example of how your serie=
s would
> > > > > not make adding a new phase easier.
> > > >
> > > > It makes it easier because you don't have to add loads of plumbing =
to
> > > > get a new phase. Also, with Kconfig changes, adding a phase could
> > > > become just a Kconfig thing, with everything else downstream of tha=
t,
> > > > There would be no need to add completely new Kconfig symbols for ev=
ery
> > > > feature.
> > >
> > > I guess this is what you've put up in "splg4" now? I'll refrain from
> > > commenting until I've had a chance to see what you've done here.
> > >
> > > > > > > > With my scheme, I want to have the options for all phases i=
n each
> > > > > > > > autoconf_xpl.h so that you can check an option for one phas=
e in
> > > > > > > > another. That is part of my intent to (as now) have a singl=
e Kconfig
> > > > > > > > which covers every option in every phase. The down-side of =
that is
> > > > > > > > that you have to be aware of it.
> > > > > > >
> > > > > > > Yes, and we're going to violate a whole lot of  "least surpri=
se" rules
> > > > > > > by changing how something we've borrowed from a much larger a=
nd more
> > > > > > > popular project works (and also how other projects which borr=
ow it
> > > > > > > work).
> > > > > >
> > > > > > I don't agree with that. Linux only builds a single build. We a=
re
> > > > > > always going to have to do more here than Linux. Also Linux has=
 no
> > > > > > interest in taking our Kbuild patches and incidentally, held out
> > > > > > against FIT for 10 years! Linux will do what it wants to do. Th=
is is
> > > > > > U-Boot.
> > > > >
> > > > > Again, I am proposing we only do a single build.
> > > > >
> > > > > And yes, this is U-Boot where one of our key attractions is "It's=
 just
> > > > > like working in the Linux Kernel, which you're likely already fam=
iliar
> > > > > with". So "Ah, but CONFIG_FOO doesn't mean CONFIG_FOO!" will viol=
ate
> > > > > that, badly.
> > > >
> > > > It means CONFIG_FOO for the phase being built, the same as your
> > > > scheme. From that POV all we are really talking about is the style =
of
> > > > plumbing.
> > > >
> > > > If I could think of a way to express things differently in Kconfig,=
 I
> > > > would do that. I did suggest at the start some possible extensions,
> > > > but you don't want those either.
> > >
> > > Yes, I suggested language extensions to reduce the symbol increase of
> > > "splc-working". I need to look at "splg4" now as that's apparently
> > > entirely different before making assumptions and commenting further.
> > >
> > > > > > > > This did get me thinking though, whether with my scheme we =
could
> > > > > > > > (later) change Kconfig so that there is an SPL symbol, whic=
h is only
> > > > > > > > true when building SPL. Basically we would change the exist=
ing SPL to
> > > > > > > > HAVE_SPL, and SPL_BUILD to SPL. But we could put the 'new' =
SPL into
> > > > > > > > Kconfig, so you can depend on it, etc. Lots of options have=
 'depends
> > > > > > > > on SPL' which would mean 'depends on HAVE_SPL', but we coul=
d just
> > > > > > > > leave them as they are.
> > > > > > > >
> > > > > > > > So then you could use
> > > > > > > >
> > > > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > > > >     depends on SPL
> > > > > > > >
> > > > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > > > >     depends on TPL
> > > > > > > >
> > > > > > > > and this would work:
> > > > > > > >
> > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot=
-order.o spl_common.o
> > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_comm=
on.o
> > > > > > > >
> > > > > > > > But there is a down-side. Because SPL_ROCKCHIP_COMMON_BOARD=
 is not
> > > > > > > > enabled in the TPL build, TPL will not have visibility into=
 that
> > > > > > > > option. We have effectively moved closer to your scheme: st=
ill with a
> > > > > > > > unified Kconfig, but completely split in the source code. S=
till, we
> > > > > > > > can control that, by having (for example) SPL_TEXT_BASE dep=
end on the
> > > > > > > > new HAVE_SPL instead of SPL. That way, CONFIG_SPL_TEXT_BASE=
 it will
> > > > > > > > appear in all builds.
> > > > > > >
> > > > > > > Yes, that sounds like it will make some of the existing compl=
ex logic
> > > > > > > even more complex, and I'm not sure of the benefit.
> > > > > >
> > > > > > Trying to split the difference between our schemes. I'm going t=
o call
> > > > > > this 'option A' for my scheme.
> > > > > >
> > > > > > >
> > > > > > > > We also have to run the 'conf' tool multiple times.
> > > > > > >
> > > > > > > And to be clear, with my scheme that's a requirement since we=
're only
> > > > > > > building and configuring a single phase. The files I've descr=
ibed with
> > > > > > > "PHASE:XPL:file" are a nice-to-have on top bit, and not requi=
red
> > > > > > > especially if it leads to confusion while discussing things.
> > > > > >
> > > > > > Yes, understood.
> > > > > >
> > > > > > Basically I think both schemes work. At present I think we shou=
ld go
> > > > > > with my scheme now, since it is pretty close to being complete =
and
> > > > > > involves minimal change to the existing Kconfig, then either do=
 option
> > > > > > A, or decide to split the Kconfig completely, i.e. your scheme.=
 It
> > > > > > seems that you believe my scheme is worse than the status quo, =
though,
> > > > > > right?
> > > > >
> > > > > I think we need to come up with some way to get the community to =
vote on
> > > > > your scheme or status quo. I don't think your scheme is "pretty c=
lose"
> > > > > to being complete and I think it will make things worse than doing
> > > > > nothing. I was hoping to get you to think about implementing what=
 I
> > > > > proposed instead, but since I still don't think you've understood=
 it,
> > > > > that's not an option either.
> > > >
> > > > I just don't like splitting the defconfig into completely different
> > > > files. I know that will open up all sorts of issues. For example, h=
ow
> > > > will this code work?:
> > > >
> > > > ulong spl_get_image_text_base(void)
> > > > {
> > > > #ifdef CONFIG_VPL
> > > >    if (xpl_next_phase() =3D=3D PHASE_VPL)
> > > >       return CONFIG_VPL_TEXT_BASE;
> > > > #endif
> > > >    return xpl_next_phase() =3D=3D PHASE_SPL ? CONFIG_SPL_TEXT_BASE :
> > > >       CONFIG_TEXT_BASE;
> > > > }
> > >
> > > Well, we start by asking why the FIT image being loaded isn't populat=
ed
> > > with the load address being valid. And then is anyone still using
> > > u-boot.bin and not u-boot.img and could we not just tidy away the who=
le
> > > function?
> >
> > Sure, but we can't even get sunxi bootstd or LED over the line. How do
> > you imagine we could retire the legacy image?
> >
> > >
> > > But then if yes we need that function, we would do:
> > >
> > > config PPL_TEXT_BASE
> > >         hex "Static load address for full U-Boot, formerly TEXT_BASE"
> > >         depends on PPL || SPL
> > >         ... current default 0xABC if BAR list for TEXT_BASE
> > >
> > > config TPL_TEXT_BASE
> > >         hex "Static load address for TPL phase of U-Boot"
> > >         depends on TPL
> > >         ... default 0xABC if BAR list
> > >
> > > config VPL_TEXT_BASE
> > >         hex "Static load address for VPL phase of U-Boot"
> > >         depends on (TPL && SUPPORTS_VPL) || VPL
> > >         ... default 0xABC if BAR list
> > >
> > > config SPL_TEXT_BASE
> > >         hex "Static load address for SPL phase of U-Boot"
> > >         depends on ((TPL || VPL) && SUPPORTS_SPL) || SPL
> > >         ... current set of default 0xABC if BAR list
> > >
> > > ulong spl_get_image_text_base(void)
> > > {
> > > #if defined(CONFIG_TPL) && defined(CONFIG_SUPPORTS_VPL)
> > >         return CONFIG_VPL_TEXT_BASE;
> > > #elif (defined(CONFIG_TPL) || defined(CONFIG_VPL)) && \
> > >                 defined(CONFIG_SUPPORTS_SPL)
> > >         return CONFIG_SPL_TEXT_BASE;
> > > #else
> > >         return CONFIG_PPL_TEXT_BASE;
> > > #endif
> > > }
> > >
> > > And I assume one of your objections to the above is that we've removed
> > > the macro functions that evaluate to 0 and let the optimizer discard
> > > things (except for CC_OPTIMIZE_FOR_DEBUG related problems). But I also
> > > see clever macros like that as a hindrance to understanding the code.
> >
> > Actually, my objection is that it is very confusing. Mixing TPL and
> > VPL and SPL. We have to do this for every symbol that depends on or
> > uses a default from another phase??
>=20
> The other problem is that we have to keep these special symbols in
> sync manually. Or are you proposing some tools that will check that
> they match when the build is done?
>=20
> I went through one file and half of another and found these which rely
> on some PPL value:
>=20
> SPL_SILENT_CONSOLE
> SPL_LOG
> SPL_LOGLEVEL
> SPL_BLOBLIST
> SPL_ACPI
> SPL_CRC32
> SPL_SHA256
> SPL_SHA512
>=20
> It seems like we would have to do a lot of tedious and error-prone
> work to update things, but then we end up with something (in terms of
> configuration) less powerful and controllable than we have today?

None of those symbols would exist with what I'm proposing, so their
normal default is fine.

--=20
Tom

--fyv6IaS2E8LvFFc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme4i4MACgkQFHw5/5Y0
tyzYugv/QeWqN8LzLmEnDU5MxP6OQhScXIXwEAqboCUFfAtm68MkVyV2ACfdt2w+
zhJcm7h0VQLhCHGVfIMCTwz09bJb928YzJc+bPJZ9wysm56cZuhKvz9lrvn/iGBh
nmlL+y/QTUhrvMYgXZczfFb6e0OppdCx7YrZnR+oID973fVmpI3AG8ISM4hUWx0c
yA0EeoGF3qd+fF+n6LCmUfgw6JAgOp6twDKy6Cdyk2IhDNqXOp1PTlAJsdGxNiK5
szK1RIOZOI8+U6gxKujmmpRJMWW0X0LuZiZct/wxQNhp+iwKvTlb6rh1pPuQFrP2
Qk/X/PcWkrfigjbmGjkEdNxE6bOeLz8PtM5g5MO7FBF/z9Ch22OH6R/DJM9sRCCk
YpU/v/Z0hvotkYqJaq2VaYm2mW+Goa17ZgbMLahUvDtuEBqRRM2TzHS7wvIYbYrG
ONsy97dVo34al+U/fH9yj0tp7XNKmxeIrI9cg/iT6tuL0EO1lbpM+mz4waG0dAVl
wNKPQOWm
=e+xg
-----END PGP SIGNATURE-----

--fyv6IaS2E8LvFFc2--
