Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CBDE77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 11:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D16D8005B;
	Mon, 16 Dec 2024 12:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734348961;
	bh=TLGt2gakmSp0IK/512I6WikP2YfH8JbUcmZx+CR7b5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0MohLZEkIB1RdGoun4z5S/TCzeRtwcKgPWLuleVJcQC7OThxsWeVcNjKMRumOO48x
	 WwUwBCTT5IGomQbICJsWgaMM7huvNrvSwcR+tTr0Rpk6zZCrnVT/j6hdqv3ublyhv5
	 zNSuDDF7SWdpM7BtXGplDYs/DvlJOmslWv1ZQIeq5bh/D534vbqeLIkfYo3kuYFulA
	 Ot4BM+g1eQSbQnJuuHWejT2bk9TDVeJdT+x229KkYk9EOoLjKfBD6rISnJdM72Il0k
	 GZyqXxQaztqZh+zBCQoduv6urE2jvwcvAVzd1gMkgmMOh4CphaIX3EkwkGSyIAZOO/
	 2JsAeC3nOR+sA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3C680104; Mon, 16 Dec 2024 12:35:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A668003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 12:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="UzCyeMXl"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E103E108B6FA1; Mon, 16 Dec 2024 12:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734348955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLGt2gakmSp0IK/512I6WikP2YfH8JbUcmZx+CR7b5s=;
 b=UzCyeMXlqTDjhcxAg4Dw0SyuKgwdSe8o+GLOiTs1df9I3hDmXKOPUnHa4JoPsZ6xf0lK5O
 phYlhUMMDqryB1eWh4y6tdLj2Xm9kzH4R70tJ0bXneFsBKVhye0q4ReyhMT2Lzz737bo+n
 DJx7N6Ns25VRaLlF3/zHYtTqMu1+ki+gyE3eopv+8cxbFjDF4r7bMG/QbMHj4dnfqO76bu
 PqXcYbVZAzkl1CV+5CO/wWQsDcc0w33EspA7EE7gMkIn0zWC5zhb1NQz5kNb3ZayCnrCp9
 5poC77/RmS7obZ0hFy7EaBXJUBig1E1DeZa+n60ka5nA/e3dr0JMoB4vU6MHsw==
Message-ID: <3307c1e3-123b-4ff1-8140-18be7393b5e5@denx.de>
Date: Mon, 16 Dec 2024 11:35:45 +0100
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB869702808B7A784031F17F83983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 12/16/24 5:16 AM, Abbarapu, Venkatesh wrote:

[...]

>>> +++ b/drivers/mtd/spi/spi-nor-core.c
>>> @@ -1140,7 +1140,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct
>> erase_info *instr)
>>>    				nor->spi->flags &= ~SPI_XFER_U_PAGE;
>>>    		}
>>>    #ifdef CONFIG_SPI_FLASH_BAR
>>> -		ret = write_bar(nor, addr);
>>> +		ret = write_bar(nor, offset);
>>
>> This change is really inobvious, the code above likely needs to be compiled out if the
>> SPI_STACKED_PARALLEL stuff is disabled ?
> 
> In the spi_nor_erase()
> 	offset = addr;
> 	if(PARALLEL)
> 		offset/=2;
> 	so for parallel or single configuration we need to pass "offset" to write_bar()
> 	write_bar(nor, offset");

The code above likely needs to be compiled out if the 
SPI_STACKED_PARALLEL stuff is disabled ?

[...]

>> If I look at this change with 'git show -w' , the change looks like this:
>>
>> "
>>    #ifdef CONFIG_SPI_FLASH_BAR
>> +               u32 remain_len;
>> +
>>                   ret = write_bar(nor, offset);
>>                   if (ret < 0)
>>                           return log_ret(ret);
>> +               remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
>> +               if (len < remain_len)
>> +                       read_len = len;
>> +               else
>> +                       read_len = remain_len;
>>    #endif
>> -
>> +               if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
>>                           if (len < rem_bank_len)
>>                                   read_len = len;
>>                           else
>>                                   read_len = rem_bank_len;
>> -
>> +               }
>>                   if (read_len == 0)
>>                           return -EIO;
>> "
>>
>> Why is there this part of code twice now, ifdeffed out differently in each case ?
>>
>> "
>>                           if (len < rem_bank_len)
>>                                   read_len = len;
>>                           else
>>                                   read_len = rem_bank_len; "
> 
> For parallel/stacked configuration and address width the "rem_bank_len" will vary and as we don't want to disturb the default read functionality added the ifdef separately.
What would happen if both SPI_FLASH_BAR and SPI_STACKED_PARALLEL are 
enabled on a system that only has one SPI NOR attached 
(non-stacked/parallel) ? I noticed the second "copy" of the code behaves 
slightly differently in the else branch, so does that mean this would 
break such setup ?
