Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63B2C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 468EB807C4;
	Fri, 21 Feb 2025 18:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pOuWCYBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6006780F67; Fri, 21 Feb 2025 18:53:31 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D51806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fc042c9290so3999727a91.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740160405; x=1740765205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yD1Ay2zwH5e253zLvn91I9X7Ex+oUzr2Js+Bmz99w/o=;
 b=pOuWCYByoUzXIegw7Uvu5/dqyS3xZg+UBSpE4w5BvGC6jNDXkFR7XoC9xLlvjFamnG
 8Kc+lCZIX84Ia+4vhZzxIZ3bWu+y0PCqRLGtMji6anrsVr0/7mui3PmteE8YkOuMc9pu
 NY0UZbvU1hewdID5ln1V9kUzd2g9WWD1ijLYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740160405; x=1740765205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yD1Ay2zwH5e253zLvn91I9X7Ex+oUzr2Js+Bmz99w/o=;
 b=f7RaTyrUdI5nszvwY7oSDhKd/7IdDSEMXuAEwgSfG+UuQDUAEUKYw6k8gT6yDc9Hfs
 MOexx7z5NLYjx08QHJLgt9uPnUJ+u2sJikf3BOVqqfXIfoUqbe8bHjfkcmNorGIY/HKj
 lCW6V3t2s19/WtjFC/wygQstVrLTsFBRFOEi53z6aTMvTwbFvv3vJCmIq2vcaYkoB74o
 rfw+JcmwMByUmB5tKap9oZupCvYoIv2FR8bNDZNu0aAj04bL6Jex51ULjVVYejSW0iGT
 21K+dh9Byuwh7RkUhWqCUeBzlNtFl+lpkDWWgy0IdP7p2rQsukjE9rlKXPSomLig+pLs
 bV7g==
X-Gm-Message-State: AOJu0YyAF6CwFtMr/lNT3o72S1KTkG5kEC9O43LIpXq53TYITzpR0Fn7
 7Abvi6FbyLlFvErUM2MbZ4NI/ob9HQkYZAxzIuN2ThqcXA8v94qaIkiS8zBKX7XX5ahOx1M/ABK
 5Sys=
X-Gm-Gg: ASbGnctQlvxq9qG73VbJIOQyp06PddN4YFktyAQumjRcEHMfBjpCGHmkZkQ+uI/r27v
 KNXxI35f6zx7YbM/5m+ySr+4FEX0ZHtuHSZ/yekm2up+xExhaPFKbjicDpDQCYSQyq/B0tpONID
 VK28Jqk8PGy7kBiS/GxFw/nw4zimMslvPTZEBF2oGoaSI6kMHRZgKADXtiXy6/us3nZIIMYXiNz
 CcVSpSmzMTXIKGjc0expFinROaBLQAsGUBF6nopYM9Pp2zNeea+x9tkk9Xr/qshSQdU45l5l9tT
 hiz2ZbgcRakLL0Yudarcyv6o
X-Google-Smtp-Source: AGHT+IGBrcq2KHu7Y+cuHLD3a0pmHCmxclzeBAk9wI30qNoFCrKOegUJsYDLyVWuQ6nQyMKsRsQPmA==
X-Received: by 2002:a17:90b:1e4c:b0:2ee:48bf:7dc3 with SMTP id
 98e67ed59e1d1-2fce78abbcfmr7059193a91.15.1740160404108; 
 Fri, 21 Feb 2025 09:53:24 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb05f673sm1694599a91.22.2025.02.21.09.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:53:23 -0800 (PST)
Date: Fri, 21 Feb 2025 11:53:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250221175320.GN1233568@bill-the-cat>
References: <20250219203406.GV1233568@bill-the-cat>
 <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mm2ffDHidwsKiIvf"
Content-Disposition: inline
In-Reply-To: <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
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


--Mm2ffDHidwsKiIvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Feb 2025 at 07:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 20 Feb 2025 at 10:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 20, 2025 at 09:43:10AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 20 Feb 2025 at 08:16, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Feb 20, 2025 at 06:19:05AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Wed, 19 Feb 2025 at 13:34, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Feb 19, 2025 at 07:48:17AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 18 Feb 2025 at 18:07, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -060=
0, Tom Rini wrote:
> > > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0=
700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom R=
ini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12P=
M -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, T=
om Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22=
:22PM -0600, Tom Rini wrote:
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
> > > > > > > > > > > > > > > > > > > > > > > >
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
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL =
(so no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > > > > > > > > - Likely need to introduce =
a PPL symbol as you suggest.
> > > > > > > > > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a=
 choice statement when building a defconfig.
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
> > > > > > > > > > > > > > > > > > > > > > > Lets come back up here, to my=
 proposal, since parts of it seem to have
> > > > > > > > > > > > > > > > > > > > > > > not been clear enough. While =
what I'm proposing should work for any
> > > > > > > > > > > > > > > > > > > > > > > platform and xPL -> xPL -> ..=
=2E -> PPL, for this example let us assume
> > > > > > > > > > > > > > > > > > > > > > > rockpro64-rk3399 supports the=
 flow of TPL -> SPL -> PPL. Also, to
> > > > > > > > > > > > > > > > > > > > > > > compare with today, it will b=
e helpful to run "make
> > > > > > > > > > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_cur=
rent rockpro64-rk3399_config" and have the
> > > > > > > > > > > > > > > > > > > > > > > resulting .config file availa=
ble.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > There shall be configs/rockpr=
o64-rk3399_tpl_defconfig. This will contain
> > > > > > > > > > > > > > > > > > > > > > > lines such as:
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_ARM=3Dy
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > When you run "make O=3D/tmp/r=
ockpro64-rk3399_tpl rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > > > > > > > > > > > > > > the resulting .config file wi=
ll contain lines such as:
> > > > > > > > > > > > > > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TP=
L is not set
> > > > > > > > > > > > > > > > > > > > > > > as this only makes sense in t=
he context of building something that will
> > > > > > > > > > > > > > > > > > > > > > > be TPL.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > A more complex example is tha=
t it will also contain:
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BO=
ARD=3Dy
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Because looking at arch/arm/m=
ach-rockchip/Makefile a bunch of that will
> > > > > > > > > > > > > > > > > > > > > > > be able to be simplified (and=
 spl_common.c should be renamed to
> > > > > > > > > > > > > > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COM=
MON_BOARD) +=3D spl.o spl-boot-order.o xpl_common.o
> > > > > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COM=
MON_BOARD) +=3D tpl.o xpl_common.o
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The .config file here will al=
so contain:
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > This is because there is no '=
config TPL_DM_SERIAL' option in
> > > > > > > > > > > > > > > > > > > > > > > drivers/serial/Kconfig anymor=
e.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > When you next run "make O=3D/=
tmp/rockpro64-rk3399_tpl all" the results in
> > > > > > > > > > > > > > > > > > > > > > > /tmp/rockpro64-rk3399_tpl wou=
ld be similar to the results as under
> > > > > > > > > > > > > > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" =
when building today.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The contents of configs/rockp=
ro64-rk3399_spl_defconfig would be similar
> > > > > > > > > > > > > > > > > > > > > > > to the tpl one, except with S=
PL-only-ever-valid options such as
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BO=
ARD=3Dy but otherwise have CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=
=3Dy, and when building the "all" target, you
> > > > > > > > > > > > > > > > > > > > > > > would only get similar result=
s to what is under the spl/ directory
> > > > > > > > > > > > > > > > > > > > > > > today.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Next we have configs/rockpro6=
4-rk3399_ppl_defconfig.  When you run "make
> > > > > > > > > > > > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_ppl=
 rockpro64-rk3399_ppl_defconfig" the
> > > > > > > > > > > > > > > > > > > > > > > important difference is what =
you do not have. You do not have:
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_SPL=3Dy
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Because we are not building S=
PL nor TPL. We're just making full U-Boot
> > > > > > > > > > > > > > > > > > > > > > > itself. This is where in more=
 full examples and with additional
