Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7DDC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 15:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A1DB80F42;
	Thu, 20 Feb 2025 16:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sB/GD4AG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531088001F; Thu, 20 Feb 2025 16:16:55 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B599801BE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so27638595ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740064608; x=1740669408; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8laJggwBsKjclN4WXa8DKO6Kke3N0Ea3iBH02jUDDfY=;
 b=sB/GD4AGimkJ9l/gWJUiq1SO3DivVMlHwFGQ93qTE+vC4IUriWbu17XAgkgsW1a4iF
 IO9iOcldhEEAFTSBKtcewWZme/L1ZIn3P/NcVVYjMb7SPR7Et7bFmpQ9k+T62SOZ6uJ1
 Qrh2CLiRByTgfErxLUzc3XBE46iOMWqjJx0/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740064608; x=1740669408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8laJggwBsKjclN4WXa8DKO6Kke3N0Ea3iBH02jUDDfY=;
 b=v1eBKfzMUlFbZdnbLdNEg9dz4vMbpIi6NOFKhFABQgZPd0E94PQPet4AxYwWqGVSid
 WpeobcJrDtZ7qJ82pRlLEZk4CXOqswtEx+NuOkYacNgZnEV//3I75+XdzR0WphMQx57i
 W/7edMisGV+/+I+tSC8SclwnxlpdakiP5CP6JCknLLLo/+Rt6vb8/Wt/EsO452eka+UY
 hnvwJBWHA7qqWVQxG4irZ4K9ByOPWfShRi97ao4dbFNzt0haaZGdKaNiBbsl3fwOy/gm
 00/HpL0SYg/ltoDmkvTvsCBUcuHZgymHq27MOxqeVaTIx5VSS/gZT4dta6vqc6+JvYqH
 Giww==
X-Gm-Message-State: AOJu0YzzcaNVG1ni84ARLfXoKVbpB5W/2Vyx8ZOmNoX2KSttiVUdHNwo
 5jMPd0Y0wgnc3BIq/I040KzRyr5+CXp4dDwccumiCscf6gK4F3k1mgQBbmNmv3c=
X-Gm-Gg: ASbGncvCoQcgIES8yqsBucPBaHjIgKuI+dfjOWreLqvpNXwkySm8LH7wT8LgpGZ3oeF
 Dow/+wJXV8fr76sQrGNzwjNF3YrBefhxxMUJJzqvvyLTj3EqPGVIPDHBA95VBTcOdP5SZqaLad9
 Y28jZ5gj8vFH9d1VpkUs0HVJ/7hERE70igai8GYKoGoedGM/TxAxjALc2Ph7YXrKSbvXLBGwoGt
 dgJxrpMSLqvCnXfARbPTagKfobJqlWPSp0JMJeNWZKx2RICYO8xkNOlocOVDZa48gWdnlUaxXRJ
 hTeOyFtHDhewBA==
X-Google-Smtp-Source: AGHT+IFKGVeRH43S7pcghIDkdALfgaFuxCHoxBbXTezZgFhaclCpBiGKE8zpP/FQqIGaPf6LJq7Utg==
X-Received: by 2002:a05:6a21:3994:b0:1ee:d515:c6ed with SMTP id
 adf61e73a8af0-1eed515cb1fmr14035289637.3.1740064607887; 
 Thu, 20 Feb 2025 07:16:47 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-addc7e25d20sm9469068a12.30.2025.02.20.07.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:16:46 -0800 (PST)
Date: Thu, 20 Feb 2025 09:16:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250220151643.GZ1233568@bill-the-cat>
References: <20250217201751.GZ1233568@bill-the-cat>
 <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
 <20250218004025.GA1233568@bill-the-cat>
 <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
 <20250218144627.GC1233568@bill-the-cat>
 <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
 <20250219010708.GS1233568@bill-the-cat>
 <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
 <20250219203406.GV1233568@bill-the-cat>
 <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ms40Ytj+EgXH8HKH"
Content-Disposition: inline
In-Reply-To: <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
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


--Ms40Ytj+EgXH8HKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 06:19:05AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Feb 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 19, 2025 at 07:48:17AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Feb 2025 at 18:07, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrot=
e:
> > > > > > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon G=
lass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom=
 Rini wrote:
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
> > > > > > > > > > > > > > > >
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
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC an=
d SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > - Likely need to introduce a PPL symbol as =
you suggest.
> > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statemen=
t when building a defconfig.
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
> > > > > > > > > > > > > > > Lets come back up here, to my proposal, since=
 parts of it seem to have
