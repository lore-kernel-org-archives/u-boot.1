Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8506FD8FC3
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 15:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529E083E83;
	Thu, 26 Feb 2026 16:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NS7laF4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B3B83EA6; Thu, 26 Feb 2026 16:26:46 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3C983AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 16:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6774d63d2e0so422525eaf.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772119603; x=1772724403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HXqRGM9mQ6JhxsAj76ZeHS4o0jtB9xUL+kTj5A4hYlA=;
 b=NS7laF4ArO03VuJ1HzaLAsz8fNLBwkN0GT1a1HaMBYA9TUHUPmiNvyC+wgZ1+yG9/9
 I47jh5fjFyLeC8HNnQq2rONBQVXetSu2oPfqZG+1V5Fo2SisTcpGNPy2aZSgsxahFcDY
 lHYngJMTfcZtOw6C+hQho1d5S06rcbYerekkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772119603; x=1772724403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXqRGM9mQ6JhxsAj76ZeHS4o0jtB9xUL+kTj5A4hYlA=;
 b=FVIxy73HiiI38YFAIY1FBEqazm5LZLbIT008ymjYnbky4lEpr1uvLht3mziBlxKp7j
 UWtjNLUd6jroP15kHGNIEu3HezSqmVZafvL3f5NuYIa8gi6IdAxlSEvb0CA1QLs2myvt
 ptEUNm/Fgoa/8mMDI38BoGC2HwGK0VgjxiRM9WEX+MIPAHCqBsm8rY0JjeuW7krtAKU3
 A3EBzJM3d0EtksUp6fAOqFh/q0g7qPYsBP8ZeOyU8h4bA1dqxlpXAioCO7dTFtK6hjKy
 vXVVZiSOrbt2k1tbgKj2xAnnFliLOP8dYW27wfNF0vgDvW+mOgRKBhSO6gZIiiWFDdWS
 Q2hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcGIa644Gnc+a4qp4H718NIgs0dSoEr+bhGEMbEGqgH76iQUGweY62Sl/dr30eZewsvE6qSiw=@lists.denx.de
X-Gm-Message-State: AOJu0Yym7yASDIqdW8ZpUU8mj5/kcE4koBHL/8IwJekECeRjnMyQAjYp
 CFxQuw+uaMvLk3y1zqZ0psvcPVNXJUgyMAStzPiRE+Hj5W8h4ypw3nl/AnX+VESwYZM=
X-Gm-Gg: ATEYQzxQmrQpicaAJqjlzdEsgFZF9POU+mK0SZlBS2lxFeSj07BsULdhfM6/YVZ7Wev
 Zgl3DdKdUPw17KocKgnw5d0yeidy7pyUGT3imsuP2fCKoEvNn01UQSlaPfRb6+nTiPLtuP6bjKX
 a6dBG8qyIygaP7+zyk90sRj5HlWajxFXD1kiOXDtnsOHsiyB9jJOIKBRc9+yb4Mc6nZnvKulP33
 wN+9EjSCdM+k3yLQcPscthSVVD3HJ2cphv3uWy1nEM85ZIJmOipe6ZGF+ZwFEBfq8E7MhDH2335
 5pT0Tkwh4k/i8Fumzya1maqga5PBTmGQ/ubjlKSgBisuxvk3l1J6xd/hyoodUx2LJSbGmpTAfbM
 8vgKlp41CWPJUSHL/HQUG/1rWiFQ01+nDnr0z+JY1gM4Bzp6DIazKCxBQwBx5e7DHNv7/5v7Gae
 zw6tthTTbwqiAzXJHw3io1XT9jCOz7S5vEaj9fO9hSk/azxv3JL3moZehDlnbQDNTgBc3RxWVOG
 8ymWv0y3Ja+MS5PPa+0u8fFMpfVshe3Z7YYiQbEKKYuhzw6ktY=
X-Received: by 2002:a05:6820:1611:b0:65c:f9c1:cba0 with SMTP id
 006d021491bc7-679ef97d1e9mr1993163eaf.37.1772119602736; 
 Thu, 26 Feb 2026 07:26:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2d85297sm1576744eaf.11.2026.02.26.07.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:26:42 -0800 (PST)
