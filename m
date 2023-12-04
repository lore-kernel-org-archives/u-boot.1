Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C97C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 07:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6851B8755D;
	Mon,  4 Dec 2023 08:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701674837;
	bh=CLBUdKsZjVda47AKm+Agy0t+NKA1TexPhAwvJ3l320w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQDnjseCz0nqXPYA+aN348FcDOhRD1X6Za1IHnyIGcuf/KU4CMmE8DKbwzRI4oPaL
	 aJ4KzYvlnQDSf5B5KDeJaSJUQhxprgcqgTLfhDn04OkguligQ16Ce187DYt/c1JACT
	 Og3eOmUbr6htnUfLO6aPdBDARIMwg1Oj0o6rgokSvncHxEOhkaAetBpmlAdFxSXrtZ
	 HS/tdnO48UwY1HsxHsnDi2n7YJW/InEYtEVah+dvAmNhSiMd1zwKGq3gbvdtgrAR7b
	 YauJdPXOW0K3H9A+DhgI4ZYcqUBenVlrdWxVSLeEd0sMY/O64grEzCZIg9yISecooY
	 guRFKvbB+EE4g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958948759E; Mon,  4 Dec 2023 08:27:16 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F6D87496
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 08:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SkFc20VLcz9sc2;
 Mon,  4 Dec 2023 08:27:14 +0100 (CET)
Message-ID: <f557a3f7-a292-4c7e-b2ad-b5f7cf412b82@denx.de>
Date: Mon, 4 Dec 2023 08:27:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Poll CD in case cyclic framework is enabled
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ1__QvjN2C8Gc_GCvB++HFv6Ni73nC6wDuN7dJq+wDwGA@mail.gmail.com>
 <9dbad2ea-2439-4974-930f-ca80c6551615@mailbox.org>
 <CAPnjgZ3FcKAAMqB=nZ24ritOwucWxQXmTtZCrDnBp_9qHWm-wA@mail.gmail.com>
 <e703f6ba-3e93-46ea-9228-c05dd603c0c9@mailbox.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <e703f6ba-3e93-46ea-9228-c05dd603c0c9@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/4/23 02:05, Marek Vasut wrote:
> On 12/4/23 01:44, Simon Glass wrote:
>> Hi Marek,
>>
>> On Sun, 3 Dec 2023 at 14:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>
>>> On 12/3/23 18:44, Simon Glass wrote:
>>>> Hi Marek,
>>>>
>>>> On Sat, 2 Dec 2023 at 16:41, Marek Vasut
>>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>>
>>>>> In case the cyclic framework is enabled, poll the card detect of 
>>>>> already
>>>>> initialized cards and deinitialize them in case they are removed. 
>>>>> Since
>>>>> the card initialization is a longer process and card initialization is
>>>>> done on first access to an uninitialized card anyway, avoid 
>>>>> initializing
>>>>> newly detected uninitialized cards in the cyclic callback.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>> ---
>>>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>>>> Cc: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>    drivers/mmc/mmc-uclass.c | 27 +++++++++++++++++++++++++++
>>>>>    1 file changed, 27 insertions(+)
>>>>
>>>> This is really nice!
>>>
>>> I wonder whether we can use this cyclic stuff for USB , that's on my
>>> roadmap to look at . We could auto-detect new devices in the background,
>>> which would be tidy. And maybe do block transfers in the background ?
>>
>> Just the detect would be amazing!!
>>
>> One thing on my mind is that we could have a console buffer, so that
>> output from background tasks can be collected and written just before
>> displaying the U-Boot prompt. I am itching to implement that part of
>> it :-)
> 
> And a 'dmesg' command to go along with it ?
> 
> Go for it.

It's very nice to see, that the cyclic infrastructure is finally getting
used by other interfaces / devices etc. Really interesting. I assume
there are many more potential use cases where it may be helpful.

Thanks for all your work on this,
Stefan