> > > > > > > > > > > > > > > not been clear enough. While what I'm proposi=
ng should work for any
> > > > > > > > > > > > > > > platform and xPL -> xPL -> ... -> PPL, for th=
is example let us assume
> > > > > > > > > > > > > > > rockpro64-rk3399 supports the flow of TPL -> =
SPL -> PPL. Also, to
> > > > > > > > > > > > > > > compare with today, it will be helpful to run=
 "make
> > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_current rockpro64-r=
k3399_config" and have the
> > > > > > > > > > > > > > > resulting .config file available.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > There shall be configs/rockpro64-rk3399_tpl_d=
efconfig. This will contain
> > > > > > > > > > > > > > > lines such as:
> > > > > > > > > > > > > > > CONFIG_ARM=3Dy
> > > > > > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > When you run "make O=3D/tmp/rockpro64-rk3399_=
tpl rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > > > > > > the resulting .config file will contain lines=
 such as:
> > > > > > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > > > > > > > as this only makes sense in the context of bu=
ilding something that will
> > > > > > > > > > > > > > > be TPL.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > A more complex example is that it will also c=
ontain:
> > > > > > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Because looking at arch/arm/mach-rockchip/Mak=
efile a bunch of that will
> > > > > > > > > > > > > > > be able to be simplified (and spl_common.c sh=
ould be renamed to
> > > > > > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D =
spl.o spl-boot-order.o xpl_common.o
> > > > > > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D =
tpl.o xpl_common.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The .config file here will also contain:
> > > > > > > > > > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This is because there is no 'config TPL_DM_SE=
RIAL' option in
> > > > > > > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > When you next run "make O=3D/tmp/rockpro64-rk=
3399_tpl all" the results in
> > > > > > > > > > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to=
 the results as under
> > > > > > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building to=
day.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The contents of configs/rockpro64-rk3399_spl_=
defconfig would be similar
> > > > > > > > > > > > > > > to the tpl one, except with SPL-only-ever-val=
id options such as
> > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but othe=
rwise have CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=3Dy, and when bui=
lding the "all" target, you
> > > > > > > > > > > > > > > would only get similar results to what is und=
er the spl/ directory
> > > > > > > > > > > > > > > today.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Next we have configs/rockpro64-rk3399_ppl_def=
config.  When you run "make
> > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk339=
9_ppl_defconfig" the
> > > > > > > > > > > > > > > important difference is what you do not have.=
 You do not have:
> > > > > > > > > > > > > > > CONFIG_SPL=3Dy
> > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Because we are not building SPL nor TPL. We'r=
e just making full U-Boot
> > > > > > > > > > > > > > > itself. This is where in more full examples a=
nd with additional
> > > > > > > > > > > > > > > restructure a "generic-arm64_ppl_defconfig" m=
akes sense and be used
> > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This brings up what to do with "ockpro64-rk33=
99_defconfig". And I'm a
> > > > > > > > > > > > > > > little unsure which of the things I mentioned=
 above is best. It's
> > > > > > > > > > > > > > > either:
> > > > > > > > > > > > > > > a) Does not exist, top-level Makefile says ro=
ughly:
> > > > > > > > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig =
%_ppl_defconfig
> > > > > > > > > > > > > > >   make O=3D$(objdir)/tpl %_tpl_defconfig all
> > > > > > > > > > > > > > >   make O=3D$(objdir)/spl %_spl_defconfig all
> > > > > > > > > > > > > > >   make O=3D$(objdir)/ppl %_ppl_defconfig all
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > > > > > b) It contains:
> > > > > > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > > > > > > > %_defconfig:
> > > > > > > > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconf=
ig file, please see..."
> > > > > > > > > > > > > > >   foreach line in $@
> > > > > > > > > > > > > > >     make O=3D$(objdir)/$PHASE $CONFIGFILE all
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > It could also be some other suggestion.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks for writing that up. It is somewhat clea=
rer.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > What happens to the Makefiles? Do they still ha=
ve $(PHASE_) in them?
> > > > > > > > > > > > >
> > > > > > > > > > > > > No. Because CONFIG_SPL_FIT would never exist, $(C=
ONFIG_$(PHASE_)FIT)
> > > > > > > > > > > > > would be meaningless. Only rockpro64-rk3399_spl_d=
efconfig would say
> > > > > > > > > > > > > CONFIG_FIT=3Dy (or more likely, only the resultin=
g .config would say
> > > > > > > > > > > > > CONFIG_FIT=3Dy just like how configs/rockpro64-rk=
3399_defconfig doesn't
> > > > > > > > > > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).
> > > > > > > > > > > >
> > > > > > > > > > > > But just above you said:
> > > > > > > > > > > >
> > > > > > > > > > > > > I believe this proposal will lead to the code and=
 Makefiles being less
