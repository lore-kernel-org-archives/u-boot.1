Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F45C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 18:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D471380BAD;
	Mon, 17 Feb 2025 19:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fHLXA1jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D57C8083C; Mon, 17 Feb 2025 19:50:43 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0A6807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2211cd4463cso29011755ad.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739818239; x=1740423039; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hd6Jtv1YEtktFpzy+EnzybcsHmVKCNsfS7M2kwg3hz0=;
 b=fHLXA1jdC3dNPRtRJQhL/4NLM1BrdBZQJV2Vs9BAXdlYTi4hQ/ek17ylspz3vxdg8F
 0Jh80rGn5ksxqQrgGgJgJpfcuD8BWqaODyE3chBiRvScU0Eg4invMxzK34KHqjsvZeQm
 DofFnCnULg0rKEkEWCyX4MHIAWHHuxwMDz03U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818239; x=1740423039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd6Jtv1YEtktFpzy+EnzybcsHmVKCNsfS7M2kwg3hz0=;
 b=BLKXZTV5JwlQu0Jc2O/DeGMZ87N8kiUnvbPRhVqxoXuYCmExnQtKoQcMEu6fdizu9r
 OWEGM9J/W31LnvAl1SzOfO0joJe2tP2lTAJez5hMTa3vXeNcGzhrXZL+lvIFncZ9Epp+
 D9cHQkQEjKPosA9+HzbuxanMMli3K/AC0hTXTyrXUEW+mVZJ7tv+hCjMUD39pHwXYyCf
 Ff2dtTZqVOrJtw4tHVpPJ6Fa1dewHHkL9D8XMIOEBD4oMAsnnHDtHyRAnlxiDdOMA+mm
 tXoiQ+DWnk3PTPZyBDNiojrtuYeJuGj2dog1XNVwYuvWlR3ConX9plotyByFUJREvYmD
 IqUw==
X-Gm-Message-State: AOJu0YwLQU1IXiqNw6L/qI0orIPzRjuV7hWUduLffw7DdRTME6mNUZEC
 j2k8NdOtU6k1OY+deFwgRGHAzHClfYMfldKP0V626yLO9APBI+0OiwyUsiIMGY8=
X-Gm-Gg: ASbGncsqIhyI04vkYxm46OhxdqpuEEoXsHt2ASed1Nx6ex1XtDPlR6jtbm4TcKvI5qV
 /hst/HVa81VeUwTXsp1UmrL+YTEAgc2Io6qkeBYM1/2ze7Y3tTZB/V8PsRYr+DjO820kk0OyA38
 ewnVjfQbXYuYniWekgH1bP1Ozn3f1Er4wpUHv1iMuJGHphcfHG+IxqG3iXucgP9yc0DjjxJGg25
 j2PxQuiaenQ7x7cf8IVYuXnkW6dKqrrt7MEyX8jg9xuRs4k/j7XX6kMMYS3/jcxn0J3z43igYSF
 3NJe0FxGDlReOQ==
X-Google-Smtp-Source: AGHT+IE9BvNG16nZGtBB5muhc/P1RqSY3w3rf23QlRBcRz8IRIaVeqyUKEsd+Wpx2YLsEdG3rFXvCA==
X-Received: by 2002:a05:6a20:72a6:b0:1ee:615c:6c8e with SMTP id
 adf61e73a8af0-1ee8cacbf27mr16272159637.9.1739818238534; 
 Mon, 17 Feb 2025 10:50:38 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73251356d78sm6973520b3a.100.2025.02.17.10.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:50:37 -0800 (PST)
Date: Mon, 17 Feb 2025 12:50:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250217185035.GT1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V//MpdqEM21SYuqX"
Content-Disposition: inline
In-Reply-To: <20250211212222.GH1233568@bill-the-cat>
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


