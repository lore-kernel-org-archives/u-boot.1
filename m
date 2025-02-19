Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104D1C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 635CB80EBD;
	Wed, 19 Feb 2025 21:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KA4++wkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6EB800D7; Wed, 19 Feb 2025 21:34:16 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2035801BE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 21:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-221050f3f00so3138325ad.2
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 12:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739997250; x=1740602050; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jWNFFm5RV3/68RkBzve1TmKcVYYhS1Pdqkx1t41tkAw=;
 b=KA4++wkIL75NhW+LZsAEi7Yitr29ZtMNFpY9Zni71IYhDnR5PKL6g6ufzqC5NS4T8N
 +hnNjM/hRhwMMmmI+as/oBabiRd3c7cLOPba6o6k0UltqskLYynQGArJ5BoB0M4kXj/0
 2I0z3lYdxXemX4c8VB9CPlQqv066qMHTLYTRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739997250; x=1740602050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWNFFm5RV3/68RkBzve1TmKcVYYhS1Pdqkx1t41tkAw=;
 b=rC7Vxc36w3eAvO0XBnHnom7dpp6220J4DN9jgYl3tuR7DhQ5Ro4avBFznO3INkXyiT
 NiFQHEWdn5hm6LUw7mN4X6Wogph++R4lT8deZqtf1KskZgvpAIo6N4t95F+t28ymd8o0
 pEdMw7MPWIJ7bkgQxaFWt6HyM2p1+LmfICbYn7XvxzLv+8Obv9jTtuUraEfsIHurH1bc
 xPA5FzCpFmMgIB8O444ZcGvHCmNh1YDSPfRI46f+DZPR+iQrV+I59nQ61NxgzTNmC/fx
 gCPgtngiJzvCyYEDqb2XZhhsYZGTaOKvWhdtWoE1UAo7+uYKZUhi65kTCK6pKmSWiBUK
 JAxg==
X-Gm-Message-State: AOJu0Yxc10ie/n/tb/2QZ00c2IszpOSiEEvZmLa2X2FF1rlUg89ZxlkT
 c1KJ1vYvoIl1SkxgCZQRX2tEtRQifyZJP3TVFXAmafuhyP9y/d+Alb3/LxxMO74=
X-Gm-Gg: ASbGncs7mZKAghEHvBOR2ZewqlS6OJUgmPQDKfZ7/+FpdHB3j2VMGRlff5iFpcxpLdY
 I1BemR50uf01RMu7aNxknTtXiKqg7+SEV0UhZE6y+goK+AdzcWZLHVjOyMGarE+0lkypJXMAYjG
 oDTZxngEP4yu7dshO5pBxBZ+nthxlslqJjZsB48DCl0W4TFmc2PXX1+t0ZDNsHKUdNMQ62u9Kjz
 X+1SriAaXOgt4fJgKtjMGD7DkcpAvV/I7h8Z/supLENqT8JHXseYx68Uh309F6T4wTyJoqeh/N+
 D3dL2mbPa7tboA==
X-Google-Smtp-Source: AGHT+IGXQos06n6QKzPzL9yiiaJmJxbmn5bc97nxrugWzH0a4DGsNeA6VqIjsg7UEODXDj78Qaq8DA==
X-Received: by 2002:a17:903:244b:b0:221:7343:80f5 with SMTP id
 d9443c01a7336-22173438107mr93371975ad.53.1739997249879; 
 Wed, 19 Feb 2025 12:34:09 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5586141sm109718795ad.227.2025.02.19.12.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 12:34:09 -0800 (PST)
Date: Wed, 19 Feb 2025 14:34:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250219203406.GV1233568@bill-the-cat>
References: <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
 <20250217194732.GY1233568@bill-the-cat>
 <20250217201751.GZ1233568@bill-the-cat>
 <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
 <20250218004025.GA1233568@bill-the-cat>
 <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
 <20250218144627.GC1233568@bill-the-cat>
 <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
 <20250219010708.GS1233568@bill-the-cat>
 <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c2B5Np86IjSkGsUb"
