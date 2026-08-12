Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E539BC5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E97B80CC3;
	Wed, 12 Aug 2026 13:09:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOirTM7HYGcW; Wed, 12 Aug 2026 13:09:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71B0B80C46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786540148;
	bh=gTkDFDbgqSnBLvYva3tJ4ps6wF+tpElk6Mp86xo1U20=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sNijj+Mi9qlKvTsxh5cvhmI/3QaLW0zkdT2Iyb42Qy3n5RxCMjti0gwQp+sQs8gds
	 j43karVsCOf0wZK+9VssjqFOX3rr+5OAdMp1i2bCnndxwFNGltaDq37XuzGRti+jgE
	 lsvLryhNKPPYP4OTYsSyK7Mtqn+sptwQuYY1TsOhtGahNxBABebu/ANSSrLzkEf6Os
	 kgUcVAfh/JpZCrx8gJf76sGZyFKE+cWKuzd4PcOgUyjP4KOvMiJXBVtRg2gxwK4Z9o
	 utEuJ34b54nOah8LsXl41mQcYFtxXQh0JmeA4lL8P96h6bxk5jOs+ZvL4YyV7V9XvY
	 +339DTWXGerEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71B0B80C46;
	Wed, 12 Aug 2026 13:09:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 297CC3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0FF7C4088F
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ImkFgv1iZCTT for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 13:09:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E84CD408A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E84CD408A5
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E84CD408A5
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:09:05 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hKpj93jBzzMlPJ;
 Wed, 12 Aug 2026 15:09:01 +0200 (CEST)
Message-ID: <b3e35156-e1ec-4be4-9693-df16eb82016d@mailbox.org>
Date: Wed, 12 Aug 2026 15:08:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
References: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
 <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
 <f71ebcbb-6cdc-4c07-8d1e-0f39ccbfa141@mailbox.org>
 <5ef6b6eb-5f90-47cc-8c87-872c01eaf3bd@amd.com>
Content-Language: en-US
In-Reply-To: <5ef6b6eb-5f90-47cc-8c87-872c01eaf3bd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y918srodod169xt7i8zu4nbmfet633cs
X-MBO-RS-ID: 06109acc3dfaa5dfbd9
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786540141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTkDFDbgqSnBLvYva3tJ4ps6wF+tpElk6Mp86xo1U20=;
 b=XBa7ybBh+qJ13ORBxb4lB+0UxAtuaAGCkcg1skbv6CC7YRwfsaeTu6DN9j6c58Y/AA8XZC
 rBsPXDvBjdLpH5eqhMpNUrz9GNRjbdqaU11qndpcwc0Njq2k66VaMvO3W0LAn8HngQw+dJ
 8zH3CbY6734nepJzhAnHEN75PLwNxdUprlkwYn0Iw7I8VMBnJ5wbUtLdn0xmf4BPdKQF6N
 WxsGlUaT+30U0eH2puaNNUosIelpSx/VM+cRM4ZJ4MwErfTvk9z51IdAf8/T2GtHXlAcm8
 uY6IR4eOScp/Rk8iV5liMWf5UMRaTIdzFxbHw4k2cLcFJlqme7pbBh+xpeBQNQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=XBa7ybBh
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/12/26 1:28 PM, Michal Simek wrote:
> 
> 
> On 8/12/26 11:11, Marek Vasut wrote:
>> On 8/12/26 8:35 AM, Michal Simek wrote:
>>>
>>>
>>> On 8/10/26 13:37, Michal Simek wrote:
>>>> Versal Gen 2 and especially march-versal2 is not covered by own 
>>>> fragment
>>>> that's why add it.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>   MAINTAINERS | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index e1379a6a3e7e..eb48eea55c5a 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -821,6 +821,12 @@ F:    drivers/spi/cadence_ospi_versal.c
>>>>   F:    drivers/watchdog/xilinx_wwdt.c
>>>>   N:    (?<!uni)versal
>>>> +ARM VERSAL GEN 2
>>>> +M:    Michal Simek <michal.simek@amd.com>
>>>> +S:    Maintained
>>>> +T:    git https://git.u-boot-project.org/u-boot/custodians/u-boot- 
>>>> microblaze.git
>>>> +F:    arch/arm/mach-versal2/
>> Use "N: versal" instead for the globbing match .
>>
>> In fact, "N:    (?<!uni)versal" above does not work ?
> 
> nope
> 
> Before
> $ ./scripts/get_maintainer.pl -f arch/arm/mach-versal2/
> Tom Rini <trini@konsulko.com> (maintainer:ARM)
> Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:ARM)
> Michal Simek <michal.simek@amd.com> (maintainer:ARM 
> VERSAL,commit_signer:14/15=93%,authored:10/15=67%)
There ^ you are , what's the problem ?
