Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C44FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B450B83693;
	Mon, 27 Apr 2026 21:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y6gm/IyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4AD83693; Mon, 27 Apr 2026 21:57:09 +0200 (CEST)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0C6805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so7894566fac.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777319825; x=1777924625; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QXMLGrg+yknsd4dx3NYuHSEV0t3cWmHpEu6XD4a7C+Q=;
 b=Y6gm/IyP385RyDPGZJrwV/lTGjPcK+vhjDnSYbRT86AFKi6GYRHnTBsbORVDKnfbBh
 Eacm1hQUVW1te1DPwth7CasScCkgWVg8rc/Sr7rzfBgEur2NGjW7wPJg8EWjkgAbcAvB
 52QyRmr69Sz1/pdZJIRZ1ra9d4gdRkeZnGlz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777319825; x=1777924625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXMLGrg+yknsd4dx3NYuHSEV0t3cWmHpEu6XD4a7C+Q=;
 b=Q2NGWjj4hg1gUxEpKixJrkiuZgu1W/mX/D8XZsM+AljINEfTt+XkLvca6Mw/PNYEN3
 X0I/8esAjWayK9eNC5ki7LFj8+VjsVSY+gH+XJNvgmdy3r5hEg6AfzmbIY2TOg7oN49r
 EYVj601zSxzJhc93PYLBRwk0EuzqCW2SIkqWUBaR45Sr7Wu0PrGxw/8UGZIL8Sm4hSDG
 4anIduoaC1bX5aQ4fklNYw4ToLDIW/vMtwb9UEt9TxxkZmoFkUYZ60tYWU8ctQ+ZUFBs
 MElbzCU/UTP1qw6CdrmUWf/V9XQIvBSPdXiCnwlp1cgB5mo+ZC04y6P5TOxD4J2QCj04
 I45w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9slKZBsrqh2cISzE90dU/4k7Lc1LkGGsMpZC77ugPjwfL3bLTwRjoG5xHgOEgtcDpkz8iWOn0=@lists.denx.de
X-Gm-Message-State: AOJu0YyfleIk3ZgooGGp4W1vKFwUxnH8/RNvQpcdrCID0EhcktB2BxBN
 mqMrg2mm5QhNpwyE8Kojt5vdsEmpseB5yCq5516clPgC4i1u3MT4BAETeXckR5HfKbI=
X-Gm-Gg: AeBDieu2IHFkSX1PDyH56jkr2uCGwB9ZP/XhawL0dq59BUn4+ioe5YrMk+/B6r3D1Ag
 6ovc/uP4iRjopUDS5Ry02tbzN5GuBDpOlW8fSLPdFLLbZ/KbYrgfDmGSrhJ1EjTY8/oTGorkYui
 M+0Rbs72l9GEIPqaU/Zdc0srKpeSPik/AOBrvp+4/6C4jGTuFiZpCz5MiUwvLniMICNUQWGQC0O
 EcXH8ULZAEEEbkmEwD24zoih1xxgTFjPyl/fXIlhlvlFGRZZUipSD/nBuQi+99BGu0+UjmnpNPZ
 Gyjl5uCIYwR3AOqmYhvQVl/lvL4qYIHduKSl71iOEujs74EkBEopToEnswJ/JwAIXln31m9H2qo
 x8EyS21VOanyuzwW8RwLDysCeCPwX2tCJ0nqP/Dfq5PMtkw6pWid9mxh8BNajdiEDpPOgnd4/Aa
 fEwI7ohDr+DceXO4KBWNYbfSVyo5CVHkAbAUZh2VmCnx9F/f+FHNzRpnIeyJsd5EvcxArQhDlVR
 0Ss5Xy1E8XtGHxS9ikZKZd1GN54O6VojeqSIVkb1aUtvUbqoLnDgsI3Wo3p1vRgwAtuY9G8
X-Received: by 2002:a05:6820:f02b:b0:696:22bd:8584 with SMTP id
 006d021491bc7-6965b8f341fmr262613eaf.1.1777319824948; 
 Mon, 27 Apr 2026 12:57:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965ba57ee1sm170526eaf.12.2026.04.27.12.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:57:04 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:57:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com,
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 07/11] binman: openssl: Add boot and load extensions
 to x509 cert
Message-ID: <20260427195702.GN41863@bill-the-cat>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-8-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t+HQx52v8hK+dDaY"
Content-Disposition: inline
In-Reply-To: <20260425033742.1519298-8-b-padhi@ti.com>
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


--t+HQx52v8hK+dDaY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 09:07:38AM +0530, Beleswar Padhi wrote:
>=20
> The boot and load extensions in the x509 certificate are required for
> requesting the secure entity (TIFS) to boot a core. These fields are
> defined in the binman node for each core that must be booted by TIFS
> and must be included when generating the signed certificate.
>=20
> Add support to parse the boot and load extension properties from the
> binman node and populate them into the certificate. If any of the
> mandatory properties for an extension are missing, that respective
> extension section is NOT added to the certificate.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>=20
> v4: Changelog:
> 1. None
>=20
> Link to v3:
> https://lore.kernel.org/all/20251231173621.1069988-8-b-padhi@ti.com/
>=20
> v3: Changelog:
> 1. New patch. Add support to sign HSM firmware here in U-Boot.
>=20
>  tools/binman/btool/openssl.py   | 49 ++++++++++++++++++++++++++++++---
>  tools/binman/etype/ti_secure.py | 18 ++++++++++++
>  tools/binman/etype/x509_cert.py |  4 ++-
>  3 files changed, 66 insertions(+), 5 deletions(-)

Is there some testing we could be adding here? Does CI pass (and so yes,
everything that coverage checks for has been caught already) ? Thanks.

--=20
Tom

--t+HQx52v8hK+dDaY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae+/jgAKCRAr4qD1Cr/k
Cv9NAP9NhUJ3KzI+RHgAKtGLn83MH7YCpimTUxf2lHBPbdtXAwD/bnVf0meBCJnj
gqeM4ufOdCpcohccMZxYYUSNkP1oDAc=
=uyzD
-----END PGP SIGNATURE-----

--t+HQx52v8hK+dDaY--
