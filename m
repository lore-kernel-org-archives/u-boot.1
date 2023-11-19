Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0F7C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F67487252;
	Sun, 19 Nov 2023 16:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="op8SOKfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDF8869CA; Sun, 19 Nov 2023 16:59:21 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBDB87186
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5c6705515d8so26958327b3.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700409557; x=1701014357; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZqY7wrFftIdn5KoJpHYzuEzhqdUrs4ugp3Uu+hTWbIA=;
 b=op8SOKfiDmLbhuY9ehFBkX6BxPb6y84lpTEHAmvuePJsgHTWdabS6iDKJQFmP7OKJM
 DK8bUpI1tldfW2iTORUK6McoJnok2EY9JiHS1W3R4K+6J7Cj6KK7luuXVTNy+3tMAgSg
 HDXRI3OmXC5p/TkUFF/eGOsNkSTmm0T5GGPmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700409557; x=1701014357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqY7wrFftIdn5KoJpHYzuEzhqdUrs4ugp3Uu+hTWbIA=;
 b=TDdyMdPeEPsgYTY3BjrG3dstStiWYwQYTM8qz4xSneBu0ULdZAdhsd0ePAL3rvNeOd
 l2cwcsufXkpuKwYzlg1H9VWaCZ9t1lTvjC+xAdNVPt/VhHtbjSKvHkEs8kEEI7lkEJYu
 RANBfrN17NQsDvTH8kgrhuh4/w+DLCdD1TiCR5IKjqNXwYpxj5wyLa5tyTNhuuz/H5t5
 EuG8uMfeSKeVS/uMRPk916PqMbQdtJnjnEpIsAmPbPswdTuPc3siU3hqvuPssL74uBP5
 NAvNNNNBe9gbUdBCjn56Y4mO6RX0OvLdvSHKoAjtIOBXjBTcpwz219Giz8Fx08rGLqVr
 0SzQ==
X-Gm-Message-State: AOJu0Yz7Epv4lLX0r/n2b+uY4xqcykvOkK4kpTyD7bafua2JlJp3/e7I
 ZAtb0b/2NQIYyEtlZKOx9rAFEA==
X-Google-Smtp-Source: AGHT+IFh+IeiHZzpmt3tbPy/4R6XU0wZic5WEUUmcl680V+uvjEeJm/R5UOPYI7DxtVok3v7+P/o5w==
X-Received: by 2002:a0d:cad8:0:b0:5c7:3a8:1798 with SMTP id
 m207-20020a0dcad8000000b005c703a81798mr5225680ywd.12.1700409556620; 
 Sun, 19 Nov 2023 07:59:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-af10-dfdb-a5aa-dfc7.res6.spectrum.com.
 [2603:6081:7b00:6400:af10:dfdb:a5aa:dfc7])
 by smtp.gmail.com with ESMTPSA id
 q188-20020a0dcec5000000b00583f8f41cb8sm1787186ywd.63.2023.11.19.07.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:59:16 -0800 (PST)
Date: Sun, 19 Nov 2023 10:59:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 3/5] video: Use cyclic to handle video sync
Message-ID: <20231119155914.GD2513409@bill-the-cat>
References: <20231119144700.631322-1-sjg@chromium.org>
 <20231119144700.631322-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oilXhjNkcQS9nK8S"
Content-Disposition: inline
In-Reply-To: <20231119144700.631322-4-sjg@chromium.org>
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


--oilXhjNkcQS9nK8S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 07:46:41AM -0700, Simon Glass wrote:
> At present U-Boot flushes the cache after every character written to
> ths display. This makes the command-line slower, to the point that
> pasting in long strings can fail.
>=20
> Add a cyclic function to sync the display every 10ms. Enable this by
> default.
>=20
> Allow much longer times for sandbox, since the SDL display is quite
> slow.
>=20
> Avoid size growth if the feature is disabled by making the new init and
> destroy functions dependent on CYCLIC being enabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  drivers/video/Kconfig        | 30 +++++++++++++++++++++++
>  drivers/video/video-uclass.c | 46 ++++++++++++++++++++++++++++++++----
>  2 files changed, 72 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 6f319ba0d544..1742e342f466 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -7,6 +7,7 @@ menu "Graphics support"
>  config VIDEO
>  	bool "Enable driver model support for LCD/video"
>  	depends on DM
> +	imply CYCLIC
>  	help
>  	  This enables driver model for LCD and video devices. These support
>  	  a bitmap display of various sizes and depths which can be drawn on

We should at least expand the help message to say that if you enable
cyclic you get some other behavior. In hind sight, cyclic shouldn't be
prompted and it should be selected as used. But that's not an issue for
this patch set.

--=20
Tom

--oilXhjNkcQS9nK8S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVaMNIACgkQFHw5/5Y0
tyzkSgv/TeKZ6nBhqcMjpxjqKyGK5MY4IPwm74pOiGJVkxsvC5PK9xiFguM9rAnf
W1YIeAAkAg9ralViws9MmXXTxpTELqiqBZw5c5rjb4gAZD98RKjUoCdN+Zhia+YI
2GiBSnNx4qNXs3KRc5XHWNdlhCFNXDpXyP9buznkfF054JqU3Tv5ZwNiZsdtINe5
DPWggPArToGzpkC2bull83f4begeqyIFE+TLGHY5OH/efo4kymj14Hw2UNRwjHmN
rlx2LZgs08EZ9XSSfVRRYI2Y4ZeeCWmbuupYymlsxgwH29mGXOAUg0KjEy75rChB
6hOOGE2uhJhrFwHnVRX7XemWqiiA7V5l1NPD2tT6d+UvkExEJe6kBDk/PHDF3Nr4
wk+uiXJ/5+gRp8hJV6Lhl/eCroV2wODReTDUG2zKOcPI5OxVbIfkuaSbWT15y6E8
IDshbr3wBLQ/o08Ts36xCR/FlDfrwpdF0zRgO0LLj++f03Jw4M3IZnsR/yY4uVtw
cCZ4xnUk
=lzed
-----END PGP SIGNATURE-----

--oilXhjNkcQS9nK8S--
