Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F9EC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7966F882E2;
	Mon, 17 Jun 2024 15:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="eDe0+Sgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9965588271; Mon, 17 Jun 2024 15:31:43 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414E7882E2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718631100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHtBlBW0BggQjQn0dKPtPYWfFg1jyiIYEbfqRteXAp8=;
 b=eDe0+SgwcOd9tlRjepYyGNHMiwcVj3eARi+UQzEEtf1cXdghku9q9yrOIf+SL360lg36ED
 LWCED5tVE2XKDSL0gRSy+yEAHDfaL5Q7jxlGHjvnnm+SvkTYxy60UAdUUZsIhS/CC8x6Oy
 j62C8NsUscGY9Wzn9V780v6T60uIOibKq42TL9k4dgwGzZglv4MiWgjZOJXOoyWFGMXRWG
 YYQ9pyzl8/IphOhrZ+Qj/1qrrr8yEa2+xW24RNEkX3INRmYO+Fw8OhavsCsFjWNCTJdQbX
 EWxUDagQjJ5kNpXDS6FxxeJ+zE+/gzOeV5AIm6eg87F8cWUF9Cv2RS5Pn9x4rg==
Date: Mon, 17 Jun 2024 15:31:39 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Dhruva Gole <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com
Subject: Re: [PATCH] mtd: spi-nor: ids: Add IS25LP01GG flash support
In-Reply-To: <18ca247a-980a-4d6a-906a-bb5719482626@amd.com>
References: <20240617041841.1336632-1-prasad.kummari@amd.com>
 <20240617062822.474khxwuq4yxs5ra@dhruva>
 <18ca247a-980a-4d6a-906a-bb5719482626@amd.com>
Message-ID: <ce7685916d3b76527425368754ea096f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Michal,

On 2024-06-17 15:26, Michal Simek wrote:
> On 6/17/24 08:28, Dhruva Gole wrote:
>> On Jun 17, 2024 at 09:48:42 +0530, Prasad Kummari wrote:
>>> Add support for ISSI 128MB flash IS25LP01GG. This part
>> 
>> Can we have the datasheet link for this part?
>> I am assuming it's this?
>> https://www.issi.com/WW/pdf/25LP-WP01GG.pdf
> 
> Problem with links is that they will disappear when company decide to
> change infrastructure or is acquired by different one.

You can prevent that by making sure that the link to the PDF file
is archived on The Wayback Machine. [1]  That way, even if the URL
becomes invalid at some point in time, the contents won't be lost.

[1] https://web.archive.org/

>> Better to add it to the commit message.
> 
> Not sure what's U-Boot policy on this but placing it below --- should 
> be enough
> or what you have done as reply to this email that it can be found via 
> b4.
> 
> Thanks,
> Michal
> 
>> 
>>> supports 4byte opcodes. It also supports dual and quad
>>> read.
>>> 
>>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>>> ---
>>>   drivers/mtd/spi/spi-nor-ids.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/drivers/mtd/spi/spi-nor-ids.c 
>>> b/drivers/mtd/spi/spi-nor-ids.c
>>> index 4e83b8c94c..8cad764237 100644
>>> --- a/drivers/mtd/spi/spi-nor-ids.c
>>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>>> @@ -242,6 +242,8 @@ const struct flash_info spi_nor_ids[] = {
>>>   			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>>>   	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
>>>   			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
>>> +	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,
>>> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) 
>>> },
>> 
>> Otherwise looks good to me,
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> 
>> 
