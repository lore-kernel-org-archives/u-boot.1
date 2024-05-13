Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E56AC25B78
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 14:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FD7882D8;
	Mon, 13 May 2024 16:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715610261;
	bh=GPe/uHnfJz0kZB4N3D/KArwIFrEqmtdkwFA3DkcO6gM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sH7ssSI7WuoWhLgvNFRp8gVLMEQPpKJTVQ1OmXPMWAUeaBXKFOTiGou8uLuKP9zde
	 L3P4ViefY8ayZSmyx1T5KJ4oBn2r0DnvMv/NGLciFdWBQtDAdnTt2VbvBKOCLWrx3Q
	 QOWePN/35Q9if3EDdmkMPJs1XCnZCjO9M+njm5Iu6gDYu4kwIFu0ejCnxvusBP33UI
	 b59TSJGIKb9pVIa/cnjX0zpAiE9pStWVavw4CPbA804nGaUHIf+/MxM/l+aElxA355
	 M59Cc3u0IGjhF/3zPCA00WkdvOgjUn+aK0YZKpy7AAcS8Jfkdt3iIk5IH+CaWS4ml0
	 h3NPdz+b9YDOA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AE687D57; Mon, 13 May 2024 16:24:20 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE0FD882D8
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 16:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VdMDy3GVPz9t8G;
 Mon, 13 May 2024 16:24:18 +0200 (CEST)
Message-ID: <0c19ad2e-9336-4c82-9a54-a8bb20962654@denx.de>
Date: Mon, 13 May 2024 16:24:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] wdt-uclass: prevent multiple cyclic_register calls
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
 <20240509004714.1394547-3-rasmus.villemoes@prevas.dk>
 <16a0c385-8293-42da-b56d-0122fea46d2b@denx.de>
 <5a406521-a1a8-4e51-b9f6-0cfdfd304667@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <5a406521-a1a8-4e51-b9f6-0cfdfd304667@prevas.dk>
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

Hi Rasmus,

On 5/13/24 13:09, Rasmus Villemoes wrote:
> On 13/05/2024 12.40, Stefan Roese wrote:
>> On 5/9/24 02:47, Rasmus Villemoes wrote:
>>> Currently, the cyclic_register() done in wdt_start() is not undone in
>>> wdt_stop(). Moreover, calling wdt_start multiple times (which is
>>> perfectly allowed on an already started device, e.g. to change the
>>> timeout value) will result in another struct cyclic_info being
>>> registered, referring to the same watchdog device.
>>>
>>> This can easily be seen on e.g. a wandboard:
>>>
>>> => cyclic list
>>> function: watchdog@20bc000, cpu-time: 22 us, frequency: 1.01 times/s
>>> => wdt list
>>> watchdog@20bc000 (imx_wdt)
>>> => wdt dev watchdog@20bc000
>>> => wdt start 50000
>>> WDT:   Started watchdog@20bc000 with servicing every 1000ms (50s timeout)
>>> => cyclic list
>>> function: watchdog@20bc000, cpu-time: 37 us, frequency: 1.03 times/s
>>> function: watchdog@20bc000, cpu-time: 241 us, frequency: 1.01 times/s
>>> => wdt start 12345
>>> WDT:   Started watchdog@20bc000 with servicing every 1000ms (12s timeout)
>>> => cyclic list
>>> function: watchdog@20bc000, cpu-time: 36 us, frequency: 1.03 times/s
>>> function: watchdog@20bc000, cpu-time: 100 us, frequency: 1.04 times/s
>>> function: watchdog@20bc000, cpu-time: 299 us, frequency: 1.00 times/s
>>>
>>> So properly unregister the watchdog device from the cyclic framework
>>> in wdt_stop(). In wdt_start(), we cannot just skip the registration,
>>> as the (new) timeout value may mean that we have to ask the cyclic
>>> framework to call us more often. So if we're already running,
>>> first unregister the old cyclic instance.
>>
>> Thanks again for all your valuable work here. I do have a question
>> regarding this patch though. AFAIU, it's a valid use-case to enable
>> 2 different watchdog devices. And this patch will prevent such a
>> setup. Or do I misunderstand this?
> 
> No, that shouldn't prevent enabling or petting two different watchdogs
> at all, that should work just as well as today. All the state I'm
> looking at and modifying belongs to one specific device, it's not
> wdt-uclass-global state, it's wdt-uclass-per-device state.

That's what I was hoping, but was too lazy to figure out myself.

> But with the existing code, if one calls wdt_start() a second time on an
> already started device, the existing priv->cyclic pointer is dropped on
> the floor (it gets unconditionally overwritten by the new
> cyclic_register() return value), so one gets the situation that the same
> device has multiple cyclic callbacks registered. Also, we're not
> unregistering the device from the cyclic framework upon ->stop().

Understood.

> Today, that's "mostly harmless". It does mean 'cyclic list' becomes
> cluttered, and is a memory leak, so you could exhaust memory by doing
> wdt_start in a loop, and cyclic_run() ends up doing extra callbacks to
> the same device (all but one will be no-ops due to the per-device
> rate-limiting of ->reset callbacks). In practice there's no chance of
> memory corruption or other failures. However, that changes with 3/3,
> where it would be catastrophic to call cyclic_register() with an already
> registered cyclic_info instance, as the hlist would become corrupt. I
> think it's worth fixing regardless of whether 3/3 is accepted.

Agreed.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
