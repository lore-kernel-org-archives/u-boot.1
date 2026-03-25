Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48BC109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C4683DA6;
	Wed, 25 Mar 2026 20:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qni1LLfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E8B83DA7; Wed, 25 Mar 2026 20:51:36 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2883E83A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-67934c83063so149808eaf.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774468293; x=1775073093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nuZkAFVgBUOBLDY4NsN1HMcknaC5TrhnOrJHRn7q2ic=;
 b=qni1LLfAEGfDh9pUAKI/49A3i7dWQMsdaVoZau+BDQWLNqIJIlpGFdWqUcrVIULAnG
 3NIh3FJ/8TDqi+IZt/UKJoD3umFvIHBPQUailhNvniIl6tMGioZ1shU6G3fPFnxei5Fb
 o68UDkyW4fq6QbTJ2yC/hKVIOvmF5krwdovvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774468293; x=1775073093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuZkAFVgBUOBLDY4NsN1HMcknaC5TrhnOrJHRn7q2ic=;
 b=tLonFkbYQSY9bnpOHHjMzX6Ci1XyTCR0kBzvny1DgayUJpgqDFB8BnFUZG4nMyStfc
 MXV0MSYibvvXdxszqoQ5sQ9GoyBThflkWDqI1xeM4uAY0BQXGUBPAFud+sV4deMvU7G4
 N0ThZDWq/XdubYXLVnLb1gGxokdvZJLxRqB7lzPm5XL/r4aXADRnZ/3qRAdRO2zhT4Iz
 c1LxmkEE2L8Ol8nhTSe29hbdf1LqLMDb0il2EsFHYmwvBTRkgMRmaIEN1t+PFMAXgo0u
 kZeImvpqnqtXs1g2yS3uT8jyzookZ4a3vOLJaXXK4bKGzG0K+ZAuSWQZ88BnYye0OKzQ
 6jeA==
X-Gm-Message-State: AOJu0YxnSqQ5EhySeeVboFhHKb/ARRczpM5X5jMyBXXx9UBS03bWAAfM
 xzRtLO1fzNHDFasLMhcUUDrPecfcJSJtHabAbyfhHlv8wVgCxoG4oyfg70snWnbXMZ4=
X-Gm-Gg: ATEYQzziPPhvVzVCBDynJV7dsRYfP+mo19D7knMITHjk7bu/5z08J7zhjwAuhM337Tw
 b7BwpvioIb5vc5GNpF+B8+ypquhrBNa2IiAE8oUuQsVmybiENcYsV0MzlO3d+mAs+qemNbxoN4Z
 P7DdrbT+L+pYxE5wkSisHtMR7wRKR4XpD4ZqPYniFF+X36oKSWgJSjnxCQ9gBKXColo1fGekqTl
 RRVoDu7c/5K3Mh9kenw6MLS/o9t+YkoD8pWEsn8hE3bvGXbD4Orkz5WDRuyLE2TpNS3V4bld+86
 dnilfGQmH/BmPdFQME/AvAMBqk9LipXDDWuR28c+cODmogEiyLpPOWDY59LsMxS06zJo57C9vFr
 TwkNjXt+0ZaY+unRLt3c6mLh0u+xeGfVX/tNJCowEGW5uUPLwcCkVw0aYmyW9qG9QL5iJzvaR04
 BN2OuofZjv9Tez3x6/3SQ8cbRgVm5i8MTcktr8aDDA5uJHSuF0f+YZ5ZGISwT/V6ynfPLUlc99t
 cVrNmunGs/G4AuAtGXxD1PSzVzgAk9gjtnqrZHM14h34FK5vzwN7af6sNQ=
X-Received: by 2002:a05:6820:d0e:b0:67b:d547:26e1 with SMTP id
 006d021491bc7-67dff51becfmr2445742eaf.43.1774468292807; 
 Wed, 25 Mar 2026 12:51:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e0aaf8185sm546769eaf.11.2026.03.25.12.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:51:32 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:51:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] arm: rockchip: Guard call of board_early_init_f in SPL
