Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B030E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 15:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12168893C2;
	Sat, 23 Nov 2024 16:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I3UI4sND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A26E893D2; Sat, 23 Nov 2024 16:24:54 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25724893AB
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 16:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4611abb6bd5so20308621cf.1
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 07:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732375491; x=1732980291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e534K5UD65PLVi3xG31xpH3woKK2H+tN40L+/7iAsOM=;
 b=I3UI4sNDixmwqzzuxGSbyulNYk5stJQCYOhdJvXl2XJ28UwWBb82Sv1pOp9kiSEb+J
 CsDhWjtW8c3EXDcsjNqtek7N5H3Bpxr5wnXbOTNBDIqKqmGoczGYW5flWQUdnDaEKWpo
 kbn+6cBDd0FoPhGagtZE7rKk8+WRjHRmjAhAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732375491; x=1732980291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e534K5UD65PLVi3xG31xpH3woKK2H+tN40L+/7iAsOM=;
 b=N5JdXQkRGDnEPggJLxgj84rb6o0Fra/EThwQKR/uqSsyop/oRN7mSRmnV6Pu72RFIL
 lp+AqdVD5qT/EQJ+B20APHkM6QGcm6YvXl75/5kBYMos5VW6V0rCai+lZQ7tjcOdf/L5
 WUnUXPwUQ50p+PXYvm4FwGPQgsPi3nmm9T2V6suNygodl1Vqk5miMgYqxzyumpZ1XQvb
 zORf14fPgfB91OZYTN0sLGQZe32/rB9qxtXqcXXiNrzlFynDXsZ78IYxQBB4y/TnjTeH
 9sXuwdRB60ZL5QOaSSBQ53X8yFQMQRVnczclpFczRXDPgqljvZeTou7nJERne/clFhWk
 pLYw==
X-Gm-Message-State: AOJu0YwaJV77Mz7EJJwoxXH3c6ckKQkD28RQESlyLgktvwe/A3W9Tj/+
 laKvwD87V9oT/wTwnbW//+Z9zXfEx80rZYQEIM0BCw4UR6UYeKiWBCOKx2IvhFXqKiLu6SZpv8d
 /2M4=
X-Gm-Gg: ASbGncuaTS0NwqRyg5rsD4q+orqniaLfJcg+mt/3/UuNAq/4ZaEP7bNP02mBgAWT/rG
 LqjxhYwsSYuCtUaObE0qyQOY/aZ94ROhJ7YSoHADPSn2rR9S+3b+lfmX19TB3aSBRgARVDP9t8N
 C+iP2HSt1x/i1/d8GYFa7m/mdO21fEtPD2kqK5msrj4G/S3H27FBgToEM2jT06sYMUoD1no9ayK
 oG2BRJSMmuvdZvKXsHanmjpncBsuP4Z1Bj2ZkChyGEFxDsO0w==
X-Google-Smtp-Source: AGHT+IENEz0iy3nZZj9qmLPz2lco2tuCDRDUp65qLnjl+nwPjCXy6xyAm5Ny6+h5mXcFFdgJvM43UQ==
X-Received: by 2002:a05:622a:180d:b0:458:2894:984e with SMTP id
 d75a77b69052e-4653d5225a2mr92056451cf.3.1732375490950; 
 Sat, 23 Nov 2024 07:24:50 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c47d0b3sm25030851cf.64.2024.11.23.07.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 07:24:50 -0800 (PST)
Date: Sat, 23 Nov 2024 09:24:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] examples: use QEMU compatible LOAD_ADDR on 32-bit ARM
Message-ID: <20241123152447.GZ3600562@bill-the-cat>
References: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FugdMIViYxq5RgeH"
Content-Disposition: inline
In-Reply-To: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
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


--FugdMIViYxq5RgeH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 09:48:53AM +0100, Heinrich Schuchardt wrote:
> On many 32-bit ARM boards including QEMU memory starts at 0x40000000.

>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  examples/api/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/examples/api/Makefile b/examples/api/Makefile
> index 722c7e45904..f0f107562f1 100644
> --- a/examples/api/Makefile
> +++ b/examples/api/Makefile
> @@ -9,11 +9,7 @@ ifeq ($(ARCH),powerpc)
>  LOAD_ADDR =3D 0x40000
>  endif
>  ifeq ($(ARCH),arm)
> -ifdef CONFIG_64BIT
>  LOAD_ADDR =3D 0x40400000
> -else
> -LOAD_ADDR =3D 0x1000000
> -endif
>  endif
>  ifeq ($(ARCH),mips)
>  ifdef CONFIG_64BIT

If we're going to start cleaning this area up and expecting it to work
more broadly, is there a reason we can't use CONFIG_SYS_LOAD_ADDR or
CONFIG_STANDALONE_LOAD_ADDR here?

--=20
Tom

--FugdMIViYxq5RgeH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdB87sACgkQFHw5/5Y0
tyzBRgv+MI8lQwNAaZDDHJLpeu0Gp8JQN5qX7wn7W/FQlWdqC2ukUhRAYR5M1mCI
K18qwBym5606mU5GMDZaD61YMUD/W8n/R83WG+QRkUAVfmYMcdzwiDRftH7tpsNS
pTHByAnIC001WSIXqMoDPkQayjZKz5b7VVF/P7SzB7vjCLFSUtbL2U7F4bwUImWb
Ogrskpq3YIJ6x/7zPVrbLWL8T0bRzgQmnz11sik6my69N4w9bO0F2VJzh47Pr2Fa
ry9nzyYres/0u8wRFfmI3ilhuxN5B/JWblLFRHmOiSz6E2uUYpAOLwTYbYkI1Zvh
bJvj1TZ5RRmRFbv5QOxKpudfD7Uz7f5hJ/pCEx8zcMX3D5Oxqj1u+FptETEwSm8X
MtUqZinDy4MOrjXGA4HPBkw7EbR9VZA2Hy66oBH4RYodigB4VRxEvbsldm9JdX4J
HcbHj6yv8xhupeeTgTshL6Kdr4fMMOHv1z1I3D2532xBkZ/TDjpAyW0TA+ETZHpJ
ZLdRlADj
=30uH
-----END PGP SIGNATURE-----

--FugdMIViYxq5RgeH--
