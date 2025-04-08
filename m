Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A40C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9606820F8;
	Tue,  8 Apr 2025 16:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yY0OZZUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FC582102; Tue,  8 Apr 2025 16:52:30 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C0B820EB
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso41742695e9.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744123947; x=1744728747; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=GimhJJiMcDHK6VGU3VHlsastU0uZIGe1E0xq91DmK9w=;
 b=yY0OZZUb16ZWNkTDto32bGO4UXrXuv8tcjFKVfYhOVymvVuC1pmpz/sa/q8KVZ63bS
 aujFJK4ef7+ujGeTZlbJ4+7yUzsMBAmVGhQ6w1Q6G92NjL2bpt1AyRuzW2CS/xuav/T/
 IjlsIOcRFwUfGVqDvTtrbOefg+XqhIFjAI9/KGSAjpUbE9hqRyk9iv/ZrUlrBZ1z9EG7
 OUdu4Cd4NYSNecnEVTh3bTCk+XHAUMJ0cEhS6IAiGHuSCydMsB74UkhucRUuqxI/cmmR
 hzUISqFWFu4lfZ2u6aleM42FFtSXPuNo8pzaTu800JdJjAGN8M11Zmu4q5YGURnTHDHv
 nhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744123947; x=1744728747;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GimhJJiMcDHK6VGU3VHlsastU0uZIGe1E0xq91DmK9w=;
 b=LSpzPUTX4iJIE4cDqwnn75kKjWpRLkO0sCvwJi5j+rlbUkC4JHCy69xaKvhJC51b3o
 KFCJevM/7BAWdPx0Cszm8rTlkcvYRWuDC9iXb9ie6/i+uQXQ+EOYqah5Isvjr7IvDNH5
 RKabh4rn2UwgFCO9xTXP5gW4+TOfzhrZAsWEbq28x+krqOjv/jOShYoFEFEt1upF8513
 O1IyZIL8PoAMnxYUkz+zkjB7xvXr0wS1Yni4MmV69EkjR0gWabebDtuAiOhboAWYlcTW
 Jcw1qIJWXhpOofYKbNlh9NiELNFUhFMi8/qZs/D0ojeKa/RwE7E7X7izrDVfavglwd67
 hWzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1RIbhC771Z6zoDcckCOE+Y632fF77oVJW20Kkf1kRZSejL4V7otgXe5pEswN6p1J2L9gUjIU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0MD3MRFzTxldIrHCfl5WOitAKN65OBLrrL/A5ZT803kFEvASx
 HvFNgWhPUaW3MuBO14ibEeZCcFObxip1Sh36ACRMVbB0tf4RXzPnSJMkZd7v5AY=
X-Gm-Gg: ASbGncuCqv1mL/E5MOMiBV3vMxqI+Am72PhYUPyDcKFwW8mwGSMruwSd8e0RWyKQPE4
 uv+QI5q46L0uUvpP95jWbk9ktMh/ZZEkq8zJWFnbjX6bkb16VMIovaibj+C0ipfh/8JexsSHfmM
 6noGjdqrSfBe/jM6+eoLkTOEEjna9bvCuaDIZbdsDuKWu2P7KEKDP0kg9vqx1FrzZ0warW5yfFO
 17zZ/rtCbUD4gDRt5ZFfpyV6YVyoP381f3Lz3rXeFsNF32Ez52uUOZ71XWWqSG6cuG6o7DM5Ncs
 BUA3KVFdrRV4DprICD8DW+VZyU7fwIsHPfe1QNekYrDncjUHXFAzPgq3FPFe+Rk5rFziWWkkj5Q
 +AbyMXflt67zDq0eSn9f1kw==
