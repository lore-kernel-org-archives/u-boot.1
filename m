Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97008CF319D
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 07:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D056E88F44;
	Wed,  2 Oct 2024 09:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xR+9AX3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A1C88B08; Wed,  2 Oct 2024 09:29:30 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B87D88ED9
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 09:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso58430945e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727854165; x=1728458965;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0OS+nOLlMH3sKaDvO//Qs7D6/2L9FK9AdcsI1+VPog=;
 b=xR+9AX3m+oxPpZHMhO5JSZri1hK2hXsQ70JfO5xw4d2SgTNUNxRNQYqgw5dPP9LEzh
 79Vcb/qgL855VA2gBt0jDXsST4uDvAjMTs+l99i53YNxAMw107vXRfuxOgI+yKvXlpAQ
 h1ytU42lE3VtRnWJ7q0iNEpjxCWlGY5cI/88hbWqE3fNbJn5wpiwXqQulo4IdikfnbdQ
 X7WstcfSr3UEttDGjNRIscxhA7lTdc836IsKfYPezBL3BulOSECq2sl/i/9wP33zL/LY
 f62StQeEilL5ZvdswyK1GJf3McTMPahhIsw1z6Az7jOiDo3+2mJ36HviGQl9ukbWZLgd
 aiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727854165; x=1728458965;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X0OS+nOLlMH3sKaDvO//Qs7D6/2L9FK9AdcsI1+VPog=;
 b=jOnEjW10D1E05dqd2wS+SzYWVfaCTDaKADoTnR4ZBj2snAvp5UGa8LYAi3vKWbRGmj
 sXyezMYxNF3Vib+PbA5G0j17UCBD5+1REh9omFAs7GKG3dMEdsir5XuZUpZDA2mf4gCc
 bfkEnO76VVeIavBJDvQRMlXmsyFLg7PsdRtm4A5MJJRBafNJpKcqADYcgyXxss3fA7VX
 2gXf0fbzm3DmxzAH8sbAlmPgpZnSrf6TRhM7eNPM0dO5VpGrcKtb1TanCP8vWIAUdSn0
 YUFWxq2rFkMs8Y0TOCs1xKDVGq3LLQ/I4NzBVmUIomTuPADSpzQWcAU4PNB6vBCcUrkl
 miOA==
X-Gm-Message-State: AOJu0Yy0nGsevEkqLcUEeRMkD8qgk9XLoHK0pJY8Jma5J2Sg0rRTXe06
 l/Kug4hnScbLiddX5wC1jFoH2xL5xVDm4mwNNUqGF5k3/v4rQBNKKr6j2Yn7Ks0=
X-Google-Smtp-Source: AGHT+IHJPQWRw1aXeKJeQ//RobD+F+2gbrhNCwAqj6fipSd/rOs3K6nBbHCGCSLhthxugr9L7XDxIA==
X-Received: by 2002:a5d:4442:0:b0:37c:ccc1:17d2 with SMTP id
 ffacd0b85a97d-37cfb9d6758mr1164262f8f.34.1727854165403; 
 Wed, 02 Oct 2024 00:29:25 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6587sm13322517f8f.47.2024.10.02.00.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 00:29:24 -0700 (PDT)
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
Date: Wed, 02 Oct 2024 09:29:22 +0200
Message-ID: <8734lfm08d.fsf@baylibre.com>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
