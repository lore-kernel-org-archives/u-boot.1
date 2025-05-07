Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70E2C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B228215B;
	Wed,  7 May 2025 14:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zCTPF65r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED8E8211F; Wed,  7 May 2025 13:47:45 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B37881F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so5343264f8f.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746618462; x=1747223262; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F/hUKPTeJR8ECbnqxMo7lD7tZbE8P3syNA/CPAYcZVg=;
 b=zCTPF65rQxokB4PokFQc5zmngn7Whe7scb3Llr5N8ZoFUZXVK1S/wvfVByeJYUMq39
 9GSRg3pc47hlIv3o6O7Ere90rRpQBt8RcIcIeHk1yI/nOZ+pSC5POcP7krEMVclD8WXK
 npjOQW0f1DYLzluJByePPAg5AD9s4phhUxdkCutJeqruPjrhp2QC0yABBVN8wIosK/te
 tKMjjqJVfQS5UTmiqtEUqbgVrwyL2uqg6hW28IcJPgxZWfibJA4/zFY4GkU3x+IidY/l
 5WktcfSL6WbqUL5oqCIQymm8p+5MoCZkGleMWhWk4/RKwupVBdQdmb0Ieaazh6WPOygH
 jOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746618462; x=1747223262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/hUKPTeJR8ECbnqxMo7lD7tZbE8P3syNA/CPAYcZVg=;
 b=Zl1oGIvPvGymjU/hzZimpY8PoswvVTgAJxAaVjFbMlbDu4dd7xoIcXySn9U20TzT6t
 s22ScdWQztrgWTSBusPnz4PPJH15t1oCRNDj9yon7RdqENeDg6NoRqtbq+kCMolHhwQw
 KbduUpJqyikCWeuEdcRCZd0E0LHFnEPje2fSSWB0RFli60Dr/ckso+JKOp/afbLnXTPs
 04sd5kCEkx1EHXa7yt+jylXcoq+DarVreVrTp9WsoQe3FlXsf54IwO8G6G/zMs0GjzuQ
 Io1H0PbzvC4jwk8hSwln2OVcuzXVgw+434kn0EjkvHpkKOe7w7jgZ+/FLl07rzGrvWPQ
 +bsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjTWhKdwbSTlXiBPDMzcd9xS4USprCJTaYu/rpSP+x5Zu2IuBk8C6FlyTqKg1pvyVDqQB4ag4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2Vq7snmJFLZ/hcJ0xFx5u6vQfrxUo8dGPvR3i2tQFIhiDV9jj
 TeMo/LzofiEY1/B/yIy8Zd4ROqftcDa7O/i/LFd6+3obMND+ybUJUe1MfkCQIbc=
X-Gm-Gg: ASbGnctymrFLQxsuVPfA7tTTlPMeSaJTDzA6ezsr2+/PsluvfbVVaz2VcfjmKbaBCOM
 odbrBZ4d2C5QIYYCqI9x2bd8iNI63rQAWGmUZPGwjUgHq+KuPlClrIdMkp75C8tOeGscQpsa0az
 +WQSk4JJgGVhATPKP+M5LvcLnYFHaL5NZ9tpMZmv6lSj6WBFN8oY6vll5O5sjrQxEJMg5Zm/zWu
 g+GduzwHbrbn1PsXAEZkUNlairK8v0B4mc7LwEQq1Qz8Ri0cY9Qearv35M3a+m6r5e+Rro1/9tQ
 Ys38mdp+l9XKj74JL0rxiwOkGp+Uam2JT6Pq6AAX5TP2EdYYEI0jO3gdMSdSSQmd6icesalzpuB
 Mmj2YqMZ6yMvQGqWjLg==
X-Google-Smtp-Source: AGHT+IGr9cCNxfsiB1zGmGJZ9j7VEBM21d0X6qG/bXpgIkBqRbPpOlx5G+Az6LoQr3E7qBdDbIiPxg==
X-Received: by 2002:a05:6000:200d:b0:3a0:b807:7432 with SMTP id
 ffacd0b85a97d-3a0b80776b7mr193001f8f.32.1746618462597; 
 Wed, 07 May 2025 04:47:42 -0700 (PDT)
