Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A899BC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FCD88395;
	Wed,  5 Jun 2024 16:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rbv7scSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2B98836E; Wed,  5 Jun 2024 16:42:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B821E88361
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f8ef63714cso4391105a34.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717598546; x=1718203346; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QTK0gcD4NcOhVJFfT3lF3gbYNmpsxR557EaRSZB0g0g=;
 b=Rbv7scSYOVw3rV/PIjcE5J7UGmdRXuj/P4PUFBuUAFA9moPVLK4QLixYon2mj5sj7Q
 wWOuuV0/ZKZGJyZ0reFH5MwaqhheVXd4hM/eun11m3vNqN8hKkem6i7fXhfgDeMWOVAD
 6Ez5GDPqrgbgh49l/3OLdEZw9hJ++w8xNZ7E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598546; x=1718203346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTK0gcD4NcOhVJFfT3lF3gbYNmpsxR557EaRSZB0g0g=;
 b=PLtCAwQ3rYyFiyUE+2ABXBnFwo/TmKF5cx7gJy8OASgPAHem0Jl2bgqnB7teLzTcmD
 tSdj4ciGqpjjOBcRrOWQUEcike9Zw8C/BqOs9p7Hwc66UVTFbu3XdiHbQuNrZkJ5Lirg
 j4YS+291sZn70Xq7IgBQrd613PfMo6MbjWLm6+lUKhUNdpgporTrswCJaMFtSGC/WOrK
 iYRcinF9gQuDtsQwlAnNEi6GVP7QFw8AQSt3GHh62NhBRI6YtIB+kxgOVFhEsmErZO8y
 dmeSRYaU1FYrOwBmZE8KyVMMWhFHZ0gQjhwCcNVSqPaaoXfw6Yf7QkItgNL36vbM+KLN
 bm/Q==
X-Gm-Message-State: AOJu0YyQY0PUDUFvBRQCXE4SUtj6kHDEOKCs2scQc6df6Wkgbgn1hxwj
 ZIKo2o88ozX6X1LNEuBx5yqrd5kBnjpBrkSxokNqdPr4WShjnAOHZsy2G75gCuc=
X-Google-Smtp-Source: AGHT+IHQZLhV38gm9wMma3ZR86F06ZJEI1lKMypXCA/GbegradZD0MxzJ5wtDKPZeIwrzWlGkIZxEg==
X-Received: by 2002:a05:6830:1dac:b0:6f9:3773:dcbf with SMTP id
 46e09a7af769-6f9437d6042mr2924208a34.31.1717598546403; 
 Wed, 05 Jun 2024 07:42:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f93e929fb1sm592098a34.14.2024.06.05.07.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:42:26 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:42:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 9/9] Revert "arm: am335x: Enable SPL_OF_CONTROL on some
 configs"
Message-ID: <20240605144224.GR68077@bill-the-cat>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="urAn1Le8VP5TuJJj"
Content-Disposition: inline
In-Reply-To: <20240605032521.1142768-10-sjg@chromium.org>
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


--urAn1Le8VP5TuJJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 09:25:21PM -0600, Simon Glass wrote:

> This is a partial revert which makes boneblack_vboot boot again.
>=20
> This reverts commit f4b64e9736e73ceec14d51600bed9a8ac48f9fe8.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  configs/am335x_boneblack_vboot_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_bo=
neblack_vboot_defconfig
> index d473a1a793b..3ec4abddd77 100644
> --- a/configs/am335x_boneblack_vboot_defconfig
> +++ b/configs/am335x_boneblack_vboot_defconfig
> @@ -40,7 +40,6 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=3D2
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_BOOTP_DNS2=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy

So, this change was a while ago. But I did it because some of the
drivers, tho I forget which ones exactly, really were not functional
without SPL_OF_CONTROL enabled. That said, does am335x_evm_defconfig
work in your configuration? I think we have to keep am335x_evm_spiboot
because it's so radically different from how the rest of the possible
options boot, but I'm not sure we need a vboot defconfig? Or if we do,
it should be updated to use the #include logic these days.

--=20
Tom

--urAn1Le8VP5TuJJj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgeVAACgkQFHw5/5Y0
tyy4Twv/SCCZmIIYfZ2GfDkfbODx4iHAYJCCwRII0AhDBSudDlKwhY7tpML2hjvQ
R6VsnXij4o1719zAysCWXdiMTxaMsUR6/768dSoFrpvqr5thzCElztA4yfODBQMt
9ZfS7BPLdQ1QNd5u+8pgiHpBFmQjpg5qc8F1oet1e20xnwnqdtnAOD8MSXMxT4Iw
OJQchY4MO5bvn2RPO9CQfTT65kWh/Eb1jd9GGXRgsOrPIFRh6BOs6EP9BKRO9liW
7v5yB2/9O3gCJDOnUQh2htrFSXfCDN8LQEOf1OuFmyZIOG2SDdWPfGA6cmm3OWim
AAx62Tp3ywFhg/kDZG591Awc9FVsjsmRFM2lr7HyZuy9XuowPNMJlZN3Rvol2uBF
/7BBy3se1ZUnU0me0M2HWqjgpjiNY/Q84/UieCWFI98Eso8GGjewBw9iBwi3rMV6
TT2EyuLbfLJ8Vq6ln9SnLoHig4W6UuMqW+FZsdSJyQYi/LjqdvqgPLRY7dNBnr3f
h3VGLRdy
=14JB
-----END PGP SIGNATURE-----

--urAn1Le8VP5TuJJj--
