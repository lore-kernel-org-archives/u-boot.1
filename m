Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C515DC4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40ED87CF1;
	Tue, 31 Oct 2023 18:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q+RIe0V5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA5587CE5; Tue, 31 Oct 2023 18:45:59 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3E187A5E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66d093265dfso38075916d6.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774356; x=1699379156; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=poOqAlpd6gWoekiWGiMzBHmV/Hrb75kmEL/zQWDovo0=;
 b=q+RIe0V5kRCWV4JvNClKevi27slR/apaJwdfoZrorynPOF8zKLIPnS8QHZlVz/N2wX
 fzdZzRGsklQadVlnmfoI3wOB+WX09wGnJNX37ps+kLBIDUtczADOXlG8TRHVVMxpWmkg
 flwTwx8vEhiO9tL9F8/LExYtz2YrOJlQX6HDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774356; x=1699379156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poOqAlpd6gWoekiWGiMzBHmV/Hrb75kmEL/zQWDovo0=;
 b=b+7TPQCULBr9PJnp/XQLP4PvtfJyMoTpL45HTtm1g2bMKVAydFOOANlz1+3QMGID+Y
 bXgD+4SOIkMr6wtUArQord6UPA/V/9oPCiEfSNdnutsTo7+sE6YnW9zBPiQhnQ+WW5Kf
 2+Mc5KyLFOyTDpV7AnWLFcuwX11X85HKmkFM9mGc4wJ+cQ17/rzJ+oYoILQY87Pb+ypA
 CF1wUs3tCrpneVwISATXDcH18HjFTO9NsBPeYfORFemi3PThqhC11NVz68cvLBF43Fmo
 IpR2Rxl47XCggGH0xxcfx+Q27a1b88+tiud3Bs+JI0sN4NJHp87/588D+VRGCpHTmMyC
 SfnA==
X-Gm-Message-State: AOJu0YwC+uA8hfYcYLouGHUHLsaHny9Ln6Nwzv8p3sk52Dr2NGS3aSfe
 dGZ6FYjdwDZDDwhcstZoweupFA==
X-Google-Smtp-Source: AGHT+IFXD1pg11P9G1H0MugGClo5bdHm+49YuGEsKJqv6rF7JD8K62UojsTqEX9WtG/EzKiGbq+ngQ==
X-Received: by 2002:a05:6214:20ce:b0:66d:9e52:a431 with SMTP id
 14-20020a05621420ce00b0066d9e52a431mr20674330qve.3.1698774356370; 
 Tue, 31 Oct 2023 10:45:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 l3-20020ad44443000000b00674a45499dcsm715258qvt.88.2023.10.31.10.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:45:55 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:45:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 4/4] configs: nuvoton: npcm8xx: Disable
 CONFIG_SPI_FLASH_USE_4K_SECTORS
Message-ID: <20231031174554.GR496310@bill-the-cat>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
 <20231023070225.3142578-5-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="64mRmolOem1jOAP3"
Content-Disposition: inline
In-Reply-To: <20231023070225.3142578-5-JJLIU0@nuvoton.com>
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


--64mRmolOem1jOAP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 03:02:25PM +0800, Jim Liu wrote:

> disable this config to improve flash program time
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
>=20
> Changes for v2:
>    - add commit message
> Changes for v3:
>    - no change
> Changes for v4:
>    - no change

Applied to u-boot/master, thanks!

--=20
Tom

--64mRmolOem1jOAP3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPVIACgkQFHw5/5Y0
tyzrgQv/RwrxRWJvcaK3kT5Dv+H5211SG7ocFDSKIiQBTlClM5kHCWcyMa32VCiR
H5p8wHqaKOGt6P6kdcN7CtEmI31qkyktn3WkwFyg9xmFUoQDeAPx0wdCwYr4oqMd
QbyGjAuaL6VPSOA/SuitNbfHsRy4nFv3+38Ffo7RmTg7YXAXwljssFRDHBBFMRDX
z17SZsBKkuknMv3Bf7z5h8wagNZeLPXSluuJ7+YeL+fWqO502DdD8Nsj/UobMEoI
b0HAIDKzfRkoQvXnQANBZ/XTkITG0OEdXYAyC+E9YZNM4xtB4qzsPg5FUgzgXMUj
jFutTL1NFZfNlFS7DtYcT1g4bysNzCdZnMPnWwIIXcna4Uakm67LAwpETHkOBtck
2BPQpdKtO7nq3k0MuJMZtwybJu0ES01IslU8uF/bTrdebQq7nhVEyz35K9vDFwkO
cfr0HLipUikyNHUkqk5O+IwcisAv51kasan3cM1u4JSphVgC7oqLTeRIFDWWfgIW
TbMomIMQ
=aoqn
-----END PGP SIGNATURE-----

--64mRmolOem1jOAP3--
