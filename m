Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCD1E8FDCD
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 15:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E1983C62;
	Sat, 27 Dec 2025 16:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N7xuYo5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80AFA83C65; Sat, 27 Dec 2025 16:08:22 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A3283C39
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 16:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7caf5314847so5046956a34.0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766848099; x=1767452899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ey79NhL2askWwFHBDnlrn1K/lUE36P8N33s/Fe5Kz1o=;
 b=N7xuYo5uXwKArjZV5TCFu1X9n+G9i8BEOXEIf33FpHdcoEfnZYZIDWj6I2X/QXnpVE
 GInrFQelac2eKU62aNnV0rozp58SazHVG+GomjrORgV5iCawCJEM2I2QMZJwrGejOeox
 UzQ20mgjgSLcN3RrNROuCa7tFtf3WNMMMO9DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766848099; x=1767452899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ey79NhL2askWwFHBDnlrn1K/lUE36P8N33s/Fe5Kz1o=;
 b=HMNiJNleGFP80M62Cjx82hZqJ5zSCi8cf+wINMkFqnXachsaOjyXVJiSzEDIA2qGqt
 fGqoIVgYy/9FvtSVRZKn0LT0mzTOx1GbgvOV643kDlGak98j+U5/lipTN3I5PFPSFCZX
 K60GCzxjKH4Kzi587ZWaOijaOdhZDS0z1nVIw+ChN44dDX2FZu0vyxTwhVwaSRYCwxbN
 heN2TVkKeV4HKf/r6OefLBDhDnQ7f5Kv01aPChRiX70Dpad6/UlORUD8X9Kaw76OhBVr
 iXtMEWcCNIhmrWyAJzFuQzz+OgWxFngzTZ76n6ykiPX8OV2BfCJQOQj0EFz2pgvpcqI/
 AYnA==
X-Gm-Message-State: AOJu0YwhHoPpjt3yGlvek0C0cpEbFNR33FtQfTFV/i7Q9JL2/dxLtOKC
 iepmR2tjm7Tl/O5EEvc7ZdmAfs48umlFYNUQ8W3xkwH14xATRvORTngQKZ4gu3XEGZQ=
X-Gm-Gg: AY/fxX6cuRe5BoaNwRVYWQdyuH6QYw6oKjtFObLFuZ94LOW20VWO9pksJ/U4U66ImOo
 QByWSxVK9UFWEwNcLyKb9q0kwbFj9BXMmfXThSJSUUCS3EqzpMRe3wTTkyWr+m0qhh2mcKCutfr
 YbXQVvLp7YRZNAfGT9keDFuHnvyzW/tmq7IUoe5C2qh5NI6r7GAtU8UYoPa79ma0bur3GJvyqdD
 zi244bpy43zGBfQJqPBFRmo2wMdn+5dtpn6bCp4FZZBEKIDgoXLLz7pNfd3K6L1NV2Nxa6IgWLr
 QTIyHjLhFfrkX4Lrlnv9yaoKyFX2AhiVZDBkUYwsDlV7bEQBsIq+vzjwZSgCi/quu8ZQMzQjFEn
 n9jDK173Vs8x/dTIvOuLVm8zfK1IJGpTQSbcq2XU37IuszZ3qzarp0nLWpDH3EpdX3omwrBvZvd
 oqqV86tYepMK4U4q22GMwj9CtsniDuXuKzve0ky5BNTiYNFNq1gg==
X-Google-Smtp-Source: AGHT+IG2CXeqFHwAXll7WYFhPxegU8CocN5iHJJmXZhJoTWx9LLX9PyJL4po0978emS+4CE4up+sog==
X-Received: by 2002:a05:6830:2e07:b0:7c7:5f09:879c with SMTP id
 46e09a7af769-7cc66ace8b3mr15167593a34.26.1766848098819; 
 Sat, 27 Dec 2025 07:08:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667fa674sm17015548a34.29.2025.12.27.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 07:08:18 -0800 (PST)
Date: Sat, 27 Dec 2025 09:08:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Manjae Cho <manjae.cho@samsung.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sujin.u@mobis.com
Subject: Re: [PATCH] Fix typo "addtional" -> "additional" in pflash section.
Message-ID: <20251227150816.GL710860@bill-the-cat>
References: <CGME20251227142137epcas1p4115a7a2e7519bbddc095c9d3baf760f4@epcas1p4.samsung.com>
 <20251227142036.10661-1-manjae.cho@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="otTY7QQYplmn12o9"
Content-Disposition: inline
In-Reply-To: <20251227142036.10661-1-manjae.cho@samsung.com>
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


--otTY7QQYplmn12o9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 11:20:36PM +0900, Manjae Cho wrote:

> Also add network testing example using virtio-net device, which
> should be helpful for users wanting to test U-Boot networking.
>=20
> Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> ---
>  doc/board/emulation/qemu-riscv.rst | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qem=
u-riscv.rst
> index b5948d9affc..25fe7beb43f 100644
> --- a/doc/board/emulation/qemu-riscv.rst
> +++ b/doc/board/emulation/qemu-riscv.rst
> @@ -43,7 +43,7 @@ qemu-riscv64_smode_defconfig instead. Note that U-Boot =
running in supervisor
>  mode requires a supervisor binary interface (SBI), such as RISC-V OpenSB=
I.
> =20
>  To create a U-Boot binary that can be utilized with a pflash device in Q=
EMU
> -apply these addtional settings to qemu-riscv64_smode_defconfig:
> +apply these additional settings to qemu-riscv64_smode_defconfig:
> =20
>  ::
> =20
> @@ -205,6 +205,29 @@ Invoke QEMU with:
>      qemu-system-riscv64 -M virt -nographic \
>      -drive if=3Dpflash,format=3Draw,unit=3D0,file=3Du-boot.bin,readonly=
=3Doff
> =20
> +Testing with Network
> +--------------------
> +
> +The QEMU virt machine supports VirtIO network devices, which can be usef=
ul for
> +testing network functionality in U-Boot. To add a network device, use the
> +following QEMU parameters:
> +
> +.. code-block:: bash
> +
> +    qemu-system-riscv64 -nographic -machine virt -bios u-boot.bin \
> +    -m 256M -netdev user,id=3Dnet0 -device virtio-net-device,netdev=3Dne=
t0
> +
> +This will create a VirtIO network device (eth0) that U-Boot can detect a=
nd use.
> +You can verify the network device is recognized by checking the boot out=
put for::
> +
> +    Net:   eth0: virtio-net#0
> +
> +From the U-Boot prompt, you can test network functionality with::
> +
> +    =3D> net list
> +    =3D> dhcp
> +    =3D> ping 10.0.2.2
> +
>  Debug UART
>  ----------
> =20

This is a case where it's appropriate to do 2 patches. If Heinrich picks
it up as 1, that's fine too, but it is two distinct changes.

--=20
Tom

--otTY7QQYplmn12o9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU/2XwAKCRAr4qD1Cr/k
CnfXAP9sNAnsvQ13reX1ij+0BRJGU0scWcZmGWrleJL9LJH3SwEA5Gcx0sM0bLUq
pC/KuSpijDaB5x67f2SOTZ4nc4Db5wo=
=9oPz
-----END PGP SIGNATURE-----

--otTY7QQYplmn12o9--
