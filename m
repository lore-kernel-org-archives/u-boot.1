Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD26C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1981876E7;
	Wed, 31 Jan 2024 14:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ict42.de header.i=@ict42.de header.b="Mxxdvs+6";
	dkim=permerror (0-bit key) header.d=ict42.de header.i=@ict42.de header.b="o/gSPAjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3926C87808; Wed, 31 Jan 2024 14:26:17 +0100 (CET)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A54187061
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ludwig.kormann@ict42.de
ARC-Seal: i=1; a=rsa-sha256; t=1706707563; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=k9dmGSf9O5brSXVetNnRV1j1RCsxz851Lnidh/8qK3Q4mHI11mXVyQoTyWjSAPDo+1
 26t2kuz5Z9LHGl4IaCAjYFWc1Bf4WjNOQvW+sRDmoOokT41JaCpM53oMh0vyJRjtBLPf
 0TmYytEnlHJ1vmeEtMR8d/cGfpKoxcxXnhYWdH8IGXVSinKgR5rkxi22w4ZE+OinDAXg
 dMVqF00V67brCtGhGhhmUL3+LipNoDODttbi/rc3ImxPWI9nofuwXnyYgAhPXK/ypz7W
 UHl5q56wUrezcNGfMtQ6AgbCw9HbrmnbM9m05lRqL47HPgEM1nXqzkd+KrwOjjSPlLBC
 BZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706707563;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=pgAQniflagvfV9wCLzmUm4L9wYpigSZf+bdpxZ3tQXQ=;
 b=ORju6qsZ9wHzksxBv+yTSN6kKHsRHyVwet/ktwp92I/ph01yI4fw6UXuWIz4HyJNNS
 F+NoWLy2e4gYNlo+uueHy13T+yFKgGPgg517oHkj1CyhLI4gOxjOE19V1AxnpUsAZ7OM
 Z2+U9bEYooIG8J8W1vnL8Z/goizwj8FuC4/eI77MUBChWLJ5xiV1xI9cHvh4vcahoBu3
 vvuzm9iBBRxDwFZ3wTBDBu+BiIehSNrxInU0cPLnjJX7pxD+KjUUrMAN4A7BHwLzvgsf
 tIuCVM5XA29cXZsV1xhsxqmfOkHgqGfBBdB6AU7Wkvbngz3ZcjyEd3MIDTCeKneHNH21
 VsUw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706707562;
 s=strato-dkim-0002; d=ict42.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=pgAQniflagvfV9wCLzmUm4L9wYpigSZf+bdpxZ3tQXQ=;
 b=Mxxdvs+6yFDge21EyY7HaA27O8i3QDVkM69M9HndocWB3CjiOxlMjRU7MgxAwhHFAV
 E19sMeLFZ80tHhGxoMPc91xw8h1J6E5yFB2hadApjLwwom4PqwRQ6G+0gv80klEyP2xO
 i8oTdaxLjueqQLZOeU85QQK80ZLqat2QPrUrq7pXP73dQu9LXw/+DhgliBvx0kPvFZFY
 85/fyQCb/XnzeuKQd3WUhgHMbqt/vwu7Uos5EvmIm28QbbL6nK1HNVCfcEfT2uz/3yVm
 Nfanu7ysvjsafQJVKSD/r9Z8CFxT+DEhvabu3OdaBnAl7uLH3iIhKIKyOdLKwjjxjgyw
 /3vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706707562;
 s=strato-dkim-0003; d=ict42.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=pgAQniflagvfV9wCLzmUm4L9wYpigSZf+bdpxZ3tQXQ=;
 b=o/gSPAjqW2YWNhfwDjWff2H76nUWo26TGbU9QdUzfvjkhnyfbpxWR4kQGZdtEvXQZX
 keTviS5lf9V2hRRhk3DQ==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0Kgl2F4tJkg7tCR14B0pVRc2TZCi+0sAd2k4="
Received: from [192.168.4.220] by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
 with ESMTPSA id x7ec2e00VDQ1IKX
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 31 Jan 2024 14:26:01 +0100 (CET)
Message-ID: <b1aecf07-8bf5-41dc-3574-257c8e8ac9c6@ict42.de>
Date: Wed, 31 Jan 2024 14:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] sunxi: sun4i: Reduce cpu clock at SPL initialization
 to 144 MHz
Content-Language: de-DE
To: Andre Przywara <andre.przywara@arm.com>
Cc: jagan@amarulasolutions.com, trini@konsulko.com, u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
References: <20240131104943.196256-1-ludwig.kormann@ict42.de>
 <20240131123622.078f5629@donnerap.manchester.arm.com>
From: Ludwig Kormann <ludwig.kormann@ict42.de>
In-Reply-To: <20240131123622.078f5629@donnerap.manchester.arm.com>
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

Hi Andre,

thanks for your feedback!

Am 31.01.24 um 13:36 schrieb Andre Przywara:
> On Wed, 31 Jan 2024 11:49:43 +0100
> Ludwig Kormann <ludwig.kormann@ict42.de> wrote:
>
> Hi Ludwig,
>
> thanks for taking care and sending a patch, though I scratch my head about
> this a bit. My main concern is why this would be an issue *now*, 11 years
> after the A20's release, and with tons of boards out there in operation.
> Also 144 MHz seem a somewhat drastic reduction?
>
We began seeing this issue beginning in early 2023 and it seems to affect
only a very small percentage of the units. We had to introduce this 
patch for
our customers and wanted to also share it with the community.

>> Up until now cpu clock gets initialized at 384 MHz, which is
>> the highest supported cpu clock.
> What do you mean with "highest supported"? Surely the A20 goes up to
> 960 MHz?
You're right, I must have mixed something up there.