--V//MpdqEM21SYuqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > Hi,
> >=20
> > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > next iteration of xPL.
> >=20
> > A recent series introduced 'xPL' as the name for the various
> > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > still use filenames and function naming which uses 'spl', but could
> > potentially adjust that.
> >=20
> > The major remaining problem IMO is that it is quite tricky and
> > expensive (in terms of time) to add a new phase. We also have some
> > medium-sized problems:
> >=20
> > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > can be confusing, particularly when combined with ifdef and ifneq
> >=20
> > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > different things. For any given option, some code uses one and some
> > the other, depending on what problems people have met along the way.
> >=20
> > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > the option is enabled in one or more xPL phases, or just in U-Boot
> > proper. The only way to know is to look for $(PHASE_) etc. in the
> > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > and has not scaled well.
> >=20
> > d. We need to retain an important feature: options from different
> > phases can depend on each other. As an example, we might want to
> > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > may also want to share values between phases, such as TEXT_BASE. We
> > can do this easily today, just by adding Kconfig rules.
>=20
> I agree with a through c and for d there are likely some cases even if
> I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> important as the other ones.
>=20
> > Proposal
> >=20
> > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > These contain the values for each Kconfig option for that phase. For
> > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> >=20
> > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > Kconfig options which should not be enabled/valid in any xPL build.
> > There are around 200 of these.
> >=20
> > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > useful in rare cases. This indicates that the option applies only to
> > U-Boot proper and is not defined in any xPL build. It is analogous to
> > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > needed at present, basically to allow access to the value for another
> > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > the address to which U-Boot should be loaded.
> >=20
> > 4. There is no change to the existing defconfig files, or 'make
> > menuconfig', which works just as today, including dependencies between
> > options across all phases.
> >=20
> > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > declared once for any/all phases. We can then drop the file in 2
> > above.
> >=20
> > With this, maintaining Kconfig options, Makefiles and adding a new
> > phase should be considerably easier.
>=20
> I think this will not make our life easier, it will make things harder.
>=20
> I think what we've reached now shows that Yamada-san was correct at the
> time in saying that we were going down the wrong path with how we
> handled SPL/TPL.
>=20
> My request instead is:
> - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
>   DM_MMC) as a prefix.
> - Likely need to introduce a PPL symbol as you suggest.
> - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> - Split something like rockpro64-rk3399_defconfig in to
>   rockpro64-rk3399_ppl_defconfig
>   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
>   and add Makefile logic such that for X_defconfig as a build target but
>   not configs/X_defconfig not existing, we see if any of
>   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
>   subdirectories of our object directory, and then using binman combine
>   as needed.
>   - Maybe instead the Makefile logic above we would parse X_defconfig
>     and see if it's a different format of say PHASE:file to make it
>     easier to say share a single TPL config with all rk3399, have a few
>     common SPL configs and then just a board specific PPL.
>=20
> This solves (a) by removing them entirely. This solves (b) by removing
> the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> Linux Kernel again. This solves (c) again by removing it entirely.

Lets come back up here, to my proposal, since parts of it seem to have
not been clear enough. While what I'm proposing should work for any
platform and xPL -> xPL -> ... -> PPL, for this example let us assume
rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also, to
compare with today, it will be helpful to run "make
O=3D/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" and have the
resulting .config file available.

There shall be configs/rockpro64-rk3399_tpl_defconfig. This will contain
lines such as:
CONFIG_ARM=3Dy
CONFIG_ARCH_ROCKCHIP=3Dy
CONFIG_ROCKCHIP_RK3399=3Dy
CONFIG_TPL=3Dy

When you run "make O=3D/tmp/rockpro64-rk3399_tpl rockpro64-rk3399_tpl_defco=
nfig"
the resulting .config file will contain lines such as:
# CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
as this only makes sense in the context of building something that will
be TPL.

A more complex example is that it will also contain:
CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy

