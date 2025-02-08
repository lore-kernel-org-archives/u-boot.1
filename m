Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76FEC0219B
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EC680821;
	Sat,  8 Feb 2025 22:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qi4f4EcP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tHGJJV75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FE68083C; Sat,  8 Feb 2025 22:31:17 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50DB280821
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Yr3tV6vhSz9sNf;
 Sat,  8 Feb 2025 22:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739050275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3a5ZR59nEorG/Ds3sfgyXth6T8RJXzLZQYcBNJPvfdQ=;
 b=qi4f4EcPMCWDjhO24/MkbhvraKqr5PFVd6CEbZ7WcKWwaLIJTLq459LCPblqpAULZxtDgB
 6C+cRo09QONeFPbmQwHeRTRdx/3NPDVGfFYTr8ufZv76CZMpg/6ZiyUvF2YOmehkw8ybBb
 NMOEQZJLmTlptdmj8YiVbad0MvVcyrQVHBmXTfrtyy5/WYE3Cyb6fL57Qh5oT+F/pvMqMa
 MMjKB4VIn16/BaIExfeyZ5098zhC5GMog7K9bUpMKKzZYd+Rdz+nkr/NX/8kVF9EPsAX6h
 ycwoE57gid8+Lxu81aYbcYIpVLNlQlG7ULr4AEsZZitaEq7yrFFDicxF0IG7LA==
Message-ID: <7810d42b-dbc5-4649-8aba-c2c5cd20c6e6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739050273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3a5ZR59nEorG/Ds3sfgyXth6T8RJXzLZQYcBNJPvfdQ=;
 b=tHGJJV75uYDwXQspX+SUSkyw60Rq5Hip37QlyNCtU6cVaEPG9q8FYqLhn6A8HHvGWbZn2N
 BfFa1bG3f8Ghq2ofrWbpnTNOHvEhTgNxMnlIaYNREGcHPsxk3UnVX1Akt8LBMoaLuYqslj
 tA1qdBaKhvjbZbaea9wO94hxZcjlwwvIZS7jAC8tBU7woiVsmqjojLIVz+8ED969dAjPib
 nKNkkY7vdqQjPIpA3QbhVgn3dBXPTFTnZBHV8JMBQUd7TUU7q1Woa7+Zc9LcqAxYpqdOf7
 OzCcEXCQRarm7TwVvIN1OB2+VqTOkO776nbV6i23XbQx0VD3kDGZ51dw/khtYw==
Date: Sat, 8 Feb 2025 22:30:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/17] miiphy: Introduce mdio_init()
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
 <78ea8dbd-56ae-49a0-b9f9-274a8cf9182a@bp.renesas.com>
 <273bc749-8378-40de-b533-6c58a4569f0e@mailbox.org>
 <dc02c0b8-55d3-49d7-8aae-012bad61b183@bp.renesas.com>
 <c025e008-48ee-41c0-ae47-2d348058a635@mailbox.org>
 <eeed65ea-94cf-4088-a169-6ab0af385439@bp.renesas.com>
 <6cf9dd5c-ca1e-4c02-bd7b-a9f38cec76e5@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6cf9dd5c-ca1e-4c02-bd7b-a9f38cec76e5@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d72a7fd4386fed9d2bc
X-MBO-RS-META: jhrx6wwke7xzni9ktp4hurfs36syswtq
X-Rspamd-Queue-Id: 4Yr3tV6vhSz9sNf
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

On 2/4/25 7:17 PM, Paul Barker wrote:
> On 27/01/2025 13:28, Paul Barker wrote:
>> On 27/01/2025 11:30, Marek Vasut wrote:
>>> On 1/27/25 11:32 AM, Paul Barker wrote:
>>>> Hi Marek,
>>>>
>>>> On 25/01/2025 12:56, Marek Vasut wrote:
>>>>> On 1/21/25 3:38 PM, Paul Barker wrote:
>>>>>> On 18/01/2025 06:53, Marek Vasut wrote:
>>>>>>> Introduce mdio_init() split off from mdio_alloc(), which is used
>>>>>>> to initialize already allocated struct mii_dev.
>>>>>>>
>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>
>>>>>> Replying here for the whole patch series...
>>>>>>
>>>>>> I like where we get to at the end of this series, but I don't like the
>>>>>> intermediate state where the bb_miiphy_buses arrays still exist but are
>>>>>> unused. I also think we should introduce a new ops struct so we're not
>>>>>> duplicating function pointers in each instance of struct bb_miiphy_bus.
>>>>>>
>>>>>> I would prefer the following order of changes, let me know if you think
>>>>>> this would be cleaner:
>>>>>>
>>>>>> 1) Introduce mdio_init().
>>>>>>
>>>>>> 2) Add mii member to struct bb_miiphy_bus.
>>>>>>
>>>>>> 3) Modify each driver to use the mii member of the appropriate struct
>>>>>>       bb_miiphy_bus instance, calling mdio_init() instead of mdio_alloc().
>>>>>>       At this point we're still using the instances in the statically
>>>>>>       allocated bb_miiphy_buses array.
>>>>>
>>>>> Those instances might be rodata , so using them as read-write storage
>>>>> does not necessarily work , does it ?
>>>>
>>>> None of the instances in the current U-Boot code are marked as const,
>>>> and the name field is already modified at runtime by each driver. So I
>>>> don't think we need to worry about them being rodata.
>>> Can the compiler not decide to place the structure into rodata if it is
>>> never written ?
>>
>> To my understanding the compiler cannot place anything in a different
>> section such as rodata unless this is explicitly requested with an
>> attribute (i.e. `__attribute__(( section(".rodata") ))` or a macro call
>> which resolves to this).
> 
> Hi Marek,
> 
> To follow up after our brief converstation at FOSDEM:
> 
> The important thing is where we arrive at the end of this series, the
> duplication we have in the intermediate state is unfortunate but it
> shouldn't be a blocker. If no one else is complaining, and it'd be time
> consuming to re-order and re-factor things, then please ignore my
> comments above and let's move ahead with your current proposal. I should
> have time this week to review the patches in more detail.
I did have one more look at this, but after a bit, I found out that this 
does not make the series easier, rather the opposite. Before 3) the 
driver does a mix of static and dynamic allocation of mdio and mii_phy 
structures , 3) would move the driver to static only allocation and 
remove the existing dynamic allocation, 11) would re-add the dynamic 
allocation . I'll be sending slightly reordered V2 now.