Content-Disposition: inline
In-Reply-To: <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
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


--c2B5Np86IjSkGsUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 07:48:17AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Feb 2025 at 18:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> > > > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rin=
i wrote:
> > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I just wanted to send a note to (re-)introduc=
e my ideas[1] for the
> > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > A recent series introduced 'xPL' as the name =
for the various
> > > > > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD me=
ans that this is any xPL
> > > > > > > > > > > > > > > phase and CONFIG_SPL means this really is the=
 SPL phase, not TPL. We
> > > > > > > > > > > > > > > still use filenames and function naming which=
 uses 'spl', but could
> > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The major remaining problem IMO is that it is=
 quite tricky and
> > > > > > > > > > > > > > > expensive (in terms of time) to add a new pha=
se. We also have some
> > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefi=
le are visually ugly and
> > > > > > > > > > > > > > > can be confusing, particularly when combined =
with ifdef and ifneq
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_EN=
ABLED() and they mean
> > > > > > > > > > > > > > > different things. For any given option, some =
code uses one and some
> > > > > > > > > > > > > > > the other, depending on what problems people =
have met along the way.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in=
 that it could mean that
> > > > > > > > > > > > > > > the option is enabled in one or more xPL phas=
es, or just in U-Boot
> > > > > > > > > > > > > > > proper. The only way to know is to look for $=
(PHASE_) etc. in the
> > > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code=
=2E This is very confusing
> > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > d. We need to retain an important feature: op=
tions from different
> > > > > > > > > > > > > > > phases can depend on each other. As an exampl=
e, we might want to
> > > > > > > > > > > > > > > enable MMC in SPL by default, if MMC is enabl=
ed in U-Boot proper. We
> > > > > > > > > > > > > > > may also want to share values between phases,=
 such as TEXT_BASE. We
> > > > > > > > > > > > > > > can do this easily today, just by adding Kcon=
fig rules.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I agree with a through c and for d there are li=
kely some cases even if
> > > > > > > > > > > > > > I'm not sure TEXT_BASE is a good example. But I=
'm not sure it's as
> > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 1. Adjust kconf to generate separate autoconf=
=2Eh files for each phase.
> > > > > > > > > > > > > > > These contain the values for each Kconfig opt=
ion for that phase. For
> > > > > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is=
 SPL's text base.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 2. Add a file to resolve the ambiguity in (c)=
 above, listing the
> > > > > > > > > > > > > > > Kconfig options which should not be enabled/v=
alid in any xPL build.
> > > > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, mean=
ing U-Boot proper (only),
> > > > > > > > > > > > > > > useful in rare cases. This indicates that the=
 option applies only to
> > > > > > > > > > > > > > > U-Boot proper and is not defined in any xPL b=
uild. It is analogous to
> > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only=
 a dozen of these are
