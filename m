Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10335CD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 10:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D9887916;
	Mon,  1 Apr 2024 12:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yW6drCOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402B287C68; Mon,  1 Apr 2024 12:25:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B751083334
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 12:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711967094;
 bh=P3oKZfUZDbuKZxQnZ3zWPUyYaIGRdCsVjjW/2iYPPao=;
 b=yW6drCOdtrrHLp/F8XmFn38WPMelJFO6KsNqdpiL1/Y1ipE/v70l8yJVnIin0KYkq9vR/G1Vt
 wjDcCmW3kxU7+V33VF6FndZXgEv5p+Pecv6WeHxWmb6OqzhwJ8tXnx+taY7OfqrjWxgqhWOX9a4
 SCadDVNKqH+7u6VUgvI5NQueQw94wba8pw3qYkMe4bPU+8A+uKwZ5Am8HkSeXWoWdhFIRI/JJEV
 GwEz6pWG+KdUoxg7/F4GPRj3N3aYv7SorBHCb2GaxDvI/jkLUSsV+kE0cuk3pi6roEAJp2ifbhJ
 puEAmMzuC8udAzfzfjilz36O6Q6OccIynyb0AaJbtz5Q==
Message-ID: <91326c6e-444f-42f7-bfe6-59cb2fb059d4@kwiboo.se>
Date: Mon, 1 Apr 2024 12:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] rockchip: rk3399: Sync DT with linux v6.8 and
 update defconfigs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <CAFA6WYPMqRQRpcN--3Mz7czh6MK10W75e19h9VWWp5P6KKbBJA@mail.gmail.com>
 <63f29606-ad3f-4883-9e8b-4d80194c12ab@kwiboo.se>
 <CAFA6WYMGLuftoVcL8WD9DR_QZf=rwe_wLWV6XARG0MTncXJCqA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFA6WYMGLuftoVcL8WD9DR_QZf=rwe_wLWV6XARG0MTncXJCqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660a8b76ad8aee03271337b2
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

On 2024-04-01 12:08, Sumit Garg wrote:
> On Mon, 1 Apr 2024 at 15:15, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Sumit,
>>
>> On 2024-04-01 10:52, Sumit Garg wrote:
>>> Hi Jonas,
>>>
>>> On Mon, 1 Apr 2024 at 01:59, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> This series adds support for new clocks used in linux v6.8 device trees,
>>>> enables use of FIT signature check for checksum validation and fixes
>>>> loading FIT from SD-card when loading FIT from eMMC fails.
>>>>
>>>> After this series it should be possible to move RK3399 boards to use
>>>> OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.
>>>>
>>>
>>> Thanks for putting this effort together. A switch to v6.8 tag for
>>> OF_UPSTREAM will happen as part of patch [1]. So if you want to save
>>> further effort then you can just rebase with a switch to OF_UPSTREAM
>>> once that patch [1] lands in next.
>>
>> Because this is a jump of device tree files from v5.14-rc1 to v6.8,
>> reviewability and being able to cherry-pick these changes to my
>> rk3xxx-2024.04 branch, I think it is much more appropriate to first sync
>> everything to v6.8 and then in a separate series move to OF_UPSTREAM.
>> Else it can be very hard to understand some of the changes that has been
>> and was needed to be made to u-boot.dtsi files.
> 
> That's fair given it's a long pending DT sync.
> 
>>
>> Reviewability is one of the shortcomings with a switch to OF_UPSTREAM.
> 
> I suppose the reasoning behind this thinking can be that people are
> used to reviewing DTs alongside driver changes. However, these patches
> aren't actual DT changes but rather DT imports which IMHO is a
> distraction for the reviewer. The actual DT can be looked into
> dts/upstream/ directory while reviewing the changes.

Things like following was easier to spot when reviewing DT syncs:
- A property that U-Boot depends on gets removed, as in [1].
- Some DT changes can break changes that has been made to u-boot.dtsi
  files, e.g. a symbol to a node is no longer available in upstream but
  referenced in u-boot.dtsi files (happened in this series).
- Changes in DT may require a workaround in a u-boot.dtsi file.
- u-boot.dtsi contains workarounds that has not yet been upstream but
  can be removed in a future DT sync.
- Driver incompatibilities due to initial driver imported from vendor
  ended up not fully compatible with upstream linux driver / dt-binding.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4d08b19629495b29601991d09d07865694c25199

Regards,
Jonas

> 
> -Sumit
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> [1] https://lists.denx.de/pipermail/u-boot/2024-March/549611.html
>>>
>>> -Sumit
>>>
>>>> I have runtime tested this series on following devices:
>>>> - 96boards Rock960
>>>> - Khadas Edge Captain
>>>> - Pine64 PineBook Pro
>>>> - Pine64 RockPro64
>>>> - Radxa ROCK 4C+
>>>> - Radxa ROCK 4SE
>>>> - Radxa ROCK Pi 4A
>>>> - Radxa ROCK Pi 4B+
>>>>
>>>> This series depends on the following series:
>>>> - Enable booting from SPI flash on ROCK Pi 4 [1]
>>>> - rockchip: spl: Cache boot source id for later use [2]
>>>>
>>>> A copy of this series and all its depends can be found at [3]
>>>>
>>>> [1] https://patchwork.ozlabs.org/cover/1912469/
>>>> [2] https://patchwork.ozlabs.org/cover/1915071/
>>>> [3] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-dt-sync-v1
>>>>

