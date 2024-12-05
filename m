Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1485E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8943894F6;
	Thu,  5 Dec 2024 14:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YcYDVkGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06DE88F49; Thu,  5 Dec 2024 08:36:01 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE48F88EB7
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 08:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so5863075e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 23:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733384159; x=1733988959; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=URYIExM4SjrL4kEMsRQPUS2vipoW6QTZA0FuJnpTdC4=;
 b=YcYDVkGXJ6hwv03LJlLpDZ1TfwGFQGUhzSCuRvTfWxJ8prHGw7czUvcKP9F/0rrU+S
 Svu4yEW21xI6QmzOV/uCc9m9y14LOktOTwDknTYpJW/aaK6ZpLjl/pGe9R1ws+Dn45pw
 HHYd+l555PVeqH51aPHkL1KQ9I9swdRzQkCuBkz8TOXvssNKoi6Y4A4tLFhHprfX98ce
 r9egPjlM9VTPAR/oxjkDvtsRyj/EEPC3ZBUDuSt16wC2oKioQOrb3CD0IJM8poBhyFW1
 07H8Dt3bzmlNaRHdOT/aIWXYCXCtEnHBHM/MsSM3DJ4yd0aETBvW/JWups32GWTS93Yz
 6Aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733384159; x=1733988959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=URYIExM4SjrL4kEMsRQPUS2vipoW6QTZA0FuJnpTdC4=;
 b=l1cXxKzBEFY5Rd5eUUHFd/sL2fFYeTg3XJ9HOlVxuPIBv+87FgFnPurTK7M4QE6JtW
 pAApMMO33S1FkYCjJpGDooM2uzoiurokKqU5WcpviUz7MJFSV/hNtBD1bzRSF+S5/R7C
 IKMIEX056rRs+hctFZ+tH2kO+80ymk/9viliTgCK3ydnejLIadaqC5+MSSfHLpC8MVo7
 URuUSC7Zcd2jCKLbBhcyypfjg9yygktudXAmaoY8i4K2sgEInNLSDL/NlfjnqB6Bffi5
 3VavQro3WDsvhvx1/Jv+Lb23fKkVYvtnxR1PAah2096+XdQS0cN4f5UIsZpwfAVQXeXs
 eDCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/vKIZMqI1BXdCpCye8I6iL8sLMxMhzMgB3Q3xznDlr/yWKZYMJkJp/4nDGJP2rsmJVPpvh+M=@lists.denx.de
X-Gm-Message-State: AOJu0YyuR3bZvhdE/Mon+0Gx/2PeVJHXiNfeqGBubymuC7oD+n4x6Qxt
 1VrE+osGPITQo9bDrT3aWEbcGY7k7MeYUWk1X83PXVgjO45H2URT+cpsHReVqYg=
X-Gm-Gg: ASbGncv1bS8NivngsTj+75rzJSVgROekTN5edKGjEK/3CW3Jgj/fpTd0MNc6rWp51sz
 dzT5uaFzXu57zB20BY2kDjvr5NrbToKdrgmxS9sPJrjf1qRRJkSrgVuLLstCnWFVGThjyrNHqIA
 nNalkM3RHwMVpZmcTWj+7kzkScCE/ZtpNuj8p6WBF9atcTF6mPG71ett3WLsxL60OZ/Vgw/7lcQ
 junHefNd/zkBZ54qh/kMUu2kxeNTeQjQj0PdNv1reyELovWbuMxZtvP7A==
X-Google-Smtp-Source: AGHT+IGn8NEmFci2nTcyj6/5xGXPTCkNiS58Bjmnp0/Fv0IWVPdholDCZmzQF6r+Bxkz80R3EvXCog==
X-Received: by 2002:a5d:6d0b:0:b0:386:857:cc54 with SMTP id
 ffacd0b85a97d-3860857cfecmr5194077f8f.9.1733384159335; 
 Wed, 04 Dec 2024 23:35:59 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fc51451sm1181050f8f.47.2024.12.04.23.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 23:35:58 -0800 (PST)
Message-ID: <2773d157-2b75-4fe5-bf16-9e6927e0f6f4@linaro.org>
Date: Thu, 5 Dec 2024 07:35:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Fix the read issue when addr_width is 4byte
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, j-humphreys@ti.com, marek.vasut@mailbox.org
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, git@amd.com
References: <20241118090544.21956-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241118090544.21956-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 05 Dec 2024 14:07:50 +0100
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

+ Marek

use get_maintainers script please

On 11/18/24 9:05 AM, Venkatesh Yadav Abbarapu wrote:
> Fix the read issue for 4byte address width by passing the entire
> length to the read function, split the memory of 16MB size banks
> only when the address width is 3byte. Also update the size when
> the configuration is stacked.
> 
> Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13b..c37a9bce74 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1580,6 +1580,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  	loff_t offset = from;
>  	u32 read_len = 0;
>  	u32 rem_bank_len = 0;
> +	u32 stack_shift = 0;
>  	u8 bank;
>  	bool is_ofst_odd = false;
>  
> @@ -1593,18 +1594,20 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  	}
>  
>  	while (len) {
> -		bank = (u32)from / SZ_16M;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			bank /= 2;
> -
> -		rem_bank_len = SZ_16M * (bank + 1);
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			rem_bank_len *= 2;
> -		rem_bank_len -= from;
> -
> +		if (nor->addr_width == 3) {

No, this looks bad because you enter the body of this for all the
flashes with addr_width 3, not just for the parallel/stacked ones.

Instead you should do whatever you do here just for your
parallel/stacked cases.

> +			bank = (u32)from / SZ_16M;
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				bank /= 2;
> +
> +			rem_bank_len = SZ_16M * (bank + 1);
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				rem_bank_len *= 2;
> +			rem_bank_len -= from;
> +		}
>  		offset = from;
>  
>  		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			stack_shift = 1;
>  			if (offset >= (mtd->size / 2)) {
>  				offset = offset - (mtd->size / 2);
>  				nor->spi->flags |= SPI_XFER_U_PAGE;
> @@ -1616,6 +1619,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  		if (nor->flags & SNOR_F_HAS_PARALLEL)
>  			offset /= 2;
>  
> +		if (nor->addr_width == 4)
> +			rem_bank_len = (mtd->size >> stack_shift) - offset;

same here.

If we still want to keep this support until everything is implemented
above SPI NOR, other option is to duplicate core methods and introduce
dedicated methods for the parallel/stacked cases. You could keep the
parallel/stacked methods in dedicated file as well.

The advantage is that you won't interfere with current SPI NOR support
and that you won't break any flashes anymore. Then we can easily remove
everything once proper support is implemented above SPI NOR. The
disadvantage is that we duplicate code ... Marek?

> +
>  #ifdef CONFIG_SPI_FLASH_BAR
>  		ret = write_bar(nor, offset);
>  		if (ret < 0)
