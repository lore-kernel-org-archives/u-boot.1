Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157A5EE0211
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 22:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECA386A33;
	Thu, 14 Sep 2023 00:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ps+bKpxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCE386C51; Thu, 14 Sep 2023 00:04:06 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6206286A28
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 00:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-592976e5b6dso3442527b3.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694642643; x=1695247443; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GG0sAK3LyRJM8zImHkb3osHgte0aju2yoFvPE1UWQdk=;
 b=Ps+bKpxnUrKNfqKsY1W9lNO1HD/6/rz+svzSBfu4qwBAWEXUUQXYIVuY1kNpOqxzgL
 ysnf9WRclmcgPu32nvVr/Z+vDPDu7aiyVYhAhhUyrIKmmJeR7aoCJ3zl4XP7uqhmXMvq
 I8y5vY1k5e5a2WiViZhMRTurwVA6tpcVjOhlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694642643; x=1695247443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GG0sAK3LyRJM8zImHkb3osHgte0aju2yoFvPE1UWQdk=;
 b=pzEWvOdxS07M8vc3WTWrsu+g3oImKNq6loFvdZW1dCHVFvHt7aQy8/baaIPbAl8s0d
 FYqmbJ8cjtbz4vHANCQhtWi7hkq4Soo5OZNuHFYA64DYuXCGW5tgcoJG5zo73m2vClZX
 ma2QKHcrbPYGYlcfF5BEMMcjBpLrc2Vhzpg6FqNVkbgxKeKW6wzVYN49mdnex1yzfO1p
 CG0bIuFR7khRxU26xAwRIfdk7FsIXF64MRC+rd6pYikONZbHK4y6msu7QkRs/OX1mjj6
 MDx3GsZHs7HDLermuPNMT5ScsxEUB4IZh3/oNW/HDWi38i5ezaFIdCYeRu6tM/NaWncT
 ItvQ==
X-Gm-Message-State: AOJu0YyGCnWut07/nfY7R0SGndVkhk51Qhpt3P8XIag3W9/gFIkushHf
 9qZJN5K6Xbg5zchmUHR3ADSUqA==
X-Google-Smtp-Source: AGHT+IGWrvWLOa49thtchNN7WiBAnV62XBxmaRYdtCwffbheC9YVWdwIeLhtDgMexIocRDWp33Nb8Q==
X-Received: by 2002:a81:a181:0:b0:59b:50f2:98fd with SMTP id
 y123-20020a81a181000000b0059b50f298fdmr3720551ywg.0.1694642642909; 
 Wed, 13 Sep 2023 15:04:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 a68-20020a0dd847000000b00589a999038asm3836ywe.77.2023.09.13.15.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:04:02 -0700 (PDT)
Date: Wed, 13 Sep 2023 18:03:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] net: phy: motorcomm: Add support for YT8511 PHY
Message-ID: <20230913220359.GS305624@bill-the-cat>
References: <20230805103508.23459-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="esaQObt77NUwmVdu"
Content-Disposition: inline
In-Reply-To: <20230805103508.23459-1-frattaroli.nicolas@gmail.com>
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


--esaQObt77NUwmVdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 05, 2023 at 12:35:01PM +0200, Nicolas Frattaroli wrote:

> The YT8511 ethernet PHYs can be found on e.g. the SOQuartz or
> the Quartz64. Add rudimentary support for them.
>=20
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--esaQObt77NUwmVdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCMc0ACgkQFHw5/5Y0
tyxKCwv/fLFFi8SNbeHI8vWTVMrBv1OyWIusYnHQV1g7tbvzziOowYVmZ5G3cm9g
VhUOYf2Bh89Z05TinNO+HNAja8wPoC8JQVIxKZgFyLKGtvSn1vJOXxg3zaROrBy8
3m6o6mAFli3pFXr5QJ6SQG5NIfK+yM4TQ2OL1lIGEH2qRZY4gYErvy8iEcc5Nf3A
M0luPhjl9ol8lLwr65wIaAVNwKHYaouHQrqCUy3CzfTKDoeXZ5+20IZWK6N5hDH3
pJYI7V1jRJgP08S6C3upQR3EXdeHOE9qmnGwYOzCgtwvjmQJfmDsV+XlJnYDXCjl
2+l03TjZCz+a7q05wyldPMaU2w0nqh+7iZq4W7/fh5f5Jx0QbJYoqOUsTJzQBVdt
UYTjp7E7zF9K0ZZrncfrsimVOFOjBp8h0pnuXEhrr8uHdkO6xbj9GRsC4ovGv5LI
at9haa6GSvOMq0Cv4qJ3fkYG2wAfRBo7jMd9sx9Qjw7Ku+xHnNricNGibhDtHsLn
zuzFamtf
=A0gQ
-----END PGP SIGNATURE-----

--esaQObt77NUwmVdu--
