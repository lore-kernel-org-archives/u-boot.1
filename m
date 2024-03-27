Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0412BC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC478803A;
	Wed, 27 Mar 2024 14:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fm2lerio";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5524788044; Wed, 27 Mar 2024 14:10:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A5C87FCC
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb94=LC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711545020;
 bh=ollVJFNGANWmnr569HQQ0jyJ/tKAVkp0GH5AbDP/A68=;
 b=fm2lerio8vZIMATLEwCf1mQSbKm4S9/DDTt+YRtpIBDQLTWktaW9Yf9b3KoRBpG/P/YN1layR
 l95rWYdRLR5mo3Wayny2d4qswFiOkGVXurfpPdSmFdPOL7EV4r3xjno/HT3ca8FzGlmQkyWXTZ+
 5V9PEyHvBQGGEPKDCp8RLfGLmNVTfUOf+W1hNZpNMSBMaLKek7zSvKrWf/HohuFPEiUCmBmAQdU
 8kuY/Gx8AcboeuqRPty2wolVPotW/ZAvaO76xJHZ2ZM4OaR1NmngTwf5VY+9zvDrTRmFqVEamhJ
 BhM6FOtn97TnVON3x8hyMjdaxfXibhAUvcJ9aJo183NA==
Message-ID: <e6a5bfde-7b9e-4da4-9f11-3252e423c670@kwiboo.se>
Date: Wed, 27 Mar 2024 14:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3588: Add Support for RAM Defines from
 ATAGs
To: Chris Morgan <macroalpha82@gmail.com>, Chris Morgan
 <macromorgan@hotmail.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: xypron.glpk@gmx.de, cym@rock-chips.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 eugen.hristev@collabora.com, u-boot@lists.denx.de
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-3-macroalpha82@gmail.com>
 <a73576d7-5c7c-49d5-bac3-682f669c2197@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a73576d7-5c7c-49d5-bac3-682f669c2197@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66041ab50bfcab107cb79353
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

Hi Chris and Quentin,

On 2024-03-27 11:51, Quentin Schulz wrote:
> Hi Chris,
> 
> On 3/26/24 21:49, Chris Morgan wrote:
>> From: Chris Morgan <macromorgan@hotmail.com>
>>
>> Add support for defining the usable RAM from ATAGs provided by the
>> Rockchip binary TPL loader. This allows us to automatically account
>> for necessary memory holes on RK3588 devices with 16GB of RAM or
>> more, as well as ensure we can use the full amount of RAM available.
>>
>> In the event we can't cleanly read the ATAG values from RAM or are
>> not running an RK3588 board, simply fall back to the old method of
>> detecting the RAM.
>>
>> Tested on Indiedroid Nova with 4GB and 16GB of RAM.
>>
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> ---
>>   arch/arm/mach-rockchip/sdram.c | 58 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
>> index 0d9a0aef6f..58b78466b0 100644
>> --- a/arch/arm/mach-rockchip/sdram.c
>> +++ b/arch/arm/mach-rockchip/sdram.c
>> @@ -10,6 +10,7 @@
>>   #include <ram.h>
>>   #include <asm/global_data.h>
>>   #include <asm/io.h>
>> +#include <asm/arch-rockchip/atags.h>
>>   #include <asm/arch-rockchip/sdram.h>
>>   #include <dm/uclass-internal.h>
>>   
>> @@ -35,12 +36,69 @@ struct tos_parameter_t {
>>   	s64 reserve[8];
>>   };
>>   
>> +/*
>> + * Read the ATAGs to identify all the memory banks. If we can't do it
>> + * cleanly return 1 to note an unsuccessful attempt, otherwise return
>> + * 0 for a successful attempt.
> 
> Return a valid error code instead? Negative if possible?
> 
>> + */
>> +int rockchip_atag_ram_banks(void)
>> +{
>> +	struct tag *t;
>> +	int bank_cnt;
>> +	size_t tmp;
>> +
>> +	if (!CONFIG_IS_ENABLED(ARM64) && !CONFIG_IS_ENABLED(ROCKCHIP_RK3588))

CONFIG_IS_ENABLED should only be used if there is an xPL variant of the
config symbol, IS_ENABLED should probably be used here. Also I would
possible check for !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) instead.

