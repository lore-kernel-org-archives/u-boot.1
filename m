Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16561C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 16:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DBF583989;
	Sat, 13 Jul 2024 18:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gGddoxMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837FF887B9; Sat, 13 Jul 2024 18:50:23 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6C987D6B
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 18:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5ce739c2650so346228eaf.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720889420; x=1721494220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tlfF7hMKuTaZb9qZXlHXXou9fr1sPRnXOHfG8e0rFfg=;
 b=gGddoxMvtu76HvEboV1iobR8SNgVztN7t3YvHOU29Xd/KnT67dHJog/5LlRaLtvAsd
 ajWkv6FuHMXw0zsw6/1zIDIQZ/BxSZ8ZxaoMUwrn9s/Mkbam8i2WXt43unakk64aFyA9
 6FrQrVdzY4Jf5UWofZOD53UZJX8aGg40UHfNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720889420; x=1721494220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlfF7hMKuTaZb9qZXlHXXou9fr1sPRnXOHfG8e0rFfg=;
 b=GD5YySFt/6uYp+GQzt0JokF3zocmO6awOJaN08TIyCfrspTCWYB4QvZzVgvFPDU0hW
 aX3M+zqOUEBdnpiO+YlAfKqeik0Lx9IUngiGJuk6sbgDmOpYso1wIeRA+0StmEKJEtic
 DD4KRhgDrme13ftXT7t36H+++GKxo2BgNhJqgPzT1lGeBLVX5oLhCjsOKJu8vXru7wT/
 F+VXTQgrAsUqbALUwiOHqAeBJwu77U8f8zn3slJ0NXnoB0ivLdeYG6ocIpXZ/zrt5MwV
 nRBWcADlhEQNamz17TPohNVNdcGz1HtssH3KE2owaunUiwamtc6DtpQoOqOPNm8uQyGO
 EFcA==
X-Gm-Message-State: AOJu0Yyu+xI4/EwqnIeri82w+BbaOk/lSaZ2sqN6pPMIuO7dmnWd7Ahz
 Rm9c+pLOL/5Ku3vEvzsbbuALZGrX1ncbargdtZD8pAscw8nuDkVNGrfX6cWjRiU=
X-Google-Smtp-Source: AGHT+IH3ThrFPG2OR8n+N5z9wdwEit45PtyP93rk49atiasQkF6Aa/gbZZx2H2Wa8HQ97a0/rNkw0A==
X-Received: by 2002:a05:6820:1786:b0:5c6:8618:5995 with SMTP id
 006d021491bc7-5ccdf493f2fmr6264393eaf.8.1720889419905; 
 Sat, 13 Jul 2024 09:50:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce74df064esm251571eaf.6.2024.07.13.09.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 09:50:19 -0700 (PDT)
Date: Sat, 13 Jul 2024 10:50:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [v2] bootstash: Do not provide a default address for all
Message-ID: <20240713165017.GC38804@bill-the-cat>
References: <20240703212338.1436606-1-trini@konsulko.com>
 <20240711212710.2743991-1-trini@konsulko.com>
 <CAFLszThp7ygWBVMmksYQrO8HTRSm5optwSh63==5fMEQ7btM+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9a1VS74sWwxTXLlS"
Content-Disposition: inline
In-Reply-To: <CAFLszThp7ygWBVMmksYQrO8HTRSm5optwSh63==5fMEQ7btM+g@mail.gmail.com>
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


--9a1VS74sWwxTXLlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 04:13:50PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 11 Jul 2024 at 22:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > A valid memory location to stash bootstage information at will be
> > architecture dependent. Move the existing defaults to the main Kconfig
> > file for this option and set 0x0 as the default only for sandbox.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - Seeing that BOOTSTAGE_STASH_ADDR did not depend on BOOTSTAGE_STASH in
> >   turn lead to discovering that (minor) BOOTSTAGE_STASH_SIZE was also
> >   missing a depends on line and then that a number of places built code
> >   with BOOTSTAGE_STASH_ADDR=3D0x0 as a compiles-but-likely-fails option.
> >   Rework a number of spots to guard usage around BOOTSTAGE_STASH being
> >   enabled.
> > ---
> >  arch/arm/mach-rockchip/tpl.c      |  4 ++--
> >  arch/arm/mach-stm32mp/Kconfig.13x |  3 ---
> >  arch/arm/mach-stm32mp/Kconfig.15x |  3 ---
> >  arch/arm/mach-stm32mp/Kconfig.25x |  3 ---
> >  arch/x86/cpu/cpu.c                |  2 ++
> >  boot/Kconfig                      |  6 +++++-
> >  cmd/bootstage.c                   |  8 +++++++-
> >  common/board_f.c                  |  2 ++
> >  common/bootstage.c                |  2 ++
> >  common/spl/spl.c                  |  2 ++
> >  include/bootstage.h               | 14 ++++++++------
> >  11 files changed, 30 insertions(+), 19 deletions(-)
>=20
> There is quite a bit going on in this patch.