> > > > > > > > > > > > > > > > > > > > > > > restructure a "generic-arm64_=
ppl_defconfig" makes sense and be used
> > > > > > > > > > > > > > > > > > > > > > > instead.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > This brings up what to do wit=
h "ockpro64-rk3399_defconfig". And I'm a
> > > > > > > > > > > > > > > > > > > > > > > little unsure which of the th=
ings I mentioned above is best. It's
> > > > > > > > > > > > > > > > > > > > > > > either:
> > > > > > > > > > > > > > > > > > > > > > > a) Does not exist, top-level =
Makefile says roughly:
> > > > > > > > > > > > > > > > > > > > > > > %_defconfig: %_tpl_defconfig =
%_spl_defconfig %_ppl_defconfig
> > > > > > > > > > > > > > > > > > > > > > >   make O=3D$(objdir)/tpl %_tp=
l_defconfig all
> > > > > > > > > > > > > > > > > > > > > > >   make O=3D$(objdir)/spl %_sp=
l_defconfig all
> > > > > > > > > > > > > > > > > > > > > > >   make O=3D$(objdir)/ppl %_pp=
l_defconfig all
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > > > > > > > > > > > > > b) It contains:
> > > > > > > > > > > > > > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vp=
l_defconfig
> > > > > > > > > > > > > > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tp=
l_defconfig
> > > > > > > > > > > > > > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_sp=
l_defconfig
> > > > > > > > > > > > > > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_pp=
l_defconfig
> > > > > > > > > > > > > > > > > > > > > > > And the top-level Makefile lo=
oks like:
> > > > > > > > > > > > > > > > > > > > > > > %_defconfig:
> > > > > > > > > > > > > > > > > > > > > > >   grep -q ^PHASE $@ || fatal =
"Invalid defconfig file, please see..."
> > > > > > > > > > > > > > > > > > > > > > >   foreach line in $@
> > > > > > > > > > > > > > > > > > > > > > >     make O=3D$(objdir)/$PHASE=
 $CONFIGFILE all
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > It could also be some other s=
uggestion.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Thanks for writing that up. It =
is somewhat clearer.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > What happens to the Makefiles? =
Do they still have $(PHASE_) in them?
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > No. Because CONFIG_SPL_FIT would =
never exist, $(CONFIG_$(PHASE_)FIT)
> > > > > > > > > > > > > > > > > > > > > would be meaningless. Only rockpr=
o64-rk3399_spl_defconfig would say
> > > > > > > > > > > > > > > > > > > > > CONFIG_FIT=3Dy (or more likely, o=
nly the resulting .config would say
> > > > > > > > > > > > > > > > > > > > > CONFIG_FIT=3Dy just like how conf=
igs/rockpro64-rk3399_defconfig doesn't
> > > > > > > > > > > > > > > > > > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL=
_FIT=3Dy).
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > But just above you said:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I believe this proposal will lead=
 to the code and Makefiles being less
> > > > > > > > > > > > > > > > > > > > > clear than they are today. The li=
ne:
> > > > > > > > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(P=
HASE_)BLK) +=3D block/
> > > > > > > > > > > > > > > > > > > > > will become:
> > > > > > > > > > > > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK=
) +=3D block/
> > > > > > > > > > > > > > > > > > > > > without being clear that it could=
 reference either full U-Boot (PPL) or
> > > > > > > > > > > > > > > > > > > > > some xPL phase. While the same Ma=
kefile will continue to have (comments
> > > > > > > > > > > > > > > > > > > > > my own):
> > > > > > > > > > > > > > > > > > > > > obj-y +=3D mtd/ # Subdirectory Ma=
kefiles control build contents
> > > > > > > > > > > > > > > > > > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mu=
x/ # Only valid for PPL.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > And so the situation for humans w=
ill be worse off than today because
> > > > > > > > > > > > > > > > > > > > > while $(PHASE_) and $(XPL_) are c=
onfusing at times, they make it clear
> > > > > > > > > > > > > > > > > > > > > what can and cannot be enabled in=
 PPL vs xPL.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Doing "something" is not better t=
han doing nothing in this case.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > So why is OK for your proposal to d=
rop the $(PHASE_) stuff, but not mine?
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Because your proposal keeps CONFIG_SP=
L_BLK (and config SPL_BLK) and has
> > > > > > > > > > > > > > > > > > > a .config file which says "CONFIG_SPL=
_BLK=3Dy" but mine doesn't.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > With my
> > > > > > > > > > > > > > > > > > proposal "I have a problem, and I want =
to see what my SPL build has with
> > > > > > > > > > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the s=
ource tree for CONFIG_BLK, the
> > > > > > > > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > There will be at least some matches, e.g.=
 CONFIG_SPL_BLK in the
> > > > > > > > > > > > > > > > > defconfig files and 'config SPL_BLK' in t=
he source tree.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, and that's confusing. I am arguing tha=
t your statement is more
> > > > > > > > > > > > > > > > confusing than $(PHASE_)BLK is.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > OK
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Or to try and explain differently, wi=
th your proposal "I have a problem,
> > > > > > > > > > > > > > > > > > > and I want to see what builds with CO=
NFIG_SPL_BLK=3Dy. Why is there no
> > > > > > > > > > > > > > > > > > > match in the source tree for CONFIG_S=
PL_BLK or even SPL_BLK". With my
> > > > > > > > > > > > > > > > > > > proposal "I have a problem, and I wan=
t to see what my SPL build has with
> > > > > > > > > > > > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the=
 source tree for CONFIG_BLK, the
> > > > > > > > > > > > > > > > > > > symbol I set, I can solve my problem."
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Well, CONFIG_BLK will be in the source tr=
ee; it just means different
> > > > > > > > > > > > > > > > > things for different phases.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And it will be, with your proposal, control=
led by BLK or SPL_BLK or
> > > > > > > > > > > > > > > > TPL_BLK or VPL_BLK in the .config file but =
only CONFIG_BLK in Makefile
> > > > > > > > > > > > > > > > and code.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > It sounds like you want to get rid of the=
 xPL prefixes for Kconfig
> > > > > > > > > > > > > > > > > options, and that overrides all other con=
siderations?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > It's one of the big problems we have today,=
 and splc-working shows how
> > > > > > > > > > > > > > > > much further the duplication must go. It's =
why I suggested the language
> > > > > > > > > > > > > > > > modification before.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > My other try here was a bit unclear act=
ually because of the confusion
> > > > > > > > > > > > > > > > > > state your proposal gives us. Try try a=
gain directly, the problem is
> > > > > > > > > > > > > > > > > > that CONFIG_SPL_BLK will be set (or uns=
et) but not referenced in code.
> > > > > > > > > > > > > > > > > > This will be true for many but not all =
SPL symbols as
> > > > > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for ex=
ample will still exist and need
> > > > > > > > > > > > > > > > > > to be referenced. This is a more confus=
ing state than $(PHASE_). $(XPL_)
> > > > > > > > > > > > > > > > > > I think can just be replaced with $(PHA=
SE_) but I haven't confirmed (I
> > > > > > > > > > > > > > > > > > think it does show that the old way was=
 confusing however).
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > OK, I think I see. You don't want people =
to have to 'know' that
> > > > > > > > > > > > > > > > > CONFIG_xPL_xxx is used to control feature=
 xxx in each xPL build?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm saying they have to know that, and also=
 know which symbols that's
