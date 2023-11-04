Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F414DC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 13:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C90086A4C;
	Sat,  4 Nov 2023 14:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vz6QXz1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4AA87049; Sat,  4 Nov 2023 14:57:16 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C9B8708A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66cfd874520so17801436d6.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699106228; x=1699711028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vszw6d1P6CHA+Zwxe7nzX9TpY3gaG6Euk1zUqvxNVdk=;
 b=Vz6QXz1xQD0ihIHLPr6Cdiah03oFMQgGkjLT3l8PqSJp4ffbhFDx826WpRBTQGSRgQ
 BBNu6lQ0MGzf+eRlxQVCDoLlIEcxMnNVKcfa4UE1yiIwqZPf4SGUmyJE7w9+D8x0+33a
 NnntqRe7cyhIn37t+cdcLwDL28sPOqCEjRUI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699106228; x=1699711028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vszw6d1P6CHA+Zwxe7nzX9TpY3gaG6Euk1zUqvxNVdk=;
 b=OTWip/wVVucTz6uTNx7Wn4ecLhi3yE9Rch3ziBXO4zLhGqsW6KKE5zUu5V5k18Btry
 wgLE3pAKB4XOqf4P0LgAwtPnYd7yJ963gfnJyTuwxeDYGS4jdKAJ0VKlcgJzONRpFP3y
 Sk0wqHT04ikyrhkJJOi5zaqZfJB838GMw2aT4w5F5tTHpArAuZodgrkB9Yuzk6jIyndm
 k3GW2m6nogedGO16p5+Nc0kHjeYJxsQCSrMuM/G/zXPvKyxP1bHNsGrh+H9PM4PatmuM
 kJ8NacM+iEKYhi+fJLwkoUQYZQ3eTZyOS0zIU6lFl0tqdRqXgFWHeVOQ4Wu7oxKepTzS
 YIPg==
X-Gm-Message-State: AOJu0YyG5gHuHPs3uerAkjgXvOxPDASeCeufPQMboXdlyY1aDFFgvdw6
 0nRqUnFOfe02kD5dwx/QqEJjHw==
X-Google-Smtp-Source: AGHT+IEndbPeloKMilfOA6ElUFoi0rTlXOcmf8KEQMbR4wPWkYJEDC/vglZoJv6eIzLW8xAkMqomvA==
X-Received: by 2002:ad4:5761:0:b0:671:6003:73b1 with SMTP id
 r1-20020ad45761000000b00671600373b1mr25877770qvx.60.1699106228280; 
 Sat, 04 Nov 2023 06:57:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 e14-20020a0cd64e000000b00674648411b3sm1668188qvj.132.2023.11.04.06.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 06:57:07 -0700 (PDT)
Date: Sat, 4 Nov 2023 09:57:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull qcom-next-20231103
Message-ID: <20231104135706.GX496310@bill-the-cat>
References: <20231103134946.365001-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5w+Gm5jzv6u7oKPa"
Content-Disposition: inline
In-Reply-To: <20231103134946.365001-1-caleb.connolly@linaro.org>
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


--5w+Gm5jzv6u7oKPa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 01:49:46PM +0000, Caleb Connolly wrote:

> Hi Tom,
>=20
> As discussed, here is the maintainers update for Snapdragon. Sumit Garg w=
ho
> maintains a few of the Qualcomm platforms in U-boot has also been added as
> a reviewer.
>=20
> The following changes since commit cbba1b7766bd93d74e28202c46e69095ac1376=
0b:
>=20
>   Merge branch '2023-10-30-assorted-general-updates' (2023-10-30 16:01:54=
 -0400)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git tags/qcom-p=
ull-20231103
>=20
> for you to fetch changes up to 48eb294bec471d5d4e176ad030671a221f307074:
>=20
>   MAINTAINERS: update Qualcomm maintainer (2023-11-03 13:17:50 +0000)

Applied to u-boot/master, thanks.

--=20
Tom

--5w+Gm5jzv6u7oKPa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVGTbIACgkQFHw5/5Y0
tyyUSQwAqFARQeCqYTt7mzlGmLr2WT3FuRv13vhMnJoIzIVWJXcHRlCFJ7zBYqID
EBbGHgZXKdJjCZzZXyxzHjh0KQkEAeSrEaBTUSnzdztm/iPiAA5v/ECs++T4KVba
H50PFSNXAdb8MKZIL30tlRbaYdJsjRx2cPACiZJ50lnUMMd6stS8/clirAXb6Z19
+NQ5iZ0H3DErL4QGLqIqcTKvyUITqhWINkba4AWS5TFnfhNuLHMm73Zyg4OtMIsW
f98OI5FMXfCVjH/UY+wxewgfq3+yDm6y1g0B4EP/BYAaIY+qFrMSSSO86hoUBfAu
lkSSTqAxsJ4VEd/dAhXmUoxuZlssvPiCzgHq5QnfHdmqSKYaP3Jv37Jo3l4HFaCd
zrmVLCcCkHUMKV2MPDj0oXLcWil2GsoY7/JOhRqxIrSGCCdMI3ayfFJlkZDaheIb
k7iW41iEexvapki130kCRy25XyXtgMaAFgPpOyMwYjOqBvucMTe9dgbccOKnvCYt
rZLmM1uL
=3k5b
-----END PGP SIGNATURE-----

--5w+Gm5jzv6u7oKPa--
