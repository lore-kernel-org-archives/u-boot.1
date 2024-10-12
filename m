Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1025CD0EE1C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616FA88D13;
	Sat, 12 Oct 2024 03:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h0ajSaMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038E188D9B; Sat, 12 Oct 2024 03:40:16 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E319288B64
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7afc67e9447so228111785a.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728697213; x=1729302013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x52sFppTIKGcDbR3y1O6n/UPKepS6w9BjkGOxrbxdrk=;
 b=h0ajSaMddbsmDi3r0azf0AMxcY1TLKCKM2UoRnXmgTCfP0zzWDomoLdXEOdgbFJGq9
 K1VSahBWRL4Gg7+zEO83mT6k8KRRTP2dKiMRFRBTsE3mHqJmO6iEjzwczu5KXUwj2n/f
 MmR+t1+VwOsqqJsRqL+TjxluOVCWEUESddqk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728697213; x=1729302013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x52sFppTIKGcDbR3y1O6n/UPKepS6w9BjkGOxrbxdrk=;
 b=sjSAR9YZ1giEoGv4bRONgHXuEVEh5XTg7BC3TU2pFgQ6afxBivVnBsiVH8q7emD0Q+
 9XR73rkc4rrUU0sVmQTu2v24PuwlKYomIQf1ZskehgIHV6kICmWS0ugE8zY3KIPxXJQf
 9hpkllqfcl7tofTDrjb6D1yS9vlkC58Ih83sM3BgFBuk7lVz1OEUTXON7LKAuxY9wmaj
 4Zxvx3AGs//yzpPfW9SRCLIBaBcDPDly67QZ/jN0v6CP3Isgl6flCUwLTd1MojWzip9a
 4VDE+D1QYvKdvqOl2vp9UJqedOSng74YgFVZUpfZ9SpBAl72CIddcc08yMIL2PEuMo+F
 IAew==
X-Gm-Message-State: AOJu0YyI8PIGYg3nd5kPuxm7mbnpn85txdjdEheAoH25cj+zfaSdHb05
 94zSgyiw+yN/KQJXUTbJgaE+qH7UiDBrnT+z2mg8/07/VlCHB5w27gVpRon+zWg=
X-Google-Smtp-Source: AGHT+IELXqAnGHFNrZgU8yLfy1nvf6EwTOWdofcmfyBV+l00LW+L8LTrasSAtISb9fiwWnmQlwBQnA==
X-Received: by 2002:a05:620a:4629:b0:7ac:b99b:48ef with SMTP id
 af79cd13be357-7b1124b2663mr1580958085a.10.1728697212677; 
 Fri, 11 Oct 2024 18:40:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042880f87sm20885631cf.68.2024.10.11.18.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:40:11 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:40:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 6/7] cmd: Move meminfo command into its own file
Message-ID: <20241012014008.GI14210@bill-the-cat>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Op3AH42xngickHb0"
Content-Disposition: inline
In-Reply-To: <20241011214032.760072-7-sjg@chromium.org>
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


--Op3AH42xngickHb0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 03:40:30PM -0600, Simon Glass wrote:

> In preparation for expanding this command, move it into a separate file.
> Rename the function to remove the extra underscore. Update the number of
> arguments to 1, since 3 is incorrect.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Split into its own patch
>=20
>  cmd/Kconfig   |  1 +
>  cmd/Makefile  |  1 +
>  cmd/mem.c     | 19 -------------------
>  cmd/meminfo.c | 26 ++++++++++++++++++++++++++
>  4 files changed, 28 insertions(+), 19 deletions(-)
>  create mode 100644 cmd/meminfo.c
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 37894eb80d6..2fd29e9fa88 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -878,6 +878,7 @@ config MD5SUM_VERIFY
> =20
>  config CMD_MEMINFO
>  	bool "meminfo"
> +	default y if SANDBOX

This should be default y for everyone, to keep compatibility, and then
your enhancements should be a new option.

--=20
Tom

--Op3AH42xngickHb0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJ03gACgkQFHw5/5Y0
tyyUagwAngL6VSQ+nLszvodBBjP7xUo/lLm2ZJcHgj8/dOwiDulE8TOhN9KF7f01
RgAnp0uIYzSk/OJu7wFIb+7YCk/Ejm0JgvGAFWlV5HO6k4MOzj9O3ZgnR0BtK2U2
D9leJOqprxvLXO8N6HIpcHVEkNmcVzeIzLHEEleom5gKwicEOv3wvOt24AzHw59W
scXcsuiDXYv03PXSIDh0j2N/wAE5qwfhczGYXiGYzgOkIVphskGtheeRiaTO+YH0
8fI7bPDY/BhEV4/HwSHl24+SMKPP4geWg4hPA4qqLLOmxCLdQ4pIIwFfJL1Tsqjj
1Otg62GOrVtJhdxWAOYo1ev6hxiTGh+C0FHvfiR1/KXWFm6FMRJShlLBzzEwVUA0
c4ugfd/WXzCoDqrI2Ij4MIyRm9JjjdfzjmEJndgwMZ9z31HqYgQQexkbSPb5W/JU
1Ovwah6Xa8EQRIdXh95rtxJIFuztNIYp307yWvgUakHwgY0aLrjN8bhcNdQdloKo
qBQzpNRf
=7KYH
-----END PGP SIGNATURE-----

--Op3AH42xngickHb0--
