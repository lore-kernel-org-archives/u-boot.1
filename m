Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E8ECD4847
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 18:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B722E88B67;
	Wed,  4 Sep 2024 20:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eq7CJR8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C289688B67; Wed,  4 Sep 2024 20:14:16 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB98588B89
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 20:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a7fd79ff71so429114585a.2
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725473653; x=1726078453; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O9417g/E6EOA8/kePwSQY+4cokx6q78wr5T+Jhoz6rs=;
 b=eq7CJR8MJQ6NASiotpkV2mxeshNg1el7SJYj+W9MLnh3GgkA77f/i4RIGfg1D9/7Xq
 lPzBNxIxjOelieAOUHG4ZS1BJLZmRDUNQIAByEjDTjbzraLZQRmGyznnBpPaz/UvdmhX
 It9YRtgblVQ8IFPucO8pGrx37OfNW8EtkU8IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725473653; x=1726078453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9417g/E6EOA8/kePwSQY+4cokx6q78wr5T+Jhoz6rs=;
 b=HhQJ8shC+E2NYXXpUbajZSd3yx+9PZC7yMOI/dU/zuxXYZofNl30Gug1Xn5P3sY5W1
 S4gQTor2OPImC19QQns1ac+YQaDy8lSQQNLt2LoahUFQXUHwD7aCBTgVqaJBR/RYgD+5
 GiMGi8Bbv1Mn9S5H46YryRG40eQwL1h3IpyzolYUdsSehBLEtRrege9txYqg2YXSoufs
 j/BZbKfbNmxvi8RnYxqVH10rq+O+Anhsoz42Ogc8+ekqkpGP0iNrHNSL5XqaK7ltlLoP
 mrJzPDEVZr9NEZNOlvasMdJ+2cEcz4nJ8zUHIL2KJL9Nmwxy2T9SNZp8zO17yE+tjsdj
 1v+Q==
X-Gm-Message-State: AOJu0YyMWtuN0ULifafrSEYMD1d7Aac5VPHZlg28fo0T7TIpJrbvgs6C
 PD6M9XtlAEA6a15shGq5q3wVBw0Ic1cKBKLq+im8norLqHZ/+r5Ah+cSTA2+FkCuoPsawdO9+em
 N
X-Google-Smtp-Source: AGHT+IFGX4aY41fQU8BaQ1Xx8QLshfmFtJkAMUsEbpTt1LvF0F5xz80dF3JKLRZ0Y8JWVU9GQIgYAA==
X-Received: by 2002:a05:620a:3726:b0:79f:1eb:d76c with SMTP id
 af79cd13be357-7a89ac13868mr1835771585a.43.1725473653340; 
 Wed, 04 Sep 2024 11:14:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef3bea7sm4540485a.41.2024.09.04.11.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 11:14:12 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:14:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] treewide: drop redundant "type string" for SYS_SOC and
 friends
Message-ID: <20240904181410.GT2479150@bill-the-cat>
References: <20240904081840.2206980-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3A6h4wRFq1EbvHB7"
Content-Disposition: inline
In-Reply-To: <20240904081840.2206980-1-rasmus.villemoes@prevas.dk>
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


--3A6h4wRFq1EbvHB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 10:18:40AM +0200, Rasmus Villemoes wrote:

> The Kconfig symbols SYS_ARCH, SYS_CPU, SYS_SOC, SYS_VENDOR and
> SYS_BOARD are defined in arch/Kconfig as having type string, and most
> board files simply amend those definition with suitable
>=20
>   default "foo"
>=20
> or
>=20
>   default "foo" if BAR
>=20
> stanzas. But some also include a redundant repetition of the type.
>=20
> Homogenize the code base by removing those lines.
>=20
> Generated by
>=20
>   find arch/*/ board -name Kconfig | xargs perl -i -g -pe 's/(config SYS_=
(ARCH|CPU|SOC|VENDOR|BOARD)\n)\s*string\n/\1/gs'
>=20
> with the trailing slash in arch/*/ ensuring that arch/Kconfig itself
> is not found.
>=20
> This does not change boards which add a prompt string, e.g.
>=20
>   string "Board name"
>=20
> because I think those change the semantics of the symbol into being
> user-settable.

Correct.

> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3A6h4wRFq1EbvHB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYo3IACgkQFHw5/5Y0
tyw1WAv/ZVKsnXt0HN8JSkih8IRMXTx6Da9VKe1JmimScZS3jZUK93hk+knhNd4o
NiZSTIMDWbU21Svg+6oX+YeTfEjJgYeTSivvTGKz9MY9XAqUVPOpSmZWmzJbf8/l
fS/Qsij7GZ6hsetk1AbJd7Ynhyt4BAXGOZU6Oyt6gh8p+hSFunVQ99FrI0z84Y87
UuoKOSBG+FZN9BWbdZrDaJ8NYcsi9ErMQsLt5RrEILfv+Yr4vUgpRukQjmLlHLRt
nFDW9DEXo+T3iurKpY17FMwpHISqrP3WSdVww7emKdqCmZyxXBxIAuVz7sMgb3Iq
2MRnkKIYOEFns1sOmbniH/V0PZHh0RsN6fDXRRP2FycfmQj3hDUzNGMln0Y9j6G6
z2CZFzqhMH1W9zlgHRercI/7X+fNLqnbfQPfJ1X9zbaky/HWrFYQT6R3prNximjz
sbSJ3fAhaQr+Fqy1J+8hs9Audl5pxkgW9o0LZ1+gwCCpnFqAQzctYXmH2OTLdhIc
wxxfkqOE
=Wgtj
-----END PGP SIGNATURE-----

--3A6h4wRFq1EbvHB7--
