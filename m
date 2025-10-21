Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B1CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 19:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A09802C1;
	Tue, 21 Oct 2025 21:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44F0D807C0; Tue, 21 Oct 2025 21:05:05 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96DB80107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 21:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.240])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DD1FEB2200FA;
 Tue, 21 Oct 2025 21:05:00 +0200 (CEST)
Message-ID: <9047fc22-295e-4e06-a67f-2fd2f7573458@freeshell.de>
Date: Tue, 21 Oct 2025 12:04:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 03/10] eeprom: starfive: Simplify get_ddr_size_from_eeprom()
To: Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-4-hal.feng@starfivetech.com>
 <3f7547d9-5abb-42d9-9bf8-02329ced4364@canonical.com>
 <b1a0ad61-f844-408a-81e9-078fd3b52462@freeshell.de>
 <ZQ2PR01MB1307068E11800715ED166144E6F22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307068E11800715ED166144E6F22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
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


On 10/21/25 02:20, Hal Feng wrote:
>> On 03.09.25 05:28, E Shattow wrote:
>> On 8/29/25 00:33, Heinrich Schuchardt wrote:
>>> On 29.08.25 08:09, Hal Feng wrote:
>>>> Directly return the DDR size instead of the field of 'DxxxExxx'.
>>>> Move the function description to the header file.
>>>>
>>>> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM
>>>> configuration")
>>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>>> ---
>>>>   arch/riscv/cpu/jh7110/spl.c                     |  2 +-
>>>>   arch/riscv/include/asm/arch-jh7110/eeprom.h     |  8 +++++++-
>>>>   .../visionfive2/visionfive2-i2c-eeprom.c        | 17
>>>> +++--------------
>>>>   3 files changed, 11 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/cpu/jh7110/spl.c
>>>> b/arch/riscv/cpu/jh7110/spl.c index 87aaf865246..3aece7d995b 100644
>>>> --- a/arch/riscv/cpu/jh7110/spl.c
>>>> +++ b/arch/riscv/cpu/jh7110/spl.c
>>>> @@ -41,7 +41,7 @@ int spl_dram_init(void)
>>>>       /* Read the definition of the DDR size from eeprom, and if not,
>>>>        * use the definition in DT
>>>>        */
>>>> -    size = (get_ddr_size_from_eeprom() >> 16) & 0xFF;
>>>> +    size = get_ddr_size_from_eeprom();
>>>>       if (check_ddr_size(size))
>>>>           gd->ram_size = size << 30;
>>>>   diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/
>>>> riscv/include/asm/arch-jh7110/eeprom.h
>>>> index 45ad2a5f7bc..6d0a0ba0c4a 100644
>>>> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>>> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>>> @@ -10,7 +10,13 @@
>>>>   #include <linux/types.h>
>>>>     u8 get_pcb_revision_from_eeprom(void);
>>>> -u32 get_ddr_size_from_eeprom(void);
>>>> +
>>>> +/**
>>>> + * get_ddr_size_from_eeprom() - read DDR size from EEPROM
>>>> + *
>>>> + * @return: size in GiB or 0xFF on error.
>>
>> No. This is not consistent with get_mmc_size_from_eeprom() return value
>> which uses 0 as short-circuit return value if read_eeprom() fails.
>>
>> It is not important to make the distinction here if eeprom read failed or the
>> data was not a valid size (i.e. zero from successful eeprom read).
> 
> OK. Will return 0 if read_eeprom() fails.
> 

Also note that Heinrich mentions this could become signed int for
returning a proper error code. I do not have any more opinion about
"zero" or "negative error code", either is okay. This can become signed
int in future if we will care to make a distinction between the types of
errors.

>>
>>>> + */
>>>> +u8 get_ddr_size_from_eeprom(void);
>>>>     /**
>>>>    * get_mmc_size_from_eeprom() - read eMMC size from EEPROM diff
>>>> --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/
>>>> board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>>> index 17a44020bcf..3866d07f9d4 100644
>>>> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>>> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>>> @@ -550,23 +550,12 @@ u8 get_pcb_revision_from_eeprom(void)
>>>>       return pbuf.eeprom.atom1.data.pstr[6];
>>>>   }
>>>>   -/**
>>>> - * get_ddr_size_from_eeprom - get the DDR size
>>>> - * pstr:  VF7110A1-2228-D008E000-00000001
>>>> - * VF7110A1/VF7110B1 : VisionFive JH7110A /VisionFive JH7110B
>>>> - * D008: 8GB LPDDR4
>>>> - * E000: No emmc device, ECxx: include emmc device, xx: Capacity
>>>> size[GB]
>>>> - * return: the field of 'D008E000'
>>>> - */
>>>> -
>>>> -u32 get_ddr_size_from_eeprom(void)
>>>> +u8 get_ddr_size_from_eeprom(void)
>>>>   {
>>>> -    u32 pv = 0xFFFFFFFF;
>>>> -
>>>>       if (read_eeprom())
>>>> -        return pv;
>>>> +        return 0xFF;
>>
>> No, inverted logic, see above return of 0xFF as an error condition is suspect.
> 
> Ditto.
> 
>>
>>>
>>> Let's assume somebody cleared the EEPROM and the SPI flash.
>>>
>>> Would it make sense to assume the minimum encodable RAM size (1 GiB)
>>> in this case, just to let the board boot to the console to allow
>>> writing the EEPROM with valid data again?
>>>
>>> The current patch to simplify the code looks correct.
>>>
>>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>
>>>>   -    return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
>>>> +    return (hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL) >> 16) &
>>>> 0xFF;
>>>>   }
>>>>     u32 get_mmc_size_from_eeprom(void)
>>>
>>
>> Yes, later fallback to 2G size configuration makes sense. Compatible products
>> with less than 2G do not exist and probably never will; there may be some
>> developer boards with 1G but none I have ever heard of directly in
>> conversations since 2023. The other common situation with zero or
>> uninitialized EEPROM would be a failed read of eeprom i.e. RTC module at
>> same i2c address or missing devicetree nodes at SPL phase.
>>
>> 1. DDR size detection heuristic should happen first without need of eeprom, if
>> possible.
>>
>> 2. Else warn DDR detection failed and read size from eeprom config
>>
>> 3. Else warn eeprom memory config invalid and set size set to default 2G.
> 
> Actually, if the u-boot fails to read DDR size from EEPROM, it will use the size (4GB)
> defined in the memory node of device tree. 
> 
> With some debugging, I found that the reason why the SPL fails to boot when the
> EEPROM crashing is that the u-boot FDT selection depends on the product ID read
> from EEPROM.  There is no default FDT for VF2 u-boot to use now.
> 
> One solution is that
> ------------------------------------------------------------------------------------------------
> diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> index b518560bb94..b1bacaf7996 100644
> --- a/arch/riscv/dts/binman.dtsi
> +++ b/arch/riscv/dts/binman.dtsi
> @@ -92,10 +92,7 @@
>                         };
>  
>                         configurations {
> -
> -#ifndef CONFIG_MULTI_DTB_FIT
>                                 default = "conf-1";
> -#endif
>  
>  #if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
>                                 @conf-SEQ {
> ------------------------------------------------------------------------------------------------
> which means using the first FDT (jh7110-deepcomputing-fml13v01) in OF_LIST as the
> default FDT.
> 
> Best regards,
> Hal

No, it is missing cpufreq driver and there is wrong behavior of the
memory driver, so this problem would repeat again when JH7110S is added.

Do you have a suggestion of OPP table values that are safe for both
JH7110 and JH7110S ? Can you implement cpufreq in U-Boot as mentioned
previously (on LKML discussion)?

Also, "2133" is not a frequency in Hz and anyway the memory driver in
U-Boot needs to be improved to use Common Clock Framework to get the
correct frequency.

Look for the two "FIXME" comments in
arch/riscv/dts/starfive-visionfive2-u-boot.dtsi from U-Boot
origin/master for location of what I am asking about.

When these issue are fixed then it will be easy to have a basic "jh711x"
dts configuration as the default until DTS selection is completed. This
will allow use of EEPROM update command from U-Boot.

Thank you, Hal.

-E
