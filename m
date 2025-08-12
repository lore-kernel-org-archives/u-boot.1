Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5E3C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 04:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4E3831BB;
	Tue, 12 Aug 2025 06:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7erEIuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5301831C2; Tue, 12 Aug 2025 06:15:08 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76354831B4
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 06:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so31770995e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 21:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754972102; x=1755576902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wyyrEvPIWYqxkKqfaEfiXvSKU6QyGxQPgG2uleBOnM=;
 b=j7erEIuZq6SauVQpuXuels+e0FNE3orgmsImyCrZ9cr81GtDeKYo7NMxGrvo/Vpa2G
 iOOXqHvvU5JflT9DQ0egx03UnLb6J4dZPeA3FTq7zYIHjHLu5laCca2j8+Je5udYf8yN
 kNq79VeoUOvCpStgnvSm9A3ptEGPYkhQLJPFUG6BEQCHf7EirgNiXcD8wCHc5Knp/O9w
 HMYJ0rOxQ39hQPJIvV1wxT+Q6TlWINbmxC0i3SS/XwePZ9LFilnLBzz4nPyka6fYfYmg
 EjRMc/+c5IV3lmSAyvfj/0Ul+8QhkJY3WKfv7zHwfgxztmkf9InN7/uHVV7gdglhcYtv
 dTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754972102; x=1755576902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0wyyrEvPIWYqxkKqfaEfiXvSKU6QyGxQPgG2uleBOnM=;
 b=p6h+Xxnh7TSTj7xhKdJ4JEu29vole1+rsqTMEvWgNpJWydIydUlCOjmqjFDcxvD3lm
 W8Y4AEdZVOY8V8A758UDbMhB9oH1d1v2HaWsSeNbRsIvHkc9ZsRNvds5Oyc4ZaEL7KqK
 +DKTH9C4lnLJkKUo7suGoJ1FN2VBGA6uj6vWTMNABmjzQwPNK8TiPUGiAQxcSzVe7tbB
 6bLJ7qzKXiudZryvsK70DwuQD1j1Ic7hnjJoBdVhyctS9YClDYR0IjIYIct9vG8y7VJP
 p66WiBXe9k5ZhXYr9Us5QVpj7j0mmWPNNXON4DrZVXp+ST5opPIRQKHPHnFVvAFm37nr
 dwVw==
X-Gm-Message-State: AOJu0Yx/Lbn9E3W76TmejTlaqnGPZa+or1Z+UdehoXPlBNocXq8MlcC1
 bRRTvM9rb63ObhIzC1FRWNlblu4Vz1tky6F8huVbsT9nWjUzWJEkHpb9uORujg==
X-Gm-Gg: ASbGncv22as0jjZ2GY4qvpe712jwRDirACfSx5sMw5rIvCO/4rzs4my6OILrpBFL0X4
 g9V3yfKs5gf06az4PIfhZDehA59bObI3XE3rZvpMs2quqjjN7ynIdrd81XF0OLw283G4EwtB3zl
 HI2E13wlDFkxTDwW2qvutUJMlsDEi3tou90kTuMENH0jLIpeEDHTWz/5Z8rzkCnvunVSkhOT56S
 BCuQeIPouw4+NrWBBYo165KQhQRt8U9JomL3ma4nbMYZca8Kcu47JNZK0fOZsX/Y2JLj70YlGnH
 mVMQT1LrpXm/mk6+7UM7uSt1T/LaVldX7we0/vCHbYher/zbzv4notNA1OZ/BaBND9u+T/hs2XP
 Cq5yOoksFpkwyUb5ICbkCm+itm2uhBF1M/+G1aUro91OH4MY0BNYJceeN92YxtgdYwGj0K4xcTK
 KV1fOC2qj1
X-Google-Smtp-Source: AGHT+IGNJLs7NvNWteyv45ZrCOyBfvS+q3My5/6zBrqb2JWzwylxbTgUjUgIv5tcXeMXy8m+6RRMiA==
X-Received: by 2002:a05:600c:354b:b0:459:d9a2:e920 with SMTP id
 5b1f17b1804b1-45a10b9ae16mr17255535e9.4.1754972101434; 
 Mon, 11 Aug 2025 21:15:01 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b8aab8c0sm413149275e9.19.2025.08.11.21.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 21:15:00 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Chris Morgan <macromorgan@hotmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/3] sunxi: spl: initialise timer before clocks
Date: Tue, 12 Aug 2025 06:14:59 +0200
Message-ID: <1900891.atdPhlSkOF@jernej-laptop>
In-Reply-To: <20250801234918.19176-3-andre.przywara@arm.com>
References: <20250801234918.19176-1-andre.przywara@arm.com>
 <20250801234918.19176-3-andre.przywara@arm.com>
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

Dne sobota, 2. avgust 2025 ob 01:49:17 Srednjeevropski poletni =C4=8Das je =
Andre Przywara napisal(a):
> Recent changes in the H6 clock code added delay() calls into the SPL clock
> setup routine, which requires the timers to work. When compiling for
> AArch64, we are always using the Arm Generic Timer (aka. arch timer),
> which does not require further setup, hence having an empty timer_init()
> routine.
> However for 32-bit SoCs we use the Allwinner timers, which require some
> setup routine, and hence we need timer_init() to be called before
> clock_init().
>=20
> Swap the order of the two calls, to be more robust when compiling the H6
> clock code for AArch32 or when using the Allwinner timers for whatever
> reason.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/mach-sunxi/board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index fb4837c2082..432b1c10f92 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -476,8 +476,8 @@ void board_init_f(ulong dummy)
>  	/* Enable non-secure access to some peripherals */
>  	tzpc_init();
> =20
> -	clock_init();
>  	timer_init();
> +	clock_init();
>  	gpio_init();
> =20
>  	spl_init();
>=20




