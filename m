Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1919C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 10:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1B288452;
	Mon, 10 Jun 2024 12:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ifd/TG+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73DA884AC; Mon, 10 Jun 2024 12:45:41 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34C588444
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 12:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eabd22d441so67817641fa.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718016339; x=1718621139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5zCVjiw4SS4D8KCwUOLvfAiM34Dnqyqyo5lBIwXtoLA=;
 b=ifd/TG+vLzDZgJLTGkPyT+3W+PdAshz54L9GoOAtiro+1BlaUXW3DgoKnWlTrqKDXa
 pYOanYTdzcXNFSN/RMmXKtxjIdlJpiLoCBYuuNnPlM+wqGUZTkcdjRl2G1MIXwOH5mhQ
 M+GNxScJ2reWjmGA2qitGwa+vBFwsh1HiqBEIo22aA3SqgZZMy62TpTfxtDhe1Z0lubK
 XUGwbmpY7Hb4noX2woy87wHpD9lf0+RihD1jXUXoxIbCeW16xWPWMmbIFtf9TsU6GjKM
 drlzR1AZ4EBJS4swJtk7Kug/eyPPqOTwKNSfoY44oMvgcLt4JYaXA7z+0M/X37fPenr+
 WajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718016339; x=1718621139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zCVjiw4SS4D8KCwUOLvfAiM34Dnqyqyo5lBIwXtoLA=;
 b=fA089oD6CB/FO/oq8JqsmFeN8T3nxDVae7nh8OlBUhEo4FwWvNIuXJbfQAlemvqIJI
 6D8s6/GfY2Y0a866cPwLJdop1nLMNBdoDwOPhU5t2NnNjbk7GDRTQYpGbkv01XC69q4G
 b3O7qoWpxL2TnW/OrVW6HKszXIP4ajdz9CLQsTk/qY56ZpRat8XnnT8XTjZzegO8Px/v
 F2YVd50TIBPWza7BM2OXLt8AoAVQbjNgxUtifnOe1NOgzPeUDAqFLabr4cpwZOcy5bFY
 kkrUlUUwLxcqkCL7kQG24ghH8PaJi6pk/Elr0qSW5GKllroD8kFfKih7AomJ/jG3GnHN
 NJlA==
X-Gm-Message-State: AOJu0YxRGrxhBLdCZzR1EPl6TjtnuUStmTAadRCLGA0F1hrOXX55l5fw
 YknFn5F5dw/hYuNqOI6zVgKpS8LMrqAZQvp+W4ol3f/ZyxspghjG/esdjCkJHN8=
X-Google-Smtp-Source: AGHT+IHkUUO/s3WpFWVY1+iF3yGRd7s0mI2UH48G1qlArl21QcfU9MkRzvyJPj2cz520SwFQjJH9qQ==
X-Received: by 2002:a2e:a165:0:b0:2ea:e759:74ab with SMTP id
 38308e7fff4ca-2eae7597610mr65101811fa.41.1718016339064; 
 Mon, 10 Jun 2024 03:45:39 -0700 (PDT)
Received: from hades (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421811de328sm53983085e9.40.2024.06.10.03.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 03:45:38 -0700 (PDT)
Date: Tue, 11 Jun 2024 00:17:08 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 03/31] lmb: make the lmb reservations persistent
Message-ID: <ZmdtVFiA835wvFV3@hades>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-4-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-4-sughosh.ganu@linaro.org>
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

Hi Sughosh 

[...]

>  #define LMB_ALLOC_ANYWHERE	0
>  
> +#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> +struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> +struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> +#endif
> +
> +struct lmb lmb = {
> +#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> +	.memory.max = CONFIG_LMB_MAX_REGIONS,
> +	.reserved.max = CONFIG_LMB_MAX_REGIONS,
> +#else
> +	.memory.max = CONFIG_LMB_MEMORY_REGIONS,
> +	.reserved.max = CONFIG_LMB_RESERVED_REGIONS,
> +	.memory.region = memory_regions,
> +	.reserved.region = reserved_regions,

This is probably a good opportunity to look into why
CONFIG_LMB_MEMORY_REGIONS was introduced.  Since we are moving towards
static allocations, do we still need it? Or allocating the size dynamically
covers all our cases. 


> +#endif
> +	.memory.cnt = 0,
> +	.reserved.cnt = 0,
> +};
> +
>  static void lmb_dump_region(struct lmb_region *rgn, char *name)
>  {
>  	unsigned long long base, size, end;
> @@ -42,8 +61,8 @@ static void lmb_dump_region(struct lmb_region *rgn, char *name)
>  void lmb_dump_all_force(struct lmb *lmb)
>  {
>  	printf("lmb_dump_all:\n");
> -	lmb_dump_region(&lmb->memory, "memory");
> -	lmb_dump_region(&lmb->reserved, "reserved");
> +	lmb_dump_region(&lmb.memory, "memory");
> +	lmb_dump_region(&lmb.reserved, "reserved");
>  }
>  
 
[...]


Thanks
/Ilias
