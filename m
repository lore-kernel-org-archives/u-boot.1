Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C2EC47DA7
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1875587559;
	Tue, 16 Jan 2024 17:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ql/v9im4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02421878CA; Tue, 16 Jan 2024 17:14:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C5F86564
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89AA43F154
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705421674;
 bh=TRX0uaVqbJj8KFkJ7nW5dYvtlv6gEAjAFd5lnPFj/9o=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=Ql/v9im4HGMzNviijIxvVTsUk0G2/SRGK768w1hmPD64QNwjccBzDGtbGhrORXm+p
 qE4zUWRX4MOS3ETQ5OVlegJ++QtNTqBNo6Hpw9nuYbGtMXs2gblrQ4CzsNVFEx3cV/
 ZhUewjmC7/x9JX5deN9GX6eSLh+7Gs0tldL0GuMkKLlMiQUp/FjfI3DDYqWVUVmEzw
 HmVU9uQo9tv6JWgqh5M6BDauKxBmsZPU4AtsTc6xKUWs+DzN00tmLeZ52UdccpozPV
 2mnjPEgKhigeFytmXfwjLV09e6uj1x6qV5FfXTMrXlNXn4iWtwgS4LjdX4UclH2FyG
 7gbBAUXHTELlw==
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50e73a3a280so7221113e87.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705421674; x=1706026474;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TRX0uaVqbJj8KFkJ7nW5dYvtlv6gEAjAFd5lnPFj/9o=;
 b=mTOGNcHC1Lyha/xx7bhT00KRxolyxcxfYzmForNTzLzzoAD7umu6IXB4NXVtlroZod
 S3DmDlQefDPiVWd4BqOMqnUKpMaqaJcgYnblRh86f0nDUrRaXSW/avLPL4cMzPD6wPqa
 5bdSG90m5dmzVw2QsNqHSfPN26f4DBhHBw6GuOhwPiOxIW95vOcjma9BzcMPNNa9FEoh
 cX+W2XDYBwObWzTcx4yT/rcdhw0vEXa03YVdweqsDFjf6UkDlOXh3HBEAStRvgR0dwl/
 TylTpHRTCCNSlEqHQ45rpaoTR5aF79HCd9v/xoLm+XlGNCSoDHIlZMvHxG8MFvxv/b8f
 60Wg==
X-Gm-Message-State: AOJu0YyMqFQc2fdaU5u61WY/TBHlKVaAL5DSDFFQCbD4UXQzZ0joLQeB
 Gqr3q6ipA27yHpmIUyCR6S5v52xHDqVgklCTW5Aj+/C0f0Nv1Ii06GjtKqM6pAYOBZazfTPWu4J
 nFpPdz1/ilwXA7tu5aUYaR3QPOss/XsViVMJEgg==
X-Received: by 2002:a05:6512:124b:b0:50e:74e9:1512 with SMTP id
 fb11-20020a056512124b00b0050e74e91512mr3796930lfb.52.1705421673984; 
 Tue, 16 Jan 2024 08:14:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWY8jAQyPkTnJj6OTQe6+ev2IDDfw9RB8cxhBCT8iAOufQ4busIjWjGf1p94SReyOGyKb12w==
X-Received: by 2002:a05:6512:124b:b0:50e:74e9:1512 with SMTP id
 fb11-20020a056512124b00b0050e74e91512mr3796917lfb.52.1705421673589; 
 Tue, 16 Jan 2024 08:14:33 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 bl2-20020a170906c24200b00a29d232ab76sm6613841ejb.182.2024.01.16.08.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 08:14:33 -0800 (PST)
Message-ID: <77d00047-154e-4e35-8171-3028c4b5d3f3@canonical.com>
Date: Tue, 16 Jan 2024 17:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] part: Add a function to find ESP partition
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Tobias Waldekranz <tobias@waldekranz.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-2-mchitale@ventanamicro.com>
 <d3d71b07-9636-42e9-b29b-31ae84d8e4b4@canonical.com>
Content-Language: en-US
In-Reply-To: <d3d71b07-9636-42e9-b29b-31ae84d8e4b4@canonical.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 16.01.24 14:45, Heinrich Schuchardt wrote:
> On 16.01.24 13:36, Mayuresh Chitale wrote:
>> If a disk has an EFI system partition (ESP) then it can be used to
>> locate the boot files. Add a function to find the ESP.
>>
>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

I ran your patches through Gitlab CI and some issues came up:

https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/771497
https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/771498

Could you, please, have a look at it.

Best regards

Heinrich

>> ---
>>   disk/part.c    | 16 ++++++++++++++++
>>   include/part.h | 11 +++++++++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 36b88205eca..6b1fbc18637 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -848,3 +848,19 @@ int part_get_bootable(struct blk_desc *desc)
>>       return 0;
>>   }
>> +
>> +int part_get_esp(struct blk_desc *desc)
>> +{
>> +    struct disk_partition info;
>> +    int p;
>> +
>> +    for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
>> +        int ret;
>> +
>> +        ret = part_get_info(desc, p, &info);
>> +        if (!ret && (info.bootable & PART_EFI_SYSTEM_PARTITION))
>> +            return p;
>> +    }
>> +
>> +    return 0;
>> +}
>> diff --git a/include/part.h b/include/part.h
>> index db34bc6bb7d..30e049c8f19 100644
>> --- a/include/part.h
>> +++ b/include/part.h
>> @@ -690,6 +690,14 @@ int part_get_type_by_name(const char *name);
>>    */
>>   int part_get_bootable(struct blk_desc *desc);
>> +/**
>> + * part_get_esp() - Find the EFI system partition
>> + *
>> + * @desc: Block-device descriptor
>> + * @Return the EFI system partition, or 0 if there is none
> 
> We want to be able to add the include to our API documentation. This 
> requires adhering to the Sphinx documentation style.
> 
> %s/@Return the/Return:/
> 
> Cf. 
> https://www.kernel.org/doc/html/v6.7/doc-guide/kernel-doc.html#function-documentation
> 
> Best regards
> 
> Heinrich
> 
>> + */
>> +int part_get_esp(struct blk_desc *desc);
>> +
>>   #else
>>   static inline int part_driver_get_count(void)
>>   { return 0; }
>> @@ -700,6 +708,9 @@ static inline struct part_driver 
>> *part_driver_get_first(void)
>>   static inline bool part_get_bootable(struct blk_desc *desc)
>>   { return false; }
>> +static inline bool part_get_esp(struct blk_desc *desc)
>> +{ return false; }
>> +
>>   #endif /* CONFIG_PARTITIONS */
>>   #endif /* _PART_H */
> 

