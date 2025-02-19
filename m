Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE70FC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 01:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15E280F42;
	Wed, 19 Feb 2025 02:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZzGipdXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0961180EC0; Wed, 19 Feb 2025 02:07:22 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72EF80646
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 02:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so9373700a91.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 17:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739927232; x=1740532032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K++gBIsZL2TLXDoWju63nB3SUnf8Y28wPVHQLlE7aM4=;
 b=ZzGipdXs6KrTm85aahByX1N/I66vJaPrYkkxC/26sWw3TTqNLxGrcR6TIMu71sfH1X
 oDsfMlLijfppXP4XnC1d6zLNqIIkLy/UAFegUY/OFmPqxiLdbaQXVjM52eVetn6jSJ5f
 /ewqVnJQJFVK+/Obtbf3UcsxZ8z+e99DGy7qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739927232; x=1740532032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K++gBIsZL2TLXDoWju63nB3SUnf8Y28wPVHQLlE7aM4=;
 b=A+aoCSW3OEUkkJmiFVvZ6ZQPTuvPY9+fnbhnVBGmj0ITZyE02uicjNw08JUAHvtG06
 3K5zXe6xcPOhemHm9YP1KNUx+thvu7SLReuM2blCkovwQfPSoPSClk+iWFEM43jsrJbF
 MiYbfqwMwSJuFvnmgkmPJq1rRu0F+TspSnCXz7riJA1VfGyrRMRsAcqpiKIqxxsWFU7V
 MHEa30h898UvMxdFwdJrZ+jrD9v5X41RwcaywVzBtnEvRSM8Ydl+zCcg5Zc8FD4FSL+i
 SC9hpS5EzkLiAwFd1AyM0NvWL6pW9VBbC71w9WSzmN+XUzalMo9Auqw8qziRoU+va/B2
 PTMQ==
X-Gm-Message-State: AOJu0YyOEyFSLayc/+QTt9B90hErsezg4XCNxFOqABZ2jUtQ8NfAl6U/
 3MsEICWxs0Ykpu03+160/yzZUsYCAdQc3DtGQ2L5GUloi1Y24dq8sCDnCZCCQt+ZA638ws6jsMQ
 o
X-Gm-Gg: ASbGncsWMQm4V3A2Yx7sEojr6SUhGCBrT+zY5RpfHpyQQyXAurCs/St39/vzlpU+bnB
 HKfWYGvFw/MgV0D8EeUqmHXlbrk8ksfERm9dO5o1729T7Speybgt4TH3t4NS4agN/VKDtHWDiGt
 8DpbiPbcAsdKxWedZFoG+IrQQnB19IcFjfUl8e1NmjOHBF1UyIlNALj4+ndFzTNYMxtNbnBKPot
 SBVVD4BDMRyi/ru9/EIskTenAvw8lOX+HgBSHjFGzk8B3f3zyjPlYu26ZbLVvpqXrjaA+sFIadq
 PKL1GVOTDXltfA==
X-Google-Smtp-Source: AGHT+IH3OoMjayhq+HChIrJ9fL3MbxNA/D1+JeeKx0DBFiKNynAnZkqcUrHvO03EKqs78tjENTSTDA==
X-Received: by 2002:a17:90b:530f:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-2fc41153e04mr21181091a91.34.1739927232091; 
 Tue, 18 Feb 2025 17:07:12 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ab0fe7sm10749567a91.10.2025.02.18.17.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 17:07:11 -0800 (PST)
Date: Tue, 18 Feb 2025 19:07:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250219010708.GS1233568@bill-the-cat>
References: <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
 <20250217192156.GV1233568@bill-the-cat>
 <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
 <20250217194732.GY1233568@bill-the-cat>
 <20250217201751.GZ1233568@bill-the-cat>
 <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
 <20250218004025.GA1233568@bill-the-cat>
 <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
 <20250218144627.GC1233568@bill-the-cat>
 <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C+6RzoMW03IiFi6k"
