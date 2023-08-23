Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350B2C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5620186478;
	Wed, 23 Aug 2023 19:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IZvKah2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB6D86473; Wed, 23 Aug 2023 19:43:18 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EDF5864C5
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d749f57cb22so3762223276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692812595; x=1693417395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LMGJzK7cgvjP3AKfmiWcUML05roO0SEnrN3YlBOKs3c=;
 b=IZvKah2Z+Mu51Bb8M3Q6B2vC9n/2waSDHD/C0uqtwUVkGIbc+YRd1NLfJO6AL9t9lZ
 rCzZK/Kb4sFVZJmXitxFZ5SSmyADGptdH02Q7vyaUeZrogxcBWckGngPWMJE39z5QcBE
 ymt2TD/egfJ8OAok9yKmgUWIOgnXHPwgupEqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692812595; x=1693417395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMGJzK7cgvjP3AKfmiWcUML05roO0SEnrN3YlBOKs3c=;
 b=L7rCr7ffQGk0h+wgaGvEZRYQhDNjQJQ+Bip9ljVvvnpG8Fzf0ZsBS0c6nw37yBpNBQ
 zkpbNNb3dFn4RzYIiwr5Iu1VFje0GbFroVebabJFu5BakjASnks6ikEMFHAFv72kUjtk
 51dd4BgbZd3gAzld8s3hxQ07MoPKkdtZZthdTWru6ahQWknI6PXYKu+1ZmEl8Px3fAWX
 vZjBPgqDtnHKNXRI5nIfyHSZWPEklgYjqR2YcK5moMY3MFBIinIEgWkMSa+UsA8K/Sov
 GMP/BdgEX8lGUsop3mtdz3CFG6Nt0VjBrzJeXEMcpO+bNKmGqYBSPJZte6ZWUSFvJOl3
 JuOQ==
X-Gm-Message-State: AOJu0YzQsLIaJYSnYoi7U1yuFKPqcdqMKTygG9Blf0PyxRwq2+F9pl/H
 jPlhTaOQI6jvkAB/lhTqw4G/lh2hjOzD6a7xAUt4rA==
X-Google-Smtp-Source: AGHT+IGk1N5vqFuFfgBm+lxtNZaT+3LNwJyWjouTKYyyIsIap1rRfB7vWw4oaI5cXb/B3frn4M+LFw==
X-Received: by 2002:a0d:ccd4:0:b0:589:f57b:e16e with SMTP id
 o203-20020a0dccd4000000b00589f57be16emr15104447ywd.25.1692812595255; 
 Wed, 23 Aug 2023 10:43:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a0ded04000000b0058cbf72d6f2sm3488701ywe.119.2023.08.23.10.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:43:14 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:43:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
Subject: Re: Pull request for doc-2023-10-rc4
Message-ID: <20230823174313.GT3953269@bill-the-cat>
References: <fbe36d84-9e06-3f2f-9a5c-b1a6f4d32df4@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n/IGsKJ5FHtSJTm1"
Content-Disposition: inline
In-Reply-To: <fbe36d84-9e06-3f2f-9a5c-b1a6f4d32df4@gmx.de>
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


--n/IGsKJ5FHtSJTm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 09:04:51AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 976fb2ffa3875a7bed9866bf5cf939a81c423e=
f8:
>=20
>   Prepare v2023.10-rc3 (2023-08-21 16:19:59 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2023-10-rc4
>=20
> for you to fetch changes up to 4e73b0153cce064e10dee4722cb2b6833361c227:
>=20
>   doc: Highlight the most relevant u-boot talks (2023-08-23 08:03:00 +020=
0)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17486
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--n/IGsKJ5FHtSJTm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmRTEACgkQFHw5/5Y0
tyyIKAv/XOsFIoI/jsLYMvXxakatK6qv2gsEEbPJnTyKZxWOcbib0O4MW3wIbDTh
rQDI053g1qzD5n9FohtAAbYVVx1F9+yvWlc9EBlyKuQCUqGbxWBYOowZgCIQzvhB
wWkkbwrJVNLoIEawksqtjueZpLGW/C8941u5OHOMqu+pIzW2w42fbp5y19PvIk8n
d810CiwqgR1ftNgO0BXhXf0P+y8gP5oFEDMLju+ZvcPsjA1IVemO61v2TC7qTdl4
JnjQ/EYn43ggaPkr/gSHVa3uA7PuThO1FNFqHjM2x4eFW2rWvnC0gzBGBYhkJFZS
Ci0WHMzv2PvbgbR4wxz8RbbG1Jksf1keQLZA0YQW4kJ6afD9jLJp7gVFWzY1CayU
MNXFMNt2xgfjrZc1lquS1suWFr68dcA5KkRJqq69EvlwNI19pUmKO5ujgwmTCemX
7xtMeSxU63pUv1j6pzHYRDa3ygB2YhrgF3qQiljaoVeHAuVh7kjyd9VWuMeGJ/im
daf/gpi1
=PG6f
-----END PGP SIGNATURE-----

--n/IGsKJ5FHtSJTm1--
