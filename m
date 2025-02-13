Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B082DC021A4
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 19:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79EA80F6A;
	Thu, 13 Feb 2025 20:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iuRgtdIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41BE80F62; Thu, 13 Feb 2025 20:39:01 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9F580EBD
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 20:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e589c258663so1538236276.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739475538; x=1740080338; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X3Vvjrmg9X1tTmidC5PUiIDGmoJ9AaLRABRb4bt6Ppc=;
 b=iuRgtdIVdFWqMVHGysduIaVizDbDbM7f/bqN8CAvxVV0KII5mmfSJt2zbptS0bWMWt
 4jafI0KSMBN/LKRATZJbDInJ58KjrzKWpDsMFcWGbbhyyMtunDcipgkvif7oy6vP704x
 VP1ucNpPikQdd7zTn0gyb7rpwB/eMBVnYPI2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739475538; x=1740080338;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X3Vvjrmg9X1tTmidC5PUiIDGmoJ9AaLRABRb4bt6Ppc=;
 b=uIc/U23IUp1lFl8nKKbp5glEaVMAUePGiCVBqgPQCuylkPL7A+enFZ2V+gC1UjyWpi
 ul6gW/BiYOpqaZuZWRZ7lIvwl6AJe+SF/z5cW8KJ4UdSydxWsDC9T4T+Ulaq/A/yocNI
 pPteUbRvpj5Jd7im+C45cYQF6EKn26S1MFpFSfWiFhJLXsSL3b9OMPXlAlwYH6TFBsEZ
 gsy0hepo45UxU75Hd2NZxXtWabOils8UigN0j6gdNZdsxEHFfFQw6O/5A6a1qwzUL86q
 jl6bPWDm/RRUehO5PTZEveqzl38/Fm0LZvwQIJbkRvSITad0vJTc0zssbYRsMQH0ayqb
 zdtQ==
X-Gm-Message-State: AOJu0YzM/LWdBqttKQ4YIJnLjUfYAJfpHTzkzKZez5GzodOm0lX2tXPh
 09NiAX0nAFQiSmBSBeAU0SWSp3bycFdR//U0hsS4dFfcm0Z6oo4KAri4+ibGMG0DJQMm8vvVEz0
 D
X-Gm-Gg: ASbGncsNw/06rF66cGqA22qo+cWQWKsROMZv+zf05Z2VWAE2g+yzFRIdjDbBYvz6/UB
 f+cGyW5WL7Tch5/ud8BJo1ItPo4xBHCtUcmte/A3B0mfGiUpqJQXBpvJwVlCUIVY/0o18u3PakD
 BP2gIxG6QCZPEHfl9o4PGbk/blJM0E0awp4DuVRgwKKU1y4/IOmFlWih2l8kTu+zCPmn/IEzz/2
 FHoFl7CdannZrl/WPKsscLE7ujykXRWpdy1wqygZPUcIcUlg07ArFUYrL7Q68jRhc8YVbbmbXgM
 OUjFclzbt45+W/M=
X-Google-Smtp-Source: AGHT+IGIxtck+JLgjELBJvgRJ4FneUQBn1hCaRFvv/97v6M2FFu9ZxTsSYtLhTTXLvo63/0bLinRLQ==
X-Received: by 2002:a05:6902:1618:b0:e5b:3de2:cead with SMTP id
 3f1490d57ef6-e5d9f179f21mr9288339276.34.1739475537972; 
 Thu, 13 Feb 2025 11:38:57 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5dadec6f3asm568735276.27.2025.02.13.11.38.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 11:38:57 -0800 (PST)
Date: Thu, 13 Feb 2025 13:38:54 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [ANN] Adding contributor repositories
Message-ID: <20250213193854.GZ1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="egsxUCkIJJPaAw4L"
Content-Disposition: inline
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


--egsxUCkIJJPaAw4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I've just now created https://source.denx.de/u-boot/contributors with
the intention of letting active members of the community who are not
also directly a custodian of an area have access to the Gitlab CI.

This is useful in that:
- It's faster than Azure triggered pull requests as the queue is not
  shared.
- It's faster than personal Azure builds as the underlying build
  machines are faster.
- It allows triggering tests on platforms in Simon's lab.
- It optionally allows someone to add their own machine(s) to their CI
  builds, to further speed them up while still being reproducible
  results.

To get started, if you would like a repository here, make sure to sign
up for an account on https://source.denx.de/ (and follow the
instructions carefully) and then send me an email off-list and we'll get
things setup.

--=20
Tom

--egsxUCkIJJPaAw4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeuSkcACgkQFHw5/5Y0
tywtogv9FL4uq+ihV7ROr3yuuUvvzDa9NbpTIljqCEr2OBEJnRrl0LHYnPap7Ute
I0ON0qXPMy99kigQ7yxK5iQyXjqnb8heUmF4c8MeVO822vINScSqCFXZKUrm5stV
c8YVxMhhwlTrRgssk/RUFJGTYkkvnM6XCvVupYqtNNBAAsi4hW8xcBvgVyHx59+v
rPayEiSncBIxsuft1T+hHasHt1BOY1qprsQ1v9CFAeJXei7Ms7dTZpnkGFJ4bIN0
SbvW1BkR1m/AmzawhTxXvZRO20YShc9F+bN7lCnq+IvJHyZVsPjnxgquMi1sR1SS
QJ9QX2z3ghCXw2PrqGJtbh0zs9H6Ps8PkQSGqxNXXvzr7zv4vJrWCV8aEJk2nQVc
7E/inCnNH9Kbr1by/uckGLH6KIGsUhH7Dky9Zc6K3m/6xdytHYAVFZBpNQM5b3ho
avQe0huuPpiqNvXxrT+CYBNvK7FpcYnB9hFvoKagEa5b+DHI4X9SWyEheQue/zXi
nXendrJF
=nJRa
-----END PGP SIGNATURE-----

--egsxUCkIJJPaAw4L--