Content-Disposition: inline
In-Reply-To: <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
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


--C+6RzoMW03IiFi6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wr=
ote:
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
> > > > > > > > > > > >
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
> > > > > > > > > > > >
> > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM=
_MMC and so on, just
> > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > - Likely need to introduce a PPL symbol as you sugg=
est.
> > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when b=
uilding a defconfig.
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
> > > > > > > > > > > Lets come back up here, to my proposal, since parts o=
f it seem to have
> > > > > > > > > > > not been clear enough. While what I'm proposing shoul=
d work for any
> > > > > > > > > > > platform and xPL -> xPL -> ... -> PPL, for this examp=
le let us assume
> > > > > > > > > > > rockpro64-rk3399 supports the flow of TPL -> SPL -> P=
PL. Also, to
> > > > > > > > > > > compare with today, it will be helpful to run "make
> > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_current rockpro64-rk3399_co=
nfig" and have the
> > > > > > > > > > > resulting .config file available.
> > > > > > > > > > >
> > > > > > > > > > > There shall be configs/rockpro64-rk3399_tpl_defconfig=
=2E This will contain
> > > > > > > > > > > lines such as:
> > > > > > > > > > > CONFIG_ARM=3Dy
> > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > >
> > > > > > > > > > > When you run "make O=3D/tmp/rockpro64-rk3399_tpl rock=
pro64-rk3399_tpl_defconfig"
> > > > > > > > > > > the resulting .config file will contain lines such as:
> > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > > > as this only makes sense in the context of building s=
omething that will
> > > > > > > > > > > be TPL.
> > > > > > > > > > >
> > > > > > > > > > > A more complex example is that it will also contain:
> > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > > > > > > > > > >
> > > > > > > > > > > Because looking at arch/arm/mach-rockchip/Makefile a =
bunch of that will
> > > > > > > > > > > be able to be simplified (and spl_common.c should be =
renamed to
> > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o sp=
l-boot-order.o xpl_common.o
> > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o xp=
l_common.o
> > > > > > > > > > >
> > > > > > > > > > > The .config file here will also contain:
> > > > > > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > >
> > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > > > > > >
> > > > > > > > > > > This is because there is no 'config TPL_DM_SERIAL' op=
tion in
> > > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > > >
> > > > > > > > > > > When you next run "make O=3D/tmp/rockpro64-rk3399_tpl=
 all" the results in
> > > > > > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to the res=
ults as under
> > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > > > > > > > >
> > > > > > > > > > > The contents of configs/rockpro64-rk3399_spl_defconfi=
g would be similar
> > > > > > > > > > > to the tpl one, except with SPL-only-ever-valid optio=
ns such as
> > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but otherwise ha=
ve CONFIG_DM_SERIAL=3Dy
> > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=3Dy, and when building th=
e "all" target, you
> > > > > > > > > > > would only get similar results to what is under the s=
pl/ directory
> > > > > > > > > > > today.
> > > > > > > > > > >
> > > > > > > > > > > Next we have configs/rockpro64-rk3399_ppl_defconfig. =
 When you run "make
> > > > > > > > > > > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_de=
fconfig" the
> > > > > > > > > > > important difference is what you do not have. You do =
not have:
> > > > > > > > > > > CONFIG_SPL=3Dy
> > > > > > > > > > > CONFIG_TPL=3Dy
> > > > > > > > > > >
> > > > > > > > > > > Because we are not building SPL nor TPL. We're just m=
aking full U-Boot
> > > > > > > > > > > itself. This is where in more full examples and with =
additional
> > > > > > > > > > > restructure a "generic-arm64_ppl_defconfig" makes sen=
se and be used
> > > > > > > > > > > instead.
> > > > > > > > > > >
> > > > > > > > > > > This brings up what to do with "ockpro64-rk3399_defco=
nfig". And I'm a
> > > > > > > > > > > little unsure which of the things I mentioned above i=
s best. It's
> > > > > > > > > > > either:
> > > > > > > > > > > a) Does not exist, top-level Makefile says roughly:
> > > > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_de=
fconfig
> > > > > > > > > > >   make O=3D$(objdir)/tpl %_tpl_defconfig all
> > > > > > > > > > >   make O=3D$(objdir)/spl %_spl_defconfig all
> > > > > > > > > > >   make O=3D$(objdir)/ppl %_ppl_defconfig all
> > > > > > > > > > >
> > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > b) It contains:
> > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > > > %_defconfig:
> > > > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file,=
 please see..."