Yes, there was unfortunately some underlying bugs.

> > diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> > index 50f04f9474a0..a47cba5163ab 100644
> > --- a/arch/arm/mach-rockchip/tpl.c
> > +++ b/arch/arm/mach-rockchip/tpl.c
> > @@ -92,10 +92,10 @@ void board_init_f(ulong dummy)
> >  int board_return_to_bootrom(struct spl_image_info *spl_image,
> >                             struct spl_boot_device *bootdev)
> >  {
> > -#ifdef CONFIG_BOOTSTAGE_STASH
> > -       int ret;
> > +       int __maybe_unused ret;
> >
> >         bootstage_mark_name(BOOTSTAGE_ID_END_TPL, "end tpl");
> > +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
>=20
> It should be enough to just call bootstage_stash_default() here,
> unconditionally. It does nothing if not enabled.

Nope, we don't have ADDR/SIZE defined. The current defaulting them to
0 leads to the case today where platforms which don't enable stash have
~700 bytes of stash related code being kept.

[snip]
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 7794ddccade1..47db4ead5050 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -472,11 +472,13 @@ static int spl_common_init(bool setup_malloc)
> >                       ret);
> >                 return ret;
> >         }
> > +#if CONFIG_IS_ENABLED(BOOTSTAGE)
>=20
> I don't think this #ifdef is needed.

As part of being able to discard the stash functionality, it is.

> >         if (!u_boot_first_phase()) {
> >                 ret =3D bootstage_unstash_default();
> >                 if (ret)
> >                         log_debug("Failed to unstash bootstage: ret=3D%=
d\n", ret);
> >         }
> > +#endif
> >         bootstage_mark_name(get_bootstage_id(true),
> >                             spl_phase_name(spl_phase()));
> >  #if CONFIG_IS_ENABLED(LOG)
> > diff --git a/include/bootstage.h b/include/bootstage.h
> > index f4e77b09d747..2d4987f31414 100644
> > --- a/include/bootstage.h
> > +++ b/include/bootstage.h
> > @@ -462,18 +462,20 @@ int _bootstage_unstash_default(void);
> >
> >  static inline int bootstage_stash_default(void)
> >  {
> > -       if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE=
_STASH))
> > -               return _bootstage_stash_default();
> > -
> > +#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
> > +       return _bootstage_stash_default();
> > +#else
> >         return 0;
> > +#endif
>=20
> I believe you can leave this as it is.
>=20
> >  }
> >
> >  static inline int bootstage_unstash_default(void)
> >  {
> > -       if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE=
_STASH))
> > -               return _bootstage_unstash_default();
> > -
> > +#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
> > +       return _bootstage_unstash_default();
> > +#else
> >         return 0;
> > +#endif
>=20
> and this

Nope, this too is required to discard "stash" when not enabled.

--=20
Tom

--9a1VS74sWwxTXLlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaSsEUACgkQFHw5/5Y0
tyyrhQwAiDkQRlTk06qO/z5L4xC+ghRNMmpUqRJcfL4UlAUgKxOhadkA4I/Wjmko
JDmYNtbzQFDGIQ1YUUMstAuKXUUfpvzhaKE/ZBpLanl5FhO1FbCoRTtsXrRY7VlL
4qX2nNFYHSMcjEyZmmJevd+oDT6SNI1jAkrUX/8SfnuUNbU0C+KUIHAPbEr++xuZ
atLKP3JQVzzk10d0WaJ3CviMsVVLIzW1Ne7ZTMRAmZQSbwWwhDwm1UkPR7Vaps/Q
nA/pDdg0Sjzs/mjmXXV2tfqxn3R2Pw1T9LxFG3Uwz2haSiA4+So1+Yh72HbCmFTX
VBrJ6yLHQ/HWAhYqWi+ICJLY1rhffMnrjPmPo3gVEQ1VEucTtwrz/ozTFbg1eSq1
3RVon/zcO4UIrwVjkszKJtuz/ni53yhu8Cyh8mh1u+fqlNg74pbVDdtFtoZk9aOs
m6UANsTR0bL4+CEeiRLus8P0Mn05Z03kJYNPwJWkpilLPJ/6lPJ6KfrxYubEw4Sh
h+GABxk+
=NdHi
-----END PGP SIGNATURE-----

--9a1VS74sWwxTXLlS--
