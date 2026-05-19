Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DC2CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 07:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C4684659;
	Tue, 19 May 2026 09:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dOZ3E9sG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A938467A; Tue, 19 May 2026 09:16:51 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6228460E
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so22418725e9.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779175008; x=1779779808; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=n0WmX2t9xP8c00OWl2oEvKK4TMNQxwZHEx1uhzJ7+wk=;
 b=dOZ3E9sGjtNfT1EuQ5JbFgbid3aQmAVIe6HQeX8ZKA4j/1lTbHY1pZs3+H7wRZAiBa
 re6GIIMkgGvCXOlBdIJ/k0k24hhYjMaSqjd4RSpW8Ifhxp4YgI/qmwFmQ567SoQCHc9X
 XyyJ/iwOSKLN2KDpZ5PUgsmjVfX/7SUmDmgrE5VXW5N5ALw/lJYS9d9Sa0bY9YdOc7rn
 SaO0KyCwDC36+NPtPQeUZ0H2fl54ExyckYVWlMWHObQ9mbWWB64YLxQfnqMua+UrgRI+
 XA1iP7hbPPM1sDAaWxmFLTCwkSqKa3ucfTJ/KrIs7qvXYtk0YglODdZONEGwi2QdX5zF
 RyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175008; x=1779779808;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0WmX2t9xP8c00OWl2oEvKK4TMNQxwZHEx1uhzJ7+wk=;
 b=pO/cD8+F2Kw6wl4kF4X7KmJpWiCU7jKO71T704cNZYRcQFQWZr13LrxdDHpbw5EneF
 XOD6FxSJX0ligbUU7gNRx0Fa4VV3pmHLhv+pA8HmQ+oc4bzwv+yYmMcPQUVvE7I3TA0r
 NvNsIPA5ypHZePEN2pwdbNLGeSiI9XatLV9EKwLAt3VEDa49oWmd+RqsmbTYYOVsPxJq
 +LhA/Nb9enfg8ZxxnjHhmEYrB2cHk2GPnqVSFVDa5ATBTylSuuONTLyywKmGt+0ktyFX
 UfMsL2l2m0I3iQHs/TyW2GtSlHpcnfmuS79ZeCH862h+rqe/P/JMGbbvtuigCNiENTQ1
 2dKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qyFXq5gg3fWeoEdm+bCPGEN/K8vNfteFu6PUvI9BSIDNu8X73Czuou1lFxQwCyxgUpRI4om4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw22uqgRcRGBdyOPmn5bqZB1O/NjNmSHh0HSLri/T+6+PjFZCGA
 AAlJyJwpuJdF76IkoL+n5SbJ+uu1YycJKmjwe+lMV8FJwAlG5SmyDauFVR+Pdg+MTlk=
X-Gm-Gg: Acq92OGoTKYPcQE8NwvsEW3udqfPxIMUqqfI02ESc0f7sJIkBuiVKhjjebkSTMDtKmo
 0h4wuhH+cCsavKpmQrkrl2FTMViluit9AOd+kSJOE8oq58zbFGbHFKCHw6myB8idiR1oSZbSeeg
 1bCpYoc8O+Jpr9ylRdLMML+v3X1B/Ds717aIC+LNWjOBcIe68FaX/PYA+qZus9w0QEB2jha9N3F
 ulA8Nls9KeHYqeRYkoX0IQQQMg4FxjqkHx/BlhI5dCP86cYve8RjSbIyYgzJ142/+0s2wzW+vmU
 ref6IOipRrIFiEr71OxebijGzlhdLy1hAaVGBUDgHKWlwlXLq1uVfhScX2EmnDWIJBarrN5oDIP
 Ms2QKq4akwF4CtX+xJU5aGR/rPfW3elExMCNyT9ANcMQo1VyKO2CZpuUXO3YsiIJHZhVBV7NBc1
 9V6Kip2v1h6sMMjN6vGaQ4wimJI3ENFSGyy6YWfsPKosCwF+Y2bNZOkqaTfQuAJP1YYknan3fMF
 q5n
X-Received: by 2002:a05:600c:c4a7:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48fe539519dmr271789485e9.14.1779175008036; 
 Tue, 19 May 2026 00:16:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm348383945e9.9.2026.05.19.00.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:16:47 -0700 (PDT)
Message-ID: <dd2da23f-bad2-4c24-9997-3f4adc456be4@linaro.org>
Date: Tue, 19 May 2026 09:16:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix dcache invalidation range in identify command
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20260519035608.15186-1-prashant.kamble223@gmail.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260519035608.15186-1-prashant.kamble223@gmail.com>
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

On 5/19/26 05:56, Prashant Kamble wrote:
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
> Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
> ---
>   drivers/nvme/nvme.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 4f9473367d3..298010de536 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -456,6 +456,7 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
>   	u32 page_size = dev->page_size;
>   	int offset = dma_addr & (page_size - 1);
>   	int length = sizeof(struct nvme_id_ctrl);
> +	dma_addr_t orig_dma_addr = dma_addr;
>   	int ret;
>   
>   	memset(&c, 0, sizeof(c));
> @@ -473,13 +474,13 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
>   
>   	c.identify.cns = cpu_to_le32(cns);
>   
> -	invalidate_dcache_range(dma_addr,
> -				dma_addr + sizeof(struct nvme_id_ctrl));
> +	invalidate_dcache_range(orig_dma_addr,
> +				orig_dma_addr + sizeof(struct nvme_id_ctrl));
>   
>   	ret = nvme_submit_admin_cmd(dev, &c, NULL);
>   	if (!ret)
> -		invalidate_dcache_range(dma_addr,
> -					dma_addr + sizeof(struct nvme_id_ctrl));
> +		invalidate_dcache_range(orig_dma_addr,
> +					orig_dma_addr + sizeof(struct nvme_id_ctrl));

The fix is good, but I think this is not enough, the page_size used in this function is
the NVMe page_size, not the host CPU cacheline size, so the dma_addr could not be aligned
on a proper page boundary and the invalidate op could be a no-op.

The proper way to do that is like I added into dwc3:
static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
{
	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);

	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
}

Neil

>   
>   	return ret;
>   }

