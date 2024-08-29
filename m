Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D272AC83010
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F15D88B70;
	Thu, 29 Aug 2024 10:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rQv0uOYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A5088AD7; Thu, 29 Aug 2024 10:59:33 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F3B88B70
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3719f0758c6so269237f8f.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724921971; x=1725526771;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x6SAdp/MPACKrTGCC+1uEHRxGkkcEPHMmtQM5pLa7eU=;
 b=rQv0uOYqjCjp6p3vone5NQ6xlY2FOdYyv0yoLHGRLY6NSKKC/VanhaOh9pG8vOiuIS
 WoREzDhoouMEIb/NK8AaKIKiMM+8F5BHriHrC3SwYJH0e+jy+vGMJKK3tX5fqbcKxU2v
 gN7h0MZ6xeGvcDBsoigz8n3RVWI6eE0eE8e5Lkv46GbuVlixViXy5TraCHJKmyWQkB/R
 qbkk4w0BjdSSR4Ojt5rxWBNkIew0E/Xzi+5TxIQBmgUZBQNrxtSFzw45tCxUJld01Eiy
 CtHcXh8aSgLgkNTGb4uGPilUc26bp0ILBId4oLTYZ4qQJ2QsLPJVINWebB3I8xaL9FJT
 /yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724921971; x=1725526771;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6SAdp/MPACKrTGCC+1uEHRxGkkcEPHMmtQM5pLa7eU=;
 b=HqkLCuVQTpRvGW1gBKf/sH2fsGrHz7VrDgzwoL+YlP5FQg5DOZGNG1ugVgef6feWm5
 sDX0HeqANK3yrjjltjwNtjx4mXoRGK0UuwsAeeahZzMqghH2UYsB3jtIouNQpvYCsOON
 XVgxloal2oX7baA/n5p8gwQYmN7ktymjQ5JBsUezRUvcBhcWUc8pUJevxpsotgirtBOR
 Q87uF34OAWmFK1wEiaPFQSQVSCqRN5tpH2dlqIdrri/dMPtF0nKp0eb6EkbFbztW68ic
 +aIvxvmgvRSm4HXE6dHs1pzzGUG0oxrRfykyrcItMx0d9g9EQeKny66c5zhVVRluVaLq
 5NwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaItTI06T29NUt6xKJA0BG8KMQtiqru01+xwKe9UKCVcrI3U79agZdYdrzkCb12hfTlhP8VF8=@lists.denx.de
X-Gm-Message-State: AOJu0YxYsSd2yLmqVlUigka3R02jeek0na/x9fFzbgcUkp1qkMf7Y0gw
 nG5m6rEO8+e3HB+fOFI86cyhRLnittmyd9VHAWf8fYdMfQYkU6Bwx/d9DZLcTrc=
X-Google-Smtp-Source: AGHT+IEhNQyHAgX+F5ThlMO3DN/zvJxLPHzoN3bF5+v1skp2qLUOB7nyu2/vhMK0DjFq/4xF6UrWiw==
X-Received: by 2002:a5d:4309:0:b0:368:37e3:dff7 with SMTP id
 ffacd0b85a97d-3749b552b2fmr1514782f8f.34.1724921970477; 
 Thu, 29 Aug 2024 01:59:30 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6a10353sm10055115e9.1.2024.08.29.01.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 01:59:30 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mmc: Hide mmc speed command under mmc command
In-Reply-To: <20240829012210.179436-1-marek.vasut+renesas@mailbox.org>
References: <20240829012210.179436-1-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Aug 2024 10:59:27 +0200
Message-ID: <87o75br9g0.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On jeu., ao=C3=BBt 29, 2024 at 03:22, Marek Vasut <marek.vasut+renesas@mail=
box.org> wrote:

> The mmc speed command configuration option keeps showing up in
> Kconfig even if CMD_MMC is not set. Move MMC_SPEED_MODE_SET under
> CMD_MMC to show up the Kconfig option only if MMC command is enabled.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> Cc: Francis Laniel <francis.laniel@amarulasolutions.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  cmd/Kconfig | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 978f44eda42..efe2357d044 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1399,6 +1399,15 @@ config CMD_MMC_SWRITE
>  	  Enable support for the "mmc swrite" command to write Android sparse
>  	  images to eMMC.
>=20=20
> +config MMC_SPEED_MODE_SET
> +	bool "set speed mode using mmc command"
> +	help
> +	  Enable setting speed mode using mmc rescan and mmc dev commands.
> +	  The speed mode is provided as the last argument in these commands
> +	  and is indicated using the index from enum bus_mode in
> +	  include/mmc.h. A speed mode can be set only if it has already
> +	  been enabled in the device tree.
> +
>  endif
>=20=20
>  config CMD_CLONE
> @@ -2963,16 +2972,6 @@ config CMD_UBIFS
>  	help
>  	  UBIFS is a file system for flash devices which works on top of UBI.
>=20=20
> -config MMC_SPEED_MODE_SET
> -	bool "set speed mode using mmc command"
> -	depends on CMD_MMC
> -	help
> -	  Enable setting speed mode using mmc rescan and mmc dev commands.
> -	  The speed mode is provided as the last argument in these commands
> -	  and is indicated using the index from enum bus_mode in
> -	  include/mmc.h. A speed mode can be set only if it has already
> -	  been enabled in the device tree.
> -
>  config CMD_MESON
>  	bool "Amlogic Meson commands"
>  	depends on ARCH_MESON
> --=20
> 2.45.2
