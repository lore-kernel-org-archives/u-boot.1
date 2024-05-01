Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49F4C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 11:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB4288AA4;
	Wed,  1 May 2024 13:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TAM/gPnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCDC88AAF; Wed,  1 May 2024 13:48:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA5C88A86
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 13:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714564069;
 bh=8xpelXg0hHuzyXeL7iNtvPbtamvLG1LHPyDyzJ822m0=;
 b=TAM/gPnhkGqI4gjQ7qN5bB5+6vz4vnHkC59HaRjhPDkfFSbX20QuodHhlELUiJ/STjgDYsI1P
 DE1+Y7L6CduAkZ1bbwEaB1adXxiE18e6BmCg7RTybIoQyq1JnSTbMmRLlaGqpClZlnWKMEF+LT7
 cFORCru3aLOBlNn+bi33vki4PqzVNQ7InXgC0SoHLad+03LzdHRsPAnk6dNjR3BawbHkfG3zxg1
 VVhiFMmzHqfQleWdDGnEJqG2ZAx9+qkiw8QSgfDk3TT8qYryZZq3hEKw0njS/0fLXRrPqEBkdSB
 OZ2tl0+Muwtb8yIgjIaZNDyMxVy2elOxOjdSjFgnuZlQ==
Message-ID: <59ff5e06-e6c9-4605-8991-3eb45b0342a2@kwiboo.se>
Date: Wed, 1 May 2024 13:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/31] rockchip: rk3399: Add a default spl-boot-order prop
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Nick Xie <nick@khadas.com>, Peter
 Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, Suniel
 Mahesh <sunil@amarulasolutions.com>, Jagan Teki
 <jagan@amarulasolutions.com>, u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-10-jonas@kwiboo.se>
 <eab26662-eef6-47b2-9de8-9f13d280da16@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <eab26662-eef6-47b2-9de8-9f13d280da16@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66322be38353c369f638bc16
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

Hi Quentin,

On 2024-04-02 16:02, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/31/24 22:28, Jonas Karlman wrote:
>> A lot of RK3399 boards use a u-boot,spl-boot-order of "same-as-spl",
>> &sdhci and &sdmmc.
>>
>> Move this to rk3399-u-boot.dtsi and make this default for boards
>> currently missing a u-boot,spl-boot-order prop.
>>
>> The &spi_flash reference has been dropped from spl-boot-order now that
>> boot source id is cached and "same-as-spl" can be resolved into the SPI
>> flash node.
>>
> 
> This is not really the same thing.
> 
> This prevents from having U-Boot proper in SPI and TPL+SPL on eMMC/SD 
> card. Is this a real usecase? I don't know, we do support it on Puma 
> (though I know you haven't changed it in this commit). I guess we could 
> still have the devices with SPI flashes have their own 
> u-boot,spl-boot-order if they want.

Agree, I tweaked the commit message a little bit in v2.

I think before the SPI flash node had to be included in spl-boot-order
to be able to load FIT from SPI flash, so the inclusion has probably
mostly been an effect of that.

> 
> So, in short, I would at the very least document this new limitation in 
> the commit log but have nothing against the change (my board not being 
> impacted by it :) ).

Agree, I have been very restrictive and try not to change any behavior
on gru based and puma targets :-

Regards,
Jonas

> 
> Cheers,
> Quentin

