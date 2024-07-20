Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B4AC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 16:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2973C886B3;
	Sat, 20 Jul 2024 18:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FlwLstfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4C8885A8; Sat, 20 Jul 2024 18:08:43 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B20886B3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 18:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-447d97f98d3so12353041cf.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721491721; x=1722096521; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cCVI9jR9VMKXJIQsHV7nYOzDSn9K3Ua2IhS0QU/LiME=;
 b=FlwLstfvwxxhjNSCyqsD1U+vwURQWXpuxZH0HkWiMScFXFPpPcNQPAKuG5TxQ2cdLa
 vFJ+/zAmIUFoLZXlQR8IGmgFRvinrSjwOxtr6vXphHo5++3RR7Wo2sySlcPfG34sETiY
 a4Gu8S0JagzW4+wP577O2dS1owdQZLy0iGBFZ1sFjDEuVAU+edM6w28py0on6O2mCdcp
 MBi/Rty8+dt9MAb3Q130r9Ssxs1vwtqeCJGllqzzdSQe7cGXIXVWDVqhaJZoJLWfDogK
 hlNs1lXIo0gE+oxsFRvj/i9P6TVnk+hsmF62RLXn/Kkxl3+PYCShVTVZqKrbj8NGQu1i
 tiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721491721; x=1722096521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cCVI9jR9VMKXJIQsHV7nYOzDSn9K3Ua2IhS0QU/LiME=;
 b=cCnY81IIc8nduxC2NHUeSbiYGzsYidJqsBRExxFt53cx6z2k5KospVP/sIDW5clIVf
 /1P6fB7xjipbIdKq7Y1eTKu5wKSDsqiFEYSK88Y/mGpt88z9N2FDm0M9L5qNQoIaGdVF
 Dadn9LtzpGHe/rDrZ+qtszdjn1EXJqYu6LYBKD4wynTiWIW/Zpl8qVatxwF5iK6hKXP4
 ib80zlhq6/Mtt2kvFF0mv+UZf46AAZ+kZ3MS3iM/k2wkHI68BIRK/jxwq0vVtYR3fD6m
 DiE3meu8l63hwhvphMpFjaSdbvId6yRbGpu6e9QVqNo7wgQA88NlTQM2fJTlI2oSt3Wn
 4FFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQL82eHyuKJ38Xj3zgoR6gu1TVCqRKAmfgquEqBskKZBmhcbBup+toBvWYIa2p+JuYEQWJ1ybs+68wUG2zGwAFAsKR8w==
X-Gm-Message-State: AOJu0Yy1dIhoPZITO5bnLK734PNZBPOEHCV+xTrJhKFcYcSL7+dWEVv5
 XNUZh7REwXEUlu0S0AJoBbFJXkVo+c/zt4Z2XeGHlZODPnRzC2SE
X-Google-Smtp-Source: AGHT+IFPUkQz9tmExziZ2mwf4LxUMynHDDzG2CFqtl5aV80MXzdK5SdcgjpCm+091+mLpcZzGFBtkg==
X-Received: by 2002:ac8:5783:0:b0:447:bff3:6b22 with SMTP id
 d75a77b69052e-44fa536c1fbmr40069391cf.60.1721491720701; 
 Sat, 20 Jul 2024 09:08:40 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cda351esm18054481cf.72.2024.07.20.09.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 09:08:40 -0700 (PDT)
Message-ID: <88378a17-67d0-2da7-817d-120ec1c3064a@gmail.com>
Date: Sat, 20 Jul 2024 12:08:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/14] spl: Use unified inline functions for spl_load_info
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar
 <devarsht@ti.com>, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-13-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-13-sjg@chromium.org>
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

On 7/20/24 02:17, Simon Glass wrote:
> Rather than declaring completely separate functions, put the code for
> each case into the same function. This makes it easier to read.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   include/spl.h | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/include/spl.h b/include/spl.h
> index 5dfdf778d2d..2f6a3e64c10 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -306,31 +306,27 @@ struct spl_load_info {
>   		      void *buf);
>   #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
>   	int bl_len;
> +#endif
>   };
>   
>   static inline int spl_get_bl_len(struct spl_load_info *info)
>   {
> +#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
>   	return info->bl_len;
> -}
> -
> -static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
> -{
> -	info->bl_len = bl_len;
> -}
>   #else
> -};
> -
> -static inline int spl_get_bl_len(struct spl_load_info *info)
> -{
>   	return 1;
> +#endif
>   }
>   
>   static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
>   {
> +#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
> +	info->bl_len = bl_len;
> +#else
>   	if (bl_len != 1)
>   		panic("CONFIG_SPL_LOAD_BLOCK not enabled");
> -}
>   #endif
> +}
>   
>   /*
>    * We need to know the position of U-Boot in memory so we can jump to it. We

Reviewed-by: Sean Anderson <seanga2@gmail.com>
