Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D5DC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A353D878CF;
	Tue,  9 Jan 2024 15:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B/HwiM5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA70878CF; Tue,  9 Jan 2024 15:16:09 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84CD87871
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e52ebd63dso2181545e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704809765; x=1705414565;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6IMwiQwoFFC0VBBN0Uic/oFn/INod1XpLWgH4lGnZJU=;
 b=B/HwiM5Nm3i/ZInXQuhcfIyU4cz50bHbGBidYj//5gyCU76L+CoJ1LMcYidAEq2nbx
 HR23EQAH3jb1UXpBNQZuY/J79c48/alZAHCbzVGrFxI5am2mLnIy4GT3ZUMnDc2Rg9/1
 8zMn2YkC08pVAIlpsXIZMGHBWn3+hV/+3DkaEG8Mge+EbuLekDkylJXwy7MZK8jzCkgy
 VKhriHmE63205eIukvBdrJGbm31kMxEZcjYlbA9uOGqQwj35rwLAfd9RrW1ZOhd+kPoQ
 XAHIB24zopKKvb+ydMSkxSPsHDmDA+KxjOVck9lrxShGkCaH7PVGq4AKGVHqAXREAt6A
 rx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704809765; x=1705414565;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6IMwiQwoFFC0VBBN0Uic/oFn/INod1XpLWgH4lGnZJU=;
 b=v7XrLUeM7p/U+UHnDcL3Tah5Fmd+pyDSn2tgY7s3XAawQjSeQKIo/Sn/T8RisW0R2V
 GEoycGx9RKJ9+Gg6sMoiukOcXA1TQwpjZdb8Ux7bm/OPusJUXWxec2HB094Dimv2tUBZ
 NfavvSBuyuEYpCV/W6X0AMNVBMremF2tyZIZe5wvt3FII0j13DTixd6iyBNtlEjxpLVF
 K06BnyRYmkVABd+RyU0JSvHvVYHufh6t+Uq+33LiYdZYtNTTMgzTYoW/M5Zmwq6jX4BI
 e6cKxwEBbnZvglZMJ2q7uX+3y+utY3NAttTc0O3rkAPi5qxP9SkOqwAy6SRpMkxiuC4h
 uEmg==
X-Gm-Message-State: AOJu0Yzt8gRQn2t7oGfQhnOzS9TnOK62KM2Cay9lPG8ft79/JUhRggn9
 aUsTNNsRDKwWFAPIkyvabyUfnEn487GHDw==
X-Google-Smtp-Source: AGHT+IGLOZi8tPPrBnHqnqF4WMM7ndser+MFECXNEVZA48OG0zGwdI52azYopCZLrhrsQTB1IF/7wg==
X-Received: by 2002:a05:600c:3504:b0:40d:3b2d:99a0 with SMTP id
 h4-20020a05600c350400b0040d3b2d99a0mr2594192wmq.81.1704809765497; 
 Tue, 09 Jan 2024 06:16:05 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 g17-20020a05600c311100b0040d81ca11casm3785126wmo.28.2024.01.09.06.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:16:05 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH 1/2] include: env: ti: ti_common: Fix a missing semicolon
In-Reply-To: <20240108-b4-upstream-fix-semicolon-v1-1-9437b3dc90ea@ti.com>
References: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
 <20240108-b4-upstream-fix-semicolon-v1-1-9437b3dc90ea@ti.com>
Date: Tue, 09 Jan 2024 15:16:04 +0100
Message-ID: <87il42wq1n.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Manorit,

Thank you for the patch.

On lun., janv. 08, 2024 at 13:48, Manorit Chawdhry <m-chawdhry@ti.com> wrote:

> Fix a missing semicolon that leads to syntax error while booting j721s2.
>
>     Importing environment from mmc1 ...
>     syntax error at 'run'HUSH died!
>
> Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_phyinit conditionally")
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  include/env/ti/ti_common.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index f0f89a228767..5473f633aa7d 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -27,7 +27,7 @@ bootcmd_ti_mmc=
>  #if CONFIG_CMD_REMOTEPROC
>  	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
>  		then run main_cpsw0_qsgmii_phyinit;
> -	fi
> +	fi;
>  	run boot_rprocs;
>  #endif
>  	if test ${boot_fit} -eq 1;
>
> -- 
> 2.43.0
