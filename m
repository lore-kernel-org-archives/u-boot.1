Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444B4CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 19:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854CD84238;
	Thu,  9 Oct 2025 21:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nuj4HU0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E203D8423A; Thu,  9 Oct 2025 21:06:47 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 731C38422F
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 21:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-43f645f162aso771711b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760036804; x=1760641604; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9vYbAxWR61SSh/qNxgrhexYQFnz3DHOrTZTPmjuyN2E=;
 b=Nuj4HU0ACZ2/R53RRsvQDILHCKfdr1/eh3AihDSDLpsfdlgrj6nW9MfLa8WFIB/JU0
 Gdl3RbQ1vVN0o93u9M1xw+B/sHPjVF/olwD/+o2Mu/oM/BJ7HwPiv7CpPa/Tigq4EjpQ
 ZO2mIQcQ3o2oiBZie5GhHK09NQluXkJNloT+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036804; x=1760641604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vYbAxWR61SSh/qNxgrhexYQFnz3DHOrTZTPmjuyN2E=;
 b=EpPVIdZEN5vFz7qMDo0k1LeQi02Wsd78Mxj6qRFFlFVgQZkHQXTcikUPLmoNsfyMVi
 7JLGI5+FW5Di+btq+Et1RSA3EMiea6Lr9i2LuzY1KZD0f2p5NG039oQPoCJVRpztwqih
 xrqTr69MRz7gWe7OlCd47iQoRfShWyKCSEjw4mO2H94KaUpum7ZU2CxvVl/SbRs7guhA
 +2KjoLSxXfufVaCvmCI00+KJZR9n/F6rsI/oUE3B47kQ46RufC41ztdCjCMKHDwugPPc
 W3rtXFgkf2DV1G7Dvp8zj0nn5lr+fri4pbhMRR0Vg0W6kaGFjlDLaITvV+E2AwusSzA8
 0nRg==
X-Gm-Message-State: AOJu0YxeVqgeAYpTTzAmJqBkDog4MK5dKvPdc5Jc2BznxuN4wPFXXyIY
 kLXAqjGcU/p3h2FLNOubvwwhvCgsHaK49rM6ySxPnn+mLY+5+C38BJVUi9Aib5O/2Hk=
X-Gm-Gg: ASbGncs/E2UeBlAVa8+KiqxWFRV6N/F19K2XWDHW9qPyhh2aBKr+wASUWpViiDal3Bh
 PO2SK94D3af6rDqMVjDYjxc9nykxQrv+9AJ8vGkvMeDAySXPIAq127s7AFQvF2S2eTn2J8PkCZv
 BprxDGmHZrq808keAXloxFZFWS8mewQiyOTcObSpnTwqEwPGLQM9YjXjCQJXGNLCvkmr6hKOVvR
 Z5AsXXCXglC8HDbKbhx7gp8sdp+GPLLp8KVYPPmRV/T43apeUTukLJ4svC82IEYJPN825rF9ygl
 zbU/LLtB1pYNrjyAduYXfZcCylq86SYJoyMeMgd6mrPBDIBEBtCoOLoED8jWzFu1wQrDFmXMeg5
 ovXJBnI7UkXd+tDNPyQ4bwlhNm73qhH+j99DWnV8A8nu5yKqDc429TkBTZ7LhU+b2MDVVpaN8iN
 l0x1+DNtB4XQ==
X-Google-Smtp-Source: AGHT+IEjCwMQRsU730WHRtG5cYvkB3DMCKM5kdhCn8JbcoY5MW0Kzrx4gmoA5cKnAU7DXDHkPoXQZA==
X-Received: by 2002:a05:6808:bc4:b0:43b:ea80:d169 with SMTP id
 5614622812f47-43fefc053a3mr5553918b6e.8.1760036804097; 
 Thu, 09 Oct 2025 12:06:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911aacesm114233a34.27.2025.10.09.12.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 12:06:43 -0700 (PDT)
Date: Thu, 9 Oct 2025 13:06:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: Please pull u-boot-ubi
Message-ID: <20251009190641.GS298503@bill-the-cat>
References: <1f803ccd-9743-9be8-a594-58fcfeb0f687@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3U9IbJrIU3n33uVE"
Content-Disposition: inline
In-Reply-To: <1f803ccd-9743-9be8-a594-58fcfeb0f687@nabladev.com>
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


--3U9IbJrIU3n33uVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 06:23:06AM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull
>=20
> The following changes since commit 92dcb3ad5d98f494b2448a7345e1cb7eefa502=
78:
>=20
>   cmd/dma: implement dmareset command (2025-10-07 17:49:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-ubi.git tags/ubi-for-2026.0=
1-rc1

Can you please update the .git/config here so that it looks like:
[remote "origin"]
	...
	url =3D https://source.denx.de/u-boot/custodians/u-boot-ubi.git
	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-ubi.git

Then "b4 pr" will be able to fetch it for me :)

> for you to fetch changes up to 0cab29ff467e297064a9fc30200347bda06ee0c4:
>=20
>   fs: ubifs: Fix and rework error handling in ubifs_finddir (2025-10-08 1=
1:36:05 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3U9IbJrIU3n33uVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOgHvQAKCRAr4qD1Cr/k
CpZTAQDPrWpc8Sxl3T0ihbIiGKYNGMPxpi8a04fQ00/hazivjwD+PMePfMmKGcAW
+R+eq5fKqArJ4/cbbA2HteXoQGAfgAU=
=JGnx
-----END PGP SIGNATURE-----

--3U9IbJrIU3n33uVE--
