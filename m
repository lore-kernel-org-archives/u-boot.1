Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A165C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6590487BEE;
	Fri, 15 Dec 2023 21:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iH4Wh4r6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C8D87BF2; Fri, 15 Dec 2023 21:40:17 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20CE87B84
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77f3c84e0f6so76243285a.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702672814; x=1703277614; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ckaETSH7mUNIl5Uck7gKEEMvaCc3e7u5jh0C/ZvpeUM=;
 b=iH4Wh4r6jlufTrEH4ZYNHM0KD7JX9rU91ZautXaVVMUkj3ZY8lGiCFztS4GYKeC4Q1
 81evPwE8PDKyZNDo0C43Md0Z1ycIrN7kVVHgN8BIj+DreAKw3lymxAoBNSvqP+68a6m1
 n0XVMOhvylacvjbXWkwoiHJ4cas0O/CZI9w9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702672814; x=1703277614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckaETSH7mUNIl5Uck7gKEEMvaCc3e7u5jh0C/ZvpeUM=;
 b=JpBpMToCjSvxd2ZhzmuY8AxkKkZ3a+ripG3zupdw1JmjxRObpZDXZ14XZWboaCErue
 zWdtUS5M4uv8xGmIJ7jUQ5MSpL8Rj3m1n112q91fKFXN1FD8dz+YXvpykV2AQwjbOq9x
 O5iYuLRws3/Rw/Xzh6DBT5TPt5TD9T8bEY9r6HA57jZZpjWL1M1wWwQkJwcBGtO/Q/WI
 xFKx6OkrXSUVOLzuAoEoOgqNRY3ag0c3s4miVcUTye7iqERi9d4pJhmI+j/FpEWLrwhp
 2Xd0FzcqsOCHmh+VViUlMx8IXeHZOj2nSlSjyT6nVC1FOp8fblMeaL+qv0j4OxemIdTA
 0zZg==
X-Gm-Message-State: AOJu0Yy+to+w0NiBpL5WWAjKdw/iMKvQdAPUNxJcmER+LIRD43GFpkEe
 Pa4z9Vf2SHD2e1fgzkKteNgtqA==
X-Google-Smtp-Source: AGHT+IE74SvGII+HhgTS9ooGNlnyE8jm0TOb44vcMg0WNoLLGzd2jFqpIMBwG6SBTN4N7uNvdav8Dw==
X-Received: by 2002:ad4:5f49:0:b0:67f:273e:6aba with SMTP id
 p9-20020ad45f49000000b0067f273e6abamr52945qvg.57.1702672814428; 
 Fri, 15 Dec 2023 12:40:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a056214032200b0067f13b8a473sm1145461qvu.45.2023.12.15.12.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 12:40:13 -0800 (PST)
Date: Fri, 15 Dec 2023 15:40:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/6]  board: siemens: clean up subfolders
Message-ID: <20231215204012.GA4029343@bill-the-cat>
References: <20231130122324.658502-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pBKb/gy1Ofb72iEh"
Content-Disposition: inline
In-Reply-To: <20231130122324.658502-1-enrico.leto@siemens.com>
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


--pBKb/gy1Ofb72iEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 01:23:18PM +0100, Enrico Leto wrote:

> This serie depends on the serie:
>     [PATCH 0/6] siemens,am335x: clean up the draco board family
>=20
>     The common folder was initialially created for the common parts of
>     the products based on draco-am355x board family. We have the
>     product lines 'pxm2', 'rut' and the base line unfortunately named
>     'draco'! Adding the new capricorn-imx8 board family, the files
>     were enhanced without cleanup.
>=20
>     Simplify first EEPROM probe and access that implements both i2c
>     with & without driver model. Use abstraction functions for this.
>    =20
>     Move all am355x specifics to a new file 'board_am335x'.
>    =20
>     Clean-up includes, config checks, maintainer.
>=20
> Signed-off-by: Enrico Leto <enrico.leto@siemens.com>

Can you please rebase this on top of the current -next branch and ensure
there's no warnings on the platforms when done? Thanks!

--=20
Tom

--pBKb/gy1Ofb72iEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8uagACgkQFHw5/5Y0
tyyyaQv9GNaIpw23qbT/wqS0ZHaxhA0Jn5fSsvDdoF+U5BlfgytpDmMUrnLJo7uy
q2DDIxwx0UOrULrbYVLjkGEntuUmo9f34b6NW5frkoJa+IZq9cnmiK6V6IzOaBv2
Bvv8jK8XcM8zFRCW63d9h1z4fuia8SNuXqnX0LGp24+s/j7DBLLVivVKBUjyw+ok
1fr6SA4cDf8ZwEwq+6xPRj+E19k76WQxdSS0m6CuNZNAh+e9dikTp6x/I3V6fSZv
djZBE3aIzpsQNxO3tsbXjO1FTGY5S1knzj0Dg2jpHo8soZdYch6m1PT5Yt8xSrNr
Y3mEz/3iXnySXkug9S0ShkJyAUFFl3haJrxqatNur2ZQxZdJRimIEH2IjvKbkGVw
lKLdHdDdB12i445QyXAoosvooXYRIucZGAXQMkbndbnDRwq03LUsiEMduL3XWHP1
aKY0XHRFfB/U5HB+aci6dnXpiEp9becJglpRIBvJ0NuLM1CCsL0Vf6kfPTV5sytq
f18Ilf4w
=+7Ai
-----END PGP SIGNATURE-----

--pBKb/gy1Ofb72iEh--
