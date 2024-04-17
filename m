Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E26C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516A88836E;
	Wed, 17 Apr 2024 02:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q9JpRORV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0C88836E; Wed, 17 Apr 2024 02:25:31 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997E48836E
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5a9ec68784cso3064496eaf.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713313527; x=1713918327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XPnFubqKSZSREu4KeWJtN2oLjDtM2P/0eViX5+3YFno=;
 b=q9JpRORVqNAmIEHsph86BTJqG5pjwZvQy/9PSH8gq0cw0zYNzOTXTSGy1ZvnzpOz/l
 b1rXhHrQBL7rcgZNfOL5HLWBlzFQh1dWp+yrWYxxbhaDmXdJzmcYRM5iQVT1Bf7jSoaj
 hbanEZG9QRHIqtehvkCkEohhfvLzTBUaf2HKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713313527; x=1713918327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPnFubqKSZSREu4KeWJtN2oLjDtM2P/0eViX5+3YFno=;
 b=NljLaCZVmCLtiJIkErH8HGn2lnH0kVrISRsOkaOct/wrPgDNR2pJaNrfHq2ranC0vw
 wSO86OvEmnUBDbdpl92pL/ni9ehCtmkZ7xbAd7sJtBQuMXOPEB/KwJgKaqPOlpfeRkym
 XNUDEKz9ktXqnh3e6CSCgtqLppB+qVPH5YuyIFEJSFs02u+3B1kq6VVvFrDswKvBOM8I
 bWkAReTy19YuozRNhju5GP1HiUenq+l8/dmJHyXFdTkqOxaNSBLMgq2BsrcYBXZepNeW
 Fvt581OQ0qNlE4G87qEw3lgoysiaerObeEKa4ObcxrLUAawfve0lHA/z+0wrwucZNiW7
 gdjg==
X-Gm-Message-State: AOJu0YwFLSSk1WhW1qbQx0rWUBWA26t4VDDIMXYbJUCmchtKV3w7Z8tz
 r4m38ZS/ZbguZ8mpgOLGMUYbly5tP4nNXlkMJBzho3opzfhCj1P/FcZ6otg4W84=
X-Google-Smtp-Source: AGHT+IHTIS//2xqmddUvoAVowY7QfRnVP8y/sWvlQwyES4lcarRRfDG/g5Bi1efn54mel2la3WrEuQ==
X-Received: by 2002:a05:6358:9617:b0:183:645b:cfa5 with SMTP id
 a23-20020a056358961700b00183645bcfa5mr18057063rwb.15.1713313527260; 
 Tue, 16 Apr 2024 17:25:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 kd23-20020a056214401700b00698f01a958asm7824831qvb.77.2024.04.16.17.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 17:25:26 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:25:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 11/23] efi_loader: switch sha256 to mbedtls
Message-ID: <20240417002524.GE1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-12-raymond.mao@linaro.org>
 <20240416192226.GW1054907@bill-the-cat>
 <CAEfUkUJvct2JPEDmvv02L-EZ9u_BkVbg1T=rafwMfe=pobfibQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xGZsb+7qUKzNJ8Pc"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJvct2JPEDmvv02L-EZ9u_BkVbg1T=rafwMfe=pobfibQ@mail.gmail.com>
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


--xGZsb+7qUKzNJ8Pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 08:22:23PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Apr 2024 at 15:22, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Apr 16, 2024 at 12:00:07PM -0700, Raymond Mao wrote:
> >
> > > When MBEDTLS_LIB_CRYPTO is enabled, use the APIs of sha256 from
> > > hash shim layer instead.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  lib/efi_loader/efi_tcg2.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> >
> > Why can't we have the abstraction be at the level where we include one
> > library or the other so that the calling code doesn't change?
> >
> > Yes, we can do this - The only reason I added new hash APIs with "_mb" =
is
> just to
> avoid vendor drivers that are using hash functions switch to MbedTLS with
> this
> patch set (As a [RFC], I was going to control all effects within the EFI
> loader).
> But if you think a complete switching has more benefits for estimation, I
> can unify
> all APIs between on/off MbedTLS.

Yes, please, a complete switch.

--=20
Tom

--xGZsb+7qUKzNJ8Pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYfFvMACgkQFHw5/5Y0
tyy8xAv+M4SZOb8YKCFdPtzUFy/erR1go0BQ8s6KoC8kUOG4WrrI9aJIlVJgwqxQ
pnjp9TChSC995zwBOx7nGbr9wgLXUSZqaFM9iA85WBRVcZM6Rppz1XZLIztOluEh
zKU2dqibuy8Bl3RFCuCbvTIa1VCG/BVvVWHDt04KVdCBxiYjdIwhBhnYtmZDwLcP
yn0mtDIC3GTfWfalTZCCPo1WkgI7mqAzHR0KPEGgA14OwyTqHilEMR5YNxV8mFCx
RJvzPqNepTjKu6W3P1vGwkHknFYy13MS1cycfVaJnNAxCT+2S9ut/DcG0KnIb5O2
WSm56ElqbUNcw9bJUOeclNAl2MAw2MprmCa3Yb2OfgHxCCwSUw6ERSWY9G/nOd4q
RRIpspPSOrRwMwu/1NZRvsJkCsZc6HVDPAVh3g0uoXANNANhj7+er6yP/iV2FScZ
ruuSerhCkAaPNq+yOcid+sHE7Z+UtCumlXJoAlYUJNan1Kl0ZV4ILoRo09YSvS0V
V69HnJah
=3R6r
-----END PGP SIGNATURE-----

--xGZsb+7qUKzNJ8Pc--
