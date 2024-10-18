Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C96D3C545
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B14891E1;
	Fri, 18 Oct 2024 05:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UeOHHdUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CC9891E0; Fri, 18 Oct 2024 05:15:02 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF18891AF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so11515076d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729221299; x=1729826099; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j1WXMCoW8GSvIlbAmLrBizo54to5CVpD1yDL6q5vDuE=;
 b=UeOHHdUlppCAoc/RatKDqHZBqEFq8DmkUOImSRlJw2Q9ZnRqVWtsSstWylMJ7pXuB5
 wY3vaVcibovDSnpDJgEIaSb1XYokQlkKJVSQoC5SF0wPdjJ/sLsvwVjQc8BdCZm2N/qZ
 wniBHIh4DhNdwyeu8Xyc2shumZG+sqckwxhME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729221299; x=1729826099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1WXMCoW8GSvIlbAmLrBizo54to5CVpD1yDL6q5vDuE=;
 b=lug1ozAdEhq6EIvmprHsf++caNTven+7feQe5ksfagwHMC6Xorl1TXeGeN394wGemt
 ZM1UZNkNOjRWaQnEE1XvN7yQcq1EgdRIYx7ZxPoXvwEE4AGmuSQP280cEOxXMgTJrT9d
 UkBBjhtgyp2JxDmC17IEwJHmSKtbPBDqEy9FoNLbI20BaVi0QZMMXKaRYz4hOyVx9nEE
 ywllcmTMy73PPL2xyi8TQMjJgf/OHF+s9T66Qm+WL2jvwltIdPeJ8nfp2EbsVP3mOFcB
 PnDMT7XV+8pwp/hrB5lLyQieXAhDay1Ld+ENunF1ivqu88oicQFOtgD/JDEf2NueBlyL
 hCqQ==
X-Gm-Message-State: AOJu0Yw6Qk9KFDilwbNxiAMHozZh/B3kj2dF0Rm9z83vxx5u49nl0Wmi
 IQAu/wunv0SN676lM7nLoMeAbfHqFLw/3UOCJygs48NKa1464RHMKi4biIRLCJY=
X-Google-Smtp-Source: AGHT+IGQt27UyBStJdvLoeiWbrjl267o68Hp8AxJWynoTrkO9K0PGdfCGCPuoVRb7qYCKTRUEqQpjA==
X-Received: by 2002:a05:6214:4308:b0:6cc:1f0:d382 with SMTP id
 6a1803df08f44-6cde14b8faamr13945276d6.8.1729221299574; 
 Thu, 17 Oct 2024 20:14:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde114d78dsm2882686d6.50.2024.10.17.20.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:14:58 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:14:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 15/34] image: Add a new type for extlinux
Message-ID: <20241018031455.GU4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-16-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5jUzI6jXiUJLFvtm"
Content-Disposition: inline
In-Reply-To: <20241017232413.724808-16-sjg@chromium.org>
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


--5jUzI6jXiUJLFvtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:23:54PM -0600, Simon Glass wrote:

> Add an image type for the extlinux.cfg file, which U-Boot supports
> reading.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/image.c    | 1 +
>  include/image.h | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/boot/image.c b/boot/image.c
> index abac254e026..cf16fb7fbf7 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] =3D {
>  	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree=
 ", },
>  	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
>  	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
> +	{	IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
>  	{	-1,		    "",		  "",			},
>  };

This whole part of the series feels like we're abusing IH_TYPE_ far past
what it's used for. Especially the command line string one. It seems
like the main use is to be able to later on print something human
friendly. Please try and figure out some other way to do that. Thanks.

--=20
Tom

--5jUzI6jXiUJLFvtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcR0q8ACgkQFHw5/5Y0
tyw+xwv+KHyiN5IUFU6tu3hmJK6EkSONhIcijp4rbF4q+bEAFXS2c2Zb0XEoa8QU
yjqEzHyczQDGWC2Sz8C1sBd8DVSWme7JLaNusbkyUpT8lCKklJsY73VR+j/kQZAp
DUk0ju5g4nFO4iINGEQpLptxY24tPvJPfqm2MAj9zdRFk4xqQ/7iVnW5tGLj4B2W
4g8FrOe1eAgdJOzh/h3HgLRhgEa6OykRUrQlcIBnnbvlV1Kcfwg07y4xlsc+EcWu
4RoqGRQkU/b25ezEl3vPhErLASKmyixce6L5eVj6/iummXWHgxE/u00c6t6QBhZ3
jbCkN6DOl8z3hX/rle7RwfzaCuP1XQlezqlJNK6i+DjcpkpbWQZDTq1DCujzbHhV
iJEUE/bvHVQCITle+ly0H6Km4YftYxWdl6iVx+409zglenXaTTIhBya3zGnqXIXB
Gookicz/14BQkPwo0lc1anuMDpuzOPP4TwpFeOF2KOvzSfrr+2/gYHouvdTUDZ6h
9aks+lem
=pfZr
-----END PGP SIGNATURE-----

--5jUzI6jXiUJLFvtm--