> > > > > > > > > > > > > > > > not true for. And that is more confusing th=
an today. I'm saying that
> > > > > > > > > > > > > > > > compared with today's arch/arm/mach-rockchi=
p/Makefile the following is
> > > > > > > > > > > > > > > > worse:
> > > > > > > > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefil=
e b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > > > > > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD)=
,)
> > > > > > > > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-inf=
o.o
> > > > > > > > > > > > > > > >  endif
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > > > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM stil=
l exist).
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And this is better:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefil=
e b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > > > > > > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > > > > > > > > @@ -7,15 +7,13 @@
> > > > > > > > > > > > > > > >  # this may have entered from ATF with the =
stack-pointer pointing to
> > > > > > > > > > > > > > > >  # inaccessible/protected memory (and the b=
ootrom-helper assumes that
> > > > > > > > > > > > > > > >  # the stack-pointer is valid before switch=
ing to the U-Boot stack).
> > > > > > > > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=
=3D bootrom.o
> > > > > > > > > > > > > > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD=
) +=3D spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=
=3D bootrom.o
> > > > > > > > > > > > > > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD=
) +=3D tpl.o spl_common.o
> > > > > > > > > > > > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-=
board-tpl.o
> > > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bo=
otrom.o
> > > > > > > > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=
=3D spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bo=
otrom.o
> > > > > > > > > > > > > > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=
=3D tpl.o spl_common.o
> > > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-boar=
d-tpl.o
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3=
036-board-spl.o
> > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUIL=
D),)
> > > > > > > > > > > > > > > > +obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-=
board-spl.o
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >  # Always include boot_mode.o, as we bypass=
 it (i.e. turn it off)
> > > > > > > > > > > > > > > >  # inside of boot_mode.c when CONFIG_ROCKCH=
IP_BOOT_MODE_REG is 0.  This way,
> > > > > > > > > > > > > > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUIL=
D)$(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > > > > >  # meaning "turn it off".
> > > > > > > > > > > > > > > >  obj-y +=3D boot_mode.o
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D b=
oard.o
> > > > > > > > > > > > > > > > -endif
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-inf=
o.o
> > > > > > > > > > > > > > > > -endif
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > > > > > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +ifdef CONFIG_PPL
> > > > > > > > > > > > > > > > +# TODO: Audit these Makefiles see if they =
really must be PPL only
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > > > > > > > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK=
3568) +=3D rk3568/
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > -# Clear out SPL objects, in case this is a=
 TPL build
> > > > > > > > > > > > > > > > -obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > -# Now add SPL/TPL objects back into the ma=
in build
> > > > > > > > > > > > > > > > -obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > > > > > > > > > > > > -obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > > > > > > > > > > > > +endif
> > > > > > > > > > > > > > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longe=
r exist as options).
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This Makefile is a very strange example. I've=
 thought about cleaning
> > > > > > > > > > > > > > > it up a few times, but then I know someone wi=
ll say it needs to be in
> > > > > > > > > > > > > > > its own series, etc. so I've never got around=
 to it. Even with the
> > > > > > > > > > > > > > > current xPL stuff (i.e. making CONFIG_SPL_BUI=
LD mean just SPL) it is
> > > > > > > > > > > > > > > needlessly complex.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > There's some complexity that can be removed her=
e today, maybe. But not a
> > > > > > > > > > > > > > lot of it, because it's complex to build three =
different things when
> > > > > > > > > > > > > > configuring once.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Anyway, with my scheme, you can still use
> > > > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want =
to. It adds SPL_ versions
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > No. You have to use it still, with yours. Becau=
se
> > > > > > > > > > > > > > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_B=
OARD" and
> > > > > > > > > > > > > > "TPL_ROCKCHIP_COMMON_BOARD" are the same concep=
t of "use common board
> > > > > > > > > > > > > > code" but different files at TPL, SPL and PPL. =
And you still have to
> > > > > > > > > > > > > > with mine, because for the same reason. With mi=
ne, the Kconfig is:
> > > > > > > > > > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > > > > > > >   bool "SPL rockchip common board file"
> > > > > > > > > > > > > >   depends on SPL
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > > > > > > >   bool "TPL rockchip common board file"
> > > > > > > > > > > > > >   depends on TPL
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And since you are only ever configuring for TPL=
 or SPL or PPL (or VPL or
> > > > > > > > > > > > > > ...) the resulting config only ever asks for th=
e appropriate one.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > of symbols to autoconf_spl.h for this reason.=
 There are also places in
> > > > > > > > > > > > > > > the code where people directly check CONFIG_S=
PL_xxx and these need to
> > > > > > > > > > > > > > > work.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, this is part of the confusion I keep notin=
g with your proposal as
> > > > > > > > > > > > > > it will be inconsistent for which symbols CONFI=
G_SPL_xxx is referred to
> > > > > > > > > > > > > > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
> > > > > > > > > > > > >
> > > > > > > > > > > > > If it is confusing, we can change all of them to =
CONFIG_xxx in a
> > > > > > > > > > > > > follow-up. There is no need to mention SPL_, it j=
ust allows the
> > > > > > > > > > > > > existing code to work without a wholesale change.
> > > > > > > > > > > >
> > > > > > > > > > > > No, that's not correct. Please look again at what I=
've written
> > > > > > > > > > > > explaining why.
> > > > > > > > > > >
> > > > > > > > > > > See below.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > > > This surprised me:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Are you saying you are OK with this one, inst=
ead of, for example:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > obj-$(CONFIG_TPL_RAM) +=3D sdram.o
> > > > > > > > > > > > > > > obj-$(CONFIG_SPL_RAM) +=3D sdram.o
> > > > > > > > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If so, why are you OK with that and not the o=
thers?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Because there is no:
> > > > > > > > > > > > > > config TPL_RAM
> > > > > > > > > > > > > >   bool "RAM driver in TPL"
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > in what I am proposing. That's why. There's one=
 symbol because there's
> > > > > > > > > > > > > > the same files being built.
> > > > > > > > > > > > >
> > > > > > > > > > > > > OK, well that works the same for my scheme too. E=
ither will do.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't see how that can work in your scheme.
> > > > > > > > > > >
> > > > > > > > > > > Here is the full Kconfig for that file, with my schem=
e:
> > > > > > > > > > >
> > > > > > > > > > > >>>>
> > > > > > > > > > > # SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > > > #
> > > > > > > > > > > # Copyright (c) 2014 Google, Inc
> > > > > > > > > > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > > > > > > > > > >
> > > > > > > > > > > # We don't want the bootrom-helper present in a full =
U-Boot build, as
> > > > > > > > > > > # this may have entered from ATF with the stack-point=
er pointing to
> > > > > > > > > > > # inaccessible/protected memory (and the bootrom-help=
er assumes that
> > > > > > > > > > > # the stack-pointer is valid before switching to the =
U-Boot stack).
> > > > > > > > > > > obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > > obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.=
o spl-boot-order.o
> > > > > > > > > > > spl_common.o
> > > > > > > > > > > obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > > > obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.=
o spl_common.o
> > > > > > > > > > > obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > > > > >
> > > > > > > > > > > obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-s=
pl.o
> > > > > > > > > > >
> > > > > > > > > > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > > > >
> > > > > > > > > > > # Always include boot_mode.o, as we bypass it (i.e. t=
urn it off)
> > > > > > > > > > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MOD=
E_REG is 0.  This way,
> > > > > > > > > > > # we can have the preprocessor correctly recognise bo=
th 0x0 and 0
> > > > > > > > > > > # meaning "turn it off".
> > > > > > > > > > > obj-y +=3D boot_mode.o
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > > > > endif
> > > > > > > > > > >
> > > > > > > > > > > ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > > > obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > > > endif
> > > > > > > > > > >
> > > > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > > > >
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3128) +=3D rk3128/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3188) +=3D rk3188/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK322X) +=3D rk322x/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3308) +=3D rk3308/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3368) +=3D rk3368/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > > > >
> > > > > > > > > > > # Clear out SPL objects, in case this is a TPL build
> > > > > > > > > > > obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > > > > > > > >
> > > > > > > > > > > # Now add SPL/TPL objects back into the main build
> > > > > > > > > > > obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > > > > > > > obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > > > > > > > <<<<
> > > > > > > > > > >
> > > > > > > > > > > The only change is the line that was:
> > > > > > > > > > > obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > > > > >
> > > > > > > > > > Yes, that's also what I showed via unified diff format =
earlier, and so I
> > > > > > > > > > agree.
> > > > > > > > >
> > > > > > > > > OK good.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > > > > For this one:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=
=3D spl.o spl-boot-order.o spl_common.o
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I don't understand how it can work with your =
scheme, since you don't
> > > > > > > > > > > > > > > want to have any CONFIG_SPL_ things?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > No, that's not what I've been saying and trying=
 to make clear with my
