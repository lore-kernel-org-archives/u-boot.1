Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC11C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A88F874A1;
	Wed, 15 Nov 2023 23:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C5/M2pvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1428749B; Wed, 15 Nov 2023 23:38:12 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744EF8704F
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5ac376d311aso1486597b3.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087889; x=1700692689; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iP39ECxTQj0LtvafiihSeJGQ2NV+rCUkNlqQIgo5vXk=;
 b=C5/M2pvh4LmBmX8fGBJg0nMqAJgbaMbkU99hMt4NllZokuErD4zEYzBlflJCcY82U4
 6jxEchEn6ldDNOjyhNKMb9ML1oHSGnDvGCvTY8WqqjMr6YAGDFvNecpbbsdVTvW3I6+l
 468BTnefxR0Hml63xEBfmpRZsaQ/XCioPQBAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087889; x=1700692689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iP39ECxTQj0LtvafiihSeJGQ2NV+rCUkNlqQIgo5vXk=;
 b=MNu9zTKfVIx7hpJ+CQYjQ/+ONWfxh9TQYlyem3d/2A2YrJoeJ+lPV5c883JUGcA3vd
 tfgAAeuPY0Pg/s3bgzqQVWnmIUKCnbet+p+MvJjoE1oSqB7UTiJHxiuV7sYZNdU9saXk
 em3YFm15s3eA+jYZHrxSKGXFs4N72YIBYa3IzIkCf5aUrFovupEtFw/GidhaYeVLl3Wk
 V2lBw5LUz00RpxhtpyPxHbKwqD8Bp2XRHBCTQ2x1uSnPjh2Fk4Zq0PGnqy02JvvaxrYm
 f0geNRWwbweyKKr4SMq358dVT3Sgln3YFTV44gyShFo6LGZchiGNqxQedBgqUCuw8isd
 E7rQ==
X-Gm-Message-State: AOJu0YyfSBL5zcjVU76R+ZmatRdPh/OxNuG0RgLOKMwyh/Q6BebjcaIr
 MUfUp3EC9XHHydqwSxv/GRtsqQ==
X-Google-Smtp-Source: AGHT+IF7M4kzF8uf8W1S3M9K2VLCT4DwQi+vxp6BOh8I6lSPnWF9AE4fx2pFvqMhFRDD9zdTB+rqHw==
X-Received: by 2002:a81:8a41:0:b0:5a7:fd05:2af2 with SMTP id
 a62-20020a818a41000000b005a7fd052af2mr15973557ywg.2.1700087889212; 
 Wed, 15 Nov 2023 14:38:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 em15-20020ad44f8f000000b0065d89f4d537sm884234qvb.45.2023.11.15.14.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:38:08 -0800 (PST)
Date: Wed, 15 Nov 2023 17:38:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 28/29] bootm: Add a function to check overlap
Message-ID: <20231115223806.GF6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-29-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="21DXz5kTFu7+rV1h"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-29-sjg@chromium.org>
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


--21DXz5kTFu7+rV1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:13PM -0700, Simon Glass wrote:

> Move this code into a function to reduce code size and make it easier
> to understand. Drop the unnecessary 0x to help a little with code size.
>=20
> Use this in bootm_find_images()
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--21DXz5kTFu7+rV1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSE4ACgkQFHw5/5Y0
tyzt1QwAtjGrni7pAYqGrAQJTaEc/ZU0v1fV65OKlsE1oQixSJA9grp9ZuFXNnNL
EXKuJM3yPXyYwN71r3rZqghJz4jg6hG+MIcRbQl9kQ/lIuMnN0ggL5PGbSd4L4CZ
nVtlXN0byQggeMlwLyP8p+Rv4ebLInVx3guplXtPsjLz6gYOdikmVCKsxpEqAWsc
/uCyl+qSihHPByHXZiKU0GGQxLSmMJi3niaqQh6u5Zib+FcM7GmXg8UeHMz2JGSW
ZRjL5VMla6njgPD0oHushGHVcpRgL4fN/bUG4L4rvtXRLMwmUxEOAYpSc6bhaSEn
zwpC8s3rlyPZw21BE1059gVl4iklmh74ne5h5xJO9n1sV4U+xlDjQemQ+1xz7C89
ByRb+bwLFUu9Q8b1LZpeezuAswHX/8n53MxK0kuX81JCrUOF7pu2QTdTYs0vsxnc
D8hObje61r5pfIaV4sqwRoUYUCjVCJ50Sni7y8rkOztvwVqcnu6eyM2ir6CQc0j3
d6HfH2Jp
=RPTQ
-----END PGP SIGNATURE-----

--21DXz5kTFu7+rV1h--
