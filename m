Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC18C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 17:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF9D88816A;
	Thu,  9 May 2024 19:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="monFTKrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2797C881FA; Thu,  9 May 2024 19:05:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B2387617
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 19:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d3cf=MN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715274289;
 bh=mhPfJ4whfjwGWSg3fz5twXqaRblV06wvOa6FxzzWI84=;
 b=monFTKrIA1XySyOOndMXE5c+KXimbz81xk2w/8nMlYqkh6JnLNArcvbE/5/Sq5OB+NDbfKJZ5
 vwVRJvu2q0blCFd1u5BtMYySofb+3Dsxdkq5d4LgzuzPVUAboruA0iI/QZ0zwg/7Ni6lUPw2n/F
 zLiWubuTh8r61F4fLtDDPjO85hODK4PaBA4smnROFL4O7NXbyeUogFCxBRc2Jee1aLbzGXb1DDl
 NtKcGgVxkSqkFxMepA+VpTiI/KUB+rwQkiRvRgCzsXZmkyOHiGHt4Mp9BIsiFImuDuC/IHQcqx2
 elXrCU0MDgtE6gjw2iZ26IInXxJi8wTIubFDrj2DFR8w==
Message-ID: <f0aa181a-d154-4647-90e1-b241fdfe893e@kwiboo.se>
Date: Thu, 9 May 2024 19:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: rv1126: Migrate to OF_UPSTREAM
To: Anand Moon <linux.amoon@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, Tim Lunn
 <tim@feathertop.org>, u-boot@lists.denx.de
References: <20240509152631.5892-1-linux.amoon@gmail.com>
 <66c67ad0-0d85-43a8-b5e2-b50e155ee3c9@kwiboo.se>
 <CANAwSgQ_iqEFZV2ZKHNpOBTG+4+Rhza8v5b-GZEFyJdA0_U2Hw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CANAwSgQ_iqEFZV2ZKHNpOBTG+4+Rhza8v5b-GZEFyJdA0_U2Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663d022ba027b205d0df851e
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

Hi Anand,

On 2024-05-09 18:42, Anand Moon wrote:
> Hi Jonas
> 
> On Thu, 9 May 2024 at 21:38, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi,
>>
>> On 2024-05-09 17:26, Anand Moon wrote:
>>> Migrate RV1126 boards that exists in Linux v6.8 to use OF_UPSTREAM.
>>>
>>> Following targets is not migrated to use OF_UPSTREAM:
>>
> 
> Ok, will update the commit message in the future.
> 
>> At first I got a little bit confused about the "not migrated", but see
>> now that these are the boards that is migrated.
>>
>>> - rv1126-edgeble-neu2 : Board is an industrial form factor
>>>                         IO board.
>>> - sonoff-ihost-rv1126 : Gateway device designed to provide a
>>>                         Smart Home Hub.
>>>
>>> Cc: Tim Lunn <tim@feathertop.org>
>>> Cc: Jagan Teki <jagan@edgeble.ai>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> Tested on neu2 edgable board.
>>> ---
>>>  arch/arm/dts/Makefile                   |   3 -
>>>  arch/arm/dts/rv1126-edgeble-neu2-io.dts | 112 -----
>>>  arch/arm/dts/rv1126-edgeble-neu2.dtsi   | 345 -------------
>>>  arch/arm/dts/rv1126-pinctrl.dtsi        | 341 -------------
>>>  arch/arm/dts/rv1126-sonoff-ihost.dts    |  29 --
>>>  arch/arm/dts/rv1126-sonoff-ihost.dtsi   | 404 ---------------
>>>  arch/arm/dts/rv1126.dtsi                | 623 ------------------------
>>>  arch/arm/mach-rockchip/Kconfig          |   1 +
>>>  configs/neu2-io-rv1126_defconfig        |   2 +-
>>>  configs/sonoff-ihost-rv1126_defconfig   |   2 +-
>>>  10 files changed, 3 insertions(+), 1859 deletions(-)
>>>  delete mode 100644 arch/arm/dts/rv1126-edgeble-neu2-io.dts
>>>  delete mode 100644 arch/arm/dts/rv1126-edgeble-neu2.dtsi
>>>  delete mode 100644 arch/arm/dts/rv1126-pinctrl.dtsi
>>>  delete mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dts
>>>  delete mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dtsi
>>>  delete mode 100644 arch/arm/dts/rv1126.dtsi
>>
>> Following should also be removed:
>> - include/dt-bindings/clock/rockchip,rv1126-cru.h
>> - include/dt-bindings/power/rockchip,rv1126-power.h
>>
>> Side note, following is remaining after the rv1108 migration and should
>> probably also be removed:
>> - include/dt-bindings/clock/rv1108-cru.h
>>
> 
> I will check if any drivers are using this if not I will remove them.
> will address this in V2.

After migration to OF_UPSTREAM any related dt-bindings include must be
removed from include/dt-bindings/ or the upstream include files cannot
be included from dts/upstream/include/dt-bindings/.

Fabio just sent a fix for rv1108-cru.h, thanks!

Please remove the two rv1126 include/dt-bindings/ files in v2.

Regards,
Jonas

> 
>> Regards,
>> Jonas
> 
> Thanks
> -Anand

