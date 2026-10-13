Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC783CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 00:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11B714052E;
	Tue, 13 Oct 2026 00:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJU1rvlPthEO; Tue, 13 Oct 2026 00:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39E2C4052A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791852335;
	b=FGzvUZxbTBw3IY1u2n2KuqHgew4iqSwutNyR7QZ3rR1RJD72XC3CMjAg8bxTVdfsG9oJ
	 JQbUgm6M20ydKjApj6wMuMk9Lq6iinAl89e6oL2kzfZqHCFn0+FMMEcm/rA8XWnCqV/5r
	 C6429XAKnPFdEdAQZz2kUO2ysTWWA/WWNZ57gVfRDBMUsh6I5hf89gLCHTn8neHKub5SD
	 rxWqqFgPxJoIOD6z0jjZjpqxGKfjU5SVrkazQC4ZEGnGwT9zaUvXtlI+m3LOSYovndDsj
	 Uod5IAQ3794xDEkCESmRtIKTso/BVAJLuGq1AN+I2VC2JUQi1kR555UYQl/Af7SK2fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791852335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tmJQXAf1AQT3LfR51nesIX/ogXDcL3gBAruUy3LXviE=;
	b=TT48rUn+B6u8vV7+Kcx8709uWGo6WEvbip73BwlFONMDMDshWgFRMq0SzcKgc7lzqPqr
	 GUnaJlZz4HHmtVLs1qZBRyGOPRxLwyDzU7uxHdUpLsv0fmnAxDB4TZjMS41+lwOoWaJIA
	 QIydnAo+Ocnwgrjfi+u6q4mW0RVGsp1QUM18epk/aru4p6WqxTrlNMeiUYzPUUhBMQUb7
	 hku9t/d2gTpiK/34Hegr0lDx0IESokuOe5pMQ/DdErWQv+4fTzhfSpwyKx2tPo5Z0qvgM
	 B8f+Qil8MCR/fYskIqQv4yltWlr1uTBFAfb6yKb3yAVfqYV99RfuqJ3EUjERvdKjeYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=F93P1AvS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791852335;
	bh=tmJQXAf1AQT3LfR51nesIX/ogXDcL3gBAruUy3LXviE=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=is2jVRwvxLdKKlVVCqnTdtvNfA/itXHKaVQeIjc6b+HMEOXVhXkLEEYGDRMDHgKGb
	 HIXHUFBBW/lh7SDNTcCi84C0lN1Effx/SkD5t1q8xAT41Mj1Q+159fbn7/4NgP5yo+
	 TImK3QfRUk3+zUpjsWgKjPfQrRcHvIbRPIvRqCOjY5RTNjKVpuXC95kQH7s557KbuW
	 eJijMg0T3KLgeZoLbnEf9EVC11q4reN9SoFrZzuebBhr48SQ1Wa4lu5QSdS7kNgVKC
	 7WBU/++PA0s94s4UbTrXWsOCdJEit3rkWIY+3E0TNxenfp5oxhG1upD1EHQYsM877q
	 VkDrNSr6W4vAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39E2C4052A;
	Tue, 13 Oct 2026 00:45:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7A7A362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9A424052A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zMcMnbFiv-kL for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 00:45:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8AFD40520
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791852333;
 b=F1EfdxA9e5YSnS5QgwAi3SyQlGJDxfR8NaeF7q7HJl3EwPMQu8tq4p8vncBjYk7qZyuO
 mnGaXqYcYYbQMAQaRCibQMxiGC7tkolAVCXRlY9leXBohTeUvSPoWgB4LYg9OHtDT0HDx
 ilPoWNgo5H8mKhl5c3BUOpfcbatS4IPYtY5peRqZ5ZeocnpZ/JQmYPUK55svqH9oeBwZv
 fmlUTvWMOKqUpnUvI43syatkPs3xU91Ex4cviVbf4xkz9Auz9sK+BJnVMNJq3ca62hp8g
 ozDkr4m8ArdBFAP3geWRRyZvHKiUJXudA06zKrWeeRa+XbSH0DTdtsTEotGtQZOJvxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791852333;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=tmJQXAf1AQT3LfR51nesIX/ogXDcL3gBAruUy3LXviE=;
 b=LlBzF+iv2qfCidS3dS/uvXrPxxlM6kVjDRwdYdI3ttvbBsZvE49xWaVr/TpFh3zW3rfB
 W2RUU2IuxKZ32VI8kXGoEyBSbEUXYdXlgKa88z7mPoRtUdGiXMtbPn3Vp2PfSGaDt+620
 z6kgAeWHFj55ReM7GWJtoHwBDiO6h5K+Iwk0FDExuFkpwLX5DBbZXIn80HMuPk07sLBbK
 jckVgEKhax6fDsdlvTv+qlbeFNX/5U2HHAamC5MlxkJh7ersJ23Jy52e+5wj92UBLX/pS
 TxcJ/JkbYtyDtIsKnkhSha64ZmLpoxknOhrVMPR5dnjP5l2qSMcBzmRXLKDe5lUHF1A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=F93P1AvS; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=F93P1AvS
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8AFD40520
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:45:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 302E41089CA; Tue, 13 Oct 2026 02:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791852322;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=tmJQXAf1AQT3LfR51nesIX/ogXDcL3gBAruUy3LXviE=;
 b=F93P1AvS1tjhoWZZHD/Cz8GOcmVww2dsqSCIrs0K+MHHZHpLTBlDqSsfb8bNaf2nQO37lN
 /uUGgv2CgqFjx/oYAq5/LB4FEf5X+SgVm7iTcXnaR9Y8RDEPGnATyPFTHKDRSBFw0Aj7sw
 uFxQywUgTnmE+gjWOYYOXIyT2MBtbP0GSAdCO2MSGE9SNg9ysizyEMBTGermOBbH52yUhP
 O5HW4szw+e5FRlGDJWDfUqOZn755hEkojGDgkRKWfPprHrsFzL+w+nPXpy/S0C9KsCkBfA
 b6Eai04qmFyhyW+GjWOQ+yf0dJl2qNocDd8q1OFVBY+sOvQlQraqb7HaFGFWTg==
