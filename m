Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D2DCF45CD
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 21:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97CC1836AC;
	Mon, 12 Jan 2026 22:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Todrc4kP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e/jhukCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C97283700; Mon, 12 Jan 2026 22:56:14 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B31836A3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dqmRG3qDRz9tYL;
 Mon, 12 Jan 2026 22:56:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768254970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fucxztaZ5+oin3WN2RLkoSumuKkk4UdE8q/8jwPgRuQ=;
 b=Todrc4kPnUsJ3xODu3rGJraz1jUmnBuzYbG4FE5fpPAB0ZAyBEnbM71wxa78Yb+kFhjL21
 k7F3FcntN9VIP/56Sj9wHUpFc8UgOb0K7r8ECL2s2Ts2U5nKjTxhP/a2IB/vk+whp8gBHc
 eDm7OikQ5u/7/Rvemsa+JN8SbFfO6gef5DaN9IeDBY6LQfQOmahWpUyvLP6FG2MVbuyank
 w7la3pvvwGkGkAMFnfNj9ifOLm9rVZw5zX0D3mVlknTxKtHh/PXJGZA445f2Yrty8zYcDW
 W23VmL12XHe28DLPpT/rAiKQpvAyNm+MvPGFY+U5jzJqRbNRya3ZR00WAKHPUw==
Message-ID: <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768254968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fucxztaZ5+oin3WN2RLkoSumuKkk4UdE8q/8jwPgRuQ=;
 b=e/jhukCmcPiJZadxzSckMrP5n0ZxAEeZYpD7vPbjRoTPe+E9ka5tCNQ6JWWM1WyP0JjoMZ
 TpmOnf2HOi7t1dKl/nQEZikvuorgCUBVZioidmAEIPvv7WqELyLLjrlVU5OWHqBTv9CUwB
 Phjm9HJsZ/vVuHE0YN9XGIfCDC6P07LA9tkmMo4WiWFVmaGiZFCLrNJF+cHTykHUijxmBZ
 PbRB0MU+nC0XBQpp+uSOdKXVFLHyvcHkoRfOKaAs1lQHppJrCQAHVEMwN3M8iQrz3wDibc
 agfvgqpRUuWReh7MqAZHomhfKshWVf4ZjAMqSKVQzalbgbhnis5dj82sCAIZCg==
Date: Mon, 12 Jan 2026 22:56:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, afd@ti.com,
 nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com> <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
 <20260112164854.GQ3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260112164854.GQ3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: eecakod375yfero1y51wn5357oih7bis
X-MBO-RS-ID: b760f6ff0a9e6dd5c96
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

On 1/12/26 5:48 PM, Tom Rini wrote:
> On Mon, Jan 12, 2026 at 06:38:19PM +0530, Anshul Dalal wrote:
>> On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
>>> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
>>> a 4-byte alignment directive after the __u_boot_list section. This
>>> alignment directive only advances the location counter without padding
>>> the actual binary output.
>>>
>>> When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
>>> data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
>>> not an aligned address (e.g., 0x41c35a00). So, when the FIT image
>>> containing device trees is concatenated to the SPL binary, it gets
>>> appended at this unaligned file size, causing libfdt validation failure.
>>>
>>> To fix this, move the alignment directive into the __u_boot_list section
>>> itself and make it 8-byte aligned as per DT spec. This forces the linker
>>> to include padding as part of the section data, ensuring objcopy
>>> includes the padding bytes in the binary and the appended FIT image
>>> starts at an 8-byte aligned boundary.
>>>
>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>> v2: Changelog:
>>> 1. Get rid of extra ALIGN() directive, replace it with a comment
>>> 2. Carry Reported-by, Closes and Fixes tag.
>>>
>>> Link to v1:
>>> https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/
>>>
>>>   arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
>>> index 3bb759d8a1c..5ad169a37b7 100644
>>> --- a/arch/arm/mach-omap2/u-boot-spl.lds
>>> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
>>> @@ -35,9 +35,13 @@ SECTIONS
>>>   	. = ALIGN(4);
>>>   	__u_boot_list : {
>>>   		KEEP(*(SORT(__u_boot_list*)));
>>> +		/*
>>> +		 * Ensure 8-byte alignment at the end of the last section before
>>> +		 * DTB is appended, to satisfy DT spec alignment requirements
>>> +		 */
>>> +		. = ALIGN(8);
>>
>> I wonder if there could be a better way to handle this constraint,
>> currently we have two major problems with this approach:
>>
>> 1. All platforms facing similar alignment issues would have to modify
>> their linker scripts.
> 
> Yes, agreed.
> 
>> 2. The FDT only gets appended directly to SPL binary in cases of
>> CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + FDT) as per
>> the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS would have to
>> be 8-byte aligned as well as the SPL binary.
>>
>> I wonder if we could have a new make target for say
>> u-boot-spl-nodtb-aligned.bin which is just (SPL binary + optionally BSS
>> + padding for alignment) and at runtime we modify the fdt addr in gd to
>> point to the correctly aligned address?
> 
> Looking back at
> https://lore.kernel.org/all/87h65ihumb.fsf@bloch.sibelius.xs4all.nl/ we
> can use dd as a portable way to ensure that a file ends with 8-byte
> alignmnent by doing:
> dd if=testfile bs=8 conv=sync of=testfile_pad
> and we get a zero-padded 8-byte aligned output file, and at the end of
> that we can concatenate our dtb.
You still need to make sure there is a symbol generated by the linker 
that points at the END of the u-boot binary . dd happens too late, so 
you cannot do that. The alignment has to be done by the linker, in the 
linker script I think.