X-Google-Smtp-Source: AGHT+IHXLHoyF0pyqrsQV5SO4EvwQguCbU8ny5JkZC29be4vwgvH/kzZIMJnqCoUdEzv1aSav60xcA==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43ecfa06fd2mr198409925e9.30.1744123947463; 
 Tue, 08 Apr 2025 07:52:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71?
 ([2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630de9sm165904965e9.1.2025.04.08.07.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 07:52:27 -0700 (PDT)
Message-ID: <c3bc727d-ff39-4117-bac7-86c73ac69557@linaro.org>
Date: Tue, 8 Apr 2025 16:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/3] part: efi: add GPT PTE cache used with
 part_get_info_cached() API
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
 <20250408-topic-gpt-cache-v2-2-de76e47debb7@linaro.org>
 <0e1b03c0-fb81-478e-a800-0653801a2f5d@gmx.de>
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
In-Reply-To: <0e1b03c0-fb81-478e-a800-0653801a2f5d@gmx.de>
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

On 08/04/2025 12:57, Heinrich Schuchardt wrote:
> On 08.04.25 11:13, Neil Armstrong wrote:
>> Implement a simple cache for part_efi to be used by the newly
>> introduced part_get_info_cached() API.
>>
>> The cache simply stores a successfully scanned GPT PTE if called
>> from the part_get_info_cached() ops, and will return the cached
>> data if the blk_desc and lba offset matches, invalidating the
>> cache if not.
>>
>> The cache will only operate if called from the part_get_info_cached()
>> API, all the over calls will operate uncached, making sure we
>> can still update & re-scan the GPT partitions like before.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   disk/part_efi.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 96 insertions(+), 18 deletions(-)
>>
>> diff --git a/disk/part_efi.c b/disk/part_efi.c
>> index 932d058c184ce6946b7142e7c2d9637b28e4661e..949968fcd30fc18766a023e73f43ca1381dcef89 100644
>> --- a/disk/part_efi.c
>> +++ b/disk/part_efi.c
>> @@ -55,12 +55,58 @@ static inline u32 efi_crc32(const void *buf, u32 len)
>>   static int pmbr_part_valid(struct partition *part);
>>   static int is_pmbr_valid(legacy_mbr * mbr);
>>   static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>> -            gpt_entry **pgpt_pte);
>> +            gpt_entry **pgpt_pte, bool cache);
>>   static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
>>                        gpt_header *pgpt_head);
>>   static int is_pte_valid(gpt_entry * pte);
>>   static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
>> -              gpt_entry **pgpt_pte);
>> +              gpt_entry **pgpt_pte, bool cache);
>> +
> 
> Please, describe the structure and its members.

Ack

> 
> https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation
> 
>> +static struct gpt_pte_cache_data {
>> +    struct blk_desc *desc;
>> +    u64 lba;
>> +    gpt_entry *gpt_pte;
>> +    gpt_header gpt_head;
>> +} gpt_pte_cache;
>> +
> 
> Please, describe all functions.

Ack

