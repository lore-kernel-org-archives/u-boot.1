Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC827C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4815981B4B;
	Fri, 18 Apr 2025 16:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Br9VJ+bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1280680584; Fri, 18 Apr 2025 16:18:38 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D722282A46
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso593791b6e.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744985912; x=1745590712; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h/5ci35GEkHVNxx1J9Cvyjp4FpvgRH5aCTtm6bSlulE=;
 b=Br9VJ+bNL4jMRMGiru+YmmMRmz4jXCGmC4pJSelsdhXgtn6G1tKhOvphA2yHXgwSun
 mSRWpalFI76VdX1tjZWrVIORtV/k/+nI0qmcSPr0DeSqmcpkm2FzaUd7pjmv7NuqL3Yt
 KB45O6abXtK9DQky8jsXDJrWAMcRb2cJ/z148=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985912; x=1745590712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/5ci35GEkHVNxx1J9Cvyjp4FpvgRH5aCTtm6bSlulE=;
 b=HEeRZm1bmGdbLeJ8XB+NUxyk006oq4B0soi4VQ9WSJ+WGB7H8bqjQJmapOjbKT8OM8
 NQpHThGc5iM+q4gymQa0xA5nFCCcbVNBGGSjUWt+qH28KctVVLkW9mXnMB7O36UhSVvs
 qJAeDwyBSWMH1JJMquuqFWJt+MlkgT1Yd3UvsTdD9B8ecvFS63Sd3oPvzTC/KmZ+eyDA
 swtcp/zNM2sJcrZryKn2kGOD5y44ZQtKIiMcg5JR2j7g5BnASdNOtRhc8ykr/OqvsWFc
 9A9kY9ooXSAos+64h02w5fj/OQLZfJQT/J0ddmh9Ao6px4ziueovF6fSZqabq0qYEz6c
 EUYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbzcLnFVj++48CCK5axGr0FOlk+EXq98XA44cw4ZcEcuAD6FPCllSn/C48uZc4K5upz9I/f9Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yxw4AG1GIuyVljZnRAeCmO8aXtvfN6oPb9Jx0dM0oJnqZCmCIQT
 mM7+U8nIrxttNROr0pWW5AP4K33OVKXJYIQ5XrUu2O6EOgYZUC99Punb0sIa0bM=
X-Gm-Gg: ASbGncvCNCKPD5ZiGXlc9gkJg1nllF7FKK51lMVZIaI9tZY2RMSmGpJXXEMPat7JRSL
 Fj8z/gonwbZbCS+wEzmTTVdDNQC1b+LRpYU8+9ldSoVam1f+TDSquLztakn4zANy2i93jJM1OsE
 EO+iFMxFfOcK5swarptVj/lqVadnGB/n6FNJuR7ayc+jUKavhRXogUD36GPFdbAnmkNYiQo9De3
 Ihrw697Ic+G070aBJQOMpq2J9i9GJASCS/95Iu4+i27MWLPvcJynlF+yAQ5bzMS0/I3D9gD05da
 QqN5gn3/6iInwRLpaisX88Wi3/9eHPvv4f+ZhEr0uU/U6ZFmubiBzxI0SR1XWhlTki4Hg8yPK19
 ZbOAxRvnvczsj
X-Google-Smtp-Source: AGHT+IFSWAIMG9L+NVajcyrDFlYfgEwnygHUYRWo/uTbnEgf3JH6y+qvEQqWVQZa6LBYfxEtzqsqnQ==
X-Received: by 2002:a05:6808:6f97:b0:3fe:af0a:f8da with SMTP id
 5614622812f47-401c0cc659dmr1353000b6e.38.1744985912574; 
 Fri, 18 Apr 2025 07:18:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff6aad00sm373091eaf.35.2025.04.18.07.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:18:31 -0700 (PDT)
Date: Fri, 18 Apr 2025 08:18:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: ant.v.moryakov@gmail.com, u-boot@lists.denx.de,
 Maks Mishin <maks.mishinFZ@gmail.com>
Subject: Re: [PATCH] scripts: Fix potential null-deref
Message-ID: <20250418141829.GQ5495@bill-the-cat>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
 <ebd844d2-fa08-4e5c-b5c1-554d1e86ea27@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XGyR/Tl/w5BXorD1"
Content-Disposition: inline
In-Reply-To: <ebd844d2-fa08-4e5c-b5c1-554d1e86ea27@cherry.de>
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


--XGyR/Tl/w5BXorD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 03:51:42PM +0200, Quentin Schulz wrote:
> Hi Maks(?)
>=20
> On 4/18/25 10:19 AM, ant.v.moryakov@gmail.com wrote:
> > From: Maks Mishin <maks.mishinFZ@gmail.com>
> >=20
> > Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
>=20
> This seems to differ from the sender. Are you Maks? If not, you need to a=
dd
> your Signed-off-by to fulfill the DCO requirements.
>=20
> > ---
> >   scripts/kconfig/menu.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> > index 5c5c1374..a0d0d2af 100644
> > --- a/scripts/kconfig/menu.c
> > +++ b/scripts/kconfig/menu.c
> > @@ -812,8 +812,10 @@ static void get_symbol_str(struct gstr *r, struct =
symbol *sym,
> >   			}
> >   		}
> >   	}
> > -	for_all_prompts(sym, prop)
> > -		get_prompt_str(r, prop, head);
> > +	if (sym) {
> > +		for_all_prompts(sym, prop)
> > +			get_prompt_str(r, prop, head);
> > +	}
> >   	prop =3D get_symbol_prop(sym);
>=20
> This one too can do a null-deref.
>=20
> And same for some other functions after as well.
>=20
> Wondering if we shouldn't update the macros to not enter the for loops if
> sym is NULL? So we don't have to patch every caller?

The feedback I had with the original patches here was to bring this up
with the linux kernel community first as this comes from them (and
there's a much wider security-focused set or reviewers there). We can
then easily backport fixes.

--=20
Tom

--XGyR/Tl/w5BXorD1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCXzUACgkQFHw5/5Y0
tywAZAv/epRNuu+g9tJl9eUC4OheMsTDbM1RrqZBstE53qm09r5ZuqXYdh+hhiVT
KOmrJy78UPOpBuWl1Gg4xdeCpqPSmOYBnoJ88ds8NUCghKWCisVrm23nwJxE+VKl
oMJQneiOte+IUQdJML9eq0PYLtLLwlOpSlV2VBUrZECDOAxb25zwJcnOlB7mEso7
QwJS6otfKB6e21TBMMn8b9JBEVWIPEIi7+uFbhA39k5s0j6WpXD4plPL7BtIgYi+
QrY3+cOb5DUTsBmy4BCB1YGC1XeR+ymFEnOAOH+8eKkSuY4kbVCvICD1alJms4Cf
tVv9zGeP9w215hd5HyLpcYr08uix06SAcH2/3vFae2y6mDiBuqyBzeDnBrU4fOjo
5gBVV91Ys52gpJRa/1WQI8f345ex6Bx7PuZAQZjX2PaYSG1/1Iw1zOgjbF46M7tl
ptGJG8qM9ECkoZd7OOsJ6LTdTQ8WFoToUcMj1WwjWKoXTJKqfrymx1N9pBTMYx0l
TrucP9YH
=ASdp
-----END PGP SIGNATURE-----

--XGyR/Tl/w5BXorD1--
