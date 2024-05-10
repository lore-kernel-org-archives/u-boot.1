Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3A5C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1277D8804B;
	Fri, 10 May 2024 21:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="exJHkNbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A6A880FC; Fri, 10 May 2024 21:33:33 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6D08800C
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c96a556006so1307490b6e.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715369609; x=1715974409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4VePc6s8vp2POO7OqtXab5D6szuwcv5voJIeYYu3z6c=;
 b=exJHkNbtZwS8F3GplxKps5Ue5LQOZghyQY8BIhcTWGjFUYkIw7k9aA6TyLZVsrDBlb
 QKggWcWPsrsEp5MkGEZ80j8V+2cBiN/XbV6S/u7l9Qx61I4/xsEW8xho/muBmCr8Ll9P
 cktZq5kvfS0RxdpHJcim3WjEc1Iw9Azl6YV3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715369609; x=1715974409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VePc6s8vp2POO7OqtXab5D6szuwcv5voJIeYYu3z6c=;
 b=rhlRiUNSG0YWS5fvf/araQ8kdwS3WaRRj4cWJN8oSxRtlms069bQH0CeVaj9GNJcYC
 LM0ljyhuyJa9br7czNJ12TDt/drKi4X0xMFssMWhCeQeTDwtia+Sg5UpPzdfb5zqtf4E
 D/bfhtXCTxPiAKzS0t4gD+SVcDL6BY1aFg88P2qw/Tkd7AfNMNG497+g93wmCwPsEc9n
 vSzAAGhwUWhknnJb4xM9fMbJeEOBedXVvMfkVLrIEaaB3n19QjTNRMKT1nE67EjKXah9
 yi1MGNzk9PxzexQzliynL/tia4u0uraxJi6/E5qqCM6hd7dI0o//QuL6YtzsXBMJ618J
 qvJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvxEHjHj4w5Xu5vmoQ2UzwFvkuF2ZCHYx11Wd2LIld1qw9O3xw4H+tJHIb5myIHnRiicxxxhiCD9tRrbZSmyu6KBSaJA==
X-Gm-Message-State: AOJu0YzDs4RH8j/k9SVEqVvWWIVZGGo5esqeSWpaCBHegJZQO5mnSKmS
 FkXLKiCP9T95vcxKa2asAP4t3dMh+eoJ2xTEmaHvInpzHlPRXq8fGgYl1vC2Txc=
X-Google-Smtp-Source: AGHT+IHLmzCy79RLttZR7QqCESmPs3OCzkPmhJ/yvwc2BaZyz3Xmy9rFvekttmvJfEI8QtKLzmtfwQ==
X-Received: by 2002:a54:4e90:0:b0:3c9:94f2:5cae with SMTP id
 5614622812f47-3c9970580e2mr3870582b6e.17.1715369609498; 
 Fri, 10 May 2024 12:33:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194c3asm19703146d6.69.2024.05.10.12.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 12:33:28 -0700 (PDT)
Date: Fri, 10 May 2024 13:33:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-ID: <20240510193325.GX2568172@bill-the-cat>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
 <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
 <20240510130830.GT2568172@bill-the-cat>
 <08b22e06-f316-4ef6-bd42-a4600f1f8035@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lmlJduQN/8gi/dJy"
Content-Disposition: inline
In-Reply-To: <08b22e06-f316-4ef6-bd42-a4600f1f8035@kernel.org>
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


--lmlJduQN/8gi/dJy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:24:41PM +0300, Roger Quadros wrote:
>=20
>=20
> On 10/05/2024 16:08, Tom Rini wrote:
> > On Fri, May 10, 2024 at 12:55:15PM +0300, Roger Quadros wrote:
> >> Tom,
> >>
> >> On 25/04/2024 15:20, Roger Quadros wrote:
> >>> Sync AM62 device tree files with Linux v6.9-rc5 and
> >>> add in the missing bits in -u-boot.dtsi to get CPSW
> >>> Ethernet working.
> >>>
> >>> The last patch is marked [not-for-merge] as it is not yet
> >>> applied to Linux device tree.
> >>>
> >>> CI testing
> >>> https://github.com/u-boot/u-boot/pull/527
> >>
> >> While the checks have passed, there are some recent conflicts introduc=
ed
> >>
> >> Conflicting files
> >> arch/arm/dts/k3-am62-phycore-som.dtsi
> >> arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts=20
> >>
> >> Those files have been removed.
> >>
> >> Do you want me to rebase and resend this series?
> >=20
> > Since part 3 was a do not merge I wasn't sure what the end goal of this
> > series was.
> >=20
>=20
> Goal was to show what is required to get Ethernet working and DT synced w=
ith kernel.org.
> part 3 can now be merged as the commit is now in linux-next. [1]
>=20
> Maybe it is best if I rebase and send this as v2 and drop the do-not-merg=
e for patch 3?
>=20
> [1] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
>       commit: 0b1133ee36ecbf3b02f69cc4e8a169f1b6019e40

Ah, since it's been merged to -next now, Nishanth, what do you want to
do?

--=20
Tom

--lmlJduQN/8gi/dJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+doUACgkQFHw5/5Y0
tyz5ZQv/eKPUncowfJMeDWUYWTPrk9m9Ib/qF0iOSxyGt3oX4VVMvSburNi2nDyj
D7YVUY2VQ4h+huje/RiIU5R9G/Jd7WsKVXTnb0pSJAp/H1O+p8X7ccSVU0Mg01sU
rVecgmrVzfXAYzE4mhs8lxHA45j4S9n/FMlOHVWwA87Y7uXu0HGBJxInhZ1ryn31
4jMs57Ll07CyJuq7yI6TVznD/mcmNnpOBnEsic2ij+7TdfZUIFCjGTPpQpcc3uXH
rwcOxAvXV5jeyf6WXo98t+3HnbAxUnm9RxQuueZTS5n4veZ9FsTyZqiRaMduOJXy
iHKUxcytgGAfQwQorfUE5+nRD2sG2af8uAp4uPsXsQh+GSvAxFqJYFTX49EkQby/
9DZMhYljs5BvrGAnSN2qauLE5dOa/gdP76HpdeZW255Mbd/2UDoE2rzzS78nCglp
7zTSnFxrwFgiaUd9KW+0darMS7gXjim/T+ISlJANRpxu3Z7RgsM/+hoQQAr15jPZ
TB/Lg0WL
=0dnq
-----END PGP SIGNATURE-----

--lmlJduQN/8gi/dJy--
