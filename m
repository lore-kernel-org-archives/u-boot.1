Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EAECD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAF58407D;
	Thu, 11 Jun 2026 16:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LM+bbkCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BDC9841C2; Thu, 11 Jun 2026 16:39:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E4583FF5
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ecc3=EI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781188792;
 bh=Ta4digMSrkViQrIsXgz1QrsoSlMjzNTE5tmF9jbkXiA=;
 b=LM+bbkCKqk2YcnrB+0y5lo5glFSoPKtmC/AYWHTVxrcYcv2QknFT1FtjzE+7zZGTe0yy7YoYh
 c9GlLsXi9uZa2IFOFj0MrCOu0oXWzedMPmSZ9Pwd725L2AlaQhPpv0dHH9sp1iduGXIqiyrxFKt
 tskvzxSbDDbzoKNAaV8fX0+TPGfJX1Js4rd/i7wSmw09yXh1OEOtNpNvwCvEAjSDRaS3DxwhAKw
 7rTBjDcLCJq13AgatehWBqFIAPelOVpTeQg26jRDguex1m7f4iBu7emCm8jbFHIaqoVeHAoPrkE
 3vZmeoSVsLSqT/LXmS0YZTix1XMw4LIX1jXnqyGv8uug==
X-Forward-Email-ID: 6a2ac8b6e8b8337cffbdf688
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fcecc9b3-da96-4de0-965e-cc5890d69a97@kwiboo.se>
Date: Thu, 11 Jun 2026 16:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: enhance clk-gpio to also handle gated-fixed-clock
To: Torsten Duwe <duwe@lst.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Daniele Briguglio <hello@superkali.me>,
 Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
References: <20260528132206.2fe9f474@lst.de>
 <178118570728.472730.15075222884813417231.b4-ty@konsulko.com>
 <f706f118-b698-4ab4-8b19-9f3de0d10c31@kwiboo.se>
 <20260611140105.GI382693@bill-the-cat> <20260611161755.447cabc8@lst.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260611161755.447cabc8@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Torsten,

On 6/11/2026 4:17 PM, Torsten Duwe wrote:
> On Thu, 11 Jun 2026 08:01:05 -0600
> Tom Rini <trini@konsulko.com> wrote:
> 
>> On Thu, Jun 11, 2026 at 03:58:04PM +0200, Jonas Karlman wrote:
>>> Hi Tom,
>>>
>>> On 6/11/2026 3:48 PM, Tom Rini wrote:
>>>> On Thu, 28 May 2026 13:22:06 +0200, Torsten Duwe wrote:
>>>>
>>>>> Devicetree commit a198185b9b5 introduced a new type of clock,
>>>>> "gated-fixed-clock", for which Das U-Boot does not have
>>>>> a driver yet. The required code is similar to gpio-gate-clock,
>>>>> and can be added using little extra text space.
>>>>>
>>>>> Use this code e.g. to boot a Rock5 ITX from NVMe
>>>>>
>>>>> [...]
>>>>
>>>> Applied to u-boot/next, thanks!
>>>
>>> Any reason this was applied without my review concerns being
>>> addressed?
>>>
>>> Please revert, or address the issues this patch have :-)
>>
>> Yes, I missed them, sorry about that. I'll go push a revert along
>> shortly.
>>
> 
> IIRC it was not a big thing, I can also follow up with the change
> suggested by Jonas, if that's easier for you.

There where three issues with this patch:
- wrong regulator_set_enable function used
- regulator is enabled during probe, not when clock is enabled
- regulator is never disabled, resulting in broken/unbalanced reference
  enable count of the regulator

Also keep in mind that there are some issues with the pcie_dw_rockchip
driver to fully and correctly fix gated-fixed-clock use on ROCK 5 ITX.

https://lore.kernel.org/u-boot/20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me/

Regards,
Jonas

> 
> 	Torsten

