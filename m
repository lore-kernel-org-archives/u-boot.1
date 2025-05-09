Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DB0C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175FC8295C;
	Fri,  9 May 2025 14:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gYGtS2DY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DAF38210D; Fri,  9 May 2025 12:52:21 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6FEC8059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 12:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso18205425e9.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746787938; x=1747392738; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JrdwOn3ZgLk9k6PJAfmU4GTzt2MlKP+s/RBsxOAu78s=;
 b=gYGtS2DYju9OFLdhaUUUt11RLhb5Whv/dkcXpGW+kAcQeHe+aI8730Mfn+wsHj3a8D
 D9Wv8L0kj0OSOQBFM0mqrg9G/cusqKLrE4kry4Y6qbUi3pUn4A0VKJzo/4uw+KahV9D7
 OP9FP+0HHv6RlJgcvv07qtNzeBjjp0Akt0j5XBxWTry+ltynjuaTb4y9RVEimG7PIpw1
 3CEVTJttOfTTF/9RXqgKhQtHvQt/n4pf8s/c8k6QmZCqBLM/UKZXLyRiyAS0804TXtZl
 w0n6EB7Qbuk6o+TYSg3I4Dz+GKihR6h1jDHMG6w16G2r7bxUQcCc2veB7SW0uvPj9dJS
 O6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746787938; x=1747392738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrdwOn3ZgLk9k6PJAfmU4GTzt2MlKP+s/RBsxOAu78s=;
 b=lktkYCzHqyJR1tdJ+0u++5yzVk9sMFKPMHIEzwww0zDBCPJi6rDrhNW9aZfSHWlz8q
 EPkTVQElX7bB9vPa7VFqKvsy5TceBi4N0pBCAqid/7ZyC2nlE6w8aT6NkyxyNU9feISP
 iWJvX5/nzkfZ62lRXrzejdRO2DY6qr4t0loGMAaBsBbASM2MnLtJxY+da4QxUUwL22lW
 o3wBzqOi8nWIhGEry80eLZjY9HJyphJCOl8M/sY22Poeo0UE/nGBBrw23ed6A34T6tHy
 jQS97cYvKltzOFZ7qJBWPwELoZyvXsYRTlv0x9us6dMijQVTJK/xEJ3BMddvi0OXL33K
 bGcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnTOFFhwxcqIf07Vrb1fEJ2V/Ml+wkess1ZS4lQ6Tqx4YdSxyp4++dgkes4pLJZrwLu2mFR8A=@lists.denx.de
X-Gm-Message-State: AOJu0YyfqhWOb0CSsoe7quNiozDr+kawDE3qRnmLA9HAwXU5vDOgRa4G
 rwEdaO6IYDGS6on51MoVcmwCgXoemsg5aMotXzUhsT41xsySRVdt5MOY5eWVBaY=
X-Gm-Gg: ASbGncv63c+jK2lvzKBkRaJC/lq6uwokZyQ+TNCadkRBOHoqiPCZ9hXv47tbq1bCvpV
 FMHw1LgzAJ/loXcHLkj34CybQTlsXnQExHkihM1F/IqqERhW+h2L6C5IhS1t4ayaxjxgUhFSiyh
 e2hOftbKpgbfuDlKeHOfutqrokTYpq86YI4JKZmsVWSsqxn0aPJvU0TPXf6AXfQW9gw0LLlbm1o
 cBoqE9G1mZbCrH1qYygxAvUdkV9gpujJBj47iWBG4Upd+i8dzoTi31/bofibf0TvyuKjjEcWijL
 Ak/ncGR4lBUG9xMj8vFjEQ9tUsSCvfIGHpMvpiiYqXlFVObZkR4mgLAttAl/7kjdfE8EY+P3r0M
 U1D7QXITWnsMKMw==
X-Google-Smtp-Source: AGHT+IHTqvfpr+G+mLit5/UHCEivaXbHxuOqfOAn1gG6FcC2U3y6BmZTyRldlvdJ+RoWhP/zxSmPoA==
X-Received: by 2002:a05:600c:35c2:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-442d6de4e91mr25585885e9.31.1746787938149; 
 Fri, 09 May 2025 03:52:18 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d14e6d74sm58419655e9.21.2025.05.09.03.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:52:17 -0700 (PDT)
Message-ID: <739a6552-1aa5-47be-a3d0-0895b00773aa@linaro.org>
Date: Fri, 9 May 2025 12:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] disk: part: implement generic function
 part_get_info_by_uuid()
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, avromanov@salutedevices.com,
 michael@amarulasolutions.com, hs@denx.de, sjg@chromium.org,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, xypron.glpk@gmx.de,
 cniedermaier@dh-electronics.com, ansuelsmth@gmail.com,
 venkatesh.abbarapu@amd.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
 <20250507112812.3066301-2-quic_varada@quicinc.com>
 <16a681a0-e272-4a41-8391-75135959ad00@linaro.org>
 <20250508052344.53pafaulmuu674f3@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508052344.53pafaulmuu674f3@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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



