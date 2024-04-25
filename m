Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBB6C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C8D488F1A;
	Thu, 25 Apr 2024 14:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tBMN6gQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9D888EF4; Thu, 25 Apr 2024 08:14:58 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6364288EF2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 08:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572250b7704so467642a12.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714025696; x=1714630496; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BMGnDWDa3bWd5+Llq1wFcat15V1NdxIngmv/ha4mHMI=;
 b=tBMN6gQcjfjbGIwdSCdu9n/FWNr9W7ABxNqw4QXK/ZLu4kgAksPxB34HtgpTm75qxo
 nKhCiTaWMZM3wPYi+XrvGAvV2/yOmKqOij8zbKG1JYZz+dWwy6uQk66HvurKnw3g2gVi
 DWpS0gBMtMEl6WoHDaJjOM55731pKxaj2O6aydyiHnhFHfmIdZzVL4uaHE04Pp9nx75F
 6lbszn4Fb7j2jfDet7TO71F4eLVXQI9vBXBjs0j+AsCLOOZTRLE6GHupzVhU+nFsj/TH
 Cpk6c1ZDKn8pyPwy+v61Qniq23RHL5oM6lQZ4e1xLzViSyCgq5Sx4yptuh+KfOgfqWIk
 k1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714025696; x=1714630496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMGnDWDa3bWd5+Llq1wFcat15V1NdxIngmv/ha4mHMI=;
 b=fMnulq5TmspKm23CXYCOHdzhxTtBGEbZIHM98XNu7ck5bEUOuTaclJb1w8lgZ8PJp4
 J/uheAHKH+oPcxz27UTDjykrVQzI5Uhc+Hk9yXxwWsbUEeRWziWuDZajG+jJbd/vRc3O
 5m8RA8ZIm2LDKJIIOhqakYi9OuICOlmRKMe8tmifyEoclEbbdvURJJ4Iu0QjbIisfOjE
 9o1K+nlvIzguQ9F8PDe7WYrzrnzJzbVD66Svw3i05ofLbQRmEh7NDjY1i1Jgl8eqNYsa
 in1mEfVd64vQYjMjIbmTpOZ4nwBuhWew9bRRK/etydI1DtNdZFoK8JmQWpuGmrvY/QTi
 Ms8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7JmxpF27js+1jJdQn9DNAjBtMPr1iY+c+JfRKig5wtJ4fbNT5IXEcuKDGPSUPrcvQZfktACGiN2cdPz2sRYGlzw5XrA==
X-Gm-Message-State: AOJu0Yw75uD5y1ZSN6gnJJj5HkPX6ucpps5b4lYHBuMXITgIoUt6Dxkz
 EU5itdgbmXhOl+DgZJvyMFxCS2xBM5oVCh+z41K4RXewm5bVs4boBZ7eR37tW3o=
X-Google-Smtp-Source: AGHT+IFdWxRdmrcRiqjruIAnlkZhwzGSdBoBrer3gHIbJ8Oi4q21akZ2AMxHqiKro8x5Ll4f4w0wfg==
X-Received: by 2002:a50:bb6f:0:b0:56d:f405:9a42 with SMTP id
 y102-20020a50bb6f000000b0056df4059a42mr3249787ede.2.1714025695812; 
 Wed, 24 Apr 2024 23:14:55 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
 by smtp.gmail.com with ESMTPSA id
 k25-20020a056402049900b005700ef75274sm8639094edv.33.2024.04.24.23.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 23:14:55 -0700 (PDT)
Message-ID: <e50af481-7bd4-4ecd-b57d-3694c1131a02@linaro.org>
Date: Thu, 25 Apr 2024 07:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: Set ECC unit size to MTD writesize
 in Infineon SEMPER flashes
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, d-gole@ti.com,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
 <f6de1f875098451edad856ce00288d8221e7bbad.1714020303.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <f6de1f875098451edad856ce00288d8221e7bbad.1714020303.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 25 Apr 2024 14:32:02 +0200
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



On 4/25/24 05:52, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> The Infineon SEMPER NOR flash family uses 2-bit ECC by default with each
> ECC block being 16 bytes. Under this scheme multi-pass programming to an
> ECC block is not allowed. Set the writesize to make sure multi-pass
> programming is not attempted on the flash.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ee968c10e4..7985ca70ff 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3456,6 +3456,13 @@ static void s25_late_init(struct spi_nor *nor,
>  			  struct spi_nor_flash_parameter *params)
>  {
>  	nor->setup = s25_s28_setup;
> +
> +	/*
> +	 * Programming is supported only in 16-byte ECC data unit granularity.
> +	 * Byte-programming, bit-walking, or multiple program operations to the
> +	 * same ECC data unit without an erase are not allowed.
> +	 */
> +	params->writesize = 16;
>  }
>  
>  static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
> @@ -3620,6 +3627,13 @@ static void s28hx_t_late_init(struct spi_nor *nor,
>  {
>  	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
>  	nor->setup = s25_s28_setup;
> +
> +	/*
> +	 * Programming is supported only in 16-byte ECC data unit granularity.
> +	 * Byte-programming, bit-walking, or multiple program operations to the
> +	 * same ECC data unit without an erase are not allowed.
> +	 */
> +	params->writesize = 16;
>  }
>  
>  static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
