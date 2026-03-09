Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C6FCA19E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 23:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B2383BC8;
	Tue, 10 Mar 2026 00:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="deuSV7lZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4391683BC8; Tue, 10 Mar 2026 00:16:07 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AED83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 00:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40974bf7781so5239805fac.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773098159; x=1773702959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xginW3BEDZ98qeB0VS45XicLu0LWaHM+dnnXtbueooE=;
 b=deuSV7lZbInP/nq2OC1td9hgDHmtM2NZyWblhxHn9MzmUpvfBAvJ2FSzh5m1BNJ2Ny
 eSz/DlZ8hpfxHcViiUca9R1XZU4NCVAalE49ZXhZO8bXZUQec7XKpiN8U9QAnmATKV0x
 ywMfOdOidcbdqziLT+oF9RODzBQZ+9JFspW1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773098159; x=1773702959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xginW3BEDZ98qeB0VS45XicLu0LWaHM+dnnXtbueooE=;
 b=WC83Ulg87Z3lKCm0jULMJ4qMYaDrqzjldO9bbHuUWBOpTzpUKGsVS4Hm8cEyUwtHnh
 XwV5GYppcdYI/6El11lAtZkSEcHS4bBzIn2ceRD5ucEWbLZf52dvajq1jqNxWKeKXEMC
 SPY+pY01SWA05+Z1qcFpuGq62MunH4+ygVwjYLGLf2xekJqjcH6FjFs2rOYqUXdIpZ4p
 CgtVp7Z6Xza67WsTixWCNSc3W4/QuI5dQKAR/9PAlg3DWbwnXhiXfnBRD85Kfmr76DK0
 kROzDKlAKhz/s+o1wuMmbC9khEjkUr+5i81kSpzLNzyR+2KQS9CWlnh8hWWXLXkFsi3j
 SyjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVVdEpBMe+ESqftjLWIYjJ6Gc7844fJWnVadyY5MXTWQJ7+ZP8jQcWTUnMUWan9jeH8E9ymnY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2/x3pFNrtptAKd0ztpxUcGk55Rv5LrXSIvsYWzCIL7YKlWbNt
 Xqm3WtvpxOoIs40fA89GRKeBYO0k3/JnxN+JwED47db0aaRk+CpNn6+WsyB6+cY2mqE=
X-Gm-Gg: ATEYQzx64yxqjXvbrhsm1eNxVRufEkuplnLeZPj5eYvyzqj9EPMSpUtjRhKUXdoxP6H
 DXuB9l2MTgefFK6nEjfjX5EeMQwQ013hNlBB+q8GgKoZm/uQOfgWJnccI7m0grDNXGKTft0gFhk
 GjpZ+jvngmgmjc1TtfDH9nN6bQUmsiucfo49xYFtRiDOrI6priXL7Fw/eMlYt2wv0vJiEd+Lwee
 IhDfWR7h5Xczmu0uySoAsQldLs5ExHyxwUSsgzQlnUxakP3uznRqcveqR9GZy8bUaqwPM38ySde
 qBNr2BgNBhiQxCWFfzuhjVb583DHysyaT4OKhsAit84XkF534rIyIQU8JkvkcwOsZD85UssZVXE
 cqQrG/WPRCR0hIZyeye/ulGTcA9MaytbLuFWzVfhgXeZJqzQLMbLYa+2LKZvBY2oZ4n7axi8Q+U
 7km4hIW2jkWBGESsfN9jgh10QPdhnZVxXIqwV0ntFz4jfo8M9XLmAn2oNOWBF0Njczirif2/hRQ
 5qBf5fpcZP03jnoJv9WVBFac3e7qFdSQQv2fjJCqm37kg==
X-Received: by 2002:a05:6870:a547:b0:3ff:46ad:271 with SMTP id
 586e51a60fabf-41756aac408mr803373fac.23.1773098159222; 
 Mon, 09 Mar 2026 16:15:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756e13565sm979667fac.18.2026.03.09.16.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 16:15:58 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:15:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Moteen Shah <m-shah@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, u-boot@lists.denx.de,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH] configs: j722s_evm_a53_defconfig: Allow configurability
 of MMCSD speeds
Message-ID: <20260309231556.GA897647@bill-the-cat>
References: <20260220072515.143720-1-m-shah@ti.com>
 <08cfa2f8-8fd5-4e82-91f1-7e73d80b8406@ti.com>
 <aaf3f58d-05f9-4b4c-913d-18fe2935279f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IAnUdzU8Rc+IFX9h"
Content-Disposition: inline
In-Reply-To: <aaf3f58d-05f9-4b4c-913d-18fe2935279f@ti.com>
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


--IAnUdzU8Rc+IFX9h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 03:17:37PM +0530, Moteen Shah wrote:
>=20
> On 20/02/26 14:05, Kumar, Udit wrote:
> >=20
> > On 2/20/2026 12:55 PM, Moteen Shah wrote:
> > > Add config to allow UHS support, in turn allowing to select
> > > UHS speed modes for the SD card
> > >=20
> > > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > > ---
> > > Test logs:
> > > https://gist.github.com/Jamm02/e8b8b8c95cb62a7145d73f7ef50b2d8e
> > >=20
> > > =A0 configs/j722s_evm_a53_defconfig | 1 +
> > > =A0 1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/configs/j722s_evm_a53_defconfig
> > > b/configs/j722s_evm_a53_defconfig
> > > index e84670c75ed..24ee293c803 100644
> > > --- a/configs/j722s_evm_a53_defconfig
> > > +++ b/configs/j722s_evm_a53_defconfig
> > > @@ -107,6 +107,7 @@ CONFIG_MMC_SDHCI=3Dy
> > > =A0 CONFIG_MMC_SDHCI_ADMA=3Dy
> > > =A0 CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> > > =A0 CONFIG_MMC_SDHCI_AM654=3Dy
> > > +CONFIG_MMC_UHS_SUPPORT=3Dy
> >=20
> >=20
> > you may need at A72/SPL stage as well,
>=20
> Other J7 boards already have this config enabled in the a72 stage.
> >=20
> > and do you think , R5/SPL will need this too ?
>=20
> Any of the K3 devices does not enables this in R5 SPL, though we do have
> HS400 enabled in the R5 stage.
> Adding the config should result in a little performance gain I think.

Is this a function of board design, or a SoC-level feature?

--=20
Tom

--IAnUdzU8Rc+IFX9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaa9UqAAKCRAr4qD1Cr/k
CgirAQDvlGgG5WFRCB3NbCDwXYAwiO5Oy3gtHFBQWaCPfR8bXQD/XYDT4M5yGsVY
Vix4uQYfIbi/cxedkJoj1v/IHK+mNQY=
=bamM
-----END PGP SIGNATURE-----

--IAnUdzU8Rc+IFX9h--
