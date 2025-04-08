Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DDAC369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4E482102;
	Tue,  8 Apr 2025 16:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NUe9VhAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E5C832F7; Tue,  8 Apr 2025 16:51:46 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1EF80107
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso32375425e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744123904; x=1744728704; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=S8crVkFymNGFCms6yS7jWXwWa90ouTTrMZB8I3sVju4=;
 b=NUe9VhAUQOU6chg+anY7NQx7FLy+sTFkPDoovOrl3OZfUgoKJla+/1F+kFH5JUtAVC
 6y3KrtaigwWVk9kuoTTPN7h8Au3/LavCK+PduPydRPIRL2uXv6D1/bqR1oh0oVJhPDLs
 WInvJFumfDfa5LBQWLKu3+HNKVrWtE/x+V7kU/E2pD7QSnbDfOb2xa5mJ6eMw6n7xRKc
 D6W5KGWBf6n0onO9EPKPVgokfjzzWKvEZlOrOW/rzIFv9Xr70W3cq9R7qRfwZPzSE3JH
 9jlmzr/nbkQiFLhQ6bY2/MEthrLGkJr3NhaRUaDuM7SVNuqaEplsuwIH/UYKUBtWSxKY
 K2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744123904; x=1744728704;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S8crVkFymNGFCms6yS7jWXwWa90ouTTrMZB8I3sVju4=;
 b=S2v5ucB7sj+jL1CyDEW5evc9Aug3ddle1o9jIJ0BFPHM7NH+b/7mBO9yq28oZ93mKH
 t1ksSRfAoWXLQiJ0uDFQC2bHHd/rwXt8LoegHrBXhl7MSf8uaSrnv7aqhxKZBDCt+VQw
 JgiXMtzhrbfhuq0Jx89nx+6fek37hwHkThxYYX2ZfNxhruzQyytLIFqATHICzMeDFJju
 Z10KBA2EwK93cT+Fk7OOgR5fQ8n69azNUP85B1AxTQjII1ouQQ9KDYrCWpvA3pDHWn5g
 7AqH5oHlqVUNGsnMzjCdaQDP90HngJpbKV1PrDkDirtAV2iBQb2KM44V8GcT+HRuiC5C
 T8YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUow6ZXSO9LEW8JxQQZisL1TzhPkCMwwOJDv8iXidNglbgjE1pTQf7V3NlKNfy1d8VLmWhuiEo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+XJ6Tu5240Im7ytnA7ncmNf8fskLZFnbYqKs5ugxZb9D8/ArP
 jAe8HRnnZPURhqEBsdGbT/McFr/T+5iT02rKaaBWyiHaU+t2KtWklD9M/+aFRq0/GJB34bxYA10
 T
X-Gm-Gg: ASbGncuhd/gnUtuR3dxFLT89xhkdop1x85ro6b8ApnmawJzh1vaZMEYG6Z7fFrA8JbR
 1tZkjgwnZB57p4FoB1HmQMKMIzpS2jfKqYFeZ56+N0X8VJMDmJ/ZtaUbBGELbimrRSHLdDWBl2x
 2ekKNIR6uX4HNo+dfAY1xF4CzrHbvSXUGgP9Nm6YzND3ZZDayvzH9wRxTBds13qodHPYva/ssMD
 sSY8YPzv69ExVi3lex3hiU3n6TeQExYhckleniJXRnP7ZsaKRxej8CwIQDmBAwdQT2qvWhSFk7b
 Ul7Y0IgjTaFuCi8I2LDM1f7CH0dc6nRlg5MGW4U1iCmxHsfXGp87Qpfdz9m/gkaaXKwjNeLO9Eb
 lFAI8kydvN+KcPzO1ye1p5A==
X-Google-Smtp-Source: AGHT+IHQ56ZB1PFuop6cnaCqinxnnzYoc5BC4onYqQnFb/9FoSAQdwPWnN3g/IqlZY4esqsXnYx6rA==
X-Received: by 2002:a05:600c:3eca:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-43ee0660808mr115718315e9.11.1744123903766; 
 Tue, 08 Apr 2025 07:51:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71?
 ([2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a9da1sm14861852f8f.22.2025.04.08.07.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 07:51:43 -0700 (PDT)
Message-ID: <ea8947b7-5558-4c6d-aadd-e003f33ce5c5@linaro.org>
Date: Tue, 8 Apr 2025 16:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/3] part: add part_get_info_cached() API
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
 <20250408-topic-gpt-cache-v2-1-de76e47debb7@linaro.org>
 <613a0f69-0fc6-4861-90a8-760f4c516a1a@gmx.de>
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
In-Reply-To: <613a0f69-0fc6-4861-90a8-760f4c516a1a@gmx.de>
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

On 08/04/2025 11:55, Heinrich Schuchardt wrote:
> On 08.04.25 11:13, Neil Armstrong wrote:
>> Introduce a new part_get_info_cached() API that's used to
>> get the part_info of a blk_desc allowing to use an eventual
>> partition scanning cache to avoid rescanning the entire disk
>> partition scheme for each partition number.
>>
>> The part_get_info_cached_free() is also added to hint the
>> partition code to flush any cached data from this disk.
>>
>> The equivalent ops are added that directly maps to those
>> added functions.
>>
>> This API is designed to be used as a direct replacement of
>> part_get_info() in codes scanning all partitions for a same
>> disk, like in blk-uclass. With this, a lot of unnecessary
>> computation is saved, leading to a faster boot time when
>> partitions are scanned, especially with storage medias
>> with potentially multiple large hardware partitions like
>> UFS, NVMe or eMMC.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   disk/part.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++-----------
>>   include/part.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 88 insertions(+), 11 deletions(-)
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 303178161c083ec6e1b767b4f06ac5773576ca60..1d09c0511c75d457c81cab040c3f5caa924ee945 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -335,8 +335,8 @@ void part_print(struct blk_desc *desc)
>>           drv->print(desc);
>>   }
>>
>> -int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>> -              struct disk_partition *info)
> 
> Thank you, Neil, for pushing this forward.
> 
> All functions deserve a description.

