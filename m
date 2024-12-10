Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9E5E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 23:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5887380209;
	Wed, 11 Dec 2024 00:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qFC2gGqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA17880214; Wed, 11 Dec 2024 00:45:46 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E0B801DB
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 00:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y7FjK44wtz9spX;
 Wed, 11 Dec 2024 00:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733874341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8hU3FAHKxjtaEgC/RD9+CuMsrHC5XtZMMVC41GNu7A=;
 b=qFC2gGqpiqjORd3Yti8h5240xuqWvImsFW6Z5/qQtNKIscXpyy7bjXA4C1YA8LMfG8jNEg
 JqBmchL2XYy1ZWojeTA7e98n52FZrN/EClwsIqmKQzLPWlSP2qovz6cIOogBkRotZIWpUS
 LO7kGIlI6S4Bcnjnf6L/6IotpJ6d9GAoHVdb05fofcFhzxwdlhun251dgxdZMDFywsZ4JS
 NPqJ0wbtsxADNx3avWTl3TCSOofNEJ0QQX7nnaZHpx1LHLgJ1REeaQMTekkzdTHbSGYNrt
 8q8pGdyC1uqNFoZUwBMsVpPslFvNlQce+rPZXihXTPmwvUDWO5X+WszAp8OLGw==
Message-ID: <3fab52c5-0635-4e0d-a107-9372e11bb554@mailbox.org>
Date: Wed, 11 Dec 2024 00:45:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Fix the read issue when addr_width is 4byte
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, git@amd.com
References: <20241118090544.21956-1-venkatesh.abbarapu@amd.com>
 <2773d157-2b75-4fe5-bf16-9e6927e0f6f4@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2773d157-2b75-4fe5-bf16-9e6927e0f6f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qh4qcre6mbn6r153b9eyeeoembfee1sk
X-MBO-RS-ID: da2173dba6475d82ef3
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

On 12/5/24 8:35 AM, Tudor Ambarus wrote:
> + Marek
> 
> use get_maintainers script please
> 
> On 11/18/24 9:05 AM, Venkatesh Yadav Abbarapu wrote:
>> Fix the read issue for 4byte address width by passing the entire
>> length to the read function, split the memory of 16MB size banks
>> only when the address width is 3byte. Also update the size when
>> the configuration is stacked.
>>
>> Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   drivers/mtd/spi/spi-nor-core.c | 24 +++++++++++++++---------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
>> index ec841fb13b..c37a9bce74 100644
>> --- a/drivers/mtd/spi/spi-nor-core.c
>> +++ b/drivers/mtd/spi/spi-nor-core.c
>> @@ -1580,6 +1580,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>>   	loff_t offset = from;
>>   	u32 read_len = 0;
>>   	u32 rem_bank_len = 0;
>> +	u32 stack_shift = 0;
>>   	u8 bank;
>>   	bool is_ofst_odd = false;
>>   
>> @@ -1593,18 +1594,20 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>>   	}
>>   
>>   	while (len) {
>> -		bank = (u32)from / SZ_16M;
>> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
>> -			bank /= 2;
>> -
>> -		rem_bank_len = SZ_16M * (bank + 1);
>> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
>> -			rem_bank_len *= 2;
>> -		rem_bank_len -= from;
>> -
>> +		if (nor->addr_width == 3) {
> 
> No, this looks bad because you enter the body of this for all the
> flashes with addr_width 3, not just for the parallel/stacked ones.
> 
> Instead you should do whatever you do here just for your
> parallel/stacked cases.
> 
>> +			bank = (u32)from / SZ_16M;
>> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
>> +				bank /= 2;
>> +
>> +			rem_bank_len = SZ_16M * (bank + 1);
>> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
>> +				rem_bank_len *= 2;
>> +			rem_bank_len -= from;
>> +		}
>>   		offset = from;
>>   
>>   		if (nor->flags & SNOR_F_HAS_STACKED) {
>> +			stack_shift = 1;
>>   			if (offset >= (mtd->size / 2)) {
>>   				offset = offset - (mtd->size / 2);
>>   				nor->spi->flags |= SPI_XFER_U_PAGE;
>> @@ -1616,6 +1619,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>>   		if (nor->flags & SNOR_F_HAS_PARALLEL)
>>   			offset /= 2;
>>   
>> +		if (nor->addr_width == 4)
>> +			rem_bank_len = (mtd->size >> stack_shift) - offset;
> 
> same here.
> 
> If we still want to keep this support until everything is implemented
> above SPI NOR, other option is to duplicate core methods and introduce
> dedicated methods for the parallel/stacked cases. You could keep the
> parallel/stacked methods in dedicated file as well.
> 
> The advantage is that you won't interfere with current SPI NOR support
> and that you won't break any flashes anymore. Then we can easily remove
> everything once proper support is implemented above SPI NOR. The
> disadvantage is that we duplicate code ... Marek?
I can imagine the duplication can be solved by factoring out the SPI NOR 
code into a library design, where each callback implementation could be 
assembled from building blocks, thus avoiding code duplication. However, 
this seems like a huge change for the current 2025.01 release cycle, we 
are already in rc4.

For 2025.01 , either this stacked stuff has to be carefully ifdeffed 
out, so it can be enabled only for platforms which need it and disabled 
for all others to avoid breaking them ... or reverted outright .
