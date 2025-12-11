Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B8D3E792
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 12:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB7B8309A;
	Thu, 11 Dec 2025 13:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="akmtTyTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4968309A; Thu, 11 Dec 2025 13:11:17 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144A28389A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 13:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db6d=6S=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1765455067;
 bh=sbNgUlIL3YUv3zJ1jprYn/Naac+APOFaRuKefVRfHr0=;
 b=akmtTyTqQ5Tq1hQHh2ITX0oYwloxDg6Xw8a/MZ5ggKMai2Ttpm4K7LWA8OyWAWZu6IhQDQFDb
 qC+qOVwFLZ5zru5eVCGVn9MyebragJY/DERRK2Vz4mgPZ4EAOVYAeymtorNW2F9+If1rpcQNoE0
 XAjAtV9pkXgdRb8FYGbZjllb+IFoq7kaTLfnacHeWilJdbDoovKGIO+4D7eplTbXf2XV4xhVKGz
 ayqn9lGsnzJHpjE34dSpxhtcXYIvr4oFkYUFC0vd46H/NRDQ1b59CZtOhcdtmnjY3glwcjFjUae
 EIXgiGpTe+54QRny7aLt3KNLZWkRTgV0pYfyYQL94jvw==
X-Forward-Email-ID: 693ab4d6138b35e7e7178456
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.6.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d74fb99d-f9aa-4417-915c-6b8a00a443b2@kwiboo.se>
Date: Thu, 11 Dec 2025 13:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk356x: Stop overriding sdhci/mmc aliases
To: Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251209211807.497095-1-pbrobinson@gmail.com>
 <7fa7ee4e-94ab-4338-bb01-481a68768922@cherry.de>
Content-Language: en-US
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7fa7ee4e-94ab-4338-bb01-481a68768922@cherry.de>
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

Hi,

On 12/11/2025 11:56 AM, Quentin Schulz wrote:
> Hi Peter,
> 
> On 12/9/25 10:18 PM, Peter Robinson wrote:
>> Upstream device tree has rules where the aliases are board
>> specific settings, no SoC settings. Looking at upstream
>> rk356x boards there's a lot of variation in the setting of
>> mmc0/mmc1 based on the device so we should not be overriding
>> this here and now we sync to upstream we should just consume
>> those settings, to do otherwise confuses users.
>>
> 
> Do all boards with DM_SEQ_ALIAS config set have these aliases set? 
> Otherwise the MMC device index may change between reboots.
> 
> While this change is appropriate, we should care to not break users just 
> for the sake of being correct. The easiest check could be to build all 
> rk356* DTB before and after your patch and see if it changes something 
> and for those boards whose DTB changed, whether they use DM_SEQ_ALIAS in 
> some U-Boot phase or not.

To my knowledge all rk33/rk35 boards should be using DM_SEQ_ALIAS in SPL
and proper in defconfig, at least that is something I have been tested
or patched in the past for most Rockchip rk33/rk35 SoCs.

The mmc0/mmc1 aliases have been added to the u-boot.dtsi to ensure that
mmc1 and mmc0 used in e.g. boot_targets env is predictable, similar to
all older RK SoCs where mmc0=eMMC and mmc1=SD-card (in U-Boot).

Removing these aliases will most likely change boot targets order in
U-Boot proper, please do not remove these aliases and without first
having a fix/replacement for the boot targets change in place.

Regards,
Jonas

> 
> Cheers,
> Quentin

