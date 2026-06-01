Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A40FCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA18848A6;
	Mon,  1 Jun 2026 15:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l5DVj8Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F23848A5; Mon,  1 Jun 2026 15:33:54 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B743848A5
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso2112117f8f.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780320831; x=1780925631; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sv77lMMcBEDj7CR8jBhrnE+fqWSP34L02gGPz9cvJk8=;
 b=l5DVj8CxIP6oKHSxjSUFOxg85mW1h5SQJgE83gVeh1ReElvi+wC1x1OXaoi1s3S0BD
 UMuwK97qJKnw5WGr00oYwsryy4lMV9aSyAAtemsH9D/tFjSd90lFEm5HbwyMnn6L8CTk
 XKXAXE+a9oY/ZVEwrA0sljIsUvFyEsbumLYtz3QkSaLGfqUvzR8FBDH0f6tVOdJyqkMv
 Od4yMpuup+pxktuGApzy6Y3PocijJyFT7ewoKY0JQLxiPeLqtneEYtdO6l36bHoxUHLB
 DKa2Z1sXV0LBTS14ISdLFSku1ALtzCAQAOT6e6QBsSig/6UxWGP5rSucuK1zGtHgai6D
 KXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320831; x=1780925631;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sv77lMMcBEDj7CR8jBhrnE+fqWSP34L02gGPz9cvJk8=;
 b=tNc0hWc/3O+gZzSHhmFs6CZxqfnMNsSjLN1EZyLPTFU5HMvYR1pctURxlWqR9870Rs
 pAybyI25GzKNU4RDJVn7IEiRKbVzm5vv3cYwrBL+b2FHGQaSyjH1KroHCn3cvRjU6u+C
 90lxF5WLbA1yjy65gb3bxMT2RZqFOCe/urZgGulGBfjwkA9O8H+bdf7b3Yv+5SHYZgyM
 MK2Gczd+xOdpnPfPEdy5iKrOOctI3Fjsku5OS9j/hvT9/ZsmLdUxA9C1S04UFily4wlu
 Ya77t0AAbp9zldw7ha21YfVP6dLAg0WdWC7Qp7hziiL0O2/esv7Pt+RTSGjamgkbsgy4
 1huw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Dv+60Wm9Cl2qnS1Sx16XCHbOXvIPER4w8j2/5E7zoTdiFuc3V+dekt5nCsYp4wLGEWOqY0no=@lists.denx.de
X-Gm-Message-State: AOJu0Yzk82XhSAfVilJIDSrgZ3n790mJw7b4LeY+2jInX+TqGiB3wczy
 B9yQWvt0HVk2807y28W7wnL+XrB9AW9nv4AeAgw5411v2LQlxBx7y6nB+BAniHaGL30BNB7V+Y0
 eTKPKGAk=
X-Gm-Gg: Acq92OHSx60LCm1s8A6WIPyYrdYA7xbhavcd6QbwLdfsmrQp0mK1KsqY5I/4EQxMk65
 EZSUs42OdGhbLzQGbCqdGAjHeE4ZkC1W3H6Xm/xhJbfZk3oWu8oTbz+APQAQivSWdZOyQXqIXhL
 9Ub9UMrCupQmFkixUdmmkzs0pTUmwbd6X/xGxeOKxWL4Be4iT8g/TdwXF4Acm3w/mWHtNCg/v74
 D4IYvebrwN+CrhDxPS4bw7y1Gf0J6U+u5tI9W+0qY5p5zd9p0sN6B3ZymJnf0Nl+tGecscbbcXj
 H3qDxixN8QWY852kFSSpTDBNXZDc9J3usIc5WyJ0UEerlfxAKhygua2ppGdAG0GCvBhkjvi92mj
 M8+fniPXFBC8UFD/6dnobguSjXIV+To2y0TUq+848eberA9hSqGz7WxUucjBmg4Iwkf8GDCBKdC
 tCtNLaD0gN+qfIRewh+MnEon3lqjgpru0HvV6q91UDl9B23puAe0Et4mC30DvfuyE3JtRwtS8vu
 1gvJ5gD3jLk8koK6A==