Received: from [192.168.1.47] (234-60-142-46.pool.kielnet.net. [46.142.60.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c48sm16620681f8f.8.2025.05.07.04.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:47:41 -0700 (PDT)
Message-ID: <16a681a0-e272-4a41-8391-75135959ad00@linaro.org>
Date: Wed, 7 May 2025 13:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] disk: part: implement generic function
 part_get_info_by_uuid()
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, avromanov@salutedevices.com,
 michael@amarulasolutions.com, hs@denx.de, sjg@chromium.org,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, xypron.glpk@gmx.de,
 cniedermaier@dh-electronics.com, ansuelsmth@gmail.com,
 venkatesh.abbarapu@amd.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
 <20250507112812.3066301-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250507112812.3066301-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 07 May 2025 14:39:00 +0200
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

Hi Varadarajan,

On 5/7/25 13:28, Varadarajan Narayanan wrote:
> Add function to search for a partition by UUID as partition
> names may not be unique.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
>   include/part.h | 20 ++++++++++++++++++++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/disk/part.c b/disk/part.c
> index 303178161c0..abae79a55a7 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -698,6 +698,43 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
>   	return -ENOENT;
>   }
>   
> +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> +			  struct disk_partition *info)
> +{
> +#if CONFIG_IS_ENABLED(PARTITION_UUIDS)

Please refer to checkpatch output (the b4 tool will run this for you 
automatically).

	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
		return -ENOENT;

> +	struct part_driver *part_drv;
> +	int ret;
> +	int i;
> +
> +	part_drv = part_driver_lookup_type(desc);
> +	if (!part_drv)
> +		return -1;
> +
> +	if (!part_drv->get_info) {
> +		log_debug("## Driver %s does not have the get_info() method\n",
> +			  part_drv->name);
> +		return -ENOSYS;
> +	}
> +
> +	for (i = 1; i < part_drv->max_entries; i++) {
> +		ret = part_drv->get_info(desc, i, info);
> +		if (ret != 0) {
> +			/*
> +			 * Partition with this index can't be obtained, but
> +			 * further partitions might be, so keep checking.
> +			 */
> +			continue;

For part_efi (which is the only one relevant here I think?) you can 
check for -EPERM which signals the end of the partition list I believe. 
Then we aren't calling get_info() 128 times for every LUN...

Kind regards,> +		}
> +
> +		if (!strncasecmp(uuid, disk_partition_uuid(info), UUID_STR_LEN)) {
> +			/* matched */
> +			return i;
> +		}
> +	}
> +#endif
> +	return -ENOENT;
> +}
> +
>   /**
>    * Get partition info from device number and partition name.
>    *
> diff --git a/include/part.h b/include/part.h
> index fcb3c13dea4..3e6eb0ec33f 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -315,6 +315,20 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
>   int part_get_info_by_name(struct blk_desc *desc, const char *name,
>   			  struct disk_partition *info);
>   
> +/**
> + * part_get_info_by_uuid() - Search for a partition by uuid
> + *                           among all available registered partitions
> + *
> + * @desc:	block device descriptor
> + * @uuid:	the specified table entry uuid
> + * @info:	the disk partition info
> + *
> + * Return: the partition number on match (starting on 1), -ENOENT on no match,
> + * otherwise error
> + */
> +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> +			  struct disk_partition *info);
> +
>   /**
>    * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
>    *					    and part name, or dev number and
> @@ -386,6 +400,12 @@ static inline int part_get_info_by_name(struct blk_desc *desc, const char *name,
>   	return -ENOENT;
>   }
>   
> +static inline int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> +					struct disk_partition *info)
> +{
> +	return -ENOENT;
> +}
> +
>   static inline int
>   part_get_info_by_dev_and_name_or_num(const char *dev_iface,
>   				     const char *dev_part_str,

-- 
Casey (she/they)

