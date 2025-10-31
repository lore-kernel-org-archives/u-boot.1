Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15BFCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 20:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEEF083AE9;
	Fri, 31 Oct 2025 21:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FqdKqcz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A391683AF6; Fri, 31 Oct 2025 21:47:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E423683AD1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 21:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f3a5=5J=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1761943635;
 bh=GAgzFYCehkkxIIKdpimrFeMntwrCCNindbzYV9/9kWA=;
 b=FqdKqcz9MKAwop/P/6mqwa1MGC3Fr+QqFvY6a8sSGDrW3A3AJhjeaGeiR5bLeP1Xqeyh/msd0
 m2CpLDxZ100fw8v2+rCxC4gmvH/nEXO4pa78QuBacTSXwy4QnRYNm3uPUUM1YvuMbUNb0cezrZa
 Xv5p7oFmlKCWpyxycSHRe+lHhTgq/XskCc2lUt0q4Yxi2zLzg6pIrvUBgrN4xpKNEE7FeepRaC7
 H5lJBx+VGpK3AvzXc114xXMXxSzDLFDVu++KB1CHQsmpkNy5DxSeHZZsPua0EBbVxtOa8APaBbL
 Y36Narw4yYtX22mqHHZeBItN0lemrrf7zqOSKf3JDA4w==
X-Forward-Email-ID: 690520500a03120dafdbac14
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
Date: Fri, 31 Oct 2025 21:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Sune Brian <briansune@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
 <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
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

Hi Brian,

On 10/31/2025 9:16 PM, Sune Brian wrote:
>> Is your issue specific to a reboot or cold boot?
> 
> First got to think in logical flow. As the SD card fail to pass the
> detection of valid SD card aka -5 error then it is 100% impossible
> to enter U-Boot user control phase, same as kernel nor distro.
> Hence, also cannot do 'reset' on U-Boot nor 'sudo reboot' on distro.

Your original mail mentions "sometimes fails" and that you tested U-Boot
v2026.01-rc1+, the most recent change for the nanpi4 family was related
to sd-card regulator handling to improve reboot when card was using uhs
speed in os and boot fails in spl due to this.

> 
> So the answer is cold boot.
> However, do reboot also have issue? This is not tested yet as
> we got to solve the regulator behavior trouble first.

Thanks for clarifying the condition when you observe this issue.

> 
>> Try adding something like following to rk3399-nanopi-neo4-u-boot.dtsi
>> to add a 2ms delay to ensure the voltage for the vcc3v0_sd regulator is
>> stabilized when it is enabled. Or any other timing that is required.
>>
>> &vcc3v0_sd {
>>         startup-delay-us = <2000>;
>> };
> 
> So far i got to comment this in the dts in order to boot.

Please try my suggestion above, the datasheet for the LDO mention 50us
start-time and card may need one ms to fully init. Defining this timing
requirement in the device tree that U-Boot SPL uses should match the
workaround/fix you mention in your original mail.

Regards,
Jonas

> 
> &sdmmc {
> // vmmc-supply = <&vcc3v0_sd>;
> };
> 
>> I only have a NanoPi M4B from the nanopi4 family to run tests on.
> 
> My board is nanopi neo4. If my reading is correct.
> The schematic on your board is mostly same as the neo4 on SD card.
> 
> M4B page 19 [1], NEO4 page 18 [2]
> 
> Should able to check if issue can be reproduced. The LDO itself could be
> slow as this is not digital based LDO, it is old analog control-loop
> one I guess.
> Meantime, the RK3399 may not have internal ADC or HW to sense the rail sanity.
> 
> Brian
> 
> [1] https://wiki.friendlyelec.com/wiki/images/1/16/NanoPi-M4B-1909-Schematic.pdf
> [2] https://wiki.friendlyelec.com/wiki/images/b/bb/NanoPi_NEO4_2008_SCH.pdf

