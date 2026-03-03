Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49862EDA6B4
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 17:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCD4839DF;
	Tue,  3 Mar 2026 18:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hka+EL4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8890083F2D; Tue,  3 Mar 2026 18:06:00 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24FB6838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 18:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d1872504cbso3354461a34.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772557557; x=1773162357; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LKHWIVh6QjvlQiA1keFnA7bYL8wo7qGHdsmmoFcDwsg=;
 b=Hka+EL4dz8TZpZIIg5LQ6gE120cZGuhZ7QBXd2eLRlqCpM6yUypw+1hlfW2d0syLE4
 ou3RgJY5EgMLe4EJPUiOHp+KWSg5EUS02W7qQ97VyV+L3kcOkT1F34E95ccgtNQM+QoL
 onLwwA4nb8vC136nQB+xYxR6Um35mFz/LTZcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772557557; x=1773162357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKHWIVh6QjvlQiA1keFnA7bYL8wo7qGHdsmmoFcDwsg=;
 b=oj5Nv3rJkcEY5o+1Q2lZPVE4dHwdPXks391Ew5ApFIsDoRIF0ReqV6PZcKHn/ydgKB
 9eHrHv+6xIXXY4cjWWBkOg7LrsivuOSzmcudW5a5DXb4UX0XOpqHho1t+F0dpwQ2KaXc
 rm9+MUcXD+cDYdbxiw1mw+mEa3CdRQi+kswo8GXim3Ecy00BZYYLAaPpCv9pauqgAomF
 uLVSLwynuZcC14/1NGkR3ZIvwpgdzo4MYK7C4sAe9tFx/Swef2+LUipTPVoJ73oiZrK1
 IUfNV18ReLSY6Vw4FrKlN1D2YqlU7gI8iSpim4XCGu6QYGEnp32KrWq+/ehH4TKd8cGs
 FKgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4IeypFk95OyJjjsLbLaWMHPns/ppddT9faSfQ98WRShwXIwYYtFjso0hdZVTdAxuywlwyn/Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1n9Lc/ExKDeulF7W2buZKxQwhYPE4sUOpcooJlewP4zCi6MzD
 nm95eyHWjRgzPkJyFwsU8EWBh40bfaNmU0m5iGBEZ+wNlRkyhbKo0anJEOHkQLs3QIk=
X-Gm-Gg: ATEYQzx1O8nrjvY6aNZUvkX8c7vut1R624aE2RjSNcWPLUQe6Z+TJ/KMi2Ie2sJULj7
 LKs+pTLX/g14Z7IDtIszflSOE4q7LDhDl50PK5iLRiw3pqU1k/Gg5b86tljDj3xuZRtFHd4uCrT
 ax/JSKZLqFV/NVaj78qUgSs1gUpjhoAMWb4Hia6MrJQvuL8E1wR6QMERxOrmHMMDrQOGhI5UlPt
 HRqpXVc3gBn1itwZHl557HJ4M9q9Eenmr293t0pBfYG/dy/IcnIqcdtP3QQp4j9TJh+8zQZymVc
 Smk832uBFphHfloLqE4avpbHzgRnL3MvKgV/cqjfmkD5RCX26q4K5FKheog1X7ex1+VN570bOP3
 UXueW5ufR3SdzTBWPUWJiZqwfJuYc3EvpiH16A7GBsNBN3vNfRIxm1zeLH8PehN6mGSrPmBixs3
 IjErfMvzzocVfztTwpECUk/JsEFV2NYmyhNtMzClaebo4+x+CZybxU2PFqEo2Ug+ddCe+TUdvA/
 5yV6imrhPxUJToaWqNrE7K9u9n+Tq5STi2afI58VBLb3Omd+9g=
X-Received: by 2002:a05:6830:65d2:10b0:7d1:89b9:9205 with SMTP id
 46e09a7af769-7d5be323cf8mr1185748a34.3.1772557556825; 
 Tue, 03 Mar 2026 09:05:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644dd17sm13393228a34.5.2026.03.03.09.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:05:56 -0800 (PST)
Date: Tue, 3 Mar 2026 11:05:54 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: Conor Dooley <conor@kernel.org>, U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
Message-ID: <20260303170554.GR1388590@bill-the-cat>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
 <20260303-choosing-chivalry-6f892a14eaef@spud>
 <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="acRQW546VY0CdNBk"
Content-Disposition: inline
In-Reply-To: <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
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


--acRQW546VY0CdNBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 01:00:13AM +0800, Ng, Boon Khai wrote:
> Hi Conor, Tom,
>=20
> > > Why would this be inappropraite for the Linux kernel, once the system=
 is
> > > fully supported in Linux is the first question to answer. Thanks.
>=20
> As Conor mentioned, the bits_per_word setting is obtained from the
> controller and validated at runtime.
>=20
> Additionally, bits_per_word can also be sourced from ACPI, as shown in the
> Linux SPI driver code
>=20
> https://github.com/torvalds/linux/blob/af4e9ef3d78420feb8fe58cd9a1ab80c50=
1b3c08/drivers/spi/spi.c#L2739C7-L2739C20
>=20
> > in its spi_device struct. I don't know if u-boot has similar
> > functionality in its code, but looking at dm_spi_slave_plat which I
> > think is your version of spi_device, that information is not there.
> >=20
> Currently, U-Boot only supports an hardcoded 8-bit bits_per_word
> configuration.

Thanks. And can we reasonably follow what Linux does here instead?

--=20
Tom

--acRQW546VY0CdNBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaacU7gAKCRAr4qD1Cr/k
CpCOAP9WkpcUsUGpA77HB7th60u4HfuipYKpibVra82Px2urzwD/XY4UN7netN1z
PR6aCmzDJyq6KXflpqk2Arzwm6zwqw8=
=TGwC
-----END PGP SIGNATURE-----

--acRQW546VY0CdNBk--
