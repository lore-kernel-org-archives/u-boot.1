Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A293FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 17:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1940688765;
	Fri, 19 Apr 2024 19:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nHt8AT+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CB08875E; Fri, 19 Apr 2024 19:00:19 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFDA88765
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 19:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso3259999a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713546017; x=1714150817; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AQ8BJsnIl09izh2xnxYFuTF3ruO2RYVgsiaber/Mtao=;
 b=nHt8AT+6koUS8927BNhTgZAb+uyEsNLTjS4OEuQ/QkEzZFvYn91o9FQdowQpsCudZX
 gPI3AQhdSFPF3t31WnFg3c96wxyLiRyCyUj+4ZdTU9AmhUDeM6m4qkNUJ4cGmsDZ2d+s
 pyA0sHxcOXQWVjEgYRjP6wAC3DjR+j1/0DPuFDrEmZFNEyZ+rXfZakloKoTPRBXtsQAZ
 fSrTY1c06I5pXSDE0pgY2mqbYmGpAu9L6xW+5Xk83Nu5hrLWddX2ZyVQZQ3dCTc/HyV0
 WRfXFVysgJ1gPbhZVTeYvS/W8z9A+5Gtn1RWIjQ0At2H+ZFMznmR57Nj47Xcu3mdZUbb
 Sryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713546017; x=1714150817;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQ8BJsnIl09izh2xnxYFuTF3ruO2RYVgsiaber/Mtao=;
 b=pBosRrND0GVVHCZ2w49yYLUwueHNzXiDvnCR6n2AqtSCstnk3/WNQNAaw1mUxdSkVl
 NyBAIDvcXyT9POxlAjq792bg8KQJz4ljqb1s4dX4X517jgi1esoKYX+RCmB9WgYfWJUH
 Xdsuyg90aAF1nm1D7XevGkd+loEFlX08QVjUDyX+S04rp2QO2nMrqn9vwru4bO37Cmhn
 IJsQc2wqSs6LSR1Ha3fdtD0cxR69SOzHeeynB6PBH6xFpK9I1IWQoBPQsrHCmSQOzs9c
 vxP1jneOY1iUDa+rq0TPkZ30sSQ6v8aO48/D6v+Kicsf3jZk4TGTBUfZIXa6lCArI6cM
 Wd1A==
X-Gm-Message-State: AOJu0YwLi+2i1srDvlYkbUpRZpCgdvzNzBTVKnpY2z3qU0HS8fEsvA9D
 NWzRhUg/azGcer4IStDfvhGdDL92UoM/yhxhCI5Wmvwbcz+uAF8v
X-Google-Smtp-Source: AGHT+IEfgxhdmSE4XzTEC+SNpScT9/CAkP5emnRf8SCQlEf1JRnc+cIQxQijs6ZhOCkcdh0UGs4Urg==
X-Received: by 2002:a17:906:bc98:b0:a55:68b2:4186 with SMTP id
 lv24-20020a170906bc9800b00a5568b24186mr1883122ejb.45.1713546016758; 
 Fri, 19 Apr 2024 10:00:16 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 um7-20020a170906cf8700b00a52225b44e4sm2433391ejb.115.2024.04.19.10.00.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 10:00:16 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=07431015b8eb40caf959a928926100e31a8eabb9e517e78cc1a532dc0940;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 19:00:15 +0200
Message-Id: <D0O9D8BH9J0E.2LF7VIFRK20XP@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 12/18] video: tegra20: dc: parameterize V- and H-sync
 polarities
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-13-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-13-clamor95@gmail.com>
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

--07431015b8eb40caf959a928926100e31a8eabb9e517e78cc1a532dc0940
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Based on Thierry Reding's Linux commit:
>
> 'commit 1716b1891e1de05e2c20ccafa9f58550f3539717
> ("drm/tegra: rgb: Parameterize V- and H-sync polarities")'
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/include/asm/arch-tegra/dc.h |  5 +++++
>  drivers/video/tegra20/tegra-dc.c     | 22 ++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-tegra/dc.h b/arch/arm/include/asm/=
arch-tegra/dc.h
> index 6444af2993..ca3718411a 100644
> --- a/arch/arm/include/asm/arch-tegra/dc.h
> +++ b/arch/arm/include/asm/arch-tegra/dc.h
> @@ -443,6 +443,11 @@ enum win_color_depth_id {
>  #define	WINDOW_D_SELECT		BIT(7)
>  #define	WINDOW_H_SELECT		BIT(8)
> =20
> +/* DC_COM_PIN_OUTPUT_POLARITY1 0x307 */
> +#define LHS_OUTPUT_POLARITY_LOW		BIT(30)
> +#define LVS_OUTPUT_POLARITY_LOW		BIT(28)
> +#define LSC0_OUTPUT_POLARITY_LOW	BIT(24)

This definition seems to be unused, other than that:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--07431015b8eb40caf959a928926100e31a8eabb9e517e78cc1a532dc0940
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYioyAACgkQ3SOs138+
s6GlQA//fPvKbbw05tMFsvJh7qtvNqyLoFFTiN+zkz3jCQzqsFihIPR+qadb409A
9qEpmeogUCaNtDp2dpz/mEdek/aVfEpYJWZvY+fakydB4FnMkGmB347xMwJu+iM8
O6aBRvznhrbLZUjlTICD8b9oLRXCdFVpMTd8worU1U88XMhI7n4RortRJw7zjw/a
sJ3EFUJoZ1tsR5AaXFY+9X4AIuHu2KYg9m+VPRjfhKrjnZSm6g6pqOe22/mzcoJg
piN4XQlGwcCtUPP5Y02Ntyu6C5qy+QoDiUprargObLbjV9y0zVMXr+DXS2OrL+RW
MvJ73CC7FZqvdNgZnSj2OgujpJyvRpJgQGRGfBNHa1letFFQVK4Uk/wTsdz3nvDh
9/PSFwfefXD59ip5p4lKcbtNjTDQdOxWhrf5I2kplUvcOyITrV1sq4BO1O7jJIrT
UuBZxKPodOMj/Tjx9cwbmN73HTKwO14f6+dxj+paHFqZXP5RwSVYdxyBahjDE6+Q
uZaV1RfczYf6zKCK9lw7ZkDnAImuTBVWzY2pF1GuHXwx++Ixc+26Uyj2ZwbuXcFo
4ZP91VI22cAkx1Yxw0OKlUPcyourylwe/aDmtAbFC9NMoQPxSVZlNcWCTMig7jgq
yu9Co9FMJwBLRvHrXRbc/BPQi0SJgw5S6Y7isOMoY8xTfVyTv6A=
=+2lG
-----END PGP SIGNATURE-----

--07431015b8eb40caf959a928926100e31a8eabb9e517e78cc1a532dc0940--
