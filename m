Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D91C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E71488958;
	Tue, 16 Jul 2024 09:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="utB0TxVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9389488971; Tue, 16 Jul 2024 09:34:48 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D3288907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52ea7d2a039so5354273e87.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115286; x=1721720086;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s8CHu5zy/2Zp7I9QWoXJ10daIee2nOc4SNfutDBGfkI=;
 b=utB0TxVpQlW8Gx22/uS09jar6endqBvUTUj+nKSNCXJpNHt8QosgN9mQrN84tqXKOq
 Wdm13VkESpg7t2URq5S/R0qvf6RYe99vzKaqiYKqkmDwAz5UiiYbZ1wHYZHUlrKdW8/A
 jY7vT11V+7rRg5jdzvKNKwTO+1blCorxQ+IijfKRN6XBdP/g+5+VvAB4zA5yc2IkQ64l
 Jv0KiMv1zAF/0+16iaXXbar45m8BBPTQt95XPAccShyiIQFhKb8QQHH5AMbwUl9vTXVU
 Dl5k5ly9vU0GMpm2QDXF5LFiJ48e+OswVyC+BwxzdkosW0L0wb4u4GRKva02yytCK3Ts
 va+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115286; x=1721720086;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s8CHu5zy/2Zp7I9QWoXJ10daIee2nOc4SNfutDBGfkI=;
 b=qIi3sikwn2QeHrJDK1Fei+tD9yDh2WAj963xY6qHy37lRBhcaU/dj2clwekpUtGsC6
 fnu8nINouoXFtedTUuqnaCom3say+zK2g0jTBLUE0q99UjhI2hQdnmVo9J27E4OCgKMS
 da2pj2MGakGug7rocCizbo6f5oeTUMPL/ikN87TmWqXFIoCOxzae5c6CVaK759bH/DTG
 j7u7d4mYnwAfNkfranI+fdip/bj8o9roRXJgZc/u0maueenN8+lQk/v1afLd57jRfQGb
 PoAHSyf7wBHiosVSQlJwt45Qoa0q1WgAKfzT3oZTLaLzCiSNnJjlyJcJA1P+Rh3JlP/j
 aklQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgp2wV9WGN5c4sjolca2xf+ZCrE6Nx2mTRgcD3vualR57PMQCjxYt9Gx+m1ymvScznYIwTaawUYovNthrw0+YyGNYxBw==
X-Gm-Message-State: AOJu0YzedmT1O0zp1SpcrI7sgDxax9M0pCtTwYSoorQAjKrFTVpjjULs
 9zqhmn7jhQOKGmkwpgziDyxsrlJZZjyqePjSi7p+RsTSTZnduzabrhKb/AdNyuo=
X-Google-Smtp-Source: AGHT+IHBbrlyq7KbmyRgX2Dxdl1E3aHAPHtZUMezQwL8gZGGzDwEDAz5k4elRXbhAKDmC8l0cYRxhg==
X-Received: by 2002:a05:6512:398e:b0:52e:7ef1:7c6e with SMTP id
 2adb3069b0e04-52edf02b86cmr675817e87.51.1721115285601; 
 Tue, 16 Jul 2024 00:34:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ba20beffsm11067185e9.0.2024.07.16.00.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:34:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 01/14] MAINTAINERS: Rename BOOTDEVICE
In-Reply-To: <20240716070419.1897560-2-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-2-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:34:41 +0200
Message-ID: <875xt5okmm.fsf@baylibre.com>
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

Hi Simon,

Thank you for the patch.

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> Rename this to BOOTSTD which is the normal name for the feature.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c6de3a1d84..9bee9284cca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -918,7 +918,7 @@ F:	drivers/block/blkmap.c
>  F:	include/blkmap.h
>  F:	test/dm/blkmap.c
>  
> -BOOTDEVICE
> +BOOTSTD
>  M:	Simon Glass <sjg@chromium.org>
>  S:	Maintained
>  F:	boot/bootdev*.c
> -- 
> 2.34.1
