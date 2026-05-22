Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3D5CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 22:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3117848BD;
	Sat, 23 May 2026 00:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CdPx4Dnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17846848C0; Sat, 23 May 2026 00:45:00 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A8F848BD
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 00:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-484d3c0855aso3141845b6e.3
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779489896; x=1780094696; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JGTjXCd+o4uQf/k4Jxq+KhJjejzZlWZR3vjNnYik3A4=;
 b=CdPx4Dnhv7ShE6uBlVIH6Vy0g7Ghn/lWtpgjBJMre7qYXsIYzyqkh695p7jEVkqMZg
 t/VSeF0+jVKOzwoWMT9br8PT9sBnR3sbwMuJkshwv1oZ1HAVJ3CFd1scL5l5dCd2M6PN
 74MrQ8wJhvyYFv+hz2FsIndHwdFmZqLN4T7/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489896; x=1780094696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGTjXCd+o4uQf/k4Jxq+KhJjejzZlWZR3vjNnYik3A4=;
 b=kBxOnGQjpj1qJDdGyzZeDeO2SCt3thR/c5nnt5NZuM/kri4sZbfPdzGd/aeUaYJHlB
 pEKDQa3ycoAYzKROspglXUKJKR6bnblEl5xY2h7D/XnYcGTB7Ry/y71ouswMkuBAS/1w
 aLrcur3YTdBl4D0qy56OyPxK9e/3dQooAkq/9BReTDxyO6u6iq/M/xChHgj2bGOE4H/8
 8BE46z9VJ0ChkfDSoKG9oS03w009qCIFIhEFUU+v/PvLbF2pXaEJhDzHz25XND+vtbUw
 tNXlfKVgC9DGrc5lAViHEuCCt3+XTW4y/KA2Pjt8TadHya83AcniINkbvoKNYGMZSXwk
 9q1w==
X-Gm-Message-State: AOJu0Ywb1p5WxqHDB1r/nxXQxT0+6nb4J4ZKgT4Urmc0tawKRAq7019y
 0wmea79dBfltz52Xto7DkHNuAED7Frg7Xl1Bslr/6eUYqs/zWATrDuVCDivvLvCveUc=
X-Gm-Gg: Acq92OHwru5D/w2XVr079gPgsIpXTNL8dWbwSqpl59xt1qQFSLRGXhnxtQALsbGfmdP
 7neLQmxbAvNBu+wASZrXtDTLFmp8rcwm4tycDIwPjgUGY8JTc6SvpygVM4m93lS0IiEUfrAVVsH
 pd311iqSh+GS/UR2vg2mgxbDTAdPHgvsdvd0h1KRK990cRUWVU0+tMaL38DSiJo4hmYYCrzQIS4
 20/yHd9iPJBdg2SgHXBibd51SiDyk4GtczD+XQ9UKppQGqdgil+uo0FOp43ZTKINYhXJbfgIUR5
 b8vui0MTcsMcQIRkb0siRpDNvuYYBlFIQRc9aRTHHnfXpU+xI7qU6M0HYswmyTil2TPrri/Osvh
 Fa5j8bc8EVhR7BStUeaW47qe0RKWawsJyYuxh/3ehz/pSHfvdGzAn4XVR/DRADFBsjuAj4M/82C
 EvAYHDIJzjKBTQxDdfYvyQrkjrDtkLZ3UFR7o+dCbpWejszpuXerr6dhXBNPBHGVhFVp9TPP8ib
 h0sS55LLO44iiL+bFx9UF03o23HaZncI0/rZGwf08VIoA==
X-Received: by 2002:a05:6808:1591:b0:467:bfa:bdb2 with SMTP id
 5614622812f47-4854a27ab57mr3081751b6e.25.1779489896513; 
 Fri, 22 May 2026 15:44:56 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-485546edd14sm1244235b6e.10.2026.05.22.15.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:44:56 -0700 (PDT)
Date: Fri, 22 May 2026 16:44:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC PATCH 5/9] linker_lists.h: drop _2 from section and symbol
 name prefix
Message-ID: <20260522224454.GC1858239@bill-the-cat>
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-6-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t1eC9GJfV7eBI4or"
Content-Disposition: inline
In-Reply-To: <20260522212756.3169222-6-ravi@prevas.dk>
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


--t1eC9GJfV7eBI4or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:27:52PM +0200, Rasmus Villemoes wrote:

> Since commit e2138cf1e60 ("linker_lists.h: drop never used ll_start,
> ll_end macros"), which removed macros that would create
> __u_boot_list_1 and __u_boot_list_3 sections, the first _2 in the
> linker list section names doesn't serve any purpose and is in fact
> just confusing. So remove it.
>=20
> There never seemed to be a reason for the symbol names to have that
> _2, other than perhaps for consistency with the section those symbols
> belonged to. Regardless, remove that as well.
>=20
> All linker scripts use a "__u_boot_list*" glob, so they will work just
> the same without that common _2.
>=20
> Keep the _2_ part in the separator between list and entry names for
> symbols, since that is called out in the documentation to allow one to
> define sublists and iterate over those. I cannot find any current use
> of that feature, but a later patch will make use of just that.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--t1eC9GJfV7eBI4or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahDcZgAKCRAr4qD1Cr/k
CoJMAQDQT6SaeUf1+GCP+m2Tqcik6xhLpoINAuizsbskG7JI9QD9FV/6IuzFkM7Q
TXo26h05YulgHAJR5/il4taSqt6fCwM=
=MAXt
-----END PGP SIGNATURE-----

--t1eC9GJfV7eBI4or--