> > > > > > > > > > > > > > > needed at present, basically to allow access =
to the value for another
> > > > > > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TE=
XT_BASE so that it knows
> > > > > > > > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 4. There is no change to the existing defconf=
ig files, or 'make
> > > > > > > > > > > > > > > menuconfig', which works just as today, inclu=
ding dependencies between
> > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 5. (next) Expand the Kconfig language[2] to s=
upport declaring phases
> > > > > > > > > > > > > > > (SPL, TPL, etc.) and remove the need for dupl=
icating options (DM_MMC,
> > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allow=
ing an option to be
> > > > > > > > > > > > > > > declared once for any/all phases. We can then=
 drop the file in 2
> > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > With this, maintaining Kconfig options, Makef=
iles and adding a new
> > > > > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think this will not make our life easier, it =
will make things harder.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think what we've reached now shows that Yamad=
a-san was correct at the
> > > > > > > > > > > > > > time in saying that we were going down the wron=
g path with how we
> > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SP=
L_DM_MMC and so on, just
> > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > - Likely need to introduce a PPL symbol as you =
suggest.
> > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement wh=
en building a defconfig.
> > > > > > > > > > > > > > - Split something like rockpro64-rk3399_defconf=
ig in to
> > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk33=
99_tpl_defconfig
> > > > > > > > > > > > > >   and add Makefile logic such that for X_defcon=
fig as a build target but
> > > > > > > > > > > > > >   not configs/X_defconfig not existing, we see =
if any of
> > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist a=
nd we run a builds in
> > > > > > > > > > > > > >   subdirectories of our object directory, and t=
hen using binman combine
> > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > >   - Maybe instead the Makefile logic above we w=
ould parse X_defconfig
> > > > > > > > > > > > > >     and see if it's a different format of say P=
HASE:file to make it
> > > > > > > > > > > > > >     easier to say share a single TPL config wit=
h all rk3399, have a few
> > > > > > > > > > > > > >     common SPL configs and then just a board sp=
ecific PPL.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This solves (a) by removing them entirely. This=
 solves (b) by removing
> > > > > > > > > > > > > > the ambiguity entirely (it will be enabled or n=
ot). As a bonus for (b)
> > > > > > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO=
) and match up with the
> > > > > > > > > > > > > > Linux Kernel again. This solves (c) again by re=
moving it entirely.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Lets come back up here, to my proposal, since par=
ts of it seem to have
> > > > > > > > > > > > > not been clear enough. While what I'm proposing s=
hould work for any
> > > > > > > > > > > > > platform and xPL -> xPL -> ... -> PPL, for this e=
xample let us assume
> > > > > > > > > > > > > rockpro64-rk3399 supports the flow of TPL -> SPL =
-> PPL. Also, to
> > > > > > > > > > > > > compare with today, it will be helpful to run "ma=
ke
> > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_current rockpro64-rk339=
9_config" and have the
> > > > > > > > > > > > > resulting .config file available.
> > > > > > > > > > > > >
> > > > > > > > > > > > > There shall be configs/rockpro64-rk3399_tpl_defco=
nfig. This will contain
> > > > > > > > > > > > > lines such as:
> > > > > > > > > > > > > CONFIG_ARM=3Dy
> > > > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > >
> > > > > > > > > > > > > When you run "make O=3D/tmp/rockpro64-rk3399_tpl =
rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > > > > the resulting .config file will contain lines suc=
h as:
> > > > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > > > > > as this only makes sense in the context of buildi=
ng something that will
> > > > > > > > > > > > > be TPL.
> > > > > > > > > > > > >
> > > > > > > > > > > > > A more complex example is that it will also conta=
in:
> > > > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > > > > > > > > > > > >
> > > > > > > > > > > > > Because looking at arch/arm/mach-rockchip/Makefil=
e a bunch of that will
> > > > > > > > > > > > > be able to be simplified (and spl_common.c should=
 be renamed to
> > > > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.=
o spl-boot-order.o xpl_common.o
> > > > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.=
o xpl_common.o
> > > > > > > > > > > > >
> > > > > > > > > > > > > The .config file here will also contain:
> > > > > > > > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > >
> > > > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is because there is no 'config TPL_DM_SERIAL=
' option in
> > > > > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > > > > >
> > > > > > > > > > > > > When you next run "make O=3D/tmp/rockpro64-rk3399=
_tpl all" the results in
> > > > > > > > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to the=
 results as under
> > > > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The contents of configs/rockpro64-rk3399_spl_defc=
onfig would be similar
> > > > > > > > > > > > > to the tpl one, except with SPL-only-ever-valid o=
ptions such as
> > > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but otherwis=
e have CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=3Dy, and when buildin=
g the "all" target, you
> > > > > > > > > > > > > would only get similar results to what is under t=
he spl/ directory
> > > > > > > > > > > > > today.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Next we have configs/rockpro64-rk3399_ppl_defconf=
ig.  When you run "make
> > > > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_pp=
l_defconfig" the
> > > > > > > > > > > > > important difference is what you do not have. You=
 do not have:
> > > > > > > > > > > > > CONFIG_SPL=3Dy
> > > > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > > > >
> > > > > > > > > > > > > Because we are not building SPL nor TPL. We're ju=
st making full U-Boot
> > > > > > > > > > > > > itself. This is where in more full examples and w=
ith additional
> > > > > > > > > > > > > restructure a "generic-arm64_ppl_defconfig" makes=
 sense and be used
> > > > > > > > > > > > > instead.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This brings up what to do with "ockpro64-rk3399_d=
efconfig". And I'm a
> > > > > > > > > > > > > little unsure which of the things I mentioned abo=
ve is best. It's
> > > > > > > > > > > > > either:
> > > > > > > > > > > > > a) Does not exist, top-level Makefile says roughl=
y:
> > > > > > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_pp=
l_defconfig
> > > > > > > > > > > > >   make O=3D$(objdir)/tpl %_tpl_defconfig all
> > > > > > > > > > > > >   make O=3D$(objdir)/spl %_spl_defconfig all
> > > > > > > > > > > > >   make O=3D$(objdir)/ppl %_ppl_defconfig all
> > > > > > > > > > > > >
> > > > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > > > b) It contains:
> > > > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > > > > > %_defconfig:
> > > > > > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig f=
ile, please see..."
> > > > > > > > > > > > >   foreach line in $@
> > > > > > > > > > > > >     make O=3D$(objdir)/$PHASE $CONFIGFILE all
> > > > > > > > > > > > >
> > > > > > > > > > > > > It could also be some other suggestion.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks for writing that up. It is somewhat clearer.
> > > > > > > > > > > >
> > > > > > > > > > > > What happens to the Makefiles? Do they still have $=
(PHASE_) in them?
> > > > > > > > > > >
> > > > > > > > > > > No. Because CONFIG_SPL_FIT would never exist, $(CONFI=
G_$(PHASE_)FIT)
> > > > > > > > > > > would be meaningless. Only rockpro64-rk3399_spl_defco=
nfig would say
> > > > > > > > > > > CONFIG_FIT=3Dy (or more likely, only the resulting .c=
onfig would say
> > > > > > > > > > > CONFIG_FIT=3Dy just like how configs/rockpro64-rk3399=
_defconfig doesn't
> > > > > > > > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).
> > > > > > > > > >
> > > > > > > > > > But just above you said:
> > > > > > > > > >
> > > > > > > > > > > I believe this proposal will lead to the code and Mak=
efiles being less
> > > > > > > > > > > clear than they are today. The line:
> > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=3D bloc=
k/
> > > > > > > > > > > will become:
> > > > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
> > > > > > > > > > > without being clear that it could reference either fu=
ll U-Boot (PPL) or
> > > > > > > > > > > some xPL phase. While the same Makefile will continue=
 to have (comments
> > > > > > > > > > > my own):
> > > > > > > > > > > obj-y +=3D mtd/ # Subdirectory Makefiles control buil=
d contents
> > > > > > > > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only valid for =
PPL.
> > > > > > > > > > >
> > > > > > > > > > > And so the situation for humans will be worse off tha=
n today because
> > > > > > > > > > > while $(PHASE_) and $(XPL_) are confusing at times, t=
hey make it clear
> > > > > > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > > > > > >
> > > > > > > > > > > Doing "something" is not better than doing nothing in=
 this case.
