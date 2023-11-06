Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF57C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB6287113;
	Mon,  6 Nov 2023 17:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SPYfLjiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B6E487114; Mon,  6 Nov 2023 17:33:36 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA7F86FF4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77063481352so459064685a.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288413; x=1699893213; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+szqMFI851KfjlqJhGFT37ugh5mBY5j7MV2aW3r8iuM=;
 b=SPYfLjiM8QamBiu3xUIGp4waixmU0WXn54PEbz2+Y4ivQGKdz8KX1oSuPdxQ1vAbZV
 vGCLx/bBVVhTS2ce8YH/gkioAJL7DttuEraIgUtSzty4ePQTMur9IoX+Dx11GY99ELy/
 j66540XuYAiDbOSxz/1evgXApBTzdGHWkw+pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288413; x=1699893213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+szqMFI851KfjlqJhGFT37ugh5mBY5j7MV2aW3r8iuM=;
 b=hpICE6s0/FI6q0F1WNug9K2uqkm9pp5eJVZiKhpF+SS1k0DxF245Olr6StNhWLGbxh
 aw+qtJ/qmIAEhPXD5tAmNuz0hkSFpBvuXbMJFsHzYCZfmH0Ei/6RJsla9/L3MdsT8ioX
 jHebJ68TDImO7P9llJ4k4PCv33f7sM4ty0OgbKUjtjwh+8a0Y/0qvmahhwgn7Z2wZTvo
 2oFG0ZohrVXf41fwvOlfV4lh6XqeIrhL/WN2eWXhNdfz6fhoqj/zy/OK6ACggpM8Eg7T
 lss+B5QdNLBbnmnDfqKtD28UoFuVQyV2bxeCdDslDBUqCGW/EWb8k64GrCl8tjznXZ4K
 cFWw==
X-Gm-Message-State: AOJu0Yy+FC2SZklsHPa0qu4zYRll+KwoKrKjNObQrmDdMadBqJgkgk37
 Td3G9OxRVGvSJcPHuk210wDjpw==
X-Google-Smtp-Source: AGHT+IEhtRAwoHDaBl98chcBFT56Q+vqd3XLiqbJuYCTv6GRSWIPxqmJRvvJrPcENAxl48Vhe4tyFQ==
X-Received: by 2002:a05:620a:2592:b0:773:a91c:6164 with SMTP id
 x18-20020a05620a259200b00773a91c6164mr14186797qko.19.1699288413133; 
 Mon, 06 Nov 2023 08:33:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 e6-20020a056214162600b00671248b9cfcsm3551804qvw.67.2023.11.06.08.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:32 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Frank de Brabander <debrabander@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCH] net: phy: TI DP83869 fix invalid clock delay configuration
Message-ID: <20231106163330.GV496310@bill-the-cat>
References: <20231006122439.10720-1-debrabander@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sT323ZYaHul2mQ/M"
Content-Disposition: inline
In-Reply-To: <20231006122439.10720-1-debrabander@gmail.com>
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


--sT323ZYaHul2mQ/M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 02:24:39PM +0200, Frank de Brabander wrote:

> Setting the clock delay from the device tree settings
> rx-internal-delay-ps and tx-internal-delay-ps was broken:
>=20
>  - The expected value in the device tree is suppose to be a
>    delay in picoseconds, but the driver only allowed an array index.
>  - Driver converted this array index to the actual delay in
>    picoseconds and tried to apply this in the device register. This
>    however is not a valid register value. The actual logic here was
>    reversed, it converted an register representation of the delay to
>    the device tree delay in picoseconds.
>=20
> Only when the internal delays were NOT configured in the device tree
> and they default value of 7 (=3D2000ps) was used, a valid value was
> loaded in the register.
>=20
> Signed-off-by: Frank de Brabander <debrabander@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--sT323ZYaHul2mQ/M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFVoACgkQFHw5/5Y0
tyzh2QwAjqCRQwHWxvQPh5OxfrsrdoHHM4HcTOIxLA33TKcAcSFXrgTH2DZ3fGBf
N+CM+TUq5d22XW/BmhUfXITw7jdA8DEcRhAhSLWuEoWo2zwU9NSZDAPYEXPmLLhF
6DaJCjma1OFY0gxAeqsdrarf0od+xkiTeRpBBwWcgSakmd7Ws+NCCnANmJ+GW0e6
KlrsZPUfLSMWWdapg0g/mVY36HsTagzX9cyymUbRn7TYqWvf9JbkM9ejcaW+u4Ar
e6do5ny5gvbgORBtvVUlf/ndu89WfgKkxCLRXdAe0dp16OJa9qdVIRz9rsSPyQbC
r2OUlJDvpGdHwRL+nLFWNoT61aqJGXul7Nr/cCmFcdwgH1nOD/Ul3Z1wxvkn1/GM
Nr22iqdx9BK4tshN+ccR9cslYRsKWJc6RoED6ZArHnTIZGtEiQ2dwMrHMF/AcjfM
OwfspgFihRMoFrR+0IxPDCQV+jNB/m9LdA7kGkazBW8vCZ7thyJ6gyZa6LSs8DFr
xkPqySEN
=0APa
-----END PGP SIGNATURE-----

--sT323ZYaHul2mQ/M--
