Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE869CF319D
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 07:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6132A88B08;
	Wed,  2 Oct 2024 09:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yIF1rEuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFEA88A4C; Wed,  2 Oct 2024 09:30:16 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6847E88B08
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 09:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so56925635e9.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727854214; x=1728459014;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eBM+DLAC/cT6O30EFsYXBt2coDHYQ/6B8OJKxvRY/vQ=;
 b=yIF1rEuk06WMd8W7mAKa2ZfUisVIiwyDmLitBSTqchlUPgAiwLgSzol+1KA5SMzFhZ
 eIgR92y7OC6Uz5IrGig+BAOdU16Uodt/mx2iK4h40akK04rqY2zkDmaKAb2jnGU+cqHH
 jMQqi9EMn9v/5n8TOjEAlXNyOcZ2p/cu6uTgigemYmM95CIBJEeK0t6TNr0OeUt7GmvF
 jzw7dSaTR+qclD3/nLBKC/Wcs/KcWnqS6CMAdGKETka+kjI6qWr1KIONv5E0Yg2lXkpK
 tYlg2NSZPm9XaNvfw/4GAv+88CF1uZzXfAaBXgyyAeL+sR8TVi3L8Z3QtOiNZdxvvUmZ
 tNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727854214; x=1728459014;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eBM+DLAC/cT6O30EFsYXBt2coDHYQ/6B8OJKxvRY/vQ=;
 b=IwbrWf0lwrOJz5whlJZvev8N7QAOgXs/nsN1fngD/qXSv+k0U3aPK7Uzv5a4+hNMFA
 hxKvMv6GdEzNFXQ9oLgie0src/ZVdQ8QQIhxyx2nTM52HXcZHwsaAt9q0Em1Gz7vIOt0
 NUEUSo/bVowh57gxQimgxK3RaTe2iZkjxUZMha+PY8R5Qr6oFmrT/m5QsMnnNwZIQ9Wz
 ScMI9SNHzLLRFnF2eDO/zNVBa65eCAYorBP+0c5U67vKO09S7a0MK+6jLr+gjuSOYjLj
 tGH4enynUiia8jlj8EsT7hV54W9sH3LhEHRpaYbJ5Q5XRw/9CMCgJpbNl4lkXNeGElGM
 i5pQ==
X-Gm-Message-State: AOJu0YwBuasPy/ELjT469x+lhUTefD9TgQdazr8oCm1sXkha71mHhkZ6
 TI5pmkC3Hw1+4OQQkeTv6sZNJ2M4UbhuawccfIZXarUtmveQuBfaoGiykhIohEs=
X-Google-Smtp-Source: AGHT+IGQb7Na52Ntoy4qfe9B93UarmubAUvFtrXBafp/HMfmGyesdsyoPVfVynhqMNYmxnpPnAAHqQ==
X-Received: by 2002:a05:600c:3b02:b0:42c:b22e:fc3e with SMTP id
 5b1f17b1804b1-42f777c7c88mr15308345e9.15.1727854213626; 
 Wed, 02 Oct 2024 00:30:13 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79c67c5csm11032185e9.0.2024.10.02.00.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 00:30:12 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] dfu: sf: rely on DT for spi speed and mode
In-Reply-To: <20241001-uboot-topic-dfu-sf-dt-v2-2-67f7acfa3ff5@linaro.org>
References: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
 <20241001-uboot-topic-dfu-sf-dt-v2-2-67f7acfa3ff5@linaro.org>
Date: Wed, 02 Oct 2024 09:30:11 +0200
Message-ID: <87zfnnklmk.fsf@baylibre.com>
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

Hi Neil,

Thank you for the patch.

On mar., oct. 01, 2024 at 18:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Align with cmd_sf, and try to rely on DT for spi speed and mode,
> and still fallback on spi_flash_probe() if it fails.
>
> With the current scheme, spi_flash_probe() will be called
> with CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
> with are set to 0 by default on DT platforms using DM_SPI_FLASH.
>
> Like cmd_sf, keep the option to specify the speed and mode
> from the dfu_alt_mode string, but rely on DT properties
> if not specified.
>
> Using CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
> makes the SPIFC controller on Amlogic Meson G12B & SM1
> hardware fail and is unable to recover until a system reboot.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/dfu/dfu_sf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
> index 7c1c0f9e2dc..8f7296adec6 100644
> --- a/drivers/dfu/dfu_sf.c
> +++ b/drivers/dfu/dfu_sf.c
> @@ -123,6 +123,7 @@ static struct spi_flash *parse_dev(char *devstr)
>  	unsigned int mode = CONFIG_SF_DEFAULT_MODE;
>  	char *s, *endp;
>  	struct spi_flash *dev;
> +	bool use_dt = true;
>  
>  	s = strsep(&devstr, ":");
>  	if (!s || !*s || (bus = simple_strtoul(s, &endp, 0), *endp)) {
> @@ -143,6 +144,8 @@ static struct spi_flash *parse_dev(char *devstr)
>  			printf("Invalid SPI speed %s\n", s);
>  			return NULL;
>  		}
> +		if (IS_ENABLED(CONFIG_DM_SPI_FLASH))
> +			use_dt = false;
>  	}
>  
>  	s = strsep(&devstr, ":");
> @@ -152,9 +155,20 @@ static struct spi_flash *parse_dev(char *devstr)
>  			printf("Invalid SPI mode %s\n", s);
>  			return NULL;
>  		}
> +		if (IS_ENABLED(CONFIG_DM_SPI_FLASH))
> +			use_dt = false;
>  	}
>  
> -	dev = spi_flash_probe(bus, cs, speed, mode);
> +	if (IS_ENABLED(CONFIG_DM_SPI_FLASH) && use_dt) {
> +		struct udevice *new;
> +
> +		if (!spi_flash_probe_bus_cs(bus, cs, &new))
> +			dev = dev_get_uclass_priv(new);
> +		else
> +			dev = NULL;
> +	} else {
> +		dev = spi_flash_probe(bus, cs, speed, mode);
> +	}
>  	if (!dev) {
>  		printf("Failed to create SPI flash at %u:%u:%u:%u\n",
>  		       bus, cs, speed, mode);
>
> -- 
> 2.34.1
