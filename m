Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5B3C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DDDD82B07;
	Tue, 10 Jun 2025 17:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="W3bNaY8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A6882B0E; Tue, 10 Jun 2025 17:41:51 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF6BA8004F
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ben.dooks@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f/SDA8qvTFTGy+62t95FhmQSkmJgTJe2hV1Aa95/ZYk=; b=W3bNaY8c1hHKbDxqbpnap7zwQv
 mYir9itDQiTkaZ4jSIC5PbHH4bFgiMHr6lVPHZm2gj3kZ+vMI6BKo7Sz4oUI5l5wtiml4SnONkGRe
 m9oxFUOfzedIXmKNiEF3+U+1xM88afwurMj8RAaCgef3LjrO3g4WR0C53FY1DJascuwruQfmiCQjX
 aGjsSATmbOyorBbrljmcz4QdxkUvyxmzPU/abkx6m3SFcO2SxMkGHKvK8u1rT1oAfmAL8QN/F7KiT
 l88TiW7HyxGxTYlhn6UnHOZZPDadcXGZNkoOrOM5gRWTCqWFlOGKRtkwViShU8CqiK1fO/w0Gbggo
 IEVH+mSQ==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uP16U-00C2Nz-NO; Tue, 10 Jun 2025 16:41:34 +0100
Message-ID: <912f1532-14cc-4959-822a-b69e64aff87c@codethink.co.uk>
Date: Tue, 10 Jun 2025 16:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: byteorder: add test for big-endian
To: Tom Rini <trini@konsulko.com>
Cc: rick@andestech.com, ycliang@pr-suspensions-neuweb-biz.expedrion.biz,
 u-boot@lists.denx.de, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk
References: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
 <20250610151850.1673111-3-ben.dooks@codethink.co.uk>
 <20250610153354.GC1382132@bill-the-cat>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20250610153354.GC1382132@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/06/2025 16:33, Tom Rini wrote:
> On Tue, Jun 10, 2025 at 04:18:50PM +0100, Ben Dooks wrote:
> 
>> Test for big-endian either via __RISCVEB__ which migth be
>> rather old, or check the BYTE_ORDER if the compiler defines
>> it (which should be any modern gcc like v12)
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   arch/riscv/include/asm/byteorder.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/byteorder.h b/arch/riscv/include/asm/byteorder.h
>> index d26ac5688fa..3140c1f585e 100644
>> --- a/arch/riscv/include/asm/byteorder.h
>> +++ b/arch/riscv/include/asm/byteorder.h
>> @@ -26,7 +26,7 @@
>>   #  define __SWAB_64_THRU_32__
>>   #endif
>>   
>> -#ifdef __RISCVEB__
>> +#if  defined(__RISCVEB__) || (defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
>>   #include <linux/byteorder/big_endian.h>
>>   #else
>>   #include <linux/byteorder/little_endian.h>
> 
> What's this look like in the linux kernel? We should likely just mirror
> that.

We're still looking at the kernel too.

I think we could just drop the __RISCVEB__ test, I don't think anything
is defining it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
