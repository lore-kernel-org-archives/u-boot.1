Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39416E6FE24
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 18:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832068416E;
	Tue, 23 Dec 2025 19:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="leuMHH/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D828416F; Tue, 23 Dec 2025 19:04:52 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 583ED84167
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 19:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3e0f19a38d0so3791505fac.0
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766513088; x=1767117888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mY7YtFfP7PCg3kzKHEeCUwQRhu+wY73JVwhHcJMneSU=;
 b=leuMHH/JH8KcZp7ZQgv4GxPeeCT7IWNp2tk7GYcYuPCvrJrLJs4FwowZXgdWJFv0Rn
 RYnsZZ65cNuBi02ic1TY7rdG7xhckx7QAfAMNfgviyVLPmOIt0mitlLWUZ4NzQ96ccQl
 oHePVZYd3rVtN04xv9h/6QIsPa2r9eDT1W2w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513088; x=1767117888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mY7YtFfP7PCg3kzKHEeCUwQRhu+wY73JVwhHcJMneSU=;
 b=RfOs1FGpUDQxgL42garBYrXexfOnbqYhageVTH8OIFq9i1YaBtQ90ueCBS6butBe6h
 SfDd4H/Zr+EirnK8A/uOVDnFfD0xPPolGQL1zF1DdJxZeetLRun0UVn/gbmdN4dWzure
 F4vIlusQqmelxigcyfxEP3Qg+Iv7IPtFeKjIQWJhSJqgY2gV7t7eaAsBxsoW1CamKFg5
 OMXgfKIlDawXJ9vpFOWIox5Oc5MTqC0tdwMl95vUyt3+ZLMjIgrXAvwtNSsHHnJWNyAt
 cSfd6zdzot47a7wBUWjEWlA7qYDblVCys4/3edv/w52tyg8gOVMh35yEO6EcCcot02FE
 NmoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5eHJ13CQ2VUahQhhXPUizEHV5QsIY37AxW5huJRnvdRj3c5P2I7pDMNDe6mEO65FSZocK4FE=@lists.denx.de
X-Gm-Message-State: AOJu0YwLhYZeR2nFyjlwpdQ42vosW4lQx8FNvpWJMrghaXWwOG8aubXC
 qQQFMWjLO63RngVdyhEutRFEHUXoLbOphvMP/XO2Y1jD9QSBAAIAQEV7lA7CFSwLc/s=
X-Gm-Gg: AY/fxX5QQDEpQXWO+cVcZJv0se+ImwIA+eZ0e1RQXiJ3ltPYrWPgXzuLcevlaS1PpJV
 onT0oNFEB5urwi6Qn18daYmUQrTHYdDy6RNbSVjApfAlxET6y7Il9OosSXA0ecKLYsXrEfTMX8Q
 zt2CdSLUZE6i2HBz3A96G+hhAHAvg12EncKu6xnygsvgYcFJK6ZnsX05rzaGXgmqSuoUS0LlfK+
 ST4IImjMTGgHL7ZyLY4zlEvRwSWAZGItI63En5x73VaLLcZNihdVYJkgmtGjjsF/W375SY5kk5s
 o8MWrVyN45Tb7TblgWDqe7JboeGQpkjbyMpGsS9pbEX+LZDkdICECY3M3GIF6ZauLdf+5NW1xWk
 +9HhUu87nCznHz5FwGu+UDkKD+qzzEoFnSFTVyS+lFlBS7piIFEecZwQA0iIxwUgspffq9tzoKm
 ltEqalN259RopgdK49fZ+PdhOPsfbbvhdD3j8Gq2x2GZaRYf1kVw==
X-Google-Smtp-Source: AGHT+IGRf0YJ50aobxjFzhIKSmXmXB6UrKDkBXg73T2ruScMcpPzSqatMoueqFhLpRyjTFBbEAfu+A==
X-Received: by 2002:a05:6870:71d3:b0:3ec:a4ed:cf3e with SMTP id
 586e51a60fabf-3fda56cb56dmr7061046fac.24.1766513088019; 
 Tue, 23 Dec 2025 10:04:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab65763sm8929166fac.13.2025.12.23.10.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:04:47 -0800 (PST)
Date: Tue, 23 Dec 2025 12:04:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] env: Add single to redundant environment upgrade
 path
Message-ID: <20251223180445.GE847766@bill-the-cat>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <20251223143130.16266-2-marek.vasut+renesas@mailbox.org>
 <ac80d9cd-4890-4382-9ce6-2f237933d32c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V5/DNzXR2x9REB2i"
Content-Disposition: inline
In-Reply-To: <ac80d9cd-4890-4382-9ce6-2f237933d32c@gmx.de>
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


--V5/DNzXR2x9REB2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 06:43:00PM +0100, Heinrich Schuchardt wrote:
> On 12/23/25 15:31, Marek Vasut wrote:
> > Add support for converting single-copy environment to redundant environ=
ment.
> > In case CRC checks on both redundant environment copies fail, try one m=
ore
> > CRC check on the primary environment copy and treat it as single enviro=
nment.
>=20
> Why would a CRC check suddenly succeed if it has failed before?
>=20
> This needs some more explanation.
>=20
> > If that check does pass, rewrite the single-copy environment into redun=
dant
> > environment format, indicate the environment is valid, and import that =
as
> > usual primary copy of redundant environment. Follow up 'env save' will =
then
> > store two environment copies and the system will continue to operate as
> > regular redundant environment system.
> >=20
> > Add test which validates this upgrade path. The test starts with spi.bin
> > which is pre-populated as single-copy environment and then upgrades that
> > environment to dual-copy environment.
> >=20
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> > V2: - Gate the option behind ENV_REDUNDANT_UPGRADE
> >      - Fix up mkenvimage path in env test
> > ---
> >   env/Kconfig               | 11 ++++++
> >   env/common.c              | 31 +++++++++++++++-
> >   test/py/tests/test_env.py | 74 +++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 115 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/env/Kconfig b/env/Kconfig
> > index 4430669964c..b312f9b5324 100644
> > --- a/env/Kconfig
> > +++ b/env/Kconfig
> > @@ -489,6 +489,17 @@ config ENV_REDUNDANT
> >   	  which is used by env import/export commands which are independent =
of
> >   	  storing variables to redundant location on a non volatile device.
> > +config ENV_REDUNDANT_UPGRADE
> > +	bool "Enable single-copy to redundant environment upgrade support"
> > +	depends on ENV_REDUNDANT
> > +	help
> > +	  Normally, redundant environment is expected to always operate on
> > +	  two copies of the environment. However, hardware that may have
> > +	  originally shipped with single-copy environment can be upgraded
>=20
> %s/with single-copy/with a single-copy/
> %s/can be/that can be/
>=20
> > +	  to redundant environment without loss of existing environment
> > +	  content by correctly configuring the location of the redundant
> > +	  environment copy and by enabling this option.
>=20
> Why do we have to make this an option?
> Shouldn't we always try to restore the environment?

Because the use case here is (I believe) converting a platform which had
non-redundant environment to a functional redundant environment. Without
making this optional we get size growth on platforms which enable
redundant env today (see v1).

--=20
Tom

--V5/DNzXR2x9REB2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUrZugAKCRAr4qD1Cr/k
CrQYAP9c9j0lnvDzcc3ZPrv+J9ZLZvhw1hIGFky8auEAwXbf4QEA4eKISqaxOQ+q
GWjCo+aVwKzGXRuXYm0Dy414S0cJdQw=
=MfjF
-----END PGP SIGNATURE-----

--V5/DNzXR2x9REB2i--
