Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9DEE63CA2
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 13:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C139F83A5A;
	Sun, 25 Jan 2026 14:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CVUQYcW9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E351E83CAA; Sun, 25 Jan 2026 14:40:24 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0753883A36
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 14:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0DF4510D8FE; Sun, 25 Jan 2026 14:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769348421;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+qLgTaZRPRtxBJTSuY/rRzQwhMfVZIpMDifEbiO6460=;
 b=CVUQYcW9fC69HL9FXJZk+DdVQBk8H3Af+OVGKf//KZEEZ8B5TJ3004K2JOlxhHFObkT8l+
 Elf7KPLVm2RAe2+LjnWNnpyQO3ytz8ibkkd3DIYIDm6ceLoIf7p9oqHPLqVruyCXReK/9c
 jp7P7pcQVLTl11RtYoL7+MxGbTWUq3IiOvMXTZCcmbmIKMjLu3/qIX2WwvtF5HgSwE0SUq
 938uRNvlzfCXRmE7s7lbEP9EyiT4COFmLB0Z/3FIklK1JONg0lXQQCbJm89OTCsM554sGS
 XmCsiRipLaOBar6hIzidY6AaQaPVxGhPlXpmbO2igMHYhAT2jBAQXeZVTiRUow==
Message-ID: <bc070525-be93-bc4d-683e-e7b481560d28@nabladev.com>
Date: Sun, 25 Jan 2026 14:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] env: add w flags for net config in explicit write mode
Content-Language: en-US
To: Benjamin ROBIN <benjamin.robin@bootlin.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adrian Freihofer <adrian.freihofer@siemens.com>
Cc: Benjamin ROBIN <dev@benjarobin.fr>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260124054040.7597-1-hs@nabladev.com>
 <2397776.ElGaqSPkdT@brobin-bootlin>
 <31984d37-7857-f6f1-fe58-96d064d45019@nabladev.com>
 <8634622.T7Z3S40VBb@brobin-bootlin>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <8634622.T7Z3S40VBb@brobin-bootlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Benjamin,

On 25.01.26 14:33, Benjamin ROBIN wrote:
> Hello Heiko,
> 
> On Sunday, January 25, 2026 at 2:03 PM, Heiko Schocher wrote:
>>> Users who enable CONFIG_ENV_WRITEABLE_LIST typically want full control
>>> over
>>> which environment variables are writable. The new default behavior
>>> introduced by your patch might not align with what all users expect or
>>> want.
>>>
>>> Would overriding the flags using CFG_ENV_FLAGS_LIST_STATIC not work in
>>> this
>>> case?
>>
>> Good question, I have to test... or may Adrian has already done
>> such tests...
> 
> Please test.

We will do.

> 
>> But looking into code.. if we add this variables in ENV_WRITEABLE_LIST
>> the results would be, that this variables are twice in ENV_FLAGS_LIST_STATIC
>>
>> include/env_flags.h
>>    87 #define ENV_FLAGS_LIST_STATIC \
>>    88         ETHADDR_FLAGS \
>>    89         NET_FLAGS \
>>    90         NET6_FLAGS \
>>    91         SERIAL_FLAGS \
>>    92         CFG_ENV_FLAGS_LIST_STATIC
>>
>> once through NET_FLAGS and once through CFG_ENV_FLAGS_LIST_STATIC
> 
> Yes, the variables with the flags would be declared twice.
>   
>> So, that is not good, and I think, code will find the first
>> entry, and parse it -> so it will not work.
> 
> What leads you to this assumption?
> 
> If you examine the code, you'll notice that:
>   - The env_attr_lookup() function returns the last entry.
>   - When iterating over the flags using env_attr_walk(), any previous attribute
>     flags are overridden by subsequent flag declarations.

Ah, thats the trick! If this is the case, I aggree, and we can
simply drop this patch!

> 
>> Should we instead in case CONFIG_ENV_WRITEABLE_LIST is enabled
>> only set/allow CFG_ENV_FLAGS_LIST_STATIC in ENV_FLAGS_LIST_STATIC ?
> 
> I haven't tested this myself, as I currently don't have a test environment
> available. Please test it, and if it doesn't work, the correct fix would be to
> ensure that any future flag declaration overrides previous ones.

We will test, thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
