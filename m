Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BEEE776CB
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 22:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421ED86DE0;
	Tue,  3 Oct 2023 00:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9QJjY7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A797686DE0; Tue,  3 Oct 2023 00:46:47 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F3986DA7
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 00:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d8181087dc9so319247276.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696286804; x=1696891604; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZbUz0kN16lwPBEbYw7pQb3+xLEElalvHA4YkXyhR9Q=;
 b=T9QJjY7kYmAfbWZa1D5ARouwQd278MvOaVjuboMuNupo2m+9KcN5Ivk/3aP1gfi+Y/
 V6T+hyBUWuxibGA+/Za2SHOCl45tdH07fY7icPhEIByod6lBl5RQU2R5v06/aABsfHo0
 /Zg/auQmT1L8d7dW6aokN5A+mwypZraITDLCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696286804; x=1696891604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZbUz0kN16lwPBEbYw7pQb3+xLEElalvHA4YkXyhR9Q=;
 b=wqU/yZNDcHRtWSqmd7YPtKmgMezoG39G6wfdOQsLJvYpmPg4D1GPybM1ilcmLX9bHa
 9RcXK2nXPbFGRIlWQKkYyRUFhOcbp4+qQu06p4GRz6ZQa6M+OZ+EGlP76GVhtBoMyegA
 s+SUfIu/XBp+O+7BA4++lmdH91lLY8RzIi6omJV4o+1V/NDHQGOPwfNtrbOXalvYLM4L
 bUZZYAZ97QCzwSaBS5Pfy5uCg2LU8yA215uzmGxGf0C0F1gYGay5GawEodENos/0INg/
 ZfRwkRQ0dYo0xfmol+2tbSYP9CVZ8Cxree8KtehJL57c/tqeGcmcc4iAXEUX9KpK81r3
 Iirg==
X-Gm-Message-State: AOJu0YzTVy+fealYQW5LJ3iG+R4TnI8hBah8b4n49DJGosfKs7ol0sgL
 TtZw6snykCZ9jQcBeuKCqZ24lh3ltmZa3gMWluGTkw==
X-Google-Smtp-Source: AGHT+IGZe9vhi9XdbYj2UOiC9/ttw4S3sqydfRwnUaSuIPlGpxWGPuRqomwskecGq1k7k2szmr/INQ==
X-Received: by 2002:a25:ab21:0:b0:d29:3f14:9d96 with SMTP id
 u30-20020a25ab21000000b00d293f149d96mr12865346ybi.56.1696286804277; 
 Mon, 02 Oct 2023 15:46:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1bd6-f13c-2029-607c.res6.spectrum.com.
 [2603:6081:7b00:6400:1bd6:f13c:2029:607c])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a056902038c00b00d7b957d8ed9sm4876ybs.17.2023.10.02.15.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 15:46:43 -0700 (PDT)
Date: Mon, 2 Oct 2023 18:46:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@google.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] input: avoid NULL dereference
Message-ID: <20231002224641.GB8465@bill-the-cat>
References: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fBICtT7q8I4lCQZ4"
Content-Disposition: inline
In-Reply-To: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
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


--fBICtT7q8I4lCQZ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 12:27:25AM +0200, Heinrich Schuchardt wrote:
> Before using the result of env_get("stdin") we must check if it is NULL.
>=20
> Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
> need a dummy assignment in the else branch. Anyway this warning is
> disabled in the Makefile.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Avoid #if.
> ---
>  drivers/input/input.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index a4341e8c7c..de62189782 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -669,17 +669,19 @@ int input_stdio_register(struct stdio_dev *dev)
>  	int error;
> =20
>  	error =3D stdio_register(dev);
> -#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
> -	/* check if this is the standard input device */
> -	if (!error && strcmp(env_get("stdin"), dev->name) =3D=3D 0) {
> -		/* reassign the console */
> -		if (OVERWRITE_CONSOLE ||
> -				console_assign(stdin, dev->name))
> -			return -1;
> +	if ((IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)) &&
> +	    !error) {
> +		const char *cstdin;
> +
> +		/* check if this is the standard input device */
> +		cstdin =3D env_get("stdin");
> +		if (cstdin && !strcmp(cstdin, dev->name)) {
> +			/* reassign the console */
> +			if (OVERWRITE_CONSOLE ||
> +			    console_assign(stdin, dev->name))
> +				return -1;
> +		}
>  	}
> -#else
> -	error =3D error;
> -#endif
> =20
>  	return 0;
>  }

This is an example I think of where #if is more readable.

--=20
Tom

--fBICtT7q8I4lCQZ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUbSEYACgkQFHw5/5Y0
tyzolgwAo114244UT2wYERnVIYbk6cXa4tSNzAs9DJT2A9mPtbS9Xjun6u8tCSJb
Vx7iEHyts+onIqLKzePcTMy7CdL/QKx4juuANDrQ1ID5ihPIVxrFDORyDNRUjpNU
ITwKDsBfP+IZeXQB+pySGhf4GmQDxYWCwGqQqj23WNQ4sCQQm9zYSYODCC0Je72e
iSMWpZYpVKHIS1cx+rkWRTmiveO+xoQRuLNNWxLxO95U81zX+4zMQ2i0K+ahqZ7w
zhx6YE6zXOkqx8sLRWRCgz4eXw++4Jy5km/Z0wl42hH5jHmNZGtttgbLIxZs5SMy
Tlll+9IkJWsW1JX1pnA3iSho4O/1sYpbMdloVxjfjccqS4UycnbDyaRgNNh2bQVo
eRbck+oV9DOHVFbf2eys/c4F5+2ZEBldIKjkjIclMyQY9XtCEWqKNaqAzPMxH8+o
NUSSkfIc/X/xryGyI/sSf6clWyu1U8KzvvQT6sej825G+YRdxCe2RXALekXwxfuF
cT+iX+tl
=/TFz
-----END PGP SIGNATURE-----

--fBICtT7q8I4lCQZ4--
