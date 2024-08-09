Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C308FC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 05:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E341188800;
	Sat, 10 Aug 2024 07:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJmOXLtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7723688A2F; Fri,  9 Aug 2024 15:05:07 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A5188702
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 15:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcus.folkesson@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52efa16aad9so2687855e87.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723208705; x=1723813505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3sn4Wku2aA+se61+stt9/R5dAHFCliFoe1wsZcym+hE=;
 b=kJmOXLtFhSakc6DLCisKeHJA3QoiXP7dYNINwMCSotbS1AL0iNgYPzc2LvKkXyQMmc
 iv9tRb/Bc3JCqx/4wOjM6smDXj8PSZuC4Yr1as0MFXicCOmBveG04Qc+MBj+HfyxdGiU
 7TfjeEh4xQTeQd4X+GxGk/dnAjO97Ss3sKn650uwB1lhB6xJU1/YbGUWoAxBZaK/Don6
 Rx/gcx5eGFOY8O2++sUCUfLiq80SHzaHR5FeM0bAac+KFEMglDBbTLhGXx6mk5PHSE3S
 MajnX4hKZl+8l6JMEkolkcv1LyHZfO87kWSoawDsP/Sh1cQftrz2+YH8WV2NfQbFHRms
 DFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723208705; x=1723813505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sn4Wku2aA+se61+stt9/R5dAHFCliFoe1wsZcym+hE=;
 b=UPM/3i62Bm+V59eIGzhW7Gl77ly/LUuC1GshugMm5VeoYZrsKsHlS3abrSaREzdczv
 +HDq67Mjk25dsUb3lV2dZueCk1EL7QLforba+QW2fJYvX9raxptFKni9Dlo6HGG8CPbQ
 vPrHTYiWqjXZ8mZq/bPLX5FFVnx0xAjrGL2DinwyKDK7MWP4/shCUcHq172J5IDK2dhC
 smtuzzFRcBlKj9nTTR8prWf2L6khKQUM8qJEKNRVogZO6EKWSXhB7GB0/KKLlp6ouuqE
 CYXiYymd39zjohNpSD04W4POs2CPGeH42Kti4p0LG4n+czPuSQuyhnaSh9A3TAL8O9Nb
 46Mw==
X-Gm-Message-State: AOJu0YxidFCCBIAoSDlxH5TwwcETMAYnKjPD6xVgyN7Fd484nNUq1ZjT
 JcCgz2WNSJ4R3If3zTJRAHZ9a770jrrVMubOuCHdPZW4TkwebN//
X-Google-Smtp-Source: AGHT+IGksDbZwLGbh+W3xtpVjzmd15Gkbf333Mua3RW1sDsy70EIPRbJbmpZv9Ku0oBidJX98os7xg==
X-Received: by 2002:a05:6512:ea5:b0:530:da95:b54c with SMTP id
 2adb3069b0e04-530ee985dfdmr1078950e87.23.1723208704364; 
 Fri, 09 Aug 2024 06:05:04 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-530de4668c6sm980452e87.219.2024.08.09.06.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 06:05:03 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:05:02 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
Message-ID: <ZrYT_k1xsQV46j2G@gmail.com>
References: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
 <20240809-challenge-causation-20cf58794b33@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H1fG6/oD2laaHXju"
Content-Disposition: inline
In-Reply-To: <20240809-challenge-causation-20cf58794b33@thorsis.com>
X-Mailman-Approved-At: Sat, 10 Aug 2024 07:06:31 +0200
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


--H1fG6/oD2laaHXju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexander,

Thanks for fast response!

On Fri, Aug 09, 2024 at 02:25:04PM +0200, Alexander Dahl wrote:
> Hello Marcus,
>=20
> Am Fri, Aug 09, 2024 at 02:15:43PM +0200 schrieb Marcus Folkesson:
> > The condition 'ret' is always true as it is never set to other than
> > -EIO.
>=20
> Technically, you're right.
>=20
> I quickly compared with the same driver in Linux.  That has some
> additional lines for DMA transfers which probably got removed when
> porting the driver.

Yes, I thought is was something like that.
>=20
> Does the code before your patch throw compiler warnings?  If not, I

Not the compiler, but vim-ale (lint engine) is yelling loudly at me.

> would keep it as is.  The compiler will probably optimize it away
> anyway, and it would make future ports from Linux easier.

I understand your reasoning but not sure I agree.

I don't think it significantly complicates any porting and the code becomes=
 cleaner.

I also think that the porting become less error-prone because it becomes a=
=20
conscious choice to introduce and use ret if needed.

That is what I think, but I don't really have a very strong opinion about i=
t.

>=20
> Greets
> Alex
>=20

Best regards,
Marcus Folkesson

--H1fG6/oD2laaHXju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAma2E/kACgkQiIBOb1ld
UjJCpA/+MLq2L4+fyrVk9z7Z0TFNc4cvh3E4fN6BfAgky2aga9oR9nqE+DW8D3R0
UFnfjcisynK471fpCpsXtB+HpdRjBJGgH924wTEc2cSm9yeY5mRVSehB9oU86Jdx
9QRB/CZQ9qRz7Pvq7fi+0ThmbtnLxCogqD3J/g9xmTXuclc15MQN3UlGHPrQbWPv
igND8Q+XRxmUsDUHaxtl+aEcKQH4qwMjXr8cjolwpx6/Y/IjXankWJox92zkQtH6
Sz7rGW4NoRtbfa32wVPLMi+AqnnUB5nGAgKH0yJX74Wu1h30oYQbs/w67vfwScyV
dV95LwN4pkRS6430PzRFOIgUy36Fy8IJb8t1JRzw9XG7Mkb/8lZlrB1c8v2uOwpP
kp5P39bEEGyaAJeSg6UGgOzvVxEJjLBV+lvFIUg6/y3Gp3gYIru6Llyv+MDVPmEa
8lkJHICWquheWGw5yhZA/tPpXKkJmMNDHI6NXnpUgm398qH96n7USbsoIcZ/ykVb
XJXQ5wqpnYaxnMdcYDrAltgpmlMzo6PVR0JtuK04te5xDty2w8nx7XW/xJgEJ2FY
R/+h+DYPC1Q3KB2LPQqp3NJ3xqnF1ldE7O/P5Ik/U9toVoUnJViq3OcHRS/tKINl
67FkU8sbZsIhoC1iOdngJ9kYfxZlX8ySvYIvOI+GOVxzls79rEY=
=feFT
-----END PGP SIGNATURE-----

--H1fG6/oD2laaHXju--
