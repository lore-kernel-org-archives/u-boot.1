Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F16ECFC296
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA9983A41;
	Fri, 21 Nov 2025 18:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o6wMlqcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F0283A41; Fri, 21 Nov 2025 18:53:07 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F4683A84
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6cc44ff62so1514866a34.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763747581; x=1764352381; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nUwi5sJmlI6HbBFy/rTRBwl+GyUq8GNnFYxvwcexioE=;
 b=o6wMlqcdpyKs41lzlA/NaIJNmLy6suDNl6AdsLwERoA1dEG8ELyfUXAHpyTTsQTF06
 DgB9K8Ys+hOgCLpc6GmWlfpjniFuM/Y/sJMwOYqM+C9PwKH72smPpuINGOi2AEz2hKmT
 MXQADsHdHX9dYLENAoIrPelU9FJiqHdBsEefU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763747581; x=1764352381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUwi5sJmlI6HbBFy/rTRBwl+GyUq8GNnFYxvwcexioE=;
 b=mQhbaXnrDnM6V1HVURrNrblhuhegveNforrhbJWkXzfOHpqS2p+mwgrW0UnpWp1e7F
 HU5YjOaXElQ8jfmJcFzEGeS10xx+YLv74OQBOKqut1rUCLXtMAiDt1tu0JcRESZfUUez
 R8c1gXVHLSb/0bnuX9rj+vkZ5y2x0plO5tR/NAe8I+7o7Va6dUWKR7tZr6XD4ILmh8PV
 D1aUtStvVo+dy8fYWJQCUndTkvsiquIeqfN8DOYohf0RVg21NDR7utwfbFJeDpSbrLAo
 F6eHB/QOWXAFD4ZM1XTWDzOyRTP8g/ilZlLAm/GXIq2L6Mulkhg8hgPuUahK1so/FfiD
 Zwjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgypoHIiOSBxm1i+ilXB8+/s7TVWjHSwUGnCMGB69oGymsE71fOb1mWkR/WEFt/GpCEGmo0Ck=@lists.denx.de
X-Gm-Message-State: AOJu0YxPnI+IVqqejmg26fJmlKAS5m6fcCEdWGMHXvVX7zcVvToC6Zys
 U5L93XtiNlg796fzwHQ93MoEeR/Juk5DSvK7wHctmWWdXuE4RIupeZoXAYxMKMvd+w1FATvPLtU
 22+r6RiI=
X-Gm-Gg: ASbGncvkdcsPaYKP271cWwh6Z+q6XBunw8eDduUnGsuKh8kmy74w90N9jPMuhIdcMAY
 D7iwo8Zc6Vj2ZgupJ65TGWvmdBoPJNixNQNJBauie9/i54TS1FFPHyHWLOJ09eMUVhr9WOQWfsP
 SAAI/BDOAabxqDDGKgH3ozqNaYWxJ0CZ6KBVFL/AyxHmn3UyYKBI/zbTBRRgqSCPLV1gwv1WA0+
 FAVkLcpHqZWVqs9pzNG3UsZyIfaA90awi9n2hBmN37lERybTadO+6Fopl3f1Hscy9AO/GOuKCkI
 xy89ZzQCcVpaPIr0xWFIZ4xJmLYDI/J0fWCG2eJdCGj9c8DzTdrXnn5KIm845/pBni0NMZndYGY
 9Zr8kUv7zvVnYVIcC8AB1lrcnQMtFuR5uVUF61Otetnag6pzXs5RgsQjJuOM2DPlpLM/nsyPe3O
 i5c1UVe35uwLUVoYyRd5HNb+e27huBYrpPeSC6ZHKwp1KtI9ZBKA==
X-Google-Smtp-Source: AGHT+IFEIbiRka/EhcHyjIaReTIcUPtqfCApnQa7aAr3yaIbpwLlDFPbvWtJuPmQYogWZ81dJ3wzSw==
X-Received: by 2002:a05:6830:71a9:b0:7c5:3da7:e03d with SMTP id
 46e09a7af769-7c798b58be9mr1700755a34.7.1763747581586; 
 Fri, 21 Nov 2025 09:53:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d32cbd9sm2494878a34.11.2025.11.21.09.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:53:01 -0800 (PST)
Date: Fri, 21 Nov 2025 11:52:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Message-ID: <20251121175259.GB2125796@bill-the-cat>
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
 <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
 <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
 <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GBRCQXRc7gMC9JF1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
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


--GBRCQXRc7gMC9JF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 10:40:13AM -0700, Simon Glass wrote:
> Hi Marek,
>=20
> On Fri, 21 Nov 2025 at 10:34, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 11/21/25 5:20 PM, Simon Glass wrote:
> >
> > Hello Simon,
> >
> > >>> - create a new VALID_OFFSET assumption (split out from VALID_DTB)
> > >>> which checks offsets in fdt_next_tag()
> > >>>
> > >>> The latter might be best. It would likely be very cheap in terms of
> > >>> code size. In fact, I should have thought of this at the time.
> > >> Wouldn't it be better to not misuse libfdt ?
> > >
> > > It actually isn't a misuse. It is perfectly OK to pass an invalid
> > > offset and libfdt has defined behaviour in that case, absent any
> > > 'assumptions' we force.
> >
> > It actually isn't OK to pass in invalid offset if we compile FDT with
> > disabled tree validity checks.
>=20
> We are saying exactly the same thing, if you read both of the above :-)
>=20
> >
> > > Remember, in Linux these checks are enabled. We added the 'assume'
> > > thing to reduce code size. Here you have found a situation where it
> > > breaks stuff, so we should back off the assumption a bit.
> > U-Boot also has those checks enabled, SPL does not, and things break
> > when OF_PLATDATA is enabled and there is no valid node associated with
> > the udevice.
>=20
> Right, so add SPL_OF_LIBFDT_ASSUME_MASK for SPL and check the code
> size. If it is too much, add a new level FDT_ASSUME_EXISTS before
> FDT_ASSUME_SANE and use that for the necessary checks (there will only
> be a few, from my reading of the code).

We already have different mask values for each xPL and then full U-Boot.
It doesn't seem like there is a good reason to allow this behavior in
xPL is the problem.

--=20
Tom

--GBRCQXRc7gMC9JF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSCm9wAKCRAr4qD1Cr/k
CgxRAQCpCOXSkyR3OqR74PjDQ14Hjbrl+hupaJX5BE5kB86PzgD/QVIlr9COFW3g
4y0JLiTZqpIxDWAnuH/uwTfbDxvllwA=
=9NOe
-----END PGP SIGNATURE-----

--GBRCQXRc7gMC9JF1--
