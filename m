Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF78FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574B18144A;
	Fri, 28 Mar 2025 14:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wJCEUnjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB11C81DCC; Fri, 28 Mar 2025 14:50:54 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECEF8070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1753251f8f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743169852; x=1743774652; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3FbXWOjImTIHNfKd2Yu0YRpiPfxpxV4rZTLule6ybiA=;
 b=wJCEUnjfJi5d88ke5tviWVnrNEqOM/BBJ6rcnHeCflIm+gY5KYa37mUP2kKuaILOpF
 A4pcxQ4WUhx3MOcXCiGMrA9ogSe9s11BItEB96arGqbbAjommZh344jDRvMYKY5ZfxxA
 Dv0znKPE6AFCsZTD5+N9NwZMpAblr/UM8fAeS141enJKf99b6DznlaLm/hyoxs1kGT9I
 tp5PPrx4cUNbBOQiX6hYacVIqkBh2V+ljMzRAUmoT8FH2mnftThPVPpIqtJDO4tccNj3
 tGtZZulcWIObee23iVe2MQcMQrjXPAaSwPYZD/NKOrKRU4NWJxqVE6EYhChpXDklaFQ2
 SZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743169852; x=1743774652;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3FbXWOjImTIHNfKd2Yu0YRpiPfxpxV4rZTLule6ybiA=;
 b=evCMBu17HkHSKuDBYjbodxVDalLaEpeb3cWSs2E8nnzG/FoEeNA2rJ48TSLu39lU+H
 gFHZVdmfA9MK4IQ+JUb+ZWUkH9kHxiXv3MpwhRb45Fe45D/YUQXUCe3wxHaTYj5FWAxD
 lKIJCOhBfqejVAbJx33fl9hGQalt3dRQcrsB453kJGxRvDy+KQvGd31XP6Rkzb/9Hpea
 Xdw+hwUrkvgwSCCASVgOEdHB2CmP+rlwNlmZ0E3ab6OXEtWoh2viTn1xMPkwKZ/4nvwv
 1ZoDJRG+PDUTVMlkLmeE1xo63YVAJq+bViy4c3BS4Yt/At0U1Am9ISJqVh2M7lEdF8mA
 pKeg==
X-Gm-Message-State: AOJu0YwHfhDuBDaW3w+tYpP3P2Dg3u01nhRyRZ0S/TfJOW+PbUoX3LjT
 etU2VLkkvALywvnmnNTGw+abF2IQoPAstQ2J1WkRRLuMMslXaLRyDYVQR5Ll3Cs=
X-Gm-Gg: ASbGncv62Q4cAfKOzuD8t0MSJkRa/Zb7/mVJUAaJu9pa8EykaUacxkACvA+l7kKgsmm
 tkPO/RAnRG0Ggelej6LgLpTUutXTPJpGikGXTs2jTJXWXwQlaRxeUn7ytkFv6AtW1HAdUAIprQE
 KIWZSZJKZR5zx5EUMESzHfyIFiDTpB26LFxOOe1fGtm287aaattglIfE3p3Vt4QCo1r01U22aIZ
 5h3dzKI028om2HcxtU+0NyF2eQADcXvIcM1IXo2iLHfQbTNn8V7AxB+OvFnGBOnaatRreuni/wo
 LzUKCWC2zdMkiXVmWr4SR/18E1K2vozMNJbu6Akhy6sWyZ1evpQpQK+EvyzIYzVotrGkssxo/JY
 anBj9dxinwzuCJl/j+BAErg==
X-Google-Smtp-Source: AGHT+IEgmrMhQUK2HdMzHr5ghL2QGohzYP3oGJJZWzkrM/EZ0YPT8O65OM2bNTUWvIY0ORb6+Cj2Lg==
X-Received: by 2002:adf:9dcd:0:b0:39c:dfa:ca71 with SMTP id
 ffacd0b85a97d-39c0dfacd5cmr1356274f8f.49.1743169851518; 
 Fri, 28 Mar 2025 06:50:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:20e7:3609:7781:1686?
 ([2a01:e0a:3d9:2080:20e7:3609:7781:1686])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d914f1561sm16967085e9.1.2025.03.28.06.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 06:50:51 -0700 (PDT)
