Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB4ED35151
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 08:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B868483CE3;
	Wed,  1 Apr 2026 10:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="E0D/lzYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB82E83CF5; Wed,  1 Apr 2026 10:54:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D91584090
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 10:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d289=CA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1775033690;
 bh=zXsLqLbwfx4QbofUd2K96cJC4tDcd/qy3SCmGmN4628=;
 b=E0D/lzYuabG6YIf8cgcKOcAoiAIivuPkjVdWN8GWMD2vGx0HRsh40mP0tua+wI6fcastO3V9h
 jswemULEirlrAOwLOlr0B4shFy+eV+C4P+1mVGaYh9OxBJPUBmGr8RG5uLH4CUYbMkJwlUKDfzE
 tLffSdqmiCFGYXSgQo3V7LwOOBGIN9MfvEUtJRxq7wMo2x59HZg7kDnCBEzHS66ZW9ISE1lwCij
 2PKvR9M6u3VJgG9NdQrBX72F/dxLnJxFQ5FSIp9rxScmThWuyQQYfrnBDCQRSBP4J+6IwqIqs+y
 icVeZhFahRPeN9XN9wkJadvMJd82Vl6W9Vr2ajipXsrg==
X-Forward-Email-ID: 69ccdd56842394fec829552c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.64
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3ed2db2d-bdbe-4ef2-980c-372a3e88fb31@kwiboo.se>
Date: Wed, 1 Apr 2026 10:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
 bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
 <564fc8c9-90de-43ed-a312-5a92b16078df@kwiboo.se>
 <CAC_iWjKRrL8CtU5Fu-ZM=Yg8XQztfC8e6TAoCY_SGX_Ds8xHCg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC_iWjKRrL8CtU5Fu-ZM=Yg8XQztfC8e6TAoCY_SGX_Ds8xHCg@mail.gmail.com>
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

On 4/1/2026 10:31 AM, Ilias Apalodimas wrote:
> Hi Jonas
> 
> [...]
> 
>>>  #if defined(CFG_SYS_SDRAM_BASE) && CFG_SYS_SDRAM_BASE > 0
>>>       /*
>>>        * Detect whether we have so much RAM that it goes past the end of our
>>> @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>>                */
>>>               return 0;
>>>  #endif
>>> +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
>>> +             phys_addr_t old_top = gd->ram_top;
>>> +
>>> +             ret = fdtdec_setup_mem_ram_top();
>>
>> This seem to make assumption that memory is already fully described in
>> FDT? Maybe this should instead be based on gd->bd->bi_dram, however that
>> is possible initialized at a later initcall.
> 
> It is. That was my first approach in fixing it, but the
> gd->bd->bi_dram contained garbage at that point.
> 
>>
>> If I got the call chain correct board_get_usable_ram_top() is normally
>> called from INITCALL(setup_dest_addr), and gd->bd->bi_dram banks are
>> typically initialized in INITCALL(dram_init_banksize), a later initcall.
> 
> Yes
> 
>>
>> On e.g. Rockchip there is no memory bank information in FDT at that
>> stage and memory banks is populated to gd->bd->bi_dram based on
>> information from dram init and only later possible added to the FDT for
>> booting OS.
> 
> And that happens after u-boot has relocated or before?

gd->bd->bi_dram is populated during dram_init_banksize() so I think it
should be almost just before u-boot is relocated.

I am not sure when or how, but the OS knows about the bank information
populated to bi_dram, not sure if some fdt fixup is happening just
before jumping to OS.

On Rockchip we keep gd->ram_top below 4 GiB to work around any >32-bit
DMA issues, however we do populate ram_size and bi_dram with correct
info gathered during the initial dram init (U-Boot TPL or external TPL).

Regards,
Jonas

> 
>>
>> Rockchip does have a platform board_get_usable_ram_top() so this will
>> not be an issue, but the new generic Kconfig option added here seem to
>> have a dependency on FDT containing memory bank information, if I am not
>> mistaken. Maybe something worth mentioning in help and commit message?
> 
> I can amend the Kconfig option. However, people using that default
> function are already aware of this.
> 
> Thanks
> /Ilias
>>
>> Regards,
>> Jonas
>>
>>> +             if (ret)
>>> +                     debug("failed to relocate to ram top");
>>> +             ret = fdtdec_setup_ram_size();
>>> +             if (ret) {
>>> +                     debug("failed to calculate RAM size");
>>> +                     gd->ram_top = old_top;
>>> +             }
>>> +     }
>>> +
>>>       return gd->ram_top;
>>>  }
>>>
>>