> > > > > > > > > > > > > > examples. I keep saying that there are explicit=
ly SPL (or TPL or VPL)
> > > > > > > > > > > > > > only options. And these need to be named as suc=
h. And so that's the
> > > > > > > > > > > > > > confusion your proposal introduces (inconsisten=
cy about referring to a
> > > > > > > > > > > > > > symbol that has been enabled) and mine removes =
entirely (we only ever
> > > > > > > > > > > > > > refer to symbols based on their name).
> > > > > > > > > > > > >
> > > > > > > > > > > > > Right, but you still have 'config SPL_RAM', right=
? Would you keep
> > > > > > > > > > > >
> > > > > > > > > > > > No, again, I do not. Please re-read my proposal as =
you seem to keep
> > > > > > > > > > > > making the same incorrect assumptions about it, and=
 then saying that
> > > > > > > > > > > > your scheme would also do that. They are very much =
not at all the same.
> > > > > > > > > > >
> > > > > > > > > > > Maybe we have reached the limits of email on this one=
, but I am quite
> > > > > > > > > > > confused about your scheme. I suggested that you don'=
t have
> > > > > > > > > > > CONFIG_SPL_ things and you said tht was wrong. Then I=
 asked if you
> > > > > > > > > > > still have SPL_RAM and you said you don't. Let me try=
 this:
> > > > > > > > > > >
> > > > > > > > > > > Q: In your scheme, do you have 'config SPL_RAM' and C=
ONFIG_SPL_RAM, or
> > > > > > > > > > > do you not?
> > > > > > > > > >
> > > > > > > > > > In my scheme we do not have 'config SPL_RAM' nor CONFIG=
_SPL_RAM as there
> > > > > > > > > > is no case where 'config RAM' and 'CONFIG_RAM' is incor=
rect. Because we
> > > > > > > > > > are never configuring and building for more than one ph=
ase.
> > > > > > > > > >
> > > > > > > > > > In my scheme we do have 'config SPL_ROCKCHIP_COMMON_BOA=
RD and
> > > > > > > > > > 'CONFIG_SPL_ROCKCHIP_COMMON_BOARD' because they are NOT=
 the same thing
> > > > > > > > > > as 'config ROCKCHIP_COMMON_BOARD' and 'CONFIG_ROCKCHIP_=
COMMON_BOARD'
> > > > > > > > > > (and again for TPL_...). They control different code. W=
hile technically
> > > > > > > > > > possible, I am arguing against overloading ROCKCHIP_COM=
MON_BOARD and
> > > > > > > > > > having the Makefile have to do some two part check like=
 we have today,
> > > > > > > > > > as those are one of the pain points of adding new code.
> > > > > > > > >
> > > > > > > > > OK I think I have some sort of understanding now.
> > > > > > > > >
> > > > > > > > > Here is the patch that works for me (on top of your patch=
 above). Note
> > > > > > > > > that we don't have to make those changes, but they show h=
ow my scheme
> > > > > > > > > is different in what it expects:
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/m=
ach-rockchip/Makefile
> > > > > > > > > index 23c30f68f87..0593e028de4 100644
> > > > > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > > > > @@ -7,27 +7,35 @@
> > > > > > > > >  # this may have entered from ATF with the stack-pointer =
pointing to
> > > > > > > > >  # inaccessible/protected memory (and the bootrom-helper =
assumes that
> > > > > > > > >  # the stack-pointer is valid before switching to the U-B=
oot stack).
> > > > > > > > > +ifdef CONFIG_XPL_BUILD
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > +endif
> > > > > > > > > +ifdef CONFIG_SPL_BUILD
> > > > > > > > >  obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-b=
oot-order.o spl_common.o
> > > > > > > > > -obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > +endif
> > > > > > > > > +ifdef CONFIG_TPL_BUILD
> > > > > > > > >  obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_c=
ommon.o
> > > > > > > > > +endif
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > > >
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > > > >
> > > > > > > > > +ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > > +
> > > > > > > > >  # Always include boot_mode.o, as we bypass it (i.e. turn=
 it off)
> > > > > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_R=
EG is 0.  This way,
> > > > > > > > >  # we can have the preprocessor correctly recognise both =
0x0 and 0
> > > > > > > > >  # meaning "turn it off".
> > > > > > > > >  obj-y +=3D boot_mode.o
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > > +endif
> > > > > > > > >
> > > > > > > > > +ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > +endif
> > > > > > > > >
> > > > > > > > >  obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > >
> > > > > > > > > -ifdef CONFIG_PPL
> > > > > > > > > -# TODO: Audit these Makefiles see if they really must be=
 PPL only
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > > @@ -43,4 +51,3 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk35=
68/
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > > -endif
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Here's the full file:
> > > > > > > > >
> > > > > > > > > # SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > #
> > > > > > > > > # Copyright (c) 2014 Google, Inc
> > > > > > > > > # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
> > > > > > > > >
> > > > > > > > > # We don't want the bootrom-helper present in a full U-Bo=
ot build, as
> > > > > > > > > # this may have entered from ATF with the stack-pointer p=
ointing to
> > > > > > > > > # inaccessible/protected memory (and the bootrom-helper a=
ssumes that
> > > > > > > > > # the stack-pointer is valid before switching to the U-Bo=
ot stack).
> > > > > > > > > ifdef CONFIG_XPL_BUILD
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > > > > endif
> > > > > > > > > ifdef CONFIG_SPL_BUILD
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-o=
rder.o spl_common.o
> > > > > > > > > endif
> > > > > > > > > ifdef CONFIG_TPL_BUILD
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common=
=2Eo
> > > > > > > > > endif
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > > > >
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > > > >
> > > > > > > > > ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > > > >
> > > > > > > > > # Always include boot_mode.o, as we bypass it (i.e. turn =
it off)
> > > > > > > > > # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_RE=
G is 0.  This way,
> > > > > > > > > # we can have the preprocessor correctly recognise both 0=
x0 and 0
> > > > > > > > > # meaning "turn it off".
> > > > > > > > > obj-y +=3D boot_mode.o
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > > > > endif
> > > > > > > > >
> > > > > > > > > ifeq ($(CONFIG_TPL_BUILD),)
> > > > > > > > > obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > > > > endif
> > > > > > > > >
> > > > > > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > > > > >
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3128) +=3D rk3128/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3188) +=3D rk3188/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK322X) +=3D rk322x/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3288) +=3D rk3288/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3308) +=3D rk3308/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3328) +=3D rk3328/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3368) +=3D rk3368/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3399) +=3D rk3399/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > > > >
> > > > > > > > > So we need CONFIG_SPL_BUILD when using a
> > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD option which I agree loo=
ks strange.
> > > > > > > > >
> > > > > > > > > We can't do this with my scheme:
> > > > > > > > >
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-o=
rder.o spl_common.o
> > > > > > > > > obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common=
=2Eo
> > > > > > > >
> > > > > > > > You can't do that with any scheme, to be clear. I don't kno=
w why you're
> > > > > > > > mentioning it.
> > > > > > >
> > > > > > > Just so we have a baseline.
> > > > > > >
> > > > > > > >
> > > > > > > > > since that will compile both targets into whatever phases=
 are enabled.
