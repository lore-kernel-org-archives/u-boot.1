Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A76BC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5829882ED;
	Mon, 17 Jun 2024 16:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XjQlWa/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD34B88208; Mon, 17 Jun 2024 16:40:07 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9EA88323
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5bdbbc37664so1852044eaf.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718635203; x=1719240003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z8nibdQvJ8tQ0rdCg37nd2wehCt10poS+6ZaIvyWNg0=;
 b=XjQlWa/sTyFfrfR8RzjvzG8WeGUlS1e/cqQFn+Vv6eoYRhMzjZB7xBD7MLHnD8SdDA
 obT5XIRgk3TtVmHGLU1zInrh2sVa74vT4NG0TWGx2GfOsqC+eWqGh/bJ3oSWGbjrgTLD
 nX0VrvmD75QpURLl5V2D4ZQz9Rb8U+LY44Gyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635203; x=1719240003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8nibdQvJ8tQ0rdCg37nd2wehCt10poS+6ZaIvyWNg0=;
 b=hj/gy6vDQezoDdoYiwCEyxNIaGd1LanP3FO8qogNPvfwIe6HfmYrhr6UDI4hSmuDVX
 hUAUpBHB2Ftgo8i5biFh3BITyUR3fJmHFIyJMGxOZETI+WdDQ9C7sbgo/xGGWkdHBOKq
 8ToAZO11ElbWjLtkVCPV8vD8wLFtMKdcvfj8bjrYPzkTSM9mJgqFeVHC2GOc1ZOkrmTv
 nBg0cL3vSTYpNpC1jDfyUNp7fStvqmJj4K6um6tJvI0kN4Y/5M5X6yjjy64WRVmBu1xc
 vUJ9IdoOWuYyqV5Ow4M2M/hGWaoZldpyn/TDZexdgd61HHaQ4srXo5daUW7PgmOQNNgs
 YUuQ==
X-Gm-Message-State: AOJu0YyfMdwVsAgV2m68zt7a5Kb4r2fKsSpiSUAktpJU9nfsL0HbMTwj
 5hxAONHZWlTpaxMstkEGW8+6ys5USgrcfxh0IbHjhTXk1U8EOZkOKrwDErSGo9AIlq80kDpCcAF
 IGbM=
X-Google-Smtp-Source: AGHT+IHDqs/4LPA7AkvrUyNAm0WhB4ieVSL+accGu5pqVDBJj8gx0BEfPxueHv+8fj70SmaajnDMLQ==
X-Received: by 2002:a05:6820:1506:b0:5bc:8ec0:e6f7 with SMTP id
 006d021491bc7-5bdadc99ed2mr9305474eaf.9.1718635202661; 
 Mon, 17 Jun 2024 07:40:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5f67f2b2sm1187627eaf.29.2024.06.17.07.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:40:02 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:40:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-next-20240615
Message-ID: <20240617144000.GV68077@bill-the-cat>
References: <20240615122213.2203637-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BH6WkjcRcIj0a8cp"
Content-Disposition: inline
In-Reply-To: <20240615122213.2203637-1-kever.yang@rock-chips.com>
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


--BH6WkjcRcIj0a8cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 08:22:13PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for next on rockchip platform:
> - New board: Theobroma Systems SOM-RK3588-Q7 Tiger, ArmSoM Sige7 Rk3588;
> - PX30 dts migrate to OF_UPSTREAM;
> - Some other update on board or config;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21113
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 3db3a6ba7b0cb09757fc631ccc9d4445eb101d=
c7:
>=20
>   Merge patch series "Enable OSPI boot for j721s2" (2024-06-13 08:20:30 -=
0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-next-20240615
>=20
> for you to fetch changes up to ae4aaa44977cbe522e9f38f2ac2ac07a784bf867:
>=20
>   rockchip: puma-rk3399: get closer to other Theobroma defconfigs (2024-0=
6-14 17:35:45 +0800)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--BH6WkjcRcIj0a8cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwSsAACgkQFHw5/5Y0
tyxHogv/TAnfTSslISLpV1O3tuP+Kwdc7JxlHBPK8VNkIvInJGUqbqDt87OInTin
eOBMwxAGlURQq7xf99AP5nJZkKtaKr1MqhkQqhRZOOTgj6M1WffX84UYZqBu5nSZ
H4RBnF6dSyoI0WJ0aGFf2Q0u/GViFUTjbR2Zne4uBrXinsf2jXtUFkoGU3eoi3I5
QKyaj2q3/oh6q1U/d0cn7ctDj1qK1HfgXSK6NFbQWJrxFN67pXLw8+0TPatGTXQm
2bUumZr09Swe+asvvs1AaxIFa5kjZKSucK9gorkzWvHHckPwF91Jrj6juqChXK0o
OSAbP6fA4GV+DQoYjFdQe4pefDR/TxkLrWvwzhtq9av+syvq5e8CEjm3z9gHbTrs
Z84CZR1WAyIlQYa/GTMqV6DCyM/U/j0wOwL2TQhslRmOHEyMaaj93hbHFqUcUenc
I8IslxOHvHPjUdEXmsQO0NCVmkqPspEwAdMPdxheG2s+APZ/mZYysP/ttjAU/rL3
kt+RFRME
=Gp3M
-----END PGP SIGNATURE-----

--BH6WkjcRcIj0a8cp--
