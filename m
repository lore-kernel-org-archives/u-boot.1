Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25ABC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A0C805E9;
	Mon, 13 Jan 2025 20:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4FvEakR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B3AD8060C; Mon, 13 Jan 2025 20:30:42 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9729805E7
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dd420f82e2so58891216d6.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736796638; x=1737401438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z+emRIP9uF5MNShwjrN/9BoXjIXj1VOCaVGU7U+Ctn8=;
 b=R4FvEakRYE+Wf+fuenQ+r08ZauyzI9nxoO/aZzXMxO9TGRr4NPYkDpavfnS6ZH7JTO
 qgVch+zXgeUkQRphkoM7ZozzmcNSCfiGltk6GAlg2sevDtAvT5Z6ztwX+XBy8vSa/sFg
 q/F3hL3jpab8zrgBjZ8MkR2D7yA6L2zOubamk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736796638; x=1737401438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+emRIP9uF5MNShwjrN/9BoXjIXj1VOCaVGU7U+Ctn8=;
 b=hfZWsINm4OD1HHTTppKWpjdOcinxY5Cqb6j3v+kCaDB2t6XzjyzspXdOtKZb2VmE8+
 SKQM8g1qpqD6Fk4u5iy6YsMo1bHxU8YZSuZYLRRjIFdyHmmqyz+NjpjCJcTc5+qa3gJX
 2vMeV2gU+taeJTp+JbtKcm6STWvg+Hm8rhTJn+U2x0xuTSkycXgf6G4LxXUiB0VGC4MW
 6aT2lHlL65cvlsOBhVIvUnX+PPQd78RKou/lheP3300Y51g57xq8tKyULioVY+O/2BcN
 DIio+w+qFMBj7QyV6on8dBwu7KP2a/RRzcH+iC4ToQJbgXezR2NPkbn4kdp8hzbsKFHF
 +5ig==
X-Gm-Message-State: AOJu0Yzm6brL2xwgZwDIMro/q27cqD4/5ikUr5YbUDcKfBKkHpu+rOsB
 ZCm6AjnjQxXVQHUX0Z/7FghvgC7WlxXTInq66zA4T0LM6c8lWYXYU8RXfGzO/Vc=
X-Gm-Gg: ASbGnctsUyqeuOtsY2uLmIAw0Bqa22WO2NP5jGAUuzg/fN6s51zglGDRjJD7GwE39Kk
 TbX9O0TZlSxYegCZZ3rppjGQ685ZJa8kby7QPp909MHwjkw0TySAxFz82XXJCt+dL2P73/wn2HU
 fTuEh8UCy2uVWhfd66HnMBevYPkITja/1qweO5jvrKDMuYV7pswaWV7tSrUu+vUCRQoPtnhL4Yt
 BsI7bAN4xJZtjvK45ZG28gYHw7hEfZoielXO2CXIqUo3pSD7x10g7Y=
X-Google-Smtp-Source: AGHT+IHwUB+IRNyj84GbmVf2JRyoeDmVpya0QSgu+76sKzRkESJSBIVKfgLnz2siddie4L6+r3Ysrg==
X-Received: by 2002:a05:6214:1d24:b0:6d8:821d:736e with SMTP id
 6a1803df08f44-6df9b28d3camr412242526d6.36.1736796638570; 
 Mon, 13 Jan 2025 11:30:38 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9b29f1sm44516296d6.67.2025.01.13.11.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 11:30:37 -0800 (PST)
Date: Mon, 13 Jan 2025 13:30:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [ANN / RFC] Regular community calls?
Message-ID: <20250113193035.GA3476@bill-the-cat>
References: <20250113183409.GY3476@bill-the-cat>
 <CAFLszTjDx3bBwgnvB2v6ow70a4-XS-fR5UHFdFQNn7Fdytba8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vNLNjCBg5DlWIfvW"
Content-Disposition: inline
In-Reply-To: <CAFLszTjDx3bBwgnvB2v6ow70a4-XS-fR5UHFdFQNn7Fdytba8w@mail.gmail.com>
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


--vNLNjCBg5DlWIfvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:10:35PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Jan 2025 at 11:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > Hey all,
> >
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
> So do you mean the first one will be in two weeks (i.e. Tues 28th January
> America/Europe, Wed for Asia?)

Yes, thanks for the clarification.

> Here are the running notes
> <https://docs.google.com/document/d/1YBOMsbM19uSFyoJWnt7-PsOLBaevzQUgV-hi=
R88a5-o/edit?tab=3Dt.0>
> from the previous series.

Meeting minutes are good, but perhaps we should send them out via email
so they're more accessible.

--=20
Tom

--vNLNjCBg5DlWIfvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFadsACgkQFHw5/5Y0
tyzoKQv/affQL7JrjMbHCxn4gWNtMcNiTPKehKVRHX8OJDEIdZIa3wdhEYQ5nVXW
vidYhSP/vU/VFACadKKK+q/mxiEIi3UFNj4trQgbX3i326Orta9wkstgnhhcgRUd
aYt0e4e+opWx3Bl8ZOmECZCfV+73Iq8uBJcVeF96y8m7kgRFGHlwmfolpRGURKV4
FKT4LogUWS9tQGWBu51dxnu4nargIuPA0lzOUzczy1YwRcxmr/i90v8Qtvjrhb3v
mhEgygy+FbKTdBFxxPLFsSOBspKhtO6PbkoO3/H3RvHr/9XhStjeQKwq0VqWfjsa
OboAvXV491FKguwiB1KZqar2e1u43l77WEad+JSyV2ISmZ0o6qDe8JSC8R1LHZNH
paibbXFdznN9kLqv7dUpkJSWWBxNhsIvPe4CCQh2lSuO9TVN8UPR+WUKXV+uGEkH
jbUaR4prtGdN8nuAE7sQkjKCOZnkOA+Alu9iNfxTqvI14EZ12Vk4bsHS1CAI+03n
uWaAUDE0
=+GHd
-----END PGP SIGNATURE-----

--vNLNjCBg5DlWIfvW--