> > > > > > > > > > > > > clear than they are today. The line:
> > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=3D =
block/
> > > > > > > > > > > > > will become:
> > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
> > > > > > > > > > > > > without being clear that it could reference eithe=
r full U-Boot (PPL) or
> > > > > > > > > > > > > some xPL phase. While the same Makefile will cont=
inue to have (comments
> > > > > > > > > > > > > my own):
> > > > > > > > > > > > > obj-y +=3D mtd/ # Subdirectory Makefiles control =
build contents
> > > > > > > > > > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only valid =
for PPL.
> > > > > > > > > > > > >
> > > > > > > > > > > > > And so the situation for humans will be worse off=
 than today because
> > > > > > > > > > > > > while $(PHASE_) and $(XPL_) are confusing at time=
s, they make it clear
> > > > > > > > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Doing "something" is not better than doing nothin=
g in this case.
> > > > > > > > > > > >
> > > > > > > > > > > > So why is OK for your proposal to drop the $(PHASE_=
) stuff, but not mine?
> > > > > > > > > > >
> > > > > > > > > > > Because your proposal keeps CONFIG_SPL_BLK (and confi=
g SPL_BLK) and has
> > > > > > > > > > > a .config file which says "CONFIG_SPL_BLK=3Dy" but mi=
ne doesn't.
> > > > > > > > > > >
> > > > > > > > >
> > > > > > > > > > With my
> > > > > > > > > > proposal "I have a problem, and I want to see what my S=
PL build has with
> > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree for C=
ONFIG_BLK, the
> > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > >
> > > > > > > > > There will be at least some matches, e.g. CONFIG_SPL_BLK =
in the
> > > > > > > > > defconfig files and 'config SPL_BLK' in the source tree.
> > > > > > > >
> > > > > > > > Yes, and that's confusing. I am arguing that your statement=
 is more
> > > > > > > > confusing than $(PHASE_)BLK is.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > > > > Or to try and explain differently, with your proposal=
 "I have a problem,
> > > > > > > > > > > and I want to see what builds with CONFIG_SPL_BLK=3Dy=
=2E Why is there no
> > > > > > > > > > > match in the source tree for CONFIG_SPL_BLK or even S=
PL_BLK". With my
> > > > > > > > > > > proposal "I have a problem, and I want to see what my=
 SPL build has with
> > > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree for=
 CONFIG_BLK, the
> > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > >
> > > > > > > > > Well, CONFIG_BLK will be in the source tree; it just mean=
s different
> > > > > > > > > things for different phases.
> > > > > > > >
> > > > > > > > And it will be, with your proposal, controlled by BLK or SP=
L_BLK or
> > > > > > > > TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK =
in Makefile
> > > > > > > > and code.
> > > > > > > >
> > > > > > > > > It sounds like you want to get rid of the xPL prefixes fo=
r Kconfig
> > > > > > > > > options, and that overrides all other considerations?
> > > > > > > >
> > > > > > > > It's one of the big problems we have today, and splc-workin=
g shows how
> > > > > > > > much further the duplication must go. It's why I suggested =
the language
> > > > > > > > modification before.
> > > > > > > >
> > > > > > > > > > My other try here was a bit unclear actually because of=
 the confusion
> > > > > > > > > > state your proposal gives us. Try try again directly, t=
he problem is
> > > > > > > > > > that CONFIG_SPL_BLK will be set (or unset) but not refe=
renced in code.
> > > > > > > > > > This will be true for many but not all SPL symbols as
> > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still=
 exist and need
