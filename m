Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0E3C531DF
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 21:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC798811A;
	Sun, 18 Aug 2024 23:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pVhFBROE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7ED889BE; Sun, 18 Aug 2024 23:43:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F43E880E6
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 23:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=618c=PS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724017424;
 bh=LibbBOHf5z+YcrneyVc3JtzF//kGYjy91yzQ27pmIOA=;
 b=pVhFBROEw7yQuATHdiPEf4NRQ+cJTWkjwUhT/STt5hKlC19HzdGsMroyuVTV5FRWZpqPPgak8
 gMOBZpDmbdm5bsMjkfktejyi/PZBlPM58+hem+JeUHhEw6OaJJxZDfZQogHiPXuTVz7rLR6u7zF
 NOzMhcUeTTbwrcYn2lTpIlR6Ft5wxk9x0AKr+PTvW7Qvn44XXl9lupp1/sIGipLLSpYyknPTZM3
 BgPmNLXc4wYyln7QhFlR+bahldB34um/sDc3wOtVH55HWzJy1NEkpn6dIsON/IPA0wFYF6XiCZ1
 D58tNWwT+Y2PtTjqlnb+Fftqdy84aZthANPejPunR3iQ==
Message-ID: <6f42837e-6378-4ded-8120-d642a13e69df@kwiboo.se>
Date: Sun, 18 Aug 2024 23:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
To: Marek Vasut <marex@denx.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Eugen Hristev
 <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <d3c80c56-ebb0-4b6f-ac92-15cd646feb27@denx.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d3c80c56-ebb0-4b6f-ac92-15cd646feb27@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66c26b0cdf911e40355fa0ee
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

Hi Marek and Sebastian,

On 2024-08-18 22:35, Marek Vasut wrote:
> On 8/2/24 7:59 PM, Sebastian Reichel wrote:
>> Hi,
> 
> Hello everyone,
> 
>> On ROCK 5B power is usually supplied via it's USB-C port. This port has the
>> data lines connected to RK3588, VBUS connected to the input regulator and
>> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
>> accessed via I2C from RK3588. The USB-C controller is needed to figure out
>> the USB-C cable orientation, but also to do USB PD communication. Thus it
>> would be great to enable support for it in the operating system.
>>
>> But the USB-PD specification requires, that a device reacts to USB-PD messages
>> send by the power-supply within around 5 seconds. If that does not happen the
>> power-supply assumes, that the device does not support USB-PD. If a device
>> later starts sending USB-PD messages it is considered an error, which is solved
>> by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
>> removed for a short period of time. For boards, which are solely powered
>> through their USB-C port, like the Radxa Rock 5B, this results in an machine
>> reset. This is currently worked around by not describing the FUSB302 in the
>> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>>
>> 1. the USB-C port cannot be used at all
>> 2. the board will be running via fallback supply, which provides limited
>>     power capabilities
>>
>> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
>> that we react to the power-supply's queries in time. The code, which is
>> originally from the Linux kernel, consists of two parts:
>>
>> 1. the tcpm state machine, which implements the Type C port manager state
>>     machine as described in the USB PD specification
>> 2. the fusb302 driver, which knows about specific registers
>>
>> Especially the first part has been heavily modified compared to the
>> kernel, which makes use of multiple delayed works and threads. For this
>> I used a priorly ported version from Rockchip, removed their hacks and
>> any states not necessary in U-Boot (e.g. audio accessory support).
>>
>> Sorry for the delay in getting PATCHv3 ready.
> 
> I am the one who should be sorry here, really, sorry for the abysmal 
> delay in my replies.
> 
> So ... this series looks good to me. Thank you for working on this !
> 
> Jonas, are your concerns resolved ?

No, for ROCK 5B the full overwrite of the Rockchip common misc_init_r()
in mach-rockchip/board.c should be fixed, rockchip_early_misc_init_r()
could probably be used instead (or possible a PREBOOT cmd), see [1].

Also the check for MISC_INIT_R symbol does not make sense and should be
dropped, see [2].

[1] https://lore.kernel.org/u-boot/34c55a9f-0e49-4439-9360-a706cf60ea2b@kwiboo.se/
[2] https://lore.kernel.org/u-boot/56322afa-1595-4228-8259-728a92531025@kwiboo.se/

Regards,
Jonas
