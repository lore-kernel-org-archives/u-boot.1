Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B49C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 13:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6003889EF;
	Thu,  8 Aug 2024 15:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l5gVmmOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83B588AF9; Thu,  8 Aug 2024 15:59:02 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5C988763
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 15:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-261112c303bso695477fac.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723125538; x=1723730338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0IZEFnuGOc+RyO8KgdOuTsL6PbW6Fd2Sy6F4BZRFMRM=;
 b=l5gVmmODxQrofGnaQ1fHRZvnc+nk/MaNDmyskXZyxk1DkE13OeHhjNmoQ48GFwBNBc
 MBQ+DPsRJQ8v4/YGPe16M7K0rkngB21ekgJ/YMPFUCICQ5/R35VYkGUISbHz8kcWh9So
 WU5AN+AXH9F1R38OKtNZCSBsdFq/6rrBnUj+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723125538; x=1723730338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IZEFnuGOc+RyO8KgdOuTsL6PbW6Fd2Sy6F4BZRFMRM=;
 b=da/Ka2AqMkYVx9tdKsINXUHWJtcLd7q4zB7gR7VrOft9mtAxNJ8qGFbvaPaut+Ejb3
 0cTh4mkPs7eeLeGkcEp/MbFtecQgNIZreGdnGEkyCUmrn6aDswZ24roGxaCSPWyOU3Xp
 auQjvMZA68INs0oDAbI5OKhW9GhJY3mDb5ya2hx7RpZZlY2xMoERbBr+fAxE0wdbTi6K
 Cqp7+Zp7JS19Q9PWZD/THesq4wBopCgS5BKXy53dsaxXff+watFCUF9Yad9Bi+lPXI87
 F/NuG9IU1ULpimVKWee5cESfrWD8H7xh3fDg+j09ml8sU8eELr2QDW/IGJrZ/jIdm+zU
 3Zpg==
X-Gm-Message-State: AOJu0YxcwU4BH1fl6EC/GmnBEANsOP0YplaV3ukwf1LUaikEH2kszcZ0
 7l5Ku0SaIewBEPZvVQd93dVbecpSWg7LFUZQXG5a9LQg6DOCk9Qpehkb/wituAc=
X-Google-Smtp-Source: AGHT+IFtRAzJYKoCAZNLLZgn5jrZgXd3ljUbfJNlSPazxmy7oOZUthBuAKK7GHznwIkbD1SYq8aTDw==
X-Received: by 2002:a05:6870:65a9:b0:254:994b:5e6b with SMTP id
 586e51a60fabf-2692b7fd2cdmr1936530fac.44.1723125537754; 
 Thu, 08 Aug 2024 06:58:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9df5esm5439672a34.14.2024.08.08.06.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 06:58:57 -0700 (PDT)
Date: Thu, 8 Aug 2024 07:58:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, David Virag <virag.david003@gmail.com>,
 Fedor Ross <fedor.ross@ifm.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20240808135854.GL1626301@bill-the-cat>
References: <8d333c2b-2aef-bd73-4489-f79fa6be84ed@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZCgKlQgv/XCUvtxk"
Content-Disposition: inline
In-Reply-To: <8d333c2b-2aef-bd73-4489-f79fa6be84ed@denx.de>
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


--ZCgKlQgv/XCUvtxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 10:42:47AM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-i2c:
>=20
> The following changes since commit b7d5ce05b1b52136af09cf34541c6a91079a4b=
86:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sunxi (2024-08-06 09:36:46
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-f=
or-v2024-10-rc3
>=20
> for you to fetch changes up to 3d299c355912e05ba534574ac557ad0c9edd7d99:
>=20
>   board: vining_2000: convert to DM_I2C (2024-08-08 05:45:11 +0200)
>=20
> ----------------------------------------------------------------
> i2c updates for v2024.10-rc3
>=20
> - i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5
>   from David
>=20
> - imx_lpi2c: cleanups and support read transfers longer than 256 bytes
>   from Fedor
>=20
> - pca954x: Remove pointer to GD
>   from Michal
>=20
> - DM_I2C conversion for some remaining boards
>   from Anatolij

First, I would like this for -next, at this point. Second:

>       board: sniper: convert to DM_I2C

As Paul noted, he has (and I've taken it for -next) done a series of
patches to cleanup and improve the platform now, including the
conversion.

--=20
Tom

--ZCgKlQgv/XCUvtxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma0zxsACgkQFHw5/5Y0
tywRgwv/dIgkcgSF6q0pXgn97nWS2fPS7APkOjVB01p+Q05QVRf1y9hBS0ASvxRD
efUDWjWQ1WN/IPSoByKkwlcSZdRAq4oMeZXLfO35aFfmGyEpGVBvdvAnzHeBBUma
uu+QJ5ipOU8PWBQH6N40CuYQ7vgAiGFgpl2c+yfvTUxwWFxuX4X2udxuW2o8T5d8
idDDC2JZkcf2Gk+yY1ekRDFG1kovmyAeu1qAqKt0MeGMoy59T26D+ONFVFJupCKE
lZhaxYiCf7Q+9kVnqdy0jXatIZxOmvwyZVeHVJhKlWUbX7PRR401LUGcAN0KpoZp
bdb+c5iW82pL9u/p9rWilluNsscVl/p7+3ZEEVEthv07gNE8jDBBSSbo/eSXR9XT
hsHSAyy7RViETufPrFu2S2rl5P/GFGzrlVuGj1T1qfbbrMXaPw5Tx5IhzgqrOL9z
p4h8U3ujs/OyL08gtyNx9+b3HbMJ3uD3DfSYBrRB7d2xtACRz6bia5yCd8TVx8ip
dOEHb1lJ
=5ffb
-----END PGP SIGNATURE-----

--ZCgKlQgv/XCUvtxk--
