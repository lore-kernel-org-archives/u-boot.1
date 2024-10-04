Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDADDCF8860
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 22:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DBAF88ADC;
	Sat,  5 Oct 2024 00:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="upmGVVu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C0888B0A; Sat,  5 Oct 2024 00:02:33 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A845889E9
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 00:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a99e4417c3so209876285a.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728079350; x=1728684150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=888DKArgWc0lVyYh4TgkLGl+D3TI54F7wvwBbDtoOv0=;
 b=upmGVVu7NDkxlNtXbNNOOHEYzfWyF3IdoU5YII7mChUYGavUPHwEPuzSB9cY1dKwui
 R8jfl/bp3Mvx5G50ydSkVUmk4w2bGfmNVOL9SYEpmKu8DQUxBiwSvEXi/NIxj0GizwBf
 VCBo5IfVzjJ97KX2pVybRQ9+Obn263CFRJnhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728079350; x=1728684150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=888DKArgWc0lVyYh4TgkLGl+D3TI54F7wvwBbDtoOv0=;
 b=CIEN/G+E5gbV42av8RKhhtG4OvQr0qByOn8PR9V9ogl67o55pa0adrfzH+2KnM+3cl
 AQjcEMJfJwYcd7PFfJPgQk7jIN1k7CY5TZqrD+YmZ+LoRXmD/dTvlGEoPPh9KjGQx24Y
 dapq/qOUPT3H/fJmMY62wQwc64wnRjITso3URNbU5khEgrM+UJ6r0/S2hk0B3b0Fq6CZ
 vMnOoVnCRdakuU9kRLRAgfGVWBn87/rxM1datCQ7AddE0m4QPww3PmG+1T/vxCPsWMIC
 F7wy4LKFzYb4obttYk/UjzS4qwK53bSIpCMcxSwhzRd2UjWZheGirhe/o8+ZutW8P9eq
 Te2g==
X-Gm-Message-State: AOJu0Yz50TQ1vkn6Q32+ZgLzzVroegTg1opBUAdok66W2nMsBw/o8VPS
 hnrhr7/FT4VJT1xUq6z6BZVsx+mrffSHPZiLk7Elz9cbP3+G01kCEMf/BwkaN7I=
X-Google-Smtp-Source: AGHT+IGyTLEMcMMFUNNbKy8QyMEm/So6c9qa2OnCpOMwdeSRJ1XkvCQOokWAByIstMva+gdazvcMpg==
X-Received: by 2002:a05:620a:4402:b0:7a9:b4c7:3e18 with SMTP id
 af79cd13be357-7ae6f44c5cemr630745185a.31.1728079350030; 
 Fri, 04 Oct 2024 15:02:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae75615911sm23543385a.25.2024.10.04.15.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 15:02:28 -0700 (PDT)
Date: Fri, 4 Oct 2024 16:02:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 Nam Cao <namcao@linutronix.de>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: Re: [PATCH v2 03/18] bootstd: Avoid sprintf() in SPL when creating
 bootdevs
Message-ID: <20241004220225.GA2484623@bill-the-cat>
References: <20240920081309.140426-1-sjg@chromium.org>
 <20240920081309.140426-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BoqdMGpxb6O9AXVn"
Content-Disposition: inline
In-Reply-To: <20240920081309.140426-4-sjg@chromium.org>
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


--BoqdMGpxb6O9AXVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 10:12:42AM +0200, Simon Glass wrote:

> The name of the bootdev device is not that important, particular in SPL.
> Save a little code space by using a simpler name.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  boot/bootdev-uclass.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> index 807f8dfb064..79d4d990edb 100644
> --- a/boot/bootdev-uclass.c
> +++ b/boot/bootdev-uclass.c
> @@ -16,6 +16,7 @@
>  #include <malloc.h>
>  #include <part.h>
>  #include <sort.h>
> +#include <spl.h>
>  #include <dm/device-internal.h>
>  #include <dm/lists.h>
>  #include <dm/uclass-internal.h>
> @@ -278,8 +279,13 @@ int bootdev_setup_for_sibling_blk(struct udevice *bl=
k, const char *drv_name)
>  	int ret, len;
> =20
>  	len =3D bootdev_get_suffix_start(blk, ".blk");
> -	snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
> -		 "bootdev");
> +	if (spl_phase() < PHASE_BOARD_R) {
> +		strncpy(dev_name, blk->name, sizeof(dev_name) - 5);
> +		strcat(dev_name, ".sib");
> +	} else {
> +		snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
> +			 "bootdev");
> +	}
> =20
>  	parent =3D dev_get_parent(blk);
>  	ret =3D device_find_child_by_name(parent, dev_name, &dev);

I don't understand this change. In testing, I don't see any size
reduction in SPL anywhere (no platforms shrink in SPL for this series)
and just size growth in main u-boot in this function. Did the wrong
comments get applied to this patch?

--=20
Tom

--BoqdMGpxb6O9AXVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAZeoACgkQFHw5/5Y0
tyxVjwv/XTPVugfDqnsAZ2y5/crHxM2O6ArQh5Nl+X/ZQPj3FWEcaLMGKcXKHzX0
zPMLybY7tGbVpmqLTk9/o6dVyxIO34IYpC16yAS6q4ZqL4rr9iQwRHWvng6EyxNU
Nk0jLchEngpiFXQ3v+wFvFChmVGMBZ+rKW8RlCY1+ZQmst/NVmIE7os1ZPtd0sp+
tonY81iOZzjIM8KyInGs8Lg8npAJDCGyGWWXQ2Rv5lHYK+OXYiUOhiYY7fm1w+0s
PNKStUfgueFp2+Tkb7XDVv2Q9c4OGxI7OTgjRS9p+nTog5/kBjy8D9FKlHuzzQI4
GNVM+0mYAXGsxv3d434b0UEqSvuA2iE0Xp0JQBSfr9VyNGXL5GNBnpjw1zcnrHKk
1NPTpkVbA5CLcs8kIybOU9a2jXjW9ct4J+T4kOX3v3u/gwjOvEK81xL7BFW6ToSp
zVnnGBbO1K7IS7CxgKdpzvcxlg31KSYfUPNjmAb7PU4rM/QxBaIEc1yC5ka5iY2O
kw/jGbfu
=aQwJ
-----END PGP SIGNATURE-----

--BoqdMGpxb6O9AXVn--
