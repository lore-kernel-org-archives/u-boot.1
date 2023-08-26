Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4BDC83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 23:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30BDD8073D;
	Sun, 27 Aug 2023 01:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OtcK7rs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500E580B98; Sun, 27 Aug 2023 01:49:51 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E9880726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-58dce1f42d6so43316397b3.0
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693093787; x=1693698587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0v7i7Ys/wTBlptiHZxYPGmIE2xoYFhE2T+lY92KrOto=;
 b=OtcK7rs9RrWltDbm3t1JI3p2GIwQM7HYsVGVKhDsUHwd31rEJs0D6ArGzMdbD5kVNa
 pSly00hNTrcHnpdp2kYqY23p+6eozm5ixtL4hvy3Y1fVE2Pzay/1Ar3yJsauapTSnGU+
 AfcaCoz8GHZjadt3kajxBWOa1TDn8GJWYMOyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693093787; x=1693698587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0v7i7Ys/wTBlptiHZxYPGmIE2xoYFhE2T+lY92KrOto=;
 b=PM131kKhdEdZ6lUVtDJ4OahaetCb8Q7UZNOcORJxo/K7MvhC0BQX+RfuFUfgs7nf0U
 h/uNLeEbQhpqWQCm1aTuO33DxpzgH2q/HlBX4bgPjr8vQRS+AkW92F0Q9LCnyII77aLa
 w/QEdXiaMNNwebvCbv+U0nOpguehqTT3h4U9RKPYFlAAFwUTi/uaf0lI2L8jIYL9gsQp
 jBdwyct9/NtQSudit+d4IylIniOuemPEx+zDyfb1/R7g699mljTlNxDclEQIHhR0qA6C
 kGpqFUjrhZju4+mman/CnuyIwJl17hWFWCqRqYupXwdr1/EmU8lUCJH7oHGdGb9R1gAy
 doig==
X-Gm-Message-State: AOJu0YyDpbm1yss4zxjTZYnM2MWgjiIoh/c3W34ati1EXigaFGYrbxLC
 GIJF38PJg9cBG063BeDIOHlAQQ==
X-Google-Smtp-Source: AGHT+IEM271c31qlZIm6oovAho6teVVZ8XwvswdK1tkUXPFZOi9oSFaEhVzGHnEgiZpBgzmNCbE0xg==
X-Received: by 2002:a81:6dd3:0:b0:56f:fd0a:588d with SMTP id
 i202-20020a816dd3000000b0056ffd0a588dmr21898294ywc.8.1693093787331; 
 Sat, 26 Aug 2023 16:49:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-cf2b-5e4e-16cb-5c6a.res6.spectrum.com.
 [2603:6081:7b00:6400:cf2b:5e4e:16cb:5c6a])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a81a551000000b00586b5b6347csm1292022ywg.109.2023.08.26.16.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:49:46 -0700 (PDT)
Date: Sat, 26 Aug 2023 19:49:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: Re: [PATCH v2 00/23] bootstd: Support ChromiumOS better
Message-ID: <20230826234944.GU3953269@bill-the-cat>
References: <20230824195553.1685996-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zStYde1B0Dd6FcMm"
Content-Disposition: inline
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
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


--zStYde1B0Dd6FcMm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 01:55:23PM -0600, Simon Glass wrote:

> This updates the ChromiumOS bootmeth to detect multiple kernel partitions
> on a disk.
>=20
> It also includes minor code improvements to the partition drivers,
> including accessors for the optional fields.
>=20
> This series also includes some other related tweaks in testing.

For the series, applied to u-boot/next, thanks.

--=20
Tom

--zStYde1B0Dd6FcMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTqj48ACgkQFHw5/5Y0
tyyFQAwAm3wbtL++Af90DwrXH7f2NEcDakvyfkjCGYrqvkXSIJ1w8KKPF8nOnRTe
/8sAZiZFo/8cfozCM1e0DgaVQGahiVCaeXn93ddv3QyExcCS8MlMnGhDIzp5YBu/
UOK459tG7t4JyXjOvScbuAYJoHkJj5gyXEtJLbzP+GKLvszy0Y8p09YJmGRdQssP
qxkrgNQfox1OsG9H2Wx0qeu300eRGmiWqN01zLnMdTJpESsa1OC9X8TBtc855JIE
jHOyQBuPmpQ/bS7vQ9+2seos/nMCZuY+nmw7EeXdxE9iWIOz77mwtZbS6EzPj5/A
tPIoidfeEWzUw21gnHkRVyAn5aNzPjVUhvOOgRt3FKlrBS+3N92/jQFNsXHeVKyM
g6yQhf9Y7bQnSrrxQD8HcebVNgfZKXSxwxyqgepB787aO9LOEq5tQ6e2RehmeFnz
gJYCUSG3NjRJWzZOd8oIH7KVD8sfPCT2D2uWZRExq0qJs29aWrHGjpP+yAc7KZbs
AbW4lWGX
=DRIF
-----END PGP SIGNATURE-----

--zStYde1B0Dd6FcMm--
