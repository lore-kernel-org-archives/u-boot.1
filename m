Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423EFE8B363
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 20:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F14583CBD;
	Tue,  3 Feb 2026 21:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PBI8pqjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2061883D3D; Tue,  3 Feb 2026 21:42:27 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AA283C39
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 21:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f5Fly2mgDz9tGQ;
 Tue,  3 Feb 2026 21:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770151342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvvP5p0G/JFixsLSQHqzUjKHFeP647pUTVf8TJAgGNA=;
 b=PBI8pqjNjFuPQf2VhAyFVTigbazHKcOxbTeOl0oP8S/SBgHk8dz/0g5Jx8G85hNUhAXplZ
 UEwDp6Jsic29lOtLMFWEj0vrOWisOgceRlWFbTz7FqIw7v9qUP9+w5S4xyrdPV0+WfojhZ
 wmUelqYKhMrfgiOGxW4QSyH8rU9Dxf+Gk0vjiyO/4ap0J/DHhH/2cop+/PIbG74GsbX+TQ
 uD3bIJXKXZxLd/q2GZHXiwCWgn/kWNiQ9BXcHrxnHDIjMut1utfBKSsOo8zg1r4UDfhwEs
 U+Bu9DDQLwcs9XzDvNa4NpRVHKCSn874vA8bZxOKpigXrKkB6zW9ELqDxRNXRw==
Message-ID: <40da5a20-d796-4123-a153-44b5ef6c6bdf@mailbox.org>
Date: Tue, 3 Feb 2026 21:42:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] gpio: Introduce gpio-delay driver and enable it on
 Kria
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, Fabio Estevam
 <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini
 <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <cover.1770105146.git.michal.simek@amd.com>
 <0097d26f-9e6a-4412-bd74-8c3a3bf19fa6@mailbox.org>
 <be5256e4-b99c-490c-9217-7671c53914ee@amd.com>
 <5f9895bd-4786-40b0-988e-e0b843c43fd0@mailbox.org>
 <c3d83865-c0e4-4478-90b5-0e291ad4e67c@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c3d83865-c0e4-4478-90b5-0e291ad4e67c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: en5ojyjd7pxtjzkdjnibgam6wbgnn9je
X-MBO-RS-ID: b1b6215ba10fc9df4b5
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

On 2/3/26 5:57 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 2/3/26 5:38 PM, Marek Vasut wrote:
>> On 2/3/26 4:32 PM, Michal Simek wrote:
>>>
>>>
>>> On 2/3/26 12:39, Marek Vasut wrote:
>>>> On 2/3/26 8:52 AM, Michal Simek wrote:
>>>>> Hi,
>>>>>
>>>>> we need to wait more time for getting USB hub out of reset to be 
>>>>> able to do
>>>>> initialiation over i2c that's why use gpio-delay driver instead of 
>>>>> changing
>>>>> waiting time in usb hub driver. Waiting time depends on gpio wiring 
>>>>> on the
>>>>> board which is in some of our case going via SLG programmable device.
>>>> Can you not use some regulator or make the reset assert/deassert 
>>>> time configurable via DT property ?
>>>
>>> Sorry not following. delay is configurable via DT now - the patch 3/3 
>>> for example.
>>
>> 3/3 never arrived in my mailbox, I think I was CCed only on 0 and 2 .
>>
>>> This avoid a need to change usb5744 driver to wait longer time which 
>>> is what we discussed in past.
>> If the delay is configurable via DT, why would the driver have to be 
>> changed ?
> 
> Delay is configurable via DT for the GPIO delay device. The delay is NOT 
> configurable via DT for the USB onboard hub device. Because of the 
> latter, the former is added as GPIO controller for adding delay to the 
> latter driver's reset line.

Oh, I see, thank you for the clarification.
