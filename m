Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1541CD1813B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5AF488FD6;
	Mon, 14 Oct 2024 20:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L2NsSyRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142DE88F5E; Mon, 14 Oct 2024 20:23:31 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB00C88CA1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b12a02596aso80179685a.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728930207; x=1729535007; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=75ba4MXXLozBeHoVvbuu5ubTf49//IpXOAWqU2hdg7Y=;
 b=L2NsSyRNkBvCkH2v13xBZCjWCzq1jRny46bEJmQB7RNwygvCMBW/IyanUGVdcbXpwI
 6RoS8IM6nqSoaL0SXI1yN+0eA5mCBA2j8q99VR4vC0HYAKA/DXxJEsT5/n/eoZH7MXDU
 lWIfqNrXHpKDfj53QXfV8wHJw5eLKC2Kc5XXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930207; x=1729535007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75ba4MXXLozBeHoVvbuu5ubTf49//IpXOAWqU2hdg7Y=;
 b=nzGy1YDbpHeChH0TkvnIwjfpPrBDR4yC1awCAUbj2OZJSGouJTrE5FRykqnNcy1/l7
 QOA1NdG3ACItd0jQmofFj8eFba6YZE6ZYzXu2esz57YDQ1/cgBGpP+svArKOigE2hpgg
 jUSV3v8/bd86bzYi4L3iAB4UtRmf+k1ZmldxNLxj23D9rHeoDDDAEhjbhMftw4zWBB50
 MvpkMVaba+GO/zkjqd5/ZkmYoy1P6dNwlnKmgKSupp8vyN8d4QfQyThRlEqDxgsrmRd/
 GvCuV+5nhfl27h3Ol+FX8eA3ahFyCa+LU9B6paywtwIV60ak4s7UonjZ7C1NiI220hlZ
 fnGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYxquSwaMFEg6P7jNoDuDnw/Rdca5H1MJ/Q/ovVuxfBL1nJYn6Mnh4gwhQhsrbSQ7BVkBvWZk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3qV+1k2pd/L/jPvjkL/IaZSTfbOYdnKiAHY74A5HUxzs9lv9P
 sKUsAwpX3+EsbW3ZYt+6dLLO0aijPa4zTpy6QKQffmUH0mmH2S7C5/kMODgMmYQ=
X-Google-Smtp-Source: AGHT+IElcDSfcuLAyEINTmscyK7TFVcjej258Cjs8vvbefUbgg8hVNAJ3nNGecmOQJmofrguHCSqMQ==
X-Received: by 2002:a05:620a:2411:b0:7a9:b10f:d54 with SMTP id
 af79cd13be357-7b11a34d980mr1816984585a.3.1728930207455; 
 Mon, 14 Oct 2024 11:23:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460427d4f62sm47588081cf.26.2024.10.14.11.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:23:27 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:23:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20241014
Message-ID: <20241014182324.GQ53053@bill-the-cat>
References: <d2b5a5e5-c50b-459e-a81e-90c952efdd16@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="83BpTbierzv7ZL5k"
Content-Disposition: inline
In-Reply-To: <d2b5a5e5-c50b-459e-a81e-90c952efdd16@linaro.org>
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


--83BpTbierzv7ZL5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:44:01AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> New Libre Computer boards are added with UEFI Capsule Update support,
> plus various fixes for HDMI support, boot targets and android-mainline
> kernel support for khadas-vim3 android config.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 580fb5773634c4a01f907a164b2a05961840b4=
c0:
>=20
>   Merge tag 'u-boot-imx-master-20241013' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-10-13 16:25:01 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20241014
>=20
> for you to fetch changes up to 315cad97a5ae09b1b975fff2413ce785b3b8592a:
>=20
>   configs: meson64: Ensure commands for boot targets are available (2024-=
10-14 09:06:16 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--83BpTbierzv7ZL5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNYZsACgkQFHw5/5Y0
tyxMWAwAq77H4XS06wdFB13lRqSfE0Qk63sn400Tj2rIgt8utohBS3ygnNfV9pPf
RBFF4rFwHkulGLu4oSUDb4Raa0MiTNXbFhg0u0ez1NVf0y9NNUl9xnrREaw0mZNH
ZeTHpRyE6xT08cHifEyq2uzmsSGvxZ3wW3FQDBtUEf0st42z2Im+kGZsFNd9nW7t
gFvC+z6RdxIyETU67VqHsnNcUlzDgwzTcZNZaTGkwtMlU8f/4nOh2Ax3wytbZyXy
vv9VT4bhMiw38xaX0cwgLXH7HKmPL49OJkSoqAV6Qw8mALbBJAthL8BLXhaaY9Rc
Q/Zv1ppdfYCPpH3OCiYrERufnL1fsiHpjam47zx25cTf3UpYPMiYn8bTuDJ50qLS
gxYTCzCZqCmwiqWfaD5nqqRcB2sSdl9nzE0ukF/wIodnpNiBXjxJ+hguOUupufh7
juUUWeKEVMiEHXHt2u89mvYxBm+31QMD4vRpWWyHj8i5CXOTDVfKcuHnoHTjYp8z
E5UT6HAt
=X9zY
-----END PGP SIGNATURE-----

--83BpTbierzv7ZL5k--
