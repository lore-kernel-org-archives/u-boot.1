Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E7CDB475
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 18:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712B380834;
	Wed, 11 Oct 2023 20:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="axD2SYfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF3786CC1; Wed, 11 Oct 2023 20:36:32 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE268082A
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a2536adaf3so2088607b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049381; x=1697654181; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iJQkmqb6knOoJWDeuxDs/NCfvfpx0nstE+MF0h97258=;
 b=axD2SYfA1Ii27snFrHX9gwCVSTUXIdP5ORrwm1JxMqxuAxVGtlhe9p7/A3nGjVuStD
 iELyJajE+wiZgO42g3f4Ix4+pC+UKnol1fViIo6sAjT1YAC873i0KnozpXNEhlPnO1Z8
 p1c+j00FbyDmc8ofwzMXVUPgct8eN89aFFNTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049381; x=1697654181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJQkmqb6knOoJWDeuxDs/NCfvfpx0nstE+MF0h97258=;
 b=Ok6opg/JAJ3OfysP6QMpc6gn65qEXNwcc/UUoTb7Q1WcEzOIO7Dpxk0Be9Ab4V0JSs
 hML5xjl9wlrc9qeVyyyC/4Vfe1+NMLCKJWxEKYqu/yelnQDcktUrfya4ezbqR6x6HuA3
 QdW4CyzsErXITSlXGYO7jVAOBa0G+0ieswjvfl3ewEhRciyNLjmyGFVG3f+KnncUgaPh
 Bsen9vo15v+eVFrwJfjIiz2Th5jl4vnTLpiIVvWSP9o+681KzruKI/OFkXHGm4j4ZTNs
 ha/5xCUZYt5d4/HzVjGQL7QUHgyoRxA9R/JWfIRThy5uizh9dUvU1uN9A4x0d6uqL/Cj
 utuQ==
X-Gm-Message-State: AOJu0YztWGoTM70Zj+cA3AioVVVubs121/Zu/nktHwYMJ/2+SlUR4J9b
 15Ssbl4u9OENjvSTqcqfXvnejQ==
X-Google-Smtp-Source: AGHT+IG6MZWb60FpHOx4wYYOugLERrbbq12R2T4aKmaYAlYPaZ4K+kxvNyBlbNQgrzMEppT0ammE3Q==
X-Received: by 2002:a25:ca15:0:b0:d9a:5aed:b7e7 with SMTP id
 a21-20020a25ca15000000b00d9a5aedb7e7mr5914077ybg.5.1697049380868; 
 Wed, 11 Oct 2023 11:36:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a254c04000000b00d9a36ded1besm1695642yba.6.2023.10.11.11.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:20 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] configs: am65x: Merge the HS and non-HS defconfigs
Message-ID: <20231011183618.GF3119521@bill-the-cat>
References: <20230803145441.315515-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tDX99O4MYvN2MaTW"
Content-Disposition: inline
In-Reply-To: <20230803145441.315515-1-afd@ti.com>
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


--tDX99O4MYvN2MaTW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:54:40AM -0500, Andrew Davis wrote:

> K3 devices have runtime type board detection. Make the default defconfig
> include the secure configuration. Then remove the HS specific config.
>=20
> Non-HS devices will continue to boot due to runtime device type detection.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Tested-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--tDX99O4MYvN2MaTW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6yIACgkQFHw5/5Y0
tywG7AwAqF1jOKCpYnM5qO4rOvhwt+XplqGcN0mQP8nVb9TLsrJckBwy74x7HvJh
LSO5T5VKvM4Q3YuXqrbBGTtcS9vhiKtLInZIt+7ql0yJl/1ukBB4JrMMjMNl2Wbg
72bPAWF+edFZBfcakLoNJ355e+mObxsEtqxSnQRyDNh3Bdl8uQAvqvDi4UFB9wcC
WDTOBNqzAFJWsuuJziAJL7qmesmo1FkGFf2Fdr6SKFYSayKNiLAYcbcSnprLGFtf
LbGo6FgdpWwpkSAwFs05HUGni6AVuWasP420GAdqGZEDaNHLwdw/7JkRmwbZns9g
XIPmzG/5A9dVDoT6OjKmk+CAFtoRUaJWWp2DYgoHZCwGAM4SMQgALRUR/aO74m2B
vVOx+gZldcAJiy/GkAwq9Mmc8+4GKBTPJdmIrZomXLwTMlQID/+co01VD/bNP/b9
M8MQyal+VL7cVLQbdEd0PqVkl+LvGWbfky9aNuJGaTGTCIfNVsg7Bb3gqA/Bjm7m
lRXE+fMS
=Ct8R
-----END PGP SIGNATURE-----

--tDX99O4MYvN2MaTW--
