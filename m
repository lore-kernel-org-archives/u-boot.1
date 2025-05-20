Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F29C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74BE582C87;
	Tue, 20 May 2025 16:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSlyAoQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 380EB82C96; Tue, 20 May 2025 16:43:44 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F41282C55
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6060167af73so3696815eaf.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747752221; x=1748357021; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OcQ8OLL5K/x3TKKk9+SXIsjA6CrSqraO2g1FvsJ+1ws=;
 b=sSlyAoQJvhcKi41yomoVw8hbgD+JvXa9ewkdoSFR1WvASDVRmRASRysY2f5+kidDLU
 iRd1cayv3flbVHLTkFoRxee+MgTw9GiKofiup5R5IXJw6bcEvgu4vUSlH/IbimvNnEPW
 O0XFbBrL39/lKvE/m+Xg5J6Auk/kt8cCsRQmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747752221; x=1748357021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcQ8OLL5K/x3TKKk9+SXIsjA6CrSqraO2g1FvsJ+1ws=;
 b=hDy5CXS0VF1BkcfRIWlax434ef/i6GS2//5yt9lTVZlHk90fR8AGVds4PcTZJ/vPCd
 nEdLVpRjBXvLWKzrk/9rSQdtrpblGDv2q0ZNLrsTKkNhGSzcVv/Rlxq3ptwMadK1XZ/f
 ee3L5OF5BseJYC7+XQwNVav6L6FIiY/Qr3uKKnDDMEl1fhVhiVrvtRjIAh5mjodARF3x
 T+htJy875ibhVOiNu6lgFYp4MO9clyiYXTQ+pvBPUvyfl6lYb72Uk0ki2TJi9Z3ouvsi
 Slyvpgaa9GyDcgD9ZR6DOC43rfJhKPY3A3TSA+N2sDEvXDrWfhqOBLrkZq/D6VfMc3oU
 Aldw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXncRyuJenYiT8A8LaLpR7YUigO8VRVA3H/4Bo77MEczL0Fsw+5p/ZqJw+TXTo1c5hTbxL6Chw=@lists.denx.de
X-Gm-Message-State: AOJu0YzBETtG4yr98zB4SWHLnxSa9tya4McCkTmejMCB4IdaeUBa3hea
 x+ncj2UCrnfDbqfDRoBiGK12Nx2o6Umr6Bex9mFzGnP70N7hMRm6QiQ6yarC/E2MQ4g=
X-Gm-Gg: ASbGncudkgZQ3Yzfq3B2ne3nTmpkPXYTB+AsCMMmO46IWCv3WcxBs+wFPrQol0N26to
 0MJmkVOm9iKWyKqXHu/LuMyosh6lhApF4CUWh9WA39ZA0NUIrUBFPxrKvAdo617FBImWLUUflVM
 JUosh7AdRk0xWnqFIAAJwyEHa2mpAt93q/GUa8UDJAU6EGOr4dC6bIy5O/y79osgRhMx0Lh0l98
 2l4IHM3+Yym+UhdEes3SJmgFupmUpXSD9CsVE7ZQKgoCPHe/CP0gwIr2Eic8UWv/edewecZYOzc
 rK/a8byiWs62NwPVIutsUz2OLbyZt9zAl/Z75D1HOGBVadGEHxs3JsjZYlSqJCPkd6FXYPlf+yw
 3e7ycBjcyKpaS
X-Google-Smtp-Source: AGHT+IFJaUEuhi/4eaxautv0FKL7W+Oa19ol1cRcufTQ7wkfAjX1AQ1rNvBWlVYAh2f0dy0dARtdDg==
X-Received: by 2002:a05:6820:188e:b0:609:dd17:795 with SMTP id
 006d021491bc7-609f37bd3e6mr11849673eaf.6.1747752220743; 
 Tue, 20 May 2025 07:43:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f3000f15sm2057585eaf.28.2025.05.20.07.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 07:43:40 -0700 (PDT)
Date: Tue, 20 May 2025 08:43:37 -0600
From: Tom Rini <trini@konsulko.com>
To: gchan9527@gmail.com
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 1/4] image-android: Prepend/postpend default bootargs
 value with given bootcmd
Message-ID: <20250520144337.GA100073@bill-the-cat>
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
 <20250520-sc7180-android-boot-v1-1-3075a84ea094@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vCfYvY5Sd/W8K7Oj"
Content-Disposition: inline
In-Reply-To: <20250520-sc7180-android-boot-v1-1-3075a84ea094@gmail.com>
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


--vCfYvY5Sd/W8K7Oj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:25:56PM +0800, George Chan via B4 Relay wrote:
> From: George Chan <gchan9527@gmail.com>
>=20
> Control how default bootargs is prepended or postpended to boot param fou=
nd
> from androidboot img.
>=20
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>  boot/Kconfig         |  8 ++++++++
>  boot/image-android.c | 10 ++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 30eb5b328d7..6559398cb92 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -11,6 +11,14 @@ config ANDROID_BOOT_IMAGE
>  	  This enables support for booting images which use the Android
>  	  image format header.
> =20
> +config ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS
> +	bool "Android Boot Image boot cmd param will prepend to env bootargs"
> +	default n

The default is always n so this should be left out. Otherwise seems
fine, thanks.

--=20
Tom

--vCfYvY5Sd/W8K7Oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgslREACgkQFHw5/5Y0
tyzxlwv/ROQtUj1XPQ1W7ZXf1IoyOPJaTeMbqSYe/PHLPVjecyazqNAJGkp+Mavb
TLrjlDn9oF7PC9h5lx3b5YaMoFQDBEqWzPyWJ4cu2a6kyX85YpFDtzS+mArZlUYo
6G0O8+oisXlG2zRHjWVFFIxgdKPrHH4Y1lYMv5PZ/oVo4k7LnhfMKUisdpcsKpx5
KrEvqWYWWnATzA2Mr/6lf9cAY/6HQRcViMFgCeraCVKj4/3AryqHNj5MtWcFzB0X
2WD7ElT7tMQ+xyX/aEYbQ59WF7mcN0Pi2yPJO1ZGWMUg837qnGHEBdxVM8rdeJ09
Njm22jw+L66s9n3kxZ1h5vK+FlKJ3xEgfNo/LAfa8dS42eJcLIbO/Dw3zI/uBqXc
4nq0gIxOznhu01HdtmMnUUeENNG+w49U8ZIpp0lMuMSN2zp7kXJRtYoKQ3kAHg0/
TYbYPvtkAWlvYbMQb1MDu7ZRIjTsFX8vF4VgqrszxUh6lTUykR0GWGmfsSwaSBRW
57ZE9GVQ
=Bffj
-----END PGP SIGNATURE-----

--vCfYvY5Sd/W8K7Oj--
