Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A0C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 17:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7117B87645;
	Fri, 27 Oct 2023 19:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sUxMZmNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77EF87638; Fri, 27 Oct 2023 19:00:28 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A5787638
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 19:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77386822cfbso166509685a.0
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698426024; x=1699030824; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3NBQuD5QuQY+Ox0fn2XYTbMQGa9C/LB6up2CnabdZTM=;
 b=sUxMZmNN9GKsoaGzvVeNUWGk9FKoigo3s3CgUwS9jTI32yw7cDk0E6oVdK4xej5Iqd
 lmFkVxfIpSP1k7b6Naj2snyeEf/Dc3qwpLaTcX8SnEYhNikfQgZgcZoJuJUfQS1ql0q2
 rn+1tZR75k5ve/F7Q1c3vc2XRhq64Br2pfXjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698426024; x=1699030824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NBQuD5QuQY+Ox0fn2XYTbMQGa9C/LB6up2CnabdZTM=;
 b=Lcv7kRkOUXnqivvpaIYxKgva2lyuXMJ+ClnEMO7+88KmqSsFsVYJqt9KaJ2q2dwoZo
 Dv7u/WfBQWNGdYWlPU3l8ZHimjDla4b/4DmPQh4htJa3N56bYrcqARvBj+o8D+dV8b4z
 NsvdXEdxNVGJ2jG1+nn5xBmceSflNzUxbX73NZjgYsEQL/6zN6Jr3Aa7TIg5+/MeoavW
 AWmo9TwLu/UKxbgTodTCD/RerssPFCoejLJAzutg3u5Wc0cZXHMhC0XKOw+MvuMvZ9/Q
 8EZ0oLipzbdpk7kLLl2z5GympZNBOurdzop0nrFZNZ2ExCdF+AaA3uKn4YONHW9BBtHQ
 gaRQ==
X-Gm-Message-State: AOJu0YyEGxSe6/lQ0225Q8Ce2EG8W//uVpOQoz2y0eHRGGfOP8YV4v8x
 SJJnnx8LrCxesNvQEl8IzYG33g==
X-Google-Smtp-Source: AGHT+IFxl4P4ZQPIrxYZAYuJI4WOmuTr+OSPel2uRAxYAvPOdL70sQGEgbHBPBlrW+PVQ5pYQ543OQ==
X-Received: by 2002:a05:620a:bce:b0:779:cf70:8482 with SMTP id
 s14-20020a05620a0bce00b00779cf708482mr3682392qki.57.1698426024328; 
 Fri, 27 Oct 2023 10:00:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a05620a44c800b00777063b89casm696218qkp.5.2023.10.27.10.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 10:00:23 -0700 (PDT)
Date: Fri, 27 Oct 2023 13:00:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [RESEND PATCH v2] rockchip: include: asm: fix entering download
 mode rk3066
Message-ID: <20231027170022.GZ496310@bill-the-cat>
References: <decbd275-3171-89a3-abf5-cb0caae0f2b7@gmail.com>
 <2745d73f-ecd4-4d3c-8ee9-5c0aed9e5c40@rock-chips.com>
 <d058e2a4-15fa-c38e-2a35-d5476cc0c8f5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AoOaiFZi/v7qW+wH"
Content-Disposition: inline
In-Reply-To: <d058e2a4-15fa-c38e-2a35-d5476cc0c8f5@gmail.com>
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


--AoOaiFZi/v7qW+wH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Resending this as I don't see it on the archives]

On Fri, Oct 27, 2023 at 11:47:25AM +0200, Johan Jonker wrote:

> Hi Tom, Simon,
>=20
> The test for my patch ends with an error that is reported on various loca=
tions on the internet.
> My knowledge is limited here. Could you have a look?
>=20
> Thanks,
>=20
> Johan
>=20
> =3D=3D=3D=3D
>=20
> rockchip: include: asm: fix entering download mode rk3066=20
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18283
>=20
> Error log:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/720456
>=20
> Error message:
> Cleaning up project directory and file based variables 00:03
> ERROR: Job failed: exit code 100

So, this is just the last line of the job saying the build failed.  Over
at https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/720456#L=
1294
we see the build summary, and one platform failed.  Looking at the
commit you note itself, I suspect the problem is that some platform (a
32bit one since that's the job that failed without a useful error) is
hitting the ROCKCHIP_BOOT_LR_REG and ROCKCHIP_BOOT_RETURN_REG questions
and not having a value and so config fails, and buildman isn't catching
and reporting the error.  Looking further, the values in
arch/arm/mach-rockchip/rk3066/Kconfig for those should be with the
question as:
	default 0x00001058 if RK3066
and so forth.

Doing ./tools/qconfig.py -s I see that it eventually hangs on one
platform.  Doing lsof | grep kconf points me at the build directory and
it is one with:
CONFIG_SYS_SOC=3D"rk3188"
CONFIG_SYS_VENDOR=3D"radxa"
CONFIG_SYS_BOARD=3D"rock"
CONFIG_SYS_CONFIG_NAME=3D"rock"
in the .config that is stuck.  That points me at rock_defconfig as being
the one which is tripping up the question.  If those new options are
only valid on say RK3066 they should depend on it specifically too.

--=20
Tom

--AoOaiFZi/v7qW+wH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU77J8ACgkQFHw5/5Y0
tyzsXQv9HDzo3Tmj9vA2+ABB71tCNlrmoHgwHPSB0IQBoq1yt0np/Y3rRpyt/KFi
i0rknO2xRr1UTyWLL986IL2m40e3c8W9iub2GweK7MtRgC88mU3wDSE3kd3vfNRz
GCk8Dj2briLPF8MJMELYk28EjZIBx3FP/FAs9Fdwhl/fKPGkg8wk2IfXXUe3YhDW
nJPiv/KfHaHgHvKC4zTxZgs4WXXZtzgiiZ9URyea0RFHy2OXkjkeWwrBiTOt8PcZ
f66zT8Qh9F9Z22U6MnP5KQCeCBAL4KhR2A7E9Ofsnh8Hzwfzp4ws7c+1gFf9e0dN
Gisx7wQ837pLfJ57cV66vhTkQ3Rp5eizUWbI8pWeEcMG5zIi3RhnoEZmZQYJQ6NP
tv9Gfp22DSZ3D21HkA4JX2eGeC9rHBXYFoz95dsyL0uopOAzAXL5VxHl1+zGYqEw
Np5LFMZb8ezD8Ls5fRViFM/yaabUAtpxAC00lOoADlTX96fCo9oxLUTmsO0wJFxq
Y+L9Y7p1
=iSbs
-----END PGP SIGNATURE-----

--AoOaiFZi/v7qW+wH--