> 
>> +static void clear_gpt_pte_cache(void)
>> +{
>> +    if (gpt_pte_cache.desc) {
>> +        if (gpt_pte_cache.gpt_pte)
>> +            free(gpt_pte_cache.gpt_pte);
>> +
>> +        memset(&gpt_pte_cache, 0, sizeof(gpt_pte_cache));
>> +    }
>> +}
>> +
>> +static void cache_gpt_pte(struct blk_desc *desc, u64 lba,
>> +              gpt_entry *gpt_pte, gpt_header *pgpt_head)
>> +{
>> +    if (gpt_pte_cache.gpt_pte)
>> +        free(gpt_pte_cache.gpt_pte);
>> +
>> +    gpt_pte_cache.desc = desc;
>> +    gpt_pte_cache.lba = lba;
>> +    gpt_pte_cache.gpt_pte = gpt_pte;
>> +    if (pgpt_head)
>> +        memcpy(&gpt_pte_cache.gpt_head, pgpt_head, sizeof(gpt_header));
>> +}
>> +
>> +static gpt_entry *get_cached_gpt_pte(struct blk_desc *desc, u64 lba,
>> +                     gpt_header *pgpt_head)
>> +{
>> +    if (gpt_pte_cache.desc && gpt_pte_cache.gpt_pte) {
>> +        if (gpt_pte_cache.desc == desc &&
>> +            gpt_pte_cache.lba == lba) {
>> +            memcpy(pgpt_head, &gpt_pte_cache.gpt_head, sizeof(gpt_header));
>> +            return gpt_pte_cache.gpt_pte;
>> +        }
>> +
>> +        clear_gpt_pte_cache();
>> +    }
>> +
>> +    return NULL;
>> +}
>>
>>   static char *print_efiname(gpt_entry *pte)
>>   {
>> @@ -205,7 +251,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>>       unsigned char *guid_bin;
>>
>>       /* This function validates AND fills in the GPT header and PTE */
>> -    if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
>> +    if (find_valid_gpt(desc, gpt_head, &gpt_pte, false) != 1)
>>           return -EINVAL;
>>
>>       guid_bin = gpt_head->disk_guid.b;
>> @@ -224,7 +270,7 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
>>       unsigned char *uuid;
>>
>>       /* This function validates AND fills in the GPT header and PTE */
>> -    if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
>> +    if (find_valid_gpt(desc, gpt_head, &gpt_pte, false) != 1)
>>           return;
>>
>>       debug("%s: gpt-entry at %p\n", __func__, gpt_pte);
>> @@ -258,8 +304,13 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
>>       return;
>>   }
>>
>> -static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>> -                        struct disk_partition *info)
>> +static void __maybe_unused part_get_info_cache_free_efi(struct blk_desc *desc)
>> +{
>> +    clear_gpt_pte_cache();
>> +}
>> +
>> +static int _part_get_info_efi(struct blk_desc *desc, int part,
>> +                  struct disk_partition *info, bool cache)
>>   {
>>       ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
>>       gpt_entry *gpt_pte = NULL;
>> @@ -271,13 +322,14 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>>       }
>>
>>       /* This function validates AND fills in the GPT header and PTE */
>> -    if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
>> +    if (find_valid_gpt(desc, gpt_head, &gpt_pte, cache) != 1)
>>           return -EINVAL;
>>
>>       if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
>>           !is_pte_valid(&gpt_pte[part - 1])) {
>>           log_debug("Invalid partition number %d\n", part);
>> -        free(gpt_pte);
>> +        if (!cache)
>> +            free(gpt_pte);
>>           return -EPERM;
>>       }
>>
>> @@ -307,11 +359,23 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>>       log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
>>             info->size, info->name);
>>
>> -    /* Remember to free pte */
>> -    free(gpt_pte);
>> +    if (!cache)
>> +        free(gpt_pte);
>>       return 0;
>>   }
>>
>> +static int __maybe_unused part_get_info_cached_efi(struct blk_desc *desc, int part,
>> +                           struct disk_partition *info)
>> +{
>> +    return _part_get_info_efi(desc, part, info, true);
>> +}
>> +
>> +static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>> +                        struct disk_partition *info)
>> +{
>> +    return _part_get_info_efi(desc, part, info, false);
>> +}
>> +
>>   static int part_test_efi(struct blk_desc *desc)
>>   {
>>       ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, legacymbr, 1, desc->blksz);
>> @@ -689,7 +753,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
>>        */
>>       if (is_gpt_valid(desc,
>>                GPT_PRIMARY_PARTITION_TABLE_LBA,
>> -             gpt_head, gpt_pte) != 1) {
>> +             gpt_head, gpt_pte, false) != 1) {
>>           log_debug("Invalid GPT\n");
>>           return -1;
>>       }
>> @@ -706,7 +770,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
>>       }
>>
>>       if (is_gpt_valid(desc, (desc->lba - 1),
>> -             gpt_head, gpt_pte) != 1) {
>> +             gpt_head, gpt_pte, false) != 1) {
>>           log_debug("Invalid Backup GPT\n");
>>           return -1;
>>       }
>> @@ -765,9 +829,9 @@ int gpt_repair_headers(struct blk_desc *desc)
>>       int ret = -1;
>>
>>       is_gpt1_valid = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
>> -                     gpt_h1, &gpt_e1);
>> +                     gpt_h1, &gpt_e1, false);
>>       is_gpt2_valid = is_gpt_valid(desc, desc->lba - 1,
>> -                     gpt_h2, &gpt_e2);
>> +                     gpt_h2, &gpt_e2, false);
>>
>>       if (is_gpt1_valid && is_gpt2_valid) {
>>           ret = 0;
>> @@ -1023,12 +1087,13 @@ static int is_pmbr_valid(legacy_mbr *mbr)
>>    * lba is the logical block address of the GPT header to test
>>    * gpt is a GPT header ptr, filled on return.
>>    * ptes is a PTEs ptr, filled on return.
>> + * cache is a bool, true to use the cached gpt_pte from previous call
> 
> "use the cache" or "use cached GPT if available"?
> 
> It remains unclear what will happen if cache=1 and no entry is found.

Ack, will clarify

> 
> Best regards
> 
> Heinrich
> 
>>    *
>>    * Description: returns 1 if valid,  0 on error, 2 if ignored header
>>    * If valid, returns pointers to PTEs.
>>    */
>>   static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>> -            gpt_entry **pgpt_pte)
>> +            gpt_entry **pgpt_pte, bool cache)
>>   {
>>       /* Confirm valid arguments prior to allocation. */
>>       if (!desc || !pgpt_head) {
>> @@ -1036,6 +1101,12 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>>           return 0;
>>       }
>>
>> +    if (cache) {
>> +        *pgpt_pte = get_cached_gpt_pte(desc, lba, pgpt_head);
>> +        if (*pgpt_pte)
>> +            return 1;
>> +    }
>> +
>>       ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, desc->blksz);
>>
>>       /* Read MBR Header from device */
>> @@ -1081,6 +1152,9 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>>           return 0;
>>       }
>>
>> +    if (cache)
>> +        cache_gpt_pte(desc, lba, *pgpt_pte, pgpt_head);
>> +
>>       /* We're done, all's well */
>>       return 1;
>>   }
>> @@ -1090,23 +1164,25 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>>    *
>>    * gpt is a GPT header ptr, filled on return.
>>    * ptes is a PTEs ptr, filled on return.
>> + * cache if a bool, use cached GPT if available
>>    *
>>    * Description: returns 1 if found a valid gpt,  0 on error.
>>    * If valid, returns pointers to PTEs.
>>    */
>>   static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
>> -              gpt_entry **pgpt_pte)
>> +              gpt_entry **pgpt_pte, bool cache)
>>   {
>>       int r;
>>
>>       r = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
>> -             pgpt_pte);
>> +             pgpt_pte, cache);
>>
>>       if (r != 1) {
>>           if (r != 2)
>>               log_debug("Invalid GPT\n");
>>
>> -        if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte)
>> +        if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte,
>> +                 true)
>>               != 1) {
>>               log_debug("Invalid Backup GPT\n");
>>               return 0;
>> @@ -1210,6 +1286,8 @@ U_BOOT_PART_TYPE(a_efi) = {
>>       .name        = "EFI",
>>       .part_type    = PART_TYPE_EFI,
>>       .max_entries    = GPT_ENTRY_NUMBERS,
>> +    .get_info_cache_free    = part_get_info_ptr(part_get_info_cache_free_efi),
>> +    .get_info_cached    = part_get_info_ptr(part_get_info_cached_efi),
>>       .get_info    = part_get_info_ptr(part_get_info_efi),
>>       .print        = part_print_ptr(part_print_efi),
>>       .test        = part_test_efi,
>>
> 

