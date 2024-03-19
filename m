Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1A2C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 16:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2F787F3D;
	Tue, 19 Mar 2024 17:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="gF3n9p4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9633C87FC5; Tue, 19 Mar 2024 17:08:57 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9008287D82
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 17:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1710864535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PrXsC+oxQf0P5VA0IKBqoNE4e+m+CfjbEGUcuRc2i0=;
 b=gF3n9p4PvNtqqgJ4qBXlTGTUUrAFAxT0JILTJhwqo1yhe217NkJnEauMdL/ZWbxyKNZw2z
 AvQ1zrzijNi0R1KDhg6ePtQSlPoMBNsRb+u3zcnWnuYfYevdUTxAiVqWOMwBnPtmNwlTt/
 uW348HafNao/vY3EUnOKJ2OJHQiYowTNG6MAu0o/mWZNLJ9ZnC9SL+gaWGl51GWgH4thQQ
 l1SoiYVavKNKbmbKsrRpZ6w14vd4/0OHqJSAFZn8t9QYJuq5THLmTE+IXb4G9/MCsUyguk
 /msgklMEb4bHwXDKnZaHRuvi2MEmDg7MYmExPD/rdmWSr2WAyu52tPcBfGrbMQ==
Date: Tue, 19 Mar 2024 17:08:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] rockchip: spl: Cache boot source id for later use
In-Reply-To: <16c848fe-5230-43fd-9917-83b196d152ec@kwiboo.se>
References: <20240315173454.2672509-1-jonas@kwiboo.se>
 <82cb3644a72bfb293364ddd7bcedc00d@manjaro.org>
 <16c848fe-5230-43fd-9917-83b196d152ec@kwiboo.se>
Message-ID: <102f0a77ecb5c417ebe55b86bc7696ab@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-03-19 16:59, Jonas Karlman wrote:
> On 2024-03-19 10:44, Dragan Simic wrote:
>> On 2024-03-15 18:34, Jonas Karlman wrote:
>>> diff --git a/arch/arm/mach-rockchip/spl.c
>>> b/arch/arm/mach-rockchip/spl.c
>>> index 1586a093fc37..27e996b504e7 100644
>>> --- a/arch/arm/mach-rockchip/spl.c
>>> +++ b/arch/arm/mach-rockchip/spl.c
>>> @@ -32,9 +32,17 @@ __weak const char * const
>>> boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>> 
>>>  const char *board_spl_was_booted_from(void)
>>>  {
>>> -	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>>> +	static u32 bootdevice_brom_id;
>>>  	const char *bootdevice_ofpath = NULL;
>>> 
>>> +	if (!bootdevice_brom_id)
>>> +		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>>> +	if (!bootdevice_brom_id) {
>>> +		debug("%s: unknown brom_bootdevice_id %x\n",
>>> +		      __func__, bootdevice_brom_id);
>>> +		return NULL;
>>> +	}
>>> +
>> 
>> Maybe it would be better to execute readl(BROM_BOOTSOURCE_ID_ADDR)
>> only once, i.e. to have something like this instead:
>> 
>>      +	static u32 bootdevice_brom_id = -1;
>> 
>>      +	if (bootdevice_brom_id == -1) {
>>      +		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>>      +		if (!bootdevice_brom_id)
>>      +			debug("%s: unknown brom_bootdevice_id %x\n",
>>      +			      __func__, bootdevice_brom_id);
>>      +	}
>>      +
>>      +	if (!bootdevice_brom_id)	/* fail on subsequent tries */
>>      +		return NULL;
>>      +
>> 
>> The logic behind such an approach would be to try only once and fail
>> on subsequent (re)tries.  That way, it would also serve as some kind 
>> of
>> a runtime canary test, because the first try should succeed, which may
>> prove useful in the field.
> 
> If we initialize the static variable to a value it will be stored in 
> the
> .data section and takes up binary size. With a static variable like in
> this patch this is instead stored in .bss section and gets initialized
> to 0 by runtime. 0 is also not a valid boot source id value and the
> reset value for the reg.

Is it mandatory that this static variable ends up in the .bss section?

> I do not see any point in making the code more complex than it has to 
> be.
> The reg will contain a known boot source id, 1 - 10, set by BROM or
> something has gone wrong and the value is not usable any way.

As I already described, making the code more complex would intentionally
introduce a failure point, which would be triggered in case obtaining
valid value from readl() fails the first time.  Something like that is
usually known as a canary, which I'm sure you already know about.