> > > > > > > > >
> > > > > > > > > To me, the ifdef I have above is less confusing than that=
, but I would
> > > > > > > > > actually prefer this:
> > > > > > > > >
> > > > > > > > > ifdef CONFIG_ROCKCHIP_COMMON_BOARD
> > > > > > > > > obj-$(CONFIG_SPL_BUILD) +=3D spl.o spl-boot-order.o spl_c=
ommon.o
> > > > > > > > > obj-$(CONFIG_TPL_BUILD) +=3D tpl.o spl_common.o
> > > > > > > > > endif
> > > > > > > >
> > > > > > > > That would be less bad than what you've had earlier, yes. B=
ut I think
> > > > > > > > mine is still clearer.
> > > > > > >
> > > > > > > Sure.
> > > > > > >
> > > > > > > >
> > > > > > > > > Anyway, this is a strange case and I don't think it is a =
huge deal. In
> > > > > > > >
> > > > > > > > Yes, but it's not the only case like this, it's just the fi=
rst one that
> > > > > > > > came to mind.
> > > > > > >
> > > > > > > I've not seen that sort of construct (spl-xxx +=3D ...) in U-=
Boot
> > > > > > > before, so I don't think it is common. I am sure there are ot=
hers, but
> > > > > > > my scheme does work with existing Makefiles.
> > > > > >
> > > > > > It's one of many examples of the workarounds needed for "do we =
want this
> > > > > > object in all phases or just some phases".
> > > > >
> > > > > You're being too negative IMO. Most of the time the right thing
> > > > > happens. Yes there are corner cases but I believe you are
> > > > > mischaracterising my scheme.
> > > >
> > > > It's the problem with the way things work today, not just your sche=
me.
> > > > It's also one of the not infrequent pain points for what we have to=
day
> > > > for including / excluding something from a given phase.
> > > >
> > > > > > > > > general, when you enable an option for some phases you ge=
t that code
> > > > > > > > > in those phases. When you actually *don't* want the code =
in a
> > > > > > > > > particular phase, either don't set the option, or add ano=
ther
> > > > > > > > > condition.
> > > > > > > >
> > > > > > > > And your proposal doesn't solve that problem, still. Go bac=
k up in the
> > > > > > > > thread and see the DWC3 example I wanted to see if was stil=
l broken, and
> > > > > > > > is still broken.
> > > > > > >
> > > > > > > What is broken about it? Are you using the old series? I don'=
t see any
> > > > > > > changes to the Makefile there in my new series.
> > > > > >
> > > > > > I summarized things in the email there. And yes, your series do=
es not
> > > > > > address and seemingly makes even worse, the problem of
> > > > > > including/excluding DWC3 from different phases.
> > > > >
> > > > > But I really don't know what is wrong with DWC3, honest! When I b=
uild
> > > > > pinebook-pro-rk3399 I don't actually see any drivers/usb in SPL,
> > > > > neither before or after my series. So can you please explain in a=
 bit
> > > > > more detail what you are getting at? The latest version is at spl=
g4 in
> > > > > my tree, although it's not finished.
> > > >
> > > > One of the first steps described in the problem statement is enabli=
ng
> > > > USB gadget for SPL only. This then blows up due to how we have / ha=
ven't
> > > > done workarounds for *USB_DWC3* symbols in Kconfig and also Makefile
> > > > logic.
> > > >
> > > > > > > > > After all, the current Makefile code is actually a bit of=
 a
> > > > > > > > > workaround. Any scheme is going to have drawbacks.
> > > > > > > >
> > > > > > > > Yes, there's lots of workarounds. My scheme removes all of =
those
> > > > > > > > workarounds once complete. What phase is being configured a=
nd built is a
> > > > > > > > strict "pick 1 from N" and so we do not have CONFIG_SPL_BUI=
LD,
> > > > > > > > CONFIG_TPL_BUILD, CONFIG_XPL_BUILD, etc.
> > > > > > >
> > > > > > > Yes, I think that's right. For the most part my scheme will d=
o the
> > > > > > > same, but there will be exceptions, like the rockchip one.
> > > > > >
> > > > > > If you're referring to arch/arm/mach-rockchip/Makefile that cou=
ld be
> > > > > > rewritten, today, to be a little less cumbersome. It is still a=
n example
> > > > > > of the tricky workarounds that are needed for including/excludi=
ng
> > > > > > objects based on phases, and is another example of how your ser=
ies would
> > > > > > not make adding a new phase easier.
> > > > >
> > > > > It makes it easier because you don't have to add loads of plumbin=
g to
> > > > > get a new phase. Also, with Kconfig changes, adding a phase could
> > > > > become just a Kconfig thing, with everything else downstream of t=
hat,
> > > > > There would be no need to add completely new Kconfig symbols for =
every
> > > > > feature.
> > > >
> > > > I guess this is what you've put up in "splg4" now? I'll refrain from
> > > > commenting until I've had a chance to see what you've done here.
> > > >
> > > > > > > > > With my scheme, I want to have the options for all phases=
 in each
> > > > > > > > > autoconf_xpl.h so that you can check an option for one ph=
ase in
> > > > > > > > > another. That is part of my intent to (as now) have a sin=
gle Kconfig
> > > > > > > > > which covers every option in every phase. The down-side o=
f that is
> > > > > > > > > that you have to be aware of it.
> > > > > > > >
> > > > > > > > Yes, and we're going to violate a whole lot of  "least surp=
rise" rules
> > > > > > > > by changing how something we've borrowed from a much larger=
 and more
> > > > > > > > popular project works (and also how other projects which bo=
rrow it
> > > > > > > > work).
> > > > > > >
> > > > > > > I don't agree with that. Linux only builds a single build. We=
 are
> > > > > > > always going to have to do more here than Linux. Also Linux h=
as no
> > > > > > > interest in taking our Kbuild patches and incidentally, held =
out
> > > > > > > against FIT for 10 years! Linux will do what it wants to do. =
This is
> > > > > > > U-Boot.
> > > > > >
> > > > > > Again, I am proposing we only do a single build.
> > > > > >
> > > > > > And yes, this is U-Boot where one of our key attractions is "It=
's just
> > > > > > like working in the Linux Kernel, which you're likely already f=
amiliar
> > > > > > with". So "Ah, but CONFIG_FOO doesn't mean CONFIG_FOO!" will vi=
olate
> > > > > > that, badly.
> > > > >
> > > > > It means CONFIG_FOO for the phase being built, the same as your
> > > > > scheme. From that POV all we are really talking about is the styl=
e of
> > > > > plumbing.
> > > > >
> > > > > If I could think of a way to express things differently in Kconfi=
g, I
> > > > > would do that. I did suggest at the start some possible extension=
s,
> > > > > but you don't want those either.
> > > >
> > > > Yes, I suggested language extensions to reduce the symbol increase =
of
> > > > "splc-working". I need to look at "splg4" now as that's apparently
> > > > entirely different before making assumptions and commenting further.
> > > >
> > > > > > > > > This did get me thinking though, whether with my scheme w=
e could
> > > > > > > > > (later) change Kconfig so that there is an SPL symbol, wh=
ich is only
> > > > > > > > > true when building SPL. Basically we would change the exi=
sting SPL to
> > > > > > > > > HAVE_SPL, and SPL_BUILD to SPL. But we could put the 'new=
' SPL into
> > > > > > > > > Kconfig, so you can depend on it, etc. Lots of options ha=
ve 'depends
> > > > > > > > > on SPL' which would mean 'depends on HAVE_SPL', but we co=
uld just
> > > > > > > > > leave them as they are.
> > > > > > > > >
> > > > > > > > > So then you could use
> > > > > > > > >
> > > > > > > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > >     depends on SPL
> > > > > > > > >
> > > > > > > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > > > > > > >     depends on TPL
> > > > > > > > >
> > > > > > > > > and this would work:
> > > > > > > > >
> > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-bo=
ot-order.o spl_common.o
> > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_co=
mmon.o
> > > > > > > > >
> > > > > > > > > But there is a down-side. Because SPL_ROCKCHIP_COMMON_BOA=
RD is not
> > > > > > > > > enabled in the TPL build, TPL will not have visibility in=
to that
> > > > > > > > > option. We have effectively moved closer to your scheme: =
still with a
> > > > > > > > > unified Kconfig, but completely split in the source code.=
 Still, we
