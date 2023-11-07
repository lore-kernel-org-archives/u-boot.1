Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48E2C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 13:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B30C87033;
	Tue,  7 Nov 2023 14:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mm+5bXLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76E186F44; Tue,  7 Nov 2023 14:05:03 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC758715E
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-586940ee5a5so2848481eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 05:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699362293; x=1699967093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sIR05KCGICqUu2frHgna+uAZ9hhauRbIb926ZlOeR4E=;
 b=mm+5bXLtrlcbn82+xin5zwSYjfeWzzKUoEP8qAE8iU6lHGWbiUclFzc1tUjpr9MCCT
 w7Zq3JVpAAn9A80wPxBjHECLKIkWLW8WgJsQqlbMbPEASebSZpr78M4lD0whhI20YTca
 xOi+4Ya1tqqXd5UVB/wdB1RxS3c1fAkkdNtYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699362293; x=1699967093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIR05KCGICqUu2frHgna+uAZ9hhauRbIb926ZlOeR4E=;
 b=QUEIrwoe/RGlxA5gDkR/OfmH3lr8qazCLbp2KzvOsBInjPjcZHaHZJ2GAGFmh9GDws
 dLLAd/Nk3NtXY/X8b6Qlnsp6LG2gvcdRTTZw5N+4nDpzdeYFZCR6TsNr1Uf4izkHIhh5
 sn3Jv0Hg8TOO5kxUuhQmt/+QoMT5DDuOzSuXh/zb1wVHCviRoPDbxa2UBm6vJcB9FyEx
 H2Cv+Zy1gQdVAzq+hVfcqtpFGGgyeaRbBqG9zDf51ez2z3P6WqKSduiamDtbsRtKhlF/
 RwTvR4FsQqoV/lNyOYPRiABUwY0hz0DhpoeVIfpgXhqL83p09EYHQKfs32mc0YXI5SIA
 Ykag==
X-Gm-Message-State: AOJu0YxvTLy8QnakhoeZRxWPkgxoisW2Xfa4SnWbuQp5kWVoEqmgvRfO
 XDM/zZe94EM/lHKvUGCOhgKWaw==
X-Google-Smtp-Source: AGHT+IHfSuaK9NV9CWQYl5+9nHGPd5fs7dusyOGig1QBZcMc80RQqEe8qQgOUp3L4C/3zp3ewYlHTQ==
X-Received: by 2002:a05:6358:528b:b0:169:a186:dc7e with SMTP id
 g11-20020a056358528b00b00169a186dc7emr23440664rwa.12.1699362293460; 
 Tue, 07 Nov 2023 05:04:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a0cefd2000000b0066d1bae2326sm4357877qvt.57.2023.11.07.05.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 05:04:52 -0800 (PST)
Date: Tue, 7 Nov 2023 08:04:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
Message-ID: <20231107130450.GA6601@bill-the-cat>
References: <20231105200453.1887418-1-sjg@chromium.org>
 <7a1345b9-8844-48e9-a1b5-8c7508cefeb1@prevas.dk>
 <CAPnjgZ1BbpM_Ksr5aKg2zWLv1FPy-N_Kz6fbrkZoh=i7LfpMUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iq+nhj81PHefSVKn"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1BbpM_Ksr5aKg2zWLv1FPy-N_Kz6fbrkZoh=i7LfpMUA@mail.gmail.com>
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


--iq+nhj81PHefSVKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:23:05AM -0700, Simon Glass wrote:
> Hi Rasmus,
>=20
> On Tue, 7 Nov 2023 at 02:56, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
> >
> > On 05/11/2023 21.03, Simon Glass wrote:
> > > This little series corrects a problem I noticed with arm64 images,
> > > where the kernel is not recognised:
> >
> > The $subject is misleading, bootm works just fine with compressed arm64
> > images, with the type set to "kernel".
> >
> > >         Type:         Kernel Image (no loading done)
> > >         Compression:  gzip compressed
> >
> > Isn't that a non-sensical combination to begin with? Decompressing the
> > Image.gz kernel image to any location (however you determine that
> > destination) _is_ loading it.
>=20
> Yes, I agree.
>=20
> >
> > If you want XIP, obviously the image must be uncompressed in the FIT. I
> > don't understand what you're trying to do here.
>=20
> Hmmm, I think I have just got confused about all of this, perhaps
> because ChromeOS uses kernel_noload with compression. Is that an
> invalid combination?

Yes, that sounds like an invalid combination.

> But then how does loading actually work? We don't want to put the load
> address in the FIT, since we don't know what it is...we want to use
> the address provided by the board. Which is kernel_noload...so how
> should this be implemented?

What do you mean, provided by the board? With kernel_noload we XIP the
payload, because the board provided (by loading us to) a safe place to
execute whatevers in there. In the olden days, that would mean (almost
certainly) the zImage which in turn was already compressed and
self-relocating. I know technically one could use the raw vmlinux
instead. With the Linux Kernel and ARCH=3Darm64 (and a few other arches
now too), they dropped the self-decompression part and the whole payload
must be decompressed. We handle this case in "booti" today by having to
have the board (via environment) say where to decompress to (and how
much space is available). Then we move it back to where we started from,
which is likely not necessary.

Looking at
https://www.kernel.org/doc/html/latest/arch/arm64/booting.html and
https://www.kernel.org/doc/html/latest/riscv/boot-image-header.html
stating "we're just like arm64" we can do better than we do today for
this format of OS image. If aren't compressed, we only need to ensure
that we are correctly aligned and move (and tell the user) if not. We
can even put the 2MB check under some legacy kernel CONFIG option (3.17
is over 9 years old). With respect to automatic decompression, if we
don't have something telling us where a buffer is and we can't pull from
the environment, we should tell the user and stop?

--=20
Tom

--iq+nhj81PHefSVKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKNe8ACgkQFHw5/5Y0
tyxKwAv8CFpLSo8sBU/kewa6uCKxQvJG3dEfLYEU+vsYKgHMdKCIXBI5NbN6TpNb
2kPOMzxHVcY9csjyy1P6OOd4/Sc4lk6JlU72iVIuqnNA9judd7iKPAwfHD27hnjR
7AZ//je3JmAc5HKjQwMZBMWzwbMv60MQlZG5qJPvllbsWdPjN5jjABg/SwS2rKvi
VZxzALmBLDroZ3OYeFPgcwLvZv5gb9q2mkzRUUZYc0ekdbgQjyQCjm6QrgKEFRPZ
U8yxExd9fwIxKN1jV3UmYiorNnXwX2SmH7mAsU5pC9EZQDBLnrjtDlbMGAp1e1vl
RimYd35UPKRerSnzFVKFIUAaUvr2WeQ0273TL2fcYgQPzoKO9CNqb11DSYvxFxLf
+H+FIz4J1BZiIOW2SuhqIcGvNwOpG36b2EaFc3mU9IB1AEz3Kq93AFd0cJ3P3Kvx
Ta49cH8UehMF0Iz+LgOuZp2diR9d2R+uXC+eynZ2ScJ7HYH/5sroRWx+SLbu8gQ1
H62ZCw5v
=SAh6
-----END PGP SIGNATURE-----

--iq+nhj81PHefSVKn--
