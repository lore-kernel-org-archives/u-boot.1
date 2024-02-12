Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54564C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 18:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1967187E78;
	Mon, 12 Feb 2024 19:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FU0joT6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D3687E96; Mon, 12 Feb 2024 19:40:39 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410BA877D3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 19:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-60777552d72so5300547b3.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707763234; x=1708368034; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1wLFGjWo9164ywA0Yuua1KHnXO4FM9BY2oVKZKTXNTg=;
 b=FU0joT6hDvTCRiUFanxJpNJ5wwzrSFUU37q6kOY9M5yMSXkvpemo4L25fDqWzRolEz
 ZZ86VbLayaJVBJJf8GpnYXG4qSndAiqoZzpfa2EHCQGFIlooTVnCx1mLvdVSnFh/xIcJ
 RkXLpxzkkhxH++CICAknYZHXpy8sEilEkcDmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707763234; x=1708368034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wLFGjWo9164ywA0Yuua1KHnXO4FM9BY2oVKZKTXNTg=;
 b=Kk9BJUS6R8co6uW6ZU89Wkd8leTejQ1+I2DcWBMwvrFfM5r847DDrWZ0UVDQduGHUw
 zvOo1ojsLZvc99vueRhVNMDCTgUIJ2d6RKpQqczDB5bSV3ZuenwhOXbcou+qKQW1mDH3
 0yPwQuIfnUrDZtbsfxzpl/2yBBQyaY2BrRXgIF3GPDHJ8A0OHoASD5NvT/AAUzcBtoDJ
 0KvIjK9y7KsgSsQGi1sj/73ggB5FvrUnkKH/G6U9I0p6Z2IgMcR7mgnhw8TupjK3etl0
 cgBouKNlehgi2SNYfwqXL0ZJLA1txxxKRJwEAZyLhmoXFJRR9c7JeEHRWIc1UyaNLMzL
 0kqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl+7QW37w4HVknSvAXHloT1lXorjL+0U3rrGGfp5ceF+BVkR5WZhCwu2ao1F7F9rsU25YHzrhqxQ7/JMBQClk6TSki2w==
X-Gm-Message-State: AOJu0Yxp5PjLMCBxFxWhXH95AfW7Tv9PsWzyUJDMHOIgTG2k4kglIb1U
 utlZ3sE1GqBLFcGWwUv21yIRsgEJe60cM1fvYzI9iqG1Y6A3pt0AC37xq7KDHnc=
X-Google-Smtp-Source: AGHT+IFrszcQJzbQgFltWUbNnRjPZckHQ3MCDx1uT1l+7ZHG3YHIC4AnTXO5If6vWaHog80MUX7xsQ==
X-Received: by 2002:a0d:e4c6:0:b0:603:c656:5e31 with SMTP id
 n189-20020a0de4c6000000b00603c6565e31mr6698157ywe.28.1707763234189; 
 Mon, 12 Feb 2024 10:40:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+kus/r38xYKSX5xFfs1Hnw0NWY77O/7oSyHNZwk732fLxcvS1nxScFtaHrLX/RrdStJwZWiFaFvWlewZV0lUcihmdsN3xm8+7w7e/tgac61jrjrMeRJG2G77HSDNk8MSXhHCHoNnTIy4OsrVFT6bAW48=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 l8-20020a0de208000000b006048617fbecsm1296203ywe.30.2024.02.12.10.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 10:40:33 -0800 (PST)
Date: Mon, 12 Feb 2024 13:40:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Nils Le Roux <gilbsgilbert@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] net: designware: Support high memory nodes
Message-ID: <20240212184031.GL3040305@bill-the-cat>
References: <20231202093952.33256-1-gilbsgilbert@gmail.com>
 <20231204010930.071a5ba7@slackpad.lan>
 <20240210173703.73d18367@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6a3inNSG6t0RjnUy"
Content-Disposition: inline
In-Reply-To: <20240210173703.73d18367@minigeek.lan>
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


--6a3inNSG6t0RjnUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 05:37:03PM +0000, Andre Przywara wrote:

> On Mon, 4 Dec 2023 01:09:30 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
>=20
> Hi Joe, Ramon, Tom,
>=20
> for some reason patchwork put this on my plate, but it looks like
> genuine network code to me, and the problem definitely doesn't affect
> sunxi.
> As tagged below, I am happy with this change, so if there are no
> objections, can one of you take this patch, please?

I believe I delegated it to you since Ramon doesn't often have time to
put together a PR, and since it seems otherwise fine and relevant to
platforms you're the custodian for, I was fine with you grabbing it. But
yes, I can pick it up directly instead.

--=20
Tom

--6a3inNSG6t0RjnUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKZhwACgkQFHw5/5Y0
tyzDlgv9HEkI6KjwseWBp7pYLVlAB98aRcixTYhm6H/fVf/9zSPikB+OiDGG9NyT
roBzocN9gBktTTpPa/+SnlAstsNxSkfkTrb3DYEARCoZnWmM7DbyjELVNDB4mpBq
vbV1HYYiJpnvP7vt4QAJ2RhnSNg80IdHwmDLyyRGq+vzHlWRBhb+wMvrjOhtXKJp
v0vxBB2stcGpCjsDtF0BU9KEZ2yUtNjR1ghtED1GYZFQeflhca7BJyF7a7Fv3dsV
/rT6hmyYI/Xyd8yx0duECJh+pfPSPk6K4UXHkmf3HttQ1CjxAD1Q/H24diHOtGjo
JlYdvbTHnyW3qCzwMtL1Zk4sVALn/rDeEj0TjHXaDt5xSRbMtsDh7O+saWgEz5WS
O3jkOG/IGfWFIVyVTcrP8tHsaHBgeCf//Mpu0za5UVQ8wiDCxJLwhM4OGJHhdpV6
I85kgWINL8G4PFY46bwZrPwTMvbzcKiOCwaVl1seTPKCkZuL3ZNMQYUM5lVShIni
hcLmRQi1
=eDKd
-----END PGP SIGNATURE-----

--6a3inNSG6t0RjnUy--
