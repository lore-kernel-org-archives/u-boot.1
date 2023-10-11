Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A8DCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40A086CF3;
	Wed, 11 Oct 2023 21:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dQ361xpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6642F86DB5; Wed, 11 Oct 2023 20:41:20 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888ED86DB5
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7a7e9357eso2111857b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049477; x=1697654277; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mv/ZsVZGRij8vy5ZK0LnbTgV3fGBymk4GSZ9GBURKdc=;
 b=dQ361xpreQOR6R7ye5r69/3hx2eeisbqYXZ7a23MJ/RrjNvj0PwAqeqozEweJNNXqq
 V0coeTYVzdVk/XO+dEqbWXlM+7Gsz6AWssq5Hq0AvGtvJujc+bwImivb1SeoDAimy+kb
 jXRws21lbBDeMSzQaCRFFBWTG4ZCYiM/3FEFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049477; x=1697654277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mv/ZsVZGRij8vy5ZK0LnbTgV3fGBymk4GSZ9GBURKdc=;
 b=bRYaRmnCtnZm4cRlZ6gA/8Jl9JFdsCe2OGEJVAWypvYDSCuqnqDIAiQGXp8SskJFlr
 ow0F/sfjIKEh1CEiTSACtBH4j+6G7ivs9+AUwJMUKUHCnJndivRzZ3/WfMFtRpAiYZn2
 t3hO6nr7mAk5Z6NA0+TGCe517cISlBv5LgRAVAnC8INurhxSEZYdyTTREUlaqIWXpoDA
 AeK7VZ41xfokK7sKFzh1RNFV0Wd3ZA4U/lOw0xX6+9stgJQajiPqn2nksZ+MwUp2KMKc
 Y/BB62vnp+t+IZeUcW/SnN/7BwNWVKMT6cpHdyk4GhkwtRpD9pQUfxG5m1d399Viq59P
 MXmQ==
X-Gm-Message-State: AOJu0Yza8OZF60VWTxwIJHnQkBzf6obTpU1vE/lbIszWg49mZL0EGNT0
 PnGs6TUvLfHLfrOQI+yi6eWPdw==
X-Google-Smtp-Source: AGHT+IHv+nQUpXpx6umENWzBADKB4xMTLByqPLKCoZwDtB7UnDvLXu1hB9yOc0B37RDXlHUrU/1Y3Q==
X-Received: by 2002:a25:e7c2:0:b0:d9a:4d90:feda with SMTP id
 e185-20020a25e7c2000000b00d9a4d90fedamr5844055ybh.62.1697049476808; 
 Wed, 11 Oct 2023 11:37:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a258911000000b00d749bc5b169sm4557816ybl.43.2023.10.11.11.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:56 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Peter Hoyes <peter.hoyes@arm.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] driver: rng: Add DM_RNG interface for ARMv8.5 RNDR
 registers
Message-ID: <20231011183754.GZ3119521@bill-the-cat>
References: <20230830113230.3925868-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J/Xu+zFdtH5Bu1Nu"
Content-Disposition: inline
In-Reply-To: <20230830113230.3925868-1-andre.przywara@arm.com>
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


--J/Xu+zFdtH5Bu1Nu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 12:32:30PM +0100, Andre Przywara wrote:

> The ARMv8.5 architecture extension defines architectural RNDR/RNDRRS
> system registers, that provide 64 bits worth of randomness on every
> read. Since it's an extension, and implementing it is optional, there is
> a field in the ID_AA64ISAR0_EL1 ID register to query the availability
> of those registers.
>=20
> Add a UCLASS_RNG driver that returns entropy via repeated reads from
> those system registers, if the extension is implemented.
> The driver always binds, but checks the availability in the probe()
> routine.
>=20
> This helps systems which suffer from low boot entropy, since U-Boot can
> provide entropy via the generic UEFI entropy gathering protocol to the OS,
> at an early stage.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--J/Xu+zFdtH5Bu1Nu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm64IACgkQFHw5/5Y0
tyxTtQwAnDNdSKriIZ6RCpEBWRxSvdCVnVdbEFPvZjqKsx8zu+M4Oazi+mKu9p4d
WNFZ9Fyjedck0r6Kj+EOEXmvFjfjXYikaFKilQibdEH70vPwXDh9t6jeqJV3FGEe
DpJk4JX9Yrb6n0+/BdyooGBuJt9J+yPkEZdYDgoF8lVxWNK9Ru40SoDxl3sFPXFT
ur56EtzbRdeGlXIo5LWTfTLxW434OtCmhDHmEZYyjIFGO6+QBYYddjUj+/RCbgef
17F5WMjcGyT1lm4OwSzat+YHzo26gRbb9OrQZOCZdx7CUUjP6Wdal8um5G/JrsNI
OTO1vmWg/CIW62P+DMuTWQCV2+59J3vEzdVYLRmKJNuTmFqPEe1rTtyNuzepMyyn
WZE8LtjjqzHtDAiwQdUxqb+HEELvXrxozaGwGvTFIAiQF5A9YJi01/XlgGcp+nAa
Ya5CREt8G9RN7Z9G6nABe/VVvo3sCj0AwHYv8jEbZOuo6bWin6a8stecKi4UevPT
Mf3w4MBW
=6mQ2
-----END PGP SIGNATURE-----

--J/Xu+zFdtH5Bu1Nu--