Message-ID: <0b673689-0383-4ae4-9029-e11ecb0a136b@linaro.org>
Date: Fri, 28 Mar 2025 14:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] part_efi: cache last scanned GPT for next partition
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250327-u-boot-efi-part-cache-v1-1-be6b69c0698b@linaro.org>
 <53E9363D-6499-4512-B204-83729DF88BD7@gmx.de>
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
In-Reply-To: <53E9363D-6499-4512-B204-83729DF88BD7@gmx.de>
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

On 27/03/2025 20:01, Heinrich Schuchardt wrote:
> Am 27. März 2025 11:02:55 MEZ schrieb Neil Armstrong <neil.armstrong@linaro.org>:
>> The actual architecture of the EFI part parser means the
>> entire GPT partition table needs to be parsed for each
>> part_info() callback.
>>
>> Since the default part scan code will always scan up to
>> 128 partitions for a block, and devices with an UFS chip
>> with up to 8 LUNs are very common in the field, this means
>> a complete GPT parsing and validation will be done
>> up to 1024 times instead of 8 on such devices.
>>
>> The GPT parsing can be cached between each part_info()
>> call speed up to 3x on the worse condition when the CPU
>> i-cache and d-cache are disabled, like in the SPL.
>>
>> The implementation does caching each time a correct GPT
>> has been parsed and verified and will match the blk_desc
>> and LBA to serve the cached data or force a re-parsing.
>>
>> In order to allow GPT manipulation, some of the calls
>> ignores the cache and some will discard the cached data.
>>
>> On the SM8650 QRD platform with a KIOXIA THGJFJT1E45BATPC
>> configured with 8 LUNs, the scsi scan takes 0.2s with both
>> CPU caches enabled, but when disabling both CPU caches it
>> goes up to 4s to do the full scan of all 8 LUN partitions.
>>
>> With this change the scan takes only 0.18s with both CPU
>> caches enabled running 1.1x times faster, and with both CPU
>> caches disabled the full scan takes only 1.27s running
>> 3x faster.
>>
>> While 20ms could look negligeable, it's still a 20ms gain
>> in the boot flow and a non negligeable reduction in
>> calculation and memory allocation since for each scan
>> it would allocate and free the gpt_pte table up to
>> 1024 times, now it would only do 8 allocations, reducing
>> memory fragmentation.
> 
> Could you, please, describe when you clear the cache. I would think of:
> 
> * Media change
> * Updating partition table (mbr and gpt commands)
> * Any raw write to sector < 35
> 
> I cannot see any of this implemented.

The partition update cache clear is implemented, but not the others
because it would need some invasive hooks from the blk layer.

This caching is really only needed from part_create_block_devices(),
for the other get_info calls we could re-scan the GPT since we
really want to speed-up the nomimal use-case, i.e. booting,
we can disable caching for all the other operations.

So perhaps adding a part_info() callback bool to allow
using cached data ?

