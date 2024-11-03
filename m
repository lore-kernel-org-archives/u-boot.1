Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D89D11140
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 15:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECB988E41;
	Sun,  3 Nov 2024 16:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EFGVb3ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D4E88E14; Sun,  3 Nov 2024 16:48:52 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEF188DEE
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 16:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cc250bbc9eso28504526d6.2
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730648929; x=1731253729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nCWjHCgjk1FuoardsSQQgfvzfFbVj3RSDCsH1bcLS9I=;
 b=EFGVb3ye/VNu4Nc5dnZ7KBS3K7idHu6h92xP0hanqPvRrjS/lMKoME9+afmgFYDP+M
 fqLVDWiXVTTImdTlh5oorImaXsmIBtfWu5iWKSscJjbap2K8aE/vLaYwFJdLzhHUE6Y/
 4N9wt9RXdFPVIWcHMOwaUxsLUczAEJT5V7fBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730648929; x=1731253729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCWjHCgjk1FuoardsSQQgfvzfFbVj3RSDCsH1bcLS9I=;
 b=EfdVJaN+4vSGL8F4pcN0Gfk343XMd49KK+O0Uze1J1Yca7n6+NVIdf0WofwDh6mI2z
 YgSgAErUoMDSYHJ+fAJ7v7b5RAIlU9/G1sI10ikbY/jEVmlIZsGFp/u6BiUCizFS9xTl
 KzXnCWkzawMBKBRjoZ7MrGPU4A/N1RQSeyqHHYTfc20NB2G7LLW+BJolk5OXb3HtvK5e
 qAjPNWf0Y/IjGkwF2SaD5Z37/V856e2la3a87WsTLucUEBtI8/x6Sik2HuMj0Wda7q59
 /MwER8k0ojVIEgcI5akrygtLk42Zb8UVjtbhA42lCI1f6b4cfTcN7eVs7c8VIuF8e7PM
 ujbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfRvB+/r3Pc8GoP4A8iyoC3f7nS5t0UrMz65uV9uJdqiIKL0Ldu0rVkjyHjpuA+Bk5+dDyu8U=@lists.denx.de
X-Gm-Message-State: AOJu0YyD0PYywSyHXxP9rfTtfZAoY7MJW4UkQJeUVjytZgRAkSMpvhlI
 P7A3/ECGIwSFuDHp4+XJ5Jz10HuGjVwOby6m4CoZLCaORmnKFVtrEi07yDfPbPc=
X-Google-Smtp-Source: AGHT+IEYQMA5mH+5oio5uQt/8SxLL9UBhwgrPTL3ecnlvq8Vc5c2q9gMidMNC9VSzFNe68D5xLzakA==
X-Received: by 2002:a05:6214:5992:b0:6cb:e5e9:3182 with SMTP id
 6a1803df08f44-6d351ad52bemr186408606d6.29.1730648928776; 
 Sun, 03 Nov 2024 07:48:48 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415a7b3sm39674606d6.93.2024.11.03.07.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 07:48:48 -0800 (PST)
Date: Sun, 3 Nov 2024 09:48:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
Message-ID: <20241103154844.GB3600562@bill-the-cat>
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
 <20241103071200.82853-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r9L6FmuuXzwq8vV/"
Content-Disposition: inline
In-Reply-To: <20241103071200.82853-3-heinrich.schuchardt@canonical.com>
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


--r9L6FmuuXzwq8vV/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 08:11:59AM +0100, Heinrich Schuchardt wrote:

> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use function hextoull() instead.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Fixes: 22c48a92cdce ("lib: uuid: supporting building as part of host tools")

> ---
>  lib/uuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/uuid.c b/lib/uuid.c
> index c6a27b7d044..19f33dd1477 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -35,6 +35,7 @@
>  #ifdef USE_HOSTCC
>  /* polyfill hextoul to avoid pulling in strto.c */
>  #define hextoul(cp, endp) strtoul(cp, endp, 16)
> +#define hextoull(cp, endp) strtoull(cp, endp, 16)
>  #endif
> =20
>  int uuid_str_valid(const char *uuid)
> @@ -339,7 +340,7 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned=
 char *uuid_bin)
>  	tmp16 =3D cpu_to_le16(hextoul(uuid_str + 19, NULL));
>  	memcpy(uuid_bin + 8, &tmp16, 2);
> =20
> -	tmp64 =3D cpu_to_le64(hextoul(uuid_str + 24, NULL));
> +	tmp64 =3D cpu_to_le64(hextoull(uuid_str + 24, NULL));
>  	memcpy(uuid_bin + 10, &tmp64, 6);
> =20
>  	return 0;
> --=20
> 2.45.2
>=20

--=20
Tom

--r9L6FmuuXzwq8vV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcnm1wACgkQFHw5/5Y0
tyzavQv/Xaoptwp6RH/iezdk3GzobfLqD6Du3oVvgvA2+7pltIvt1a4kZReYqnUu
PKkpSnfBw8Vp+oufJMXJpyzhVLwyCLXblT8t2Mqe1sU8vQ/L1MKN+VgEq+fy8xbW
djKwcjBoD5VqEneJHwBhsZkEawD2qVNrgP3fvmm1x8jfnQFWxaOTZuRIO9BvUXfY
4NT5ZMPNEWgBCVOimV3FKEN0lOfuK+WGpV2wOHJTERzKLvOjLBvM6L5773FC7IGi
JA97bory/qi8Kg9XFcgp0/Sjr4fAY+YqwgQi6+AMEgGsUErLToGo4FQ7TDJKE7v/
Zmhf8waHZlt0bEesvOv7YXqXga5Ry7Cq/rKe4jYDxYYJUBuxPAhoBgFiMB3BOdd+
xCaKMCg43hfzJisEbSwHm4b3TtUnHyPxBApRob9TQWqZPmwTSLwpkHWczz4gF0qW
Ydo1kTiivnGuvZmN1HOVrJrDmdiIKsV9GytzFzYjuUo8k/xAmzfGi9Wfgit6+nZ9
UJVDvf3+
=1wzz
-----END PGP SIGNATURE-----

--r9L6FmuuXzwq8vV/--
