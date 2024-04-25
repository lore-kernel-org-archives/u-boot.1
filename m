Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB52BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94F988F52;
	Thu, 25 Apr 2024 14:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QBI+OD3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464AE88EF4; Thu, 25 Apr 2024 08:16:15 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383A488EF2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 08:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41b498ed12dso2338105e9.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714025771; x=1714630571; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FwR9dGChw4tJZOm1r6L9qKd8f3jwo01lNWx4IK7tRao=;
 b=QBI+OD3lST2wqhcUj9lakI+4JhlPhcKMSzEYCITph59vPLqtppCRb8368IPcmQ9WR5
 0Yl38NIlaZBIXRaWR9+Xb4GEYesmfpL6s7snZ8wBLyD7z/INsV3W3sC+Gs5QdEssQFtA
 LLb3ATpwfkO8kFUm5g/zOA0r0VuuBTVNOr04uxGznhPLDlROJT2IMtZzncvZSXqodaqD
 hCdKl0UoD/m8tu9wCNMBv04a8NuA0qCXZsQFHU7f66MZ/Qej/FCdnNIgAmUT+TIwyofa
 eQrATk5+iEO7Y1oQ6TAd5RKhRJo+rRj77Jtqw7u4nu+2NEMuNMq4yMwNJ0nu68iLLG3u
 FxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714025771; x=1714630571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FwR9dGChw4tJZOm1r6L9qKd8f3jwo01lNWx4IK7tRao=;
 b=onz0LxvMQczAjmTCXugf9rkb7lQcpm/3CusNvpALL6URXPrWBjIaHHVPjwIRielA4s
 df25AinKVVLGOTOO+TK7KEU8ft9pHsOcPJdliJF76YAzbkbjA0D/tiYQe2FiIRPs/55+
 21cakvo36cGaCffyYkdTulOuKXJsxHxPfMTaXPkhm3LJkzuc/REHtgWgCetgNKUFy+GI
 NaiafFH1K3h+6ghry8ecja055TnEsuLfbdaMj/txB+sfsb/oaPRVhqXQnNaxP1b02LIU
 wD4oZ/NF+Yy9oRiFdEIc9ZLOg8faG0jLXnknrTeR2+kDXub2ju2g5KaWQ3HIyjp/nFJj
 6drw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6h7L+oY3egT6W7eLZXKj+k9aNX/2IlfIQokx17/igb5ltLEajPVZgRv6Yi3Eh6D2HaPePx0JOMsPwzgj1w0mc/8oCeA==
X-Gm-Message-State: AOJu0YwC3CmIdLpyFRni+jdFXBQ+1H3gH9iMjLY2KF8X84NlP1Twe+Nx
 re2Jin7pglr55P2ODX+W+YqY/S9UYulIix+7ugbgciaq0zd8BvcbJKjUwvmyul8=
X-Google-Smtp-Source: AGHT+IGJz5BRxYjfONwlqEE9IjYpGi167/WjnoUcAnfwPwiDCa9BUsWiQWFu6xvoOSGBnQCJ4UQZTg==
X-Received: by 2002:a05:600c:5113:b0:418:37e1:3f73 with SMTP id
 o19-20020a05600c511300b0041837e13f73mr4066532wms.2.1714025771171; 
 Wed, 24 Apr 2024 23:16:11 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0041a0f3d92c7sm16481970wmq.2.2024.04.24.23.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 23:16:10 -0700 (PDT)
Message-ID: <4f1c16dd-5aa4-4f1f-a245-355dbcc010f2@linaro.org>
Date: Thu, 25 Apr 2024 07:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: Call spi_nor_post_sfdp_fixups() only
 after spi_nor_parse_sfdp()
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, d-gole@ti.com,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
 <b396511bbb406b980f9125b1692d7cb636f07ea0.1714020303.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <b396511bbb406b980f9125b1692d7cb636f07ea0.1714020303.git.Takahiro.Kuwano@infineon.com>
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
> spi_nor_post_sfdp_fixups() was called regardless of if
> spi_nor_parse_sfdp() had been called or not. late_init() should be
> instead used to initialize the parameters that are not defined in SFDP.
> 
> Ideally spi_nor_post_sfdp_fixups() is called only after successful parse
> of SFDP. However, in case SFDP support is disabled by .config, that can
> break current functionality. Therefore, we would call it after
> spi_nor_parse_sfdp() regardless of its return value.
> 
> This patch follows the upstream linux commit:
> 5273cc6df984("mtd: spi-nor: core: Call spi_nor_post_sfdp_fixups() only
> when SFDP is defined")

this shall be the first information in the commit message.

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index fda879f3a3..ee968c10e4 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -190,11 +190,10 @@ struct sfdp_bfpt {
>  /**
>   * struct spi_nor_fixups - SPI NOR fixup hooks
>   * @post_bfpt: called after the BFPT table has been parsed
> - * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
> - *             that do not support RDSFDP). Typically used to tweak various
> - *             parameters that could not be extracted by other means (i.e.
> - *             when information provided by the SFDP/flash_info tables are
> - *             incomplete or wrong).
> + * @post_sfdp: called after SFDP has been parsed. Typically used to tweak
> + *             various parameters that could not be extracted by other means
> + *             (i.e. when information provided by the SFDP tables are incomplete
> + *             or wrong).
>   * @late_init: used to initialize flash parameters that are not declared in the
>   *             JESD216 SFDP standard, or where SFDP tables not defined at all.
>   *
> @@ -2760,13 +2759,12 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  
>  /**
>   * spi_nor_post_sfdp_fixups() - Updates the flash's parameters and settings
> - * after SFDP has been parsed (is also called for SPI NORs that do not
> - * support RDSFDP).
> + * after SFDP has been parsed.
>   * @nor:	pointer to a 'struct spi_nor'
>   *
>   * Typically used to tweak various parameters that could not be extracted by
> - * other means (i.e. when information provided by the SFDP/flash_info tables
> - * are incomplete or wrong).
> + * other means (i.e. when information provided by the SFDP tables are incomplete
> + * or wrong).
>   */
>  static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
>  				     struct spi_nor_flash_parameter *params)
> @@ -2901,9 +2899,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  		} else {
>  			memcpy(params, &sfdp_params, sizeof(*params));
>  		}
> +
> +		spi_nor_post_sfdp_fixups(nor, params);
>  	}
>  
> -	spi_nor_post_sfdp_fixups(nor, params);
>  	spi_nor_late_init_fixups(nor, params);
>  
>  	return 0;
