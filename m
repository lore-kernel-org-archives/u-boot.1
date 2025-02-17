Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF47C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 19:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24ABA80BAE;
	Mon, 17 Feb 2025 20:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Moa8al29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B88BE807F1; Mon, 17 Feb 2025 20:22:03 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FBD8083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 20:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0e1so3026836a91.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739820119; x=1740424919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8bestgRbkwnywCmsDDLBatzndszVHBLZzvY/lgHhdlk=;
 b=Moa8al296Ud3JKWeM1eI0SmsDKFr6byYqCSx1sPzCBujr1DFF1F9+W39KXj3hX7nhD
 G50hbyoncHpbzXmek3J6uMn6I9e4MJgI8pVBKlouHiK78t/gWqNEsSwgXT5j3/Yi3AA0
 gpcCg786oSShACy7xlsHDrt+uZ6C7oDfdSfXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820119; x=1740424919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bestgRbkwnywCmsDDLBatzndszVHBLZzvY/lgHhdlk=;
 b=QRaP68AOZU7MfDnW3mQ9AFv/DClZaOmIG550YzmyeqsfxcMeHZQeTNPX+ftTyXcFLU
 3WdJ5kfVqRu4Exr98AHEaMKeiY5Z0aDf8jSXtOdCBW+wm7a5zKYf+mTt7oj7kw7YBAdO
 kva+34tAqLlbLzZAIK8VWuO+LTUo/yUC+0j7wQB+608YM9Ohx0TV80RRKV1pLDJvOT5X
 5/v1vkGvjoMX+fCgqWjF1Q8jeZp2oxF0v/NCZ4mVzdfOS10dYMDJJn2K/GMiHDJh71XW
 TK/1akb5wEHXiYPVCwZ0PoK63PaKm2bI+E7hpTJfWzwNTDTdYhFPaBNrXaY50C27q5Dr
 +KCQ==
X-Gm-Message-State: AOJu0Yx1OjPv9bKh0/6ce0b85lGpQRPnlUiN5a04CJ37PcRIFEq0uKk2
 17uOHyGOL5+H1/b+eGIf1eirORq7Ruc6iy65Trko8if9jsnVIeJTP1QNA7zJzEk=
X-Gm-Gg: ASbGnctBPhd5caQvYEJPtVNTgLRVsbnL1i0uSuHQmETcFOXIRppZ0jkz8+sXUqrii7b
 IP2RpbvxgG3Ss5KT9H0QFTGtC9ZY/1C0qpZDk5Y+ilTPDo1uP9+wo12sSs7+TK/1DsyLzALGVcI
 vB5FfjvS45HNL0tuqHfFYTJvkSKtEoPlo5HncqKXzcETvp/y3oz9ilBNSzAXPbYa2gEXl6rRvgb
 DsdzUawde558pv+KllkRfMPDkXNCSeiJd+wbixnXXzuNlztU2ul6jex8bLWuzjYnR2d813gDGZS
 LLhq5pG7gRm4cA==
X-Google-Smtp-Source: AGHT+IGTOAQNzJwqwKewBFbhC3tl+J7ntnvI9QnEsVVWVS3RX+P1n/zi94kt920VDwMjZpXBdRsj4A==
X-Received: by 2002:a17:90b:17d1:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-2fc4076f03dmr16763323a91.11.1739820119508; 
 Mon, 17 Feb 2025 11:21:59 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349210sm75020855ad.11.2025.02.17.11.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:21:58 -0800 (PST)
Date: Mon, 17 Feb 2025 13:21:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250217192156.GV1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <20250217185035.GT1233568@bill-the-cat>
 <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YgknaXOmbtPEvl/h"
Content-Disposition: inline
In-Reply-To: <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
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