> > > > > > > > > > >   foreach line in $@
> > > > > > > > > > >     make O=3D$(objdir)/$PHASE $CONFIGFILE all
> > > > > > > > > > >
> > > > > > > > > > > It could also be some other suggestion.
> > > > > > > > > >
> > > > > > > > > > Thanks for writing that up. It is somewhat clearer.
> > > > > > > > > >
> > > > > > > > > > What happens to the Makefiles? Do they still have $(PHA=
SE_) in them?
> > > > > > > > >
> > > > > > > > > No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(=
PHASE_)FIT)
> > > > > > > > > would be meaningless. Only rockpro64-rk3399_spl_defconfig=
 would say
> > > > > > > > > CONFIG_FIT=3Dy (or more likely, only the resulting .confi=
g would say
> > > > > > > > > CONFIG_FIT=3Dy just like how configs/rockpro64-rk3399_def=
config doesn't
> > > > > > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).
> > > > > > > >
> > > > > > > > But just above you said:
> > > > > > > >
> > > > > > > > > I believe this proposal will lead to the code and Makefil=
es being less
> > > > > > > > > clear than they are today. The line:
> > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=3D block/
> > > > > > > > > will become:
> > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
> > > > > > > > > without being clear that it could reference either full U=
-Boot (PPL) or
> > > > > > > > > some xPL phase. While the same Makefile will continue to =
have (comments
> > > > > > > > > my own):
> > > > > > > > > obj-y +=3D mtd/ # Subdirectory Makefiles control build co=
ntents
> > > > > > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only valid for PPL.
> > > > > > > > >
> > > > > > > > > And so the situation for humans will be worse off than to=
day because
> > > > > > > > > while $(PHASE_) and $(XPL_) are confusing at times, they =
make it clear
> > > > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > > > >
> > > > > > > > > Doing "something" is not better than doing nothing in thi=
s case.
> > > > > > > >
> > > > > > > > So why is OK for your proposal to drop the $(PHASE_) stuff,=
 but not mine?
> > > > > > >
> > > > > > > Because your proposal keeps CONFIG_SPL_BLK (and config SPL_BL=
K) and has
> > > > > > > a .config file which says "CONFIG_SPL_BLK=3Dy" but mine doesn=
't.
> > > > > > >
> > > > >
> > > > > > With my
> > > > > > proposal "I have a problem, and I want to see what my SPL build=
 has with
> > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree for CONFIG_BL=
K, the
> > > > > > symbol I set, I can solve my problem."
> > > > >
> > > > > There will be at least some matches, e.g. CONFIG_SPL_BLK in the
> > > > > defconfig files and 'config SPL_BLK' in the source tree.
> > > >
> > > > Yes, and that's confusing. I am arguing that your statement is more
> > > > confusing than $(PHASE_)BLK is.
> > >
> > > OK
> > >
> > > >
> > > > > > > Or to try and explain differently, with your proposal "I have=
 a problem,
> > > > > > > and I want to see what builds with CONFIG_SPL_BLK=3Dy. Why is=
 there no
> > > > > > > match in the source tree for CONFIG_SPL_BLK or even SPL_BLK".=
 With my
