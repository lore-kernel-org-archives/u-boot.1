Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816A2C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2290980C6F;
	Thu,  6 Feb 2025 18:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fT19UCJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C614280C77; Thu,  6 Feb 2025 18:10:52 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8226F80C66
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so19296835ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738861849; x=1739466649; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XhoLb/Y27ddqZbNRDhHV65lJEv6yI7vfEQoxnJ7Rou8=;
 b=fT19UCJP5lHA4I1apGCwjQfP3uCkKhV/J5wfQSzwWh1yBgPj4vr0nphzR2jdKe6Rho
 Nr4o+LDDpWxreaKpRYYkGLNfAFgsn1OyUecQOZlrQdBktEMk8OVyLTUATHsjLCesNJkw
 oLZl7shCwIsSgAd3jwge26l/haAR6+uYhx6Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738861849; x=1739466649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhoLb/Y27ddqZbNRDhHV65lJEv6yI7vfEQoxnJ7Rou8=;
 b=sQ0CAPMhHGiy1KTJ2dD8GRhNOWvV4fokvE1iQKSg+7M1nbJnZKWQzIk6ozqxCw9V8Q
 Ajzz7Jd0heTFDigSifGM7ER69/pVmuKnRXrcve2dVPXRjXkXRln+bVgiGzS86ExeKB4c
 2AxUyZb+WSXIepXV/FQQYZdPYuxZqqz1ot9NOLCTldN0dOJRioLYvjDour4FdulV6GZs
 uZHy5rDOTFGQUSI2gfrDWp7I2znW7P548pX6JdS9S9ZsYNyiCEJo2BMbBevAh0RixTmI
 wznNsmASCDHAIk4+Mr1u6Jt0c9+wxViAaLHRa/60rbBoo4/6BQ24mCOrmRI95+9clVH2
 iopA==
X-Gm-Message-State: AOJu0Yy9RZD9fl7tW3RtZP/kX5Mx8mStD8X8GNoTZdhzJMiNbiQQF7e7
 f/+bSHW0LKP4bWvQ/OoBzk35fHkjBDysymKV6ZQea8N51JvMCwK5lv6KbUw6Gi0=
X-Gm-Gg: ASbGnctdj9L0hKHMPu6K3ks97hUT2rKbxItHmtz4D48czeMq0KQ/oivEHI+7yNgJdsY
 3vc/rThUj8P/CdbhJ3lmqxeDu9atcIeNmXTvYCSCoLJzecv+c9w273rpHrYPZFRGQCQGmmfPhK8
 ca5ge3yl2uOqIlRUtghfSm7d055vcYKXclof6fIzzSZb7FwhyR0C8L6HxsERUERcleMXoN8ebTF
 tJNEzug5x9YaAmLZvoFqcdzcBy7QglMdDzsn5gN+m97Y4h4NIdm0xCKFMjae+Q7J5qqc8iauKoR
 qez9OiZmcB7I8Hg=
X-Google-Smtp-Source: AGHT+IHhSG3V+ojsmBkStCnKDNvqHJZCsKr6iIsUKl8So0i+E7uiQpTUZnl/QOUHfPv7SK0pbQge2w==
X-Received: by 2002:a05:6a00:1806:b0:725:ab14:6249 with SMTP id
 d2e1a72fcca58-7305d4170e0mr19780b3a.2.1738861849018; 
 Thu, 06 Feb 2025 09:10:49 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048a9d282sm1537102b3a.6.2025.02.06.09.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:10:48 -0800 (PST)
Date: Thu, 6 Feb 2025 11:10:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 01/32] Convert build-efi script to Python
Message-ID: <20250206171045.GJ1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-2-sjg@chromium.org>
 <20250203200744.GZ1233568@bill-the-cat>
 <CAFLszTh0JYdCy8SYOkbnhGZB-cbtcYeZiqoHp0R-VF4Nn9rbsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j9jiFbnh/oOpbrEe"
Content-Disposition: inline
In-Reply-To: <CAFLszTh0JYdCy8SYOkbnhGZB-cbtcYeZiqoHp0R-VF4Nn9rbsA@mail.gmail.com>
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


--j9jiFbnh/oOpbrEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 06:05:36AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 13:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 10:41:54AM -0700, Simon Glass wrote:
> >
> > > Before this gets any longer, convert it to Python so it is easier to
> > > maintain.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  MAINTAINERS                        |   2 +-
> > >  doc/develop/uefi/u-boot_on_efi.rst |   4 +-
> > >  scripts/build-efi.py               | 258 +++++++++++++++++++++++++++=
++
> > >  scripts/build-efi.sh               | 207 -----------------------
> > >  4 files changed, 261 insertions(+), 210 deletions(-)
> > >  create mode 100755 scripts/build-efi.py
> > >  delete mode 100755 scripts/build-efi.sh
> >
> > This should just go live in the u-boot-extras repository as another
> > sample script. And as a bonus, there you can just push the script right
> > now.
>=20
> But I can't be sure it will stay that way. In any case I see these
> scripts as first-class citizens, in the docs, tested in CI, used by
> people to report bugs, updated as new features appear, etc.

Yup, I still think that's the wrong way of looking at it. It's a sample
script on how to use this for QEMU which means it's useful as a debug
and development aid. It's bad for CI since if we want to deal with "CI
is slow" we need to pre-create test disk images, not do that on the fly.
And you've got sudo and various external blobs being used. No, it does
not belong in the main repository and I'm sorry I missed it the first
time.

And converting this to python is even worse as we have yet another tool
that should have a proper requirements.txt file and keeping that up to
date. And then oh, the inevitable "here's a security issue in U-Boot!"
(by which they mean an issue in a support script and not what's deployed
and used).

So please, lets just move this to the extras repository, and point to
*that* in our docs enough that it's clear that we have tooling that can
be useful in some cases there.

--=20
Tom

--j9jiFbnh/oOpbrEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmek7RUACgkQFHw5/5Y0
tyzJFgv/Q6vbH/Zv5r+GVNZSQgbheLmZIZvfGl/ghrEY6ObhaTAJUlDSxM3PLzzr
BUmx8p0r0kaE27VakOwUvEO0pO6SIvp+yG8xnY2X+1T6tFMDLKdD0xgzKb9PT+2O
2qAG/qu/dbql2lweyMn0OIJnEtkq+U606jBYRCgwNM5q7W5/bb5NQtGh+LGapD78
5xdlLPW99WI5+I339wDQZgnIYz4557n6OkrLgYNp/WPhHbik1tVsv5bF37dhOmnO
2Y2fdOyOmebi9oPiqK82Qk43VqUl6kta7V+3jAP8Sxw1bKRQCpsI787OCoSK7MgP
Qh9xgAK5/JAgAOaldu1Mkg67b77b0vYfH+jOCul+u2kzmi1f7Ciq+m+o8qGx2MfD
h0iY+I2AR7WANKhO9jGZfglDWCsfr0veRVnkjIf9WGuoOqsyP3RK3zq20HZcYsE5
7/EHVeGoN7wEtj4zmRNnqS2kk02LM02f8Btwx97gF6uTu+PxQzjBmTrP0wWAcBDm
orhESF6H
=0yxp
-----END PGP SIGNATURE-----

--j9jiFbnh/oOpbrEe--
