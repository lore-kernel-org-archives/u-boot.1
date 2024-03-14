Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA6CC54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87EB787FA3;
	Thu, 14 Mar 2024 01:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TV+V4uRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C89287EDA; Thu, 14 Mar 2024 01:40:15 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6110787ED8
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78810ba2ff1so17664085a.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376812; x=1710981612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r4kyR5gJGa6N0LO2QajlCBaEzSlOWNYnnimCN3BNK+Y=;
 b=TV+V4uRsQVQ1u5+lTesdKlZfelRm7k0myvcCI1kChF1pEp4qchvNIf30deU6+hAqQR
 P8aR+xEeHg9D6rSoUAtn3vc7NhQEj5q+f6B/zh8sl0geYDqAROr6S78ZqST7++boN96A
 u9JD/MaZ8F+P/ViTLH6eo3co67kjs2YJD1d5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376812; x=1710981612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4kyR5gJGa6N0LO2QajlCBaEzSlOWNYnnimCN3BNK+Y=;
 b=KhoeS4sttrtmIc8pYCatCedb5luFlBR1Gdg/dC1BwETLER1ULkAt6IH6eSBF//c+ub
 ZTkjpSGv+BtgKB9r2KhNPhuYQmmGLwKc7o28IFhlax62at2/1GTx6nztYQr+AymCdFDr
 X2Y8fo/RoFSyjHrLrqZ5Dv3Ne8RJWTbYUiaXeAPi8STXXnMJqw0psv5rVGG+GSG9LfiO
 Y5wpTEAYlKrGZEDkZBpUtwU9e1OOLHjbh8Chw9WRuwHgEiERJGw8DanasLDn6ZTk0nGh
 DnGBjG5rGMg1Sb7TimZB6c+BV3J/V8gl41N0YQoORPSycIaDDd9shordtvwEx/tWOrCg
 nDww==
X-Gm-Message-State: AOJu0Yxo8kVXHU2eF56fI/Ne/UhlpCI0iCqoMyu0kehIFJruZ8JALxmN
 qqkr4lmyGnHOyC5LyvoLvQdQElDkhEf7PkcwXIRLLTcC205Qzzd7LwryU/Gu0h8=
X-Google-Smtp-Source: AGHT+IHwzRFVBG4D2A5v73zQBlr0vGpWS4aDhAfsogTlKmSRfrBytsII+n4TntP7cKIwejALScLgYQ==
X-Received: by 2002:a05:620a:29c8:b0:788:2367:509b with SMTP id
 s8-20020a05620a29c800b007882367509bmr443534qkp.51.1710376812169; 
 Wed, 13 Mar 2024 17:40:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 c14-20020a37e10e000000b007883a49baeesm172683qkm.4.2024.03.13.17.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:40:11 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:40:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: u-boot@lists.denx.de, Maxim.Moskalets@kaspersky.com
Subject: Re: [PATCH v5] cmd: add FDT setup for bootelf by flag
Message-ID: <20240314004009.GN3442575@bill-the-cat>
References: <20240307212914.83657-1-Maxim.Moskalets@kaspersky.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ziwlBEMvMDINhbAJ"
Content-Disposition: inline
In-Reply-To: <20240307212914.83657-1-Maxim.Moskalets@kaspersky.com>
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


--ziwlBEMvMDINhbAJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 12:29:14AM +0300, Maxim Moskalets wrote:

> From: Maxim Moskalets <maximmosk4@gmail.com>
>=20
> Added the ability to use FDT for ELF applications, required to run some
> OS. To make FDT setup, you need to set the -d fdt_addr_r cmd option for
> bootelf command. Enable by selecting CMD_ELF_FDT_SETUP.
>=20
> Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>

Applied to u-boot/next, thanks!

--=20
Tom

--ziwlBEMvMDINhbAJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR2kACgkQFHw5/5Y0
tywQhQv/QfUrlfi0iGDjQ2MDmBBX1Fk2AQie4PebMjOW4vpeiGZZNPi00OY9mazQ
DihuI6Y0Xnru6YIsB2aIK7pdyOGZTTn2W6blTVgsDi8GCvzQSHYoFfwDDvXiJwDC
DC05ZrclMGue+PSdDaRcTTrJG+an7ehjgH2W3GP5cbboZzxkEzfVOzXTIler/lxs
CkLM5DJSMEqaUqgeyVCZnFGVshXCw7YG8A0U+5vx7ZxiI9KjwjuPb+m2oVn4Im2l
nc9oqFfufwcrf/6pNAv8LGpfXwTIlBEzFeZJksyn1gk02jTAFI0F9a6uKl0gK+8C
EqcyQBK2+WJIPF5IWxEHOv1Fr8RBGrvigM4oVdRXhRSATpHghHFcWfUVGY8jG2Ad
bLP7ZHbEOz9d+UdYdDVAqqSNwNd/KOg9/7tJHmR1rlzaLaRt7Nhr/ZTf5m3x7GKN
J/qEY8QToh8IfDep5bglfxlm2gNVYaHziNXq7Yw+Qrsc8R7al8zSl4rO0o0On2Em
Z7DQcyvz
=wAJK
-----END PGP SIGNATURE-----

--ziwlBEMvMDINhbAJ--
