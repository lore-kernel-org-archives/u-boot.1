Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EFFCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 12:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90AE86CA1;
	Thu, 12 Oct 2023 14:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fQuIihVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7D286E15; Thu, 12 Oct 2023 14:02:24 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E4186C78
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7c08b7744so10681347b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697112138; x=1697716938; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DUq9w8iTisDRitrxGwX10Qm5LAqFsqlyfOfNmkLPQNo=;
 b=fQuIihVfku3q6ZcMBVz4XI6R+sa4qJzXMwI9u2/THW9zlgFGJ998UemfSbWhOYpm2R
 qxst8Q9fDHeu8sLkSOImgAa9NCh7+olR52n9TSiw+kyNfWELZPuFshvk/637lU8w+uuG
 0/v7mmvqxYrAPAWsQ531iLkLS0G6ZYO+HvKLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697112138; x=1697716938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUq9w8iTisDRitrxGwX10Qm5LAqFsqlyfOfNmkLPQNo=;
 b=aWXgGsRq7+SeBUGX9LhfPn7nr2YzjJAcJwley7aOxAVOf0mlWbbBK8fSbUAgvLbuHe
 pQMmY1kXw1EFS/mDo0NDWQcsCxjrBv7xsVX8ps0Boxyob2qxNNBIAP/LHjU8FlenFG6B
 oRAyBpWKGOfy7NdZEkGgja7qmwrfGihncTJV7m3H+RfEiqefZ0IaPkxKlgkfkcs0/x7d
 DLtlQR5Yczgh7Pe8P4GKWNWHplpQM4/MgH5skdWO7dizOvaWKj/tdbsslEQkU7+fSy6M
 ZEd2bh62FGo4sQ8tHJJZs7J0DV1WfLvFSThmuNYtB3RATgk2hrTXCXPwFHB3CSZDq78V
 GWkA==
X-Gm-Message-State: AOJu0Yy1OsC9fo+A4vrygLQwE6wsV/qgQw+wyNmrWJAJ/BFw+s1BUvrj
 MgmTEgGuPwbKKESIm5AONbGeUA==
X-Google-Smtp-Source: AGHT+IEAHHOqk2sr8tpdLpgzYQkQTm5cKasZgtuH68fJ8BeEoznS+dqdcDpzih2OA6FlPz1JF29zfg==
X-Received: by 2002:a0d:cf42:0:b0:595:59f:28d7 with SMTP id
 r63-20020a0dcf42000000b00595059f28d7mr25414301ywd.48.1697112137611; 
 Thu, 12 Oct 2023 05:02:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a814e05000000b005a80102fe3bsm285677ywb.13.2023.10.12.05.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 05:02:16 -0700 (PDT)
Date: Thu, 12 Oct 2023 08:02:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Message-ID: <20231012120215.GK3119521@bill-the-cat>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
 <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SFpwfJIF/UKoa63D"
Content-Disposition: inline
In-Reply-To: <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
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


--SFpwfJIF/UKoa63D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 10:17:50PM -0400, Sean Anderson wrote:
> Hi Rasmus,
>=20
> On 10/11/23 15:07, Rasmus Villemoes wrote:
> > On 11/10/2023 20.37, Tom Rini wrote:
> > > On Thu, Sep 28, 2023 at 10:02:57AM +0200, Rasmus Villemoes wrote:
> > >=20
> > > > The man page correctly said that -B was ignored without -E, while t=
he
> > > > `mkimage -h` output suggested otherwise. Now that -B can actually be
> > > > used by itself, update the man page.
> > > >=20
> > > > While at it, also amend the `mkimage -h` line to mention the
> > > > connection with -E.
> > > >=20
> > > > The FDT header is a fixed 40 bytes, so its size cannot (and is not)
> > > > modified, while its alignment is a property of the address in RAM o=
ne
> > > > loads the FIT to, so not something mkimage can affect in any way. (=
In
> > > > the file itself, the header is of course at offset 0, which has all
> > > > possible alignments already.)
> > > >=20
> > > > Reported-by: Sean Anderson <seanga2@gmail.com>
> > > > Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >=20
> > > Applied to u-boot/master, thanks!
> > >=20
> >=20
> > Thanks, but I'm afraid that was premature.
> >=20
> > The original series which this was a fixup/followup for hasn't been
> > applied, and Sean had reservations. I'm leaving it to Simon or Tom or
> > whoever has final say to decide if they should eventually go in, but it
> > would probably be good to get a verdict soonish (it really shouldn't be
> > too controversial), and if it's a no, this should just be reverted.
>=20
> I was hoping you would respond to my most-recent email regarding this ser=
ies.
> In particular:
>=20
> | Why does mkimage have to do this? Can't you just use truncate or, in a
> | binman context, align-size?
>=20
> Presumably you have some reason for wanting this in mkimage rather than u=
sing
> existing tooling.

I think part of the fun of trying to figure out how to have the dtb in
u-boot be properly (8 byte) aligned was that existing command wise,
something portable is tricky?

--=20
Tom

--SFpwfJIF/UKoa63D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUn4EMACgkQFHw5/5Y0
tyyATwv/ejF89I4TDYRt/42LAj8tAUI0tMJhNljvYYkD00C7FNKxfNs2YidDeLrI
9jBxoqEXdCVZ/Eh4QrbTI0ED0q1oS58pFf2xhlbhP9CgGUsX37lJMBQXNevMH9gh
pAHudyzszPBIQtQNMUtv5h34dIoBQweY2rskVX2SdTSJQguKg4zcncP3HDtgkGun
6ro1+CZVto2MTBvlXBchCNMw1hU7YyG8JlNxpMD2D9vUlgDYzoIClVjhU9yTFonq
Sq/HpFQOxN+my4IxnSEw3SGjS2/ZCvPWAheX18coYlceqcgi3d+U67hUfg6FJtQ3
id3j50vsTi5JrvR0f1ybEr49t4K5LoqQOcjGpLUo1JaUh+hf08wENdINjWdK7x/E
jZC4kgkmKxqmTgvDdDxJ7nuT6iroNFn9LDUY0yHLgEhtj2P+vJ3WS7R5paH60TDX
1JuBZ113Ch2U+EEA6vHBNXCZRxiu+pOMi4KA9Qhr5BOtsdxZ6ZbbwAt2QNHs0B3P
Ha6cigMf
=UCG3
-----END PGP SIGNATURE-----

--SFpwfJIF/UKoa63D--
