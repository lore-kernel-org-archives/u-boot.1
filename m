Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFD3C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B1D8775C;
	Mon,  4 Dec 2023 09:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i36+bMvC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l/LqRnag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0FE876E0; Mon,  4 Dec 2023 09:01:28 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECF48775C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SkGMJ2lGgz9snJ;
 Mon,  4 Dec 2023 09:01:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701676876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZ3H762Hm2+O03mClkAvlURWaMDtqAZ/0LNSrtiIXHU=;
 b=i36+bMvCEtjNQG7xk08j8+a4TVzAVOc6+gpcGWlN0zdvXCJTMCclvvgFDhdm+T6NNhbYN3
 9a4CYjr6xLfV9+ufKuXaLVqFKrluZOJ/LQUCj74RJD89nxSUnXclubcJ64of3mFTG2OmLD
 vKuKxod74NrIDpAgdyD++j/U3FS8EgauN93MfVjrZ4fO8JZTbhsAvzk+z9sRamZrjNxL6m
 nvxWf2d7d3KVTJl+1b/26/c2DBbkWeMwScFNYjJpvRJWx6/URqV9ugM6eQtKwbuq16FAzR
 02G3DBm5L3LFMj/1eq/0Y9ZrSoYS043jmA4piNqwJJJHUGdH+zAL72/LE4Y8SA==
Message-ID: <3de60655-bf3f-48a4-b1a8-afa613865c14@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701676874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZ3H762Hm2+O03mClkAvlURWaMDtqAZ/0LNSrtiIXHU=;
 b=l/LqRnagfjyVpJ20OFmC9ETkPEE+EthJXEbEFzMJTJniuD6FZTwvw3F85KFEw6X6JbCrDZ
 zUjMdpZ2VLAF6/OYTxK4fy9f1iVypXwluoXkij3q6hcnFPUv+XISI2m6rqjdP1XiMVyCRt
 PN1iq01c9NQTE86i/6mJyL+tR7VzHd/tW2fugJzinMshlW2URawoOT+n3BD0rUOqDwgPWa
 NJ7NvMlCDzeHAF1jseKMni5gAWD3pKx73BRyN2SaGjdwIkC/BPjiHbChbSUHeDsyisLn/z
 kiemns8WWb8FL4+8sHqWJZWPzbd0p3nO62vnp6nVEEJIOZvvsvG8+LQsi/J8xw==
Date: Mon, 4 Dec 2023 09:01:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Poll CD in case cyclic framework is enabled
Content-Language: en-US
To: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ1__QvjN2C8Gc_GCvB++HFv6Ni73nC6wDuN7dJq+wDwGA@mail.gmail.com>
 <9dbad2ea-2439-4974-930f-ca80c6551615@mailbox.org>
 <CAPnjgZ3FcKAAMqB=nZ24ritOwucWxQXmTtZCrDnBp_9qHWm-wA@mail.gmail.com>
 <e703f6ba-3e93-46ea-9228-c05dd603c0c9@mailbox.org>
 <f557a3f7-a292-4c7e-b2ad-b5f7cf412b82@denx.de>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f557a3f7-a292-4c7e-b2ad-b5f7cf412b82@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e07cd51ff19bc790746
X-MBO-RS-META: qpjoih4ese6uusxrj1dzqu7pjho1xa34
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

On 12/4/23 08:27, Stefan Roese wrote:
> On 12/4/23 02:05, Marek Vasut wrote:
>> On 12/4/23 01:44, Simon Glass wrote:
>>> Hi Marek,
>>>
>>> On Sun, 3 Dec 2023 at 14:01, Marek Vasut <marek.vasut@mailbox.org> 
>>> wrote:
>>>>
>>>> On 12/3/23 18:44, Simon Glass wrote:
>>>>> Hi Marek,
>>>>>
>>>>> On Sat, 2 Dec 2023 at 16:41, Marek Vasut
>>>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>>>
>>>>>> In case the cyclic framework is enabled, poll the card detect of 
>>>>>> already
>>>>>> initialized cards and deinitialize them in case they are removed. 
>>>>>> Since
>>>>>> the card initialization is a longer process and card 
>>>>>> initialization is
>>>>>> done on first access to an uninitialized card anyway, avoid 
>>>>>> initializing
>>>>>> newly detected uninitialized cards in the cyclic callback.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>> ---
>>>>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>>>>> Cc: Peng Fan <peng.fan@nxp.com>
>>>>>> ---
>>>>>>    drivers/mmc/mmc-uclass.c | 27 +++++++++++++++++++++++++++
>>>>>>    1 file changed, 27 insertions(+)
>>>>>
>>>>> This is really nice!
>>>>
>>>> I wonder whether we can use this cyclic stuff for USB , that's on my
>>>> roadmap to look at . We could auto-detect new devices in the 
>>>> background,
>>>> which would be tidy. And maybe do block transfers in the background ?
>>>
>>> Just the detect would be amazing!!
>>>
>>> One thing on my mind is that we could have a console buffer, so that
>>> output from background tasks can be collected and written just before
>>> displaying the U-Boot prompt. I am itching to implement that part of
>>> it :-)
>>
>> And a 'dmesg' command to go along with it ?
>>
>> Go for it.
> 
> It's very nice to see, that the cyclic infrastructure is finally getting
> used by other interfaces / devices etc. Really interesting. I assume
> there are many more potential use cases where it may be helpful.

Yes, many indeed.
