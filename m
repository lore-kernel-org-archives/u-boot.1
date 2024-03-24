Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A13C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 21:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D404287D42;
	Sun, 24 Mar 2024 22:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="MMmaFgWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F49287DEC; Sun, 24 Mar 2024 22:28:31 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E951B87572
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 22:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1711315708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7LYG0xkUkRUiWKU6yEu9H2AiorNUvzPObYdvdjzkWw=;
 b=MMmaFgWbM+IdNwMMMFEgDd1UQUX+y52daf1lhPutYy5MbQbf8HsRs98fuUpSLXSsBjItyA
 n3ocFPm4TqWbIXVf65N4A8yepRA0WkUvHPWYxjQlqzCGpU+F9cyUh2RojWrUrIMNuOHeoU
 ChXMUR7yJwiNRTXAAPLI6SjnCe69tW70nAuPGxR8a9Te6AWc8EVm+boJgK3AwaybAVR0dQ
 fxahuHcsyCik+yLGwAz/WmG8nKkEvR4lp5OdN/NMa9LYk4cWEtlNhFGVmXrpjvjdKA7ouX
 DT0A8h6L0Aep+Olsd5+JoqFeAWUzbp34UH7GkwIQRi/QJSI8HnRD4s9r1eqn2Q==
Date: Sun, 24 Mar 2024 22:28:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Christopher Obbard <chris.obbard@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] rockchip: spl: Add SPI NOR flash to boot_devices
 array
In-Reply-To: <dc60db5b-a030-41e4-8cfe-f909dd89badf@kwiboo.se>
References: <20240322205027.3860170-1-jonas@kwiboo.se>
 <20240322205027.3860170-4-jonas@kwiboo.se>
 <69ac8183dcf1cc54f51d21b823c1abfa@manjaro.org>
 <955522b3-344d-4f11-8ea3-d24cbc9f7f7a@kwiboo.se>
 <9ae8cf4a7aefef78dd1f546fb3290825@manjaro.org>
 <dc60db5b-a030-41e4-8cfe-f909dd89badf@kwiboo.se>
Message-ID: <3e8d12008f4f12ad13302efb91e09aca@manjaro.org>
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

On 2024-03-24 22:23, Jonas Karlman wrote:
> On 2024-03-24 21:58, Dragan Simic wrote:
>> On 2024-03-24 18:28, Jonas Karlman wrote:
>>> On 2024-03-24 17:52, Dragan Simic wrote:
>>>> On 2024-03-22 21:50, Jonas Karlman wrote:
>>>>> diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>>> b/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>>> index 27a748327e31..b3ffabc5449a 100644
>>>>> --- a/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>>> +++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>>> @@ -141,6 +141,7 @@ enum {
>>>>> 
>>>>>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>>>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff490000",
>>>>> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff4c0000/flash@0",
>>>> 
>>>> AFAICT, no RK3308-based board contains an SPI chip, and I'm not 
>>>> really
>>>> sure where does /spi@ff4c0000/flash@0 come from.
>>> 
>>> RK3308 TRM mention that it can boot from the SFC. And yes there is no
>>> upstream board that currently have a jedec,spi-nor node, it however
>>> have the sfc (spi@ff4c0000) node so this adds correct node path.
>> 
>> Hmm, I see no sfc node in any of the arch/arm/dts/rk3308* files?
>> Maybe I'm missing something, but there's also no "ff4c0000" string
>> in the entire arch/arm/dts directory.
> 
> The rk3308 DTs in U-Boot is very outdated so the sfc node cannot be
> found in current master branch.
> 
> The sfc node is part of linux upstream DT, should also match in
> dts/upstream in next branch and after the rk3308 DT sync series [1].
> 
> rockchip: rk3308: Sync DT with linux v6.8 and update defconfigs:
> [1] https://patchwork.ozlabs.org/cover/1912830/

All good, thanks for explaining it further.  Please add

Reviewed-by: Dragan Simic <dsimic@manjaro.org>
