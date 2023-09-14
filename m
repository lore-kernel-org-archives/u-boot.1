Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865FEEDE98C
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 08:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F66E86E1A;
	Thu, 14 Sep 2023 10:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VHDvxK1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0016586E26; Thu, 14 Sep 2023 10:20:40 +0200 (CEST)
Received: from mail-m127225.xmail.ntesmail.com
 (mail-m127225.xmail.ntesmail.com [115.236.127.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A0786D76
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 10:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VHDvxK1Epz70Ce6+f8IgoKZabq7E9D7bY+7I3xLURpSRctQJIz3IxrsjFN6351LyWaQL7aGySacHOcTx2dGg++fhpSakAk8rRRs6bRLZ85hXVeMF4CPsU3hiM3w/NXTYn3lVTK7k0DPJorlfYMPqMz6VhN3NBuGoxge9KiaUBXo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=iuw95EEiEhXpmSYF59hjJuSoBdjHodEc7wRWhhyKVRo=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by mail-m12737.qiye.163.com (Hmail) with ESMTPA id 5E17D2A0742;
 Thu, 14 Sep 2023 16:19:36 +0800 (CST)
Message-ID: <9f11be33-0311-ad7a-5f7d-971b83902110@rock-chips.com>
Date: Thu, 14 Sep 2023 16:19:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] rockchip: include: asm: fix entering download mode
 rk3066
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <d94f5f41-b610-4345-f583-439eb1bc7c8a@gmail.com>
 <5d231e55-b85d-9ada-4444-426007067bfc@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <5d231e55-b85d-9ada-4444-426007067bfc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR9IVktMTE5MHUsaHkJKSlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8a92c63035b210kuuu5e17d2a0742
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6OSo6Hz1NNwwIERADDRgw
 IR4aCR9VSlVKTUJPTUxCTkxMSE5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUNNTUM3Bg++
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

Hi Johan,

On 2023/9/13 19:00, Johan Jonker wrote:
> Hi,
>
> Maybe put this Rockchip rk3066 patch on hold, if we can find a better solution.
> Any insider help is appreciated here.

The solution is to handle the BOOT_BROM_DOWNLOAD TAG in the ddr init 
binary, and the method

is the same with return -1 , the TAG will need to update after the 
bootrom is ready to get into USB mode.


Thanks,

- Kever

>
> The idea to test BOOT_BROM_DOWNLOAD comes from 30_LPDDR2_300MHz_DD.bin
> Setting location 0x10080028 only breaks the inner loop.
> BOOT_BROM_DOWNLOAD flag is not reset.
> It continues testing for boot blocks on NAND till nothing is left.
> For NAND up to 50 erase blocks are tested
>
> struct func_array function_table[4] =
> {
>    { &NAND_INIT, &NAND_READ_BLK, &NAND_READ_HEADER, &NAND_GET_PAGE, 50 },
>    { &SPI0_INIT, &SPI_READ_BLK, &SPI_READ_HEADER, &SPI_GET_PAGE, 13 },
>    { &SPI1_INIT, &SPI_READ_BLK, &SPI_READ_HEADER, &SPI_GET_PAGE, 13 },
>    { &EMMC_INIT, &EMMC_READ_BLK, &EMMC_READ_HEADER, &EMMC_GET_PAGE, 1 }
> };
>
> Given below part of rk3066 BROM main read loop.
>
> Proposal 1:
> In case of BOOT_BROM_DOWNLOAD return to 0x1100 instead of 0x1058.
> Also reset flag.
>
> //////////
>
> In case this TPL binary is reused to upload and to store this TPL entry function
> can be called from 3 to 4 BROM functions. Only when data comes from
> SPI, NAND or EMMC it needs to early return to BROM.
> In download mode this section is skipped when the lr register
> address is not in the functions that handles USB OTG and UART0.
>
> Proposal 2:
> Instead of a retry_counter test LR: 0x1058.
> In all other cases skip early return
>
> Let me know your ideas/advice!
> How rk3188 handle return flag?
>
> Johan
>
> /////////////////////////
>
> //main read loop rk3066 bootrom
>
>       db4:	e92d4ff3 	push	{r0, r1, r4, r5, r6, r7, r8, r9, sl, fp, lr}
>
> [..]
>
>      1050:	02840004 	addeq	r0, r4, #4
>      1054:	012fff30 	blxeq	r0
>
> // Branch to U-boot TPL early
> // LR: 0x1058
> // In case of BOOT_BROM_DOWNLOAD return to 0x1100 instead of 0x1058.
>
>      1058:	e3a01c02 	mov	r1, #512	@ 0x200
>      105c:	e2840b01 	add	r0, r4, #1024	@ 0x400
>      1060:	ebfffc49 	bl	0x18c
>      1064:	e3a01c02 	mov	r1, #512	@ 0x200
>      1068:	e2840c06 	add	r0, r4, #1536	@ 0x600
>      106c:	ebfffc46 	bl	0x18c
>      1070:	e2490004 	sub	r0, r9, #4
>      1074:	e1560000 	cmp	r6, r0
>      1078:	12844b02 	addne	r4, r4, #2048	@ 0x800
>      107c:	1a000012 	bne	0x10cc
>      1080:	e59f10cc 	ldr	r1, [pc, #204]	@ 0x1154
>      1084:	e59f00d0 	ldr	r0, [pc, #208]	@ 0x115c
>      1088:	e5d13000 	ldrb	r3, [r1]
>      108c:	e5d02000 	ldrb	r2, [r0]
>      1090:	e1530002 	cmp	r3, r2
>      1094:	05d12001 	ldrbeq	r2, [r1, #1]
>      1098:	05d03001 	ldrbeq	r3, [r0, #1]
>      109c:	01520003 	cmpeq	r2, r3
>      10a0:	1a00000d 	bne	0x10dc
>      10a4:	e5d12002 	ldrb	r2, [r1, #2]
>      10a8:	e5d03002 	ldrb	r3, [r0, #2]
>      10ac:	e1520003 	cmp	r2, r3
>      10b0:	05d00003 	ldrbeq	r0, [r0, #3]
>      10b4:	05d12003 	ldrbeq	r2, [r1, #3]
>      10b8:	01520000 	cmpeq	r2, r0
>      10bc:	1a000006 	bne	0x10dc
>
>      10c0:	e2810004 	add	r0, r1, #4
>      10c4:	e12fff30 	blx	r0
>
> // Branch to U-boot TPL full
> // LR2: 0x10c8
>
>      10c8:	e3a04206 	mov	r4, #1610612736	@ 0x60000000
>      10cc:	e5980000 	ldr	r0, [r8]
>      10d0:	e3700001 	cmn	r0, #1
>      10d4:	12866004 	addne	r6, r6, #4
>      10d8:	1affffb6 	bne	0xfb8
>      10dc:	e1570006 	cmp	r7, r6
>
>      10e0:	93a00206 	movls	r0, #1610612736	@ 0x60000000
>      10e4:	912fff30 	blxls	r0
>
> // Branch to U-boot SPL
>
>      10e8:	e28bb001 	add	fp, fp, #1
>      10ec:	e59a0010 	ldr	r0, [sl, #16]
>      10f0:	e150000b 	cmp	r0, fp
>      10f4:	92855001 	addls	r5, r5, #1
>      10f8:	9affff35 	bls	0xdd4
>      10fc:	eaffff88 	b	0xf24
>
> // End off read loop
> // In case of BOOT_BROM_DOWNLOAD return to 0x1100 instead of 0x1058 to prevent further testing.
>
>      1100:	e8bd8ffe 	pop	{r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
>
>
>
> On 9/11/23 17:37, Johan Jonker wrote:
>> When a Rockchip rk3066 board download key is pressed it hangs.
>> The rk3066 BROM doesn't have support to check the return to BROM,
>> so when a key is pressed the loop that reads data must be broken
>> by writing a "-1" to the variable that points to the next page address.
>> It then goes in download mode and waits for data on USB OTG and UART0.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   arch/arm/include/asm/arch-rockchip/boot0.h | 32 +++++++++++++++++++---
>>   1 file changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
>> index 0c375e543a5e..305461ce3751 100644
>> --- a/arch/arm/include/asm/arch-rockchip/boot0.h
>> +++ b/arch/arm/include/asm/arch-rockchip/boot0.h
>> @@ -3,6 +3,8 @@
>>    * Copyright 2017 Theobroma Systems Design und Consulting GmbH
>>    */
>>
>> +#include <asm/arch-rockchip/boot_mode.h>
>> +
>>   /*
>>    * Execution starts on the instruction following this 4-byte header
>>    * (containing the magic 'RK30', 'RK31', 'RK32' or 'RK33').  This
>> @@ -23,17 +25,39 @@
>>   	 * the first one may be overwritten, if this is the first stage
>>   	 * contained in the final image created with mkimage)...
>>   	 */
>> -	b 1f	 /* if overwritten, entry-address is at the next word */
>> +	b	1f  /* if overwritten, entry-address is at the next word */
>>   1:
>>   #endif
>>   #if CONFIG_IS_ENABLED(ROCKCHIP_EARLYRETURN_TO_BROM)
>> -	adr     r3, entry_counter
>> +#if IS_ENABLED(CONFIG_ROCKCHIP_RK3066)
>> +/*
>> + * Unlike newer Rockchip SoC models the rk3066 BROM code does not have
>> + * built-in support to enter download mode after return to BROM code.
>> + * Before a return the boot mode register must be checked for the
>> + * BOOT_BROM_DOWNLOAD flag. Writing '-1' to a location in SRAM
>> + * where the BROM stores the next page address breaks the loop
>> + * that reads boot blocks. The boot ROM code then goes into a
>> + * download mode and waits for data on USB OTG and UART0.
>> + */
>> +	ldr	r1, =BOOT_BROM_DOWNLOAD
>> +	ldr	r0, =CONFIG_ROCKCHIP_BOOT_MODE_REG
>> +	ldr	r0, [r0]
>> +	cmp	r0, r1           /* if (readl(CONFIG_ROCKCHIP_BOOT_MODE_REG) == */
>> +	bne	counter_check    /*     BOOT_BROM_DOWNLOAD) {              */
>> +	ldr	r1, =0xffffffff
>> +	ldr	r0, =0x10080028
>> +	str	r1, [r0]         /*     writel(0xffffffff, 0x10080028);    */
>> +	mov	r0, #1           /*     return 1;                          */
>> +	bx	lr               /* }                                      */
>> +counter_check:
>> +#endif
>> +	adr	r3, entry_counter
>>   	ldr	r0, [r3]
>>   	cmp	r0, #1           /* check if entry_counter == 1 */
>>   	beq	reset            /* regular bootup */
>> -	add     r0, #1
>> +	add	r0, #1
>>   	str	r0, [r3]         /* increment the entry_counter in memory */
>> -	mov     r0, #0           /* return 0 to the BROM to signal 'OK' */
>> +	mov	r0, #0           /* return 0 to the BROM to signal 'OK' */
>>   	bx	lr               /* return control to the BROM */
>>   entry_counter:
>>   	.word   0
>> --
>> 2.39.2
>>