> > > > > > > > > > to be referenced. This is a more confusing state than $=
(PHASE_). $(XPL_)
> > > > > > > > > > I think can just be replaced with $(PHASE_) but I haven=
't confirmed (I
> > > > > > > > > > think it does show that the old way was confusing howev=
er).
> > > > > > > > >
> > > > > > > > > OK, I think I see. You don't want people to have to 'know=
' that
> > > > > > > > > CONFIG_xPL_xxx is used to control feature xxx in each xPL=
 build?
> > > > > > > >
> > > > > > > > I'm saying they have to know that, and also know which symb=
ols that's
> > > > > > > > not true for. And that is more confusing than today. I'm sa=
ying that
> > > > > > > > compared with today's arch/arm/mach-rockchip/Makefile the f=
ollowing is
> > > > > > > > worse:
> > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mac=
h-rockchip/Makefile
> > > > > > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > >  endif
> > > > > > > >
> > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > >
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > >
> > > > > > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> > > > > > > >
> > > > > > > > And this is better:
> > > > > > > >
> > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mac=
h-rockchip/Makefile
> > > > > > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > @@ -7,15 +7,13 @@
> > > > > > > >  # this may have entered from ATF with the stack-pointer po=
inting to
> > > > > > > >  # inaccessible/protected memory (and the bootrom-helper as=
sumes that
> > > > > > > >  # the stack-pointer is valid before switching to the U-Boo=
t stack).
> > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl=
-boot-order.o spl_common.o
> > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl=
_common.o
> > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boo=
t-order.o spl_common.o
> > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_com=
mon.o
> > > > > > > > +obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > >
> > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > > > -
> > > > > > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > +obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > > >
> > > > > > > >  # Always include boot_mode.o, as we bypass it (i.e. turn i=
t off)
> > > > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG=
 is 0.  This way,
> > > > > > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_B=
UILD),)
> > > > > > > >  # meaning "turn it off".
> > > > > > > >  obj-y +=3D boot_mode.o
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > -endif
> > > > > > > >
> > > > > > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > -endif
> > > > > > > >
> > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > >
> > > > > > > > +ifdef CONFIG_PPL
> > > > > > > > +# TODO: Audit these Makefiles see if they really must be P=
PL only
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk356=
8/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > -
> > > > > > > > -# Clear out SPL objects, in case this is a TPL build
> > > > > > > > -obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > > > > > -
> > > > > > > > -# Now add SPL/TPL objects back into the main build
> > > > > > > > -obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > > > > -obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > > > > +endif
> > > > > > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as optio=
ns).
> > > > > > > >
> > > > > > >
> > > > > > > This Makefile is a very strange example. I've thought about c=
leaning
> > > > > > > it up a few times, but then I know someone will say it needs =
to be in
> > > > > > > its own series, etc. so I've never got around to it. Even wit=
h the
> > > > > > > current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just SPL=
) it is
> > > > > > > needlessly complex.
> > > > > >
> > > > > > There's some complexity that can be removed here today, maybe. =
But not a
> > > > > > lot of it, because it's complex to build three different things=
 when
> > > > > > configuring once.
> > > > > >
> > > > > > > Anyway, with my scheme, you can still use
> > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds SPL_=
 versions
> > > > > >
> > > > > > No. You have to use it still, with yours. Because
> > > > > > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
> > > > > > "TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use common=
 board
> > > > > > code" but different files at TPL, SPL and PPL. And you still ha=
ve to
> > > > > > with mine, because for the same reason. With mine, the Kconfig =
is:
> > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > >   bool "SPL rockchip common board file"
> > > > > >   depends on SPL
> > > > > >
> > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > >   bool "TPL rockchip common board file"
> > > > > >   depends on TPL
> > > > > >
> > > > > > And since you are only ever configuring for TPL or SPL or PPL (=
or VPL or
> > > > > > ...) the resulting config only ever asks for the appropriate on=
e.
> > > > > >
> > > > > > > of symbols to autoconf_spl.h for this reason. There are also =
places in
> > > > > > > the code where people directly check CONFIG_SPL_xxx and these=
 need to
