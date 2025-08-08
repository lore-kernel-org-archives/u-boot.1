Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A4FC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA76B846CE;
	Fri,  8 Aug 2025 13:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="beUVgG3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6F5846DC; Fri,  8 Aug 2025 13:58:24 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D6F83CD3
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bz2bv2WmYz9tKq;
 Fri,  8 Aug 2025 13:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754654299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuwVeHFge7y6kCoSNyBcatOHb7IT24jWTBZ9dT+XaNw=;
 b=beUVgG3zYBiTy/MJB9SGDDoyVw3QGlKOgrGU3/VQyJKW8PPBBDTAzVSRrdmo97rDGudcj9
 04VJH3/+Jutd3+pBhQJtC1QCzGCrVBLgEw9iA4jt7OGbTNIOY9hyEp7PLIfivV57olXvGy
 GOxw3ue1w4GPVcfzq3q/qQJcYO1AzodtVbGsvf8qSLeLp5kAIG911CP3mrzUwQ4YFImZLK
 ouJbZEslmgeR/atZeM55feqfJijLHF3rahxSglJ//F/AHycTkBsPtpBg5XTeUj0X0Zjm6x
 bzOs4XMeSD0jxL1WFQwIJQyI6cPs5JJ1gYsRzjvpWxQIkVfPpoHlaSKE5TvKtQ==
Message-ID: <0d7db528-52e8-4e79-aeaf-2979c8efa344@mailbox.org>
Date: Fri, 8 Aug 2025 13:58:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] sata: sata_mv: Remove always true test
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250722-sata_mv-v1-1-ad4f3589a67b@linaro.org>
 <f7b3bf62-5255-496b-840f-ecb935991d0b@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <f7b3bf62-5255-496b-840f-ecb935991d0b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6cdaa8f9385f463dd6d
X-MBO-RS-META: e3tgpfseu9mpzozs3nw91geqejoxibka
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

On 07.08.25 17:09, Andrew Goodbody wrote:
> On 22/07/2025 17:42, Andrew Goodbody wrote:
>> Smatch reported an issue with a test that was always true in that an
>> unsigned variable will always be >= to zero. This led to a closer look
>> at the code which showed that some static functions returned values that
>> were always discarded so make those functions return void. Also make
>> the passing of block counts in those functions always use lbaint_t.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

>> ---
>>   drivers/ata/sata_mv.c | 43 ++++++++++++++++---------------------------
>>   1 file changed, 16 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index ac78760a33e..82dc5304dde 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -363,7 +363,7 @@ static int mv_start_edma_engine(struct udevice 
>> *dev, int port)
>>       return 0;
>>   }
>> -static int mv_reset_channel(struct udevice *dev, int port)
>> +static void mv_reset_channel(struct udevice *dev, int port)
>>   {
>>       struct mv_priv *priv = dev_get_plat(dev);
>> @@ -374,8 +374,6 @@ static int mv_reset_channel(struct udevice *dev, 
>> int port)
>>       udelay(25);        /* allow reset propagation */
>>       out_le32(priv->regbase + EDMA_CMD, 0);
>>       mdelay(10);
>> -
>> -    return 0;
>>   }
>>   static void mv_reset_port(struct udevice *dev, int port)
>> @@ -578,9 +576,9 @@ static void process_responses(struct udevice *dev, 
>> int port)
>>       }
>>   }
>> -static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
>> -                   struct sata_fis_h2d *cfis,
>> -                   u8 *buffer, u32 len, u32 iswrite)
>> +static void mv_ata_exec_ata_cmd(struct udevice *dev, int port,
>> +                struct sata_fis_h2d *cfis,
>> +                u8 *buffer, labint_t len, u32 iswrite)
>>   {
>>       struct mv_priv *priv = dev_get_plat(dev);
>>       struct crqb *req;
>> @@ -589,7 +587,7 @@ static int mv_ata_exec_ata_cmd(struct udevice 
>> *dev, int port,
>>       if (len >= 64 * 1024) {
>>           printf("We only support <64K transfers for now\n");
>> -        return -1;
>> +        return;
>>       }
>>       /* Initialize request */
>> @@ -653,7 +651,7 @@ static int mv_ata_exec_ata_cmd(struct udevice 
>> *dev, int port,
>>       /* Wait for completion */
>>       if (wait_dma_completion(dev, port, slot, 10000)) {
>>           printf("ATA operation timed out\n");
>> -        return -1;
>> +        return;
>>       }
>>       process_responses(dev, port);
>> @@ -664,16 +662,13 @@ static int mv_ata_exec_ata_cmd(struct udevice 
>> *dev, int port,
>>           invalidate_dcache_range(start,
>>                       start + ALIGN(len, ARCH_DMA_MINALIGN));
>>       }
>> -
>> -    return len;
>>   }
>> -static u32 mv_sata_rw_cmd_ext(struct udevice *dev, int port, lbaint_t 
>> start,
>> -                  u32 blkcnt,
>> -                  u8 *buffer, int is_write)
>> +static void mv_sata_rw_cmd_ext(struct udevice *dev, int port, 
>> lbaint_t start,
>> +                   labint_t blkcnt,
>> +                   u8 *buffer, int is_write)
>>   {
>>       struct sata_fis_h2d cfis;
>> -    u32 res;
>>       u64 block;
>>       block = (u64)start;
>> @@ -693,18 +688,15 @@ static u32 mv_sata_rw_cmd_ext(struct udevice 
>> *dev, int port, lbaint_t start,
>>       cfis.sector_count_exp = (blkcnt >> 8) & 0xff;
>>       cfis.sector_count = blkcnt & 0xff;
>> -    res = mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
>> -                  ATA_SECT_SIZE * blkcnt, is_write);
>> -
>> -    return res >= 0 ? blkcnt : res;
>> +    mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
>> +                ATA_SECT_SIZE * blkcnt, is_write);
>>   }
>> -static u32 mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t start,
>> -              u32 blkcnt, u8 *buffer, int is_write)
>> +static void mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t 
>> start,
>> +               lbaint_t blkcnt, u8 *buffer, int is_write)
>>   {
>>       struct sata_fis_h2d cfis;
>>       lbaint_t block;
>> -    u32 res;
>>       block = start;
>> @@ -720,19 +712,16 @@ static u32 mv_sata_rw_cmd(struct udevice *dev, 
>> int port, lbaint_t start,
>>       cfis.lba_low = block & 0xff;
>>       cfis.sector_count = (u8)(blkcnt & 0xff);
>> -    res = mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
>> -                  ATA_SECT_SIZE * blkcnt, is_write);
>> -
>> -    return res >= 0 ? blkcnt : res;
>> +    mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
>> +                ATA_SECT_SIZE * blkcnt, is_write);
>>   }
>>   static u32 ata_low_level_rw(struct udevice *dev, int port, lbaint_t 
>> blknr,
>>                   lbaint_t blkcnt, void *buffer, int is_write)
>>   {
>>       struct blk_desc *desc = dev_get_uclass_plat(dev);
>> -    lbaint_t start, blks;
>> +    lbaint_t start, blks, max_blks;
>>       u8 *addr;
>> -    int max_blks;
>>       debug("%s: " LBAFU " " LBAFU "\n", __func__, blknr, blkcnt);
>>
>> ---
>> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
>> change-id: 20250722-sata_mv-40e704eb9b2b
>>
>> Best regards,
> 
> Are there any comments for thsi patch please?
> 
> Thanks,
> Andrew
> 

