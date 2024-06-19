Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F76C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549CC8836D;
	Wed, 19 Jun 2024 17:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bEwCB3ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA76087F19; Wed, 19 Jun 2024 17:24:58 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBDF8836D
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f8ffe1b65dso450043a34.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718810693; x=1719415493; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vXXynwaB01kiX0He1O0QisOXkqQ4EZ/R+52I2TRBzW0=;
 b=bEwCB3tsnw1Cl5mJP3CSPxyQJbIz075/KF9mIvexNn88ipGcDCjMUEWwONBfRUfvFH
 ZRFlpggA6jj1EMJm7mvXTWIUEpgDRWTMbzw/TOW0eh/MB+DtXV75IVBuX7tZXZ0rQvdU
 3Ssru/g3zEVgdsuwDPvh+iyvxAF6JAWpahSM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810693; x=1719415493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXXynwaB01kiX0He1O0QisOXkqQ4EZ/R+52I2TRBzW0=;
 b=C+ubA3jFFZq5IBL8/OvBl4S+WdW/Lv5CALT9zDj4IWxyn0ieG7uyQIYuCJZFQcI9eW
 P/UE+ANRB3hM9+DuzO45AqVxtUEMkKIfCclYBZ2c3Y9kp/1BjUCZQR+WyfsTUqxvnL9s
 VK22nKgwNLhXdDXxlYC4F91A79CGHonphHcU8+5Sy0ai61PNCyVwitwLyiW442vaMMUI
 hlmP6jg7RXk9EEuMcCMjp/H7fF4mQskWmoGp1aco8LBMirySGnt7S7NyKkVzIX7Qn1uw
 Fr+f1Bo3/6FLdaOCThAJMKLpbOQ8RGqQqJitQutQOW9B7NHrkXGtZR2huJJ7K/0HJBIs
 g1Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIUAhSXe6O27JMNLY/HYgvfgVPCrhO/0mnmdUDjZKG5DF2R7KrcjJhpbVwAenRXALq81Y/kvo8nVYsd6Tuq9xhlyNMLA==
X-Gm-Message-State: AOJu0YylYm5MZ6jUu8G9fD0+EULEAii2YWRGocb7XJLstX0oI6Gu6xPs
 29gxGK7ODL8yX6ryEKp1acY+iJvSVDwJ/IpILJe6o2zGnuOWHa54XHfh9PoABzo=
X-Google-Smtp-Source: AGHT+IH3etpvK7TKOiBfv+3dyl+hZVgoe4KEJscO5KlMKji0UoYED8IsY5PVu3kGLo1TyOFIhhcWMA==
X-Received: by 2002:a05:6830:18c4:b0:6f9:9268:751 with SMTP id
 46e09a7af769-7006aa4ed75mr1262840a34.14.1718810693311; 
 Wed, 19 Jun 2024 08:24:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b63ee15sm2198285a34.57.2024.06.19.08.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:24:52 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:24:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] arm: implement invalidate_icache_all on ARM11
Message-ID: <20240619152449.GD68077@bill-the-cat>
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-3-heinrich.schuchardt@canonical.com>
 <CAC_iWj+VpDYAdzj0fqxBPAPshVt03g9SCNafxN-8RPdrPVDiMg@mail.gmail.com>
 <e8c883a8-7dd6-434b-b477-41959e3e7746@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/4yG9IucDOJitg+3"
Content-Disposition: inline
In-Reply-To: <e8c883a8-7dd6-434b-b477-41959e3e7746@canonical.com>
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


--/4yG9IucDOJitg+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 02:56:24PM +0200, Heinrich Schuchardt wrote:
> On 19.06.24 14:22, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >=20
> > On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > In EFI sub-system we rely on invalidate_icache_all() to invalidate the
> > > instruction cache after loading binaries. Add the missing implementat=
ion on
> > > ARM1136, ARM1176.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   arch/arm/cpu/arm11/cpu.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/arch/arm/cpu/arm11/cpu.c b/arch/arm/cpu/arm11/cpu.c
> > > index 01d2e1a125d..4bf0446b543 100644
> > > --- a/arch/arm/cpu/arm11/cpu.c
> > > +++ b/arch/arm/cpu/arm11/cpu.c
> > > @@ -116,3 +116,15 @@ void enable_caches(void)
> > >   #endif
> > >   }
> > >   #endif
> > > +
> > > +#if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
> > > +/* Invalidate entire I-cache */
> > > +void invalidate_icache_all(void)
> > > +{
> > > +       unsigned long i =3D 0;
> > > +
> > > +       asm ("mcr p15, 0, %0, c7, c5, 0" : : "r" (i));
> >=20
> > This looks correct, but can't we define it as
> > __asm__("mcr p15, 0, %0, c7, c5, 0" : : "r" (0)); ?
>=20
> Both compile to the same code. So we should simplify the expression.
>=20
> arch/arm/cpu/armv7/cache_v7.c and other modules always uses asm and not
> __asm__.
>=20
> @Tom:
> Can we specify what is preferred in doc/develop/codingstyle.rst?
>=20
> https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html gives some
> background.

Sure.

--=20
Tom

--/4yG9IucDOJitg+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZy+EEACgkQFHw5/5Y0
tyxxnwwAr/UIfJtK2Tl+2mKdfxd+MVZplO4UBI5Wj8qfX1/u2OOTAD1zgoDdcRAQ
SDSgRubH8ug2dlUmF6qyRQj2IsugWCJhjoZD+IOo2ETGGvSknfIX5iLCyiMj0KmT
EPnl7YVL2sQbArwT7SB/8gnjScLk/cS6Moj34f5vPSxdTJWHcsnJknWcMsb9WNFe
9Bslkp7nPoDSLK9+dtkVjvILboL32c7xoMzCA5ibQHOFJEinUKVhUhgQnaMSw5bX
K+ICUpmGXq324kJzPe8QMpgoH/ZIMnrAIfZO257sdptzPPG/rJoEQnmpw98JDpur
Itr0r1/OSkM0sREXrCf8YmkRK+yCLVWxRzspanOyc9CwLrhWkDfPpHPIDGmJ7gaJ
MZ6WllZDvDb4KeA+ooBHdWjvDr/pG/6ICgv68S1IzK3nUSp9QZ2t3/8z6XOVpnKk
Vh/IbLPkWlM9uvGuUVRmQ2e5kos+l5qGUxRy62qQuliSstZKeVKcsoB4Gl9KVi+n
Ze3loy7O
=eZ2d
-----END PGP SIGNATURE-----

--/4yG9IucDOJitg+3--
