Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59411D462D3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8228959F;
	Wed, 13 Nov 2024 17:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kdwbGlxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 953B889586; Wed, 13 Nov 2024 17:26:55 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643A68955B
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-295d27f9fc9so1194969fac.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731515212; x=1732120012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bPI8eck5zJLQoN1MbImtJfzn8brW2eRPXbZk9g9k5+Q=;
 b=kdwbGlxK5uSrqHG7MJH/8WoQFwlD7QAdXQWdf7YhDnDyjwlrJ71IWGlZ3G6zLeAMEe
 5rQ4Tng+sTL2NN+vW4LB1m8gPzHUXv5p+UagtkBOZLjYH8d69FrUueObXnLptuiCQkOQ
 ihQylo7JgcplB+Nk+Cr5Tka+gcrsEFSpgS0jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731515212; x=1732120012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPI8eck5zJLQoN1MbImtJfzn8brW2eRPXbZk9g9k5+Q=;
 b=aBUd2JP7Lb+kx7Eb5Zrxj8RFsNxYCKlWgfxSNmIK3vZ1dYI/6ZbuIWJfIoCLYkIQBG
 S0VigTD4Y0JFgQOwgnSn25DD2mc9W+jlf4XSG13mH54dkn9IDJ8OGE/quGOaHH/8Sv3N
 PS8KRnveB26tkX5axP2ecf9UvibXvgAeKIP+bfBZRKs7ZAARF/v3qHBX/QjskSTZ3hkc
 G6Gvz1qdgrnQjJ58pRvqqy5c7qTts69LrueA3hbYdTPDanMiTV7N5sMbewzt2OLdtIdc
 Pq7kRiTlh/D5T8wt+RUHhC9vhlsA+2T4gZJLFwgwWqD0VeccoGqd1aE3zDwjH6DsYftB
 uWHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3CiyygWvbnFauqWwVOrDBiGQcEHpQKOwAm/EoMEpNWTEs2iQLm/A5+xDl2tGPM5S9DtahApQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyiQL+NXl4sXyNv3cCKPFNz6J/WXQFiG5F1z+NbkRWzZoo3SHqw
 O/DPHHsJQnQMTbdkIhWrG/YdmxtO0kYaQW2PJ+mSMQWsD3BeTnbz0Y95qPEDHJM=
X-Google-Smtp-Source: AGHT+IGQQDyCpNluBR2pLDZjRtXJYRl6RmgA30/hQjX+iPlyjH2U+GI7elMaMxLDh3rJU9iy0VUZyQ==
X-Received: by 2002:a05:6871:230e:b0:270:1eca:e9fd with SMTP id
 586e51a60fabf-2956000776cmr18316582fac.3.1731515212136; 
 Wed, 13 Nov 2024 08:26:52 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-295e9334fecsm853512fac.45.2024.11.13.08.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 08:26:51 -0800 (PST)
Date: Wed, 13 Nov 2024 10:26:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
Message-ID: <20241113162648.GQ3600562@bill-the-cat>
References: <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
 <20241018151152.GX4959@bill-the-cat>
 <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
 <20241018175254.GB4959@bill-the-cat>
 <CAFLszTiQHArgoS5zK6aKpi1kiTBcAT4wEkbFaVSt5FjVQ8vmpQ@mail.gmail.com>
 <20241018182937.GE4959@bill-the-cat>
 <CAFLszTjKs0NocoePYyCZMufYg5ahKEHNcux_EwJkT6N1=1T+cQ@mail.gmail.com>
 <CAFLszTj8MK4QmxrQqALXi01EuXHrT2zXwbhR9qmC=txE1nqgLw@mail.gmail.com>
 <20241113152423.GP3600562@bill-the-cat>
 <CAFLszTjbHKtukCQVp+hkhtFV6_E5k6az+VnBR_sUVfSQxu8vrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3hlIBbPtGs0hOEqW"
Content-Disposition: inline
In-Reply-To: <CAFLszTjbHKtukCQVp+hkhtFV6_E5k6az+VnBR_sUVfSQxu8vrA@mail.gmail.com>
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


--3hlIBbPtGs0hOEqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 09:03:22AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 13 Nov 2024 at 08:24, Tom Rini <trini@konsulko.com> wrote:
[snip]
> > We're not going to get the sunxi series in for v2025.01, so we have time
> > to think about this still and try and get the code to match up with the
> > use cases.
>=20
> That's quite unfortunate. This series was first sent 3 months ago.

And unfortunately it's not yet ready. The point of the migration was to
find further real world challenges when used on a more wide variety of
hardware, and in that regard it's been a wild success. So we need to
make sure we don't get that wrong and have v2025.01 suddenly fail to
work on some platforms.

--=20
Tom

--3hlIBbPtGs0hOEqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc000QACgkQFHw5/5Y0
tyzVRAv/X6UCkIGJIfEwIzohKZnyP06+XaoQkLq63M48M90l9AE2PnUYKkYECJfJ
ddzwJnPd5Txq8vqXHe82b13ANTg0TH6X/7fTASTIc0UZH2XXVqBfQ7d0k44o/le0
J7cBF5Y9UeeeCd7BMCZO2GUEMnqqc3mEBW+l7jf05XHoeDt86iR4fOg4Tc+AkaxC
xV6AyTS1O+ebc+yhj3UjNRnWrEgHEem+w5XFFfvAq3Cb3gPos6SNR83qr368a7qE
6sV2nT3uB95OB0XuF/XBKARxAYVFYCTLQpbvg2lJetwrPxy4Skb47NXt18+1hTxU
0azMC4WrQVerfsl53kk3fN/0rt0gPUp1H0VrPLllO6CrkET+mCsEXZpwLHqStKk+
Em9QAOAqhXIcEnNBSQctxbMZuEvYTad3pap4eM+FnsH4cBRanYcaGkcy7sP9qdW+
B4OYWaVGScyPtvsFcS8lcZhWnoX66bB6177vG0bsaB87en1Chdtkmzv28/lCYcWe
xSJZvmnx
=zkA3
-----END PGP SIGNATURE-----

--3hlIBbPtGs0hOEqW--