> > > > > > > proposal "I have a problem, and I want to see what my SPL bui=
ld has with
> > > > > > > CONFIG_BLK=3Dy. I can see hits in the source tree for CONFIG_=
BLK, the
> > > > > > > symbol I set, I can solve my problem."
> > > > >
> > > > > Well, CONFIG_BLK will be in the source tree; it just means differ=
ent
> > > > > things for different phases.
> > > >
> > > > And it will be, with your proposal, controlled by BLK or SPL_BLK or
> > > > TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK in Makef=
ile
> > > > and code.
> > > >
> > > > > It sounds like you want to get rid of the xPL prefixes for Kconfig
> > > > > options, and that overrides all other considerations?
> > > >
> > > > It's one of the big problems we have today, and splc-working shows =
how
> > > > much further the duplication must go. It's why I suggested the lang=
uage
> > > > modification before.
> > > >
> > > > > > My other try here was a bit unclear actually because of the con=
fusion
> > > > > > state your proposal gives us. Try try again directly, the probl=
em is
> > > > > > that CONFIG_SPL_BLK will be set (or unset) but not referenced i=
n code.
> > > > > > This will be true for many but not all SPL symbols as
> > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exist a=
nd need
> > > > > > to be referenced. This is a more confusing state than $(PHASE_)=
=2E $(XPL_)
> > > > > > I think can just be replaced with $(PHASE_) but I haven't confi=
rmed (I
> > > > > > think it does show that the old way was confusing however).
> > > > >
> > > > > OK, I think I see. You don't want people to have to 'know' that
> > > > > CONFIG_xPL_xxx is used to control feature xxx in each xPL build?
> > > >
> > > > I'm saying they have to know that, and also know which symbols that=
's
> > > > not true for. And that is more confusing than today. I'm saying that
> > > > compared with today's arch/arm/mach-rockchip/Makefile the following=
 is
> > > > worse:
> > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockch=
ip/Makefile
> > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > >  endif
> > > >
> > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > >
> > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > >
> > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> > > >
> > > > And this is better:
> > > >
> > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockch=
ip/Makefile
> > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > @@ -7,15 +7,13 @@
> > > >  # this may have entered from ATF with the stack-pointer pointing to
> > > >  # inaccessible/protected memory (and the bootrom-helper assumes th=
at
> > > >  # the stack-pointer is valid before switching to the U-Boot stack).
> > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-or=
der.o spl_common.o
> > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.=
o spl_common.o
> > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
> > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
> > > > +obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
> > > >
> > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > > -
> > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > +obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
> > > >
> > > >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  =
This way,
> > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > >  # meaning "turn it off".
> > > >  obj-y +=3D boot_mode.o
> > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
> > > > -endif
> > > >
> > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > >  obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
> > > > -endif
> > > >
> > > > -obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
> > > > +obj-$(CONFIG_RAM) +=3D sdram.o
> > > >
> > > > +ifdef CONFIG_PPL
> > > > +# TODO: Audit these Makefiles see if they really must be PPL only
> > > >  obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
> > > >  obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
> > > >  obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
> > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
> > > >  obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
> > > >  obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
> > > >  obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
> > > > -
> > > > -# Clear out SPL objects, in case this is a TPL build
> > > > -obj-spl-$(CONFIG_TPL_BUILD) =3D
> > > > -
> > > > -# Now add SPL/TPL objects back into the main build
> > > > -obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
> > > > -obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
> > > > +endif
> > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as options).
> > > >
> > >
> > > This Makefile is a very strange example. I've thought about cleaning
> > > it up a few times, but then I know someone will say it needs to be in
> > > its own series, etc. so I've never got around to it. Even with the
> > > current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just SPL) it is
> > > needlessly complex.
> >
> > There's some complexity that can be removed here today, maybe. But not a
> > lot of it, because it's complex to build three different things when
> > configuring once.
> >
> > > Anyway, with my scheme, you can still use
> > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds SPL_ versions
> >
> > No. You have to use it still, with yours. Because
> > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
> > "TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use common board
> > code" but different files at TPL, SPL and PPL. And you still have to
> > with mine, because for the same reason. With mine, the Kconfig is:
> > config SPL_ROCKCHIP_COMMON_BOARD
> >   bool "SPL rockchip common board file"
> >   depends on SPL
> >
> > config TPL_ROCKCHIP_COMMON_BOARD
> >   bool "TPL rockchip common board file"
> >   depends on TPL
> >
> > And since you are only ever configuring for TPL or SPL or PPL (or VPL or
> > ...) the resulting config only ever asks for the appropriate one.
> >
> > > of symbols to autoconf_spl.h for this reason. There are also places in
> > > the code where people directly check CONFIG_SPL_xxx and these need to
> > > work.
> >
> > Yes, this is part of the confusion I keep noting with your proposal as
> > it will be inconsistent for which symbols CONFIG_SPL_xxx is referred to
> > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
>=20
> If it is confusing, we can change all of them to CONFIG_xxx in a
> follow-up. There is no need to mention SPL_, it just allows the
> existing code to work without a wholesale change.

