Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1302BC35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E18E81DDF;
	Fri, 14 Mar 2025 15:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L+S2oZfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A260981DED; Fri, 14 Mar 2025 15:54:22 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E8581D6C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c3c4ff7d31so280221585a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741964059; x=1742568859; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lFe33un/omqbqaVNKcm9czMPh/9yLSYLU4UDWPTvzKg=;
 b=L+S2oZfsoSiHLcY3D08YF8uPjFg61XY4X/gDaVgfPyFoIoULElHATEOrpPYRhnQKIY
 1/xQS2xqYO5w64fyCY8Zg/veUezQ7svkFBqh8qU1A2Qwwup/UMvq+jli6G+8n4WJffHY
 B3hv0UOT0Hv7in1bxVK5nqnhqF1i4tyKYNvSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741964059; x=1742568859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFe33un/omqbqaVNKcm9czMPh/9yLSYLU4UDWPTvzKg=;
 b=AWscYq0tw2bQZoyiJeMbcevWIQIlIegtzsJ366ZZ3Mu2Cj3sH4aUyD2IC8YSXlcQNx
 p4N6lV0dIisFBg8WPK1hVVBod1TJpE9iN2z8uNbZ3hzPWKjFVGe4o5flHBrCwSYqVZcX
 33JX/BBLOvMxVL33RMik9kgdQl+mafARKjalCHEExaWPkvEebuMHutuMux2GCZIXsW7J
 wvuRsi4anLu3aSR5pQl3nIrioWt+1rmZ9Rv3iiWCAH4j1vHS1LcxCLXRfzZrBE53eco0
 J2p07/dYBUJMppEfI1DH41yNUQv89IhJOW8wpuqjI5+Vmau9DXpeZa88PV23ZJoQ/Cr1
 rWVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmj+D6Z9L2VnvbfWr4MNaavxHXb//JGyKBi/E0iXny4P1OARnj7wNzTV3/XqyjWQ/Ce7Zc7z8=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ7N7FL2F4DpllqFusNITFyer3EQMRCfYPMVCvylgH2b6eaQ5V
 SKj3ypNPpdQ8fRIIj4fnBSZNe7wcTdI0i5/9qLyzfyj6jR+bfxaDpLn5RKESaJ0=
X-Gm-Gg: ASbGncsybSUJkScKPlywbSemegoj55jyPyKf93WLxvMElw+g/om5y8E8PMHPct9zloT
 uwZf/4qcFe6lDAFYsGHVULPypIOAOdMkcl5LJ8ICFb33Xzqe9T7PShST+gZknioX//6nTKR0W5P
 X/9faFyDigxz3L9Rhn82IWG8B//ZbliTfp2erUgmlzWR0hQyi4nFHtP0VJG4QmiMMyLVZ2rMEQJ
 wSwANA0uaeZJL0tB4wPWSLz9cSH7XLNIIXNy6Qp7SPcSarjB+DX/8YmrUzhm6RD3uQIIP+vLa6F
 GRBpKtieQs/UkNPGjwnuEsPlXO2xkNhxRE8B/q/TqnDvNA==
X-Google-Smtp-Source: AGHT+IGnADMqh7wLn5fXJgVq6nByeBOL7X5JHZS1WlfvwaIB4NdcS0Sv2vVkBvlGKVqab2T4kdmk5A==
X-Received: by 2002:a05:620a:4384:b0:7c5:5d32:2612 with SMTP id
 af79cd13be357-7c57c928ceemr412449985a.58.1741964059322; 
 Fri, 14 Mar 2025 07:54:19 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d9256asm260894385a.106.2025.03.14.07.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:54:18 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:54:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: tkuw584924@gmail.com, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut@mailbox.org>, jagan@amarulasolutions.com,
 vigneshr@ti.com, pratyush@kernel.org, ashok.reddy.soma@amd.com,
 venkatesh.abbarapu@amd.com, Hiroyuki.Saito2@infineon.com,
 Shinsuke.Okada@infineon.com, Daisuke.Nakata@infineon.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor-core: Rework spansion_sr_ready() for
 parallel memories support
Message-ID: <20250314145415.GP2640854@bill-the-cat>
References: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
 <39ff6a5876f739f27aae4121f0669545def4aafe.1741930961.git.Takahiro.Kuwano@infineon.com>
 <b4fa6dc3-d9c5-4543-8410-5125a6fc9b7f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y2gPr1E0X6uyN3ff"
Content-Disposition: inline
In-Reply-To: <b4fa6dc3-d9c5-4543-8410-5125a6fc9b7f@linaro.org>
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


--y2gPr1E0X6uyN3ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 07:40:17AM +0000, Tudor Ambarus wrote:
> + Marek,
>=20
> Hi,
>=20
> On 3/14/25 5:53 AM, tkuw584924@gmail.com wrote:
> > spansion_sr_ready() needs to support parallel memories configuration,
> > that reads status register value from each devices and combines the
> > status bits, likewise read_sr() and read_fsr().
>=20
> SNOR_F_HAS_PARALLEL describes 2 flashes that work in parallel mode. And
> we hacked SPI NOR and used a single spi_nor object to handle both
> flashes which is obviously wrong.
>=20
> My 2c is that we shouldn't build on top of a crumbling foundation. Until
> everything's moved on top of SPI NOR, I'd accept just fixes on this
> subject, so no new support. Tom and Jagan to decide.

Yes, I believe I was expecting some patches to redo / rework what we
have in-tree currently.

--=20
Tom

--y2gPr1E0X6uyN3ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUQxMACgkQFHw5/5Y0
tyxp6Av+NCQM3M6vjhFEEV8B2GhqlwxnHsyeKyDaSGouI0TXzKd2z/OYba5CzEhQ
Dw6NrKppLduaGIKi5LYv45qv9qBkWeqHkIyRRLKYVqOJiywSjZUFIAxa/oUpSxPD
ZqFeP2fQTfSgu2NQ/bwHQnEnncxvRiFsizzh/tvFwIdwWWEmWZ+UQcEo89wfa6j7
mT3n14ExQqfcyqzpLzIq9bjDOP0ts/f463pIOgwYbcyVYoSh08EKSoZceInKjkT8
5z/7aD6EH3tWqDgiZrr/O9n1Xo4ql34/5ZgfchzFNIXfaa+wEQNDjYQ5XmNPHGEU
iQXM2Q9ZEUcOGh5K+dhA8kRhgtf0lbClgxcJJZ5BdS4pSwoH8sz4S2rTN6zlBZuC
iB30EEelylQfaCiKHSsCq7kELewHrlqlrgCyL7DLHIYbAteD6fPMQY3fFaekB6U0
chCZoCKwsRu4qJDoxP19vdh0PH0g95AkhM6ipwDvzciYsrpzX+mBQd5KZXdT32AG
iBxF1sLj
=SBu1
-----END PGP SIGNATURE-----

--y2gPr1E0X6uyN3ff--
