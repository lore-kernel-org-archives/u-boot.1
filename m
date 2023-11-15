Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01353C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4BE8749D;
	Wed, 15 Nov 2023 23:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oOAvvPU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6F6874AB; Wed, 15 Nov 2023 23:38:24 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 833398749D
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-db057de2b77so129740276.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087901; x=1700692701; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D3tFbSadrpf3iPTBBN3s8UpYmCCoUh5BOExZdL4JnZw=;
 b=oOAvvPU4VlPbIacP8yNOIqZXpsM0lhWb1laK0KsCQbK7hb/Id7d80FbAKvKdNaa7ZU
 /SQv8/jJ653GCMks1Zf2R6vmvv5KAQOW6vitDrUj39O/Nt4RUFQImxBkXFbxYZWRJ2yb
 seyax7FPa2LDi3ctonkPirIUOlZvN3+Ne7I94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087901; x=1700692701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3tFbSadrpf3iPTBBN3s8UpYmCCoUh5BOExZdL4JnZw=;
 b=ToOnU7ExPo/G1wl1cFVgzRN4skUBsKmfqsri3LDIOa+zZRPIGQzQwLs7gmaJIdNsJr
 UZK0roAhN+jIkiNDZRvINw5mcvO6VJgqjGHRwza8ezN54sPibuNRtXRI3xtAQp47aFBR
 mjuLNhMvo5DE+OomIqhXS9ZisTxf8vldcTAAWuonniG5y+QLfA4rW2TlnYTmZHy2kF8S
 tUKc785iQAtSe4NcYhUlBovzDPEODkTcPPJykf89Zx78NSJAuhnSNFplFBuCZEuBvOtb
 TSW0IHepFAuHhbtcy/9d8DQelC+BLUiuPHmEVhtV/G/dCWlEE1E/G06u87TeMi4ukmld
 Z70A==
X-Gm-Message-State: AOJu0YwBZVrk/xt8BGrDU9OwjPPHc19zRrBD0j/c+Tcyy9MTvEfUijfR
 +S17gEBEjWJR4JVcElM4TToUT7rgJwf4TtZZ1iXWiw==
X-Google-Smtp-Source: AGHT+IGvajGkPTDAdWlooHLk5Mx5kXqmt+mafbSao9KNhskT7KECzZy9PDJhMQT/2Da6ivNsjp20wQ==
X-Received: by 2002:a25:58c1:0:b0:da0:ce05:ca2c with SMTP id
 m184-20020a2558c1000000b00da0ce05ca2cmr11736189ybb.7.1700087901104; 
 Wed, 15 Nov 2023 14:38:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 jh3-20020a0562141fc300b006779f7e68c9sm880739qvb.134.2023.11.15.14.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:38:20 -0800 (PST)
Date: Wed, 15 Nov 2023 17:38:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20231115223818.GH6601@bill-the-cat>
References: <CAPnjgZ3V6qnjrKS+XL95LS-iLJv2VU3g5Us=DHJmpHT7xRC+cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L7CO0Vo331Q+8GM4"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3V6qnjrKS+XL95LS-iLJv2VU3g5Us=DHJmpHT7xRC+cA@mail.gmail.com>
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


--L7CO0Vo331Q+8GM4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:19:26AM -0700, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/18586
>=20
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D55&view=
=3Dresults
>=20
>=20
> The following changes since commit 92b27528d777ce85362af45e7d2974a6c85621=
9b:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sunxi (2023-11-12
> 16:36:52 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-15nov23
>=20
> for you to fetch changes up to 0d4d9f94c555577f78cddc372c307465fc92413e:
>=20
>   bootstage: Correct exhasuted typo (2023-11-14 20:04:01 -0700)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--L7CO0Vo331Q+8GM4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSFoACgkQFHw5/5Y0
tyzUsQv8DXv8eCZ6GCFDgeiOXMFpptXRvV5SbaTZQW/jaud7DVi6VZtx3q5qo7zt
Zoqi++kP7cbcpa5OTvgCHSa/ZhrwIp61y1HW11D9fJAiE03zLZX0DxMxhhTNez+q
nfcG/LthGt9BHf++SHqQkgA1mxBK10XHFggxnMmHoOnLbgtgU2JeWwKAUiiJB+Dj
MXTo+4tZ+xiSkOUyKEbJvcZBBU6yQLaBkOy+6IGkkbR3k5H3XtZfy4oByFG2mEEj
nbGpFUoKLMKcbT98ZQNOtaNCxmD8rnulX4RjpPAGUnCbISe9yOlpjBjxvr1o02fp
MPBbWdPDfwErL2/5RaIj/VXEBO2eZxbRrVDPk/1q6ufDTpJmbYjIlpreSiPieM4z
irMYRnrqDSkqBIkMYMK9PtXGf2NhtB7S1pZQuOOJYV6MdJtc8nEuNoN2LyEz8iDI
b6oWeAm9g0s2vu9u2K4rwEH2qAhXqEYjiTPLsKQwz+WWWOZyHUfAAnWTjDVKifc3
cWG1NwRJ
=E/Eu
-----END PGP SIGNATURE-----

--L7CO0Vo331Q+8GM4--
