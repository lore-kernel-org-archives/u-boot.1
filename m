Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03345E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C698975E;
	Mon,  9 Dec 2024 20:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HKc364SH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDBA89723; Mon,  9 Dec 2024 20:02:03 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A188977E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d891ec719bso60035876d6.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733770919; x=1734375719; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ye1VWQp7XG6WVeFztw2P+FUHOQKTTmTDHkNI8D3648U=;
 b=HKc364SHLd0NI1kKcGRf5mHSuMFIUQez97DOVo9vFOgLaOgl6PYXt8Ntjb8m+JY5WN
 bIm6EILEiKM9RHyD3vbQ6XFFAcmld1nWJ4GxhhWepAWoPlljPyPR96edg2Eqycj8ouKD
 3BXvcCStnYdKIdrNkAZdY+JwB0Kzusg4Kncs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770919; x=1734375719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ye1VWQp7XG6WVeFztw2P+FUHOQKTTmTDHkNI8D3648U=;
 b=ncffCGONcP+c8yZDsct/V3I6PNJ1yHfWrqG14BTrN3woKQO5SXNz4Xy7hJeOm/IBHv
 QNkjmiD+6f28yD+3XIFVt5gl29VLFvXyv/ThbJ1tyJ5PokfnUArVgd11KMNShjtYzqts
 4qGagokeTZAcVgnuKdtezChgBwa7nlR4qaPHcPI9AVjfbYGXoLA9Yc6t0igm0aDf2yWM
 RXnUIBdqIUgeqm5DaaXPEuuYfarY15jGqwvcOEs34OfEulKjNQdc+/r9sWbsz8h1DAM8
 LrHbPUUjYaHdY3wY7i/+LdKvhpgICwYJlaYugoFhSjCeWz+KLUexYe6uNV0WFh7xvXCx
 nE1A==
X-Gm-Message-State: AOJu0YwYVQQof3oXuXGgs9zOIASLdoduVRQAsqWFOxeYOGJAcmXdbyaQ
 HC6TCBe2nuf8IpxoTLFwZjESzzPcE37cTxWe++FBpoakOMpvgj6vwzzA4fzBuis=
X-Gm-Gg: ASbGnctEfpLrlX4rnUyDb5B4NPtohIW0eQLtWybiKAMoU7xXPhOBtwGfdQk8DfIDmT3
 zBui+F/bAd0DYqH47il2ZAi3xV8uQlvRw0W1tZeafWBzgPxiDTQy/evWx2acPY/Cpa4RCOEQoe6
 stGmLLW+h7OAS2zr8O6cXcYG/fiq1C1l3KgIEfUu59+gBzocCvgxzC2x6topZ4K60fa/1s5l+dn
 +dOGVnp0gPg0Ssh5nfGSV5wXrEyrvVPnt+rFcr2WrSNssfyxi8=
X-Google-Smtp-Source: AGHT+IGtSGw7e2VZxXQO6veK6GKfqGen8FH6C7OGBVTpGsWztbKdNRku082dXFzgadWMUzPgsua15g==
X-Received: by 2002:a05:6214:23c6:b0:6d8:8466:d205 with SMTP id
 6a1803df08f44-6d91e300ba4mr26726666d6.6.1733770919542; 
 Mon, 09 Dec 2024 11:01:59 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66db63sm51658856d6.18.2024.12.09.11.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:01:58 -0800 (PST)
Date: Mon, 9 Dec 2024 13:01:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 4/5] rpi: Update environment to support booti and
 large initrd
Message-ID: <20241209190156.GT2457179@bill-the-cat>
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T4ImwvSqqeEd5O0G"
Content-Disposition: inline
In-Reply-To: <20241209182002.671953-5-sjg@chromium.org>
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


--T4ImwvSqqeEd5O0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 11:20:00AM -0700, Simon Glass wrote:

> The existing values don't provide for decompressing an arm64 boot-image.
> Add those values and move things apart a bit so that a 50MB kernel can be
> accommodated.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  board/raspberrypi/rpi/rpi.env | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index b79730a3e26..ee5a4810262 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -69,9 +69,11 @@ dfu_alt_info+=3DzImage fat 0 1
>  bootm_size=3D0x20000000
> =20
>  kernel_addr_r=3D0x00080000
> -scriptaddr=3D0x02400000
> -pxefile_addr_r=3D0x02500000
> -fdt_addr_r=3D0x02600000
> -ramdisk_addr_r=3D0x02700000
> +kernel_comp_addr_r=3D0x02000000
> +kernel_comp_size=3D0x02000000
> +scriptaddr=3D0x05400000
> +pxefile_addr_r=3D0x05500000
> +fdt_addr_r=3D0x05600000
> +ramdisk_addr_r=3D0x05700000
> =20
>  boot_targets=3Dmmc usb pxe dhcp

As shown in
https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.3050251-1-w=
alter.lozano@collabora.com/
there's a large comment block to update to reflect and explain why the
addresses are where they are. Please update that as well to explain
the "why" of the "where" things are placed, thanks.

--=20
Tom

--T4ImwvSqqeEd5O0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXPqQACgkQFHw5/5Y0
tyyCaQwAtIPABFF4yM/eCj1zgBglhBt/1dL2gjbLhtcBWqX4F3oxbFfDzDHh1wCb
Cg+R8kddTjSSSTls+RW/DsC+tYWh3RqkHTn0yUQiHKoMO6/JsXa4ug6r87PdmuLi
0WftqZN3un2QwdDBd6rjcOxHzO462EXpITjlME8017HG8bkL2UahErfiUKcFjKQA
oMnS2BLdaK23kvv5hDgPbjXxjiri2CHWYJ2tU6xh1ycYR3/o3AqfqRTdZLzkC32g
SkFX2HZTHMUCy01SX3xhUYH5fPhGa5WL6+XUKRrY70wT6vFtQ7KbDXzlXWtWxgaI
ar5jDAElKLsvnrd8aIHlxoUQe+Ns8HXu1IF1hfOj1vPiRxOFc/Q0/9MlUQVPo+II
SVhJH9UBIUw2s0Y33cJ7BwloO8IWpprn7oVSw+dJ1bTsaPrIbYxs1uPm4IXv7+Bu
uBEROnZMt9/isC5p/Aei5pd0JaBN2UlIrGF3CWLxx3caWXiCuMxr0s8u6byIVSUx
KcsoQzN/
=hw0F
-----END PGP SIGNATURE-----

--T4ImwvSqqeEd5O0G--
