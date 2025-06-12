Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A6C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 17:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA5782C30;
	Thu, 12 Jun 2025 19:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="maDwWKiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 225D282C4D; Thu, 12 Jun 2025 19:18:54 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A741882B97
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 19:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so756958fac.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749748730; x=1750353530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2cq0XDs/CoRPCSHDOrzZ3ixiIdSIaoh6zkyes4CA4sQ=;
 b=maDwWKiFK31U8c/yssmVRxxGY7Brfz2YcBP6ArGEy4a3to/81sOmgEeGkZKMoYwoKz
 mxbMHwW3qIJM1+5sppbtPPK9OBemynseMvVZ6iqYUwgLC9Iqt4xHUPT4+yAsQrrNoOw9
 dzReoIN91FfdFgRADE5EjSQYOV6TSyoUgT6sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749748730; x=1750353530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cq0XDs/CoRPCSHDOrzZ3ixiIdSIaoh6zkyes4CA4sQ=;
 b=mrOUbhdnHUrfWSdp2QY9v/5DPryJ9Fls0YNuOCLkZ86KRg4SE6yIc7iq8pQr2oEERW
 e6y+TUTodIHSySjbGRv6//NaHhVbEiftJ9QUQzXf2zyASik/gYYlBL2q+DjeSqbHux5/
 gj4BcMQMD6mVg1mWx09sLuyRm7lrQIcPzcKJsXd2P7JRTog7e7e+DtQYLYRFCQKvnR+L
 qB4ajK0BEOvlodSyXoYfQyiF0A/fNFr0T63ECjMpKK+17eTrAjgBSQv0X1aB04Rd7zmy
 aighjL5E+gCLufbydDtGpijSs6Bn7sqVMmPe8CFK+NHbDBL19fLuat2CizY08e2I8Q4t
 M1DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb5AV7gRwDa5H0vuzYefvRUsd1ZoefM9SIuDYPPhCFC9m8B9/hKo9hqERY60lugrEywt8d95Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzmUNgajpyXPgSYfkWt2DDrJnSwk+xX7hMBhQLcsKUOHdkQfEG2
 CVaeSRoODnToWu1otZEJ6S/auwGHByjcjcq5UUvrk0u9CfCXFqtIoDfLwSUygK83Umc=
X-Gm-Gg: ASbGnct+Dt2ppNbApcyZINo4P2LpRD4KiHC74mYjGo5Bq8b/VBUcbDlVQ9s5hHjahw9
 XnIlQ0XdWiKFTo1hvMgt1hzOAZgsdUiDVgASxdRVjCo5dwJ6ObytFZ/TIAKGRrMauDzoqtLnmEU
 iOKPPuH/pvUZaoxtqLtZGfwpZj2XwG2xUm2dFgmgDeXP9f8011LPsSYYi5yOXACYiSWcyOlYEH2
 1qMA06HVdhRZebHRk65W6Zcpx3Aj6hajbJOohv8xqfwEyDMAL0RvIGxo9M33X8/bW+hlottz4Ym
 OJoq3mnyNzpVCDdzFLDRQ9p0YgzJhXbjbQ3hm03+Y+LZNq94ALjT6kdSbtHsmQouZvbhC+EkHZc
 ishL/9X16vFVRgyVCDKOnSyUBYQtqevpfJg==
X-Google-Smtp-Source: AGHT+IH3FsqjpQvWvdvXcCoEa8yF1RGUqdYn3PRrBd7FakiS991/LGKHuFMNwEo2jzlOZKsawdiGAg==
X-Received: by 2002:a05:6870:828c:b0:2d5:25b6:ec14 with SMTP id
 586e51a60fabf-2ea96c3ccd7mr5129951fac.15.1749748730331; 
 Thu, 12 Jun 2025 10:18:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8de6b4fsm360221fac.24.2025.06.12.10.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:18:49 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:18:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/7] Qualcomm: teach the build system to emit signed
 ELF images
Message-ID: <20250612171847.GQ1382132@bill-the-cat>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fFudDyiGwhbZV3Pi"
Content-Disposition: inline
In-Reply-To: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
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


--fFudDyiGwhbZV3Pi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 04:16:36PM +0200, Casey Connolly wrote:

> With several new Qualcomm platforms appearing on the mailing list, all
> of which build U-Boot as an ELF, sign it, and then flash it to some
> partition on the board, we're getting a lot of defconfigs which just
> contain a debug UART and a TEXT_BASE address. This leads to needless
> rebuilds in CI of effectively the same image, and needless duplication
> of build instructions.
>=20
> To address this, let's introduce a new tool "mkmbn.py", this is based
> on the existing qtestsign[1] tool but is (currently) hardcoded to
> only handle the Dragonwing and IPQ boards which use MBN header v6.
> Additionally, the tool contains a lookup table that maps from a boards
> DT compatible property to the load address it needs. Since it's highly
> unusual for different boards using the same SoC to have different load
> addresses, generic platform matching is also done (e.g. "qcom,qcm6490").
>=20
> With this tool in place, we teach binman to use it and introduce
> a qcom-binman.dts file to describe the image. The tool will emit a
> u-boot.mbn file for supported platforms, for unsupported platforms the
> u-boot MBN etype in binman will print a notice explaining that no mbn
> file is built and to look at tools/qcom/mkmbn/mkmbn.py
>=20
> Finally, the defconfigs are cleaned up by moving the debug UART
> definitions to config fragments (since it doesn't make sense to have
> them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
> the qcs9100_defconfig is removed entirely since the same binary can
> be created with just make arguments. This platform entirely lacked
> documentation to begin with, which should be addressed by future
> patches.
>=20
> The Qualcomm documentation is also cleaned up, a new "signing" page
> is added to briefly cover the what and why of MBN signing, and board
> specific pages are updated to explain the new build process.
>=20
> These patches have been tested on the RB3 Gen 2, but additional
> testing for other platforms would be super useful.
>=20
> [1]: https://github.com/msm8916-mainline/qtestsign

Thanks for switching this all over to binman. My big question is, is
there binman documentation that you wished was clearer, or that should
be written to make this easier for the next SoC / architecture that
needs to come along and add to binman?

--=20
Tom

--fFudDyiGwhbZV3Pi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLC/cACgkQFHw5/5Y0
tyyVZgv/b11UwGy4TSygDx1FiSpLi7ylELb5lS6K+SR8O7ZQa0qLM8KObyjLPz0c
vQBA1NB1+HhR8sQeIWezN1GiZtVxz7Hw9nTKfry4shC2r6wZ5Zg2HW6uS9FYFY86
0ua3eV8JYm/+b6hPvmxktIfaeiUfQhW46hQ9DtTC/T2Cu/upwu3f4wsvs7KDxELs
VzmeVSQ5cmzGvEmKoH/rphZn0Xmngx3btpdSd2PMmrwPufCHlR/Ja5L0p8qX1JfQ
xC37Itz1H8+CND+ZgJz748tIgRVG4Cy/BtttdJGq5hFULkdKRhLNZF13l3OwDV0+
i5yfxqmoUfEUg+CDpeFyqiwtgvXaZ9mOoA7W5Uke9bJVS1mQfiYuxJDE+NeGetso
Ak2uaeLt2gdhxoLosJ4U7YoiXDYLn9j1ztCOYl0nzre13+DOmANfVnRXKrhY5DUW
MzB3YPZN3X6Q5R5XAozZIGbh5gTenTf2IsMudNfG8rk33la7riyIU+7r/2R/WewZ
8TjjQQFk
=JX+I
-----END PGP SIGNATURE-----

--fFudDyiGwhbZV3Pi--
