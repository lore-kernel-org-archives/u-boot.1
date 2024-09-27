Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816CFCEBF60
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 00:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F62C88F4C;
	Fri, 27 Sep 2024 02:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UaSzzhDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F26E88F4C; Fri, 27 Sep 2024 02:22:38 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2A188D9B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 02:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a99d23e036so150986885a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 17:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727396554; x=1728001354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aaMUrAy5lMDPgSH3WxrkKQHPad2JCbCEGhiw9mFTXKs=;
 b=UaSzzhDttxsk+smOizvW0H5DqLXSf6UWESLWGQ2R5Zlvj5uFFGNsEXkjBkEUvVWXmq
 UdOK4TGBpe0ghdIxs53VdiUsKQ7bHRikwetU9ueGK60qMb4q3g2rKJFza7Xxr4qTIkIp
 NHsrNvpNSVS/t2/23kgYG+PXBGhcu9V6p9PFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727396554; x=1728001354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaMUrAy5lMDPgSH3WxrkKQHPad2JCbCEGhiw9mFTXKs=;
 b=X31ntcnNsXuL/xi/OqeRYgkuwMK/pQztNbjvg70Bz42rbSN34neImFbz3/f2Hq6ivV
 w9QWMxVr8wyMss2yljzAJm9631ElT0J7QakjwNh3sLSuLUycauKrFK5oo+YefiLi0iae
 yGr+NKGpEXIQfPgUL6BExuuFJRbUGDFsPPvYwZTZCnE8ZQx4AFSYjiA7BIETLVo8ZBmX
 leeNbXbHU6A8uK/CAETPw60+0GDGIgsHT73ROzdINI4DIlX6xtwF2QWDowM6MI2Idb9+
 alhBmqFhIeXnvPmje3SrtaMOJxNFgwjVN+RzsHv2FTOK/VqS4zYO6TAYHW2C0leSSven
 cuhw==
X-Gm-Message-State: AOJu0YwAJZN3FMaR1jQm5LxNrYwqHIO9skjuU5dvfV4BDbWytloCurB8
 6CxvAMLoUOzeIzLHYpVpJbT8nrNcmnkxsVcMiNQGZv1BQ7nab/na/nLwDGRXtJz0SuLmUAkCpbu
 Ojgo=
X-Google-Smtp-Source: AGHT+IF5jm+tfgIbro6IehfAFITJrMPWXn/lGI8OjBvuQrNJt+FrwxrKlolbUjmyJTvPq7FdKvQK/w==
X-Received: by 2002:a05:620a:400d:b0:7ac:b93b:b21b with SMTP id
 af79cd13be357-7ae37755da0mr231666485a.0.1727396554583; 
 Thu, 26 Sep 2024 17:22:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bd791sm38171985a.24.2024.09.26.17.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 17:22:34 -0700 (PDT)
Date: Thu, 26 Sep 2024 18:22:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20240927002231.GP4252@bill-the-cat>
References: <CAFLszTi-vwb90vZMDAou=-gdZzSeJvRYPWG6V0=BCLLjYWn7Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8FZg7TLh9/3noSyv"
Content-Disposition: inline
In-Reply-To: <CAFLszTi-vwb90vZMDAou=-gdZzSeJvRYPWG6V0=BCLLjYWn7Gg@mail.gmail.com>
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


--8FZg7TLh9/3noSyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:22:01PM +0200, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/22430
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D68&view=
=3Dresults
>=20
>=20
> The following changes since commit 4386ab9118e7b405829fbcb3bbbaf2f47ddf0b=
44:
>=20
>   power: regulator: Consistently return -ENOSYS when ops is
> unimplemented (2024-09-25 08:54:03 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-next-26sep24
>=20
> for you to fetch changes up to ac0876c890c2dcaa4e21ce36bfa2ea3e02139a01:
>=20
>   binman: Make a start on an iMX8 test (2024-09-26 12:40:31 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--8FZg7TLh9/3noSyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb1+scACgkQFHw5/5Y0
tyxQ3gv+O+H4gU8zm8g2ms2s46f3NMb+jriejExmrsDwAhnXXKxcYS386bLYgU1M
gk15iHhaIadhXnfk6a0gP3Vgcryth2WQaniqUGDUxUaTCKGDVp71Pq8SPm0IHUCN
tSYUH1QAdBdtUY+t4h2S/grJz7ppR27HQ/qTtb4LVaHPaYRWA21tf5ELM88n98xM
rc0QONxlG+4+RfKbYPYqRCQ8D+IADU96sLp+SzMqfhu8DdzYu5dS2u852T5RnX1I
2uy7QL1VW5DcFFEpCPIdbMsTsTSdVviklBKEBmXfhUoEp/CLKmgjlEWtF5obHGMC
XPEKwXpt4rFviNM5o4f25dWjpYVYdyJETfjIB4xRxTr8dhJG0Tbt/Y2NlMfSSr03
FJaX1SHFBMKR8u9N1mW7dZhY3m4e4rkC9mUKkpxxHMOqLR80HaMmikIh2cZKa+8Q
SKJdReyqLoQAh28iHlBN3ttR3TFgsn2Zakq/0d5kavKsDMubY9NMO/9s/BHjZdkL
fgrImCE9
=63SD
-----END PGP SIGNATURE-----

--8FZg7TLh9/3noSyv--