> > > > > > > > > can control that, by having (for example) SPL_TEXT_BASE d=
epend on the
> > > > > > > > > new HAVE_SPL instead of SPL. That way, CONFIG_SPL_TEXT_BA=
SE it will
> > > > > > > > > appear in all builds.
> > > > > > > >
> > > > > > > > Yes, that sounds like it will make some of the existing com=
plex logic
> > > > > > > > even more complex, and I'm not sure of the benefit.
> > > > > > >
> > > > > > > Trying to split the difference between our schemes. I'm going=
 to call
> > > > > > > this 'option A' for my scheme.
> > > > > > >
> > > > > > > >
> > > > > > > > > We also have to run the 'conf' tool multiple times.
> > > > > > > >
> > > > > > > > And to be clear, with my scheme that's a requirement since =
we're only
> > > > > > > > building and configuring a single phase. The files I've des=
cribed with
> > > > > > > > "PHASE:XPL:file" are a nice-to-have on top bit, and not req=
uired
> > > > > > > > especially if it leads to confusion while discussing things.
> > > > > > >
> > > > > > > Yes, understood.
> > > > > > >
> > > > > > > Basically I think both schemes work. At present I think we sh=
ould go
> > > > > > > with my scheme now, since it is pretty close to being complet=
e and
> > > > > > > involves minimal change to the existing Kconfig, then either =
do option
> > > > > > > A, or decide to split the Kconfig completely, i.e. your schem=
e. It
> > > > > > > seems that you believe my scheme is worse than the status quo=
, though,
> > > > > > > right?
> > > > > >
> > > > > > I think we need to come up with some way to get the community t=
o vote on
> > > > > > your scheme or status quo. I don't think your scheme is "pretty=
 close"
> > > > > > to being complete and I think it will make things worse than do=
ing
> > > > > > nothing. I was hoping to get you to think about implementing wh=
at I
> > > > > > proposed instead, but since I still don't think you've understo=
od it,
> > > > > > that's not an option either.
> > > > >
> > > > > I just don't like splitting the defconfig into completely differe=
nt
> > > > > files. I know that will open up all sorts of issues. For example,=
 how
> > > > > will this code work?:
> > > > >
> > > > > ulong spl_get_image_text_base(void)
> > > > > {
> > > > > #ifdef CONFIG_VPL
> > > > >    if (xpl_next_phase() =3D=3D PHASE_VPL)
> > > > >       return CONFIG_VPL_TEXT_BASE;
> > > > > #endif
> > > > >    return xpl_next_phase() =3D=3D PHASE_SPL ? CONFIG_SPL_TEXT_BAS=
E :
> > > > >       CONFIG_TEXT_BASE;
> > > > > }
> > > >
> > > > Well, we start by asking why the FIT image being loaded isn't popul=
ated
> > > > with the load address being valid. And then is anyone still using
> > > > u-boot.bin and not u-boot.img and could we not just tidy away the w=
hole
> > > > function?
> > >
> > > Sure, but we can't even get sunxi bootstd or LED over the line. How do
> > > you imagine we could retire the legacy image?
> >
> > Partly by focusing on one thing and not 5 things at a time. bootstd is
> > stuck on reworking efi bootmanager integration, and LED is waiting for
> > someone to confirm that really, finally, we have all of the old use
> > cases supported in the new code.
> >
> > But more importantly, do we really have anyone not using u-boot.img? I
> > don't know.
>=20
> If we did one of these sorts of things at a time, we would only get
> 2-3 things done each year!

A project with 4 yearly releases finishing two 2-3 big changes a year
sounds great to me. Rather than not finishing a dozen things?

> > > > But then if yes we need that function, we would do:
> > > >
> > > > config PPL_TEXT_BASE
> > > >         hex "Static load address for full U-Boot, formerly TEXT_BAS=
E"
> > > >         depends on PPL || SPL
> > > >         ... current default 0xABC if BAR list for TEXT_BASE
> > > >
> > > > config TPL_TEXT_BASE
> > > >         hex "Static load address for TPL phase of U-Boot"
> > > >         depends on TPL
> > > >         ... default 0xABC if BAR list
> > > >
> > > > config VPL_TEXT_BASE
> > > >         hex "Static load address for VPL phase of U-Boot"
> > > >         depends on (TPL && SUPPORTS_VPL) || VPL
> > > >         ... default 0xABC if BAR list
> > > >
> > > > config SPL_TEXT_BASE
> > > >         hex "Static load address for SPL phase of U-Boot"
> > > >         depends on ((TPL || VPL) && SUPPORTS_SPL) || SPL
> > > >         ... current set of default 0xABC if BAR list
> > > >
> > > > ulong spl_get_image_text_base(void)
> > > > {
> > > > #if defined(CONFIG_TPL) && defined(CONFIG_SUPPORTS_VPL)
> > > >         return CONFIG_VPL_TEXT_BASE;
> > > > #elif (defined(CONFIG_TPL) || defined(CONFIG_VPL)) && \
> > > >                 defined(CONFIG_SUPPORTS_SPL)
> > > >         return CONFIG_SPL_TEXT_BASE;
> > > > #else
> > > >         return CONFIG_PPL_TEXT_BASE;
> > > > #endif
> > > > }
> > > >
> > > > And I assume one of your objections to the above is that we've remo=
ved
> > > > the macro functions that evaluate to 0 and let the optimizer discard
> > > > things (except for CC_OPTIMIZE_FOR_DEBUG related problems). But I a=
lso
> > > > see clever macros like that as a hindrance to understanding the cod=
e.
> > >
> > > Actually, my objection is that it is very confusing. Mixing TPL and
> > > VPL and SPL. We have to do this for every symbol that depends on or
> > > uses a default from another phase??
> >
> > It shouldn't be confusing. It's less confusing than the current example
> > because it doesn't rely on inline macros and test ? true : false inline
> > "if" statements.
> >
> > That said, it's also in the minority of symbols where we need some
> > *value* that we only indirectly use *and* it's not just the same value
> > and so only exists as one question at all. But finally, I was eliding
> > the default ... part there because none of these should be in a
> > defconfig and they should come from the Kconfig having the correct
> > default value. I would be strongly tempted to remove the prompt portion
> > of the entry if I could make sure the resulting failure was obvious.
>=20
> It's confusing because we have to update one phase to make a copy of
> the symbol from another phase and then keep them in sync.

The implication that these are values that should be changed and need to
therefore be kept in sync is wrong. And getting these to all be under
default X if Y will make the times when they have been and need to be
again, slightly tweaked for an SoC easier, not harder.

>=20
> The current code is much more obvious:
>=20
> ulong spl_get_image_text_base(void)
> {
> #ifdef CONFIG_VPL
>         if (xpl_next_phase() =3D=3D PHASE_VPL)
>                 return CONFIG_VPL_TEXT_BASE;
> #endif
>         return xpl_next_phase() =3D=3D PHASE_SPL ? CONFIG_SPL_TEXT_BASE :
>                 CONFIG_TEXT_BASE;
> }
>=20
> and with splg, also obvious:
>=20
> ulong spl_get_image_text_base(void)
> {
> #ifdef CONFIG_VPL
>         if (xpl_next_phase() =3D=3D PHASE_VPL)
>                 return CONFIG_VPL_TEXT_BASE;
> #endif
>         return xpl_next_phase() =3D=3D PHASE_SPL ? CONFIG_SPL_TEXT_BASE :
>                 CONFIG_PPL_TEXT_BASE;
> }

