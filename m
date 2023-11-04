Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873F8C4167D
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 15:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9DF8708A;
	Sat,  4 Nov 2023 16:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCBesGeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6B38708A; Sat,  4 Nov 2023 16:13:15 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B827086FE7
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 16:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6754b4091b6so18033956d6.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699110791; x=1699715591; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SaS7ocNZYDQslFYPs6uMs34w/4zmIQXp6f/7k9a2QH8=;
 b=mCBesGeKAani5WfB1wV0XEdzKat0Q7jq4SsfAQPAZizWkGA9MAvKtYMbqqD5Cgm+jm
 DS75H5/WQFGwE963MV+I/G5jJdp7qhgsnYGILjqlbi1T9JPDh6eErcWKvOW2kX1IV6R2
 bht299rIqVt1g5hXY9s3YsCCT5U1ZB7mIRrAoDD9wA9MmddBnIVhfZSEms7oDBzwR8g3
 7ZwzUcZ4fQRDElrW0fC12PVZd7Z9WJHRB838pDXCIRBoWRrMkUsQvKskC7wDK8k/BvCj
 w+ZIz2r33ywz2KxeVEr4O7Ee9jGgcue4k9g504hGxmGvJDop2cVxIFadL2l+WY0pEuGn
 XEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699110791; x=1699715591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SaS7ocNZYDQslFYPs6uMs34w/4zmIQXp6f/7k9a2QH8=;
 b=rBh2uKTK4/auM/vxvvv4uCfgPgTNTjwMH77FFDBPJSQ0NW+H3kaZ4VnPnX/LgM8sIv
 7e0pyTGGjnTLSmqK8gfpKgWjeWHnr0fs1eZpMw7xvLIFLbyBcsLwagLG8AcOBYBSkIGd
 eCo3OhSx/41hEcjMyVuK0iJXx4AhqcR7HExv2+8OcXXVK77T5zb7OVGW38laZetUMIfo
 zAawiR7l7x5I9nign0gDzy7D3zGmiu0IDSEL1nAx/ZLMeoItf1Ksimw+7CPqgTrKKMxR
 9Ffd2rZSaMRuXgjCZgWY5hvlnwsGPD+qRmWp8MxslncmDvGOVoJ6JDAdH74hiiHqKeX/
 RchA==
X-Gm-Message-State: AOJu0YzQwVzX5SRveAd7YwoCIDQDgmezRGc3Me3AcQibqtg7icckDm//
 Sc9deMjW5xS8lI0rAScW/5M=
X-Google-Smtp-Source: AGHT+IFNn45k3Vu3crtDl6DAHVD/B3xJjV7Q8cXrun1Vn4fxjee3Vkkja2rEOvrgGQnp+PQzMJopYw==
X-Received: by 2002:ad4:5c65:0:b0:656:3b4c:b98b with SMTP id
 i5-20020ad45c65000000b006563b4cb98bmr33711019qvh.11.1699110791367; 
 Sat, 04 Nov 2023 08:13:11 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 b3-20020a0ce883000000b0066cfd398ab5sm1701605qvo.146.2023.11.04.08.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 08:13:11 -0700 (PDT)
Message-ID: <f3e284a2-c73f-fa97-d057-f0d954b9cba0@gmail.com>
Date: Sat, 4 Nov 2023 11:13:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] spl: fit: Load compressed blob to heap buffer
Content-Language: en-US
To: Loic Poulain <loic.poulain@linaro.org>, sjg@chromium.org, marex@denx.de
Cc: u-boot@lists.denx.de, abbaraju.manojsai@amarulasolutions.com
References: <20231103143426.3643712-1-loic.poulain@linaro.org>
 <20231103143426.3643712-3-loic.poulain@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231103143426.3643712-3-loic.poulain@linaro.org>
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
> CONFIG_SYS_LOAD_ADDR is usually configured as the address where
> the kernel should be loaded at. It can be problematic to use it
> as a generic temporary buffer for FIT compressed blobs.
> 
> An example is when the image is a compressed kernel with load
> address equal to CONFIG_SYS_LOAD_ADDR, this causes (inplace)
> decompression to fail.
> 
> Instead we can simply allocate a temporary buffer in the heap
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>   common/spl/spl_fit.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 08428660b0..8a807db5ba 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -249,7 +249,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   	ulong size;
>   	ulong load_addr;
>   	void *load_ptr;
> -	void *src;
> +	void *src, *src_ptr;
>   	ulong overhead;
>   	int nr_sectors;
>   	uint8_t image_comp, type = -1;
> @@ -289,8 +289,6 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   	}
>   
>   	if (external_data) {
> -		void *src_ptr;
> -
>   		/* External data */
>   		if (fit_image_get_data_size(fit, node, &len))
>   			return -ENOENT;
> @@ -302,10 +300,13 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   			return 0;
>   		}
>   
> -		if (image_comp != IH_COMP_NONE)
> -			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
> -		else
> +		if (image_comp != IH_COMP_NONE) {
> +			src_ptr = malloc_cache_aligned(len + 2 * info->bl_len);
> +			if (!src_ptr)
> +				return -ENOMEM;
> +		} else {
>   			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
> +		}
>   		length = len;
>   
>   		overhead = get_aligned_image_overhead(info, offset);
> @@ -383,6 +384,9 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   			image_info->entry_point = FDT_ERROR;
>   	}
>   
> +	if (external_data && image_comp != IH_COMP_NONE)
> +		free(src_ptr);
> +
>   	return 0;
>   }
>   

Why not use spl_simple_fit_read?

--Sean