Message-ID: <21caaf22-db18-47be-54a7-c88aa6a28757@nabladev.com>
Date: Tue, 13 Oct 2026 02:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini <trini@konsulko.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-2-hs@nabladev.com>
 <CAFLszThVWu+8sLzkyyDHgEh5ipM6YjBH7xLsP=xi=p9JccuR8w@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2 1/5] mtd: refuse an erase on a device that cannot erase
In-Reply-To: <CAFLszThVWu+8sLzkyyDHgEh5ipM6YjBH7xLsP=xi=p9JccuR8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Simon,

On 09.10.26 09:00, Simon Glass wrote:
> Hi Heiko,
> 
> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>> mtd: refuse an erase on a device that cannot erase
>>
>> mtd_erase() calls mtd->_erase() without checking that the driver has
>> one, so a device which does not provide one will end in accessing
>> NULL pointer.
>>
>> MTD_NO_ERASE flag exists, but nobody reads it yet.
> 
> This sentence is confusing. spi-nor-core.c already sets MTD_NO_ERASE
> for SPI_NOR_NO_ERASE parts, which still have an _erase and a non-zero
> erasesize. This patch doesn't read the flag either, so it would be
> clearer to drop the sentence or to say why the check uses erasesize
> and _erase rather than the flag. Also, how about 'jumps to a NULL
> pointer' instead of 'will end in accessing NULL pointer'?

I drop the sentence which is wrong. Also reword to "jumps to a NULL
pointer"

> 
>>
>> Linux guards mtd_erase() with
>>
>>          if (!mtd->erasesize || !master->_erase)
>>                  return -ENOTSUPP;
>>
>> so do the same in U-Boot, but with EOPNOTSUPP as the error code,
>> as checkpatch asks for ("ENOTSUPP is not a SUSV4 error code, prefer
>> EOPNOTSUPP").
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> drivers/mtd/mtdcore.c | 3 +++
>>   drivers/mtd/mtdpart.c | 3 ++-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>> @@ -930,6 +930,9 @@ EXPORT_SYMBOL_GPL(__put_mtd_device);
>>
>>   int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
>>   {
>> +     if (!mtd->erasesize || !mtd->_erase)
>> +             return -EOPNOTSUPP;
>> +
> 
>  From what I can see, but 'mtd erase' never gets this far.
> do_mtd_erase() first calls mtd_is_aligned_with_block_size(), which
> does do_div(size, mtd->erasesize), then mtd_div_by_eb(). With
> erasesize == 0 both divide by zero.
> 
> do_mtd_io() also calls mtd_is_aligned_with_block_size(mtd, off) for
> every page, so I think 'mtd read' and 'mtd write' hit it too. The test
> in patch 5 calls mtd_read() and mtd_write() directly, so it doesn't
> catch this.
> 
> Please can you make mtd_is_aligned_with_block_size() cope with
> erasesize == 0 (e.g. treating it as 'no blocks'), and have
> do_mtd_erase() bail out early with a message for such a device? A
> small test that runs 'mtd read', 'mtd write' and 'mtd erase' against
> the SRAM would cover it.

Of course! I think I start with a test/cmd/mtd.c

> 
>> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
>> @@ -654,7 +654,8 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
>> -     slave->_erase = part_erase;
>> +     if (master->_erase)
>> +             slave->_erase = part_erase;
> 
> This is fine, but please mention it in the commit message: a partition
> only gets part_erase() when its master has an _erase, so part_erase()
> can't call through a NULL master->_erase either.

Will add this.

> 
> With the above:
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Will add this too, thanks for your review!

bye,
Heiko
> 
> Regards,
> Simon
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
