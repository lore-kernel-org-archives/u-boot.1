Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39C0C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 03:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EE383189;
	Tue,  8 Jul 2025 05:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751946600;
	bh=JfiR3vUWMlsMImWf7zl8QPziR8mY9Bkv4PqXiAOd0fA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dxWfFdncY3CxSnvfALPsZC56dtsMUEG1EjHBqTJUmTi88KLjHl5fo1cOPBWaa1m7X
	 U02aWfZIOdEZy8RYLKjqMIWRnQiBVRfiLt89THJ6iw9GHP58XpwaBPPWN4pPVnzjRu
	 qWLLAkAakEuA5VtptG2PdqtdhkLkvD9OfJxlvusYDZlZB/+B/kWBEnJJkNjBWw3PsO
	 Sa4JGJ44RxvM9gIJ+OFmWjaNd1+y2eoNVu3tImrbpawux4IAH96+jUjhxibTeFhj9T
	 9UCiCur9411snuvgcvQ28P8ozq1cZHsPk0NTMWBaTNKOQsrp/Tig9MDDK3y41sQ+UK
	 /6c3vlokxzs/A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58888319F; Tue,  8 Jul 2025 05:49:59 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52C383145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 05:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZJ96VL6y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4B2601039729E; 
 Tue,  8 Jul 2025 05:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751946597;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=JfiR3vUWMlsMImWf7zl8QPziR8mY9Bkv4PqXiAOd0fA=;
 b=ZJ96VL6yFfzgJCTKBLoNli4Y4RisKd/SxEoYMM2uaA9ztto++FNpiG2L+6wMQGDdSCKaYS
 UeNnUaLpnHr4LP59Tq3Si92OKPMSGwwUPUTyiOBHjnEI/e6kVTQieluVaoQvrnRKwl+e/r
 OSDDX6J/Gjt6kFO7M0K/e1KRlGvKfbuhNz9Lb6TwpnrlS+mWayloaVKuEQsRscQhmq47KH
 0PTHp+bxgtXbgozVYsne6vUtoVv1ksdHcm71+kcySqglUwmk/CP5w6mbpXvHP0Q6nRfVPu
 8EH9/o1cvVNP6WPr3mnWkfHaRNiGO+h4gT4alFhGt2xBXivc2R2v39yOvGPJOQ==
Message-ID: <6bea1e46-e5ce-d3aa-369c-b6fd7b0b116c@denx.de>
Date: Tue, 8 Jul 2025 05:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: i.MX6UL: Adding bootcount support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, =?UTF-8?Q?Marek_Va=c5=a1u?=
 =?UTF-8?Q?t?= <marex@denx.de>
References: <CAOMZO5Ag7CmRBhpvOB5btNvHiAMayBoxSYMoBJXbV3-w1ET7jA@mail.gmail.com>
 <072c3a1f-7501-891c-b2b7-a55ea47be0f4@denx.de>
 <CAOMZO5A_7Ruaq9mE=owPctK-6uDu56kaBkqth-Vngr_CvAMHKQ@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5A_7Ruaq9mE=owPctK-6uDu56kaBkqth-Vngr_CvAMHKQ@mail.gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Fabio,

On 08.07.25 03:36, Fabio Estevam wrote:
> Hi Heiko,
> 
> Thanks for your email.
> 
> On Mon, Jul 7, 2025 at 1:30 AM Heiko Schocher <hs@denx.de> wrote:
> 
>> Have you checked if CONFIG_SYS_BOOTCOUNT_ADDR address is stable over
>> reset? May someone overwrites it...
> 
> When I inspect via md.l, it is always zero.

?

Did you tried to write it with mw ? After boot, it should be != 0

> 
>> I had it working on imx6ull
>>
>> CONFIG_BOOTCOUNT_BOOTLIMIT=3
>> CONFIG_SYS_BOOTCOUNT_ADDR=0x20d8024
>> CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
>> CONFIG_BOOTCOUNT_LIMIT=y
> 
> I tried these changes, but they did not help.

Hmm.. of course the address do not fit for imx6ul... Here I used
SRC_GPR2...

The imx6ull says here:

Holds argument of entry function for core0 for waking-up from low power mode. The SRC ensures that 
the register value will persist across system resets.

Which is, what I need for bootcount feature...

=> md 20d8024 1
020d8024: b0010002                             ....
=>
=> res
[...]
=> md 20d8024 1
020d8024: b0010003                             ....
=>

So fine incrementing value, with magic number here...

> Do you happen to remember which U-Boot version you used?

2023.10

>> I did not needed
>>
>>   > +CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C4000
>>   > +CONFIG_SYS_BOOTCOUNT_BE=y
>>
>> but may because I have an older base...
>>
>> Hmm.. your register seems fine ... I read in RM:
>> """
>> For backward compatibility with earlier
>> versions of SNVS LPGPR0 is aliased at its original offset of 68h.The GPR will be
>> automatically zeroized when a tamper event occurs, unless GPR zeroization is disabled
>> via the GPR_Z_DIS bit in the LP Control Register.
>> """
>>
>> May try 0x20b00090 ... just a try...
> 
> Also, tried, but it also stays at 0.
> 
>> May tamper event occurs? And the register is in "low power domain" ... may
>> there is a problem... so no real idea here from my side, just speculation...
> 
> It seems that I am missing something to get the LPGPR register to increment.

Yep...

Ah, looked into RM of imx6ul ... it has also a SRC_GPR2 with the same
comment as imx6ull has ... uff... why does this not work for you than?

Try with md and mw and make soft resets (not power off/on !)

And try may the other SRC_GPRx registers ... but of course you need to
check, that your kernel does not use them...

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
