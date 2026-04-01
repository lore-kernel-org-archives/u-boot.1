Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF11210F6FD9
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5713283CE3;
	Wed,  1 Apr 2026 17:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IBTBoWI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A26383F7D; Wed,  1 Apr 2026 17:40:53 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2766F80517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fm8Mj2kn4z9vHM;
 Wed,  1 Apr 2026 17:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775058049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpGgdl8aUZOJv1H2JssHtoMr3a4uPvWlYTxgBALxoZ8=;
 b=IBTBoWI7i3HHWx9U+2PmHgY/04q3F0FTX38zlIOiJLp3Q9z5OtidPwj0DJavExZNJIOrLs
 m28/pMxMqYe1TOFivIWxYGMRjQ+ksjGvvKNHkkik+TBoOEZ8vlVE3/Is5nhg1NVQJzgyyN
 D0ttNE2QSOsfjEhJCuGtqF3vvae4vjjSHdlMqmxqGAhk5YOsbutKzGCAkBGmyCY0D+XOPK
 TMlclGGX+6JrQ5JtAcpoJew1MoifKJGk8X8PEUe+bns237YXyRdaazkNiTJ5OYtNZP60R5
 WOOphC03s0F0JKynaeT2YLEwZXnmukECBe3Rlvefk/XKXsWBh4bYDfB4qBOytA==
Message-ID: <b5b94815-f0bf-4a4b-b62c-d7a2e85fb48f@mailbox.org>
Date: Wed, 1 Apr 2026 17:40:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to
 determine the memory size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
 <cbe4109d-7290-4104-8142-076b3296e13a@mailbox.org>
 <CAC_iWjLOJs-C4W=9EcY2DEVRde8Qqmmqb3b3h4+hGn1r9Pab+g@mail.gmail.com>
 <e8bcf2e6-9962-4c82-b38d-f803a69028d6@mailbox.org>
 <CAC_iWj+MyguKpRz7kcfSyaASiUUH2P=YW84zu5xy13pCh6zV+Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWj+MyguKpRz7kcfSyaASiUUH2P=YW84zu5xy13pCh6zV+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: df1d21fed2d8241e13a
X-MBO-RS-META: 4ktnb74qpudix74giiz4zgfhukbp5141
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

On 4/1/26 5:29 PM, Ilias Apalodimas wrote:
> Hi Marek,
> 
> On Wed, 1 Apr 2026 at 18:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 4/1/26 8:43 AM, Ilias Apalodimas wrote:
>>
>>>>> +++ b/include/fdtdec.h
>>>>> @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
>>>>>      * invalid
>>>>>      */
>>>>>     int fdtdec_setup_memory_banksize(void);
>>>>> +/**
>>>>> + * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of
>>>>> + *                        all banks
>>>>> + *
>>>>> + * Decode the /memory 'reg' property to determine the memory available in all
>>>>> + * banks and populate the global data ram_size with it.
>>>>> + *
>>>>> + * This function should be called from a boards board_get_usable_ram_top().
>>>>
>>>> Is the board_get_usable_ram_top() really the right place to call this ?
>>>> It feels like it is being conflated with ram_top here too.
>>>
>>> I don't think so. You are effectively calculating the top address you
>>> should relocate to. You should also calculate the difference in
>>> ramsize. Those two should not be separated actions
>> The address where you relocate to is gd->relocaddr, which is ram_top
>> minus all the reserved areas, see common/board_f.c setup_dest_addr().
>>
>> This setup_dest_addr() function does manipulate with gd->ram_size , but
>> only to handle CONFIG_SYS_MEM_TOP_HIDE , which may not be the right
>> place for it, I think it would be better to have a separate initcall for
>> the ram_size calculation, which precedes setup_dest_addr().
> 
> Yes, but when you calculate the reloc address and use a bigger
> ram_top, the right thing to do is adjust the size as well

That is the root of my concern, ram_top and ram_size are always the 
same, relocaddr is not.

>> With that, the function description can claim that each function must be
>> called before that specific initcall, fdtdec_setup_mem_ram_top() before
>> setup_dest_addr() and fdtdec_setup_ram_size() before
>> setup_whatever_is_the_new_initcall_name().
> 
> I really don't mind. I just don't see the point of making things so
> granular. Unless I am wrong and someone thinks it makes sense to
> change ram_top without taking into account the size.
Maybe it would make sense to decouple relocaddr from ram_top/ram_size 
calculation ?
