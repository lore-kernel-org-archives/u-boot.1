Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBA9C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 13:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3389787505;
	Sat,  9 Dec 2023 14:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a8UepO9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB59F87505; Sat,  9 Dec 2023 14:42:26 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E3187078
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 14:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5cd81e76164so28084837b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 05:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702129343; x=1702734143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k07CcomtJDYPb55SlJ6Z885uOCBygGmPBpbd7cdpYtg=;
 b=a8UepO9Xeeg/sskwBhA+DBZJKoFCK4pWKYFQnTW015fKTCjRMJgY6lwGpgfGTR0CLC
 0sCaBVTVTDabSKkWpzz1YGNb+ycTdzvDPnXD2lJK0n9BgNSvwjpHXWxa0rZgfiQGXQrj
 slRaYA729ZosH4ww0YgdzrrGFauVy1M47h0/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702129343; x=1702734143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k07CcomtJDYPb55SlJ6Z885uOCBygGmPBpbd7cdpYtg=;
 b=wICr/ulWoF25YvZ7Tbf0Z5IpP0kYyBJWGfFW+IRkPJNp2ulPbedRN4YkVT+++aNGUh
 IebO0ViYJTAwjlDjoNNU11zDrkWUSwfB6Gny57pwg/ursxqp5xUmkfifhpxY6D1Bidel
 6KdwLpXmSGMD9SrUVCiLObgFKQQB6BBdcMJbia0t1k0eSqScBwnq5qvw7DGUdk6YCDsd
 Yz6UlEua30mbDyD+1lP+flZLTc6SHkSiOfTSgJ56tc5W/YW70sZ8wn4MkJl8a+v+fyuq
 iiW9kYfpmn2eFFxyD3G9CQ1bmOCEirkRHUoywD1rrJ2BLAH9a3jXs2HhZrYwPkWX5ou3
 Inrg==
X-Gm-Message-State: AOJu0YzypReWw/twTZdGN/ahy4DOu6OZ9bHcMjdNUXxEjRJgzUR+f2+i
 UiXi7sXDlUw5cegLm2M4qIq0rg==
X-Google-Smtp-Source: AGHT+IF6OZn7n87mpGkxTMEcvQAc2FyXdNmn5AnL4O8ohep6WaK64Y5xmtBazy28DlCXMZtVYFc8lg==
X-Received: by 2002:a0d:d956:0:b0:5d7:1940:dd63 with SMTP id
 b83-20020a0dd956000000b005d71940dd63mr997282ywe.57.1702129342761; 
 Sat, 09 Dec 2023 05:42:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 p140-20020a0de692000000b005d14e254367sm1466292ywe.80.2023.12.09.05.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 05:42:22 -0800 (PST)
Date: Sat, 9 Dec 2023 08:42:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Bob McChesney <bob@electricworry.net>,
 Stephen Graf <stephen.graf@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: Pull request: u-boot-sunxi/master for v2024.01
Message-ID: <20231209134220.GA2513409@bill-the-cat>
References: <20231207135240.2070795-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8MFTg2JB2LiRfRMF"
Content-Disposition: inline
In-Reply-To: <20231207135240.2070795-1-andre.przywara@arm.com>
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


--8MFTg2JB2LiRfRMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 01:52:40PM +0000, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the hopefully final sunxi changes for this cycle:
>=20
> the first four patches are actual fixes. The last three patches add
> support for the apparently popular OrangePi Zero 3 board: multiple
> people seem to be champing at the bit, so I'd rather give them
> something real instead of people using random trees they found on the
> Internet. It's actually mostly the new defconfig file anyway, so the
> chances for regressions are very slim.
>=20
> Gitlab CI passed, and multiple people booted that on the Zero 3 board.
>=20
> Thanks,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to d2e1cc69a24719e9939a84dc42bdf281af6ec35d:
>=20
>   sunxi: H616: Add OrangePi Zero 3 board support (2023-12-06 23:09:17 +00=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--8MFTg2JB2LiRfRMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0brYACgkQFHw5/5Y0
tyzhiQv6A45ZVWEKORJ+6bohUsCjBAYCh2w8nThigXsaLKUrM/cVbTNmDrfau7xL
LfId0sDyJKXQ4s+O0daSsCO+s0LZK2nV32kQxaRKPjGQ0uaUYz75rlCji+OkshvM
dzePWMmgkDBNrYQCGfZs+yTifoOWvaQ3N8XHCT9Fc3jSQ6/B6TuU1tHz7Mwm3XkE
TVKQqBhQQks2T0lUqfzk7h8vHzbyou3TcdWjZrvxZfe4f/Jfvit5TOyiO89TNyxz
UZNZWf9/RswXTgaIwVnbPG3RDST23lwkObbKnBrULs+tW/cBOI3eFeZ/r74tFeSZ
kUL6y6LsWGpUOMnaXsLdxIQU+pilcLgFxyBR4KubjA6DibxLVfJv5ELHFgVChF5p
yuaCWGEpjrRLPoqqVjrYpXdsSIVcCtIQ9SyW1H5kvzAA5SUnc83gAp9Rg42A2plS
R1I7I1jcpYl2FNkzad69Lzr67AY+yMHpm6ISHuTuaulA90K/pFnz+IxsVuFpC47C
KU3SR6o5
=wHrd
-----END PGP SIGNATURE-----

--8MFTg2JB2LiRfRMF--
