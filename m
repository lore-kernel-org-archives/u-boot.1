Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C05EC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 17:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41DF80EC1;
	Thu, 30 Jan 2025 18:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mova4ZFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3C682128; Thu, 30 Jan 2025 18:04:13 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0263B807A8
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 18:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb8db8ae9aso441859b6e.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256650; x=1738861450; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RofXr7bsc1Ub88it2FH576I0qFSrMzuf2YY4dRgYriA=;
 b=Mova4ZFna/EKLiyWRd5C1aLZByT+BpsVfjHnD7j974b+HORvohlb1sTEl5AjGPEdk+
 i2Fskg2plVpVKZa6N8l+1Qlsfj3Lfts6FOc5v0t0JJwQiQ6Hu5VMpnE3Su+WktgG9I5f
 QDqhisweIJpHl/TEpDjm0ix2DVBqcmeLLUOys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256650; x=1738861450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RofXr7bsc1Ub88it2FH576I0qFSrMzuf2YY4dRgYriA=;
 b=aBXsZngUBxFHYUx424zO0oB9HU7yewQRoiQN1e57BJbroIUuh9YfkZXtBnzaYGg5qg
 cLFLJpmO6Lg3gLu66DHW4m/3rQKM0IR2LGN8gc6y/wphZeovwWpmFPsO7sR1X/H1+lKP
 7mjLlMIX3MdZPF//uaK5H7gkU3Wh3ZkamyoQZP6YuQnPaS+l5snuKbgh9yd/xjgBoWew
 Bgpdx5POIBnb7DDL0RNV+0cIJRu0fRL/1OQDI94x9I1fu+JlydGj/2Rn6zw7QSXI0gLe
 4/qqxABEPZBpqbvugiMkeVSPEFAQEG2o1khdSMD/HDhMoKtWwZlDkiGAvglXczLEXXsd
 9Kvw==
X-Gm-Message-State: AOJu0YyfJ1fa4EBvf8xwsDhBURok+fS38/wH1glekRPlXy+wVPx5tHkd
 dX1UWheXzFO8mZUVQp1FhleE+VL3aPjI358VrGwW/Y/0d3bz0+b3c7ReYZwLHviHXVrsuBVXDzr
 s
X-Gm-Gg: ASbGncvUr6Zonfk8DVcRxpuUflB3NMwvA7xMpIkeVfhyhn1DbNR/RJnYFSQY4T2LXGt
 GXn/pdOj/jZNxsteSSZ7ulvDcUpkjSEInVF6eY4Delfz+8SRvWqAh7SISDezqikS8rlqtnshBp8
 hdpj43202fs4TSVRSW43bg5GtQQa5hBgvXQ1ogupZNXb7vBTQfckjCf30hH/Pl0VStXawndTmbs
 r+pSXff8FqsgNLpg+aSGnfg2ZUGJOPaEcEGZ2sdHRZYmkD2p/0f7qtBpK325NW29tqYQYbXgUIA
 MMsRltWsco3QOaA=
X-Google-Smtp-Source: AGHT+IEDH9S96N3AfQgPMPEGacEzwy5334tOy9BsOMz4reTsrn8LrRhyIFmx2ZJtb6ep8BA62U0a8A==
X-Received: by 2002:a05:6808:1493:b0:3eb:63c9:fe87 with SMTP id
 5614622812f47-3f323a470a1mr5235352b6e.16.1738256649671; 
 Thu, 30 Jan 2025 09:04:09 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f33368b80asm327072b6e.46.2025.01.30.09.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:04:08 -0800 (PST)
Date: Thu, 30 Jan 2025 11:04:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferenc Fejes <fejes@inf.elte.hu>
Cc: u-boot@lists.denx.de
Subject: Re: u-boot in restricted environment: networking over serial
Message-ID: <20250130170406.GF1233568@bill-the-cat>
References: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8nDSc8F49DbRZZ9N"
Content-Disposition: inline
In-Reply-To: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
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


--8nDSc8F49DbRZZ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 02:55:53PM +0100, Ferenc Fejes wrote:

> Hi,
>=20
> Is it possible to use the serial port for u-boot networking? For example,=
 given
> a restricted environment where the FIT image is available with ethernet f=
irmware
> and drivers, so it is not possible to boot it with DHCP boot since there =
is no
> networking. Or simply the ethernet NIC has no u-boot driver at all. For s=
uch
> cases, I assume ymodem is recommended to download and boot the FIT image.
>=20
> However, experimenting with different images and debugging, it would be m=
ore
> convenient if serial could be used as both data and console channel. Is t=
his
> possible?
>=20
> A simple example:
> 1. ppp on the host machine, with IP forward, NAT, etc.
> 2. u-boot establish a ppp connection over serial to the host
> 3. u-boot starts a netconsole session to the host
> 4. user can use netconsole and wget to download images
>=20
> I was thinking of PPP, but that's probably not supported by u-boot. Anyth=
ing
> similar with RNDIS and USB CDC ACM?
>=20
> Thanks in advance for any hint!

Typically we use x/y/zmodem for sending data over the serial port in
U-Boot as no, we do not have networking support via serial port. Thanks.

--=20
Tom

--8nDSc8F49DbRZZ9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebsQYACgkQFHw5/5Y0
tyy6iAwAoTa7zT+HGpusS8NRIk4oJoHIZB8FfAGhZgE5Z/bbnxlSbPoSDmAB2WPO
XfXizzyQonuPAMZcol1ZRb73M92klf/iepvsdlybxokQfqc/S0hrhsgU8xxuL3Zt
ZezLtd1lv8Hc/HRel18eQ9hz97NX/NstysCvtn8SvF+Gim9HtfahfTeab7YZSu8S
B5TodxcHEkicD1LwSysKrleCawgS3nj5KwRnuszMTHnDd38Ugd427c781AsxDj2q
rhzbDFrYJimrHUppwWnx7a1Zxki8tJ974bVNzPyTfl8IyHPH5PSN7vN6Q0PuHypH
GYyhkEkmNNmxMNGi5Vprvsy68T2NIuF0cun5vzpELdGSlJJNS/iLVXAXZ4ikSM2J
F4GO07Fle7h6JVgwQg4Vh6bFYIPKh1Hpg/gzrwyO8xth1gZD0HWDzgHioAQqJPZw
7tI3m8na+CIiD69wd3DYXKXkjotnc39TJLdLl0ef7reFaKYHvux1quDeUNemN0PR
JALQ3+pC
=CTGv
-----END PGP SIGNATURE-----

--8nDSc8F49DbRZZ9N--