> Also please note that 384 MHz is the PLL1 reset configuration, so it's not
> something we came up with, but probably some safe value that Allwinner
> burned into their chips.
>
>> Recent A20 batches show an increased percentage of modules
>> reacting very sensitive to operating conditions outside the
>> specifications.
> What are those specifications, exactly? Do you have any more reliable
> data? The datasheet is very quiet on those conditions, it seems.
> In particular, I couldn't find any official frequency/voltage
> combinations, it seems like the values in the DTs are just passed on from
> some BSP drop?
Yes, it's hard/impossible to find any reliable information on this.
Our main reference have been the values in the DTs.

>
>> The cpu dies very shortly after PLLs, core frequency or cpu
>> voltage are missconfigured. E.g.:
>> - uboot SPL selects 384 MHz as cpu clock which requires a cpu
>>    voltage of at least 1.1 V.
>> - Linux CPU Frequency scaling with most sun7i dts will reduce
>>    cpu voltage down to 1.0 V.
> How so? The mainline DT suggests 1.1V for anything above 312 MHz, and
> even above 144 MHz for the BananaPi. Are you using any OPs that differ
> from that?
>
>> - When intiating a reboot or reset from linux the cpu voltage
>>    may keep the 1.0 V configuration and the cpu dies during SPL
>>    initialization.
> Ah, so you mean we run (in Linux) on a 1.0V OP, probably at a very low CPU
> frequency, and then the CPU cores reset, leaving the PMIC at 1.0V? And
> then the SPL programs 384 MHz, which is too high, even for the brief period
> until we program DCDC2 to 1.4V?
Yes, the CPU dies before the voltage gets updated.
> If you have evidence (those "newer batches"? A20 batches in 2024?) for
> that, what about 312 MHz? Does that work?
The batches are actually from 2022+. We went for 144MHz as it's the lowest
of the "default" speeds, that also ensures we're "low enough" to (hopefully)
never trigger the issue again.
It seems like there's some variation in A20 production that triggers the 
issue
and as we don't know any "official" voltage/frequency limits it's better 
to have
some safety margin.

>
>> Therefore reduce cpu clock at uboot SPL initialization down
>> to 144 MHz from 384 MHz.
> I am bit concerned about slowing down the initial SPL phase that much, for
> *all* A20 users. We run the DRAM init with that initial clock, even though
> the voltage is already up at this point.
In my opinion the impact / additional delay for the initial SPL phase 
should not
be in a very relevant range actually, as it usually only takes a few 
hundred milliseconds.
But you're right of course, this would force the lower value onto all 
A20 users.

>
> So if you see issues with those "newer batches" only(?), and since I
> haven't heard about any issues about that before, can we make this a
> Kconfig choice? We could make it simple, forcing K to 1, so we just need
> to divide the frequency by 24 and shift by 8 to get to the register value?
I will try to look into this and provide an update.
>> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
>> ---
>>   arch/arm/include/asm/arch-sunxi/clock_sun4i.h | 2 +-
>>   arch/arm/mach-sunxi/clock_sun4i.c             | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
>> index 2cec91cb20..252c4c693e 100644
>> --- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
>> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
>> @@ -141,7 +141,7 @@ struct sunxi_ccm_reg {
>>   #define CCM_PLL1_CFG_SIG_DELT_PAT_EN_SHIFT	2
>>   #define CCM_PLL1_CFG_FACTOR_M_SHIFT		0
>>   
>> -#define PLL1_CFG_DEFAULT	0xa1005000
>> +#define PLL1_CFG_DEFAULT	0xa1004c01
>>   
>>   #if defined CONFIG_OLD_SUNXI_KERNEL_COMPAT && defined CONFIG_MACH_SUN5I
>>   /*
>> diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
>> index 8f1d1b65f0..ac3b7a801f 100644
>> --- a/arch/arm/mach-sunxi/clock_sun4i.c
>> +++ b/arch/arm/mach-sunxi/clock_sun4i.c
>> @@ -25,6 +25,7 @@ void clock_init_safe(void)
>>   	       APB0_DIV_1 << APB0_DIV_SHIFT |
>>   	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
>>   	       &ccm->cpu_ahb_apb0_cfg);
>> +	sdelay(20);
> Where does that come from? Can you mention that in the commit message?

This delay is required after switching the clock source.

See "A20 Reference manual v1.4" Page 50 / section "1.5.4.16. 
CPU/AHB/APB0 CLOCK RATIO(DEFAULT: 0X00010010)":
"If the clock source is changed, at most to wait for 8 present running 
clock cycles."

Also these delays are already correctly beeing used later on in the same 
file e.g. within clock_set_pll1(...) on line 153:
>     /* Switch to 24MHz clock while changing PLL1 */
>     writel(AXI_DIV_1 << AXI_DIV_SHIFT |
>            AHB_DIV_2 << AHB_DIV_SHIFT |
>            APB0_DIV_1 << APB0_DIV_SHIFT |
>            CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
>            &ccm->cpu_ahb_apb0_cfg);
>     sdelay(20);


kind regards

Ludwig

> Cheers,
> Andre
>
>>   	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
>>   	sdelay(200);
>>   	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
>> @@ -32,6 +33,7 @@ void clock_init_safe(void)
>>   	       APB0_DIV_1 << APB0_DIV_SHIFT |
>>   	       CPU_CLK_SRC_PLL1 << CPU_CLK_SRC_SHIFT,
>>   	       &ccm->cpu_ahb_apb0_cfg);
>> +	sdelay(20);
>>   #ifdef CONFIG_MACH_SUN7I
>>   	setbits_le32(&ccm->ahb_gate0, 0x1 << AHB_GATE_OFFSET_DMA);
>>   #endif

