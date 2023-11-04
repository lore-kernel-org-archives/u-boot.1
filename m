Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE9AC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 15:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B237870EE;
	Sat,  4 Nov 2023 16:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOK/wn1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6381487119; Sat,  4 Nov 2023 16:10:51 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90C3870EE
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 16:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77897c4ac1fso178546585a.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699110635; x=1699715435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Qa7gqcJQDsDH2lppr3XdAGAU5FABpfBQ8MAsXbqpsU=;
 b=IOK/wn1S+kt1+frDlIFB8wwSwYWyC37AVpxMoohx3BsfWwOQCZtyXRuoO5q7831njO
 RwqokyR4kqd6Q+/rASqHsv2y6UyvnExKYUhnHr+OX1H18zfDg9XzZlj3qjn8YwqmZq2J
 vrRtEUfxcU/jNejiyOZemj46360SYOwo9EDoiMtOWsgoGGgHLHy+6RN+BBU/TWRpEhKT
 psL9pExGcscBdlc4gFJg0KsPKEhhY0qNw0vUIMmsQvTdATcbmfMAGqSduHFAwBbY4Fhj
 a8kp9PqYvbmzHQ1Ngud5iINgk/Q52wAQNPEPrt3JGvTKXWXauzkqNVCMZxTl24lhjGYE
 J7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699110635; x=1699715435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Qa7gqcJQDsDH2lppr3XdAGAU5FABpfBQ8MAsXbqpsU=;
 b=q7QgcMgF7ytFzhmAgZW9fklfdoiz3b7AHfG8g//x3kVw+l9iXwsl/4QxTKl1dWR5X7
 D8vDDstgxbdXXAmZs7d7bOl97gD+FSkoiWtujuIhUmiXkXa9AWQMvEyaV/eQty20HbZy
 Guji3xTGItx+Fk6zx5uPf+dYmaOdl4Q+8zEcHjIR/RWI6wuWF1Sbg3nDD6Vs8lAfyLkQ
 goPpVG4qFNbEDEpyykjTRIvPA3WCgOTKt3lJQ6edihloQsoxd8RjPVq1xvOS926OjLtW
 3yfNqbOYHIRnoF/34HRgojWfBA//hhzRYLjgyuON9AqttbnQ7ypbyQYmmMLuT5SgGSsL
 r7+Q==
X-Gm-Message-State: AOJu0YxHVpYMhx8bPS73hTjyhEbVBBphSLScZX99Ew1Xg3KGQKRGy3sS
 R+GWMnMJxl2OJRQ4NjCQXXY=
X-Google-Smtp-Source: AGHT+IF8SVxdUtq/1d4SHTTANOeua6Do9BHXrS+AWmlQFf1cIit9x0OCwjaaghmmJDF1Rad4jiwdSg==
X-Received: by 2002:a05:620a:888d:b0:778:910f:d89e with SMTP id
 qk13-20020a05620a888d00b00778910fd89emr19641092qkn.72.1699110635554; 
 Sat, 04 Nov 2023 08:10:35 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 oo12-20020a05620a530c00b007758b25ac3bsm1646226qkn.82.2023.11.04.08.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 08:10:35 -0700 (PDT)
Message-ID: <e1a1482a-cf05-005d-817a-96a925cf6f87@gmail.com>
Date: Sat, 4 Nov 2023 11:10:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] spl: fit: Discard decompression if not supported
Content-Language: en-US
To: Loic Poulain <loic.poulain@linaro.org>, sjg@chromium.org, marex@denx.de
Cc: u-boot@lists.denx.de, abbaraju.manojsai@amarulasolutions.com
References: <20231103143426.3643712-1-loic.poulain@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231103143426.3643712-1-loic.poulain@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/3/23 10:34, Loic Poulain wrote:
> And simplify further decompression testing.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>   common/spl/spl_fit.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 70d8d5942d..1d42cb1d10 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -208,6 +208,20 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
>   	return (data_size + info->bl_len - 1) / info->bl_len;
>   }
>   
> +static inline bool spl_fit_decompression_supported(uint8_t comp)
> +{
> +	switch (comp) {
> +	case IH_COMP_GZIP:
> +		return IS_ENABLED(CONFIG_SPL_GZIP);
> +	case IH_COMP_LZMA:
> +		return IS_ENABLED(CONFIG_SPL_LZMA);
> +	case IH_COMP_NONE:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>   /**
>    * load_simple_fit(): load the image described in a certain FIT node
>    * @info:	points to information about the device to load data from
> @@ -235,7 +249,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   	void *src;
>   	ulong overhead;
>   	int nr_sectors;
> -	uint8_t image_comp = -1, type = -1;
> +	uint8_t image_comp, type = -1;
>   	const void *data;
>   	const void *fit = ctx->fit;
>   	bool external_data = false;
> @@ -248,9 +262,11 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   			debug("%s ", genimg_get_type_name(type));
>   	}
>   
> -	if (spl_decompression_enabled()) {
> -		fit_image_get_comp(fit, node, &image_comp);
> -		debug("%s ", genimg_get_comp_name(image_comp));
> +	fit_image_get_comp(fit, node, &image_comp);
> +	if (!spl_fit_decompression_supported(image_comp)) {
> +		debug("Discard unsupported compression %s ",
> +		      genimg_get_comp_name(image_comp));
> +		image_comp = IH_COMP_NONE;
>   	}
>   
>   	if (fit_image_get_load(fit, node, &load_addr)) {
> @@ -283,8 +299,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   			return 0;
>   		}
>   
> -		if (spl_decompression_enabled() &&
> -		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
> +		if (image_comp != IH_COMP_NONE)
>   			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
>   		else
>   			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);

Why doesn't spl_decompression_enabled work here?

--Sean
