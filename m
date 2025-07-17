Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF0C83F22
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 13:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D50E833E1;
	Thu, 17 Jul 2025 15:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="WTnmJ1as";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C34833E8; Thu, 17 Jul 2025 15:56:42 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0236A833D0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 15:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ariel.dalessandro@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752760595; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Z6nMevRJVjA/ATYy/4Qo4QI2fd8Uhj52MsoceaLy/8Crt970YxDPV7GgvZl+qgbyv3SZnPD0oU5Tgy62Cnn/YY3XXOK1uFGf1G63Vrgez5Ul0/qaoZ8L6x4WFglB7Cj01fw8LAepnl3rZgvr4/7bbnJ4zc1RYGX0vhHlYze5+H0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752760595;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eWsfAnwod3tBCsTSQCNpFdrWMOjhVhxWTcDBGMaWxxw=; 
 b=UIA/YCF2Uul71xzb0mSClTb8BA5JLE0h9etcwSOLXrzJESvfeJ0EmQmxZcfs2DuFFR3M4H5V5EtRNrxhvzjAH+2I7FyK+ZBfVUqhoEvCu7m4IrxQkjOO7pZ6JSrk/ie618nc9UVrljKBk7fcGHC9bJquBsg+fHC4yFC/OTNEiLs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
 dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752760595; 
 s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=eWsfAnwod3tBCsTSQCNpFdrWMOjhVhxWTcDBGMaWxxw=;
 b=WTnmJ1asDiFCOzcmQwV/S5R7tON0vK1lIml8nLwF7E1VgRfZx3GNGZJYXNA/OV8o
 y9VKlsKeFXsdSx6UJt/FiMu0X0W0f7H0zgyr6SDWedrov9hdD1Wb8SdM4POhK/H91GI
 shuLXsxYNsNULxEnn2S+0h+CgW86OueCZvyENieM=
Received: by mx.zohomail.com with SMTPS id 1752760592878813.6364941079948;
 Thu, 17 Jul 2025 06:56:32 -0700 (PDT)
Message-ID: <b446525c-c852-471b-93d4-b6d98834c6a3@collabora.com>
Date: Thu, 17 Jul 2025 10:56:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: fastboot: Add support for SPI flash memory
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, jerome.forissier@linaro.org,
 patrice.chotard@foss.st.com, ilias.apalodimas@linaro.org,
 andre.przywara@arm.com, casey.connolly@linaro.org, mwalle@kernel.org
References: <20250715191109.329588-1-ariel.dalessandro@collabora.com>
 <87y0sn2utc.fsf@kernel.org>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <87y0sn2utc.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

Hi Mattijs,

On 7/17/25 3:30 AM, Mattijs Korpershoek wrote:
> Hi Ariel,
> 
> Thank you for the patch.
> 
> On Tue, Jul 15, 2025 at 16:11, Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> 
>> Fastboot currently supports MMC and NAND flash devices. Similarly,
>> extend the support to SPI flash memories.
>>
>> Note that in this initial implementation, partitions on the device are
>> not supported yet, but raw partitions can be set in u-boot environment.
> 
> nitpick: u-boot -> U-Boot

Ack.

> 
>>
>> To define a raw partition descriptor, add an environment variable
>> similar to the MMC case:
>>
>> ```
>> fastboot_raw_partition_<raw partition name>=<offset> <size>
>> ```
>>
>> for example:
>>
>> ```
>> fastboot_raw_partition_boot=0x0 0x1000000
>> ```
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>   drivers/fastboot/Kconfig        |   6 +-
>>   drivers/fastboot/Makefile       |   1 +
>>   drivers/fastboot/fb_command.c   |   8 +
>>   drivers/fastboot/fb_getvar.c    |   6 +
>>   drivers/fastboot/fb_spi_flash.c | 249 ++++++++++++++++++++++++++++++++
>>   include/fb_spi_flash.h          |  40 +++++
> 
> Can we also include a doc change to doc/android/fastboot.rst ?
> The current doc mentions:
> "Support for both eMMC and NAND devices is included."
> 
> We should add SPI flash to that sentence.

Sure.

> 
> Maybe also mention in the "Raw partition descriptors" that this is
> supported for SPI flash as well.

Will do.

> 
>>   6 files changed, 309 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/fastboot/fb_spi_flash.c
>>   create mode 100644 include/fb_spi_flash.h
>>
> 
> [...]
> 
>> +
>> +/**
>> + * fastboot_spi_flash_get_part_info() - Lookup SPI flash partition by name
>> + *
>> + * @part_name: Named device to lookup
>> + * @part_info: Pointer to returned struct disk_partition
>> + * @response: Pointer to fastboot response buffer
> 
> Can we add a Return: line to document the return code?

Sure, will add it to both source and header files.

> 
>> + */
>> +int fastboot_spi_flash_get_part_info(const char *part_name,
>> +				     struct disk_partition *part_info,
>> +				     char *response);
>> +
>> +/**
>> + * fastboot_spi_flash_write() - Write image to SPI flash for fastboot
>> + *
>> + * @cmd: Named device to write image to
>> + * @download_buffer: Pointer to image data
>> + * @download_bytes: Size of image data
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_spi_flash_write(const char *cmd, void *download_buffer,
>> +			      u32 download_bytes, char *response);
>> +
>> +/**
>> + * fastboot_spi_flash_erase() - Erase SPI flash for fastboot
>> + *
>> + * @cmd: Named device to erase
>> + * @response: Pointer to fastboot response buffer
>> + */
>> +void fastboot_spi_flash_erase(const char *cmd, char *response);
>> +#endif
Thanks a lot for the feedback!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718

