Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A66D1D88D
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639BA88A3C;
	Tue, 15 Oct 2024 18:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729011341;
	bh=LlWEpDmUnZec3r2C+dYpflZfrVPuktCDVUxIiWZ3fqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OgAS0RYiXGVgr1SQSETeLk1uF3Vz0HgJj1mKPWWTl9UvJBmIudFTl1QS7MF1jaYJM
	 g5e6xISJ6tI3CHx3aSY9PLtSvFSxGeDrXPdksuR4VUdoB0jpxwkCHGEqEJzKzB8D2B
	 UgCaVISxJL88XGEc4W40SGuPORD2CXdIMb/nPYseBFmSNrJ65MKjlpM3f9O7lBfUfb
	 Q+jWh0MP5npX6yxmbyV8bXAIwFmr8OrTJ1JADu2ELlh41H8g9N40nFQgeA82ClHeEV
	 ZUMbqNpeyx8IsqQxzewfYH0VzQoxw33PZRYlld88AEXXYdep+Iei6i2Fp70qdYstPe
	 d4e6PcWA2KyMg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F2107889CA;
 Tue, 15 Oct 2024 18:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729011339;
 bh=LlWEpDmUnZec3r2C+dYpflZfrVPuktCDVUxIiWZ3fqI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pZiS0ZAQLmtlvG20idP6e8CMTVnsVmFJ1vDi7KHFaLjaC7WnvIcdnbNrsWbw0nMR4
 X5nPjIN6yu2iOiBAk++NdjpaqchcRUllNgXsPF6aMtzWXSeRMC/e1tEBXfOcY1Uhbp
 tbJzT+LsoC0UHYWH3fmCq+6QoAVBflPpmld+j6GM6MAAbLC7n8iSK7qub3Arkcjkmj
 djGY45K+kVezoY9kfBnLga0BLgPpNwYD7G33Xms/LUqd6xgbUZLnUwUXfr5VKByzYJ
 i9KTKGpYat2A92bq/m9t90PGdaW+6KjgTak8Wh11Bj9Fc/Yl6xxMooNokDhopUQOjs
 4sXn2OOJsNGrg==
Message-ID: <866aa26b-dc1e-4c64-a539-94592c6249b9@denx.de>
Date: Tue, 15 Oct 2024 17:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241014221523.2912260-1-alexthreed@gmail.com>
 <22953d33-b660-49ba-9664-845416bbc35b@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <22953d33-b660-49ba-9664-845416bbc35b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/15/24 11:34 AM, Quentin Schulz wrote:
> Hi Alex,
> 
> On 10/15/24 12:15 AM, Alex Shumsky wrote:
>> Increase rng-seed size to make Linux happy and initialize rng pool 
>> instantly.
>> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, 
>> but u-boot
>> currently provides only 8 bytes.
>> Linux 5.18 and probably some versions before it used to require 64 bytes.
>> Bump min value to 64 bytes to be on a safe side.
>>
>> Boot with 8 byte rng-seed (Linux 6.11):
>>      # dmesg | grep crng
>>      [   12.089286] random: crng init done
>> Boot with 32 byte rng-seed (Linux 6.11):
>>      # dmesg | grep crng
>>      [    0.000000] random: crng init done
>>
>> Linux source references:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
>> tree/drivers/char/random.c?h=v5.19#n551
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
>> tree/drivers/char/random.c?h=v5.18#n236
>>
>> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
>> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all 
>> Rockchip devices")
>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>
>> Changes in v4:
>> - fix typos and code style
>>
>> Changes in v3:
>> - reword warning
>> - increase default rng_seed_size to support older linux as well
>> - reword commit message
>>
>> Changes in v2:
>> - add env config knob rng_seed_size
>> - add warning for small rng_seed_size
>> - 12-character commit SHA in Fixes
>>
>>   arch/arm/mach-rockchip/board.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/ 
>> board.c
>> index 3fadf7e412..ca6404776f 100644
>> --- a/arch/arm/mach-rockchip/board.c
>> +++ b/arch/arm/mach-rockchip/board.c
>> @@ -472,9 +472,18 @@ __weak int misc_init_r(void)
>>   __weak int board_rng_seed(struct abuf *buf)
>>   {
>>       struct udevice *dev;
>> -    size_t len = 0x8;
>> +    ulong len = env_get_ulong("rng_seed_size", 10, 64);
> 
> I'm wondering if we have somewhere some documentation on the environment 
> variables that exist and what they used for because this would be a nice 
> addition. At the very least, we can mention this variable in:
> - include/fdt_support.h for the function
> - common/Kconfig for the symbol
> 
> I'm also a bit torn on the base though, I think the assumed base is 
> generally hex and not dec, so maybe we should rather have that?
It is a decimal number, similar to e.g. bootcount , hence base 10 .
