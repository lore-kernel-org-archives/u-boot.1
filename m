Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F139C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6F686553;
	Thu, 24 Aug 2023 10:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="jFnzX7pG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769408657C; Thu, 24 Aug 2023 10:34:51 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFAD863C9
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so1099885e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692866088; x=1693470888; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EeyOk228v8M6OdIEdXgh9WMMV4wLbgu62VC8rbHQ9zU=;
 b=jFnzX7pGVreyfQj9fBvqcTiUST/n4JmFGsOMSLU7gkqzsKiXQC9a12TYhOpLkGPS27
 wkkarqeC5kUYCDbSjfp+AVDzExDg8Yy0QsxFxdTuojhiMkdqX2wGasyeziqeV3J9TQng
 EBkoPGfDt/i00Ucz/pinh5TKTjsPWzzl6tZolfQm5A4i+Tos4463sCmylrm1LTj4IELA
 OtPDWpJ8ZxQ7K36HqtzHXZj3xm3W2D64N7FFj+bqDEfRCRZchqrbgFkNtpWjeTnN1emu
 jAI6LYh3120aUy911Qf6umzovO7We1CTAP+2eXepgtssxtGJarKN6BqVdkTPg1gMipZn
 +dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692866088; x=1693470888;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeyOk228v8M6OdIEdXgh9WMMV4wLbgu62VC8rbHQ9zU=;
 b=FbMembW1qhoDJ5iWK5ATh58igcTPzEqosMzxQQrSx/izwfQjMKV8VnIqQ77yF4U127
 TYknOytcen7QeKAhunBspZi88iPaz6ZnMYjbKJo27t0lHWYucXQ2ozAyNQsuw0f1UOGX
 MCyBHTH+obOFSoywG1QeTBHXISTLc94qw5UU6BfDiHgcsIW06idRqM8HNlZPZNdfHE67
 Nerc9/dF+s3C+ZyhCchYkyZPa0f3tB4qvNwqFyjKJAviabNGreh01o+UPXYDmeVMQ+0d
 +p344aFLPPxZ9v5Y3mr/ifdLDCFgD/rM43uheI560HXt703ZjHkiyvYI71+/SBKMxAp1
 epww==
X-Gm-Message-State: AOJu0Yy9q4RSMKSrz/YI4qkzPqGRrcvdLUqNiBebKQei6pAwCbY0Jv7M
 g2bL6uV0D67YFq3HfQOVsVgHkQ==
X-Google-Smtp-Source: AGHT+IFv6jayIyVhUp4AgrjENm+otgOrzVjJon+Tqy42iLptjqWMyouI8b24Y6RZ4jriDSQTEQaKYQ==
X-Received: by 2002:a1c:4c17:0:b0:3fa:95c7:e891 with SMTP id
 z23-20020a1c4c17000000b003fa95c7e891mr11266440wmf.35.1692866088079; 
 Thu, 24 Aug 2023 01:34:48 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 y11-20020a05600c364b00b003fe2a40d287sm1953601wmq.1.2023.08.24.01.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:34:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 10/17] arm: mach-k3: am625_init: Use IS_ENABLED()
In-Reply-To: <20230824031101.3460411-11-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-11-nm@ti.com>
Date: Thu, 24 Aug 2023 10:34:46 +0200
Message-ID: <87a5ugrg7t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On mer., ao=C3=BBt 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:

> Drop the #ifdeffery and use IS_ENABLED() inline check and let the compiler
> do it's thing.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> new patch (cleanup before modifying for adding UDA-FS)
>
>  arch/arm/mach-k3/am625_init.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> index 0e5d44269ebf..165bca6885ef 100644
> --- a/arch/arm/mach-k3/am625_init.c
> +++ b/arch/arm/mach-k3/am625_init.c
> @@ -121,10 +121,10 @@ void board_init_f(ulong dummy)
>  	struct udevice *dev;
>  	int ret;
>=20=20
> -#if defined(CONFIG_CPU_V7R)
> -	setup_k3_mpu_regions();
> -	rtc_erratumi2327_init();
> -#endif
> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> +		setup_k3_mpu_regions();
> +		rtc_erratumi2327_init();
> +	}
>=20=20
>  	/*
>  	 * Cannot delay this further as there is a chance that
> @@ -156,29 +156,28 @@ void board_init_f(ulong dummy)
>=20=20
>  	preloader_console_init();
>=20=20
> -#ifdef CONFIG_K3_EARLY_CONS
>  	/*
>  	 * Allow establishing an early console as required for example when
>  	 * doing a UART-based boot. Note that this console may not "survive"
>  	 * through a SYSFW PM-init step and will need a re-init in some way
>  	 * due to changing module clock frequencies.
>  	 */
> -	early_console_init();
> -#endif
> +	if (IS_ENABLED(CONFIG_K3_EARLY_CONS))
> +		early_console_init();
>=20=20
> -#if defined(CONFIG_K3_LOAD_SYSFW)
>  	/*
>  	 * Configure and start up system controller firmware. Provide
>  	 * the U-Boot console init function to the SYSFW post-PM configuration
>  	 * callback hook, effectively switching on (or over) the console
>  	 * output.
>  	 */
> -	ret =3D is_rom_loaded_sysfw(&bootdata);
> -	if (!ret)
> -		panic("ROM has not loaded TIFS firmware\n");
> +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
> +		ret =3D is_rom_loaded_sysfw(&bootdata);
> +		if (!ret)
> +			panic("ROM has not loaded TIFS firmware\n");
>=20=20
> -	k3_sysfw_loader(true, NULL, NULL);
> -#endif
> +		k3_sysfw_loader(true, NULL, NULL);
> +	}
>=20=20
>  	/*
>  	 * Force probe of clk_k3 driver here to ensure basic default clock
> @@ -209,11 +208,11 @@ void board_init_f(ulong dummy)
>  		enable_mcu_esm_reset();
>  	}
>=20=20
> -#if defined(CONFIG_K3_AM64_DDRSS)
> -	ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
> -	if (ret)
> -		panic("DRAM init failed: %d\n", ret);
> -#endif
> +	if (IS_ENABLED(CONFIG_K3_AM64_DDRSS)) {
> +		ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
> +		if (ret)
> +			panic("DRAM init failed: %d\n", ret);
> +	}
>  	spl_enable_dcache();
>  }
>=20=20
> --=20
> 2.40.0
