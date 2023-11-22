Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ABFC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A78198766E;
	Wed, 22 Nov 2023 21:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aB4fSlAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5868765C; Wed, 22 Nov 2023 21:49:40 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE7D687655
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-db3fd3e971cso212015276.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686176; x=1701290976; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=osWKaUbRxnQzzjsWlI5wAzdBg2Zdht7RSfSLMC0qrpI=;
 b=aB4fSlAF+4KfSH7+J5mVxQbzOrLDZduezKhIIZZChJvqFwBcCvLrHJBpVjDKf/oPGE
 X1+SdBizYsxKEpmmBH+UDvXOGCCXV7UL9kO/yfMTycZ72CiwtfpWlxeoAFc1DLoj7NuF
 SwUedr2bvRJYC2719SbOmzPwkyghwX0F6WCQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686176; x=1701290976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osWKaUbRxnQzzjsWlI5wAzdBg2Zdht7RSfSLMC0qrpI=;
 b=YjrUNLI9ne49MWqRNB3zPdaKWr6QaZ1DefHg/iM/Tf3BkVJ4zEMxT33Lq5eu7MXfrv
 o5HjI/x0uDBydpTCEaoQHS5SH/aZtS095xCOzurEW25GJsgUSl7rurzXy5FjUfajVI4O
 5gY9M3G+FhXOlk21s4xD+TWg/7V+3FGyUS0nhNBlfzHRD74NbLi3O7bYQUSsn0u/JOxo
 1PPhkAs9S9jjep/peLZKoX4W7pJ9KLcMbp02N3iBJK12bDHdveRP3rIpPALjSCdVyew3
 dZAqmAiyBGD+gFf0TK+qQjyLs1RAgSVOrdvdQXkUsZdt4APOmmAUITzRf+GkciIAuo23
 1G+g==
X-Gm-Message-State: AOJu0YwEYHiecCm9DR37aVGWKYM9ZP/PAgILRft+dDs42/SXa2AHG9u4
 KwDhKyvcYu4QvRBV1M1c3jHb4A==
X-Google-Smtp-Source: AGHT+IH1SPMTwNSGs9ThAamXRNVJAA5TZcWoodu94jk0h1fzSQlrzuyUhdOwDEl/jDCR5K/QUWMIDQ==
X-Received: by 2002:a25:820d:0:b0:d9a:e815:38f6 with SMTP id
 q13-20020a25820d000000b00d9ae81538f6mr3438428ybk.15.1700686176439; 
 Wed, 22 Nov 2023 12:49:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 a82-20020a254d55000000b00da3b52e3cf5sm1571656ybb.10.2023.11.22.12.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:36 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de
Subject: Re: [PATCH V2 1/4] arm: dts: Add k3-j721e-beagleboneai64
Message-ID: <20231122204934.GE2513409@bill-the-cat>
References: <20231104081103.10607-1-nm@ti.com>
 <20231104081103.10607-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iOOAR2IGbng+dfc9"
Content-Disposition: inline
In-Reply-To: <20231104081103.10607-2-nm@ti.com>
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


--iOOAR2IGbng+dfc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 03:11:00AM -0500, Nishanth Menon wrote:

> From: Robert Nelson <robertcnelson@gmail.com>
>=20
> BeagleBoard.org BeagleBone AI-64 is an open source hardware single
> board computer based on the Texas Instruments TDA4VM SoC featuring
> dual-core 2.0GHz Arm Cortex-A72 processor, C7x+MMA and 2 C66x
> floating-point VLIW DSPs, 3x dual ARM Cortex-R5 co-processors,
> 2x 6-core Programmable Real-Time Unit and Industrial Communication
> SubSystem, PowerVR Rogue 8XE GE8430 3D GPU. The board features 4GB
> DDR4, USB3.0 Type-C, 2x USB SS Type-A, miniDisplayPort, 2x 4-lane
> CSI, DSI, 16GB eMMC flash, 1G Ethernet, M.2 E-key for WiFi/BT, and
> BeagleBone expansion headers.
>=20
> This board family can be indentified by the BBONEAI-64-B0 in the
> at24 eeprom:
>=20
> [aa 55 33 ee 01 37 00 10  2e 00 42 42 4f 4e 45 41 |.U3..7....BBONEA|]
> [49 2d 36 34 2d 42 30 2d  00 00 42 30 30 30 37 38 |I-64-B0-..B00078|]
>=20
> Baseline of the devicetree is from v6.6-rc1
>=20
> https://beagleboard.org/ai-64
> https://git.beagleboard.org/beagleboard/beaglebone-ai-64
>=20
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--iOOAR2IGbng+dfc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaV4ACgkQFHw5/5Y0
tyzf7Av7B8vUa3YZkvMQq2aQOBOsJIAoFE+YaDxQukIk5T31rOSNefnPhw+J/UTS
K7dJq47CjBp3vWvwHPz7EGmj1jY1sHm6Q/y4rhvgNcbiZ1infgzE73sWBrkIKCy0
Jl94JDey8/WMzAJ6KqFGRpsL9qBHy/I5hb9OrjzmTKSs3FOoeE8tpTOz2ykW0vhQ
DLF0mbQJsIcRf+Cu5j0VmZJVQacCC+M/rriNb2/7hCkyRCuKBL3jcZl0/DSALCrs
ytqF8XSBTbX3az9DBj7nbaQGI+JQmFUszLRnVscbwXQNf4kHSo1gxJEorX/kPT4o
fgFsDuQlqv9IZj4VQySl7R+rX2dPxS5+Wyu560OxR0CK/zf1NJxpvEN5jcVmrJWd
jeZHnsYGpKyLVyR7Lh8QkMAylmjjKGIVgp6oD+BV57des6iLKBufzZSgu74hmlvV
StkCg4OmVbBgHYnUnnjkaCFeKLyZRtFBZ0JLuR+/kKncgdmjwS3qrH5jXSZvUnDy
GqIo2BwB
=g3ga
-----END PGP SIGNATURE-----

--iOOAR2IGbng+dfc9--