Date: Thu, 26 Feb 2026 09:26:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Re: Re: Re: Re: [PATCH] arm: Backward compatibility to U-Boot
 v2020.04
Message-ID: <20260226152640.GG1593142@bill-the-cat>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
 <20260203170002.GO2603314@bill-the-cat>
 <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
 <20260206015447.GP2603314@bill-the-cat>
 <989f3c4aa5a04fd3b1c2efda1aedd459@rohde-schwarz.com>
 <20260206150345.GT2603314@bill-the-cat>
 <1000751cb4604e768e2f789c3dfda18e@rohde-schwarz.com>
 <f991777100194a22b350660b5977cf27@rohde-schwarz.com>
 <20260225222417.GY1593142@bill-the-cat>
 <669abe865bc74dd6aeea69caabeae259@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S4cIb5BwkGsQ/hxV"
Content-Disposition: inline
In-Reply-To: <669abe865bc74dd6aeea69caabeae259@rohde-schwarz.com>
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


--S4cIb5BwkGsQ/hxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 08:15:14AM +0000, Dorde Stojicevic wrote:

> Hi all,
>=20
> yup, I completely understand and agree with you.
>=20
> One way would be to detect the characteristic string Lynx has in the begi=
nning of the FIT image " eLynxSecure" :
>=20
> mkimage:
> FIT description: LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
> Created:         Thu Feb 19 11:44:07 2026
>  Image 0 (kernel-1)
>   Description:  LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
>   Created:      Thu Feb 19 11:44:07 2026
>   Type:         Kernel Image
>   Compression:  uncompressed
>   Data Size:   =20
>   Architecture: AArch64
>   OS:           Linux
>   Load Address:=20
>   Entry Point: =20
>  Image 1 (fdt-1)
>   Description:  Flattened Device Tree blob for LynxSecure 2025.10.0-39844=
b80e0 SRP (aarch64)
>   Created:      Thu Feb 19 11:44:07 2026
>   Type:         Flat Device Tree
>   Compression:  uncompressed
>   Data Size:   =20
>   Architecture: AArch64
>  Default Configuration: 'conf-1'
>  Configuration 0 (conf-1)
>   Description:  LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
>   Kernel:       kernel-1
>   FDT:          fdt-1
>=20
> xxd -l 128
> 00000000: d00d feed 1dea 3bd5 0000 0030 1dea 3b64  ......;....0..;d
> 00000010: 0000 0030 0000 0011 0000 0010 0000 0000  ...0............
> 00000020: 0000 0071 1dea 3b34 0000 0000 0000 0000  ...q..;4........
> 00000030: 0000 0001 0000 0000 0000 0003 0000 002e  ................
> 00000040: 0000 0065 4c79 6e78 5365 6375 7265 2032  ...eLynxSecure 2
> 00000050: 3032 352e 3130 2e30 2d33 3938 3434 6238  025.10.0-39844b8
> 00000060: 3065 3020 5352 5020 2861 6172 6368 3634  0e0 SRP (aarch64
> 00000070: 2900 0000 0000 0003 0000 0004 0000 0056  )..............V
>=20
> Thing is I am currently pretty busy with other stuff, so wont be able to =
commit myself to it at the moment.
> Maybe you can work out a proper solution, based on info I provided.
> To my understanding, shouldn=E2=80=99t actually be that complex, e.g. jus=
t add check for eLynxSecure in the code location where my patch is.
> But may be I don=E2=80=99t see the whole picture of U-Boot and missing so=
mething.
>=20
> Let me know if I can be of help somehow

I was suggesting adding a new IH_OS type because otherwise we're going
to be opening ourselves up to invalid (or malicious) images being passed
in. Thanks!

--=20
Tom

--S4cIb5BwkGsQ/hxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaBmMAAKCRAr4qD1Cr/k
Ci5OAQCATtvIAEj7HvnoG7rJxeROQwMdwBwG5JrVOCnBtziApgEAgydkJdSd+4Ak
YZH2SFLZpAUMPz0XwMzrFLzkDICaHw0=
=kvic
-----END PGP SIGNATURE-----

--S4cIb5BwkGsQ/hxV--
