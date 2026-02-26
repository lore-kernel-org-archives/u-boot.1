Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE56FD9E1F
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D5A83D1A;
	Fri, 27 Feb 2026 00:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t4NG3sAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E2F83D8A; Fri, 27 Feb 2026 00:38:22 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD8583642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d196a2334fso1225872a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772149099; x=1772753899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m9YuZZa9t2345OiqUVgbwn7dFJcUm2bluQWc7EkU/WA=;
 b=t4NG3sApE7EUahv0ZT3Lj5hc8Smz+ArwE1/aUT3xRbFyU1CwJicPS0cyqXzJc3hlJ1
 SS55pMcXvljxp9KLxmIEZgSwkoRUao5LtRDem0m8l3usr9GEX0rVZPaBBju1auJi1ahC
 tCLzWFvF9PR0SzFqiR5mn64H1JpO1Uxjhnj/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149099; x=1772753899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m9YuZZa9t2345OiqUVgbwn7dFJcUm2bluQWc7EkU/WA=;
 b=ndIccTL+FbXGQhL75jSoGyim2ccM3ptvyerBRBCsPUeQRu1vy1I+n4CrLbYGGdToul
 ynwDmFH3e5eCHf4WJM92FLufW57nTQGCfo8Mzubk6Q06XDQUuaVC3KmKa6T0ksKnpmhk
 8FdYtKbvacflLLxcuoMZ11O9UJnknRA/GsqvRLs3UTBpTrvaRYJPsr4YEIt8Pku31e3f
 qxAjqRlJ2JYU7a9sJ4U0n4TvahgdNwz/pJKPq273ENWflX+oVx3PDG320HVLFkY5UVma
 k9YqJg6AeuXJSG4hOteWXfvlnKiKi9uSblCOwTRUqBXFNldwdR00qh6a+IKqnITJsi79
 t4UQ==
X-Gm-Message-State: AOJu0Yzv7MHD5dyguCtq1Z9vFWcmzvsuwufPIVvFptFUQa/+3NV9bxyr
 0VNVHm21/kLj5heSjl2WvCv+63eiTHa8kxoJ37S8Pcd8SU2e9mzXKyGS32ka74TUag4=
X-Gm-Gg: ATEYQzwpDd7gb88DZnWX+LkoZn5B8vfmz3tVWIipgP7l3ZAnzHqh6UHyFgMjcRd9mUH
 ZZ8fQjKMfnaQ5EQexvu+/YOw+mRinuWyxBXDB3nohzscQVPJSDiIJayN5/XaRmSvfD4c8Q5Z3ap
 o6stSF+HumZQhykr1sA+zxYSzr9zuA2AoXE5fnteNlDgn5jq9BN1Vm6tQ7moPf6wQgU6knB9+eS
 rxZYZiO2nsZqGo+x4OkiNdZlJ78khowJhfPdS0AkMUF6lTzmF4eBiW3Gqab7yvAUnvtmvHOWq+L
 vXfA+Rn9R4oN6cHSttdvTN5EzWWjF2OQfG4f+hDcp0F7sN2aRkwgkWkPwf6mNqf0pkTKWNYhSMn
 1p2/A5UOJkittPQICgVZ+975XEjock990qqyJEv/jSYRdC+s+Ttq02K2s/X6AwsU1wbCop2jW66
 8Rwz44pTrxl5i2EPD5LgINGo5G/IIE54/cYHkWVLD0mNhLysYFYINHK9l8lfXqC6iRPma5j757G
 m4iM7CQHFb8zznT6GrOu7FUvUMg0R7wjxpgczpF1LSuf82Bt70=
X-Received: by 2002:a05:6830:6d0e:b0:7d4:bca1:1d9d with SMTP id
 46e09a7af769-7d591eb844fmr634982a34.11.1772149098749; 
 Thu, 26 Feb 2026 15:38:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866269a8sm2919536a34.13.2026.02.26.15.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:38:18 -0800 (PST)
Date: Thu, 26 Feb 2026 17:38:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] linux_compat: fix NULL pointer dereference in get_mem()
Message-ID: <20260226233816.GM1593142@bill-the-cat>
References: <20260226212728.61889-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D8xlzNNaU8SJ0LT6"
Content-Disposition: inline
In-Reply-To: <20260226212728.61889-1-ant.v.moryakov@gmail.com>
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


--D8xlzNNaU8SJ0LT6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:27:28AM +0300, Anton Moryakov wrote:

> Add NULL check after memalign() call in get_mem() to prevent
> potential NULL pointer dereference (CWE-476).
>=20
> The function memalign() can return NULL on allocation failure.
> Dereferencing the returned pointer without checking for NULL
> may cause a crash in low-memory conditions.
>=20
> Changes:
> - Add NULL check after memalign() allocation
> - Return NULL on failure, consistent with function semantics
>=20
> This fixes the static analyzer warning:
>   linux_compat.c:34: dereference of memalign return value without NULL ch=
eck
>=20
> Reported-by: static analyzer Svace
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--D8xlzNNaU8SJ0LT6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaDZZAAKCRAr4qD1Cr/k
CmsQAQDxevgqP8v3rWXgseOyGt+spdqMpC5ETya0AFcAZ47MpQEAw5+e6jx/L807
0HxZTLD2H49JXNHMcON2bcnLFMHGqA8=
=1njW
-----END PGP SIGNATURE-----

--D8xlzNNaU8SJ0LT6--
