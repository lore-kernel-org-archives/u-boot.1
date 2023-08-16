Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24122C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90002846C0;
	Wed, 16 Aug 2023 17:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SEIVJ7kD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wcbIOMUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828A680DF7; Wed, 16 Aug 2023 17:23:59 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C84D846EE
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RQsNn025Vz9smn;
 Wed, 16 Aug 2023 17:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692199433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDIeHK0LjU67eNtv5OY83aV2RPgavrgdaKArDJieWLo=;
 b=SEIVJ7kD85MUJZEGtncrb0nVXo5jl4Cc9vpWVR2X/tnekgW0V63b3JLv3gO/HIUilrtRrW
 sxjWuDvoK0pVvULHLMtDT4oQg2WB4PId9a7XTo0X9ob/1K9XYAsC8NbQ+a4AlZU/GJNEPA
 RGT7aAkAUP8nqy04Yv6tg436+C4GFAzUMnxZgfeb7LFoijGG759UCutfWsw1E/ul29Vi5H
 0BRCzqLL+xFaEWgyYTnyQKtgnMLstAyXGVV8DsN2hNDgX9Bq/9f61LDrMpfB0j1qrNo13T
 pZ/iiFZRcecuMoemqWah6nxdREaaNRb/ak+pCHvwsZ/r7gJCC6toaoB6wEBZUQ==
Message-ID: <8de3268a-5f25-d47b-cc82-0c6ff12aab4a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692199430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDIeHK0LjU67eNtv5OY83aV2RPgavrgdaKArDJieWLo=;
 b=wcbIOMUBpOTzGrj6ovEmKrhPyX6tuUqk+cR3e0972gOLUQGYyRDc5bqz1xhTGjViNRf1PF
 4AkXj6luj5Gs7h3cTw6mt3VS1Nj5TbQE7V+dJqYkDz1G4QWFUnSQ4EhGgyh6J5PqxztrKK
 ZlK3RVtY9/OQqK4FjwJmKLJgEZ63tAsVGaHlzvRxdUWZANYqabQ7oobVE1H4e3EQW4JWVt
 I6D/9u6Q+cR0iEnB+glXD1VZiykmshZ4jyx075+cWLTRFgDO1ZaSAkHZcHlsLLYRch7ycM
 PVqXLochb/iNHqr/KIWgNBR4+8CsdbtveoTAQqKH617jH1c5C1iJR+1pOTN/7w==
Date: Wed, 16 Aug 2023 17:23:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] log: select physical address formatting in a
 generic way
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 marek.vasut+renesas@mailbox.org, nd@arm.com, trini@konsulko.com,
 u-boot@lists.denx.de
References: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
 <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
 <e41876d3-7bc2-08f7-9573-0aa7e7a7153a@mailbox.org>
 <CAPnjgZ3=7oGkM_FmKc097VALOgQVfmHDqcnUfh19+-9Ccd+=pA@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPnjgZ3=7oGkM_FmKc097VALOgQVfmHDqcnUfh19+-9Ccd+=pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f24d7e0d905ffc087b3
X-MBO-RS-META: a9rcu5rcxxdj75i1uebmg9ucs6o7zdkc
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

On 8/16/23 16:39, Simon Glass wrote:
> Hi Marek,
> 
> On Wed, 16 Aug 2023 at 05:13, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 8/16/23 13:05, Abdellatif El Khlifi wrote:
>>> sets the log formatting according to the platform (64-bit vs 32-bit)
>>
>> Use imperative mood please, see
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
>>
>>> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> ---
>>>    cmd/armffa.c  | 8 --------
>>>    include/log.h | 9 +++++++++
>>>    2 files changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/cmd/armffa.c b/cmd/armffa.c
>>> index 7e6eafc03a..ab0fd54d97 100644
>>> --- a/cmd/armffa.c
>>> +++ b/cmd/armffa.c
>>> @@ -13,14 +13,6 @@
>>>    #include <stdlib.h>
>>>    #include <asm/io.h>
>>>
>>> -/* Select the right physical address formatting according to the platform */
>>> -#ifdef CONFIG_PHYS_64BIT
>>> -#define PhysAddrLength "ll"
>>> -#else
>>> -#define PhysAddrLength ""
>>> -#endif
>>> -#define PHYS_ADDR_LN "%" PhysAddrLength "x"
>>
>> Would it make sense to implement printf '%pa' formatting string instead ?
> 
> The problem is that it is not a pointer. Also we want the compiler to
> check the size.

What does Linux use ?
