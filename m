Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B94AC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED6687D0A;
	Mon, 11 Mar 2024 16:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PF4v98dW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00CD87D0A; Mon, 11 Mar 2024 16:02:44 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06FBA87C48
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78863dc4247so84535485a.3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710169359; x=1710774159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v3B9gOxsqVv/OgrT470dUEibm0909I3w7eCBMsEjnCo=;
 b=PF4v98dWoDeaLcsOQ4HaGp+vU0AYoBHFEy7Ovz7fm8ZNuLOQXjtdz/6ze1DqR1QVDO
 ehHNNXfeAUZYoLwKFxtnqkB5N5nVvxm3NRiuAV2xSLWT6OTQcmQ4TYWSW3WTVGGrYYgy
 LMp57MX35NYYbWUF9IZ0IRdRNY5niL4UVWPvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710169359; x=1710774159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3B9gOxsqVv/OgrT470dUEibm0909I3w7eCBMsEjnCo=;
 b=gXxcsgLi3Xv03gM72df+FDax0sjd69GPIKDJOACG79448iopYzo4IQalKxqAfuZ2yV
 chtG5qnTSnOc4KCmNetxF4fofXW3a951yK8dtZ0hyvszmSlVsZbnwycJZdQhECZpgknx
 dr4XIe3GVxqbnYvLhbyWyvGJPYs6vlqIMIQc7zGwcFGzNtvqQH/dHKARAaB0Ykq+52NZ
 jLwdfQmKUuknj7KwNxxSoJukbt5QtB8e/BzqV8S+8aMmGCwXM5Au6vIyTfJuYdydiKkK
 Cfu2kDTwIejTZFltQOZdbBDvz5JdhLpK1kAsW5Kc81WSy7SOd71ik4q3avndEr8D2XZy
 Oj+A==
X-Gm-Message-State: AOJu0YwCi2hy2xTyIu6L8PKD369nEzoGcOOVzV63mPc8Bnxvd+gFkjKT
 SrNPP/8PdtUkizpubZuiJwT3JhPtPkQyHE3Da2yzj3BzikOhP4ouhvG5rQsbC0a8FPGgAiFneRQ
 M
X-Google-Smtp-Source: AGHT+IFpFgRNHj8lNIueFC2yHHxcCdpg5J8lf1n5sueV4K1LUtWGOB1JofNzIq/TYPdyKoyRBAl1tg==
X-Received: by 2002:a05:6214:5008:b0:690:bb92:bdc with SMTP id
 jo8-20020a056214500800b00690bb920bdcmr10215377qvb.22.1710169358771; 
 Mon, 11 Mar 2024 08:02:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 cx15-20020a056214188f00b00690bee954fasm2709286qvb.98.2024.03.11.08.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:02:38 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:02:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240311
Message-ID: <20240311150236.GW1523872@bill-the-cat>
References: <20240311130524.2353972-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QLWm5GTC+QIomkph"
Content-Disposition: inline
In-Reply-To: <20240311130524.2353972-1-festevam@gmail.com>
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


--QLWm5GTC+QIomkph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:05:24AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit 0981f8900f2b1f45a3f282b704012b5374fdd7=
a6:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-03-09 1=
1:29:48 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240311
>=20
> for you to fetch changes up to 4484c7b3c38dcb21244a882d0b81d141db1ed162:
>=20
>   arm: dts: imx8mp-beacon-kit: Resync DTS with Linux 6.8 (2024-03-11 08:4=
3:42 -0300)
>=20
> u-boot-imx-master-20240311

Applied to u-boot/master, thanks!

--=20
Tom

--QLWm5GTC+QIomkph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXvHQUACgkQFHw5/5Y0
tyzV4QwAnoRMKuiyQHCy7fsNeyok/xrhDwdFK8CI9GHPyMTQq3XjrWt22efqaBPb
LnYD/H//UjFAhv5D+lfGK/5+8YTSAWeF5prQCNcm79mjVZxi7DPTONy+fuWOD59i
gSrGoylf/9PKCZjfo3cts/EI4krbXbzDJ8Pr0bOKmfZpz9ajGEp/5i4tIdaHzsWu
+i9weQqNNTGFMXLpIza3nKcYbfX8dSg9+7osBtOv/2NceCVQjhOoyHelhbRZQsp4
/BvKTZPqg9YvjssWxJqnnjP6otgY1AfdizUK8V29QYO784+PE6CgAnD1XQUHoSV0
fLC+XYrWagCi76mv4dqCMr92ImN+jh9wnRZRDIRE5VDg5ccEULs4FclVAhXbT5kV
MakZU+2BZyERjB3XNRiiZszr0iS4DUOi1E+EZ6ncglF9ieRtF/c7P4dkuTBmTFmB
s1bqbBTd/HEDnkV+oFydXf1f8SRzTJZaxzxro0mHe1u1BhejIHDTimOkZgxBYbZf
LoKwk5tI
=ci05
-----END PGP SIGNATURE-----

--QLWm5GTC+QIomkph--