> > > > > > > work.
> > > > > >
> > > > > > Yes, this is part of the confusion I keep noting with your prop=
osal as
> > > > > > it will be inconsistent for which symbols CONFIG_SPL_xxx is ref=
erred to
> > > > > > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
> > > > >
> > > > > If it is confusing, we can change all of them to CONFIG_xxx in a
> > > > > follow-up. There is no need to mention SPL_, it just allows the
> > > > > existing code to work without a wholesale change.
> > > >
> > > > No, that's not correct. Please look again at what I've written
> > > > explaining why.
> > >
> > > See below.
> > >
> > > >
> > > > > > > This surprised me:
> > > > > > >
> > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > >
> > > > > > > Are you saying you are OK with this one, instead of, for exam=
ple:
> > > > > > >
> > > > > > > obj-$(CONFIG_TPL_RAM) +=3D sdram.o
> > > > > > > obj-$(CONFIG_SPL_RAM) +=3D sdram.o
> > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > >
> > > > > > > If so, why are you OK with that and not the others?
> > > > > >
> > > > > > Because there is no:
> > > > > > config TPL_RAM
> > > > > >   bool "RAM driver in TPL"
> > > > > >
> > > > > > in what I am proposing. That's why. There's one symbol because =
there's
> > > > > > the same files being built.
> > > > >
> > > > > OK, well that works the same for my scheme too. Either will do.
> > > >
> > > > I don't see how that can work in your scheme.
> > >
> > > Here is the full Kconfig for that file, with my scheme:
> > >
> > > >>>>
> > > # SPDX-License-Identifier: GPL-2.0+
> > > #
> > > # Copyright (c) 2014 Google, Inc
> > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > >
> > > # We don't want the bootrom-helper present in a full U-Boot build, as
> > > # this may have entered from ATF with the stack-pointer pointing to
> > > # inaccessible/protected memory (and the bootrom-helper assumes that
> > > # the stack-pointer is valid before switching to the U-Boot stack).
> > > obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order=
=2Eo
> > > spl_common.o
> > > obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > >
> > > obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
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
> > > # Clear out SPL objects, in case this is a TPL build
> > > obj-spl-$(CONFIG_TPL_BUILD) =3D
> > >
> > > # Now add SPL/TPL objects back into the main build
> > > obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > <<<<
> > >
> > > The only change is the line that was:
> > > obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> >
> > Yes, that's also what I showed via unified diff format earlier, and so I
> > agree.
>=20
> OK good.
>=20
> >
> > > > > > > For this one:
> > > > > > >
> > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boo=
t-order.o spl_common.o
> > > > > > >
> > > > > > > I don't understand how it can work with your scheme, since yo=
u don't
> > > > > > > want to have any CONFIG_SPL_ things?
> > > > > >
> > > > > > No, that's not what I've been saying and trying to make clear w=
ith my
> > > > > > examples. I keep saying that there are explicitly SPL (or TPL o=
r VPL)
> > > > > > only options. And these need to be named as such. And so that's=
 the
