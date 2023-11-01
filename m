Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AB9C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5316B87D7B;
	Wed,  1 Nov 2023 19:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaWArHNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3325587D81; Wed,  1 Nov 2023 19:26:27 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617A087524
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cda69486eso50215371cf.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698863182; x=1699467982; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MCyVLcCJz6HEmHbg1Cn8Bfhia55pbZZ/dStUqfaHB/s=;
 b=UaWArHNpro9+ae3rhWRqVx3s0+cF7FTdp4ZV3JcyMWqVRVJdMMw2oRtFsWzecqrw2/
 5Av3/5Wt91mKuWCzPzznZoEEPZCSLhxjkTWzltjwNOeIWE4Mzi9y19rMRiDq667mb09x
 sdfQvFgbSjfCNrGOF4Ef6/mHmYoLWNs0QOZRu79fc3ggmiNicUJ6XBIAlcqHzZ8WP1m/
 ReV91+DPaPov8l52W9dCtOEwJ6wKyjpCAMUlY/AMek0I8TaDpGRrYoV91dB5IQFi8RwW
 D/B7cmzMaseHkRYUrnf7FfRk1g7CEQYOZqCUxfyUVRQ75rWMmiTbWn3WSsl3B6ItAm0A
 UwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698863182; x=1699467982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MCyVLcCJz6HEmHbg1Cn8Bfhia55pbZZ/dStUqfaHB/s=;
 b=YWiX29pQJAVZ0fkUff/4JiRmd8n8NJwCqCY7KxMTtD1iWyLG3kvqYoivc1sOxEv6ea
 cCyEkw/aKDYdxpVYvwHQEOOOD3/mhU/TKThoG3Rz8TffIn+nVZ8a8uwN2DoQtbfJ024t
 svRyp92UJV/xKjk2DakJSHD1MRG3P//cYGBXu6CgEH3AkgAS1CSDfFXfFVh/lWxTPeCE
 3LtUIimFomDBm9kSxs11wsmfecNKIM27C0abECxkGlL/X2yjENRIDCnXePLQV0HW9DCV
 vDbnz42AQ1ArCusQgEgxin+eAFQDF3+Jvfx4BIAZlVaYcg0pQSBHa/gtQUdWQzllwWou
 doXQ==
X-Gm-Message-State: AOJu0YwXkXiyZETC/L98mWADY/p+MUvjh555tUPJNObCcGxlyqeF4hR2
 EVQrVN4mFYUtw/U0tqGV3tI=
X-Google-Smtp-Source: AGHT+IEVAqQyoWVQP4LPRqxi5V0Qp5N0S7ya4F7QsOUWGGAHd4IMVTtIqzH342NeuX2Cfx3to8a0qw==
X-Received: by 2002:ac8:598d:0:b0:417:b91b:e101 with SMTP id
 e13-20020ac8598d000000b00417b91be101mr20358562qte.21.1698863182167; 
 Wed, 01 Nov 2023 11:26:22 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 x19-20020a05622a001300b0041e211c5d0bsm1628230qtw.6.2023.11.01.11.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:26:21 -0700 (PDT)
Message-ID: <5eca2518-9444-5d3f-07e0-c70d1e8ffcfc@gmail.com>
Date: Wed, 1 Nov 2023 14:26:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: change log_err() to log_info() to make it quiet with
 clk_register_fixed_rate()
Content-Language: en-US
To: notfound405 <forbidden405@foxmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <tencent_AC2AFCA3734CD16CE13CB5D7E8F5C07FEE08@qq.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <tencent_AC2AFCA3734CD16CE13CB5D7E8F5C07FEE08@qq.com>
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

On 3/28/23 13:03, notfound405 wrote:
> clk_register_fixed_rate() calls clk_register() with the fourth
> argument(parent_name) being NULL, making it output error message. Change
> to log_info() to fix it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
> ---
> The previous email is signed with a wrong name. The patch is not
> modified.
> 
>   drivers/clk/clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a5a3461b66..0619937cee 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -24,7 +24,7 @@ int clk_register(struct clk *clk, const char *drv_name,
>   
>   	ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
>   	if (ret) {
> -		log_err("%s: failed to get %s device (parent of %s)\n",
> +		log_info("%s: failed to get %s device (parent of %s)\n",
>   			__func__, parent_name, name);
>   	} else {
>   		log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,

cf: https://lore.kernel.org/u-boot/20230818-clk-fix-v1-2-49ec18f820bf@outlook.com/
