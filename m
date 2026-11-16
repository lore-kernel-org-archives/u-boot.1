Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94385606A32F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VarrBrt5;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=h/QwSYlM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51C886071E;
	Mon, 16 Nov 2026 10:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id czwEdBLzczWJ; Mon, 16 Nov 2026 10:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 708B16067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794825937;
	b=TylK0sotQKAWyMxxOaY8kbWH3wZfZwyLmK63F5MlAwqn6QY2Twq/AKcdKxs+JA7ikwQW
	 1y3WN6ePcEWFaRg0CooAPnoq+S+oXSXcSDvkJsWu7NamQKRKgQI4sKRFcjzp052OukqT5
	 oQ1eiOAYz2V7AC0PvFS8VjrGxVx25dtXHc9wVs1OpLADzRSiCebhV1OBz/AqCyCZta+Iz
	 RdORHxx5moS+8i3+4107tKDfatQzns3TV22pE/ScTeTGm37oH8JHehX9cHljmIuUd296P
	 uytHqjczbtSg3f94/SG9NiU+xHwhpoVzoM8f0Xysm4sB5GOGhmGy8COdMGHggZNJm/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794825937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XvMZ4ZFJCpG1Qitvm2YDdpS9N6r2BEmq+tQY8Bet20w=;
	b=RQceT6VkbTE+jI7Jm4JHxkMRuSllvfBOc/o7QgfqnboXX0N/QID8Hfbwx3Ry7+Y28hAd
	 mtgf6FlgL28mXUnQD5fjLugIbfhCWHAcZTM8M/bPE0dVeec9PKVhO/ShdmN6zBuQjAglh
	 BAvA0wfDUGzviqLPGSHY4WImOzHSbHmZOIJz7Q0Ka3FP/UNi0yFe7TZDEnWqwCKN95j02
	 qSzd6gtI6UsDuR05iMK04NdqHs2Pqn9f/O1guYHOXlYkGCcVFXuNjHPG3HebJkf7a+x3i
	 xUKp/fM8Sx6tFZql/Y46rqj/VoceyxlK/iLAqGKxlwZ0QXxAoJ96bbY02oqyG10DpzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794825937;
	bh=XvMZ4ZFJCpG1Qitvm2YDdpS9N6r2BEmq+tQY8Bet20w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VarrBrt53WGbOkPyIMX9HBSvB87Xk/VDaJt8Y+zlo8cdAZ0HKR86oH/pxrlMEIp+f
	 iu1rgTp7UyT/4FiYFKyT+HWug8ylC6M0TXgXXsR1DdzY9K7G9nuydZRhiy/uS3mflO
	 CiakpKWvrd7UR9SFtkBUkWO2E8PWEkWBmmuJh3ifkNIPHUVoM7ju0Oalfncwzy3rie
	 9mVcqgycm49zEZRe6R0JwHU14gBRjbVtRtXUzXBkOL8/P9qVM/WkfGBOK5lRC5aNDq
	 YFFoEFi+g+4X+B2XUtBj7hp0sPY6sqxIB9mhO8Ps6Udh9bqTOX9KUy3NTAquXQGfmi
	 4VEiq6NupbLGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 708B16067D;
	Mon, 16 Nov 2026 10:45:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 040794DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9C27400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P27spr4YUUTC for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 88B294009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:38e0::8faa"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::8faa; helo=smtp-8faa.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=h/QwSYlM
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::8faa])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88B294009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:45:33 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSkzH0R9Zz1ptK;
 Mon, 16 Nov 2026 11:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794825930;
 bh=XvMZ4ZFJCpG1Qitvm2YDdpS9N6r2BEmq+tQY8Bet20w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h/QwSYlMY8dAzR1dsvIO3kZiVvh8YofTOacivpR+cyz3Z8hry/RunBBrceOf5MTEA
 OlQcHQQN+E3k75aVMN/9KWIiIybltmYIJwpd6XtRXVfFMsdpFmKs0wr1rkTyrLd+xm
 m52J9MiaPOXehEpx0PHpm13wW2B5P182RL3Mq0qQuFP0YnPG2iiK9JSZ8Dsi6JDjCj
 cvIMVg2sFxcwWQ14O0w0doPvBLYjFZ91WkleqGp3fOkaR/5mtMAHAcLGHTpuLNM3ze
 MqXnIA9dhHmm5lNlUg6wPVuAAw/EiKUwQD068w5GNlOVdKRX2GiFpWodoD0eyTkln8
 Suy//lXQn5ijg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jSkzG1wFFzsV2; Mon, 16 Nov 2026 11:45:30 +0100 (CET)
