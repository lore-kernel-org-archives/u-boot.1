Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11864C25B75
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 00:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BAD8872E;
	Sat,  1 Jun 2024 02:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qb0y4yLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC4EB88758; Sat,  1 Jun 2024 02:14:03 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A45880A5
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 02:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d1e17dd278so906484b6e.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717200840; x=1717805640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x2UBTyWVoEyIaCEyrx7YQTxjMxYrOu2a5/cF5KD3coA=;
 b=Qb0y4yLWWtAr9XGllBvFYwuYDBj26bHC5uZEYydBZjC3lcHyT1ya2q9UxHs5Tlxaer
 EmQgnGegDlvzpXfct/3Q/yjYbA7xceBkKf6HJTFlDV27HSMt2nDDoDThfwuGTfxY0f2D
 dcWslVN4ZSWReT2oeVWJRTwD91+v5Vz4+g6XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717200840; x=1717805640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2UBTyWVoEyIaCEyrx7YQTxjMxYrOu2a5/cF5KD3coA=;
 b=LFeH/ZxCQZNSdQPQipPAnTF5j7dVMBY2/IAvWA5RE/LfNU3MPUiuby2CyBcJHYmZk2
 JItDO6JwcASXPEE7EWNo00MERoDLiLnZChy+jjLe085BDR/chKgWJ9zxYQwxiqusK8jN
 o7Ic8lNfzBUyQGQYalbWQqd5Yfiuv/x2+QyTL02wcd23uqcFfyp2SIFw8Qvhe0Zvtsly
 w5uR6o10oVBsbq0xIv17UP4NRNaBd3CWmJpNeZLekM2oF6lxP2zI2j6gtqMKHGGXNvev
 HTTTz9b1yLraZKMjQTsofcN157trzQT+3zUrlUu0I4gIpYmfiX9maMjS3Zw1bZgnSUxt
 hmOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm1c6EpfXwIoDz1jPtUASMqwgsQSUFldK1OpUSmfVp3yJnN+DvYv77/WCiDioIC2gcGl3bCNEixb6yYGbpNL73p+QjFg==
X-Gm-Message-State: AOJu0YzOMnkg5DqhfCbYPV/My6IL+AylBcXO+IQRv+rsRvXvbY42A4v+
 kNO6spQQGpG7pv0tSDLV1eQ8vlmJKWdLrZl9/VywMANjqIT4PFFCg586+rHxIrY=
X-Google-Smtp-Source: AGHT+IHPnAfHF4GEnF1XZkzsOv/dNTWQWRX2MUE7+OAxfC3MQJe58P2ayij+gDFy18bCxsCi25g0rg==
X-Received: by 2002:a05:6808:19a6:b0:3d1:d348:d1f1 with SMTP id
 5614622812f47-3d1e35c13f4mr4541660b6e.37.1717200840119; 
 Fri, 31 May 2024 17:14:00 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4b42b7a3sm10510276d6.138.2024.05.31.17.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 17:13:59 -0700 (PDT)
Date: Fri, 31 May 2024 18:13:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-ID: <20240601001355.GQ3714513@bill-the-cat>
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
 <171622056331.1577131.5584438868595064237.b4-ty@konsulko.com>
 <95fad9de-5fd3-4dd4-8a13-850dc81da26d@kernel.org>
 <7eb83ef8-e405-4441-b9cf-4aa6303b3259@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NOkfF8NPNW78LkRo"
Content-Disposition: inline
In-Reply-To: <7eb83ef8-e405-4441-b9cf-4aa6303b3259@kernel.org>
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


--NOkfF8NPNW78LkRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 07:53:24PM +0300, Roger Quadros wrote:
> Tom,
>=20
> On 31/05/2024 19:32, Roger Quadros wrote:
> > Hi Tom,
> >=20
> > On 20/05/2024 18:56, Tom Rini wrote:
> >> On Mon, 13 May 2024 15:13:53 +0300, Roger Quadros wrote:
> >>
> >>> Sync AM62 device tree files with Linux v6.9 and
> >>> add in the missing bits in -u-boot.dtsi to get CPSW
> >>> Ethernet working.
> >>>
> >>> CI testing
> >>> https://github.com/u-boot/u-boot/pull/534
> >>>
> >>> [...]
> >>
> >> Applied to u-boot/next, thanks!
> >>
> >=20
> > I see that this series was applied to u-boot master as well
> > and then later reverted by commit d678a59d2d719da9e807495b4b021501f2836=
ca5
> > as it was based on u-boot/next
> >=20
> > Can I re-send this series based on u-boot/master so it can be still app=
lied to master?
> > Without this Ethernet is broken on beagleplay.
> >=20
>=20
> This series apply cleanly on u-boot/master so no need to resend.
>=20
> I've created a pull request for CI loop testing on u-boot/master.

Note that the base commit was on -next I believe and so that's what lead
b4 to pull in -next changes that I wasn't expecting. I have tooling in
place now to catch this in the future.

--=20
Tom

--NOkfF8NPNW78LkRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZaZ8AACgkQFHw5/5Y0
tyxrkQwAjZ0s7qB//rJlzAsDKLijFqB3A1el0Nr4mzq4mCyuXB/SW/EIyi9tR8lF
kfX3RPtB8J7ap+W40tgkJsrjtG9LZED+WsLAy64Zic5E2L+zMdPQ4ffGObmNYjGf
PL1DFs0SwRbda7ONSr3nImYMwgm7YIOuzi9LURqoZ+TTRLhcXLO2rCk9iejIvjEc
BzyPostha5u6vUmXqe/r4lNkQ6bRmQOV1VqXggqgk1zmsZUe/U4FjefmMRIOncXq
qTZpTPE3bHu/fj2Ixh3cuW8k8SUOMRlM3o5Vt9N0iWYguhw01KA8px+JMePGglSR
0/GcToTAXJxnFCb/Lxa3vXF6hSzU2unRa8nME1V2uGkYf9iB9Ofxj/CHLDbxSAYc
rlewikpXUDY0hJltz1BMcUgq9Mm0FQidzhhSj65MBKRVOCzj7Pacl7aoxISg8jkZ
mOUyLJgD8yn0N48+a66iX9uvwJO0Dzx8V0Yw60sNGLp7GxIk8jQQW4Mhu/O8FqbD
Kwt49Atq
=jwgR
-----END PGP SIGNATURE-----

--NOkfF8NPNW78LkRo--
