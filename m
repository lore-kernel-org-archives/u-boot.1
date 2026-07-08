Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FFCC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 18:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1510284A5D;
	Wed,  8 Jul 2026 20:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BuBWbCV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DA8849D2; Wed,  8 Jul 2026 20:09:27 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8685D84A4A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 20:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-448b69cfc6dso440007fac.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783534163; x=1784138963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o56qeFkcha6n/98aSR9nU6uf4a/EC2z4nnbSnkO9/ec=;
 b=BuBWbCV64RKXeDTascL2paccuj80d7sq0rKjcN31HB+3M5a0M5hpJ15bqLyMFVnTmF
 d6t0NgrFf/qWIHXURbv17BdopkxvXZs6Df43yN7QgZhxByR4oDSesJsMP+MnZvHTn2zP
 +ZrEWRq4UsoXF7HOvUYvO6MBuisqO3jRubp3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783534163; x=1784138963;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o56qeFkcha6n/98aSR9nU6uf4a/EC2z4nnbSnkO9/ec=;
 b=FtrNZrYsyZwlWKLVzPOCk4CrADQQ8wRLcYirWhbkKGJtphSvVLh+Tq/5ZN96SzoUzT
 I+KwdlzUHmtosztGxUml/DcTI8v+BzhXCaYHg9A3UhJ69MYO1px1gGYyIygR80RcCktf
 7OKCYuyamMvUztz72MqSSKLyTuxVAV2dOdp/OcESQYtf0QmINnWYWxo4y2F1CR2UeJvX
 BfPgF0+KMVjgoPO43iaawo+54qyl/OEB3uU4sNS0kGFDYXKQUkgcQ0J7NslxVUFCOkCK
 /9BCnwxI38pBH3cPsLGDq82QQAJxpffjZQe4uDabAW3KU7sVdW8INfNZ2sewDhuZF01l
 35fw==
X-Gm-Message-State: AOJu0Yz4sb4p9PV2l4RAMKFtW/KAv1CshwkB2Gsw358q6v2u+JW/Z7Pi
 f6+lEGu0t1fWNrH4ZnwVTtN0AWBKG160iLl/or+JPdtbVqjHOVLNb9Coyrwhj7y7IWE=
X-Gm-Gg: AfdE7clJNdmpjQeYAm01247tIXRHkBLowrlxjHb+8PWu2Hwv5XF5mXZ49fSvZvK3cJt
 Osf22BrNfOH6N6OVuPy84Zl5fSOpO8r0d4bZ2VBByOSR0YY7HwIxRopXb+N+poJafJJPKOdEyJj
 31fnuR/BX2Bgvy36GchK6xtbp9RYPZ6UFCI2k6bx37SIIzXllXZQXhXdKUpSLZOKaeRfdbImfW2
 soNhrabzbgy7L4Jfd2Nbjyik+3t9aOF8OlYg8oFiyqgA/qwwmBb7eXi5twND7pLAoUT1rvOr2UP
 JYBwIzScaON4VAttc7ebt104/rNbULmuttWTCF6v5zH02E0tm80c1rixBmszC053RAsXS3QKol1
 UXnltXMEOdhHnm0uWy0orqviODv5nLcFxLoiBfanLY8d62lEJ4g5BNm0x242k4PHsqcfDvLwnh9
 nTCst1JQoc9xuNJ3Qpq7YYathrWRYUJ7qSfuFYAUXAQfcwDAUEJdZ/TeOM15e6YXFbEGLcftPQJ
 2rNq+YHT6XBtRgFJjQVGxRK/GlpIj0WtU/CGw==
X-Received: by 2002:a05:6870:47a2:b0:448:b149:eb09 with SMTP id
 586e51a60fabf-45163c20befmr2333264fac.21.1783534162946; 
 Wed, 08 Jul 2026 11:09:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb13c9efsm17484958fac.4.2026.07.08.11.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 11:09:22 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:09:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tony Dinh <mibodhi@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/3] doc: CONTRIBUTE: use internal link instead of
 hardcoded external URL
Message-ID: <20260708180920.GE749385@bill-the-cat>
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
 <20260708-other-contrib-v1-1-8b3bd4d265ef@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s90UEhEyIAjdGbGT"
Content-Disposition: inline
In-Reply-To: <20260708-other-contrib-v1-1-8b3bd4d265ef@cherry.de>
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


--s90UEhEyIAjdGbGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 07:21:13PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> This way we don't need to make sure this link still points to something
> that exists, as Sphinx will enforce it at build time. It also has the
> added benefit that if someone builds the docs they will point at their
> docs (though that is debatable whether that's useful, but at least you
> stay on the same website).
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--s90UEhEyIAjdGbGT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6STwAKCRAr4qD1Cr/k
CoKHAP9D5MTXMaNngy0wklHUIN9MvaPHCAsTgmT0iZUfBEJxWwD/SDK6pEa011DY
5nhY1nSM822rckPM5dPEMxpPrq+uUAg=
=AcX8
-----END PGP SIGNATURE-----

--s90UEhEyIAjdGbGT--
