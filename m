Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE4ACF07BF
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 08:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B937E89025;
	Thu, 10 Oct 2024 10:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K+qDC+Xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0030D89241; Thu, 10 Oct 2024 10:09:20 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1C989025
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37ce9644daaso378323f8f.3
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728547758; x=1729152558;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iD+DMtVCqso+YzMLLnKry5Oy3qdDRY/Zl3EBQvqH/94=;
 b=K+qDC+XuI1n/csLsFiRwyKmw3MysnYLXIKgcSGlesqEanXAMqC6qhnEIVzVX8aurRF
 7E5GQaNKIjok27EuIDmQuCm3PiUWPdxdHqnNkh5A8QDb5cuMBPIpgTwvxGWev9c6NOVJ
 AYFDLkneNOR1bjf13Tc6ZBamrRkTyTEOWy597dPQn25KeJG0bv+ojoqT5WQFyzh6Byb1
 5dFlzE7OurWWwzDUHdV6qPOVdJWoMvK6ZW0+oy6dVNQaxjkYFhbVSGXTu8NOelPGsQad
 KAex77AoM5pQ5qhuqpcfSwHj8f+MgHQhwv8W8G6WajVKYQtiF5gqPfkPBcDCzEizF1FO
 iXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728547758; x=1729152558;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iD+DMtVCqso+YzMLLnKry5Oy3qdDRY/Zl3EBQvqH/94=;
 b=fyi1mbYZqFdwwYGVeUMBq+IWG/R0R3HYRCQxLrD/nSoXoXQsQYWaznztDqw/dAVJ6q
 8k1Qg3JSxun2ZbKHzM6gHrvHZrkLvDdZsAzHSSwAiSpWkEwyhHiMl4AhqCYGNcbkvoGQ
 Np0RRQDduBa3tbj/PFXoMhSRbmY872u3RR2OVz3fRCCL42B48VO7NjdYhAjYzfLOuHqd
 bTp6PjeatJCaCRKSW1LfVj4cnJj1IgADFciMfHZF32kQGUhDsw9by0xAcFAGpybcKT+w
 e7U9LSfFi5TqnjJ+R/RCc0PDSHm0Ju+Dl3dBIbg22HhmIKzjSyUjqJEjvVxdj5lK3KN9
 kndg==
X-Gm-Message-State: AOJu0YzYiqNNmwHGEB4FPzjaGU3Mx4bHAYRfLKu/6Iur9OsxDZUrbo7n
 awasR+V7dl5GjNcubvQrDGfuQKcvLVOvjKAgPHDDNzs7F3CrJ3d28ZICEySR7C8=
X-Google-Smtp-Source: AGHT+IF4nB6seNEIdCljyDytx7Luanrn423DwI2hClHuYGJWrb8LQwT468SMgqWuigpo6NdOpBLxPg==
X-Received: by 2002:a5d:5350:0:b0:37d:493c:f7b8 with SMTP id
 ffacd0b85a97d-37d493cfacemr979593f8f.2.1728547757877; 
 Thu, 10 Oct 2024 01:09:17 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd399sm798092f8f.26.2024.10.10.01.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 01:09:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/2] spi: add DM_SPI_FLASH compatibility inline
 functions
In-Reply-To: <20241001-uboot-topic-dfu-sf-dt-v2-1-67f7acfa3ff5@linaro.org>
References: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
 <20241001-uboot-topic-dfu-sf-dt-v2-1-67f7acfa3ff5@linaro.org>
Date: Thu, 10 Oct 2024 10:09:16 +0200
Message-ID: <87v7y09y6r.fsf@baylibre.com>
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

Hi Jagan, Vignesh,

On mar., oct. 01, 2024 at 18:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> To smoothly handle the transition from the legacy SPI FLASH
> API to the the driver model API, add the DM functions
> as dummy inline functions.
>
> Today, client code uses #if/#else conditionals, but it's better
> to use if(IS_ENABLED()) to make sure all code builds fine
> and avoid configuration hell, leaving the compiler remove
> the dead code.
>
> An example is cmd/sf, which could make use of those dummy
> functions to drop the conditional compilation.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I'd like to submit this through u-boot-dfu but before that i'd prefer to
have an Acked-by from one of you.

Any opinion on this ?

Thank you for your time!

> ---
>  include/spi_flash.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/include/spi_flash.h b/include/spi_flash.h
> index 10d19fd4b11..2e703e85250 100644
> --- a/include/spi_flash.h
> +++ b/include/spi_flash.h
> @@ -139,6 +139,40 @@ int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>  void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>  
>  #else
> +/* Compatibility functions for when DM_SPI_FLASH is disabled */
> +static inline int spi_flash_probe_bus_cs(unsigned int busnum, unsigned int cs,
> +					 struct udevice **devp)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int spi_flash_read_dm(struct udevice *dev, u32 offset, size_t len,
> +				    void *buf)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int spi_flash_write_dm(struct udevice *dev, u32 offset, size_t len,
> +				     const void *buf)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int spi_flash_erase_dm(struct udevice *dev, u32 offset, size_t len)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int spl_flash_get_sw_write_prot(struct udevice *dev)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int spi_flash_std_probe(struct udevice *dev)
> +{
> +	return -ENODEV;
> +}
> +
>  struct spi_flash *spi_flash_probe(unsigned int bus, unsigned int cs,
>  		unsigned int max_hz, unsigned int spi_mode);
>  
>
> -- 
> 2.34.1