X-Received: by 2002:adf:e990:0:b0:45e:73a5:e5e4 with SMTP id
 ffacd0b85a97d-45ef6ba0b7dmr14839602f8f.33.1780320830933; 
 Mon, 01 Jun 2026 06:33:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5?
 ([2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a0374sm22984743f8f.2.2026.06.01.06.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 06:33:50 -0700 (PDT)
Message-ID: <5712779c-353a-46cd-94b9-f49250556aaf@linaro.org>
Date: Mon, 1 Jun 2026 15:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ufs: Expose selected UFS functions
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>, u-boot@lists.denx.de
References: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
 <20260601112606.2278753-2-raz.benyehuda@mobileye.com>
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
In-Reply-To: <20260601112606.2278753-2-raz.benyehuda@mobileye.com>
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

On 6/1/26 13:26, Raz Ben Yehuda wrote:
> Remove the static qualifier from selected functions to allow
> future reuse.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   drivers/ufs/ufs-uclass.c | 18 +++++++++---------
>   drivers/ufs/ufs.h        | 16 ++++++++++++++++
>   2 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6a51f337e47..78f6064ddea 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -757,7 +757,7 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
>    *
>    * Flush cache in aligned address..address+size range.
>    */
> -static void ufshcd_cache_flush(void *addr, unsigned long size)
> +void ufshcd_cache_flush(void *addr, unsigned long size)
>   {
>   	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
>   	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
> @@ -1089,8 +1089,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
>   /**
>    * ufshcd_query_flag() - API function for sending flag query requests
>    */
> -static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> -			     enum flag_idn idn, bool *flag_res)
> +int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> +		      enum flag_idn idn, bool *flag_res)
>   {
>   	struct ufs_query_req *request = NULL;
>   	struct ufs_query_res *response = NULL;
> @@ -1320,9 +1320,9 @@ out:
>   /**
>    * ufshcd_query_descriptor_retry - API function for sending descriptor requests
>    */
> -static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
> -					 enum desc_idn idn, u8 index, u8 selector,
> -					 u8 *desc_buf, int *buf_len)
> +int  ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
> +				   enum desc_idn idn, u8 index, u8 selector,
> +				   u8 *desc_buf, int *buf_len)
>   {
>   	int err;
>   	int retries;
> @@ -1457,9 +1457,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
>    * ufshcd_read_desc_param - read the specified descriptor parameter
>    *
>    */
> -static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
> -				  int desc_index, u8 param_offset,
> -				  u8 *param_read_buf, u8 param_size)
> +int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
> +			   int desc_index, u8 param_offset,
> +			   u8 *param_read_buf, u8 param_size)
>   {
>   	int ret;
>   	u8 *desc_buf;
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 0f6c93fbce7..75b7ff83155 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -218,6 +218,9 @@ enum flag_idn {
>   	QUERY_FLAG_IDN_BUSY_RTC				= 0x09,
>   	QUERY_FLAG_IDN_RESERVED3			= 0x0A,
>   	QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE	= 0x0B,
> +	QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN               = 0x0E,
> +	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN                = 0x0F,
> +	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8           = 0x10
>   };
>   
>   /* Attribute idn for Query requests */
> @@ -809,4 +812,17 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
>   
>   int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
>   
> +int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
> +			   int desc_index, u8 param_offset, u8 *param_read_buf,
> +			   u8 param_size);
> +
> +void ufshcd_cache_flush(void *addr, unsigned long size);
> +
> +int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> +		      enum flag_idn idn, bool *flag_res);
> +
> +int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
> +				  enum desc_idn idn, u8 index, u8 selector,
> +				  u8 *desc_buf, int *buf_len);
> +
>   #endif

This patch is useless, just merge with previous one, expose the functions directly.

Neil