>> +		return 1;
>> +
>> +	t = atags_get_tag(ATAG_DDR_MEM);
> 
> I believe this will not compile for non RK3588 because this function is 
> not defined.
> 
> There are a few ways to handle this:
> - always compile atags.c but have ifdefs there with inline functions 
> returning -ENOTSUPP or something like that.
> 
>> +	if (!t)
>> +		return 1;
>> +
> 
> -ENOENT? -ENOXIO?
> 
>> +	bank_cnt = t->u.ddr_mem.count;
>> +
>> +	/*
>> +	 * Check to make sure the first bank ends at 0xf0000000, if it
> 
> Explain what 0xf0000000 represents here.

You should use SDRAM_MAX_SIZE instead of 0xf0000000.

> 
>> +	 * does not fall back to the other methods of RAM bank
>> +	 * detection.
> 
> Do we really need the first bank to ends exactly at 0xf0000000? Or 
> should we rather make sure that it doesn't go into that space? (so 
> anything below that would be fine?). I assume this is the result of some 
> experiments, what did you learn from those boards?

The Rockchip TPL will report differently depending on model/build.

Some report regions that can be used as-is, other report actual memory.
So we must handle the case where first bank is reported for
0 - SDRAM_MAX_SIZE and the other case when full memory, 0 - 8 GiB, is
reported and skips the SDRAM_MAX_SIZE - 4GiB hw regs space.

Here are dumps of ddr_mem atag on RK3568/RK3588:

RK3588: https://gist.github.com/Kwiboo/1c020d37e3adbc9d0d79dc003d921977
RK3568: https://gist.github.com/Kwiboo/6d983693c79365b43c330eb3191cbace

  count = number of banks
  bank[x] = start addr
  bank[x + count] = size

> 
>> +	 */
>> +	if (t->u.ddr_mem.bank[t->u.ddr_mem.count] != 0xf0000000)
>> +		return 1;
>> +
> 
> -EINVAL?
> 
>> +	/*
>> +	 * Iterate over the RAM banks. If the start address of bank 0
>> +	 * is less than or equal to 0x200000, set it to 0x200000 to
>> +	 * reserve room for A-TF. Make sure the size of bank 0 doesn't
>> +	 * bleed into the address space for hardware (starting at
>> +	 * 0xf0000000). Banks 1 and on can be defined as-is.
>> +	 */
>> +	for (int i = 0; i < (t->u.ddr_mem.count); i++) {
> 
> This may result in out-of-bounds access. Indeed gd->bd->bi_dram is a 
> build-time allocated array of size CONFIG_NR_DRAM_BANKS.
> 
> So I would recommend printing an error message if t->u.ddr_mem.count is 
> bigger than CONFIG_NR_DRAM_BANKS. I assume we may want to still boot but 
> with less RAM in that case? If we do, then only loop for the min between 
> t->u.ddr_mem.count and CONFIG_NR_DRAM_BANKS.
> 
>> +		if (i == 0) {
>> +			if (t->u.ddr_mem.bank[i] <= 0x200000)
>> +				gd->bd->bi_dram[i].start = 0x200000;
>> +			else
>> +				gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
>> +			tmp = gd->bd->bi_dram[i].start + t->u.ddr_mem.bank[(bank_cnt + i)];
> 
> This is incorrect, it may be offsetting up to 0x200000. If it's offset, 
> you need to remove it from the address size.
> 
> """
> if (t->u.ddr_mem.bank[i] <= 0x200000)
>      tmp -= 0x200000;
> """
> 
>> +			if (tmp > 0xf0000000)
>> +				gd->bd->bi_dram[i].size = 0xf0000000 - gd->bd->bi_dram[i].start;
> 
> Shouldn't we do this check for all declared address spaces, not only the 
> first one?
> 
>> +			else
>> +				gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];
> 
> You may need to remove the 0x200000 offset here as well, e.g. with
> 
> """
> 
> if (tmp > 0xf0000000)
>      tmp = 0xf0000000;
> 
> gd->bd->bi_dram[i].size = tmp - gd->bd->bi_dram[i].start;
> """
> 
> Renaming tmp into end would probably also help figure out what it's 
> supposed to contain.
> 
>> +		} else {
>> +			gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
>> +			gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];
>> +		}
>> +	};
>> +
> 
> You can make this for-loop logic a bit more readable (well, to me :) ) with:
> 
> """
> /* Iterate over the RAM banks. */
> /* If the start address of bank 0
>   * is less than or equal to 0x200000, set it to 0x200000 to
>   * reserve room for A-TF. Make sure the size of bank 0 doesn't
>   * bleed into the address space for hardware (starting at
>   * 0xf0000000).
>   */
> if (t->u.ddr_mem.bank[0] <= 0x200000)
>      gd->bd->bi_dram[0].start = 0x200000;
> else
>      gd->bd->bi_dram[0].start = t->u.ddr_mem.bank[0];
> 
> tmp = gd->bd->bi_dram[0].start + t->u.ddr_mem.bank[bank_cnt];
> 
> if (tmp > 0xf0000000)
>      gd->bd->bi_dram[0].size = 0xf0000000 - gd->bd->bi_dram[0].start;
> else
>      gd->bd->bi_dram[0].size = t->u.ddr_mem.bank[bank_cnt];
> 
> for (int i = 1; i < (t->u.ddr_mem.count); i++) {
>      gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
>      gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];
> }
> """
> 
> Side question, do gd->bd->bi_dram have to store banks in a specific 
> order (e.g. from lowest (0) to highest (0xfffffff) location in memory) 
> or can it be random? If the former, is Rockchip guaranteeing us that the 
> ATAGS will always be ordered properly or should we order them at runtime 
> too?

Based on dumps of multiple different versions and models, the banks have
always been reported in correct order.

Regards,
Jonas

> 
> Cheers,
> Quentin