Message-ID: <1f9961fb-2c28-431d-b3f0-c453d4ba43b6@0leil.net>
Date: Mon, 16 Nov 2026 11:45:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ram: rockchip: add config option for tinier debug
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-4-b82ff9c860ba@gmail.com>
 <29c060b0-17c1-43a8-90f0-f517ac874268@0leil.net>
 <CAC928HY5SW0akmHG-tJ-wA6F0a_2ZokChr5K7N+HqBLvch3pTQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928HY5SW0akmHG-tJ-wA6F0a_2ZokChr5K7N+HqBLvch3pTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/15/26 11:34 AM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mer 11 nov 2026 alle ore 17:23 Quentin Schulz ha scritto:
>> Hi Massimo,
>>
>> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
>>> Selecting the RAM_ROCKCHIP_DEBUG_TINY new configuration option, the
>>> debugging code prints only the SDRAM type, frequency and size, limiting
>>> the required space. In this way, the debugging code can coexist with
>>> support for multiple SDRAM types without exceeding the output size
>>> limit, such as in the case of the PX30 SoC TPL.
>>>
>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>> ---
>>>    drivers/ram/rockchip/Kconfig        | 11 ++++++++
>>>    drivers/ram/rockchip/sdram_common.c | 54 ++++++++++++++++++-------------------
>>>    drivers/ram/rockchip/sdram_px30.c   |  4 ++-
>>>    3 files changed, 41 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
>>> index f51ae6a4542..98770659cd2 100644
>>> --- a/drivers/ram/rockchip/Kconfig
>>> +++ b/drivers/ram/rockchip/Kconfig
>>> @@ -24,6 +24,17 @@ config RAM_ROCKCHIP_DEBUG
>>>          This is an option for developers to understand the ram drivers
>>>          initialization, configurations and etc.
>>>
>>> +config RAM_ROCKCHIP_DEBUG_TINY
>>> +     bool "Rockchip ram drivers tiny debugging"
>>> +     depends on RAM_ROCKCHIP_DEBUG
>>
>> question: do we really need a new symbol for that?
>>
>> Maybe we can simply have a constant (e.g. DEBUG) defined at the top of
>> the file and check on that. I am trying to think if anyone would want to
>> have this configurable in a defconfig? If it's only useful for quick
>> debugging, I don't think it makes sense to have a symbol for it.
> 
> Quite true, indeed. But RAM_ROCKCHIP_DEBUG defaults to 'y', and 143 of the
> 152 configurations that have RAM_ROCKCHIP defined also have RAM_ROCKCHIP_DEBUG
> defined. Therefore I have thought about a Kconfig option, but we can consider
> a different solution: will do in a next series.
> 

Do you have an idea about the size impact of RAM_ROCKCHIP_DEBUG=y 
compared to RAM_ROCKCHIP_DEBUG=n, both with your series applied?

I'm wondering if we cannot change the meaning of RAM_ROCKCHIP_DEBUG. 
Essentially, always print the few infos we have about DDR, and have 
RAM_ROCKCHIP_DEBUG decide whether we print *more* instead of *all*.

 From ./tools/qconfig.py -f ARCH_ROCKCHIP '~RAM_ROCKCHIP_DEBUG', I think 
the problematic ones could be RV1108 and RK3036 boards which have very 
limited SRAM (12KB, 8KB). RK3566 and RV1126 have 64KB, RK3399 200KB and 
RK3588 almost 1MiB so they should be fine?

Cheers,
Quentin