--YgknaXOmbtPEvl/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > next iteration of xPL.
> > > >
> > > > A recent series introduced 'xPL' as the name for the various
> > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any x=
PL
> > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > still use filenames and function naming which uses 'spl', but could
> > > > potentially adjust that.
> > > >
> > > > The major remaining problem IMO is that it is quite tricky and
> > > > expensive (in terms of time) to add a new phase. We also have some
> > > > medium-sized problems:
> > > >
> > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly a=
nd
> > > > can be confusing, particularly when combined with ifdef and ifneq
> > > >
> > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > different things. For any given option, some code uses one and some
> > > > the other, depending on what problems people have met along the way.
> > > >
> > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean th=
at
> > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusi=
ng
> > > > and has not scaled well.
> > > >
> > > > d. We need to retain an important feature: options from different
> > > > phases can depend on each other. As an example, we might want to
> > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > can do this easily today, just by adding Kconfig rules.
> > >
> > > I agree with a through c and for d there are likely some cases even if
> > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > important as the other ones.
> > >
> > > > Proposal
> > > >
> > > > 1. Adjust kconf to generate separate autoconf.h files for each phas=
e.
> > > > These contain the values for each Kconfig option for that phase. For
> > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > >
> > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > There are around 200 of these.
> > > >
> > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (onl=
y),
> > > > useful in rare cases. This indicates that the option applies only to
> > > > U-Boot proper and is not defined in any xPL build. It is analogous =
to
> > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > needed at present, basically to allow access to the value for anoth=
er
> > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it kno=
ws
> > > > the address to which U-Boot should be loaded.
> > > >
> > > > 4. There is no change to the existing defconfig files, or 'make
> > > > menuconfig', which works just as today, including dependencies betw=
een
> > > > options across all phases.
> > > >
> > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MM=
C,
> > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > declared once for any/all phases. We can then drop the file in 2
> > > > above.
> > > >
> > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > phase should be considerably easier.
> > >
> > > I think this will not make our life easier, it will make things harde=
r.
> > >
> > > I think what we've reached now shows that Yamada-san was correct at t=
he
> > > time in saying that we were going down the wrong path with how we
> > > handled SPL/TPL.
> > >
> > > My request instead is:
> > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, ju=
st
> > >   DM_MMC) as a prefix.
> > > - Likely need to introduce a PPL symbol as you suggest.
> > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfi=
g.
> > > - Split something like rockpro64-rk3399_defconfig in to
> > >   rockpro64-rk3399_ppl_defconfig
> > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > >   and add Makefile logic such that for X_defconfig as a build target =
but
> > >   not configs/X_defconfig not existing, we see if any of
> > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > >   subdirectories of our object directory, and then using binman combi=
ne
> > >   as needed.
> > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > >     and see if it's a different format of say PHASE:file to make it
> > >     easier to say share a single TPL config with all rk3399, have a f=
ew
> > >     common SPL configs and then just a board specific PPL.
> > >
> > > This solves (a) by removing them entirely. This solves (b) by removing
> > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > Linux Kernel again. This solves (c) again by removing it entirely.
> >
> > Lets come back up here, to my proposal, since parts of it seem to have
> > not been clear enough. While what I'm proposing should work for any
> > platform and xPL -> xPL -> ... -> PPL, for this example let us assume
> > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also, to
> > compare with today, it will be helpful to run "make
> > O=3D/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" and have the
> > resulting .config file available.
> >
> > There shall be configs/rockpro64-rk3399_tpl_defconfig. This will contain
> > lines such as:
> > CONFIG_ARM=3Dy
> > CONFIG_ARCH_ROCKCHIP=3Dy
> > CONFIG_ROCKCHIP_RK3399=3Dy
> > CONFIG_TPL=3Dy
> >
> > When you run "make O=3D/tmp/rockpro64-rk3399_tpl rockpro64-rk3399_tpl_d=
efconfig"
> > the resulting .config file will contain lines such as:
> > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > as this only makes sense in the context of building something that will
> > be TPL.
> >
> > A more complex example is that it will also contain:
> > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> >
> > Because looking at arch/arm/mach-rockchip/Makefile a bunch of that will
> > be able to be simplified (and spl_common.c should be renamed to
> > xpl_common.c) to:
> > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o xpl=
_common.o
> > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o xpl_common.o
> >
> > The .config file here will also contain:
> > CONFIG_DM_SERIAL=3Dy
> >
> > What it will not contain is:
> > CONFIG_TPL_DM_SERIAL=3Dy
> >
> > This is because there is no 'config TPL_DM_SERIAL' option in
> > drivers/serial/Kconfig anymore.
> >
> > When you next run "make O=3D/tmp/rockpro64-rk3399_tpl all" the results =
in
> > /tmp/rockpro64-rk3399_tpl would be similar to the results as under
> > "/tmp/rockpro64-rk3399/tpl/" when building today.
> >
> > The contents of configs/rockpro64-rk3399_spl_defconfig would be similar
> > to the tpl one, except with SPL-only-ever-valid options such as
> > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but otherwise have CONFIG_DM_SERIA=
L=3Dy
> > and no CONFIG_SPL_DM_SERIAL=3Dy, and when building the "all" target, you
> > would only get similar results to what is under the spl/ directory
> > today.
> >
> > Next we have configs/rockpro64-rk3399_ppl_defconfig.  When you run "make
> > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig" the
> > important difference is what you do not have. You do not have:
> > CONFIG_SPL=3Dy
> > CONFIG_TPL=3Dy
> >
> > Because we are not building SPL nor TPL. We're just making full U-Boot
> > itself. This is where in more full examples and with additional
> > restructure a "generic-arm64_ppl_defconfig" makes sense and be used
> > instead.
> >
> > This brings up what to do with "ockpro64-rk3399_defconfig". And I'm a
> > little unsure which of the things I mentioned above is best. It's
> > either:
> > a) Does not exist, top-level Makefile says roughly:
> > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
> >   make O=3D$(objdir)/tpl %_tpl_defconfig all
> >   make O=3D$(objdir)/spl %_spl_defconfig all
> >   make O=3D$(objdir)/ppl %_ppl_defconfig all
> >
> > But this might be too rigid.
> > b) It contains:
> > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > And the top-level Makefile looks like:
> > %_defconfig:
> >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, please see..."
> >   foreach line in $@
> >     make O=3D$(objdir)/$PHASE $CONFIGFILE all
> >
> > It could also be some other suggestion.
>=20
> Thanks for writing that up. It is somewhat clearer.
>=20
> What happens to the Makefiles? Do they still have $(PHASE_) in them?

