Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B8C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF98080F6F;
	Fri, 21 Feb 2025 02:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SatzZyBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9386B80F6F; Fri, 21 Feb 2025 02:07:29 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C80980F7D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-221206dbd7eso30865905ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740100045; x=1740704845; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G1iqEls4BYOQEZQUTD8qywN1mrgpZdnl3KUYU+flY4U=;
 b=SatzZyBMhqAe3zYWG9W1YH/qxKBtLDsjlg+PNnKi8Bz93wl4ves7AMun6Jxg8L5N0Y
 4tTCQiNhNrzjQzQp9jd15eG60FpZ5Xsv5HlfBzubnPGS7T3J2u6phKRVcfuqw7K2+kI8
 FPuvX3TuQIZHKwfzWjKVvYlJfkTG+XkDeQ6SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740100045; x=1740704845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1iqEls4BYOQEZQUTD8qywN1mrgpZdnl3KUYU+flY4U=;
 b=t3pY9vfquU4KWC2eu79jsOWjZE4j1MPuYe+lxMCLLt/aV66sRV4BCLloZ7b6ChMxYb
 EHtx0lefYQkFImY9nQyD73e97GlV5qqRQB0aEiW9k7FqH/muSPBBLfWH0UcGlU+ixFyu
 YFrRZNcXzVNZNADxjduIsspSpRFCr1ewtIiMzAW38UQJ8ZeMTIKqJS1ZhDLAfNHqCIlb
 JhpRxhFictLPzbS62uoZc7dgszCsDd4VW6ZOcz5PlwC0O9sFRv5An2PHK6Ella2xcUA4
 Aut36iM7pyufPwStg/tNhHWYTvBo0MwOJfTOb77pcI9BN1ydzHQyugzHjA9UEZQQJG0j
 Lo/A==
X-Gm-Message-State: AOJu0Yxzn5q7KNAN30lMmgzkrkI9x1n2N23Eolnjag1/Xf3zUBCLNdGw
 XOHVEfo2NFFC7wemJHhL8DjHJhbgJb+3RJ8ZEgzHoPp5Q/mZMmzY4mQZRX4dcX0=
X-Gm-Gg: ASbGncuhejT4syxgiB47RUwnJY8OJFflq2YCuDbxss/clnx+iARH1PYBqqwsjSnlD0R
 SAanP7hD4fMJy7OlY9Rk867Nm4i5tB70og4TVVrzChX+AsOQjwPw+mFFYbjKkGU3gSjcDAR85tx
 dJvM6sdSkyNcbUTdZqxMrzWdzjUBm/XpVHi+XpgEBwA7utBTXo29KEAfOnKV1Ll7VGUSW6+ezeG
 Md5LuD7vuKciroMo3VEDh3LvutKi7AScP6a65PNPSXtGK7KwI1Fclw3pPyKqIpzhHxX8TckGqmR
 WZYVI5lI/MF50g==
X-Google-Smtp-Source: AGHT+IFRDrZBZh2ecGsGPX0wwkVC27A9EhPB3HYaWqU8FAm7ss+EUF4BfpvkY3qSpBYlj8xF2YWR9g==
X-Received: by 2002:a05:6a20:72a3:b0:1ee:6b39:c386 with SMTP id
 adf61e73a8af0-1eef3c77081mr2401231637.13.1740100045596; 
 Thu, 20 Feb 2025 17:07:25 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade415b35c6sm9671587a12.18.2025.02.20.17.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 17:07:25 -0800 (PST)
Date: Thu, 20 Feb 2025 19:07:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH 07/12] cmd/cbsysinfo: Allow on ARM as well
Message-ID: <20250221010721.GF1233568@bill-the-cat>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-8-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8uQw5xplEJ/RgahV"
Content-Disposition: inline
In-Reply-To: <20250220205900.3127680-8-swboyd@chromium.org>
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


--8uQw5xplEJ/RgahV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:58:49PM -0800, Stephen Boyd wrote:
> This command isn't x86 specific. Move it up one level so that it can be
> used on a platform that can find the coreboot table, i.e. x86 or ARM.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  cmd/Kconfig               | 2 +-
>  cmd/Makefile              | 1 +
>  cmd/{x86 =3D> }/cbsysinfo.c | 0
>  cmd/x86/Makefile          | 1 -
>  4 files changed, 2 insertions(+), 2 deletions(-)
>  rename cmd/{x86 =3D> }/cbsysinfo.c (100%)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 864b6d464ba0..0f456e3b95a2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2898,7 +2898,7 @@ menu "Debug commands"
> =20
>  config CMD_CBSYSINFO
>  	bool "cbsysinfo"
> -	depends on X86
> +	depends on X86 || (ARM && SYS_COREBOOT)
>  	default y if SYS_COREBOOT
>  	help
>  	  This provides information about the coreboot sysinfo table stored in

Maybe just depends on SYS_COREBOOT and default y?

--=20
Tom

--8uQw5xplEJ/RgahV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme30ckACgkQFHw5/5Y0
tyymGAv9EitvI/jdtDV9AliAxtlkyohrjuh42HqBdvQ92ypmZ3bQ99tx/eFCyJ1c
IimxP5wvHSWJj6jnhxjR8F7v7ZFEnuWeVEoUpO5ybSIpCQL0ar+a9nMnebSV1pk0
7fbdz2Q1QKuSho3/+KrjaMSEPmhF9L89kQPmVLFjAR851zXkui63FbGuMlaf5yoE
u3hh3ntK+90sUbZl5Uic9k4AoJuJ121dmDJ8AISA/dkRithQwKxg5y2SPQ4Ii6HE
ebEuF0rE5TrYUcfEIVtKWtT7ufzbK42fyMOU4Iy6a7J3MffdX3llj/lnILgb88ST
1qHMmJQ9eDOwUvQGprcAvnsgTegNBU1LYTlxCyT3mJWRCVhpPu2d/9KN6lrH7emO
sB7rLRJTugNuTGJjy5LHATCYvmr7DwXV4FRweoXoOHPw/L5XmGthTdOz3hAFgTMA
zUoNmNzHAKMD21fC8+ngJtAUydlzHUiuFdRPA30HowXMG6YRg8kq6Y63X7PrJXJ0
fx3qzwA5
=iKWC
-----END PGP SIGNATURE-----

--8uQw5xplEJ/RgahV--
