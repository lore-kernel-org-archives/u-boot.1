Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A22C4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D59C87D60;
	Wed,  1 Nov 2023 19:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lYVUnS4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B72587B35; Wed,  1 Nov 2023 19:03:23 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE60D876E1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cbd1d7e04so46152821cf.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698861798; x=1699466598; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rZiCcKKUvMtJ93eWL7qsxlEZ/AW3d7HOAE81f/P1ewE=;
 b=lYVUnS4bfUg8GqE5KML/0BZ9L4dPqqCLdkUDro9SpFMBwD865TkJo0gasAIRRzIwJk
 6XXzABzxq2AmLSDpM1OOQIeL5yggC+07qvCDMLrZdoDgZJyvApHTN1H+H7SE5owLzwpF
 jOFlv5f5jPJoVQLlFcznnms5+tYaK+WkqaFPPK92SLR95CdW0v7cZEnhG6v8tuPiBwmS
 cKR+/3JkCd09/vrKSqX9psZVYrLz+5nMGk71l50yP1GfSfMtPi0CLLNeqOC0VLkeI7tQ
 qf8iCNYyyR1Y8v9ZvuvrHmB+wt50Ae+ynTlI8dgDj+Ays4i2SjICEu9q8H6/CAw8eUig
 GZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698861798; x=1699466598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rZiCcKKUvMtJ93eWL7qsxlEZ/AW3d7HOAE81f/P1ewE=;
 b=dqVZ3iWYTiu2p3jBLopDVskNcxSRK/bI7Ji4nQlPU+KLCZ5q9FijQZuZzHM2Et+xfB
 7X7NrZ1cFWpmF3yJa+Z25vcx/bg8YlnVv/BxTSVGtkhrKrvWk5SySc3yThba0EDFqZ8R
 WAg6zW12TBPTeBUTJn7NOuXSOm/geMWXdayppGVz0Rjk9dbG4JjAbUGzDps0OmghJhpq
 wWI0JkdFDKySoEYV7OKvt4YFTnuFvquF+trJehY5Uicm1fVejZuFBd125OIyJRKzhrKB
 YDCJNDFNznd9ngqXAeyJSktRjFO6hpsD49BG+uNI+lBoc1GNPHTWQgy2gWuLsZM+EWXT
 nDjg==
X-Gm-Message-State: AOJu0YxIOeSwRdMTiiDt86EQ54g3G9aSTEanfzNhFbjvUZpSu5cwwzsr
 3Wnn1axVTvQdv6vwxo+Yp2l8Btvlxm9r3w==
X-Google-Smtp-Source: AGHT+IHBQXqNur+3js+jpDNQFtZVidu1nlE15MdUSRFMLeO2UvlDpXnQZl4iUxJ9SOch8rR1MNUa/A==
X-Received: by 2002:a05:622a:587:b0:41e:1dff:bed5 with SMTP id
 c7-20020a05622a058700b0041e1dffbed5mr18259243qtb.37.1698861796777; 
 Wed, 01 Nov 2023 11:03:16 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 l5-20020ac84a85000000b0041811e71890sm1589954qtq.33.2023.11.01.11.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:03:16 -0700 (PDT)
Message-ID: <61f20966-cc87-d378-7590-9cda92298ec4@gmail.com>
Date: Wed, 1 Nov 2023 14:03:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 3/5] clk: also handle ENOENT in *_optional functions
Content-Language: en-US
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-3-49ec18f820bf@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230818-clk-fix-v1-3-49ec18f820bf@outlook.com>
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

On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> If the device does not specify any clocks in device tree, these
> functions will return PTR_ERR(-ENOENT). This is not the intended
> behavior and does not comply with linux kernel CCF. Fix that by
> returning NULL under such circumstances instead.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   include/clk.h | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/clk.h b/include/clk.h
> index d91285235f..f95da0838d 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -223,9 +223,11 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id);
>   static inline struct clk *devm_clk_get_optional(struct udevice *dev,
>   						const char *id)
>   {
> +	int ret;
>   	struct clk *clk = devm_clk_get(dev, id);
>   
> -	if (PTR_ERR(clk) == -ENODATA)
> +	ret = PTR_ERR(clk);
> +	if (ret == -ENODATA || ret == -ENOENT)
>   		return NULL;
>   
>   	return clk;
> @@ -335,7 +337,7 @@ static inline int clk_get_by_name_optional(struct udevice *dev,
>   	int ret;
>   
>   	ret = clk_get_by_name(dev, name, clk);
> -	if (ret == -ENODATA)
> +	if (ret == -ENODATA || ret == -ENOENT)
>   		return 0;
>   
>   	return ret;
> @@ -359,7 +361,7 @@ static inline int clk_get_by_name_nodev_optional(ofnode node, const char *name,
>   	int ret;
>   
>   	ret = clk_get_by_name_nodev(node, name, clk);
> -	if (ret == -ENODATA)
> +	if (ret == -ENODATA || ret == -ENOENT)
>   		return 0;
>   
>   	return ret;
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
