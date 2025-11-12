Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D08CD4842
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED1683CEA;
	Wed, 12 Nov 2025 21:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="DRWcznmN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B2183CEB; Wed, 12 Nov 2025 21:25:43 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B6783C62
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1762979139;
 bh=T1PLyqlOP3qNMBKSqeB6LUXejCNSVhjD7hHwLEOmLn8=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=DRWcznmNlnM0xYonEccot4t75jj9feo+x+0EMxaVjJa7a9tnzaLXjYMC88dyEEuSO
 Vg4a5SkEL/x6evvRhSRNEEP76WwO+zjJ7eUccN0LEL98nG/rTGnZYAs1YVBhTxIDWA
 Ny3Q9iz8sH6r2fItomgzz5sWyMhel/jeoUB5FNshJiTI1k7M3AKGst4henaRHn1EpP
 hNCrR7rU6BNOGLrOtI+an2Dv4TH6A2nj/0EsEkku4pLa0lNoZ8Wej68j40Hs7xgn7J
 bgqv6XihWlNwpPT24iRFVl/8tXQzpM2yMTdBhIbqN4kN5bZfXT9Y3EaukGV/IqsWJv
 Px+2SQxFEQ/3g==
Received: from [192.168.2.54] (unknown [143.105.117.4])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 78A43B2208BA;
 Wed, 12 Nov 2025 21:25:38 +0100 (CET)
Message-ID: <4e05dfc1-d640-44a3-bcb5-9f4622b7c43b@freeshell.de>
Date: Wed, 12 Nov 2025 12:25:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
To: Christoph Stoidner <C.Stoidner@phytec.de>
References: <20251031145951.535376-1-c.stoidner@phytec.de>
 <a41edf4c-39f5-432e-8eeb-9426dba89a17@freeshell.de>
 <DB9P195MB12122313AC9E54232C3B713D97CCA@DB9P195MB1212.EURP195.PROD.OUTLOOK.COM>
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: E Shattow <e@freeshell.de>
In-Reply-To: <DB9P195MB12122313AC9E54232C3B713D97CCA@DB9P195MB1212.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
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



On 11/12/25 10:13, Christoph Stoidner wrote:
> Hello,  sorry, did you send that mail only direct to me? I cannot find it in the Mailinglist.
> 
> I don't want to bother you. However would you mind to send it also to the list, to have it transparent for all?
> 
> Regards,
> Christoph

Okay, sorry I missed this before. CC: U-Boot Mailing List

-E

> 
> 
> ________________________________
> Von: E Shattow <e@freeshell.de>
> Gesendet: Freitag, 31. Oktober 2025 22:27
> An: Christoph Stoidner <c.stoidner@phytec.de>
> Betreff: Re: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
> 
> 
> On 10/31/25 07:59, Christoph Stoidner wrote:
>> mmc/sd specification requires a 1 ms delay (stable supply voltage)
>> after vdd was enabled and before issuing first command.
>>
>> For most sdcard/soc combinations, the missing delay seems to be not a
>> problem because the processing time between enabling vdd and the first
>> command is often hundreds of microseconds or more. However, in our
>> specific case, some sdcards were not detected by u-boot:
>> * soc: NXP i.MX 93
>> * sdcards: SanDisk Ultra, 64GB micro SDXC 1,
>>            MediaRange, 8GB, SDHC
>> * measured time between vdd and first command: approx. 784us
>> * symptom: both sdcards did not respond at all to first commands,
>>            u-boot mmc subsystem ran into timeout and stops to
>>            initialize the cards
>>
>> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/mmc.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>> index ec61ed92e86..2093d169094 100644
>> --- a/drivers/mmc/mmc.c
>> +++ b/drivers/mmc/mmc.c
>> @@ -2878,11 +2878,18 @@ static int mmc_power_cycle(struct mmc *mmc)
>>                return ret;
>>
>>        /*
>> -      * SD spec recommends at least 1ms of delay. Let's wait for 2ms
>> -      * to be on the safer side.
>> +      * SD spec recommends at least 1ms of 'power on' delay.
>> +      * Let's wait for 2ms to be on the safer side.
>>         */
>>        udelay(2000);
>> -     return mmc_power_on(mmc);
>> +     ret = mmc_power_on(mmc);
>> +
>> +     /*
>> +      * SD spec recommends at least 1ms of 'stable supply voltage' delay.
>> +      * Let's wait for 2ms to be on the safer side.
>> +      */
>> +     udelay(2000);
>> +     return ret;
>>  }
>>
>>  int mmc_get_op_cond(struct mmc *mmc, bool quiet)
> 
> Let's do what it says. Would udelay(1000) ever possibly complete faster
> than the recommended time in the specification ?
> 
>          /*
> -        * SD spec recommends at least 1ms of delay. Let's wait for 2ms
> -        * to be on the safer side.
> +        * SD spec requires:
> +        * 1ms of delay 'power on' before power on
> +        * 1ms of 'stable supply voltage' after power on
>           */
>          udelay(1000);
> -       return mmc_power_on(mmc);
> +       ret = mmc_power_on(mmc);
> +       udelay(1000);
> +       return ret;
>  }
> 
> To follow the specification recommendations exactly?
> 
> Also, why add the delay before returning from mmc_power_on() in
> mmc_power_cycle() and not in mmc_power_on() itself?
> 
> -E
> 

