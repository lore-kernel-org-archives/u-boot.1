Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9DFC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 14:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50669833E1;
	Tue, 22 Jul 2025 16:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d4BeqOM0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R68I0yuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5664833E8; Tue, 22 Jul 2025 16:30:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D61683323
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 16:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bmfnh02p1z9scR;
 Tue, 22 Jul 2025 16:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753194648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Uy6jgb+YX1rgOc/oBI46cD573Q7bG7TRnouAVAvYOM=;
 b=d4BeqOM02Py2taA6+xvCezXBcJBUU95+lrGJyr/IR1LI0YXBcsQCtNFRNFyixP3T2Td+by
 kLtezqbKvBTCkvArXRKGnt8jTtOPbWdu/PijPIg3ArO2kzaSwuoLxdYecm9QFVdUsu76aD
 8A/ZTw9rtgUTgY33kj3bdcLPgka2MvJS3odBnJvF2vmiK6JlC418Pkgyp9gPCfybR9L0sD
 wPOK4gDjrQz13PKmC8yqp+6nlD+F4nqxUIzLdwfwFVFmh5fdjtg1XF8VX2ZEsdNws2tq9R
 PaqT+l3yuEm2m9c6Vocchzyt2Nfh4mBpYdGukVvc9BSiP57nxWCOLMNSrGT5Vg==
Message-ID: <260cc2f9-2270-46f1-a05f-2dea6a98e106@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753194646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Uy6jgb+YX1rgOc/oBI46cD573Q7bG7TRnouAVAvYOM=;
 b=R68I0yuBzjrGYh7SsABxmNh+lbu49ghwAiK2umyTX9NAj17TVfWN//eNejeffRSqezvPdu
 TnU7E9JrUIlB9tSDg6KFPfcbiEpSG/EENDnOLxd8GF1XAD1fshyt/QyAMLHljyl+IblLI9
 kAzLsQEhmQITRunnylqHPtRiSkr2KkENEs0nWNHwA2WAyRb7alFwxKwFUKXpQOmcqbXl6r
 1yBbiUOolrm4kSSF8QQ4EjgDxZaAw/j7UR8SDRlKXqfdZ5aq1QEfk7Zm99YD1cwV9rGSlG
 cKfppJJJGMcvFQOvgON0f/XJL6NjoSkyxvE8Qx9kIa0v2bKRFkk/zRJ+bmcpVw==
Date: Tue, 22 Jul 2025 16:30:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77Q51NW
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
 <c3c99016-b6ae-443b-ac1e-a6c5144dd815@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c3c99016-b6ae-443b-ac1e-a6c5144dd815@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qeis9y5mhjcddrdnpc4wowpnj5g3ipfp
X-MBO-RS-ID: f8b016f2b8cfd543ab2
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

On 7/22/25 11:20 AM, Tudor Ambarus wrote:
> 
> 
> On 7/20/25 8:58 PM, Marek Vasut wrote:
>> Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
>> with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
>> flash part is similar to W25Q512NWM .
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index e7e97780d7c..0383175beb5 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -591,6 +591,7 @@ const struct flash_info spi_nor_ids[] = {
>>   	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>   	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>   	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> +	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> 
> 
> The patch is looking fine. Any idea why SFDP parsing is optional?

I suspect to reduce SPL size on platforms where SPL runs into SRAM size 
constraints .

> I see a SPI_FLASH_SFDP_SUPPORT that guards it. Having SFDP optional
> introduces headaches as one has to specify all flash parameters statically
> at flash declaration. I assume it's about image size limitation. I also
> see a spi-nor-tiny.c, about which I'm not thrilled. Is there a general
> recommendation on when to split things? Maybe a question for Tom.

SPL is probably non-SFDP , unless the SRAM is big.
U-Boot should be SFDP if possible.

> Here it seems that you specify just data that can be discovered by SFDP.
> You won't need a flash entry at all if one adds a "spi-nor-generic"
> flash info that initializes the flash solely on its SFDP data, see
> linux. It would require porting the parsing of the 4bait table from
> linux and other small changes for the rest of parameters.
Or maybe synchronize the entire framework again ?
