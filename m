Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDACCA0ECD
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB4783102;
	Mon, 11 Aug 2025 17:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Flgkd1l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D320083118; Mon, 11 Aug 2025 17:50:22 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0330830CA
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so31281505e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754927417; x=1755532217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtrRo/BoZTjiMTe6FzxhDKNMcjGGd7QmGBrzBr4Ji/c=;
 b=Flgkd1l5TFUtxJTMTR/TQeM2H5jm9cODggbjCf0KYAYYiwyhGYqobamXV+Vu6U3Y/x
 NzeTgD9gpEVOI0ZbfjB0W2Lezin9dV21aJXnD6uhu3VjZW0S9FWmsRqkBNXjJ/Yw1mJe
 mbgcINZCwOJDLfwNcNda260h/g0fanc52bY/G4AgE/ceRoijBK30SkbwG7UwrtPEMGxS
 KaHq5HPqZ3VmVlwJcqHQruiDIEB9xO679hPY5etcKWWuFcQgrZdeQD1B3AO2+SoTi/YF
 5p/o6ACnc57Dmnub0rUc3G/ZczRtoBTYItXPz5Mn/4ISUBaD83UMyarsMarSFZmmfD2X
 Uw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927417; x=1755532217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtrRo/BoZTjiMTe6FzxhDKNMcjGGd7QmGBrzBr4Ji/c=;
 b=Dpj4rHKKcvK8v3Il70QwaoP4GdMuJ5XDlOEHrm8BOpiGxJbM7quBjW+NsUH/gfLW/F
 FJfeNnlhnGTnXr0NsWDE0oEanLilU5hJX8QCnoM0Mxo/Hqh3rCMWaVU7yZP/gbb1aYV+
 5PJogZCVXV3Lt7JB4U1iFbmNdDsmXVIue77PPPn08w+y7PEBpSA8NmZiW8CLBbUTF3VM
 PagY5Xi5cCijJ4YjoUZnMAcLBmqtE6P8rUekFhjEKmKgSmZWm2ByDNYVP9wMFmOIlDwI
 VeUvujhbfN9AAp0aMviuACUGiN6cgXDxtck+MxZydt2lfxkmztojhQu4W9EBYrND7Zvo
 uf0w==
X-Gm-Message-State: AOJu0Yz3e5eEr2L0vrmJr6wmwKtG3hrN279N7RVS4yWwxAKHhrekA611
 H/+IXLVe5UFrvcSrCcz2n3MVvo6it5eCMdcFTrLsDjTl+GurYsoUI7Nx/AmBJA==
X-Gm-Gg: ASbGnctPHFcm+0hFm5aCTwtuCd7Q4iLybToDnajk6lX17GQdIgt0TtSx/EN7co+Xq7X
 MK8JDwFzmX4grks9mgunek4gJ3DToQm9C7UhHlsPkp86uOoEuxrC5bkdwsau6zN9gAONm0AfOm8
 vFUkRcZzp+Lvh7nzfxqA+ejp3Hb/5d6ANwVOw2hqW0edVGuQdnbXiRPpGCkVQ/74ti8FqaH5TV9
 vqxnLLYqCZsoDZaC+oF1sF5O+t7HFRV5d7u0+18UhR7FhqNl7pEiIf3/ltSMPFePAxHLTO959GZ
 rzIM31lFYw7u+u3t8hZAE1pxF3+s3Z6Ukx3oIBFIb+PxXELy5hHi96aIvoXQHSNUeowJmfqiwo5
 q40hakqycj+99U8fUVAAnx+c+4FHpG02HPn7Fq42FER+Pug2FkBrHEVe0acxKKSnjRV/FVl5UAQ
 ==
X-Google-Smtp-Source: AGHT+IEqB1JFwUX9cVNAnqFzk+sbTvY4gcXyBKYE+G4Qk92GyC51DD6X4AW+l3WYQ6CaGg9sEVywbA==
X-Received: by 2002:a05:600c:1c27:b0:456:eb9:5236 with SMTP id
 5b1f17b1804b1-45a10bb6cb7mr2592555e9.15.1754927416860; 
 Mon, 11 Aug 2025 08:50:16 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c4beasm39949541f8f.30.2025.08.11.08.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:50:16 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: a523: change Ethernet pin function
 name
Date: Mon, 11 Aug 2025 17:50:15 +0200
Message-ID: <3642499.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20250801002726.8924-2-andre.przywara@arm.com>
References: <20250801002726.8924-1-andre.przywara@arm.com>
 <20250801002726.8924-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 1. avgust 2025 ob 02:27:25 Srednjeevropski poletni =C4=8Das je A=
ndre Przywara napisal(a):
> The name of the pin function was changed last minute in the DT, from
> emac0 to gmac0.
> Adjust the name we use in the pinctrl driver accordingly.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunx=
i/pinctrl-sunxi.c
> index 03cfe23aaf8..fd357ab0d4e 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -760,7 +760,7 @@ static const struct sunxi_pinctrl_desc __maybe_unused=
 sun50i_h616_pinctrl_desc =3D
>  };
> =20
>  static const struct sunxi_pinctrl_function sun55i_a523_pinctrl_functions=
[] =3D {
> -	{ "emac0",	5 },	/* PI0-PI16 */
> +	{ "gmac0",	5 },	/* PI0-PI16 */
>  	{ "gpio_in",	0 },
>  	{ "gpio_out",	1 },
>  	{ "mmc0",	2 },	/* PF0-PF5 */
>=20




