Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF348CFB42B
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CC388CBD;
	Sat,  5 Oct 2024 21:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pEHpOBJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574E288A47; Sat,  5 Oct 2024 21:34:55 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069A388970
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a9aec89347so195779285a.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728156892; x=1728761692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0YHY/88vva/AwZVmt8JOmFF/EBcuB8qxgVCTYi5rsvo=;
 b=pEHpOBJK6VwtDh2VkPVxrnwRd0RsY36pwnISKrKZxkmuKaplpF5FUWQAfJuC8mCFww
 6pjnwII28D7obIkQyuz2RqdkBcwFcYU55uIFvp9N5rDgGFAJFfw/3QR2hCzvM3Sku+Hr
 UOYTOS/y4D9QQLBEwYK03ixnB+o6LChYPdvZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156892; x=1728761692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YHY/88vva/AwZVmt8JOmFF/EBcuB8qxgVCTYi5rsvo=;
 b=rCsmlu8zoAYuOTllbelW/YHmcDCb8soTLsb74xyFZjgPoerX6kmMLT0bkyW2zu0TVd
 TEccFB1xvFKLVrYF/VWOgEG5+WtYsXR78JaIvaeg0YMp/klL0ZV06QBqiiDeSPbsRPiS
 OWV+lMV1e22wXCUBmltJUiyva3NYF76IBb+318NTNUm1sMidGuS/yF3okrO4UkQ8aOJF
 9n+pKNzIChMB6EV2aBaSgktZugUa9L3isu/dbhORDyhRpZ99JNlej1ensuHAh8bgSmJb
 pc+UOcHjThBedq/B3tupK67NO1NljxDuSiXwwpnNadMmCK4xDnfIF2rRGB3fQ02P3YIl
 SbYA==
X-Gm-Message-State: AOJu0YzwMJ+j80bKOJKVRlsvJ+9SfMcZzN7BUuQpZF7Y1L9cp7Foo8+V
 2QOkLmE1v708OMEfso7huFopkxKv7i4v9wT3EDnwDD+GqIi5jYRpAAQForS3wBKZGOz446Rcwuk
 O
X-Google-Smtp-Source: AGHT+IGkQvWnl89WwSVwxdL7mOoea7bonefPh8Efmj7JiVu0zEr4an5XUjgaIF5IiTUDjZhs+Wx38g==
X-Received: by 2002:a05:620a:4625:b0:7ac:9dff:4525 with SMTP id
 af79cd13be357-7ae6f44ceafmr895004885a.35.1728156891851; 
 Sat, 05 Oct 2024 12:34:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae75615aa2sm103744585a.14.2024.10.05.12.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:34:51 -0700 (PDT)
Date: Sat, 5 Oct 2024 13:34:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20241005
Message-ID: <20241005193448.GN4737@bill-the-cat>
References: <20241005164438.2065748-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q3xWiCB0UIkwaJU6"
Content-Disposition: inline
In-Reply-To: <20241005164438.2065748-1-festevam@gmail.com>
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


--q3xWiCB0UIkwaJU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 01:44:38PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 00292c6b39b3f7dcb34e8c3ae6ef276ac862a1=
46:
>=20
>   Merge tag 'u-boot-dfu-next-20241003' of https://source.denx.de/u-boot/c=
ustodians/u-boot-dfu into next (2024-10-03 16:09:40 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20241005
>=20
> for you to fetch changes up to ef815d75514da91dd98f9e3278d810439fd1f1ea:
>=20
>   lxr2: Add DA9063 watchdog support (2024-10-04 09:55:26 -0300)
>=20
> u-boot-imx-next-20241005

Applied to u-boot/next, thanks!

--=20
Tom

--q3xWiCB0UIkwaJU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcBlNgACgkQFHw5/5Y0
tyx9Cgv/besNJJjShXnKYgY2XoKe16oEDgmUbmW00P/VgMb5c6xzKotIEEVvM2U3
gv+Y5Zl9cfiqmCZo7w/bqED734QNB/v7SCjQCNR/j7/7E0E4ncQIup5ST3O/a3ro
2kmx40C6LAMFiBa5SK+irCZKOXQhuGmlI0mhSDoKeV75Bqwctv0yiZBxGW/kDOxQ
iLwe3FZfBBDWycLDi/4mzxaER6tg5w7olGs7V0xHjDb28RdStKRGNYdCbo0sVKwz
T1GCqylr7j8DHOivHMDBMRlrBmII+ksIrBWgxqBhxAl5lRX8fetGpnDQSyXuLeh4
BgunregvlglI5+AM7M7dph0YywJlCAUTb4B4eyGZ0ZARrEQgtJ39lprW5bUH0c10
IsQJB2Nm9KdNuZCgdO+A6FVjXd8BS9L0k7GjnjXkRBUg/mS1lRPduoxjRJSAjks8
GbbWbwqCN7d6nq7xI8TcQnGE+gko3W84Rhm2nmCEbunOxqhLqOPd7XuiYB6y83I5
7qREiTpm
=eMme
-----END PGP SIGNATURE-----

--q3xWiCB0UIkwaJU6--