> > > > > > confusion your proposal introduces (inconsistency about referri=
ng to a
> > > > > > symbol that has been enabled) and mine removes entirely (we onl=
y ever
> > > > > > refer to symbols based on their name).
> > > > >
> > > > > Right, but you still have 'config SPL_RAM', right? Would you keep
> > > >
> > > > No, again, I do not. Please re-read my proposal as you seem to keep
> > > > making the same incorrect assumptions about it, and then saying that
> > > > your scheme would also do that. They are very much not at all the s=
ame.
> > >
> > > Maybe we have reached the limits of email on this one, but I am quite
> > > confused about your scheme. I suggested that you don't have
> > > CONFIG_SPL_ things and you said tht was wrong. Then I asked if you
> > > still have SPL_RAM and you said you don't. Let me try this:
> > >
> > > Q: In your scheme, do you have 'config SPL_RAM' and CONFIG_SPL_RAM, or
> > > do you not?
> >
> > In my scheme we do not have 'config SPL_RAM' nor CONFIG_SPL_RAM as there
> > is no case where 'config RAM' and 'CONFIG_RAM' is incorrect. Because we
> > are never configuring and building for more than one phase.
> >
> > In my scheme we do have 'config SPL_ROCKCHIP_COMMON_BOARD and
> > 'CONFIG_SPL_ROCKCHIP_COMMON_BOARD' because they are NOT the same thing
> > as 'config ROCKCHIP_COMMON_BOARD' and 'CONFIG_ROCKCHIP_COMMON_BOARD'
> > (and again for TPL_...). They control different code. While technically
> > possible, I am arguing against overloading ROCKCHIP_COMMON_BOARD and
> > having the Makefile have to do some two part check like we have today,
> > as those are one of the pain points of adding new code.
>=20
> OK I think I have some sort of understanding now.
>=20
> Here is the patch that works for me (on top of your patch above). Note
> that we don't have to make those changes, but they show how my scheme
> is different in what it expects:
>=20
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Mak=
efile
> index 23c30f68f87..0593e028de4 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -7,27 +7,35 @@
>  # this may have entered from ATF with the stack-pointer pointing to
>  # inaccessible/protected memory (and the bootrom-helper assumes that
>  # the stack-pointer is valid before switching to the U-Boot stack).
> +ifdef CONFIG_XPL_BUILD
>  obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> +endif
> +ifdef CONFIG_SPL_BUILD
>  obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o spl_=
common.o
> -obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> +endif
> +ifdef CONFIG_TPL_BUILD
>  obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> +endif
>  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
>=20
>  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
>=20
> +ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> +
>  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
>  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This w=
ay,
>  # we can have the preprocessor correctly recognise both 0x0 and 0
>  # meaning "turn it off".
>  obj-y +=3D boot_mode.o
>  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> +endif
>=20
> +ifeq ($(CONFIG_TPL_BUILD),)
>  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> +endif
>=20
>  obj-$(CONFIG_RAM) +=3D sdram.o
>=20
> -ifdef CONFIG_PPL
> -# TODO: Audit these Makefiles see if they really must be PPL only
>  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
>  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
>  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> @@ -43,4 +51,3 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
>  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
>  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
>  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> -endif
> --=20
> 2.43.0
>=20
>=20
> Here's the full file:
>=20
> # SPDX-License-Identifier: GPL-2.0+
> #
> # Copyright (c) 2014 Google, Inc
> # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
>=20
> # We don't want the bootrom-helper present in a full U-Boot build, as
> # this may have entered from ATF with the stack-pointer pointing to
> # inaccessible/protected memory (and the bootrom-helper assumes that
> # the stack-pointer is valid before switching to the U-Boot stack).
> ifdef CONFIG_XPL_BUILD
> obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> endif
> ifdef CONFIG_SPL_BUILD
> obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o spl_commo=
n.o
> endif
> ifdef CONFIG_TPL_BUILD
> obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> endif
> obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
>=20
> obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
>=20
> ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>=20
> # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This wa=
y,
> # we can have the preprocessor correctly recognise both 0x0 and 0
> # meaning "turn it off".
> obj-y +=3D boot_mode.o
> obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> endif
>=20
> ifeq ($(CONFIG_TPL_BUILD),)
> obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> endif
>=20
> obj-$(CONFIG_RAM) +=3D sdram.o
>=20
> obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> obj-$(CONFIG_ROCKCHIP_RK3128) +=3D rk3128/
> obj-$(CONFIG_ROCKCHIP_RK3188) +=3D rk3188/
> obj-$(CONFIG_ROCKCHIP_RK322X) +=3D rk322x/
> obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288/
> obj-$(CONFIG_ROCKCHIP_RK3308) +=3D rk3308/
> obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328/
> obj-$(CONFIG_ROCKCHIP_RK3368) +=3D rk3368/
> obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399/
> obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
>=20
> So we need CONFIG_SPL_BUILD when using a
> CONFIG_SPL_ROCKCHIP_COMMON_BOARD option which I agree looks strange.
>=20
> We can't do this with my scheme:
>=20
> obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o spl_commo=
n.o
> obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o

You can't do that with any scheme, to be clear. I don't know why you're
mentioning it.

> since that will compile both targets into whatever phases are enabled.
>=20
> To me, the ifdef I have above is less confusing than that, but I would
> actually prefer this:
>=20
> ifdef CONFIG_ROCKCHIP_COMMON_BOARD
> obj-$(CONFIG_SPL_BUILD) +=3D spl.o spl-boot-order.o spl_common.o
> obj-$(CONFIG_TPL_BUILD) +=3D tpl.o spl_common.o
> endif

That would be less bad than what you've had earlier, yes. But I think
mine is still clearer.

