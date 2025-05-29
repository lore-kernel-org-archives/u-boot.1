Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD401C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7AD820B0;
	Thu, 29 May 2025 17:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MXl9wVcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC9D82B8E; Thu, 29 May 2025 17:49:30 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C06F81FFC
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3feaedb531dso265310b6e.3
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748533767; x=1749138567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/H41qRTs4eGWlsLLg0JQ/neaSJ55ll7qD3K2j+Bf21w=;
 b=MXl9wVcOqkFACDr3K1EoQGG7vjmgm4iNT56RxvjeWF51yoQHV4ouuX3ZC8GapTY7OO
 kXnx7QtMV1BcqsNo/NjlMNA3+qvNeqdHni/Z63H1ccGBqsE/05myhHfcFFPuAVK9bBUI
 4Wu//xJSL6IOOW91pi7rh1hw/2VeZ9Wk4aSf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533767; x=1749138567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/H41qRTs4eGWlsLLg0JQ/neaSJ55ll7qD3K2j+Bf21w=;
 b=PA1ky4cR++OVppk7RSRSlZ3m5KvDjiD/XbEOfxNIN65JMmo5nQPKxf/z9abT0AiiX4
 Np9uuUB+xS3bWCeazPqY6fRNhL/23oOrmfmD1Zrhdh64U9y0MTdP1bv1/q2JmiywPD3y
 HhbkD9PZy7XyuYrN3fLFJQxI56aOKFe76pmUSoqC2xGl2q0Wd7Xp3hm70yRQTvJdO5iv
 fQyh/rJaww8F3x2CkD56pEHPMrlzjQz/upNvVq7ycQDKz0xz2hWKDYlIYA1K6+7nDuOj
 PfEwiiKIz2mHIvKmFJkWxx1YLYOMYCzP6MT9TkSiw7oQdVjqoXo5e2mLq04ufit6kWLl
 X7AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+k6BvHEw51b6/m992B+7D4LZs+E6JOuWJ6ir5R3RljWlx1wNx1SfaMZfr+RLDtTtH+Zu7d74=@lists.denx.de
X-Gm-Message-State: AOJu0YxpVozd5jagrYHeWRybuvXlIAWHucOv0gDs3js00zJiM1WSK1R3
 BGwPDpsURtI1c9mmwteOAEQK9OPAx5S1v3jgUawp/HTCLusAAIm6AEZH7BMmCI6QVFE=
X-Gm-Gg: ASbGncvhQ+fBGSjrwefXp7AiZDTM8G9c1Dh/BVywNztgyTwwSlOSqsHLEiJMjiXJNVb
 czwUHn6bQDtFqiXVgXppGZUpGwp9p3C8a8nj2yN3Kx01HDFCQv2tLZGDxylWSh/M+XxCwKYTvAC
 wNRKsO8OiD54xsp90syJmDORskmQEXlvepKic9EvT5SDIabPcble0aU9rxoVUwMQu4pcLEwkFK/
 ZJ6z2O2R/G9nroOLYd41ORicB7dZVOG+UNxvckHalfLP04xqFV5q029EMH/Js9eau298EReZJgT
 3zfz9PVOa5ZnQhBu5FFb4OMmYmZ5FgNMsnlrBfM8nAZgK60qQ1/N4ed0kO4p8MiOmLiPWE1UJiF
 yLkpB/616TkVz
X-Google-Smtp-Source: AGHT+IEvFfdoh6Ob0SxslWLPKvgZiAfqjhbMW3HfXzT9qdcUEt7AT5Dribg8rh2YDUqjB2mQgy3gZw==
X-Received: by 2002:a05:6808:6a87:b0:401:16e:918e with SMTP id
 5614622812f47-406796e54dcmr9803b6e.8.1748533766722; 
 Thu, 29 May 2025 08:49:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678d04728sm29440b6e.50.2025.05.29.08.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:49:25 -0700 (PDT)
Date: Thu, 29 May 2025 09:49:23 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGJvb3Rt?= =?utf-8?Q?=3A?= Pass
 SMP core ID and DTB address for ELF-formatted kernels
Message-ID: <20250529154923.GL100073@bill-the-cat>
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
 <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
 <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
 <20250523222926.GZ100073@bill-the-cat>
 <fbe649de-dc78-4ef3-8204-95020ff2cf45@gmx.de>
 <SY3PPF5E5ED63A94E67F10470722CA5B3529F66A@SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xMBwPAjHuysm0rbe"
Content-Disposition: inline
In-Reply-To: <SY3PPF5E5ED63A94E67F10470722CA5B3529F66A@SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM>
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


--xMBwPAjHuysm0rbe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 09:33:56AM +0000, =E7=89=9B =E5=BF=97=E5=AE=8F wrot=
e:
> hi team,
>=20
> The ITS file looks something like the following, and the kernel is not a =
standard Linux kernel:
> ```
> /dts-v1/;
>=20
> / {
>     ...
>     images {
>         kernel {
>             type =3D "kernel";
>             arch =3D "riscv";
>             os =3D "elf";
>             ...
>         };
>=20
>         fdt {
>             type =3D "flat_dt";
>             arch =3D "riscv";
>             ...
>         };
>     };
>     ...
> };
> ```
>=20
> To handle this scenario, we need to:
>=20
>   1.
> Access the values of the `type`, os, and arch fields stored in bootm_head=
ers->image_info to determine the current context.
>   2.
> Access the boot_hart and ft_addr stored in the gd variable to update argc=
 and argv.
>=20
> Not sure whether accessing the bootm_headers and gd variables in lib/elf.=
c is allowed or safe.
So this is why I was asking if there's some more generalized
specification we can reference. Is the OS you're using something
pre-existing and so we need to do what it already expect from some other
loader? Or is it something you're also creating and if so, why not
follow the linux kernel convention for compatibility?

--=20
Tom

--xMBwPAjHuysm0rbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg4gfsACgkQFHw5/5Y0
tyzMfwv/W+8SRkpi2memHmiPaKRtRIPCIP9h1dPfGkNJvRl7oYkCmd1mr0sTWc/f
71TyojqroO0pbOPLOgiD/2ji3kitoYB3JBIIlryoQjVFejM85jnbCNjR/4TnRq6M
dTBkcXIEcQbC6rTdl2ejQkzUrsD0YsbBL6DGQF9eXvL+PUDTzjEwumICDMgnPNnd
8ltw34Wl8kOVdV8FnCNHgPkAu/y0gA1a8VQ4/YubjIXIDFCur68anD8bZTl6xkKo
zU3ejvuMaTCg8POYMRRgfQA5LvS38jO3BcRLGwQgMmmVNHrksJgvuIA4+VxIoDIb
vgSnLUIsaFn/9ov9INIQe8WH09Nj3FqryHaX/u3kgOQQSfdD+n+f5ETZ+6RqOcHb
dUcOHsGmT4WMnp5dCbj671kdBkF+AzMuqjxzL0dZBoM/9WVAN+0VTCrZRht1HL72
JlrbBCOnhcTCj3rMiA6GqFclfdMKiKnYbieTQiqURyelC13tVBfqgTUHi7NHhgPs
LhgCEflI
=6AHh
-----END PGP SIGNATURE-----

--xMBwPAjHuysm0rbe--
