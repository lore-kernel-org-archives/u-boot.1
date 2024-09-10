Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A420DEDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 17:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBAA9890D7;
	Tue, 10 Sep 2024 19:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ocit17ui";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cFswqDWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884D0890D5; Tue, 10 Sep 2024 19:55:03 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E4789056
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 19:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X3BDh6q6Yz9sZZ;
 Tue, 10 Sep 2024 19:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725990901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZa+UHd5fsrF8hjSHVSZA7aeL8jk3NM/ipL/aZGhL/c=;
 b=ocit17ui2wOTwhPvQGkNgkR+lnrZclfmUwbmCWsCYWntULcPKtjm27ILPdfi0Uco24LYvi
 JD7f3kqYRWVW0P5QamrmH66ovdAWsSu8GGaxmtaAbBHHGA2BTkYkpsndQfvWK4wv4Nao6s
 iHmAQlwcQ6qA1tPr8RpMavSf9s77Q2f7to0GLdX7uA6XWYtXA/793SWI7rlA6LUXoywklf
 VvfTLgBSj7J5IOpR9er6jVvflBwiT/wMq6wQg0EDOAT/B5KWOigRs0MrCqhvnLZtfMzq6P
 w1IQLf3GTkvBlBFVd9GOuvq0F2K3FxmzcA10mcd4rbXQe4DngOSxMVE4ymBhyA==
Message-ID: <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725990898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZa+UHd5fsrF8hjSHVSZA7aeL8jk3NM/ipL/aZGhL/c=;
 b=cFswqDWH6FeAmP7MnhqrFq9cC2iz9X5ueUFsVhMi1wJb366iOVNnMhee9jP4J94ormbZFy
 bMSeSi2oHALnsCj41DkP3zGPQYTZCe0eQhd5QhJT3B0BgC62ggXR3HzsGfSDW6xFRo2oXa
 V+MivYSPV0ys963b7CUi2nFEaXkXFzeRAhLOx+z2Z1uXERejnuj4u8ZEgjlt15+1gShuXx
 DKa7ImTR1WYrS26g/CYJF0tkq1ZXSsDtmJu8ZXiFGSRyqP1xBwtxbhnZ5L1cIcb72ZN2if
 EjX+V9oO7sJdsicYRSlyfPXWvkcW2YchQfwLddzESuF5U7qr6JJk44pgkJMWdQ==
Date: Tue, 10 Sep 2024 19:54:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] sh: cache: Fill in invalidate_icache_all()
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
 <20240910172151.GG4252@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240910172151.GG4252@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 264ec32601b08e0f69a
X-MBO-RS-META: 5sqhctqcwiw494judckqqq9yr4hp3nb8
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

On 9/10/24 7:21 PM, Tom Rini wrote:
> On Tue, Sep 10, 2024 at 02:15:58AM +0200, Marek Vasut wrote:
> 
>> Implement invalidate_icache_all() by clearing all V bits in
>> IC and OC. This is done by setting CCR cache control register
>> ICI and OCI bits.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   arch/sh/cpu/sh4/cache.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
>> index d3c480e79ed..99acc599965 100644
>> --- a/arch/sh/cpu/sh4/cache.c
>> +++ b/arch/sh/cpu/sh4/cache.c
>> @@ -33,8 +33,9 @@ static inline void cache_wback_all(void)
>>   	}
>>   }
>>   
>> -#define CACHE_ENABLE      0
>> -#define CACHE_DISABLE     1
>> +#define CACHE_ENABLE		0
>> +#define CACHE_DISABLE		1
>> +#define CACHE_INVALIDATE	2
>>   
>>   static int cache_control(unsigned int cmd)
>>   {
>> @@ -46,7 +47,9 @@ static int cache_control(unsigned int cmd)
>>   	if (ccr & CCR_CACHE_ENABLE)
>>   		cache_wback_all();
>>   
>> -	if (cmd == CACHE_DISABLE)
>> +	if (cmd == CACHE_INVALIDATE)
>> +		outl(CCR_CACHE_ICI | ccr, CCR);
>> +	else if (cmd == CACHE_DISABLE)
>>   		outl(CCR_CACHE_STOP, CCR);
>>   	else
>>   		outl(CCR_CACHE_INIT, CCR);
>> @@ -103,7 +106,7 @@ void icache_disable(void)
>>   
>>   void invalidate_icache_all(void)
>>   {
>> -	puts("No arch specific invalidate_icache_all available!\n");
>> +	cache_control(CACHE_INVALIDATE);
>>   }
>>   
>>   int icache_status(void)
> 
> Thanks for filling this in, I wasn't sure how the implementation would
> look from a quick skim of the linux kernel code.
I believe it should look like the above, but lemme CC Geert to be on the 
safe side.
