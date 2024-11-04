Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50798D1BDF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE4488D7E;
	Mon,  4 Nov 2024 22:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nqQ0C7gI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F1388E50; Mon,  4 Nov 2024 22:34:29 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5472D88D4A
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b15416303aso356062985a.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 13:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730756066; x=1731360866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HVUsoZocIupg6jejrWuASmclaUbMp6OI9Cx6n0DMJu0=;
 b=nqQ0C7gIyEBmMu9taYSTMwyCqSlftXHbCXw+brvg0hs6Z6I8TBZqSry++N0/zy3sit
 F8YOzyhvd0GFptodB3eb5HrF2B+dwcrKvIFy97cGjqMNePQIrV0Soy10oFSuwelcO0VI
 hk3dTPbAc2PLS8ITL2zS2ZGyPPhRPsG/iOxIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730756066; x=1731360866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVUsoZocIupg6jejrWuASmclaUbMp6OI9Cx6n0DMJu0=;
 b=kWd/h3zoYOpDG4BJ+NmzAXKZ43+Bav3QJu7TP8r1skau70L+PuIBfrmMqwtMhRXF8S
 fdYWA280fapSc861Bn62ffR8HCRA7s1f/W9uQg1E82FsV8GsxTYm4E1L0Xn/YSuvW0/L
 3vY7UjCYquvvxh+9fXYzaJ3kV3iXpECHbq8xsw1mtRQJBKBj4+K83rUwHSWzjwHsxRqr
 uI4YgrxuGrzDv/lHPTukhklBWRlyHcEf9I03j3GV3ikkpPZqmN+MkKJAQ/1Li24H8G5u
 XB9feVCi7Gt+tKUqFKxUdlqz9trxfGZvGqLCrr0oiidgL70r4cjhE5Xcx2od/WxbLcFp
 vqKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1d38H0Z+kfmnlIbe0APm+rMPVqdRkXuxiZbCoODswksG85Q5tHrJK2iQI3JaeeQHjkA6Rx4M=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5f4ne5caP/PEeyxntubmse6IjHCo2eq17qWpQ2VvkZE81bj6P
 fVacy8TBmEEtq4QPwNzGSLtLn7ozb0QLx/y1QV09BzJm7ibZG/raCARdOa3HnWI=
X-Google-Smtp-Source: AGHT+IG5UE51bDj6+j6YjCufQkH73YX2WTErrks/n9xpxX82Jazly0FQ4UEYXVLOMf3DpgRBQRKnqA==
X-Received: by 2002:a05:620a:444c:b0:7ab:3ec9:f4c7 with SMTP id
 af79cd13be357-7b2fb982785mr1553963385a.35.1730756066117; 
 Mon, 04 Nov 2024 13:34:26 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a9ae1bsm459779385a.123.2024.11.04.13.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:34:24 -0800 (PST)
Date: Mon, 4 Nov 2024 15:34:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/9] docker: Adjust packages for arm64
Message-ID: <20241104213422.GX3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-5-sjg@chromium.org>
 <FAADE9B2-6D3B-4975-8A5F-F96CADCD1B65@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ASf1qqz8g3FfaQLL"
Content-Disposition: inline
In-Reply-To: <FAADE9B2-6D3B-4975-8A5F-F96CADCD1B65@gmx.de>
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


--ASf1qqz8g3FfaQLL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 09:58:50PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 4. November 2024 14:39:48 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >The package names are slightly different for arm64 and we don't seem to
> >have a linux-image-kvm package. Provide a different set for arm64
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > tools/docker/Dockerfile | 12 +++++++-----
> > 1 file changed, 7 insertions(+), 5 deletions(-)
> >
> >diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> >index c9d794082c8..c4c3dc5a901 100644
> >--- a/tools/docker/Dockerfile
> >+++ b/tools/docker/Dockerfile
> >@@ -39,7 +39,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/too=
ls/crosstool/files/bin/x86_
> > RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/downloa=
d/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
> >=20
> > # Update and install things from apt now
> >-RUN apt-get update && apt-get install -y \
> >+RUN if [ "$TARGETPLATFORM" =3D "linux/arm64" ]; then \
>=20
> Please, use 'arm64' and not 'linux/arm64' as variable value.

Getting back to your previous comment about documenting these variables,
I took it that these are NOT free-form but rather what Docker (et al)
require for proper multi-architecture containering.

--=20
Tom

--ASf1qqz8g3FfaQLL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpPdoACgkQFHw5/5Y0
tyyfVQv/QnjJy+/m0IybBWYpn+yC3Z/lbNtdY6B3exs7oUEqROC40HlWuNy2ua2p
YD/jIBqhB9YGDpV5FZz2yGVVIemHXEV/5iajs2stm75wo6iajd6vJiH7OZ26pWOQ
OFLedrrjZ9u9Onrz9v6QSp46k4DaB0tnuRVhClKAWpiFGPznAXtRn262PmiCP5zC
+Tlk5kxyFZk3+0WM3ODKuFaAI6VZd1h/BhJWPsmxK3JY9TLSgEro4hTXYa+FAHtb
6tasCxh2/cG2h5q7/Lo4Tsg3aFySAYSqWyLYZwHxALug4kh9keK5twEeTE80UxkE
esyFha3y9euthzKUkcWRvKlIKDHLskD+SQ3/364gBzyq5Efh64INPOQ0Y3361+Mf
uiR8bZrZSJl/QjU8fDmpGhoU+4zD6Pz9/8s3ZM8zz0Ww41iuy7XyhoRfQi9/xc36
gNzZJL6zLTcoWchl3+jQPcZ3qcEZdnZHptY2b7rvQC5f/qEx9mOChAOwAuz4yuGL
AHZwV5TV
=bcuQ
-----END PGP SIGNATURE-----

--ASf1qqz8g3FfaQLL--
