Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30489CEACDC
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 15:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB53789224;
	Tue,  1 Oct 2024 17:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FGQhunAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41E0891C4; Tue,  1 Oct 2024 17:05:41 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B1A891C4
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 17:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a99fde9f1dso498915585a.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727795135; x=1728399935; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fpnfpQ/4G0wldHmdFQ3bqBz0o8WdI3FX6VqEwMzv6v8=;
 b=FGQhunAQ10TT6rV2jGvQ+Slft36174LRp2EyQrxs4b0pYaO/+Mgvhqrc2zFQx1bc+h
 j7MiQCfzf+4TSNTg8HsHb6R0YvMP2UwnroIsFPQDpD7ywK44iR6tpsEGZBlzf0Z/xtdp
 1XRie8PT2RpRtic/SYISadOx1TVl7Fh7uR0Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795135; x=1728399935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpnfpQ/4G0wldHmdFQ3bqBz0o8WdI3FX6VqEwMzv6v8=;
 b=MDzRSJM+YUWn1MdaQT5ZZ+a3iGXYBXpFNQAEnhuWYo4Da3/B/U4hVqsEqYLC3tmBbN
 5fcqnMD0wTOgvKXgMcQHuyk8nDrsvTyh5G8m1xGBoRWJs53gLVqLF3NuZPfJj5AjrgzB
 3n7jwmEQeHSaGfWU7ixmgB6xZB9gFTH+kD9XqHjv8KsAw7YsfqqhLy3UbSrdkeMFnqNX
 lwcoyXqhAaHSpPJE1z+oUpxeLw9XoLbmMCiF4q4xR/EaRj2XxfL/gpooDv2pqGdozFsD
 xSzJsoYf/2OUMKjExNaN+QfJKMs8Q+9JgMWDy7KUZvwfoLonKwaAWKRVlVfmEAPRnrbk
 IFog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt100Q1CvtXzYtAu9OnswGn53gGA2//6uoOEG6B8QDShz6HvgdOQ8KaSdzLDOIH7V9CtOWIpA=@lists.denx.de
X-Gm-Message-State: AOJu0YyGWoAIJSw8u8rarqFIhu7DaUyDdWGfrl+GQ0TXqr0nnHopT6Ea
 VlTYlIY0d4U79v7qGCkXsyyWoa8008eClcT9IuV5Blm1arR6SL9aECkReOr9cyg=
X-Google-Smtp-Source: AGHT+IFMRtxvzpF3lRO6kA/M4tgronZwXnwpjcLYR4BCATFLf47lznLtcgxbZAsMigxSQGlZxnZv9w==
X-Received: by 2002:a05:6214:4b11:b0:6c5:acf0:400 with SMTP id
 6a1803df08f44-6cb3b685c4fmr186214056d6.52.1727795134999; 
 Tue, 01 Oct 2024 08:05:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b67f5efsm50707666d6.110.2024.10.01.08.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:05:34 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:05:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] lib: fdtdec: Parse the gzip/lzo headers only when
 dependencies have met
Message-ID: <20241001150531.GG4737@bill-the-cat>
References: <20241001095647.180840-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5MZd4VYYy/2KQVvS"
Content-Disposition: inline
In-Reply-To: <20241001095647.180840-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


--5MZd4VYYy/2KQVvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 10:56:47AM +0100, Prabhakar wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> It might happen that CONFIG_GZIP and CONFIG_LZO are enabled but we might
> have CONFIG_MULTI_DTB_FIT_LZO enabled in this case in the code path of
> uncompress_blob() we parse the gzip headers first which results in
> `Error: Bad gzipped data` being printed. To avoid this parse the gzip/lzo
> headers only when dependencies have met.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5MZd4VYYy/2KQVvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8D7sACgkQFHw5/5Y0
tywSCgv9F26Uh744okzK1O3EJx+O3ShGgUsVDAhxb92GLgwyIyN0xQap6WAeI7C/
UYr6KbWPEN2A5NT/ndtpCAkksew8VksxBZ+OIwY94KCI1dhP4ojPIKaGKVtblBRd
hftGDjNmIAVTil0BhCn41pybN0T2C1BWVzJ3Icgwh+/AYd+JxZJRpvhNz18k/vw9
WxlVgZsUmEzHC3/qlXoY0A3mi4RTh+1C295Ad5MhDZC6p0rGytzWAmQ7JobA860X
ARam8bhs5NuUb/H5gPYSBUzAr5/jZPJw+j0TLJHeNnqGvs8Z9/ijjNBb6rEF9baB
C8jY2FxOBS6Z6FoKyA9dk7gdkXswWM3TF66OXN9iEfvBw8Bpl5xWxjYzbCq30rfB
rKg3eHDcXqF+OBlNY4J7k6/gf8fcJ18nzhY0dgQiQVfpAn+RDM0Ta0TzJCVmd0vn
hoKQopjtyaX2NSYDcw/hEg9t325PBY5g9/cS6nK03jvV2Ki6cuLveFlrfJg1t57R
Q4E1IaxI
=4qoc
-----END PGP SIGNATURE-----

--5MZd4VYYy/2KQVvS--