> > > > > > > > > >
> > > > > > > > > > So why is OK for your proposal to drop the $(PHASE_) st=
uff, but not mine?
> > > > > > > > >
> > > > > > > > > Because your proposal keeps CONFIG_SPL_BLK (and config SP=
L_BLK) and has
> > > > > > > > > a .config file which says "CONFIG_SPL_BLK=3Dy" but mine d=
oesn't.
> > > > > > > > >
> > > > > > >
> > > > > > > > With my
> > > > > > > > proposal "I have a problem, and I want to see what my SPL b=
uild has with
> > > > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree for CONFI=
G_BLK, the
> > > > > > > > symbol I set, I can solve my problem."
> > > > > > >
> > > > > > > There will be at least some matches, e.g. CONFIG_SPL_BLK in t=
he
> > > > > > > defconfig files and 'config SPL_BLK' in the source tree.
> > > > > >
> > > > > > Yes, and that's confusing. I am arguing that your statement is =
more
> > > > > > confusing than $(PHASE_)BLK is.
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > > > > Or to try and explain differently, with your proposal "I =
have a problem,
> > > > > > > > > and I want to see what builds with CONFIG_SPL_BLK=3Dy. Wh=
y is there no
> > > > > > > > > match in the source tree for CONFIG_SPL_BLK or even SPL_B=
LK". With my
> > > > > > > > > proposal "I have a problem, and I want to see what my SPL=
 build has with
> > > > > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree for CON=
FIG_BLK, the
> > > > > > > > > symbol I set, I can solve my problem."
> > > > > > >
> > > > > > > Well, CONFIG_BLK will be in the source tree; it just means di=
fferent
> > > > > > > things for different phases.
> > > > > >
> > > > > > And it will be, with your proposal, controlled by BLK or SPL_BL=
K or
> > > > > > TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK in M=
akefile
> > > > > > and code.
> > > > > >
> > > > > > > It sounds like you want to get rid of the xPL prefixes for Kc=
onfig
> > > > > > > options, and that overrides all other considerations?
> > > > > >
> > > > > > It's one of the big problems we have today, and splc-working sh=
ows how
> > > > > > much further the duplication must go. It's why I suggested the =
language
> > > > > > modification before.
> > > > > >
> > > > > > > > My other try here was a bit unclear actually because of the=
 confusion
> > > > > > > > state your proposal gives us. Try try again directly, the p=
roblem is
> > > > > > > > that CONFIG_SPL_BLK will be set (or unset) but not referenc=
ed in code.
> > > > > > > > This will be true for many but not all SPL symbols as
> > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exi=
st and need
> > > > > > > > to be referenced. This is a more confusing state than $(PHA=
SE_). $(XPL_)
> > > > > > > > I think can just be replaced with $(PHASE_) but I haven't c=
onfirmed (I
> > > > > > > > think it does show that the old way was confusing however).
> > > > > > >
> > > > > > > OK, I think I see. You don't want people to have to 'know' th=
at
> > > > > > > CONFIG_xPL_xxx is used to control feature xxx in each xPL bui=
ld?
> > > > > >
> > > > > > I'm saying they have to know that, and also know which symbols =
that's
> > > > > > not true for. And that is more confusing than today. I'm saying=
 that
> > > > > > compared with today's arch/arm/mach-rockchip/Makefile the follo=
wing is
> > > > > > worse:
> > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-ro=
ckchip/Makefile
> > > > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > >  endif
> > > > > >
> > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > >
> > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > >
> > > > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> > > > > >
> > > > > > And this is better:
> > > > > >
> > > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-ro=
ckchip/Makefile
> > > > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > > @@ -7,15 +7,13 @@
> > > > > >  # this may have entered from ATF with the stack-pointer pointi=
ng to
> > > > > >  # inaccessible/protected memory (and the bootrom-helper assume=
s that
> > > > > >  # the stack-pointer is valid before switching to the U-Boot st=
ack).
> > > > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boo=
t-order.o spl_common.o
> > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_com=
mon.o
> > > > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-or=
der.o spl_common.o
> > > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > > > > +obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > > >
> > > > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > > -
> > > > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > > +obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > > >
> > > > > >  # Always include boot_mode.o, as we bypass it (i.e. turn it of=
f)
> > > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is =
0.  This way,
> > > > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD=
),)
> > > > > >  # meaning "turn it off".
> > > > > >  obj-y +=3D boot_mode.o
> > > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > > > -endif
> > > > > >
> > > > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > > > -endif
> > > > > >
> > > > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > > > >
> > > > > > +ifdef CONFIG_PPL
> > > > > > +# TODO: Audit these Makefiles see if they really must be PPL o=
nly
> > > > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > > > -
> > > > > > -# Clear out SPL objects, in case this is a TPL build
> > > > > > -obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > > > -
> > > > > > -# Now add SPL/TPL objects back into the main build
> > > > > > -obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > > > -obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > > > +endif
> > > > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as options).
> > > > > >
> > > > >
> > > > > This Makefile is a very strange example. I've thought about clean=
ing
> > > > > it up a few times, but then I know someone will say it needs to b=
e in
> > > > > its own series, etc. so I've never got around to it. Even with the
> > > > > current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just SPL) it=
 is