Sure

> 
>> +static int _part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>> +                  struct disk_partition *info, bool cached)
>>   {
>>       struct part_driver *drv;
>>
>> @@ -356,24 +356,57 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>>                     desc->part_type);
>>               return -EPROTONOSUPPORT;
>>           }
>> -        if (!drv->get_info) {
>> -            PRINTF("## Driver %s does not have the get_info() method\n",
> 
> Writing to the console creates screen havoc in EFI applications. Please,
> use log_debug() instead of PRINTF().
> 
> And, please, remove that noisy '## '. It carries no information.

Right, those were already present, I'll add a cleanup patch before.

Thx,
Neil

> 
> Best regards
> 
> Heinrich
> 
>> -                   drv->name);
>> -            return -ENOSYS;
>> -        }
>> -        if (drv->get_info(desc, part, info) == 0) {
>> -            PRINTF("## Valid %s partition found ##\n", drv->name);
>> -            return 0;
>> +        if (cached && drv->get_info_cached) {
>> +            if (drv->get_info_cached(desc, part, info) == 0) {
>> +                PRINTF("## Valid %s partition found ##\n", drv->name);
>> +                return 0;
>> +            }
>> +        } else {
>> +            if (!drv->get_info) {
>> +                PRINTF("## Driver %s does not have the get_info() method\n",
>> +                       drv->name);
>> +                return -ENOSYS;
>> +            }
>> +            if (drv->get_info(desc, part, info) == 0) {
>> +                PRINTF("## Valid %s partition found ##\n", drv->name);
>> +                return 0;
>> +            }
>>           }
>>       }
>>
>>       return -ENOENT;
>>   }
>>
>> +int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>> +              struct disk_partition *info)
>> +{
>> +    return _part_get_info_by_type(desc, part, part_type, info, false);
>> +}
>> +
>> +int part_get_info_cached(struct blk_desc *desc, int part,
>> +             struct disk_partition *info)
>> +{
>> +    return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, true);
>> +}
>> +
>>   int part_get_info(struct blk_desc *desc, int part,
>>             struct disk_partition *info)
>>   {
>> -    return part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info);
>> +    return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, false);
>> +}
>> +
>> +void part_get_info_cached_free(struct blk_desc *desc)
>> +{
>> +    struct part_driver *drv;
>> +
>> +    if (blk_enabled()) {
>> +        drv = part_driver_lookup_type(desc);
>> +        if (!drv)
>> +            return;
>> +        if (!drv->get_info_cache_free)
>> +            return;
>> +        drv->get_info_cache_free(desc);
>> +    }
>>   }
>>
>>   int part_get_info_whole_disk(struct blk_desc *desc,
>> diff --git a/include/part.h b/include/part.h
>> index fcb3c13dea4de6346ad98d6ce320ef36747dda85..8c98865146306fb66509576068c45de01b9cedb6 100644
>> --- a/include/part.h
>> +++ b/include/part.h
>> @@ -216,6 +216,34 @@ struct blk_desc *mg_disk_get_dev(int dev);
>>    */
>>   int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>>                 struct disk_partition *info);
>> +
>> +/**
>> + * part_get_info_cached() - Get partitions from a block device but save the
>> + * disk partition map between different partitions.
>> + *
>> + * Call to part_get_info_cached_free() is required when scanning of the
>> + * block device is finished.
>> + *
>> + * If the partition driver doesn't support cached part_info, the
>> + * normal part_info will be called instead.
>> + *
>> + * @desc:    Block device descriptor
>> + * @part:    Partition number to read
>> + * @info:    Returned partition information
>> + *
>> + * Return: 0 on success, negative errno on failure
>> + */
>> +int part_get_info_cached(struct blk_desc *desc, int part,
>> +             struct disk_partition *info);
>> +
>> +/**
>> + * part_get_info_cached_free() - Free the saved disk partition map
>> + * from a previous call of part_get_info_cached().
>> + *
>> + * @desc:    Block device descriptor
>> + */
>> +void part_get_info_cached_free(struct blk_desc *desc);
>> +
>>   int part_get_info(struct blk_desc *desc, int part,
>>             struct disk_partition *info);
>>   /**
>> @@ -463,6 +491,22 @@ struct part_driver {
>>       int part_type;
>>       /** @max_entries:    maximum number of partition table entries */
>>       const int max_entries;
>> +    /**
>> +     * @cache_free_cache_free:    Free any parsing data stored from get_info_cached()
>> +     *
>> +     * @get_info_cache_free.desc:    Block device descriptor
>> +     */
>> +    void (*get_info_cache_free)(struct blk_desc *desc);
>> +    /**
>> +     * @get_inf_cachedo:        Get information about a partition, and save
>> +     *                the resulting parsing data for the next partition.
>> +     *
>> +     * @get_info_cached.desc:    Block device descriptor
>> +     * @get_info_cached.part:    Partition number (1 = first)
>> +     * @get_info_cached.info:    Returns partition information
>> +     */
>> +    int (*get_info_cached)(struct blk_desc *desc, int part,
>> +                   struct disk_partition *info);
>>       /**
>>        * @get_info:        Get information about a partition
>>        *
>>
> 

