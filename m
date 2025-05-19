Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E4C3ABDD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 19:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3241E82A39;
	Mon, 19 May 2025 21:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bkiorTKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F5782A46; Mon, 19 May 2025 21:11:23 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7E682952
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 21:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3f6eaa017d0so4231432b6e.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747681880; x=1748286680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ouvutywAv1EHeDHOA2bRVpKzP/ycRFLQGtXZi08hTro=;
 b=bkiorTKcnWa/a/vrZg69eF9XEsqxZAbbfVO3eKyqZHUEIyy+iT3ht9DHuf63Ol9Efn
 otYx7Sa3gKO2Mmx02kMM3C5QMUOXEjcCm/R1+SGooRnGlCMHYQaeOBw6uo/vwd5MrPrc
 JZojTZYuYV5eVN5ls6DDYuYWm5paWiAwEFab8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747681880; x=1748286680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouvutywAv1EHeDHOA2bRVpKzP/ycRFLQGtXZi08hTro=;
 b=NA4kHglD9YGgiAhYujkGoAIgouuKLbh4WOYRYuOcuKn5c5KQVwhA0lVXQVe2oZ6h98
 kdUw7sffZnt0VccgGNqSEQDWywo++tAu9MzIh8nXmlZF1SNIoHeoOSaC47LwOBXMXcQy
 1bQBhKSIPDV2U+V8f3t9046wOz6AZy7bQyWWvUcyGGG6mf0r6XVmdJ4JJPJHakYp1qPn
 5iCWApbNY9fQH7Wj8AHbuFtOB2chKZ+ons6yGXTf5O5QZzNGDVynV6YSgTXK0DeHR62z
 EsmjdnFKUSUUF6id27qbEC9OIzgfXI79DCWjZ4ILYgE2Bp71xAiemMIz/ZExQrjLpAQd
 EE6w==
X-Gm-Message-State: AOJu0YxShzWXmhvdTWocPyZIEDxs7m8IXYt6DXAAQZTKeZ50NEcf1XsS
 54Dg8VZe6I6nUpmH7hloTC5vFZpTlv+uDpYDGqQHfBTn09HnVAaqs95EO67iDNgObYE=
X-Gm-Gg: ASbGncuF8jSw5cwWwDaigLiKlFEpjBcBnm86xRf9IW17zd6K0UKG4j2dmTclf1gYUfA
 dZJ/U/UzwLK/vHH+/8HOOiukwiJC2AATiyHZ9g56IbO+HiRp2fvOYxRNYX9IH1m9L+zXP/IkqNZ
 tbhF+EMJ4fe7yio0Q1XspOirtA/PAV1bt/FxSizoxdEo4oaNhq97Dd2RU3KWqmPlE6AgJfTgSLX
 gw13um3ZQVFT8Sfx8wvSJgNVpiHBkk8J1DLhKSgFW7IC0a/4Yei5heFCirsDTcZLSPfifStcMF7
 bswYrl6ujC+CFttSzp7Gl4d2oHVtUyjfW66mEPxVf3lHlOPGocFAn8YVdJndB0qDekUCbwZYkCh
 6TTtxTzhA/tMgTASGZUZ0u+M=
X-Google-Smtp-Source: AGHT+IHAN4jqUr51k3TzpxKOLT7UmtfAsLYcQ0jaX3FGOZSdgN3WAhLoT5X1vvuhQTN9vbckHltFqA==
X-Received: by 2002:a05:6808:2f0a:b0:401:e933:5de9 with SMTP id
 5614622812f47-404d87504ffmr9235844b6e.18.1747681879747; 
 Mon, 19 May 2025 12:11:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404eacec299sm962137b6e.26.2025.05.19.12.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 12:11:18 -0700 (PDT)
Date: Mon, 19 May 2025 13:11:16 -0600
From: Tom Rini <trini@konsulko.com>
To: ant.v.moryakov@gmail.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] lib: add NULL pointer check for %s format
Message-ID: <20250519191116.GT100073@bill-the-cat>
References: <20250516185447.141540-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8TwG6YxWNKFOJzid"
Content-Disposition: inline
In-Reply-To: <20250516185447.141540-1-ant.v.moryakov@gmail.com>
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


--8TwG6YxWNKFOJzid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 09:54:47PM +0300, ant.v.moryakov@gmail.com wrote:

> From: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> Handle NULL pointer case in string formatting (%s) by printing '(null)'
> instead of dereferencing NULL pointer. Makes behavior consistent with
> standard printf implementations and prevents potential crashes.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>"

First, this is tiny-printf so the subject should be changed to be
clearer about the impact. This is only used in very constrained
environments.

> ---
>  lib/tiny-printf.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
> index faf55d7f327..da596d72050 100644
> --- a/lib/tiny-printf.c
> +++ b/lib/tiny-printf.c
> @@ -306,6 +306,8 @@ static int _vprintf(struct printf_info *info, const c=
har *fmt, va_list va)
>  				break;
>  			case 's':
>  				p =3D va_arg(va, char*);
> +				if (!p)
> +					p =3D "(null)";
>  				break;
>  			case '%':
>  				out(info, '%');

It's so constrained that I'd rather not include "(null)". We should end
up printing nothing in this case, as this is handled in commit
f0dab28915b7 ("tiny-printf: Handle NULL pointer argument to %s") and
having a print where we just omit something, in this constrained
environment, is acceptable (and should be the debug hint needed).

--=20
Tom

--8TwG6YxWNKFOJzid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrglAACgkQFHw5/5Y0
tyw2Ywv9ElPAef9VchNyfUEABjJ3dk/6dq4jR5KZBvu2bbj8B25qL4iQ6kRK3f+t
YbL0E5i2gcNfxnS+Fnarfugk2SJ+6qO543QvtSaggkTsYL1EAGJdThxD/DHOBi1h
j3vbrc8/3E3TEgUbFNb46ETtjQkLG6o7s36K88bCjkGdcktUc0M7aNwXGB3NBYyV
d7VGg42mGdtHAAONCLN6nByMpGmPOsMXXLh94b2RtZHMpYMy2MgAPeUh+XLgFvGO
YkisqPIham0jw3m+7b0PVpkpPhvbYr1HguV0+FzMZmaeLBnpSnkD1v4jMRj69TuW
6k0B9cRx9Ajuqv1mXCVz4POl6INPFnRZV/0eZGEI287UxZodvxo89o95Z7U8zrty
HUywPNnnuYlVeru+aB9GSkMOxSQl1TdjTZ/Ju6BSYjapeZ+GsGljdCDBv/0vQiae
L3axqCMEMszB0EsBmEhhLjQOLNKsnW7tQCQIrZb96UOZAHrzX1URr1XN3Qfza6AO
M8Y4oCX+
=K16a
-----END PGP SIGNATURE-----

--8TwG6YxWNKFOJzid--
