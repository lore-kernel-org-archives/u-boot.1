Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5938BCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB27848B4;
	Mon,  1 Jun 2026 15:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KSkXMV6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A739D848CF; Mon,  1 Jun 2026 15:34:50 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD90A848B4
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso2112801f8f.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780320886; x=1780925686; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QUM8i/DxMxY3gPB4VxZB0CXveOb8Pd4AqYAdS5sHmqQ=;
 b=KSkXMV6qKqaxPoHZQ6Q8fcarDCnpmvO3CRd3juIUxqx6M9l6evDpVtcHybPL+8LSe2
 zZtTyDVwLfVasTvEtbVZ4jrGTqu7ygWBFAf1/XWDqbWliMspTycf0Ca/WGW4IKLFe6z5
 kaoBh23rLCfGpEcQUSJK9MRVj2wur+uKD5GtVZXzPhhS0/n1MxnJQR8reWz8eXRQe3Y2
 H3vBzdboKlZKstG7KkN4HgyrXOvMJ/CkeebbbTKhpDwJLSPPX4U2DQaRoVuoVddRiw+e
 yvcsIjd5g5iNb7+GGljznvgT2j/5LJmnSZh0kqa14XFF24oDTF4jUOAJuBFPJ3xPaJ4E
 5qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320886; x=1780925686;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUM8i/DxMxY3gPB4VxZB0CXveOb8Pd4AqYAdS5sHmqQ=;
 b=rR6JOCxjpEb3KWmktOicKE0ztPVnAhoPtq+GvknNGd53eJa1dh5X7B5s+F0SYdnynX
 cKUyKSE9ISgKZZ7gyM4PiBDc6RY4HU3IW0Vtwg0kRHAQzFlhUJzkcZv9PTZ4QTjVTF+t
 ihTg+Skv22iMJuViOP8boob9TwRzfM6sP4D5jo72aEt0vpz+Curjw61Q8+sw8BbbNlKn
 +iEL3u6uycfZVuSUncYs/3Hifum0iUjlkusHTOOO/xn044TOVRJiNW6ns0rWPJCt4QvY
 fcXXKXwVS0luw+8mXx39DBNhSUXpHcupbD97dOZTp/Hmfp+abaZ2jvcLCAB+e+FgNc9t
 aqhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GKGQmVgF3+8CgkbjC6v0UfwstD5pjyS1onOMFxlSWoxQfiKm6p5Mp+18fSTMr1GafHnC5VDE=@lists.denx.de
X-Gm-Message-State: AOJu0YyMu//LnqH46uWwtBx3i/hsBIOk0K5mxmC2wsfRH9iYBzGKgIR3
 u/3VgVH9buPRhQAbxMLDKQi0tRCajOEIpmTtHq9tn1o99tD9TCqV17TCYYjfL6cygRY=
X-Gm-Gg: Acq92OFjDah0k5gSkY4vcoaaLTjl2ffUUDWe9WtLCm+zuU/cZIN17cVa3f/O9JdTq0k
 e+rj7sScx44EVVOrr/ZsHIq+hGxrbLVxyQqiOuXqxCISFQdWA9+EAqOl6laRgeoTqEPPlX7o9P2
 uCrTOCWyNHdauJ6PQXGppIReq2OV/5V21sYWgOHyZ/tjMqgcFe7P9iFBfHrAlRlZdp78ib2kUTN
 J4/TKqsSOrO+b6h9l3NF5D4hjz7C9GuKh6FHMLBNbMLciem8jXEj8z73akRXZ7CRmD+ugIKYkoG
 4RAspTaduMPnVjyzoGNCbNGnPOTaLomlphJuhoFz2fv0/DWpLDuIr56l1KShPce5nH0Q3ONdg6U
 GK9WNMjVsjAPg6rA8Zi0a7Wj3S69n4Y/FuwSzreWsaznZMnMT18PsEtmIWsMLEb1DzTLnUVwwyQ
 34SDfaDNg7fhu1bM3ctZwiuFlslJXoWlO/Hk0Dr563UI/gJr4NSp6202icjSMvSl5l0paVE2cTJ
 Xhmwow6WRURZKtn2pJSM2S3nIAL
