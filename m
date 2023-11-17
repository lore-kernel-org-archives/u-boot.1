Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C0C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6436386E81;
	Fri, 17 Nov 2023 20:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TkVhsWEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AD986EC9; Fri, 17 Nov 2023 20:54:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B9F86D23
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9f74=G7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1700250833;
 bh=fLXjxy+Q3T+MyGeqUq6NF6KRGeFOPZwYnGih194kYXM=;
 b=TkVhsWEp2j/T+R8JzJHd1yf3IQw3lbcKldkN/viZag9IsDJwicvkISa+YjULtp2sPy+3ojUK6
 fycf+jNbWW9tn/nOJ7RxSMDlGpoL5QF2Fv7f2zKbCjbphfSTRQ/MqRGF8KeMc8dpC+O7CE2WvvH
 xHP7q20On8f8xUTu+uPMNHrgHF297nE4v/BlPEpfU9aCxD11bu9z/GwGuFaNnYHXXpWffoh6bj1
 2MPVCpKWJITCrdio98XkZzWRn+fPHoBZv19oe8CiLgWDfqwvfMAhS6wpILILzrlx/SmNSBnw6OF
 JC63hgCvxjtXzuIK+7ejsGLuzyPGb8Vo2avYZARpuvRA==
Message-ID: <9353ea1a-1bf2-4385-9142-0c62a49a562d@kwiboo.se>
Date: Fri, 17 Nov 2023 20:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, John Clark <inindev@gmail.com>, Quentin
 Schulz <quentin.schulz@theobroma-systems.com>
Cc: Slawomir Stepien <sst@poczta.fm>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, u-boot@lists.denx.de
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
 <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
 <ZVdyu2vjW0LrW6Jf@nr200> <20231117175020.GP170968@bill-the-cat>
 <31e783f3-a73b-e6fc-bf25-84a8b2c4cd1d@gmail.com>
 <20231117190750.GQ170968@bill-the-cat>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231117190750.GQ170968@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6557c4d0af9939f36202a54e
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

On 2023-11-17 20:07, Tom Rini wrote:
> On Fri, Nov 17, 2023 at 01:50:58PM -0500, John Clark wrote:
>>
>> On 11/17/23 12:50 PM, Tom Rini wrote:
>>> On Fri, Nov 17, 2023 at 03:03:39PM +0100, Slawomir Stepien wrote:
>>>> On lis 14, 2023 15:06, Quentin Schulz wrote:
>>>>> Hi Jonas,
>>>> Hi Quentin
>>>>
>>>>> On 11/12/23 11:26, Jonas Karlman wrote:
>>>>>> The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
>>>>>> NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
>>>>>>
>>>>>> At the time the reason for this new bootsource id value 6 was unknown.
>>>>>>
>>>>>> We now know that the BootRom on RK3588 use different bootsource id
>>>>>> values depending on the iomux used by the flash spi controller, and not
>>>>>> by the type of spi nor or spi nand flash used.
>>>>>>
>>>>>> Add the following defines and use them for RK3588 boot_devices.
>>>>>>
>>>>>> - BROM_BOOTSOURCE_FSPI_M0 = 3
>>>>>> - BROM_BOOTSOURCE_FSPI_M1 = 4
>>>>>> - BROM_BOOTSOURCE_FSPI_M2 = 6
>>>>>>
>>>>>> Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI NOR flash")
>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>> ---
>>>>>>    arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
>>>>>>    arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
>>>>>>    2 files changed, 6 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>>>> index 7dab18fbc3fb..f78337397d63 100644
>>>>>> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>>>> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>>>> @@ -47,8 +47,10 @@ enum {
>>>>>>    	BROM_BOOTSOURCE_EMMC = 2,
>>>>>>    	BROM_BOOTSOURCE_SPINOR = 3,
>>>>>>    	BROM_BOOTSOURCE_SPINAND = 4,
>>>>>> +	BROM_BOOTSOURCE_FSPI_M0 = 3,
>>>>>> +	BROM_BOOTSOURCE_FSPI_M1 = 4,
>>>>> I'm a bit wary of two pairs of enums sharing the same value, especially when
>>>>> we want to use them as offset in a static definition of an array.
>>>>>
>>>>> Should we #ifdef it (meh) for RK3588?
>>>>> Should we add a suffix like before for identifying RK3588-specific options?
>>>>>
>>>>> At the very least explicit that those are RK3588-specific in a comment for
>>>>> both conflicts (the ones that apply to everything except RK3588 to say to
>>>>> use only for !RK3588, and the ones that apply to RK3588 only)?
>>>> Can you say why it is so important to know that given enum is specific to given CPU here in the
>>>> header file? I think that the enums in the bootrom.h should be as generic as possible.
>>>>
>>>> By using the possible enums in a static array, "solves" the problem of assigning the boot source to
>>>> specific CPU. There is not need to make such grouping in the bootrom.h.
>>> Do we have any insight as to why Rockchip re-used those values? Looking
>>> at the header I see RK3588 has a different SPINOR value than others.
>>> Does RK3588 share the same value for other sources? How much of
>>> bootrom.h is still correct for RK3588? I'd rather not have to move to
>>> having bootrom_${soc}.h like so many other headers are, and if it's just
>>> these values, it might be cleaner to #if .. #else .. #endif the whole
>>> enum, and then re-evaluate things abased on whatever the next new SoC
>>> does here.
>>>
>> Which c specification does u-boot follow?  Duplicate values in enumerations
>> are explicitly allowed in c as far as I ever have known.
>>
>> "The use of enumerators with = may produce enumeration constants with values
>> that duplicate other values in the same enumeration."
>> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf
> 
> Sorry I wasn't clear. It's less about C specification and more about
> readability. We could do, but I feel is odd readability-wise is:
> enum {
>         BROM_BOOTSOURCE_NAND = 1,
>         BROM_BOOTSOURCE_EMMC = 2,
>         BROM_BOOTSOURCE_SPINOR = 3,
>         BROM_BOOTSOURCE_SPINAND = 4,
>         BROM_BOOTSOURCE_SD = 5,
>         BROM_BOOTSOURCE_FSPI_M0_RK3588 = 3,
> 	BROM_BOOTSOURCE_FSPI_M1_RK3588 = 4,
>         BROM_BOOTSOURCE_FSPI_M2_RK3588 = 5,
>         BROM_BOOTSOURCE_SPINOR_RK3588 = 6,
>         BROM_BOOTSOURCE_USB = 10,
>         BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
> };
> 
> But how many of the other values are still correct for RK3588? The TRM I
> found quickly does say that NAND and SD/eMMC are valid options, and USB,
> but I didn't see a table that mapped back to the values here.
> 

Remaining values that is supported should be same, the only difference
for RK3588 is that the old SPINOR=3/SPINAND=4 values now map to flash
spi iomux M0 and M1, and compared to bootrom in other SoCs cannot be
used to determine if SPI NOR or SPI NAND was the boot source. The new
value 6 maps to flash spi iomux M2. What type of flash spi media the
device was booted from, nor/nand, does not matter for RK3588.

Guess I can add a enum for the rk3588 FSPI_M0/M1/M2 values directly in
rk3588.c where they are used, and when next SoC re-use iomux for flash
spi controller they can be moved to bootrom.h.

Regards,
Jonas



