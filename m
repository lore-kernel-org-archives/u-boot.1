Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D0C3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 16:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26016871CE;
	Sat, 23 Dec 2023 17:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rk5YkAeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBE0874AC; Sat, 23 Dec 2023 17:09:15 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941F686314
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 17:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f07090053so19185026d6.2
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703347751; x=1703952551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oJheyjZwAq2bVn5Vy+diPHPS1b2EKMHX56WivR170V0=;
 b=rk5YkAeJQsvT1SH2LwpjzHx0jwZ98ZHEvYWeNBU2GieQa9wzFunZgKpgPuS0GXBIND
 Scg17lFk+/hWhU2M2NKc2VrKSfKAe7XZKMK5Wcpt0yA4fEooCPbT8i3V2RuTrZqlvwCV
 Rl7BMdIMTWNnHd7686p9+Tdr7tvPCrY0Rfww4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703347751; x=1703952551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJheyjZwAq2bVn5Vy+diPHPS1b2EKMHX56WivR170V0=;
 b=pMYekZSJHYqfylyyGjpLWeniSRiZdoMrGvfY0KFJzKIIZus1E1FAZTs2D8ZjYKMrpZ
 uMmZnbDtSiqhgS+p90V+e2n7mTOKuDa9lvJrUsQmsVldJUjvvmejwE/v1fQRS352uZuN
 UuYEz+Q0MFR0R7R2rPVjdnaI/XmWAz+ryeKnhcEQBc7uYRkWImko8sosn/HfvjiTvL0w
 for4tMzU2GzB5Nf8AMqRiIXpriWEg1G3QfLvli7rwWr71pe8mrgJ9w4VcSgwYE2Hyee2
 qgn+nVtRlvnpAxVqvYnIkizdCojCZpoQHFTV0zTBS9/TBaHjpvlIMbtwJ/CCcF/a5/KU
 YwRQ==
X-Gm-Message-State: AOJu0Yxff3oP8yEpZ3Ue9NE5Xulh/pDrXTz0e+8fj6H30T9L0/X5YE4M
 G4PyPrK9ZZK0b5fbHu+5DNHvZOvxIhGgJw==
X-Google-Smtp-Source: AGHT+IFhcoS42Un0slyPVxupsZm79v+Vb8I767KQdo+vXpy+a1O/2+lEf6tHtPne79MeDOKwwkgaxg==
X-Received: by 2002:a05:6214:2b05:b0:67f:85e4:976b with SMTP id
 jx5-20020a0562142b0500b0067f85e4976bmr5117064qvb.1.1703347751291; 
 Sat, 23 Dec 2023 08:09:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 em18-20020ad44f92000000b0067f99ee84e7sm1116838qvb.71.2023.12.23.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Dec 2023 08:09:10 -0800 (PST)
Date: Sat, 23 Dec 2023 11:09:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Hugh Cole-Baker <sigmaris@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] rockchip: rk35xx: expand space for decompressed kernel
Message-ID: <20231223160908.GF2652760@bill-the-cat>
References: <20231223121310.43790-1-sigmaris@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="23luQiNadSes7lHg"
Content-Disposition: inline
In-Reply-To: <20231223121310.43790-1-sigmaris@gmail.com>
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


--23luQiNadSes7lHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 12:13:10PM +0000, Hugh Cole-Baker wrote:
> An uncompressed 6.7.0-rc1 Linux kernel Image built with the arm64
> defconfig is about 40MB. This does not fit in to the space between
> kernel_comp_addr_r and fdt_addr_r, so when uncompressing an Image.gz
> to this size, the FDT will be overwritten. Move fdt_addr_r and
> ramdisk_addr_r higher in memory to allow 96MB for uncompressing kernels.
>=20
> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> ---
>  include/configs/rk3568_common.h | 4 ++--
>  include/configs/rk3588_common.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_com=
mon.h
> index 1b7d3437b1..da5b38803e 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -20,10 +20,10 @@
>  	"script_offset_f=3D0xffe000\0"	\
>  	"script_size_f=3D0x2000\0"	\
>  	"pxefile_addr_r=3D0x00e00000\0"	\
> -	"fdt_addr_r=3D0x0a100000\0"	\
> +	"fdt_addr_r=3D0x0e000000\0"	\
>  	"fdtoverlay_addr_r=3D0x02000000\0"	\
>  	"kernel_addr_r=3D0x02080000\0"	\
> -	"ramdisk_addr_r=3D0x0a200000\0"	\
> +	"ramdisk_addr_r=3D0x0e100000\0"	\
>  	"kernel_comp_addr_r=3D0x08000000\0"	\
>  	"kernel_comp_size=3D0x2000000\0"

I think this shows the real problem is that the defaults here need to be
re-thought with functional maximums in mind. There's a practical limit
of 128MB for the kernel so we should have the kernel, then the kernel
decompression buffer, then device tree and overlays space, then ramdisk
at the end.

--=20
Tom

--23luQiNadSes7lHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWHBh4ACgkQFHw5/5Y0
tywOqAv+K0ETqO4j0drqJnnimdBRC7NSNchBd9uSsDmLkcA6RceNxb/u6IZsy8br
qDv2G39R+ha/F0/rKHmvQgOFGAqrFF+4ejjiLgkjbyqi7v58JE4x4AMo+MgKHGbJ
PzsZFtxcHSHI7v5VRZOUrpl0nkUn02iSlYiuZd8MlKsB/rbNNkjbI44KMWVCoxCV
ielScj/C8nAlydNWlRiB3r7xXtcBzKczX0NepZz4FXbgBssf8XAp1oNFwciJi1Im
1NP8TUDOXg8x1f8DvzbIt8dEJQ0TIMEOAQjbzDmn9buqBtTkr7YNFVR1xJMmYmFD
Na/nWJ9edWpkaCORsg+Yqm7+6jzADXjvpsPqErUly8zWJ3bZM8U9HUfg9rq2x8Q5
sVXvIJNXPXaonRgxDIlvWjQg8SdeBBxx4lM3UvwEK61fcEccNNTIfQ7EcjAfdZNA
hrlCtwOOApoA2+N+WDo6VHzsZWuyxzo1b9U4e+QLh8v4tnOILSJ8h1+QPqGhqPRn
Ro2Gk/1Z
=9pi+
-----END PGP SIGNATURE-----

--23luQiNadSes7lHg--
