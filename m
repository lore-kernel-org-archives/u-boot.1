Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BC4CD4857
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 16:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D29D88754;
	Wed,  4 Sep 2024 18:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aYZyCva3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2144388B12; Wed,  4 Sep 2024 18:43:42 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3A0388381
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 18:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-45681098bbdso9143141cf.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725468219; x=1726073019; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l7C/V9u6TyheFoUexeEtTRZu/bqlr3XXEs8U8CTIKcg=;
 b=aYZyCva3RPbNEoxk5P0cYlg5gBIR9CHf4D61AfPuP4qnd8YDExhRmdx73SBdVBRARW
 olYoMd2JsKAiqglChyyKpGJGXqXmjMIz848XuCthOrqFWdIEOwiYekfjIyMa3VJpJ0e3
 O2pfHRgBSqCMAFp6aaS5gGmE5epq8MN7TzSbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725468219; x=1726073019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7C/V9u6TyheFoUexeEtTRZu/bqlr3XXEs8U8CTIKcg=;
 b=eIRcBpVJB7+u9vxgwTsBv/q8hOzj8H2+CxGyCv6Hkn8zIAoTmw2fKRyievHZOpp/ue
 Jbp56CIrecQpOKnzPpfWqpxSVzg5AGRXcgCVHbO6wO/5L2H/O880N2MK+4XFu8qJJn3D
 +xA+WqD1wHE08k5JT53h9mOpqu2Z1OgxOGbQq/NdBTXz/FFVab0Tt2rEYbjNeE+EwH7P
 uoLZcArzxbEBC00Z83BKyrnV53JCvGgxwbPIBOzXDTeO1jgZ5wNNSvPN9sWvsAhMJb5N
 9bM+KW52sJeIceEWCyYjnKOMLT8OPI8dylmRHYfd/10wjbMdhaZccMsjeYvB1yshWNHf
 /MQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcdhtmH1u8ChVo/T8/0kT6iuuJk5WI39VFQAcM7ounNsuoSSsaOAAyImaVCcxPWanLHHpMi0E=@lists.denx.de
X-Gm-Message-State: AOJu0Yw79pz18Nh7zPGZ1Lj51kiitkLjOPXch0JQpa5RKIKRGxcaVm1i
 QtkJ9c+0Vg/SdQvqos2c8RWSTd4NYCQfCvlGemtMkyfCUOku0GHasF2XqQpGsBg=
X-Google-Smtp-Source: AGHT+IFU5dmxNzVJ2t487UxgJWpIVEdub0mL8/URd2D9Bk+cXX4EowkokL9+SIXy+DtykB+JWx3roQ==
X-Received: by 2002:ac8:7585:0:b0:447:d963:ebbf with SMTP id
 d75a77b69052e-457f8c1079amr44203141cf.21.1725468218504; 
 Wed, 04 Sep 2024 09:43:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-457e1dfb1basm21409781cf.56.2024.09.04.09.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:43:37 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:43:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240904164332.GQ2479150@bill-the-cat>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
 <CALeDE9PqT54MH0riLFng3ONi=rtEa53LsxRgYcV1ENX=ikuV0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J7bKpa7rzjarnbLk"
Content-Disposition: inline
In-Reply-To: <CALeDE9PqT54MH0riLFng3ONi=rtEa53LsxRgYcV1ENX=ikuV0A@mail.gmail.com>
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


--J7bKpa7rzjarnbLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 01:48:43PM +0100, Peter Robinson wrote:
> Hi Simon,
>=20
> > I wonder if we could leave out the SHA stuff? The algorithms are
>=20
> One of the big advantages of the mbedtls when it comes to all things
> security is that it's seen a wide audit of it's code which for a lot
> of usecases is very useful from a security PoV, I'm not sure the
> amount of audit the U-Boot in project code has had, I'm sure there has
> been but I've not seen anything published.

