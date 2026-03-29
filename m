Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85FB10D1487
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 03:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA9F83B8F;
	Sun, 29 Mar 2026 05:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u3wu1nDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBC883B8F; Sun, 29 Mar 2026 05:11:41 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868BA83B48
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 05:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fjztd5J2mz9tn6;
 Sun, 29 Mar 2026 05:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774753897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8LpuEPU2U4FCmDpji9UuCQtB/b8eSIsi3nvV/nOfBQ=;
 b=u3wu1nDeCQGjP8+xdxyYD7mG2WHRPARKc/uWsYCOIAPPOnCmNSMm0ROmALTVxQAXIdsPxY
 udNWq5NRHIZvZaQ/Pn2mRJzsgVdhCyhTImMqH/cG86hk8CQFbnqpJ/ytoViKvvnbpMGT+F
 8fkCboab/lWWXjPPnBHwPiqRli4SV5TJgcshjsrjSpClnoXx+Mawt+499WYVbfUVWLpw5+
 Yt5KzWzv1g775xRHhNcvC7/aI466fuLR5szgiahLhVHje6HHx3yoZs3f7Fvsa19HEtutHt
 Lhr8bnu9YNRxg28a4ZRK1rO+6QDeighZLREa83atG33LB5yc97lHkWON37jejw==
Message-ID: <5bcd1951-e7ba-4759-98d1-827004135304@mailbox.org>
Date: Sun, 29 Mar 2026 05:11:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Udit Kumar <u-kumar1@ti.com>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
 <20260316145027.GK502704@bill-the-cat>
 <b1f8bc9f-13fe-4931-a6b3-ae494632dd77@mailbox.org>
 <20260316171026.GN502704@bill-the-cat>
 <23cb1b70-1657-474f-ad02-8b49db12d0de@mailbox.org>
 <20260328230055.GA41863@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260328230055.GA41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5cc39caeb6e85158115
X-MBO-RS-META: u9pyhn81st9u5szh3o1md1fh1yco4c55
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

On 3/29/26 12:00 AM, Tom Rini wrote:
> On Sat, Mar 28, 2026 at 01:03:15AM +0100, Marek Vasut wrote:
>> On 3/16/26 6:10 PM, Tom Rini wrote:
>>
>> Hello Tom,
>>
>>>>>> +config SKIP_RELOCATE_CODE
>>>>>> +	bool "Skips relocation of U-Boot code to end of RAM"
>>>>>> +	help
>>>>>> +	  Skips relocation of U-Boot code to the end of RAM, but still does
>>>>>> +	  relocate data to the end of RAM. This is mainly meant to relocate
>>>>>> +	  data to read-write portion of the RAM, while the code remains in
>>>>>> +	  read-only portion of the RAM from which it is allowed to execute.
>>>>>> +	  This split configuration is present on various secure cores.
>>>>>
>>>>> Is this really configurable, or is this determined by the SoC? This
>>>>> feels like something a board should be select'ing rather than
>>>>> configuring and I do worry about boards abusing this in the same of some
>>>>> possibly dubious speed-up rather than the intented and valid use case.
>>>>
>>>> On R-Car X5H, the Cortex-M core U-Boot port selects this, the Cortex-A core
>>>> U-Boot port does NOT select this. So, this is neither SoC level
>>>> configuration nor board level configuration, this is SoC CPU core level
>>>> configuration. I can definitely hide this symbol and conditionally select it
>>>> on SoC level.
>>>
>>> At the high level, this sounds similar to the TI K3 platforms where we
>>> have a Cortex-R build and a Cortex-A build and so (ARCH_K3 && CPU_V7R)
>>> is valid in Kconfig. I assume there something similar in this situation,
>>> so yes please, thanks.
>>>
>>>>> [snip]
>>>>>> diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
>>>>>> index 6ee58f4edfe..b6a648708f4 100644
>>>>>> --- a/arch/arm/lib/relocate.S
>>>>>> +++ b/arch/arm/lib/relocate.S
>>>>>> @@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
>>>>>>     ENTRY(relocate_code)
>>>>>>     relocate_base:
>>>>>>     	adr	r3, relocate_base
>>>>>> +
>>>>>> +#ifdef CONFIG_SKIP_RELOCATE_CODE
>>>>>> +	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET
>>>>>
>>>>> Spacing. But if there's no other comments and propmting the user is
>>>>> correct, I can fix when applying.
>>>> Fixed in V2 .
>>>
>>> Thanks.
>> Either drop this patch and wait for V2, or I will send a follow up ?
> 
> Sigh, I forgot about my own feedback here even, I'll revert this in next
> shortly, sorry.
I can also send a follow up fix, which I already have in tree for this.
