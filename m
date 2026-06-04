Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E0ECD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499FD8490B;
	Thu,  4 Jun 2026 14:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R6lcEouB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D7A8490B; Thu,  4 Jun 2026 14:47:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1522D84931
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 14:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso5503785e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780577236; x=1781182036; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=rpXK/Nf8+NJGpjRGop0ypcNXBgRJC39yKPrYSTGK2Kw=;
 b=R6lcEouBH9kTa+AMRFLAI/WT7H1fkkVxkuqMZN1P65UyYFn5C/n9gZRUkCEoKTPDWt
 Me3Gos615KDpouCDT2AahtlHpI1Va/AJUFAxbI1eRt6fGtERKRrCPVHZRUbiWwY7xRBH
 mBxbpwnk9M52Gt+FYJ0JyT+OBVgVviVQbfB67SDl4/GUN+9eu6Lf7zRxCADtxn8X4Ih0
 +2qJAVwgovVp/IThQlmQa/aHxEMZECUWigeLdvtt7eeeSKOrM8Ev5QBvhWZkOR+u4OGf
 2TzjtSdAPDYGbtH3mM1OrdyWV1WmrPiTNscohYTpay5eUybpvumQ1fs3rKAye4TE2rOK
 MKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577236; x=1781182036;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpXK/Nf8+NJGpjRGop0ypcNXBgRJC39yKPrYSTGK2Kw=;
 b=pJlwyMG5GOAioETL+5FWfUZ59VzEn7yegDeodZcWr9/L8/4F651Xr4CvIbrPLm5ZcP
 xg3nw3BPmPkSVMQXfvSvxr815bX61QWcp/jZAQcjXC04rnGGjEf/btQUot93d/hvkFtl
 1sKsWJi1+yUsN57zZ8Ll6srRWCL7WmjbiRF/qFC1EZhPnOr59xlTQiIhClZNKuPFKSoB
 P5jebgTW4i//BOFsvT2hGEAOWEcfN+0uZo7ey48M3kTZNVrdHHuyZA8OU8HqOoAMRHvt
 Zbf6+hsqmBYGH1EEblC1UJUCfx5k43QGihVWTdHdj1OM2N+/jO4POfuZ6X6Bn08YWVm2
 1gqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iCeqw6Sy+Apnk4e6fx6IlPQzby/GbGz1lO3c1f2RHmeAgX5lL4zk1DsWr6Kai/QBwQhfL1Kg=@lists.denx.de
X-Gm-Message-State: AOJu0YySDP6QGzg3IHofb01ptMNoTLG3Xh9qmTUG4g/sjOSUVLFkb1FG
 Vs/kj75+i7CZnFpjg5sTxkiYKLfUmF9Jua0mFc1JTrl3TXac/hF2X8nJl1YDVIs3/QE=
X-Gm-Gg: Acq92OGqURHX4RriFPztVIePxkibR2YF3UBp6Wz1jmfseNnasyVKrHX7lm6XOsJVnps
 CeCrjC/E7vxVUnevArikXfBWA8hBh21v+7LksVKdyhFsarhMbBUK+01piOMjuEAtkXJqLCIySIp
 RgOicJDH8jx7ivZNhPpZ9UB61f5bhA+q+iKlGGORYRv0joq3upRa2wewf3m1luR308z8VdjnzUb
 IK2lASuBd+0rplT53VsA6KD48C6+lcfKiwBIqTUIdEpmHpuBhU0niClH0UjXVQNjrXG8jQ+m7oe
 otjueeu1ghPbU9+bxDIy99UbupTyh8sJ2O0bkpJbPUqLjDg8ycx3q22We4DbHPwJQYiIiYCS+ih
 +ejTmfZCnt05r0wpoic4Cdq748gHWoQLUVQDA4vrjybjW2sGzOoteqgf5GBQrqI8gz0fhK3S+QV
 +C5FzrUyoshuhyEP2Cu8ilrSQ99NtF7XEGD6T3jJ1vtwVc+cdC/M8Z3fDnMRVmeBZ8t8p3SvsCo
 B+Z8K8v16R/7y0=
X-Received: by 2002:a05:600c:3487:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-490b5e57944mr128781115e9.22.1780577236331; 
 Thu, 04 Jun 2026 05:47:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fd663sm77572305e9.10.2026.06.04.05.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:47:16 -0700 (PDT)
Message-ID: <1a356fb3-0093-4c25-a59c-2ead6507bb22@linaro.org>
Date: Thu, 4 Jun 2026 14:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH PATCHSET 3/6] ufs: Expose selected UFS functions
To: raz.benyehuda@mobileye.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
 <20260604-ufs_tool-v1-3-741ed00232c0@mobileye.com>
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
In-Reply-To: <20260604-ufs_tool-v1-3-741ed00232c0@mobileye.com>
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

On 6/4/26 13:25, Raz Ben Yehuda via B4 Relay wrote:
> From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
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

Those should be added in a separate patch.

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
> 