> Anyway, this is a strange case and I don't think it is a huge deal. In

Yes, but it's not the only case like this, it's just the first one that
came to mind.

> general, when you enable an option for some phases you get that code
> in those phases. When you actually *don't* want the code in a
> particular phase, either don't set the option, or add another
> condition.

And your proposal doesn't solve that problem, still. Go back up in the
thread and see the DWC3 example I wanted to see if was still broken, and
is still broken.

> After all, the current Makefile code is actually a bit of a
> workaround. Any scheme is going to have drawbacks.

Yes, there's lots of workarounds. My scheme removes all of those
workarounds once complete. What phase is being configured and built is a
strict "pick 1 from N" and so we do not have CONFIG_SPL_BUILD,
CONFIG_TPL_BUILD, CONFIG_XPL_BUILD, etc.

> With my scheme, I want to have the options for all phases in each
> autoconf_xpl.h so that you can check an option for one phase in
> another. That is part of my intent to (as now) have a single Kconfig
> which covers every option in every phase. The down-side of that is
> that you have to be aware of it.

Yes, and we're going to violate a whole lot of  "least surprise" rules
by changing how something we've borrowed from a much larger and more
popular project works (and also how other projects which borrow it
work).

> This did get me thinking though, whether with my scheme we could
> (later) change Kconfig so that there is an SPL symbol, which is only
> true when building SPL. Basically we would change the existing SPL to
> HAVE_SPL, and SPL_BUILD to SPL. But we could put the 'new' SPL into
> Kconfig, so you can depend on it, etc. Lots of options have 'depends
> on SPL' which would mean 'depends on HAVE_SPL', but we could just
> leave them as they are.
>=20
> So then you could use
>=20
> config SPL_ROCKCHIP_COMMON_BOARD
>     depends on SPL
>=20
> config TPL_ROCKCHIP_COMMON_BOARD
>     depends on TPL
>=20
> and this would work:
>=20
> obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o spl_c=
ommon.o
> obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
>=20
> But there is a down-side. Because SPL_ROCKCHIP_COMMON_BOARD is not
> enabled in the TPL build, TPL will not have visibility into that
> option. We have effectively moved closer to your scheme: still with a
> unified Kconfig, but completely split in the source code. Still, we
> can control that, by having (for example) SPL_TEXT_BASE depend on the
> new HAVE_SPL instead of SPL. That way, CONFIG_SPL_TEXT_BASE it will
> appear in all builds.

Yes, that sounds like it will make some of the existing complex logic
even more complex, and I'm not sure of the benefit.

> We also have to run the 'conf' tool multiple times.

And to be clear, with my scheme that's a requirement since we're only
building and configuring a single phase. The files I've described with
"PHASE:XPL:file" are a nice-to-have on top bit, and not required
especially if it leads to confusion while discussing things.

--=20
Tom

--Ms40Ytj+EgXH8HKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme3R1gACgkQFHw5/5Y0
tywFIwv+Mg6Nyjr+xIWQ2OgNSdVPaeLdyO6827fwb+AbE/pmnra4AEwYkQDquPn8
oNIXT62dNJYU1PN0lYhwK6/T5fAt2guoJ/KUlJfGx4Yn/Zpf2+tbUsbq3Oh8Zzy1
of0z2P8rfkdNjVdsyoTItWjkEHN1vVAnhPhvExAsdCaLCXzW1Scu8C9Oz7pUWb6P
MJ1VLrSvcUT4TgSlbatTFnHpF/YPceMe+UYAa/NosfrKNx05kowJvAxHbJ6eZfwX
R55TtBwUagGSPc2UWNLq4Csy6E6zXct9G3wCeQQzkdHbQxEIOr8jJbZHAhmEJehY
XVA9x1RNo50weg+2NVmeqEPQTkFiU/6kEc2BlVuDwlVUHoZQWnn2ezgEr8hJrMbi
OEjwCHGVvbf2bBV3vJLzS6tu04rkXqqIPZujjAKOkGTPPkCp9mM53HQEkgUYkDf3
lm+8jsfSiDhHLjzHNoJKQPeWMGP285gDG0VWSXR3uo0E7CGNaQSM/tdpU5yOHcaD
3UT2tSy5
=i9SL
-----END PGP SIGNATURE-----

--Ms40Ytj+EgXH8HKH--