I find your functions here unclear and confusing because we are not
ever really making some run-time decision. All of the above should be
optimized at compile time down to "return static value". It's implying
there's something more at work here than there is. Getting perhaps too
deep in to the weeds, it should be an inline function, even. But I'm not
sure if the compiler will be smart enough with the way it's constructed
here, but would be with mine.

> and I suspect we could avoid #ifdef with a bit of thought.

Possibly if CONFIG_VAL() handles undefined things right, otherwise we
risk more cases of "default 0x0" in order to make compile time C checks
work when compile time cpp checks would have already worked without a
potentially incorrect default being used.

> > > > We
> > > > would also change xpl_phase() to:
> > > > static inline enum xpl_phase_t xpl_phase(void)
> > > > {
> > > > #ifdef CONFIG_TPL
> > > >         return PHASE_TPL;
> > > > #elif defined(CONFIG_VPL)
> > > >         return PHASE_VPL;
> > > > #elif defined(CONFIG_SPL)
> > > >         return PHASE_SPL;
> > > > #else
> > > >         DECLARE_GLOBAL_DATA_PTR;
> > > >
> > > >         if (!(gd->flags & GD_FLG_RELOC))
> > > >                 return PHASE_BOARD_F;
> > > >         else
> > > >                 return PHASE_BOARD_R;
> > > > #endif
> > > > }
> > > >
> > > > But could not use it above because we will not globally have *TEXT_=
BASE
> > > > defined. And I don't worry about keeping these in sync between diff=
erent
> > > > defconfig files as they are SoC dependent features. And maybe it's a
> > > > sign that my notion that we should have these defaults in the main
> > > > symbol, rather than arch/... various subdirs .../Kconfig was wrong =
and
> > > > has discouraged setting appropriate defaults. Because in this speci=
fic
> > > > example, FPGA-fun aside, it's not very arbitrary as to what address
> > > > space where is available to use when. Well Known Defaults should be
> > > > provided.
> > >
> > > I'm not sure, but yes, perhaps arch/ or even board/ is a better place.
> > >
> > > >
> > > > > > But imagine you aren't interested in
> > > > > > hearing No and not doing it, again.
> > > > >
> > > > > Not particularly, but I could just do nothing on this.
> > > >
> > > > I will look at "splg4" once it's somewhere on source.denx.de and I =
can
> > > > look at it, and refrain from otherwise assuming how it solves the
> > > > problems I had seen previously.
> > >
> > > I pushed an updated version to dm/splg-working but it is not very
> > > updated. Still needs more work.
> >
> > Thanks.
>=20
> [joining threads, sorry about sending out of turn]
> >
> >
> > > >
> > > > Actually, my objection is that it is very confusing. Mixing TPL and
> > > > VPL and SPL. We have to do this for every symbol that depends on or
> > > > uses a default from another phase??
> > >
> > > The other problem is that we have to keep these special symbols in
> > > sync manually. Or are you proposing some tools that will check that
> > > they match when the build is done?
> > >
> > > I went through one file and half of another and found these which rely
> > > on some PPL value:
> > >
> > > SPL_SILENT_CONSOLE
> > > SPL_LOG
> > > SPL_LOGLEVEL
> > > SPL_BLOBLIST
> > > SPL_ACPI
> > > SPL_CRC32
> > > SPL_SHA256
> > > SPL_SHA512
> > >
> > > It seems like we would have to do a lot of tedious and error-prone
> > > work to update things, but then we end up with something (in terms of
> > > configuration) less powerful and controllable than we have today?
>=20
> > None of those symbols would exist with what I'm proposing, so their
> > normal default is fine.
>=20
> Doesn't that mean that (before your scheme can land) you have to go
> through all the Kconfig to remove 90% of the SPL/TPL/VPL symbols from
> Kconfig?
>=20
> I'm not sure if this is accurate, but it gives an idea, just for this poi=
nt:
>=20
> $ grep -A4 "config SPL_" `find . -name "Kconfig*"` |grep -P 'depends
> on (?!SPL_)' |wc -l
> 229

Before it can land? Maybe? Maybe not? Depends on how the switchover is
done. But yes, the point I keep trying to make is that most of the work
is in updating dependencies and removing existing symbols. So yes, we
would remove nearly all SPL, TPL and VPL symbols as they duplicate
without functional difference. CONFIG_SPL_LOG and CONFIG_LOG just
control the same logging functionality. Things like
CONFIG_SPL_ROCKCHIP_COMMON_BOARD are the exception, not the rule.

> I'm really very concerned about splitting the Kconfig entirely right
> off the bat. I believe for a first step, we need to keep a 'whole'
> Kconfig and allow phases to access each others options. In other
> words, do the minimum we can to split the config and deal with the
> fallout from that, then plan the next move.
>=20
> Nothing in my scheme precludes splitting the config earlier. I do note
> your serious concerns about confusion in Makefiles but in general it
> will simplify the Makefiles and I don't see it as confusing as you do.
>=20
> I don't think I have convinced you that my scheme is a step towards
> yours, though? You are so worried about one type of confusion that you
> don't even want to go there?

I still think you don't understand what I'm proposing. So, on top of the
current splg-working, the following is valid (and needed for consistency
with other changes you made to Makefiles), right?
commit 9ba0be66daaf786895bc8672ee9c43856ac29c78
Author: Tom Rini <trini@konsulko.com>
Date:   Fri Feb 21 11:26:19 2025 -0600

    CONFIG_SPL_LIBCOMMON_SUPPORT -> CONFIG_LIBCOMMON_SUPPORT
   =20
    Signed-off-by: Tom Rini <trini@konsulko.com>

diff --git a/arch/arm/mach-davinci/spl.c b/arch/arm/mach-davinci/spl.c
index 8c6cf9c21925..5f9b04ff8489 100644
--- a/arch/arm/mach-davinci/spl.c
+++ b/arch/arm/mach-davinci/spl.c
@@ -15,7 +15,7 @@
 #include <spi_flash.h>
 #include <mmc.h>
=20
-#ifndef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifndef CONFIG_LIBCOMMON_SUPPORT
 void puts(const char *str)
 {
 	while (*str)
@@ -29,7 +29,7 @@ void putc(char c)
=20
 	ns16550_putc((struct ns16550 *)(CFG_SYS_NS16550_COM1), c);
 }
