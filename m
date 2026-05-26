Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F97CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED768404D;
	Tue, 26 May 2026 08:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L41NGV/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D6F5846C0; Tue, 26 May 2026 08:59:23 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3343683EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso68718585e9.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779778759; x=1780383559; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=rVNitwiTI0jAjMG6gy9TRdjqI0rapxqwLHKJHcrJvVE=;
 b=L41NGV/wZJDOfHRpwTQaBEuPNmc91KKbu80UkNsV5UBfSFkgMZPqqemuZ8xpaFrW/1
 WbdmrPeg4PLt/MIGhwoMbn59S9qXsMK2e8gETMgFvpVPMgstdLCzg3k5Cwxmm4PHfyjW
 3KCxX3opa6W001d4HgkbdOzArqlx7xw5c0r3eIyGQJY0JYXXmEnMa1PluuZyFOiJqLJi
 bvMf6LZ5jj7WvQR6IiSh1drDKny/E98fx16YJr89gFpqjGDcvxK9OSgid1wXaIXsdqwu
 zdzio4qwH6ofB/jJS1IasFu5vqTkAOBGAnLwVIXSsQKfwURSnkOVXDP7xsmiePLCnI/T
 56KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778759; x=1780383559;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVNitwiTI0jAjMG6gy9TRdjqI0rapxqwLHKJHcrJvVE=;
 b=qYLpJb1tDlC1Irfgq+dKNB/PuHfQSJxjVFrrZaaa1YwE9rOfjUIS9GOElN3AAeU4oL
 ypf86FZQU7pNFif/anJ35IEyT4uLPZ2Pf1zSTKdYvQlf0OE8Pq8qyRBSDj44R800w+Eq
 Fc6C9ecDUHVhxJOZWbvtjDkVKjnpVQ7j9S9o1OIX59oBLvsBlcXnWbfjTvcyJI7SoD51
 zeEJ+pT3xGTkhNhrzyUHHbhSZCUZQj1Unv6D0cpfGVgmKXbfM4pg/kVtXO81hAjwzUH1
 jzlRj61nH1drfg6bTyz1YdatSgT5qZE3WJke+LFRFHZ3nKYapaut4Di2OIAOqHqwDPgc
 x6UA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WFOwGkdgHrasVeVvsOeeQLIrnb166KS9+7HzBeww/zmspyhV+AQuR3ngK1a6AUxVKr3+KBGw=@lists.denx.de
X-Gm-Message-State: AOJu0YwtDluuuGvpi+/3W99j2DDeVmP8IlKQUZVKvruikhtNNbGXi4V+
 Eib/vOpsXdEzw9nvoTmictl7Zs8CLrAvYBOTRYSNSwYBgggMo22Xw4zO1yeaU6PSvXg=
X-Gm-Gg: Acq92OGd0AS2Db2IpQto/K7z6caVg6auxkf1VXzhF9TJ2KiyeQTET5zIgelTtT21oag
 gwGNWTT8ad0TNDnHLMVETQhS5dxj/zrcDWBXO2RdvnHuiyo9IV+b5e9AvXP8v3e19WDWyQhzDdo
 8CfrM2lMu2Y3MCp7bV06dDnIjQvKRMr7LZc+5P8ZDfN3CGrtx16KZ192f0ZRFe0VtZJhDiQbPgQ
 i4pX0w7oSnf3OS1CQ0I2FW7N3qmjbdDPLe8k9aVZzjVUwz3J3h0Bxc5LsnbSzdBtrSta9FjKWMi
 LM8CDMY2a5Tdqy8zLDAahSiESk25tt/tduff07suepqMCmM5iZ/8vHYBlnJHyDv8fBK4R7iPXaX
 CL3I5G7suqJixQy9fGrSwquBNylgU4Xea5+55HwiFq2c2i1XN51YtWXL5NCwSFs77w997ftSTMc
 bl7hpZp25uyIfNU+CoRWWoepy69YYctJHZOIikkeW+CHmovAWL4a8F7z58gdljUdRxZd56M8AGu
 uqNolz9gIEEKJ7N4g==
X-Received: by 2002:a05:600c:3488:b0:490:6869:7d8b with SMTP id
 5b1f17b1804b1-49068697e08mr103266785e9.15.1779778759271; 
 Mon, 25 May 2026 23:59:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cce01asm34049039f8f.11.2026.05.25.23.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 23:59:18 -0700 (PDT)
Message-ID: <c1a34502-c259-47da-bf35-c333a6ab2b4d@linaro.org>
Date: Tue, 26 May 2026 08:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] nvme: fix dcache invalidation range in identify command
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20260519035608.15186-1-prashant.kamble223@gmail.com>
 <20260524100625.11135-1-prashant.kamble223@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260524100625.11135-1-prashant.kamble223@gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/24/26 12:06, Prashant Kamble wrote:
> When the identify buffer crosses a page boundary, PRP2 is used
> and dma_addr is advanced to the second page:
> 
>      dma_addr += (page_size - offset);
> 
> The subsequent invalidate_dcache_range() calls then use the
> modified dma_addr instead of the original buffer start address.
> 
> As a result, the beginning of the identify buffer is not
> invalidated and the invalidation range extends past the end of
> the buffer.
> 
> Fix this by preserving the original DMA buffer address for cache
> invalidation.
> 
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
> 
> ---
> v2:
> - Align invalidate range to cacheline boundaries
> - Add local helper function to calculate the invalidate range
> ---
>   drivers/nvme/nvme.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 0631b190b97..da7dad9f52b 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -27,6 +27,23 @@
>   #define IO_TIMEOUT		30
>   #define MAX_PRP_POOL		512
>   
> +/**
> + * nvme_invalidate_cache_aligned() - invalidate cache with proper alignment
> + *
> + * Aligns cache invalidation to cacheline boundaries to ensure correct
> + * behavior even when the DMA buffer is not aligned to page boundaries.
> + *
> + * @addr:	The start address of the buffer
> + * @length:	The length of the buffer in bytes
> + */
> +static inline void nvme_invalidate_cache_aligned(uintptr_t addr, int length)
> +{
> +	uintptr_t start_addr = addr & ~(ARCH_DMA_MINALIGN - 1);
> +	uintptr_t end_addr = ALIGN(addr + length, ARCH_DMA_MINALIGN);
> +
> +	invalidate_dcache_range(start_addr, end_addr);
> +}
> +
>   static int nvme_wait_csts(struct nvme_dev *dev, u32 mask, u32 val)
>   {
>   	int timeout;
> @@ -456,6 +473,7 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
>   	u32 page_size = dev->page_size;
>   	int offset = dma_addr & (page_size - 1);
>   	int length = sizeof(struct nvme_id_ctrl);
> +	dma_addr_t orig_dma_addr = dma_addr;
>   	int ret;
>   
>   	memset(&c, 0, sizeof(c));
> @@ -473,13 +491,13 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
>   
>   	c.identify.cns = cpu_to_le32(cns);
>   
> -	invalidate_dcache_range(dma_addr,
> -				dma_addr + sizeof(struct nvme_id_ctrl));
> +	nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
> +				      sizeof(struct nvme_id_ctrl));
>   
>   	ret = nvme_submit_admin_cmd(dev, &c, NULL);
>   	if (!ret)
> -		invalidate_dcache_range(dma_addr,
> -					dma_addr + sizeof(struct nvme_id_ctrl));
> +		nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
> +					      sizeof(struct nvme_id_ctrl));
>   
>   	return ret;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
