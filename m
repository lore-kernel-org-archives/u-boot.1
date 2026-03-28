Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E1B10BA424
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 06:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9675D83DA7;
	Sat, 28 Mar 2026 07:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qR/GI3uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E64083F14; Sat, 28 Mar 2026 07:44:06 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C1C83DCB
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fjSfB3ljPz9tpk;
 Sat, 28 Mar 2026 07:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774680242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6Zy7YH25Lqd9HHlQg9temN3+cj3u46x3Crzcp8TR3M=;
 b=qR/GI3uu+H2igxuxsvW90IHR0x3qR7QuHdybSEUl5ozwT8nm2VB8ypooSaE0Pgi9/6kJPL
 KHRiwmSH0gLDimoaMR4Ag7ypw68LDKjZwHFQmBYuNh/OMFTzbrwB+gvaPKK3Bs8cNsdFfB
 AhGKdiYYK6tRnNKBbECwjOCuXSOaTri09zU2+5fIEYBAQoHHAmzodqYBgnmXm11VW0cqrf
 EohLxkGlgrOhwdvkB3Q0wdp1Xck3Q0N+LfvKMaVW98j3hsYFHMYvypO46eltINDwtd+cvJ
 Cq7D01Eh3bbZfAcKLcPPzHYKDBnkk7nNjAPrIDA61yoM9xYiTbzQ2ElZQqbTAQ==
Message-ID: <23cb1b70-1657-474f-ad02-8b49db12d0de@mailbox.org>
Date: Sat, 28 Mar 2026 01:03:15 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260316171026.GN502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4f791dawinkju5f64k3rf5g41n51nauq
X-MBO-RS-ID: d3b9628451a4ff4ec1f
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

On 3/16/26 6:10 PM, Tom Rini wrote:

Hello Tom,

>>>> +config SKIP_RELOCATE_CODE
>>>> +	bool "Skips relocation of U-Boot code to end of RAM"
>>>> +	help
>>>> +	  Skips relocation of U-Boot code to the end of RAM, but still does
>>>> +	  relocate data to the end of RAM. This is mainly meant to relocate
>>>> +	  data to read-write portion of the RAM, while the code remains in
>>>> +	  read-only portion of the RAM from which it is allowed to execute.
>>>> +	  This split configuration is present on various secure cores.
>>>
>>> Is this really configurable, or is this determined by the SoC? This
>>> feels like something a board should be select'ing rather than
>>> configuring and I do worry about boards abusing this in the same of some
>>> possibly dubious speed-up rather than the intented and valid use case.
>>
>> On R-Car X5H, the Cortex-M core U-Boot port selects this, the Cortex-A core
>> U-Boot port does NOT select this. So, this is neither SoC level
>> configuration nor board level configuration, this is SoC CPU core level
>> configuration. I can definitely hide this symbol and conditionally select it
>> on SoC level.
> 
> At the high level, this sounds similar to the TI K3 platforms where we
> have a Cortex-R build and a Cortex-A build and so (ARCH_K3 && CPU_V7R)
> is valid in Kconfig. I assume there something similar in this situation,
> so yes please, thanks.
> 
>>> [snip]
>>>> diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
>>>> index 6ee58f4edfe..b6a648708f4 100644
>>>> --- a/arch/arm/lib/relocate.S
>>>> +++ b/arch/arm/lib/relocate.S
>>>> @@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
>>>>    ENTRY(relocate_code)
>>>>    relocate_base:
>>>>    	adr	r3, relocate_base
>>>> +
>>>> +#ifdef CONFIG_SKIP_RELOCATE_CODE
>>>> +	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET
>>>
>>> Spacing. But if there's no other comments and propmting the user is
>>> correct, I can fix when applying.
>> Fixed in V2 .
> 
> Thanks.
Either drop this patch and wait for V2, or I will send a follow up ?
