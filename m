Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983B9C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153438783A;
	Wed, 20 Dec 2023 22:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uBG5AyMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3764877F3; Wed, 20 Dec 2023 22:01:42 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F798783A
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e784ce9bb8so1064067b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106099; x=1703710899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PBfxZU7tCLw8OBM6PfN5/pZif7tPiwMiZQZZEVs8tvI=;
 b=uBG5AyMPfic9Cq3jO/JxvStgeSXHlRQacE//jBKI8BIl8LXMNSNE3sXCq+a3zoatUC
 Yp/QJs/xuzCx7ER5xjT0AjLpou0b8ZqrUOv2I0ZJI7py+Yn51wJmpR6gzC3wSmBdlUmL
 zkLq5SoqnQbZbJ6NONeshI4gzHGaFZu67UsVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106099; x=1703710899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBfxZU7tCLw8OBM6PfN5/pZif7tPiwMiZQZZEVs8tvI=;
 b=MCTruKGOS/ZOMx0h240m0PkFijn4f9ont7IcFyxjXU+vi/UMGoaJaxcqu5pbe5so6M
 SxfAowNxIzmaRnGG1B/5gUG8eUvhZoRIDbwfL+AvWiJftDwiIwlONsDo/eBuuW1oKaCS
 E27MBRtEKIyHwCRXaV1QPeBF6DxiFKB1b5rpoUB6quy2Y2zKLYNNnQeJXdqYbcqswyA1
 TmvaYPiK2/0ONYFKvDMM1Mzzhv2VwfVxD0Hy2KG0EbR7yay+UT1mhBXlbY8/qmTeJv71
 zwthWB8A4J5CTpAJcCB2l/4I51svv16BkqNVnkM/Zu92riIVXDdi58L5bWvr2NBqJvaV
 CZUQ==
X-Gm-Message-State: AOJu0YwI6LzIuJyJApJXMOrl0g68g8kyw+zhzBeJN3/0WqCiAnRq9uk3
 z/YV2AEVDoyiB5gxQ1A9NRkd4g==
X-Google-Smtp-Source: AGHT+IHGp2EU9n0OvKOtgA74pVlR8xQB7W8o/DSeDWY323IpDJmK7DpBsA8gOwYCqF8gHyCK59sOKQ==
X-Received: by 2002:a81:b411:0:b0:5d3:66ad:f8f6 with SMTP id
 h17-20020a81b411000000b005d366adf8f6mr225924ywi.24.1703106099429; 
 Wed, 20 Dec 2023 13:01:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 o204-20020a8173d5000000b005d3a41adfafsm224035ywc.133.2023.12.20.13.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:01:38 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sjg@chromium.org, sean.anderson@seco.com, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2 v3] Provide a fallback to smbios tables
Message-ID: <20231220210137.GT2513409@bill-the-cat>
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="95+C5dhjWLHl3k8W"
Content-Disposition: inline
In-Reply-To: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
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


--95+C5dhjWLHl3k8W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 11:18:48AM +0200, Ilias Apalodimas wrote:

> Hi,
>=20
> This is v3 of the smbios series [0].
> v3 has a bigger cleanup in the existing smbios code, folding in
> smbios_add_string() that were sprinkled around  to smbios_add_prop().
>=20
> The latter is now the only caller of smbios_add_string().
>=20
> Simon asked for a selftest which makes sense, but we plan to refactor some
> of the smbios creation code anyway. I am happy to add tests once we do th=
at
>=20
> I've also removed the r-b tags from Peter and Tom, since some of the code
> they reviewed changed.
>=20
> [0] https://lore.kernel.org/u-boot/20231127171058.165777-1-ilias.apalodim=
as@linaro.org/
> Ilias Apalodimas (2):
>   smbios: Simplify reporting of unknown values
>   smbios: Fallback to the default DT if sysinfo nodes are missing
>=20
>  lib/smbios.c | 163 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 122 insertions(+), 41 deletions(-)

With the understanding that tests will be added "soon" as well as any
reasonable cleanup of the code (along with adding features like
chassis-type being added), I've applied the series to u-boot/next now.

--=20
Tom

--95+C5dhjWLHl3k8W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVjAACgkQFHw5/5Y0
tyzbIgv9GglcSxN+Q0De5PcVbNlmf+sAMJXGjhrj51cQ6c0xMKaC4mAAbk3VFePB
diw3dKumw6GA7KcYsvZ3/z79HziKSAFx4MbnhBFeZD7Flfk2X6Uc+2JENpgJG3YC
TJwghWxk23/qnJxyaR+ZeSQFzH80yQfznzdxorElG+efn7nIB9gov8NDbqh3XyF+
+IuQoSvBI1ZgzyxS5JwS/Gl/fE+pGGWo2/Df+GBuXU66xV1uKlUSzpWe3S5xhb34
w3HSGvvsS2eSBkK35UK6uqbT+2+RC72zbIqGIsDGsJEmTMzq7BHXIkcE7ShDCa0h
ptiNtxGWn1Z7sx0QwWrFUG8NSRWfyUBmU1/XL3G9mXLXuKKEJc7JT7ZBFXNkvHqa
9KW5E1aRsFo1wq5kEj/56eYPTSx0GjILtqG/bgej1JngdXuE75qinvGwckSp9fi9
+/D7HRRm2kctXK80Gy3qeGKnX0MBx+QlSmulLBdvk+s6ufLs0oyLHCQdbBo0KSOy
kwt5qkUf
=N02Z
-----END PGP SIGNATURE-----

--95+C5dhjWLHl3k8W--
