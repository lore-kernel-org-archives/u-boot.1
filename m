Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED22C25B5F
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 18:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B74887E74;
	Sat, 11 May 2024 20:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LmKfUkeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6902087ECC; Sat, 11 May 2024 20:48:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB10887E1D
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 20:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b203=MP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715453292;
 bh=acWbtUYj5o5y2X2rR46+eYMfB1dpjmP92eacT4R9aKw=;
 b=LmKfUkePzqpcLXV9GD5d4stNfPThJ1ZQHw049yFkntBwlahjiRnRxJxPGVamkAs/mOHq1rnHp
 D3c432686EzWJpsyK9CTUFrUpmEfHUuVv0d38x9qugOrJNvWHmOaPjzCrGPNo3MbEyl19udzQfL
 TxrHxsrSEUuzldcE7ojP3PgrnD8oqdV/dH6DUxxbMkfHVIJW1M6F8zelHUNoSoBtyOZ40fkcyAc
 +aELjDVXfhrUENTEVp47IqtfJk5eL/tj8l137RgVjSAZrM6kVe0rW7CUUJuzrcdyqX/ZroVF5lR
 bsqsugiwsTf/39p+1qRj9qRSWVBH1Mtii5IkXpSPUFlQ==
Message-ID: <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
Date: Sat, 11 May 2024 20:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
To: Alex Bee <knaerzche@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663fbd51d6c959cb9883f533
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

Hi Alex,

On 2024-05-11 19:44, Alex Bee wrote:
> Hi Jonas,
> 
> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
>> This series add gpio request() and pinctrl gpio_request_enable() ops so
>> that a gpio requested pin automatically use gpio pinmux and U-Boot
>> behaves more similar to Linux kernel.
> 
> I'm not sure that's a good idea.
> While linux does it the same way, we really shouldn't expect every 
> software/os/ … which uses DT (now or in future) to implicitly switch the 
> pin function when using a pin as gpio. So the real fix would probably be 
> to add the the correct pinctrl settings to the upstream DT of those 
> boards and sync it later on (not sure those if those SoCs already using 
> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.

I fully agree that the pinctrl for the problematic boards should be
corrected in upstream DT, but that is a separate issue and should not
block adding support for the request()/gpio_request_enable() ops.

While the pcie reset-gpios full board freeze that was my driving factor
to fully implement the gpio request() ops it is not the only use case,
using the gpio cmd on a pin that use a non-gpio pinmux is another.

Or do you see any technical issue with having the gpio request() ops
implemented and having it ensure gpio pinmux is used on a gpio requested
pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
platforms in U-Boot?

Regards,
Jonas

> 
> Alex
>>
>> With the gpio and pinctrl ops implemented this series also remove a PCIe
>> reset-gpios related device lock-up workaround from board u-boot.dtsi.
>>
>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
>> define gpio-ranges props and is affected by this series.
>>
>> A follow up series adding support for the pinmux status cmd will also
>> add gpio-ranges props for remaining RK SoCs.
>>
>> Jonas Karlman (4):
>>    pinctrl: rockchip: Add gpio_request_enable() ops
>>    gpio: rockchip: Add request() ops
>>    rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
>>    rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
>>
>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
>>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
>>   drivers/gpio/rk_gpio.c                        | 10 ++++++
>>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
>>   4 files changed, 41 insertions(+), 24 deletions(-)
>>
> 

