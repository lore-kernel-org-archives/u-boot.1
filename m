Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C7CC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FEE80A09;
	Wed, 29 Jan 2025 18:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bjVBCug7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZtdEvvQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5F380AE4; Wed, 29 Jan 2025 18:00:56 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EC380843
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YjpM947y1z9shr;
 Wed, 29 Jan 2025 18:00:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRNwIyXeT10gSdqZ5zLgQO3drbmujFmTytdzDGPbhlY=;
 b=bjVBCug7piXO5vEpkCEmC+WH+7VsgbTsURGv9rH6auOTDGbgSeJKKN8XRDi+P0PKyhmVqk
 eem54KRvH9EGF684MmjLfv4eZn6o6JLkc6tPUXGgJsBGWVSwvV4+Wc1tR9ixnmhkcMyQl7
 B568x0N7tm+vjJHeIeEVpE0+WAnyqRdMwpbLKfixPH/PxjUvcEsqO3TBgtn5fQzNMY9Zak
 lvVzl/ftRCQkPLCryPxyOxHiXlQ5TdCAf2lpvF+YS+hDCtHv8CwtgsXxGrw9/wXbc7xxoT
 T2Z8nWHehiPZ0qT2CoPVM+ANXgdQ1vlhFUE/uiixG3J7LQTdrbhZL8u7wH/9mA==
Message-ID: <b7b755d2-1156-4463-9764-086d9e6ef080@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRNwIyXeT10gSdqZ5zLgQO3drbmujFmTytdzDGPbhlY=;
 b=ZtdEvvQJRuDoYc/nmrm0AGMspKJvJcNeiT/X5z6zNQR0W2lq0FElwG9NNXTwGeCCRoK4wc
 hxO9dEoy8j+7kP/hE6UtcXdHCX9vA1bSMF3bp6w+toVsh0FOzUVzxhXUQEVJMzA7VV8/+b
 84vmcE09xj7fe0WMgTHIo1KObJXLqGnDlST/b181qU5V5pYhze3APXvBjD+ltklv1uoyv0
 8mgIHcf0/Jg5Wd4pB1wNn3yW/VuT/HPJM7roG2jVUpjFSPP+HVClGhIgiuum/H76v0odsy
 zBUopCAO3v4yVvCyb85NohmIyOUtR9Bd4bPGn/eAt9Nts403Otw9tlFVE2OVhg==
Date: Wed, 29 Jan 2025 18:00:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm64: renesas: Add TFA BL31 handoff support
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-3-marek.vasut+renesas@mailbox.org>
 <8409fd39-3816-4686-9b9c-56785209ed37@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8409fd39-3816-4686-9b9c-56785209ed37@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 744714beff444a4d3bd
X-MBO-RS-META: 8wef3kny5wp5ex9m9zcfkkmk3xfpch59
X-Rspamd-Queue-Id: 4YjpM947y1z9shr
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

On 1/29/25 5:02 PM, Quentin Schulz wrote:
> Hi Marek,

Hi,

[...]

>> +void armv8_switch_to_el2_prep(u64 args, u64 mach_nr, u64 fdt_addr,
>> +                  u64 arg4, u64 entry_point, u64 es_flag)
>> +{
>> +    typedef void __noreturn (*image_entry_noargs_t)(void);
>> +    image_entry_noargs_t image_entry =
>> +        (image_entry_noargs_t)(void *)tfa_bl31_image_addr;
>> +    struct bl2_to_bl31_params_mem *blinfo =
>> +        (struct bl2_to_bl31_params_mem *)PARAMS_BASE;
>> +
>> +    /*
>> +     * Destination address in arch/arm/cpu/armv8/transition.S
>> +     * right past the first bl in armv8_switch_to_el2() to let
>> +     * the rest of U-Boot pre-Linux code run. The code does run
>> +     * without stack pointer!
>> +     */
>> +    const u64 ep = ((u64)(uintptr_t)&armv8_switch_to_el2) + 4;
>> +
>> +    /* If TFA BL31 was not part of the fitImage, do regular boot. */
>> +    if (!tfa_bl31_image_loaded)
>> +        return;
>> +
>> +    /*
>> +     * Set up kernel entry point and parameters:
>> +     * x0 is FDT address, x1..x3 must be 0
>> +     */
>> +    blinfo->bl33_ep_info.pc = ep;
>> +    blinfo->bl33_ep_info.args.arg0 = args;
>> +    blinfo->bl33_ep_info.args.arg1 = mach_nr;
>> +    blinfo->bl33_ep_info.args.arg2 = fdt_addr;
>> +    blinfo->bl33_ep_info.args.arg3 = arg4;
>> +    blinfo->bl33_ep_info.args.arg4 = entry_point;
>> +    blinfo->bl33_ep_info.args.arg5 = es_flag;
>> +    blinfo->bl33_image_info.image_base = ep;
>> +
>> +    /* Jump to TFA BL31 */
>> +    image_entry();
>> +}
> 
> Shouldn't we have a weak implementation that SoC vendor can override if 
> they feel like it?

We do have one. Please do have a look at 1/3 in this series:

WEAK(armv8_switch_to_el2_prep)

> To me this feels like it could be much quicker adopted if we had some 
> default people could try out for their boards.
> 
> We already have a generic spl_invoke_atf() so why not the same for this 
> mechanism? As far as I could tell, we get the load address of TEE and U- 
> Boot proper (bl32 and bl33) and pass it the FDT (or nothing if 
> SPL_ATF_NO_PLATFORM_PARAM symbol set).

Looking at spl_invoke_atf(), it _almost_ looks like something I could 
use, but from what I see there and here, the handoff structure layout is 
slightly different, it seems to be board specific.

But that is fine, as this is a board specific strong implementation of 
weak armv8_switch_to_el2_prep function.

> I am not too sure who and how TEE will be started as it needs to be 
> executing in EL3 too I believe? So we may still have to provide that 
> one? BL33 would be the kernel params like you did in this patch. Then 
> the bl31 param could also be either the fdt or nothing if 
> ATF_NO_PLATFORM_PARAM is set.
> 
> I guess the issue is that Renesas doesn't use any of that generic stuff?
> 
> What do you think?

The board does ship with a custom loader which starts on a security 
core, which starts the BL31 on an application core. That custom loader 
does set up the handoff structure before releasing the application core 
from reset, and then the application core jumps right into the BL31 .

But mainline U-Boot now has SPL which can run on another realtime core, 
bring up DRAM, application core, start U-Boot on it ... and then U-Boot 
has to set up the handoff structure before starting TFA, in the same 
form like the custom loader.

-- 
Best regards,
Marek Vasut
