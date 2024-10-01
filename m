Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B95CCE7CF7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6115874AC;
	Tue,  1 Oct 2024 10:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v9by1+hf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6128917A; Tue,  1 Oct 2024 10:52:07 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1874189177
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso37174135e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727772724; x=1728377524;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Vh9wZ9ow6C+AxI6sCUbau0dIfZJtbujaUdbg2XeWAY=;
 b=v9by1+hfcYfB2DzEtr1e4oKxpmdudYOoXQ8H29z9zFiahV9u0tsFk8d1Sbb9GcZbbq
 kKok+3NZF7303v1jux7Ujl0h/Ht5ZEG0FwdlsIKuO32Csgb1K4f87SVTEY4bOGNsrWI6
 8DqHdD7HbI0DUfqGMr4qPjQfkrJMv/Ay/swE7mWX4hSbLFVNJNXdDN7YcWokY/bUrPV3
 cR6gVgmpTpLbvDu8s1BRVqnqvK3ZEjoZbYS1SVZQenoIkorMk2Tygm7FmlirJeVkO46a
 iM5yYXpMbBale2//YKt0h8RAeIbUJjCuzV+SEE8VqS0IRJV8NGL/db38aKa3faeYW0VY
 uCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727772724; x=1728377524;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Vh9wZ9ow6C+AxI6sCUbau0dIfZJtbujaUdbg2XeWAY=;
 b=IjlIQx8ztHh+nr7EgqDPrFljfEWAbsjLDHz2gf63CIQ/p304SzGHWaKrpF6H4QO3qS
 ypmop/nrL51BEjIj8tu+6x1ysFOPZ+vBGvui0HDuWKZJW51uFQ9SoAgm4tWkj1U6ovZQ
 wQzWKcOdLEXFLHBez/6jBgs4/0rEjS8Zf6Nmk+6c0EJqmX9rYzxZw+fYG9uHgD1MQ7qu
 aXVBKk/5G6CrYT8VbJzn/u5fp8pRD/O2jNikbSwCaq9AIiqMPlJehFlGKxcUo4Ne5x30
 xYdSM3ZEEF8oo6NBu+s4d5GN8A6dhWwDzBkLBmvMXj1qfooPKVy5WK58KiVe1VfKidNN
 d0oQ==
X-Gm-Message-State: AOJu0YxmAlguOKJQ4qpMMn1Ygs3gVjTsXZ8cvbNTR4k+iuNBr1PHehwe
 rVvq6/S+Mg8+T3CPXzREZW8qx96E1MSyVeCSkkeobQJng4Soh06nC9pFYRbGDpM=
X-Google-Smtp-Source: AGHT+IHzgtO+KnSUC8i3dk1FQa1O0xqA3keWEl0X/uZR5SnwD86Y0+pQQeY0yX6gBk2mNW/YYuvFbQ==
X-Received: by 2002:a05:6000:c47:b0:37c:cce8:4acc with SMTP id
 ffacd0b85a97d-37cf28a9931mr1279240f8f.13.1727772724377; 
 Tue, 01 Oct 2024 01:52:04 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d2c7sm11359191f8f.9.2024.10.01.01.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 01:52:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] dfu: sf: rely on DT for spi speed and mode
In-Reply-To: <20240917-uboot-topic-dfu-sf-dt-v1-1-8cf38451eea4@linaro.org>
References: <20240917-uboot-topic-dfu-sf-dt-v1-1-8cf38451eea4@linaro.org>
Date: Tue, 01 Oct 2024 10:52:00 +0200
Message-ID: <87ldz8cij3.fsf@baylibre.com>
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

Thank you for the patch and sorry the review delay.

On mar., sept. 17, 2024 at 14:24, Neil Armstrong <neil.armstrong@linaro.org> wrote:

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
> ---
>  drivers/dfu/dfu_sf.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
> index 7c1c0f9e2dc..b5d875be5ea 100644
> --- a/drivers/dfu/dfu_sf.c
> +++ b/drivers/dfu/dfu_sf.c
> @@ -123,6 +123,9 @@ static struct spi_flash *parse_dev(char *devstr)
>  	unsigned int mode = CONFIG_SF_DEFAULT_MODE;
>  	char *s, *endp;
>  	struct spi_flash *dev;
> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
> +	bool use_dt = true;
> +#endif

Can we use if (IS_ENABLED(CONFIG...)) for this logic instead of #if ?

checkpatch.pl seems to warn about this:

$ ./scripts/checkpatch.pl --u-boot --git HEAD^..HEAD
WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
#36: FILE: drivers/dfu/dfu_sf.c:126:
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)

I know we will have an unused local variable (use_dt) when
DM_SPI_FLASH=n but to me that is fine.
We already have unused local variables based on KConfig symbols in
dfu_flush_medium_sf()

Thanks,
Mattijs

>  
>  	s = strsep(&devstr, ":");
>  	if (!s || !*s || (bus = simple_strtoul(s, &endp, 0), *endp)) {
> @@ -143,6 +146,9 @@ static struct spi_flash *parse_dev(char *devstr)
>  			printf("Invalid SPI speed %s\n", s);
>  			return NULL;
>  		}
> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
> +		use_dt = false;
> +#endif
>  	}
>  
>  	s = strsep(&devstr, ":");
> @@ -152,9 +158,25 @@ static struct spi_flash *parse_dev(char *devstr)
>  			printf("Invalid SPI mode %s\n", s);
>  			return NULL;
>  		}
> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
> +		use_dt = false;
> +#endif
>  	}
>  
> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
> +	if (use_dt) {
> +		struct udevice *new;
> +
> +		if (!spi_flash_probe_bus_cs(bus, cs, &new))
> +			dev = dev_get_uclass_priv(new);
> +		else
> +			dev = NULL;
> +	} else {
> +		dev = spi_flash_probe(bus, cs, speed, mode);
> +	}
> +#else
>  	dev = spi_flash_probe(bus, cs, speed, mode);
> +#endif
>  	if (!dev) {
>  		printf("Failed to create SPI flash at %u:%u:%u:%u\n",
>  		       bus, cs, speed, mode);
>
> ---
> base-commit: 19dbc09405d3503ce3efef3c2e4b4f0f1a03372d
> change-id: 20240917-uboot-topic-dfu-sf-dt-8ae62e5c7d79
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
