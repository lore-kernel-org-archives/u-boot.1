Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E90C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 23:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06EF38043C;
	Tue, 11 Feb 2025 00:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t1VGhdyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D18A805D7; Tue, 11 Feb 2025 00:28:23 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A6B800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f679788fd1so34568817b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739230100; x=1739834900; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VtP620+ZoorfoWqiNW4BEv6Ym90FWpixzZOAHZTP1IM=;
 b=t1VGhdyDJEAu1MrQ7rgdLNKnzdsQU+Q/uvbAuK8l65krPxDkpnmADoMUDzAhGXklBT
 wf15th70cD/K7GTBQfYaBkzCqm2DsybX3yfgnzc0E07ukIFC13cfbhNWJWx4oVKuK7uK
 UnoLAcaPomaTLgP0RaR8DhvcRb4V6jpax0kjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739230100; x=1739834900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtP620+ZoorfoWqiNW4BEv6Ym90FWpixzZOAHZTP1IM=;
 b=ZcUlRhl7x0FtEElBtmoSXhUmiWDZV0QiMtdj6TRrUTLBRudZpi75EMOGyv5Cq2rHbm
 hD3XIIx1q/UV1L951cRQgzn+o2us3Xyf+XXUed8p4YnLqVJpVDI6TH5j3o60HyuEnA80
 eQ3BT65F10ijGP46i0M8fymiP/SCfL4nGzsbFEcLKKlfZ91IQn4QkPWomgVWfKy6YxFe
 qGxdz/oq/zDwWw/Zi5MH1xSujEYya8u6i2r0MpN0g8IQHuUXOstx1X0PI2Db+2q2JOk4
 OeSKbQOzD0+/umntQ2DEp/zUVet+FMRvw2k+2XTceA+fe4k7XxIY3BKQeT3o0wwzm++u
 s14Q==
X-Gm-Message-State: AOJu0YwvvhKlX3ukLPDdbzxI/qJKEI9lfM3X9FVfCawcfk084+m+yJa1
 BwdXLK03UEKHRMRuD1pMZv58/O6twSfJHlJqnrch6Lvcnl6AEoOoCWVXMgLBcbM=
X-Gm-Gg: ASbGncu+VWDCSp+1xmfE9VO1oZbnmF1X4CuvaN/AwKRvaMZOjb9jY5jZZFFkQgFtG/Q
 dQLZvpLDTqUe3LlMP5RlFcG+SJupx2Odfxg+vd55NhcACsLLQD/G9N+Nr27nF7Mu8Boo0N8SAtJ
 LluNESDTcU81macGbKu0GtqPzI20glYQi5EzvNbmlrdzZIAylKTecEExb94XLUlLupRsfs08lqE
 g8xbvZZ6fsULOw68JGXRCCsmoi6fYTTkwEQAyZpRR0ohBtRquRIey5259lX2U+SmsFd1uX1jqfz
 Qkhym5hG/yzuR80=
X-Google-Smtp-Source: AGHT+IHR8QqSQAr4Guq7ikvVDVWXtpoeDL6I/9r+JEOYyPvcfsRAkrnscG66J5sE6zyOMTN7DG1XfA==
X-Received: by 2002:a05:690c:6809:b0:6ef:7f34:fe08 with SMTP id
 00721157ae682-6fb0b4d89b3mr25455227b3.18.1739230099562; 
 Mon, 10 Feb 2025 15:28:19 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a938sm18837147b3.73.2025.02.10.15.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 15:28:18 -0800 (PST)
Date: Mon, 10 Feb 2025 17:28:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] tools: image-host: Fix potential memory leaks
Message-ID: <20250210232816.GA2985471@bill-the-cat>
References: <20250203161012.4022394-1-maks.mishinFZ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="okErOVPbmbGkb4M2"
Content-Disposition: inline
In-Reply-To: <20250203161012.4022394-1-maks.mishinFZ@gmail.com>
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


--okErOVPbmbGkb4M2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 07:10:12PM +0300, Maks Mishin wrote:

> For a variable `info.name` memory is allocated when calling the=20
> `fit_image_setup_sig` function and is lost when the error code is returne=
d.
>=20
> The situation is similar for the `region_prop` variable,=20
> the memory for which is allocated by calling the function `fit_config_get=
_regions`.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tools/image-host.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