Because looking at arch/arm/mach-rockchip/Makefile a bunch of that will
be able to be simplified (and spl_common.c should be renamed to
xpl_common.c) to:
obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o xpl_com=
mon.o
obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o xpl_common.o

The .config file here will also contain:
CONFIG_DM_SERIAL=3Dy

What it will not contain is:
CONFIG_TPL_DM_SERIAL=3Dy

This is because there is no 'config TPL_DM_SERIAL' option in
drivers/serial/Kconfig anymore.

When you next run "make O=3D/tmp/rockpro64-rk3399_tpl all" the results in
/tmp/rockpro64-rk3399_tpl would be similar to the results as under
"/tmp/rockpro64-rk3399/tpl/" when building today.

The contents of configs/rockpro64-rk3399_spl_defconfig would be similar
to the tpl one, except with SPL-only-ever-valid options such as
CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but otherwise have CONFIG_DM_SERIAL=3Dy
and no CONFIG_SPL_DM_SERIAL=3Dy, and when building the "all" target, you
would only get similar results to what is under the spl/ directory
today.

Next we have configs/rockpro64-rk3399_ppl_defconfig.  When you run "make
O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig" the
important difference is what you do not have. You do not have:
CONFIG_SPL=3Dy
CONFIG_TPL=3Dy

Because we are not building SPL nor TPL. We're just making full U-Boot
itself. This is where in more full examples and with additional
restructure a "generic-arm64_ppl_defconfig" makes sense and be used
instead.

This brings up what to do with "ockpro64-rk3399_defconfig". And I'm a
little unsure which of the things I mentioned above is best. It's
either:
a) Does not exist, top-level Makefile says roughly:
%_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
  make O=3D$(objdir)/tpl %_tpl_defconfig all
  make O=3D$(objdir)/spl %_spl_defconfig all
  make O=3D$(objdir)/ppl %_ppl_defconfig all

But this might be too rigid.
b) It contains:
PHASE:VPL:rockpro64-rk3399_vpl_defconfig
PHASE:TPL:rockpro64-rk3399_tpl_defconfig
PHASE:SPL:rockpro64-rk3399_spl_defconfig
PHASE:PPL:rockpro64-rk3399_ppl_defconfig
And the top-level Makefile looks like:
%_defconfig:
  grep -q ^PHASE $@ || fatal "Invalid defconfig file, please see..."
  foreach line in $@
    make O=3D$(objdir)/$PHASE $CONFIGFILE all

It could also be some other suggestion.

--=20
Tom

--V//MpdqEM21SYuqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezhPcACgkQFHw5/5Y0
tyzUvQwAl6OzTBKbkme0xVr2VwQP+EzTQTdNumh9Nfh/GcUofSi76RnmH2oR3rn1
vE6dcKsFI+1gJF5Pjp22dXnTDeu1rzZC8cIb440CFypRsGb1A04PC+JPYJb1eQvS
NPvCVu5H2ggTW7y8l3HrTTVMF2i/qAYv05gAQ6jA1p1ZU0ugGHN7/2sDgs/52MoY
2Bvdx9rl4YyFPmyClKcEOHFdGACEsfyBCgXI/6dnTTt/e8UEHf6fQJZ0CgvkErT/
RiqAsOxcvY9cO6VF+Oqh896EdqG/AHzy42YQ2+0esGvdSW87Aahz2MDrILSPhoFE
FBEBAdy7McICQ18nzBos1ueLbDybpEFFF0aeUgWXybGJzS38OnxefXStOGpQ2tr+
uX7ulcKIRr/qJ8yUmrFF5K9H03o9azqaE7+eigR0P0ksBDEM3+a9J69+2UATFsXW
z5JPkQgbKaQNnpikGZR9yQ7UUpTxfMDUA3hqRkPdKh1VrKz9de5V3CQPOXxweqxd
OxCfHBW6
=cXsI
-----END PGP SIGNATURE-----

--V//MpdqEM21SYuqX--
