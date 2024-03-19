Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978EDC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 16:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5ADD8802B;
	Tue, 19 Mar 2024 17:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="O2vvirg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D4587FFA; Tue, 19 Mar 2024 17:52:37 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11FCF87F04
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 17:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ea35=K2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710867145;
 bh=GNstNPNKljx4U9SEo9S6easdtvkYjh9vOjz/vtNcK/w=;
 b=O2vvirg6WLymWDX7J9hijCcH3B4P2gWXinkr46jnNM/9nhd9WMOTWy08qnWsMDgeyKzwueO8W
 xZmLmJ921ODHl+P5ed7XQOpGmQOE0N97nfrgGTmU17Unuk8/eXFKPTNm8Qkd9Ty3c8ZpJSEKMtt
 rLnhiLHIr/IgIc5gdqDnExk9rRLjihQK3FuTCuTD1roDDqzymcIt0s9wCdmtpVmQXn6EK9HGEYY
 WdCzJVYJ1uiAfXuKCFSbrUUEoXnlJrhgMARFvZTZWE8QnP314tkfgy7t3AkVqd8Y24JG5FWwoZO
 v7kPPyAGQChEWBT+xT8brflGtRng6/XImvLYrbzLy4lw==
Message-ID: <c0634604-a065-46bb-8907-9b2401aebc39@kwiboo.se>
Date: Tue, 19 Mar 2024 17:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl: Cache boot source id for later use
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240315173454.2672509-1-jonas@kwiboo.se>
 <9cde709e-a49b-40df-91d3-6f690313cf31@theobroma-systems.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9cde709e-a49b-40df-91d3-6f690313cf31@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f9c2c862c9892177fe437a
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

Hi Quentin,

On 2024-03-19 11:19, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/15/24 18:34, Jonas Karlman wrote:
>> Rockchip BROM write a boot source id at CFG_IRAM_BASE + 0x10, the id
>> indicate from what storage media TPL/SPL was loaded from.
>>
>> SPL use this value to determine what device "same-as-spl" represent when
>> determining from where FIT should be loaded. This works as long as the
>> boot_devices array contain a matching id <-> node path entry.
>>
>> However, SPL typically load a small part of TF-A into SRAM and on RK3399
>> this overwrites the CFG_IRAM_BASE + 0x10 addr used for boot source id.
>>
>> Here boot source id is 3 before FIT images is loaded, and 0 after:
>>
>>    U-Boot SPL 2024.04-rc4 (Mar 15 2024 - 17:26:19 +0000)
>>    board_spl_was_booted_from: brom_bootdevice_id 3 maps to '/spi@ff1d0000/flash@0'
>>    Trying to boot from SPI
>>    ## Checking hash(es) for config config-1 ... OK
>>    ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>    ## Checking hash(es) for Image u-boot ... sha256+ OK
>>    ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>>    ## Checking hash(es) for Image atf-2 ... sha256+ OK
>>    ## Checking hash(es) for Image atf-3 ... sha256+ OK
>>    board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
>>    spl_decode_boot_device: could not find udevice for /mmc@fe330000
>>    spl_decode_boot_device: could not find udevice for /mmc@fe320000
>>    spl_perform_fixups: could not map boot_device to ofpath: -19
>>
>> Use a static bootdevice_brom_id to cache the boot source id after an
>> initial read from SRAM to fix this, this allow spl_perform_fixups() to
>> resolve correct boot source path for "same-as-spl" after SPL have loaded
>> TF-A related FIT images into memory.
>>
>> With this the spl-boot-device prop can correctly be resolved to the
>> SPI flash node in the control FDT:
>>
>>    => fdt addr ${fdtcontroladdr}
>>    Working FDT set to f1ee6710
>>    => fdt list /chosen
>>    chosen {
>>        u-boot,spl-boot-device = "/spi@ff1d0000/flash@0";
>>        stdout-path = "serial2:1500000n8";
>>        u-boot,spl-boot-order = "same-as-spl", "/mmc@fe330000", "/mmc@fe320000";
>>    };
>>
> 
> I'm perplexed. We make use of this spl-boot-device DT property on Puma 
> (RK3399) and Ringneck (PX30) and I am pretty sure I tested it does what 
> it's supposed to do. So that is a bit surprising this seems to not work 
> anymore. Is this related to the BSS/stack memory address location 
> changes you made recently by any chance? Or did I manage to be very 
> lucky for a very long time for our boards?

As you figured out below, this is currently only an issue with SPI flash
because it was only the SPI flash code path that re-used boot source id
after FIT images have been loaded into memory.

