Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4FFC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0A88774A;
	Mon, 27 Nov 2023 19:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BxXMg6zD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516DF8774A; Mon, 27 Nov 2023 19:37:10 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFE08761B
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dafe04717baso4041174276.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701110226; x=1701715026; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m980Otq7AY87iON7e0fUmOlVmJt6+iHL7aka1AjC9rI=;
 b=BxXMg6zDIUqUP+xV1M3Y7HEFxj2GMfdsdo4ljo4G4Xx5HAWY1JtKiy5Jg1oK3CfBBX
 IVcCaKdr2ZvWly0kAvVBxOHe50AOIqI9WDzAVfKvwHVHl2rPNKfGvCBro6/7wQJi1on/
 EopefUaW5eKgN616CU/BUCFidp0M5/86QHzwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701110226; x=1701715026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m980Otq7AY87iON7e0fUmOlVmJt6+iHL7aka1AjC9rI=;
 b=eg3fKnICKiE274Ji7jfrvxWqbH4hPNjEj4045FVcJKoH5mrzMtCCSnIEFztuxetql9
 UUZlPvf6dcJLPwNIbrGMvSsWIVLodysh6Js+aZ9lAwVPJCLd5zp/dRLMC6Ttf14wqQ4l
 tszLP8KxMttlWz2sqMX9OFNcKHEjUzUgonLZIlHbdEcXeww7ZSZWl1b/Ueju7qNbVIR7
 syryyzv9zPeMjdyQz7W5Ea8RYUp68vhpw1yBotvDQp1F722f36G4iq7xGeEXdjq1aTBl
 8RYK0L4/7/tUYAs/wGlKr5EzqYRGbgyybWzMJjPQ+evb+Co2ctKJBqEVeywX4b3ItvoN
 bXAQ==
X-Gm-Message-State: AOJu0Ywo2BhQ+12T+bfkRH5uEHmX2oHk31owtRuNDlgZbZu7NHuo+DqI
 LGidq+N2f87XZfcBDTlSpSYIfw==
X-Google-Smtp-Source: AGHT+IGpWnda2GHMEdBgPjQKlVq7up/4e/eTu5+JhabsySwp7jEcxgrmeU2RVgLLEYHYDsG6zFeXnw==
X-Received: by 2002:a05:6902:309:b0:da3:ab41:2fc8 with SMTP id
 b9-20020a056902030900b00da3ab412fc8mr10630386ybs.16.1701110226696; 
 Mon, 27 Nov 2023 10:37:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a25f442000000b00d7360e0b240sm3198332ybe.31.2023.11.27.10.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:37:06 -0800 (PST)
Date: Mon, 27 Nov 2023 13:37:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
Message-ID: <20231127183704.GV2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R5EdD4TLg3bZWTK/"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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


--R5EdD4TLg3bZWTK/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:56:43PM +0600, Maxim Uvarov wrote:

> Hello,
>=20
> Please find updated version of lwip patches. Changes are in the
> changelog bellow.
>=20
> Thank you,
> Maxim.=20
>=20
> changelog:
> 	v11: - v11 is mosly respin of v10 patches with CI error fixes.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gitlab CI:=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 https://source.denx.de/u-boot/custodians/=
u-boot-tpm/-/pipelines/18368
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Azure CI:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 https://dev.azure.com/u-boot/u-boot/_buil=
d/results?buildId=3D7366&view=3Dresults
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (Azure CI, which is connected to github. =
Sometime I can see
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tftp timeout after some part of downlo=
ad there, but that can not be
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reproduced locally. While Gitblab CI i=
s stable. Because of num tries in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CI I suspect this CI was not always re=
liable.)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Azure and Gitlab also have different tool=
chains and I=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 would say Gitlab generates bigger code th=
en Azure CI.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Also many boards have a binary limit size=
 of 800k (even
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qemu has limits). And increased limits to=
 fit all the code. Specially did it
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 patch by board config to show which board=
s are failing to build. There I have
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a question if we really want to support n=
ew functionality for old boards (mips,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arm32 and etc...). I hope board owners ca=
n help me if
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 it's valid to increase these limits.
>=20
> 		In this version I used git submodules and friend CI with
> 		submodules. But I don't mind if you decide to maintain it in a different
> 		way.

I just want to note that generally this is a good improvement on v10 and
I'll give things a spin in my lab (am335x_evm excluded ;)).

--=20
Tom

--R5EdD4TLg3bZWTK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk4dAACgkQFHw5/5Y0
tyz4fAv/Qy+NTAhK5f3X6MLW3Qjrv2DTFScXlW/8wJ//ANM6hr7rW22W4NjLzN5U
tlO+lx2x4x3irC0gE6hMEAAR8iNMH5GsOYcaIYcwaoRthdGg6WgUlWMDQu0Bb+Cz
mJUknJU5phcDetoVzPtcOX20tzZkjHKx07Ds2Fu/NIdmQwWm8hdWJWkv2xvJaVpV
0wwebrTUqY/4O77WScs7V5BakoPezhxE9WXdAd/M4C8ypj0nFGeQtelVEkMlGhbC
oJo69cAn9V30WIKGHHmiFKv+F8RUFQm0eLJpXJNtOdZDe3ut0XY8CKSfpN3tcJt5
YR/+FjP3jHMVa1EntqCx04OOoeaSfSXJ5tdgeP38xkwyQHUtjkHOrE+TXBnnTAPN
HRxeGBwjnHtKSA6saKfJRC8fqJIhegcgKUxguA8b/gVCYzyebZA5ZAYQiWRds4dH
wSyQN9M2xS7E1B2wR043jdo0w+krwZHtwAPBefGSjiuQ3bAtCCHETDjzClAEHrEk
hqGyP24h
=kixB
-----END PGP SIGNATURE-----

--R5EdD4TLg3bZWTK/--
