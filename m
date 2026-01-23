Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECC7D778B0
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 20:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B3EF83B21;
	Fri, 23 Jan 2026 21:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iFaXfGhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E4C83B27; Fri, 23 Jan 2026 21:12:10 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E874A83AEE
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 21:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-65e943048afso783499eaf.0
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769199125; x=1769803925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=scd5LdjXEHXFJ7reuYaj2EaMVHsWUDP0Nw4MfTUmKvk=;
 b=iFaXfGhmcQ3Tw6TUYa6MAZ+7um1Ginn/VyNVLouiWFX142DwZCz2MTLpCSrgu5oZ20
 fhgbNWW5enioNHK0QXBK7gsgfcvqOqRaBsDKl+7NUz82ERyEGsanf28tHH44e9qZS0Oo
 wSthhLcgJme0WTmfA1YO9D5FDsBhGpaZPupv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769199125; x=1769803925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scd5LdjXEHXFJ7reuYaj2EaMVHsWUDP0Nw4MfTUmKvk=;
 b=ivQHF6Wh0DOtpYb7mQfLI+UeKu0+u/PrUoAIS0J49cfs0ty+MlnGwFBM4dGRwLNRME
 42Ne5ie/3FsPGOFdttqolHTMLYazIgrlK1bEAQCiiulBCbnk5D65F7aQ553ciLGUXyf4
 GYkhrDy5+HO0MJpWwmRcEwobfuBBMYsvnq/PXuVe5/df5n7QytgQyq+0lP5QT5pTLG3L
 9QR1WzQPnSitOdhPEdPekmZNHuMBsKIqYvfOyPFgfa5WZ4Fsn4GCtzELwG1cueBj2wIe
 MYgUkqvJjAwxKPxxVLXnb6GfMfA3NhCbwfGHaEdgwzLCIq306yOp8sl63AAWNYzzMwT0
 LxNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGtNBUxBLL3RhXpvBqW33tFrb4KsZSZxFBIPzIximJHWAVpuBHnRYQEfvDyPFrJLxkDFZVZlw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywt/CumEDD6/i93UHnRyCSvUEbYqx/5yQtNIgVUMqGhYc2jQtES
 hbklHO0hYBPf/GrVBxv+LEVI42aqCFBiWS+JhDW3tZlByUqqSPA3oPaZ5AGwHtI/4gE=
X-Gm-Gg: AZuq6aLaDivdAlt1CGdr462aY2FNjAPKI12mBhLflmYuNOTm+QmrsOBTBfYGCX7yT/b
 Jnhi26+KkJrcvgF3vKaTV9y6TTar5CeQbMvMmYvTial4+lBXG+AiZMz1+vAThwJjTtQEe9i/RJf
 3WXluS//nSdYHDvhX61x6Jpai66dJIBlClSLCx3R8+OMCtlC9U/Kzl+f45gcVoEZRqB6vFRexfD
 cBsjUlQ110r5N1uCBdPni/aB/8MPudGm2l8tC3DsLrcr9tPhM1d35+IOjer3XgtFv1dRq4mC4K6
 +IZXf/Gs8BhQysT0LaN3+8XjTCfOPm5s1Y5nE0MLaUI6XIWAXmiS1XzyIOmPetkHRme0Rs1Hmz3
 yKKozVJgH171byPwYKkt02gHa9stSW4aND5lsm4wGS3CYKJ2J6Nt1IoSA/w0fM+dlq8miKULMM5
 iBOiRfzONEw7npFSQa/xz1rRocqMr3ZSwhY3s10d/k2EQbY/Yf1k5TYP2nmgW7eLUv76fXZaB7t
 YACV58hiPAFyDRh4/G/uQkSKB9kQRwDHFBlOVw=
X-Received: by 2002:a05:6820:1609:b0:65b:f0da:31b9 with SMTP id
 006d021491bc7-662caa562abmr1905259eaf.0.1769199125614; 
 Fri, 23 Jan 2026 12:12:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662cb4f24fdsm1527155eaf.5.2026.01.23.12.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 12:12:04 -0800 (PST)
Date: Fri, 23 Jan 2026 14:12:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: marek.vasut@mailbox.org, u-boot@lists.denx.de, sjg@chromium.org,
 ilias.apalodimas@linaro.org, Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
Message-ID: <20260123201202.GO3416603@bill-the-cat>
References: <20260123161907.392211-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y1kSxbLsTg/Y84Dz"
Content-Disposition: inline
In-Reply-To: <20260123161907.392211-1-festevam@gmail.com>
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


--Y1kSxbLsTg/Y84Dz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 01:19:07PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@nabladev.com>
>=20
> When CONFIG_SPL_SEPARATE_BSS is disabled, SPL expects the embedded device
> tree to start exactly at __bss_end. This address is fixed by the linker
> script and SPL probes this location directly for FDT_MAGIC at runtime.
>=20
> Commit 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device
> tree is aligned") modified the linker layout such that the
> .binman_sym_table section may end at a non-word-aligned offset. Since no
> alignment is enforced at the end of this section, the DTB is written a
> few bytes past __bss_end in u-boot-spl.bin, even though the __bss_end
> symbol itself remains correctly aligned and unchanged.
>=20
> As a result, SPL reads zeroes at __bss_end instead of FDT_MAGIC, leading
> to a "Missing DTB" failure, while the DTB is actually present at
> __bss_end + 4.
>=20
> Align the end of the .binman_sym_table section to 8 bytes so that the DTB
> is placed exactly at __bss_end as expected.
>=20
> This fixes SPL boot regressions observed on Rockchip RV1103 and RV1126.
>=20
> Fixes: 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended devic=
e tree is aligned")
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
>  arch/arm/cpu/u-boot-spl.lds | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index d780a5060774..fc2b7fcb969f 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -40,6 +40,7 @@ SECTIONS
>  	.binman_sym_table : {
>  		__binman_sym_start =3D .;
>  		KEEP(*(SORT(.binman_sym*)));
> +		. =3D ALIGN(8);
>  		__binman_sym_end =3D .;
>  	}
> =20

I've been talking with Ilias for the last few hours. This still isn't
right, it just happens to work in some cases, but not others. What's
going on is that while we always have u-boot-nodtb.bin 8-byte aligned
because while the BSS itself may end 8 byte aligned, we actually care
about the size of the BSS being 8 byte aligned. Can you please try:

diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index d780a5060774..dae8a1ec665b 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -58,6 +58,7 @@ SECTIONS
 	_end =3D .;
=20
 	.bss __rel_dyn_start (OVERLAY) : {
+		. =3D ALIGN(8);
 		__bss_start =3D .;
 		*(.bss*)
 		 . =3D ALIGN(8);

And see if it works at run time? hexdump'ing looks good. If so, I'll do
something more broad to catch the SPL_SEPARATE_BSS=3Dn case, and add the
ASSERTS that are missing.

--=20
Tom

--Y1kSxbLsTg/Y84Dz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXPWDgAKCRAr4qD1Cr/k
ClKNAQDxGzKrDJQY5fNLrNBiPa+9xPQmLAda9o4yJ/mReVZWXgD9ELa1D+PaYosC
0l0OoJgdSE0xXsiya/m/QjjyYLscYgI=
=EjBw
-----END PGP SIGNATURE-----

--Y1kSxbLsTg/Y84Dz--
