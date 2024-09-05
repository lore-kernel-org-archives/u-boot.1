Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0C0CD98FE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 18:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD7388CA2;
	Thu,  5 Sep 2024 20:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bWAzQL1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE5888CBB; Thu,  5 Sep 2024 20:33:04 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EEC588C1C
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 20:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X07Jr2SJbz9t3F;
 Thu,  5 Sep 2024 20:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725561180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmJCWiE8g/44htmJA6zvIla8UhHX+XdDLfxDz1dWHQg=;
 b=bWAzQL1m8+VdrHBZNB0elnxc4TRvczz+HeffR3RQr/7DO4ovgWXM0HrLHuYtlPBEAatuGv
 DsXClCGX2jjJqt6pg3kwcLvm6Ulke/ntApBdEJ66k39jUVd5KsC2Hs6P/JW2xU9SiwNwOd
 e/c3M2vzncwQ2uhzHyw17wSq5gwOTmcHsLBq3Hn9vd+fQYuVR69jKLpHT2GK80RcYsCWnl
 Q6vtzw2LPEQpdYNGA0XqIJLMbimprEeeD3XIkiGMd7CjN6F4kJLwNl28ZKMHpUBlq2C2HA
 aSA7niUPLybB5e8/LlJg3NGrze8M5WjYslxmqHcHgVYV15+KZ84qSXlsZoDJzg==
Message-ID: <9e31a388-98ca-4399-851f-1edc35ff7cd9@mailbox.org>
Date: Thu, 5 Sep 2024 20:32:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
From: Marek Vasut <marek.vasut@mailbox.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: 'Peng Fan' <peng.fan@nxp.com>, 'Simon Glass' <sjg@chromium.org>
References: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
 <CGME20240423231800epcas1p4e21bd06153b2394afd9a8696a4df6470@epcas1p4.samsung.com>
 <fab40e09-1ac4-45c3-8dda-f0a1544d2d39@mailbox.org>
 <000001da97a2$d3247950$796d6bf0$@samsung.com>
 <e55e21af-7208-4b4d-9398-ee1e4825f69b@mailbox.org>
 <050401da9a85$b24539a0$16cface0$@samsung.com>
 <d1eb5f12-0718-4a85-bfe1-3c141ee6b049@mailbox.org>
Content-Language: en-US
In-Reply-To: <d1eb5f12-0718-4a85-bfe1-3c141ee6b049@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b8c464a05817de331c6
X-MBO-RS-META: udcznq5ak4enduudf1oecidxm45myga6
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

On 4/30/24 3:48 AM, Marek Vasut wrote:
> On 4/30/24 12:36 AM, Jaehoon Chung wrote:
>>
>>
>>> -----Original Message-----
>>> From: Marek Vasut <marek.vasut@mailbox.org>
>>> Sent: Friday, April 26, 2024 8:41 PM
>>> To: Jaehoon Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de
>>> Cc: 'Peng Fan' <peng.fan@nxp.com>; 'Simon Glass' <sjg@chromium.org>
>>> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
>>>
>>> On 4/26/24 8:27 AM, Jaehoon Chung wrote:
>>>> Dear Marek,
>>>>
>>>>> -----Original Message-----
>>>>> From: Marek Vasut <marek.vasut@mailbox.org>
>>>>> Sent: Wednesday, April 24, 2024 8:18 AM
>>>>> To: u-boot@lists.denx.de; Jaehoon Chung <jh80.chung@samsung.com>
>>>>> Cc: Peng Fan <peng.fan@nxp.com>; Simon Glass <sjg@chromium.org>
>>>>> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is 
>>>>> enabled
>>>>>
>>>>> On 3/16/24 9:13 PM, Marek Vasut wrote:
>>>>>> In case the cyclic framework is enabled, poll the card detect of 
>>>>>> already
>>>>>> initialized cards and deinitialize them in case they are removed. 
>>>>>> Since
>>>>>> the card initialization is a longer process and card 
>>>>>> initialization is
>>>>>> done on first access to an uninitialized card anyway, avoid 
>>>>>> initializing
>>>>>> newly detected uninitialized cards in the cyclic callback.
>>>>>
>>>>> Any input on this ?
>>>>
>>>> When I have applied your patch from patchwork, it didn't apply 
>>>> directly.
>>>> If you're ok, I will apply after touch your patch. Is it ok?
>>>
>>> Sure.
>>
>> After touching your patch, I will inform again to you.
> 
> btw. what is the problem with the patch ?

Any news ?
