Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6BDE95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F6386406;
	Mon,  9 Oct 2023 16:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U983npx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986D286406; Mon,  9 Oct 2023 16:36:03 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 553A5863C9
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a4c073cc06so47054617b3.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696862153; x=1697466953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A7Vo5OzivvdYSe/MZN0yrYS34JuaTP9tqCVKnAdHgUs=;
 b=U983npx3rvQG1hZLEGvHGr3Neu0vTTsvAOefvbEzvi5tze6jiCvd5NQuWq5cVknvZW
 +CLSdZJ+5zUHfUQ0aAUh8ge5jMovcR3UDq4OhMfGIQXwYRmvSeanW3gnNC9U5Lj0XKhG
 dJASBQpM7vtTGSpOAAL4+2DZGucDcz85b9Rd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862153; x=1697466953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7Vo5OzivvdYSe/MZN0yrYS34JuaTP9tqCVKnAdHgUs=;
 b=nD3FfnNyBsv5MwpsarqIDfqHYHOtbS3fCWwKmpImlUAExArYDyK2rxUPA0IJ3xxzjo
 qEOP/z+SjfPQNVgeW8TehbIB96k6rfB/1kke0lQ/lm7UcsJz+Qmfofu7FotLdAYVjtlj
 zsEoHm+nm5vu3foDk5FPemz4OSxUOc/EC3jwGjh+fHxX7RmNz2UJjovdL0mY3kQ6UsLW
 3A6r1x5RB3Xga7R+4u4zekc3f+wVejvAr30plEMz5ziZ1Rlcrp7a06fLjEt88gBW2dyd
 jLdW1h8H5ttfY0NGz/KXIp477kl5la8KVAfQvHccVE29AXn6DoItFYU3nLD2ebS3xOQ2
 ekHw==
X-Gm-Message-State: AOJu0Yz6oBNKZwWsQ0K7RRBExtOzE6ftNrRdbyyjPDRMHE8f3uxcDYA5
 u0ylKgh29cyRGNHRv8xGzoq10HNuzWNoMsl4iX/w1A==
X-Google-Smtp-Source: AGHT+IHGloqiinRZLjThvyy9h5BuSzVHLgIkemsjnkl/IFnN/gM3P40FjJxGzt0ux8L+PlL0e95cuQ==
X-Received: by 2002:a0d:eb85:0:b0:59f:6404:89b5 with SMTP id
 u127-20020a0deb85000000b0059f640489b5mr8606831ywe.9.1696862153482; 
 Mon, 09 Oct 2023 07:35:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fae2-bb7a-3833-e7d0.res6.spectrum.com.
 [2603:6081:7b00:6400:fae2:bb7a:3833:e7d0])
 by smtp.gmail.com with ESMTPSA id
 q66-20020a0dce45000000b0059bcadded9dsm3719620ywd.116.2023.10.09.07.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:35:52 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:35:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20231007
Message-ID: <20231009143550.GJ2227687@bill-the-cat>
References: <20231007102658.568693-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OjVOFj8QOptiy4F4"
Content-Disposition: inline
In-Reply-To: <20231007102658.568693-1-kever.yang@rock-chips.com>
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


--OjVOFj8QOptiy4F4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 06:26:58PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add Board: rk3568 Bananapi R2Pro;
> - Update pcie bifurcation support;
> - dwc_eth_qos controller support for rk3568 and rk3588;
> - Compressed binary support for U-Boot on rockchip platform;
> - dts and config updates for different board and soc;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18047
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit be2abe73df58a35da9e8d5afb13fccdf1b0faa=
8e:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2023-10-05=
 13:26:44 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20231007
>=20
> for you to fetch changes up to dd8d52c934e8858264f91e8e8e2d8c7d8b059dd7:
>=20
>   rockchip: rk356x-u-boot: Add bootph-all to i2c0_xfer pinctrl node (2023=
-10-07 16:52:48 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--OjVOFj8QOptiy4F4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUkD8IACgkQFHw5/5Y0
tywFuQwAgck9N1GzQkfQ/l/SfhKNBKzVWYh+hs0dSVeSRDQaYNTxT88tFoxBTpV0
z+pohs66ix8LBcwEePWUAuwKxY1boNDad+ut+nnP268yK0AvqmwSAOc4CIB2r9Yk
yTpjUp/rmhyRMckx0ykUEAIZgkz4VpLDPerzw+QgBOceLEB9y78YZLHuNwdkjK0z
kpc0MH0BebTBwvEhYahwzacCYe1G94poJBKmgb9uAgxwa0C3g+0G8hHlkmpsSWSH
Vn6UZ/NUq/7rKjRJaEMUUlz8rDsK6RXDbPOBHwHJ4OKPg9Rn1PPtq57psA13FRIv
yCqePGDw0DUY0oQ8fxeOm/4a1kAwNZVz8gmpxR3snss2vG7aSXRwXNLCOsPigYbd
IxdfKTbRVzupY7HLxg7/eBvQrifbx1LFN3szPi37gh/YiVNtOzbPVf6xOuLC3PJr
RPKcYqcP1VaBfvJPPoHn5YkUCWmmTWwb9yxhWphOiNdjXMIfWNhE1OlVoEfOB6KK
rgPOb46o
=fLHt
-----END PGP SIGNATURE-----

--OjVOFj8QOptiy4F4--
