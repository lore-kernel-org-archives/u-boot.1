Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6A4EDE994
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 03:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683B588F1C;
	Tue, 10 Sep 2024 05:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jm6jXeMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E2E88E19; Mon,  9 Sep 2024 18:44:41 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A177B889F8
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 18:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so24711985e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725900279; x=1726505079; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MZeFIoFWSGDj9mCirYeXTk22YRTMGVpc+HNyYWgGKoE=;
 b=jm6jXeMJIZr0YJt7MIDYdcysfQTPefOIX0lVv2QL8IhOKW1lDlwBVDOOcD+LyUP2vx
 39mr4iFADV/R92z4ygWk7Yxmy70Od4LFMO6qCAlrs0fK5SNlUIarAzyM7JG+XkQerJUU
 w4s4UEANP/ZnqNIw6ve93OnVDMA8+JgCj4vJo257zej6bqjZIiiNKHeVlujz+ruWtH/I
 OaH5HV7oExpbyz7mJq0r7zNlXnwwSk9M/GkttUr95UuzVDFfl67rnZnZEyzwuAAXJfJd
 MZUaeGfzJZm15Jf3DNDSjjAO+HeJmvHT/e+i0AgC3rSrI/YVYkLPg8L1f8UP7VzzhC/4
 RFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725900279; x=1726505079;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MZeFIoFWSGDj9mCirYeXTk22YRTMGVpc+HNyYWgGKoE=;
 b=Z4nMx7JWYWG6nefbVwlQB2z/rnLwEx9BW5CzfOojHx3dahaQvKoX5Y+cErqtuii2V7
 HMLeTttUmXJV3M9yvCM4B88ETSQ4JOd7PNpVwOomp0ydQmQ2EEX6r+iQXEbWPJkpGLkQ
 93oXC6m5rqA1hWnUTNKGFbHRn8DZDisZQCr3A8ZFGKukN8p/4ypNnj4fMBqYOKCQpQZ0
 D/3oHMvldp5/PSjHvEpPdreAmimDx2m8LzdmeanmaX00w32JRN3wfrqLZulSG/ujolcX
 Vy2KqY5XYg2LWRwSnpxdc8R/pL4IVwx1aJI7MsJAAbl7fg6X073nkXVe0HmZy5vCzF+M
 RGtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhUJ+ElNgxtp4qerV3oY4v7zkDUswZjxavtUtDIoAWRMQhoMR+tipDt5LpLO1rkUeXdMT5mAM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7gxNekgeoIohoAcdixk7o4k/tVUTyGOlAd3zvqfWMU6C4Lg0z
 3uOg/kV7iowN8UzhrSNRudihW7SuX0oL+XAgbuelhbdfEZqebQdm
X-Google-Smtp-Source: AGHT+IHbtlikFg3+zPGZYl6hoT5rEIgmtvhuWaP0kUO2lFrUwUOnj1fr+dFiI68yxGior+X8NxL0rA==
X-Received: by 2002:a05:600c:1d98:b0:42c:b9dd:93ee with SMTP id
 5b1f17b1804b1-42cb9dd9517mr19437465e9.34.1725900278052; 
 Mon, 09 Sep 2024 09:44:38 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789567609esm6459153f8f.59.2024.09.09.09.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 09:44:37 -0700 (PDT)
Message-ID: <e6b099ac-77b9-42e2-877e-1f7055aca65d@gmail.com>
Date: Mon, 9 Sep 2024 19:44:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Deduplicate w25q16dw entry
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>
References: <20240906210951.193142-1-marex@denx.de>
From: Tudor Ambarus <tudor.ambarus@gmail.com>
Content-Language: en-US
In-Reply-To: <20240906210951.193142-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Sep 2024 05:19:45 +0200
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



On 07.09.2024 00:09, Marek Vasut wrote:
> The w25q16dw entry exists twice in spi_nor_ids, remove the less
> complete variant of the entry and keep only one copy of it.
> 
> Fixes: baef13ec9d59 ("mtd: spi-nor-ids: Add support for flashes tested by xilinx")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neal Frager <neal.frager@amd.com>
> Cc: Prasad Kummari <prasad.kummari@amd.com>
> Cc: Teik Heng Chong <teik.heng.chong@intel.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 88709a52b3a..d1389e681d6 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -430,11 +430,6 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("w25x05", 0xef3010, 0, 64 * 1024,  1,  SECT_4K) },
>  	{ INFO("w25x40", 0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
>  	{ INFO("w25x16", 0xef3015, 0, 64 * 1024,  32, SECT_4K) },
> -	{
> -		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
> -			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> -	},
>  	{ INFO("w25x32", 0xef3016, 0, 64 * 1024,  64, SECT_4K) },
>  	{ INFO("w25q20cl", 0xef4012, 0, 64 * 1024,  4, SECT_4K) },
>  	{ INFO("w25q20bw", 0xef5012, 0, 64 * 1024,  4, SECT_4K) },
> @@ -442,7 +437,8 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{
>  		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
> -			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)

you probably chose to keep the second entry to have some sort of
alphabetical order. I'd keep the first entry as the second entry was
never used anyway, then reorder alphabetically if one cares. Just
nitpicks so fine by me either way:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>  	},
>  	{
>  		INFO("w25q32dw", 0xef6016, 0, 64 * 1024,  64,
