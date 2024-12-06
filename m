Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B0E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 08:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4849D8937D;
	Fri,  6 Dec 2024 09:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fGXc6rLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0942D89365; Fri,  6 Dec 2024 09:17:33 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7AA189498
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 09:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so163218f8f.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 00:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733473050; x=1734077850; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=JQ72ev8ZKBnMgmNOcUY1PtKHndg4+T/gRQBJ4OgNYcc=;
 b=fGXc6rLLKiH6hE3pLIV+Fjrq01U+07uPQwgrcEUGCIuY+n6d1BV53VJYguIW5t/kah
 WOSsRio1V5war4clUOlJi6CsW5zjdKgmfR0n1HNt2/fR3ziZ79IHM/uepXOJziAbOUuq
 9HwXGMT30ke0qKB4wNqM2uOkbUKtgbfjlLw6/VmfpayByEHH4+xvPpqa55MARPaZxdUW
 fhSJ/3k+8boI0lK/XZS1YYqKtd02y/DszmIYQUCguhPBxvc35lZNJpWurZlfg+dU5epw
 8uyflLxkrhYtZ8c7kmo4Tlz839VQJlOWP9ts6EQw2QTn+g5jnljTy24Qi8rIuEVVzkEo
 +hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733473050; x=1734077850;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JQ72ev8ZKBnMgmNOcUY1PtKHndg4+T/gRQBJ4OgNYcc=;
 b=YjnVfHEqDyGsx/6LuVGK/KzRI31eAyfuDIkYO+B5Wydv37aj1uJDIeAQ/82eaoR+fH
 h7YPH7t6Y/AHX5oL/u7ls3TFFGnDMOukKXZbZE+vXE/uYQNcZibU/lYGzVOpghz/4jk+
 cmjGpbqWBiMpaPvOJ4ZIj2BgTdFRpVuDX4U5OieIkiqto4jvJ7vKlD2hIckSSlksxXPr
 dlcp9knAjWqoN4Vnl5p24Fihijr+SxKRnl5EMhbYjR+JpGtF4F7szgF1z76fUCoC+/fp
 nBOSlro/nzEdJerPp/PenibDlaxHPDBvt02SU1NtMDN97MhVLUf2IKX+dzPXjW8OWmc/
 gCaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI2yxzgMgzUAS/PMj1rmHPcCmImrxaMGnGrEH+PT951/oPJfoisOAw7wi1tGKRvo2ERZSEx9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwO7mjIrAQN2Z1atYZr8nYFO/9XkNket4xrW8A++14sOwRj2YOe
 k1tJ91m3aOQrQa/RUvABh1Ec+SMtoT8sjVWdW8MDZQpwtl4lBlsVV0KD6IpNzHs=
X-Gm-Gg: ASbGncsASjPLfVVLlvNcGb8Hbj4eTnFEeq/O4Kx+ZcqVoEqfXiGNcibmfSaqSNr6Ga8
 h9H75qdgju4y5i+474sDg4N9Ole0SZS0R1DIfIRBaYq6Ldn7ggu1teVO+xDP2qgS98AIJXTdzd4
 nq1/ArMivgU0PbYlh+BsYNcqVlgx0jq+K1vgnaRBjQSNtAT8+5VX2lxApSaO9aG26JWvRLvCAXm
 FpzcqFHg9i3inqJ9GviU2Sg9Se3y4PlgC8vATdT9MOpvXV/ywHRIIFEHqsK+WhTFWbBfhu9OcY0
 YMS6ZecVMhXSBRxnpeElRlwyC1g=
X-Google-Smtp-Source: AGHT+IESgTQW2cYliCuB3zFCYdnuT3zgwDY5Z4+4gW+znihnMIQ3lxExbxm1aOQTz+LPU7S8mr7dnw==
X-Received: by 2002:a05:6000:178a:b0:385:fcaf:841 with SMTP id
 ffacd0b85a97d-3862a914a7bmr1396854f8f.23.1733473050169; 
 Fri, 06 Dec 2024 00:17:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:94d0:55af:a150:5d08?
 ([2a01:e0a:982:cbb0:94d0:55af:a150:5d08])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386221a62f2sm3972291f8f.105.2024.12.06.00.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:17:29 -0800 (PST)
