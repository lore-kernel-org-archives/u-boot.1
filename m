Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F067CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B2AD846C6;
	Mon, 25 May 2026 16:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lz1B0rSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F8D846C6; Mon, 25 May 2026 16:12:28 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378C480398
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e61f8d3cbfso1034547a34.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779718345; x=1780323145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4DzJTIGMgWuCoKBnDbZvYq5nYcjRhwyr3yG6yKXSJT0=;
 b=lz1B0rSzJ9IMvaVRNLg+GfVJbO57dsahH7ztUKtCMWD1TEvdMMjiNpp22TfIXyAzbs
 MuoAEcspkSKiGFM1SHxThJdv/YjZPLmxZ98GXcnoTUC0UEcHJNYB7mo593RwvWFohtHE
 Cm8aJd2y89M88NKCv9stRmnZd3RKuuzwlwBRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779718345; x=1780323145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DzJTIGMgWuCoKBnDbZvYq5nYcjRhwyr3yG6yKXSJT0=;
 b=YsQj5HjqASOC+s5cL3EW6GjHSsdRvnMFM8nqCheDOBP7i2IH5J5OeDR0XWXANUBMSl
 kjUOInNkyv7v90TeJksUYj36m2/AxZ00vUXVrpMdt/fBuz2TgRPjuxzRE9JWEb3tcwHj
 BZ9kg39j1zLKlyxJazec6mWA4WFJOTJDeAfoKr024b2ZYF3oQ7lCtd1HSNnZAtS2cQvc
 BWPMM1pNaOgmaoe8KREe/yf5yNxlzSv2wCpveEbRmXJf2srY2dbv+YluVaUx8s8ot5/x
 1m3HHjEErfVEdmIjwxwZblN6j1WnYU2oOGpG+9hOM6HuTIE1LzaqlvyV6/kca5cKV8Gt
 Uj2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hUXAJmFPpaNq91EBBNCbQ0lDnHJYm8xfbqUypJJSlKx+s+mfSIfqc7QKjCJGwiNvF6p+UkPs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9TloXH+NzGtLLqw7g8PlTqwWPv0xWl07NiBMwwIitnTk8H3hW
 qr1lCq3hch5KsBb5zCuUGhIjgJrmkt250VF06E2/XiEbtFTZCuIuAsyiKZrxurCpqnY=
X-Gm-Gg: Acq92OEjNjiV4LxkSmT5iOwInnqBh/wotfx72eVgqou7nOlvFmBivOZOq5pWG1fzXtO
 SWWydm3p5MceQ9OapLwytuB/OOCgEb7PmTLxQLGjxOjhdiFNfyNj06+894kXTmtQG9eZNAm7WkQ
 Wrq9YRSG+h9uhLTcUuVE7rg9QAtHo++mgaEOib5Jh65US8HJYLMl+Er+zK+zEXzu/rl9FpcVlZ7
 JhyQkm4LwrPyZVnPWFbZ7mvgMVbWOJdEtbZqFH0AUy6C/UVDzs9XKvhInYWVp1Bprb6XaEi2rfN
 3gVFLHnkJiRtg5uNeXsR9jPz8WjoG5n8Tx55kj+tGTsUMX4tZ7/mzWZJMa4vhFR0rDabEW1ZYpu
 xhxrlPXG5g2VsDpAP6ipfhxHe0HdYVyPzCy1kFw4h6XyvlJHG0uDLdLCuqqBtnY5IQVamuTvY+w
 vBfNgbtTJaTLuwqwkKheMqT7/nML0humufdzC9BsC8Z91IugBGIUEVQ0IxAAv+3iAKF/pDz3bbH
 4dAdGBlwngBwBTd3oLqibwfPiJ/Z00QSlzRaV63avGypg==
X-Received: by 2002:a4a:ec4c:0:b0:69d:6bbf:3fd0 with SMTP id
 006d021491bc7-69d7ec7f7d3mr7211619eaf.49.1779718344950; 
 Mon, 25 May 2026 07:12:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm5438098eaf.15.2026.05.25.07.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:12:24 -0700 (PDT)
Date: Mon, 25 May 2026 08:12:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Re: [PATCH v4] binman: add CST backend selection for i.MX8M signing
Message-ID: <20260525141222.GH1858239@bill-the-cat>
References: <20260504190531.103295-1-marex@nabladev.com>
 <CAFLszTg+Ak2oZmYo4qy9T8kXpM=Mk1Vv0+dUucW7-xi9MX-Duw@mail.gmail.com>
 <cfa42674-8349-445e-aa10-ba92b6a9eaaf@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QYlMcxPgzJ+YKr5G"
Content-Disposition: inline
In-Reply-To: <cfa42674-8349-445e-aa10-ba92b6a9eaaf@nabladev.com>
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


--QYlMcxPgzJ+YKr5G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 06:20:48PM +0200, Marek Vasut wrote:
> On 5/7/26 5:31 PM, Simon Glass wrote:
> > Hi Marek,
> >=20
> > On 2026-05-04T19:04:59, Marek Vasut <marex@nabladev.com> wrote:
> > > binman: add CST backend selection for i.MX8M signing
> > >=20
> > > Add support for setting the CST backend, both via DT property and
> > > CST_BACKEND environment variable. The CST currently supports two
> > > backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
> > > CST tool is invoked without any -b parameter. Keep 'ssl' backend
> > > as the default, but explicitly pass it via the '-b' parameter,
> > > unless the user selects 'pkcs11' via either method.
> > >=20
> > > Signed-off-by: Marek Vasut <marex@nabladev.com>
> > >=20
> > > doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 +++++++++++++++++-=
---------
> > >   tools/binman/etype/nxp_imx8mcst.py            | 19 ++++++++++++++++-
> > >   2 files changed, 37 insertions(+), 12 deletions(-)
> >=20
> > > diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/=
nxp_imx8mcst.py
> > > @@ -90,6 +97,10 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> > > +        self.backend =3D os.getenv(
> > > +            'CST_BACKEND', fdt_util.GetString(self._node, 'nxp,cst-b=
ackend',
> > > +                                              'ssl'))
> > > +
> >=20
> > Please add a binman test covering this new feature - see
> > testNxpImx8mCSTFastAuth in ftest.py and the vendor/nxp_imx8_csf*.dts
> > fixtures. The missing coverage line for me is 177 (cst_backend =3D
> > "pkcs11" )
>=20
> The pkcs11 option requires a HSM, how do you propose to test that ?

We have softhsm already in the CI container and
tools/binman/btool/softhsm2_util.py and tools/binman/ftest.py has an
example that might be useful.

--=20
Tom

--QYlMcxPgzJ+YKr5G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRYxQAKCRAr4qD1Cr/k
Cs/fAP9487S7+135KKiJfk5BTrDmMTnAsc0g7GYJqKX8DPJxWwEA06CUiYKV6V30
D3YyX5envAGNsVqUs4KAt5EwA+cpigc=
=Xi3h
-----END PGP SIGNATURE-----

--QYlMcxPgzJ+YKr5G--