Yes, it's a positive in my mind to bring in the assorted hashing
algorithms from mbedTLS here.

> > stable and this would seem to avoid much of the size growth, and all
> > the pain of trying to integrate another yet another hashing layer (we
> > already have normal, progressive and h/w acceleration, plus
>=20
> What's the difference between the first two?
>=20
> > UCLASS_HASH which h/w acceleration should use but that migration never
>=20
> How hard would it be for UCLASS_HASH to use the mbed hashing underneath?

This, long term, is what I would like to see figured out how to do.

> > happened). I struggle to see any benefit in replacing U-Boot's very
> > solid hashing infra with something else, particularly as this series
>=20
> I would need to look at the HW support in both U-Boot and mbedtls but
> given wider use of mbedtls I bet adding HW support there that U-Boot
> could utilise may be more apertising to most HW vendors as it means
> they only have to write one set of code and have it used much more
> widely.

We had some discussion in earlier iterations about HW acceleration for
the algorithms for mbedTLS and I thought this version of the series
exposed what was available when it's available (like the ARM crc32
instructions can be used, but not the full HW accelerators of some other
HW platforms) ?

> > adds yet another. Better to invest the time to refactor it. I asked
> > about this before and was told that it would happen 'later'. Let's
> > just not change it at all, then it is more likely someone will sort it
>=20
> What, like the HW support in UCLASS_HASH? Things clearly don't work like =
that.

Yes, I too am OK with figuring out what needs to be done here, if all
that much / anything really, honestly, afterwards. Maybe common/hash.c
needs to be split up, but "do something very clever to the hash_algo
table" sounds like something that could be a lot of effort for
questionable gains (and possibly some losses wrt code size).

> > Also, if MbedTLS is wanting to be a general library for TLS (I assume
> > transport-local security, not thread-local storage) perhaps it might
> > consider changing to non-Windows newlines, or perhaps even kernel code
> > style?
>=20
> I think the newlines might be a possible ask, they are generally
> receptive to change (they relicensed it to be a dual license
> compatible with U-Boot when asked), I don't think forcing a separate
> to the kernel project to a kernel code style is a fair request.

While it would be nice for newlines to change, I'm not sure it's
strictly needed? One of the first steps in the process is fixing those,
and I believe git handles subsequent re-merges fine. And yes, just like
other external code we aren't really in a position to demand (nor should
we, nor expect someone else to) rework their codebase.

--=20
Tom

--J7bKpa7rzjarnbLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYjjAACgkQFHw5/5Y0
tyxd+gv/YCbGws76eayneJ1Y8uzPpSqsxncwbO4moQpBghuTV+IkGvxGjAqyr4ni
LtuwQFkhAvkE5xcL2y1os4qphQDiFzDRMwrTYKQidUH7VvVoY2I5dI+MZcUB3oQM
TqIk4y1O4CqtDRw4WZ9uPhkXMHiFAGeWhcDHVwVnWhXEoOy81uQODn1OWdT3Uluf
ICc9eLcRhTsidnZ6mNeRLWvWKrcuKQBxl7wgL6vLRCbEIDNnyrRf/3FbP04hZSip
ITKdO4LurxlTMeUNe6eQ4L/BFgpFrwdZp+QKZbJ8LzuzIfgMOBs6weJsKIRrDsKr
hVTJ8ac9lExmQudZST6E29j+mGvtxyiHJmFeQmZT8VyBOGPGKThx+P1AwsZ+xuCP
q9HHFd0dtdjry0RxOeFrct9fNiQ3zdTh42VTjgGEcBpslB3cS5b+27UWGyYEJUj+
ErMOCru1Pie9MNnr4ggXpbw2SUFHMTQiFfuTB2CJD1M9UOhu7xfqtkBE545wPOBh
NpgpYGhd
=z0OU
-----END PGP SIGNATURE-----

--J7bKpa7rzjarnbLk--
