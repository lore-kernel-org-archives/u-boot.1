Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF513CD5BD3
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED7486ADA;
	Tue, 19 Sep 2023 17:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jSmoDPOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B4086ADA; Tue, 19 Sep 2023 17:14:57 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0323786ACA
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59c0442a359so47984867b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695136493; x=1695741293; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jXFk1sFz0hayL7Gxb9G8VyoekAm7+19Jm2A43jUcPew=;
 b=jSmoDPOTto6HlArefLQAzxoWiKRZ8zrA6MqbydDGUa2oD5IZKPIWlqu7uDXPxnRIUJ
 U1y8WJHKxe9LMfl0rOvqZlAiAzeSAuNCPk/4rhSQOW3Ztw5EW/+d9Jk9Qi6jQpzXVLhi
 a+4a+ePtTcy5seYUQwkGT6ksSAR/Smvc7zAyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136493; x=1695741293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXFk1sFz0hayL7Gxb9G8VyoekAm7+19Jm2A43jUcPew=;
 b=e5puJg9fQb/bCW7PsS/87VzBjo0o4zYgtrKNojw4kdotXj8vnzl4XizbK9rKe8hQde
 xvaQh74cDlG5WuP6FgJHGw4t1cBIxwpjjkUg/Z1CvYtx+gPGFXqb7jkiSDVC/lZreA3y
 YqDq3qu2TI1AdWW0DgAW4yfKFrtyAUPpwGwm7lh2E2SOOJwhP61Z7sQx/Y2nFKBvJoIs
 YRUj4j/tUuPwCMNMdTiKg7Dbt7CdGruwDBYjs/FSwKPO4/CIB9HOquIRwaE60o38b0Xy
 fiVePhDYwCPA/KDYJ5onoPnS87p45O427TLn5RVE6HTJhVAaGxtSScG/A7CEgb3zXZA+
 /2BQ==
X-Gm-Message-State: AOJu0YwS4b3EwK4QIRUX/U2XnsivBdPrjPNGSfCvl+AnosLjgfL8NiA1
 GEgY1QOrE10mh29yeoBWMl0icA==
X-Google-Smtp-Source: AGHT+IE/C6AwaGIpd7ZWFV5Qr+HeeqRt8PPq/FKr/7+dPjb3Vtb3Tq98DAFqQClMiQ3tvIGkMccNYg==
X-Received: by 2002:a25:cb14:0:b0:d44:af:3cce with SMTP id
 b20-20020a25cb14000000b00d4400af3ccemr11131748ybg.27.1695136493608; 
 Tue, 19 Sep 2023 08:14:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-715d-a992-91e3-9182.res6.spectrum.com.
 [2603:6081:7b00:6400:715d:a992:91e3:9182])
 by smtp.gmail.com with ESMTPSA id
 t76-20020a25aad2000000b00d80df761a6csm2889995ybi.10.2023.09.19.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:14:52 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:14:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 1/4] arm: dts: Introduce k3-serdes.h from v6.6-rc1
Message-ID: <20230919151450.GK305624@bill-the-cat>
References: <20230911144401.1011354-1-nm@ti.com>
 <20230911144401.1011354-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NovN4AaSIZG594qb"
Content-Disposition: inline
In-Reply-To: <20230911144401.1011354-2-nm@ti.com>
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


--NovN4AaSIZG594qb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 09:43:58AM -0500, Nishanth Menon wrote:

> Introduce the new serdes header from kernel v6.6-rc1
>=20
> The DTS uses constants for SERDES MUX idle state values which were earlier
> provided as bindings header. But they are unsuitable for bindings.
> So move these constants in a header next to DTS.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--NovN4AaSIZG594qb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUJuuoACgkQFHw5/5Y0
tyxjowv9FV2xQ4mYIaZ7zjWf2cNrhZVJ6zRUVq7d0FzGiGnOl0bPQdu+yvSKpWnP
nngCKWtkD65e96GtnmNa5cfh+/YqLOZKh5tPUWcigKFMEfLi6BE/O4NwVSne49yY
pVdVm95yQGlVJvcSlgpl7ZbBoH3HlvhpAtc0MN41i0VvaNa6ku24URxzOHv/h4gy
0q9i358p7Vis5jIMrwv+9OmPe2v0OP8em3IsyJnZvviiuSJ8LSPrRsUbE00D3rRX
J8Ku1bEU2cEBERSOLEd3F/txYQ+GleqPoxysv2BjrsmQFkA2If9mVK8uSZ3nKwKp
Uxi300Smer42OqOsy0fXZe2ijqkqUp7hfP+S6cFoSdLdypERJZJJuta/QPG7S30X
fHE4osXCc6284b1h7GOVeE1/Yvg9PZc8eJtaM/vR9HlfEPDeik23ReRZAscPDLTr
sk/WuL/ScWqSd8kH5oMl6bwIhnl+7Wag6G/uSm7Z/gfG1Hd2V0q9Mt8HaTwG7IsJ
Gtb/ImmZ
=ron7
-----END PGP SIGNATURE-----

--NovN4AaSIZG594qb--
