Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF75C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 01:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2AF8789F;
	Mon,  4 Dec 2023 02:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ACq2kkBc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RERZgzc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F35878B0; Mon,  4 Dec 2023 02:06:03 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C919877B5
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 02:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Sk5844Rgtz9sXg;
 Mon,  4 Dec 2023 02:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701651956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmOkNfTfAJxzARdtXTlCz+2mFw8VRVLl3B8s7ChDHTc=;
 b=ACq2kkBch1D1Sf5XTf5FvTBe6tM2Ej49Efrw/s+dyzO6yMppcB2FNjflaHjLceni42SdEn
 j6kY4vj265Q/rR1eQctfAjQy8ed9xQ5l8sPGxwCD1lZUm9A6okkCjpvKoz4nqI/TOuQ3uL
 TGwb5epydzryhvaInK9BuYKdjV8C73GXwKqpa4YWQ8cD/XtPXCPhRq5P88OL6kL55cpnCX
 vSRxDWbjc8+1G6mjmQ02qv7rfHlSBVyFKmhLKYpENyxaTI95sNN1VY9fTBbYeNX2WRjIyJ
 fHnasZrgWPBweER9jetQLDJCBRbEJp1xyWyadAbaic8fdjRNefQXI1rgkxwZGw==
Message-ID: <e703f6ba-3e93-46ea-9228-c05dd603c0c9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701651954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmOkNfTfAJxzARdtXTlCz+2mFw8VRVLl3B8s7ChDHTc=;
 b=RERZgzc8ZRY9fMbqdHvGKUgUBdcWrKhPfqWCxVsJStiYaGntAGUX3qkqdkfC3k2hKaQxGJ
 NpfqmwHAIpunrK6UnX97RW0iD3zvz9YlaBAWB7c8JeHbYWmjX18sFp3ItpCYKen+KAi1jh
 7YIr7Fqsun6m5D4PLOp+kmCSIxe9n8IBCboy/4YGBfVAK73mWEoLpGgj+QJNXEiRiX1Xgm
 B1S7WoZN+EKkSrzuI5vqSNaFEzKo4xj4Y1U7Kt4T01ncgA9+lC3Gi9zaGMOmChu5uN+an+
 jhTY6FUb3Jowj+qlYVb5Kzvo5N+bLkndg65gTIJcZCYcTRPmksPkNAvih6vrhw==
Date: Mon, 4 Dec 2023 02:05:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Poll CD in case cyclic framework is enabled
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ1__QvjN2C8Gc_GCvB++HFv6Ni73nC6wDuN7dJq+wDwGA@mail.gmail.com>
 <9dbad2ea-2439-4974-930f-ca80c6551615@mailbox.org>
 <CAPnjgZ3FcKAAMqB=nZ24ritOwucWxQXmTtZCrDnBp_9qHWm-wA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPnjgZ3FcKAAMqB=nZ24ritOwucWxQXmTtZCrDnBp_9qHWm-wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a70c7abc33cf8a72c0b
X-MBO-RS-META: dhzfjr6udjggu793y166m9jwinobm19s
X-Rspamd-Queue-Id: 4Sk5844Rgtz9sXg
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

On 12/4/23 01:44, Simon Glass wrote:
> Hi Marek,
> 
> On Sun, 3 Dec 2023 at 14:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 12/3/23 18:44, Simon Glass wrote:
>>> Hi Marek,
>>>
>>> On Sat, 2 Dec 2023 at 16:41, Marek Vasut
>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>
>>>> In case the cyclic framework is enabled, poll the card detect of already
>>>> initialized cards and deinitialize them in case they are removed. Since
>>>> the card initialization is a longer process and card initialization is
>>>> done on first access to an uninitialized card anyway, avoid initializing
>>>> newly detected uninitialized cards in the cyclic callback.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Cc: Peng Fan <peng.fan@nxp.com>
>>>> ---
>>>>    drivers/mmc/mmc-uclass.c | 27 +++++++++++++++++++++++++++
>>>>    1 file changed, 27 insertions(+)
>>>
>>> This is really nice!
>>
>> I wonder whether we can use this cyclic stuff for USB , that's on my
>> roadmap to look at . We could auto-detect new devices in the background,
>> which would be tidy. And maybe do block transfers in the background ?
> 
> Just the detect would be amazing!!
> 
> One thing on my mind is that we could have a console buffer, so that
> output from background tasks can be collected and written just before
> displaying the U-Boot prompt. I am itching to implement that part of
> it :-)

And a 'dmesg' command to go along with it ?

Go for it.
