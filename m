Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF78DC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4D5884D2;
	Sat,  4 May 2024 00:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vgi5/E1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91649884C7; Sat,  4 May 2024 00:21:48 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D05F8818B
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-23eb4ec4e7eso70368fac.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774905; x=1715379705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YVLdqrT1pMpyBpGfdMEVH+iqtaYgBogIRT7q0xLqXqs=;
 b=Vgi5/E1JLhPWgvU7ddErkO3nYJ0A8SfywBe/SI1AJ/XmoNYzBBTg2DofnUWIsImNKc
 IsH3attOQwL4cmwPE0ov1+N2oDgmqOFCnIdaCsqX52sBnbZtJbvOz9B1JDROS6ibZzcL
 jWzko2sWqKNFap2Fm70ZduVPiDaAH1FjVuQMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774905; x=1715379705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVLdqrT1pMpyBpGfdMEVH+iqtaYgBogIRT7q0xLqXqs=;
 b=Q2EXEuIO77PlZC7oWB0LE80tfxNB+XUD2s4YEsx0XApRnPh0RPn+rtqKOiYDyyTOjf
 WVuOInxempmlDRuGhVRgcINJoP3SoFDSLb/IzoWulVKYRgxBJXo7rlQy5DRPR+K5GSQm
 wtggCkW18+EOHLvUxdJ3i8SX2w5RIguEauHyl1NovexzVBJZhGugYz1nm2/uEjIcQwcL
 FppEhkws6t5zoVwzYRa5f+ca9H866O3iZZvwEczTlZMUEi6FwkpfTWHfdaL6dh0rFBai
 yqo/VZgCVUq56XE/1+k6WQu2hn6Rij9fFGbKw/zhMpFIoej0AyGRNOKPLd7ZS+MDDCw5
 Y7Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX2TBlAP3ok4K1oDZ2LMOuZ2N67/y6uzGEKOmh4LXSOiK4MBWhlUcW5jYi08VY6KUq5se/qFjyF1VjHO3PRyXzocDkfw==
X-Gm-Message-State: AOJu0YwFRqyH9uWVkw9gxHDOsFK/pHYeRJOLieidt/Fz8DfrxekoHuXF
 bMTdJjuSgWpFSN4uJsluj3ZEHXH3AexmvYD3cOLJlN9aPhd9UE53CQlkMe/seRE=
X-Google-Smtp-Source: AGHT+IFvcQ+aTY3/ObzVPYs5LGxZTUV/EjprkrE1OnKA+EIwLKgsAN2p0iHi3AFbmmJnbavqWl/GQg==
X-Received: by 2002:a05:6870:a187:b0:22a:bdd7:7b3b with SMTP id
 a7-20020a056870a18700b0022abdd77b3bmr4646257oaf.11.1714774905227; 
 Fri, 03 May 2024 15:21:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 ay10-20020a05620a178a00b0078d677e72f3sm1586291qkb.118.2024.05.03.15.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:44 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Charles Hardin <ckhardin@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] net: consider option-length when parsing NIS domain
Message-ID: <20240503222141.GJ2568172@bill-the-cat>
References: <20240423070944.36526-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ySR4LpLgmm3JaWs4"
Content-Disposition: inline
In-Reply-To: <20240423070944.36526-1-heinrich.schuchardt@canonical.com>
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


--ySR4LpLgmm3JaWs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 09:09:44AM +0200, Heinrich Schuchardt wrote:

> When parsing option 40 (network information service domain) the
> option length is in variable 'oplen' and not in 'size'.
>=20
> Addresses-Coverity-ID: 492765 Uninitialized variables (UNINIT)
> Fixes: 8ab388bfdbcf ("net: add support to parse the NIS domain for the dh=
cp options")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ySR4LpLgmm3JaWs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y3UACgkQFHw5/5Y0
tyxdjgwAhvjKPqaFQE7mpW1fRplXqhRSzkownZ/XRDwKWBoLMb9+33efmaiJFqpy
3m5jtRwSudERXdseTwVxoemtAPXLwom8tmyPrP/bu1L5dzHdY8nsx1L31jUoLotB
jC99ujoNrV6WhefWTH3P851OuTi48qZ4uNwKDtzn8J5ilSerYzBSWAqUa0SAoLat
7mKw+Y+hR9TsJuvoOMbf7ExctOHrFktUAs/rYlr7eFrpuYyWa7e8HjF9t8givQfE
LGZsKOghwAXhcIUosVdZXrcvyOqsQq2KmXTlW3sWWwoHpzUIPKeVRK1Vfa4My5U8
9pQv0XOO/a4UeZCTiZBgRZfgmtVKpsSS31yNISLQ2ZAUSBaoj+R+O9RdcDLYid/X
bWlP/RThVsZ35/RCy7aIJX8SNxFbZ31NWqt/xO9BgVH842mkRScw/D20zciUzSRy
jdBdKZTyw1TN5MQkvkh8EePIahdJQkVzdHKQ55XES4tTEfzfNm9Clg/oVOsPkxxm
pgBSESdM
=g+Zy
-----END PGP SIGNATURE-----

--ySR4LpLgmm3JaWs4--