> > > > > needlessly complex.
> > > >
> > > > There's some complexity that can be removed here today, maybe. But =
not a
> > > > lot of it, because it's complex to build three different things when
> > > > configuring once.
> > > >
> > > > > Anyway, with my scheme, you can still use
> > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds SPL_ ver=
sions
> > > >
> > > > No. You have to use it still, with yours. Because
> > > > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
> > > > "TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use common boa=
rd
> > > > code" but different files at TPL, SPL and PPL. And you still have to
> > > > with mine, because for the same reason. With mine, the Kconfig is:
> > > > config SPL_ROCKCHIP_COMMON_BOARD
> > > >   bool "SPL rockchip common board file"
> > > >   depends on SPL
> > > >
> > > > config TPL_ROCKCHIP_COMMON_BOARD
> > > >   bool "TPL rockchip common board file"
> > > >   depends on TPL
> > > >
> > > > And since you are only ever configuring for TPL or SPL or PPL (or V=
PL or
> > > > ...) the resulting config only ever asks for the appropriate one.
> > > >
> > > > > of symbols to autoconf_spl.h for this reason. There are also plac=
es in
> > > > > the code where people directly check CONFIG_SPL_xxx and these nee=
d to
> > > > > work.
> > > >
> > > > Yes, this is part of the confusion I keep noting with your proposal=
 as
> > > > it will be inconsistent for which symbols CONFIG_SPL_xxx is referre=
d to
> > > > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
> > >
> > > If it is confusing, we can change all of them to CONFIG_xxx in a
> > > follow-up. There is no need to mention SPL_, it just allows the
> > > existing code to work without a wholesale change.
> >
> > No, that's not correct. Please look again at what I've written
> > explaining why.
>=20
> See below.
>=20
> >
> > > > > This surprised me:
> > > > >
> > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > >
> > > > > Are you saying you are OK with this one, instead of, for example:
> > > > >
> > > > > obj-$(CONFIG_TPL_RAM) +=3D sdram.o
> > > > > obj-$(CONFIG_SPL_RAM) +=3D sdram.o
> > > > > obj-$(CONFIG_RAM) +=3D sdram.o
> > > > >
> > > > > If so, why are you OK with that and not the others?
> > > >
> > > > Because there is no:
> > > > config TPL_RAM
> > > >   bool "RAM driver in TPL"
> > > >
> > > > in what I am proposing. That's why. There's one symbol because ther=
e's
> > > > the same files being built.
> > >
> > > OK, well that works the same for my scheme too. Either will do.
> >
> > I don't see how that can work in your scheme.
>=20
> Here is the full Kconfig for that file, with my scheme:
>=20
> >>>>
> # SPDX-License-Identifier: GPL-2.0+
> #
> # Copyright (c) 2014 Google, Inc
> # Copyright (c) 2019 Rockchip Electronics Co., Ltd.
>=20
> # We don't want the bootrom-helper present in a full U-Boot build, as
> # this may have entered from ATF with the stack-pointer pointing to
> # inaccessible/protected memory (and the bootrom-helper assumes that
> # the stack-pointer is valid before switching to the U-Boot stack).
> obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o
> spl_common.o
> obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
>=20
> obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
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
> # Clear out SPL objects, in case this is a TPL build
> obj-spl-$(CONFIG_TPL_BUILD) =3D
>=20
> # Now add SPL/TPL objects back into the main build
> obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> <<<<
>=20
> The only change is the line that was:
> obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o

