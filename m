Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99DBE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A2348060C;
	Tue, 14 Jan 2025 17:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eyt48RnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD0F8069D; Tue, 14 Jan 2025 17:40:10 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0D58022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6dd049b5428so46116646d6.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736872807; x=1737477607; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ur/NKTjRZ7FbiqRfeUqfIxZF+2YRZHJqr1BKJ0tfy+Q=;
 b=eyt48RnFM3o3Ew8Cyx8U5wHueqnzqE0Ri6fWREbTKYyJI+GQNMLFIMVmoXfj4ZN7dj
 KPQigbHkUVxTo1abzZT+ita+YDYXbwJ0xfZEsVBT2vHWCCwOJMPwH/wyAQZ1X8sChRrD
 n4Wtt7G+mNMdT3Ewp02VwSaRp3P+R0c8+eK0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736872807; x=1737477607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ur/NKTjRZ7FbiqRfeUqfIxZF+2YRZHJqr1BKJ0tfy+Q=;
 b=lGSV+tdiPkbzuBpUzx07Vf3vhj7cyDMNPKvikGs90emNJqKl9+0GhlYB0BomHnreR1
 0SQVFnZM22PK8jtv+Yyb9qI9/2skPym0x62D5CQvR1sE0QiCqBK+UexG4N4ZknNVJRxe
 MUgQ/5ua3iS7q/v602nm5LeEUfU6L6v1rSajXLtLFQEbQiqE61xVDqTF5VygDBHaI7Bh
 xj6NvUKv0R4rIFo5qrbVQVe54XMyLYeNrvebQDq9TEutPut/HBYxoLinFe2EOYbmya0x
 CGHwUT1SbqJghkUWi1ueztohBI4qBuCll/z+5O5lkygOSoUqqO0UdmuFeVbuopt24LO4
 bvbg==
X-Gm-Message-State: AOJu0YxbSVl3szTm80beRadt4Rc75ZynOfh1XZAqEGVU7bCUIWq+oiUq
 7e0mkLnkVIBQoQo0klYcld5ZrWxuWQz7PU7owiqZPqrXoHS0ueGgJf0UqnU5zMssiGtOzvC/5Bl
 l
X-Gm-Gg: ASbGncsw5DpYb3w+mkG+UzwAJQRrzkdZEsy8CIO6VAxo1Q7NLpXfNUqUlYWDE5qO70u
 aMUF8Y3AjI9Lhc0kDCP7ZcKB7V94VjFGGLX8CxYga7TC2mAsc6NHl4HqtG/ICpG7Xgwjzl3INHe
 7GiuOjSnfbKRedgT9SbQ/5I/ywzVyevnVmF4IWsd6U9QYlgCwSfxZ4GQZ5UCxjciOakB591Gp3f
 A0N6eusxg5+8pbLOtDP10RRmYpbWcnWfBrrTdP846mbKo27oN0UIg==
X-Google-Smtp-Source: AGHT+IFSCzQLooj5QSnMp/qU8X7UUon79VE8vsjiq8wyZch5DqZw0BPZYLysaMmT7n7W+iQjeuTxPA==
X-Received: by 2002:ad4:5747:0:b0:6d8:8fdd:9797 with SMTP id
 6a1803df08f44-6df9b2b1a16mr470094296d6.36.1736872807460; 
 Tue, 14 Jan 2025 08:40:07 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade89362sm53895826d6.110.2025.01.14.08.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 08:40:06 -0800 (PST)
Date: Tue, 14 Jan 2025 10:40:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: u-boot@lists.denx.de
Subject: Re: [ANN / RFC] Regular community calls?
Message-ID: <20250114164004.GI3476@bill-the-cat>
References: <20250113183409.GY3476@bill-the-cat>
 <31e9cdb8-72a1-401d-bd7b-6be8ef403507@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gim4wAE3pY14BULt"
Content-Disposition: inline
In-Reply-To: <31e9cdb8-72a1-401d-bd7b-6be8ef403507@monstr.eu>
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


--gim4wAE3pY14BULt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 03:21:09PM +0100, Michal Simek wrote:
> Hi
>=20
> On 1/13/25 19:34, Tom Rini wrote:
> > Hey all,
> >=20
> > It's been suggested again a few times recently that we should try and
> > have some sort of regular open call / video chat as that might help
> > clear up some issues. To that end, I'd like to propose we have the first
> > one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a day
> > after the v2025.04-rc1 release, and I'll include a link in the release
> > email. If this works out well, we can make it a regular thing for the
> > day after a release and also try rotating the time, or having a second
> > meeting much later in my day that's at a better time for other parts of
> > the world.
>=20
> +1
> TBH would be the best to send meeting invitation to have a record in a ca=
lendar.

I agree in theory, but Google is being a bit of a challenge at making a
public calendar link. I'm trying to avoid doing things that will result
in a higher spam potential. How far in advance would it be good to send
the meeting invite out do you think?

--=20
Tom

--gim4wAE3pY14BULt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeGk1gACgkQFHw5/5Y0
tyyLqQwAkTjnI6elfDi0W9Xx7yj/VNL2bVKj41DbnVz6BwwyIIGMrWDBZ+cMUYKF
wl1hYOnUxhMB9MOY41yNR5MoH1zD9lD98KpsxXfZILqpFpl3rb+2SmQO5szvmuqS
wiZmtP2YkbrBRXLKYlnwkPYg7d8ZP+CgQUWRbLheVFUjBfhNwidw/30p1wueDfE5
4Dwz4eI61HbkVITha+gd5FlC2AKyF9ZRo6n0iAklgheVTY8pjVk6CeVNFNrzduQS
KTi550+VYbHBe6Ttw8RjhT0Lb+zbeJs5DvABOrcF78QILjCxMVduga9sfwb9I8Ol
iUQMhCGNn12wS2Qbis5YHZ1B+4J1/Re+B3EW0KYoKD10sCyhOdl8EgdlHBlgOq4D
CHFAMAwEVMxFYsU15vpQrkCiTtgbPNTKvxtpJs3kTLG5rol+sEEOyowsGV2nppJv
fC33lcEZXPbIi7TUVWZDcYLaUNZgT2NCITKi/+08mudw1rcBXwZgsBp4z5iJUBSo
SX1htmRH
=UJw4
-----END PGP SIGNATURE-----

--gim4wAE3pY14BULt--
