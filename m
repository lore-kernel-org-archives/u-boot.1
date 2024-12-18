Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20481E77184
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 01:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4A9801FB;
	Wed, 18 Dec 2024 02:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734484756;
	bh=mJ6j2XoLxayrEEmclGUWclNNZXX144nd6IOf/JMTNag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aCsLiAThuRhHNZ6kk0JzGgStoxuv3LcUCEpJ9ORCvAGb9SiG36OpQT6qIUWls1+yr
	 E3S4w/Yc2uygwDReuXn0id7+VI6a1mDr8GT1O8JWdoMYufBrQ9rWkYV+eHQIvAu7DP
	 dUF9hPMvWmeh4IjtvDGGZXsQ/ew+G5iNMNxX36ZfzPo0PefZV4iVSkeX2NbhvB9hrm
	 wyCtIsgNeeW3h8zp8emCNPRk2rwxfRZ36VvXRZ7faWPMKHSopJt/E5AS4d9jJwrYp9
	 QarIuumE8G7S86jji71ZQ31gwtQ22CYzKItKpFtbe8FK1wb4Wt9HtJC96/1c4nlkun
	 nDneEXUadNTvw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8BD80214; Wed, 18 Dec 2024 02:19:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CEBB801CE
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HD1LxmEC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D9CB71048E294; Wed, 18 Dec 2024 02:19:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734484750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJ6j2XoLxayrEEmclGUWclNNZXX144nd6IOf/JMTNag=;
 b=HD1LxmECalEL1/RzgVla4eJpsomzpMe9K058d+tj6I7QKW8EU7BGKaDHn81ne23a2rHUbl
 2p0kXm6WLB/dutzV6ZQA6LroXFpxneMkqQmI8Xf5y82UFxmxlbbBxY00Nd13WW2rDGJ0Zp
 Tel1ApQN3XFeKf0/yL/hvFmJ3BGz6o7uiFqmNVQMrjU9cu7xoftTfBlZRw3MDwJdHf21T3
 9fnfU2FjzAgNgTas8g7v6rEeJA0l236lfNfxEboXSfJ+NtHruwfdgJYp6uEE1fUv4H9zMR
 BAxptkCm1EYlibl8He63Ns0PBEZfBG5t3SmwEtiYlIUuueVmSYKI9Nxm0fyCxg==
Message-ID: <7f2b69af-ea98-4d22-a831-e484811c9715@denx.de>
Date: Wed, 18 Dec 2024 02:09:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
 <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
 <SA1PR12MB869702808B7A784031F17F83983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <3307c1e3-123b-4ff1-8140-18be7393b5e5@denx.de>
 <SA1PR12MB86974EDF358A58732A9B7A6F983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB86974EDF358A58732A9B7A6F983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 12/16/24 2:58 PM, Abbarapu, Venkatesh wrote:

>>>>> +++ b/drivers/mtd/spi/spi-nor-core.c
>>>>> @@ -1140,7 +1140,7 @@ static int spi_nor_erase(struct mtd_info *mtd,
>>>>> struct
>>>> erase_info *instr)
>>>>>     				nor->spi->flags &= ~SPI_XFER_U_PAGE;
>>>>>     		}
>>>>>     #ifdef CONFIG_SPI_FLASH_BAR
>>>>> -		ret = write_bar(nor, addr);
>>>>> +		ret = write_bar(nor, offset);
>>>>
>>>> This change is really inobvious, the code above likely needs to be
>>>> compiled out if the SPI_STACKED_PARALLEL stuff is disabled ?
>>>
>>> In the spi_nor_erase()
>>> 	offset = addr;
>>> 	if(PARALLEL)
>>> 		offset/=2;
>>> 	so for parallel or single configuration we need to pass "offset" to write_bar()
>>> 	write_bar(nor, offset");
>>
>> The code above likely needs to be compiled out if the SPI_STACKED_PARALLEL
>> stuff is disabled ?
>>
>> [...]
>>
> Already the code here is being checked with the flags SNOR_F_HAS_PARALLEL and SNOR_F_HAS_STACKED. Do you want to add the check SPI_STACKED_PARALLEL apart from these flags?

Yes, to compile the code out completely.

>>>> If I look at this change with 'git show -w' , the change looks like this:
>>>>
>>>> "
>>>>     #ifdef CONFIG_SPI_FLASH_BAR
>>>> +               u32 remain_len;
>>>> +
>>>>                    ret = write_bar(nor, offset);
>>>>                    if (ret < 0)
>>>>                            return log_ret(ret);
>>>> +               remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
>>>> +               if (len < remain_len)
>>>> +                       read_len = len;
>>>> +               else
>>>> +                       read_len = remain_len;
>>>>     #endif
>>>> -
>>>> +               if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
>>>>                            if (len < rem_bank_len)
>>>>                                    read_len = len;
>>>>                            else
>>>>                                    read_len = rem_bank_len;
>>>> -
>>>> +               }
>>>>                    if (read_len == 0)
>>>>                            return -EIO; "
>>>>
>>>> Why is there this part of code twice now, ifdeffed out differently in each case ?
>>>>
>>>> "
>>>>                            if (len < rem_bank_len)
>>>>                                    read_len = len;
>>>>                            else
>>>>                                    read_len = rem_bank_len; "
>>>
>>> For parallel/stacked configuration and address width the "rem_bank_len" will vary
>> and as we don't want to disturb the default read functionality added the ifdef
>> separately.
>> What would happen if both SPI_FLASH_BAR and SPI_STACKED_PARALLEL are
>> enabled on a system that only has one SPI NOR attached
>> (non-stacked/parallel) ? I noticed the second "copy" of the code behaves slightly
>> differently in the else branch, so does that mean this would break such setup ?
> 
> If both SPI_FLASH_BAR and SPI_STACKED_PARALLEL are enabled, the "rem_bank_len" manipulation is done under the CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL) code and this won't break any default functionality.
Wouldn't read_len calculation be done twice ?