Message-ID: <20260325195129.GX502704@bill-the-cat>
References: <20260325190025.3428560-1-trini@konsulko.com>
 <fb6ee141-3369-45e6-8320-e91f67ec6b1e@kwiboo.se>
 <CAFLszTiF4RDyo8+4RZhsNViSNquU3Ouq2fNr5NjG7PvK+2zrtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NX7njlrbuT/Z+snT"
Content-Disposition: inline
In-Reply-To: <CAFLszTiF4RDyo8+4RZhsNViSNquU3Ouq2fNr5NjG7PvK+2zrtg@mail.gmail.com>
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


--NX7njlrbuT/Z+snT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 01:42:28PM -0600, Simon Glass wrote:
> Hi Jonas,
>=20
> On Wed, 25 Mar 2026 at 13:31, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Tom,
> >
> > On 3/25/2026 8:00 PM, Tom Rini wrote:
> > > Today, no platforms call board_early_init_f, and rockchip provides a
> > > weak default function. Change this to not providing a weak function a=
nd
> > > only call board_early_init_f if CONFIG_BOARD_EARLY_INIT_F is enabled.
> > > This will allow any potential future needs to be taken care of, and m=
ake
> > > future consolidation easier.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > > Cc: Kever Yang <kever.yang@rock-chips.com>
> > > ---
> > >  arch/arm/mach-rockchip/spl.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/sp=
l.c
> > > index e989c148079a..8026cc0abb8d 100644
> > > --- a/arch/arm/mach-rockchip/spl.c
> > > +++ b/arch/arm/mach-rockchip/spl.c
> > > @@ -97,11 +97,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 b=
oot_device)
> > >       return MMCSD_MODE_RAW;
> > >  }
> > >
> > > -__weak int board_early_init_f(void)
> > > -{
> > > -     return 0;
> > > -}
> > > -
> > >  __weak int arch_cpu_init(void)
> > >  {
> > >       return 0;
> > > @@ -111,7 +106,8 @@ void board_init_f(ulong dummy)
> > >  {
> > >       int ret;
> > >
> > > -     board_early_init_f();
> > > +     if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F))
> >
> > This patch seem to introduce a change in behavior for chromebook bob and
> > kevin, they do not seem to enable BOARD_EARLY_INIT_F, yet they have a
> > board_early_init_f() in board/google/gru/gru.c no longer being called
> > after this change.

I wouldn't call it a behavior change, since it's not called now, and
this is the output from building before/after, checking for size
differnces (and how I spotted odd cases as part of this overall work):

            chromebook_bob : spl/u-boot-spl:all -8 spl/u-boot-spl:text -8
               spl-u-boot-spl: add: 0/-1, grow: 0/-1 bytes: 0/-12 (-12)
                 function                                   old     new   d=
elta
                 board_init_f                               148     144    =
  -4
                 board_early_init_f                           8       -    =
  -8
            chromebook_kevin: spl/u-boot-spl:all -8 spl/u-boot-spl:text -8
               spl-u-boot-spl: add: 0/-1, grow: 0/-1 bytes: 0/-12 (-12)
                 function                                   old     new   d=
elta
                 board_init_f                               148     144    =
  -4
                 board_early_init_f                           8       -    =
  -8


> > I do not have a chromebook_bob/kevin so I cannot help verify if this
> > change break anything, hopefully Simon can help test/verify.
>=20
> Kevin spews some junk to the console with or without this patch.
>=20
> No change observed on bob or kevin. BTW both are in the lab so you
> should be able to test if you push to your tree.
>=20
> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_kevin
> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_bob

Perhaps the problem is those platforms should be enabling, but lost.
I'll take a look, but would be unrelated to this (since if enabling
BOARD_EARLY_INIT_F it would then call it).

--=20
Tom

--NX7njlrbuT/Z+snT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacQ8vgAKCRAr4qD1Cr/k
CqZJAP4p6bd0IBXJAJSDTvy1VypdoYs3RTG8hIIvK2HmIwos1wD/aLUdyruCUNFT
0fYbULk7Z5dNo24I6CU9RioV1E9ZSgQ=
=r+fN
-----END PGP SIGNATURE-----

--NX7njlrbuT/Z+snT--
