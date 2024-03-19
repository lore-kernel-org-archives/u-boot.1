Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6B2C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 10:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5961987D3D;
	Tue, 19 Mar 2024 11:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Msg084BC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE3887D40; Tue, 19 Mar 2024 11:34:02 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D278751B
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1710844438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRytbk8eSEZwOmIDICAiCJONTZ3bTYl1O9fIE5asXIU=;
 b=Msg084BCIhsewX5XkNlWvVQXhjdpCK89QMRePlNg+SQkuK3wC6U2+JU0GyNpF0CEYkZc5C
 hYx95vP6gu4/PtVHj4OGrMuv2SmEGCcbv3yw4WwOSaJ12/MY43Y2vPZQQ4EBYX1pSTNegr
 uh0egHxZ05YnqtsuXT6oKJVRU95Oco9np4F8JysVoHHucM5AtZTJHdziRSggMiETCLaoVv
 shIj0jXmFpmKpXcww4l1NmBgwjfVp+jTkHPztqcXvYXMpvELYYV8lyyB5nULFPtawXJDXa
 GSJVQN4W5E/eiC2gLDIViP5D0piY+vArZ5+IfKfy2km2PGtJuV4rLzNjWONQnw==
Date: Tue, 19 Mar 2024 11:33:56 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Christopher Obbard
 <chris.obbard@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] rockchip: spl: Cache boot source id for later use
In-Reply-To: <9cde709e-a49b-40df-91d3-6f690313cf31@theobroma-systems.com>
References: <20240315173454.2672509-1-jonas@kwiboo.se>
 <9cde709e-a49b-40df-91d3-6f690313cf31@theobroma-systems.com>
Message-ID: <5edb985f0f5f5d2fbe73200b8cfc8dc5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

On 2024-03-19 11:19, Quentin Schulz wrote:
> On 3/15/24 18:34, Jonas Karlman wrote:
>> Rockchip BROM write a boot source id at CFG_IRAM_BASE + 0x10, the id
>> indicate from what storage media TPL/SPL was loaded from.
>> 
>> SPL use this value to determine what device "same-as-spl" represent 
>> when
>> determining from where FIT should be loaded. This works as long as the
>> boot_devices array contain a matching id <-> node path entry.
>> 
>> However, SPL typically load a small part of TF-A into SRAM and on 
>> RK3399
>> this overwrites the CFG_IRAM_BASE + 0x10 addr used for boot source id.
>> 
>> Here boot source id is 3 before FIT images is loaded, and 0 after:
>> 
>>    U-Boot SPL 2024.04-rc4 (Mar 15 2024 - 17:26:19 +0000)
>>    board_spl_was_booted_from: brom_bootdevice_id 3 maps to 
>> '/spi@ff1d0000/flash@0'
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
>> resolve correct boot source path for "same-as-spl" after SPL have 
>> loaded
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
>>        u-boot,spl-boot-order = "same-as-spl", "/mmc@fe330000", 
>> "/mmc@fe320000";
>>    };
>> 
> 
> I'm perplexed. We make use of this spl-boot-device DT property on Puma
> (RK3399) and Ringneck (PX30) and I am pretty sure I tested it does
> what it's supposed to do. So that is a bit surprising this seems to
> not work anymore. Is this related to the BSS/stack memory address
> location changes you made recently by any chance? Or did I manage to
> be very lucky for a very long time for our boards?
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
> U-Boot 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 
> +0100)
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
> board_spl_was_booted_from being called a second time after BL31 is
> loaded?
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
> U-Boot 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 
> +0100)
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
> Puma, so when same-as-spl fails to resolve, the device is still found
> in spl-boot-order DT property which means spl_perform_fixup will still
> be able to write that spl-boot-device DT property. So basically, the
> issue is related to SPI-NOR flash NOT being explicitly listed in
> spl-boot-order or/and that the order isn't actually respected because
> same-as-spl is basically skipped right now (but it works for Puma
> because the next medium in the list is SPI, so skipping same-as-spl
> for SPI, would result in checking SPI again :) ).

This was a very nice read, thanks for writing it down in detail! :)

> Can you please add:
> 
> Fixes: d57e16c7e712 ("rockchip: find U-boot proper boot device by
> inverting the logic that sets it")
> 
> to the commit log regardless of the implementation we'll go for?
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/spl.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/mach-rockchip/spl.c 
>> b/arch/arm/mach-rockchip/spl.c
>> index 1586a093fc37..27e996b504e7 100644
>> --- a/arch/arm/mach-rockchip/spl.c
>> +++ b/arch/arm/mach-rockchip/spl.c
>> @@ -32,9 +32,17 @@ __weak const char * const 
>> boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>     const char *board_spl_was_booted_from(void)
>>   {
>> -	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>> +	static u32 bootdevice_brom_id;
>>   	const char *bootdevice_ofpath = NULL;
>>   +	if (!bootdevice_brom_id)
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

Having a separate if + debug() message would be fine if we opt for
the "runtime canary test" approach I suggested a bit earlier.  If we
opt for a different approach, I agree that a separate if + debug()
would be pretty much redundant.

> Also, I would suggest to add a new entry to the BROM_BOOTSOURCE_*
> enum, e.g. BROM_BOOTSOURCE_INVALID/UNKNOWN = 0 so it's a bit more
> explicit and we're also "ready" for the day Rockchip decides to use 0
> as a valid BROM boot source so we know all the places we need to
> modify the logic.
> 
> Moreover, I join Dragan over the use of a "valid" value for deciding
> to read from the RAM... but for another reason. If it actually is 0
> for some reason, we would re-read from that address in RAM until we
> get something different from 0... which may happen to be written with
> something else than 0 when loading that small part of TF-A into SRAM?
> So we would then have something completely unexpected as boot source
> now.

Good point.  I didn't have that in mind, but using a totally invalid
value to determine uninitialized state is pretty much always a good
approach that may also prevent unforeseen issues.