No, that's not correct. Please look again at what I've written
explaining why.

> > > This surprised me:
> > >
> > > obj-$(CONFIG_RAM) +=3D sdram.o
> > >
> > > Are you saying you are OK with this one, instead of, for example:
> > >
> > > obj-$(CONFIG_TPL_RAM) +=3D sdram.o
> > > obj-$(CONFIG_SPL_RAM) +=3D sdram.o
> > > obj-$(CONFIG_RAM) +=3D sdram.o
> > >
> > > If so, why are you OK with that and not the others?
> >
> > Because there is no:
> > config TPL_RAM
> >   bool "RAM driver in TPL"
> >
> > in what I am proposing. That's why. There's one symbol because there's
> > the same files being built.
>=20
> OK, well that works the same for my scheme too. Either will do.

I don't see how that can work in your scheme.

> > > For this one:
> > >
> > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.=
o spl_common.o
> > >
> > > I don't understand how it can work with your scheme, since you don't
> > > want to have any CONFIG_SPL_ things?
> >
> > No, that's not what I've been saying and trying to make clear with my
> > examples. I keep saying that there are explicitly SPL (or TPL or VPL)
> > only options. And these need to be named as such. And so that's the
> > confusion your proposal introduces (inconsistency about referring to a
> > symbol that has been enabled) and mine removes entirely (we only ever
> > refer to symbols based on their name).
>=20
> Right, but you still have 'config SPL_RAM', right? Would you keep

No, again, I do not. Please re-read my proposal as you seem to keep
making the same incorrect assumptions about it, and then saying that
your scheme would also do that. They are very much not at all the same.

--=20
Tom

--C+6RzoMW03IiFi6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1LrEACgkQFHw5/5Y0
tyxkygwAqejHlhCmi81sJBVXG4ywaoWsUQpnKZQE7OUUdX0TU/Ip9OA7RTyi6kcD
CjWkx4Zprs4BhE4VO4/yZhgSR5+BCeQ/pFzFhEMdjXlkVy8zyXAGThYlOBJXnvAE
lUw/fcLfaExnUUxCyXwsiTjPYSJFZvgzpHFR1vKSj8o/Xu6BaoX2U9A8VCMgtzj5
+Brv3flQifkGgqvJWkiz5TbUOXq1n1jFsIBs9RslBPiGbBPZm58ELepDquE6kYbp
P0knAFIND1Z5DZknyYhhfBKmTVzdRoIVF3Mbn5ONIOEFAoQqFJ5ACpyHKKNxsQHX
ar6YnvK9KX9FVcq6gkJthT7HUC+3q2z1dXyrLeOtayb5J0rFaOa2Lw+sSjjWWJ92
34h9Nwl5sS3RIIXU98hXYnx9CoMycKSe8Y/YqcQhKnul0RHT4gJqWLA87afAw/HV
gxRrkAIn79BMUonj1+8Km+PLfF1fJEDrO3OsOPdmNhb9qhzxxF0rnco+zdd9xo1D
V6bzVkCd
=EODU
-----END PGP SIGNATURE-----

--C+6RzoMW03IiFi6k--
