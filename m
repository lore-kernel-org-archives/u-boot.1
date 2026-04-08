Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE9010F995A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5F783F98;
	Wed,  8 Apr 2026 18:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L/R+2e55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFA48404A; Wed,  8 Apr 2026 18:14:31 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7526B83D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-471618e202bso5274b6e.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775664868; x=1776269668; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2X1BmZlrW0zFvuUzH9wKFStxNfwWqM3FLAjpNLqjBw=;
 b=L/R+2e55XuSL46pLZ/B3sMMjar1RZKkyYjtIeS8yI5keEKX1Upi3SzXG8qOUNZbihC
 D5dKuuNbuwoUgwes8oDxxHqCCtcU+njvFg1fqSP06RxggzINZRjb02WX8gzBrID5TGOB
 ePYU+sOjLbKMSEpgxBLC88N8BDiQFn13RZyZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775664868; x=1776269668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2X1BmZlrW0zFvuUzH9wKFStxNfwWqM3FLAjpNLqjBw=;
 b=fvZSNCOebh7lOC0g4EOd8GbGemLCSHzr7cSwIzkTW/CRzkdRzpHqNuhr9asbTexLu7
 e01It4SW5R88s1Jz0SQjANr5lPSN6A1eXwo+FtQY8Z4MR9h2CkiDa1xKS0VmsHsdBtWu
 NHztLcqYIJi6GZeiBMOGx3xVhcEFWao5IMrvRJcFnu6LKpOHucdFJU6rIiQAzY76SS09
 fkQoP4C0/W9ilBRFcMUR8Q0rGgSDS7mEaXko9IWe6jPde/gis0c1nbBwTIPfAPXeVIdM
 stThyhPr7Z3j1XOYnYl8BbG28BNxnTV0K2kYMFja4zikjMy6mvvmU4Ep9+MHkvCxHPgR
 189Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXMXpBZepahE6bDpVF8IpDG/2UMyF7fDAXCABSujyd2DEv1yYIzgY4kkzWDrEgoMSgXjFH4lM=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ3dHsAtNKTvL6u2ODtPungj5RhS68YMdtoQgJA83GlDXXHgs7
 qNv0XS7rpd6weQt5kSIxrkWH2+ucV2BYf6j4iPzav07B63IUzAOJKAFPz9Y5pl8KO/Q=
X-Gm-Gg: AeBDiev0i5bkO/cYQ2ZVBE9915BRB3dSE9gWm76+MPfMa58NVIpJ8PNhDD3Mc+52/jk
 QF1hWWzseamTkTTO21S2XIUSZ+EyPMskkkyon0aGaGGOcfK/pjK9xOtlgErjyRtyqdvElPnTXjz
 B0y6jqtUBdbjbQofz7j4Enl6zqbrLXKQRDFClYesaHegy6iGYwpGOOy2zw3OKPb4gEN7Ws9WU9Q
 noOJq/Gvp8pjLaX4Y+AGxrKnWtaqZwM7QADYYtIU3nb+gOUntJoO8RYE23nkBmDPAHdt8ssHOi+
 vs9BosWYV+r1C1TsvUOnnZeIgk1pUBXpPqAD/Je0EvfNq5zXWf+IaHKdnLl7GbMJGbuvue2kQa/
 vkZNHrOL17aJNSZ52TvJEWO4MWhuAjM/rONV59KgWyN8U07EL8GTSd4tlDzcfsTiVE1AcgDnt9Y
 GKPbQs6kM1kW7x6BjmSeQeEaMz9b1VhmcGoaxZjPsKbuPz6PHKQMhA91LTKixkiFAtR4ZyPYgaZ
 I37aucIBItu9wz9gk7PE/HaovwUCClA8dX99KD0cuPCYWLp
X-Received: by 2002:a05:6808:5294:b0:467:32c1:acf1 with SMTP id
 5614622812f47-47723a76870mr95748b6e.39.1775664868088; 
 Wed, 08 Apr 2026 09:14:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4757665c7c5sm2411083b6e.1.2026.04.08.09.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:14:27 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:14:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>,
 openembedded-core@lists.openembedded.org, u-boot@lists.denx.de,
 simon.glass@canonical.com, Francesco Dolcini <francesco@dolcini.it>
Subject: Re: EXTERNAL - Host GnuTLS now needs pkcs11 support
Message-ID: <20260408161425.GC41863@bill-the-cat>
References: <f5ov7deig7xaovxmtx3nhewki6mudgebahghknhxodlfa3lrdh@ary63d3fodkz>
 <adX6wVUWvNrzYfuV@mt.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XbF3t9EVcNoRe6zu"
Content-Disposition: inline
In-Reply-To: <adX6wVUWvNrzYfuV@mt.com>
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


--XbF3t9EVcNoRe6zu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 08:50:41AM +0200, Wojciech Dubowik wrote:
> On Tue, Apr 07, 2026 at 06:15:13PM +0200, Franz Schnyder wrote:
> Hello Franz,
> > Hello Wojciech,
> >=20
> > with commit 0c716a157be ("tools: mkeficapsule: Add support for pkcs11"),
> > mkeficapsule now references to pkcs11 related symbols.
> >=20
> > This breaks our OE builds because it causes link failures for=20
> > configurations that build mkeficapsule when the host gnutls is=20
> > built without pkcs11 support:
> > ```
> > undefined reference to `gnutls_pkcs11_obj_list_import_url4'
> > undefined reference to `gnutls_x509_crt_import_pkcs11'
> > undefined reference to `gnutls_pkcs11_init'
> > undefined reference to `gnutls_pkcs11_add_provider'
> > undefined reference to `gnutls_pkcs11_deinit'
> > ```
> > On the OE side, enabling support in gnutls via p11-kit fixes the failur=
es.
> > However, I wonder what the cleanest solution would be. Should this new=
=20
> > host requirement for pkcs11 be handled in the U-Boot OE recipe,=A0 or is
> > there a better way to approach this correctly?
> >=20
> > Any ideas?
> I could add disable compile flag in mkeficapsule if there are no objectio=
ns. Sth
> like this in pkcs11 places:
>=20
> +#ifndef DISABLE_PKCS11
>                 ret =3D gnutls_privkey_import_pkcs11_url(pkey, ctx->key_f=
ile);
> [...]
> +#else
> +               fprintf(stdout, "Pkcs11 support is disabled\n");
> +               return -1;
> +#endif
>=20
> This way OE or possibly openwrt don't need to patch.

We should do this as a Kconfig symbol (which shouldn't be enabled by
default), and make sure that tools-only_defconfig does enable it and let
distros disable it as desired.

--=20
Tom

--XbF3t9EVcNoRe6zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadZ+3QAKCRAr4qD1Cr/k
CslWAP9IJYebAgzpwavtZYuCdtH/izsjMJzrHw4g+kjUT4a6vwEAo46Pm8cFArzL
s3tRpu+hFqK/WCIk0pjofDcw/E39ngw=
=rR2Q
-----END PGP SIGNATURE-----

--XbF3t9EVcNoRe6zu--
