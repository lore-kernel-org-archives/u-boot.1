Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FE9C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 18:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56772886B9;
	Mon,  1 Jul 2024 20:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a9099WiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530C7886BA; Mon,  1 Jul 2024 20:08:34 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B0D88670
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 20:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-25c9af0102cso1663719fac.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719857311; x=1720462111; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mziQn/ffyNyccDlznvXlxlTcMTsdikg1qE0MwxeKG5A=;
 b=a9099WiSdUIFk5qhFtKMfCl4D3TR3zpU+KF/T+lsR1tgmrChhUmAmJz8Bj64g0fCkc
 UuEnBjTVaqnyHYCepjNp3db5t2rUiBD/3fZ0cBnepiDyxhAJwsUKYR4HMoF7QzMaIfl7
 EgP/lqJqMNNdFRTdkkDCOUWc24DtL7TWKG0c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719857311; x=1720462111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mziQn/ffyNyccDlznvXlxlTcMTsdikg1qE0MwxeKG5A=;
 b=STK0zax562Cgry4qGRlGXMELNjilWSZOiBr0jrt2W5aolG7HqmB6rAiUC//gpGerVW
 kXigpJofGU/bE1v6hAViRHb1ZfPAaViU1i1EVWtzCaObl9fDREfguRuPdByRTNlyxgMz
 yph11srmzag7SAWglpdCtKBIkyX98oqzw/I1oK1+yg8xPrfANQWeRZTQotNgZx8SI8Zg
 b8u4USNfc+P8oO9QCR5p15wLIG8cS6rNEtQEGXnG425GTTk19dGvf3wb+gaCCjQ28nCm
 UwDuvtMEdBgCmZiTj5spXdYrX2c34TBIHfNCLQJSGMnqUDqEMjBjDCqDrWix1V7P7XMG
 Zl+Q==
X-Gm-Message-State: AOJu0Yw/c3RH6QHUcybVV6oNW4LT9IYXnUvhF7qA0fisRuTYuVNPIb0s
 lv71DccupG4YvrExgr9HvyNA9/nnV+1NRwkfCX4XGjVmqyKpfARkV+aBTYZOPXo=
X-Google-Smtp-Source: AGHT+IGVthffckeHY6WU+PmWxT35ubGRKmZaDBTUWh/E291gwdhd/dIKBlowjs1KgArTG269WZY9bQ==
X-Received: by 2002:a05:6870:eca3:b0:259:8b37:9e9a with SMTP id
 586e51a60fabf-25db34b9bcfmr6100354fac.34.1719857310751; 
 Mon, 01 Jul 2024 11:08:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e234b66sm1874848fac.30.2024.07.01.11.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 11:08:30 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:08:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH] binman: Update cbfstool
Message-ID: <20240701180827.GL38804@bill-the-cat>
References: <20240701134102.1465810-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IOCvoPfXKVLVsAIQ"
Content-Disposition: inline
In-Reply-To: <20240701134102.1465810-1-sjg@chromium.org>
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


--IOCvoPfXKVLVsAIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 02:41:02PM +0100, Simon Glass wrote:

> Update to a newer version of this tool, from December 2023. This runs OK
> with the current binman tests.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/binman/btool/cbfstool.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/binman/btool/cbfstool.py b/tools/binman/btool/cbfstool=
=2Epy
> index 29be2d8a2b5..b7c64b90ffa 100644
> --- a/tools/binman/btool/cbfstool.py
> +++ b/tools/binman/btool/cbfstool.py
> @@ -215,5 +215,5 @@ class Bintoolcbfstool(bintool.Bintool):
>          if method !=3D bintool.FETCH_BIN:
>              return None
>          fname, tmpdir =3D self.fetch_from_drive(
> -            '1IOnE0Qvy97d-0WOCwF64xBGpKSY2sMtJ')
> +            '1KPR41-fKHPqlMCVsfMl2xJcyUgTT_6YI')
>          return fname, tmpdir

This should probably be from 4.22.01 to match CI, or do we need to bump
CI up to a newer release too?

--=20
Tom

--IOCvoPfXKVLVsAIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaC8JsACgkQFHw5/5Y0
tyxQkgv/b3eDoQIR9sLFhxRwC10GXnrqmwHOsegrz5F5XqwEzgKd1XKw0cfhLqwS
wR5lE0REeKqQ534VBpb0VWX4J+4Nn57t8dqZqSqR7E9+JivvKUdYh6tF+3sGxTey
qwrwcJ4gkgYWA/f6Q2LPuulD0r+FA7CqGL3Tz+vXRlgWjt9xJzvtXxKK51WhpX2o
6pPuScNFfecDfY3a1UclMvELDXsAiG7JWTKF9x4uhPN4hMxozKbPAmSAKg6o0o39
1AoEC9WyzRR5OlKOOQ/p2aeYnFn52VNyQYA7t3aGdRGXLrKCz6lmpopz64IJgLt/
iz8VLNXaRxzskI48GgXl5jHqgf0pb5HDLlYfRlVg8eCTUK/vDJ7j3c2HOXfONtwp
MWoROOmsVsN16KXcu4E8bdTzK+4YoYWt/CEWsIX7idtGMu+2qus/jNCHL1GmCWND
9/i9byrIINaptxV/HDuRE54mzEEZihuWxzktiJal0GhRBHR5ruS1b8Uc6P9/w9K1
MC/e6Bsc
=Gboe
-----END PGP SIGNATURE-----

--IOCvoPfXKVLVsAIQ--