No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHASE_)FIT)
would be meaningless. Only rockpro64-rk3399_spl_defconfig would say
CONFIG_FIT=3Dy (or more likely, only the resulting .config would say
CONFIG_FIT=3Dy just like how configs/rockpro64-rk3399_defconfig doesn't
say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).

--=20
Tom

--YgknaXOmbtPEvl/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezjFQACgkQFHw5/5Y0
tyyLwAv+NVpK6b/9KoXNuzf5vkbMqpVb1YO8D7ggYmES2gkB4px2vqE82KKof7xG
sy+wOcnB1FPubJ3/CGeoJiJHH8MrDtiPB8RrmvEBEfKGlc8mCDgSQ/+a+U9XfTx7
QytdQjnOY/JFhwwyyqbLFVaSxIEg1vbfxlDqIs/JoLh3EUARdL7OwQK10Q4IcLfI
OBbUN5MyskwkoIrKkrqWRX9xmvYRI2FG4pg3Uj3wYcJgQRkyHvg95ALWMROjaY3v
Z2ftYEiBDQ6CAbR2C4EThG/fMvya5RGeNBB8X18UDlIfrFkccBDM89tHOugP2bT7
OnBD5z/tbVFsiTngBpKATeUNyTht2RPJVF/rNkOSG45ikyQ/VgqEoy++N9WOAc0d
FJeoB9FqBf3uLxTb7uoOtokIVQrBr8dfF3eypCZPRQ0FsbNq/Z7sTsuCAQUiHMZr
5ztXHGk0ubqkOykVOG8Sk+ep3dYE2ZrFV+daKQJx4dOMPxHIxczl8klakjaybfMf
8U0sN8NQ
=39Hy
-----END PGP SIGNATURE-----

--YgknaXOmbtPEvl/h--
