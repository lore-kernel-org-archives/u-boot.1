Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCF9C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E9887BE5;
	Thu, 25 Jan 2024 17:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d0DH9gxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB8E87A2A; Thu, 25 Jan 2024 17:14:35 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCD787BCB
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5ff84214fc7so67361917b3.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199272; x=1706804072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6JEiDuKYBdP85lx4GQ4ZkYIDrlOGGu9N/q6PcdyYZjw=;
 b=d0DH9gxcn3ZRb9u7Lub/GQhKFMCLIluAotFqfjjbA7B4nFiU35GlDCW4fLOsnTUItj
 bkZS/aaq96FlZVG0iIAkBx2prGlLjfNAuy5TZtivDkSY5xOFuaiVEQW9G5ZdPxmeRsTS
 rCV9iiO2EmDSy//yS28zjXH5urG45iZDTSoZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199272; x=1706804072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JEiDuKYBdP85lx4GQ4ZkYIDrlOGGu9N/q6PcdyYZjw=;
 b=kpTQTYvknA9UXpmqMAOBxsU069lae81jJvJ7ACd2vypK/48VaNwLIH//d53fivlakO
 +/S2nghyB9r1VqwKHpA4yN2BjDY6gphtVkkX/eqiTKNzEDW9Ixvdbe3rdSApMRIBtevz
 jmSgkUWdrVh8inP6/eX2k5b8tYNTu3EKfsxNFOLg2zz/6Polar+PBghTlv4IZDnqU0M2
 CzMw0KNewpo+TVGjxmCUZr4yBXiIqOcY5IC0DbmOvHcQaRL2rk3RxmdMqFZNmhdRtWPl
 qE8MF2Me30dVmenjjN99FctDtXQGJi86At7qUPY2eSLP3hALsKMBGqErht/mzu1zSlK3
 +lYQ==
X-Gm-Message-State: AOJu0Yy0v+nW6ArWs95lDx3BA/F49HO2zJ9GAHB+5yOZcSOPU8zp5O9b
 SO/RQ3rBnrKy3W8KvCv9Dx9Mtgf37RhOLHOHB/44w8ulx+ghY3oUC1D/nEa0V8A=
X-Google-Smtp-Source: AGHT+IEw7znGxFGf8AWDL+RcdamcRzFynj+LuZ2dfMZ4ZVSN0ab6I9YAtR3EhNh7R35RFHtTDAUqhw==
X-Received: by 2002:a81:844b:0:b0:602:c59a:7cc4 with SMTP id
 u72-20020a81844b000000b00602c59a7cc4mr41247ywf.7.1706199271883; 
 Thu, 25 Jan 2024 08:14:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c16-20020a814e10000000b006029c8adfb1sm745640ywb.61.2024.01.25.08.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:31 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Max Krummenacher <max.oss.09@gmail.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/4] board: verdin-am62: improve comment on usb phy
 core voltage
Message-ID: <20240125161429.GQ3652023@bill-the-cat>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
 <20240117101743.3955852-2-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yKctvGrxFd0K8unC"
Content-Disposition: inline
In-Reply-To: <20240117101743.3955852-2-max.oss.09@gmail.com>
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


--yKctvGrxFd0K8unC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:16:46AM +0100, Max Krummenacher wrote:

> From: Max Krummenacher <max.krummenacher@toradex.com>
>=20
> TI recommends to clear the bit independent of the used voltage.
> So the comment which claims to do it due to the core voltage
> at 0.85V is bogus.
>=20
> See https://e2e.ti.com/support/processors-group/processors/f/processors-f=
orum/1252724/am625-usb-phy-core-voltage-selection-and-vdda_core_usb-mismatch
>=20
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--yKctvGrxFd0K8unC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiOUACgkQFHw5/5Y0
tywIhwv9Gukwje+/6D0ACd/6yKDKsp+sjmZHkmg+yr4wyBYlOfsz09nK86is+jXw
nBZoX8i/SYz2/pM0LQGOogaa5TXM528jhEOfXEqCjIymTKqy767rPNOELR1mhmKo
vk4X2k7bouFP5L8QyhtXLLJm2HLXVgJ9M81cD4c+siGiSGD9MEaJhZJ0ihRAJQE4
dinNqwvhQtSC2uvB3oXSE/Z6Woid1VqSaz8Hpvb/0gATt7QYh0bddneYLOdoiOhd
vKv587aYh6TWgDYdp10e7JpLkHKK74+/QkHxRttnKT0cMGCnSnh60LCOexO1pjRi
1K5ndUfamlmGN6LtoAw3zmcJZ7nKVQsAY/umz5ZEKNVPM8yvB/DQ1Bh+O03VGc1D
1tmR8ne9UoboEA//YdCIHVx6KGcs/8HCUZy2WdgktFS7V5OPX17j1cza/1+F6VHG
dst1UR1zl5mCRYXfrPbUjKAWiqf5Om9lpyjRcQXI/Sx5FZGsTIE0kjPGt3uJdQzH
1wjtXiAG
=8bIR
-----END PGP SIGNATURE-----

--yKctvGrxFd0K8unC--
