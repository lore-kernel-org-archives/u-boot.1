Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B568CE7B12
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A335983F54;
	Fri, 14 Nov 2025 15:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="alU5INi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AE684101; Fri, 14 Nov 2025 15:24:05 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D5583EF2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e10d1477afso1349679fac.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763130242; x=1763735042; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4L5pg0IAV6NUeumRXP7mMEXqmsoEYUrxX6IuiVFhxpc=;
 b=alU5INi4j4cW1DpLpQFEPPogRg2C9JUakrjx/MX06UShjgyHwjv87MRQ32h48n0dAe
 atqwUXo9IZmIZB0ojXRt0uDuIUdVwlcoV7eEdK46g+YuQZ/exs25QTG7IHaLRY8821S1
 3sU/WaDxV7lqBmV5QDDI7EwspkIf7lkb9P6Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130242; x=1763735042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4L5pg0IAV6NUeumRXP7mMEXqmsoEYUrxX6IuiVFhxpc=;
 b=Ndzh2c2KK5kZBdwQFDEdsfpYUg1YA9aFSycj5FQ4dRpnjElmDOhOnRnp7nQlsn/Yoj
 jORTn30K/KGBz4+A5hCFXuJLwcD1/pen+zglmpdbm9HQgtsPOwThNvvGdCQP4LxxqGXm
 iSFDqT2Yjxaz0ZDOyCKE0DnVV/6z2JS5aIWCCdX1ViClYumdu64idIIGIFOZAitbg9Eh
 h7HsplDnaH6t64dqsf6+3v4HJ7t0GK1PAZ4aatsNYftwALziZEpy2nU08Gpyan73jlG4
 dmecDQxtPP6qY31RWPfwPYBJqhVT2ENlYBwkWmo7sth8PJj6Xj4UHZDOpe4fCd4nDBP/
 vcnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTZdNcQEVivbdjiuDbuiek+/VaWXdU5iYvaH/8XKm2Dil4l/a5XIRelEAOHyUdEylf0rC6ZRg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6ssHEKtEmgFBdAGh1kRimOJ1j4DCsnxOOYV+98+AbqoCyD+tN
 OUG31EimGBRz4+343/zYl6cqWowCqXWeoM223mrnLJ6un1mmRofpkoLgSglVPSnyjOM=
X-Gm-Gg: ASbGncutL3kmgxJlaXd3vrtobTnc+7wCtWFEw6pIma+tJjaIApB0wRFthDcYMyt2MqR
 TOb0rDopLF9qrEGHznnWuyea9u1yGh5eOa9mWNnNtgkU5TxemhXi80/6Cay8+0zYjC4QpQKEGBS
 6RuqnteqwtOSiWMJln7O35OPmIbXSbfBgQZ3iRfkHbqIuk7v5jjQNG6BU0onKLC8nCYDUySzEsA
 HQTpMRmmhqLQRQCV2lCSCrGOk+zvkxd/E9iCyvdVKjCUq7Q82agaxt3jzunkh4zrjU5EVdZ0Kr4
 m4+K24Ym+8tzSv2R7Dn5CB6TLReYJA0dDR8I0NXmikFxEzWMRVqFVmwfOaWbtXwCIJEA94SrTXC
 mA+N+/NJNCrez0atspKr1VtGvZIT7dLbikguDEA17nwXp6YCdh4Og5oAUbOqv/m9YzkCbi11oHk
 gLiK0TgSGKEjJfWHWRlsft5Ys4PeT4pSTZzDfEeS0=
X-Google-Smtp-Source: AGHT+IEy4VD4sSEELL78TBJ/eKZi67NdwsHYmr24JCQPAM9O6yZE3T2LCFICnNHQeN9Fy3i5iVnn5A==
X-Received: by 2002:a05:6870:9f09:b0:36c:59db:7559 with SMTP id
 586e51a60fabf-3e868ea0d0fmr1396492fac.17.1763130241891; 
 Fri, 14 Nov 2025 06:24:01 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522640casm2761601fac.15.2025.11.14.06.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:24:01 -0800 (PST)
Date: Fri, 14 Nov 2025 08:23:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
Message-ID: <20251114142359.GX6688@bill-the-cat>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2tyAUKHsNG/Qye6v"
Content-Disposition: inline
In-Reply-To: <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
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


--2tyAUKHsNG/Qye6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 05:45:32AM -0700, Simon Glass wrote:
> Hi Marek,
>=20
> On Thu, 13 Nov 2025 at 14:57, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 11/13/25 9:36 PM, Tom Rini wrote:
> >
> > Hello everyone,
> >
> > >>> Which is different from disagreeing with your specific feedback abo=
ut
> > >>> how we get there, to be clear.
> > >
> > > And again, since your feedback to this patch was "Don't?", I'm saying=
 we
> > > need to. But the rest of your feedback was structural on moving towar=
ds
> > > resolving it and so I assume Marek will respond.
> >
> > The "blast radius" are these patches, that's all that tripped the tests:
> >
> >   - boot: android: Always use 8-byte aligned DT with libfdt
> >   - test/py: android: Point fdt command to aligned addresses
> >   - test/py: Use aligned address for overlays in 'extension' test
> >   - sandbox: Fix DT compiler address warnings in sandbox DTs
> >   - sandbox: Fix DT compiler pin warnings in sandbox DTs
> >   - boot: Assure FDT is always at 8-byte aligned address
> >   - arm: qemu: Eliminate fdt_high and initrd_high misuse
> >   - efi_loader: Assure fitImage from capsule is used from 8-byte aligned
> > address
> >   - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> >
> > Regarding last minute alignment, the problem with this android image
> > seems to be in the android image itself, which packs in badly aligned
> > FDT. We therefore have to copy it out and realign.
>=20
> My request is to implement these checks as part of the boot flow
> (bootm, etc.) rather than adding memory allocations in leaf function.
> We already support copying the FDT to a different address so we can
> expand it and add things. Can we make use of that code?

There are likely some cases where we should do the check-and-move
elsewhere, but others such as MIPS where we shouldn't get it wrong to
start with. I believe we've had a few other patches that also fix the
other cases where we don't ensure correct alignment to start with, and
really must.

--=20
Tom

--2tyAUKHsNG/Qye6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRc7fgAKCRAr4qD1Cr/k
Cu5MAP9WioAXcedudXd58Gjh79M04FVuScpngMHJa2F0lAZpLgD+M3NRwNr/RK5s
qWkqkYeG7tnS4C0wHTeH3dMFifZuLAc=
=Ym2l
-----END PGP SIGNATURE-----

--2tyAUKHsNG/Qye6v--