-#endif /* CONFIG_SPL_LIBCOMMON_SUPPORT */
+#endif /* CONFIG_LIBCOMMON_SUPPORT */
=20
 void board_init_f(ulong dummy)
 {
diff --git a/boot/common_fit.c b/boot/common_fit.c
index a2f9b8d83c3b..507be98055b2 100644
--- a/boot/common_fit.c
+++ b/boot/common_fit.c
@@ -53,7 +53,7 @@ int fit_find_config_node(const void *fdt)
 	     node =3D fdt_next_subnode(fdt, node)) {
 		name =3D fdt_getprop(fdt, node, "description", &len);
 		if (!name) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 			printf("%s: Missing FDT description in DTB\n",
 			       __func__);
 #endif
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 6dee03122bb7..997506041e38 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -39,7 +39,7 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
=20
 	err =3D ext4fs_mount();
 	if (!err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 		printf("%s: ext4fs mount err - %d\n", __func__, err);
 #endif
 		return -1;
@@ -55,7 +55,7 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
 	err =3D spl_load(spl_image, bootdev, &load, filelen, 0);
=20
 end:
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 	if (err < 0)
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, filename, err);
@@ -83,7 +83,7 @@ int spl_load_image_ext_os(struct spl_image_info *spl_imag=
e,
=20
 	err =3D ext4fs_mount();
 	if (!err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 		printf("%s: ext4fs mount err - %d\n", __func__, err);
 #endif
 		return -1;
@@ -128,7 +128,7 @@ defaults:
=20
 	err =3D ext4fs_read((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0, filelen, &ac=
tlen);
 	if (err < 0) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, CONFIG_SPL_FS_LOAD_ARGS_NAME, err);
 #endif
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index b6a3b9b21553..23ed87ba0f8d 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -33,7 +33,7 @@ static int spl_register_fat_device(struct blk_desc *block=
_dev, int partition)
=20
 	err =3D fat_register_device(block_dev, partition);
 	if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 		printf("%s: fat register err - %d\n", __func__, err);
 #endif
 		return err;
@@ -90,7 +90,7 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 	err =3D spl_load(spl_image, bootdev, &load, size, 0);
=20
 end:
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 	if (err < 0)
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, filename, err);
@@ -141,7 +141,7 @@ defaults:
 	err =3D file_fat_read(CONFIG_SPL_FS_LOAD_ARGS_NAME,
 			    (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
 	if (err <=3D 0) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, CONFIG_SPL_FS_LOAD_ARGS_NAME, err);
 #endif
diff --git a/common/spl/spl_usb.c b/common/spl/spl_usb.c
index bf0d57678e78..0aab2e4e4936 100644
--- a/common/spl/spl_usb.c
+++ b/common/spl/spl_usb.c
@@ -31,7 +31,7 @@ int spl_usb_load(struct spl_image_info *spl_image,
 	}
=20
 	if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#ifdef CONFIG_LIBCOMMON_SUPPORT
 		printf("%s: usb init failed: err - %d\n", __func__, err);
 #endif
 		return err;
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 83168b46cc53..dca88730a4c5 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -301,7 +301,7 @@ struct mmc *find_mmc_device(int dev_num)
 	ret =3D blk_find_device(UCLASS_MMC, dev_num, &dev);
=20
 	if (ret) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 		printf("MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
@@ -373,7 +373,7 @@ void mmc_do_preinit(void)
 	}
 }
=20
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct udevice *dev;
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 14c62f63c822..16806ea92fba 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -328,7 +328,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 			break;
=20
 		if (status & MMC_STATUS_MASK) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 			log_err("Status Error: %#08x\n", status);
 #endif
 			return -ECOMM;
@@ -341,7 +341,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 	}
=20
 	if (timeout_ms <=3D 0) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 		log_err("Timeout waiting card ready\n");
 #endif
 		return -ETIMEDOUT;
@@ -483,7 +483,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, =
lbaint_t start,
=20
 	if (blkcnt > 1) {
 		if (mmc_send_stop_transmission(mmc, false)) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 			log_err("mmc fail to send stop cmd\n");
 #endif
 			return 0;
@@ -534,7 +534,7 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t st=
art, lbaint_t blkcnt,
 		return 0;
=20
 	if ((start + blkcnt) > block_dev->lba) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 		log_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
 			start + blkcnt, block_dev->lba);
 #endif
@@ -2724,7 +2724,7 @@ static int mmc_startup(struct mmc *mmc)
 	bdesc->log2blksz =3D LOG2(bdesc->blksz);
 	bdesc->lba =3D lldiv(mmc->capacity, mmc->read_bl_len);
 #if !defined(CONFIG_XPL_BUILD) || \
-		(defined(CONFIG_SPL_LIBCOMMON_SUPPORT) && \
+		(defined(CONFIG_LIBCOMMON_SUPPORT) && \
 		!IS_ENABLED(CONFIG_USE_TINY_PRINTF))
 	sprintf(bdesc->vendor, "Man %06x Snr %04x%04x",
 		mmc->cid[0] >> 24, (mmc->cid[2] & 0xffff),
@@ -2953,7 +2953,7 @@ retry:
 		err =3D mmc_send_op_cond(mmc);
=20
 		if (err) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 			if (!quiet)
 				log_err("Card did not respond to voltage select! : %d\n",
 					err);
@@ -3008,7 +3008,7 @@ int mmc_start_init(struct mmc *mmc)
 #endif
 	if (no_card) {
 		mmc->has_init =3D 0;
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 		log_err("MMC: no card present\n");
 #endif
 		return -ENOMEDIUM;
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index 0ac092fad105..21d659e4c49d 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -44,7 +44,7 @@ struct mmc *find_mmc_device(int dev_num)
 			return m;
 	}
=20
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 	printf("MMC Device %d not found\n", dev_num);
 #endif
=20
@@ -93,7 +93,7 @@ void mmc_list_add(struct mmc *mmc)
 	list_add_tail(&mmc->link, &mmc_devices);
 }
=20
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct mmc *m;

This is the kind of confusion I strongly object to because you have and
would not be removing:
common/spl/Kconfig:config SPL_LIBCOMMON_SUPPORT
common/spl/Kconfig-	bool "Support common libraries"
--
common/spl/Kconfig.tpl:config TPL_LIBCOMMON_SUPPORT
common/spl/Kconfig.tpl-	bool "Support common libraries"
--
common/spl/Kconfig.vpl:config VPL_LIBCOMMON_SUPPORT
common/spl/Kconfig.vpl-	bool "Support common libraries"

Despite these being all of the non-config that "LIBCOMMON_SUPPORT" touches:
arch/arm/mach-davinci/spl.c
arch/arm/mach-rockchip/bootrom.c
boot/common_fit.c
common/spl/spl_ext.c
common/spl/spl_fat.c
common/spl/spl_usb.c
drivers/mmc/mmc-uclass.c
drivers/mmc/mmc.c
drivers/mmc/mmc_legacy.c
include/spl.h
lib/hang.c

And the entire reason for four symbols and $(PHASE_)LIBCOMMON_SUPPORT is
to include the same thing in yet another phase, unchanged.

In my proposal we would tidy this up to either a single:
config XPL_LIBCOMMON_SUPPORT
  bool "Support common libraries in xPL phases"
  depends on !PPL # Not valid in full U-Boot

Because we can and should use the XPL namespace for items that are
common to all of the not-PPL builds but are identical within any other
phase.

Or tidy it up to a single:
config LIBCOMMON_SUPPORT
  bool "Support common libraries in xPL phases"
  depends on !PPL # Not valid in full U-Boot

Because using the XPL namespace is too confusing inside the CONFIG
namespace.

--=20
Tom

--Mm2ffDHidwsKiIvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme4vYUACgkQFHw5/5Y0
tyzyZwv/cDNnw1tJZ2zKXKF/e/f/nyB4iAi2rnZAmY4L2514nsxM3htNvIjDSOmB
mR79jj1iZtd7DBLpvXHjFGnBemu/CJor+xc0/GK1rdx0/WpMGxVuwErMi8u9CJxF
vO+dOWC4NK0vkMCX9FDnSZO2bB5KiXIzw96WxESpQ/rLrZ6+8R671txqq8eA9yv+
jvv6N4tzapwMEhCDk4CvElgb+N7r3bi28bjL5LDFD11SJjZ7/LJKzmrPRuOGpZSM
1CagEzoEFPPvsP345EWbcx7bnB4tMI3s5zEvlKiwZITLQngq+o1YRBlo+xO0IuwD
FOHZrj/reigj4McgXRk1jvWKmfKWmupo+aX28mb9Pw8fYJcy8HLHhtM0sVlTlh8n
ItVY03x6mtFI+ZLsPuMHLMaB0lDOHC+/I+KYfkcGbOHQYpcZSVwlam2MvcdHcxXy
SVygxobYR46RT40wvrfsCbKkmQ0mOTPZ1dz/2+aAMLJjSUFi1a+R9mJzMrDDyJ+1
WHwVyUCR
=JRu2
-----END PGP SIGNATURE-----

--Mm2ffDHidwsKiIvf--