X-Received: by 2002:a5d:49cb:0:b0:45e:ef2e:25a8 with SMTP id
 ffacd0b85a97d-45ef6b9a95bmr16137113f8f.32.1780320886077; 
 Mon, 01 Jun 2026 06:34:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5?
 ([2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35598e5sm23156875f8f.27.2026.06.01.06.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 06:34:45 -0700 (PDT)
Message-ID: <1dd56edf-3a30-4339-b895-582d7681b63a@linaro.org>
Date: Mon, 1 Jun 2026 15:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ufs: Expose selected UFS functions
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>, u-boot@lists.denx.de
References: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
 <20260601112606.2278753-2-raz.benyehuda@mobileye.com>
 <5712779c-353a-46cd-94b9-f49250556aaf@linaro.org>
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
In-Reply-To: <5712779c-353a-46cd-94b9-f49250556aaf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/1/26 15:33, Neil Armstrong wrote:
> On 6/1/26 13:26, Raz Ben Yehuda wrote:
>> Remove the static qualifier from selected functions to allow
>> future reuse.
>>
>> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
>> ---
>>   drivers/ufs/ufs-uclass.c | 18 +++++++++---------
>>   drivers/ufs/ufs.h        | 16 ++++++++++++++++
>>   2 files changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
>> index 6a51f337e47..78f6064ddea 100644
>> --- a/drivers/ufs/ufs-uclass.c
>> +++ b/drivers/ufs/ufs-uclass.c
>> @@ -757,7 +757,7 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
>>    *
>>    * Flush cache in aligned address..address+size range.
>>    */
>> -static void ufshcd_cache_flush(void *addr, unsigned long size)
>> +void ufshcd_cache_flush(void *addr, unsigned long size)
>>   {
>>       uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
>>       uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
>> @@ -1089,8 +1089,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
>>   /**
>>    * ufshcd_query_flag() - API function for sending flag query requests
>>    */
>> -static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>> -                 enum flag_idn idn, bool *flag_res)
>> +int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>> +              enum flag_idn idn, bool *flag_res)
>>   {
>>       struct ufs_query_req *request = NULL;
>>       struct ufs_query_res *response = NULL;
>> @@ -1320,9 +1320,9 @@ out:
>>   /**
>>    * ufshcd_query_descriptor_retry - API function for sending descriptor requests
>>    */
>> -static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
>> -                     enum desc_idn idn, u8 index, u8 selector,
>> -                     u8 *desc_buf, int *buf_len)
>> +int  ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
>> +                   enum desc_idn idn, u8 index, u8 selector,
>> +                   u8 *desc_buf, int *buf_len)
>>   {
>>       int err;
>>       int retries;
>> @@ -1457,9 +1457,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
>>    * ufshcd_read_desc_param - read the specified descriptor parameter
>>    *
>>    */
>> -static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
>> -                  int desc_index, u8 param_offset,
>> -                  u8 *param_read_buf, u8 param_size)
>> +int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
>> +               int desc_index, u8 param_offset,
>> +               u8 *param_read_buf, u8 param_size)
>>   {
>>       int ret;
>>       u8 *desc_buf;
>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
>> index 0f6c93fbce7..75b7ff83155 100644
>> --- a/drivers/ufs/ufs.h
>> +++ b/drivers/ufs/ufs.h
>> @@ -218,6 +218,9 @@ enum flag_idn {
>>       QUERY_FLAG_IDN_BUSY_RTC                = 0x09,
>>       QUERY_FLAG_IDN_RESERVED3            = 0x0A,
>>       QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE    = 0x0B,
>> +    QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN               = 0x0E,
>> +    QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN                = 0x0F,
>> +    QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8           = 0x10
>>   };
>>   /* Attribute idn for Query requests */
>> @@ -809,4 +812,17 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
>>   int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
>> +int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
>> +               int desc_index, u8 param_offset, u8 *param_read_buf,
>> +               u8 param_size);
>> +
>> +void ufshcd_cache_flush(void *addr, unsigned long size);
>> +
>> +int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>> +              enum flag_idn idn, bool *flag_res);
>> +
>> +int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
>> +                  enum desc_idn idn, u8 index, u8 selector,
>> +                  u8 *desc_buf, int *buf_len);
>> +
>>   #endif
> 
> This patch is useless, just merge with previous one, expose the functions directly.
> 
> Neil

Sorry I did not read correctly, this patch is fine, keep it.

Thanks,
Neil