> 
> """
> U-Boot SPL 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 
> +0100)
> board_spl_was_booted_from: brom_bootdevice_id 5 maps to '/mmc@fe320000'
> Trying to boot from MMC2
> load_simple_fit: Skip load 'atf-5': image size is 0!
> NOTICE:  BL31: v2.9(release):v2.9.0
> NOTICE:  BL31: Built : 17:47:58, Jun 21 2023
> 
> 
> U-Boot 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 +0100)
> [...]
> => fdt addr ${fdtcontroladdr}
> Working FDT set to f1f13d10
> => fdt list /chosen
> chosen {
> 	u-boot,spl-boot-device = "/mmc@fe320000";
> 	stdout-path = "serial0:115200n8";
> 	u-boot,spl-boot-order = "same-as-spl", "/spi@ff1d0000/flash@0", 
> "/mmc@fe330000", "/mmc@fe320000";
> };
> """
> 
> for Puma when booting from SD card... I don't see 
> board_spl_was_booted_from being called a second time after BL31 is loaded?
> 
> mmmmmmm
> 
> Very interestingly, when booting from SPI-NOR flash:
> 
> """
> U-Boot SPL 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 
> +0100)
> board_spl_was_booted_from: brom_bootdevice_id 3 maps to 
> '/spi@ff1d0000/flash@0'
> Trying to boot from SPI
> load_simple_fit: Skip load 'atf-5': image size is 0!
> board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
> NOTICE:  BL31: v2.9(release):v2.9.0
> NOTICE:  BL31: Built : 17:47:58, Jun 21 2023
> 
> 
> U-Boot 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 +0100)
> [...]
> => fdt addr ${fdtcontroladdr}
> Working FDT set to f1f13d10
> => fdt list /chosen
> chosen {
> 	u-boot,spl-boot-device = "/spi@ff1d0000/flash@0";
> 	stdout-path = "serial0:115200n8";
> 	u-boot,spl-boot-order = "same-as-spl", "/spi@ff1d0000/flash@0", 
> "/mmc@fe330000", "/mmc@fe320000";
> };
> """
> 
> but the DT is properly written...
> 
> Ahah! This is because of one of my commits where I added support for 
> SPI-NOR flashes to spl_perform_fixups. So I think this worked for me 
> because the SPI-NOR flash is explicitly listed in spl-boot-order for 
> Puma, so when same-as-spl fails to resolve, the device is still found in 
> spl-boot-order DT property which means spl_perform_fixup will still be 
> able to write that spl-boot-device DT property. So basically, the issue 
> is related to SPI-NOR flash NOT being explicitly listed in 
> spl-boot-order or/and that the order isn't actually respected because 
> same-as-spl is basically skipped right now (but it works for Puma 
> because the next medium in the list is SPI, so skipping same-as-spl for 
> SPI, would result in checking SPI again :) ).

Correct, as long as the spi flash node was added to the spl-boot-order
there has not been any noticeable issue.

TF-A overwriting the boot source id reg is something I have only seen on
RK3399 so far. I think this is not an issue on RK3328 and RK35xx, but I
could be wrong.

It was only when testing the SPI flash patches for ROCK Pi 4 and my
suggestion to drop the explicit listing of the flash node that I noticed
that there was something not working correctly with the same-as-spl code
path.

> 
> Can you please add:
> 
> Fixes: d57e16c7e712 ("rockchip: find U-boot proper boot device by 
> inverting the logic that sets it")
> 
> to the commit log regardless of the implementation we'll go for?

Sure, I will include a fixes tag in a v2.

> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/spl.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
>> index 1586a093fc37..27e996b504e7 100644
>> --- a/arch/arm/mach-rockchip/spl.c
>> +++ b/arch/arm/mach-rockchip/spl.c
>> @@ -32,9 +32,17 @@ __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>   
>>   const char *board_spl_was_booted_from(void)
>>   {
>> -	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>> +	static u32 bootdevice_brom_id;
>>   	const char *bootdevice_ofpath = NULL;
>>   
>> +	if (!bootdevice_brom_id)
>> +		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>> +	if (!bootdevice_brom_id) {
>> +		debug("%s: unknown brom_bootdevice_id %x\n",
>> +		      __func__, bootdevice_brom_id);
>> +		return NULL;
>> +	}
> 
> I don't think we absolutely need the second if block, as this would be 
> handled by the else part of the if block that isn't shown in this git 
> context.

Correct, it is technically not needed, it was mostly added there was an
effort to clean up boot source related debug messages in spl-boot-order.c
and this adds a different grepable debug message.

> 
> Also, I would suggest to add a new entry to the BROM_BOOTSOURCE_* enum, 
> e.g. BROM_BOOTSOURCE_INVALID/UNKNOWN = 0 so it's a bit more explicit and 
> we're also "ready" for the day Rockchip decides to use 0 as a valid BROM 
> boot source so we know all the places we need to modify the logic.

Agree, I will add a BROM_BOOTSOURCE_INVALID and change debug message to
invalid instead of unknown in v2.

> 
> Moreover, I join Dragan over the use of a "valid" value for deciding to 
> read from the RAM... but for another reason. If it actually is 0 for 
> some reason, we would re-read from that address in RAM until we get 
> something different from 0... which may happen to be written with 
> something else than 0 when loading that small part of TF-A into SRAM? So 
> we would then have something completely unexpected as boot source now.

1 - 10 is the only expected valid boot source id, anything else would be
considered invalid and is ignored.

The intent of this patch was to cache the first valid boot source id
that is read back from the reg, technically it currently also cache
invalid values, will fix that in a v2.

I have only seen the reg being overwritten to 0 for both open source and
RK TF-A on RK3399. And with current intended use of the function the
value is always read at least once before FIT images is loaded so I am
not that concerned that we will end up with a wrong or bad value.

Regards,
Jonas

> 
> Cheers,
> Quentin

