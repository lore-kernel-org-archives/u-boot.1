Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E1ACD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE7087E13;
	Thu, 11 Apr 2024 05:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQeKf+pI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EC288120; Thu, 11 Apr 2024 05:10:31 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8392887E13
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-434ed2e513dso7814031cf.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712805028; x=1713409828; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RChY/THSl2n6z5/XZAxWgPwPbdcy0r1TRZwFIoPVC3w=;
 b=aQeKf+pIup7HD5OlYqHSJSzU4UTj3appVWF9A2LlgMggNXWeZ8TNfisCjya6CxEfyZ
 8VGlHfoPpllNFDNmedQpL1IF7L2yXPfTFu7PGxsW73xFTMJL0GBm/VrF88SbkbVpplLc
 hkDdfvXISwEI3wuJYpTjONVi7r+xXRreHkLiPo+4yiBn47ZbzRYyOD8AQ9gaaezW76bI
 lxn4uT3l1leNsk/88BSRtD7VdqSZuImOId7jf8x2spNbanzjyhR4VuoAYvipm+SQ+P4w
 wwlqFXc8B4jFurRjnVjLS9VCZW8djPRWYZM99dWaPmJpHH8l0ICXG83+wkVhuzLjwKZF
 rabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712805028; x=1713409828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RChY/THSl2n6z5/XZAxWgPwPbdcy0r1TRZwFIoPVC3w=;
 b=BOuwRLL3KbB+4nvnBKT3fEbUpfg1ftt10dpQJDVjTn184lTxT8NsAIBopWX+Bb7Kd0
 WS/cEROCZasHXuvZmH5oUVL1R87rW2xul8Ljja5ulLyYK567J0AzvJxw7ho59QIV94UL
 Np2gKbFExBWSb93FTS6r5IjiB4/zRneOWAqWwkaF3kP3EqMdB8xWdWi1fuFtTX7Lmcxc
 5/JfS0SB6hrKlal3+LH0s4kiEjCj/zDZxZrtQ33w6fyJfRTrFzvBQgcZfSiBgkDNJcum
 UoSH3HTHMl6HP09IsN8zBvw/EleOfkStLgiumXNZ0uwtQJMayKkL6Heg/7bVfKE0gVar
 PkMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEXA7UN93ySMLokJCWTVPexhTg4EAGwsmBxNj54eZ07p/KdZPm1CVshODIJLl4fC8vUuVgLIAwIkKeSI2N1A0Dob0mZg==
X-Gm-Message-State: AOJu0YzOjaHoEsDJG6TIvwhuklyqU0xKNFyDKkahAFKZkfQcwvBfDQiX
 cKjYhsqOsvnY1lB8E2EbQP69Wxm1cVMbsUEv6IcEjBBa8HsW6YkjqStDNg==
X-Google-Smtp-Source: AGHT+IHRVE9Gz3ZucoT+Vc535BeiAOdOMX/8fbjF/mJp1uEeA/O3cRFpu/dmWPzQaUl6swcrt7MDcQ==
X-Received: by 2002:a05:622a:15d4:b0:434:3e50:2203 with SMTP id
 d20-20020a05622a15d400b004343e502203mr5082209qty.39.1712805028349; 
 Wed, 10 Apr 2024 20:10:28 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 e8-20020ac86708000000b0043490cc5254sm356535qtp.32.2024.04.10.20.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 20:10:28 -0700 (PDT)
Message-ID: <00786854-f7d5-4b3e-22ae-82364e201abf@gmail.com>
Date: Wed, 10 Apr 2024 23:10:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: Fix error message in clk_get_bulk
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Lukasz Majewski <lukma@denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <e654ed23-1fbb-4458-83d3-2348ec7ef1de@siemens.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <e654ed23-1fbb-4458-83d3-2348ec7ef1de@siemens.com>
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

On 3/9/24 07:27, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Fix a logical inversion of the printed text.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   drivers/clk/clk-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index ed6e60bc484..78d8ea94c65 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -180,7 +180,7 @@ int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
>   bulk_get_err:
>   	err = clk_release_all(bulk->clks, bulk->count);
>   	if (err)
> -		debug("%s: could release all clocks for %p\n",
> +		debug("%s: could not release all clocks for %p\n",
>   		      __func__, dev);
>   
>   	return ret;

Reviewed-by: Sean Anderson <seanga2@gmail.com>
