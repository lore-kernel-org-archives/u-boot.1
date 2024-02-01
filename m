Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9F9C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 10:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9385287C49;
	Thu,  1 Feb 2024 11:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HI3svnTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D7187C7A; Thu,  1 Feb 2024 11:51:28 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C8F86DEE
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 11:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8890=JK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1706784665;
 bh=nCAm3AoQJ4rfdDGDOdBgyIBvQIbOAi60s+DChP3VcJM=;
 b=HI3svnTznV/JDSAGkOkzGyb63La+tKFvdFCnlWqVrzhktzrGHUg7eiFAyG52Gkd2aUBudMkbT
 GJ+KyP6ij6BvvDP2buoqJ7H8qTFaYoR/1T5FpDjcai2eT3SRFqaC3bVs1RHHCw+W8n6mlgPsiBB
 7FofRKQ6IkAJ92iDcSlKKjIWuyZNg1DbI571ITvGPUU8SX0rwVBGO4fCdgJz58EXxn1jjkDIkWP
 3YGrA99xWzuJ8d0jiJbOjxWuvAaLJi2hE+2u431QLSEBj+JhEGgbgvfWzZ/esvZ1OxyuNYUhef6
 6o0rAsgJLQXXMlRl+J4EZwrnPCDeRBgIxiNe8l78a7mQ==
Message-ID: <e9d6883b-4331-4237-be19-5df6126a3962@kwiboo.se>
Date: Thu, 1 Feb 2024 11:51:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Eugen Hristev
 <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, Simon
 Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom
 Rini <trini@konsulko.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>, Akash
 Gajjar <gajjar04akash@gmail.com>, Joshua Riek <jjriek@verizon.net>
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
 <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
 <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
 <23d7337a-88b7-4dcb-be08-c42b21e9dbd1@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <23d7337a-88b7-4dcb-be08-c42b21e9dbd1@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bb779825cafd4e4cc3519c
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

On 2024-02-01 11:18, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/27/24 12:15, Jonas Karlman wrote:
>> Hi Eugen,
>>
>> On 2024-01-27 04:48, Eugen Hristev wrote:
>>> Hi Jonas,
>>>
>>>
>>> On 1/27/24 01:26, Jonas Karlman wrote:
>>>> Writing to eMMC using DDR52 mode does not work reliably or at all on
>>>> RK356x and RK3588 boards.
>>>>
>>>
>>>
>>> This is related to the old issue I encountered last year with mmc write?
>>
>> Yes, I think it is.
>>
>> I did some testing on RK3566/RK3568/RK3588S/RK3588 boards with different
>> eMMC modules with following result:
>>
>> Read seem to work with all enabled modes:
>> RK3566: MMC legacy, MMC High Speed (26MHz), MMC High Speed (52MHz),
>>          MMC DDR52 (52MHz) and HS200 (200MHz)
>> RK3568/RK3588S/RK3588: all above + HS400 (200MHz) and HS400ES (200MHz)
>>
>> However, write had issues with some of the modes:
>> MMC DDR52 (52MHz): all RK35xx
>> HS400/HS400ES: only on RK3568 after changing hs400_txclk_tapnum to 8
>>
>> HS200 seem to be the most stable write speed that worked on all SoCs.
>>
>> So, dropping MMC DDR52 (52MHz) and enable use of HS200 (200MHz) seem to
>> be the best option to get speedy and working read and write eMMC.
>>
> 
> 1) we have this enabled on RK3588 Jaguar in upstream Linux... I may have 
> improperly tested it then, would you mind sharing how you tested this 
> mode on RK3588 so I can reproduce this and fix it on our product if 
> we're impacted? I assume because we have HS200/HS400/HS400-ES enabled, 
> DDR52 would never be used? (our eMMC is soldered and support the former 
> modes).

My main mode of testing eMMC in U-Boot has been to enable following
Kconfig options,

CONFIG_MMC_HS200_SUPPORT=y
CONFIG_MMC_HS400_SUPPORT=y
CONFIG_MMC_HS400_ES_SUPPORT=y
CONFIG_MMC_SPEED_MODE_SET=y

and from U-Boot cli run following,

=> mmc rescan <mode> && mmc info && mmc read 10000000 2000 10000
=> mmc rescan <mode> && mmc info && mmc write 20000000 4000 10000

for each of the modes below.

  0 = MMC legacy
  1 = MMC High Speed (26MHz)
  3 = MMC High Speed (52MHz)
  4 = MMC DDR52 (52MHz)
  10 = HS200 (200MHz)
  11 = HS400 (200MHz)
  12 = HS400ES (200MHz)

on different boards and different eMMC modules.

Using some modes the read or write return ERROR instead of OK. When
ERROR was reported a rescan or board reset was needed to test next mode.

Please also note that I have only tested in U-Boot, not in linux.

> 
> 2) Why are we not enabling HS400/HS400-ES for RK3588 boards? You seem to 
> be saying there are issues with HS400/HS400-ES on RK3568 but you didn't 
> mention the status for RK3588. Did I misunderstand the last sentence? 
> Can you please rephrase in that case?

I can see now that my wording was very confusing.

Write for HS400/HS400ES mode only worked on RK3568 after modification to
the driver, on RK3588 write always returned error for me.

So on RK3568 HS400 modes could be made work, on remaining SoCs there was
issues.

Regards,
Jonas

> 
> Cheers,
> Quentin

