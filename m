Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A840C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6944D810C1;
	Thu, 30 Jul 2026 14:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CS1bG-e7j7yg; Thu, 30 Jul 2026 14:26:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72095810B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421584;
	bh=sfm7mbMfpsZphefVPkepDlK1kp4p5kx0fDF9mrIyajw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=t44IsjODCqFNhhVrLFzalFgTztITJoU/ZrCKj+KQpr0AJsIZ18MFSciOT645FBB4o
	 6yeRJZGGTcx616H2j7vlKLh8mbZIk3Z7umeeigenHv8c9RlJOlR2cKbuv+jReSeL7E
	 Fi5kOB/PFFWw/VzbIeCbHi5Wwn8b/j6tFdTUzZews4Tz50Aj+4dW3GVQ7nOOL9xM8f
	 hTlxuUtuNZHFeC0fi8RrhzeDKnUQuwm6g5qwGi2P+wAWtlZTN48eBvCSy3O86yjM3t
	 k2Mdh39hePNSv5Ax0oD/TziGCPv/WrBMQ5124zPUxk0JlEdQLTmIeMF6/gyENrUZ87
	 KayPJvWrzr7dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72095810B7;
	Thu, 30 Jul 2026 14:26:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 380A626C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 293F1810B7
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzTZzUYYHiG9 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:26:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.172;
 helo=smtp-8fac.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 49524810B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49524810B6
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [83.166.143.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49524810B6
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:26:20 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9s2H6BxGznFC;
 Thu, 30 Jul 2026 16:26:15 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h9s2G5bYkzJ2p; Thu, 30 Jul 2026 16:26:14 +0200 (CEST)
Message-ID: <6374504b-d097-42a9-898d-48240a54357f@0leil.net>
Date: Thu, 30 Jul 2026 16:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
To: Takahiro.Kuwano@infineon.com, festevam@gmail.com
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, festevam@nabladev.com, vigneshr@ti.com
References: <20260722194638.1285159-1-festevam@gmail.com>
 <a49f6530d95c4ea1908efe23d16f8843@infineon.com>
Content-Language: en-US
In-Reply-To: <a49f6530d95c4ea1908efe23d16f8843@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1785421575;
 bh=sfm7mbMfpsZphefVPkepDlK1kp4p5kx0fDF9mrIyajw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gSXQ4DPmbmfG7B5HsE0UbyftH5nUHu/hwYapO1+xn0d9+x+moQU+XUPK6xWQevzNd
 44az7uOI59flAvATChK8Ap6u3SpH+rRLvNoLF0xREs045xAp5kF5Z9jpmfXdOYcev8
 scCqZbsNHqT+qazzQ1diMEz4rIQbsUEfusfQSrZHjaWtT2yoJW6/8cyuOOXrneL7st
 TYkT8ZHA9lloHNmqw014qmdds6/2tIx3FYl/81iOkJ7s7VZxfbe+4ZyD2IFRvST7hN
 K/+fJVok06VcgRJ6Yw2d6IbuPPbOZ9ZwCJj/b105PldCLSsYunGyWB+tHC5XfuKzao
 VQEtIf7R+3JwA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=gSXQ4DPm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/29/26 10:59 AM, Takahiro.Kuwano@infineon.com wrote:
> Hi,
> 
>> From: Fabio Estevam <festevam@nabladev.com>
>>
>> Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.
>>
>> This is a 128Mbit device using 64KiB sectors and supporting 4KiB
>> erase, dual read and quad read, matching the other XM25QH128 variants.
>>
>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
>> ---
> 
> It would be nice to have Link: tag followed by datasheet URL [1].
> 

I'll add the link when applying (I'm targeting the next branch, open in 
a bit more than a week from now), no need to send a v5 for that.

Please still answer Takahiro's question below when you have time.

Thanks!
Quentin

>> Changes since v3:
>> - None.
>>
>>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index 31a2ba49a87c..90aa1025176c 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -673,6 +673,7 @@ const struct flash_info spi_nor_ids[] = {
>>          { INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>          { INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>          { INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> +       { INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> 
> Per the datasheet, this chip supports Dual/Quad ops but for my reference,
> could you let me know if you tested 1-1-4 or 1-4-4 ops?
> 
> Anyway,
> Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> 
>>          { INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>          { INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>> SPI_NOR_4B_OPCODES) },
>>          { INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>> SPI_NOR_4B_OPCODES) },
>> --
>> 2.43.0
> 
> [1] https://www.xmcwh.com/uploads/435/XM25QH128C.pdf
> 

