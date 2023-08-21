Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB004EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D83F87067;
	Mon, 21 Aug 2023 15:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMrT/ocy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62AA387067; Mon, 21 Aug 2023 15:54:49 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7356986813
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so4044306a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692626086; x=1693230886;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/9CcMuCkdMvjXWxXqP7BV4hLgjJ1ODoozwi2VXzz64=;
 b=IMrT/ocyOuJ4E9jKOiecYYwFSH5iT6XlsOJfve4AdfYZi9OR2MHAL31sGaYha68c4h
 3QJ+S5PDm+FUQPIpZafeFPcNDsCCf9sya/nHQ/W0qfOs92FZBlUwXSjfegu3QEfbRQ2r
 dNtenYNMhO0ZiCZJm+H9F5dfpXSRY17qzPUjxzowh1HkrkJTRxtENe0veikgzoUYCvmm
 W9Z6/WAbSEohm8dfxY2SDIMJT65LKQd1RkQb/wcY0NnWlqW42CC+ztwvCVdspS3oR8cB
 78Pj5XJ3zR5G4DxiiNeEK//KtbdL4d7KnGkhw4twGNMPMixnmIGXqCsKuPLosZbQgmFR
 3e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692626086; x=1693230886;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/9CcMuCkdMvjXWxXqP7BV4hLgjJ1ODoozwi2VXzz64=;
 b=lpjeYf4mzroISTD66AEnZ1vsJJhbwbpWnhDLi6lskqGpwjM3VyJTHnAwvJodMxv+L5
 TDWqfY4ddePWVC6AaRlNUpi9w6rp6wA5LuOWwc1XzrRFtKNSvLT0JFkXhubASXwNIzCv
 65bU6cOu52+DP/48cU256KFJY+mMPjnd6+XVYtvDXABRH/SDJe07DQjTTrwHCAb6Hpba
 er11mVQmFf6nnlFJO0LE7iu9AvCgSoKcbiLgsHDv3cncbOfEbEIxqyo1KHo/WQAqID3b
 DrMZvo3uLmS/m+9+Q4va0z5VaXZhSDYvP1KUu595Z4/hWc7CDaWTsjJjaD+sIfPaZzXi
 WDDw==
X-Gm-Message-State: AOJu0Yyn7dVRz3tTc0R7fEoMJZC1GwL5xW+6Ub1efXDCZIIDyG0q0q+7
 DBKoEdQU2d2Su9/u1R4NAaY=
X-Google-Smtp-Source: AGHT+IE5u7nmlsFu8NgOOYJWwJsmb1fq97TrZYR7/vrhfCnhhGXETT/Wxbo+ipl2pGfNpglkewY9+g==
X-Received: by 2002:a05:6402:1610:b0:523:38ea:48bb with SMTP id
 f16-20020a056402161000b0052338ea48bbmr5119547edv.24.1692626085676; 
 Mon, 21 Aug 2023 06:54:45 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a056402034200b005257da6be23sm6009669edw.75.2023.08.21.06.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:54:45 -0700 (PDT)
Date: Mon, 21 Aug 2023 15:54:43 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
Message-ID: <ZONso_P3jXiDSkSh@orome>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yps4BaiD65T6UsCj"
Content-Disposition: inline
In-Reply-To: <20230818164943.GZ1515023@bill-the-cat>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--yps4BaiD65T6UsCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 12:49:43PM -0400, Tom Rini wrote:
> On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
>=20
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Hi Tom,
> >=20
> > The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2f3a=
fe19:
> >=20
> >   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-06-21=
 14:42:50 -0400)
> >=20
> > are available in the Git repository at:
> >=20
> >   git@source.denx.de:u-boot/custodians/u-boot-tegra.git tags/tegra-for-=
2023.10-rc1
>=20
> FYI, in your .git/config you can do:
> 	url =3D https://source.denx.de/u-boot/custodians/u-boot-tegra.git
> 	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-tegra.git
>=20
> And this part looks "nicer".  Not a big deal, just an FYI.

This actually comes from a script that doesn't use the git config but
takes this from gitlab directly using the REST API. This is primarily
because the script also gets the link to the CI pipeline from there so
it was convenient.

Anyway, I wasn't sure if you preferred the HTTPS link or the SSH link,
but I can update the script now that I know. =3D)

Thierry

--yps4BaiD65T6UsCj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTjbKMACgkQ3SOs138+
s6GXtg/+PDK3L6zQxelXrccwS/+yeMbXpmrh9OYvwwbcjVy+ACJkRnI6Wvxj6TO4
CmRgsUWTCkVq355lB10rx9xjKgGNwzsblqxMMuITH0QVDTxlZZy+VbzLZP+yZhGa
/tmfrLklsibVt9fnjFgh14AlxRwfmaxPBwOANSqnihqQs93iPaKJJcK+uz8VAs0X
NFFFHs2i9nuOuFnC8LkEoM45yeRiGuhCXE9hVP8PXR//OKX7AmbVxVvEktTy265Y
ngu6BSdVbe4+JWSuvIesrOAyeMjO2H5NEJq9tMJKrk3AyXv8bwbK/vYtTLJwgXh9
rtGw09Y2KZ2R2sfPyZXcjYyNz7O7pm7No9ulp7vM+O2zj+nC1T7X/7vQpotHqpsK
XmjECkGqymkDonj8Ub4t2BkObtP4qJBODIYgdUmQ4AkhSCwFZDfZzr2jHo+nbApS
kOpY8GJ51FAxc0kyP4cUIvy5safo+oRUTrwfI10rHA84nudIiLcYNQCreYBMQCFW
bn4tqcdUONFuFzpbirGt/uXP3az8KHlYxm1ZBLB5/2m1KOgt98JJf8ykCSF/Hz7W
vgnQlr/kLJoYCItxMuebpMlQeDDuR8xwPqgJeEXHmMHNptXEdAwAKx2mwKVf6wTj
xx+MpE6JYhIQEgsVpddTPkIAqQMJBiQffxk4Lxtk/8UV1CoKhTI=
=qwq4
-----END PGP SIGNATURE-----

--yps4BaiD65T6UsCj--
