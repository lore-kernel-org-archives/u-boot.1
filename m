Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDC6C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7926E87652;
	Wed, 29 Nov 2023 17:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZVcZWqvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7846A87654; Wed, 29 Nov 2023 17:57:45 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD5287638
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5d05ff42db0so38479907b3.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277062; x=1701881862; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A3lEZ4DaSU1wohJRQDxY2W9NtHgvrh3Lc2cQI8VIdO0=;
 b=ZVcZWqvKbQL8Zu3o3X9dKwkSPUp8o6ECLcP4V4jyW6pQOmOpR45y4es7x0rTCXafDs
 b4pUgNRnz49oeJXCpopXVYOQj7fUU/2ef+muQdvn94AVRKoEmpV+P5tsjLGZzif3ADX7
 Lr7Gw1Ykd6wBlaJ2jUr5umCNdkOLJEOwL0HKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277062; x=1701881862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3lEZ4DaSU1wohJRQDxY2W9NtHgvrh3Lc2cQI8VIdO0=;
 b=kyu0ZW2j3mzKEdOnjWqJWR4p4l9CLHvllKxdoFx3gLhTt4MO8Hg5FYk+hJxlUn2S60
 UiEABfLZ7o/HRdwvXdE82Cf+b7kw+/Ca0NAXheD4NsfeH//8WcetANBL4HyBrGJcjNu+
 LZU19cHUgYjQu8GUlHYdTtx1tlp5CJ7Bw87nRm4OLFg45ATyNzZlTu+fSBhlESxlWjLO
 jV0AzYzfDUg9sg5qpo6xy67gTXQHH/UZdjtu1lgA/BrQjBpW/YdpQeDB8DVVdUvRQgA9
 Ym1FdLcECW4muwrsOkv3ld4cAHnRrucbKlfGFG1Rl++M+bUwPFqwsHU7iwUoNq4sAd04
 Zp3w==
X-Gm-Message-State: AOJu0YzkrnLStjK7rxGe/C4RoaYdlQEldnS1hLbuwL4YiCKKjVg/FB9u
 u585PqCPutTzq3BGi66bpB15/g==
X-Google-Smtp-Source: AGHT+IGlPko1yUSJDDr0L12EWxv6Zt+wQBh3LBwqQfTIJoUeyJS5TIEJ+UuL5qK5sv39Pqv5dySG1w==
X-Received: by 2002:a81:df05:0:b0:5cb:38dc:aac9 with SMTP id
 c5-20020a81df05000000b005cb38dcaac9mr18620130ywn.39.1701277062064; 
 Wed, 29 Nov 2023 08:57:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a81ad13000000b005b37c6e01f9sm3342606ywh.90.2023.11.29.08.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:57:41 -0800 (PST)
Date: Wed, 29 Nov 2023 11:57:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] configs: keystone2: Do not include hardware.h
Message-ID: <20231129165739.GH2513409@bill-the-cat>
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dojq6wiLE4NejSSe"
Content-Disposition: inline
In-Reply-To: <20231117223829.346652-2-afd@ti.com>
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


--Dojq6wiLE4NejSSe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:38:28PM -0600, Andrew Davis wrote:

> This is a hacky way to have this file included in all source files that
> include common.h, instead just include from the files that need it.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Dojq6wiLE4NejSSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbYMACgkQFHw5/5Y0
tyxd0gv/fqySJajVAV9GECE4rOkxzkPHB5+qU0+vc5l95z9HYD8VwEHVLtlz6mte
ogyWchUffHWynX29FAo7u4WEalAewPFl9f8KzOl+gGisz8ut6bOqbtEaqSIwLyZa
/K1Q0X5zQyEmiVot5JK0yuvZBKWE4oscyqFph+ugxOwUp5VEZR6iEhtgeYYb6HRj
DiZ9KPmnZ7d0QvuOxS6I3aCT6vb88vUC20m3RXFh+BUUV/4KH5ej6XEKugaisUpG
77FnMIB2mGzKoQvDCYqTxdOjW5s89w+yn40p5VSmmSM8jIK96Jj0DvkILXYCfqlu
vYC6Ph4lPjIfaIljWkjK/ZcCMnvHJOkGihfuSWf2ORVAL7zGTAQpV2vK1i8RKmgx
3VikPIl/KVJaMCGOJklrkmAzphqDj3k6GCrvJLOUyL/3JKefW7+9MJ7XlDjlgpuE
soeUvjHFOo6iFNtt0sMPu1wuwlYS3GbaGHV12hGGTsF2Zy/nLig0FB/E4C+xibBR
SExC3KeE
=GM4g
-----END PGP SIGNATURE-----

--Dojq6wiLE4NejSSe--