Neil

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> disk/part_efi.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++----------
>> 1 file changed, 77 insertions(+), 16 deletions(-)
>>
>> diff --git a/disk/part_efi.c b/disk/part_efi.c
>> index 932d058c184ce6946b7142e7c2d9637b28e4661e..4f02fabe265ce5ca4c8f55e41768a95582022e21 100644
>> --- a/disk/part_efi.c
>> +++ b/disk/part_efi.c
>> @@ -55,13 +55,59 @@ static inline u32 efi_crc32(const void *buf, u32 len)
>> static int pmbr_part_valid(struct partition *part);
>> static int is_pmbr_valid(legacy_mbr * mbr);
>> static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>> -			gpt_entry **pgpt_pte);
>> +			gpt_entry **pgpt_pte, bool cache);
> 
> Please, provide Sphinx style function documentation describing all parameters.
> 
>> static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
>> 					 gpt_header *pgpt_head);
>> static int is_pte_valid(gpt_entry * pte);
>> static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
>> 			  gpt_entry **pgpt_pte);
>>
>> +static struct gpt_pte_cache_data {
> 
> Please, provide Sphinx style documentation for the structure and its elements.
> 
> 
>> +	struct blk_desc *desc;
>> +	u64 lba;
>> +	gpt_entry *gpt_pte;
>> +	gpt_header gpt_head;
>> +} gpt_pte_cache;
>> +
>> +static void clear_gpt_pte_cache(void)
>> +{
> 
> Add function documentation for all changed function interfaces.
> 
> Besr regards
> 
> Heinrich
> 
>> +	if (gpt_pte_cache.desc) {
>> +		if (gpt_pte_cache.gpt_pte)
>> +			free(gpt_pte_cache.gpt_pte);
>> +
>> +		memset(&gpt_pte_cache, 0, sizeof(gpt_pte_cache));
>> +	}
>> +}
>> +
>> +static void cache_gpt_pte(struct blk_desc *desc, u64 lba,
>> +			  gpt_entry *gpt_pte, gpt_header *pgpt_head)
>> +{
>> +	if (gpt_pte_cache.gpt_pte)
>> +		free(gpt_pte_cache.gpt_pte);
>> +
>> +	gpt_pte_cache.desc = desc;
>> +	gpt_pte_cache.lba = lba;
>> +	gpt_pte_cache.gpt_pte = gpt_pte;
>> +	if (pgpt_head)
>> +		memcpy(&gpt_pte_cache.gpt_head, pgpt_head, sizeof(gpt_header));
>> +}
>> +
>> +static gpt_entry *get_cached_gpt_pte(struct blk_desc *desc, u64 lba,
>> +				     gpt_header *pgpt_head)
>> +{
>> +	if (gpt_pte_cache.desc && gpt_pte_cache.gpt_pte) {
>> +		if (gpt_pte_cache.desc == desc &&
>> +		    gpt_pte_cache.lba == lba) {
>> +			memcpy(pgpt_head, &gpt_pte_cache.gpt_head, sizeof(gpt_header));
>> +			return gpt_pte_cache.gpt_pte;
>> +		}
>> +
>> +		clear_gpt_pte_cache();
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> static char *print_efiname(gpt_entry *pte)
>> {
>> 	static char name[PARTNAME_SZ + 1];
>> @@ -211,8 +257,6 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>> 	guid_bin = gpt_head->disk_guid.b;
>> 	uuid_bin_to_str(guid_bin, guid, UUID_STR_FORMAT_GUID);
>>
>> -	/* Remember to free pte */
>> -	free(gpt_pte);
>> 	return 0;
>> }
>>
>> @@ -252,9 +296,6 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
>> 		uuid = (unsigned char *)gpt_pte[i].unique_partition_guid.b;
>> 		printf("\tguid:\t%pUl\n", uuid);
>> 	}
>> -
>> -	/* Remember to free pte */
>> -	free(gpt_pte);
>> 	return;
>> }
>>
>> @@ -277,7 +318,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>> 	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
>> 	    !is_pte_valid(&gpt_pte[part - 1])) {
>> 		log_debug("Invalid partition number %d\n", part);
>> -		free(gpt_pte);
>> 		return -EPERM;
>> 	}
>>
>> @@ -307,8 +347,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>> 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
>> 		  info->size, info->name);
>>
>> -	/* Remember to free pte */
>> -	free(gpt_pte);
>> 	return 0;
>> }
>>
>> @@ -382,6 +420,9 @@ int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
>> 					   * sizeof(gpt_entry)), desc);
>> 	u32 calc_crc32;
>>
>> +	/* Clean cache */
>> +	clear_gpt_pte_cache();
>> +
>> 	debug("max lba: %x\n", (u32)desc->lba);
>> 	/* Setup the Protective MBR */
>> 	if (set_protective_mbr(desc) < 0)
>> @@ -620,6 +661,9 @@ int gpt_restore(struct blk_desc *desc, char *str_disk_guid,
>> 	gpt_entry *gpt_e;
>> 	int ret, size;
>>
>> +	/* Clean cache */
>> +	clear_gpt_pte_cache();
>> +
>> 	size = PAD_TO_BLOCKSIZE(sizeof(gpt_header), desc);
>> 	gpt_h = malloc_cache_aligned(size);
>> 	if (gpt_h == NULL) {
>> @@ -689,7 +733,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
>> 	 */
>> 	if (is_gpt_valid(desc,
>> 			 GPT_PRIMARY_PARTITION_TABLE_LBA,
>> -			 gpt_head, gpt_pte) != 1) {
>> +			 gpt_head, gpt_pte, false) != 1) {
>> 		log_debug("Invalid GPT\n");
>> 		return -1;
>> 	}
>> @@ -706,7 +750,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
>> 	}
>>
>> 	if (is_gpt_valid(desc, (desc->lba - 1),
>> -			 gpt_head, gpt_pte) != 1) {
>> +			 gpt_head, gpt_pte, false) != 1) {
>> 		log_debug("Invalid Backup GPT\n");
>> 		return -1;
>> 	}
>> @@ -764,10 +808,13 @@ int gpt_repair_headers(struct blk_desc *desc)
>> 	int is_gpt1_valid, is_gpt2_valid;
>> 	int ret = -1;
>>
>> +	/* Clean cache */
>> +	clear_gpt_pte_cache();
>> +
>> 	is_gpt1_valid = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
>> -				     gpt_h1, &gpt_e1);
>> +				     gpt_h1, &gpt_e1, false);
>> 	is_gpt2_valid = is_gpt_valid(desc, desc->lba - 1,
>> -				     gpt_h2, &gpt_e2);
>> +				     gpt_h2, &gpt_e2, false);
>>
>> 	if (is_gpt1_valid && is_gpt2_valid) {
>> 		ret = 0;
>> @@ -906,6 +953,9 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
>> 	lbaint_t lba;
>> 	int cnt;
>>
>> +	/* Clean cache */
>> +	clear_gpt_pte_cache();
>> +
>> 	if (is_valid_gpt_buf(desc, buf))
>> 		return -1;
>>
>> @@ -1023,12 +1073,13 @@ static int is_pmbr_valid(legacy_mbr *mbr)
>>   * lba is the logical block address of the GPT header to test
>>   * gpt is a GPT header ptr, filled on return.
>>   * ptes is a PTEs ptr, filled on return.
>> + * cache is a bool, true to use the cached gpt_pte from previous call
>>   *
>>   * Description: returns 1 if valid,  0 on error, 2 if ignored header
>>   * If valid, returns pointers to PTEs.
>>   */
>> static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>> -			gpt_entry **pgpt_pte)
>> +			gpt_entry **pgpt_pte, bool cache)
>> {
>> 	/* Confirm valid arguments prior to allocation. */
>> 	if (!desc || !pgpt_head) {
>> @@ -1036,6 +1087,12 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>> 		return 0;
>> 	}
>>
>> +	if (cache) {
>> +		*pgpt_pte = get_cached_gpt_pte(desc, lba, pgpt_head);
>> +		if (*pgpt_pte)
>> +			return 1;
>> +	}
>> +
>> 	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, desc->blksz);
>>
>> 	/* Read MBR Header from device */
>> @@ -1081,6 +1138,9 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>> 		return 0;
>> 	}
>>
>> +	if (cache)
>> +		cache_gpt_pte(desc, lba, *pgpt_pte, pgpt_head);
>> +
>> 	/* We're done, all's well */
>> 	return 1;
>> }
>> @@ -1100,13 +1160,14 @@ static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
>> 	int r;
>>
>> 	r = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
>> -			 pgpt_pte);
>> +			 pgpt_pte, true);
>>
>> 	if (r != 1) {
>> 		if (r != 2)
>> 			log_debug("Invalid GPT\n");
>>
>> -		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte)
>> +		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte,
>> +				 true)
>> 		    != 1) {
>> 			log_debug("Invalid Backup GPT\n");
>> 			return 0;
>>
>> ---
>> base-commit: 4adbf64ff8d8c730223fd8ae299d770bebb6fe86
>> change-id: 20250327-u-boot-efi-part-cache-ddc1499c3ef6
>>
>> Best regards,
> 

