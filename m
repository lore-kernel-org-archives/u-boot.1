Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73865CF58D6
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 19:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E266A83E0E;
	Wed, 19 Nov 2025 20:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SdP/ycgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8C183F26; Wed, 19 Nov 2025 20:56:36 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03EB183957
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 20:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3eae4e590a4so20553fac.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763582193; x=1764186993; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q6Xro7ZHdVgvQ+t0Dp2PP9owt4rjpZI+xcXT2qPlZY4=;
 b=SdP/ycgA48DGkLFZSYgNWNi17zcnjtZP7vq5esGsu0aXv5Kbyzcj0Jp+GEOWSpcF4L
 euEZwX4Za9DNsjXyjCjAd4Dg/0+5GU3mDuHaDjIk0HpHwEtV7i6znFj6o/GizByEXrC9
 bEHbBLvKh8cmE9MsXcuhKNj7c9/1aeBO9ouek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763582193; x=1764186993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6Xro7ZHdVgvQ+t0Dp2PP9owt4rjpZI+xcXT2qPlZY4=;
 b=ocOjaIClBmmffwSy1k1Pp+/yp6/8zdCX9jY8erv4XQYGwgd3IDrtWSLIhT+bzuoY0w
 eItqGwnAMKLV09yeCQQ5Jl9geaw0tzpwD6vqWOfDeaklczcJ8DpNpb3KgvAzR9LhhOfh
 sG3Z5zKs6SyOsyhQ5T9IOkAy7Md9lFKOQyJ88N0Qf6DScDzvaK9AQ8Yzh+/HhgqOm0UH
 sFQG7XPt9dz47MNL4bD2RchxW+PGWjGDdOYiG8OmHYyoXSPySl5Udgbbd1qKd6ziNP8c
 RKqaf/RyM/Wdvi/+Q5W8F2b/qP836xz7pe22IfqQU8ykUAUxEzdzl6M6YixJ4A5drVSa
 DjYg==
X-Gm-Message-State: AOJu0YxyT07PDt6b4NYTMzLCTcw7ygajLvUwDTryLAafihbOMdtT+Sh7
 koHOwuZWAxjdSi5MCU7KfUQUqw0wL9VFxBXFQxLUdC7FFUZB0uli6vFU1d8S3OmIzRE=
X-Gm-Gg: ASbGncuaXvas7rQoK4IDjdNJoImEMki/0cJC3IyJ1ukdkiQdHemSyvCvI5Z96DoPC/C
 oeWAo8RnWhG8n53LTXBIfLSlXNP/+dOB8swKWMZa4NMBgXDJ7fdjh329gBT5jcEi02gHY9nqEBu
 Q9VrDNGBSJxHIme5yiXHz9kA82GYyRw27UX3FCfREN0W7TM1GsdSaOD5LFKZ1GAX8h5wYFhMSeR
 AEkYG29ZjX1watDNhfb8SbkK9KLYALokuv9PXdhxIHoNZOaajvXZ9pSkjtjHCY3VlQcS5i2t0Yk
 loI16obLTG8SGptEmdBab2Q2rzbcDf8RtMh+vEVtQsg5qh3/DqSZx7vbIHCqljS3uCEfxHnFcRK
 Cc8tHhvh1c/CK0uZIItZ39+0z+i32K4gc+IcfAe6zLb5/GmrYYoTVw/FWPTjTEcjE6AX28roWcs
 sn9/dFtMyYbW3LwmQ5x1JIZEhI0i7mVVJqC60cLxnP4TX23GlqEfw8/STwPaoT
X-Google-Smtp-Source: AGHT+IEH2Shr7Y6YgLxuVDuzY1DUqya78gsh95LCYtxF7e1dGcWnoLuLHFuoarn/PJ6pW/PS2QZZ7A==
X-Received: by 2002:a05:6870:880e:b0:3ec:9c0c:283a with SMTP id
 586e51a60fabf-3ec9c0c29c5mr224565fac.24.1763582192680; 
 Wed, 19 Nov 2025 11:56:32 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc21868sm130102fac.14.2025.11.19.11.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 11:56:32 -0800 (PST)
Date: Wed, 19 Nov 2025 13:56:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2] boot: Warn users about fdt_high=~0 usage
Message-ID: <20251119195629.GF2125796@bill-the-cat>
References: <20251119174425.58535-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jyEXnXMbfO/lvMFo"
Content-Disposition: inline
In-Reply-To: <20251119174425.58535-1-marek.vasut+renesas@mailbox.org>
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


--jyEXnXMbfO/lvMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 06:43:53PM +0100, Marek Vasut wrote:

> In case the 'fdt_high' environment variable is set to ~0, warn users
> about the dangers of the fdt_high usage. This will hopefully lead to
> removal of most of the fdt_high ~0 usage over time.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jyEXnXMbfO/lvMFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR4g5gAKCRAr4qD1Cr/k
Cj8pAQDKYBO6g519yqIN+I52y0IH4jlob8dlFIXql3q9DFIJUAEA+wBNXTE8fIAm
+GAWgZC77+8tQ9Gt/qVVdL1QE1HQeQg=
=aUse
-----END PGP SIGNATURE-----

--jyEXnXMbfO/lvMFo--
