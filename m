Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BCCCCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 21:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4B38393C;
	Mon, 27 Oct 2025 22:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uhmd2fw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5438393C; Mon, 27 Oct 2025 22:20:34 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B9E838F8
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 22:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d5bb03d5c2so355226fac.1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761600030; x=1762204830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DPoMLHF6XCOH6xDRgIEXZcj8CzFAnJNrblH0H8FQ/E4=;
 b=uhmd2fw3BO9+bzPPPYI5XP999XY7Lz8Mzgtz6r6wzCyh5O6IXay1tGvPjZ4AE6lq4h
 KxUcNYjZ2QPgAR9zh2jBndwGuqz3s84rNXxS0lFMRfzncW96kWgx1FJCeVt/zjcoot7/
 RJr8rCcLwR+rmWDTWPGXfLgyxIw+eDmKX2Shg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761600030; x=1762204830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPoMLHF6XCOH6xDRgIEXZcj8CzFAnJNrblH0H8FQ/E4=;
 b=l5otkuAPkjVqA6kn3fI+QY7Z3LRHFK6BQWwBq9fDIKzsjA5OFnfcNBY2u4JJc3+LBF
 teg36bOrqu9F+hUbGgTjQE2PSWmbfov3ZYGV6HawdhHD0VElt5XNiw+yMYqkluSeeY1m
 8KPk1NavklN/CTcRueV2ZYUEJpbfH5xlgE8cTAoljR+cTy3YlPbeg/GC/t0CXt7hPasi
 7xb8qh/8x78jm6vNedg1w4m96CoWx63tfKkzR9eFGrcWYWoKxTdb9ZZRnwyoUqIaJtRo
 OSmH8783ZkRcOzqliPAjwIBy4GcngvcuK62VYUdjD4Y5c0XCmE443/tjk/9l+9HRGaFh
 0Nfg==
X-Gm-Message-State: AOJu0YxG2j2TOq0cf7me51C3QGXozOGYXe+pcBLhpY0FCAFQ7qCm6Pul
 XpyLM29ryIAaXODvFq9F5sWfyjdVGSfsI1V0Xiu+q2VJ/8S0u4y5VIXVZ7Ho6y6iLko=
X-Gm-Gg: ASbGncvs7KfCsh5iGjWS5BIyG2psnAjSdpb8zw4qrUP4WYdP8hXv9eOUcPKP/2tGaeK
 r6XTNsgFm/TvPo74jJEitzxnPZz4B4P+OWAt2W/UQbkGzkMKqHMWY3b+/Q96YCzgSQNLnMpStk8
 pr2ej/BR6kZI4lHrA9vZBzFDf1l0lYZykhIGdEHPv2Pt5FxD6I0xF9uLAlDJsZJumUKz+jkYNQR
 XnkpX2A7RjvLrAvDPCpoHaYF5KFb8D3e9r8Pkgd4P3mo367/k3u4FT6329fTJ6MXAG1xkbFwvgd
 YzFbAyaUV69ldIdmKoJHK8bkH7yuI9bEfmlgFhyaNjlS93Q+Oq1kt4xb8TNeJSplcPU0k+0jmQ/
 fX6sozF7itR0t+LnjZYXk75iKB7kr8m9rgYD70dzwEptV+so/rv7Zkhfb0JnZxHd5Y/XJNTp4Tg
 fNlAoRk/6yfotv0SMchaLrouKJCEndxCpDXWaJBcc=
X-Google-Smtp-Source: AGHT+IHcyWLhqAVdyR5Oz97LDv98qNZrVFzY3jRfpFFQJZLVtu7/Gyq9EqnyDZIbrUG22ZA79i1TZg==
X-Received: by 2002:a05:6870:fb8c:b0:3d3:3d2f:5c55 with SMTP id
 586e51a60fabf-3d5d9d7b2e8mr623788fac.46.1761600030355; 
 Mon, 27 Oct 2025 14:20:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e395c213sm2860625fac.21.2025.10.27.14.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 14:20:29 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:20:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Chen-Yu Tsai <wens@kernel.org>, James Hilliard <james.hilliard1@gmail.com>,
 Lukas Schmid <lukas.schmid@netcube.li>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [GIT PULL] u-boot-sunxi/master for v2026.01
Message-ID: <20251027212027.GA6688@bill-the-cat>
References: <20251027144512.3199406-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eb/6plx4Mpjbvxgf"
Content-Disposition: inline
In-Reply-To: <20251027144512.3199406-1-andre.przywara@arm.com>
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


--eb/6plx4Mpjbvxgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 02:45:12PM +0000, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull these sunxi changes for v2026.01. No big features this time,
> mostly a collection of patches that have been lying around for a bit.
> There are some DT updates, for those SoCs that do not use OF_UPSTREAM yet,
> hopefully that's the last time we need to do this exercise. And that's
> offset by switching over two more SoCs to OF_UPSTREAM.
> Two new boards get a defconfig, and some improvements for the sun8i-emac
> Ethernet driver. Finally a patch that fixes occassional DRAM size
> misdetection for new A523 boards.
>=20
> There are a few outstanding patches that just wait for getting some
> details confirmed, which I might send then later.
>=20
> CI passed, and I tested this briefly on affected boards.
>=20
> Thanks,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit 9094482ca7576877b2bfaa57c8e73cfeb536f8=
b9:
>=20
>   Merge tag 'efi-2026-01-rc1-2' of https://source.denx.de/u-boot/custodia=
ns/u-boot-efi (2025-10-26 09:03:36 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git HEAD
>=20
> for you to fetch changes up to fa4dfe870c16a90ed14be92f5f3a3822a7ecfe9a:
>=20
>   sunxi: dts: arm: update devicetree files from Linux kernel tree (2025-1=
0-27 11:12:57 +0000)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--eb/6plx4Mpjbvxgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP/iGwAKCRAr4qD1Cr/k
ClozAP4us0WiSRftiYTQrlbL+Gi3yjBCEd/O0VTgBs8UVkrYIgD/QX/GpAklJ025
9nmTMbo8oASGroqbjr0E0Qwxnc722Qk=
=pwEM
-----END PGP SIGNATURE-----

--eb/6plx4Mpjbvxgf--
