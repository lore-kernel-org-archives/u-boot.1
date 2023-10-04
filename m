Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE625E7C4D0
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 15:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5210187522;
	Wed,  4 Oct 2023 17:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eYqsl5ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725CA87517; Wed,  4 Oct 2023 17:20:58 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E29C8750A
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 17:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S0z0k2gGDz9sR5;
 Wed,  4 Oct 2023 17:20:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696432854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYBUFR18IcX94jtN157Zc49BKCwmJ++1jeXSBopJq0w=;
 b=eYqsl5eysLcdBp+fhxX+77gynrXkVUgfdDqZUxqbUfaftYdMqucDexSSEBXhAe7gxh9hVH
 9oTwXAeJomrvx89CnEp31/hD2cPVQWpW72jdqkNfCojB5iEpgue5M/hhh78Ea/Ap+FoAD6
 uCFYt974MMCU4rPLSLFFTZtEsDMlEaNBlzZ3oNDcUG8z7h3Kj81y/pvJbFs243zM/ofH2G
 V8hXr6nxeUIlQognIbnMbRoVkYf0LZWrtx8RwBMRgtabeW0uiCpppD/i/kdMGMKYj5p5Yf
 EgPwKeO6C+zV5g7uDCSUz5d8AeNdF7rpfN4JE8hMbYBrK0hO2R9Oc5SrO94wNQ==
Message-ID: <e40c7ae1-99b2-455a-88ba-ef2c9eb21822@mailbox.org>
Date: Wed, 4 Oct 2023 17:20:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 14/16] arm: rmobile: Support RZ/G2L memory map
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-15-paul.barker.ct@bp.renesas.com>
 <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>
 <4ee54918-cb7f-b6e1-a712-31b613c4f8ea@bp.renesas.com>
 <f3f30fb3-65ed-4070-9f5a-2efd84acc722@mailbox.org>
 <20231004135402.7hnhb2li66ixyro3@GBR-5CG2373LKG.adwin.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231004135402.7hnhb2li66ixyro3@GBR-5CG2373LKG.adwin.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6e44615c9dc9688b8fb
X-MBO-RS-META: bw8dd5smop7m5ctwyonsqpd55u9jqacr
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

On 10/4/23 15:54, Paul Barker wrote:
> On Wed, Oct 04, 2023 at 02:30:53PM +0200, Marek Vasut wrote:
>> On 10/4/23 11:18, Paul Barker wrote:
>>
>> [...]
>>
>>>>> +static struct mm_region rzg2l_mem_map[RZG2L_NR_REGIONS] = {
>>>>> +	{
>>>>> +		.virt = 0x0UL,
>>>>> +		.phys = 0x0UL,
>>>>> +		.size = 0x40000000UL,
>>>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>>> +			 PTE_BLOCK_NON_SHARE |
>>>>> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>>> +	}, {
>>>>> +		.virt = 0x40000000UL,
>>>>> +		.phys = 0x40000000UL,
>>>>> +		.size = 0x03F00000UL,
>>>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>>> +			 PTE_BLOCK_INNER_SHARE
>>>>> +	}, {
>>>>> +		.virt = 0x47E00000UL,
>>>>
>>>> What's this part about ?
>>>
>>> This is copied from the RCar Gen3 memory map.
>>
>> I suspected as much. Please recheck the memory map instead of copy-paste and
>> make sure it is really matching the hardware.
> 
> Sorry, I wasn't specific enough there.
> 
> The addition of an entry at 0x40000000 of size 0x03F00000, followed by a
> gap until 0x47E00000, is coped from R-Car as the way TrustedFirmware and
> OP-TEE use the first 128MiB of system memory is the same. The mappings
> here are due to the software configuration of TrustedFirmware & OP-TEE,
> not due to the hardware.
> 
> The hardware itself has a pretty simple memory map which is shown in the
> commit message. The memory map in this file is complete.
> 
> I have a note in the commit that says "Within the DDR area, the first
> 128 MiB are reserved by TrustedFirmware.", I probably just need to
> expand on why we need the mappings at 0x40000000 and 0x47E00000, instead
> of just using the mapping from 0x48000000 that's in the dtb.

Yes please :)

The better the commit message is, the easier the long term maintenance is.
