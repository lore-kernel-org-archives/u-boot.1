Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BA3C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5AB8783E;
	Tue, 19 Dec 2023 18:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HCfiw3gR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E20787824; Tue, 19 Dec 2023 18:46:58 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C7B48781D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d226f51f71so40235347b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703008015; x=1703612815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q/SxhQj8COCgIA+VOFV/k/LVo8d2CR2pgqu30ApOEoc=;
 b=HCfiw3gRtj8xAmhWpWD1NcBvB5kc9IKO63g33c/3c7fXOzbtrO4YQcedfrsCI5wYZf
 nYUnhw6VUOZKzkzeF4UWKHgYs0GaFhW8fmmoc2XlNu5v3uy0TaTlig2pDPNJ40+svaLt
 F8AmuCaBBBxMp9v2VYSwvKBmuBjgu7pw6GvAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703008015; x=1703612815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/SxhQj8COCgIA+VOFV/k/LVo8d2CR2pgqu30ApOEoc=;
 b=keOm4D5uQJL6U26x/ZQ9B0VHv6QRy2klyH93lbtvK0ZRiHci0xMy7vSJgj6cAvl1Gz
 WUvr23juQ5HfUB+gZTNTSJUHegkYDUf4fIoi492QhBPQWl4vi1LoCEdR2hMPza/WUNvk
 ZsXzutwU2Q42r0tGZX+VCBfsDH6VIB8H56vxs4MmktYJrU+5wvkljCWQA23WezYCDNl8
 fHCel9dIDLGbPawSWCHhGsTgsK2Z6w9TK7JXPwCdlWBdYFz9bhMfw4AgJ+euaXzPaS+u
 pgt+T7cjPbS6LacxxZX9vYBJAV6wrggZjOBuRQgmxh6BGoW53GOb9h3EEgeOKQn96i1O
 Wd5A==
X-Gm-Message-State: AOJu0Yxl8XuBCN2ixnuAafeMP+oIoTsz8T4/+kHSPvUMm1UI2tMlTrdN
 W91r6qC7+hpI9oLv3/k9nSpgZQ==
X-Google-Smtp-Source: AGHT+IEvwYJhKSboOnb/sFbMCQo0i+6IYRt7VDiCFvrYM6m2dBcSxfq6YtaJmxsPRWl4XEmlp3o99w==
X-Received: by 2002:a0d:d857:0:b0:5e8:34a0:5284 with SMTP id
 a84-20020a0dd857000000b005e834a05284mr401049ywe.20.1703008015318; 
 Tue, 19 Dec 2023 09:46:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 i129-20020a0dc687000000b005463e45458bsm9903991ywd.123.2023.12.19.09.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:54 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mach-k3: am625: Relax emmc boot condition
Message-ID: <20231219174653.GH2513409@bill-the-cat>
References: <20231208075305.14276-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3Cp/6qANThX01qf3"
Content-Disposition: inline
In-Reply-To: <20231208075305.14276-1-michael@amarulasolutions.com>
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


--3Cp/6qANThX01qf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 08:53:05AM +0100, Michael Trimarchi wrote:

> spl_mmc_emmc_boot_partition return a number different from 0
> if the partition is a boot one. We can have the uboot img
> for instance in a raw offset in emmc partition 0 so we would
> like to continue to load the next stage. If the user want
> to use EMMC as boot device allow him to use any part of the
> emmc and not only boot partition
>=20
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied to u-boot/next, thanks!

--=20
Tom

--3Cp/6qANThX01qf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1w0ACgkQFHw5/5Y0
tyxBcgv+Nn8AXXn3SW7vuAYC3c+7N2bonuq7hf8AY6PFXm9SUgaLYtrPouREmX4H
Osq8mFii4ysytXBfHpvLaemCvpZL6FtoWNBOHSYgopdt4sOKyK+Qy4PPfX+zHuOV
zu+KkXYAUr5utskMjS8yd5R+5zgV+1UvPSvbh8rcCrjF+thp+C1eddrEVmjmUhbx
RbDULoNUExTnoiE1t6L4xTU+6Eli2RnujOc7acXUFaCFWB3TWXFaIa4k16e73Khz
NN+P2VxdvSnsmmWMgIfkpjM0yNV2oArGnPXq3kLiszldcayvvQcgvWdbw83Hc6KM
+gTFy7M7h6zxaJynTdqRXKPkRL9PNJ7gWKV/BuQtH3K+u+34Xwt42G5WJpD2UBwn
eppJxEKANGZs/7rGsMdDn46YAmuv422PYh3UDBRrE74UGT2v+lKtESaHZ0zttZ0K
qaY06CU6i/3UzeuTipq5rYFDhsYv2w/Grn2Cmg+/HWaXs3uTjqjGyuoF/oiNEB2H
l6lWR5Vc
=dPsa
-----END PGP SIGNATURE-----

--3Cp/6qANThX01qf3--
