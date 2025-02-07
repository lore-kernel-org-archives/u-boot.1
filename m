Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0038C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 01:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2745801DE;
	Fri,  7 Feb 2025 02:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KNTBh0FS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA0C806FB; Fri,  7 Feb 2025 02:44:50 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4444F801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 02:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so1279364a91.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 17:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738892686; x=1739497486; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bo5PU2wh38JiQTfShxkzFZ2Pw1gySCWx73d/uZl2WjI=;
 b=KNTBh0FSwuw1xg3JGV7f9F26irV0+Pz8PCzK8uDywudspczozJDVw0M2BQKKCHyhCH
 eRPyBohmFIcnkL0WI6F2Ysa24DXB/jIbvO5vk7v2G2y+DpVMXp7hN1Eug1n0gADJv7PU
 dPQzW+v+15yQNJVpeOAyUUUrGVEwdxQbEatBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738892686; x=1739497486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bo5PU2wh38JiQTfShxkzFZ2Pw1gySCWx73d/uZl2WjI=;
 b=usqKy4Nr8l1k7CwKR5vic7wHnS6j6OSX0oTEI6BLI6h/E9PCCVhsEoJ5ufRR+umuMF
 0WGBA5tzaEyPQx20W3xc5sbEErPbAcv+m3wnjTEr/Vnjq4a7WgE8W6z1PZYk0RLNxIjd
 OZUAmRoH6vYmiTgbWYyenpgwTIX2uGgMiDqWRlaGiiVHxnTdbLUHr6tOt6eYX53At6KW
 tHFqx0EKzEPWM71ZZOxinJNiu4tSsijy77pr/izlnh0B0c4u58eekbVQfg+uk108lvZ/
 OTqIihYE5kR1efYDZIeu/tGwMLDx+msbAn1SmqkZZCnkjtHpL+tJBNsCAFau6tyfeXfx
 D/8g==
X-Gm-Message-State: AOJu0YwHHu6JyIP/+6xtgDIQxcgY+2umoH8u2pJiAhJZJ93K9IUZQlFO
 sY0RqZr90dteg26UqYR97IG7J1QJSKiB0SGCzoGzSRrWZgAE/9caK2qVA+8X+CA=
X-Gm-Gg: ASbGncu3qAdgFHbtCvkxvQckRwLS6nvCuUcZqgnCWG2ZedzT/kykHMMAdXxEqZw1BhR
 CovOrum5a5rS5MPtLRStmTgfbQ31QoYKokupIpUxDBzXRnbEfxT4YaIMMVjXi2ReauAipHc0HX0
 RYdKQk6QuRK2uCiLcLQAA+kcOIDhlJLFQiSP1Dw3YmK73b2ax5ikIhM4hdLjuAebnhsjhibcBiv
 rvt6ZDJkvjfOleYrOO7hRWMvkY65ZE1DUnL71gwFt5iFznAhCszkYLvKF8e/RM3nS+r26Lj6Rw4
 ADrEixDj7pzQ0y8=
X-Google-Smtp-Source: AGHT+IF/MtX7snOYTrffNKE59tifohyExbWYqQ1OU9Nt5Sm3gMaHoXqTnQAkYV5LtNCVhAeTJxA3Vg==
X-Received: by 2002:a05:6a00:148d:b0:725:ef4b:de28 with SMTP id
 d2e1a72fcca58-7305d4f021amr2475908b3a.17.1738892685768; 
 Thu, 06 Feb 2025 17:44:45 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51aecd387sm1972290a12.24.2025.02.06.17.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 17:44:45 -0800 (PST)
Date: Thu, 6 Feb 2025 19:44:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH 14/32] efi: Rename ImageBase to image_base
Message-ID: <20250207014442.GW1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-15-sjg@chromium.org>
 <20250203200902.GH1233568@bill-the-cat>
 <CAFLszTgR==OvRFb-FBF4OHfr9zAjM8mz9G6ts8Md7vNuv7oqkw@mail.gmail.com>
 <20250206232413.GQ1233568@bill-the-cat>
 <CAFLszTh92nrDzXcrDRL8za=MLYkpB3j-utPm3Sxs_jcw+dFGOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ieHVUdH+3y4oYb0I"
Content-Disposition: inline
In-Reply-To: <CAFLszTh92nrDzXcrDRL8za=MLYkpB3j-utPm3Sxs_jcw+dFGOw@mail.gmail.com>
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


--ieHVUdH+3y4oYb0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:49:55PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Feb 2025 at 16:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 02:27:30PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 10:42:07AM -0700, Simon Glass wrote:
> > > >
> > > > > It is confusing to have a camel-case indentifier in the link scri=
pts.
> > > > > Rename it to fit with U-Boot's snake-case style.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > This isn't the linker script, it's the crt0 file.
> > >
> > > Yes, it's referred to in the x86 linker scripts. Probably we should
> > > rationalise some of these names.
> > >
> > > > Given that this is intended to match up with
> > > > https://learn.microsoft.com/en-us/windows/win32/debug/pe-format (wh=
ich I
> > > > got from looking at the commit message on commit 216459d2cf36
> > > > ("efi_loader: correct SizeOfCode, SizeOfInitializedData") and
> > > > include/pe.h I don't think this is a good change. Heinrich?
> > >
> > > Well, pe.h is a file format so I don't believe we need to use the same
> > > code style. We had that discussion when the EFI code was coming in,
> > > and decided that it wasn't a good idea (as I recall).
> >
> > I really don't think our linker script for making a specific output type
> > should deviate from how the output type talks about things. Deviation is
> > confusing.
>=20
> Well in that case, it is pe.h that needs to change. The original file
> I brought in was there because I was planning to add ARM support at
> the time. As it turns out, the file isn't needed for arm64, so this
> series removes most of it. For 32-bit ARM, the file is not used at all
> (although Heinrich might correct me if sandbox on 32-bit ARM uses
> it?). See:
>=20
> arch/sandbox/lib/crt0_sandbox_efi.S

We likely shouldn't be so broadly including <pe.h> within EFI and I'll
defer to Heinrich on if changing include/pe.h to non-CamelCase will make
the users more or less clear.

--=20
Tom

--ieHVUdH+3y4oYb0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelZYoACgkQFHw5/5Y0
tyw5+wv/UBqgB6wbOEDK57VzQEMPZUVrkvpyFZmhKDGhDpnI4HdGbPlMhhl1E1Aa
1PhCyX8N44hllvEZY1ceNMm6W1QJ2ZGoW0HqgEBt2D3aq8cqnh/KJUVfn2SIOBWT
+Fz093jb6UALBOqpB60rTf8+0nB1PxFpsx8nXEPx9wbOKZMarhTYwEV5FEVjJ8eQ
2W74+BF2+yHzPGnbJdHXPB49J5YSO/BTh7zqwx3csyxBt8p0YY6YYmnsskhZExyk
DzAdsOT65Ms/9RXscjDLsRfRNXWir2gVFGsAbCaJpqKj9d9LWLKr0p3ifCrX8Dch
DJGtpB2VTe5FT2vdaDVqd+BeDtEXBuTP7Kw3wtRvvOugwDvAWnjk88rAugphrwkw
CPfGAWrJkda47wPGnXxrg5K+MNCPUQ7QljBJ9AdxJBBJNBVVhFQi9bVN1t1siBgo
RcsEbnjBl+NxYBoKm+LrBNmEfcBMENs79eXZn7UqrzSFoY0bRtmjuByx6WwYKs8c
n50Z4pAD
=r+sJ
-----END PGP SIGNATURE-----

--ieHVUdH+3y4oYb0I--
