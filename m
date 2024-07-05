Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C461CC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB42889DF;
	Sat,  6 Jul 2024 00:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IOk6/uCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BC7889DC; Sat,  6 Jul 2024 00:39:51 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF6688630
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c9cc66c649so1037948b6e.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219188; x=1720823988; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4asD8coOo5Qwq5GXoaxsc0fohB1vmo+aCy1GCDx0wmQ=;
 b=IOk6/uCdL/oTuF7ugRqiHNF3fEwjNPEbvNfUpuIJyrWdEw+uR/7baNLBRuh0k1bs8M
 GP7a3yBOlE8BYue9CmRfxooVZnltr0lgHcGu1orggUVEBqx2RtDjs+UGkX6prJF6BKYA
 TrqxF5cpQ4QVkRofnjQNesFsp6y/l22A8vScQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219188; x=1720823988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4asD8coOo5Qwq5GXoaxsc0fohB1vmo+aCy1GCDx0wmQ=;
 b=gcpq+glJsJVmcyY2sVFAIS9eyu/6AAYruxkvROJoO0vA7x5Wf6WcGD3kvQWPwc0MZ2
 8dbmuPf+gU2qrJQbvuy7yV48W2Ru0HtF4zy+h13L4qI6wJhvW7AAFY72FqxR1sDOLdmI
 +r9ZepO7ZZIQjE0i730+JOcVpCa6T3Su2rpW27KkyoBqDInOs66/4L276ZrxrPMkymDP
 tigOHq1Ixjz47xOd/UkWtwu2e8nGoiQru4FhnfaoED1gaGc/XdVf001XAFHr8ein5yPN
 TXBk8VwG0/indJHmrV1SkKXWR8YBzQ+iQgL5q6kgsamLyZFMkDqsyEiezUL4RnQyD4IA
 bl5Q==
X-Gm-Message-State: AOJu0Yy3J3j6CIUIPVECEdR8miSLRbjSl3yEifkyeJJ2atJ12DAAdlsI
 UBddKQrAYcbKyjLlkoHOD/TmNgWTqJWYJ7uYDbYSExXqJZoFtDds4Z/CmTE3ENwFjal2rfwJY0S
 gLKDPQg==
X-Google-Smtp-Source: AGHT+IFdhqI8+injG5WJ+aHFp2Yw44saNyJSdIlbFxQleAeK+0ewHZmZVG8Ihjb+zxbuPCkF1/Lpsg==
X-Received: by 2002:a05:6808:14d1:b0:3d5:630e:7b6f with SMTP id
 5614622812f47-3d914c4b11fmr6458763b6e.10.1720219187673; 
 Fri, 05 Jul 2024 15:39:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62fb48ab1sm2824474b6e.54.2024.07.05.15.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:39:47 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:39:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, d.schultz@phytec.de
Subject: Re: [PATCH] doc: board: phytec: phycore-am6: Describe UART based boot
Message-ID: <20240705223945.GU38804@bill-the-cat>
References: <20240620120554.2640307-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MbPVzQR0OT8JDZDl"
Content-Disposition: inline
In-Reply-To: <20240620120554.2640307-1-w.egorov@phytec.de>
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


--MbPVzQR0OT8JDZDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 02:05:54PM +0200, Wadim Egorov wrote:

> Describe how to boot via UART.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

Applied to u-boot/master, thanks!

--=20
Tom

--MbPVzQR0OT8JDZDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdjEACgkQFHw5/5Y0
tyyzowv/VNUcWsZZ/zeR2SWujQ3D7ty/VmuEdoLwmZmw+1OJZ7/xeg0HnAlGa3Lu
Nrq8O2MHRdn4fAjk7A/2sBTChJ57vIb6zWZFOdYtN4PUYLWI1/ilPS4sJXOBFN1i
F6WlR/rGgogaOvZCrneKjIg3s0YG76DB498iNeIFay/YVN5gvX7Wf+HiM/kEY9HD
AuDML2s1NQISn8fRZPs9nUNncnOMUHSXKHukajSX0MZWdynMC+GMN2NAyyhiBI9m
cphT3ylbx92rRgw8eSGhNcuMUH6toIUxTWP5c5BD9wXbaKQNu7/T8pzYw6OH7vky
9g5wjrhw6n5tQyI6j4uF/B0BUGErrq0cP3pJYS5jZfYh3JWh7Lv+VsrbXKzmHPJN
xjL6soEL3cUoHQVmO/+0zIynZSBxKqGDwNHQXKrWEB+SvJjWG4ndahXEgRIPQcem
/rplQva63Ij0o+Dx0UoyGSl7pB6w/U6Dt1MieRkKP4kx8IAk0Xb799Ja+44gzCV/
5j4T1wg0
=/96z
-----END PGP SIGNATURE-----

--MbPVzQR0OT8JDZDl--
