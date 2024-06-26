Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E89C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 15:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABD8882DC;
	Wed, 26 Jun 2024 17:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i6CRtRKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE65888496; Wed, 26 Jun 2024 17:37:44 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8278826B
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 17:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6439f6cf79dso34905617b3.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719416261; x=1720021061; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWavs7vLntYqGL/xMzdfJTZJGn7CYpKwCdvRpO93pGI=;
 b=i6CRtRKWyVY/VTvMeJPkEBqkL1iOSK00b7idTcwu3OV41QAqtZXC7d8tCXOyzc19km
 2PKi9orUbvJ0fyh6tHMsu0PE1r6WIKReb+uZ2yUL4aTF2YNdNnzWkpsWnlTFNY0M18az
 ZpRbBB39DVxng2zvaKiR/pbDXAMPWXw0ORe2C0KOA8pCmXPuz/4vmVA2DD9ij1ogvWWa
 I9gd5+SpHGIbAwbOVqpAeRgvAAHx3umpAeJm/lWi4udw7dHH0kWb0oEy+5tsOg5y0fak
 7ZNWeLrbP2oo4BZSxSFnCvk9YItJNo4E8D8hcq5t9QLa48vEf0WC7wJ1WoIUW9pvLQf/
 jfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719416261; x=1720021061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWavs7vLntYqGL/xMzdfJTZJGn7CYpKwCdvRpO93pGI=;
 b=tZF87kJpa/1bfGj5Z4DiTICGi9XTHhvnTdyhy0U8ioQdJ5v5yvOOYMTRvstwhBXwwC
 AN8udeTtE8q/a4iOLf/qCWEvgHj4JWBvQ5V5DHzblsJ87s97MZ9Intj2ezzrAzj1qzva
 0TId5ve74EcctGqQyX8MZ2eUzYWVXElv6zOBZIxqSLml6puAfwmL6ejxDNuJxk4dKnAj
 HEwXL1MFAf81oO3oM/GKXhwt+P8qYWKjJiPW1mdI2+f8ZYggaClrsYYnltgCDWUCp6q5
 kozu8XYqPHVg3kh4v4VebT5LFTssnx/n6t9J/u19dQ81lqwpZaG9HI+D6/Sy1uj1tKDF
 r+zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkwTluonqsZJ640xO2/zv+FL02ApbUEXVEXER5MSxGsdu7HdRstTd8BF/hGoOQ8/mfpYy8h4e+lsJyVqWfUzMOmoKxbg==
X-Gm-Message-State: AOJu0YzTuX3xtU5IvYB0xQKKJBYuUx+pw1qBuafso7ldqK4x4eb5RGiJ
 oYEy9DMFsUXKrD8XBELbP5YGRoG0Q9E1KiXWPjycoM8M6Fb/i63yNPMpJAcLeGr4xXGwyrFj8Fz
 RopyRxAB0tIkrryp8DM+1A3sr3j03PfLXIFNTmg==
X-Google-Smtp-Source: AGHT+IFkvlrBwPNSNL9bH6tg1SwjCrjPKy1IYKsyXDqjmUBgenDWTgBOoW1RnsCkp/gG6Xx7tgIHaZ7mW3CGQD0l0vw=
X-Received: by 2002:a81:9146:0:b0:648:2949:4d2b with SMTP id
 00721157ae682-64829589223mr18498667b3.12.1719416261558; Wed, 26 Jun 2024
 08:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240626151522.83561-1-linux.amoon@gmail.com>
In-Reply-To: <20240626151522.83561-1-linux.amoon@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 26 Jun 2024 10:37:30 -0500
Message-ID: <CAPLW+4kqcLVFxxdGL8V66TquKEtPz0VX7NyejAYS=reJmjJWEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dm: exynos: Correct CONFIG_SYS_BOARD setting for
 Odroid XU3 boards
To: Anand Moon <linux.amoon@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 --Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jun 26, 2024 at 10:15=E2=80=AFAM Anand Moon <linux.amoon@gmail.com>=
 wrote:
>
> Fix the issue where CONFIG_SYS_BOARD was incorrectly set on
> Odroid XU3 boards, causing boot failure. This was resolved by
> correcting the SYS_BOARD entry in Kconfig to load the correct
> device tree source (dts) for the Odroid Exynos5422 Platforms.
>
> Fixes: f76750d11133 ("Convert CONFIG_CONS_INDEX et al to Kconfig")
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> U-Boot 2024.07-rc5-00042-g80a111f426 (Jun 26 2024 - 15:03:09 +0530) for O=
DROID-XU3/XU4/HC1/HC2
>
> CPU:   Exynos5422 @ 800 MHz
> DRAM:  2 GiB
> Core:  74 devices, 12 uclasses, devicetree: separate
> MMC:   mmc@12200000: 0, mmc@12220000: 2
> Loading Environment from MMC... Reading from MMC(2)... *** Warning - bad =
CRC, using default environment
>
> In:    serial
> Out:   serial
> Err:   serial
> Model: Odroid XU3/XU4/HC1/HC2 based on Exynos5422
> Type:  xu4
> Boot device: MMC(2)
> Net:   No ethernet found.
> Hit any key to stop autoboot:  0
> switch to partitions #0, OK
> mmc2 is current device
> Scanning mmc 2:1...
> Found U-Boot script /boot/boot.scr
> 2046 bytes read in 22 ms (90.8 KiB/s)
> 8104280 bytes read in 519 ms (14.9 MiB/s)
> Failed to load '/boot/dtbs/exynos5422-smdk5420xu4.dtb'
> SCRIPT FAILED: continuing...
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
> Loading Boot0000 'mmc 2' failed
> EFI boot manager: Cannot load any image
> MMC Device 1 not found
> no mmc device at slot 1
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  board/samsung/smdk5420/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/samsung/smdk5420/Kconfig b/board/samsung/smdk5420/Kcon=
fig
> index a9d62fffa5..37d6bbbed1 100644
> --- a/board/samsung/smdk5420/Kconfig
> +++ b/board/samsung/smdk5420/Kconfig
> @@ -1,7 +1,7 @@
>  if TARGET_ODROID_XU3
>
>  config SYS_BOARD
> -       default "smdk5420"
> +       default "odroid"
>
>  config SYS_VENDOR
>         default "samsung"
>
> base-commit: c53b344475734d0d29f522b7b1d80c5b8204442d
> --
> 2.44.0
>
