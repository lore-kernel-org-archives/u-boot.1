Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA18C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 15:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C28B87D64;
	Tue, 19 Mar 2024 16:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fGggXzb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D284887E1D; Tue, 19 Mar 2024 16:59:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233AC87D64
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 16:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ea35=K2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710863946;
 bh=lgwPJR2cgZUbcTy99msZH2VJcJ0Ny/S9TCpAcAemIGo=;
 b=fGggXzb2B0zwaWBWndPqQUKTGgu+75TZ9gzVBevT7hgJliAIaN6xTroqR0d/zpRGQtMJuRzta
 D4lr7DRkDqxooCgvOOD6/OJOvmr+RhZ/ctaa3DgH6M6O9jZ4/P321MsuNX0sZwEX19mE/uEu2xH
 guy4UIC/cRox19WypEzS1qB8x58ndn+ynP78MAtNCQUMUasMYyl/SvOQF0hrWqYrYUOVRE+VMBR
 mXeg6QA70quVsIJDlW9Pxf2eyItTOqrIW6ac6kGhwT+3Q/QXoWdfrUIDGBVvnqilS0FXYiW9pBf
 e4zWuwoQU5O4fmkQ2Y8nYEa3CISK1OVlY/oeisTDubmw==
Message-ID: <16c848fe-5230-43fd-9917-83b196d152ec@kwiboo.se>
Date: Tue, 19 Mar 2024 16:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl: Cache boot source id for later use
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240315173454.2672509-1-jonas@kwiboo.se>
 <82cb3644a72bfb293364ddd7bcedc00d@manjaro.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <82cb3644a72bfb293364ddd7bcedc00d@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f9b649c6d8aebcc137f0b2
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

Hi Dragan,

On 2024-03-19 10:44, Dragan Simic wrote:
> Hello Jonas,
> 
> Please see a few comments below.
> 
> On 2024-03-15 18:34, Jonas Karlman wrote:
>> Rockchip BROM write a boot source id at CFG_IRAM_BASE + 0x10, the id
>> indicate from what storage media TPL/SPL was loaded from.
> 
> s/write/writes/
> s/indicate/indicates/
> 
> There are also a few more similar small grammar issues in the rest
> of the patch descroption below.

Thanks, will try to incorporate the grammatical fixes in a v2.

> 
>> SPL use this value to determine what device "same-as-spl" represent 
>> when
>> determining from where FIT should be loaded. This works as long as the
>> boot_devices array contain a matching id <-> node path entry.
> 
> s/use/uses/
> etc.
> 
>> However, SPL typically load a small part of TF-A into SRAM and on 
>> RK3399
>> this overwrites the CFG_IRAM_BASE + 0x10 addr used for boot source id.
>>
>> Here boot source id is 3 before FIT images is loaded, and 0 after:
>>
>>   U-Boot SPL 2024.04-rc4 (Mar 15 2024 - 17:26:19 +0000)
>>   board_spl_was_booted_from: brom_bootdevice_id 3 maps to
>> '/spi@ff1d0000/flash@0'
>>   Trying to boot from SPI
>>   ## Checking hash(es) for config config-1 ... OK
>>   ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>   ## Checking hash(es) for Image u-boot ... sha256+ OK
>>   ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>>   ## Checking hash(es) for Image atf-2 ... sha256+ OK
>>   ## Checking hash(es) for Image atf-3 ... sha256+ OK
>>   board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
>>   spl_decode_boot_device: could not find udevice for /mmc@fe330000
>>   spl_decode_boot_device: could not find udevice for /mmc@fe320000
>>   spl_perform_fixups: could not map boot_device to ofpath: -19
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
>>   => fdt addr ${fdtcontroladdr}
>>   Working FDT set to f1ee6710
>>   => fdt list /chosen
>>   chosen {
>>       u-boot,spl-boot-device = "/spi@ff1d0000/flash@0";
>>       stdout-path = "serial2:1500000n8";
>>       u-boot,spl-boot-order = "same-as-spl", "/mmc@fe330000", 
>> "/mmc@fe320000";
>>   };
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/mach-rockchip/spl.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-rockchip/spl.c 
>> b/arch/arm/mach-rockchip/spl.c
>> index 1586a093fc37..27e996b504e7 100644
>> --- a/arch/arm/mach-rockchip/spl.c
>> +++ b/arch/arm/mach-rockchip/spl.c
>> @@ -32,9 +32,17 @@ __weak const char * const
>> boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>
>>  const char *board_spl_was_booted_from(void)
>>  {
>> -	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>> +	static u32 bootdevice_brom_id;
>>  	const char *bootdevice_ofpath = NULL;
>>
>> +	if (!bootdevice_brom_id)
>> +		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>> +	if (!bootdevice_brom_id) {
>> +		debug("%s: unknown brom_bootdevice_id %x\n",
>> +		      __func__, bootdevice_brom_id);
>> +		return NULL;
>> +	}
>> +
> 
> Maybe it would be better to execute readl(BROM_BOOTSOURCE_ID_ADDR)
> only once, i.e. to have something like this instead:
> 
>      +	static u32 bootdevice_brom_id = -1;
> 
>      +	if (bootdevice_brom_id == -1) {
>      +		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>      +		if (!bootdevice_brom_id)
>      +			debug("%s: unknown brom_bootdevice_id %x\n",
>      +			      __func__, bootdevice_brom_id);
>      +	}
>      +
>      +	if (!bootdevice_brom_id)	/* fail on subsequent tries */
>      +		return NULL;
>      +
> 
> The logic behind such an approach would be to try only once and fail
> on subsequent (re)tries.  That way, it would also serve as some kind of
> a runtime canary test, because the first try should succeed, which may
> prove useful in the field.

If we initialize the static variable to a value it will be stored in the
.data section and takes up binary size. With a static variable like in
this patch this is instead stored in .bss section and gets initialized
to 0 by runtime. 0 is also not a valid boot source id value and the
reset value for the reg.

I do not see any point in making the code more complex than it has to be.
The reg will contain a known boot source id, 1 - 10, set by BROM or
something has gone wrong and the value is not usable any way.

Regards,
Jonas

> 
>>  	if (bootdevice_brom_id < ARRAY_SIZE(boot_devices))
>>  		bootdevice_ofpath = boot_devices[bootdevice_brom_id];