Yes, that's also what I showed via unified diff format earlier, and so I
agree.

> > > > > For this one:
> > > > >
> > > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-or=
der.o spl_common.o
> > > > >
> > > > > I don't understand how it can work with your scheme, since you do=
n't
> > > > > want to have any CONFIG_SPL_ things?
> > > >
> > > > No, that's not what I've been saying and trying to make clear with =
my
> > > > examples. I keep saying that there are explicitly SPL (or TPL or VP=
L)
> > > > only options. And these need to be named as such. And so that's the
> > > > confusion your proposal introduces (inconsistency about referring t=
o a
> > > > symbol that has been enabled) and mine removes entirely (we only ev=
er
> > > > refer to symbols based on their name).
> > >
> > > Right, but you still have 'config SPL_RAM', right? Would you keep
> >
> > No, again, I do not. Please re-read my proposal as you seem to keep
> > making the same incorrect assumptions about it, and then saying that
> > your scheme would also do that. They are very much not at all the same.
>=20
> Maybe we have reached the limits of email on this one, but I am quite
> confused about your scheme. I suggested that you don't have
> CONFIG_SPL_ things and you said tht was wrong. Then I asked if you
> still have SPL_RAM and you said you don't. Let me try this:
>=20
> Q: In your scheme, do you have 'config SPL_RAM' and CONFIG_SPL_RAM, or
> do you not?

In my scheme we do not have 'config SPL_RAM' nor CONFIG_SPL_RAM as there
is no case where 'config RAM' and 'CONFIG_RAM' is incorrect. Because we
are never configuring and building for more than one phase.

In my scheme we do have 'config SPL_ROCKCHIP_COMMON_BOARD and
'CONFIG_SPL_ROCKCHIP_COMMON_BOARD' because they are NOT the same thing
as 'config ROCKCHIP_COMMON_BOARD' and 'CONFIG_ROCKCHIP_COMMON_BOARD'
(and again for TPL_...). They control different code. While technically
possible, I am arguing against overloading ROCKCHIP_COMMON_BOARD and
having the Makefile have to do some two part check like we have today,
as those are one of the pain points of adding new code.

--=20
Tom

--c2B5Np86IjSkGsUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme2QDoACgkQFHw5/5Y0
tyzxPgwAkfVaen7wLFaiN/UHMO1cX/69CKKg2zRntXL4sMYDfWc4DulZm4wliOAi
0du/mWZbAtB0ytL6GP1OniQT7x59Yfoy7Qv4dp+Sby5v3YoKlcx2IuWNKvmnltUS
5S+LZwrK+b8RvdTvCc0W6MqLWQkO2z93q8ifIbtn24GMeQPXoTHSWHizCJiPgPYu
uyk9ot+3W7IYC0bXzadKIGA+oK1ZhDG/yXc4MstKHP0XscpfOEt4wCoJlGOglVGB
N0vCYoj924U1U5cR8tDymSvgtyiGPbuXJimt1Iw0+tc2elt/VSaX3rJG/UHXouA8
A8A6H7PpognqPhyHBNWWxFWt257QbXf31kUzh6EKFEeNmr7WazuHT+GJQxmVaacd
6G+5b9zObBfax8osNG6EANyhVghpklg/fiEwtACGomNZQ3LRWx21lAolb7hT2qOd
ylWu9UlzU0yORxB6NliMokMHUDYzfNNM8nsghkwm7JhuWSrdrlM3Z5bCAUevl7if
+FIviQ6W
=X5cM
-----END PGP SIGNATURE-----

--c2B5Np86IjSkGsUb--