Message-ID: <5ba31e11-cc45-4ecf-bbe5-95f061dfd860@linaro.org>
Date: Fri, 6 Dec 2024 09:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] ufs: core: mark unexported functions as static
To: Neha Malcom Francis <n-francis@ti.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <20241120-topic-ufs-cleanup-v1-2-a5cef54b1cdc@linaro.org>
 <5461b278-59ed-4ee5-a100-5cdf08f3df19@ti.com>
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
In-Reply-To: <5461b278-59ed-4ee5-a100-5cdf08f3df19@ti.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 06/12/2024 08:55, Neha Malcom Francis wrote:
> On 20/11/24 14:52, Neil Armstrong wrote:
>> Mark the remaining local functions as static to avoid build
>> warnings.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/ufs/ufs.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>> index 31c2959aeb12931b2bbdf26b3c676ae1a7b0fd1a..8a6c9f1e40b058dfd29bc07d011d576cdfc504cb 100644
>> --- a/drivers/ufs/ufs.c
>> +++ b/drivers/ufs/ufs.c
>> @@ -1035,8 +1035,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
>>   /**
>>    * ufshcd_query_flag() - API function for sending flag query requests
>>    */
>> -int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>> -              enum flag_idn idn, bool *flag_res)
>> +static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>> +                 enum flag_idn idn, bool *flag_res)
>>   {
>>       struct ufs_query_req *request = NULL;
>>       struct ufs_query_res *response = NULL;
>> @@ -1171,9 +1171,9 @@ out:
>>   /**
>>    * ufshcd_query_descriptor_retry - API function for sending descriptor requests
>>    */
>> -int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
>> -                  enum desc_idn idn, u8 index, u8 selector,
>> -                  u8 *desc_buf, int *buf_len)
>> +static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
>> +                     enum desc_idn idn, u8 index, u8 selector,
>> +                     u8 *desc_buf, int *buf_len)
>>   {
>>       int err;
>>       int retries;
>> @@ -1265,8 +1265,8 @@ static void ufshcd_init_desc_sizes(struct ufs_hba *hba)
>>    * ufshcd_map_desc_id_to_length - map descriptor IDN to its length
>>    *
>>    */
>> -int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
>> -                 int *desc_len)
>> +static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
>> +                    int *desc_len)
> 
> Isn't ufshcd_map_desc_id_to_length exported?

Indeed while not defined in any header, it has an EXPORT_SYMBOL, but it's a no-op in uboot...

So i'll need to drop this export.

> 
>>   {
>>       switch (desc_id) {
>>       case QUERY_DESC_IDN_DEVICE:
>> @@ -1309,9 +1309,9 @@ EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
>>    * ufshcd_read_desc_param - read the specified descriptor parameter
>>    *
>>    */
>> -int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
>> -               int desc_index, u8 param_offset, u8 *param_read_buf,
>> -               u8 param_size)
>> +static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
>> +                  int desc_index, u8 param_offset,
>> +                  u8 *param_read_buf, u8 param_size)
>>   {
>>       int ret;
>>       u8 *desc_buf;
>> @@ -1570,8 +1570,8 @@ static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
>>    * ufshcd_read_string_desc - read string descriptor
>>    *
>>    */
>> -int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>> -                u8 *buf, u32 size, bool ascii)
>> +static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>> +                   u8 *buf, u32 size, bool ascii)
>>   {
>>       int err = 0;
>> @@ -1882,7 +1882,7 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
>>       hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
>>   }
>> -int ufs_start(struct ufs_hba *hba)
>> +static int ufs_start(struct ufs_hba *hba)
>>   {
>>       struct ufs_dev_desc card = {0};
>>       int ret;
>>
> 