This introduces a failure to build:
/home/trini/work/u-boot/u-boot/tools/image-host.c: In function =E2=80=98fit=
_image_process_sig=E2=80=99:
/home/trini/work/u-boot/u-boot/tools/image-host.c:244:26: warning: passing =
argument 1 of =E2=80=98free=E2=80=99 discards =E2=80=98const=E2=80=99 quali=
fier from pointer target type [-Wdiscarded-qualifiers]
  244 |                 free(info.name);
      |                      ~~~~^~~~~
In file included from /home/trini/work/u-boot/u-boot/include/compiler.h:24,
                 from <command-line>:
/usr/include/stdlib.h:687:25: note: expected =E2=80=98void *=E2=80=99 but a=
rgument is of type =E2=80=98const char *=E2=80=99
  687 | extern void free (void *__ptr) __THROW;
      |                   ~~~~~~^~~~~
/home/trini/work/u-boot/u-boot/tools/image-host.c: In function =E2=80=98fit=
_config_process_sig=E2=80=99:
/home/trini/work/u-boot/u-boot/tools/image-host.c:1087:26: warning: passing=
 argument 1 of =E2=80=98free=E2=80=99 discards =E2=80=98const=E2=80=99 qual=
ifier from pointer target type [-Wdiscarded-qualifiers]
 1087 |                 free(info.name);
      |                      ~~~~^~~~~
/usr/include/stdlib.h:687:25: note: expected =E2=80=98void *=E2=80=99 but a=
rgument is of type =E2=80=98const char *=E2=80=99
  687 | extern void free (void *__ptr) __THROW;
      |                   ~~~~~~^~~~~
In function =E2=80=98fit_config_process_sig=E2=80=99,
    inlined from =E2=80=98fit_config_add_verification_data=E2=80=99 at /hom=
e/trini/work/u-boot/u-boot/tools/image-host.c:1156:10,
    inlined from =E2=80=98fit_add_verification_data=E2=80=99 at /home/trini=
/work/u-boot/u-boot/tools/image-host.c:1377:9:
/home/trini/work/u-boot/u-boot/tools/image-host.c:1078:17: warning: =E2=80=
=98region_prop=E2=80=99 may be used uninitialized [-Wmaybe-uninitialized]
 1078 |                 free(region_prop);
      |                 ^~~~~~~~~~~~~~~~~
/home/trini/work/u-boot/u-boot/tools/image-host.c: In function =E2=80=98fit=
_add_verification_data=E2=80=99:
/home/trini/work/u-boot/u-boot/tools/image-host.c:1066:15: note: =E2=80=98r=
egion_prop=E2=80=99 was declared here
 1066 |         char *region_prop;
      |               ^~~~~~~~~~~

--=20
Tom

--okErOVPbmbGkb4M2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqi4kACgkQFHw5/5Y0
tyxu8Av+JFQMpNxs9M/coAfBsuuQPzQca3oYX7HMxkFOuksi4S1ceEKjsk7rYVEl
RYA3MQduJUY1IEEWcNCRixhyuwRZ8iLrqzHVc2dgNt1dz3Xb4Tng2Arvoa43jgK3
2vXjRMm+ZP0nPSP0/DCa2nB4CU145CmrjDCTdjqFTtnLexNZ/jciwWwtpo3wtz+N
qhNXjDnuNNMTreCEQ9Jd0aeGQ3k7Wv4iuOVAZdmGSM76orCBZxgJZi5AlqDKT2Uh
7CUyOa1qTwVZO2E/FhzP2Okfe7KvUuj7Od4LEV5q+1kAlB3ms5PwQuWJuANwIxSz
qsGbH0XmE/z+uB2R5kCEq0SogY3gb8kXL8nEwG2MEtO8Vy7BWl/+8daXRjDFdCCZ
KgtIYkvX429KJE9DO68HKOGlBkpOQgd9ng0ES2iRWatNODyuyYu5kvANJV3bNnia
7kRZ+LUDrHvpi2g1rQXQ+bwHu3ZXQsefnbU5M2FPTL6uIdiczzGSvv/qQMsRaPAh
SNHsa5W6
=1r1k
-----END PGP SIGNATURE-----

--okErOVPbmbGkb4M2--