On 5/8/25 07:23, Varadarajan Narayanan wrote:
> On Wed, May 07, 2025 at 01:47:40PM +0200, Casey Connolly wrote:
>> Hi Varadarajan,
>>
>> On 5/7/25 13:28, Varadarajan Narayanan wrote:
>>> Add function to search for a partition by UUID as partition
>>> names may not be unique.
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>>    disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
>>>    include/part.h | 20 ++++++++++++++++++++
>>>    2 files changed, 57 insertions(+)
>>>
>>> diff --git a/disk/part.c b/disk/part.c
>>> index 303178161c0..abae79a55a7 100644
>>> --- a/disk/part.c
>>> +++ b/disk/part.c
>>> @@ -698,6 +698,43 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
>>>    	return -ENOENT;
>>>    }
>>> +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>>> +			  struct disk_partition *info)
>>> +{
>>> +#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
>>
>> Please refer to checkpatch output (the b4 tool will run this for you
>> automatically).
> 
> Ok
> 
>> 	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
>> 		return -ENOENT;
>>
>>> +	struct part_driver *part_drv;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	part_drv = part_driver_lookup_type(desc);
>>> +	if (!part_drv)
>>> +		return -1;
>>> +
>>> +	if (!part_drv->get_info) {
>>> +		log_debug("## Driver %s does not have the get_info() method\n",
>>> +			  part_drv->name);
>>> +		return -ENOSYS;
>>> +	}
>>> +
>>> +	for (i = 1; i < part_drv->max_entries; i++) {
>>> +		ret = part_drv->get_info(desc, i, info);
>>> +		if (ret != 0) {
>>> +			/*
>>> +			 * Partition with this index can't be obtained, but
>>> +			 * further partitions might be, so keep checking.
>>> +			 */
>>> +			continue;
>>
>> For part_efi (which is the only one relevant here I think?) you can check
>> for -EPERM which signals the end of the partition list I believe. Then we
>> aren't calling get_info() 128 times for every LUN...
> 
> This is a replica of part_get_info_by_name() - [1]. Not sure why it has
> it that way and didn't want to miss corner cases (if any). Please let
> me know if still you would prefer to change to check for -EPERM.

Unfortunately the get_info callback doesn't document the return value :(

I think it would be nice to clean this up, and document a return value 
for get_info to save a bit of time but I guess this is fine with the API 
being so poorly defined :(

Kind regards,>
> Thanks
> Varada
> 
> 1 - https://source.denx.de/u-boot/u-boot/-/blob/master/disk/part.c?ref_type=heads#L685
> 
>> +		}
>>> +
>>> +		if (!strncasecmp(uuid, disk_partition_uuid(info), UUID_STR_LEN)) {
>>> +			/* matched */
>>> +			return i;
>>> +		}
>>> +	}
>>> +#endif
>>> +	return -ENOENT;
>>> +}
>>> +
>>>    /**
>>>     * Get partition info from device number and partition name.
>>>     *
>>> diff --git a/include/part.h b/include/part.h
>>> index fcb3c13dea4..3e6eb0ec33f 100644
>>> --- a/include/part.h
>>> +++ b/include/part.h
>>> @@ -315,6 +315,20 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
>>>    int part_get_info_by_name(struct blk_desc *desc, const char *name,
>>>    			  struct disk_partition *info);
>>> +/**
>>> + * part_get_info_by_uuid() - Search for a partition by uuid
>>> + *                           among all available registered partitions
>>> + *
>>> + * @desc:	block device descriptor
>>> + * @uuid:	the specified table entry uuid
>>> + * @info:	the disk partition info
>>> + *
>>> + * Return: the partition number on match (starting on 1), -ENOENT on no match,
>>> + * otherwise error
>>> + */
>>> +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>>> +			  struct disk_partition *info);
>>> +
>>>    /**
>>>     * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
>>>     *					    and part name, or dev number and
>>> @@ -386,6 +400,12 @@ static inline int part_get_info_by_name(struct blk_desc *desc, const char *name,
>>>    	return -ENOENT;
>>>    }
>>> +static inline int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>>> +					struct disk_partition *info)
>>> +{
>>> +	return -ENOENT;
>>> +}
>>> +
>>>    static inline int
>>>    part_get_info_by_dev_and_name_or_num(const char *dev_iface,
>>>    				     const char *dev_part_str,
>>
>> --
>> Casey (she/they)
>>
-- 
Casey (she/they)

